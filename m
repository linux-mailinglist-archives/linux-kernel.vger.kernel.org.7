Return-Path: <linux-kernel+bounces-866382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 22CD1BFFA17
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 09:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4B429565905
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 07:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB5E2C11FC;
	Thu, 23 Oct 2025 07:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PmVuvN+2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BCE2701BB
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 07:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761204142; cv=none; b=XzcUqR1wdXYBzjdIuN4Cr0yNDBUZ6Mym0GLGbQ6NGmtUbh4f7rn6PqtytCSoM3OsAWWrKWI4pUvQULX0Klstq18Ea/9Hph034xnQdKM0P8A9gkA/xXbVoN/VA6sNwX6CIbrDNocjH6N4kbKPF48GJkbOyUJV61wuViFc5lylOV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761204142; c=relaxed/simple;
	bh=m06cFSRwa4hK5j+jrJ1R/6IaNvK0zToLVUnQY6cAFmc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aKpJiSdZ/QezkHubxpRJOXYtunF0E43RHEyfsKAZhbiFw7K6tKIk7oBeJNsP10vNEePTV1qPKWO18AwqXdRixlx7WWkuJlSJpwyZ1IAv8wjGgBwSH4JNF3NFtsvDNlepP7+6KT38Mjbayxl0UJtXt24Ayiigy5L8Z4bPxwuRC8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PmVuvN+2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761204139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=FqBgEpalzjOOdWWQ6f5KvVtDhqwHZed5PGSC57AnXJE=;
	b=PmVuvN+2bET4VwtbL/KbRdgzVhHsHOpEzUfSw3Pfwg0kam5QOJ+hyfe32g5IBOgrWQEnif
	NHM/BfN2rtXlFlbXTKXy57cGj8HVx2CYg/JvMP1kGwKd9uvd6/KkXO+dCvQgQe++0YdoaJ
	fTbj6DRgp7U3LSONTEPZ0vBKJHrooUg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-_ngz1082OdqC3SnCAXkckA-1; Thu, 23 Oct 2025 03:22:17 -0400
X-MC-Unique: _ngz1082OdqC3SnCAXkckA-1
X-Mimecast-MFC-AGG-ID: _ngz1082OdqC3SnCAXkckA_1761204136
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47108163eeaso1667775e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 00:22:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761204136; x=1761808936;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FqBgEpalzjOOdWWQ6f5KvVtDhqwHZed5PGSC57AnXJE=;
        b=FDwQg+xXnyp4FNRBWcQNMyT3mhgSKWDlU6Vf+gfRjXhygdC35RdZPpKswZlp6slYO1
         AaYM+vIhwBMPntITaQSVVtLlCS7nHYICueV4Ag5AQSfh6FuRXV4iczBZuhKr9zQapJRV
         JKyfefCmLdWASnnknQgiiAQj7eGu2WZg59Y2/lFEnoftY/tXNCaW2v6QC5z1jfOFiHV0
         WCBq/jA3lZlDGUNuaPPJCWjsojcmZ/0xjPj+s3Wo+FaefPJdQpJBL46FgdS2H9Wu3j8s
         iFhxys3ndI7VV7Bz4IPh47Io4Szn8+1Snv54wKt8XTmeRJW20xyl+18cBK8CnAXseBUB
         5h5g==
X-Forwarded-Encrypted: i=1; AJvYcCU/KRFRMxqjFD6Gcju9ZcJ1wl9FJFXKWFw0F6lKBl79k5VPfrQ37WVqw6DJLchTTZrb1jx3ocFa9V3aL3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF95CP1MDpo3jxiIRzc1/C3F/8u1I7/l2daRWT+fqgze212kgk
	K1cZOn5VyHmzuJdsyvry1TEcy1hv1zN6JtxsvEjFpCaI0tPrcpsTs870H3L1uGlaXdmtyoSsHE2
	U3eCd7LxAYzS6bBTzIzxQEgzichbWKDazm1NbbUYsDvlRMDoYvrsIXG5PM+XhpZoErg==
