Return-Path: <linux-kernel+bounces-859995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0DCDBEF1C7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 04:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75A1A3BEC46
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 02:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5238E29ACE5;
	Mon, 20 Oct 2025 02:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b4aob83x"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B06F17A2F0
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 02:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760927970; cv=none; b=P/+7anSnyc8X5Y3yXlAcpxDQ6Jbmeitbth/Ae5BaMcCjkew7J50drW6E9x5v34r5beVy1o0p9N8ZHVXNH5hg19eUcYgqxOyupspgkqwZ0tp+lIBEaf80ieSFLP9gHx35HYS7/gco7bx+ADWGsAv5P9VBZdKPFWYoLOUFxutJLaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760927970; c=relaxed/simple;
	bh=AHIr1rCfOzKrgGllIJE+2osrB1Nxu1jpnyMI10s+AJ4=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=knWIyngg+mlMDE6UwP9ANNhLFLZalaN78N3pCIsaWRGzchjHDXrwR+PgtEmtmCLXPX5djjm3GevWWAo74oc4hczECY8XfiGYbYpvWdtps/eMfxV2OLtVPGEMASFege7dlB3K57N928FF2HALvc+Wpp+wVjUQeh7OTdAUYS5ZTkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b4aob83x; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760927967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9EkYhcXhHkTg4ElWdhzFPtQOrK8H5aoYZo0Q03k+XHA=;
	b=b4aob83x4JuzRVRpWEWg6jqhPxzdOQ5G7Bw5CkYWLtwqh3yvMbXEse4YxKV8lFqCumovaN
	gPT2yS2j/1/p8gm4xS8ikvhX9AU/DTJ1HcACD0nYoV5Ii1x8GM5jylDmmMYOL3uuAI4sM/
	XYISLP/7gI8Q0HoxUrzr2mto4F9Iwx8=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-PZRFqqCPOLyd3CWKsz5tbA-1; Sun, 19 Oct 2025 22:39:25 -0400
X-MC-Unique: PZRFqqCPOLyd3CWKsz5tbA-1
X-Mimecast-MFC-AGG-ID: PZRFqqCPOLyd3CWKsz5tbA_1760927965
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-81d800259e3so63542436d6.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 19:39:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760927965; x=1761532765;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9EkYhcXhHkTg4ElWdhzFPtQOrK8H5aoYZo0Q03k+XHA=;
        b=PzrRZRTJCrfPrKMoLUr0NrK0K5hyTAJORqm6Haor96qkylOHjSsn2maDxArWBmswHM
         eDqobouIPoDr06VAYXjwpR9aHCp0gy+qIURuscfZ8oXNsIjwhJJ20Ppq/Xi9llPFqkg3
         pEoi7hkyVRuX8FYhC+K/Aenzg3zqilaIzPO13LWfRGM5kZ65cbaOqeRST3o4sFqNxvIh
         Ya4WmV/AVLTomTwScWsZlahBOKSTTMpnAC0+EQKQ9NqPrWQOYKf5f+kIjpYlkwPb0kj7
         kRrGsVHvmBifVoaXLSYKYPyqfPOu9w16YxDrB1NlKT+0ZUKU9VbpPXIdLej+StEPti3L
         i2Gw==
X-Forwarded-Encrypted: i=1; AJvYcCUSsmyoLYMxVIY2PY9nPx0e1K8CyXV4C1ej2n3kr9vTIE32+pcE6XYaOkcZXEpor7G4XsEjjhJN/5gAuwM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnQbrjBaszvU58PySf/06y0e5ZWZdy2SqqSsfgOGl4BHspBr42
	eoatEhIOn6jOex8BdvVPDrAD1IxqIbbkvW+bn85Df9E4Rc5RfCXpg9YjrYXpP1g/uUd/UGsDXIX
	NgzWVOZ4aJzzjHQ1A6WxXCtZ8297svv5CNFWGr6teh+k0LBjREHuqnRbrlfKEMZus1g==
X-Gm-Gg: ASbGncvD7LDw9rtugWdCF8F3Z40EKmCWPAc3NT0BOyWHtL8CnAWq2Tit5nwd91HYTht
	jkFppaWxDIPfVfNsuoT9PHwoMpGjtHY731O3l+ejn7Hm45W9gi0fMQAD/vmMPNL1XX2u7QDqx7r
	6HXTH/JM0bq8AIUyyyzDFP84PfK36D+15rLWyC4pQ5SFLHP7VPOfTqlUuFLw8W8Vhs5XFuF8fG7
	uPzBVThDOHvUiozUhijhB5rf/h4dfrIgGze6RtlZai01CpFl+esGMrKC6GCLmTAUdsCtZIPBiZr
	bFgaLEMx7H5Rd4XDrYM5LIMmKQk+ivAdVEpPJ+bWvLyW1ktptVfHfDdcMrcELdkhqZ/xSq3lnKO
	1Co5ssQTbqnJDTcz57ix1bOxA2I4Z24IX65l4vKNdekmUnA==
