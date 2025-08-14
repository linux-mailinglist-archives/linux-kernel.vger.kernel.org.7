Return-Path: <linux-kernel+bounces-767853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D47E3B259DE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 05:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 827363B2322
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 03:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C5B25CC6C;
	Thu, 14 Aug 2025 03:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DuN7P9aE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41F3239E92
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 03:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755142076; cv=none; b=I/o4Woxbt5mRzHmEYxH3YRJXNsv/PHc84RrMUnpFOV/Wes294akJNxr7mMWmpJ2QmrSwDfTwwSdM62Ib++7zK4D6R/oDhMxUzPhxXUJf2lOXpek/KaO/5X1ajF5VP+z5L7OrodqYFC7U06M4jRZmkl3GpyqFSBOISrqcHNDuMkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755142076; c=relaxed/simple;
	bh=mdXgPJSAFLczjgL1pMydByQ+6QZayJAaU58a8KbOSSE=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=iPQqL5XBTsMYS2ipXHQcsAKG3Vw9dT5NbT0Lxcd9O4fs5mygNqpyTTI65PQgBFM3gcD3SHR6Ptq6IakoJcxoHJgtKK6Ev87HwWD9Za0YcdD/km85zUtSRYm5SJ1lnU2keUlncTtnZICOTK15ZeOxwQe4qLD4xahNJHV74RgUTFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DuN7P9aE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755142071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=59+2AJKoXTwjmtAk2DQHHWr6SdM3QLz8zeRy+8bR4r4=;
	b=DuN7P9aEW+O8Lb0v0345+S8SmFfrBqVOFjC5Zug5UbE8kVjrClzM+HSL4NrkgzbU6g+Fo6
	v6FFyaHBPypDTMTsogFS4p7g8f+4XkDbytDUrnlWNbI6aS2UCwyE8bCmrrgrI7z9rnuaH+
	T2EMQkiHJOsET5Jtk2BD9optSX3tTMc=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167-cGepcjeYMumLVzTf92IeDA-1; Wed, 13 Aug 2025 23:27:49 -0400
X-MC-Unique: cGepcjeYMumLVzTf92IeDA-1
X-Mimecast-MFC-AGG-ID: cGepcjeYMumLVzTf92IeDA_1755142069
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b109acac47so15003521cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 20:27:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755142069; x=1755746869;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=59+2AJKoXTwjmtAk2DQHHWr6SdM3QLz8zeRy+8bR4r4=;
        b=WE7eO343OqIumr6QvMWI/vU6qoeUExFn6I/3dVfjtTAvPMjLbQtMPrBhPnSZmHPJ0S
         M2atjZOQ+VtqFbuFcEJaApTpM4cdDnRk+eZkxPlUKDEGlP2M+SrczZUGbfxGUu7tgA0R
         V3kT08C6VxxOAf1yjL4P6j2yv/YW/8FnEla3IbV43TbUVwsrj7Vimxqpf4zfeKxTpUNJ
         cqPj4CJ2I3Dg3sgG8dFaxCtOznAJQZKbjWdW5twtSInw28lrALJZdfwArcWEqwMkjnH+
         KCbBFHdBN1IS8CpMAUvYPjeSkNxpch9TbzBj3EkNd+ku2Iadpm8wMSaPFccHpGI356SR
         fY0A==
X-Forwarded-Encrypted: i=1; AJvYcCWJZztRonZ3KhzBRMpiCDTez/4oWfbKGUdq2FXF6PkPLDajreQt+Vcwzy/0cK/EImphd30qI9Gwp2Dq9F4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd4Cm7YmGs6SzXvMIgBICQHMRvGESV7sHRO5oeJZgSHQIK1Nu2
	NN/UJ7Q4vFFOByiUQIHeSQBVpqXg4QT5t1x5gqURTcrA/1JYMzvGSyL3W/sZcnQ2KPYga69qkDd
	JHoj0nO3ECx1SO9n01SiKdoAAsxVNjPIQNpfqQE/KOoohZ5EEISpxL4J8fxHIJAA3xA==
X-Gm-Gg: ASbGnct+iTOLe05kxk9hoA/3t/L21RegkYCtceMS0t+Qy2AMPg8zQym4o3and0BUURw
	04t8GDJbMGwaYDT0vLpvoh6z2GI4gDaY28f9MBIt9pJie0kqIWYcUBRyhCS8Vg12esWf8uPE5Yt
	ADRR3X8l826zAGSoRlo2oJfFBlDVv3n6lQIlpE3xXIQKfPytMwLQd/7hcqhL+wQ+QwtqG6PggQR
	cjWoTyVsAoqHgume2L/lAwoclKABH2OLARfxAmVbsUXAVunqVI4G0ZUalLoDxSZVAsk7b19UaJr
	pyD3u1sP0y/rJ8A4yENF7MnAiEaHtoyRwpMUx6X2GTuUoaieu1Lc6LWmx2S3e2CPm0hMDhjnY72
	flcA1vXHLLA==
