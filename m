Return-Path: <linux-kernel+bounces-827915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA47B936A0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 23:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 277137A561A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 21:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E351C311C06;
	Mon, 22 Sep 2025 21:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YhAgJ+Xo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C562F49F2
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 21:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758578359; cv=none; b=bF9H9uzh9rh3Xl8P0t4RY2i1mDG3LfUx9TsAUIDSNwJT4WVEweZbbyIu2Z6dMJm18FdnUBP8y+U16NLkNE7onq3AM13d+4UdHO4BdqnIR2A5/rlejNSfb95YBvRi4GR2VN3jKVLLohFCB4A9VByDh2qn74FMQiOsZovtqTFMXxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758578359; c=relaxed/simple;
	bh=TBLAWI/01Mxm/FPjAN5/L7dSJBnelejvoJwcUwPik8c=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=OMUVgG0eiaJewWx58dGCs6wRdOQvHIgL1Xvhs3CFlR1Q3fi+5aqf9MZyLwXnKs46a+QB+16kCSKdCYxEE5l4h+w5WpoRg9SPM7spCtMQl/EkpI1kgLAz0sYYfbtXnJJmZdI1QCQoEQZbGmUzspuwL/57Q5TP1BtH3XaNdLKUlxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YhAgJ+Xo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758578356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PApI70tveZI3fLaO8VuqSiVWaaxwDqYrNcJIn/abLXw=;
	b=YhAgJ+XoyOsC0503e6ck5CCmfl+g9xhNoYDbH1xyiEbUmXu6N4Pjq9g/Cl/DsZO+uHiiMO
	Xwz+LxooWS8e4JLNb52OtKAd6NAllxJuoCw+JZQlEBMPL8vBw+8k0e+k8B/fpSjSaN5aZE
	aj0a1uZeguPnsrr5vvMQt5jC3H4vr0s=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-OxVZIgcAMqSpUasmFLl5KQ-1; Mon, 22 Sep 2025 17:59:14 -0400
X-MC-Unique: OxVZIgcAMqSpUasmFLl5KQ-1
X-Mimecast-MFC-AGG-ID: OxVZIgcAMqSpUasmFLl5KQ_1758578354
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-82968fe9e8cso1365929085a.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 14:59:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758578354; x=1759183154;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PApI70tveZI3fLaO8VuqSiVWaaxwDqYrNcJIn/abLXw=;
        b=kON4fFYg5lCfg4bRWuFVO/tEbbCnmYTiu+mUFVUY5Y+PaJDYDP3FFtbAQSjB9hL3lj
         jRhJvEWDeIgBmZJc2+++P9ww83fZO0gdEyD9qH96LWfbdEW3qhxPhXN5j1F9QKk1etI3
         tTCrTM2kwfFQA3F7/hRLYNbkjQC26ibNue3rskQ2+522BhKV75dRVrXuMFN8efCQzC4O
         YU2MpyszQ/e+/j62KN1HHVeGDJeOeqbG9B888qPXfrSXUgH9AiDIOwmhfVYnMRJJvWBT
         iaSm8IP9dIpO2HN+qKV9gPHyQfYOm4zWqv1b/amxzfHlgD+N7O3zll3ELQjYuOFhvMgR
         uSJw==
X-Gm-Message-State: AOJu0YxdN+0YV7qLBZ4mgDKXrOJtqFXnfpMdEOamH0ftkeGQ9d0erMTa
	RbshZWsLjuXXtEFSnL4U7Ws8zx02w4joP0dxiwGJ1VA7UJh2LUOStDkfQNR7GZJf0OhboIdX/QX
	g/R9IJ0BxpNumLRnD63R05bpXdjwTrGcckbh9MPkkTgZJtYxSkp4wnSrHPF04BWkbOQ==
