Return-Path: <linux-kernel+bounces-783715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3052B33192
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 19:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7EF8202C27
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 17:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD6629A309;
	Sun, 24 Aug 2025 17:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SH+J9Dm4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4841E2312
	for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 17:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756055130; cv=none; b=B8wiVHhABX+u04HcLzu/XXlw7JLru99qEvXdRQgHXWUguO80xYl9MVPO+v5gdxV9QrdypCq+0YBqqf1F184+zU9EoAVMZcHIaPzxuZA0MXm9aK9urdEG30CUs5T0XJl/MSmb5Kfum2Q0aYYas8Mijn6wq6y5vgShRJsu2A1utEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756055130; c=relaxed/simple;
	bh=+gXyxD/FxzgurSb+TaoB7tPfHS2XOVjo4E24unteKDs=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=gDXxgm4m+LSxy5YHZCKqyVjjOBlVfweSybRWWvEHRBYcWrGqo0lbI7GSOBoc+f2zTCBm2i5VDCWUYvpaZxxNtCJ9lk0mnu+A+GbaL49nCbyg4JGdSs5uyirQByLUlmTIfwNu8Z5r8XwtPVyX+LPdyTDeZJ+NBKGorjmpk3RZHOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SH+J9Dm4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756055126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ebk50XJ5aBZpDlGgruPIO2wKskukMvv2mXJM5o43iUI=;
	b=SH+J9Dm4cJYrLsuX7MSSfyI+zPoxskjpwxX/Pd5o2ERZkoXK0YyzwE7jIwwv5NqsvNngQt
	xn9OM/hh06ERJg94EobdvuVyCtpWjKv2kybuKDTtm53e8yipkHMbaP8C/6PLVtkb4f08cu
	8pga/CPlJFbbAaWM9VKEF9Zd2pvABaw=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-351-OyhtrFfgMPiY_a0Bx8jydw-1; Sun, 24 Aug 2025 13:05:25 -0400
X-MC-Unique: OyhtrFfgMPiY_a0Bx8jydw-1
X-Mimecast-MFC-AGG-ID: OyhtrFfgMPiY_a0Bx8jydw_1756055124
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-71d4cc7fa4fso78770567b3.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 10:05:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756055124; x=1756659924;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ebk50XJ5aBZpDlGgruPIO2wKskukMvv2mXJM5o43iUI=;
        b=oNLVYEJO1IRJc+Kee0/PwA6q5r6y0CFFZ0mz3Pherf0VtsUM3x38cVcvj7hAxZwRKh
         In2c+DsgZfBTmIyCyiqoP//ViWeoW7P57dm3CQ5INuX3g8UgGtrYseF93s5N6ktsZIEk
         JlWCc0UoNjSGrgdCHs+BcyDN2v7W4ES9ciq0QDbpBjfihbI4F1WkwvL2FCw/MBCpaqaZ
         eOJetNen9XhROxhobXW7K+gtZOCUJpDRjUtsUVUmF2maoxryPGVvlQrRA7fRaGTcxLcl
         zNdP4fKM3esMDnYQ4bAkTODHAZYASRJJaulm0RTcbdXsrYMWCOhLxqR2bwCs3MnW9CV4
         a/EA==
X-Forwarded-Encrypted: i=1; AJvYcCVTIBuSZ/dNNje7qPvKNiDeM3nFXIP+2qZ+Ac5Psv4n/9M3L6v5LLrBzgAIl0bZ3J9XFTGpLpboBImmkls=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkAZ732iiJFTOiSRTWVNbWANOBXXJ0GzI491FFOTSSor2zoLWU
	fZox7OAoNHJ2Bk6RKZ9tDcJYvJYNzRgvGQaYeqMY4AZTkvsfzzCedt10FqbLqj5YLy/QZ1ATr+6
	8TX8ysVEKSAo31zFIOnrNAODm8uRbqFN6OzciPGDE+hbkaF3SyA5MzsxNEU9XTVirGA==
