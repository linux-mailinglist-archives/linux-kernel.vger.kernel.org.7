Return-Path: <linux-kernel+bounces-883693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E39AC2E20E
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 22:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E4251895D7C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 21:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1253F1DFF7;
	Mon,  3 Nov 2025 21:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FC7Flu7f";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="HHhICV/m"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA57D191F84
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 21:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762204673; cv=none; b=SN+NN90ydjvANlhxyB8cY9JDNMdEvvywFEbcv5q67vqogl3jIJSVxNMpiSM1EnkaEsmz64SCCCTi/iHa5hhrgMLcTmlqDJP+ANfuIK5hAMsIzHIcx3R9zaD8+3PLOnujdHb95kFDC5KWgUKxQrY4hUopX8uOZPyag+Bd2BMnYuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762204673; c=relaxed/simple;
	bh=9J6yqex/gZJKgynTDeP/ehjjvv0k/x/9/xKD0WVfO6M=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=O1vqXP4B6hoeTv2ycgAPUcw5uKdOAaO2NOgVsBZ/T7NVQqR1t/h4V5Zn67CJloCvNfkmt56+fObaV0SJSWLu9+/3Z2KhZ5x+9BYZ+TceW7TYEg8a8E9j6nmdnX1GUTzb/seWcMgQZIoARQrVgc3s8amoj490Ig4LG70VzZngw3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FC7Flu7f; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=HHhICV/m; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762204670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=USFRuarN2DDmZ60WTQmY9vNchaKY1eZd7PSTZA30xy4=;
	b=FC7Flu7fT4XTNWrn+QSNSlz5z/vOvmFRFWnWipMTvbP86Fk0Oym2WVuLa55qhyAZX6+6Hc
	o/8XIkh1eMCTUeVsmC6NgJmg1GMxQBJfUKpH3eTX+cBPvvRdL977GheGs3DC2CJa9DbByn
	33Hb7VYHMCD2pYmp0jaCfPKF6pkS2GA=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-CEJ5yb5FOK6hiVsm5xScQQ-1; Mon, 03 Nov 2025 16:17:49 -0500
X-MC-Unique: CEJ5yb5FOK6hiVsm5xScQQ-1
X-Mimecast-MFC-AGG-ID: CEJ5yb5FOK6hiVsm5xScQQ_1762204669
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-88050bdc2abso51662466d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 13:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762204669; x=1762809469; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=USFRuarN2DDmZ60WTQmY9vNchaKY1eZd7PSTZA30xy4=;
        b=HHhICV/mZugNvZAhp4YGr0oPkX6jqBwBQXpdxOWTWasceUFxwc04r3BziL1B0FStzb
         6VOfX4KJRr4UDf3nF9rv2dSYipLcFJ7haweuVaQPAkvxON1zpbjgEV9yT1hqlKMGa1jy
         UAGgp3UrpTT/24SfVk9qcRdmpgWxG3XoQ18+0a+b9yCDDao4toDed17qMpS7qdYLe4SW
         Fct6UxL+RlyUqKOZ4tfgBX//hPCqCbGIiutgnJetWRGrypzeD3JIX8v+tQ1NiGxQlQCw
         Xbxgl5yyCOOQf/ywk+JM6SJ2GeXfCgKtZF+hmyD3L07Q9HlPaCKD+/y9afeZNz2VbCAR
         IP4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762204669; x=1762809469;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=USFRuarN2DDmZ60WTQmY9vNchaKY1eZd7PSTZA30xy4=;
        b=jlv4QOSRrz0yodctlV53M9F4tR+yA1Ng29rGvkxEooP5irSPGTEjahb1Bg+/flYKmL
         ExQWFzSpDvQHieXI2V6pYV10FvPmc22lJLqy/2kPUnSrNHHume0CIBsp+5laRqsZMZan
         i7Aj8NBVA/toFrqHSGAo4Ynq9RAQYZtbxeJwpXSjJkrNPWhjvp2BeOIWHUjzzYrRKzLm
         JK7cKc2fFVdwWPWOuKRba1Sou6MgYif/4ApvD/XpUawFq/wIHWoroh/pyW47VTFy9U2Q
         JdKIdAnIFTd07yeXuxEwlLaCEVh8iBf/LnQ/AH6HD+MXwZMaE6aIIsSDxsSRpNNqknHj
         hGHA==
