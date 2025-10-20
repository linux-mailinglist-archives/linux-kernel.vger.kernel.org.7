Return-Path: <linux-kernel+bounces-859998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54536BEF1D6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 04:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9D281898641
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 02:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A90329B228;
	Mon, 20 Oct 2025 02:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CPzf1Ish"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EDC946A
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 02:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760928199; cv=none; b=C7M+VSYIxa4xTibC/umoQcmZwHqMnRBjLbknQz/pCsCSlm/8Fy/Ja3nZ3KZg9gGAdYPy+V73Vlx6LZMW3I2rRIavmo/ow3Gpp37fgmQ28Ov1i06G13Tg0El1v5Ux1NYTsM2ftIGUhEKx4PZ/HTd8nqcrhKyqQKYaE4VflHoV85Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760928199; c=relaxed/simple;
	bh=ry1rTLJGX0OoxJ2k+Ec+cH/Am8wxXowdHDabfgpLk3M=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=rfbuNcHHMZvfBCZf2f57GnLXpeEKmGtODJLpT7vJVwYStVYrfdb5t7/xJ049fRT4hHkmFN41mh3SCpHsJ4/m++vX+23lhCcpp3/tuJqv4iRlzKLRcBiWpxVTZPw7t0c1Gp/Jr3/LwYTeKYdd5WjPItEI7lsViIJMaMQxUKzJCbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CPzf1Ish; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760928196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a9FeIFGHIOt061MX7LYjVGVrxA4LCOAprqsl7d5bkDA=;
	b=CPzf1IshtsY9vQAQ14mJ1y7wWH+CxTxHI0Do5MELL1V4Xu2Emdgd22/RedPt6T6TnvP3Cp
	zlllL33BcshY+nJaBqPiOwo1qIUNori7YWUuByy+XgOfRFV3yRvCkTBs12BMGjLzxg1j4l
	w9tQao9Eg4VaVWu6AyqgN3po/q0lYO4=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-1nHoGWTbN822nRut9zp12g-1; Sun, 19 Oct 2025 22:43:15 -0400
X-MC-Unique: 1nHoGWTbN822nRut9zp12g-1
X-Mimecast-MFC-AGG-ID: 1nHoGWTbN822nRut9zp12g_1760928195
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8741223accfso163575676d6.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 19:43:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760928195; x=1761532995;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a9FeIFGHIOt061MX7LYjVGVrxA4LCOAprqsl7d5bkDA=;
        b=gl11bDE3vYRb9deeokKKRn/+8fTIcoFbYfHEItbg6WwfRCsr7AViFXnzTs4CiQighS
         a3OMcJtmMn+KHoDAODmEpGNWP3nyxjQgDrmkWSlmlOL4RddpZOC8YT8Pmc2i3AazKXv+
         mliCvKmi48Zt3BwciDFR3y/WDUJIkwNRaxIgrWnEp+c2ACFr4lK0yBiNTkJIpb7oGUEf
         hBMEJnCqDcyia2wtlQ3Rib3tZyVydTsPFFJSuan4k2oRjtvcXV0TjXC29H4LWUI+Tf9u
         Huv84rPSL5O+H6SbbLBVS11vNXoPTi9/Tw5dnxRbGB/lu/C17fNBwF1oJy3SaGMog0yv
         50Ag==
X-Forwarded-Encrypted: i=1; AJvYcCURyT6eQU8e6aahcVnaVbpqNPGEbuIxYJhzZ8fIn5H4tRdnzFiGCWqc0quv1XshwjcLBHFghogWOGnhels=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSzj7W//IiziF2T6MUgyZyqsacpIYopwzCK9b9/3LGfWIuVeKm
	1+7IQquYaJogpRUF5i8wS71Stf3GZSG1oyZ2jX5IgQ5kNLBxQTOPvc5+1wzYNEEuoYvWcZxNvqf
	ihYBCi2ZUt75lXZt5zcboLFVm8mIy03zySKx3lgXKXUxGeRCVyacH7hTmtZiYykuDCQ==
X-Gm-Gg: ASbGncsuB5Y94OnSeGDazOfXmvq4DUpggEjxZkcqlzZVFCKTd/uaUz6yoY5Oppbu70c
	yCCsbHpvxewnNftPynRUHMizmfqIDaGQ4iKYSzerzOeAvXg3tuq5ppYGv28hgJXYEEeKFOLN6ug
	VlPop7AkTKN0ULbgo2E0Ec/D90uH1+vuPzQJBm97ZexVqRY04RhZtHZK4kSXUoNubELMu8GtuZ3
	nKKcpZAy9qgtcSBuw5rhQgPpN7B7qQxII9Z8rZrjNZJ+70p7ba2gv3R+hgLin+gqhQyznoHKVK9
	Fj/ebai6JFlYRDSxKKqittY6c/ZVMOsxwynatXWKG2Ic4es3c1mVQnR8OjOFFvbx1Y8QvphGxJ/
	0oJK66wFtYrb1vOxZrWsQkSJrj/ijGVZyNEOcUYbCnPigtQ==
