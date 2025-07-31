Return-Path: <linux-kernel+bounces-751900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5338DB16F06
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 11:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4996F3ADDD0
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 09:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0FA729CB52;
	Thu, 31 Jul 2025 09:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="b/htALRZ"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E448BF4FA
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 09:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753955488; cv=none; b=Skldxu4w9rbliYdblPnO4sgsoxGzibaG/OQoqdsrk4JNX85zHV08XQ/gYHZos62z5usE7H5N1zebtv3ltf70Vrhd3pufL3QC6lAujh5v90yoFLTuJ0eGPC2OI+G+P5GqrTAGRJ5R6MO5JUu8ByyeTGE8Tx1N4raKTE5nA12i9Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753955488; c=relaxed/simple;
	bh=eYUeaKiCmL/zOn7Jm80x6klMLR2T92q9Blw1PdGs2nk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jdkIzCezppfQi9K1OJ0XYUQuQKhnQG49rUFPBoAmxCToWsM0AWQMvZCoWolKhS5l6v574Y9TZV2nDh3iFx6yakm3Bru2AcgxUOalW3DQomimQlMtgw0VWhE6k7VkEWC0uQpj9JZN2GS+j3ZY7ewsYKxWNr+YHrb1D46cqunTml4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=b/htALRZ; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2406fe901fcso8783165ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 02:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753955485; x=1754560285; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kKKKnXRg7JsP7e6OYP4fYKsmB1zCRKVCmYDMPFZVSmM=;
        b=b/htALRZMlGl7kAFFZv12YW2zN+W+jUc4AAp8dy4t0O68Y+MBVYOXukTCUAc7qIBB2
         56LmK1mPIZZJxYkAwlN4W7iKQxuSNOXmsvMDiBQtQZ5bUaeUK+OSa33CPgVpvs9oB7vB
         DYzNJVjnWSHND3HwOzp4n3QOIMlUi4mSTpFjQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753955485; x=1754560285;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kKKKnXRg7JsP7e6OYP4fYKsmB1zCRKVCmYDMPFZVSmM=;
        b=Dx0e/6cDd+RBJGm3JuP1rNed/pMFZKN+Z5jmpQ7uuHiZ8aXGy47VmprdU+ZUy/HXFs
         EQV2AOza581Kq2ksKunQbDUIiD3KN3/M3yLooGWsfKcPJw7CVJOR2a3HwjzV+ATFo60U
         Im7P/td4mBWAPJv5hk1jlHnyi5SaDJeRiuWdc4TXHDXbUjTaD8MptRrgW+8MOZSFDIKT
         3gKLyJav8DyjAJRokXUDv0jLCiYWg+mKQKM4limOEQ9ZEtuMClnagp0URYB+wr5npOOH
         gJDfy7X2muhpJrfsK0fiDA+I5mrYT1J6cI39yypsUIjVn/BTgNU5iHw3QPpHcp63dbYO
         1KDQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7SjXbbLKE40BMyn8pExKl/MbR/53KdV0quObQzQuGYcer0DMSaz5Fmql/9xMF9/APS93l0Cbs6pwslHk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr/bhM9ZSXndycsOsWXyShRkRsKDdNI7kTz5HzZGU+/mi471W2
	uCmN9xkOjxAUoGNQrSNGZiSYJRw4NX1zgVqlCIN8kg4F2n3wIzv0VII39c/78DkaS7CcytaseLA
	Eku8=
X-Gm-Gg: ASbGncsIB216oo+YCkw1nkJidGY6WX4zUswGWI4ptfVJnn4BNS9K9Cfic/FMCvtZ1AW
	pfuxsjUfTRE+4z4S7i6qZt1DWQUi1MN5UI6rcYKmRak0RT7a+EqETUbhx3/ICEAdSeaEVu00P0p
	0ZEzBjp/HyFj2Zr/06jPbRdsI1Ra8xcXGWnebd0IrUp46tutd5u0qSQxdo73kEBFriMwFlKKgAA
	6Glu4icpZo+oDgtzPzMN53aHfhAFkMOuzxPKtFftTVIjesWLCvjSZARa5ltYNn8zQoQNsdiN1sg
	+LCV45m4UP25H8optTJDxkOK6RgDQiAZ4H+Vi4C30D1YrjPjmpfniZtYzwscB+Bwh8eOJ4WfRDI
	JPKaP9kYQK2fQZWcsfwYyCFES/TLhcbIe8Hwy
