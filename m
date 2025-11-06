Return-Path: <linux-kernel+bounces-889095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A65C3CAFD
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 18:03:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D394A189FB51
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 17:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F241B34DB41;
	Thu,  6 Nov 2025 17:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nOFurHju"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC2334D91A
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 17:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762448568; cv=none; b=Xgon2E2f3oMCaIDR1T/8CnIdFhHfkCIwRNyWZ9lxR6sGQ6vofgKbrqis0JkajHKd8Khz2UCBpB2Thd1LwCTOffihgweCbelJe+uZMRDwxgx5Wq2mZNnIfdLuRtYdJm9lK0pZ1Ipe3CZ8O1Qm9XLlMMnEGqIF1fFZPpGOaFiJ/UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762448568; c=relaxed/simple;
	bh=bmpbnRF3cKHlPN9Xaqa4sxklQfqyLwTGZdaTa34IQvM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cJwb9L6fUGaYsHg4RF3c7pmk5t+nGbstMJ/2UYZxHzr0re2L+Jt2Qo5XlnXoA8kulxm6HRW/FJRKJXyfsK6BFuKA7jB9RvK2uo3UJB2JucpczgII0ilJQ5/JyVn5SLy1h6NPIza7XcmQ8LbqktGbw4P602mlLyLyCQhXjtuE9Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nOFurHju; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-34088fbd65aso1226143a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 09:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762448565; x=1763053365; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YPpU0awjnKN/G6+KlazEDar1/1ZBM2a+Pz44QPC0Ujg=;
        b=nOFurHjuTzW0jfTeH02iB669PpnWqGca+VSjL5Xawhy24YIFlKgN4ZDeCkphWGSbpW
         y8A0huE1cOAJVEtiAqe+qxFfOPI/3xAr9ZpZfugEIW71U/rdRELKftThDLP/bMke3CPR
         agarxOKgUyUGSkUBPW8y7eboNpCPIBGv07HtXJI6bT9aybJhFylgLlwobWu0uDeJLbFE
         p2Bz484i47jg/RqlvITtoX7m4vid689CHH+SM2GXkNsbsuVQYrYlh3jYZBU4k36ALk64
         2aSl5hH2W9XzEXWuNxygV8f2mf52Z+oDtchEYxV9AhmFagL3m8mtpp0jovFzltywJ0ho
         MPlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762448565; x=1763053365;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YPpU0awjnKN/G6+KlazEDar1/1ZBM2a+Pz44QPC0Ujg=;
        b=CctUCqQFDti4MGrr7Dyzd3kmvwU6N2Ns+Fd5H+CUYQk4AuhYCZknoLxIccCUFC1qx9
         36eLQ/gmi9R3CKStKrkHfIvoqec8r7z3yzY+JSV3v3iuDoaaD/9WZDPOeKKVIFCdM4bI
         26zmuGYixB7WbIAWrBOqbbe1NghHVc4BzqfI/KPnI5GnwzFCyAg5eHG1W3Cp4hB3MSFM
         88SMN4G5rzERBeLhUMCMJOL2dRZEmNzqk9bikACylvNGhGYWHulMahqWZE/nnN9bDuZ8
         G+RcpgWF9z/uQZv81emmcn4uwA8CtjZ9CtjNhmROYxuAAkhpb9CSPnv+LE+uKVkBE3MF
         xTxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXE31yaK6FlBYd11JmH65SCKh5Dd33NUagpfFVwBm9YUII5NixHHvrasKhy/uy9ryhHIUZ0tXI0jV/2Yg0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwilSuCyDWG8YcunwremFoDzacbEtvq29rTJv/hWioN0M9HEMtA
	eUGYgsmmjGltrSMkW++mYWF56z6eq4bLtWnyCDmuJg8xhnPByAYJrxWX
