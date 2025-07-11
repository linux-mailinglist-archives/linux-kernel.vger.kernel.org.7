Return-Path: <linux-kernel+bounces-727422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A1A3B019F8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 12:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C68C3A8BA2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 10:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE5F2877E8;
	Fri, 11 Jul 2025 10:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SHoMR2mh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE922853F7
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 10:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752231094; cv=none; b=JhjCURH/N58LINLlhhTN9Vd9UWikp7EU8WHOqORxv5q7KjfBAc0pgsDjs7fe0UtV2HxxUBWdEpEFBrC4bnEUgXrK1Rgo/tfC2qsSO6N2m0u0SCx+Vcptmr4FfryCzTpOIBHcJZCo7q+1B5PiJ9Fvpjwl1LiN9chZ0wY0N0IYvKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752231094; c=relaxed/simple;
	bh=l99lvOSgYlGPbio240GPOs34MoTqDQJRaQaGCA199WQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ieS8p73BTwIxVW0f5jdYPc8OmAiRzl6en60lGXWPD0Hc036lSMZcul3rKrzHJKo8QYSlHUAARa5Gg7a2DGEpvbstO6tXPARzTjY1VC5NwpaF1smtiiFNu/aoybbXVVu2owBZ5cGakMugMbu3KiEkqaUVOgvQcFmIPJAHs0Twmw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SHoMR2mh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752231089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=q8VBQiFLT//EeYl3ROmP1EwYI9fSpWGAhPvrES6B45o=;
	b=SHoMR2mhm0plO9sWIBwjOTjU/k5MDyR7G3N66zxZ5u4yVKWEA/+2htDTdOW/qAiqY5c5Bn
	o1bczRRU2Fip7VNwqyJ66fR5eWA1zx2nyBQeaT5JseO0u5x7du2Pxfg/10AarTZFDsnQP7
	RSgBqM32dcEElyDCvF/2jjdofNL+PpU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-acEDa7OaPfWKZpPB5EZfqg-1; Fri, 11 Jul 2025 06:51:28 -0400
X-MC-Unique: acEDa7OaPfWKZpPB5EZfqg-1
X-Mimecast-MFC-AGG-ID: acEDa7OaPfWKZpPB5EZfqg_1752231087
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-455d95e711cso1860105e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 03:51:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752231087; x=1752835887;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=q8VBQiFLT//EeYl3ROmP1EwYI9fSpWGAhPvrES6B45o=;
        b=k0olzlgdGy76i4SVgZyk6yhY0Nwd6Txe/X3YotZoILMLbWjdGZZGzPBxw+0d9nHkku
         kDCR/3fCuCfPlsWBssJuxxswyb7/oKPG6dHXcFSmsw6z6MPmDLtSOL1jCiYUc9NdyIpM
         yFUvBZEaXo1YkaO7mLcRU/OBp3fceyMvsa5G96shZKejz/ZmVbmX6Cbft7xCanHUM7Aj
         h1Vz6DnM9tyER5va5gjs2vDzBc/Q8IZomnN4+B0Gt4RxfE0ES+0+ziC8Yx5NNWd3lBam
         QX6vuD1jDfzNLh1CBEkjYS3ZprRE7V/ZNs47OW5uTklIbYQ99+qsbpysExNsiu2my4tY
         PWxw==
X-Gm-Message-State: AOJu0YyhinsycbV1b84hRGXS5Owl0iWRSJgHlLo9KsHYRj1v14mQPHDW
	eaw/4L4UaJiubfOphAEam9nKUN1XJJWHc3LRD9hc7ekm7jzVmp3zGLgilt6/XjG5SA3bABhqqBS
	6GWUomCoC/4mfF9wz39/z1/99gcWx/DRZPtnQUu535v46f+vYmLD8j5tdRwAGfkyI0Q==
X-Gm-Gg: ASbGncsA0+MWYLAdx1GdRzdeSBI8ktk5MTSU5ZodebRDjPDk8QijDHQjqaAYyGSdxGy
	om618CIn2n0g84czNMHjbJ0GREi7vRWjd0lh3uVNHwPrIFEAanep1m6NmQaD+BZLm8Vh42z2ip6
	C618LEDzKc+2NpZfGygbw1PxaK8ZPFPPycLR6p12gmkzV9K2deNLfXTOZrEHA+q3hLNEwCEDfi2
	u8/R3MjDzZmQfuTIIYhV1TUTIPWIHAvD/LoNyVeyWHi70w+WpArGcW1l9+O1ggYSVpOenRTo591
	TIM9ezGXsV8po7hjf9m6cnII7yKlLbFu8kT6Fj1tftbJ0CjovkQR2L1/oTIMCIp3f3ulGhRwx71
	NaZVi3R1rB+f+iDmQiWWJpT6yArWc89mUniri3rVfXh7H5mm5EnZmJnWU2REhf4XzSMs=
X-Received: by 2002:a05:6000:230c:b0:3a4:f7ae:77c9 with SMTP id ffacd0b85a97d-3b5f1c67bb3mr2296087f8f.5.1752231086766;
        Fri, 11 Jul 2025 03:51:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsGS5dc3KDbynrDW47+++kkEuKHhuStoQal+N9lYCQvCANPyj0LCXBNA1BlZsqbPtddyKJjA==
X-Received: by 2002:a05:6000:230c:b0:3a4:f7ae:77c9 with SMTP id ffacd0b85a97d-3b5f1c67bb3mr2296069f8f.5.1752231086371;
        Fri, 11 Jul 2025 03:51:26 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f3c:3a00:5662:26b3:3e5d:438e? (p200300d82f3c3a00566226b33e5d438e.dip0.t-ipconnect.de. [2003:d8:2f3c:3a00:5662:26b3:3e5d:438e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e0dbddsm4193594f8f.63.2025.07.11.03.51.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 03:51:25 -0700 (PDT)
Message-ID: <21d6b420-c8df-4a48-8b47-ef06135a4d1b@redhat.com>
Date: Fri, 11 Jul 2025 12:51:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] mm: Remove unmap_and_put_page()
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Jordan Rome <linux@jordanrome.com>, Andrew Morton <akpm@linux-foundation.org>
References: <20250709194017.927978-3-vishal.moola@gmail.com>
 <20250709194017.927978-6-vishal.moola@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250709194017.927978-6-vishal.moola@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09.07.25 21:40, Vishal Moola (Oracle) wrote:
> There are no callers of unmap_and_put_page() left. Remove it.
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> ---
>   include/linux/highmem.h | 6 ------
>   1 file changed, 6 deletions(-)
> 
> diff --git a/include/linux/highmem.h b/include/linux/highmem.h
> index a30526cc53a7..6234f316468c 100644
> --- a/include/linux/highmem.h
> +++ b/include/linux/highmem.h
> @@ -682,10 +682,4 @@ static inline void folio_release_kmap(struct folio *folio, void *addr)
>   	kunmap_local(addr);
>   	folio_put(folio);
>   }
> -
> -static inline void unmap_and_put_page(struct page *page, void *addr)
> -{
> -	folio_release_kmap(page_folio(page), addr);
> -}
> -
>   #endif /* _LINUX_HIGHMEM_H */

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


