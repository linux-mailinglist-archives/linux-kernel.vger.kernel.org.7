Return-Path: <linux-kernel+bounces-754986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2057B19F84
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 12:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3309018994DC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 10:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA86246796;
	Mon,  4 Aug 2025 10:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OOGrfL9c"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA39B1EFF96
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 10:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754302325; cv=none; b=S++IUVTY85czI6l+wvN2qUUK7YUCkFXVgo96Hrn5PwEUxrdeczH2NnwpYQRT0Aars9zR5EJZH9fkMSkLyrT9HHF/HMAYtsgnK+bxrw/mnQ2+Ji4VhnnMXzqXlHLTqQMCMUW0t8JmVnwlM4+nZ+HyFI6qXjMR/WujkgHWrwU7VeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754302325; c=relaxed/simple;
	bh=hZApIlBOWv7ok5FEqKF3cdEVfDjYEno/iYtxfVdOxuo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=TLK6TOuZ4FltmEYkEQJro315MuQVwTw6D6ZiGtCbi0ptuKvK1SHukzW6LhlW1MgW7Q1fKHpvy6ItygYCYdCZPnH1czwR7YrPh6PXpjkdEKa3R3sf1NVOygxAP8q2nTC8ntWcSNyi2KkVJ0UP58ULz5hAjYRPLP7/NBtRVHnrHzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OOGrfL9c; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-31ef50d8d57so2018001a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 03:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754302323; x=1754907123; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+m9dNDoA2LrkBnWEk52swdGfOHuXAiWRRUcjSMLrQRc=;
        b=OOGrfL9celHHZlC9dHLd35frK2YWBnp6273qPVt3K29WIO2zk4By+d6y0wKn7ZfXK1
         iHJsgEO5YgmICTiqdbpHRlRHHnWGqml24t9Wl43/TmbwXUFHcNblBK7H2jNYcJm2HFWH
         VkFiIe3rIknWcuwTWg2kRSXkhYLswD84w2cekBHn7QkadIAQZFGnRf5s6q9VRshpPZTm
         bCKNpye5SuXNE5R296TuxcWbJFQbaEYRlBdRN31D92Ajyscl1Kl2A56EcWk9TFoTag+0
         3xi/b+h9FCZNG9fC+A513WAgJAVLNNcvpCJSNtDgGzu5PjsEWPTOVZLhyJpJN8oBtN2/
         rjJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754302323; x=1754907123;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+m9dNDoA2LrkBnWEk52swdGfOHuXAiWRRUcjSMLrQRc=;
        b=eTym9PN9lAJqcMb1GoYPslnWFKxLIHT/POcVbeW3IR11U1k4yaNURk2lJv5xBYvklJ
         9h9RHBl55ZxIWo+ok77pgiPDGR/P21bRWf/7CvoWI9pYTmDnVr/dgdC3mGxLA/tx6dnz
         FgknWHEXGgDKLE46EJhrzz1YeXZWK13+joeWB1dJlGc3qaVoy/iaXuKBOx8za+3g3KjN
         Dc1UaAw/hBY+T+bhAhzvn+SonPQTJZQM3wILlxx9n1pc4nRqfSJEMcKS5TpvSiS+YtVT
         shYZZclh8ZAMCnd6+BZpqH1mUowLbsDc6rM3qAd4i4eDvpJz4OmZxHbbsjQEUWt+W5QZ
         e3Ug==
X-Forwarded-Encrypted: i=1; AJvYcCVcJR7lH6rvtHBm9ZGLlyf/Ws9ASaHUrJ2vJVU0oiApPEiH2vzlERXgZ7UQp3CkfqEZcZV4Ra9rEJIgoRs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy76d8ZP4zKTPJ/LTT5f7mOAfZQdqNvfT+UPkuYjGWTfb8+FrB
	+s0c+sCpsEVp4LfIeyi4ZiE+RkU0jP8IaYk/WWvFFuRW43S+SFzRZ29MBIAXeFz8bbjboRvraWp
	vwdPeugp5wwVg7ZcL5qmP3qTtGtQu8NeJZbWnx6SQ6Q==
X-Gm-Gg: ASbGncsXDf6w84FfIslz3GEz0as2/LHVwoRG2QLI0BOwK420n+yn0WVUloVWY3Fl2pG
	59eEJMAfnzlYlQmrFJMUhIZURaGBTLrzDpbBRd/o6hDFHX5nhajtmaZvX50DQG/Gqfvg5TIWwqS
	eLEMGHzRapziPFKNTjkA+Auci1aC9ATT8UmV0GBvZumzggD4TvHGQXckdEifGANkjKoYdEkBmSd
	MR6s55gBcBgnEsFZlIMApj0c+Mk+FFryfS/1ag=
