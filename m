Return-Path: <linux-kernel+bounces-771381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FB4B28635
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 21:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C65A81D06384
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 19:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC431EF091;
	Fri, 15 Aug 2025 19:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E3zcScCy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31DF3AC22
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 19:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755285236; cv=none; b=PViKLZRzSzzgFjAC91vnThQ8MNVrt7r5i0MUHvktz8uYHu83rmnaluXj5zy8A3xtJKrKSXYZNZ+EDYpE7y217O/0Sob7Nsi4iV1alUS/eaQqcyGzIjrYMpwX1CbLtLdW67eIz4OQiGTWU+W1En18RK/6spjRSvjNWl8e14GS5FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755285236; c=relaxed/simple;
	bh=oNhweOl6Iq/Hda3o5m5+6ZwPRynn8p1xkDuLuBJGJcY=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ch+jO1aoUmja7S4v1FEcZFXdFkAs21+nvz2UHI1HpZ1Rxbc488du43ppimnEq7wwqwThAoMWwjEu3Qvhic+aOwC4NEEzR9kBdSXXwcWMrSppa+klikPnogFt0Ta5pchTlqixmzMFTPK0HeXsUGuf6/thVGjY5Lr3FfYwLcl8UAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E3zcScCy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755285233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9NnFY7XGdPFGZ6/tk81vvfIJer3/1BjfcPoDujGBtK4=;
	b=E3zcScCyg6FSFlIc3cTQTrRKjQs9nWcSsd11KwydMt2iNEjLAy8c2OXbWHikEmm3QVTINT
	4F7w6LQWm+iIIQ8qcfPJn2bIAFcf+5OaC67URYRI31Hp4ztaIjFWhylYoQCxc/CnbFxHKr
	hROPjN3IJUa8Tn7wxVzP9e9vj2kAxsQ=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-8Wp_3dgKOpS0hRqF9QJ2kQ-1; Fri, 15 Aug 2025 15:13:52 -0400
X-MC-Unique: 8Wp_3dgKOpS0hRqF9QJ2kQ-1
X-Mimecast-MFC-AGG-ID: 8Wp_3dgKOpS0hRqF9QJ2kQ_1755285232
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-70a928282a3so72039656d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 12:13:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755285231; x=1755890031;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9NnFY7XGdPFGZ6/tk81vvfIJer3/1BjfcPoDujGBtK4=;
        b=Rk46vD2YAdY7M0MVWpbT/qzgw4TyLly0CakT86QlCahcd3nKDXMXFQ9anbYZ7YfCI2
         n9hvCTyL0TjYUUPyXeDLuziuK9WZn05ZQ+sr2RRQvEwIHTwMSKkOXAy8D9KRVBOqwsn1
         ZKtFe4RDykWBEU99Gc+41O9YeS4yjCXgp6pCyKIcsar52mQ8qbhfZziwes38dlpa3Ho3
         8ydO6BpBLPrsub77OZB2Q7U5N36ONUY/gcpiKox7tSfF7CG87M1troQL6aXwYN1Shfgw
         3IF1o27VncBPPKWaCwsEOULs3YEkLThIHCdQUvZNrP/WGLitFlLIL+3FkjM2V7Zfj3UQ
         /1zA==
X-Forwarded-Encrypted: i=1; AJvYcCVOdpYXNKvLRnV+Rf2lMurKAv+yrdYEUlibF4+9hrKdQ5oEmAjXCjuJYpMPPTbZsPLogSxne7eVNSN1+Sk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeCVLVP9ES5HcdXTmkB5pZMBjbkXrR6MsVLFZmIST1/vE2sxuD
	TXOTupHWV/5RJbaBk1nDunluSjv12qNGXrFUpmJLUJCJl/IHQOItTn8T/FASwbwGc5b7iQ4QaLB
	IhXTmoOOp2gtq3DKeNgD/PYz5MC0o/q4BtmOM5z0rAANQad6gTbUs8T91q1XdFMHVX0rpQ1HyUQ
	==
X-Gm-Gg: ASbGncvemluqRTqt8m8nvU3dy9uJ0alPokZ4Aip97a0D1LEXSJYPKZ2FWqaX6N9bjFn
	B2li+zpHbpBT2DvcrpYHHlhNxf3jzf8hVbzt0HapnY9QOm5TgusRFeLkncb/cuDlfrHJPhm4GGm
	6DtVKZYSkQ/ygx9BPyKC/kVofGpuA79/umtaMR/V0FY35n5vq7mNUTCaRlRjzYeEx2WXAaATy28
	US0rcR6BNtSWyw47vYnEf/BSygQtMJkpch6nRfsXnAQyuw7BBfS9ixN1aRgHOhCWcPt1HSI2n7Z
	gNCWvLWAxWORBlIewL90lIwEP9/vdS6vSyG1KzDiYr3cPyqFU/HpforBgSa3DcZd8iAc/o009uS
	Tr90gMd9S0g==
X-Received: by 2002:ad4:5aa6:0:b0:6fd:236f:abb4 with SMTP id 6a1803df08f44-70ba7c33008mr39939506d6.34.1755285230509;
        Fri, 15 Aug 2025 12:13:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFWqragQ70JVZ9oModMUHd76UYFFhu+9iT3ePLx/Lzp8VZiH2Q7Yl1XvW0lTL2bJNoB5gssQ==
