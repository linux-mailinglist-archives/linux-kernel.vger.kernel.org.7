Return-Path: <linux-kernel+bounces-754072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F97B18DBE
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 11:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 412DA1AA454A
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 09:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7981C21A435;
	Sat,  2 Aug 2025 09:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YEuxIPIE"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBAF20C488
	for <linux-kernel@vger.kernel.org>; Sat,  2 Aug 2025 09:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754127515; cv=none; b=IZf13IFxp98LMeqU2UsfBK+A+uTxzQlCHwVCiAaGxhPTGNc9jIc7wv7mqj+vFyvly9MJXg8brm2vHUfZC4MSlasPDJoIOc6IlWpnI3sHeTV77mnCgc5jrxTE5OjIBx5bk6vojmy0D+kb/E3ThIJWZMPA8gRcDS8joB4APAKKBJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754127515; c=relaxed/simple;
	bh=r/hwo79/sOCkDx/PWAdSOloxXDtqouqf6GXaCjYTYnI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gNQCVROpDNIJVh7pXNtRN8rNIYxBGcMfoyowk2upYNAOkCIOPAB2Z0e+Aldqzc8j/MRRCwpQOLWyvvgYuqzWrAB0Ld6G8/DOYlpY1DE5mTwBfhQl9jfjhwwQP3+TqufypLuLpCAJ/b2mM4nRoWS8a6Jvr0Qp6E2zWCGBvSEzbCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YEuxIPIE; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7426c44e014so2777066b3a.3
        for <linux-kernel@vger.kernel.org>; Sat, 02 Aug 2025 02:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754127513; x=1754732313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Zs1/E6+Pq3G0J+zxWbP0N2xFqyirvOa67L8/BHLq6NQ=;
        b=YEuxIPIEaGnGL2JL4aWqLRYxo11NJfMZ3nZl/Hra8UkMDf7eqaV9+p8FncP92LPBvb
         VrDWkMsOcO181NQ/fWlh15p6/b85gbDOjTBy5HV8+mB7lgalIS8DItIof2CeKQCG7D6E
         C1WZMt2tf5e4KfXRoDT2tBe7cLcyK3PIXIF0ZTZDqSVvn7NMG8PAyRP9MY00xDF1UQ7I
         WpF+xtPaZCa12rb4xkMe0VG5+Frwsbb3M6PKmOaSj/d3HKxszV5DOWEVvYHV8Y+ZD2U0
         9/hCtIMAYKlkGbbjMg9eM1udBtLsgp569S8piPx7+ybg/dU/M6bpmPTIHQyDuXnJ6ngN
         DCuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754127513; x=1754732313;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zs1/E6+Pq3G0J+zxWbP0N2xFqyirvOa67L8/BHLq6NQ=;
        b=ZUQ0qG5eoISzTKbyMliiKqn8V0PUX0F6V/sy23ez3kt6yOBerxSFjYBb7YxHTf4/lY
         rRqr7/dfwEm/jBeZtaygn/MlwKTTJsWwqzoKod+zrAVW8GxoD5cLVdhnRKsGPnR5NRZL
         6YUhB4qPyL2MWjOm1S/aY/Ulzdfe0Y2pFiuEB4vmLwHZkADHXYy2jlJiHZYnGyh7t7id
         kAa0zpt3FfchLnWnAON4Hcx14ioGxIIn5TJxZtWMWkfHjnJiIhLDJuu2fII7xMF1mFnV
         MT3L4jW0AYwzhUZaSA+j7H3zMo9YSPyCt+FMhS4Z2iUEVCZlzQ4EA24gV8NIOQ3DizhH
         VpYw==
X-Gm-Message-State: AOJu0YzJ+Rg/DU993QaqeVgyFjBOe4xtDXy8TjbzxDqfJyitBj6SzsDR
	Bk0xfqoxJJfCobknnEonzpFinT33f2QB/TZDr6mGupRcyP6oG+eKw/io
