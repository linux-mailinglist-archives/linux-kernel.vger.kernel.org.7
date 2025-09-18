Return-Path: <linux-kernel+bounces-755300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4CFDB1A44A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 16:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD38318A1DFF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 14:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF316271441;
	Mon,  4 Aug 2025 14:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fMu+ibrs"
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD352701CC;
	Mon,  4 Aug 2025 14:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754316971; cv=none; b=HMKqrgK746iH4AGGR9sC3frX/oSxoT7h7Qw3KruyTyMTq9qUuYF7uNqpRnH7UUp01dHPkVz+k0yOEt41+a05CMthYhqlL0zsebtLCBwJDhQcUCoB4BwnXYrLdVo76Xz8COSFzAIc94VhhIL0Ok0F5qjofBN6QGdW9C7MXqWXz8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754316971; c=relaxed/simple;
	bh=2ez4NrkdBhhXO7XsF1bXklZWOD8UgsKYO4H2IfUXj8M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hpXxYd3lh6htnJfEPDL86nZ4+Gf1M2wfxElOGQ/X04nhH+g095/+Rm6PH67yAqvxRQd1Gc4kj+SexUmHo9v/Tb/05l+kzHqq34BmnqxiJKBlqe7rqVB7LxzyVcMhfKR7flT72ktv5oeRj7UZPEk1tPmBFkQWzUHOqeaLy3VbT68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fMu+ibrs; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c5e66881-2fca-479b-9ef6-c9ada34e731c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754316957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iW3oW/9RKVGDSRNtLdJfx42RFGJ9MbvVjxp4rk7AV1M=;
	b=fMu+ibrsrPOsuiv40kYSQxEdD1l6mffdhKJHZtunqnRicEX1QkjezXLpYBEndZlSUhiIYm
	yIgpM+7QLBkVTBE6CEnAM1s5RE4W8kV1byTEm8N/NOCVlseKiYki+tdiJsHAyYUjcP7K1x
	1aNVnXYskcGWuYza/SnZ2g1ZPpmK4Jk=
Date: Mon, 4 Aug 2025 22:15:46 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: Disable migrate when kprobe_multi attach to
 access bpf_prog_active
To: Jiri Olsa <olsajiri@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, mattbobrowski@google.com,
 rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
References: <20250804121615.1843956-1-chen.dylane@linux.dev>
 <aJCvY7G-gVR8taLh@krava>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <aJCvY7G-gVR8taLh@krava>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/8/4 21:02, Jiri Olsa 写道:
> On Mon, Aug 04, 2025 at 08:16:15PM +0800, Tao Chen wrote:
>> The syscall link_create not protected by bpf_disable_instrumentation,
>> accessing percpu data bpf_prog_active should use cpu local_lock when
>> kprobe_multi program attach.
>>
>> Fixes: 0dcac2725406 ("bpf: Add multi kprobe link")
>> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
>> ---
>>   kernel/trace/bpf_trace.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
>> index 3ae52978cae..f6762552e8e 100644
>> --- a/kernel/trace/bpf_trace.c
>> +++ b/kernel/trace/bpf_trace.c
>> @@ -2728,23 +2728,23 @@ kprobe_multi_link_prog_run(struct bpf_kprobe_multi_link *link,
>>   	struct pt_regs *regs;
>>   	int err;
>>   
>> +	migrate_disable();
>>   	if (unlikely(__this_cpu_inc_return(bpf_prog_active) != 1)) {
> 
> this is called all the way from graph tracer, which disables preemption in
> function_graph_enter_regs, so I think we can safely use __this_cpu_inc_return
> 
> 
>>   		bpf_prog_inc_misses_counter(link->link.prog);
>>   		err = 1;
>>   		goto out;
>>   	}
>>   
>> -	migrate_disable();
> 
> hum, but now I'm not sure why we disable migration in here then
> 

It seems that there is a cant_migrate() check in bpf_prog_run, so it 
should be disabled before run.

> jirka
> 
>>   	rcu_read_lock();
>>   	regs = ftrace_partial_regs(fregs, bpf_kprobe_multi_pt_regs_ptr());
>>   	old_run_ctx = bpf_set_run_ctx(&run_ctx.session_ctx.run_ctx);
>>   	err = bpf_prog_run(link->link.prog, regs);
>>   	bpf_reset_run_ctx(old_run_ctx);
>>   	rcu_read_unlock();
>> -	migrate_enable();
>>   
>>    out:
>>   	__this_cpu_dec(bpf_prog_active);
>> +	migrate_enable();
>>   	return err;
>>   }
>>   
>> -- 
>> 2.48.1
>>
-- 
Best Regards
Tao Chen