X-Gm-Gg: ASbGncuJaXfE5Tg5H0HAGicIWg+1Y+tiO1b3OBsoB/5hRBIRy65VPp8QhDm2AqMKHc4
	Ylf8daBmwak3TEJ86fUWvN8OSwkmBXcRlz9WVK4NPssr6B+uVVO454XqiCbd/9CsDiyxVi1+YVG
	PnRhtXvsiOc7aAOmRlKtAjP5cidVVBui4sVwgq7fzHnKYijAwTlmVSJB4eFjocPr3LgOVrTvAgA
	vHBzFP54dawZmF214UJN5kBp9Qq2Y+weNQ+sLKa58rtr/wUUZlzK0LB2/vbZm1/vjo8s6AGAPxR
	/dvWqHGMhGEs/wWUi6M3lHZl3hWCzESdqJKzDA65yJZgJiawQhpk5Ffny8o9PkOtdCrER41d+Ht
	yhhWk8tc3A0fNMMTpc0bt/WDCAKQES8Dqb+uPvClGKVUHPsU7GXobYK9XZszB9fj3abFw/6ML25
	Hl1LKVXz1HWCIAOJio6L4R
X-Google-Smtp-Source: AGHT+IF+6Xuvm4wgSMuStjeXOxmAX8A3ViGGV9aMWlq3E5tLch0rpxg/9QHMKCn3GRSTdg/WUL+Q6Q==
X-Received: by 2002:a17:90b:2f87:b0:330:6d5e:f17b with SMTP id 98e67ed59e1d1-341a6dc4b6emr10139367a91.21.1762448564481;
        Thu, 06 Nov 2025 09:02:44 -0800 (PST)
Received: from [192.168.4.196] ([73.222.117.172])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341d0456b34sm3029537a91.3.2025.11.06.09.02.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 09:02:43 -0800 (PST)
Message-ID: <37aa86c5-2659-4626-a80b-b3d07c2512c9@gmail.com>
Date: Thu, 6 Nov 2025 09:02:41 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mm-new v2] mm/memcontrol: Flush stats when write stat file
To: Leon Huang Fu <leon.huangfu@shopee.com>, linux-mm@kvack.org
Cc: hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
 shakeel.butt@linux.dev, muchun.song@linux.dev, akpm@linux-foundation.org,
 joel.granados@kernel.org, jack@suse.cz, laoar.shao@gmail.com,
 mclapinski@google.com, kyle.meyer@hpe.com, corbet@lwn.net,
 lance.yang@linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
References: <20251105074917.94531-1-leon.huangfu@shopee.com>
Content-Language: en-US
From: JP Kobryn <inwardvessel@gmail.com>
In-Reply-To: <20251105074917.94531-1-leon.huangfu@shopee.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/4/25 11:49 PM, Leon Huang Fu wrote:
> On high-core count systems, memory cgroup statistics can become stale
> due to per-CPU caching and deferred aggregation. Monitoring tools and
> management applications sometimes need guaranteed up-to-date statistics
> at specific points in time to make accurate decisions.
> 
> This patch adds write handlers to both memory.stat and memory.numa_stat
> files to allow userspace to explicitly force an immediate flush of
> memory statistics. When "1" is written to either file, it triggers
> __mem_cgroup_flush_stats(memcg, true), which unconditionally flushes
> all pending statistics for the cgroup and its descendants.
> 
> The write operation validates the input and only accepts the value "1",
> returning -EINVAL for any other input.
> 
> Usage example:
>    # Force immediate flush before reading critical statistics
>    echo 1 > /sys/fs/cgroup/mygroup/memory.stat
>    cat /sys/fs/cgroup/mygroup/memory.stat
> 
> This provides several benefits:
> 
> 1. On-demand accuracy: Tools can flush only when needed, avoiding
>     continuous overhead
> 
> 2. Targeted flushing: Allows flushing specific cgroups when precision
>     is required for particular workloads

I'm curious about your use case. Since you mention required precision,
are you planning on manually flushing before every read?

> 
> 3. Integration flexibility: Monitoring scripts can decide when to pay
>     the flush cost based on their specific accuracy requirements

[...]
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index c34029e92bab..d6a5d872fbcb 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -4531,6 +4531,17 @@ int memory_stat_show(struct seq_file *m, void *v)
>   	return 0;
>   }
> 
> +int memory_stat_write(struct cgroup_subsys_state *css, struct cftype *cft, u64 val)
> +{
> +	if (val != 1)
> +		return -EINVAL;
> +
> +	if (css)
> +		css_rstat_flush(css);

This is a kfunc. You can do this right now from a bpf program without
any kernel changes.


