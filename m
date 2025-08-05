Return-Path: <linux-kernel+bounces-756718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18304B1B84C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 18:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1F253B1FC3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 16:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FCAD292B50;
	Tue,  5 Aug 2025 16:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="V62fxt6c"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307F4291C2D
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 16:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754410679; cv=none; b=TYDhvEQOe79NWfrv2YxNKmelN5DcaPeKgKb5QVLQt0918DrRp28qr6xFvU+LgnPRzs/ggzL0CcXzaKh0HUQaLbttlc/n2GHQICJisadi5rMzZLq/MQk2Hnf6e8oNy4g0IsAVUvhlJM/6CZf61MevZmZ25TmPd8A4V+/aveHtUnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754410679; c=relaxed/simple;
	bh=Gje33Ku1Kycd0kqAcKLN0ia3FPXS5zk+1WtW9NDLHW8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hj02FldvyFedT1mEWSr3AieXIDQsSiVK3orW5nEN17xuZ3q9hWFJr7WNbU7fB0nB08pgmFFP79e1LscPtLXWLNyvn6XqeY5YQQ5gmpeLK9o9Au1n+8Ia5z/5ZkL6UKazZVpsPbD8YIBK+UiNj4taoIzKx16St14OSdELrMdclEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=V62fxt6c; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f7acfd22-bcf3-4dff-9a87-7c1e6f84ce9c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754410675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I3J2rk/T5mDdXAJ5BgbcckzUFF7bRL42mE76alpb8eE=;
	b=V62fxt6cn6vW+HTPNNzUamAMCnIMy0ZIvTd0eo1+vnhdM2iSeFiTEs3/4nJgb1g0uktFHh
	o2Q5URJtNjnuMRw6nLtPMUwKO1gUBfqpHhWoZ1HJc9pMbI3wuK5XYsx7NZCDepaeIIAVqJ
	If+lBv8AmvCzGAY1gn7NZQ1jsy6wydk=
Date: Wed, 6 Aug 2025 00:17:43 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: Remove migrate_disable in
 kprobe_multi_link_prog_run
To: Jiri Olsa <olsajiri@gmail.com>
Cc: song@kernel.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, mattbobrowski@google.com, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20250805122312.1890951-1-chen.dylane@linux.dev>
 <aJIrkAWK4ob5rCZ5@krava>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <aJIrkAWK4ob5rCZ5@krava>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/8/6 00:04, Jiri Olsa 写道:
> On Tue, Aug 05, 2025 at 08:23:12PM +0800, Tao Chen wrote:
>> bpf program should run under migration disabled, kprobe_multi_link_prog_run
>> called the way from graph tracer, which disables preemption in
>> function_graph_enter_regs, as Jiri and Yonghong suggested, there is no
>> need to use migrate_disable. As a result, some overhead maybe will be
>> reduced.
>>
>> Fixes: 0dcac2725406 ("bpf: Add multi kprobe link")
>> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>
> 
> thanks,
> jirka
> 
> 
>> ---
>>   kernel/trace/bpf_trace.c | 9 +++++++--
>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
>> index 3ae52978cae..1993fc62539 100644
>> --- a/kernel/trace/bpf_trace.c
>> +++ b/kernel/trace/bpf_trace.c
>> @@ -2734,14 +2734,19 @@ kprobe_multi_link_prog_run(struct bpf_kprobe_multi_link *link,
>>   		goto out;
>>   	}
>>   
>> -	migrate_disable();
>> +	/*
>> +	 * bpf program should run under migration disabled, kprobe_multi_link_prog_run
>> +	 * called the way from graph tracer, which disables preemption in
> 
> nit, s/called the way/called all the way/
> 

will fix it, thanks.

> 
>> +	 * function_graph_enter_regs, so there is no need to use migrate_disable.
>> +	 * Accessing the above percpu data bpf_prog_active is also safe for the same
>> +	 * reason.
>> +	 */
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
>> -- 
>> 2.48.1
>>


-- 
Best Regards
Tao Chen

