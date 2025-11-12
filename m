Return-Path: <linux-kernel+bounces-897767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C0FBAC53885
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 17:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E33D0502876
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939CC33F8A4;
	Wed, 12 Nov 2025 16:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QqqbRQys";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="U4ogwg8j"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D59E33B977
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 16:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762965627; cv=none; b=inAbglyMu9nfun/OC0AKBbp3QCOfNqZms6tG22bu/28gkHR/RqAaE3YbAPP1GeOMYKa69/ssUuR7JHGGnEn8r/78BwJs1H9e1R6jV06/QHfOrqle8N0E+/z3zgg5+YwOgoUZyvoMK8d8zWixb416oC+fAjGVKK8dqego42mZp5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762965627; c=relaxed/simple;
	bh=NPKmesSgG0k5cHihrVZICOAHxzeS6yl0o6Q6Msfzyf0=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=WLKeoaRbsHegg4OhKULcYJKG3fElwPo97J7/04hV2p84DzljwewRkH8gNmnS2R/dFydg9Sq7ErcpSUgnIYLRQ9Vtb/w1qSXH62Ugohbx+XFPqh4J0pd/VPdqHoihA9vXDFVxjoaljwihAXQ3DoiM2J300uMUI2tYsVlpbfL23io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QqqbRQys; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=U4ogwg8j; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762965625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a54XX/ax76HZixMaF/okaC52MUDpaFJIGlkFp/l1jwo=;
	b=QqqbRQystCACz+o0nIRnSxIyxalNjjtxCH5G7TzQVTQebceczJnTFogI1xrkaYlemIC2F6
	pn+n9gXZTI7x20Jqh6xnLyulmOjMSl0ogrZvLqeztJPX1eRBYie84P+6lpMmV4oE74EMV5
	NcXmMTHQPwf0T8iH84KZx/WgYKUwU5c=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-esfSW5VcNgu5VdLK5O0G9g-1; Wed, 12 Nov 2025 11:40:24 -0500
X-MC-Unique: esfSW5VcNgu5VdLK5O0G9g-1
X-Mimecast-MFC-AGG-ID: esfSW5VcNgu5VdLK5O0G9g_1762965621
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8b2657cfcdaso135554185a.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 08:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762965621; x=1763570421; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=a54XX/ax76HZixMaF/okaC52MUDpaFJIGlkFp/l1jwo=;
        b=U4ogwg8j0AkH0dSCF16QZLstcV5ZtOrLLgzfytX0ey0f+aDo6nI7UjT/4mLSN+1rch
         I5oPWSCFEWiwN5zNGLA5tf6LY7p0aoOo4tE6+AMIuABCxpjChI+t/B03dHZtdn8VmRQv
         6WYcRZpAeM8PFbYJ5GsSxcgbGr5ZZNpWzcNU4nTpRU68EaS8LkpvLKhfs6Hm64Ansxsb
         C6ShRFRlGcXfbXsQZa+wc37LLumw1hrDT0/QI8Kv8+K8Hq40PAgpeTPiOxCmm9mICVdd
         t62e1ga2v0npHM4tBcXTgw5rBXmqHiHa+B3AtenWLTIKQetr6Bmq2YxwZ6dat7kpNn2y
         7Aow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762965621; x=1763570421;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a54XX/ax76HZixMaF/okaC52MUDpaFJIGlkFp/l1jwo=;
        b=wHzeRIIg33huzsy+7JLEqvzZxARg57YnhAksr4I+9KMP4Ur2EqGhhJ3gKff5MbI7Gu
         mmLee4adspualWWAZS/dP0Nb4dpT+ryZ3V+LJAr+0Duy11/YjkKlgy01kFWbyR2jirBL
         jef5cfq1YNPKIy44PikoRysnLMG5cGmJgjckGh+HN3GIZsRfxp0WuXSl1YnpZuO7R9Z7
         9hfTNc/fra0eoVTiky6CzuqT2etX6yb8pTySJrppNTKGl3eNwaXKX+uUZMuRzMiy9Qtn
         oCPg5MJW6tY7RcyxoXDH7X0raBckuFcivVdisOzGPD3s5mdETQuQx82XrPxwfy7Pw2tM
         YNlA==
X-Forwarded-Encrypted: i=1; AJvYcCVKlYiz8kDeoZuGF/cBRDnW5x/bfjJnU8DfCRmEHyZ1ExyCzPNHpCYryrDSaJQm3RRDrDgbJJEvx6fgp1s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMaQCQTM+BcoG1uDqjS/npcbhxixemUAxMDwmv/dGSSG/3Evxh
	mRvQiE+kW/cfujU8GgNNO8jhLp8HJddonJSi4y5z6i6v1Zine5uWwbDEhAfVilD3crtiVOJYjsY
	6ykCrDNJgJM42w9836m2VUL33qzicQE4VsObdKVieFtQDCyQgCSy1bmnEBjKGpvqdP0ijiX9bQg
	==
