Return-Path: <linux-kernel+bounces-837760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E94B7BAD204
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 15:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C57A7A059D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 13:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85046302779;
	Tue, 30 Sep 2025 13:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H4hBMVo3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345E22FD1DD
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 13:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759240651; cv=none; b=HuLba5XDUoepMTZWq+wKf6pdJm4PjjbLwPRjsi+2VAA2c6DRSx0mr7kRgufCZE1Au6l6MbqHjD95qUodXtz0FehVH5CqzHHuSGaUhFVa2OeD0yCzSbrlkMkU+gpZrq8itYiaQrFvGR07to0TnvFtTGeU8g1LYvx2MTmRqB46L/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759240651; c=relaxed/simple;
	bh=BjipmKiYqvOMqy6wFOLf2B1TFV/73W3I8z7alN1lxDM=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ozQyY/Bajn93/aQJlLd0zmDWXNFZSCSB01Lx/2jMNZU2SANhSHDQPmmJQRVY0RK4mp586bZni1d76hVrWqtMetao8smXFzeQ3MjkuYKstZJMP4ha/V86e4jndh1K+fV1h8cumfrATIGqUh9Btwq27w/g5rg4VWxkMO43L2tzXmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H4hBMVo3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759240649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=StT/fwa4hIsTlxaXA0cy/bjyM8J68OtRfbRwReR7TO4=;
	b=H4hBMVo3zE7h/8xOsHOMdS5gxp2XA+l7dRyEzwhYuJuKk0zGzjy1/dl9qn3GhPUVdKOTx0
	JwNv0jOXE1X8c8I0S7Gg9YGjL5BrTn9KsPjpPMlwf1sJIj8WGMPYsYs9xoRP1T3J2uGfLp
	DXaHn8x3e//mHyfTKsvnor3d5rEAsMQ=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-mzhm7NGvOy2UMRwwWB3OPw-1; Tue, 30 Sep 2025 09:57:24 -0400
X-MC-Unique: mzhm7NGvOy2UMRwwWB3OPw-1
X-Mimecast-MFC-AGG-ID: mzhm7NGvOy2UMRwwWB3OPw_1759240644
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4df10fb4a4cso120675881cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 06:57:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759240644; x=1759845444;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=StT/fwa4hIsTlxaXA0cy/bjyM8J68OtRfbRwReR7TO4=;
        b=fCQRjb5TzzCOnbaW3VMIsFauGDE8Ec+5ounGQREkP+/FEfTIrQotTmHDNwRVnJeI7o
         p8OWJdkWjQUXAJ7xY+YlpIdWi2liD3zgP0GLtj3nuopus/KzP4syuumPRD3bUSy66zVV
         9Qrq7velXOEy6ACE50Piy+kZ6M0gohMq6KsWplMNVb/SNFkNu4pdY038bZow7yIOUIhX
         Eex96rAPsM1pF3P4qoR5AKVUCO1FD740wCYZRMuMRH9zxCg7m476HdzDA8Xqbao/0OOq
         op34AGjtKKnB/g5uF5p1TQrGPdUP84xCOvRA4GnRwJwqT03Mm4sYwJB2XhchX2Hi0BGq
         ayDg==
X-Forwarded-Encrypted: i=1; AJvYcCU5kK38LMVj5zqOYZ5bGDEQtzhcGxJKSJ4YFbyL4EDpOzqPI+QxNo6d9l0z4SmR6egtx4frlc8lctLVFzY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSGScE1/YqZ+N5wrGGOlERks5kjneFfgtPebsmiJNni3AcMiH6
	twddF4C2Dxwq+y1wPDRQYSgjjcdp7hfb12MAMYsMrxGlLBGs1RbbqlmjIsH+GYGN/Yk7kAY/Rb9
	yLt+YchQGuWNgyNadFjr6Mz6D5zC0aRfPtfLd1LnG5aW4jVpfNRNwt0rvmpnORckC1w==
