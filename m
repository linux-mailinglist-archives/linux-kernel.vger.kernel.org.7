Return-Path: <linux-kernel+bounces-758098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D32B1CACC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 19:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62C963A334E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 17:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F991E573F;
	Wed,  6 Aug 2025 17:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xf/z4h9S"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383CEA41
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 17:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754501445; cv=none; b=q7jHbXpAHtNQCjxljJxD3rViWLuIob2OhlUdf6yoP3hPQLoSW8sCiwQ0gGRFCuTtaWYiCl/jziYvJ0y3ZEq0SdlNvY+lrOuqQm0UmCsja2QEiJceQ0X7OtkHsEcGcSPFq2rh/FZMuySUhQIQQtZJDCmqrPYGVEKt/RBuQXwQU6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754501445; c=relaxed/simple;
	bh=rwu7EbHnd6wQb+iO4s/C8em34k2dJwqajxQ0+wzSRO8=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Cfpu14N+Wb1GkFxIRAiww5tGZ8yOXi/yg4m1nFvbcqYLRrN0LBe8MZwSLzH/ulUGUldRIjyfdBiP6rB2n/phGBCC9KFfTRWXP4o8gAYPNLuYN9Ybiz3Ff2TnwvPrgWBld/N/vDvjDnlZyVvRU6JIz0lDRhC1GRa80ALFhSEwPFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xf/z4h9S; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754501442;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S0FtVJ+cvvsMupVuJOSmNRM6v2yyfUsa12kAjP3d/wU=;
	b=Xf/z4h9SuzzMkH4O+l198gfvHAYGu7QADd/U5KeeDbHRRTuCFkog54CdjAlZCOZgFg5+ZU
	AMooPEhnW1lLd5h9nDnkM/lCRHNYjR9N8oI9/SIOJADrB2d7WyVeIggO/kjjQxoY1Yrl4Q
	5aLHKOrfdLa6ogeiIaJgZ1PXfHlDrKQ=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-OBH4MciMNDakqnOvoXLuog-1; Wed, 06 Aug 2025 13:30:39 -0400
X-MC-Unique: OBH4MciMNDakqnOvoXLuog-1
X-Mimecast-MFC-AGG-ID: OBH4MciMNDakqnOvoXLuog_1754501438
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7e6c4ae500bso11805885a.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 10:30:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754501438; x=1755106238;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S0FtVJ+cvvsMupVuJOSmNRM6v2yyfUsa12kAjP3d/wU=;
        b=e6EqTrzrszX/VIEFjXl/FqeZeUySKR/WyO40hm0VW2Yp5EE5B0l2KXudO2EIH03v/s
         zOEJ8V+Ejfnnnlse8/jYh8IcxnUsbNvj92viJczu1XFalUzjquCGmyBHrCBm2jLuo+/h
         DVgxqD4cgs8r1Z66/EwSHqZtdZchaiQgAe2AgrFLaJNMbt09YrGb5jBLlZpso1zEESuX
         zX9CPv/gPRtwQ+NA4sv1GBDi9Xbp6u79w6AQiCDgWdYpHQEriDYWSc4mUaZlcQTbuKau
         NyPNeDxjShc4OSBzs7DgcSiGwmxmfqeByC7+ilaO9jDMaP4ugQ0BYOK4VWBoHkHl0ZVY
         pvDg==
X-Forwarded-Encrypted: i=1; AJvYcCWh/y9G6mxAQ/HqBO7WiNSoXOWGpkxfuKJElVf+72dRHMxnlTJWCXMpIdVO3qDYUwrUIMDyVpUYLkTtRlI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4oq31E/4mCzbGwkUrR1U7EcHKVEOGi7ogRvsQxp2ACch2xOqK
	OaPwzkmB2M0fZ1rEWHEgdnsml3CEYjmjA7cxBgGjLvf4HJp95vLS8uX24o7hfjZBkUcGMr5i4Pf
	so8WIrikYvPpoh7Il3CKRtGpGBFWLnid5XIFecFyUKj2TKadI5VR+lAMZXLGPRsJ/9A==
