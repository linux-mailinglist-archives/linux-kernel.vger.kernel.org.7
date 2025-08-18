Return-Path: <linux-kernel+bounces-773065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DCEBB29B00
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 09:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 658213B9A4E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 07:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8DBD27F00E;
	Mon, 18 Aug 2025 07:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WA9k8StF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7C027E048
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 07:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755502993; cv=none; b=LoyQ89Nhws+oJwgRpuos++dvhZ4hl/NUe1/dCUr7w+SHu2jemwtd6fAR93RDYtapLsa5ozXrMR2yX5Ar9mhMr/o58zmcEFLDk1RAMR63CuVAk3J/6VP2NTD1pmrOU8g5RbtE+F0P5C/61j8H19QKAMx+UY8DE25OcvqEFZqfaYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755502993; c=relaxed/simple;
	bh=WCl0AaGlA+XtROGE2++6JjAtk2OJ2sH1wzVqlPRaXnc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bLKE05GimevCh9N9YXdLFYjahoembTHwtJsANhCO1gLx8DXnccv3XIdrqvGlhxLiOuSVC06+xU6/EZqCC8bJwk9izKTSe4DtkofFkCS08y56swsVrpV0Wb5sQ3j6CApeImgXN3w6hnkz9AduaUqpV/8oXIp4WqTerBjxszNmQgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WA9k8StF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755502990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7Q9dfL5NkBeTOjHsVTZ5sPYGGBR76TYaJ3knIQdKHmo=;
	b=WA9k8StF1AQ3O/FC2F4NUB3wCD+Uu71coPzFjVY0nZjmcNsvA0EztPJReHIAJq6sPueRnO
	rNDWs6m+IdGegU2X+FKwwVAjCp6ZwNSOibTKHF6Pve/irywjVSjsfvGUF/B8eEMN98/RC2
	rh+qYwMUgTx2D2c3n+1E2wpB/Mi8CQE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-ofSKVo3uMQ-iNH1qdM7PKw-1; Mon, 18 Aug 2025 03:43:07 -0400
X-MC-Unique: ofSKVo3uMQ-iNH1qdM7PKw-1
X-Mimecast-MFC-AGG-ID: ofSKVo3uMQ-iNH1qdM7PKw_1755502986
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45a1b0098c0so22435585e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 00:43:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755502986; x=1756107786;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7Q9dfL5NkBeTOjHsVTZ5sPYGGBR76TYaJ3knIQdKHmo=;
        b=SmCCJ38weTARs6SEKXdY7L4pTEuIuwuELuoaP89Y5FwqYQ6mFTYeJxJYw0XWzHzsS/
         Ufj/kPCRI7ajGjPIpp+PGso1HOvrYr4lPjOBEMwZkRQsp5S5YwtWzxjBILR4ljzetXaA
         zDDg6JhxDkw44e1c3DiaKjdctzIJOHtaxedhwuJ8E3b+Etn7N4ENodmGB7e6ZUnEMZI4
         9qX7Iz/AuyrSvta9UnsUqVlL2IkgF/RCtyBaigmWlxrIwG/kVyz+nPqdVqcn8W/pciC/
         ORGUlsaZnwyR+/4Es0qMDKCOTBPVw0X1lpcFXbLJlrs2GS+En+HmrI1vmIHWiFg/z8WW
         tsLA==
X-Forwarded-Encrypted: i=1; AJvYcCXswDVBacjtipGfhXC/aH+Z0uVj0jN9y0+0JFg25pjf68c/L8BZO/9mxgixm+ZjqjMe7OeBSePm1Der5bE=@vger.kernel.org
X-Gm-Message-State: AOJu0YybeS7m+wiKJaRGYJX7Qe2JGfFVdOgpkGV/nFAEiTBhDjHL/uUg
	3mSGPT2C6p4+jnHM0ZB98p//AwgyBTLAS5NRpYddPW15CDB111YdDERZeJclgOGAav1vfJHUY2A
	HIQ5j4cGufWa8dFO5oJbGUVrtCy4Vee7H/6HuI3cAIw0Yev3Hp8P9JBLMlXc4keKT6A==