X-Gm-Gg: ASbGncv1zAAuEt/O++gOOt2bnm/OAnEGVWcfXJkNwe1EskiHCNKjQUVu4xJ+RqXjKFX
	ab5Mc1kZJ5YcnR25DkgKvU6e3M9Zji8Riw1MGPehzDzA+FSq2DeV/PYPrUXWelGjV27UEkRNlCt
	ktaQybGLB/bUgYsch3YtTPX36H71TzIJM0Vzvx5fwyq0aSd3r8ZmFQKXJmFGJnpTQKlEqZRD5IL
	7zfq+hOaoNRJlisOUBcBSvwLe4jsfQEg13RTlMLwEIoGbItcJqxfl9xrXXX+hWXwG4bkBzWhHuL
	u/lAXdAbW/gmNWdi4L+cV/Sd+ksR1p8xXTQ3PhYvwv2BvdG490IApmvlXEhW5gi6VgSMCqnWgw0
	44y053FTxlK3SFIoPX3Avjw==
X-Google-Smtp-Source: AGHT+IGAAp2EKtflfqBdWN1FVaNPyD0Ryl8jVPBLx7PlsOAzbCWJopFdKY8ub8Sb3pZVlaB1hs4TGg==
X-Received: by 2002:a05:6a20:7d9c:b0:232:36e3:9a4e with SMTP id adf61e73a8af0-23df917c223mr4313520637.40.1754127512686;
        Sat, 02 Aug 2025 02:38:32 -0700 (PDT)
Received: from localhost ([223.185.40.141])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfd0e78sm5948251b3a.99.2025.08.02.02.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Aug 2025 02:38:32 -0700 (PDT)
From: Shardul Bankar <shardulsb08@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	Shardul Bankar <shardulsb08@gmail.com>
Subject: [PATCH] lib/ref_tracker: Validate tracker pointer before dereference in ref_tracker_free
Date: Sat,  2 Aug 2025 15:08:28 +0530
Message-Id: <20250802093828.3636790-1-shardulsb08@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ref_tracker_free() function is vulnerable to a Use-After-Free (UAF)
if a caller provides a dangling pointer to a freed tracker object.

The existing safeguard, 'if (tracker->dead)', dereferences this potentially
stale pointer to read the 'dead' flag. If an attacker reclaims the memory
of the original tracker object using a zero-initializing allocator (e.g.,
kzalloc) between a first and second free, they can control the contents
of the memory. This makes the 'dead' flag appear false, bypassing the
safeguard and leading to a double call to kfree(). This results in slab
corruption and a kernel panic, demonstrating a viable exploit primitive.

This patch fixes the vulnerability by adding robust validation at the
beginning of the function, before the dangling pointer is ever
dereferenced. It iterates through the directory's internal 'quarantine'
and 'active' lists to verify that the provided tracker pointer is a known,
managed member.

If the pointer is not found on either list, it is treated as invalid, a
warning is issued, and the function returns immediately. This prevents a
call to kfree() on an attacker-controlled or already-freed object.

To reproduce this issue, a kernel module PoC has been created that reliably triggers the vulnerability. The PoC code and a Makefile are available at: https://gist.github.com/sbankarCL/a09ed2ce358f1616f0562e3dcc38a2ae

The crash was reproduced on a v6.16.0-rc4 kernel compiled with KASAN and CONFIG_REF_TRACKER enabled. The following KASAN report shows the UAF occurring:

[  +0.001841] ==================================================================
[  +0.000463] BUG: KASAN: slab-use-after-free in ref_tracker_free+0x54c/0x6b0
[  +0.000928] Read of size 1 at addr ffff888103a04610 by task uaf_trigger/4346

