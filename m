Return-Path: <linux-kernel+bounces-895686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF04CC4EA85
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 16:02:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F9E418C06AB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 14:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1375343D8E;
	Tue, 11 Nov 2025 14:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BnEyeh/p";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="qZQgeEBv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20E025C818
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 14:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762873004; cv=none; b=ZZ99zth9B4f1pFIrDsKh8f3goDWYAYsEsVM7PtAqOG06WCk51ZHw1XSevkPbPzLlqo1VG+kWeaqMRuDEo5WZg/GKaw5m9xoFOLRN96/LCLW9HXOEYTloBPgZaj7pUdVAtfT4Ed93UWJFdoTh+ROFpsXzKnrct5/csvhAKbWTAgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762873004; c=relaxed/simple;
	bh=DjX4+Bnt6nCSaTOh31I+NVtamBU63UWP22wg01klHls=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=X5w7/e8cblua24nBQnXOraXM0Eh+pLTauRFP4kJOJg6mitOiEEWm9JTeQr1d/mLFBv6bhDR5/entxhNtUX6Crw9tF7kmjwgxbmqiYbaCXNrjxtZBDz2TV5hQ5AyCM26vuTwkXwHXbK7n0qVmDExuSkbK0ZdPEyfUaqCDcb8XWGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BnEyeh/p; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qZQgeEBv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762873002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OGO7wZ0zR6bxjpI3h5K0xPQHJOsx28xRrKSKYu9tvms=;
	b=BnEyeh/pGLH0LvS8ixPTX15gVABdti1xy+aqUaKLx2LNCok+yavtVUdbKD9kmAmoU7e74q
	Hb0NQ4F600lntwbWYysiJp2y5ZkrLT+R6z+gOqc4MLnMmJXo0tOTlPrpLbS8snDVtXvEQI
	QTGIeijOuZg1OHwdad9II9Id6tnXp9k=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-WNEuf-sEP-emIgH24MV1sQ-1; Tue, 11 Nov 2025 09:56:40 -0500
X-MC-Unique: WNEuf-sEP-emIgH24MV1sQ-1
X-Mimecast-MFC-AGG-ID: WNEuf-sEP-emIgH24MV1sQ_1762873000
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-882485f2984so57142266d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 06:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762873000; x=1763477800; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OGO7wZ0zR6bxjpI3h5K0xPQHJOsx28xRrKSKYu9tvms=;
        b=qZQgeEBvLe28tJW6qYYn8wQ2imnaGmJ8NIZURCI9E8FLIUok2F4gAj1e3532fZUEsD
         b3d2F7eZDUsTt5YaCrFey9cPZ1DPBQYq6FcsyYfTfcguNbvP2o6ru4hpOIlQJa/W9FHI
         HEzpbcU2oea0q3QPiiefOis4UKU92M/Qo4R5WQ9hHECshRcT3gPNDpaHnA7TOnBwhU/B
         tE9mzkiDk0dfn8YAoHBMIpLG5pNu8X3ZQv7SwxkWlatzz/7QKIWEuLZuu66TEqu+6TIR
         ILSiZcTpjIHtd2vOBuFjjoJg0AmHGMNw9QY8g6oFBhddYC6Q42U5u0r71gXFb5EORAXX
         sArA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762873000; x=1763477800;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OGO7wZ0zR6bxjpI3h5K0xPQHJOsx28xRrKSKYu9tvms=;
        b=eNcKwCRJJYNZB/rhFSws9A1uzGvx6wDpW1jE7ancATeAgfZ54lsIFygQQFmuqpGT9U
         s/Sq0uSzhoJfKTR6lq0kX/QyF/poAkfexTGovBlM7z8YXBg2YSWNUtsAhZXaErHTNaDv
         gklQsXMXTU7gQvBtCoAoVT1AkxNWCuYDoDXG1BjnBE27bvYwd9UUjX14WzjUdxGBz9WG
         ts5gXbupUXnQ7ObUF8cJ5/XfDT2FRUhL6iJXXQCOLt+cg7UHTegTwaIL81jO3S5gQqXT
         8UUopT3NtelhvIM1BsTMlO8ztieEM9EtS5N8ENs2r3k1spssSFN9ZlK35wrdTOt3tklt
         yl2g==
X-Forwarded-Encrypted: i=1; AJvYcCWi71VEnUgyNvR4w5WyIe8qqRzPuua7POuapr9BPQEif3LCSfeH+oMSpef2yEJ4ATLXLFaSWA5Jw+gDELk=@vger.kernel.org
X-Gm-Message-State: AOJu0YypsARSvY+kT36ok3/iOXUMwzh3h0CKneG6TMHfPaEGwp5oKZmG
	hl4P9zh7PFrE2gDawreZU/lz3Ei1gOcKONBlujsnK35gfP0gvznVFHYQWwz8/yw0GBXo0XhYCWb
	U1/gdj/yjsXgh0Qk7tIuGwYDl95lG4G1VV8jedJ2qJp5QpnB+El3wx1GoLyOKqyxNiA==