X-Received: by 2002:a05:622a:1105:b0:4e8:a307:a41f with SMTP id d75a77b69052e-4e8a307aae0mr119925981cf.39.1760928194937;
        Sun, 19 Oct 2025 19:43:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJ0yQKFR/MoRvIK9gEEecFjos80cv/rlKd3fsdcQb0wVYZhYSGfMtg5oJB522O1rjmGfdbPA==
X-Received: by 2002:a05:622a:1105:b0:4e8:a307:a41f with SMTP id d75a77b69052e-4e8a307aae0mr119925931cf.39.1760928194556;
        Sun, 19 Oct 2025 19:43:14 -0700 (PDT)
Received: from ?IPV6:2601:600:947f:f020:85dc:d2b2:c5ee:e3c4? ([2601:600:947f:f020:85dc:d2b2:c5ee:e3c4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-891cf86fb69sm465658385a.53.2025.10.19.19.43.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Oct 2025 19:43:14 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <6122ac29-3984-4364-ab37-4987b65b5450@redhat.com>
Date: Sun, 19 Oct 2025 22:43:12 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next RFC 05/16] cpuset: factor out partition_update()
 function
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20250928071306.3797436-1-chenridong@huaweicloud.com>
 <20250928071306.3797436-6-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20250928071306.3797436-6-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/28/25 3:12 AM, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
>
> Extract the core partition update logic into a dedicated partition_update()
> function. This refactoring centralizes updates to key cpuset data
> structures including remote_sibling, effective_xcpus, partition_root_state,
> and prs_err.
>
> The function handles the complete partition update workflow:
> - Adding and removing exclusive CPUs via partition_xcpus_add()/del()
> - Managing remote sibling relationships
> - Synchronizing effective exclusive CPUs mask
> - Updating partition state and error status
> - Triggering required system updates and workqueue synchronization
>
> This creates a coherent interface for partition operations and establishes
> a foundation for enhanced partition management while maintaining existing
> remote partition behavior.
>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>   kernel/cgroup/cpuset.c | 71 ++++++++++++++++++++++++++++--------------
>   1 file changed, 47 insertions(+), 24 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 1944410ae872..0e2f95daf459 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1587,6 +1587,49 @@ static void partition_disable(struct cpuset *cs, struct cpuset *parent,
>   	cpuset_force_rebuild();
>   }
>   
> +/**
> + * partition_update - Update an existing partition configuration
> + * @cs: The cpuset to update
> + * @prs: Partition root state (must be positive)
> + * @xcpus: New exclusive CPUs mask for the partition (NULL to keep current)
> + * @excpus: New effective exclusive CPUs mask
> + * @tmp: Temporary masks
> + *
> + * Updates partition-related fields. The tmp->addmask is the CPU mask that
> + * will be added to the subpartitions_cpus and removed from parent's
> + * effective_cpus, and the tmp->delmask vice versa.
> + */
> +static void partition_update(struct cpuset *cs, int prs, struct cpumask *xcpus,
> +				  struct cpumask *excpus, struct tmpmasks *tmp)
> +{
> +	bool isolcpus_updated;
> +	bool excl_updated;
> +	struct cpuset *parent;
> +
> +	lockdep_assert_held(&cpuset_mutex);
> +	WARN_ON_ONCE(!cpuset_v2());
> +	WARN_ON_ONCE(prs <= 0);
> +
> +	parent = is_remote_partition(cs) ? NULL : parent_cs(cs);
> +	excl_updated = !cpumask_empty(tmp->addmask) ||
> +			!cpumask_empty(tmp->delmask);
> +
> +	spin_lock_irq(&callback_lock);
> +	isolcpus_updated = partition_xcpus_add(prs, parent, tmp->addmask);
> +	isolcpus_updated |= partition_xcpus_del(prs, parent, tmp->delmask);

The current partition_xcpus_add/del() functions assume the given cpumas 
is non-empty. In the new partition_update() helper, you can pass an 
empty cpumask to them. This will cause useless work to be done. Also 
isolcpus_update may not be correct because of that causing unneeded work 
to be done in the workqueue code.

-Longman