[  +0.000748] CPU: 0 UID: 0 PID: 4346 Comm: uaf_trigger Tainted: G           OE       6.16.0-rc4 #152 PREEMPT(lazy)
[  +0.000010] Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[  +0.000003] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[  +0.000097] Call Trace:
[  +0.000296]  <TASK>
[  +0.000003]  dump_stack_lvl+0x117/0x1b0
[  +0.000576]  ? ref_tracker_free+0x54c/0x6b0
[  +0.000005]  print_address_description.constprop.0+0x6e/0x370
[  +0.000431]  ? ref_tracker_free+0x54c/0x6b0
[  +0.000006]  print_report+0xfc/0x1ff
[  +0.000005]  ? __virt_addr_valid+0x8b/0x650
[  +0.000227]  ? __phys_addr+0xf0/0x190
[  +0.000016]  ? ref_tracker_free+0x54c/0x6b0
[  +0.000005]  kasan_report+0xb1/0x170
[  +0.000253]  ? ref_tracker_free+0x54c/0x6b0
[  +0.000009]  ref_tracker_free+0x54c/0x6b0
[  +0.000005]  ? tracer_hardirqs_on+0xfc/0x460
[  +0.000269]  ? __pfx_ref_tracker_free+0x10/0x10
[  +0.000005]  ? trigger_thread_fn+0x1ae/0x210 [010_ref_tracker_write_what_where]
[  +0.000011]  ? kthread+0x420/0x820
[  +0.000064]  ? ret_from_fork+0x523/0x600
[  +0.000220]  ? ret_from_fork_asm+0x1a/0x30
[  +0.000155]  ? kthread+0x1f5/0x820
[  +0.000006]  trigger_thread_fn+0x1ae/0x210 [010_ref_tracker_write_what_where]
[  +0.000012]  ? __pfx_trigger_thread_fn+0x10/0x10 [010_ref_tracker_write_what_where]
[  +0.000012]  ? __pfx_trigger_thread_fn+0x10/0x10 [010_ref_tracker_write_what_where]
[  +0.000014]  ? __kthread_parkme+0x184/0x230
[  +0.000009]  ? kthread+0x1f5/0x820
[  +0.000006]  ? __pfx_trigger_thread_fn+0x10/0x10 [010_ref_tracker_write_what_where]
[  +0.000011]  kthread+0x420/0x820
[  +0.000006]  ? __pfx_kthread+0x10/0x10
[  +0.000006]  ? tracer_hardirqs_on+0xfc/0x460
[  +0.000006]  ? __lock_release.isra.0+0x59/0x170
[  +0.000191]  ? __pfx_kthread+0x10/0x10
[  +0.000006]  ret_from_fork+0x523/0x600
[  +0.000007]  ? __pfx_kthread+0x10/0x10
[  +0.000006]  ? __pfx_kthread+0x10/0x10
[  +0.000006]  ret_from_fork_asm+0x1a/0x30
[  +0.000011]  </TASK>

[  +0.007236] Allocated by task 4344:
[  +0.000227]  kasan_save_stack+0x30/0x50
[  +0.000156]  kasan_save_track+0x14/0x30
[  +0.000163]  __kasan_kmalloc+0x9a/0xb0
[  +0.000152]  ref_tracker_alloc+0x1d7/0x5e0
[  +0.000176]  uaf_exploit_poc_init+0x6e/0xff0 [010_ref_tracker_write_what_where]
[  +0.000284]  do_one_initcall+0x109/0x660
[  +0.000157]  do_init_module+0x2cc/0x880
[  +0.000229]  init_module_from_file+0xe1/0x150
[  +0.000182]  idempotent_init_module+0x226/0x760
[  +0.000209]  __x64_sys_finit_module+0xcd/0x150
[  +0.000181]  do_syscall_64+0x94/0x380
[  +0.000690]  entry_SYSCALL_64_after_hwframe+0x76/0x7e

[  +0.000336] Freed by task 4346:
[  +0.000128]  kasan_save_stack+0x30/0x50
[  +0.000155]  kasan_save_track+0x14/0x30
[  +0.000156]  kasan_save_free_info+0x3b/0x70
[  +0.000237]  __kasan_slab_free+0x52/0x70
[  +0.000159]  kfree+0x137/0x4e0
[  +0.000420]  ref_tracker_free+0x376/0x6b0
[  +0.000163]  trigger_thread_fn+0x1ae/0x210 [010_ref_tracker_write_what_where]
[  +0.000283]  kthread+0x420/0x820
[  +0.000133]  ret_from_fork+0x523/0x600
[  +0.000152]  ret_from_fork_asm+0x1a/0x30

[  +0.000226] The buggy address belongs to the object at ffff888103a04600
               which belongs to the cache kmalloc-rnd-01-32 of size 32
[  +0.000569] The buggy address is located 16 bytes inside of
               freed 32-byte region [ffff888103a04600, ffff888103a04620)

[  +0.000513] The buggy address belongs to the physical page:
[  +0.000214] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x103a04
[  +0.000517] flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
[  +0.000321] page_type: f5(slab)
[  +0.000205] raw: 0017ffffc0000000 ffff8881000428c0 dead000000000100 dead000000000122
[  +0.000377] raw: 0000000000000000 0000000000400040 00000000f5000000 0000000000000000
[  +0.000290] page dumped because: kasan: bad access detected

