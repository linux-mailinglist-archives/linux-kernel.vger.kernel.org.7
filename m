Return-Path: <linux-kernel+bounces-767424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A058CB25414
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 21:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BE99727EE8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 19:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 007D1287504;
	Wed, 13 Aug 2025 19:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ai338TZl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61131DF979
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 19:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755114626; cv=none; b=H9E0LBKGrULOqbrpO1CyyxYRaKvph49qmRUqfhj4F0w0kzT7CBNFXjVfY+IqZflJeBn9D58cxTi3cKYcxD4ndB/6EoivcWiLha7hdBHLuLUvuwOCDOjfdQfsCjlvDRWFkURyQhY/YPXAFo/ULUE7pug0sQd38C/Z7gOskNSyxSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755114626; c=relaxed/simple;
	bh=ChZ1iINx635rX4LDGMfL5exJIYnJ0e0bNj1dXoD91Lk=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=V23eAjxRvyOgy4tBjl4uUsG3WScbbQHCHhUoINfl/LBK2Lh6YjtiS7fRQb5W6+CKLJDdVDe2tsQU2YY+Bxp5/mV7uBoe0UZozN78uBKUSNvNvPVSGtze1rVu7wPPvWzGqDGmgvoNwpWRWmT+q/Bweyj1MVpggKhQcZG+t/TnMOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ai338TZl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755114622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R+9vJT083vVIOoUe/0ydCQv0NYkhLLgtEyVYnXFMiAI=;
	b=Ai338TZlxcLwC/qCHXXkxhqM56BF2Q1/wkXgoi638o4gacWgMRA1GwAFSyxogOzFBLNh20
	8YeurE0rM0J983qNBjgs0hsL3/C5cI9EA2ZtbBTmG1DO1OHyrf4ABn/C5caXaTvtx5fXni
	lXVqfhPqUGzdHktW8/mmu/ITDampo5o=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-d5Oxml2zOIWu8it-h-jwXg-1; Wed, 13 Aug 2025 15:50:19 -0400
X-MC-Unique: d5Oxml2zOIWu8it-h-jwXg-1
X-Mimecast-MFC-AGG-ID: d5Oxml2zOIWu8it-h-jwXg_1755114619
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-71d600f9467so4285817b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 12:50:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755114619; x=1755719419;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R+9vJT083vVIOoUe/0ydCQv0NYkhLLgtEyVYnXFMiAI=;
        b=W0SdkWrTwdRrRv4lIo7UTY463Xcy1qwqMa07puOsIP+5wzLSFoEsxZPfWwvfxT0aBn
         y0YFGHoUTHr6oHQUrnqbnBDnqc8sei6hMVoZnObNHLthr37yoRSiwX/Q0MbVQPEaeWXi
         FM+gESl62xPSvIGTGam6EZXZPangzyePMeH27z/3LYje5jDRjTLnGSXHs1DfI2sPM6SE
         PbidEhwZKrLkcYYbSoVkCBUT4IThkIdcHaTyt4OayfJfO985Eqdb57sGINa3JNPAaiM7
         vGYJCb3KBdMs+T5NuYGyvJsdpkM29TfGOGVSISLf6riMw/oG+WTaBsT1yq4/Cb4jyJHu
         JRmA==
X-Forwarded-Encrypted: i=1; AJvYcCWK/J3xpBiGwrrwo6o+VFNI6XszcNupu1cQOk+Qm5eL58JByYJbn6BiSmVubSVOImvzO/xceO0Oev7uT7k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdCr0gxJrDsC+yKVe5Hjm5mBgLRNUEUmaVW6nMYNxTCH/3uUFy
	qtBpmGmR4xLvRiFKmfXYCqdeBOmSZHj9mpqVhkj0hkjJSK40skWKxsYDpL+aCLbcjuhogMQg3BA
	Xmp5WM+8rbyAnVdLacyUhmF6c1s6d8A9ktw39MRCRlEe3ObudnLacgYrK59r2CO2d+A==
X-Gm-Gg: ASbGnctKp4VG9cItIKzyQjYmfteEmzBxrQh+6KThFXiiXslUg6Mjl9YTYIHHLNADg8u
	DOhouH/Nkzy9oa0LhzTGaiI2s8wGaerfXdSOW0QMW8j5PCDlLHCJ2b9qPOkIOCIvEu2CFypSNHd
	Jo7d/pE7ZveSbjASh99XJY0Fkeu+h9lwM+pryhLfdmLU4v87bprcHhpyUoxLBLz2BBAXA8wzaAU
	/0Ad5kbQbkgJJECKVk7tJQpaI7p8WgKekJSe+/f3RJDNu6Kl8gJsN2VXr9z0YQZlSuGd5R0q64W
	vyGg6Vb8Tj1FOR0B0nAVADxrz+YWGcwFqhafH5TYMcfZAiIZ0a3SA2b57womkvwTcw1GM5jUBBh
	axdQa2okujw==
