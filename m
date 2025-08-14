Return-Path: <linux-kernel+bounces-767844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFD4B259BA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 05:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 472FA2A8393
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 03:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D06624502D;
	Thu, 14 Aug 2025 03:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B3cDLm91"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7015E146D45
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 03:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755141231; cv=none; b=QFsbPrdrivQzyCGpacfSVeCXsRTSxrjisd5HKJSBCAQR/5inTJ7+r25EDM7NxIyfkCst7meKB+2TZDJt0shaejKwe0wYey1vHmKhYUV+uEbuKRf5U6EKDVo33scr9LNdhVpuUXIv2q2dHpVFYTTpOwqA2JGVZ5zGqN++wqtxW+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755141231; c=relaxed/simple;
	bh=iHqjsY4MfwDqWbGNqm5cbcklEGuylreMnuzVcA9KZnY=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=R5AOri0AqC1ebaA071+Wz0mhRMHwq3X7y42xc3/TWSG2zn4dihl454u0hpyGiOD/97Pn+ovcte8yxSDobdburYyOE8E+HMph6KV9MsoEYNw4/bA4VUb7aRXvDMD0bBwhcEEHTNUuTFnCgvhndxEcRzKzT/Z4Z7mRWUFcFyNEc8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B3cDLm91; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755141228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tg3g0W3TnLPMEjK0YCe2ung/C6H2Ffd72IZHE9zkrW0=;
	b=B3cDLm91t07OgMmzn1EcpV+vzkM3mo7P7zKxorQ+wcz8aTIOykG1tZbcJ1+esVIU3RGnBW
	iYOA5aToUOQPVKly91rShyMqlNK4c80gQeLyi6kB0etHcuEmydeF2mboo0jM1dWXy8GFrd
	RxVuwR5qwMtR/BVCm2+T5gbEmfD5yp4=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-DNzjJi1VPiaL3SOqyHGPMQ-1; Wed, 13 Aug 2025 23:13:46 -0400
X-MC-Unique: DNzjJi1VPiaL3SOqyHGPMQ-1
X-Mimecast-MFC-AGG-ID: DNzjJi1VPiaL3SOqyHGPMQ_1755141226
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b109be41a1so20391181cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 20:13:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755141226; x=1755746026;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tg3g0W3TnLPMEjK0YCe2ung/C6H2Ffd72IZHE9zkrW0=;
        b=tMYNiZPimuDebOcLBK9NkToCosoGXnYolLc0HarZ9n5wkonV6vD9v8I8uyR4iirv9U
         zV0aZ/6Pgv+sERuMR3dfruJB5FRVbzLd5tofJzodAAUAp18RQ+D28TkKF13v4rqwhpPm
         HTrb37I0LjU5hztKWMUV2GON5JKMZcQUA8F3zr9Pb2KRBTNRWrZSrtM5J+sdd663pV+f
         4+oZgbAiDAOMF3audGz+ViJmzia0iyrgzcq5oWMzLQE2IGUr6nViiblApUhNcyB+tBbe
         R7kkqXHq+zaSDotgv+4Dokxnj+bYaC7jPaQxjT/Tj7URZdDwb5n+E8D+GBkY0rGrLsXx
         Phtw==
X-Forwarded-Encrypted: i=1; AJvYcCX1as6BQRXbzaBRBMFLZCkr5oaVS0B9DtXhSubgnEHvy8iSXRFzfqSis6FfYlAE6G6ggDJ0V5Z7n2orEAU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPwRTjGc9Sf2+F9Vawuz1yQG1TkbWIpsz9oCJBSY4XwpK7S5Rr
	JnObtPB/wDT/ifllwWMaWoMgKDfOb0Mrz7FOL2VZ3EiAZZnm9kFeYXubkrUuGsMg5fIXccIibxG
	P6byTncQqjED1Df5q9cJA8TRqhqxqQUe3aZNrZQtaUmlndoIyd+ZQ4DVcjJpfNVinBA==
