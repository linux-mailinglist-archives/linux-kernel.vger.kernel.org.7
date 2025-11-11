Return-Path: <linux-kernel+bounces-894634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4511AC4B764
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 05:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0C8414E15D3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 04:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC9B2777F9;
	Tue, 11 Nov 2025 04:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hfniQUtG";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="oFcRJrzj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290331DE8BF
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 04:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762835702; cv=none; b=Q5OJt+R8z1+O2dQrPziCeBaXuPGVbZ0808Ux+plEDnKM6KYvbrioI2bqyyTmVnch4w4dw3dv+Fy5N3jWrzxAMHc8fGUYVF+ZIAwakucTOdLVabd2ICYMYqSnNME6GGR5vqD4wryHYvl7x96HnQlPhp4kSbbML1yqr+bQZnocvwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762835702; c=relaxed/simple;
	bh=nvBD73hNCydgzs3YLQTIXDAlBF/l51pFUxWiIgInHSg=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=fbuRT7oG9nYKnVdqjVR+5/33eZyPyD8p2ap1ct8X7MBwaIGXkhlrvDL8myX+89fwQsFDO3+g7MirvqiNVG1Vtf2kOqIO7jGR1a79oAshvBBX05mAOohUJL35AnCPpPpK8HWjjebdy1lxZnJzM0UII4hcAzIZZZktcqpJAsyLyIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hfniQUtG; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=oFcRJrzj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762835699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jCYMUUPQqU04UpWt5btWgNU4XsvVLOwaZFyt3a/sEn4=;
	b=hfniQUtGNg0UwIJkqskqb69E9Cwg/mkudOO4jReRm42pfFrUUWwFxLvExneIyiRPTXMOAj
	g69efUpJBpp5wXGyjRutoKF1LbExfme1WmPGwQ/1zatuZo6As5LYRnS0A2m5WGbFdmfWZ1
	JleP3ZbL37y/2C8Qw7u8cJYCVrtsRoc=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-ASOALmolOI6Ovnw5HA1HFg-1; Mon, 10 Nov 2025 23:34:56 -0500
X-MC-Unique: ASOALmolOI6Ovnw5HA1HFg-1
X-Mimecast-MFC-AGG-ID: ASOALmolOI6Ovnw5HA1HFg_1762835696
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8b22ab98226so913329885a.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 20:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762835696; x=1763440496; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jCYMUUPQqU04UpWt5btWgNU4XsvVLOwaZFyt3a/sEn4=;
        b=oFcRJrzj2Cd0m7VwP8Yspvp7EdcVhy5R4XB9ajSNpNhx/d71qa6NzWdiAcbsHSr3Tp
         siyiPcZoptHKtY8B73D0PhF4aK2CW8pZ/GKJFMlxyrfjg4yaOiQG0LfH751XfWsNl92c
         Y+yW+CsrrXgBVm4afxbaepTn4KlrAstVrLYvvd+wxdo1bfoaHMSsU5HgcfoPz1Fwfg9y
         Ic2ZZNYR8mcwCLzNjpAf8rIbV9osqTewRXs4kOdAL96Nw0/bqfCWz+hvcn9IlFJHsw+F
         71ZiLugfnYo56CfwP6edzbkYHiYtbr3ByHK2sjtvl+HfKHyYgHExUZciZ1Kl99L7mvAI
         BnOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762835696; x=1763440496;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jCYMUUPQqU04UpWt5btWgNU4XsvVLOwaZFyt3a/sEn4=;
        b=WySMPn1Fh/Gn6ldQUJTGU4dj3BTZ9Zlgq8f9CpWRdt/U7phu8VlgTaqu4jOE6GiJ4L
         HLuvjxqqzHYjws1oxgf5LDIA9N8R68SZXZwfi/HuDM2M53eAF9wpFa1tlocq6w7+vcj/
         cXpkl9fP8lnjrGtBSJPi6SRda/NoxjhTTYdr6NAuQZpf+KjhjybFkyi+QyX8tt0YUeC3
         B+Bkhj7MrpNVqn1ihpArgz4qb+CPMr+agHNQeH+6noX4YNcBLhwfVYLo4Pe2XJ67eJbN
         uVhiM4dhUDjHxfOfnP2cAvMRZbVGfNolZ5tdAQ0+Pwypcug8+FQRGqIfAwVHXki8gK5q
         r6Wg==
