Return-Path: <linux-kernel+bounces-897892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C26C53E36
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 19:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A2737343D34
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 18:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF3F307AD4;
	Wed, 12 Nov 2025 18:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FijbiEZd";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="q3ctEXq0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BEB29AAFD
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 18:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762971678; cv=none; b=CSxcHRTg/FC6tHVu/tuFqPVB7MMjf5QP2j6gtU8Jz+GVbPM/1isIUkwvWSQsVK2Vhs8175ea+E/RNCJsIwyyKWDvaAC77uq81t/64hS17MGsg/QqfQsts6DaY30VQoRWTl9KPww1izF3lEOL68wiqVR9KGn1+FZVCZO+PtQ9/qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762971678; c=relaxed/simple;
	bh=yl+oslX8wXO1RMzv0DqKzC2S5J5LK9Sv9dWD7vhAgAM=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Nds4regE0ruuHjjlidjbVKLD93k0rA3g6v3RTizWYN39Kh3/1BOag0rdvwUbQ6Jr42zRwskzyO6vyt+JtEZAsXFQnfdHzgNmz8ujI2AR+n4nVTxB4maU5LH6cnzAAw71VOtHUiF6cyAN2jpaUKWQyTH4B0p/XlVPCx9YoT1UzLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FijbiEZd; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=q3ctEXq0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762971676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+dJpJWnR6W2PauvB5c9FgPR6gGTYegkNj3iOoqqoWtg=;
	b=FijbiEZd46vSeDwSvYBUxk3wafkUoH+Cv1oAAsVk1KrbmfCySsHlI3zt3VxmCM+zPS8fUy
	tJtGDmvKTyT8p74VG6fJBnmwQazbLEzuCB4Wdi1C9H0T+f8Q49KjUxKQOmBEaCFghaI0t8
	DsjiiCACuG1Aa8ySQEUy2WyVQs23xg0=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-WL8JvF3WNASTlj1B4VACBw-1; Wed, 12 Nov 2025 13:21:14 -0500
X-MC-Unique: WL8JvF3WNASTlj1B4VACBw-1
X-Mimecast-MFC-AGG-ID: WL8JvF3WNASTlj1B4VACBw_1762971674
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8b25cdd6d6bso307259385a.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 10:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762971674; x=1763576474; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+dJpJWnR6W2PauvB5c9FgPR6gGTYegkNj3iOoqqoWtg=;
        b=q3ctEXq0ffJ4swuBHHeX0XNAnGJowN6jiL8X3fYDo7vZfFxBdJxCiGVFvTrJ1xKOxj
         3BsZ45bqdOSjKLzQ8P+gXTnFq6rluEAwmx7ccwuR9hWtAkgqDg3J54rEbqvn4hf9BIC3
         TWk00a6BXXLekHWc5phULXwY1RAlCLlaF+GxXjy8aXZeNx/CT7GZKs2kpJ0bzmYB87c2
         aNND3ZDytqAkn4nr+OW2ya3iBlGLIw4UGgL3IoyxM01sVvOmOHzEHr90JmlcWPJqXt1z
         KVy1Ejoa52qHF8UA19yKmCalFAOzej6H+7PlG1AVFVq04YekvGUzw4JVjh53rLc+bLAG
         O4vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762971674; x=1763576474;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+dJpJWnR6W2PauvB5c9FgPR6gGTYegkNj3iOoqqoWtg=;
        b=SxEFwsJf4ACU0qYvLuMegvfNlPNH1d7X/Gc37o4gU9IpKUriU5EpnNoqBMg1bcUyZt
         7uGlxuLf8DHm82ske1TiowCxGtxKTuEXZcXEFNldZYm4FPEppCmfhioWhroVxAADMDR8
         NLHImTqYyzlKxc8f/wJK9LDo8iUIfCOKAP83Mtc2gNEqB4JU3d6sHGVfhvTzvTQT6Sbw
         2z+TpVPHk64c5Brj3NxsYiOcuPWk5DVOlmtOZPWMMuDcnr6ZBND1YwM7Iw8frhMeBrHP
         siYHca2tcFjsq+rA6TLfkMoeP5bT98c3Kj78RF2QMS2gIXPAiDpQXxIamYjE2kFlU2oR
         oOIw==
X-Forwarded-Encrypted: i=1; AJvYcCXtIv7n1y9mlmbktiJhr2wKjMogPqF7I1A0cm+Pey7VnfZKfMfimozz9laQPccofYtQTGV2sPzOnor/iP8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpsSLEUNJ5nUhc11nSddLOxFc/9dv4w6OrVIZ6bfo5vfQnZyIb
	cjKZ9+2+KuL05k/xlBxSRIYmqQTQCDNslyDij03M08AgJglCDtTKlb1e39E76ta9vX16r3ulp51
	a+SLgDuiGq152DGasySaaByrWzxltKET+7dfQeJ8BBevtxpXG/r+56NhUVKu/TrbS+w==
