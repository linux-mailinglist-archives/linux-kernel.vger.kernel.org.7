Return-Path: <linux-kernel+bounces-765745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7F5B23DBB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 03:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29B221B62871
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 01:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E5A19F41C;
	Wed, 13 Aug 2025 01:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DRPDiH5k"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A7E17578
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 01:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755048828; cv=none; b=mhp7YxdVYNvfLltft0kzv5nV1NjEqff1HZPsUoKV60z56tolCZRO4+pA3oVoIU2083H+0MeoHhUbHM3vnmipDsopFtY2o2Ie8OV7XizeLXhqgzxL4zkAhEWbXxgAEHAuVlAXYJGUgCVbnFuEvSXDOiLsitWGGTuaVqF8CyBJocA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755048828; c=relaxed/simple;
	bh=amt9fQ+hzqhUzUaBuuFUSSschCXSCkytR0vGDT1aRso=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=APYGv7d3HsaT2mbwICdWZA5YbH2G2AKzSuiKUMes+5wyRkHYqL51kaunZsEnl5fL6MTKz8tfyQ0hjjypofFquzZGpTJQndYr3wkKM5hXHr+V1aW92QWhRWJgy5CJnriw6A6VwfJfs6NeYvMNNjn+Fz6rh1jfsJRQlaL9p1k3i+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DRPDiH5k; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755048824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SMkXgqdgmkLcM/jJiNxIyh4VhtxDGX3we5dKE2An65U=;
	b=DRPDiH5kAdOoAa0Nf0ytnU9VDzle7uCH7A07N3eQuIud0T3HDp4pWbbN08WiADz+VpKaaN
	GQAyPeTFQ1mv+Z3qPQfLDkUjMKufE6D/IR4qD5LEsTclmiThJpmJvvtm0pEVgF8TZxXSm8
	cn0gTMePIh4l1d4dXLdAPFKPoLW8o90=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-AU_puUWjNKOsyM-JjyU1ng-1; Tue, 12 Aug 2025 21:33:42 -0400
X-MC-Unique: AU_puUWjNKOsyM-JjyU1ng-1
X-Mimecast-MFC-AGG-ID: AU_puUWjNKOsyM-JjyU1ng_1755048822
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-70741fda996so109717546d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 18:33:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755048822; x=1755653622;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SMkXgqdgmkLcM/jJiNxIyh4VhtxDGX3we5dKE2An65U=;
        b=IgwhodnGIivYM6WWBbImjuL3ExyKWVAQuRBJ/pvTsQ66GsYtgiJ09JJvTbYNPYZSvb
         ud0O8XADQRpUqzQ34JsSLBPWeZr8WFqOgK4YEOtX3CIgUD/T3Y8Ke5XberJnjqa2stRj
         0/OPfrt28/BhaVSmijlWr3ZAIYxPsHcYtvw48IAthH54LkpGbWGmLZLRBpWH/OZjk25i
         FRUwbhSNXkAHqu63iAQTytuHXq+ryJrTGccQVx4FYzZdYUnmdJqlot2/LQjWeFqwVRIn
         3SEJsW8S8kLtTWFvslZsnZS8HAy9NaUaL2WI+dEw38q/flu/jqlnkfuGkz7rVc80tFvw
         2Dpg==
X-Forwarded-Encrypted: i=1; AJvYcCUhcmiKBOJE9H/3CHMPiMArb9p3Jorl37FE/7d6eF/UecrzItYToM6n1bsC0c8oUN0MKwEOde8ZxpxyQw8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl+CobSpRptZi6s4jQkk3jcIS5iOK7hF6YAv+8sbIz3ULn5Yao
	00Cjh/2YOBGwhvyMoj10H7piNhU4i5+/Rl+vejt/8nnU1D9dhKppA/p8Sg/KHyZvANLqysNmuK3
	Nj859lwgkkCfBWcpnDHIDXzRDwOEmJMU3VqvnvyDrQJfrPzwe/3fq2VzQX7pbSkdR6g==
X-Gm-Gg: ASbGncsssf4dQvVgj2CiQ5QBpOWgf2DwpdVs1ExvCdGffV/7hn7/k/Om9ZSbKibBtP3
	S4qtugAX6oiJiJI2mFlCmgZfocpqGY+1jPed8FC4bU9NDR+YdbPfXFkbJxwcsHBJTALEipiZvci
	nQEf8Otqcrn0tChqAqJC/9EM43rDLIF1WNoLjjcUgXs/l1onN6wgimtmPZDkwkiE8pmK/qsNptm
	NDcew2fQuNT0nqS+pFjJpd7kmrXOywiuwKIKlYNHYrvO4TdMe3/m9YpDh/z0RSMf9/YOEjdxnBG
	7FSaKOYJOI2JKEbc2CAPzf0SBkMa3dKNAhqL2KWGuI3tNSr0oBzDD8xgnpbHsyBjztQpX8h8pDi
	XcDhGCOllHw==
