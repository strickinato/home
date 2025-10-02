// Config docs:
//
//   https://glide-browser.app/config
//
// API reference:
//
//   https://glide-browser.app/api
//
// Default config files can be found here:
//
//   https://github.com/glide-browser/glide/tree/main/src/glide/browser/base/content/plugins
//
// Most default keymappings are defined here:
//
//   https://github.com/glide-browser/glide/blob/main/src/glide/browser/base/content/plugins/keymaps.mts
//
// Try typing `glide.` and see what you can do!

glide.keymaps.set("normal", "<leader>1", () => openTabInContainer(0));
glide.keymaps.set("normal", "<leader>!", () => openContainerWindow(0));

// The following is lifted from:
// https://github.com/gsomoza/firefox-easy-container-shortcuts/blob/master/background.js#L28
//
//Discussionhere https://news.ycombinator.com/item?id=26200520
async function openContainerWindow(contextNumber) {
  let context = await getContextFor(contextNumber);
  if (!context) {
    return;
  }

  return browser.windows.create({
    cookieStoreId: context.cookieStoreId
  });
}

async function openTabInContainer(contextNumber) {
  let context = contextNumber !== -1 ? await getContextFor(contextNumber) : {};
  console.log(context)

  if (!context) {
    return;
  }

  browser.tabs.query({currentWindow:true, active:true, status:'complete'}).then(function(results) {
    if (!results || results.length < 1) {
      return; // do nothing
    }

    let currentTab = results[0];

    if (currentTab.url.startsWith('about')) {
      return;
    }

    browser.tabs.create({
      cookieStoreId: context.cookieStoreId,
      index: currentTab.index + 1,
      url: currentTab.url,
      pinned: currentTab.pinned
    });
    browser.tabs.remove(currentTab.id);
  });
}

async function getContextFor(contextNumber) {
  let contexts;
  try {
    contexts = await getContexts();
  } catch (e) {
    console.error(e);
    return;
  }

  if (contextNumber > contexts.length - 1) {
    return; // no container defined for this shortcut, do nothing
  }

  return contexts[contextNumber];
}

function getContexts() {
  return browser.contextualIdentities.query({});
}
