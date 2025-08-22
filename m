Return-Path: <linux-kernel+bounces-781295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 756C7B3109D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1275E600FA9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 07:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EBFD2E8E0B;
	Fri, 22 Aug 2025 07:38:56 +0000 (UTC)
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8E22E888B
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 07:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755848335; cv=none; b=AS3KM60Fnha772AvLlLcWDFUCGDBCyYdZtV7Lli83STsE6Mn9cPGAgbUMC8vLpaNluWscfPYW74fqOVl45N3SYhUTeuzCraHoj/8C/B70PUbpJEwahVQ9X5CJE+EkSpXMGUip6gTwF55Xy6jJ2jbHEd+3dOCM7k0Sqo5Zao3fW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755848335; c=relaxed/simple;
	bh=qlw1BewNgTbcxk9+Zfxfd0FREHyppZ5bbOnRW4JLKOQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rq525erjp0rL+e8GVdN0qtWnAX9Mjdie5qehRuRCsJy/oCpGf+2I98N81oeSGqF8q+J8xeMlIuX/qrBNeYrf7Z7Tq5XTRn6gPrAQS0RNNGF2aAVE0vp26xqgiPlLFES5RzqV/8en9qqZuIfJhqtKJH3W9a+TSQMo4xk0MkqdZPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-53b174ac3e5so672182e0c.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 00:38:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755848331; x=1756453131;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xc+ad6ueJZivvK7qf2yMrtzdxyOSdaq18ItNm0zJyQ4=;
        b=UynGFrBBLAHILAjeHYUVKT9X8WOTO8PNzktKkNhg7VAfhkySEFkJfp0kGYuqOH5a0s
         eOlixu8g5+tbG22YwwvcgigOZ7ggrJRlkgPctuaUL7pph5HKi0d6y9BpAFnmwubohKB/
         G6dfXwBiCkvY5iQhWn3ssw9avVmwWXzi4xXDYOaUknT9SvJn1T8Cz5LZY1/skn0tTipw
         +zy23rpTmaEkB7ojbK3gRgLJbc9GfeKJcQ7Bg9zH7yzOV7Zi/hyEeFA8anz31Umxxp0J
         ZWT94Ow6jcSlWHXuZGalpTNfsuS49e07nGhUej/WIQ3u+SAVk1R7TL4AM2XBZ2+HFW2z
         Deqw==
X-Forwarded-Encrypted: i=1; AJvYcCXhJB08Y4QZB18peUpSynhwuhSWaa+9HOGGp7zRaO2V1RQc9dhHhUy5k4akkmUqkVZkU9qgBIRr/t7Qxi8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhTmPvGP+ZXbBMlxAruEJKAvDXCUkMQ6eh0NJ0pgkbA56+A28B
	mvzobdqQO4EzFQGpv4Ca91YYDmbE3SovgP2pWeYp1+xq7pOn+wXjPCBg2rw5uwo/
X-Gm-Gg: ASbGncvv55ds1EiDxFeJZAGUHI4gPvSA2Er9P8QjBfRcZbMjTwtxhyvsDXnHVYwel3u
	lWw6E/ITUxetQcywZFli8+Ss2h3v5+BL5qBdCWK6fX3n3VIEm1PBH5mH7vV0VRMxn8BS9DMoclm
	tPjTzoDeqW31I1l0G06CNB9pRK2sGhKWoFBPWPUqq+KK4F6NqOL1mbJA3Uae+bzAzCBOqbyId6F
	i86XSzVNqBqDeF86N9xUeLU6uUTdaAZROgVIZN4bgN1iRthJgElQN+WQo1bILSqRe7CIj/p0DvE
	m+hV3W7qBYECZzqEJP4UZxzqQzOGuOiwbh0i/JcgLFkzesjRw0MPqVfLlw0lLw5h8L2qTt90p8Y
	NSDSuJ/0Og9oe9NIhH2jEDI4eCh7PPiMdqusT3brs+jNH8HuNV4vf/NL2tRzzKla2HsRyBUBN7e
	E=
