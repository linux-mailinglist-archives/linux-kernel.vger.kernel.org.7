Return-Path: <linux-kernel+bounces-877366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B17C1DF13
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 01:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1515C3A9FBC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 00:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72CA1FF5F9;
	Thu, 30 Oct 2025 00:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ULiUj4m2"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4685B17A318
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 00:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761785004; cv=none; b=uKnUKuztEXEA5pRfNmQFZPqm1PnGFhjkxjzdry9J8A6+Ib0TWOjCRfOCQV1JduGxIoyKrR9ZT1n5xTMPSPPVfMw2gsFEqQQbyiLX/DcJAokSb63+va3+jqwMs9q90psqr95YSiMR9rmDbYkHEaVh9kKFJxSWnNNYEX3GL+SBOEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761785004; c=relaxed/simple;
	bh=RPsWrulHFeHXbQMdfczHRBXPMspKZ82TpoNbHRZZZLY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TS7ib3NzGoVi+qhUEP6SNXTkXsq5O1EMKixda9qAlSKaaZLhauimsA/H+hXvgTpytX2i2wrjaR5JARcp96ZGzKHyPNLZehzvB8/REv24cYU5bKfmE8nkHb5305GOQobxntf2VozSK1aq+PCUoDCC8MazUuqDkNycoZcdRZbwWXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ULiUj4m2; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <dc66b416-6d35-4e7f-af9c-6a0831dc1fb7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761784989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=prXThHTV0GDAwL3oDEaWG8s/Dj6lCyEPeFRl/UXwls4=;
	b=ULiUj4m2ZADrpZISUHsciB+yZ7PKa6iclQpmxGVtWMVHGj6KYXWwkoKCZXXY9Uits03dv4
	vupgCZLkEk8MYN4sAipt4OJzgrznJx+C4i2+XdgM1k/plomzacRE4NBqO+zq8iMFDoad9k
	yH8o9Eo8jbJOdnnYDOj5Jw2VA3b/1RY=
Date: Wed, 29 Oct 2025 17:43:02 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 02/23] bpf: initial support for attaching struct ops to
 cgroups
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@kernel.org>,
 Shakeel Butt <shakeel.butt@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>,
 Andrii Nakryiko <andrii@kernel.org>, JP Kobryn <inwardvessel@gmail.com>,
 linux-mm@kvack.org, cgroups@vger.kernel.org, bpf@vger.kernel.org,
 Martin KaFai Lau <martin.lau@kernel.org>, Song Liu <song@kernel.org>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Tejun Heo <tj@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
References: <20251027231727.472628-1-roman.gushchin@linux.dev>
 <20251027231727.472628-3-roman.gushchin@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20251027231727.472628-3-roman.gushchin@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 10/27/25 4:17 PM, Roman Gushchin wrote:
> When a struct ops is being attached and a bpf link is created,
> allow to pass a cgroup fd using bpf attr, so that struct ops
> can be attached to a cgroup instead of globally.
> 
> Attached struct ops doesn't hold a reference to the cgroup,
> only preserves cgroup id.
> 
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> ---
>   include/linux/bpf.h         |  1 +
>   kernel/bpf/bpf_struct_ops.c | 13 +++++++++++++
>   2 files changed, 14 insertions(+)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index eae907218188..7205b813e25f 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1849,6 +1849,7 @@ struct bpf_struct_ops_link {
>   	struct bpf_link link;
>   	struct bpf_map __rcu *map;
>   	wait_queue_head_t wait_hup;
> +	u64 cgroup_id;
>   };
>   
>   struct bpf_link_primer {
> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> index 45cc5ee19dc2..58664779a2b6 100644
> --- a/kernel/bpf/bpf_struct_ops.c
> +++ b/kernel/bpf/bpf_struct_ops.c
> @@ -13,6 +13,7 @@
>   #include <linux/btf_ids.h>
>   #include <linux/rcupdate_wait.h>
>   #include <linux/poll.h>
> +#include <linux/cgroup.h>
>   
>   struct bpf_struct_ops_value {
>   	struct bpf_struct_ops_common_value common;
> @@ -1359,6 +1360,18 @@ int bpf_struct_ops_link_create(union bpf_attr *attr)
>   	}
>   	bpf_link_init(&link->link, BPF_LINK_TYPE_STRUCT_OPS, &bpf_struct_ops_map_lops, NULL,
>   		      attr->link_create.attach_type);
> +#ifdef CONFIG_CGROUPS
> +	if (attr->link_create.cgroup.relative_fd) {
> +		struct cgroup *cgrp;
> +
> +		cgrp = cgroup_get_from_fd(attr->link_create.cgroup.relative_fd);
> +		if (IS_ERR(cgrp))
> +			return PTR_ERR(cgrp);
> +
> +		link->cgroup_id = cgroup_id(cgrp);

Not sure storing the cgroup_id or storing the memcg/cgroup pointer is 
better here. Regardless, link->cgroup_id should be cleared in 
bpf_struct_ops_map_link_detach(). The cgroup_id probably is useful to 
bpf_struct_ops_map_link_show_fdinfo().

> +		cgroup_put(cgrp);
> +	}
> +#endif /* CONFIG_CGROUPS */
>   
>   	err = bpf_link_prime(&link->link, &link_primer);
>   	if (err)


