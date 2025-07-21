Return-Path: <linux-kernel+bounces-739541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FACB0C793
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 17:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ABF84E6182
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 15:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3AC92DF3EC;
	Mon, 21 Jul 2025 15:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FVBaiUnT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB1C72617
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 15:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753111705; cv=none; b=sp2FXTz5Gr9GTUoYn3HPxSJcBKQ2C9Pb1WIm5ZYol7ONN1aHl4SkLe0F4X4WYXjTYz4h7HVWM8uHbL3t2JuEPsGilrJbmoQaOTidU4wafOTNSXJiXzzWXUVs7OzInl1YyDSmTS4I6LulhD3E+94EpjGbXW6UeOysoXKcTsv8Rvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753111705; c=relaxed/simple;
	bh=KAjqmmSNUJsaFZnkWyXBZPCS3oCAxo7Zdsxi3lRn0ug=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=MVSCWm09ay819wnP0tFUGW9BrO+1ye97O7Np136TLOfYv2QRE+30Qo4V6BtmAh3xNEULMCmbXtRXN/Gm1Awp2CeyCHrCC/6C1LEqpab3binRywhh3icX7nVAD3d16EjJxZq2dI63+dYy7dXiaYULTa8rJ+ATQA95pfe1/xp/vwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FVBaiUnT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753111702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1FAGnQIaMxJlnDMfsOE3b9V6crtiwzXirYY+AEfUHfA=;
	b=FVBaiUnT5ddl/ENYX5a61DzMt5UohQ9iobjSYnQIBkmffwr4Ac7svc3G+zD/W0oNYXAB4m
	9f19zC1FWsGJRpe4vmav3LG+c0HhD5HMso1qUVRy9X2TspSu58gK2BoiLnRRZTEqO6KVH9
	ulH9f2qPO8cvX8Bum+Yk40ueVBOJA7M=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-92-8Sx9S3MtO0-Pm7bjeY5MAg-1; Mon, 21 Jul 2025 11:28:21 -0400
X-MC-Unique: 8Sx9S3MtO0-Pm7bjeY5MAg-1
X-Mimecast-MFC-AGG-ID: 8Sx9S3MtO0-Pm7bjeY5MAg_1753111699
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-740774348f6so4126386b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 08:28:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753111699; x=1753716499;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1FAGnQIaMxJlnDMfsOE3b9V6crtiwzXirYY+AEfUHfA=;
        b=VE0ja4XK/4J8SSn46GYjo1Lh04WVkIFj1iLFTQU+ly8A90PJBAO7YvljQkjpwwE6wY
         TsAb96ZKdBouF+ogejo5fa2i1fkfmDZziWceOxll9zkLRvBQ2ZGlJzwBwdNhyI8JpcsQ
         g673KiXG+y1p7PaQ7NoEYG9d68fvDuJXGi7fNgY1F++il8AeQQttHc5LZy0qemXthmgB
         OuDvQ8kDQy8mRONgPid3LHDbaGW4WETY1cqAyNb4MI+xj21AA8rhI/LhSduG8KPziZms
         1I8rllIXhHnAGgyITBCqo+v+i6+fIcp8tmXPOUViSOTWHWmIdYJjHzFJtIKzPFjlZlWb
         3G/g==
X-Forwarded-Encrypted: i=1; AJvYcCXBoEM9nDsBi17tIXX4ID8NcKOXARlGlE6wh/m+NgCFTl/17ZgJJ0aOvJwzixiPOfufuSj+7kdK0LVimBI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJw3rd3fuxkM07bx70yQCud12wO/jxifu50dXVWqsGzZ2LmEXR
	N7r1hxn21l7XsyJxoRF/y8Ak2tRLA3fKf9vRHqxNhMf6mZCrT2QYUW73DVMV+mTewDwS+E4Y2wG
	ClyPiwAWiPMQThK9rsR31DTeAcs2luczeLoriNAtt7KN90fnmbsNKYTexhjSqe/yMEw==
X-Gm-Gg: ASbGncsCqj3qyrBdXhHiYgrK2XDsxDYQEbqnplMM/sWG5xqpXCRJetgtSGs7rnUyVz2
	dmR3/P3OPQWELx5OvZlCoxynmR4B1JvAN1n3CBFdY7yzW5WMjHgus1T5zXOtTpKOMLpbbSkrgqf
	JKzizowApYZLsk65R5WRfzA+BVnA5pey94F+X4ozKO4XZrotvOEUmPDUSA3QO0qfi+JDRzb430A
	mDO5JbsvFeB+NK/S3M8szcHnnWNIsDoWXqkFMDQGkHd9wulKYcbT2OfcVN52BBthxIYAV3tx7rt
	pELi7TcTAWjNzWWrtAqQLiUexPCc4u4jRwouAfMf2UUJVnE5YXzi0O30u132P70Qxee0QeQVTkZ
	yo8pWV1rHng==
X-Received: by 2002:a05:6a00:3981:b0:748:fb2c:6b95 with SMTP id d2e1a72fcca58-759adcd49c4mr17806660b3a.18.1753111699386;
        Mon, 21 Jul 2025 08:28:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPM0nuxfEYmVcmD9DluTfp24c3r9Je30bankMzwjCMPBJmunsQVaJMVzxVXE4/wnie8bPkcA==
X-Received: by 2002:a05:6a00:3981:b0:748:fb2c:6b95 with SMTP id d2e1a72fcca58-759adcd49c4mr17806622b3a.18.1753111698925;
        Mon, 21 Jul 2025 08:28:18 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cb15761dsm6021416b3a.67.2025.07.21.08.28.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jul 2025 08:28:18 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <9bd275be-45df-47f3-9be3-f7e1458815a4@redhat.com>
Date: Mon, 21 Jul 2025 11:28:15 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] sched/core: Skip user_cpus_ptr masking if no online
 CPU left
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 Chen Ridong <chenridong@huaweicloud.com>,
 Johannes Weiner <hannes@cmpxchg.org>
References: <20250718164143.31338-1-longman@redhat.com>
 <20250718164857.31963-1-longman@redhat.com>
 <2vpxlzo6kruo23ljelerqkofybovtrxalinbz56wgpek6j47et@om6jyuyqecog>
Content-Language: en-US
In-Reply-To: <2vpxlzo6kruo23ljelerqkofybovtrxalinbz56wgpek6j47et@om6jyuyqecog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/21/25 11:13 AM, Michal Koutný wrote:
> On Fri, Jul 18, 2025 at 12:48:56PM -0400, Waiman Long <longman@redhat.com> wrote:
>> Chen Ridong reported that cpuset could report a kernel warning for a task
>> due to set_cpus_allowed_ptr() returning failure in the corner case that:
>>
>> 1) the task used sched_setaffinity(2) to set its CPU affinity mask to
>>     be the same as the cpuset.cpus of its cpuset,
>> 2) all the CPUs assigned to that cpuset were taken offline, and
>> 3) cpuset v1 is in use and the task had to be migrated to the top cpuset.
> Does this make sense for cpuset v2 (or no cpuset at all for that matter)?
> I'm asking whether this mask modification could only be extracted into
> cpuset-v1.c (like cgroup_tranfer_tasks() or a new function)

This corner case as specified in Chen Ridong's patch only happens with a 
cpuset v1 environment, but it is still the case that the default cpu 
affinity of the root cgroup (with or without CONFIG_CGROUPS) will 
include offline CPUs, if present. So it still make senses to skip the 
sched_setaffinity() setting if there is no online CPU left, though it 
will be much harder to have such a condition without using cpuset v1.

Cheers,
Longman


