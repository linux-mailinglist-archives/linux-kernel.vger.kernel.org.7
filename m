Return-Path: <linux-kernel+bounces-782292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B3FEB31E6D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 17:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90C331897D08
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 15:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9412211A11;
	Fri, 22 Aug 2025 15:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LltHfBbd"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD18220B1F4
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 15:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755875922; cv=none; b=XC03MMTgAx9pzVwYkC7zsLuZdZlkqfQWWlT6uC+DECYQhi+Scq7U6TgMEhtILnIB0mTs3K6K5iliDag+bEPXfW1vSQDoUlDwX6eqGn+PJG4avlQO40sRtlHkO1b+whI+YAYHHkmJvadXVR/HNVT8zS2X63JVJ6aZvOiw84ltPRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755875922; c=relaxed/simple;
	bh=IYZgQKI03y918eQONBx3DSU7odWFvqMkWz41EDgh3RU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XczONIgoDjULV7QBQ2i8yVIpxzoy3kBRNX3twPMsaoKEzDdl1T7DROCWnA8DfN8a8t5+YURVJp0VJRv9HmV4YbrnV07W+CdXsVRk67D7RlLb2MbNYFFeNyW8n2azGpuXU6v+YL08BFvY1gvRCEmZN11IEtj7eWM3GYXXkYazf8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LltHfBbd; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <da53a828-137a-4efc-a192-a2b49a06d050@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755875917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ua95879Pvf7zkEEiHm84qVrH3woQsPV7xcvpBpzaf28=;
	b=LltHfBbd51kCb/JqRAhlGV+CykdU8zUVSQDvgeb2hPFCCaQW93l/o6Puid1U8VecGOa7YW
	h+ELdUfWHxXBWkccaOtTFchVBV2wAzFZfSXiDt4tOePGrtS0Mz463jA+mgQE7SMV1L8FWe
	gnqWLBNGElOGXyA1BE875hnvwAgIr9Y=
Date: Fri, 22 Aug 2025 23:18:25 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v5 2/3] hung_task: show the blocker task if the task is
 hung on semaphore
Content-Language: en-US
To: Geert Uytterhoeven <geert@linux-m68k.org>, senozhatsky@chromium.org,
 mhiramat@kernel.org
Cc: akpm@linux-foundation.org, will@kernel.org, peterz@infradead.org,
 mingo@redhat.com, longman@redhat.com, anna.schumaker@oracle.com,
 boqun.feng@gmail.com, joel.granados@kernel.org, kent.overstreet@linux.dev,
 leonylgao@tencent.com, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 tfiga@chromium.org, amaindex@outlook.com, jstultz@google.com,
 Mingzhe Yang <mingzhe.yang@ly.com>, Eero Tamminen <oak@helsinkinet.fi>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 Lance Yang <ioworker0@gmail.com>
References: <20250414145945.84916-1-ioworker0@gmail.com>
 <20250414145945.84916-3-ioworker0@gmail.com>
 <CAMuHMdW7Ab13DdGs2acMQcix5ObJK0O2dG_Fxzr8_g58Rc1_0g@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <CAMuHMdW7Ab13DdGs2acMQcix5ObJK0O2dG_Fxzr8_g58Rc1_0g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi Geert,

Thanks a lot for bisecting and reporting!