X-Gm-Gg: ASbGnctX8SMkXHOR/EeL1Wxk9/kUOuJVIVdkdgcDLVPD+0GIASym7qJ//nbpz+jkYHM
	ZtvrjEYNKeS27oql1ZhnlkQgQWMsIvOiEBQbUd7av7sZjVWpYhn3QTB5fUaHLDRB5W1hF/x1DZe
	tD46RoVxXS/3CwCaACC/zRamiDhvwUoIk0arfd8CoqU4tI19y4JLFdl1N7mHGWSmGsAxLo2n+rS
	d//WtFiSywjpE8Oc5bwlVvSRVjrYQx+V4gZAsj9SuYpGw3LKyd4DJVjzHbk2rr45uB1q23VOQNu
	Cbgr2eAJ7n8rnxCnrNaFghD7MRNgGIfjzH3RUP6f9igRlxv1me0d3QpTLrPyzHdXW5ObDGeddBT
	zf3J2JAnr9BQ=
X-Received: by 2002:a05:620a:4484:b0:811:1212:1b6e with SMTP id af79cd13be357-85170245016mr77855685a.50.1758578354406;
        Mon, 22 Sep 2025 14:59:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGF4aCJmVxX283zKdgoGqqHv/hlsXVL9SOjLFHOlJR9jB81AYP9Ha6Zz6Y5QnzcoO52MnZZGg==
X-Received: by 2002:a05:620a:4484:b0:811:1212:1b6e with SMTP id af79cd13be357-85170245016mr77853785a.50.1758578354039;
        Mon, 22 Sep 2025 14:59:14 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4bda15f59besm77848421cf.8.2025.09.22.14.59.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 14:59:13 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <1c77c072-ddf1-4894-a5bb-73bf13a838b9@redhat.com>
Date: Mon, 22 Sep 2025 17:59:12 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/33] sched/isolation: Remove HK_TYPE_TICK test from
 cpu_is_isolated()
To: Frederic Weisbecker <frederic@kernel.org>, Waiman Long <llong@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Marco Crivellari <marco.crivellari@suse.com>, Michal Hocko
 <mhocko@suse.com>, Peter Zijlstra <peterz@infradead.org>,
 Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Vlastimil Babka <vbabka@suse.cz>
References: <20250829154814.47015-1-frederic@kernel.org>
 <20250829154814.47015-20-frederic@kernel.org>
 <dc75acab-36c1-4340-9cf2-35a35361c32b@redhat.com>
 <aNFpHgRnf-mV-4d8@2a01cb069018a81087c6c9b3bf9471d3.ipv6.abo.wanadoo.fr>
Content-Language: en-US
In-Reply-To: <aNFpHgRnf-mV-4d8@2a01cb069018a81087c6c9b3bf9471d3.ipv6.abo.wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 9/22/25 11:19 AM, Frederic Weisbecker wrote:
> Le Tue, Sep 02, 2025 at 10:28:58AM -0400, Waiman Long a écrit :
>> On 8/29/25 11:48 AM, Frederic Weisbecker wrote:
>>> It doesn't make sense to use nohz_full without also isolating the
>>> related CPUs from the domain topology, either through the use of
>>> isolcpus= or cpuset isolated partitions.
>>>
>>> And now HK_TYPE_DOMAIN includes all kinds of domain isolated CPUs.
>>>
>>> This means that HK_TYPE_KERNEL_NOISE (of which HK_TYPE_TICK is only an
>>> alias) is always a superset of HK_TYPE_DOMAIN.
>> That may not be true. Users can still set "isolcpus=" and "nohz_full=" with
>> disjoint set of CPUs whether cpuset is used for additional isolated CPUs or
>> not.
> There can be domain isolated CPU that are not nohz_full indeed. But OTOH nohz_full
> CPUs that are not domain isolated don't make much sense. I know such settings
> exist but it's usually a half working misconfiguration. I wish I had
> forbidden that since the early days but this was from times when we didn't know
> about all the potential usages.

The assumption is true for cpuset isolated partition, but users may 
still set conflicting nohz_full and isolcpus parameters by mistake. We 
should probably a warning if this happens and document that clearly to 
enforce such rule.

Cheers,
Longman


