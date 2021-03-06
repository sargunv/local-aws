// clang-format off
import * as E from '@root/js-helpers'
import * as U from '@root/ui-components'

import('./strings.en').then(m => {
  const msg: HTMLDivElement = document.createElement('div');
  const d = U.EditableTable
  debugger

    msg.innerText = m.hello() + E.hello() + d;
    // For sourcemap testing, keep this string literal on line 6 column 21 !!
    msg.className = 'ts1';
    document.body.appendChild(msg);
});