X-Received: by 2002:ad4:5aa7:0:b0:707:430e:dc00 with SMTP id 6a1803df08f44-709e899099emr19101386d6.39.1755048822246;
        Tue, 12 Aug 2025 18:33:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6sHvbCHj/mN3gkdBxFJ5MFYqpAWh6qVfC8b7SInzTw6ddl7QL7pNleVjOpscQwsuVLkOkcw==
X-Received: by 2002:ad4:5aa7:0:b0:707:430e:dc00 with SMTP id 6a1803df08f44-709e899099emr19101106d6.39.1755048821705;
        Tue, 12 Aug 2025 18:33:41 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077c9da463sm186228176d6.9.2025.08.12.18.33.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 18:33:41 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <8ed8cac1-4cf1-4880-9e7d-4e8c816797fa@redhat.com>
Date: Tue, 12 Aug 2025 21:33:39 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next 1/4] cpuset: remove redundant CS_ONLINE flag
To: Chen Ridong <chenridong@huaweicloud.com>, Waiman Long <llong@redhat.com>,
 tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20250808092515.764820-1-chenridong@huaweicloud.com>
 <20250808092515.764820-2-chenridong@huaweicloud.com>
 <db5fdf29-43d9-4e38-a5a8-02cd711b892a@redhat.com>
 <775ef75a-b796-4171-b208-df110a73c558@huaweicloud.com>
 <a27c39d5-7470-475e-aefa-0841bd816675@redhat.com>
 <95c78188-bf8d-4453-b74f-b8a7dc6ae14d@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <95c78188-bf8d-4453-b74f-b8a7dc6ae14d@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 8/12/25 9:20 PM, Chen Ridong wrote:
