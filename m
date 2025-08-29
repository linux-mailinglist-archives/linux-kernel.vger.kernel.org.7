Return-Path: <linux-kernel+bounces-792352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87094B3C308
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 21:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 436FFA6082B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 19:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1658241686;
	Fri, 29 Aug 2025 19:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gO0smhQi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AB523BCF3
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 19:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756495779; cv=none; b=dUDpme34D5UsFbyB16t8ZQ+ssunIREWZsz99nhoqae9AYtZuFOED+BWvc1biVssrmxZZ+K8uEZ0+6qMFNLwA5u0CWPPF3NZ7B4QR4IrN7SfXOMyWw30I4TCer7QZv7yXG59Wxck3f4f7REmNHG+/I+3RFXxGKWNRkEXlR7N7040=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756495779; c=relaxed/simple;
	bh=iKxaVraoESaD2AWDvePT1ytVuxHP6kmx08/S1xYPATE=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=VzqU/ZA/2l2L+okCQbkSYqFLBSzZaDQ+87gCwNa2OGx5c/RWf7d+nBeJZiABGrO2Rryw6eOgrpMNU2lrONJFiNYLJsv2+pMd5e/w+lOgSe1Oo4AJh7r5tVmEoNugcGjiDD2fCvyRsszoMxxfRPDAY3hmXMMA8qd2OgHGnLDcrCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gO0smhQi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756495776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ih3Z33J4/DFJic2bWxlA8iLEPjEmBgPscUOkXmjcxCw=;
	b=gO0smhQirOrysc4q04BxbxePP6ZYvHIr5UUXWlS3YmXST3bolg/i3RrHkOIYPtKXTb2NMA
	GXQ1aESoPkUdlNraYa2Hxg3oqDMi9fiY0lRIrShg53k1Ylyz4qf8BgmSAhKysaUon1GO3h
	lJ3MZA1p4uClelA89GBn88k4AbCV6Kg=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-Tdo_3StmPSmTfKTT4eLVsQ-1; Fri, 29 Aug 2025 15:29:34 -0400
X-MC-Unique: Tdo_3StmPSmTfKTT4eLVsQ-1
X-Mimecast-MFC-AGG-ID: Tdo_3StmPSmTfKTT4eLVsQ_1756495774
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-70ddbb81696so44226376d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 12:29:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756495774; x=1757100574;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ih3Z33J4/DFJic2bWxlA8iLEPjEmBgPscUOkXmjcxCw=;
        b=jWc+Uc5lWSINqUYR9C4AuqhNcVROfxLOm8tn9uLrjfLBe6JCNDcJqBpnLPsWNwOvpf
         I4OPKyylyOAEnsk+ldwHNXjdONhDW0rNB35EOtV/25D1gxX86m4fbhrzJJI1FFxoQvFd
         6Os44RQ5M4+xTs3tzr8isIZQdDXUEa62OCJ0lUH5xCRzKcsKd57r7XJguge8pwjht1yh
         PzFFfQ4HkWDA7EY4Hjfv7cHNAuwR0IaWv3eB8jozzWtIDVtrq+HKkiGZkf2XkV857LGp
         hdnaH4Hbsav2SKPOWld1IHw/2wQWvNM4cLv7iK0e1ZZ4pw8AUG1lgV3lOb8HokXP51Ab
         8zhA==
X-Forwarded-Encrypted: i=1; AJvYcCVj0TWxX1jl+d5mNI0N2fFnqmsWcy3PZp5iNi+MRcE86GrLXdaDNed2FKU1n9ZLIHv30ZDS5IReqm4zkJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuIzW+1Zgl7PclLNeyLEq9klR7LlcCNriapJhDcTQiyleyPwLj
	b3Tc+qyQflrWqwJ5jts+IK2AP4x+06bfQiNW7/LTGyIwb38L0LAgWlDMZvPZfyzOR2UVM6Gna3J
	P5c4ibAL8K0k8lgDKcLb6zQCi1MJTWZ/J4L5oLr2Fe7wEmOOZ8z5/hxSpkhHCIUlkcA==