X-Received: by 2002:ac8:424b:0:b0:4e8:a3ed:4c6c with SMTP id d75a77b69052e-4e8a3ed4d4bmr83408741cf.33.1760927965041;
        Sun, 19 Oct 2025 19:39:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJghEypNh7+N9IeJFPOFeoy5BjrryYWLQAHJ4Kb5bkTlDx9CGosRlGv+om9gKXtkjcwAT9YQ==
X-Received: by 2002:ac8:424b:0:b0:4e8:a3ed:4c6c with SMTP id d75a77b69052e-4e8a3ed4d4bmr83408551cf.33.1760927964539;
        Sun, 19 Oct 2025 19:39:24 -0700 (PDT)
Received: from ?IPV6:2601:600:947f:f020:85dc:d2b2:c5ee:e3c4? ([2601:600:947f:f020:85dc:d2b2:c5ee:e3c4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-891cf86fb69sm465119785a.53.2025.10.19.19.39.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Oct 2025 19:39:24 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <9168ffab-b0a8-4024-a1f4-966b9f95c953@redhat.com>
Date: Sun, 19 Oct 2025 22:39:22 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next RFC 03/16] cpuset: factor out partition_enable()
 function
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20250928071306.3797436-1-chenridong@huaweicloud.com>
 <20250928071306.3797436-4-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20250928071306.3797436-4-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/28/25 3:12 AM, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
>
> Extract the core partition enablement logic into a dedicated
> partition_enable() function. This refactoring centralizes updates to key
> cpuset data structures including remote_sibling, effective_xcpus,
> partition_root_state, and prs_err.
>
> The function handles the complete partition enablement workflow:
> - Adding exclusive CPUs via partition_xcpus_add()
> - Managing remote sibling relationships
> - Synchronizing effective exclusive CPUs mask
> - Updating partition state and error status
> - Triggering required scheduler domain rebuilds
>
> This creates a coherent interface for partition operations and establishes
> a foundation for future local partition support while maintaining existing
> remote partition behavior.
>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>   kernel/cgroup/cpuset.c | 55 +++++++++++++++++++++++++++++++++---------
>   1 file changed, 44 insertions(+), 11 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 0787904321a9..43ce62f4959c 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1515,6 +1515,49 @@ static inline bool is_local_partition(struct cpuset *cs)
>   	return is_partition_valid(cs) && !is_remote_partition(cs);
>   }
>   
> +static void partition_state_update(struct cpuset *cs, int new_prs,
> +					  enum prs_errcode prs_err)
> +{
> +	lockdep_assert_held(&callback_lock);
> +
> +	cs->partition_root_state = new_prs;
> +	WRITE_ONCE(cs->prs_err, prs_err);
> +	if (!is_partition_valid(cs))
> +		reset_partition_data(cs);
> +}
> +
> +/**
> + * partition_enable - Transitions a cpuset to a partition root
> + * @cs: The cpuset to enable partition for
> + * @parent: Parent cpuset of @cs, NULL for remote parent
> + * @new_prs: New partition root state to set
> + * @new_excpus: New exclusive CPUs mask for the partition
> + *
> + * Transitions a cpuset to a partition root, only for v2.
> + */
> +static void partition_enable(struct cpuset *cs, struct cpuset *parent,
> +				 int new_prs, struct cpumask *new_excpus)
> +{
> +	bool isolcpus_updated;
> +
> +	lockdep_assert_held(&cpuset_mutex);
> +	WARN_ON_ONCE(new_prs <= 0);
> +	WARN_ON_ONCE(!cpuset_v2());
> +
> +	if (cs->partition_root_state == new_prs)
> +		return;
> +
> +	spin_lock_irq(&callback_lock);
> +	/* enable partition should only add exclusive cpus */
> +	isolcpus_updated = partition_xcpus_add(new_prs, parent, new_excpus);
> +	list_add(&cs->remote_sibling, &remote_children);
> +	cpumask_copy(cs->effective_xcpus, new_excpus);
> +	partition_state_update(cs, new_prs, PERR_NONE);
> +	spin_unlock_irq(&callback_lock);
> +	update_unbound_workqueue_cpumask(isolcpus_updated);
> +	cpuset_force_rebuild();
> +}
> +
partition_enable() is supposed to be a common helper used for the 
creation of both local and remote partitions. The one in this patch does 
work for remote partition but not for local partition. I would prefer to 
make it good for both cases when you introduce it instead adding code in 
patch 6 to make it work for local partition later in the series. It will 
make it easier to review instead of jumping back and forth to make sure 
that it will do the right thing.

Cheers,
Longman



