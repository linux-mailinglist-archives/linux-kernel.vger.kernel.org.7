Return-Path: <linux-kernel+bounces-897876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 06595C53D88
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 19:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7DCB0343A3C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 18:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E4B34A766;
	Wed, 12 Nov 2025 18:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g1pHKZOy";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="fvBBqqqy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B04329C64
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 18:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762970723; cv=none; b=qGOJ+WkwbKGQOO+L7htefjiHnIzic5iNUehVFsVRO0VNrujxgj2F7o/iJVLdlp5ctS28igh70vbaU3S6UwjLLwqcLF2h9WgDZhgEfMreJlxfLbsnaTD4Rt8Z9daaCzBGpQV7MN1cgXMsxz7r7PecrF2HVVh8dK+UAHZv7soiZlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762970723; c=relaxed/simple;
	bh=ko5BbGl6a9fQFlBxeoKvlk91k6qFsjA2qTndHaSt7YE=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=u4qjnDgMHt/bjlqcEaw4rnqsMDAm3k6kVxCYlSaQkSyW1dY76aTxdBx/5TglcFTjbQPopu4565wpYInab1LGUS1Nsy6gqknTLX1MgNGh06ha4UvUmsG2KQyQyjnmvzsHHa2s0X4jSdribdFwlveDVCZTs12wvONQ3jyxbDOoA5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g1pHKZOy; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fvBBqqqy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762970720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0Zn2uqlOqkTGm+7Vhf+JluqFYrDljO4Zyy3TKQXkdTw=;
	b=g1pHKZOy60hG/jVhhK7otWbiJpJWQz1qXEl6a76aIU8p9M8vhu/ZbMO0LwTb5jBw0hjIj5
	JZrfIsmmnpPtZlQQwa/aKp28vG81yBZbrlfkGlFTaL2qXIm+AC6DpsN4vXQC39rFB/zawX
	RCkFtqvRNWH28y5cWqA2EUvB8XqrABI=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-pz7MdbRrNcOzBNsNAkYZ6w-1; Wed, 12 Nov 2025 13:05:19 -0500
X-MC-Unique: pz7MdbRrNcOzBNsNAkYZ6w-1
X-Mimecast-MFC-AGG-ID: pz7MdbRrNcOzBNsNAkYZ6w_1762970718
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8b286006ffaso322920385a.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 10:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762970718; x=1763575518; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0Zn2uqlOqkTGm+7Vhf+JluqFYrDljO4Zyy3TKQXkdTw=;
        b=fvBBqqqyTlsxOIpJ9UPap7LmW1Xe5fW9YUJV3oCBJ1KX1CFIaX5xqLNBDGrE7gge5Y
         O23qi8y+k/5Okr59fUf/XJ/xTSlxUh2UsmSta2Yzr8xtp33E0JCsZ3Wqjk4402bP3pQa
         N+dmz4M8zr/G0Y2E56IAN9pe3sJkpxUlNJ7hYJIpXEot8BZ6eqO+cfKWL+T3TWNneOwZ
         MaMEXMvUkwX6xO4PPRDYphpIJB7/+2tZhjfJ/bt1IIGUpN2TE4da2+m8Q3WHXkrgoAyZ
         OESEdmlcK0rpnVjrCSdbYp+Rax+vRgEbFheMfR/h1HpG9m3Z9n+jZR3RKTPKhBcxUQOW
         PidA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762970718; x=1763575518;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Zn2uqlOqkTGm+7Vhf+JluqFYrDljO4Zyy3TKQXkdTw=;
        b=LGVxKSJR5LyH9oSv+1TW3I+cI8xW2TU1teYJVFBfvoJWVHnbKQ/WBYRDYj6UCzlUxG
         TXVjw8N3bQ3LUnEdBF1HxOIYIHWyqp0B/D+vumf646FofyjW4yqW1OYkyAjzDU6CR8VN
         OJj3+kjIb264Vm3boWSehviro+/i4x8iO7o4iUJTkUgPF0CU1jSUx4jizFbcER++g6OI
         C/Uo6KD+6QrnHq8VAjxRdGxM++LtIsFDQAVH7XfxMRkaMXlmSsiDIXd6bluob9tziTo5
         yoa0jTtEyHBXeLIKEK+5oI7hBGQ363yfJx/O5A8rEe9xLlngUOhysYHXF6mADgs0Rjns
         qpaw==
X-Forwarded-Encrypted: i=1; AJvYcCWB58d/9xHhxM4eJ3u90efF1v2IYm87XT0iSOEnwIaqysZ5gB3SWIWwpIUwHBVwOmUCb4rLIyrRG0l+RCY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOjay+3FavDduGVTwIYyP37FZhKI09Qf7UtnqC8+DYp1tYq+Au
	qW7X1ELldHA08XYlWjbiDEHcderfC95vQ/Viazaq3AccEfQdv8DlvGS9cho17FvplwpkhH+a7pa
	vKZW9wnfsTMeU/rFsPvePe4Ed0kmDAcx1d1wq9IdiLBdtwbcvXLpxrq8oCDx38pop4c9QT+UHKg
	==
