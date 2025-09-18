Return-Path: <linux-kernel+bounces-750854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C98DAB161E1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 15:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EE325664BB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 13:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92CD52D8DA9;
	Wed, 30 Jul 2025 13:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NnmcbnfJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E392C8F0
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 13:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753883572; cv=none; b=bdlMbqNf2idMVIIwISwX8cLmqpRcWsnBR58brZXLjGLKZxdWT51j9xQWpze51UPg2hoFoFtR41n+G++zRhoBGlwJ7H/E1B5PCzshZn9nLQhE0mIvR7mN8x99z7mQ1QOYG0yebtR9rwcEb3AV49aaWvMgQhrZ+Gye4kJdqnciatI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753883572; c=relaxed/simple;
	bh=+fhqt74zbGwFmAVFYzLM/I7yTITHbGkLqM+wqDzwR5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P5wqo1HEXFoGSGpAFtO7LIReyS6UjZr2FWRKlcejh4Tp0sgWMihVEhsJhl5wq/TReu5VYkJfy4qzrrtIW7K3rBHXFw0pxjvVhYEuVDq6NWi8u7+GjjbBBqJ2kjMn/Ek6ndjYtu0iGK7bgl7/hzvTD2sJrxKibfT6mfNW8j8ECzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NnmcbnfJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753883570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=INvhw9PaQlqHnlfqMb8yKpdneujvD9kPiqSCHTmOp+c=;
	b=NnmcbnfJhU2/NmsRFZVrdqjNb5iMgOgQqbzK9LVodq8aDOuY6kCm/h/jNenCXHLdwak9Bf
	6ihB/pUr2EfVQrfdqua1RmzzPZ1u+oQnEvsbeFbIqa1oGKbROs286G+gCPjrvmr2REfDDw
	Ese/ZybnmLWigjzY9x/lgBKwH0D3M4Q=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-YWLBQm3tO3WN-ymX6zp1sw-1; Wed, 30 Jul 2025 09:52:49 -0400
X-MC-Unique: YWLBQm3tO3WN-ymX6zp1sw-1
X-Mimecast-MFC-AGG-ID: YWLBQm3tO3WN-ymX6zp1sw_1753883568
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ade6db50b9cso91028066b.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 06:52:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753883568; x=1754488368;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=INvhw9PaQlqHnlfqMb8yKpdneujvD9kPiqSCHTmOp+c=;
        b=QK+qVBNSkg9CtXD7qKdtJbW9NbL7KYvsp3Apzb8TGGnRVdAkYjl3i5CnIXbZpMioxP
         ITFsdNCSmv9NzzvZMiqpo8H3OGyw60lmFiuLLZdW6J+NzbkmVgZ4VuwahfBENbIMlLR1
         W8S8OD4VlkjUpcA14Xd2gdRdngDKO6XbPp3xnw/Ig4DhDFYDPvwoWHLIDpMM9vnCCkNw
         BEMqh4eVl80tY0SHhOlIhUM7SnK4uz/4v9ZJrIC+ucF/Fu42i/IP3ITDjsvezT02dVmw
         430IJsD7m3t23Mu3VUdnIDUKfPqrTatvmrI4WxiCJD2yonag3Ug5QeFm/s4pxvatO0B+
         GOrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTR9o5NoyrYui1BFcTFPIHc07cR3vsCERi6qKg+uOIqnzcNuOxNMp4kx3LqZoLPKDlwEG85bl42TFHJ4I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGy7ukfILD8OLGiuw4dtk5821V15XMcDH0hBJgBrAidwqOHjwp
	L/Wg1OrtEeCFidNQzyx+t9odMRZzhL+rl93ap7pjqR4NVl7XVNIQxxnukelNvwCNMC1rT4JBLFb
	bjPoATIEKguDNvF2GzN+x5VrQ3I2jCeATgUTQjrSeFR8U6YBJLBThep+P1XiToCIx/w==