X-Google-Smtp-Source: AGHT+IGmoaWXbNeWHeHrWCnDRCt/5bpldGAOryYToFxsZb5CspShWUEkgr/A2ZYVYe7ryQGoP6JWlwkDsrdA48AD4cg=
X-Received: by 2002:a17:90b:1c86:b0:321:265a:e0d3 with SMTP id
 98e67ed59e1d1-321265ae4bamr8421691a91.25.1754302322958; Mon, 04 Aug 2025
 03:12:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 4 Aug 2025 15:41:51 +0530
X-Gm-Features: Ac12FXwHubfFBQejxBFSQfy7WS98qKcbwEiY123z2BlqNH5k05Q6sO7VgOAYTX4
Message-ID: <CA+G9fYuDtzPpJOX7wdWAf2QmHyc-5v0cZ2Wood8cRwCttuyRmA@mail.gmail.com>
Subject: next-20250804: clang-nightly hardening.config boot failed on arm64 rock-pi-4b
To: clang-built-linux <llvm@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>, 
	lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>, 
	linux-hardening@vger.kernel.org
Cc: kees@kernel.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Ben Copeland <benjamin.copeland@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Regressions found while booting the Linux next-20250804 on the
qemu-arm64, dragonboard-410c, rock-pi-4b due to following kernel log.

Regression Analysis:
- New regression? Yes
- Reproducibility? yes

First seen on the next-20250804
Good: next-20250801
Bad: next-20250804

