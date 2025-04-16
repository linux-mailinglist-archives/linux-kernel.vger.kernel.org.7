Return-Path: <linux-kernel+bounces-607788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 537BDA90ACC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Apr 2025 20:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABB92188B52D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Apr 2025 18:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CDD21ABCB;
	Wed, 16 Apr 2025 18:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q1tXpvu6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FF3217F35
	for <linux-kernel@vger.kernel.org>; Wed, 16 Apr 2025 18:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744826714; cv=none; b=gIUxlqQQcC98+r7FE6KGo/gudM1fQNmkJIjQWM+66AEC2r3LecFM0sdpTv2sNzDOEV6qErFhGH2qZuFuAie0X/NYX8+yxTQv8R5W0CcZYjZk5sti/mRZiEL+AzFiUsP6+QDFA/TlqnY4f2orrLhmz/mH5vFxEeaOtHZ8+fLp5xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744826714; c=relaxed/simple;
	bh=ZIr5qWePhTTAu6QP9ykCRzp3/zXxyl7rRo50HkLvVzc=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=a8oQtZ8kMCoTMZuzoXwRJHs/SvDyOK4Eq6an4AquPYBDsRyVty5RR33w8sR1DYUG+kbryuMBtkwTLYCEG0q063AbxPcdzjqIPWnh5SaSUPGs3WCEzQQKlzYunezpJqgKcSDJjPQNEpsw6i9eguRH1ldtiZorHmel4ZFGdLwxjGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q1tXpvu6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744826711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TvegWG7Gj78xUkKCUKVmQ3vNed+Ayv7sODOOTAUPKj4=;
	b=Q1tXpvu6k4zw61/5aVV2COVuGr8WKW+Dkl0IEhxM8lJ88dDhvKnx3fXp1albceR12BHPei
	CBlHEm/9vDPSgaIpFMi3aIyB+nfUyc8O/XUMjspgRK5G/1Og9WCnoBU1MbUp/d4oFDTwGA
	eQYyLtReEQFMLSqpnfuEUXDf5MmRSS4=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-P9G5hST3PnmlHU-e4HRZ-g-1; Wed, 16 Apr 2025 14:05:10 -0400
X-MC-Unique: P9G5hST3PnmlHU-e4HRZ-g-1
X-Mimecast-MFC-AGG-ID: P9G5hST3PnmlHU-e4HRZ-g_1744826710
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4768d63b1dcso16070871cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Apr 2025 11:05:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744826709; x=1745431509;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TvegWG7Gj78xUkKCUKVmQ3vNed+Ayv7sODOOTAUPKj4=;
        b=vp6cbDOIN54ZAUBxm9R8ouaZJ9gXuf3j2UnxGNpBv0wsM5DePIvyXgT1jtLe6Is16V
         eVPk4WohYzoCNfa8cx531zx/hoxTHx4tbNBhWMbsKy+miuf8PNtX9rVi/Kcdm3JfB53c
         s3w8DoCvs1b6/BBZEKUqfqQslN8Q+BwIMyBmzw6O7qj7I8DSVX3owGW9Ym+hzZQK5Cdz
         RlFIIVrO9+CXZygEtmOfB9hqb0VRC4VOd4EBoVCKCdvQhJ3VZF64WZrFb5ppkws/4jMa
         1RpxcqQRYOOEyHkiGJF6viWQ027XzYyONO+ipLV3ihczgaNMQh/31Qeeiy5j7fc1ss0o
         40xA==
X-Forwarded-Encrypted: i=1; AJvYcCUGQ1P6Tfl65UtyyHegHJoSTGm/f+7zQDmwhq+5EgZtKqLkMt/V/Z3PiFTUf3PeVcUiKVX9H+yTSsBJdFM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiWJTDREZl9CDavQb/yxJFEwpApyfaRwv1dvkBzaEMPnKaEtZK
	AoZa2JH1Z/OnK0OOHyVR8J1mTDXVOZFST/Qpl6go4YhlSTXIXa+oCdze4o9BxGct78QuwWqkTQW
	OMqUk2fdkbI4DHFFgXWtiBdoFfU5qzI4QKJaDsIBudGhmJ+CBThmGzND9dOP4UQ==
X-Gm-Gg: ASbGncsj5xbSPbVAo0qZDN31JlIxXnruZaU/w2eeDQqXwqVEgKbFlnz5jJtEp2vAOqj
	fR6eKa1BYv4QIivrIBmEGTzSesjVzgy+CSe9mqo16SPLoGsEEu9g8LTpiyyPaoEagKaN4m4Cq93
	pNnPrnszPmcj9tbIlCZrP5qEw8mvCkwCiWRwBpnGhtmFXTKkhO5dZVaQxhC4yuk5t5lw9ZZEYJP
	FrTIx/oAQ7VuFGhGWdeMIqb3YBog+cSvm/0EPWPFNZhhVHLgtglzRpWRKyv/tHN/PyvZgIO1HUB
	P9Rje2+aNEfqkHUfxZEUID4dYcJOuCO31b5r54EeOLdoN8ET1oOJjjzVWQ==
X-Received: by 2002:a05:622a:229e:b0:477:113e:1fb3 with SMTP id d75a77b69052e-47add9b119dmr5840091cf.3.1744826709606;
        Wed, 16 Apr 2025 11:05:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpCQG/sH+Ymk/ikKjnKHM6wtmN6xWEToIN33YtXK8oyvo+AxyY+0yFSum8ebtAl603wlPKvA==
