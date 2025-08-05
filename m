Return-Path: <linux-kernel+bounces-755892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C5EB1AD04
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 06:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33A82189D237
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 04:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8111E0B9C;
	Tue,  5 Aug 2025 04:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="b0/WvJbQ"
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3055643ABC
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 04:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754366723; cv=none; b=MvJ81xVnOiEFXbAExVhYQLVKVPhRdEAmMW/prYOh6DJmwNJgSJlLiTB1tyfgoaF4Re+7beAtdkRgtsWEcx23BJLLJrJxHadnYU5HpBcPaMomSD2t2cY48RGwQC/S6KSdgzDhbiUpquGAWxSYaFkyHYYY58HKcA37U/AwQPfhLVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754366723; c=relaxed/simple;
	bh=EMfUCHtgs3IuqzXuNcpwRrDEplEmislVrV6AOXDDDpE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ap1HumPikepZ55t5z2UqPgshvqN2R54iTfBDSXLtfrlRXFL/NhTWHpgBsfUVHWtxTvehPQs7nt6+TD1GVluZgv5MbS11TiVEXqv5HXL9b22nqrpNAfSoIwRkU7NQv0DAXUhocSsbRoCekhVJ9xyezYY4nwIWpJcSB1QOLOjXPPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=b0/WvJbQ; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3cf22505-e338-4cc1-ab76-896bfc336b40@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754366708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gyJlZNo6vE7cHWA+QVc0Ikg9XrHom96gqkhClW3dl1E=;
	b=b0/WvJbQaEhaneW/zRlslwwvZgNmZtIZPesXUfDg9zZC0pF+7MLJcJphBhcCXaBc3BZrFT
	4Pns7CJ8oyUtY0hEK4wSXGOlq6McaTJbyNUlYQ73svBDvXFmA7c3X5/TlsqtSS/4n5hVL6
	5Hvfuds6nY71dAXyvszuD2KIknwt8oM=
Date: Mon, 4 Aug 2025 21:05:00 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: Disable migrate when kprobe_multi attach to
 access bpf_prog_active
To: Jiri Olsa <olsajiri@gmail.com>, Tao Chen <chen.dylane@linux.dev>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, mattbobrowski@google.com, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20250804121615.1843956-1-chen.dylane@linux.dev>
 <aJCvY7G-gVR8taLh@krava>
Content-Language: en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <aJCvY7G-gVR8taLh@krava>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 8/4/25 6:02 AM, Jiri Olsa wrote:
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
> this is called all the way from graph tracer, which disables preemption in
> function_graph_enter_regs, so I think we can safely use __this_cpu_inc_return

Agree. migrate_disable() is not needed here. But it would be great to add some
comments here since for most other prog_run, they typically have migrate_disable/enable.

>
>
>>   		bpf_prog_inc_misses_counter(link->link.prog);
>>   		err = 1;
>>   		goto out;
>>   	}
>>   
>> -	migrate_disable();
> hum, but now I'm not sure why we disable migration in here then

Probably a oversight.

>
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


