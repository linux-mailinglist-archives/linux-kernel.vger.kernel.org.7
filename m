Return-Path: <linux-kernel+bounces-896481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC3AC507C9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 05:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0D9F34E52BA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 04:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B382D3231;
	Wed, 12 Nov 2025 04:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iVZld2PA";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ekFg/j6a"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36B82C21F1
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 04:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762920576; cv=none; b=RFyuok7ibICfb8O/j45FIaWf+0Ql7fxkLCCzzUuFSQgga55bHi9EWcM9+BS412v3cDV1Y5koEX83sQlQ4lmrYjWm6AO5+Kcu50CCACtzc3ijCMBdhEwRj1eXOwtbAf354v5C0hHCk+RTbUkcffOyS3H+8n9XwHCEnBglh3LAyYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762920576; c=relaxed/simple;
	bh=9PW+A3JHWzURTlDXLHDmB0OKXZRnM2OGKf4qPL38i74=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=p22DTwIvQ1ojp7rSkuj6W9ij7NaOmFgChr3AeidVZwAbrealgCP9DOMc85E/isuHY371FJjrLRASvvXSZqg7i+AsopP0oitVViWCRpb6Mul+vBSuRTV8HQjiqBDW+K6tX8jgYy1NThDGcTT8ZAd64glCkGqfwV7VsCyTjQtCXtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iVZld2PA; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ekFg/j6a; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762920573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jBULf+ZIkA9FqHKiIs1320k4feJF2I1rgP/b6d4F0Mk=;
	b=iVZld2PAXjpRSlGTe0cH5HmVZ7v+UYe//tagccXLrsM8Le4IMe23vWbNtoFPhWZ1kY4cui
	bjnNI8UlLVTXreSWMSXEYj1CPWRBFgbcmKjg5UIYP3ejJWBC02NT8hxCy3gf+uIezeIafV
	UtyE/GiYSVJTfcGu+dr99GDHf+n9/HE=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-d6eXpE3AMB-ILyyG_JW-ow-1; Tue, 11 Nov 2025 23:09:31 -0500
X-MC-Unique: d6eXpE3AMB-ILyyG_JW-ow-1
X-Mimecast-MFC-AGG-ID: d6eXpE3AMB-ILyyG_JW-ow_1762920571
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ed74e6c468so5223311cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 20:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762920571; x=1763525371; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jBULf+ZIkA9FqHKiIs1320k4feJF2I1rgP/b6d4F0Mk=;
        b=ekFg/j6aJfbuCI/fUdbBHYO8FmybPehHCL7m55Fnh0HjygoTnq+HTAe0eYnXO+75oz
         Fc/b/tdXULJVMhXcohj3c9qQols4VKsA1uFCztCyQgeRvso/io1K3UYQOljc0E7lPLOC
         a7MkjAXGg5R/2WA/oNYIs38rFTE2fgEU6SPP7l+txRfcjQccaIN3MMVprsaiGheYPSRw
         2uSTJBPY6bHhz1IPfk0FC7zX37tPfX7h76Lkz4aggmGZbmos5zAqXRePPhu+9+HUHeRQ
         8egx2jc37454HovImtru3UjyT1psiGVYihYQnxj2zGv7G+hS/9k9nQHJj9x/0KlEVR2A
         g//g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762920571; x=1763525371;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jBULf+ZIkA9FqHKiIs1320k4feJF2I1rgP/b6d4F0Mk=;
        b=dyNLic2qpGSbNcknhvDMcJPUrm8A324/APwoGaVzjsFPmMbKWSvM7A30NQDM9I7dIF
         bX2ww1KYY+i7XCELwUvVRnDprd+V2mA01+Pg6O6X6qM8Bh+m4tf3AXB/+zI3vB5d3DG9
         VzYXMn8fl7DVQN0Opt7QAK9LfQqfKfNqS9toZtu/8UGIXr4WVv7vvHlRUjfnVxkbyO9b
         DqhbKxtxKUohJUoNoIJrAmpX6ILUrYlxk9aDvU2UC4mMD2I2hH5smQl5EzI/KmGrMxrB
         vN3jSGkMQYThDQr4Jy88mOV/uClgbO9VgMXbhDvBJXCVhghSDu/ylQgcuYJp3SiVNs3c
         9LRQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6IoxxZV3IPD31nUCG9L9uW7kT92yEpugAtPMqgqEE7xs9Ybm1tAjfOXf653ws1D4WEKn+9isFQAbCutw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5IrjuIBb6mOLsuIXQkQwpcOQIMYNp8Xu/hIZ6iJ23EvJVlU8T
	b/KjIG9MOeI3s9N3UQW5+HADyGGoAM64lAbRQQ9lyB8PBItjzWJlhalToTf9ZqezwCIJgoZTHFO
	Zp62f13/CvzEKPeM/H9nYpZ9Q80uEDGXiavWBij9yd/MELy5XrpSR7Xe97NyeDg3yTw==
X-Gm-Gg: ASbGncv9XH7gX12xYzVcGbLTLP4rAVUzASxSwMxmoxKzG+poXihBmfXHBAAEzba+6Bo
	D5zs+YdqtqI7EMK8dDkeO3m4VqEYtlXaYiOB/cYnMMRaRVuC0j6DKctf8f9aBvWTTE6MrNJW81+
	nuXOihA5Zya0ZOltU1fCiLDNpblFvJLSRDvqIU+pWBmRiMGZw1NmajBPtFI7iZjF8zOtXo4Vlhn
	EaWL9c/TiFT2CkXx3+X4lD7FcOatgYoe3LmR9qfC1fBYHZ5hGCXTX67E9kVzolKUkZmUPkJ6ynS
	79wKTzQt2UEPfI/uehusnSWKF6FcgB0ffmlrrF5kTRPgLbaePrHcKQzJ3kEGBVlf7y1kDN7r4gx
	Xkg3TuzR+3tPi6iRTCTH2AT3Q9JQvrxRqQA2BZCGEjQ9FWA==
X-Received: by 2002:ac8:5a15:0:b0:4e8:ada0:450a with SMTP id d75a77b69052e-4eddbd774bamr18423741cf.45.1762920571007;
        Tue, 11 Nov 2025 20:09:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGPWTMesD++oG9Eb6d/7De7HTmZLuSnw0p9oUBYq3+RbK0SLKI1SdBODf1yz+ndvuVag3fpAg==
X-Received: by 2002:ac8:5a15:0:b0:4e8:ada0:450a with SMTP id d75a77b69052e-4eddbd774bamr18423691cf.45.1762920570668;
        Tue, 11 Nov 2025 20:09:30 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4eda563fbfcsm77229701cf.10.2025.11.11.20.09.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 20:09:30 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <b9dce00a-4728-4ac8-ae38-7f41114c7c81@redhat.com>
Date: Tue, 11 Nov 2025 23:09:29 -0500
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
> Does this rule have any negative impact on your products?
>
> The CPUs specified by the user (including cpuset.cpus and cpuset.cpus.exclusive) can be treated as
> the dedicated exclusive CPUs for the partition. For the cases you provided, both siblings can be
> partitions. For example, in case 1, A1 can also be converted to a partition. If this rule is
> relaxed, I don’t see any check for exclusive conflicts when A1 becomes a partition.
>
> Additionally, I think we should preserve the CPU affinity as the user intends as much as possible.

Where does the original patch sent to? I didn't see it.

Anyway it is late for me. I will take a further look tomorrow.

Cheers,
Longman


