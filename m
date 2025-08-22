Return-Path: <linux-kernel+bounces-781288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF8CB3108A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EC7EAC415D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 07:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62B52E7BB9;
	Fri, 22 Aug 2025 07:34:21 +0000 (UTC)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53BD2E764D
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 07:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755848060; cv=none; b=K2bPpXw+2pyRjuymGER1XkSwRF4fwpp5avKsnH5shOjutHrJdmROuenD1PQwJdwCZH1NPLBKGhtnBe3HYk0HkV+XVu/L65cuBIyybitNeOEQhUuSGGMslOxuGOTj4kjvxTpU80bifvymHX6ZnDxcGTWYJDzFcT2lcHwkEeB6tnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755848060; c=relaxed/simple;
	bh=hGyK9NgR/DbXF3924uOzaoGtAFbgB68R5NSsgCWjOdc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gbXQa2HFa38UXv8XrndfX9Gfw6xTAU0j9xAxyYYSdNUmfwADHuMyaaPSXTs5sd3l7Tg472VaF07OZ9Ad4I1KX3OXMzbGxHIx6RxdFbMpvBJMicv2oG+zMU+FsMMUPhy9cdHQxs//+ovRnei26m1USPCwflxLsXfwc8JEK9O8NUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-50f88cd722bso543483137.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 00:34:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755848057; x=1756452857;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+zd/fta2fMfQmXWrnRWBKVykAsRKUs5bEyg/PKJKfBU=;
        b=buRnUJXjRsZQv+m5A7gWcFBLNWkZTquPHaApMRzpNXtpH+OqYhyRIQ0Luwoyg5qTRp
         6xBftIWHeXx7xGr0mHNtAG9QgSyQR9oREvwtkadfKCU8zVU73sfoRmEA2vmWYAm+5a5g
         GprW+BAI3URPtez21zDn1S+uRublOz4jh13L+2XfNYEfUGOrdQdwsSGtXkysmPowcxwv
         B6mfgfsi4UIF+61z3p1zJkwRj1jVN8X74SIpptHChOIoObxKaeHEHn8aNhKU69v7geNZ
         783vYJIxXBDeDqVWGJadK5Nlm2g3HR57FKagCM1PPzGdonrDXGNZJClBvrEsMlRy075u
         ZwbA==
X-Forwarded-Encrypted: i=1; AJvYcCWbQ3Oh6dLzDQLiwlVcY/a+dnhY9+C3Ow4qydd4/m4MMNt8ihDDlnRiK8RZaRQrJvT8gIi7ZVSKxEhC4pc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzubdebuXLALAfpzTpIBPZJhV8dqgebRlNwtn7R+YVCQcEstx4/
	w1M1XnWw0H8aC5nJlqTegFS3jnCQzXC1eF4L2jGN7764gHzpWH5Avnr8x4ZhyVzf
X-Gm-Gg: ASbGncuCgFFhf8U4gID41A/r265w84mbQQt/Zfbuix9si3FcyGZfZsn241izhTlzf+g
	K7hy4OTlCfqrrZGBmic5x/j+6VngsdQMks8rgb6EUTMNBgSZ7xdL7kU8DWhAthxRea4CRdch+PW
	1SoX0EQP10OFZ1EDzxBODm2Kxr0PY1XwTA9BDQl/vzjf9y8aOYArXvAeFWPImwWgHryo+BE/Rv2
	2WcAaCTCZrOBqqHIeAftfxnFXn/taDZcR98tcUuvQoX4Bkixjl/wpoJ2iSK7c2dg4y+O6Wxs7Qt
	ym5Ir5nP+OVk9TNo5sClJbTy1nwn96JUq6ooOTqG8j/6jvuQbN9gdhXWr2Ldy6W4nm7cfxyDAko
	HNZ5O+AxN6TaJMg1hDyxBpC5L9+YhM4BBamk2mgRYY8SJASW0p+LtTunyhQJ3
