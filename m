Return-Path: <linux-kernel+bounces-898637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DF241C55A16
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 05:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 20D9C4E233F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 04:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7CB29D281;
	Thu, 13 Nov 2025 04:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M9acG6bA";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="YiRJbblu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD3E2BCF45
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 04:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763007144; cv=none; b=uXi7JJCIjooMWvXoiQI01eZ5BaDXNVug/JFxnVlfTU9bu2q9O1hkIFvH/THTtTG+5fW/hH/RtQFZQqS8xhSgW0qs2L7PSNiRwliS1aPKysLqEp8SQn0IN8mxjmU1ec90LyK2MLpavPvZSavqksGgIjvKZK1bNMb4b7BZkhdSjIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763007144; c=relaxed/simple;
	bh=5KVcUwFam+d3kfWZaKYqsgN5CXXYEyx0nSIK4JVGF1c=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZxKflRIsvkULbry4zyoV9QWxYF/KpCmre6NmvkPTH5S4Mo0SC1G/01eOGyirlCgfddGVayvjr7jarXCWdJOnHEn2atT3ui0dcfq/JcXATH5idzYrP4GyVJyrzZrvdUJlSPQBbszAhX8GxYDt0fLVEjoBOHrvahKysC0jaUzr0dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M9acG6bA; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=YiRJbblu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763007141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PXF2BvFrpcJte5UaMjynGshHJ8MIVF48yxM6S+pDvV4=;
	b=M9acG6bAvyZd5+s0mMLdLKMxQmD8Zkt2fGQxdR/fqMirTg/GcnZlggefx03AaOkv6iNd2Z
	SDG/ubju+v8WEHqWDnDgJ22wA/T667BkZemEvdf9kd35YZ1k0TIMWMcDEauFZ/3vHeOFO8
	GDedTNRCYJEKoA4FKNulSJmAGtG+VCg=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-163-NIbUvcDwOYax-75PQqVcfw-1; Wed, 12 Nov 2025 23:12:15 -0500
X-MC-Unique: NIbUvcDwOYax-75PQqVcfw-1
X-Mimecast-MFC-AGG-ID: NIbUvcDwOYax-75PQqVcfw_1763007135
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8826a2b2d9aso13416776d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 20:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763007135; x=1763611935; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PXF2BvFrpcJte5UaMjynGshHJ8MIVF48yxM6S+pDvV4=;
        b=YiRJbblusMl0T6AQKNqzBM00P628i/eBpaDgGFXuoFGV1OyHPbO+9QhLPMWNdznaCO
         hwjjsdyasfWYPzvABQDVcAG8XVRS4MG9wWEFGVCaw9NfaJxFf9ZCgrr/29qSuoG4pwKo
         IOSmDWOPDDXFySES9PoFH88/LehNn/nlyo4BTIycZJV+oNBZe6slEcXXOb2nwnsw7mMW
         OEp5ZNyvPFyf/LKklj7i+gXrJ8qjl5nwW+96HROfKgjISpVU8XMXg4wvwurR5lwuFy6S
         /AXNaioXuGeIgnfN305mghZH/XBV0pPiph7AAuIYFBB8xWZG0IcGKzJ05W9rRpyaGUhy
         ixFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763007135; x=1763611935;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PXF2BvFrpcJte5UaMjynGshHJ8MIVF48yxM6S+pDvV4=;
        b=EAws9xWctGaWYLp9FluCZSPxL33mJA8QActd4pz3daGrPtylvrL86lJnULKrmozb6N
         ge811Nrygfyg3mtU7H3qtBVRheZWTxItdPDi74R0zZZUl+u1mHqjTa1zHdlDSLxZ5hEs
         dFOeZS2+s+WXU4+pfUCwgQdDD/sGHvHIxzwZL2gAXqodqzh36yDH+SD0U1ZTKT5Cnf6U
         NJp9Egl7vvwjSpbUfyM/K0vqh9r/zg6euNTqu+S5lGi6JTHncoxYGJ7+J2oXwffbbKvc
         1CVkjZAW8O0pBIDwI1FJ1He2xSvMTxumJ0aaQ8iPyEmvYUXvWl05FbHCTRLkhRtM7+d3
         7Ggw==