Test regression: next-20250804 clang-nightly hardening.config boot
failed on arm64 rock-pi-4b

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Rk3399-rock-pi-4b
[    0.006047] kfence: initialized - using 2097152 bytes for 255
objects at 0x(____ptrval____)-0x(____ptrval____)
[    0.007767] Unable to handle kernel execute from non-executable
memory at virtual address 00000000820d0614
[    0.008666] Mem abort info:
[    0.008933]   ESR = 0x0000000086000004
[    0.009284]   EC = 0x21: IABT (current EL), IL = 32 bits
[    0.009780]   SET = 0, FnV = 0
[    0.010074]   EA = 0, S1PTW = 0
[    0.010376]   FSC = 0x04: level 0 translation fault
[    0.010834] [00000000820d0614] user address but active_mm is swapper
[    0.011424] Internal error: Oops: 0000000086000004 [#1]  SMP
[    0.011954] Modules linked in:
[    0.012255] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted
6.16.0-next-20250804 #1 PREEMPT
[    0.013053] Hardware name: Radxa ROCK Pi 4B (DT)
[    0.013486] pstate: 80500205 (Nzcv Daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    0.014138] pc : 0x820d0614
[    0.014414] lr : start_kernel+0x1d8/0x388
[    0.014806] sp : ffff800082703e80
[    0.015121] x29: ffff800082703e90 x28: 0000000000000000 x27: 00000000f3ff3ad0
[    0.015802] x26: 00000000f3f2bf18 x25: 0000000000000000 x24: 0000000000000710
[    0.016481] x23: 0000000000000003 x22: 00000000f1f31468 x21: 00000000f1ef9000
[    0.017160] x20: ffff80008270a000 x19: ffff800082716ac0 x18: ffff800082715ac8
[    0.017841] x17: 0000000000000004 x16: 000000000000000c x15: 00000000000000ac
[    0.018521] x14: 0000000000000400 x13: 0000000000000000 x12: ffff0000f749b2ac
[    0.019200] x11: 0000000000000000 x10: 0000000000000002 x9 : 0000000000000006
[    0.019880] x8 : 00000000000000c0 x7 : 0000000000000000 x6 : 00000000b1f352b2
[    0.020557] x5 : ffff800082703b78 x4 : 0000000000000000 x3 : ffff800082703d30
[    0.021240] x2 : fffffffffffffb54 x1 : ffff0000f75b5180 x0 : 0000000000000000
[    0.021921] Call trace:
[    0.022159]  0x820d0614 (P)
[    0.022433]  __primary_switched+0x90/0x9c
[    0.022854] Unable to handle kernel write to read-only memory at
virtual address 0000000000000008
[    0.023677] Mem abort info:
[    0.023942]   ESR = 0x0000000096000044
[    0.024291]   EC = 0x25: DABT (current EL), IL = 32 bits
[    0.024788]   SET = 0, FnV = 0
[    0.025078]   EA = 0, S1PTW = 0
[    0.025375]   FSC = 0x04: level 0 translation fault
[    0.025831] Data abort info:
[    0.026103]   ISV = 0, ISS = 0x00000044, ISS2 = 0x00000000
[    0.026613]   CM = 0, WnR = 1, TnD = 0, TagAccess = 0
[    0.027088]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[    0.027585] [0000000000000008] user address but active_mm is swapper

## Qemu-arm64 boot failed log
<6>[    0.000056] sched_clock: 61 bits at 1000MHz, resolution 1ns,
wraps every 4398046511103ns
<6>[    0.003490] kfence: initialized - using 2097152 bytes for 255
objects at 0x(____ptrval____)-0x(____ptrval____)
<2>[    0.016829] Unhandled 64-bit el1h sync exception on CPU0, ESR
0x000000003a000000 -- PSTATE.IL
<4>[    0.018731] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted
6.16.0-next-20250804 #1 PREEMPT
<4>[    0.018869] Hardware name: linux,dummy-virt (DT)
<4>[    0.019015] pstate: 72500209 (nZCV Daif +PAN -UAO +TCO -DIT
-SSBS BTYPE=--)
<4>[    0.019099] pc : start_kernel+0x1e8/0x388
<4>[    0.019688] lr : start_kernel+0x1d8/0x388
<4>[    0.019706] sp : ffffb0d172f03e80
<4>[    0.019723] x29: ffffb0d172f03e90 x28: 0000000000000000 x27:
0000000000000000
<4>[    0.020240] x26: 0000000000000000 x25: 0000000000000000 x24:
0000000000000000
<4>[    0.020264] x23: 0000000000000000 x22: 0000000000000000 x21:
0000000048000000
<4>[    0.020288] x20: ffffb0d172f0a000 x19: ffffb0d172f16ac0 x18:
ffffb0d172f15ac0
<4>[    0.020311] x17: 0000000000000000 x16: 0000000000000008 x15:
00000000000001e8
<4>[    0.020334] x14: 0000000000000400 x13: 0000000000000000 x12:
fff00000ff395f6c
<4>[    0.020357] x11: 0000000000000000 x10: 0000000000000000 x9 :
0000000000000002
<4>[    0.020397] x8 : 00000000000000c0 x7 : 0000000000000000 x6 :
00000000c333cce7
<4>[    0.020419] x5 : 00000000f80cd09e x4 : 0000000000000000 x3 :
ffffb0d172f03d30
<4>[    0.020441] x2 : fffffffffffffb54 x1 : fff00000ff397cc0 x0 :
0000000000000000
<0>[    0.020652] Kernel panic - not syncing: Unhandled exception
<4>[    0.020740] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted
6.16.0-next-20250804 #1 PREEMPT
<4>[    0.020757] Hardware name: linux,dummy-virt (DT)
<4>[    0.020843] Call trace:
<4>[    0.020960]  show_stack+0x18/0x28 (C)
<4>[    0.021107]  __dump_stack+0x28/0x3c
<4>[    0.021136]  dump_stack_lvl+0x24/0x6c
<4>[    0.021151]  dump_stack+0x18/0x24
<4>[    0.021166]  vpanic+0x10c/0x384
<4>[    0.021181]  panic+0x48/0x4c
<4>[    0.021195]  __panic_unhandled+0x68/0x6c
<4>[    0.021239]  el1_abort+0x0/0x5c
<4>[    0.021258]  el1h_64_sync+0x70/0x74
<4>[    0.021341]  start_kernel+0x1e8/0x388 (P)
<4>[    0.021359]  __primary_switched+0x90/0x9c
<0>[    0.028904] ---[ end Kernel panic - not syncing: Unhandled exception ]---

## Dragonboard-410c boot failed log

[    0.019420] Unable to handle kernel execute from non-executable
memory at virtual address 0000000082150614
[    0.028831] Unable to handle kernel write to read-only memory at
virtual address 0000000000000008
[    0.028839] Mem abort info:
[    0.028842]   ESR = 0x0000000096000044
[    0.028847]   EC = 0x25: DABT (current EL), IL = 32 bits
[    0.028853]   SET = 0, FnV = 0
[    0.028858]   EA = 0, S1PTW = 0
[    0.028864]   FSC = 0x04: level 0 translation fault
[    0.028869] Data abort info:
[    0.028872]   ISV = 0, ISS = 0x00000044, ISS2 = 0x00000000
[    0.028878]   CM = 0, WnR = 1, TnD = 0, TagAccess = 0
[    0.028884]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[    0.028892] [0000000000000008] user address but active_mm is swapper
[    0.028899] Internal error: Oops: 0000000096000044 [#1]  SMP
[    0.028907] Modules linked in:
[    0.028919] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted
6.16.0-next-20250804 #1 PREEMPT
[    0.028932] Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
[    0.028939] pstate: 404000c5 (nZcv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    0.028949] pc : ret_to_kernel+0x8/0x68
[    0.028966] lr : el1h_64_irq+0x70/0x74
[    0.028975] sp : ffff8000827837e0
[    0.028981] x29: ffff800082783908 x28: ffff800082796ac0 x27: ffff800082b352c8
[    0.028998] x26: 0000000000000000 x25: ffff800082d10000 x24: ffff800082796ac0
[    0.029014] x23: 0000000020400205 x22: ffff8000801e3dfc x21: 0000000082149000
[    0.029030] x20: 0000000000000000 x19: ffff8000827839f4 x18: ffff800082795b30
[    0.029046] x17: 00000000a540670c x16: 00000000a540670c x15: 00000000000a0d34
[    0.029062] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
[    0.029078] x11: 0000000000000000 x10: ffff800082796ac0 x9 : ffff800082745598
[    0.029093] x8 : 0000000000000000 x7 : 205d303234393130 x6 : 302e30202020205b
[    0.029109] x5 : ffff800082d111c8 x4 : ffff8000827837b7 x3 : ffff8000827837e0
[    0.029125] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff800082d10f7c
[    0.029141] Call trace:
[    0.029146]  ret_to_kernel+0x8/0x68 (P)
[    0.029161]  console_flush_all+0x2ac/0x3cc (P)
[    0.029175]  console_unlock+0x80/0x17c
[    0.029191]  vprintk_emit+0x208/0x2ac
[    0.029208]  vprintk_default+0x44/0x70
[    0.029225]  vprintk+0x34/0xb4
[    0.029236]  _printk+0x54/0x80
[    0.029249]  die_kernel_fault+0x40/0x74
[    0.029261]  vma_end_read+0x0/0x94
[    0.029277]  do_page_fault+0x44/0x768
[    0.029292]  do_translation_fault+0x4c/0x68
[    0.029307]  do_mem_abort+0x54/0xa8
[    0.029322]  el1_abort+0x3c/0x5c
[    0.029335]  el1h_64_sync_handler+0x50/0xfc
[    0.029346]  el1h_64_sync+0x70/0x74
[    0.029358]  0x82150614 (P)
[    0.029368]  __primary_switched+0x90/0x9c
[    0.029393] Code: 944fdb51 d5184035 d5184016 a94007e0 (a800ada6)
[    0.029401] ---[ end trace 0000000000000000 ]---
[    0.029408] Kernel panic - not syncing: Attempted to kill the idle task!
[    0.282802] ---[ end Kernel panic - not syncing: Attempted to kill
the idle task! ]---


Rock-pi-4b
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250804/testrun/29369027/suite/boot/test/clang-nightly-lkftconfig-hardening/log
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250804/testrun/29369027/suite/boot/test/clang-nightly-lkftconfig-hardening/details/

Qemu-arm64
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250804/testrun/29368323/suite/boot/test/clang-nightly-lkftconfig-hardening/log
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250804/testrun/29368323/suite/boot/test/clang-nightly-lkftconfig-hardening/details/

Dragonboard-410c
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250804/testrun/29368937/suite/boot/test/clang-nightly-lkftconfig-hardening/details/
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250804/testrun/29368937/suite/boot/test/clang-nightly-lkftconfig-hardening/log

 ## Source
* Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
* Git sha: 5c5a10f0be967a8950a2309ea965bae54251b50e
* Git describe: next-20250804
* Project details:
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250804
* Architectures: arm64
* Toolchains: clang-nigtly Debian clang version 22.0.0
(++20250803105249+e640ca8b9adc-1~exp1~20250803225437.1615)
* Kconfigs: hardening.config

## Build
* Test history:
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250804/testrun/29368937/suite/boot/test/clang-nightly-lkftconfig-hardening/history/
* Test history 1:
https://regressions.linaro.org/lkft/linux-next-master/next-20250804/boot/clang-nightly-lkftconfig-hardening/
* Test plan: https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/30oCAKqSuQzYzKbypjmyC5lVNoC
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/30oC7nI5ieJMRpDzpr0LBsg5Tnp/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/30oC7nI5ieJMRpDzpr0LBsg5Tnp/config

--
Linaro LKFT
https://lkft.linaro.org