[  +0.000281] Memory state around the buggy address:
[  +0.000188]  ffff888103a04500: 00 00 00 00 fc fc fc fc 00 00 00 00 fc fc fc fc
[  +0.000273]  ffff888103a04580: 00 00 00 00 fc fc fc fc 00 00 00 00 fc fc fc fc
[  +0.000272] >ffff888103a04600: fa fb fb fb fc fc fc fc 00 00 00 00 fc fc fc fc
[  +0.000274]                          ^
[  +0.000154]  ffff888103a04680: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
[  +0.000272]  ffff888103a04700: 00 00 00 00 fc fc fc fc 00 00 00 00 fc fc fc fc
[  +0.000272] ==================================================================
[  +0.000358] Disabling lock debugging due to kernel taint
[  +0.000280] ref_tracker: reference already released.
[  +0.000275] ref_tracker: allocated in:
[  +0.000147]  uaf_exploit_poc_init+0x6e/0xff0 [010_ref_tracker_write_what_where]
[  +0.000287]  do_one_initcall+0x109/0x660
[  +0.000172]  do_init_module+0x2cc/0x880
[  +0.000154]  init_module_from_file+0xe1/0x150
[  +0.000173]  idempotent_init_module+0x226/0x760
[  +0.000179]  __x64_sys_finit_module+0xcd/0x150
[  +0.000179]  do_syscall_64+0x94/0x380
[  +0.000149]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  +0.000209] ref_tracker: freed in:
[  +0.000134]  trigger_thread_fn+0x1ae/0x210 [010_ref_tracker_write_what_where]
[  +0.000276]  kthread+0x420/0x820
[  +0.000133]  ret_from_fork+0x523/0x600
[  +0.000153]  ret_from_fork_asm+0x1a/0x30
[  +0.001795] ------------[ cut here ]------------
[  +0.000266] WARNING: CPU: 0 PID: 4346 at lib/ref_tracker.c:255 ref_tracker_free.cold+0x111/0x14e
[  +0.001143] Modules linked in: 010_ref_tracker_write_what_where(OE+) 9p(E) ppdev(E) snd_pcm(E) snd_timer(E) 9pnet_virtio(E) parport_pc(E) snd(E) floppy(E) 9pnet(E) bochs(E) pcspkr(E) serio_raw(E) zram(E)
[  +0.000121] Unloaded tainted modules: snd_pcsp(E):1 padlock_aes(E):2
[  +0.001006] CPU: 0 UID: 0 PID: 4346 Comm: uaf_trigger Tainted: G    B      OE       6.16.0-rc4 #152 PREEMPT(lazy)
[  +0.000523] Tainted: [B]=BAD_PAGE, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[  +0.000251] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[  +0.000445] RIP: 0010:ref_tracker_free.cold+0x111/0x14e
[  +0.000208] Code: 03 48 c1 e0 2a 0f b6 04 02 84 c0 74 04 3c 03 7e 4c 8b 7b 18 e8 d8 3d b8 03 e8 23 2a c2 00 48 8b 34 24 48 89 ef e8 07 79 3a 08 <0f> 0b bb ea ff ff ff e9 f3 5c b8 03 4c 89 f7 e8 43 8c 36 01 e9 14
[  +0.000830] RSP: 0018:ffff888005e3fc78 EFLAGS: 00010246
[  +0.000394] RAX: 0000000000000046 RBX: ffff888103a04600 RCX: ffffffffa0448dcc
[  +0.000349] RDX: ffff888007150000 RSI: 0000000000000000 RDI: ffffffffa00dfa21
[  +0.000330] RBP: ffffffffc0922480 R08: ffffffffa04466c1 R09: 0000000000000000
[  +0.000274] R10: 0000000000000005 R11: 0000000000000000 R12: 1ffff11000bc7f91
[  +0.000283] R13: ffff888110f7d8c0 R14: ffff888103a04618 R15: 0000000005ba052a
[  +0.000327] FS:  0000000000000000(0000) GS:ffff88816938d000(0000) knlGS:0000000000000000
[  +0.000305] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  +0.000229] CR2: 000055e97fdb08c0 CR3: 0000000008396000 CR4: 00000000000006f0
[  +0.000285] Call Trace:
[  +0.000102]  <TASK>
[  +0.000090]  ? tracer_hardirqs_on+0xfc/0x460
[  +0.000229]  ? __pfx_ref_tracker_free+0x10/0x10
[  +0.000182]  ? trigger_thread_fn+0x1ae/0x210 [010_ref_tracker_write_what_where]
[  +0.000296]  ? kthread+0x420/0x820
[  +0.000140]  ? ret_from_fork+0x523/0x600
[  +0.000186]  ? ret_from_fork_asm+0x1a/0x30
[  +0.000224]  ? kthread+0x1f5/0x820
[  +0.000141]  trigger_thread_fn+0x1ae/0x210 [010_ref_tracker_write_what_where]
[  +0.000291]  ? __pfx_trigger_thread_fn+0x10/0x10 [010_ref_tracker_write_what_where]
[  +0.000296]  ? __pfx_trigger_thread_fn+0x10/0x10 [010_ref_tracker_write_what_where]
[  +0.000294]  ? __kthread_parkme+0x184/0x230
[  +0.000167]  ? kthread+0x1f5/0x820
[  +0.000143]  ? __pfx_trigger_thread_fn+0x10/0x10 [010_ref_tracker_write_what_where]
[  +0.000331]  kthread+0x420/0x820
[  +0.000254]  ? __pfx_kthread+0x10/0x10
[  +0.000160]  ? tracer_hardirqs_on+0xfc/0x460
[  +0.000181]  ? __lock_release.isra.0+0x59/0x170
[  +0.000213]  ? __pfx_kthread+0x10/0x10
[  +0.000153]  ret_from_fork+0x523/0x600
[  +0.000347]  ? __pfx_kthread+0x10/0x10
[  +0.000161]  ? __pfx_kthread+0x10/0x10
[  +0.000167]  ret_from_fork_asm+0x1a/0x30
[  +0.000187]  </TASK>
[  +0.000094] irq event stamp: 2046
[  +0.000133] hardirqs last  enabled at (2045): [<ffffffffa3a1e8d9>] get_random_u64+0x5e9/0x730
[  +0.000749] hardirqs last disabled at (2046): [<ffffffffa00df9b4>] __raw_spin_lock_irqsave+0x54/0x60
[  +0.000347] softirqs last  enabled at (966): [<ffffffff9fefe182>] handle_softirqs+0x552/0x7e0
[  +0.000547] softirqs last disabled at (941): [<ffffffff9fefe5a1>] __irq_exit_rcu+0x181/0x1d0
[  +0.000322] ---[ end trace 0000000000000000 ]---

