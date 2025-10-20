Return-Path: <linux-kernel+bounces-861655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 072A3BF343F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 21:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8994318C3846
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 19:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7B2331A6A;
	Mon, 20 Oct 2025 19:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ebBx/mFj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872AB23A9AC
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 19:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760989531; cv=none; b=cG8B+dbb8ESqE9gS54OH80iUNL2i5IzwHpVheVYg9CSRh9oeV9ebgv6xa+cY46ycHpTjaj+hNunwWLldEfa4B3lGegnQuPGFxiYm9ApVpgvfP2Z8Voq+wgbEZj5/gA+FxOe5zfZF4yBPMaWzWa5YeV9Se5d5PgQjLsShamtX9G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760989531; c=relaxed/simple;
	bh=nXCjMi2Yq8GgzphVfEblLdFRVUETUkxaBsRDMXkKJpQ=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=MGWrrGvDo26I7/+6pb9U8jIP1K/z/lfrSKSl+eWPIvVbZURakVqIZ+60foyYh6K4Ef1KPS+hqeDDanRVSPk2MPW7WeIJsfgUtRuZ9XAgwozKwZ8vPqlSLhYw6ZatmSGfB4v6w9GWpA+XI89Oxg01UnPY8uOjAHkLC7pTW+l2w50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ebBx/mFj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760989528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MSc4SPvE5zlV2jSt01m+Rve1DxerwKjZK+NG8BwSKVA=;
	b=ebBx/mFj3FikF838cXH7/eralDHiESQgTZJQL8wtx9+FqKalopEo3OhC7lETkLRB4qGc+c
	KRTtZOE/dTrG7TJU97JUS+4s3FFc4x3849RnKBHyqhpEllGylNTRDbig60ygH6126F+OKM
	nEEgGRCcrZBfRckb/EHO5K8YYZVLcVY=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-KDmzYORCMHWW1R_k_wgo7A-1; Mon, 20 Oct 2025 15:45:27 -0400
X-MC-Unique: KDmzYORCMHWW1R_k_wgo7A-1
X-Mimecast-MFC-AGG-ID: KDmzYORCMHWW1R_k_wgo7A_1760989526
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-32ee62ed6beso8182843a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 12:45:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760989526; x=1761594326;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MSc4SPvE5zlV2jSt01m+Rve1DxerwKjZK+NG8BwSKVA=;
        b=l3Wu81YKBXDc51M1/ozv4KyFHsjOYAiwjRY0etkwq/3f8u1PO9okHpTzbIySFwMSaD
         qawSWFUjs58ms+sH8tzw/4pHklnihlLx9r9IosgfHP7Wz7/pCH51BlBd4qNXzxnQgx7I
         onRM8Xyt8DgtxUL3O9qJtUHK75Row1cjBEyTlNHbWgvXYqSzECuO1AjwHMBXqfwsi02H
         Fo3swaUWIodj4x7lhZ1FD/xkO7YXNXmjmGWRg645RTuU+07HKrxkHaMYAGV4WkAMSRam
         NIrG58skQjkmWKa5i7EmZRBFW/put1lznt9rLXU69rYTLHgcHhOL8RqZ1PGisY6AzCWE
         UDQA==
X-Forwarded-Encrypted: i=1; AJvYcCUyNvcUnReBcNY3P9hrVKMM54vOxQWjnmVOvi6gH/QdUT+EypH0liEzUOibufsfFDawFEogcFgRfygzDjU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjeg4TCzs6nODQYFIGh9WVi5sH4My1MO9DHrPZdwBx49kuJLNH
	7+Nssa5VjzUOg4z3v5Rm4gtZlxyc19d7C3txRcQ+tZFT7TzmoMtYrSJlFELVpkzTTRmYhPgxpVq
	Ls9tfOEzfVlhk3BI6LnifA1TCDR6kkmCXMEKKCHtQzTfoUrVP6cGlngKxOvT+IZwyaQ==
X-Gm-Gg: ASbGnct/aqUbyvxD/0FxWQ9CfglftJcl+F+aQpJAD9Zq6FJzPnyLTk/xOSi075RjONq
	9OYP7HS014j/hmuNwY9iQFmxoMMxIt3p3reF7B34pRTazK5xwsg2nvQapql/Lu8aoqm2z/GQqiK
	GLrB5QsAOSkRpcLP4wZ83tW75vu2ZPkt8Ez2pxY111ZuMC3txEUQLOQeYEwcouqHMEHtW8Hzvin
	U0CtKT+uv1v2r9DddxdBjYIsBVewqj1FZA2OVNryYVlWl4OJOhuSGOFv1vPpkW+VuFsc9gD2dxY
	K1BAsVh4fgcbsb+kOs5+OP//ndvWPuaD4uesiGPsAb8La4kp4kXuHmQONhUvT+J0EZuzlV0dluF
	u49MAU1jGGPowXU1Uc+sOIRnzSx0E2wH0Bisl/3oFpt3dDA==
X-Received: by 2002:a17:90b:3a8a:b0:33b:ae39:c297 with SMTP id 98e67ed59e1d1-33bcf8a9ee7mr20255577a91.16.1760989525812;
        Mon, 20 Oct 2025 12:45:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFaoPQHglXlR88zFvEFnxyPtsTWfFWtKzd84I842h6iBrZVmeZMFfG82zyNf9mI8kr7gERWHw==