X-Gm-Gg: ASbGnctR9Jc31djUknuFG2XoPz13eyk842CyaxawUWKBIPzVRx3o7aic0TlOE5Gpb0D
	BHQ7a2rayY9aSKNrwxqpr+TtkDOe5A7z7Pjl2FDC3G5zgvGM+yweFqI8VLL+X3NY/mj/ErJLQd3
	elU3RgpT4R9CtpqtCdzqNLWqaxWe3VH0izYkkhad/fVl66XypglVv4t5CHOZYcnHJonFnVi2ulP
	TupvvkerR5azkduRs3ODQdOC1jGrCvWBu9bKdaj3mCh6ZA/bfuwFv6rn/Ziml8izRYof7tshw5P
	Ifls4qcD/v+f0GnPvE/5ynjriqXvx2TtIta7wSVvQwD5l4FVC9F5geIBpXG0iZTB5RoC8/hhsBD
	4Bmx/F2loCQ==
X-Received: by 2002:a05:620a:2546:b0:7e3:363f:2c19 with SMTP id af79cd13be357-7e816709015mr540443185a.50.1754501438347;
        Wed, 06 Aug 2025 10:30:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUY/YEaX2Klj4Ymjnw1Oc1ae8Dt5bDFRXWaXaUiPkMDaNaMn8PLlQGjoTN+3PRBhj6S9Strw==
X-Received: by 2002:a05:620a:2546:b0:7e3:363f:2c19 with SMTP id af79cd13be357-7e816709015mr540430185a.50.1754501437403;
        Wed, 06 Aug 2025 10:30:37 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e67f5947dbsm829284385a.12.2025.08.06.10.30.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Aug 2025 10:30:36 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <4ebbbe0b-0f4c-4002-b13b-263b7efc9f69@redhat.com>
Date: Wed, 6 Aug 2025 13:30:35 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] cgroup/cpuset.c: Fix a partition error with CPU
 hotplug
To: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ingo Molnar <mingo@kernel.org>, Juri Lelli <juri.lelli@redhat.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>
References: <20250806172430.1155133-1-longman@redhat.com>
 <20250806172430.1155133-3-longman@redhat.com>
Content-Language: en-US
In-Reply-To: <20250806172430.1155133-3-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/6/25 1:24 PM, Waiman Long wrote:
> It was found during testing that an invalid leaf partition with an
> empty effective exclusive CPU list can become a valid empty partition
> with no CPU afer an offline/online operation of an unrelated CPU. An
> empty partition root is allowed in the special case that it has no
> task in its cgroup and has distributed out all its CPUs to its child
> partitions. That is certainly not the case here.
>
> The problem is in the cpumask_subsets() test in the hotplug case
> (update with no new mask) of update_parent_effective_cpumask() as it
> also returns true if the effective exclusive CPU list is empty. Fix that
> by addding the cpumask_empty() test to root out this exception case.
> Also add the cpumask_empty() test in cpuset_hotplug_update_tasks()
> to avoid calling update_parent_effective_cpumask() for this special case.
>
> Fixes: 0c7f293efc87 ("cgroup/cpuset: Add cpuset.cpus.exclusive.effective for v2")
> Signed-off-by: Waiman Long <longman@redhat.com>

Oh, forget to remove the unneeded ".c" from the patch title.

-Longman

> ---
>   kernel/cgroup/cpuset.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index bf149246e001..d993e058a663 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1843,7 +1843,7 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
>   			if (is_partition_valid(cs))
>   				adding = cpumask_and(tmp->addmask,
>   						xcpus, parent->effective_xcpus);
> -		} else if (is_partition_invalid(cs) &&
> +		} else if (is_partition_invalid(cs) && !cpumask_empty(xcpus) &&
>   			   cpumask_subset(xcpus, parent->effective_xcpus)) {
>   			struct cgroup_subsys_state *css;
>   			struct cpuset *child;
> @@ -3870,9 +3870,10 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
>   		partcmd = partcmd_invalidate;
>   	/*
>   	 * On the other hand, an invalid partition root may be transitioned
> -	 * back to a regular one.
> +	 * back to a regular one with a non-empty effective xcpus.
>   	 */
> -	else if (is_partition_valid(parent) && is_partition_invalid(cs))
> +	else if (is_partition_valid(parent) && is_partition_invalid(cs) &&
> +		 !cpumask_empty(cs->effective_xcpus))
>   		partcmd = partcmd_update;
>   
>   	if (partcmd >= 0) {


