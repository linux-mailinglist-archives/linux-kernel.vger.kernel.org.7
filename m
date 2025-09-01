Return-Path: <linux-kernel+bounces-793689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F8CB3D6D4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 04:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15853176F35
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 02:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106972045AD;
	Mon,  1 Sep 2025 02:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AC4NPwnK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EBA1EDA0E
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 02:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756695095; cv=none; b=ORSLTynpgzvcn29bI7v7ygpr0qzRGnjjIfofPbBsQdDFD4GDZdLrS7L/q1W/X00sQWIy4XYCJpQV1fJONSTsRPACCPIU0KKUWDK1xMr2MGslBVOzt5AeUfjOC9wIEF6WJ1lGRuGla6OjNiAxZea55bJpBDlaXuWNk7t3LWllbAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756695095; c=relaxed/simple;
	bh=Ph3PHxH3IDjbrn6uZoSPtSu21RAn/NfeUzKOS+rTGHE=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=iZkb/SRcm1uEcaXoDAtxAX1d8LjYEDROST1iloZ01TbPMObgyyog0pl953tdKiBZ/lBjeLvhHxBBh1iXRMNrB6WdQYPk+0+weXKUspmpBRtol0iDVAJM2zmUELdwdpbkK5pkpOaMXtAoLt92oaRMlWMJ0OMKb/vfLeaStYy7LS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AC4NPwnK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756695091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/BkoUn/3LVi8bOJIvIwXSjQ7FkDfIUIzvpCA+z3b9AI=;
	b=AC4NPwnK3WKfgYCCzJzRFwLg/tlvf9c4ITYInhFxEUTfijTXcNm4MSAWA+4qugSSxZnZlW
	NBRBvoDFpVFXUubd+KgVwMOtnG9O97Hmm6MxsRRrPhU+puu/+Jdy5mrKladhSOK0hQEB7I
	v1PzFyizSRuf+mPufAGmjMcOAlGCzMA=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-zRFpAbOOM7CCb-ZjMo8L6A-1; Sun, 31 Aug 2025 22:51:30 -0400
X-MC-Unique: zRFpAbOOM7CCb-ZjMo8L6A-1
X-Mimecast-MFC-AGG-ID: zRFpAbOOM7CCb-ZjMo8L6A_1756695089
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-70dd6d255c4so103954556d6.0
        for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 19:51:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756695089; x=1757299889;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/BkoUn/3LVi8bOJIvIwXSjQ7FkDfIUIzvpCA+z3b9AI=;
        b=o4A8HC1E12UQIf93SJRjgwDJXvdrN0bUuG+rMO6aueVsYV8TYGqFI1iDI1zqUsR96z
         rapeemHxyDpdhoLB0zgpZBNDv6wmwsbvZOgspaFQHONPDnSbFuh1biNNnCI8HmbIHuFY
         4HH53sbkpYGkfasYm6OlOfG284cYvYVarYnikztuLFnVMb7g4K7Ev4gX0tUAMFD2TE6g
         hAG+3p96RORTFH92tPXF/AUtDyrZ/taBm2Xa6AmLhDYbe8dapSHcDKA+KnGeSne02una
         MUUI0xpYiTE5csO96LEOZyQblR/1KBhsPa9xYIN63e6dSQmgn2FkWS1sNRnJXNSqggBK
         akXg==
X-Forwarded-Encrypted: i=1; AJvYcCXHKALg+9XF4Yw+q3mn/8/IVvYyleyNh/be5ouYolvsoNEbNZXfWbRwWnti3biOIWAN8QRhu89yz3izRas=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaHDPcR8NGN+yjhmE93D2CpcoCduie4wxRtPUNwnAEoxGGUZnz
	KX/yWOud7oU5FW1jAARqWU0safPg/fE2z1gfXGR9bDTtrIuxEz2EfYqYKVXCWHc8Nz2CiEFtsln
	Tq0XcYg4RmyZstj3gB1hwcr/X2MpmdknAWjlYQxImAeeEEJoeqkQ2AGgTP5Y94pBQRQ==
