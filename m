Return-Path: <linux-kernel+bounces-771747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30487B28AFF
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 08:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E6451CE6FDB
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 06:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F662144CF;
	Sat, 16 Aug 2025 06:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OVh3pBvL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52DC1F4703
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 06:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755325669; cv=none; b=MKl1zOvscC/QmCpt95QIwr1rX3/UguVe6yvFxXAHjdUguDES6KNOoRip2z5nOmFZezzrLQGmkA+3UZUG24VLmxdVQkL5q0qDzGgvahtwAfDNbUMsfx9TwTokYVP4thBuhad6nwbzSGC8cPqpr9kIN5GW9xBkxeSZQ1Ably59TEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755325669; c=relaxed/simple;
	bh=YMHLuGEY+IemOK1W2IdkwqTXgmfUTd7SA5lwh1wV1zM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LCVUPeOgF9/hzzOj2A9xOG1TtvVpzr3aF1CGBKD7HG/XKUH9MIl+Kr2VxG6SSg1/Wq+Vq2gH6NJV+VSQdYnFLxC1Y937JIgDq1ovKX1SstLV66hJZlTu58Q5eiWte8CPuuH7E0hN2dr46o/7tASCFqlRC6zBB4hNmTYqRZv5X+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OVh3pBvL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755325666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fUuoR3W6iZ2p6uoKb6adWtn5/8ajohyLB0yXCyvc0h8=;
	b=OVh3pBvL3T/Sq1BL08wkmdNejPIwjo/n6bFs1Eg+8uRoIEd1fPWvSS7sO3LNvK7H/AHBRS
	r+7R9XxCd8bzGhR+kkzeHjBHTkR3Pba4759JREo/ckbVJSeKYhxn5UcOnkpnicpLRKakGb
	4Cuaaq/jTS0pm8iAwumBvcEY102vU6A=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-7Ol7zbo2M_WGunczIxHBRQ-1; Sat, 16 Aug 2025 02:27:43 -0400
X-MC-Unique: 7Ol7zbo2M_WGunczIxHBRQ-1
X-Mimecast-MFC-AGG-ID: 7Ol7zbo2M_WGunczIxHBRQ_1755325662
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45a1b0cc989so12897075e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 23:27:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755325662; x=1755930462;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fUuoR3W6iZ2p6uoKb6adWtn5/8ajohyLB0yXCyvc0h8=;
        b=etL3QQoXV8b//TltJ/AP0IR9x9jExrQSJQGAaVjQkCticnp1+Y0GVGlaWJhFXm76U4
         t7dgBtQqJCCnTwaUu5eNR2IMhAGp/YtTTqJtBrIC1hAjZ9S1y6XIBiVuoYheZZnQnBoO
         mpfK6zpUb9xzCd3cxI0gyOr5uSwrgps5zxxlRMBwrWebTc1r6XAdvhL4KACLDZLAJV81
         VaAanRDAkmzgfN6hPzdhY30xSqtkYdiukzeSgtOUdDHj+CQCieydQRpaChWA6hIZwQHS
         0YojiAshySq2yj+yJrsNS4LGDtDnUgxljmoMEatRLhgCmH5UFL98JruWs9g/LQf2SacW
         3TKA==
X-Forwarded-Encrypted: i=1; AJvYcCX+4GRz6JZt+xMnWFx6Zxf0e+wRxY6CGL3isbTnJ03EljllHYvLBgs1CGvttZuIxZ/MJFs5ozUx7DDZ7js=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywhkhe90+apSWR045fAulFK7ECZTNoYRn2bGbdsuA+iVqSFnCSE
	jIMQSPIwUjgD1hZHpgThkHNCwLKwueK0oGR45mVp2+diP2LnskzGegD86dBBVWen/XeP/6M8skX
	5RaVpb+plpGm83GYbsdgVkh6hdi8/kE75U/qTMNOW+jC0esovNOY4kHttb7EJVi6oLg==
X-Gm-Gg: ASbGnctyoNHC3zK01UdwVF6ISK8MtO/jweAHaluJ3GFc6LA3VdLKsRyplKL/XX5vijF
	ANIJCnRRCniqiWdHVBm5m+53LBNhHROMnQpeJaINm6O+rLjFvQb+Ugv4lTe0Ga2nG4EYbc3G2js
	3AMU5w68yMjMlhdipn/otOGZ4FBb60ecPRkalS3gkyio7WOXpKJQx30j9bz5LqQTMH21n2Z9SpB
	oOiGACbSS/La3BB27hyf8WoqYJtpsvoRDcGUqTHNbPqDBE32qq7IDftOTfQcUdR6NcPhh/qXuHa
	RjDXJ54SIe4kpy6useukfLGRlFqSfRT3KTGgRqLBUoSE6ft6qfc6c7yIFzExwzwp1cp0N+2dFoJ
	ScfU32zXy4oRNyA4GVSD+Nu2uXmB44XH32Cqhj//1DstyMkb4dp1I75nCVLjM7udnf6Q=