X-Google-Smtp-Source: AGHT+IEsnLuPPt46ERj5rjEmCIU2niTVMuyQVsdH0i4MUiU85HeruS5NuTRR2hEHKqF7NJY5QGagxA==
X-Received: by 2002:a05:6102:2c0d:b0:4fa:37cc:2877 with SMTP id ada2fe7eead31-51d09e15ffbmr594533137.0.1755848057099;
        Fri, 22 Aug 2025 00:34:17 -0700 (PDT)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-53b2bd552c1sm4205861e0c.3.2025.08.22.00.34.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Aug 2025 00:34:16 -0700 (PDT)
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-89018fa6f6dso563756241.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 00:34:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVLIuPgUjMDjRy3NVi+bNelG0uRrsdFAxjNKREzGskSnNust8vhFrtnBrkaFRwgrrfWwAbPMAiOSV8mk0w=@vger.kernel.org
X-Received: by 2002:a05:6102:cd0:b0:4fd:bbf2:6fce with SMTP id
 ada2fe7eead31-51d0d12e766mr492445137.9.1755848055510; Fri, 22 Aug 2025
 00:34:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250627072924.36567-1-lance.yang@linux.dev> <20250627072924.36567-3-lance.yang@linux.dev>
In-Reply-To: <20250627072924.36567-3-lance.yang@linux.dev>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 22 Aug 2025 09:34:03 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXR72M+oiJ_WmuHC0Xkq2m4=zqhP8DtW40mHyJTCdS+ew@mail.gmail.com>
X-Gm-Features: Ac12FXxVdc_cD0Xb_uzqKoxEosJAtG2Ywzf3DddL5ZR_ainigwq4pwW9T0-VQ6c
Message-ID: <CAMuHMdXR72M+oiJ_WmuHC0Xkq2m4=zqhP8DtW40mHyJTCdS+ew@mail.gmail.com>
Subject: Re: [PATCH 2/3] hung_task: extend hung task blocker tracking to rwsems
To: Lance Yang <ioworker0@gmail.com>
Cc: akpm@linux-foundation.org, zi.li@linux.dev, anna.schumaker@oracle.com, 
	boqun.feng@gmail.com, joel.granados@kernel.org, jstultz@google.com, 
	kent.overstreet@linux.dev, leonylgao@tencent.com, 
	linux-kernel@vger.kernel.org, longman@redhat.com, mhiramat@kernel.org, 
	mingo@redhat.com, mingzhe.yang@ly.com, peterz@infradead.org, 
	rostedt@goodmis.org, senozhatsky@chromium.org, tfiga@chromium.org, 
	will@kernel.org, Lance Yang <lance.yang@linux.dev>, Eero Tamminen <oak@helsinkinet.fi>, 
	linux-m68k <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"

Hi Lance,

