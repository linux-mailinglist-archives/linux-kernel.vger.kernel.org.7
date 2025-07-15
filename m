Return-Path: <linux-kernel+bounces-732032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD689B06118
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 16:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2671A1896AA5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 14:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7692670831;
	Tue, 15 Jul 2025 14:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Elb+dvkp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA3823ABA8
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 14:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752589113; cv=none; b=pQTetHnk1SUOHdeKO+0MEMjwkqCqpkOsezR/Kqo5U9EKjZOIr5qn7jEBrY4aQ11M/oL5NtLm5Ud57IwcjM9C3RUMLXq3YpHQ/LVS1YiwKNv2MNziMSxTz+24gt8ntyTu7yPO2EkYxAMGIXXmuShH0I9e/G9aTGumYci7xWln7Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752589113; c=relaxed/simple;
	bh=q6++1c2ADBvgs9g4B37AnH974+HtqY3SPSEInNO/cyA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bh3zcVlipJgr0D+O0TcYhBH0blcLL8f7li17UbbWUn5qhtq4dappoCo9jIUGUmdfKR+joMMrniIrBtN8+/8xsuT4SfvVP+b1jayihUxYOn60Fj9nYyERkS80rY3/wOGsDm9T2HursgAgmrj7aGRjr85pWrrDgKG6u0oPdj5NYxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Elb+dvkp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752589111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iCz3aFtz9BoXuFwRStITMsUKAM3VRx5ZileAaCmlgUc=;
	b=Elb+dvkpDrd+BKVrNBAT6k25Yt5h/ApO6tanaXQ546iXtyxfBcf5y3qQwNrgfiuLbyj9Xe
	QoIDaFGV3HjxmPHBWbX4avMpSaDPdb1aMDifuTSCv+Hf3jIc+lnHe4AZ8Qa+Bn/3bkb0n2
	IXQ6G1y6MBgUnUk8YMwq0Mcinctpr54=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-zCcVu9hgM5KMBDNxVV9L7A-1; Tue, 15 Jul 2025 10:18:30 -0400
X-MC-Unique: zCcVu9hgM5KMBDNxVV9L7A-1
X-Mimecast-MFC-AGG-ID: zCcVu9hgM5KMBDNxVV9L7A_1752589109
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45359bfe631so33228935e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 07:18:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752589109; x=1753193909;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iCz3aFtz9BoXuFwRStITMsUKAM3VRx5ZileAaCmlgUc=;
        b=RzHGTy7Thk/NfvEKSEFW/WvW7mD1QYQItdY6rL5cFZs35c12AtRsNxXJ2dAsk6LDK7
         noZbJICTp1kl1QnwjPPwSTb4AGuiMKy52lkBPD9YrpwGsEOQQyDS3WC5ojmZbkM7mjKn
         DH6pg9avcrE73p3i9PgYS7RevGKbVnTyM+meffL6Of2XC/akbYR0dCV64pWuSoRqLwqw
         xoAIxednavadc4X9Faz/I29IPLwaFkW+CE71CSCRxNCHiCHOMUq0yXyyqmGKU5gYgyMb
         imgfr7Dcm53VrV3CJfLA99TKwEsf/rVh1k/wGaKBi8CFrjYxEc7ClkTbEmIW1M9IhiJ9
         JhZw==
X-Gm-Message-State: AOJu0YwJHUW+IqUys+RTSzsNNS9/br1rhjalju98S71UBwvUvN7qyh2I
	65HUXtuelCV62SYueHF2d9DEAtOkjXT/Y7xefHMlaYYzW0V24qvd6EcjxfJAkv6mRMEnMCoBo1R
	+3bVfS4cnvkv+vM2RP1tD8CL0Cc64DFtY7duSCZqrICNBNfPG+p9hSZ/YrllPnz5dWA==