X-Gm-Gg: ASbGnct/hcCiJIkg29dlKqMaGhRhHCAcwbxn/ebeaqW2lv24tZsD6fdUCE6ykUs9k2V
	gieg4MQ7D/4KcJqsRJG51cu9tG8uCMPGlkkTtqwvllz2dVPRx7pj/7GMJJsDV0VhnsWijyTx3sc
	Nj1T2gRo+pFYLcN3ZiValVGgNeC67+NAD54Iplj1uYkgqD7BuP17PDpZpa+qFwZLF3nsvrd+MKU
	4pzUNe5R1zo/AHu2mEMIWnvkFByIGOlbU4UVQ6TffTqv6y70e+DGkbu7201UoBQxB3uXhTjqD1T
	guko5ltZ2C2ZokKbJKByB0Xvy98drWydfOr4HPtOzgRo+OyxfF1KgWAolu2Zm031nBFjKjA1URp
	te0Tkwm8tZpOaM5oP
X-Received: by 2002:a05:622a:6109:b0:4d8:67fb:4185 with SMTP id d75a77b69052e-4da47c057e2mr219780191cf.15.1759240643399;
        Tue, 30 Sep 2025 06:57:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4ERJkEqmQ7ePM8VRv3iVEwz8JDqKErLEOLUqEtBj8xKLCAQv4aJ0I8B9MMJsvQOQqPyV4aA==
X-Received: by 2002:a05:622a:6109:b0:4d8:67fb:4185 with SMTP id d75a77b69052e-4da47c057e2mr219779651cf.15.1759240642510;
        Tue, 30 Sep 2025 06:57:22 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-80175168d7dsm95307126d6.68.2025.09.30.06.57.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 06:57:21 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <4d49ad5a-878a-44a1-a4d0-459e56924581@redhat.com>
Date: Tue, 30 Sep 2025 09:57:20 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next RFC 0/2] cpuset: Add cpuset.mems.spread_page to
 cgroup v2
To: Cai Xinchen <caixinchen1@huawei.com>, llong@redhat.com, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com
References: <20250930093552.2842885-1-caixinchen1@huawei.com>
Content-Language: en-US
In-Reply-To: <20250930093552.2842885-1-caixinchen1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/30/25 5:35 AM, Cai Xinchen wrote:
> I encountered a scenario where a machine with 1.5TB of memory,
> while testing the Spark TPCDS 3TB dataset, experienced a significant
> concentration of page cache usage on one of the NUMA nodes.
> I discovered that the DataNode process had requested a large amount
> of page cache. most of the page cache was concentrated in one NUMA node,
> ultimately leading to the exhaustion of memory in that NUMA node.
> At this point, all other processes in that NUMA node have to alloc
> memory across NUMA nodes, or even across sockets. This eventually
> caused a degradation in the end-to-end performance of the Spark test.
>
> I do not want to restart the Spark DataNode service during business
> operations. This issue can be resolved by migrating the DataNode into
> a cpuset, dropping the cache, and setting cpuset.memory_spread_page to
> allow it to evenly request memory. The core business threads could still
> allocate local numa memory. After using cpuset.memory_spread_page, the
> performance in the tpcds-99 test is improved by 2%.
>
> The key point is that the even distribution of page cache within the
> DataNode process (rather than the current NUMA distribution) does not
> significantly affect end-to-end performance. However, the allocation
> of core business processes, such as Executors, to the same NUMA node
> does have a noticeable impact on end-to-end performance.
>
> However, I found that cgroup v2 does not provide this interface. I
> believe this interface still holds value in addressing issues caused
> by uneven distribution of page cache allocation among process groups.
>
> Thus I add cpuset.mems.spread_page to cpuset v2 interface.
>
> Cai Xinchen (2):
>    cpuset: Move cpuset1_update_spread_flag to cpuset
>    cpuset: Add spread_page interface to cpuset v2
>
>   kernel/cgroup/cpuset-internal.h |  6 ++--
>   kernel/cgroup/cpuset-v1.c       | 25 +----------------
>   kernel/cgroup/cpuset.c          | 49 ++++++++++++++++++++++++++++++++-
>   3 files changed, 51 insertions(+), 29 deletions(-)
>
The spread_page flag is only used in filemap_alloc_folio_noprof() of 
mm/filemap.c. By setting it, the code will attempt to spread the 
folio/page allocation across different nodes. As noted by Michal,  it is 
more or less equivalent to setting a MPOL_INTERLEAVE memory policy with 
set_mempolicy(2) with the node mask of cpuset.mems. Using 
set_mempolicy(2) has a finer task granularity instead of all the tasks 
within a cpuset. Of course, this requires making changes to the 
application instead of making change to external cgroup control file.

cpusets.mems.spread_page is a legacy interface, we need good 
justification if we want to enable it in cgroup v2.

Cheers,
Longman