X-Gm-Gg: ASbGncthiAcqieoueDh+Gjg6OdN2mDJE6iXh3Q+68szQ2exkDkHOODM6xbQaTQH0CJW
	RX2e8UQAxKhFHbWCN/22fPvOA90rpYI2o0I2o1lF2hEKTGYDJe48jUL9bLpcR9PKn6NWCzSHixH
	gwrdv7iuNUQFwPHFCKdiIGi9Av6YwHUbJzEcJfPl598UQPBnh0a6b0D5bn4Or4ZrXqBUXsL2L7z
	ArGQldGbChy14/WtDG+siJUlvEvc3MrPzLsWNKqmquqvB3G1RExyDmjFeSoaa1LyU4WfOTGzQUE
	Wq3J3mYdX9zVH1/mGc6F4VW5u2Cv3/jPoeKQSBgPQKAgI8xtBgx0h5z9vtx7ZU39NQQTHk26cow
	8s6w2c7aQKRjCMIetbpUFqNFburAT35qYyJNPFuQ1E/ipyA==
X-Received: by 2002:a05:620a:3189:b0:891:ae32:d696 with SMTP id af79cd13be357-8b29b82bdaamr491394385a.66.1762971674376;
        Wed, 12 Nov 2025 10:21:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFmk9lfZ7Dqn8dctjmk3Q6bmGkgKiuUiM1dIje3DZrti/tFNHBsEkMGCydCnh8k8ZsuTO/tAA==
X-Received: by 2002:a05:620a:3189:b0:891:ae32:d696 with SMTP id af79cd13be357-8b29b82bdaamr491389785a.66.1762971673918;
        Wed, 12 Nov 2025 10:21:13 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b29a85e0a9sm238798185a.20.2025.11.12.10.21.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 10:21:13 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <318f1024-ba7a-4d88-aac5-af9040c31021@redhat.com>
Date: Wed, 12 Nov 2025 13:21:12 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cgroup/for-6.19 PATCH] cgroup/cpuset: Make callback_lock a
 raw_spinlock_t
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, Chen Ridong <chenridong@huawei.com>,
 Pingfan Liu <piliu@redhat.com>, Juri Lelli <juri.lelli@redhat.com>
References: <20251112035759.1162541-1-longman@redhat.com>
 <20251112085124.O5dlZ8Og@linutronix.de>
Content-Language: en-US
In-Reply-To: <20251112085124.O5dlZ8Og@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/12/25 3:51 AM, Sebastian Andrzej Siewior wrote:
> On 2025-11-11 22:57:59 [-0500], Waiman Long wrote:
>> The callback_lock is a spinlock_t which is acquired either to read
>> a stable set of cpu or node masks or to modify those masks when
>> cpuset_mutex is also acquired. Sometime it may need to go up the
>> cgroup hierarchy while holding the lock to find the right set of masks
>> to use. Assuming that the depth of the cgroup hierarch is finite and
>> typically small, the lock hold time should be limited.
> We can't assume that, can we?
We can theoretically create a cgroup hierarchy with many levels, but no 
sane users will actually do that. If this is a concern to you, I can 
certainly drop this patch.
>> Some externally callable cpuset APIs like cpuset_cpus_allowed() and
> cpuset_cpus_allowed() has three callers in kernel/sched/ and all use
> GFP_KERNEL shortly before invoking the function in question.
The current callers of these APIs are fine. What I am talking is about 
new callers that may want to call them when holding a raw_spinlock_t.
>
>> cpuset_mems_allowed() acquires callback_lock with irq disabled to ensure
> This I did not find. But I would ask to rework it somehow that we don't
> need to use raw_spinlock_t as a hammer that solves it all.

OK.

Cheers,
Longman

>> stable cpuset data. These APIs currently have the restriction that they
>> can't be called when a raw spinlock is being held. This is needed to
>> work correctly in a PREEMPT_RT kernel. This requires additional code
>> changes to work around this limitation. See [1] for a discussion of that.
>>
>> Make these external cpuset APIs more useful by changing callback_lock
>> to a raw_spinlock_t to remove this limitation so that they can be called
>> from within other raw spinlock critical sections if needed.
>>
>> [1] https://lore.kernel.org/lkml/20251110014706.8118-1-piliu@redhat.com/
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
> Sebastian
>