X-Google-Smtp-Source: AGHT+IFa9U2uuxyoQGvOPEFv6OcRf+BqEtrGBqSTLKMrKEgEVDOVjm8xxg2Pky+0U6FFsXe+u7mNSA==
X-Received: by 2002:a17:903:240c:b0:240:3ef:e17d with SMTP id d9443c01a7336-24096b3551bmr93714765ad.40.1753955485092;
        Thu, 31 Jul 2025 02:51:25 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:9455:d03d:1e86:6ce4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef7d96sm13499995ad.18.2025.07.31.02.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 02:51:24 -0700 (PDT)
Date: Thu, 31 Jul 2025 18:51:20 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>, 
	Feng Tang <feng.tang@linux.alibaba.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] panic: remove redundant panic-cpu backtrace
Message-ID: <af77hin3ywef3kpw6p6mpfdkukxwfrwh5cvyozlgtvq4pefgl7@3eozofs75xfo>
References: <20250731030314.3818040-1-senozhatsky@chromium.org>
 <84seichm5t.fsf@jogness.linutronix.de>
 <2kwymhiz4fcozfmbmj6ju2qatsbmnrtiidfa4nxrqutgwa6xfy@dbf3caohbbay>
 <84pldghkho.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84pldghkho.fsf@jogness.linutronix.de>

On (25/07/31 09:51), John Ogness wrote:
> > Another way to get backtrace on panic CPU is via BUG(), which routes
> > through die()->__die_body(), which prints registers, stack trace,
> > and so on, before it calls into panic().  This might be x86 specific,
> > though.
> 
> So in that case you see 2 stack traces if CONFIG_DEBUG_BUGVERBOSE=y?

Yes.

Triggering BUG() with panic_print=0x40 generates two panic CPU
backtraces - one from die() trap handler and one from NMI:

[..]
<2>[   44.003032] kernel BUG at fs/drop_caches.c:68!
<4>[   44.003138] Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
<4>[   44.003302] CPU: 2 UID: 0 PID: 3560 Comm: bash Not tainted 6.12.24-kasan-00964-gcf04fce2879f-dirty #1 77a011f1de55cafdc697f1d21852e4a93167feea
<4>[   44.003624] RIP: 0010:drop_caches_sysctl_handler+0xe5/0xf0
<4>[   44.003732] Code: ...
<4>[   44.003954] RSP: 0018:ffff888053cd7cd8 EFLAGS: 00010202
<4>[   44.004058] RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000002
<4>[   44.004215] RDX: 0000000000000000 RSI: dffffc0000000000 RDI: 0000000000000000
<4>[   44.004369] RBP: ffff888053cd7cf0 R08: ffff888053cd7be8 R09: 0000000000000001
<4>[   44.004461] R10: ffff888053cd7b00 R11: ffffffff888ce910 R12: ffff888053cd7db8
<4>[   44.004617] R13: dffffc0000000000 R14: 0000000000000001 R15: 1ffffffff1ad5821
<4>[   44.004773] FS:  000078fd06d9f740(0000) GS:ffff88810b100000(0000) knlGS:0000000000000000
<4>[   44.004868] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
<4>[   44.005022] CR2: 00005a31efb86c60 CR3: 00000001021f8000 CR4: 00000000003506f0
<4>[   44.005178] Call Trace:
<4>[   44.005268]  <TASK>
<4>[   44.005360]  proc_sys_call_handler+0x34a/0x550
<4>[   44.005467]  vfs_write+0x76a/0xa80
<4>[   44.005628]  ? proc_sys_read+0x20/0x20
<4>[   44.005734]  ksys_write+0xb4/0x160
<4>[   44.005835]  do_syscall_64+0x6a/0xe0
<4>[   44.006715]  entry_SYSCALL_64_after_hwframe+0x55/0x5d
<4>[   44.006876] RIP: 0033:0x78fd06ec1594
<4>[   44.006973] Code: ...
<4>[   44.007195] RSP: 002b:00007ffe87fcd618 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
<4>[   44.007297] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 000078fd06ec1594
<4>[   44.007451] RDX: 0000000000000002 RSI: 0000573b1ca40130 RDI: 0000000000000001
<4>[   44.007626] RBP: 00007ffe87fcd640 R08: 0000000000000001 R09: 0000000000000001
<4>[   44.007731] R10: 000078fd06f55820 R11: 0000000000000202 R12: 0000000000000002
<4>[   44.007906] R13: 0000573b1ca40130 R14: 000078fd06f945c0 R15: 000078fd06f91f20
<4>[   44.008093]  </TASK>
<4>[   44.008192] Modules linked in: [...]
<0>[   44.017630] gsmi: Log Shutdown Reason 0x03
<4>[   44.017886] ---[ end trace 0000000000000000 ]---
<4>[   44.037806] RIP: 0010:drop_caches_sysctl_handler+0xe5/0xf0
<4>[   44.037926] Code: ...
<4>[   44.038078] RSP: 0018:ffff888053cd7cd8 EFLAGS: 00010202
<4>[   44.038143] RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000002
<4>[   44.038249] RDX: 0000000000000000 RSI: dffffc0000000000 RDI: 0000000000000000
<4>[   44.038310] RBP: ffff888053cd7cf0 R08: ffff888053cd7be8 R09: 0000000000000001
<4>[   44.038416] R10: ffff888053cd7b00 R11: ffffffff888ce910 R12: ffff888053cd7db8
<4>[   44.038521] R13: dffffc0000000000 R14: 0000000000000001 R15: 1ffffffff1ad5821
<4>[   44.038581] FS:  000078fd06d9f740(0000) GS:ffff88810b100000(0000) knlGS:0000000000000000
<4>[   44.038688] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
<4>[   44.038803] CR2: 00005a31efb86c60 CR3: 00000001021f8000 CR4: 00000000003506f0
<0>[   44.038865] Kernel panic - not syncing: Fatal exception
<4>[   44.038971] NMI backtrace for cpu 2
<4>[   44.038978] CPU: 2 UID: 0 PID: 3560 Comm: bash Tainted: G      D            6.12.24-kasan-00964-gcf04fce2879f-dirty #1 77a011f1de55cafdc697f1d21852e4a93167feea
<4>[   44.038988] Tainted: [D]=DIE
<4>[   44.038996] Call Trace:
<4>[   44.039001]  <TASK>
<4>[   44.039005]  nmi_cpu_backtrace+0x14c/0x1a0
<4>[   44.039016]  ? arch_trigger_cpumask_backtrace+0x20/0x20
<4>[   44.039026]  nmi_trigger_cpumask_backtrace+0xd8/0x1b0
<4>[   44.039035]  panic_other_cpus_shutdown+0x2d/0x80
<4>[   44.039045]  panic+0x199/0x450
<4>[   44.039055]  oops_end+0xb9/0xc0
<4>[   44.039062]  do_trap+0x10c/0x330
<4>[   44.039089]  handle_invalid_op+0x95/0xd0
<4>[   44.039095]  ? drop_caches_sysctl_handler+0xe5/0xf0
<4>[   44.039102]  exc_invalid_op+0x3c/0x50
<4>[   44.039110]  asm_exc_invalid_op+0x16/0x20
<4>[   44.039118] RIP: 0010:drop_caches_sysctl_handler+0xe5/0xf0
<4>[   44.039124] Code: ...
<4>[   44.039129] RSP: 0018:ffff888053cd7cd8 EFLAGS: 00010202
<4>[   44.039135] RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000002
<4>[   44.039139] RDX: 0000000000000000 RSI: dffffc0000000000 RDI: 0000000000000000
<4>[   44.039143] RBP: ffff888053cd7cf0 R08: ffff888053cd7be8 R09: 0000000000000001
<4>[   44.039148] R10: ffff888053cd7b00 R11: ffffffff888ce910 R12: ffff888053cd7db8
<4>[   44.039152] R13: dffffc0000000000 R14: 0000000000000001 R15: 1ffffffff1ad5821
<4>[   44.039158]  ? proc_dointvec_minmax+0xe0/0xe0
<4>[   44.039168]  ? drop_caches_sysctl_handler+0x15/0xf0
<4>[   44.039174]  proc_sys_call_handler+0x34a/0x550
<4>[   44.039184]  vfs_write+0x76a/0xa80
<4>[   44.039191]  ? proc_sys_read+0x20/0x20
<4>[   44.039201]  ksys_write+0xb4/0x160
<4>[   44.039208]  do_syscall_64+0x6a/0xe0
<4>[   44.039259]  entry_SYSCALL_64_after_hwframe+0x55/0x5d
<4>[   44.039265] RIP: 0033:0x78fd06ec1594
<4>[   44.039273] Code: ...
<4>[   44.039278] RSP: 002b:00007ffe87fcd618 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
<4>[   44.039285] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 000078fd06ec1594
<4>[   44.039289] RDX: 0000000000000002 RSI: 0000573b1ca40130 RDI: 0000000000000001
<4>[   44.039294] RBP: 00007ffe87fcd640 R08: 0000000000000001 R09: 0000000000000001
<4>[   44.039298] R10: 000078fd06f55820 R11: 0000000000000202 R12: 0000000000000002
<4>[   44.039302] R13: 0000573b1ca40130 R14: 000078fd06f945c0 R15: 000078fd06f91f20
<4>[   44.039310]  </TASK>
<6>[   44.039314] Sending NMI from CPU 2 to CPUs 0-1,3:
[..]