X-Gm-Gg: ASbGncvVYOmuwwul7OjR5aQHWlOIdo7L/ltUrl1Y3hwYzP/DXLypvsJ9niQRpEC2Luk
	a3Xz7sL/mTdL3mRJ++NRsAoQF9NAXPwC+XWBIoxRy1GNUM2/PckeauTDpjkU4zkCePuwowAoz+I
	84MTHCIQmBooe5jjua/rJkDiYuDLEPsUlLWVHeq6wIIn920+r1iCGsVI20EFTSuPbU4BzTtFkQW
	zd1yY+h/tcgJ3EiYKsFFL3AEBGWMy6gqTBLDC5Y1S5buwFe7iH88KsjH6qF6b/dkge19YqoZifa
	B/nZt1KMte9fkC3qlBwT+5SteJQn558u9/rCzW1tbIb2hUnQHvE77aK6PdBF2m0J2mKSL9bwlA4
	oIJciWb5BoQ==
X-Received: by 2002:a05:6214:1d2c:b0:70d:ff3a:f986 with SMTP id 6a1803df08f44-70dff3afee3mr55211296d6.13.1756495773801;
        Fri, 29 Aug 2025 12:29:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBDKVwwFPBvRUkBnugQcMU8CagCVbesKVDDj2wyOnC3IvZmD4TMscDpJdqzJF1bJznls9vFg==
X-Received: by 2002:a05:6214:1d2c:b0:70d:ff3a:f986 with SMTP id 6a1803df08f44-70dff3afee3mr55211086d6.13.1756495773364;
        Fri, 29 Aug 2025 12:29:33 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70e624cfd32sm21802186d6.47.2025.08.29.12.29.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 12:29:32 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <be3275f5-a825-42bd-bf36-3d92387d0b50@redhat.com>
Date: Fri, 29 Aug 2025 15:29:32 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next RFC 06/11] cpuset: introduce cpus_excl_conflict and
 mems_excl_conflict helpers
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20250828125631.1978176-1-chenridong@huaweicloud.com>
 <20250828125631.1978176-7-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20250828125631.1978176-7-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/28/25 8:56 AM, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
>
> This patch adds cpus_excl_conflict() and mems_excl_conflict() helper
> functions to improve code readability and maintainability. The exclusive
> conflict checking follows these rules:
>
> 1. If either cpuset has the 'exclusive' flag set, their user_xcpus must
>     not have any overlap.
> 2. If both cpusets are non-exclusive, their 'cpuset.cpus.exclusive' values
>     must not intersect.
Do you mean "both cpusets are exclusive"?
> 3. The 'cpuset.cpus' of one cpuset must not form a subset of another
>     cpuset's 'cpuset.cpus.exclusive'.
>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>   kernel/cgroup/cpuset.c | 62 ++++++++++++++++++++++--------------------
>   1 file changed, 32 insertions(+), 30 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 5dd1e9552000..5cfc53fe717c 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -584,6 +584,35 @@ static inline bool cpusets_are_exclusive(struct cpuset *cs1, struct cpuset *cs2)
>   	return true;
>   }
>   
> +static inline bool cpus_excl_conflict(struct cpuset *cs1, struct cpuset *cs2)
> +{
> +	/* One is exclusive, they must be exclusive */
The comment is hard to understand. Basically, if one cpuset has 
exclusive flag set (a v1 feature), they must be exclusive wrt each other.
> +	if (is_cpu_exclusive(cs1) || is_cpu_exclusive(cs2))
> +		return !cpusets_are_exclusive(cs1, cs2);
> +
> +	/* Exclusive_cpus can not have intersects*/
Grammatical mistake, better wording - "exclusive_cpus cannot intersect"
> +	if (cpumask_intersects(cs1->exclusive_cpus, cs2->exclusive_cpus))
> +		return true;
> +
> +	/* One cpus_allowed can not be a subset of another's cpuset.effective_cpus */
"cpus_allowed of one cpuset cannot be a subset of another cpuset's 
exclusive_cpus"
> +	if (!cpumask_empty(cs1->cpus_allowed) &&
> +	    cpumask_subset(cs1->cpus_allowed, cs2->exclusive_cpus))
> +		return true;
> +
> +	if (!cpumask_empty(cs2->cpus_allowed) &&
> +	    cpumask_subset(cs2->cpus_allowed, cs1->exclusive_cpus))
> +		return true;
> +
> +	return false;
> +}
> +
Cheers,
Longman


