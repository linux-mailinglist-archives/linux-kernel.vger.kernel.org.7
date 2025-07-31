Return-Path: <linux-kernel+bounces-751556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01251B16AD8
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 05:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52FC77A99F5
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 03:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD22238C3C;
	Thu, 31 Jul 2025 03:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="b4mLFGse"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF35376
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 03:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753932331; cv=none; b=hCuFekBJPOs5L0Pdzz6dqQfgpp5wrfp8Gwsj3mdldLHKtZpfTOfSmrza5ZS+vOSOHWjWtISbYslKQg8ZWTLMUAIpGBbEdIZiDsUYH5yQbZYWaHa9+z87gk0Lvd0jZUGcinhwVXZNhLU5Yk5PiOukl2MsMN8ytUvNIP8djjKN5xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753932331; c=relaxed/simple;
	bh=G/8Kd7XhRHlCDkh944tNXDiO93iLLlfWqYXkbSvzT18=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=D+cStN+7+rk3dyrXhyqnOvqstWI4zR92L6SuelvuGoY9+aG9M1pYuVG+PWlualzg0aEYlcuKXUU+u1/Wvy6LkIleEqZL9RkO7NpDhACyZ6wt5GmHeAjMQ7o84q7JM6hvHsFnmVtQObZhdFszc3v5znAeeKPlU7VOMcdpEtze6nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=b4mLFGse; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4c227812-23ef-4fe8-9bf1-cc4966fd31ac@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753932326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/IatK5q3gJnvfpl3dCmv5YyNMtWu4dox3dnNKBtd5Nc=;
	b=b4mLFGseBsOJoEVaFOnbkRgYR1o5l6V37UgHotQ5rlLBHJXXyYV4RD7qgt0rP2XomgXweA
	QAw7nT/VIXr8BKqraHbRQihf3ejdGZaI4YWVxcd6S3J/It7zU1kyyg2XO/Gs/Ge/OoDQrh
	VwvNZo8u5ye+dtdE/IhB6hWApFEvMMk=
Date: Thu, 31 Jul 2025 11:25:13 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] hung_task: Dump blocker task if it is not hung
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
To: Sergey Senozhatsky <senozhatsky@chromium.org>,
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Waiman Long <longman@redhat.com>, Joel Granados <joel.granados@kernel.org>,
 Anna Schumaker <anna.schumaker@oracle.com>, Lance Yang
 <ioworker0@gmail.com>, Kent Overstreet <kent.overstreet@linux.dev>,
 Yongliang Gao <leonylgao@tencent.com>, Steven Rostedt <rostedt@goodmis.org>,
 Tomasz Figa <tfiga@chromium.org>, linux-kernel@vger.kernel.org
References: <175391351423.688839.11917911323784986774.stgit@devnote2>
 <reyd4bppb5tfon7gtqaelwknvptdeyhrsh5ijbcj77ezini3yq@ivkgxmiqzk3x>
 <e34a1a00-1728-4cf9-ad30-d8a7098b8876@linux.dev>
In-Reply-To: <e34a1a00-1728-4cf9-ad30-d8a7098b8876@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2025/7/31 11:15, Lance Yang wrote:
> 
> 
> On 2025/7/31 10:53, Sergey Senozhatsky wrote:
>> On (25/07/31 07:11), Masami Hiramatsu (Google) wrote:
>>> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>>>
>>> Dump the lock blocker task if it is not hung because if the blocker
>>> task is also hung, it should be dumped by the detector. This will
>>> de-duplicate the same stackdumps if the blocker task is also blocked
>>> by another task (and hung).
>>>
>>> Suggested-by: Sergey Senozhatsky <senozhatsky@chromium.org>
>>> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>>> Acked-by: Lance Yang <lance.yang@linux.dev>
>>
>> Tested-by: Sergey Senozhatsky <senozhatsky@chromium.org>
>>
>>
>> Wrote a simple 3 tasks circular lock test (same that I had in real
>> life).  The output looks good:
> 
> Nice work! The log is now much clearer ;)

Forgot to add:

This circular lock test is great. It would be very valuable to have
it in samples/hung_task ;)

Would you be willing to submit it as a patch?

Thanks,
Lance