X-Google-Smtp-Source: AGHT+IEXcTeaJXuQxohaaJO8jGQ5yUI1J/o4xuBUzezHiIHN8xbJAg2Xldqp829QcewWex869fhB3w==
X-Received: by 2002:a05:6122:1ad2:b0:53c:896e:2870 with SMTP id 71dfb90a1353d-53c8a40b923mr519164e0c.12.1755848330987;
        Fri, 22 Aug 2025 00:38:50 -0700 (PDT)
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com. [209.85.221.175])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-53b2bd9a854sm4208197e0c.11.2025.08.22.00.38.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Aug 2025 00:38:50 -0700 (PDT)
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-53b1737003bso645638e0c.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 00:38:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWrtz3JEKnkVLHoKoLJtF+T3VMGZ4IMMG/lCycVB8Mu9eHPkbHQ+d5k5Zd3jf7H0IjscljLaim3XSnyNgc=@vger.kernel.org
X-Received: by 2002:a05:6102:4589:b0:519:534a:6c22 with SMTP id
 ada2fe7eead31-51d0f90c662mr535141137.32.1755848329730; Fri, 22 Aug 2025
 00:38:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250414145945.84916-1-ioworker0@gmail.com> <20250414145945.84916-3-ioworker0@gmail.com>
In-Reply-To: <20250414145945.84916-3-ioworker0@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 22 Aug 2025 09:38:38 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW7Ab13DdGs2acMQcix5ObJK0O2dG_Fxzr8_g58Rc1_0g@mail.gmail.com>
X-Gm-Features: Ac12FXya42sPjt2fsPaBDM-XMot0XSFHHv5h6MzVpLqabH-uSeTQ2vTLYZCzxTk
Message-ID: <CAMuHMdW7Ab13DdGs2acMQcix5ObJK0O2dG_Fxzr8_g58Rc1_0g@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] hung_task: show the blocker task if the task is
 hung on semaphore
To: Lance Yang <ioworker0@gmail.com>
Cc: akpm@linux-foundation.org, will@kernel.org, peterz@infradead.org, 
	mingo@redhat.com, longman@redhat.com, mhiramat@kernel.org, 
	anna.schumaker@oracle.com, boqun.feng@gmail.com, joel.granados@kernel.org, 
	kent.overstreet@linux.dev, leonylgao@tencent.com, 
	linux-kernel@vger.kernel.org, rostedt@goodmis.org, senozhatsky@chromium.org, 
	tfiga@chromium.org, amaindex@outlook.com, jstultz@google.com, 
	Mingzhe Yang <mingzhe.yang@ly.com>, Eero Tamminen <oak@helsinkinet.fi>, 
	linux-m68k <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"

Hi Lance,

(this time the right email thread, I hope ;-)