X-Gm-Gg: ASbGncusu99syoeYMnBq6eJm2yUB770RupdWPIRo+NFUYE2th3WeF+dzOx5O759PNEl
	krB/CkwYK1h7rCO5QgKZkmliZvPuPugpWwiPhMJLwfKNx72oRKqT37LxA97j8lbMpuRuylTM48M
	wFs87RXGPq8iGyXjIDe64YloL81aA6zXlwkMu760Tvg+E8980hhD0f0U/ce8DpfzOA29MY3VErP
	Kxf1HE8ETAK7t6Ro3VHLCMQ6zP9dIPyIvTqNJxqt+egGy6r3yb/ggj7VUj2goaJonkpjSwmKkD/
	vZq7FBATIU1yJLF8Q7O+xflGFthLxt0tm4QrVZ6lfRm4OfrCU8/Hjb/Wv0vKE5REqbmHqsM9JEK
	yblRV0Drb1yZYbk7ryuZXalVefbBfV2ha4L/7dKensgeVpIIkagFRApzlErV0DeKwwZU=
X-Received: by 2002:a05:6000:643:b0:3a5:25e0:1851 with SMTP id ffacd0b85a97d-3b5f1875e37mr15346462f8f.7.1752589108640;
        Tue, 15 Jul 2025 07:18:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGiBepijZKJjM02yAnF9OJBk4VUiu5bY/nT8xuLFQ4t33OnHfJOgjJeATj2QBAyc/L6yPLj6g==
X-Received: by 2002:a05:6000:643:b0:3a5:25e0:1851 with SMTP id ffacd0b85a97d-3b5f1875e37mr15346404f8f.7.1752589108184;
        Tue, 15 Jul 2025 07:18:28 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f28:4900:2c24:4e20:1f21:9fbd? (p200300d82f2849002c244e201f219fbd.dip0.t-ipconnect.de. [2003:d8:2f28:4900:2c24:4e20:1f21:9fbd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc1de0sm15098577f8f.24.2025.07.15.07.18.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 07:18:27 -0700 (PDT)
Message-ID: <3336b153-7600-4b1a-9acc-0ecde8d32cdc@redhat.com>
Date: Tue, 15 Jul 2025 16:18:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] huge_memory: add
 huge_zero_page_shrinker_(init|exit) function
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
 Suren Baghdasaryan <surenb@google.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Borislav Petkov <bp@alien8.de>,
 Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
 Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>,
 Mike Rapoport <rppt@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>,
 Michal Hocko <mhocko@suse.com>, Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, Nico Pache <npache@redhat.com>,
 Dev Jain <dev.jain@arm.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org, willy@infradead.org, linux-mm@kvack.org,
 x86@kernel.org, linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 "Darrick J . Wong" <djwong@kernel.org>, mcgrof@kernel.org,
 gost.dev@samsung.com, hch@lst.de, Pankaj Raghav <p.raghav@samsung.com>
References: <20250707142319.319642-1-kernel@pankajraghav.com>
 <20250707142319.319642-3-kernel@pankajraghav.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Organization: Red Hat
In-Reply-To: <20250707142319.319642-3-kernel@pankajraghav.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07.07.25 16:23, Pankaj Raghav (Samsung) wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
> 
> Add huge_zero_page_shrinker_init() and huge_zero_page_shrinker_exit().
> As shrinker will not be needed when static PMD zero page is enabled,
> these two functions can be a no-op.
> 
> This is a preparation patch for static PMD zero page. No functional
> changes.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>   mm/huge_memory.c | 38 +++++++++++++++++++++++++++-----------
>   1 file changed, 27 insertions(+), 11 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index d3e66136e41a..101b67ab2eb6 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -289,6 +289,24 @@ static unsigned long shrink_huge_zero_page_scan(struct shrinker *shrink,
>   }
>   
>   static struct shrinker *huge_zero_page_shrinker;
> +static int huge_zero_page_shrinker_init(void)
> +{
> +	huge_zero_page_shrinker = shrinker_alloc(0, "thp-zero");
> +	if (!huge_zero_page_shrinker)
> +		return -ENOMEM;
> +
> +	huge_zero_page_shrinker->count_objects = shrink_huge_zero_page_count;
> +	huge_zero_page_shrinker->scan_objects = shrink_huge_zero_page_scan;
> +	shrinker_register(huge_zero_page_shrinker);
> +	return 0;
> +}
> +
> +static void huge_zero_page_shrinker_exit(void)
> +{
> +	shrinker_free(huge_zero_page_shrinker);
> +	return;
> +}

While at it, we should rename most of that to "huge_zero_folio" I assume.

-- 
Cheers,

David / dhildenb