On 2025/8/22 15:38, Geert Uytterhoeven wrote:
> Hi Lance,
> 
> (this time the right email thread, I hope ;-)
> 
> On Mon, 14 Apr 2025 at 17:23, Lance Yang <ioworker0@gmail.com> wrote:
>> Inspired by mutex blocker tracking[1], this patch makes a trade-off to
>> balance the overhead and utility of the hung task detector.
>>
>> Unlike mutexes, semaphores lack explicit ownership tracking, making it
>> challenging to identify the root cause of hangs. To address this, we
>> introduce a last_holder field to the semaphore structure, which is
>> updated when a task successfully calls down() and cleared during up().
>>
>> The assumption is that if a task is blocked on a semaphore, the holders
>> must not have released it. While this does not guarantee that the last
>> holder is one of the current blockers, it likely provides a practical hint
>> for diagnosing semaphore-related stalls.
>>
[...]
> 
> Thanks for your patch, which is now commit 194a9b9e843b4077
> ("hung_task: show the blocker task if the task is hung on
> semaphore") in v6.16-rc1.
> 
> Eero reported [1] two WARNINGS seen with v6.16 on emulated Atari.
> I managed to reproduce it on ARAnyM using the provided config (it does
> not happen with atari_defconfig), and bisected it to this commit:

The two warnings are directly related, and the first one
is the root cause, IIUC.

> 
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 39 at include/linux/hung_task.h:48

The first warning at hung_task.h:48 is triggered because
WARN_ON_ONCE(lock_ptr & BLOCKER_TYPE_MASK) check fails.

static inline void hung_task_set_blocker(void *lock, unsigned long type)
{
	unsigned long lock_ptr = (unsigned long)lock;

	WARN_ON_ONCE(!lock_ptr);
	WARN_ON_ONCE(READ_ONCE(current->blocker));

	/*
	 * If the lock pointer matches the BLOCKER_TYPE_MASK, return
	 * without writing anything.
	 */
	if (WARN_ON_ONCE(lock_ptr & BLOCKER_TYPE_MASK)) <- here
		return;

This logic assumes the lock pointer is sufficiently aligned,
allowing the lower bits to be used for the lock type. But it
appears we are being passed an unaligned lock pointer,
unfortunately.

	WRITE_ONCE(current->blocker, lock_ptr | type);
}

Because the check fails, hung_task_set_blocker() returns
early without setting current->blocker, which directly
leads to the second warning at hung_task.h:56

> __down_common+0x13a/0x1be
> CPU: 0 UID: 0 PID: 39 Comm: getty Not tainted
> 6.15.0-rc6hatari-00018-g194a9b9e843b #1986 NONE
> Stack from 01633d00:
>          01633d00 00366e9e 00366e9e 00000000 002c9762 00360cb5 01633d24 0000873e
>          00366e9e 01633d40 0002e0d4 00360cb5 00000030 00000009 0039c79a 00061408
>          01633d78 000028e0 00360cb5 00000030 002c9762 00000009 00000000 00000000
>          7fffffff 00000002 1185d266 01633eb0 01326c58 00000080 01633dc0 002c9762
>          00360cb5 00000030 00000009 00000000 00002014 01326c00 1185d266 01633eb0
>          002c93ea 00053d60 00061408 01326c58 0038db90 0038db90 01633e32 01633fb8
> Call Trace: [<002c9762>] __down_common+0x13a/0x1be
>   [<0000873e>] dump_stack+0x10/0x16
>   [<0002e0d4>] __warn+0x7a/0xbc
>   [<00061408>] msleep+0x0/0x2c
>   [<000028e0>] warn_slowpath_fmt+0x42/0x62
>   [<002c9762>] __down_common+0x13a/0x1be
>   [<002c9762>] __down_common+0x13a/0x1be
>   [<00002014>] arch_local_irq_enable+0xe/0x22
>   [<002c93ea>] mutex_lock+0x0/0x28
>   [<00053d60>] other_cpu_in_panic+0x0/0x26
>   [<00061408>] msleep+0x0/0x2c
>   [<002c97fc>] __down+0x16/0x1e
>   [<002c9832>] down+0x2e/0x30
>   [<00053dac>] console_lock+0x26/0x4c
>   [<001aae4e>] do_con_write+0x3a/0x16d4
>   [<002c93ea>] mutex_lock+0x0/0x28
>   [<0004fa70>] __add_wait_queue+0x3a/0x6a
>   [<001ac520>] con_write+0x1a/0x30
>   [<0019cafa>] n_tty_write+0x2c6/0x35e
>   [<00199456>] signal_pending+0x0/0x26
>   [<000aba2a>] __kvmalloc_node_noprof+0x3a/0x114
>   [<00004cc0>] io_uring_try_cancel_requests+0x98/0x318
>   [<0004fb2e>] woken_wake_function+0x0/0x24
>   [<0019a180>] file_tty_write.isra.0+0x144/0x1b8
>   [<0019a206>] tty_write+0x12/0x16
>   [<000b97c2>] vfs_write+0xec/0x148
>   [<00028000>] fp_getdest+0x1b8/0x224
>   [<00010000>] g_trace+0x16/0x28
>   [<000b9916>] ksys_write+0x54/0x8a
>   [<000b9962>] sys_write+0x16/0x1a
>   [<000093da>] syscall+0x8/0xc
>   [<0000c001>] arch_dma_prep_coherent+0x51/0x58
> 
> ---[ end trace 0000000000000000 ]---
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 39 at include/linux/hung_task.h:56

Later, when hung_task_clear_blocker() is called, its
WARN_ON_ONCE triggers because it finds current->blocker
is still zero from the earlier failure.

static inline void hung_task_clear_blocker(void)
{
	WARN_ON_ONCE(!READ_ONCE(current->blocker)); <- here

	WRITE_ONCE(current->blocker, 0UL);
}

So, the unaligned lock pointer appears to be the root cause,
breaking the assumptions of the blocker tracking mechanism.

> __down_common+0x17a/0x1be
> CPU: 0 UID: 0 PID: 39 Comm: getty Tainted: G        W
> 6.15.0-rc6hatari-00018-g194a9b9e843b #1986 NONE
> Tainted: [W]=WARN
> Stack from 01633d00:
>          01633d00 00366e9e 00366e9e 00000000 002c97a2 00360cb5 01633d24 0000873e
>          00366e9e 01633d40 0002e0d4 00360cb5 00000038 00000009 0039c79a 01633db2
>          01633d78 000028e0 00360cb5 00000038 002c97a2 00000009 00000000 00000000
>          00000000 00000002 00000000 00000000 01326c58 0039c79a 01633dc0 002c97a2
>          00360cb5 00000038 00000009 00000000 00002014 01326c00 1185d266 01633eb0
>          002c93ea 00053d60 00061408 01326c58 00380000 01000000 01220162 b64001b8
> Call Trace: [<002c97a2>] __down_common+0x17a/0x1be
>   [<0000873e>] dump_stack+0x10/0x16
>   [<0002e0d4>] __warn+0x7a/0xbc
>   [<000028e0>] warn_slowpath_fmt+0x42/0x62
>   [<002c97a2>] __down_common+0x17a/0x1be
>   [<002c97a2>] __down_common+0x17a/0x1be
>   [<00002014>] arch_local_irq_enable+0xe/0x22
>   [<002c93ea>] mutex_lock+0x0/0x28
>   [<00053d60>] other_cpu_in_panic+0x0/0x26
>   [<00061408>] msleep+0x0/0x2c
>   [<002c97fc>] __down+0x16/0x1e
>   [<002c9832>] down+0x2e/0x30
>   [<00053dac>] console_lock+0x26/0x4c
>   [<001aae4e>] do_con_write+0x3a/0x16d4
>   [<002c93ea>] mutex_lock+0x0/0x28
>   [<0004fa70>] __add_wait_queue+0x3a/0x6a
>   [<001ac520>] con_write+0x1a/0x30
>   [<0019cafa>] n_tty_write+0x2c6/0x35e
>   [<00199456>] signal_pending+0x0/0x26
>   [<000aba2a>] __kvmalloc_node_noprof+0x3a/0x114
>   [<00004cc0>] io_uring_try_cancel_requests+0x98/0x318
>   [<0004fb2e>] woken_wake_function+0x0/0x24
>   [<0019a180>] file_tty_write.isra.0+0x144/0x1b8
>   [<0019a206>] tty_write+0x12/0x16
>   [<000b97c2>] vfs_write+0xec/0x148
>   [<00028000>] fp_getdest+0x1b8/0x224
>   [<00010000>] g_trace+0x16/0x28
>   [<000b9916>] ksys_write+0x54/0x8a
>   [<000b9962>] sys_write+0x16/0x1a
>   [<000093da>] syscall+0x8/0xc
>   [<0000c001>] arch_dma_prep_coherent+0x51/0x58
> 
> ---[ end trace 0000000000000000 ]---
> 
> It still happens on v6.17-rc2.  Reverting commits 77da18de55ac6417
> ("hung_task: extend hung task blocker tracking to rwsems") and
> 194a9b9e843b4077 ("hung_task: show the blocker task if the task is
> hung on semaphore") fixes the issue for me.

Thanks! I'm looking into it.

Lance

> 
> Thanks!
> 
> [1] "v6.16 console issues on Atari Falcon"
>      https://lore.kernel.org/all/92518308-c763-4591-96ef-6b38c5d8f434@helsinkinet.fi
> 
> Gr{oetje,eeting}s,
> 
>                          Geert
> 


