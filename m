Return-Path: <linux-kernel+bounces-796618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5CB0B403C6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 15:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80EAD168DEB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 13:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA08324B1B;
	Tue,  2 Sep 2025 13:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OdPBgfN9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E749C322C78
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 13:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756819826; cv=none; b=bNQ8bFK0eZy8gmT7U/EMHXHjc7OWNxDb7yfSNGN1sdSdhuHN3LyrrjhLMxd8rFpFNNU6zRJVPqJXuEzUuIGvj++1PHWCRaE18Wd1HkUaVZHlbUgIVSXsGk6ElL47ownMVm7QS6z3dYSwXxH8hz8IRHbkxJ7HttTmwsgCSQohC/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756819826; c=relaxed/simple;
	bh=g3sifc9TW5tsJF8SxDzkpDMgfvwIfT1Q5I/5Dy+fJ6I=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ckp0G8fklsI12YfaHB1nEVFXHCfXWnSvUwWO6vk15RDsTmhYlH0pNB9g7NmY8BlvfgrlLrtWE4zzG2UW6yrdz9KHB8I4CYdVzrMuwwg7YMDlpA8DIaBwvBFAdxlA/cP9M5Fn03+uJ46ZM9RelKklJKuXA+Y5c88P+Nia3jMCeLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OdPBgfN9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756819823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b5rIBDXadKc0Riamv/Bxc9wrw9KFcdiEe2g6YluW24E=;
	b=OdPBgfN9I/EFhTp2W8586Pc7bnwwha1vELjsaNjJGZVc4qdvYkYCqqgDGSVPe0Rhrg8nRo
	DIpIuYE4XBKx2YRDcz/1OZfhedS2iaxrc3j8gVac0MTwMzevMq1dOFLOCr5SOoYixYAfgb
	HnV02jCO6F4Py4GfcMGMnYbNT4V58Hw=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-Zs0ZVPOTMeCuSofHqbcQoA-1; Tue, 02 Sep 2025 09:30:20 -0400
X-MC-Unique: Zs0ZVPOTMeCuSofHqbcQoA-1
X-Mimecast-MFC-AGG-ID: Zs0ZVPOTMeCuSofHqbcQoA_1756819820
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b33e8943e3so21658901cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 06:30:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756819820; x=1757424620;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b5rIBDXadKc0Riamv/Bxc9wrw9KFcdiEe2g6YluW24E=;
        b=p1ReOZf2QPm9oGrvZZfW9YrqkIvYOC1GzdMqm3L6UFXWj7/JI+Qftvua3It/78Ft6o
         sRh+pp9Wy+vPBr8S6H4T70ZXi4OGj6S3aqoHnCpAoqhPBBg1mNF5ZEzMWSd5RxdG/np0
         dMDt88Gee4IGBCnNB/U05sO2aj91jWJ46dkU6BiP6esvrbFJphMPcCya9/Qbarkdj8w/
         e2rl2Eol4jQYp6LkPw0IrlFMET3Vvn1fmi7wYRtS2u6NxoUs9uWhzRIPZsh7Qp9gpTCk
         33ew21JQ+w4L7jUNUZmtzjJDGsEPPHuAEirXSm83BK8gdAlq0nEVk1cbIb/Fc6P4+kHI
         TF1A==
X-Forwarded-Encrypted: i=1; AJvYcCXfp7f9HJLX9/rSzLj6FcG1FUjSi8EJ/mWiJEkWDtylW/2w3wshVfrt7ty5gJlM9Ho79Nbfe18fPi4vAjg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhvIbKDlQaFb6RBq78j+wD15ao9ea/dRIfLEuRpGWGhUTssQUr
	RCayKK6zXlYm3QnYUfaW3nm6A4zBjfggPVQcRLNUpc5PGmJvRy7nbZr9e12em4NzbjN4qzX+DOO
	p0/rCWH4aRgBf9yq9ibQvownivZ+niRWxkDYlsAPmkrCcjexba1l47WGXbFldo6UnTA==
X-Gm-Gg: ASbGncs92ld1fiZGeSVpglBVcYlvozIylIysZ2DyLENNsBv2iYV1CsNv92/iEoG6lhr
	S5UT7MqsHtdIChbO1U/fWheukTCYl4NTXt31K2B+il9wGm/FzJiwF8acmH5vQmwv1icm7d72PFl
	TZp225sTQov3jbSTMKYhTbNqNqk8rlvNFJOGOB5kqaYl2VNSC8GvLeYxgYcgQylwc1rdOKB4xt0
	WqPIDrnsPLs52m82RFUkEb/PPpGMeArWGbs8e/YQ2pbvVir1SV2SqABWoix+YlETnusrpnmH04L
	Y2LiM2Tt896I3DZWFpDTq4XrUd8AFUa+0Dgp41DnWhumMS/31XOVhFDyoH3BneMMPqAcL8P0QMK
	S5djhGjMvAw==
X-Received: by 2002:a05:622a:5443:b0:4b3:4d20:2f6 with SMTP id d75a77b69052e-4b34d200c44mr11166261cf.19.1756819819626;
        Tue, 02 Sep 2025 06:30:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDYAIOyEc9Fw0i0zuOWxfALXYIKNMMLAs3fedzZX/lCIFNOzBsogoQf3qUBhtg2wrUl6dh1A==
X-Received: by 2002:a05:622a:5443:b0:4b3:4d20:2f6 with SMTP id d75a77b69052e-4b34d200c44mr11165501cf.19.1756819818750;
        Tue, 02 Sep 2025 06:30:18 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8069ccec9besm130589885a.53.2025.09.02.06.30.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 06:30:18 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <2a6759fa-841a-4185-ae94-b8215c93daf5@redhat.com>