X-Forwarded-Encrypted: i=1; AJvYcCXEtTXuXhKzQTZ917EDTpys+tcnhjiKfqIhuq+hVCetAbFGAXhS6dQmJGb/A2xm98yJtuFOcX0zY0XZi+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRwAFPnHrPwLnLp0GTT8bjSedr76paHTVIbTlGr+Ahc/rHWQQZ
	qtkgB5SBt+8N6dzpSk2ag3fk/kiB1VGnAOcdJfB6rcizkhzY1f/IwkSubNyuOnacfh6pUurOcco
	EJsgZi+KzKRntuGov8q6GsN58wykaqxSvnREZsBEBPElFXDnk9KeJWRMM/DJW3H/tAA==
X-Gm-Gg: ASbGncubj1K/I2ssOItWzYCovD/jruo7W77aprg+GZlVqGxAyQw3AMoLUJY48RXSUdk
	kmXlSwx8PurOtIXY37bgUWGnBVdHHBGD0BWq6CtSt1jGafGzbfcIpHHhVspmTW/IldVlURfN2C+
	yA8BLZ8ilRVBwUOlXGOnl2PT3uj+FDM8DjC2TWBXcoEgfZN6SwK1hBpQJHKPDvLjxj21/EKdVmU
	pzVff4+RJx3BzkEy/EIKhzTBIWquU5GRbVFU+FxM7qveQHGSh4xmq73G41g14P91nJvWaLgVBV+
	3y3aW9Tkxs4DZfylB5MSAu9g+6OGUds8hFF06K0YupY9KhYZNM4mf1XMNeeEFM8po4YXk+JKW27
	/Yf9Rcbck2xUvheIg451LxSDeKAC9ULkXNHXEavjQ7upfNg==
X-Received: by 2002:a05:6214:1c48:b0:880:4bdd:eb99 with SMTP id 6a1803df08f44-88271a39bf8mr81658456d6.50.1763007135029;
        Wed, 12 Nov 2025 20:12:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGRDhCLizq1RLY3ln4mDWmpcPMOmzDiMDvejsHPgswmKFEfCLHM0V9nS2E9rZHYrxzUs/bBHw==
X-Received: by 2002:a05:6214:1c48:b0:880:4bdd:eb99 with SMTP id 6a1803df08f44-88271a39bf8mr81658336d6.50.1763007134668;
        Wed, 12 Nov 2025 20:12:14 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88286318333sm4839906d6.24.2025.11.12.20.12.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 20:12:14 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <b97e1f53-3b6a-4d2a-82fc-3150565e266a@redhat.com>
Date: Wed, 12 Nov 2025 23:12:13 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] cpuset: Avoid unnecessary partition invalidation
To: Sun Shaojie <sunshaojie@kylinos.cn>, chenridong@huaweicloud.com
Cc: tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, shuah@kernel.org,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <b9dce00a-4728-4ac8-ae38-7f41114c7c81@redhat.com>
 <20251113033322.431859-1-sunshaojie@kylinos.cn>
Content-Language: en-US
In-Reply-To: <20251113033322.431859-1-sunshaojie@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/12/25 10:33 PM, Sun Shaojie wrote:
> The reviewer mentioned they couldn't see my original patch, so I'm
> re-quoting the key changes below for clarity:
>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index 52468d2c178a..e0d27c9a101a 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -586,14 +586,14 @@ static inline bool cpusets_are_exclusive(struct cpuset *cs1, struct cpuset *cs2)
>>   * Returns: true if CPU exclusivity conflict exists, false otherwise
>>   *
>>   * Conflict detection rules:
>> - * 1. If either cpuset is CPU exclusive, they must be mutually exclusive
>> + * 1. If both cpusets are exclusive, they must be mutually exclusive
>>   * 2. exclusive_cpus masks cannot intersect between cpusets
>>   * 3. The allowed CPUs of one cpuset cannot be a subset of another's exclusive CPUs
>>   */
>> static inline bool cpus_excl_conflict(struct cpuset *cs1, struct cpuset *cs2)
>> {
>> -	/* If either cpuset is exclusive, check if they are mutually exclusive */
>> -	if (is_cpu_exclusive(cs1) || is_cpu_exclusive(cs2))
>> +	/* If both cpusets are exclusive, check if they are mutually exclusive */
>> +	if (is_cpu_exclusive(cs1) && is_cpu_exclusive(cs2))
>> 		return !cpusets_are_exclusive(cs1, cs2);
>>
>> 	/* Exclusive_cpus cannot intersect */
> Here are the main changes, where the conflict check for step #6 in Table 2
> is performed. And these changes have no effect on cgroup v1.

cpus_excl_conflict() is called by validate_change() which is used for 
both v1 and v2.

Cheers,
Longman


