Return-Path: <linux-kernel+bounces-750454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF7EB15B75
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 11:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BE623BE35C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 09:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A1D270EBF;
	Wed, 30 Jul 2025 09:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SubXcjS1"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318F5270542
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 09:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753867394; cv=none; b=nk57Ys0TQefa/WXsz3nvfBoDZTJl2+mtOyaxpyaYBlsA0Lbv26d9kWHkr1T4v6BGvS/cKpI+y1yK1pQQFu+inze9qMk/OqDqL930b4cVT4yrTuFbaBSCeXTe31R+yzUMOti0aMFP5ERlx2BiRlZybaINzXSy7pnVCDxj5M9B660=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753867394; c=relaxed/simple;
	bh=zhQEXdzY9wPGLnOAGDyGmb50Qft7puioGy9ER23tpHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gJpxXLZQ0LnMJ6bKNc8w+XHPNjTaCazx8t8wb9hXvjojFX58HrFhKIESIwdJs0Wy0juzDMOM9YzZcSxHpsAe1X81FkAUxL6ebMCdFhpj8wYK1RpE9YiJzPGUkAawTAFYtx0mudRNuwtdgClWymXIwaz3PZimojMsmSzcxxJ1aNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SubXcjS1; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <392dc660-b4b0-4a0e-8e70-51e19c62589c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753867389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zmAzPly67sv1VGDCn9GEHPT33P9sZAQ+9+ib6EbFReo=;
	b=SubXcjS1Ky5Yw7Wnn/GxIXzPbT9cgM7ELkuTP4UyPvhGE7j+JVCZ1rxwWjTULg+qaX8oeI
	hFer7QAMoOVHEsgJwyujCmCEUOf+X2o975wZYyMApaYg93g9Bp42PcmRv9+Y6yqHXskbDQ
	ptClaDpO15CMWspq1BfcbaZDfMn1ndY=
Date: Wed, 30 Jul 2025 17:22:59 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 1/2] hung_task: Show the blocker task if the task is
 hung on mutex
Content-Language: en-US
To: Sergey Senozhatsky <senozhatsky@chromium.org>,
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Boqun Feng <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>,
 Joel Granados <joel.granados@kernel.org>,
 Anna Schumaker <anna.schumaker@oracle.com>, Lance Yang
 <ioworker0@gmail.com>, Kent Overstreet <kent.overstreet@linux.dev>,
 Yongliang Gao <leonylgao@tencent.com>, Steven Rostedt <rostedt@goodmis.org>,
 Tomasz Figa <tfiga@chromium.org>, linux-kernel@vger.kernel.org
References: <174046694331.2194069.15472952050240807469.stgit@mhiramat.tok.corp.google.com>
 <174046695384.2194069.16796289525958195643.stgit@mhiramat.tok.corp.google.com>
 <tfzs3z7yjs6ppobm53hxwjzhhptgq2aqc2obylblz5rk7mdstg@bkas4xcq66xk>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <tfzs3z7yjs6ppobm53hxwjzhhptgq2aqc2obylblz5rk7mdstg@bkas4xcq66xk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2025/7/30 15:59, Sergey Senozhatsky wrote:
> On (25/02/25 16:02), Masami Hiramatsu (Google) wrote:
>> The "hung_task" shows a long-time uninterruptible slept task, but most
>> often, it's blocked on a mutex acquired by another task. Without
>> dumping such a task, investigating the root cause of the hung task
>> problem is very difficult.
>>
>> This introduce task_struct::blocker_mutex to point the mutex lock
>> which this task is waiting for. Since the mutex has "owner"
>> information, we can find the owner task and dump it with hung tasks.
>>
>> Note: the owner can be changed while dumping the owner task, so
>> this is "likely" the owner of the mutex.
>>
>> With this change, the hung task shows blocker task's info like below;
>>
>>   INFO: task cat:115 blocked for more than 122 seconds.
>>         Not tainted 6.14.0-rc3-00003-ga8946be3de00 #156
>>   "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>>   task:cat             state:D stack:13432 pid:115   tgid:115   ppid:106    task_flags:0x400100 flags:0x00000002
>>   Call Trace:
>>    <TASK>
>>    __schedule+0x731/0x960
>>    ? schedule_preempt_disabled+0x54/0xa0
>>    schedule+0xb7/0x140
>>    ? __mutex_lock+0x51b/0xa60
>>    ? __mutex_lock+0x51b/0xa60
>>    schedule_preempt_disabled+0x54/0xa0
>>    __mutex_lock+0x51b/0xa60
>>    read_dummy+0x23/0x70
>>    full_proxy_read+0x6a/0xc0
>>    vfs_read+0xc2/0x340
>>    ? __pfx_direct_file_splice_eof+0x10/0x10
>>    ? do_sendfile+0x1bd/0x2e0
>>    ksys_read+0x76/0xe0
>>    do_syscall_64+0xe3/0x1c0
>>    ? exc_page_fault+0xa9/0x1d0
>>    entry_SYSCALL_64_after_hwframe+0x77/0x7f
>>   RIP: 0033:0x4840cd
>>   RSP: 002b:00007ffe99071828 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
>>   RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00000000004840cd
>>   RDX: 0000000000001000 RSI: 00007ffe99071870 RDI: 0000000000000003
>>   RBP: 00007ffe99071870 R08: 0000000000000000 R09: 0000000000000000
>>   R10: 0000000001000000 R11: 0000000000000246 R12: 0000000000001000
>>   R13: 00000000132fd3a0 R14: 0000000000000001 R15: ffffffffffffffff
>>    </TASK>
>>   INFO: task cat:115 is blocked on a mutex likely owned by task cat:114.
>>   task:cat             state:S stack:13432 pid:114   tgid:114   ppid:106    task_flags:0x400100 flags:0x00000002
>>   Call Trace:
>>    <TASK>
>>    __schedule+0x731/0x960
>>    ? schedule_timeout+0xa8/0x120
>>    schedule+0xb7/0x140
>>    schedule_timeout+0xa8/0x120
>>    ? __pfx_process_timeout+0x10/0x10
>>    msleep_interruptible+0x3e/0x60
>>    read_dummy+0x2d/0x70
>>    full_proxy_read+0x6a/0xc0
>>    vfs_read+0xc2/0x340
>>    ? __pfx_direct_file_splice_eof+0x10/0x10
>>    ? do_sendfile+0x1bd/0x2e0
>>    ksys_read+0x76/0xe0
>>    do_syscall_64+0xe3/0x1c0
>>    ? exc_page_fault+0xa9/0x1d0
>>    entry_SYSCALL_64_after_hwframe+0x77/0x7f
>>   RIP: 0033:0x4840cd
>>   RSP: 002b:00007ffe3e0147b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
>>   RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00000000004840cd
>>   RDX: 0000000000001000 RSI: 00007ffe3e014800 RDI: 0000000000000003
>>   RBP: 00007ffe3e014800 R08: 0000000000000000 R09: 0000000000000000
>>   R10: 0000000001000000 R11: 0000000000000246 R12: 0000000000001000
>>   R13: 000000001a0a93a0 R14: 0000000000000001 R15: ffffffffffffffff
>>    </TASK>
> 
> One thing that gives me a bit of "inconvenience" is that in certain
> cases this significantly increases the amount of stack traces to go
> through.  A distilled real life example:
> - task T1 acquires lock L1, attempts to acquire L2
> - task T2 acquires lock L2, attempts to acquire L3
> - task T3 acquires lock L3, attempts to acquire L1
> 
> So we'd now see:
> - a backtrace of T1, followed by a backtrace of T2 (owner of L2)
> - a backtrace of T2, followed by a backtrace of T3 (owner of L3)
> - a backtrace of T3, followed by a backtrace of T1 (owner of L1)
> 
> Notice how each task is backtraced twice.  I wonder if it's worth it
> to de-dup the backtraces.  E.g. in
> 
> 	task cat:115 is blocked on a mutex likely owned by task cat:114
> 
> if we know that cat:114 is also blocked on a lock, then we probably
> can just say "is blocked on a mutex likely owned by task cat:114" and
> continue iterating through tasks.  That "cat:114" will be backtraced
> individually later, as it's also blocked on a lock, owned by another
> task.
> 
> Does this make any sense?

Good spot! There is room for improvement.

In a deadlock chain like T1->T2->T3->T1, by definition, T1, T2, and T3
are all hung tasks, and the detector's primary responsibility is to
generate a report for each of them. The current implementation, when
reporting on one task, also dumps the backtrace of its blocker.

This results in a task's backtrace being printed twice — once as a
blocker and again as a primary hung task.

Regarding the de-duplication idea: it is elegant, but it does introduce
more complexity into the detector. We should also consider that in many
real-world cases, the blocking chain is just one level deep, where this
isn't an issue, IHMO ;)

Thanks,
Lance



