Return-Path: <linux-kernel+bounces-896484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 591AFC507FA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 05:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 154F7189A15E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 04:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090562C11E3;
	Wed, 12 Nov 2025 04:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GsQqfgCm";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="VNuIGV/b"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75076225415
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 04:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762921202; cv=none; b=r2QOXQvHNIgd3WdID9eD7gAh/+EKTDEz6LTf1VX/Ej83hxb2ftWZm8wjusQOkJtgK7qG4lUIM06iD8LIv5h8oZqeOtkzPhlxrezvqHHzXUxCW55vBdUBqMmssWa1WZwP9vsfZZVn8ddm9oCrFubuH+rvlLtzWPUfIHP+BezqY1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762921202; c=relaxed/simple;
	bh=99ZkEBdOVrlrgRWH5y+oIYLqPCwO/Ovyudmk2p0QKNg=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=SROhGvt9R9m/6qYtAdb63NXet6UQVgeQi5RfMnPwtkmC2/LDno06Sm1Cn5VEe0PVWNL7K0p507usNPytZyba73PiPwhRYdnU1Yj9s6JGiOerTwD+1XWhYR1ta6iyCEDVTb+MzyXBv9HWE1FLYlR/IP0gXip+uLzRz/BcMregB2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GsQqfgCm; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=VNuIGV/b; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762921199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AclnRmvTYc5uBIch2ljEKodBb0PluAr47F+xl2MP6pE=;
	b=GsQqfgCmTuK9PidBUYN9ms/GwQukcA0f0bqYjJM/eLOxixve2VD9G1MtceKs8CV4GTQY1O
	JmeGbIMGpBWq2nTI0+lfKcTeB30Jx4MMYS8v31QwmtMBD5aiSgH8GStgD7ar7NKDDyudPB
	EDT9J2LLa2A9Cr22Vc85lXU5+gULsV4=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-SLNxP--BN7KgUhjkEb2_dg-1; Tue, 11 Nov 2025 23:19:58 -0500
X-MC-Unique: SLNxP--BN7KgUhjkEb2_dg-1
X-Mimecast-MFC-AGG-ID: SLNxP--BN7KgUhjkEb2_dg_1762921197
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-88236bcdfc4so10489016d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 20:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762921197; x=1763525997; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AclnRmvTYc5uBIch2ljEKodBb0PluAr47F+xl2MP6pE=;
        b=VNuIGV/buMaLJzbOF4e5TLW5xVsk342kWLdLAPbe23f6UgxtLF6RPG0Y35vkdmPGJU
         C4Nl5VEYVEJhnXxirodXkWz07ufcnlPwpaZ/Z6sDNNgytCjGpMkttiYfaRRvc/J2Frlf
         HDD2edNPKSy4bJpz1awfEoCSzQ2AMw+fjtmPMi+F90P3oxjMsDWwwM1uY89Moh/oAr/w
         +wqQpf2Nn9ipZRliR1SWA+dklNYSY6OiMloYSUbcXS3/T0lXb2QfHGQpy3nockVBP4FV
         7drHORPRyl5kWu9yMmraF+M5tZyJCNvlGPkSW8+anmmQKTzCiWGDozLB8R4szirrRAh3
         gP+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762921197; x=1763525997;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AclnRmvTYc5uBIch2ljEKodBb0PluAr47F+xl2MP6pE=;
        b=tOwkUszB2vogcO8f4YJIWSe+vW6Nbsca4bIYE5oGF7LpmErZCSd1tD5hOrAG8JpVqt
         6mMHiCzrYCKAveJ+D97BHThAdidz5KuSRKmelpFBQU4qVlueIdzzTj9k9tCMl22TMtxH
         4AT3jfJPMuFQ1OI3Q2qpOZqwyQIB/yLZ1MLEcQlgWbfS4mcGD8qqdhNFPI3wXp8txHGL
         +j2FDAUP1mB8ZV6bGY1PR7RMD5wTEkHF5CSd32Kn5PXwao+ibGC870rZTg5b9HEVkqYR
         BNvvQ5wAGzcHFg7NmO6HWjQVEBTClEmjMwVcH6cGhzg9YS+2SIipWajS33a/GE/9Rlbe
         D+EQ==
X-Forwarded-Encrypted: i=1; AJvYcCVa8U3bcvvOKeaZSbuQCuZws8MKKIDokevhWRXt5cN0HirTA7B7Er/cTHtf8Vy+CpdwCakECclPMI4yqik=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfcOdcDmTDQWQuzHExOR6GVq6U4HjBkeCcPV6GrBPATTm9bYJx
	zc/DMSQ8jSe7Tbhc0V0K0dGIB5ZKYUwxrGFUbWYp+RqqE1OMfIHnesJXHYQ2cgIfT0KIVJwsCIj
	w4LoM65bJsMjK1RKouT1wpQ/HVUMJbKmaXzNb3DvW2jjj361vldg8/ZfpHw//Dpqxxw==
X-Gm-Gg: ASbGncsaDq5JFncCwiyGA23aHyYQ7P/+ChPmnuN18tSp5xH25GaQS4Hz3Qx5bb1s6Gx
	aL1C6yrw7+8iVR/l7NY3rziaJOn84DAcOJyPaQvdSme8mTmcoHwcq0LoEC33u1Em6lAS33FW1Ou
	GcXV5JbY7bR//6UrhiEf593A6OolusnoGbMkO1XhgV3IpGZ2740dQtl+viWAKYcS7l7qHWSclRR
	9y8xqirZiKbnsl3xtKoKcN7CMYz06412q3FZ6XF92UOaEClKQGpRTYh9RG1hnw5hJYViSAoXXNI
	OudZpg0Q/1CPEv1ua+RaYUPMdfFssq+AC9Ayv68iu1Hxn9ImXI4ROiifCS5qFahozpulhAi1Man
	qLGNCbDVt4+sn6dX+zm1QXJtGtVJulPM8HWuU2lCExPDt5A==
