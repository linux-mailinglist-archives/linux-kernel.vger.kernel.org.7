Return-Path: <linux-kernel+bounces-811596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C6DB52B49
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 10:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E1F118964D7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 08:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC512D94A9;
	Thu, 11 Sep 2025 08:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Petj6vyc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3E42D7DDA
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 08:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757578376; cv=none; b=kno72ZnEaSd55/BvFpIoIt+U6agzWKEZamxXWaOGjlmoIau2+6RxOP795SnGKg/9MR1oS6qtOn/RGtvdWipJe59EF+4JlSxi9+Ydj7Fc5zO2BR6UAnSaJBN4TSZgLY4JNqVvK0sRoQDwfT4+3gtTzCfKqI9cM8UTY0NZvlGAtW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757578376; c=relaxed/simple;
	bh=Qswk4ktfXPZFVRjWEeGarfZ7iJCNW+NzDaHbkB0hBNM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H/e8YbP2znvDb42cn70ro3ashzXIsh3rBoQmXyjzedX5jZYWg920JfOEMieeVyHQ/ottxQPaPCEUzV4JAMnQPHumjAy4+cyUhiiOqZ55x1v0gFHWCDLQyzV86Yf+9AMAeq2Rcifv+WLaVMY16jlTYQrJbtl2KLSXJVQJOkYUcaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Petj6vyc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757578373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=q3FQkhEMcvr0EcoaDlDZlVAs7hfOGwWx07xz7iOCeSY=;
	b=Petj6vyc3RQNdo8O3XK2HWxrts+VJyfNuSu30dvaTGt8iittqS0QbDFBik5vTmpcW8OHCv
	etCoYhiSTy+q72Yffsfxr8kM9R7uzJE9xKt3sYUdeMnD9eSd+8uu5nSqhEMN1CAd+Y+2V2
	q0/T4q7GkXhaZJhTNWartU85U7ZC+nQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-XZrFio1MMy6FVKOHk0vMEA-1; Thu, 11 Sep 2025 04:12:52 -0400
X-MC-Unique: XZrFio1MMy6FVKOHk0vMEA-1
X-Mimecast-MFC-AGG-ID: XZrFio1MMy6FVKOHk0vMEA_1757578371
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3df19a545c2so305245f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 01:12:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757578371; x=1758183171;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q3FQkhEMcvr0EcoaDlDZlVAs7hfOGwWx07xz7iOCeSY=;
        b=EcDbEpuInLmajJL+A3A5NHf/hflF6HtMSEy7TRba8mkx0iM6uL6T7G9Fy2RnV25wXi
         WDBZBo9WoAy7QnU4t74vSImpovIYOcs6HP5tLsUTbpRZfzFZnXTLsimpDiGkVoh3nvLk
         ncCNVLmbwENxxcLBu8dpzsjZd1Oz7bp9+syHGQMpZiSFdBA5fOY40Fwdnix1zgBlQPix
         13hPPLne66QqRScjjK5M9hOPAufe/cZFRrZkzsq6Xy8eKF6OFBFckZOBLVbOcL3+2Qmx
         vGC1VDc699DpUFruDfZvbDKYYKTfF1KDRuFNDTjNrr2nVKOll2gATgmj3DfcJERj0rM2
         8nHw==
X-Forwarded-Encrypted: i=1; AJvYcCUTGDXqJ2KoBEyQXJ7Lhxe/0rvSE7Py5YLoE9TRC+hKH/xZvPWQPGWVqYGMbFYZ0foFxI9PjOpqhTUFR80=@vger.kernel.org
X-Gm-Message-State: AOJu0YweZpWJQfgiCCOJ0hfdqDtZHV4EosVmP0HwdEd48u693pgrERzu
	EEbBa6SXljPhKvds41CWkgqPKRhPBW41pz1VTfY37qYLajfDkHSEkj58NXijawoGtdcRisVvXMc
	RUW6+NFfbihXTYZnwcEdxJ169bOvU5EsHUv7k0vYg/Rk52OMduOSWrpCNu422zS6oiA==