X-Received: by 2002:a05:600c:c04b:10b0:459:e3f8:9308 with SMTP id 5b1f17b1804b1-45a21ab157fmr22208065e9.11.1755325661988;
        Fri, 15 Aug 2025 23:27:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFaL5U3yulaxPkegpoMwZPMWC4xqYC1NkrnFhrR/g7GiOgEyUoKNgfM5RiObhMGQcjcxWIdJg==
X-Received: by 2002:a05:600c:c04b:10b0:459:e3f8:9308 with SMTP id 5b1f17b1804b1-45a21ab157fmr22207915e9.11.1755325661595;
        Fri, 15 Aug 2025 23:27:41 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f23:c700:d8ae:41bf:492a:9e4c? (p200300d82f23c700d8ae41bf492a9e4c.dip0.t-ipconnect.de. [2003:d8:2f23:c700:d8ae:41bf:492a:9e4c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a2221136dsm44144735e9.5.2025.08.15.23.27.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Aug 2025 23:27:41 -0700 (PDT)
Message-ID: <ee29262a-911b-4a97-b619-0dea3b657252@redhat.com>
Date: Sat, 16 Aug 2025 08:27:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/cma: print total and used pages in cma_alloc()
To: Xiang Gao <gxxa03070307@gmail.com>, akpm@linux-foundation.org
Cc: lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, gaoxiang17 <gaoxiang17@xiaomi.com>
References: <20250816042842.3959315-1-gxxa03070307@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250816042842.3959315-1-gxxa03070307@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16.08.25 06:28, Xiang Gao wrote:
> From: gaoxiang17 <gaoxiang17@xiaomi.com>
> 
> This makes cma info more intuitive during debugging.
> 
> before:
> [   24.407814] cma: cma_alloc(cma (____ptrval____), name: reserved, count 1, align 0)
> [   24.413397] cma: cma_alloc(cma (____ptrval____), name: reserved, count 1, align 0)
> [   24.415886] cma: cma_alloc(cma (____ptrval____), name: reserved, count 1, align 0)
> 
> after:
> [   24.069738] cma: cma_alloc(cma (____ptrval____), name: reserved, total pages: 16384, used pages: 64, request pages: 1, align 0)
> [   24.075317] cma: cma_alloc(cma (____ptrval____), name: reserved, total pages: 16384, used pages: 65, request pages: 1, align 0)
> [   24.078455] cma: cma_alloc(cma (____ptrval____), name: reserved, total pages: 16384, used pages: 66, request pages: 1, align 0)
> 
> Signed-off-by: gaoxiang17 <gaoxiang17@xiaomi.com>
> ---
>   mm/cma.c | 15 +++++++++++++--
>   1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/cma.c b/mm/cma.c
> index 2ffa4befb99a..46cc98e7f587 100644
> --- a/mm/cma.c
> +++ b/mm/cma.c
> @@ -776,6 +776,17 @@ static void cma_debug_show_areas(struct cma *cma)
>   	spin_unlock_irq(&cma->lock);
>   }
>   
> +static unsigned long cma_get_used_pages(struct cma *cma)
> +{
> +	unsigned long used;
> +
> +	spin_lock_irq(&cma->lock);
> +	used = bitmap_weight(cma->bitmap, (int)cma_bitmap_maxno(cma));
> +	spin_unlock_irq(&cma->lock);
> +
> +	return used << cma->order_per_bit;
> +}
> +
>   static int cma_range_alloc(struct cma *cma, struct cma_memrange *cmr,
>   				unsigned long count, unsigned int align,
>   				struct page **pagep, gfp_t gfp)
> @@ -858,8 +869,8 @@ static struct page *__cma_alloc(struct cma *cma, unsigned long count,
>   	if (!cma || !cma->count)
>   		return page;
>   
> -	pr_debug("%s(cma %p, name: %s, count %lu, align %d)\n", __func__,
> -		(void *)cma, cma->name, count, align);
> +	pr_debug("%s(cma %p, name: %s, total pages: %lu, used pages: %lu, request pages: %lu, align %d)\n",
> +		__func__, (void *)cma, cma->name, cma->count, cma_get_used_pages(cma), count, align);

		^ one space missing for proper indentation.

But doing another spinlock cycle just for debugging purposes? That does 
not feel right, sorry.

-- 
Cheers

David / dhildenb