X-Gm-Gg: ASbGnctXYJA8bLHU42RBOu6liUsOaXlO+BHX2lV4rCiXq6V/qsx/ENFZ/AVE1QWzrgw
	wxC9YqPjQtgFOaL7QyDQKro+Q7OFZcFIhxQPeAWwPPiBMLaQgZv0tfnUK8rwF35j1aYZYf8kDlV
	4dOs9U7+ORTStH6z9xMa/+n/Atet36hu8y6P7yQ0t9XuEiRnctZgzLDfJ8/JgN6lCvo6135q0BE
	THZMtQLHwTxy2vnnp8HN+v5n1ipIJkLTGnkeqa8lRYXVO3mPWWIUrgo9NXIOr8ixRPN3y01X0PX
	gi2Uq/A0XN9BZRrJAINCj92qRYuXgZw4nkZso92ZCbLtGfte/R279/1UcLMwksUmgUCIwaY2zng
	2Fq6zAdKq/ApbvE4VvOlZJFWxf/3h2r1OyjnaeYplfxMAtA==
X-Received: by 2002:ad4:5f49:0:b0:882:4f53:ed41 with SMTP id 6a1803df08f44-882719e6978mr55688886d6.39.1762970717996;
        Wed, 12 Nov 2025 10:05:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG4IiIw+N1Z2Q8t2UVNI42KNkJKyBdYBTSzcbCJ42RBQAZsdIZ+JdFm9V5TA71Qksd6vDNtIw==
X-Received: by 2002:ad4:5f49:0:b0:882:4f53:ed41 with SMTP id 6a1803df08f44-882719e6978mr55688206d6.39.1762970717419;
        Wed, 12 Nov 2025 10:05:17 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88238b293a6sm95893676d6.37.2025.11.12.10.05.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 10:05:16 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <85f438b2-5131-4794-bb2d-09ca611fb246@redhat.com>
Date: Wed, 12 Nov 2025 13:05:15 -0500
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
 <20251112094610.386299-1-sunshaojie@kylinos.cn>
Content-Language: en-US
In-Reply-To: <20251112094610.386299-1-sunshaojie@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/12/25 4:46 AM, Sun Shaojie wrote:
> Hi Ridong,
>
> Thank you for your response.
>
>  From your reply "in case 1, A1 can also be converted to a partition," I
> realize there might be a misunderstanding. The scenario I'm addressing
> involves two sibling cgroups where one is an effective partition root and
> the other is not, and both have empty cpuset.cpus.exclusive. Let me
> explain the intention behind case 1 in detail, which will also illustrate
> why this has negative impacts on our product.
>
> In case 1, after #3 completes, A1 is already a valid partition root - this
> is correct.After #4, B1 was generated, and B1 is no-exclusive. After #5,
> A1 changes from "root" to "root invalid". But A1 becoming "root invalid"
> could be unnecessary because having A1 remain as "root" might be more
> acceptable. Here's the analysis:
>
> As documented in cgroup-v2.rst regarding cpuset.cpus: "The actual list of
> CPUs to be granted, however, is subjected to constraints imposed by its
> parent and can differ from the requested CPUs". This means that although
> we're requesting CPUs 0-3 for B1, we can accept that the actual available
> CPUs in B1 might not be 0-3.
>
> Based on this characteristic, in our product's implementation for case 1,
> before writing to B1's cpuset.cpus in #5, we check B1's parent
> cpuset.cpus.effective and know that the CPUs available for B1 don't include
> 0-1 (since 0-1 are exclusively used by A1). However, we still want to set
> B1's cpuset.cpus to 0-3 because we hope that when 0-1 become available in
> the future, B1 can use them without affecting the normal operation of other
> cgroups.
>
> The reality is that because B1's requested cpuset.cpus (0-3) conflicts with
> A1's exclusive CPUs (0-1) at that moment, it destroys the validity of A1's
> partition root. So why must the current rule sacrifice A1's validity to
> accommodate B1's CPU request? In this situation, B1 can clearly use 2-3
> while A1 exclusively uses 0-1 - they don't need to conflict.
>
> This patch narrows the exclusivity conflict check scope to only between
> partitions. Moreover, user-specified CPUs (including cpuset.cpus and
> cpuset.cpus.exclusive) only have true exclusive meaning within effective
> partitions. So why should the current rule perform exclusivity conflict
> checks between an exclusive partition and a non-exclusive member? This is
> clearly unnecessary.

As I have said in the other thread, v2 exclusive cpuset checking follows 
the v1 rule. However, the behavior of setting cpuset.cpus differs 
between v1 and v2. In v1, setting cpuset.cpus can fail if there is some 
conflict. In v2, users are allow to set whatever value they want without 
failure, but the effective CPUs granted will be subjected to constraints 
and differ from cpuset.cpus. So in that sense, I think it makes sense to 
relax the exclusive cpuset check for v2, but we still need to keep the 
current v1 behavior. Please update your patch to do that.

Cheers,
Longman