panic() with DEBUG_BUGVERBOSE and panic_print=0x40, two backtraces
on the panic CPU:

[..]
<0>[   45.149482] Kernel panic - not syncing: BOOM
<4>[   45.149792] CPU: 1 UID: 0 PID: 3512 Comm: bash Not tainted 6.12.24-kasan-00964-gcf04fce2879f-dirty #1 221d6609d9c374a289b848042333fd4fa6f5bddd
<4>[   45.150176] Call Trace:
<4>[   45.150285]  <TASK>
<4>[   45.150394]  panic+0x190/0x450
<4>[   45.150529]  drop_caches_sysctl_handler+0xb4/0xe0
<4>[   45.150727]  proc_sys_call_handler+0x34a/0x550
<4>[   45.150858]  vfs_write+0x76a/0xa80
<4>[   45.150978]  ? proc_sys_read+0x20/0x20
<4>[   45.151182]  ksys_write+0xb4/0x160
<4>[   45.151303]  do_syscall_64+0x6a/0xe0
<4>[   45.154298]  entry_SYSCALL_64_after_hwframe+0x55/0x5d
<4>[   45.154490] RIP: 0033:0x797c7ab90594
<4>[   45.154608] Code: ...
<4>[   45.154866] RSP: 002b:00007fff4f3ae9f8 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
<4>[   45.154998] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 0000797c7ab90594
<4>[   45.155183] RDX: 0000000000000002 RSI: 0000577d00a03130 RDI: 0000000000000001
<4>[   45.155365] RBP: 00007fff4f3aea20 R08: 0000000000000001 R09: 0000000000000001
<4>[   45.155478] R10: 0000797c7ac24820 R11: 0000000000000202 R12: 0000000000000002
<4>[   45.155689] R13: 0000577d00a03130 R14: 0000797c7ac635c0 R15: 0000797c7ac60f20
<4>[   45.155884]  </TASK>
<4>[   45.155992] NMI backtrace for cpu 1
<4>[   45.156005] CPU: 1 UID: 0 PID: 3512 Comm: bash Not tainted 6.12.24-kasan-00964-gcf04fce2879f-dirty #1 221d6609d9c374a289b848042333fd4fa6f5bddd
<4>[   45.156042] Call Trace:
<4>[   45.156054]  <TASK>
<4>[   45.156065]  nmi_cpu_backtrace+0x14c/0x1a0
<4>[   45.156094]  ? arch_trigger_cpumask_backtrace+0x20/0x20
<4>[   45.156122]  nmi_trigger_cpumask_backtrace+0xd8/0x1b0
<4>[   45.156149]  panic_other_cpus_shutdown+0x2d/0x80
<4>[   45.156176]  panic+0x199/0x450
<4>[   45.156206]  drop_caches_sysctl_handler+0xb4/0xe0
<4>[   45.156229]  proc_sys_call_handler+0x34a/0x550
<4>[   45.156259]  vfs_write+0x76a/0xa80
<4>[   45.156279]  ? proc_sys_read+0x20/0x20
<4>[   45.156313]  ksys_write+0xb4/0x160
<4>[   45.156338]  do_syscall_64+0x6a/0xe0
<4>[   45.156788]  entry_SYSCALL_64_after_hwframe+0x55/0x5d
<4>[   45.156810] RIP: 0033:0x797c7ab90594
<4>[   45.156829] Code: ...
<4>[   45.156846] RSP: 002b:00007fff4f3ae9f8 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
<4>[   45.156869] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 0000797c7ab90594
<4>[   45.156884] RDX: 0000000000000002 RSI: 0000577d00a03130 RDI: 0000000000000001
<4>[   45.156899] RBP: 00007fff4f3aea20 R08: 0000000000000001 R09: 0000000000000001
<4>[   45.156913] R10: 0000797c7ac24820 R11: 0000000000000202 R12: 0000000000000002
<4>[   45.156927] R13: 0000577d00a03130 R14: 0000797c7ac635c0 R15: 0000797c7ac60f20
<4>[   45.156954]  </TASK>
<6>[   45.156965] Sending NMI from CPU 1 to CPUs 0,2-3:
[..]