X-Received: by 2002:a05:690c:74c9:b0:710:e7ad:9d49 with SMTP id 00721157ae682-71d6343c296mr2296557b3.13.1755114618885;
        Wed, 13 Aug 2025 12:50:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1uej4ImNVgiwyTxeKWBGtqsi1nzxETVvKE8OUTp1C76DEAwd48J4GnXV36VbOW5Ej+SklCg==
X-Received: by 2002:a05:690c:74c9:b0:710:e7ad:9d49 with SMTP id 00721157ae682-71d6343c296mr2296397b3.13.1755114618541;
        Wed, 13 Aug 2025 12:50:18 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71d6103c2e3sm1148077b3.68.2025.08.13.12.50.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 12:50:18 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <d50ccb6d-a26c-4ab8-b213-161622e25c7c@redhat.com>
Date: Wed, 13 Aug 2025 15:50:16 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [-next v2 2/4] cpuset: decouple tmpmaks and cpumaks of cs free
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com, christophe.jaillet@wanadoo.fr
References: <20250813082904.1091651-1-chenridong@huaweicloud.com>
 <20250813082904.1091651-3-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20250813082904.1091651-3-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/13/25 4:29 AM, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
>
> Currently, free_cpumasks can free tmpmasks of cpumask of cs. However, it
> doesn't have couple these 2 options. To make the function more clearer,
> move the freeing of cpumask in cs to the free_cpuset. And rename the
> free_cpumasks to the free_tmpmasks. which is Single responsibility.
>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>

Other than typos in the patch title, the code change looks good to me.

Cheers,
Longman

> ---
>   kernel/cgroup/cpuset.c | 32 +++++++++++++-------------------
>   1 file changed, 13 insertions(+), 19 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 3466ebbf1016..aebda14cc67f 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -459,23 +459,14 @@ static inline int alloc_cpumasks(struct cpuset *cs, struct tmpmasks *tmp)
>   }
>   
>   /**
> - * free_cpumasks - free cpumasks in a tmpmasks structure
> - * @cs:  the cpuset that have cpumasks to be free.
> + * free_tmpmasks - free cpumasks in a tmpmasks structure
>    * @tmp: the tmpmasks structure pointer
>    */
> -static inline void free_cpumasks(struct cpuset *cs, struct tmpmasks *tmp)
> +static inline void free_tmpmasks(struct tmpmasks *tmp)
>   {
> -	if (cs) {
> -		free_cpumask_var(cs->cpus_allowed);
> -		free_cpumask_var(cs->effective_cpus);
> -		free_cpumask_var(cs->effective_xcpus);
> -		free_cpumask_var(cs->exclusive_cpus);
> -	}
> -	if (tmp) {
> -		free_cpumask_var(tmp->new_cpus);
> -		free_cpumask_var(tmp->addmask);
> -		free_cpumask_var(tmp->delmask);
> -	}
> +	free_cpumask_var(tmp->new_cpus);
> +	free_cpumask_var(tmp->addmask);
> +	free_cpumask_var(tmp->delmask);
>   }
>   
>   /**
> @@ -508,7 +499,10 @@ static struct cpuset *alloc_trial_cpuset(struct cpuset *cs)
>    */
>   static inline void free_cpuset(struct cpuset *cs)
>   {
> -	free_cpumasks(cs, NULL);
> +	free_cpumask_var(cs->cpus_allowed);
> +	free_cpumask_var(cs->effective_cpus);
> +	free_cpumask_var(cs->effective_xcpus);
> +	free_cpumask_var(cs->exclusive_cpus);
>   	kfree(cs);
>   }
>   
> @@ -2427,7 +2421,7 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
>   	if (cs->partition_root_state)
>   		update_partition_sd_lb(cs, old_prs);
>   out_free:
> -	free_cpumasks(NULL, &tmp);
> +	free_tmpmasks(&tmp);
>   	return retval;
>   }
>   
> @@ -2530,7 +2524,7 @@ static int update_exclusive_cpumask(struct cpuset *cs, struct cpuset *trialcs,
>   	if (cs->partition_root_state)
>   		update_partition_sd_lb(cs, old_prs);
>   
> -	free_cpumasks(NULL, &tmp);
> +	free_tmpmasks(&tmp);
>   	return 0;
>   }
>   
> @@ -2983,7 +2977,7 @@ static int update_prstate(struct cpuset *cs, int new_prs)
>   	notify_partition_change(cs, old_prs);
>   	if (force_sd_rebuild)
>   		rebuild_sched_domains_locked();
> -	free_cpumasks(NULL, &tmpmask);
> +	free_tmpmasks(&tmpmask);
>   	return 0;
>   }
>   
> @@ -4006,7 +4000,7 @@ static void cpuset_handle_hotplug(void)
>   	if (force_sd_rebuild)
>   		rebuild_sched_domains_cpuslocked();
>   
> -	free_cpumasks(NULL, ptmp);
> +	free_tmpmasks(ptmp);
>   }
>   
>   void cpuset_update_active_cpus(void)