X-Gm-Gg: ASbGncvs3PtlU5hR1ftx2nhiOQJtnuW0NSiR8mMS12/padIbQPNP+mfr9XVGsZaCY+M
	AUWDOaSA7XpkExFj3b0RbnnZwxx4MgHfKWuPJE5PKHro2S6HYmW4ZWcBKsTMZBihvg6HtvPlBFb
	/eP3L+u5CFZyJ9PXHDDpj/gxbrs5D9BWMVw4ZGusKQ+wCMG9WmS58Z+/GDpJM9ZUDf0hkZJsqsf
	tiV3SsNWiNUcqhnvkqXES2lk6QWHeGPP6GUKED5FZs4kHa3SYbd9Iro3mb7nlf2OvidMZtuQ3+9
	BaqK2VKDmMoTDAvmU2XQJ/uKFy9DSFQhJY9IunHH69ExvyNF0Rz/2SvNQ+x5Rczb3qCR/4quKfQ
	m5ue2x218gL86UarhtfrhGEWcbM2RNam3gdhW1IwSyhh1BhKqd36n4iI967F6IfenRgA=
X-Received: by 2002:adf:eb02:0:b0:3e7:4ede:d8a1 with SMTP id ffacd0b85a97d-3e74eded8c3mr8215903f8f.48.1757578370656;
        Thu, 11 Sep 2025 01:12:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExNs5PQty033WtXs6t/LxnTxcNbGcQzB2atLhIjEhboWCVT5UxRk/pjRwFiDV6ZMYel8lVSg==
X-Received: by 2002:adf:eb02:0:b0:3e7:4ede:d8a1 with SMTP id ffacd0b85a97d-3e74eded8c3mr8215888f8f.48.1757578370258;
        Thu, 11 Sep 2025 01:12:50 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f42:b000:db8b:7655:f60f:812b? (p200300d82f42b000db8b7655f60f812b.dip0.t-ipconnect.de. [2003:d8:2f42:b000:db8b:7655:f60f:812b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e760711bb9sm1533593f8f.0.2025.09.11.01.12.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 01:12:49 -0700 (PDT)
Message-ID: <c88a263e-a73e-430a-bfb9-a2b9a32dede8@redhat.com>
Date: Thu, 11 Sep 2025 10:12:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: avoid poison consumption when splitting THP
To: Andrew Zaborowski <balrogg@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Miaohe Lin <linmiaohe@huawei.com>
References: <20250911021401.734817-1-balrogg+code@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250911021401.734817-1-balrogg+code@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11.09.25 04:14, Andrew Zaborowski wrote:
> Handling a memory failure pointing inside a huge page requires splitting
> the page.  The splitting logic uses a mechanism, implemented in
> migrate.c:try_to_map_unused_to_zeropage(), that inspects contents of
> individual pages to find zero-filled pages.  The read access to the
> contents may cause a new, synchronous exception like an x86 Machine
> Check, delivered before the initial memory_failure() finishes, ending
> in a crash.
> 
> Luckily memory_failure() already sets the has_hwpoisoned flag on the
> folio right before try_to_split_thp_page().  Don't enable the shared
> zeropage mechanism (RMP_USE_SHARED_ZEROPAGE flag) down in
> __split_unmapped_folio() when the original folio has has_hwpoisoned.
> 
> Note: we're disabling a potentially useful feature, some of the
> individual pages that aren't poisoned might be zero-filled.  One
> argument for not trying to add a mechanism to maybe re-scan them later,
> apart from code cost, is that the owning process is likely being
> killed and the memory released.
> 
> Signed-off-by: Andrew Zaborowski <balrogg+code@gmail.com>
> ---

I would suggest just checking whether the page (PageHWPoison()) is 
poisoned before doing the check for zero. If set, just treat it as non-zero.

No need to stop the split.

You'll have to do that in two locations.

No need to mess with RMP_USE_SHARED_ZEROPAGE

-- 
Cheers

David / dhildenb