> 
>>
>> [   90.985431] [    T140] INFO: task T1:525 blocked for more than 30 
>> seconds.
>> [   90.990981] [    T140]       Not tainted 6.16.0- 
>> next-20250730-00003-g5865c79d6085-dirty #261
>> [   90.996912] [    T140] "echo 0 > /proc/sys/kernel/ 
>> hung_task_timeout_secs" disables this message.
>> [   91.001617] [    T140] task:T1              state:D stack:0     
>> pid:525   tgid:525   ppid:2      task_flags:0x208040 flags:0x00004000
>> [   91.007564] [    T140] Call Trace:
>> [   91.008767] [    T140]  <TASK>
>> [   91.009872] [    T140]  __schedule+0x137f/0x20c0
>> [   91.011606] [    T140]  schedule+0xdc/0x280
>> [   91.013115] [    T140]  schedule_preempt_disabled+0x10/0x20
>> [   91.015200] [    T140]  __mutex_lock+0x721/0x1590
>> [   91.016817] [    T140]  ? __mutex_lock+0x500/0x1590
>> [   91.018074] [    T140]  mutex_lock+0x81/0x90
>> [   91.019169] [    T140]  t1+0x62/0x70
>> [   91.020061] [    T140]  kthread+0x583/0x6e0
>> [   91.021140] [    T140]  ? drop_caches_sysctl_handler+0x130/0x130
>> [   91.022729] [    T140]  ? kthread_blkcg+0xa0/0xa0
>> [   91.023921] [    T140]  ret_from_fork+0xc8/0x160
>> [   91.025091] [    T140]  ? kthread_blkcg+0xa0/0xa0
>> [   91.026309] [    T140]  ret_from_fork_asm+0x11/0x20
>> [   91.027577] [    T140]  </TASK>
>> [   91.028326] [    T140] INFO: task T1:525 is blocked on a mutex 
>> likely owned by task T2:526.
>> [   91.030404] [    T140] INFO: task T2:526 blocked for more than 30 
>> seconds.
>> [   91.031978] [    T140]       Not tainted 6.16.0- 
>> next-20250730-00003-g5865c79d6085-dirty #261
>> [   91.034069] [    T140] "echo 0 > /proc/sys/kernel/ 
>> hung_task_timeout_secs" disables this message.
>> [   91.036215] [    T140] task:T2              state:D stack:0     
>> pid:526   tgid:526   ppid:2      task_flags:0x208040 flags:0x00004000
>> [   91.039233] [    T140] Call Trace:
>> [   91.040084] [    T140]  <TASK>
>> [   91.040810] [    T140]  __schedule+0x137f/0x20c0
>> [   91.041954] [    T140]  schedule+0xdc/0x280
>> [   91.042984] [    T140]  schedule_preempt_disabled+0x10/0x20
>> [   91.044329] [    T140]  __mutex_lock+0x721/0x1590
>> [   91.045464] [    T140]  ? __mutex_lock+0x500/0x1590
>> [   91.046624] [    T140]  mutex_lock+0x81/0x90
>> [   91.047632] [    T140]  t2+0x69/0x70
>> [   91.048473] [    T140]  kthread+0x583/0x6e0
>> [   91.049453] [    T140]  ? drop_pagecache_sb+0x200/0x200
>> [   91.050686] [    T140]  ? kthread_blkcg+0xa0/0xa0
>> [   91.051808] [    T140]  ret_from_fork+0xc8/0x160
>> [   91.052886] [    T140]  ? kthread_blkcg+0xa0/0xa0
>> [   91.054036] [    T140]  ret_from_fork_asm+0x11/0x20
>> [   91.055205] [    T140]  </TASK>
>> [   91.056011] [    T140] INFO: task T2:526 is blocked on a mutex 
>> likely owned by task T3:527.
>> [   91.058014] [    T140] INFO: task T3:527 blocked for more than 30 
>> seconds.
>> [   91.059682] [    T140]       Not tainted 6.16.0- 
>> next-20250730-00003-g5865c79d6085-dirty #261
>> [   91.061708] [    T140] "echo 0 > /proc/sys/kernel/ 
>> hung_task_timeout_secs" disables this message.
>> [   91.063825] [    T140] task:T3              state:D stack:0     
>> pid:527   tgid:527   ppid:2      task_flags:0x208040 flags:0x00004000
>> [   91.066668] [    T140] Call Trace:
>> [   91.067462] [    T140]  <TASK>
>> [   91.068121] [    T140]  __schedule+0x137f/0x20c0
>> [   91.069244] [    T140]  schedule+0xdc/0x280
>> [   91.070264] [    T140]  schedule_preempt_disabled+0x10/0x20
>> [   91.071723] [    T140]  __mutex_lock+0x721/0x1590
>> [   91.072848] [    T140]  ? __mutex_lock+0x500/0x1590
>> [   91.074032] [    T140]  mutex_lock+0x81/0x90
>> [   91.075054] [    T140]  t3+0x23/0x30
>> [   91.075932] [    T140]  kthread+0x583/0x6e0
>> [   91.076953] [    T140]  ? t2+0x70/0x70
>> [   91.077865] [    T140]  ? kthread_blkcg+0xa0/0xa0
>> [   91.078974] [    T140]  ret_from_fork+0xc8/0x160
>> [   91.080109] [    T140]  ? kthread_blkcg+0xa0/0xa0
>> [   91.081250] [    T140]  ret_from_fork_asm+0x11/0x20
>> [   91.082530] [    T140]  </TASK>
>> [   91.083248] [    T140] INFO: task T3:527 is blocked on a mutex 
>> likely owned by task T1:525.
> 


