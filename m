Return-Path: <linux-kernel+bounces-792405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC2AB3C378
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 21:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37DB4567801
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 19:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8050C244679;
	Fri, 29 Aug 2025 19:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eQz2rbJc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED31241CB6
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 19:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756497395; cv=none; b=jbQwcJ/su0AWoDxmPWIJoXOOCLiXGGq2U4cMaiyjPzUuDUgH4oTFvecIqvh222TyDaNRo72bQGLXDVK1+ku9FmFrTFQXWYO5jPU45elrbEIwwaGgXPEzBnueruRpCabmdT31ZG3m4eNUd4/j6y2Oc7+vGdrmj+p9FVJ86Q+vphc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756497395; c=relaxed/simple;
	bh=dfist05fBW0TaZ4Z7JckJFBZ+mUcaLGzirY0CwdQkNA=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=KbydovD1bAwX8wkWGt7cIrzFBMh7BvOoWwFwrC9BrOCcXSUi++yb6iDiQGeJ0aE4+GHa6pGP09QQ5yRXKik7lUlnwieYHCq/FFqenNs1dTs54Xp/AvQVcz1lhQHmq+gOBi8Ie/F2otvl7vw6+E5RwYbmp4MpFPTGC9Lk4ok4FgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eQz2rbJc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756497393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NWrOzdp8UX+L55QSRJ8fYGBKAQ7vGRfHefsUd0SiDXs=;
	b=eQz2rbJc9yOnZC8+S+bUUTelBnxOogdBawnchzKZhA3ZFNkPiLHo0ck9YyAhjXs+qXYNua
	0mb30gHQyyzuvdbDZ0W7borLts/S6GH37o+bWeOpp/kjUIYD0Rkx2RjxD30IBo01HbOuXf
	e/BONxHu56UeuywEMDsQjugse1vB47s=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-EYkzZ_HiMj-_KQB_UGFfrw-1; Fri, 29 Aug 2025 15:56:27 -0400
X-MC-Unique: EYkzZ_HiMj-_KQB_UGFfrw-1
X-Mimecast-MFC-AGG-ID: EYkzZ_HiMj-_KQB_UGFfrw_1756497386
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-70dfcc58904so29345096d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 12:56:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756497385; x=1757102185;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NWrOzdp8UX+L55QSRJ8fYGBKAQ7vGRfHefsUd0SiDXs=;
        b=pRoIV1Gv3scZLrMJBtfFbuH9NP+V3K1xiVu+btrs0Dqo5LttlDQBuD3I86ANdda20n
         tZKaLDgNmTEcT9A2axc6sVnsSNw31mxTaaYhYA2sZbpuoLzICW5gk+FYgw+ZBsGDHRz8
         hAxRTDo8YTeL2Rt/LVWiKyIVk3nN0ee03VnySShpMmX4kbt4n2L7Ns325PWwqO8JHflk
         XkIgiB03OMQxs7mg8hDplgSlggjZ0BUES5JoTZIC35dF0AVHM8KSGg/lh2MkAMWeWjLy
         hhZsB8I+GeZtHchJjMnuF2f74tp2ypetwBLqDajVAEtfzKERWRzHcCWS39Ke6d6GM1cK
         Zogw==
X-Forwarded-Encrypted: i=1; AJvYcCXvHdTHTMAtSzjpbRyJbhfLQ8qbuJkT5AnSyAXjnOI80L68FnAhqUjHnZIbHFpshGtipS2yquykUS2aL+4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzkwcjj8WDn6WYR4f16JdGud+A89RuGPY2KhnM86svFTFkxHCh
	AzGc8KG4b/r89TZ4mnip15R4U35C63gAaL+EoJgkgT8GYWLP4JbyNwEEbBewfSMVe833iSHgkLW
	E3TXpWJZ/Jo9vElB3WefyjCpODU2+8zgqSOrJRSUsc/MsvuBKRiqdZwK9pJ4qUikqDw==
X-Gm-Gg: ASbGnctWPQl45DvDL7TWQbbvWvnu54fftmlmZvZl+UKFVw4X3YhUrzxwvXsPD+5GwNM
	JRrNYUnYtCH1YgB1pcom00pyfVrUys9a+iov6Tx/Bgcxe6Q8oe/c6TtKoZqhCX3GfY1F4kN8My7
	V8BKbhz+5/8rHY4Vw5GfZzpVn8eix9qf87Q5YCVeFTgDrBDXW0QJLXX3UtSlNzBseoqdzLioZIa
	rJ+bxCRdpWJ7qooXTv9mzF2MojtOGtV6c8vWAfZhdzmaF0rpiykR5Ci//ffczsOLdTf0iaaVJGr
	3uRwWD7BGXjv61EFkhg3rH0GQztIzWNC9ihSUAAAt/WAhfTzYejAF0rEGR4DnWPNSQhjvtlu/R1
	NQbTiIks/Rw==
X-Received: by 2002:a05:6214:808d:b0:70d:a635:2cc with SMTP id 6a1803df08f44-70da635069dmr293244066d6.63.1756497385491;
        Fri, 29 Aug 2025 12:56:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNHSAju9DW3ila94dwjgBIjx9yFjXZrZMlxb9LCSw17FFSqf1l3Y4mWEh0CGl7n96P+uqNgQ==
X-Received: by 2002:a05:6214:808d:b0:70d:a635:2cc with SMTP id 6a1803df08f44-70da635069dmr293243726d6.63.1756497384907;
        Fri, 29 Aug 2025 12:56:24 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70e57e0ec80sm22375726d6.26.2025.08.29.12.56.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 12:56:24 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <98eb72df-2897-413e-8c01-7d688ad58810@redhat.com>
Date: Fri, 29 Aug 2025 15:56:23 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next RFC 07/11] cpuset: refactor out
 invalidate_cs_partition
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20250828125631.1978176-1-chenridong@huaweicloud.com>
 <20250828125631.1978176-8-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20250828125631.1978176-8-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 8/28/25 8:56 AM, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
>
> Refactor the invalidate_cs_partition function to handle cpuset partition
> invalidation when modifying cpuset.cpus. This refactoring also makes the
> function reusable for handling cpuset.cpus.exclusive updates in subsequent
> patches.
>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>   kernel/cgroup/cpuset.c | 49 +++++++++++++++++++++++++++++++-----------
>   1 file changed, 36 insertions(+), 13 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 5cfc53fe717c..71190f142700 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -2376,6 +2376,40 @@ static int parse_cpulist(const char *buf, struct cpumask *out_mask)
>   	return 0;
>   }
>   
> +/**
> + * invalidate_cs_partition - Validate and mark the validity of a cpuset partition configuration

The function name has "invalidate", but the description uses validate. 
It is confusing.

My suggestion

   validate_partition - Check the validity of a cpuset partition 
configuration

   Return 0 if valid, a non-zero prs_errcode otherwise

Cheers,
Longman


