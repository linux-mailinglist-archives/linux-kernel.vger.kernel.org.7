Return-Path: <linux-kernel+bounces-797294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E741B40E85
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 22:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 292F87A6B86
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 20:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7473E35A289;
	Tue,  2 Sep 2025 20:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VVptB+eS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3654C345733
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 20:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756844413; cv=none; b=twsNS1LbJWkX9ryHZOXCZcqmGlFUE6+VU/6aGE2rrMS9OTDcd1/yug2bZycv7Pvrz/fuUXEAzKWFqf7Xup2QFEdXNScxfdIvFsI/S5B3HrjKtwU70xUKibOTFfMjZkldWEU2zT+EJXez5QyyY5saEka3ZsTWIwHmGoFMtblZBz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756844413; c=relaxed/simple;
	bh=+mjCRJqVRXsDIaIlSE+WayK9Zs5CHflb90E/W9KBXhc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VdUi/4nbNwzjXva7hnZNyj/xWAJIYP1IbFfqO3Avo7ahnuPntiNM+4JyDeTvTpWolNzcu+1nLWUy/CIsRwMJoLByVFllsvRWL+6jHrVjPanMEYgVtU/aEI4bkgmdQvsEPZbMqvZwMIRFmihrOPKtVgMuQo4hvH3Xm/UVaeK9YYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VVptB+eS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756844411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=CuyuxRm5ec6gcsPJM4+KShUVcowrlvBWYElAr0kZulc=;
	b=VVptB+eSiKcH0FNZ/CxK3w4pKRF6UFSP0CNWjomq8ABNjY/XgMQ80OS4x/PKmhr4GH59yh
	Dkn6QNlNtu94kr6HRoqjcsKaau2X1ARTA1g2IWO2SV+if/iKd2iF6inHQluGb/7idvfPvd
	R1kWxeXFn+ysqadyrbvCXiKXWYd3o6w=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-H0p4ayqCPdOE_4cjbapKPw-1; Tue, 02 Sep 2025 16:20:09 -0400
X-MC-Unique: H0p4ayqCPdOE_4cjbapKPw-1
X-Mimecast-MFC-AGG-ID: H0p4ayqCPdOE_4cjbapKPw_1756844408
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45b85c93afdso11776255e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 13:20:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756844408; x=1757449208;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CuyuxRm5ec6gcsPJM4+KShUVcowrlvBWYElAr0kZulc=;
        b=VArrsBJnHNQAhsXuvDkWjOGAqebNualn2PjCAHg9CoyQLYPVYb3ufhDkIPj0LgE/6Y
         65rFYRwJSxwQS5xE+Z7DUiYo+8wwNRkQI9IWjeY+hXWVCrc5fBEv9GI2vMeH0PRe1Ykg
         v6DWj7DSGqZ9kMvZhPSVRmsf5i8SyEmEf+jKYaH6X8S0zP8vRatz3Wusx3QhFi9FPhHJ
         BNA7zgCpy8TsuoKdrn4jQSlQFtbPKkv1FwjqZUxjBX5ejVn4ITPrzV9wWerrU05xdTJx
         jxLPRuZp4TCoxueIlxa5DwT6VIZ7aFSwpc08lAQFNHsW+KeCSupceirN9M0GEgYGUDXc
         uYug==
X-Forwarded-Encrypted: i=1; AJvYcCXzc02IaWlK3K8KznYitv8mewZqWsa/HxzSn8oW6ICle8zhxVwz/7el9qTP8oUrvotApBcMPCe/NK049oE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6XMqOoZForkVH2+Z4A/tfMDshCb9raKGGhfCAmN+d020zTPTn
	Ka9B7wZJTGMSmjyjSIJWHd6whNK1nsIvByNhAmUuOp9HmgCd0urrJYnglYzPgABmFSYCpTGlBX0
	fUf5asEkSuTylgUTFaVDMzequ0X8CrU+kJF0WISXJf25r8zWPA8UbJTKLWutbhEy7Wg==