X-Received: by 2002:ad4:5aa6:0:b0:6fd:236f:abb4 with SMTP id 6a1803df08f44-70ba7c33008mr39939176d6.34.1755285230097;
        Fri, 15 Aug 2025 12:13:50 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70ba902f827sm12451976d6.10.2025.08.15.12.13.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Aug 2025 12:13:49 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <820ec990-9695-46d0-ae95-2c0eda66bf9c@redhat.com>
Date: Fri, 15 Aug 2025 15:13:48 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [-next v2 4/4] cpuset: add helpers for cpus read and cpuset_mutex
 locks
To: Chen Ridong <chenridong@huaweicloud.com>, Waiman Long <llong@redhat.com>,
 tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com, christophe.jaillet@wanadoo.fr
References: <20250813082904.1091651-1-chenridong@huaweicloud.com>
 <20250813082904.1091651-5-chenridong@huaweicloud.com>
 <e0ac3594-deab-455c-9c2f-495b4e4422e2@redhat.com>
 <750ac0bd-42f9-47fa-8274-0ff4e4a7fa3d@huaweicloud.com>
 <93e37ccf-8ac8-40f5-840f-2f221f58131e@redhat.com>
 <d09c4e49-8a3a-49b9-9f63-0b39a4bea45f@redhat.com>
 <c88c6e2e-5988-405c-a037-651a8800ba83@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <c88c6e2e-5988-405c-a037-651a8800ba83@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/13/25 11:58 PM, Chen Ridong wrote:
>
> On 2025/8/14 11:27, Waiman Long wrote:
>> On 8/13/25 11:13 PM, Waiman Long wrote:
>>> On 8/13/25 8:44 PM, Chen Ridong wrote:
>>>> On 2025/8/14 4:09, Waiman Long wrote:
>>>>> On 8/13/25 4:29 AM, Chen Ridong wrote:
>>>>>> From: Chen Ridong <chenridong@huawei.com>
>>>>>>
>>>>>> cpuset: add helpers for cpus_read_lock and cpuset_mutex
>>>>>>
>>>>>> Replace repetitive locking patterns with new helpers:
>>>>>> - cpus_read_cpuset_lock()
>>>>>> - cpus_read_cpuset_unlock()
>>>>>>
>>>>>> This makes the code cleaner and ensures consistent lock ordering.
>>>>>>
>>>>>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>>>>>> ---
>>>>>>     kernel/cgroup/cpuset-internal.h |  2 ++
>>>>>>     kernel/cgroup/cpuset-v1.c       | 12 +++------
>>>>>>     kernel/cgroup/cpuset.c          | 48 +++++++++++++++------------------
>>>>>>     3 files changed, 28 insertions(+), 34 deletions(-)
>>>>>>
>>>>>> diff --git a/kernel/cgroup/cpuset-internal.h b/kernel/cgroup/cpuset-internal.h
>>>>>> index 75b3aef39231..6fb00c96044d 100644
>>>>>> --- a/kernel/cgroup/cpuset-internal.h
>>>>>> +++ b/kernel/cgroup/cpuset-internal.h
>>>>>> @@ -276,6 +276,8 @@ int cpuset_update_flag(cpuset_flagbits_t bit, struct cpuset *cs, int
>>>>>> turning_on)
>>>>>>     ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
>>>>>>                         char *buf, size_t nbytes, loff_t off);
>>>>>>     int cpuset_common_seq_show(struct seq_file *sf, void *v);
>>>>>> +void cpus_read_cpuset_lock(void);
>>>>>> +void cpus_read_cpuset_unlock(void);
>>>>> The names are not intuitive. I would prefer just extend the cpuset_lock/unlock to include
>>>>> cpus_read_lock/unlock and we use cpuset_lock/unlock consistently in the cpuset code. Also, there is
>>>>> now no external user of cpuset_lock/unlock, we may as well remove them from include/linux/cpuset.h.
>>>>>
>>>>> Cheers,
>>>>> Longman
>>>> I like the idea and have considered it.
>>>> However, I noticed that cpuset_locked is being used in __sched_setscheduler.
>>> Right, I overloooked the cpuset_lock() call in kernel/sched/syscall.c. So we can't remove it from
>>> include/linux/cpuset.h.
>>>
>>> This call is invoked to ensure cpusets information is stable. However, it doesn't hurt if the
>>> cpus_read_lock() is also acquired as a result. Alternatively, we can use a name like
>>> cpuset_full_lock() to include cpus_read_lock().
>> I have a correction. According to commit d74b27d63a8b ("cgroup/cpuset: Change cpuset_rwsem and
>> hotplug lock order") , sched_scheduler() can be called while holding cpus_hotplug_lock. So we should
>> keep cpuset_lock() as it is.
>>
>> Cheers,
>> Longman
> Thank you Longman, this is very helpful.
>
> I had considered whether we can add cpus_read_lock() to the cpuset_lock, but based on your
> explanation, I now understand this approach would not work.
>
> For clarity, would it be acceptable to rename:
> cpus_read_cpuset_lock() -> cpuset_full_lock()
> cpus_read_cpuset_unlock() -> cpuset_full_unlock()

Yes, that is what I want to see. Note that taking both cpus_read_lock() 
and cpuset_mutex are needed to modify cpuset data. Taking just 
cpuset_mutex will prevent other from making changes to the cpuset data, 
but is not enough to make modification.

Cheers,
Longman

>


