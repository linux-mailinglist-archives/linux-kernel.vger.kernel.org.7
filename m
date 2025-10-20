Return-Path: <linux-kernel+bounces-861646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C92BF3406
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 21:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 064654FC952
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 19:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3422F12D6;
	Mon, 20 Oct 2025 19:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XOgBwqhZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A41827AC31
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 19:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760989350; cv=none; b=jzX6Ggn7RLz+LHoEczgE1pE0LrsuPMl2S5u7Ecb3NJWToxNWFuKiO4mACZ7c9CqeXtBfPSqdl5LauS+BjpOPE8hRLJNVtPoIlJOQCur3cTugiuMyAXllluBUmfDyHZSYPi4HsUrQh6J33/K20DiJoI/Ndo5u1ueCZGGg2QrBjsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760989350; c=relaxed/simple;
	bh=Ztw6Vg3yxEBGSCGxY69MHUAEyG+LUvQQcv47RkuBdYU=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ScLw8R7SgWCvTJ7cTrHy08q2PjFCMvVYgNYcu3PLxGBCWxqnGJPAYRys/y6uJOsPTeVFnPOo0NvehILL7X5dle5cJ8ktiAhblpAK5tnlk51PB1Sa6shnRsp219Zz3uZ1p9MvxQEU27WAVAIS3vq73ucNMcBMJII1l+erSLiea9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XOgBwqhZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760989347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a6g3XqFbLunJWKjBLqSAOthKCe1NOTnQPQLUs+XNm8A=;
	b=XOgBwqhZrbyGw4WpYizy3xuosTUtSFZn0m/tKPiG8S3aPewFJnNLTNYCEQasUeCbwuXXTM
	wgOF1QonH9CAj1B5VVkQC77dm4TtfL7nHIs7hlKT0+w65PkesY0seyJxMyKowmiHTjIobM
	ETcmcjSnqw+fE4dN9MiJm6VXVauqJ+k=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602-j3RMlJYCMDO0IF3Vqecatg-1; Mon, 20 Oct 2025 15:42:26 -0400
X-MC-Unique: j3RMlJYCMDO0IF3Vqecatg-1
X-Mimecast-MFC-AGG-ID: j3RMlJYCMDO0IF3Vqecatg_1760989345
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b6a793619b2so1407738a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 12:42:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760989344; x=1761594144;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a6g3XqFbLunJWKjBLqSAOthKCe1NOTnQPQLUs+XNm8A=;
        b=rXHDaSapgR3I3ObGwhYdyH0oiyPUJANLf3vxsUMhzLyPC00kLZkhQMwKTCue2AZCm+
         KK7DcJl45yG3cnLfVe01uTNLEhHJWJC1rU0vl+VhA2Lin0HQuFQtrfwd338rc4WBifEo
         O5CdUy4MjrtG6o8U+Fyngvkp3WPhZpyBegZBx6VWBuG749BbHPepOU/MqyHLALPOxNL1
         VrB27vPncZXDEUGb9WiNM6bLR2d/zbE74OzY18I+USxTFfCTgySBBLSsOdwuBv8BisNU
         oY6+qkCo6y36JbBRZbUKcGGPbwvatuZKb76ap9CATuQZBgSQRTz0hVUIlaxq0XM8eaA5
         G2RA==
X-Forwarded-Encrypted: i=1; AJvYcCUzlEM1bXtz+ACCcPcRg3pMMRniOtAv7BNNbpzrKdOYmPx50eanEHzb0veZ8MafJaEc9w1GLq4MBrt/c/g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6r+hJldfCOyNxP6TH63NphlHRAivKsKRkS3Yz25CcIl7Nh29f
	1Ru/wWtsZbsMRn0kVR1YxxR9cP3WUroS6p9fj2P6fda7U++ORXbWC8rwwjRmolaPGIw3zCcfoTF
	skQ1bjTpV8iyji3E2/WXRzNTd6k8juPJDsQutPIpHSIrvzoq6cgz/bR/R0bawjbs29g/3w/MgFw
	==
X-Gm-Gg: ASbGnct7oWKl5bmOZCWc775gvLmWZwqaRh1F/OU0ZUdRz4f1H3uhog2yOTAitxeAIy2
	4G1feT3C3W350OLHas/4aJKbXLk056bxLiOJDM7ZXF16O6vbiZdXUrjbGXuiG4p2W6ie4nVA+0P
	eKRzqGTOcWijQxD8m8MjBa6vttf8VyCwuSjch3+6aoknUJoOoiiSwTRy5tAxbwLt+bNN7CYtbnt
	GSK7gh4Ax7hPbFdxXQBgnMg30rtc1/j1PqK6Y4X7SgvSjnhuOWyo6g11uYibG1gSet/VE4qRe6v
	kB398o0g5KrUSPJYoplIJdVcCJ7aW4/D9FIci8L0E4h8lYBMivaSYql530sJSZgNyuecAukmzrl
	ygpr6hRdNpu9rv2ZoLwK/+uGlw8v7dkUSnOeqooDn5aJN5Q==
X-Received: by 2002:a17:902:f70e:b0:267:912b:2b36 with SMTP id d9443c01a7336-290c740004bmr156554755ad.23.1760989344513;
        Mon, 20 Oct 2025 12:42:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRWFk1AZqstaY8GO1xjmBy3mYMSjCJ/Vl8njIHQS7mPY1BPP47SjE6229biJif3Mo6uDRSmA==
X-Received: by 2002:a17:902:f70e:b0:267:912b:2b36 with SMTP id d9443c01a7336-290c740004bmr156554425ad.23.1760989343966;
        Mon, 20 Oct 2025 12:42:23 -0700 (PDT)
