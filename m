Return-Path: <linux-kernel+bounces-828602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D4B2B94FAE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 10:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1656B3A18FA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 08:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40CA31A550;
	Tue, 23 Sep 2025 08:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N7sSa4VW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50932E92BC
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 08:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758615913; cv=none; b=YJQm7XvkbvC3GfjqCfPNyBWyei31qhNlRi33jdzBh8XowK6h0QcSVc2/SG0Bzr4D2Axk6l5Pt6K8Y+XZ7bggmfEZg+8RJ1V0NvD3LddjI992A37QZqOYqNXB0xWdLuRKwvA3+lBLyqDROyw0SVE9ZP9MxiUCXEWrnt0ZQjvdLy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758615913; c=relaxed/simple;
	bh=RCqJ+Lp6KKFdVamgmAQ4xFm1iFaBi0fOBeZwXRcWz0I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XjAnLWcftD+uiqgbn0lUB9txGtMNfJc/NGgkeFSXypE3ZYdiPqqN9jaAMCjfTmv1IO4Kh002pQ+qojh0VVh2ibr7jwFutEJmoHnuEIsYluPykUBaysTAmtbu/Tyt7v/jrK0Vau1sjsuJ6pBkX5cYypliZ7ykBjmf6uu05kc4xNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N7sSa4VW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758615908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=x97u53GTt2R3N2Pgwrhc5uqxe/T+rOMKjkl/kO4sN+M=;
	b=N7sSa4VW8et4QpF05QRv+1M7iB5DHWvfEP/htfHRJAyAeu+KmazvU7hyc+JxN3T0SM7KYL
	JElpFUXG8bmjC6MHmvUSnhI3bg2JUyHMj/HEVN3HGZG99fofc1cY3tn21s0z7o2MKwxl+v
	N7/9Rs+Nj6NKRop/bKfMDK6LGe4KDg8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-uXPGykrAPlW6Lp29PpKG_w-1; Tue, 23 Sep 2025 04:25:07 -0400
X-MC-Unique: uXPGykrAPlW6Lp29PpKG_w-1
X-Mimecast-MFC-AGG-ID: uXPGykrAPlW6Lp29PpKG_w_1758615906
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3ee888281c3so1755088f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 01:25:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758615906; x=1759220706;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x97u53GTt2R3N2Pgwrhc5uqxe/T+rOMKjkl/kO4sN+M=;
        b=NSqQJTThQ2akosqQtMEgxX/UpC5WZo8RQm+GPfDQHIeCDfSEL80J06gOAE/djBF8YP
         2PsP0kfX7x7+70al48E5UW+8+uVxn3OI1NMw6vmfSldp/zgoyy3cpsFlqVR21ShYthzB
         Lr0KQ1Mgc1AnkK6l54qkjP9QXM1NtfPC14NFHTrehClBXnWItINuRIK9ckhX5heiAoS0
         CS2keaYq9CeRDNoJLrlJnSKI/bUA+YndWorxC5DcS7FD2gZXzNYeyCydtWf49YFCTSNz
         9FZuMRrYjPaXlGNupWfXu7T2uKAPdfGPnIqAO8Yi0jz+hq2MhQoGOmib5rgk65a5rnUq
         Np1w==
X-Forwarded-Encrypted: i=1; AJvYcCVCk9rHbkkldwnmP8WUiCntXejTYlHBiPHkHHrSnYCed0frT4SjgQRJKKluXruRuO9ME9gutTA3ze41gYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI9KkAkAJzFbdfzbtBDZtQVAUgUddPyrAUSwX9yq9rXBAWusvW
	JQZ3dYYkBwKMd5qJ33Rcb3f66Tjk8r+QIzoDY2zX/PV7f4iX9LF+xYfncheZhtDiguoG2rfMCFH
	JWfzJaFfrzOrAlvK6FDWrbVMCL+wXCZpN+7Bso+ZCWZfp+gtEGpE7I19mojV2JdMuYQ==
