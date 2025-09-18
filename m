Return-Path: <linux-kernel+bounces-759416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE09B1DD46
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 21:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61D1818C6A67
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 19:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD36256C6F;
	Thu,  7 Aug 2025 19:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eLUHsNvO"
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199961E520C
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 19:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754593331; cv=none; b=Pvqt0Ft4R+qPwnbYuq0X/0gkagetiBI1ncHWQ3F4lRzuWoOZTvqfLp8Pwf09WJ4pfk0XezuMg1II7UuYPqfcpcYRA5ssBaddlT8Kt2AadX3tS7+Bi9VkHfyPUPnlSpS8k/5kdWz7HnRuQIKQCOhmwZXY67OuHGr9ycBWxeU28Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754593331; c=relaxed/simple;
	bh=YU3FWR8iG4THu3BwrW+8ZOs+Rk5Onr2YbeN26Hjq9gg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PNK8N9o/uV2pgdJD6k/eKL+6d467QL5S78ZK1JGwSeNYHXz8wktNnoOQ3tofjauFGtICALcN8oR/VX6THRVVFDbykPZ0GLpk1VDCVRSCQqXZArUWsngg/vinm0Y1LVsUCL2e6Z0Ltl98aKOla1miEETIcuHBRf+hTymXLDrxbNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eLUHsNvO; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <fbabac62-4bc1-4c11-9316-ed51ae9dbb0d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754593326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jSPNJqkeusudPMefdSnHFALV74tRT6VfM3GcmBqG6YE=;
	b=eLUHsNvOLX6OA25UC9F604zsVRybNuc2c4EQTwVMyoLd4/dkf8UImV5/yCF927u77LepHW
	9ms8HzK8HNSVKOUns4rv8bmqtj0ynGLni1LhkSv7F2Lpd+qJ2ligL2N9xsDcGVsW4hifDR
	8RBWGUZDjJ/PdaGKdj+0Biw9tKnK4lk=
Date: Thu, 7 Aug 2025 12:01:57 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] bpf: refactor max_depth computation in
 bpf_get_stack()
Content-Language: en-GB
To: Arnaud Lecomte <contact@arnaud-lcm.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com,
 john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
 linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@fomichev.me,
 song@kernel.org, syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com
References: <6cc26e1f-6ad6-44cd-a049-c4e7af9a229a@linux.dev>
 <20250807175032.7381-1-contact@arnaud-lcm.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250807175032.7381-1-contact@arnaud-lcm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 8/7/25 10:50 AM, Arnaud Lecomte wrote:
> A new helper function stack_map_calculate_max_depth() that
> computes the max depth for a stackmap.
>
> Signed-off-by: Arnaud Lecomte <contact@arnaud-lcm.com>
> ---
>   kernel/bpf/stackmap.c | 38 ++++++++++++++++++++++++++++++--------
>   1 file changed, 30 insertions(+), 8 deletions(-)
>
> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index 3615c06b7dfa..14e034045310 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -42,6 +42,31 @@ static inline int stack_map_data_size(struct bpf_map *map)
>   		sizeof(struct bpf_stack_build_id) : sizeof(u64);
>   }
>   
> +/**
> + * stack_map_calculate_max_depth - Calculate maximum allowed stack trace depth
> + * @map_size:        Size of the buffer/map value in bytes
> + * @elem_size:       Size of each stack trace element
> + * @map_flags:       BPF stack trace flags (BPF_F_USER_STACK, BPF_F_USER_BUILD_ID, ...)
> + *
> + * Return: Maximum number of stack trace entries that can be safely stored,
> + * or -EINVAL if size is not a multiple of elem_size

-EINVAL is not needed here. See below.

> + */
> +static u32 stack_map_calculate_max_depth(u32 map_size, u32 map_elem_size, u64 map_flags)

map_elem_size -> elem_size

> +{
> +	u32 max_depth;
> +	u32 skip = map_flags & BPF_F_SKIP_FIELD_MASK;

reverse Christmas tree?

> +
> +	if (unlikely(map_size%map_elem_size))
> +		return -EINVAL;

The above should not be here. The checking 'map_size % map_elem_size' is only needed
for bpf_get_stack(), not applicable for bpf_get_stackid().

> +
> +	max_depth = map_size / map_elem_size;
> +	max_depth += skip;
> +	if (max_depth > sysctl_perf_event_max_stack)
> +		return sysctl_perf_event_max_stack;
> +
> +	return max_depth;
> +}
> +
>   static int prealloc_elems_and_freelist(struct bpf_stack_map *smap)
>   {
>   	u64 elem_size = sizeof(struct stack_map_bucket) +
> @@ -406,7 +431,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
>   			    struct perf_callchain_entry *trace_in,
>   			    void *buf, u32 size, u64 flags, bool may_fault)
>   {
> -	u32 trace_nr, copy_len, elem_size, num_elem, max_depth;
> +	u32 trace_nr, copy_len, elem_size, max_depth;
>   	bool user_build_id = flags & BPF_F_USER_BUILD_ID;
>   	bool crosstask = task && task != current;
>   	u32 skip = flags & BPF_F_SKIP_FIELD_MASK;
> @@ -423,8 +448,6 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
>   		goto clear;
>   
>   	elem_size = user_build_id ? sizeof(struct bpf_stack_build_id) : sizeof(u64);
> -	if (unlikely(size % elem_size))
> -		goto clear;

Please keep this one.

>   
>   	/* cannot get valid user stack for task without user_mode regs */
>   	if (task && user && !user_mode(regs))
> @@ -438,10 +461,9 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
>   		goto clear;
>   	}
>   
> -	num_elem = size / elem_size;
> -	max_depth = num_elem + skip;
> -	if (sysctl_perf_event_max_stack < max_depth)
> -		max_depth = sysctl_perf_event_max_stack;
> +	max_depth = stack_map_calculate_max_depth(size, elem_size, flags);
> +	if (max_depth < 0)
> +		goto err_fault;

max_depth is never less than 0.

>   
>   	if (may_fault)
>   		rcu_read_lock(); /* need RCU for perf's callchain below */
> @@ -461,7 +483,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
>   	}
>   
>   	trace_nr = trace->nr - skip;
> -	trace_nr = (trace_nr <= num_elem) ? trace_nr : num_elem;
> +	trace_nr = min(trace_nr, max_depth - skip);
>   	copy_len = trace_nr * elem_size;
>   
>   	ips = trace->ip + skip;