On Mon, 14 Apr 2025 at 17:23, Lance Yang <ioworker0@gmail.com> wrote:
> Inspired by mutex blocker tracking[1], this patch makes a trade-off to
> balance the overhead and utility of the hung task detector.
>
> Unlike mutexes, semaphores lack explicit ownership tracking, making it
> challenging to identify the root cause of hangs. To address this, we
> introduce a last_holder field to the semaphore structure, which is
> updated when a task successfully calls down() and cleared during up().
>
> The assumption is that if a task is blocked on a semaphore, the holders
> must not have released it. While this does not guarantee that the last
> holder is one of the current blockers, it likely provides a practical hint
> for diagnosing semaphore-related stalls.
>
> With this change, the hung task detector can now show blocker task's info
> like below:
>
> [Tue Apr  8 12:19:07 2025] INFO: task cat:945 blocked for more than 120 seconds.
> [Tue Apr  8 12:19:07 2025]       Tainted: G            E      6.14.0-rc6+ #1
> [Tue Apr  8 12:19:07 2025] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [Tue Apr  8 12:19:07 2025] task:cat             state:D stack:0     pid:945   tgid:945   ppid:828    task_flags:0x400000 flags:0x00000000
> [Tue Apr  8 12:19:07 2025] Call Trace:
> [Tue Apr  8 12:19:07 2025]  <TASK>
> [Tue Apr  8 12:19:07 2025]  __schedule+0x491/0xbd0
> [Tue Apr  8 12:19:07 2025]  schedule+0x27/0xf0
> [Tue Apr  8 12:19:07 2025]  schedule_timeout+0xe3/0xf0
> [Tue Apr  8 12:19:07 2025]  ? __folio_mod_stat+0x2a/0x80
> [Tue Apr  8 12:19:07 2025]  ? set_ptes.constprop.0+0x27/0x90
> [Tue Apr  8 12:19:07 2025]  __down_common+0x155/0x280
> [Tue Apr  8 12:19:07 2025]  down+0x53/0x70
> [Tue Apr  8 12:19:07 2025]  read_dummy_semaphore+0x23/0x60
> [Tue Apr  8 12:19:07 2025]  full_proxy_read+0x5f/0xa0
> [Tue Apr  8 12:19:07 2025]  vfs_read+0xbc/0x350
> [Tue Apr  8 12:19:07 2025]  ? __count_memcg_events+0xa5/0x140
> [Tue Apr  8 12:19:07 2025]  ? count_memcg_events.constprop.0+0x1a/0x30
> [Tue Apr  8 12:19:07 2025]  ? handle_mm_fault+0x180/0x260
> [Tue Apr  8 12:19:07 2025]  ksys_read+0x66/0xe0
> [Tue Apr  8 12:19:07 2025]  do_syscall_64+0x51/0x120
> [Tue Apr  8 12:19:07 2025]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [Tue Apr  8 12:19:07 2025] RIP: 0033:0x7f419478f46e
> [Tue Apr  8 12:19:07 2025] RSP: 002b:00007fff1c4d2668 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> [Tue Apr  8 12:19:07 2025] RAX: ffffffffffffffda RBX: 0000000000020000 RCX: 00007f419478f46e
> [Tue Apr  8 12:19:07 2025] RDX: 0000000000020000 RSI: 00007f4194683000 RDI: 0000000000000003
> [Tue Apr  8 12:19:07 2025] RBP: 00007f4194683000 R08: 00007f4194682010 R09: 0000000000000000
> [Tue Apr  8 12:19:07 2025] R10: fffffffffffffbc5 R11: 0000000000000246 R12: 0000000000000000
> [Tue Apr  8 12:19:07 2025] R13: 0000000000000003 R14: 0000000000020000 R15: 0000000000020000
> [Tue Apr  8 12:19:07 2025]  </TASK>
> [Tue Apr  8 12:19:07 2025] INFO: task cat:945 blocked on a semaphore likely last held by task cat:938
> [Tue Apr  8 12:19:07 2025] task:cat             state:S stack:0     pid:938   tgid:938   ppid:584    task_flags:0x400000 flags:0x00000000
> [Tue Apr  8 12:19:07 2025] Call Trace:
> [Tue Apr  8 12:19:07 2025]  <TASK>
> [Tue Apr  8 12:19:07 2025]  __schedule+0x491/0xbd0
> [Tue Apr  8 12:19:07 2025]  ? _raw_spin_unlock_irqrestore+0xe/0x40
> [Tue Apr  8 12:19:07 2025]  schedule+0x27/0xf0
> [Tue Apr  8 12:19:07 2025]  schedule_timeout+0x77/0xf0
> [Tue Apr  8 12:19:07 2025]  ? __pfx_process_timeout+0x10/0x10
> [Tue Apr  8 12:19:07 2025]  msleep_interruptible+0x49/0x60
> [Tue Apr  8 12:19:07 2025]  read_dummy_semaphore+0x2d/0x60
> [Tue Apr  8 12:19:07 2025]  full_proxy_read+0x5f/0xa0
> [Tue Apr  8 12:19:07 2025]  vfs_read+0xbc/0x350
> [Tue Apr  8 12:19:07 2025]  ? __count_memcg_events+0xa5/0x140
> [Tue Apr  8 12:19:07 2025]  ? count_memcg_events.constprop.0+0x1a/0x30
> [Tue Apr  8 12:19:07 2025]  ? handle_mm_fault+0x180/0x260
> [Tue Apr  8 12:19:07 2025]  ksys_read+0x66/0xe0
> [Tue Apr  8 12:19:07 2025]  do_syscall_64+0x51/0x120
> [Tue Apr  8 12:19:07 2025]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [Tue Apr  8 12:19:07 2025] RIP: 0033:0x7f7c584a646e
> [Tue Apr  8 12:19:07 2025] RSP: 002b:00007ffdba8ce158 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> [Tue Apr  8 12:19:07 2025] RAX: ffffffffffffffda RBX: 0000000000020000 RCX: 00007f7c584a646e
> [Tue Apr  8 12:19:07 2025] RDX: 0000000000020000 RSI: 00007f7c5839a000 RDI: 0000000000000003
> [Tue Apr  8 12:19:07 2025] RBP: 00007f7c5839a000 R08: 00007f7c58399010 R09: 0000000000000000
> [Tue Apr  8 12:19:07 2025] R10: fffffffffffffbc5 R11: 0000000000000246 R12: 0000000000000000
> [Tue Apr  8 12:19:07 2025] R13: 0000000000000003 R14: 0000000000020000 R15: 0000000000020000
> [Tue Apr  8 12:19:07 2025]  </TASK>
>
> [1] https://lore.kernel.org/all/174046694331.2194069.15472952050240807469.stgit@mhiramat.tok.corp.google.com
>
> Suggested-by: Andrew Morton <akpm@linux-foundation.org>
> Suggested-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Signed-off-by: Mingzhe Yang <mingzhe.yang@ly.com>
> Signed-off-by: Lance Yang <ioworker0@gmail.com>
> Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

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