X-Forwarded-Encrypted: i=1; AJvYcCXXNwXPlpduzhCa/njQtyaQUJvMICsPXkuqjan2N68Scsnyo4l9qbM54GyeUDgLnVaHlJtqC4pmcha/z8g=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz+Zw8RVb/1KZu+tPVZ74Z9Wa3/vRGyCvnzgGij0HvAb1FPQjO
	glAXqs/u3QbZWhRBd4fY0wuR9wIfV/P0hxu3zWYJYril7zSGSaMDLpCEGlLILKncUQVPToH6B5I
	VbwqT5zcIsVjeGpIlboYjm8MTvq7kWXnM2EOA8+2q4qqfX1MQ2Db6aE+CQsGS/pkNug==
X-Gm-Gg: ASbGncsXqQHOrK6ifp7KlVNUo5XsQukLAA/7+hzon9zjNoZOgQlCd0KXMHKm3zIazYv
	hUY8rZPusHpcg/pIIdcHbf4VZ718XeGLUo3Jks1LK97SrZUfV2e31ZjpcabG6j7YddpBroP8nao
	MsuMDpKbCE6TW/J2HpjqpgQfiSmVmf1muFHKadlSY+z0niDKWvz2sPRx3Y5gWSxo5SOyfR70G+A
	AtCoeaXq2AS6osX6WFxOB5ieejFYr3tU0StyWUszjSaJtqbzKGcLgIsUTcnltMn8GkwjbIpDuJi
	EGVQTX7IXXdSbgoYPH4s5pKPdvvy/nIfnBBvx7TC81XxlwQesuI1NLu9MMw4MQ+HBFihrRP1r74
	25R3hokONqC1TsO49JWUH527s/mg4eMSQ2lxOf7eOtsUBEQ==
X-Received: by 2002:ad4:5ec6:0:b0:880:4695:4640 with SMTP id 6a1803df08f44-88046954d60mr135727206d6.28.1762204668858;
        Mon, 03 Nov 2025 13:17:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGgiWHmeJStIAjhdNz7B69Q+dc+3OAFuWf7GDRnU1qJuTYKxeQ4SiuLMWhQY8veT2nqDtzHrg==
X-Received: by 2002:ad4:5ec6:0:b0:880:4695:4640 with SMTP id 6a1803df08f44-88046954d60mr135726836d6.28.1762204668454;
        Mon, 03 Nov 2025 13:17:48 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88060db5a9esm9423726d6.1.2025.11.03.13.17.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 13:17:47 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <6911f3c8-dcef-444f-bea2-d6bb247563d9@redhat.com>
Date: Mon, 3 Nov 2025 16:17:46 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cgroup/for-6.19 PATCH 3/3] cgroup/cpuset: Globally track
 isolated_cpus update
To: Chen Ridong <chenridong@huaweicloud.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 Chen Ridong <chenridong@huawei.com>, Gabriele Monaco <gmonaco@redhat.com>,
 Frederic Weisbecker <frederic@kernel.org>
References: <20251103013411.239610-1-longman@redhat.com>
 <20251103013411.239610-4-longman@redhat.com>
 <ffe1d7ec-70fc-44cd-879c-23902929a24a@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <ffe1d7ec-70fc-44cd-879c-23902929a24a@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 11/3/25 1:46 AM, Chen Ridong wrote:
>
> On 2025/11/3 9:34, Waiman Long wrote:
>> The current cpuset code passes a local isolcpus_updated flag around in a
>> number of functions to determine if external isolation related cpumasks
>> like wq_unbound_cpumask should be updated. It is a bit cumbersome and
>> makes the code more complex. Simplify the code by using a global boolean
> Agree.
>
>> flag "isolated_cpus_updating" to track this. This flag will be set in
>> isolated_cpus_update() and cleared in update_isolation_cpumasks().
>>
>> No functional change is expected.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   kernel/cgroup/cpuset.c | 74 ++++++++++++++++++++----------------------
>>   1 file changed, 35 insertions(+), 39 deletions(-)
>>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index d6d459c95d82..406a1c3789f5 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -81,6 +81,13 @@ static cpumask_var_t	subpartitions_cpus;
>>    */
>>   static cpumask_var_t	isolated_cpus;
>>   
> Is isolated_cpus protected by cpuset_mutex or callback_lock?
>
> If isolated_cpus is indeed protected by cpuset_mutex, perhaps we can move the update of
> isolated_cpus outside the critical section of callback_lock. This would allow us to call
> update_isolation_cpumasks in isolated_cpus_update, making the isolated_cpus_updating variable
> unnecessary. Reducing a global variable would be beneficial.

isolated_cpus is a user visible cpumask. So I would like to protect it 
with both cpuset_mutex and callback_lock like the other user visible 
cpumasks.


>
>> +/*
>> + * isolated_cpus updating flag (protected by cpuset_mutex)
>> + * Set if isolated_cpus is going to be updated in the current
>> + * cpuset_mutex crtical section.
>> + */
>> +static bool isolated_cpus_updating;
>> +
>>   /*
>>    * Housekeeping (HK_TYPE_DOMAIN) CPUs at boot
>>    */
>> @@ -1327,13 +1334,14 @@ static void isolated_cpus_update(int old_prs, int new_prs, struct cpumask *xcpus
>>   		cpumask_or(isolated_cpus, isolated_cpus, xcpus);
>>   	else
>>   		cpumask_andnot(isolated_cpus, isolated_cpus, xcpus);
>> +
>> +	isolated_cpus_updating = true;
>>   }
>>   
>>   /*
>>    * isolated_cpus_should_update - Returns if the isolated_cpus mask needs update
>>    * @prs: new or old partition_root_state
>>    * @parent: parent cpuset
>> - * Return: true if isolated_cpus needs modification, false otherwise
>>    */
>>   static bool isolated_cpus_should_update(int prs, struct cpuset *parent)
>>   {
>> @@ -1347,15 +1355,12 @@ static bool isolated_cpus_should_update(int prs, struct cpuset *parent)
>>    * @new_prs: new partition_root_state
>>    * @parent: parent cpuset
>>    * @xcpus: exclusive CPUs to be added
>> - * Return: true if isolated_cpus modified, false otherwise
>>    *
>>    * Remote partition if parent == NULL
>>    */
>> -static bool partition_xcpus_add(int new_prs, struct cpuset *parent,
>> +static void partition_xcpus_add(int new_prs, struct cpuset *parent,
>>   				struct cpumask *xcpus)
>>   {
>> -	bool isolcpus_updated;
>> -
>>   	WARN_ON_ONCE(new_prs < 0);
>>   	lockdep_assert_held(&callback_lock);
>>   	if (!parent)
>> @@ -1365,13 +1370,11 @@ static bool partition_xcpus_add(int new_prs, struct cpuset *parent,
>>   	if (parent == &top_cpuset)
>>   		cpumask_or(subpartitions_cpus, subpartitions_cpus, xcpus);
>>   
>> -	isolcpus_updated = (new_prs != parent->partition_root_state);
>> -	if (isolcpus_updated)
>> +	if (new_prs != parent->partition_root_state)
> Can this if statement be replaced with new helper isolated_cpus_should_update？

The isolated_cpus_should_update() helper is for validating the change. 
It is too late to call in partition_xcpus_add/del().

Cheers, Longman