X-Gm-Gg: ASbGnctDgToirY+b2nX5XYzPnzh900Vr0x5RSbHd3IXjn+bIhcYH6q7+z/WMhY62Jz4
	FO/vZOjAPn2w3KRvOeWta8xm6YMJbfHjgwBTgrydJOtmgRu9oD5YyUuk9gscWd4HEVQZg1FEKFs
	oh8yRTHnk9Rjn4TjusUI5ejFxmXLuStRpP6/A2KCFflrvDgo+Ezm5UDEQCPgMw5YXPE2orMNQqI
	cmIGlaS6D//i3Ya8QY/qcw3mGz1iOPKw32XrbcMAoZuM8sLjrcZSYeqbpxJhTnB5Wnav70bGm8c
	mEIrP1z0S0qEEK8mf+nnu7EeBDT21bdjTIjqT15G38NzESm8grIPhvFWRzU4YTEX5lDC5mtD2Ju
	R6NYC+ZBtWg==
X-Received: by 2002:a05:690c:7286:b0:71e:6583:7d37 with SMTP id 00721157ae682-71fc9f1ecf0mr125649727b3.14.1756055124347;
        Sun, 24 Aug 2025 10:05:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/J+Luf7Qg54td3ILGcBBdVf0JpOfbrxB1sftPC23mthSTIISxqOToHijO+yObw95KPV/nMg==
X-Received: by 2002:a05:690c:7286:b0:71e:6583:7d37 with SMTP id 00721157ae682-71fc9f1ecf0mr125649357b3.14.1756055123743;
        Sun, 24 Aug 2025 10:05:23 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71ff173633esm12308057b3.27.2025.08.24.10.05.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Aug 2025 10:05:23 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <0b918f11-d850-4cdb-b9af-ffa436b8fd1e@redhat.com>
Date: Sun, 24 Aug 2025 13:05:21 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v4 2/3] cpuset: separate tmpmasks and cpuset
 allocation logic
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20250818064141.1334859-1-chenridong@huaweicloud.com>
 <20250818064141.1334859-3-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20250818064141.1334859-3-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 8/18/25 2:41 AM, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