X-Forwarded-Encrypted: i=1; AJvYcCUmJo8Nysw54z6PLQca2Zn3qF7slsaZaZO1tiVRdKvkkKtiX0N8ZJDUvVQa72ieJF2+OrhCoy8rP7d4G0g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzon8DXzNZImSl47cRKZ+jCWVUQfpyQYBUitqk8tvWvw50LYIF+
	xRk4owkRRcIsDaiX7iNK8ZZe6nULStqXN4WiaVlgFkvukzujTNs0JgbeO0aQQOvzWKb7SA4sE5t
	+iQipU2T5feB2eqJ4/6opJn2LcwRysTFwEsd14gZAW5PjsbqGG0CJvj2Ru2rlFgydgg==
X-Gm-Gg: ASbGncuwCEY6lkdpCOZsrqF+xhbvVm5hj8Z3pgtkk3XI7IkBh8TtDAUQOq1xwn+Qvbu
	rnU+EQP8YqCd0A/cYYQTrFqxiL4lMgKIgAc0vgdHHwjRv0myjvjyFxF3dCGyM8KzW0L2Hok/9kv
	7scsTafow4xr+BDc0Qw0SFh+NDVDkmkc5Ty6mqSKoNQjqPOnWASwKeFnmBxrYdWoyatfw2SOMhE
	GAlomiqdWF5IyNygpzVSh+mzWmB4T9kxfgU7+3N2B1yeh/e1/Ur8ob2TIspWK0HhJZIZq0UAfSf
	NImB6wUhrnE/t0NksuBtBfJ6G/jv9zIfIIKcWvpoDZTkyZxFu/tj/wlUfamSBOqRAn7Gec2kZrb
	sqCY9t5U4GubKnDHhAElpcmX78HQRSAvTPFCfXmxmjWxu1g==
X-Received: by 2002:ac8:5a85:0:b0:4ed:6324:f53f with SMTP id d75a77b69052e-4eda4f90171mr140140941cf.39.1762835696090;
        Mon, 10 Nov 2025 20:34:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHkOuvyMWOsQLKP1lELLhT0SXqNPK9ygO0b57VoBlO+iFqS7YJaii6zmA0kHCfB7uBNGB7D2A==
X-Received: by 2002:ac8:5a85:0:b0:4ed:6324:f53f with SMTP id d75a77b69052e-4eda4f90171mr140140761cf.39.1762835695776;
        Mon, 10 Nov 2025 20:34:55 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4edb56e2173sm42728951cf.2.2025.11.10.20.34.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 20:34:55 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <51ee41f3-02d7-4b76-acfc-882abe9a003d@redhat.com>
Date: Mon, 10 Nov 2025 23:34:54 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next 2/3] cpuset: remove global remote_children list
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20251110015228.897736-1-chenridong@huaweicloud.com>
 <20251110015228.897736-3-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20251110015228.897736-3-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/9/25 8:52 PM, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