X-Gm-Gg: ASbGncuhEG1CaA6+aq57+0ga5FXQnfaYbnUPl8fo0YxKV8mTTToMlwFDxG/QrifzNki
	ezWyhI2JnvvhQ4TCnIiMdu9ODeszJ4J2YiXpxpzIXHNyfTFPbCidn/fVjT3+P6H+WXm9TEPxlnt
	pl+6vezDYTT9qtSo4hL1sz4nagGamfma5tf53l/h4VbROYy9DRGjzS5sPSkRJiPiuf82X8vCDeT
	WONGbufTkEjFyIlkL6PxlIDM7o3UEaY+R9KcVjGYx2wL6mcAFzKrlkZxm6u7l1hBOKuIag5w/Qo
	WDJAk32nZUMI5K2sSye43/2Tl3uiNuNhCXWXcJgARUoBbwkNfiekZUxyn3fN9A==
X-Received: by 2002:a17:907:7252:b0:ae6:e25b:2413 with SMTP id a640c23a62f3a-af8fda42a6emr459883466b.44.1753883567585;
        Wed, 30 Jul 2025 06:52:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2KhtHgQZ228r5yO4JfetEAu342+CZE6Zr5/g2fkWHPp7n9P5vjQqg7A7lY87sHfovdnuCuA==
X-Received: by 2002:a17:907:7252:b0:ae6:e25b:2413 with SMTP id a640c23a62f3a-af8fda42a6emr459879766b.44.1753883567129;
        Wed, 30 Jul 2025 06:52:47 -0700 (PDT)
Received: from [10.32.64.156] (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af8f1b172f2sm210258566b.80.2025.07.30.06.52.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 06:52:46 -0700 (PDT)
Message-ID: <ffc43855-2263-408d-831c-33f518249f96@redhat.com>
Date: Wed, 30 Jul 2025 15:52:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH v2 22/29] mm/numa: Register information into Kmemdump
To: Eugen Hristev <eugen.hristev@linaro.org>, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-mm@kvack.org, tglx@linutronix.de, andersson@kernel.org,
 pmladek@suse.com
Cc: linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org,
 corbet@lwn.net, mojha@qti.qualcomm.com, rostedt@goodmis.org,
 jonechou@google.com, tudor.ambarus@linaro.org
References: <20250724135512.518487-1-eugen.hristev@linaro.org>
 <20250724135512.518487-23-eugen.hristev@linaro.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250724135512.518487-23-eugen.hristev@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24.07.25 15:55, Eugen Hristev wrote:
> Annotate vital static information into kmemdump:
>   - node_data
> 
> Information on these variables is stored into dedicated kmemdump section.
> 
> Register dynamic information into kmemdump:
>   - dynamic node data for each node
> 
> This information is being allocated for each node, as physical address,
> so call kmemdump_phys_alloc_size that will allocate an unique kmemdump
> uid, and register the virtual address.
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
> ---
>   mm/numa.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/numa.c b/mm/numa.c
> index 7d5e06fe5bd4..88cada571171 100644
> --- a/mm/numa.c
> +++ b/mm/numa.c
> @@ -4,9 +4,11 @@
>   #include <linux/printk.h>
>   #include <linux/numa.h>
>   #include <linux/numa_memblks.h>
> +#include <linux/kmemdump.h>
>   
>   struct pglist_data *node_data[MAX_NUMNODES];
>   EXPORT_SYMBOL(node_data);
> +KMEMDUMP_VAR_CORE(node_data, MAX_NUMNODES * sizeof(struct pglist_data));
>   
>   /* Allocate NODE_DATA for a node on the local memory */
>   void __init alloc_node_data(int nid)
> @@ -16,7 +18,8 @@ void __init alloc_node_data(int nid)
>   	int tnid;
>   
>   	/* Allocate node data.  Try node-local memory and then any node. */
> -	nd_pa = memblock_phys_alloc_try_nid(nd_size, SMP_CACHE_BYTES, nid);
> +	nd_pa = kmemdump_phys_alloc_size(nd_size, memblock_phys_alloc_try_nid,
> +					 nd_size, SMP_CACHE_BYTES, nid);

Do we really want to wrap memblock allocations in such a way? :/

Gah, no, no no.

Can't we pass that as some magical flag, or just ... register *after* 
allocating?

-- 
Cheers,

David / dhildenb


