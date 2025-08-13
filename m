Return-Path: <linux-kernel+bounces-765976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F00B240CA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 07:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 797171BC0D12
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 05:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B03E2BF007;
	Wed, 13 Aug 2025 05:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="d6bgEZpr"
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC8923D7CF
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 05:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755064470; cv=none; b=tmdKd8jQ07XMuXq1x/S5cx2L7qwaW3e2ZA5nO2qe/pTqNuD5s+5R4Evo/cEMVagJBb/DMdtM6aldqIl0oRZfdceKK+O8RPDpmwHyk9rZbJ0O8gUuuYT59QhXYstxMDCzTqI7sLqjQEYlAJqagn4nKMdEuOcJ9KX8EIJcky107R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755064470; c=relaxed/simple;
	bh=fZOVSL1aaBMqAX7y8C8YBr0X/fLnGUZLq38WeFWRXkE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZscfohsXnkAdA1qeHyFy5r38NGdzL76ktweAXySSHhEqLKhNQuWcB2ZNzwK5sq4ZbsS1DuYPLBQtj6EQHJynF1evD76OnYtFHocbGX6k6uQ7DtPpn7Tc7gcP5G+iINunCw6jKh+XB80ZtDDAWo6shOGJCte/3TcoLmzwLpavzDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=d6bgEZpr; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <09dc40eb-a84e-472a-8a68-36a2b1835308@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755064456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oPwnB9ps9W0P2V8Lp6Eg8bH+ecaPEc7707QvrsMdmYQ=;
	b=d6bgEZpr5Uz5ABoe5truZsmAVAosr4BsOTslxGJ9yd68JukM8py6clULdHLPcEaQZtLJoK
	askYi/r+jaEcihlGv/Qn7wS4joZQNIX0I7hQUz74iglTK/JJKfomIvmfkGxDUkCtME83lo
	xsjLDuFqO+Lz63FsTHNrCIxVG+CG5PQ=
Date: Tue, 12 Aug 2025 22:54:02 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 1/2] bpf: refactor max_depth computation in
 bpf_get_stack()
Content-Language: en-GB
To: Arnaud Lecomte <contact@arnaud-lcm.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com,
 john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
 linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@fomichev.me,
 song@kernel.org, syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com
References: <ef33d3cb-4346-41af-9e0e-541fdc007f89@linux.dev>
 <20250812193034.18848-1-contact@arnaud-lcm.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250812193034.18848-1-contact@arnaud-lcm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 8/12/25 12:30 PM, Arnaud Lecomte wrote:
> A new helper function stack_map_calculate_max_depth() that
> computes the max depth for a stackmap.
>
> Changes in v2:
>   - Removed the checking 'map_size % map_elem_size' from
>     stack_map_calculate_max_depth
>   - Changed stack_map_calculate_max_depth params name to be more generic
>
> Changes in v3:
>   - Changed map size param to size in max depth helper
>
> Signed-off-by: Arnaud Lecomte <contact@arnaud-lcm.com>

LGTM with a small nit below.

Acked-by: Yonghong Song <yonghong.song@linux.dev>

> ---
>   kernel/bpf/stackmap.c | 30 ++++++++++++++++++++++++------
>   1 file changed, 24 insertions(+), 6 deletions(-)
>
> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index 3615c06b7dfa..a267567e36dd 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -42,6 +42,27 @@ static inline int stack_map_data_size(struct bpf_map *map)
>   		sizeof(struct bpf_stack_build_id) : sizeof(u64);
>   }
>   
> +/**
> + * stack_map_calculate_max_depth - Calculate maximum allowed stack trace depth
> + * @size:        Size of the buffer/map value in bytes
> + * @elem_size:       Size of each stack trace element
> + * @flags:       BPF stack trace flags (BPF_F_USER_STACK, BPF_F_USER_BUILD_ID, ...)

Let us have consistent format, e.g.
  * @size:  Size of ...
  * @elem_size:  Size of ...
  * @flags:  BPF stack trace ...

> + *
> + * Return: Maximum number of stack trace entries that can be safely stored
> + */
> +static u32 stack_map_calculate_max_depth(u32 size, u32 elem_size, u64 flags)
> +{
> +	u32 skip = flags & BPF_F_SKIP_FIELD_MASK;
> +	u32 max_depth;
> +
> +	max_depth = size / elem_size;
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
> @@ -406,7 +427,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
>   			    struct perf_callchain_entry *trace_in,
>   			    void *buf, u32 size, u64 flags, bool may_fault)
>   {
> -	u32 trace_nr, copy_len, elem_size, num_elem, max_depth;
> +	u32 trace_nr, copy_len, elem_size, max_depth;
>   	bool user_build_id = flags & BPF_F_USER_BUILD_ID;
>   	bool crosstask = task && task != current;
>   	u32 skip = flags & BPF_F_SKIP_FIELD_MASK;
> @@ -438,10 +459,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
>   		goto clear;
>   	}
>   
> -	num_elem = size / elem_size;
> -	max_depth = num_elem + skip;
> -	if (sysctl_perf_event_max_stack < max_depth)
> -		max_depth = sysctl_perf_event_max_stack;
> +	max_depth = stack_map_calculate_max_depth(size, elem_size, flags);
>   
>   	if (may_fault)
>   		rcu_read_lock(); /* need RCU for perf's callchain below */
> @@ -461,7 +479,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
>   	}
>   
>   	trace_nr = trace->nr - skip;
> -	trace_nr = (trace_nr <= num_elem) ? trace_nr : num_elem;
> +	trace_nr = min(trace_nr, max_depth - skip);
>   	copy_len = trace_nr * elem_size;
>   
>   	ips = trace->ip + skip;