X-Gm-Gg: ASbGncsSAtw8jOtQ68FCGZT7j9aot/H9p9D5dQ3oYhF99tfSNuDMep2kRrLrkxUrDa/
	3Q4nQZraz3qIFPbuet3pygkYNzI68CdNjo+Uywy78c/9kzp/P/vB1/PTNjn+QJ6VaqeQlpC5d3w
	7stUhZFi4EdW1bHLxgJFYCr2afrHLwPhb3f7YHpIcddaLjj7HT0APMhTdPJq97ohqCZHV1A9p8K
	dwicKo6TpQ+Q93UiT1hjtR1Atu2ugQmPHINcCJOl6DBYjL2rQj0R3++xZS26CxcNdRipVaWmaMb
	VRjUuNwPJ0GEmsI0BI34MJ/dtCpXBOy8vZKb+33Wmsn5O7XR1CYhHOmJskZXJIPtVpSbbrhNsnG
	/Glnq3sClqg==
X-Received: by 2002:a05:622a:180e:b0:4b0:a07f:c1d0 with SMTP id d75a77b69052e-4b10a9df06fmr20521211cf.5.1755141226264;
        Wed, 13 Aug 2025 20:13:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlPMhkNapB6PW9gJ4xsfcttM+z5+l4+YuV0ppOAeh+8NYEEGvbvW3eRbtqNMeL16JO0FbMvA==
X-Received: by 2002:a05:622a:180e:b0:4b0:a07f:c1d0 with SMTP id d75a77b69052e-4b10a9df06fmr20521041cf.5.1755141225950;
        Wed, 13 Aug 2025 20:13:45 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b093596ff5sm115726061cf.30.2025.08.13.20.13.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 20:13:45 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <93e37ccf-8ac8-40f5-840f-2f221f58131e@redhat.com>
Date: Wed, 13 Aug 2025 23:13:44 -0400
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
Content-Language: en-US
In-Reply-To: <750ac0bd-42f9-47fa-8274-0ff4e4a7fa3d@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/13/25 8:44 PM, Chen Ridong wrote:
>
> On 2025/8/14 4:09, Waiman Long wrote:
>> On 8/13/25 4:29 AM, Chen Ridong wrote:
>>> From: Chen Ridong <chenridong@huawei.com>
>>>
>>> cpuset: add helpers for cpus_read_lock and cpuset_mutex
>>>
>>> Replace repetitive locking patterns with new helpers:
>>> - cpus_read_cpuset_lock()
>>> - cpus_read_cpuset_unlock()
>>>
>>> This makes the code cleaner and ensures consistent lock ordering.
>>>
>>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>>> ---
>>>    kernel/cgroup/cpuset-internal.h |  2 ++
>>>    kernel/cgroup/cpuset-v1.c       | 12 +++------
>>>    kernel/cgroup/cpuset.c          | 48 +++++++++++++++------------------
>>>    3 files changed, 28 insertions(+), 34 deletions(-)
>>>
>>> diff --git a/kernel/cgroup/cpuset-internal.h b/kernel/cgroup/cpuset-internal.h
>>> index 75b3aef39231..6fb00c96044d 100644
>>> --- a/kernel/cgroup/cpuset-internal.h
>>> +++ b/kernel/cgroup/cpuset-internal.h
>>> @@ -276,6 +276,8 @@ int cpuset_update_flag(cpuset_flagbits_t bit, struct cpuset *cs, int turning_on)
>>>    ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
>>>                        char *buf, size_t nbytes, loff_t off);
>>>    int cpuset_common_seq_show(struct seq_file *sf, void *v);
>>> +void cpus_read_cpuset_lock(void);
>>> +void cpus_read_cpuset_unlock(void);
>> The names are not intuitive. I would prefer just extend the cpuset_lock/unlock to include
>> cpus_read_lock/unlock and we use cpuset_lock/unlock consistently in the cpuset code. Also, there is
>> now no external user of cpuset_lock/unlock, we may as well remove them from include/linux/cpuset.h.
>>
>> Cheers,
>> Longman
> I like the idea and have considered it.
> However, I noticed that cpuset_locked is being used in __sched_setscheduler.

Right, I overloooked the cpuset_lock() call in kernel/sched/syscall.c. 
So we can't remove it from include/linux/cpuset.h.

This call is invoked to ensure cpusets information is stable. However, 
it doesn't hurt if the cpus_read_lock() is also acquired as a result. 
Alternatively, we can use a name like cpuset_full_lock() to include 
cpus_read_lock().

Cheers,
Longman