>
> On 2025/8/13 9:00, Waiman Long wrote:
>> On 8/12/25 8:54 PM, Chen Ridong wrote:
>>> On 2025/8/12 22:44, Waiman Long wrote:
>>>> On 8/8/25 5:25 AM, Chen Ridong wrote:
>>>>> From: Chen Ridong <chenridong@huawei.com>
>>>>>
>>>>> The CS_ONLINE flag was introduced prior to the CSS_ONLINE flag in the
>>>>> cpuset subsystem. Currently, the flag setting sequence is as follows:
>>>>>
>>>>> 1. cpuset_css_online() sets CS_ONLINE
>>>>> 2. css->flags gets CSS_ONLINE set
>>>>> ...
>>>>> 3. cgroup->kill_css sets CSS_DYING
>>>>> 4. cpuset_css_offline() clears CS_ONLINE
>>>>> 5. css->flags clears CSS_ONLINE
>>>>>
>>>>> The is_cpuset_online() check currently occurs between steps 1 and 3.
>>>>> However, it would be equally safe to perform this check between steps 2
>>>>> and 3, as CSS_ONLINE provides the same synchronization guarantee as
>>>>> CS_ONLINE.
>>>>>
>>>>> Since CS_ONLINE is redundant with CSS_ONLINE and provides no additional
>>>>> synchronization benefits, we can safely remove it to simplify the code.
>>>>>
>>>>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>>>>> ---
>>>>>     include/linux/cgroup.h          | 5 +++++
>>>>>     kernel/cgroup/cpuset-internal.h | 3 +--
>>>>>     kernel/cgroup/cpuset.c          | 4 +---
>>>>>     3 files changed, 7 insertions(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
>>>>> index b18fb5fcb38e..ae73dbb19165 100644
>>>>> --- a/include/linux/cgroup.h
>>>>> +++ b/include/linux/cgroup.h
>>>>> @@ -354,6 +354,11 @@ static inline bool css_is_dying(struct cgroup_subsys_state *css)
>>>>>         return css->flags & CSS_DYING;
>>>>>     }
>>>>>     +static inline bool css_is_online(struct cgroup_subsys_state *css)
>>>>> +{
>>>>> +    return css->flags & CSS_ONLINE;
>>>>> +}
>>>>> +
>>>>>     static inline bool css_is_self(struct cgroup_subsys_state *css)
>>>>>     {
>>>>>         if (css == &css->cgroup->self) {
>>>>> diff --git a/kernel/cgroup/cpuset-internal.h b/kernel/cgroup/cpuset-internal.h
>>>>> index 383963e28ac6..75b3aef39231 100644
>>>>> --- a/kernel/cgroup/cpuset-internal.h
>>>>> +++ b/kernel/cgroup/cpuset-internal.h
>>>>> @@ -38,7 +38,6 @@ enum prs_errcode {
>>>>>       /* bits in struct cpuset flags field */
>>>>>     typedef enum {
>>>>> -    CS_ONLINE,
>>>>>         CS_CPU_EXCLUSIVE,
>>>>>         CS_MEM_EXCLUSIVE,
>>>>>         CS_MEM_HARDWALL,
>>>>> @@ -202,7 +201,7 @@ static inline struct cpuset *parent_cs(struct cpuset *cs)
>>>>>     /* convenient tests for these bits */
>>>>>     static inline bool is_cpuset_online(struct cpuset *cs)
>>>>>     {
>>>>> -    return test_bit(CS_ONLINE, &cs->flags) && !css_is_dying(&cs->css);
>>>>> +    return css_is_online(&cs->css) && !css_is_dying(&cs->css);
>>>>>     }
>>>>>       static inline int is_cpu_exclusive(const struct cpuset *cs)
>>>>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>>>>> index f74d04429a29..cf7cd2255265 100644
>>>>> --- a/kernel/cgroup/cpuset.c
>>>>> +++ b/kernel/cgroup/cpuset.c
>>>>> @@ -207,7 +207,7 @@ static inline void notify_partition_change(struct cpuset *cs, int old_prs)
>>>>>      * parallel, we may leave an offline CPU in cpu_allowed or some other masks.
>>>>>      */
>>>>>     static struct cpuset top_cpuset = {
>>>>> -    .flags = BIT(CS_ONLINE) | BIT(CS_CPU_EXCLUSIVE) |
>>>>> +    .flags = BIT(CS_CPU_EXCLUSIVE) |
>>>>>              BIT(CS_MEM_EXCLUSIVE) | BIT(CS_SCHED_LOAD_BALANCE),
>>>>>         .partition_root_state = PRS_ROOT,
>>>>>         .relax_domain_level = -1,
>>>> top_cpuset.css is not initialized like the one in the children. If you modify is_cpuset_online() to
>>>> test the css.flags, you will probably need to set the CSS_ONLINE flag in top_cpuset.css.flags. I do
>>>> doubt that we will apply the is_cpuset_online() test on top_cpuset. To be consistent, we should
>>>> support that.
>>>>
>>>> BTW, other statically allocated css'es in the cgroup root may have similar problem. If you make the
>>>> css_is_online() helper available to all other controllers, you will have to document that
>>>> limitation.
>>>>
>>>> Cheers,
>>>> Longman
>>> Hi, Longman, thank you for your response.
>>>
>>> If I understand correctly, the CSS_ONLINE flag should be set in top_cpuset.css during the following
>>> process:
>>>
>>> css_create
>>>     css = ss->css_alloc(parent_css);  // cgroup root is static, unlike children
>>>     online_css(css);
>>>        ret = ss->css_online(css);     // css root may differ from children
>>>        css->flags |= CSS_ONLINE;      // css.flags is set with CSS_ONLINE, including the root css
>>>
>>> I think css online must be successful, and it's CSS_ONLINE flag must be set. Do I missing anything?
>> I am talking about just the top_cpuset which is statically allocated. It is not created by the
>> css_create() call and so the CSS_ONLINE will not be set.
>>
>> Cheers,
>> Longman
> Hi Longman,
>
> Apologies for the call stack earlier. Thank you for your patience in clarifying this matter.
>
> The CSS root is brought online through the following initialization flow:
>
> cgroup_init_subsys
>    css = ss->css_alloc(NULL);       // css root is static, unlike children
>    online_css(css)
>      ret = ss->css_online(css);     // css root may differ from children
>      css->flags |= CSS_ONLINE;      // css.flags is set with CSS_ONLINE, including the root css
>
> My key point is that:
> - The root CSS should be online by design.
> - Root css CSS_ONLINE flag should be properly set during initialization.

Yes, you are right. I missed css_online() call for the root css for each 
controller. Thanks for the clarification.

With that, I am OK with this patch. Though the other ones are not good.

Acked-by: Waiman Long <longman@redhat.com>