X-Received: by 2002:a17:90b:3a8a:b0:33b:ae39:c297 with SMTP id 98e67ed59e1d1-33bcf8a9ee7mr20255541a91.16.1760989525315;
        Mon, 20 Oct 2025 12:45:25 -0700 (PDT)
Received: from ?IPV6:2601:600:947f:f020:85dc:d2b2:c5ee:e3c4? ([2601:600:947f:f020:85dc:d2b2:c5ee:e3c4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33d5ddf1209sm8784439a91.5.2025.10.20.12.45.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 12:45:24 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <649eeb65-8872-4b52-aef9-d61cd282c7ed@redhat.com>
Date: Mon, 20 Oct 2025 15:45:24 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next RFC 05/16] cpuset: factor out partition_update()
 function
To: Chen Ridong <chenridong@huaweicloud.com>, Waiman Long <llong@redhat.com>,
 tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20250928071306.3797436-1-chenridong@huaweicloud.com>
 <20250928071306.3797436-6-chenridong@huaweicloud.com>
 <6122ac29-3984-4364-ab37-4987b65b5450@redhat.com>
 <155a2703-e43e-41f7-bb91-2936f89c29e2@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <155a2703-e43e-41f7-bb91-2936f89c29e2@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/20/25 4:05 AM, Chen Ridong wrote:
>
> On 2025/10/20 10:43, Waiman Long wrote:
>> On 9/28/25 3:12 AM, Chen Ridong wrote:
>>> From: Chen Ridong <chenridong@huawei.com>
>>>
>>> Extract the core partition update logic into a dedicated partition_update()
>>> function. This refactoring centralizes updates to key cpuset data
>>> structures including remote_sibling, effective_xcpus, partition_root_state,
>>> and prs_err.
>>>
>>> The function handles the complete partition update workflow:
>>> - Adding and removing exclusive CPUs via partition_xcpus_add()/del()
>>> - Managing remote sibling relationships
>>> - Synchronizing effective exclusive CPUs mask
>>> - Updating partition state and error status
>>> - Triggering required system updates and workqueue synchronization
>>>
>>> This creates a coherent interface for partition operations and establishes
>>> a foundation for enhanced partition management while maintaining existing
>>> remote partition behavior.
>>>
>>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>>> ---
>>>    kernel/cgroup/cpuset.c | 71 ++++++++++++++++++++++++++++--------------
>>>    1 file changed, 47 insertions(+), 24 deletions(-)
>>>
>>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>>> index 1944410ae872..0e2f95daf459 100644
>>> --- a/kernel/cgroup/cpuset.c
>>> +++ b/kernel/cgroup/cpuset.c
>>> @@ -1587,6 +1587,49 @@ static void partition_disable(struct cpuset *cs, struct cpuset *parent,
>>>        cpuset_force_rebuild();
>>>    }
>>>    +/**
>>> + * partition_update - Update an existing partition configuration
>>> + * @cs: The cpuset to update
>>> + * @prs: Partition root state (must be positive)
>>> + * @xcpus: New exclusive CPUs mask for the partition (NULL to keep current)
>>> + * @excpus: New effective exclusive CPUs mask
>>> + * @tmp: Temporary masks
>>> + *
>>> + * Updates partition-related fields. The tmp->addmask is the CPU mask that
>>> + * will be added to the subpartitions_cpus and removed from parent's
>>> + * effective_cpus, and the tmp->delmask vice versa.
>>> + */
>>> +static void partition_update(struct cpuset *cs, int prs, struct cpumask *xcpus,
>>> +                  struct cpumask *excpus, struct tmpmasks *tmp)
>>> +{
>>> +    bool isolcpus_updated;
>>> +    bool excl_updated;
>>> +    struct cpuset *parent;
>>> +
>>> +    lockdep_assert_held(&cpuset_mutex);
>>> +    WARN_ON_ONCE(!cpuset_v2());
>>> +    WARN_ON_ONCE(prs <= 0);
>>> +
>>> +    parent = is_remote_partition(cs) ? NULL : parent_cs(cs);
>>> +    excl_updated = !cpumask_empty(tmp->addmask) ||
>>> +            !cpumask_empty(tmp->delmask);
>>> +
>>> +    spin_lock_irq(&callback_lock);
>>> +    isolcpus_updated = partition_xcpus_add(prs, parent, tmp->addmask);
>>> +    isolcpus_updated |= partition_xcpus_del(prs, parent, tmp->delmask);
>> The current partition_xcpus_add/del() functions assume the given cpumas is non-empty. In the new
>> partition_update() helper, you can pass an empty cpumask to them. This will cause useless work to be
>> done. Also isolcpus_update may not be correct because of that causing unneeded work to be done in
>> the workqueue code.
>>
>> -Longman
> Thank you, Longman.
>
> I think we can add a check for empty cpumask inputs in partition_xcpus_add() and
> partition_xcpus_del() to avoid unnecessary operations.
Yes, you should do an empty cpumask check if empty cpumask can be passed 
to the helper.
>
> To clarify, do you mean that passing an empty cpumask to these functions might lead to incorrect
> isolcpus_updated value? or are you referring to other potential logic issues?

My main concern is doing non-useful work. However, I am sure if there 
will be an undesirable side effects as well.

Cheers,
Longman