>
> The original alloc_cpumasks() served dual purposes: allocating cpumasks
> for both temporary masks (tmpmasks) and cpuset structures. This patch:
>
> 1. Decouples these allocation paths for better code clarity
> 2. Introduces dedicated alloc_tmpmasks() and dup_or_alloc_cpuset()
>     functions
> 3. Maintains symmetric pairing:
>     - alloc_tmpmasks() ↔ free_tmpmasks()
>     - dup_or_alloc_cpuset() ↔ free_cpuset()
>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>   kernel/cgroup/cpuset.c | 128 ++++++++++++++++++++++-------------------
>   1 file changed, 69 insertions(+), 59 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index aebda14cc67f..d5588a1fef60 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -411,51 +411,46 @@ static void guarantee_online_mems(struct cpuset *cs, nodemask_t *pmask)
>   }
>   
>   /**
> - * alloc_cpumasks - allocate three cpumasks for cpuset
> - * @cs:  the cpuset that have cpumasks to be allocated.
> - * @tmp: the tmpmasks structure pointer
> - * Return: 0 if successful, -ENOMEM otherwise.
> + * alloc_cpumasks - Allocate an array of cpumask variables
> + * @pmasks: Pointer to array of cpumask_var_t pointers
> + * @size: Number of cpumasks to allocate
>    *
> - * Only one of the two input arguments should be non-NULL.
> + * Allocates @size cpumasks and initializes them to empty. Returns 0 on
> + * success, -ENOMEM on allocation failure. On failure, any previously
> + * allocated cpumasks are freed.

The convention for the kernel-doc is to have a "Return:" tag if the 
function has a returned value. That "Return:" tag is deleted by this 
change. Your description does describe the returned value and no test 
robot failure was reported. Other than that, the rest of the patch looks 
good to me.

Cheers,
Longman

>    */
> -static inline int alloc_cpumasks(struct cpuset *cs, struct tmpmasks *tmp)
> +static inline int alloc_cpumasks(cpumask_var_t *pmasks[], u32 size)
>   {
> -	cpumask_var_t *pmask1, *pmask2, *pmask3, *pmask4;
> +	int i;
>   
> -	if (cs) {
> -		pmask1 = &cs->cpus_allowed;
> -		pmask2 = &cs->effective_cpus;
> -		pmask3 = &cs->effective_xcpus;
> -		pmask4 = &cs->exclusive_cpus;
> -	} else {
> -		pmask1 = &tmp->new_cpus;
> -		pmask2 = &tmp->addmask;
> -		pmask3 = &tmp->delmask;
> -		pmask4 = NULL;
> +	for (i = 0; i < size; i++) {
> +		if (!zalloc_cpumask_var(pmasks[i], GFP_KERNEL)) {
> +			while (--i >= 0)
> +				free_cpumask_var(*pmasks[i]);
> +			return -ENOMEM;
> +		}
>   	}
> -
> -	if (!zalloc_cpumask_var(pmask1, GFP_KERNEL))
> -		return -ENOMEM;
> -
> -	if (!zalloc_cpumask_var(pmask2, GFP_KERNEL))
> -		goto free_one;
> -
> -	if (!zalloc_cpumask_var(pmask3, GFP_KERNEL))
> -		goto free_two;
> -
> -	if (pmask4 && !zalloc_cpumask_var(pmask4, GFP_KERNEL))
> -		goto free_three;
> -
> -
>   	return 0;
> +}
>   
> -free_three:
> -	free_cpumask_var(*pmask3);
> -free_two:
> -	free_cpumask_var(*pmask2);
> -free_one:
> -	free_cpumask_var(*pmask1);
> -	return -ENOMEM;
> +/**
> + * alloc_tmpmasks - Allocate temporary cpumasks for cpuset operations.
> + * @tmp: Pointer to tmpmasks structure to populate
> + * Return: 0 on success, -ENOMEM on allocation failure
> + */
> +static inline int alloc_tmpmasks(struct tmpmasks *tmp)
> +{
> +	/*
> +	 * Array of pointers to the three cpumask_var_t fields in tmpmasks.
> +	 * Note: Array size must match actual number of masks (3)
> +	 */
> +	cpumask_var_t *pmask[3] = {
> +		&tmp->new_cpus,
> +		&tmp->addmask,
> +		&tmp->delmask
> +	};
> +
> +	return alloc_cpumasks(pmask, ARRAY_SIZE(pmask));
>   }
>   
>   /**
> @@ -470,26 +465,46 @@ static inline void free_tmpmasks(struct tmpmasks *tmp)
>   }
>   
>   /**
> - * alloc_trial_cpuset - allocate a trial cpuset
> - * @cs: the cpuset that the trial cpuset duplicates
> + * dup_or_alloc_cpuset - Duplicate or allocate a new cpuset
> + * @cs: Source cpuset to duplicate (NULL for a fresh allocation)
> + *
> + * Creates a new cpuset by either:
> + * 1. Duplicating an existing cpuset (if @cs is non-NULL), or
> + * 2. Allocating a fresh cpuset with zero-initialized masks (if @cs is NULL)
> + *
> + * Return: Pointer to newly allocated cpuset on success, NULL on failure
>    */
> -static struct cpuset *alloc_trial_cpuset(struct cpuset *cs)
> +static struct cpuset *dup_or_alloc_cpuset(struct cpuset *cs)
>   {
>   	struct cpuset *trial;
>   
> -	trial = kmemdup(cs, sizeof(*cs), GFP_KERNEL);
> +	/* Allocate base structure */
> +	trial = cs ? kmemdup(cs, sizeof(*cs), GFP_KERNEL) :
> +		     kzalloc(sizeof(*cs), GFP_KERNEL);
>   	if (!trial)
>   		return NULL;
>   
> -	if (alloc_cpumasks(trial, NULL)) {
> +	/* Setup cpumask pointer array */
> +	cpumask_var_t *pmask[4] = {
> +		&trial->cpus_allowed,
> +		&trial->effective_cpus,
> +		&trial->effective_xcpus,
> +		&trial->exclusive_cpus
> +	};
> +
> +	if (alloc_cpumasks(pmask, ARRAY_SIZE(pmask))) {
>   		kfree(trial);
>   		return NULL;
>   	}
>   
> -	cpumask_copy(trial->cpus_allowed, cs->cpus_allowed);
> -	cpumask_copy(trial->effective_cpus, cs->effective_cpus);
> -	cpumask_copy(trial->effective_xcpus, cs->effective_xcpus);
> -	cpumask_copy(trial->exclusive_cpus, cs->exclusive_cpus);
> +	/* Copy masks if duplicating */
> +	if (cs) {
> +		cpumask_copy(trial->cpus_allowed, cs->cpus_allowed);
> +		cpumask_copy(trial->effective_cpus, cs->effective_cpus);
> +		cpumask_copy(trial->effective_xcpus, cs->effective_xcpus);
> +		cpumask_copy(trial->exclusive_cpus, cs->exclusive_cpus);
> +	}
> +
>   	return trial;
>   }
>   
> @@ -2332,7 +2347,7 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
>   	if (cpumask_equal(cs->cpus_allowed, trialcs->cpus_allowed))
>   		return 0;
>   
> -	if (alloc_cpumasks(NULL, &tmp))
> +	if (alloc_tmpmasks(&tmp))
>   		return -ENOMEM;
>   
>   	if (old_prs) {
> @@ -2476,7 +2491,7 @@ static int update_exclusive_cpumask(struct cpuset *cs, struct cpuset *trialcs,
>   	if (retval)
>   		return retval;
>   
> -	if (alloc_cpumasks(NULL, &tmp))
> +	if (alloc_tmpmasks(&tmp))
>   		return -ENOMEM;
>   
>   	if (old_prs) {
> @@ -2820,7 +2835,7 @@ int cpuset_update_flag(cpuset_flagbits_t bit, struct cpuset *cs,
>   	int spread_flag_changed;
>   	int err;
>   
> -	trialcs = alloc_trial_cpuset(cs);
> +	trialcs = dup_or_alloc_cpuset(cs);
>   	if (!trialcs)
>   		return -ENOMEM;
>   
> @@ -2881,7 +2896,7 @@ static int update_prstate(struct cpuset *cs, int new_prs)
>   	if (new_prs && is_prs_invalid(old_prs))
>   		old_prs = PRS_MEMBER;
>   
> -	if (alloc_cpumasks(NULL, &tmpmask))
> +	if (alloc_tmpmasks(&tmpmask))
>   		return -ENOMEM;
>   
>   	err = update_partition_exclusive_flag(cs, new_prs);
> @@ -3223,7 +3238,7 @@ ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
>   	if (!is_cpuset_online(cs))
>   		goto out_unlock;
>   
> -	trialcs = alloc_trial_cpuset(cs);
> +	trialcs = dup_or_alloc_cpuset(cs);
>   	if (!trialcs) {
>   		retval = -ENOMEM;
>   		goto out_unlock;
> @@ -3456,15 +3471,10 @@ cpuset_css_alloc(struct cgroup_subsys_state *parent_css)
>   	if (!parent_css)
>   		return &top_cpuset.css;
>   
> -	cs = kzalloc(sizeof(*cs), GFP_KERNEL);
> +	cs = dup_or_alloc_cpuset(NULL);
>   	if (!cs)
>   		return ERR_PTR(-ENOMEM);
>   
> -	if (alloc_cpumasks(cs, NULL)) {
> -		kfree(cs);
> -		return ERR_PTR(-ENOMEM);
> -	}
> -
>   	__set_bit(CS_SCHED_LOAD_BALANCE, &cs->flags);
>   	fmeter_init(&cs->fmeter);
>   	cs->relax_domain_level = -1;
> @@ -3920,7 +3930,7 @@ static void cpuset_handle_hotplug(void)
>   	bool on_dfl = is_in_v2_mode();
>   	struct tmpmasks tmp, *ptmp = NULL;
>   
> -	if (on_dfl && !alloc_cpumasks(NULL, &tmp))
> +	if (on_dfl && !alloc_tmpmasks(&tmp))
>   		ptmp = &tmp;
>   
>   	lockdep_assert_cpus_held();