X-Received: by 2002:a05:622a:229e:b0:477:113e:1fb3 with SMTP id d75a77b69052e-47add9b119dmr5839651cf.3.1744826709102;
        Wed, 16 Apr 2025 11:05:09 -0700 (PDT)
Received: from ?IPV6:2601:408:c101:1d00:6621:a07c:fed4:cbba? ([2601:408:c101:1d00:6621:a07c:fed4:cbba])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c7a8969242sm1081236285a.49.2025.04.16.11.05.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Apr 2025 11:05:08 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <146ecd0e-7c4c-4c8c-a11f-029fafb1f2e3@redhat.com>
Date: Wed, 16 Apr 2025 14:05:07 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cgroup/cpuset-v1: Add missing support for
 cpuset_v2_mode
To: "T.J. Mercier" <tjmercier@google.com>,
 Kamalesh Babulal <kamalesh.babulal@oracle.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250415235308.424643-1-tjmercier@google.com>
 <46892bf4-006b-4be1-b7ce-d03eb38602b3@oracle.com>
 <CABdmKX2zmQT=ZvRAHOjfxg9hgJ_9iCpQj_SDytHVG2UobdsfMw@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CABdmKX2zmQT=ZvRAHOjfxg9hgJ_9iCpQj_SDytHVG2UobdsfMw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/16/25 1:55 PM, T.J. Mercier wrote:
> On Wed, Apr 16, 2025 at 2:19 AM Kamalesh Babulal
> <kamalesh.babulal@oracle.com> wrote:
>> Hi,
>>
>> On 4/16/25 5:23 AM, T.J. Mercier wrote:
>>> Android has mounted the v1 cpuset controller using filesystem type
>>> "cpuset" (not "cgroup") since 2015 [1], and depends on the resulting
>>> behavior where the controller name is not added as a prefix for cgroupfs
>>> files. [2]
>>>
>>> Later, a problem was discovered where cpu hotplug onlining did not
>>> affect the cpuset/cpus files, which Android carried an out-of-tree patch
>>> to address for a while. An attempt was made to upstream this patch, but
>>> the recommendation was to use the "cpuset_v2_mode" mount option
>>> instead. [3]
>>>
>>> An effort was made to do so, but this fails with "cgroup: Unknown
>>> parameter 'cpuset_v2_mode'" because commit e1cba4b85daa ("cgroup: Add
>>> mount flag to enable cpuset to use v2 behavior in v1 cgroup") did not
>>> update the special cased cpuset_mount(), and only the cgroup (v1)
>>> filesystem type was updated.
>>>
>>> Add parameter parsing to the cpuset filesystem type so that
>>> cpuset_v2_mode works like the cgroup filesystem type:
>>>
>>> $ mkdir /dev/cpuset
>>> $ mount -t cpuset -ocpuset_v2_mode none /dev/cpuset
>>> $ mount|grep cpuset
>>> none on /dev/cpuset type cgroup (rw,relatime,cpuset,noprefix,cpuset_v2_mode,release_agent=/sbin/cpuset_release_agent)
>>>
>>> [1] https://cs.android.com/android/_/android/platform/system/core/+/b769c8d24fd7be96f8968aa4c80b669525b930d3
>>> [2] https://cs.android.com/android/platform/superproject/main/+/main:system/core/libprocessgroup/setup/cgroup_map_write.cpp;drc=2dac5d89a0f024a2d0cc46a80ba4ee13472f1681;l=192
>>> [3] https://lore.kernel.org/lkml/f795f8be-a184-408a-0b5a-553d26061385@redhat.com/T/
>>>
>>> Fixes: e1cba4b85daa ("cgroup: Add mount flag to enable cpuset to use v2 behavior in v1 cgroup")
>>> Signed-off-by: T.J. Mercier <tjmercier@google.com>
>> The patch looks good to me, please feel free to add
>>
>> Reviewed-by: Kamalesh Babulal <kamalesh.babulal@oracle.com>
>>
>> One nit below:
>>
>>> ---
>>>   kernel/cgroup/cgroup.c | 29 +++++++++++++++++++++++++++++
>>>   1 file changed, 29 insertions(+)
>>>
>>> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
>>> index 27f08aa17b56..cf30ff2e7d60 100644
>>> --- a/kernel/cgroup/cgroup.c
>>> +++ b/kernel/cgroup/cgroup.c
>>> @@ -2353,9 +2353,37 @@ static struct file_system_type cgroup2_fs_type = {
>>>   };
>>>
>>>   #ifdef CONFIG_CPUSETS_V1
>>> +enum cpuset_param {
>>> +     Opt_cpuset_v2_mode,
>>> +};
>>> +
>>> +const struct fs_parameter_spec cpuset_fs_parameters[] = {
>>> +     fsparam_flag  ("cpuset_v2_mode", Opt_cpuset_v2_mode),
>>> +     {}
>>> +};
>> A minor optimization you may want to convert the cpuset_fs_parameters into
>> a static const.
> Thanks, I copied from cgroup1_fs_parameters since that's where
> cpuset_v2_mode lives, which doesn't have the static currently
> (cgroup2_fs_parameters does). Let me update cpuset_fs_parameters in
> v3, and add a second patch for cgroup1_fs_parameters.

Besides not exposing the structure outside the current file or maybe a 
tiny bit of linker speedup, is there other performance benefit by adding 
"static"?

Regards,
Longman