X-Gm-Gg: ASbGncspDqXzrg6x8DlNzxhQabzHtjCtUFwkytB0lNGkSjYqtDRrXNQZ3+QI6+TX/4Z
	Jki2ECyOFFRCLN53JI4YdElb6VGtpaiG5sxJDZYvaMjgwX2NMEhm8BMJNkyacsFhnLY/LuL5U4x
	RfleYnKeD5j24QkBGFi5bfdU21QQ91kqeRAGpT2nl+okQh3P0zL6oVziRha9Qw9snyy5TRBpAem
	IdIQaW2pGXfwlisKa2UNRtvmCPZ9J9CdP7HRerKQua8YjPaZTAWodfghJSbw/9P+8VD6heGuwrh
	mKWsD3pNka1jd3OEjmT1PGiDbTBzlOf//zNsLcpfufFEtXK7+tbqeMpwzsv6pwQ17OQtkOeuJld
	p92/cerrcmZIb6hZtJArZS+j4MoJxYCaiXnhq6w467KoFvg==
X-Received: by 2002:a05:6214:240c:b0:77b:2925:a85b with SMTP id 6a1803df08f44-8823866c6e7mr159348566d6.44.1762873000234;
        Tue, 11 Nov 2025 06:56:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGEORJX30Vv4A6mzZNTTYVEP1dBmzzuthZd5tIvL3PbtzkKoRMI26cc5glhHR4AHIslhhMKAQ==
X-Received: by 2002:a05:6214:240c:b0:77b:2925:a85b with SMTP id 6a1803df08f44-8823866c6e7mr159348246d6.44.1762872999906;
        Tue, 11 Nov 2025 06:56:39 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8823c56b387sm67927066d6.24.2025.11.11.06.56.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 06:56:39 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <307e7687-4320-4b2b-a552-5d8409522cfe@redhat.com>
Date: Tue, 11 Nov 2025 09:56:37 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v2 2/3] cpuset: remove global remote_children list
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20251111132429.950343-1-chenridong@huaweicloud.com>
 <20251111132429.950343-3-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20251111132429.950343-3-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/11/25 8:24 AM, Chen Ridong wrote:
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
>   kernel/cgroup/cpuset-internal.h | 10 +++++++---
>   kernel/cgroup/cpuset.c          | 13 ++++---------
>   2 files changed, 11 insertions(+), 12 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset-internal.h b/kernel/cgroup/cpuset-internal.h
> index 5cac42c5fd97..01976c8e7d49 100644
> --- a/kernel/cgroup/cpuset-internal.h
> +++ b/kernel/cgroup/cpuset-internal.h
> @@ -158,6 +158,13 @@ struct cpuset {
>   	/* partition root state */
>   	int partition_root_state;
>   
> +	/*
> +	 * Whether cpuset is a remote partition.
> +	 * It used to be a list anchoring all remote partitions — we can switch back
> +	 * to a list if we need to iterate over the remote partitions.
> +	 */
> +	bool remote_partition;
> +
>   	/*
>   	 * number of SCHED_DEADLINE tasks attached to this cpuset, so that we
>   	 * know when to rebuild associated root domain bandwidth information.
> @@ -172,9 +179,6 @@ struct cpuset {
>   	/* Handle for cpuset.cpus.partition */
>   	struct cgroup_file partition_file;
>   
> -	/* Remote partition silbling list anchored at remote_children */
> -	struct list_head remote_sibling;
> -
>   	/* Used to merge intersecting subsets for generate_sched_domains */
>   	struct uf_node node;
>   };
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index c90476d52f09..aff3ddc67393 100644
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
I forgot to notify you that this init is also not needed. Anyway, this 
is a minor issue.
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
> @@ -3603,7 +3600,6 @@ cpuset_css_alloc(struct cgroup_subsys_state *parent_css)
>   	__set_bit(CS_SCHED_LOAD_BALANCE, &cs->flags);
>   	fmeter_init(&cs->fmeter);
>   	cs->relax_domain_level = -1;
> -	INIT_LIST_HEAD(&cs->remote_sibling);
>   
>   	/* Set CS_MEMORY_MIGRATE for default hierarchy */
>   	if (cpuset_v2())
> @@ -3874,7 +3870,6 @@ int __init cpuset_init(void)
>   	nodes_setall(top_cpuset.effective_mems);
>   
>   	fmeter_init(&top_cpuset.fmeter);
> -	INIT_LIST_HEAD(&remote_children);
>   
>   	BUG_ON(!alloc_cpumask_var(&cpus_attach, GFP_KERNEL));
>   
Reviewed-by: Waiman Long <longman@redhat.com>