X-Received: by 2002:a05:6214:4107:b0:880:54ac:79f8 with SMTP id 6a1803df08f44-88271a5b788mr22274186d6.48.1762921197563;
        Tue, 11 Nov 2025 20:19:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHbMi8UVm64iXlaFa6Bci1MOgHNeZ6t6/Lf2J2rdZ6Af7CSNMp6WRlYJamjOLJvlFJXARjjXg==
X-Received: by 2002:a05:6214:4107:b0:880:54ac:79f8 with SMTP id 6a1803df08f44-88271a5b788mr22274086d6.48.1762921197146;
        Tue, 11 Nov 2025 20:19:57 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88238b293a6sm84556446d6.37.2025.11.11.20.19.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 20:19:56 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <01a859a8-c678-4fd3-8d01-f45759c61c72@redhat.com>
Date: Tue, 11 Nov 2025 23:19:55 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 00/22] cpuset: rework local partition logic
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20251025064844.495525-1-chenridong@huaweicloud.com>
 <31b58b15-0b46-4eba-bd50-afc99203695a@huaweicloud.com>
 <c5c4e977-9194-42c8-9045-0ed0ff16f5a5@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <c5c4e977-9194-42c8-9045-0ed0ff16f5a5@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 11/11/25 11:11 PM, Chen Ridong wrote:
>
> On 2025/11/3 19:18, Chen Ridong wrote:
>>
>> On 2025/10/25 14:48, Chen Ridong wrote:
>>> From: Chen Ridong <chenridong@huawei.com>
>>>
>>> The current local partition implementation consolidates all operations
>>> (enable, disable, invalidate, and update) within the large
>>> update_parent_effective_cpumask() function, which exceeds 300 lines.
>>> This monolithic approach has become increasingly difficult to understand
>>> and maintain. Additionally, partition-related fields are updated in
>>> multiple locations, leading to redundant code and potential corner case
>>> oversights.
>>>
>>> This patch series refactors the local partition logic by separating
>>> operations into dedicated functions: local_partition_enable(),
>>> local_partition_disable(), and local_partition_update(), creating
>>> symmetry with the existing remote partition infrastructure.
>>>
>>> The series is organized as follows:
>>>
>>> 1. Fix a bug that isolcpus stat in root partition.
>>>
>>> 2. Infrastructure Preparation (Patches 2-3):
>>>     - Code cleanup and preparation for the refactoring work
>>>
>>> 3. Introduce partition operation helpers (Patches 4-6):
>>>     - Intoduce out partition_enable(), partition_disable(), and
>>>       partition_update() functions.
>>>
>>> 4. Use new helpers for remote partition (Patches 7-9)
>>>
>>> 5. Local Partition Implementation (Patches 10-13):
>>>     - Separate update_parent_effective_cpumask() into dedicated functions:
>>>       * local_partition_enable()
>>>       * local_partition_disable()
>>>       * local_partition_invalidate()
>>>       * local_partition_update()
>>>
>>> 6. Optimization and Cleanup (Patches 14-22):
>>>     - Remove redundant partition-related operations
>>>     - Additional optimizations based on the new architecture
>>>
>>> ---
>>>
>>> Changes in v2:
>>> - Added bugfix for root partition isolcpus at series start.
>>> - Completed helper function implementations when first introduced.
>>> - Split larger patches into smaller, more reviewable units.
>>> - Incorporated feedback from Longman.
>>>
>>> Chen Ridong (22):
>>>    cpuset: fix isolcpus stay in root when isolated partition changes to
>>>      root
>>>    cpuset: add early empty cpumask check in partition_xcpus_add/del
>>>    cpuset: generalize validate_partition() interface
>>>    cpuset: introduce partition_enable()
>>>    cpuset: introduce partition_disable()
>>>    cpuset: introduce partition_update()
>>>    cpuset: use partition_enable() for remote partition enablement
>>>    cpuset: use partition_disable() for remote partition disablement
>>>    cpuset: use partition_update() for remote partition update
>>>    cpuset: introduce local_partition_enable()
>>>    cpuset: introduce local_partition_disable()
>>>    cpuset: introduce local_partition_invalidate()
>>>    cpuset: introduce local_partition_update()
>>>    cpuset: remove update_parent_effective_cpumask
>>>    cpuset: remove redundant partition field updates
>>>    cpuset: simplify partition update logic for hotplug tasks
>>>    cpuset: unify local partition disable and invalidate
>>>    cpuset: use partition_disable for compute_partition_effective_cpumask
>>>    cpuset: use validate_local_partition in local_partition_enable
>>>    cpuset: introduce validate_remote_partition
>>>    cpuset: simplify update_prstate() function
>>>    cpuset: remove prs_err clear when notify_partition_change
>>>
>>>   kernel/cgroup/cpuset.c | 1000 +++++++++++++++++++---------------------
>>>   1 file changed, 463 insertions(+), 537 deletions(-)
>>>
>> Hi Longman,
>>
>> I'd appreciate it if you could have a look at this series when you have a moment.
>>
> Hi Longman,
>
> Could you kindly take a look at this series when you have a moment?
> I'd appreciate any feedback you might have, and I’ll update the series accordingly.

I will take a look at this series tomorrow, though it has to be updated 
again anyway.

Cheers,
Longman

>