X-Gm-Gg: ASbGncuqkXjSsLX5zx3UxqG3yETLCftpA3JDhCNDdJVAszHMp1TWWSci0M5m1qasdMm
	Tp1VW9Vnh0kxBGDsep/O6EiOjfRHnaoH/b9pbyEWfsRouAoXCR3UblT3V7KKYeShnr7iPFC8RcL
	O5euzZQJ6ggrlfNJ1r0Gx/o0Ba3j8oRxmDxXaGax7zojRqazM0SXiysMM2GJEbACp4Fm9h5dJAG
	567pX3d0+8Ay90CFwWTSFd84dkq0cv/2cskWRYbmS6Dqj1DrNjE/EhVPHWSaLbBx2AVNiA91Y+4
	nz3Cs7/iMZ2BwYN0nsr2CqfQa+OP0vKOM7ngUfGuKH2du2aBs1lqVNqUOKfXi1zcqngtCE9OpPg
	ivXUrxa9JsuLj1XvAJadpDJlJyBfL7x0=
X-Received: by 2002:a05:600c:871a:b0:471:14f5:124f with SMTP id 5b1f17b1804b1-471179258f3mr168688185e9.35.1761204136305;
        Thu, 23 Oct 2025 00:22:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE637JmCoQPr2mlXiBFwoMgjjEzyrxQoOiysCD1cn9SQtGjECI7sz5kgwkfulxwgT/NzBgR/w==
X-Received: by 2002:a05:600c:871a:b0:471:14f5:124f with SMTP id 5b1f17b1804b1-471179258f3mr168687935e9.35.1761204135909;
        Thu, 23 Oct 2025 00:22:15 -0700 (PDT)
Received: from [192.168.3.141] (p57a1af76.dip0.t-ipconnect.de. [87.161.175.118])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475caf2f142sm22098575e9.15.2025.10.23.00.22.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 00:22:15 -0700 (PDT)
Message-ID: <68673e95-7996-4463-9bee-45ed54387fdc@redhat.com>
Date: Thu, 23 Oct 2025 09:22:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] mm/huge_memory: preserve PG_has_hwpoisoned if a folio
 is split to >0 order
To: Zi Yan <ziy@nvidia.com>, linmiaohe@huawei.com, jane.chu@oracle.com
Cc: kernel@pankajraghav.com, akpm@linux-foundation.org, mcgrof@kernel.org,
 nao.horiguchi@gmail.com, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Wei Yang <richard.weiyang@gmail.com>, Yang Shi <shy828301@gmail.com>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, stable@vger.kernel.org
References: <20251023030521.473097-1-ziy@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251023030521.473097-1-ziy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23.10.25 05:05, Zi Yan wrote:
> folio split clears PG_has_hwpoisoned, but the flag should be preserved in
> after-split folios containing pages with PG_hwpoisoned flag if the folio is
> split to >0 order folios. Scan all pages in a to-be-split folio to
> determine which after-split folios need the flag.
> 
> An alternatives is to change PG_has_hwpoisoned to PG_maybe_hwpoisoned to
> avoid the scan and set it on all after-split folios, but resulting false
> positive has undesirable negative impact. To remove false positive, caller
> of folio_test_has_hwpoisoned() and folio_contain_hwpoisoned_page() needs to
> do the scan. That might be causing a hassle for current and future callers
> and more costly than doing the scan in the split code. More details are
> discussed in [1].
> 
> This issue can be exposed via:
> 1. splitting a has_hwpoisoned folio to >0 order from debugfs interface;
> 2. truncating part of a has_hwpoisoned folio in
>     truncate_inode_partial_folio().
> 
> And later accesses to a hwpoisoned page could be possible due to the
> missing has_hwpoisoned folio flag. This will lead to MCE errors.
> 
> Link: https://lore.kernel.org/all/CAHbLzkoOZm0PXxE9qwtF4gKR=cpRXrSrJ9V9Pm2DJexs985q4g@mail.gmail.com/ [1]
> Fixes: c010d47f107f ("mm: thp: split huge page to any lower order pages")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---

Thanks!

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