On Fri, 27 Jun 2025 at 09:30, Lance Yang <ioworker0@gmail.com> wrote:
> From: Lance Yang <lance.yang@linux.dev>
>
> Inspired by mutex blocker tracking[1], and having already extended it to
> semaphores, let's now add support for reader-writer semaphores (rwsems).
>
> The approach is simple: when a task enters TASK_UNINTERRUPTIBLE while
> waiting for an rwsem, we just call hung_task_set_blocker(). The hung task
> detector can then query the rwsem's owner to identify the lock holder.
>
> Tracking works reliably for writers, as there can only be a single writer
> holding the lock, and its task struct is stored in the owner field.
>
> The main challenge lies with readers. The owner field points to only one
> of many concurrent readers, so we might lose track of the blocker if that
> specific reader unlocks, even while others remain. This is not a
> significant issue, however. In practice, long-lasting lock contention is
> almost always caused by a writer. Therefore, reliably tracking the writer
> is the primary goal of this patch series ;)
>
> With this change, the hung task detector can now show blocker task's info
> like below:
>
> [Fri Jun 27 15:21:34 2025] INFO: task cat:28631 blocked for more than 122 seconds.
> [Fri Jun 27 15:21:34 2025]       Tainted: G S                  6.16.0-rc3 #8
> [Fri Jun 27 15:21:34 2025] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [Fri Jun 27 15:21:34 2025] task:cat             state:D stack:0     pid:28631 tgid:28631 ppid:28501  task_flags:0x400000 flags:0x00004000
> [Fri Jun 27 15:21:34 2025] Call Trace:
> [Fri Jun 27 15:21:34 2025]  <TASK>
> [Fri Jun 27 15:21:34 2025]  __schedule+0x7c7/0x1930
> [Fri Jun 27 15:21:34 2025]  ? __pfx___schedule+0x10/0x10
> [Fri Jun 27 15:21:34 2025]  ? policy_nodemask+0x215/0x340
> [Fri Jun 27 15:21:34 2025]  ? _raw_spin_lock_irq+0x8a/0xe0
> [Fri Jun 27 15:21:34 2025]  ? __pfx__raw_spin_lock_irq+0x10/0x10
> [Fri Jun 27 15:21:34 2025]  schedule+0x6a/0x180
> [Fri Jun 27 15:21:34 2025]  schedule_preempt_disabled+0x15/0x30
> [Fri Jun 27 15:21:34 2025]  rwsem_down_read_slowpath+0x55e/0xe10
> [Fri Jun 27 15:21:34 2025]  ? __pfx_rwsem_down_read_slowpath+0x10/0x10
> [Fri Jun 27 15:21:34 2025]  ? __pfx___might_resched+0x10/0x10
> [Fri Jun 27 15:21:34 2025]  down_read+0xc9/0x230
> [Fri Jun 27 15:21:34 2025]  ? __pfx_down_read+0x10/0x10
> [Fri Jun 27 15:21:34 2025]  ? __debugfs_file_get+0x14d/0x700
> [Fri Jun 27 15:21:34 2025]  ? __pfx___debugfs_file_get+0x10/0x10
> [Fri Jun 27 15:21:34 2025]  ? handle_pte_fault+0x52a/0x710
> [Fri Jun 27 15:21:34 2025]  ? selinux_file_permission+0x3a9/0x590
> [Fri Jun 27 15:21:34 2025]  read_dummy_rwsem_read+0x4a/0x90
> [Fri Jun 27 15:21:34 2025]  full_proxy_read+0xff/0x1c0
> [Fri Jun 27 15:21:34 2025]  ? rw_verify_area+0x6d/0x410
> [Fri Jun 27 15:21:34 2025]  vfs_read+0x177/0xa50
> [Fri Jun 27 15:21:34 2025]  ? __pfx_vfs_read+0x10/0x10
> [Fri Jun 27 15:21:34 2025]  ? fdget_pos+0x1cf/0x4c0
> [Fri Jun 27 15:21:34 2025]  ksys_read+0xfc/0x1d0
> [Fri Jun 27 15:21:34 2025]  ? __pfx_ksys_read+0x10/0x10
> [Fri Jun 27 15:21:34 2025]  do_syscall_64+0x66/0x2d0
> [Fri Jun 27 15:21:34 2025]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [Fri Jun 27 15:21:34 2025] RIP: 0033:0x7f3f8faefb40
> [Fri Jun 27 15:21:34 2025] RSP: 002b:00007ffdeda5ab98 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> [Fri Jun 27 15:21:34 2025] RAX: ffffffffffffffda RBX: 0000000000010000 RCX: 00007f3f8faefb40
> [Fri Jun 27 15:21:34 2025] RDX: 0000000000010000 RSI: 00000000010fa000 RDI: 0000000000000003
> [Fri Jun 27 15:21:34 2025] RBP: 00000000010fa000 R08: 0000000000000000 R09: 0000000000010fff
> [Fri Jun 27 15:21:34 2025] R10: 00007ffdeda59fe0 R11: 0000000000000246 R12: 00000000010fa000
> [Fri Jun 27 15:21:34 2025] R13: 0000000000000003 R14: 0000000000000000 R15: 0000000000000fff
> [Fri Jun 27 15:21:34 2025]  </TASK>
> [Fri Jun 27 15:21:34 2025] INFO: task cat:28631 <reader> blocked on an rw-semaphore likely owned by task cat:28630 <writer>
> [Fri Jun 27 15:21:34 2025] task:cat             state:S stack:0     pid:28630 tgid:28630 ppid:28501  task_flags:0x400000 flags:0x00004000
> [Fri Jun 27 15:21:34 2025] Call Trace:
> [Fri Jun 27 15:21:34 2025]  <TASK>
> [Fri Jun 27 15:21:34 2025]  __schedule+0x7c7/0x1930
> [Fri Jun 27 15:21:34 2025]  ? __pfx___schedule+0x10/0x10
> [Fri Jun 27 15:21:34 2025]  ? __mod_timer+0x304/0xa80
> [Fri Jun 27 15:21:34 2025]  schedule+0x6a/0x180
> [Fri Jun 27 15:21:34 2025]  schedule_timeout+0xfb/0x230
> [Fri Jun 27 15:21:34 2025]  ? __pfx_schedule_timeout+0x10/0x10
> [Fri Jun 27 15:21:34 2025]  ? __pfx_process_timeout+0x10/0x10
> [Fri Jun 27 15:21:34 2025]  ? down_write+0xc4/0x140
> [Fri Jun 27 15:21:34 2025]  msleep_interruptible+0xbe/0x150
> [Fri Jun 27 15:21:34 2025]  read_dummy_rwsem_write+0x54/0x90
> [Fri Jun 27 15:21:34 2025]  full_proxy_read+0xff/0x1c0
> [Fri Jun 27 15:21:34 2025]  ? rw_verify_area+0x6d/0x410
> [Fri Jun 27 15:21:34 2025]  vfs_read+0x177/0xa50
> [Fri Jun 27 15:21:34 2025]  ? __pfx_vfs_read+0x10/0x10
> [Fri Jun 27 15:21:34 2025]  ? fdget_pos+0x1cf/0x4c0
> [Fri Jun 27 15:21:34 2025]  ksys_read+0xfc/0x1d0
> [Fri Jun 27 15:21:34 2025]  ? __pfx_ksys_read+0x10/0x10
> [Fri Jun 27 15:21:34 2025]  do_syscall_64+0x66/0x2d0
> [Fri Jun 27 15:21:34 2025]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [Fri Jun 27 15:21:34 2025] RIP: 0033:0x7f8f288efb40
> [Fri Jun 27 15:21:34 2025] RSP: 002b:00007ffffb631038 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> [Fri Jun 27 15:21:34 2025] RAX: ffffffffffffffda RBX: 0000000000010000 RCX: 00007f8f288efb40
> [Fri Jun 27 15:21:34 2025] RDX: 0000000000010000 RSI: 000000002a4b5000 RDI: 0000000000000003
> [Fri Jun 27 15:21:34 2025] RBP: 000000002a4b5000 R08: 0000000000000000 R09: 0000000000010fff
> [Fri Jun 27 15:21:34 2025] R10: 00007ffffb630460 R11: 0000000000000246 R12: 000000002a4b5000
> [Fri Jun 27 15:21:34 2025] R13: 0000000000000003 R14: 0000000000000000 R15: 0000000000000fff
> [Fri Jun 27 15:21:34 2025]  </TASK>
>
> [1] https://lore.kernel.org/all/174046694331.2194069.15472952050240807469.stgit@mhiramat.tok.corp.google.com/
>
> Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Suggested-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Signed-off-by: Lance Yang <lance.yang@linux.dev>