Date: Tue, 2 Sep 2025 09:30:17 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next RFC 09/11] cpuset: refactor partition_cpus_change
To: Chen Ridong <chenridong@huaweicloud.com>, Waiman Long <llong@redhat.com>,
 tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20250828125631.1978176-1-chenridong@huaweicloud.com>
 <20250828125631.1978176-10-chenridong@huaweicloud.com>
 <632cd2ab-9803-4b84-8dd9-cd07fbe73c95@redhat.com>
 <031d83b6-bc67-4941-8c49-e1d12df74062@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <031d83b6-bc67-4941-8c49-e1d12df74062@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/29/25 10:01 PM, Chen Ridong wrote:
>
> On 2025/8/30 4:32, Waiman Long wrote:
>> On 8/28/25 8:56 AM, Chen Ridong wrote:
>>> From: Chen Ridong <chenridong@huawei.com>
>>>
>>> Refactor the partition_cpus_change function to handle both regular CPU
>>> set updates and exclusive CPU modifications, either of which may trigger
>>> partition state changes. This generalized function will also be utilized
>>> for exclusive CPU updates in subsequent patches.
>>>
>>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>>> ---
>>>    kernel/cgroup/cpuset.c | 59 ++++++++++++++++++++++++++----------------
>>>    1 file changed, 36 insertions(+), 23 deletions(-)
>>>
>>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>>> index 75ad18ab40ae..e3eb87a33b12 100644
>>> --- a/kernel/cgroup/cpuset.c
>>> +++ b/kernel/cgroup/cpuset.c
>>> @@ -2447,6 +2447,41 @@ static int acpus_validate_change(struct cpuset *cs, struct cpuset *trialcs,
>>>        return retval;
>>>    }
>>>    +/**
>>> + * partition_cpus_change - Handle partition state changes due to CPU mask updates
>>> + * @cs: The target cpuset being modified
>>> + * @trialcs: The trial cpuset containing proposed configuration changes
>>> + * @tmp: Temporary masks for intermediate calculations
>>> + *
>>> + * This function handles partition state transitions triggered by CPU mask changes.
>>> + * CPU modifications may cause a partition to be disabled or require state updates.
>>> + */
>>> +static void partition_cpus_change(struct cpuset *cs, struct cpuset *trialcs,
>>> +                    struct tmpmasks *tmp)
>>> +{
>>> +    if (cs_is_member(cs))
>>> +        return;
>>> +
>>> +    invalidate_cs_partition(trialcs);
>>> +    if (trialcs->prs_err)
>>> +        cs->prs_err = trialcs->prs_err;
>>> +
>>> +    if (is_remote_partition(cs)) {
>>> +        if (trialcs->prs_err)
>>> +            remote_partition_disable(cs, tmp);
>>> +        else
>>> +            remote_cpus_update(cs, trialcs->exclusive_cpus,
>>> +                       trialcs->effective_xcpus, tmp);
>>> +    } else {
>>> +        if (trialcs->prs_err)
>>> +            update_parent_effective_cpumask(cs, partcmd_invalidate,
>>> +                            NULL, tmp);
>>> +        else
>>> +            update_parent_effective_cpumask(cs, partcmd_update,
>>> +                            trialcs->effective_xcpus, tmp);
>>> +    }
>>> +}
>>> +
>>>    /**
>>>     * update_cpumask - update the cpus_allowed mask of a cpuset and all tasks in it
>>>     * @cs: the cpuset to consider
>>> @@ -2483,29 +2518,7 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
>>>         */
>>>        force = !cpumask_equal(cs->effective_xcpus, trialcs->effective_xcpus);
>>>    -    invalidate_cs_partition(trialcs);
>>> -    if (trialcs->prs_err)
>>> -        cs->prs_err = trialcs->prs_err;
>>> -
>>> -    if (is_partition_valid(cs) ||
>>> -       (is_partition_invalid(cs) && !trialcs->prs_err)) {
>>> -        struct cpumask *xcpus = trialcs->effective_xcpus;
>>> -
>>> -        if (cpumask_empty(xcpus) && is_partition_invalid(cs))
>>> -            xcpus = trialcs->cpus_allowed;
>> This if statement was added in commit 46c521bac592 ("cgroup/cpuset: Enable invalid to valid local
>> partition transition") that is missing in your new partition_cpus_change() function. Have you run
>> the test_cpuset_prs.sh selftest with a patched kernel to make sure that there is no test failure?
>>
>> Cheers,
>> Longman
> Thank you Longman,
>
> I did run the self-test for every patch, and I appreciate the test script test_cpuset_prs.sh you
> provided.
>
> The trialcs->effective_xcpus will be updated using compute_trialcs_excpus, which was introduced in
> Patch 4. The corresponding logic was then added in Patch 5:
>
> -	cpumask_and(excpus, user_xcpus(trialcs), parent->effective_xcpus);
> +	/* trialcs is member, cpuset.cpus has no impact to excpus */
> +	if (cs_is_member(cs))
> +		cpumask_and(excpus, trialcs->exclusive_cpus,
> +				parent->effective_xcpus);
> +	else
> +		cpumask_and(excpus, user_xcpus(trialcs), parent->effective_xcpus);
> +
>
> Therefore, as long as excpus is computed correctly, I believe this implementation can handle the
> scenario appropriately.

It will be helpful to put down a note in the commit log that the missing 
logic will be re-introduced in a subsequent patch.

Thanks,
Longman