X-Gm-Gg: ASbGncv5jxozZNR8Cs9tpGr1Ag7DKAjav/6VqhLLGmwPYISoFvfDbhK2kb5KxGMyhBO
	1ilcsN7/OwhosoKFWIOl9gif92siIGScpVCBdDPLPknWMTADjIov0ZByv21l0pbBNWoT7Y28W/w
	ChlCJHmsegI5fszUsBsDqj96E1IhLFLtEnajavIInyHp4dOh4WeOhEHqTS8h0p/7q6LGyjrOX6c
	Oqv2gI5CyS9+PlArfGZUZDLMkvicComAbx/YMrDWnDWoW22fHnGxQR2nV1ZCQdHCGJjjIiwkL3J
	1YQ2krcm5VzdE7KKB+2jbJROmPBMUT0FKvnaMaiukSTAsNj5yDoeNI73ojzwXUXy8u/bYkonxNi
	nw1rKimvwVfLk8yJ6KGrqh46o/VYOJbBdmBqzjKrl4IPc3A==
X-Received: by 2002:a05:620a:45a7:b0:89e:99b3:2e9f with SMTP id af79cd13be357-8b29b7d96c9mr432074585a.54.1762965620706;
        Wed, 12 Nov 2025 08:40:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEeRHn0TE7WSuy/RawTo+0uqdbnmzeUBkTfUMKCdOV0bkTaq6MIRt0f6pTVYA0aGPlXvo+hcw==
X-Received: by 2002:a05:620a:45a7:b0:89e:99b3:2e9f with SMTP id af79cd13be357-8b29b7d96c9mr432071385a.54.1762965620280;
        Wed, 12 Nov 2025 08:40:20 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b29a85e0e8sm222910385a.15.2025.11.12.08.40.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 08:40:19 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <c8e234f4-2c27-4753-8f39-8ae83197efd3@redhat.com>
Date: Wed, 12 Nov 2025 11:40:18 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] cpuset: Avoid unnecessary partition invalidation
To: Chen Ridong <chenridong@huaweicloud.com>,
 Sun Shaojie <sunshaojie@kylinos.cn>
Cc: tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, shuah@kernel.org,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20251112021120.248778-1-sunshaojie@kylinos.cn>
 <380567da-9079-4a4d-afae-42bde42d2a58@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <380567da-9079-4a4d-afae-42bde42d2a58@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/11/25 10:33 PM, Chen Ridong wrote:
>
> On 2025/11/12 10:11, Sun Shaojie wrote:
> Hello Shaojie,
>
>> Currently, when a non-exclusive cpuset's "cpuset.cpus" overlaps with a
>> partitioned sibling, the sibling's partition state becomes invalid.
>> However, this invalidation is often unnecessary.
>>
>> This can be observed in specific configuration sequences:
>>
>> Case 1: Partition created first, then non-exclusive cpuset overlaps
>>   #1> mkdir -p /sys/fs/cgroup/A1
>>   #2> echo "0-1" > /sys/fs/cgroup/A1/cpuset.cpus
>>   #3> echo "root" > /sys/fs/cgroup/A1/cpuset.cpus.partition
>>   #4> mkdir -p /sys/fs/cgroup/B1
>>   #5> echo "0-3" > /sys/fs/cgroup/B1/cpuset.cpus
>>   // A1's partition becomes "root invalid" - this is unnecessary
>>
>> Case 2: Non-exclusive cpuset exists first, then partition created
>>   #1> mkdir -p /sys/fs/cgroup/B1
>>   #2> echo "0-1" > /sys/fs/cgroup/B1/cpuset.cpus
>>   #3> mkdir -p /sys/fs/cgroup/A1
>>   #4> echo "0-1" > /sys/fs/cgroup/A1/cpuset.cpus
>>   #5> echo "root" > /sys/fs/cgroup/A1/cpuset.cpus.partition
>>   // A1's partition becomes "root invalid" - this is unnecessary
>>
>> In Case 1, the effective CPU mask of B1 can differ from its requested
>> mask. B1 can use CPUs 2-3 which don't overlap with A1's exclusive
>> CPUs (0-1), thus not violating A1's exclusivity requirement.
>>
>> In Case 2, B1 can inherit the effective CPUs from its parent, so there
>> is no need to invalidate A1's partition state.
>>
>> This patch relaxes the overlap check to only consider conflicts between
>> partitioned siblings, not between a partitioned cpuset and a regular
>> non-exclusive one.
>>
The current cgroup v2 exclusive cpuset behavior follows the v1 behavior 
of cpuset.cpus.exclusive flag. Even if we want to relax the cgroup v2 
behavior, we will still need to maintain the v1 behavior as we want to 
minimize any changes to cgroup v1.  IOW, we have to gate this change 
specific to v2.

Cheers,
Longman