X-Gm-Gg: ASbGncuwONu8jp+dAuLjj6Y92M3KoDDBpMWeKhp6l3frUb7+PqIOfIomC7KeOKmF5NQ
	KEhlo6y69cGDSTdGfScA2ZcyTb6Y0iUFPEp66WVWlN/FClRY1SBqNzYTEx/Vj3wgqfAe26V+Ti/
	F5ldC1h1ud0FEG2w43GLdOHP4cAzNLm+wfuX3j/qsTu/BZA74DszMzinicvfGAs7aUvaZNJg2Ey
	TJtLDSsDPJ40asPHkeGy6PWBxgZ2D6HWt+UGG+/+NS9JKYi6BiVJEiSqB4LjuSM2H1HOTWTOhP/
	jw7WEauRCG2TBEjgtF+uhUABo73g9udY8HwjTa4DcWGBlEnt0r2bm6P6m4RxCR/c27hieIhHZjb
	PS0mUIs+Tl/I3ByMl0JjytlBhVo4gONa9VEnGR2I8lBLRWLSMYEoMHBwEJciUvTMVJQY=
X-Received: by 2002:a05:600c:358c:b0:45b:9a3b:34aa with SMTP id 5b1f17b1804b1-45b9a3b36d5mr32941135e9.16.1756844408270;
        Tue, 02 Sep 2025 13:20:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMVtUOblrZpD/cN66xO+epD0JILTT1Y4c8ImtObJsq4l24+VO0esi7Oc90vomay1kmdbGuGQ==
X-Received: by 2002:a05:600c:358c:b0:45b:9a3b:34aa with SMTP id 5b1f17b1804b1-45b9a3b36d5mr32941015e9.16.1756844407862;
        Tue, 02 Sep 2025 13:20:07 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1f:3f00:731a:f5e5:774e:d40c? (p200300d82f1f3f00731af5e5774ed40c.dip0.t-ipconnect.de. [2003:d8:2f1f:3f00:731a:f5e5:774e:d40c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e50e30asm210722625e9.24.2025.09.02.13.20.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 13:20:07 -0700 (PDT)
Message-ID: <abacf7ba-f6af-40ac-b8b4-afe259546c16@redhat.com>
Date: Tue, 2 Sep 2025 22:20:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 12/15] highmem: define clear_highpages()
To: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, x86@kernel.org
Cc: akpm@linux-foundation.org, bp@alien8.de, dave.hansen@linux.intel.com,
 hpa@zytor.com, mingo@redhat.com, mjguzik@gmail.com, luto@kernel.org,
 peterz@infradead.org, acme@kernel.org, namhyung@kernel.org,
 tglx@linutronix.de, willy@infradead.org, raghavendra.kt@amd.com,
 boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
References: <20250902080816.3715913-1-ankur.a.arora@oracle.com>
 <20250902080816.3715913-13-ankur.a.arora@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250902080816.3715913-13-ankur.a.arora@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02.09.25 10:08, Ankur Arora wrote:

subject is wrong.

Maybe call it

mm/highmem: introduce clear_user_highpages()

> Define clear_user_highpages() which clears sequentially using the
> single page variant.
> 
> With !CONFIG_HIGHMEM, pages are contiguous so use the range clearing
> primitive clear_user_pages().
> 
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> ---
>   include/linux/highmem.h | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/include/linux/highmem.h b/include/linux/highmem.h
> index 6234f316468c..eeb0b7bc0a22 100644
> --- a/include/linux/highmem.h
> +++ b/include/linux/highmem.h
> @@ -207,6 +207,18 @@ static inline void clear_user_highpage(struct page *page, unsigned long vaddr)
>   }
>   #endif
>   
> +#ifndef clear_user_highpages
> +static inline void clear_user_highpages(struct page *page, unsigned long vaddr,
> +					unsigned int npages)
> +{
> +	if (!IS_ENABLED(CONFIG_HIGHMEM))
> +		clear_user_pages(page_address(page), vaddr, page, npages);
> +	else
> +		for (int i = 0; i < npages; i++)
> +			clear_user_highpage(page+i, vaddr + i * PAGE_SIZE);

Maybe

if (!IS_ENABLED(CONFIG_HIGHMEM)) {
	clear_user_pages(page_address(page), vaddr, page, npages);
	return;
}

...

And maybe then the do while() pattern I suggested for the other variants.


-- 
Cheers

David / dhildenb