Signed-off-by: Shardul Bankar <shardulsb08@gmail.com>
---
 lib/ref_tracker.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/lib/ref_tracker.c b/lib/ref_tracker.c
index a9e6ffcff04b..bfcdd3ca93a4 100644
--- a/lib/ref_tracker.c
+++ b/lib/ref_tracker.c
@@ -292,6 +292,7 @@ int ref_tracker_free(struct ref_tracker_dir *dir,
 	struct ref_tracker *tracker;
 	unsigned int nr_entries;
 	unsigned long flags;
+	struct ref_tracker *iter;
 
 	WARN_ON_ONCE(dir->dead);
 
@@ -309,6 +310,31 @@ int ref_tracker_free(struct ref_tracker_dir *dir,
 					GFP_NOWAIT | __GFP_NOWARN);
 
 	spin_lock_irqsave(&dir->lock, flags);
+
+	list_for_each_entry(iter, &dir->quarantine, head) {
+		if (iter == tracker) {
+			pr_err("ref_tracker already in quarantine - double free detected.\n");
+			stack_depot_print(stack_handle);
+			spin_unlock_irqrestore(&dir->lock, flags);
+			WARN_ON_ONCE(1);
+			return -EINVAL;
+		}
+        }
+
+	list_for_each_entry(iter, &dir->list, head) {
+		if (iter == tracker) {
+			break;
+		}
+	}
+
+	if (iter != tracker) {
+		pr_err("ref_tracker not in active list - already freed or corrupted.\n");
+		stack_depot_print(stack_handle);
+		spin_unlock_irqrestore(&dir->lock, flags);
+		WARN_ON_ONCE(1);
+		return -EINVAL;
+	}
+
 	if (tracker->dead) {
 		pr_err("reference already released.\n");
 		if (tracker->alloc_stack_handle) {
-- 
2.34.1