Thanks for your patch, which is now commit 194a9b9e843b4077
("hung_task: show the blocker task if the task is hung on
semaphore") in v6.16-rc1.

Eero reported [1] two WARNINGS seen with v6.16 on emulated Atari.
I managed to reproduce it on ARAnyM using the provided config (it does
not happen with atari_defconfig), and bisected it to this commit:

------------[ cut here ]------------
WARNING: CPU: 0 PID: 39 at include/linux/hung_task.h:48
__down_common+0x13a/0x1be
CPU: 0 UID: 0 PID: 39 Comm: getty Not tainted
6.15.0-rc6hatari-00018-g194a9b9e843b #1986 NONE
Stack from 01633d00:
        01633d00 00366e9e 00366e9e 00000000 002c9762 00360cb5 01633d24 0000873e
        00366e9e 01633d40 0002e0d4 00360cb5 00000030 00000009 0039c79a 00061408
        01633d78 000028e0 00360cb5 00000030 002c9762 00000009 00000000 00000000
        7fffffff 00000002 1185d266 01633eb0 01326c58 00000080 01633dc0 002c9762
        00360cb5 00000030 00000009 00000000 00002014 01326c00 1185d266 01633eb0
        002c93ea 00053d60 00061408 01326c58 0038db90 0038db90 01633e32 01633fb8
Call Trace: [<002c9762>] __down_common+0x13a/0x1be
 [<0000873e>] dump_stack+0x10/0x16
 [<0002e0d4>] __warn+0x7a/0xbc
 [<00061408>] msleep+0x0/0x2c
 [<000028e0>] warn_slowpath_fmt+0x42/0x62
 [<002c9762>] __down_common+0x13a/0x1be
 [<002c9762>] __down_common+0x13a/0x1be
 [<00002014>] arch_local_irq_enable+0xe/0x22
 [<002c93ea>] mutex_lock+0x0/0x28
 [<00053d60>] other_cpu_in_panic+0x0/0x26
 [<00061408>] msleep+0x0/0x2c
 [<002c97fc>] __down+0x16/0x1e
 [<002c9832>] down+0x2e/0x30
 [<00053dac>] console_lock+0x26/0x4c
 [<001aae4e>] do_con_write+0x3a/0x16d4
 [<002c93ea>] mutex_lock+0x0/0x28
 [<0004fa70>] __add_wait_queue+0x3a/0x6a
 [<001ac520>] con_write+0x1a/0x30
 [<0019cafa>] n_tty_write+0x2c6/0x35e
 [<00199456>] signal_pending+0x0/0x26
 [<000aba2a>] __kvmalloc_node_noprof+0x3a/0x114
 [<00004cc0>] io_uring_try_cancel_requests+0x98/0x318
 [<0004fb2e>] woken_wake_function+0x0/0x24
 [<0019a180>] file_tty_write.isra.0+0x144/0x1b8
 [<0019a206>] tty_write+0x12/0x16
 [<000b97c2>] vfs_write+0xec/0x148
 [<00028000>] fp_getdest+0x1b8/0x224
 [<00010000>] g_trace+0x16/0x28
 [<000b9916>] ksys_write+0x54/0x8a
 [<000b9962>] sys_write+0x16/0x1a
 [<000093da>] syscall+0x8/0xc
 [<0000c001>] arch_dma_prep_coherent+0x51/0x58

---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 39 at include/linux/hung_task.h:56
__down_common+0x17a/0x1be
CPU: 0 UID: 0 PID: 39 Comm: getty Tainted: G        W
6.15.0-rc6hatari-00018-g194a9b9e843b #1986 NONE
Tainted: [W]=WARN
Stack from 01633d00:
        01633d00 00366e9e 00366e9e 00000000 002c97a2 00360cb5 01633d24 0000873e
        00366e9e 01633d40 0002e0d4 00360cb5 00000038 00000009 0039c79a 01633db2
        01633d78 000028e0 00360cb5 00000038 002c97a2 00000009 00000000 00000000
        00000000 00000002 00000000 00000000 01326c58 0039c79a 01633dc0 002c97a2
        00360cb5 00000038 00000009 00000000 00002014 01326c00 1185d266 01633eb0
        002c93ea 00053d60 00061408 01326c58 00380000 01000000 01220162 b64001b8
Call Trace: [<002c97a2>] __down_common+0x17a/0x1be
 [<0000873e>] dump_stack+0x10/0x16
 [<0002e0d4>] __warn+0x7a/0xbc
 [<000028e0>] warn_slowpath_fmt+0x42/0x62
 [<002c97a2>] __down_common+0x17a/0x1be
 [<002c97a2>] __down_common+0x17a/0x1be
 [<00002014>] arch_local_irq_enable+0xe/0x22
 [<002c93ea>] mutex_lock+0x0/0x28
 [<00053d60>] other_cpu_in_panic+0x0/0x26
 [<00061408>] msleep+0x0/0x2c
 [<002c97fc>] __down+0x16/0x1e
 [<002c9832>] down+0x2e/0x30
 [<00053dac>] console_lock+0x26/0x4c
 [<001aae4e>] do_con_write+0x3a/0x16d4
 [<002c93ea>] mutex_lock+0x0/0x28
 [<0004fa70>] __add_wait_queue+0x3a/0x6a
 [<001ac520>] con_write+0x1a/0x30
 [<0019cafa>] n_tty_write+0x2c6/0x35e
 [<00199456>] signal_pending+0x0/0x26
 [<000aba2a>] __kvmalloc_node_noprof+0x3a/0x114
 [<00004cc0>] io_uring_try_cancel_requests+0x98/0x318
 [<0004fb2e>] woken_wake_function+0x0/0x24
 [<0019a180>] file_tty_write.isra.0+0x144/0x1b8
 [<0019a206>] tty_write+0x12/0x16
 [<000b97c2>] vfs_write+0xec/0x148
 [<00028000>] fp_getdest+0x1b8/0x224
 [<00010000>] g_trace+0x16/0x28
 [<000b9916>] ksys_write+0x54/0x8a
 [<000b9962>] sys_write+0x16/0x1a
 [<000093da>] syscall+0x8/0xc
 [<0000c001>] arch_dma_prep_coherent+0x51/0x58

---[ end trace 0000000000000000 ]---

It still happens on v6.17-rc2.  Reverting commits 77da18de55ac6417
("hung_task: extend hung task blocker tracking to rwsems") and
194a9b9e843b4077 ("hung_task: show the blocker task if the task is
hung on semaphore") fixes the issue for me.

Thanks!

[1] "v6.16 console issues on Atari Falcon"
    https://lore.kernel.org/all/92518308-c763-4591-96ef-6b38c5d8f434@helsinkinet.fi

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