Received: from ?IPV6:2601:600:947f:f020:85dc:d2b2:c5ee:e3c4? ([2601:600:947f:f020:85dc:d2b2:c5ee:e3c4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471d5971sm87457045ad.56.2025.10.20.12.42.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 12:42:23 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <e8018984-96ed-49fa-8571-79a0d39cb218@redhat.com>
Date: Mon, 20 Oct 2025 15:42:22 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next RFC 03/16] cpuset: factor out partition_enable()
 function
To: Chen Ridong <chenridong@huaweicloud.com>, Waiman Long <llong@redhat.com>,
 tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20250928071306.3797436-1-chenridong@huaweicloud.com>
 <20250928071306.3797436-4-chenridong@huaweicloud.com>
 <9168ffab-b0a8-4024-a1f4-966b9f95c953@redhat.com>
 <fa7fa2e5-c602-4318-90e1-89c742c6cc1a@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <fa7fa2e5-c602-4318-90e1-89c742c6cc1a@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/20/25 3:48 AM, Chen Ridong wrote:
>
> On 2025/10/20 10:39, Waiman Long wrote:
>> On 9/28/25 3:12 AM, Chen Ridong wrote:
>>> From: Chen Ridong <chenridong@huawei.com>
>>>
>>> Extract the core partition enablement logic into a dedicated
>>> partition_enable() function. This refactoring centralizes updates to key
>>> cpuset data structures including remote_sibling, effective_xcpus,
>>> partition_root_state, and prs_err.
>>>
>>> The function handles the complete partition enablement workflow:
>>> - Adding exclusive CPUs via partition_xcpus_add()
>>> - Managing remote sibling relationships
>>> - Synchronizing effective exclusive CPUs mask
>>> - Updating partition state and error status
>>> - Triggering required scheduler domain rebuilds
>>>
>>> This creates a coherent interface for partition operations and establishes
>>> a foundation for future local partition support while maintaining existing
>>> remote partition behavior.
>>>
>>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>>> ---
>>>    kernel/cgroup/cpuset.c | 55 +++++++++++++++++++++++++++++++++---------
>>>    1 file changed, 44 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>>> index 0787904321a9..43ce62f4959c 100644
>>> --- a/kernel/cgroup/cpuset.c
>>> +++ b/kernel/cgroup/cpuset.c
>>> @@ -1515,6 +1515,49 @@ static inline bool is_local_partition(struct cpuset *cs)
>>>        return is_partition_valid(cs) && !is_remote_partition(cs);
>>>    }
>>>    +static void partition_state_update(struct cpuset *cs, int new_prs,
>>> +                      enum prs_errcode prs_err)
>>> +{
>>> +    lockdep_assert_held(&callback_lock);
>>> +
>>> +    cs->partition_root_state = new_prs;
>>> +    WRITE_ONCE(cs->prs_err, prs_err);
>>> +    if (!is_partition_valid(cs))
>>> +        reset_partition_data(cs);
>>> +}
>>> +
>>> +/**
>>> + * partition_enable - Transitions a cpuset to a partition root
>>> + * @cs: The cpuset to enable partition for
>>> + * @parent: Parent cpuset of @cs, NULL for remote parent
>>> + * @new_prs: New partition root state to set
>>> + * @new_excpus: New exclusive CPUs mask for the partition
>>> + *
>>> + * Transitions a cpuset to a partition root, only for v2.
>>> + */
>>> +static void partition_enable(struct cpuset *cs, struct cpuset *parent,
>>> +                 int new_prs, struct cpumask *new_excpus)
>>> +{
>>> +    bool isolcpus_updated;
>>> +
>>> +    lockdep_assert_held(&cpuset_mutex);
>>> +    WARN_ON_ONCE(new_prs <= 0);
>>> +    WARN_ON_ONCE(!cpuset_v2());
>>> +
>>> +    if (cs->partition_root_state == new_prs)
>>> +        return;
>>> +
>>> +    spin_lock_irq(&callback_lock);
>>> +    /* enable partition should only add exclusive cpus */
>>> +    isolcpus_updated = partition_xcpus_add(new_prs, parent, new_excpus);
>>> +    list_add(&cs->remote_sibling, &remote_children);
>>> +    cpumask_copy(cs->effective_xcpus, new_excpus);
>>> +    partition_state_update(cs, new_prs, PERR_NONE);
>>> +    spin_unlock_irq(&callback_lock);
>>> +    update_unbound_workqueue_cpumask(isolcpus_updated);
>>> +    cpuset_force_rebuild();
>>> +}
>>> +
>> partition_enable() is supposed to be a common helper used for the creation of both local and remote
>> partitions. The one in this patch does work for remote partition but not for local partition. I
>> would prefer to make it good for both cases when you introduce it instead adding code in patch 6 to
>> make it work for local partition later in the series. It will make it easier to review instead of
>> jumping back and forth to make sure that it will do the right thing.
>>
>> Cheers,
>> Longman
>>
> Thank you, Longman.
>
> My original intention was to keep the changes easier to review. Patches 3–5 are meant to be pure
> refactoring moves of code from the remote partition logic, without altering any behavior.
>
> Would it be clearer to proceed in the following stages:
>
> 1. Introduce partition_enable(), partition_disable(), and partition_update() with their complete
> logic first.
> 2. Replace the corresponding logic in remote partitions with these new helpers.
> 3. Then, replace the logic in local partitions with the same helpers.
>
Yes, that should make it easier to review.

Thanks,
Longman