X-Received: by 2002:a05:622a:149:b0:4b0:da5c:e250 with SMTP id d75a77b69052e-4b10c5fa96fmr13493811cf.59.1755142069119;
        Wed, 13 Aug 2025 20:27:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESk1/DttNu6iz8CxDSplgxOB5v0RkzObYtmeSlNLDBymBrq3Udoku8HCQ3q7jolK4rRJ50Aw==
X-Received: by 2002:a05:622a:149:b0:4b0:da5c:e250 with SMTP id d75a77b69052e-4b10c5fa96fmr13493581cf.59.1755142068677;
        Wed, 13 Aug 2025 20:27:48 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4afb76dcadfsm159725941cf.19.2025.08.13.20.27.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 20:27:48 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <d09c4e49-8a3a-49b9-9f63-0b39a4bea45f@redhat.com>
Date: Wed, 13 Aug 2025 23:27:46 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [-next v2 4/4] cpuset: add helpers for cpus read and cpuset_mutex
 locks
To: Waiman Long <llong@redhat.com>, Chen Ridong <chenridong@huaweicloud.com>,
 tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com, christophe.jaillet@wanadoo.fr
References: <20250813082904.1091651-1-chenridong@huaweicloud.com>
 <20250813082904.1091651-5-chenridong@huaweicloud.com>
 <e0ac3594-deab-455c-9c2f-495b4e4422e2@redhat.com>
 <750ac0bd-42f9-47fa-8274-0ff4e4a7fa3d@huaweicloud.com>
 <93e37ccf-8ac8-40f5-840f-2f221f58131e@redhat.com>
Content-Language: en-US
In-Reply-To: <93e37ccf-8ac8-40f5-840f-2f221f58131e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/13/25 11:13 PM, Waiman Long wrote:
> On 8/13/25 8:44 PM, Chen Ridong wrote:
>>
>> On 2025/8/14 4:09, Waiman Long wrote:
>>> On 8/13/25 4:29 AM, Chen Ridong wrote:
>>>> From: Chen Ridong <chenridong@huawei.com>
>>>>
>>>> cpuset: add helpers for cpus_read_lock and cpuset_mutex
>>>>
>>>> Replace repetitive locking patterns with new helpers:
>>>> - cpus_read_cpuset_lock()
>>>> - cpus_read_cpuset_unlock()
>>>>
>>>> This makes the code cleaner and ensures consistent lock ordering.
>>>>
>>>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>>>> ---
>>>>    kernel/cgroup/cpuset-internal.h |  2 ++
>>>>    kernel/cgroup/cpuset-v1.c       | 12 +++------
>>>>    kernel/cgroup/cpuset.c          | 48 
>>>> +++++++++++++++------------------
>>>>    3 files changed, 28 insertions(+), 34 deletions(-)
>>>>
>>>> diff --git a/kernel/cgroup/cpuset-internal.h 
>>>> b/kernel/cgroup/cpuset-internal.h
>>>> index 75b3aef39231..6fb00c96044d 100644
>>>> --- a/kernel/cgroup/cpuset-internal.h
>>>> +++ b/kernel/cgroup/cpuset-internal.h
>>>> @@ -276,6 +276,8 @@ int cpuset_update_flag(cpuset_flagbits_t bit, 
>>>> struct cpuset *cs, int turning_on)
>>>>    ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
>>>>                        char *buf, size_t nbytes, loff_t off);
>>>>    int cpuset_common_seq_show(struct seq_file *sf, void *v);
>>>> +void cpus_read_cpuset_lock(void);
>>>> +void cpus_read_cpuset_unlock(void);
>>> The names are not intuitive. I would prefer just extend the 
>>> cpuset_lock/unlock to include
>>> cpus_read_lock/unlock and we use cpuset_lock/unlock consistently in 
>>> the cpuset code. Also, there is
>>> now no external user of cpuset_lock/unlock, we may as well remove 
>>> them from include/linux/cpuset.h.
>>>
>>> Cheers,
>>> Longman
>> I like the idea and have considered it.
>> However, I noticed that cpuset_locked is being used in 
>> __sched_setscheduler.
>
> Right, I overloooked the cpuset_lock() call in kernel/sched/syscall.c. 
> So we can't remove it from include/linux/cpuset.h.
>
> This call is invoked to ensure cpusets information is stable. However, 
> it doesn't hurt if the cpus_read_lock() is also acquired as a result. 
> Alternatively, we can use a name like cpuset_full_lock() to include 
> cpus_read_lock().

I have a correction. According to commit d74b27d63a8b ("cgroup/cpuset: 
Change cpuset_rwsem and hotplug lock order") , sched_scheduler() can be 
called while holding cpus_hotplug_lock. So we should keep cpuset_lock() 
as it is.

Cheers,
Longman