>
> The remote_children list is used to track all remote partitions attached
> to a cpuset. However, it serves no other purpose. Using a boolean flag to
> indicate whether a cpuset is a remote partition is a more direct approach,
> making remote_children unnecessary.
>
> This patch replaces the list with a remote_partition flag in the cpuset
> structure and removes remote_children entirely.
>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>   kernel/cgroup/cpuset-internal.h |  4 ++--
>   kernel/cgroup/cpuset.c          | 14 +++++---------
>   2 files changed, 7 insertions(+), 11 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset-internal.h b/kernel/cgroup/cpuset-internal.h
> index 5cac42c5fd97..7308e8bc4dde 100644
> --- a/kernel/cgroup/cpuset-internal.h
> +++ b/kernel/cgroup/cpuset-internal.h
> @@ -172,8 +172,8 @@ struct cpuset {
>   	/* Handle for cpuset.cpus.partition */
>   	struct cgroup_file partition_file;
>   
> -	/* Remote partition silbling list anchored at remote_children */
> -	struct list_head remote_sibling;
> +	/* Whether cpuset is a remote partition */
> +	bool remote_partition;
>   

The original purpose of adding a linked list for remote children is to 
enable us iterate the list of remote children when needed. This 
capability is not currently being used. So we can simplify it for now, 
but I would like to add a comment saying that we can switch it back to a 
list in case we need to iterate the remote children list in the future. 
Also I would suggest moving the bool up before partition_file to reduce 
the number of holes in the cpuset structure.

Cheers,
Longman

>   	/* Used to merge intersecting subsets for generate_sched_domains */
>   	struct uf_node node;
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index c90476d52f09..c357bfb69fe2 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -94,9 +94,6 @@ static bool isolated_cpus_updating;
>   static cpumask_var_t	boot_hk_cpus;
>   static bool		have_boot_isolcpus;
>   
> -/* List of remote partition root children */
> -static struct list_head remote_children;
> -
>   /*
>    * A flag to force sched domain rebuild at the end of an operation.
>    * It can be set in
> @@ -219,7 +216,7 @@ static struct cpuset top_cpuset = {
>   		 BIT(CS_MEM_EXCLUSIVE) | BIT(CS_SCHED_LOAD_BALANCE),
>   	.partition_root_state = PRS_ROOT,
>   	.relax_domain_level = -1,
> -	.remote_sibling = LIST_HEAD_INIT(top_cpuset.remote_sibling),
> +	.remote_partition = false,
>   };
>   
>   /*
> @@ -1572,7 +1569,7 @@ static int compute_trialcs_excpus(struct cpuset *trialcs, struct cpuset *cs)
>   
>   static inline bool is_remote_partition(struct cpuset *cs)
>   {
> -	return !list_empty(&cs->remote_sibling);
> +	return cs->remote_partition;
>   }
>   
>   static inline bool is_local_partition(struct cpuset *cs)
> @@ -1621,7 +1618,7 @@ static int remote_partition_enable(struct cpuset *cs, int new_prs,
>   
>   	spin_lock_irq(&callback_lock);
>   	partition_xcpus_add(new_prs, NULL, tmp->new_cpus);
> -	list_add(&cs->remote_sibling, &remote_children);
> +	cs->remote_partition = true;
>   	cpumask_copy(cs->effective_xcpus, tmp->new_cpus);
>   	spin_unlock_irq(&callback_lock);
>   	update_isolation_cpumasks();
> @@ -1651,7 +1648,7 @@ static void remote_partition_disable(struct cpuset *cs, struct tmpmasks *tmp)
>   	WARN_ON_ONCE(!cpumask_subset(cs->effective_xcpus, subpartitions_cpus));
>   
>   	spin_lock_irq(&callback_lock);
> -	list_del_init(&cs->remote_sibling);
> +	cs->remote_partition = false;
>   	partition_xcpus_del(cs->partition_root_state, NULL, cs->effective_xcpus);
>   	if (cs->prs_err)
>   		cs->partition_root_state = -cs->partition_root_state;
> @@ -3603,7 +3600,7 @@ cpuset_css_alloc(struct cgroup_subsys_state *parent_css)
>   	__set_bit(CS_SCHED_LOAD_BALANCE, &cs->flags);
>   	fmeter_init(&cs->fmeter);
>   	cs->relax_domain_level = -1;
> -	INIT_LIST_HEAD(&cs->remote_sibling);
> +	cs->remote_partition = false;
>   

We don't need to initialize remote_partition here as the structure is 
zalloc'ed.

Cheers,
Longman

>   	/* Set CS_MEMORY_MIGRATE for default hierarchy */
>   	if (cpuset_v2())
> @@ -3874,7 +3871,6 @@ int __init cpuset_init(void)
>   	nodes_setall(top_cpuset.effective_mems);
>   
>   	fmeter_init(&top_cpuset.fmeter);
> -	INIT_LIST_HEAD(&remote_children);
>   
>   	BUG_ON(!alloc_cpumask_var(&cpus_attach, GFP_KERNEL));
>   