X-Gm-Gg: ASbGncu8W+k0KhkQ+9Yd9gkO8uB5z0gxP4bSCM/vFdcFuN51KgLQZ0rRlM5Crk3TtOx
	2GLpqbrkkXTneuK09Ke4aJ4ZCpyCRUuDKxedETHzhg4uL2Hqyw5CV3dsaBKLhvJo/AfogO2TZ6A
	+WgGUh1jbTwqgPg2YI05jK29TVC+96OUoSxf3vD9T/ZaKOMb3rbybrdFUXpWz6zPxEAQ3N1GRN/
	GDpG6FuWbukWyPdrPZ1QN2QQV7SkuT6OeAfrzRcp2sajpnVnSDX60BIKq2EGQjgVha4HyqW+k+5
	qZXNv9eXYfik5YrB1EY88aj2qpbWRDdSzqoqVZUeL6dn2FOoimU3mF49BeD7g0mc4f1fo1xJfjB
	MOpoT8RrC1ebP4fE9lgJI6w88DTZYyVQDpXZDiNqWYsr5y9jeAjMXeJUqDT1JjTPx/w==
X-Received: by 2002:a5d:5f92:0:b0:3f9:6657:d05 with SMTP id ffacd0b85a97d-405c551a369mr1243708f8f.12.1758615905718;
        Tue, 23 Sep 2025 01:25:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECy5ZyUMi86SkAmY3UUEpYt+kdXd66GExl/asl5sc/9lT72Pm81eO5xU3dy52ferMCYaK/cg==
X-Received: by 2002:a5d:5f92:0:b0:3f9:6657:d05 with SMTP id ffacd0b85a97d-405c551a369mr1243681f8f.12.1758615905225;
        Tue, 23 Sep 2025 01:25:05 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4f:700:c9db:579f:8b2b:717c? (p200300d82f4f0700c9db579f8b2b717c.dip0.t-ipconnect.de. [2003:d8:2f4f:700:c9db:579f:8b2b:717c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e1ce0f019sm10938525e9.0.2025.09.23.01.25.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 01:25:04 -0700 (PDT)
Message-ID: <9688edb5-f474-49a4-ac84-0702ed3af3a2@redhat.com>
Date: Tue, 23 Sep 2025 10:25:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH linux-next v3 4/6] ksm: make ksm_process_profit available
 on CONFIG_PROCFS=n
To: xu.xin16@zte.com.cn, akpm@linux-foundation.org
Cc: shakeel.butt@linux.dev, hannes@cmpxchg.org, mhocko@kernel.org,
 roman.gushchin@linux.dev, chengming.zhou@linux.dev, muchun.song@linux.dev,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org
References: <20250921231334093OILrn169i655S8Pe0KMUC@zte.com.cn>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250921231334093OILrn169i655S8Pe0KMUC@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21.09.25 17:13, xu.xin16@zte.com.cn wrote:
> From: xu xin <xu.xin16@zte.com.cn>
> 
> This remove the restriction CONFIG_PROCFS=y for the heler function

s/heler/helper.

> ksm_process_profit(), then we can use it for the later patches on
> CONFIG_PROCFS=n.


Better to something like this:

"Let's provide ksm_process_profit() also without CONFIG_PROCFS so we can 
use it from memcg code next."

?

> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/all/202509142046.QatEaTQV-lkp@intel.com/

Both tags should be dropped as there is nothing fixed here.

> Signed-off-by: xu xin <xu.xin16@zte.com.cn>
> ---
>   mm/ksm.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/mm/ksm.c b/mm/ksm.c
> index e49f4b86ffb0..a68d4b37b503 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -3282,7 +3282,6 @@ static void wait_while_offlining(void)
>   }
>   #endif /* CONFIG_MEMORY_HOTREMOVE */
> 
> -#ifdef CONFIG_PROC_FS
>   /*
>    * The process is mergeable only if any VMA is currently
>    * applicable to KSM.
> @@ -3307,7 +3306,6 @@ long ksm_process_profit(struct mm_struct *mm)
>   	return (long)(mm->ksm_merging_pages + mm_ksm_zero_pages(mm)) * PAGE_SIZE -
>   		mm->ksm_rmap_items * sizeof(struct ksm_rmap_item);
>   }
> -#endif /* CONFIG_PROC_FS */
> 
>   #ifdef CONFIG_MEMCG
>   struct memcg_ksm_stat {


-- 
Cheers

David / dhildenb