X-Gm-Gg: ASbGncuLVpKzJM0RLFpaXUGfkHHvX+J8B/9HZkORFNGZ2BHDLTW9pORqAsBgfN5ny/m
	ukc9twzHZXhOyUETcQz3eJZ7bFdKELL+Szl1HLNJlnWrW5uuzGmvn2nPHFGjb0A5bgYSutaTd2+
	ZFfEiQVRbxHLVz5PPexLS7+HVv1LrDplkIfNY1YOqqfizr2zwdAj6LxN/O5nkdlf36rTyj3UkHE
	bgaj7vnJDy8Fw3iOPaspq4vlIVTQgRkeaSzQb/5l6411BXau9H1qr8iJcg4Eg3zW6DkVRiwaX+Q
	ePlF/biYwvBAnK1INtVM3neA+/J2boybUd0KX0QTHPSDHlP6vmuxcH848GD8Izgj7cbPddmHuEJ
	EuirDdmlqysY2sIzc4PPamQIB9FSzjkeFw9QMOXE+CZrRIzvI4+zvnwxoQtFSHncB
X-Received: by 2002:a05:600c:3b27:b0:459:f90e:4f5a with SMTP id 5b1f17b1804b1-45a2180628dmr95908615e9.15.1755502986176;
        Mon, 18 Aug 2025 00:43:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbUO6Z15wcjLXZ1p7h5ZxBFKKm7y8rLmD0275SppxqeMk9vb+XVHeYCjL8BnaHtfWRGyYaMw==
X-Received: by 2002:a05:600c:3b27:b0:459:f90e:4f5a with SMTP id 5b1f17b1804b1-45a2180628dmr95908285e9.15.1755502985704;
        Mon, 18 Aug 2025 00:43:05 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f22:600:53c7:df43:7dc3:ae39? (p200300d82f22060053c7df437dc3ae39.dip0.t-ipconnect.de. [2003:d8:2f22:600:53c7:df43:7dc3:ae39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a22329b12sm121196175e9.24.2025.08.18.00.43.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 00:43:05 -0700 (PDT)
Message-ID: <e05aaefc-1732-4dcd-81d2-413d74aab664@redhat.com>
Date: Mon, 18 Aug 2025 09:43:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] of_numa: fix uninitialized memory nodes causing kernel
 panic
To: Yin Tirui <yintirui@huawei.com>, robh@kernel.org, saravanak@google.com,
 dan.j.williams@intel.com, akpm@linux-foundation.org, rppt@kernel.org,
 Jonathan.Cameron@huawei.com, devicetree@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Cc: wangkefeng.wang@huawei.com, chenjun102@huawei.com
References: <20250816073131.2674809-1-yintirui@huawei.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250816073131.2674809-1-yintirui@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16.08.25 09:31, Yin Tirui wrote:
> When the number of CPUs is fewer than the number of memory nodes,
> some memory nodes may not be properly initialized because they are
> not added to numa_nodes_parsed during memory parsing.
> 
> In of_numa_parse_memory_nodes(), after successfully adding a memory
> block via numa_add_memblk(), the corresponding node ID should be
> marked as parsed. However, the current implementation in numa_add_memblk()
> only adds the memory block to numa_meminfo but fails to update
> numa_nodes_parsed, leaving some nodes uninitialized.
> 
> During boot in a QEMU-emulated ARM64 NUMA environment, the kernel
> panics when free_area_init() attempts to access NODE_DATA() for
> memory nodes that were uninitialized.
> 
> [    0.000000] Call trace:
> [    0.000000]  free_area_init+0x620/0x106c (P)
> [    0.000000]  bootmem_init+0x110/0x1dc
> [    0.000000]  setup_arch+0x278/0x60c
> [    0.000000]  start_kernel+0x70/0x748
> [    0.000000]  __primary_switched+0x88/0x90
> 
> Cc: stable@vger.kernel.org
> Fixes: 767507654c22 ("arch_numa: switch over to numa_memblks")
> Signed-off-by: Yin Tirui <yintirui@huawei.com>
> 
> ---
> 
> v2: Move the changes to the of_numa related. Correct the fixes tag.
> ---
>   drivers/of/of_numa.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/of/of_numa.c b/drivers/of/of_numa.c
> index 230d5f628c1b..cd2dc8e825c9 100644
> --- a/drivers/of/of_numa.c
> +++ b/drivers/of/of_numa.c
> @@ -59,8 +59,11 @@ static int __init of_numa_parse_memory_nodes(void)
>   			r = -EINVAL;
>   		}
>   
> -		for (i = 0; !r && !of_address_to_resource(np, i, &rsrc); i++)
> +		for (i = 0; !r && !of_address_to_resource(np, i, &rsrc); i++) {
>   			r = numa_add_memblk(nid, rsrc.start, rsrc.end + 1);
> +			if (!r)
> +				node_set(nid, numa_nodes_parsed);
> +		}
>   
>   		if (!i || r) {
>   			of_node_put(np);

With the changes Mike requested and a more detailed explanation you gave

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