X-Gm-Gg: ASbGncvSxl+kxyB8ZBayNDrxfq0JJoqPEYYTFnEIZ8e4cxuWG/4lNLY9HEZocM1A8OS
	N2/yqh3OD6/Z2Y+F3rfkoEOhMGlhLf2ANLzcP+6vRMhyIHxg9fwTXtWk1YPJTkNTQp5aGb6wcvc
	vQtByd+ZfD7GqscPlg0bqEJc6Vyw7CUwj6sJBvIajQZhzBeYM1dgWMmSzlcjhHp0fTqqAoLTPxU
	oQdM6Q6v+04OPye6WrFDlBmEHBceVBMI9j6VS9Nuuew4rBz3pAsUltvDt9RxFxC+M13CtewV4mZ
	gs/HlZ6OzP1uOkSe2Iu/pED7vmDVrvX8U1c9NExDNHYIVCWj0SZxwyF79G8YiB+oHGdhOs/2TMz
	iPMbM4er53A==
X-Received: by 2002:ac8:58c1:0:b0:4b2:dfc5:fbee with SMTP id d75a77b69052e-4b31da099cbmr70781111cf.32.1756695089407;
        Sun, 31 Aug 2025 19:51:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkoufCnFgjbgzFW+oNc3o0VuyQRzDbMe1YkLx0QJxMgDX5ZpbTSK/aus3UJJV/ZoqngeX9tw==
X-Received: by 2002:ac8:58c1:0:b0:4b2:dfc5:fbee with SMTP id d75a77b69052e-4b31da099cbmr70780971cf.32.1756695089001;
        Sun, 31 Aug 2025 19:51:29 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b30b54d06csm53949631cf.13.2025.08.31.19.51.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Aug 2025 19:51:28 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <197dd0c0-f4cc-4e75-accb-6bf85ea5291d@redhat.com>
Date: Sun, 31 Aug 2025 22:51:27 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/33] cpuset: Propagate cpuset isolation update to
 workqueue through housekeeping
To: Frederic Weisbecker <frederic@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Cc: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Ingo Molnar <mingo@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Lai Jiangshan <jiangshanlai@gmail.com>,
 Marco Crivellari <marco.crivellari@suse.com>, Michal Hocko
 <mhocko@suse.com>, Peter Zijlstra <peterz@infradead.org>,
 Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Vlastimil Babka <vbabka@suse.cz>, cgroups@vger.kernel.org
References: <20250829154814.47015-1-frederic@kernel.org>
 <20250829154814.47015-18-frederic@kernel.org>
Content-Language: en-US
In-Reply-To: <20250829154814.47015-18-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/29/25 11:47 AM, Frederic Weisbecker wrote:
> --- a/kernel/sched/isolation.c
> +++ b/kernel/sched/isolation.c
> @@ -102,6 +102,7 @@ EXPORT_SYMBOL_GPL(housekeeping_test_cpu);
>   int housekeeping_update(struct cpumask *mask, enum hk_type type)
>   {
>   	struct cpumask *trial, *old = NULL;
> +	int err;
>   
>   	if (type != HK_TYPE_DOMAIN)
>   		return -ENOTSUPP;
> @@ -126,10 +127,11 @@ int housekeeping_update(struct cpumask *mask, enum hk_type type)
>   
>   	mem_cgroup_flush_workqueue();
>   	vmstat_flush_workqueue();
> +	err = workqueue_unbound_exclude_cpumask(housekeeping_cpumask(type));
>   
>   	kfree(old);
>   
> -	return 0;
> +	return err;
>   }

Actually workqueue_unbound_exclude_cpumask() expects a cpumask of all 
the CPUs that have been isolated. IOW, all the CPUs that are not in 
housekeeping_cpumask(HK_TYPE_DOMAIN). So we do the inversion here or we 
rename the function to, e.g. workqueue_unbound_cpumask_update() and make 
the change there.

Cheers,
Longman


