Return-Path: <linux-kernel+bounces-712934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B94AF10C0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jul 2025 11:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E01A97A16A6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jul 2025 09:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5EF2247DEA;
	Wed,  2 Jul 2025 09:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CRbNUBRd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF7D1E5B6D
	for <linux-kernel@vger.kernel.org>; Wed,  2 Jul 2025 09:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751450235; cv=none; b=JXvYjHQbm058T8mnD/U85oXuFO9TinL+TjIUviOdflw8UzNFENasJOMwRAG6SrQPR4+zpvJJkpE8YIDf6oFf/YdCcpY2idO94elXlSsNgywf5cM6ynTHVYZAakTd8KMI2otK2HtYe2EcPLV5DrxabA5NXHd5XkJnAuL/OQpBpY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751450235; c=relaxed/simple;
	bh=IbmoAK6KfNMGR09htAo693uG5h39ZwlNorBNKuR9ldA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z82C6zsOv4LvmxQJh45wNo9RzfFpMed3DX+sC8V0gb0yLTrFWBprE3mYy0AujRPvxcHam8ACzAxZjYz7jB32y8JK0V+n6AGN9dhybC9gzePHbkRgGR+rJ64iKjdWwAFBy444GuNA/Ovm59JsFMIC0uhAgHM67IbfRKNd+NTuWo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CRbNUBRd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751450233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=B3XTbmiJEq13XDHOk1FZ1KuGU85tSUiXUu+TUSHg/gY=;
	b=CRbNUBRdrd8Ni/aMt+1leocvGlTp/5jzIcGFO+nOB/tgh8DkqWvvknolI9MtI2qbJlg+Rl
	L+V4pcgE/gQ6alGmej/xCuo8fHOGc86FIRRhZc2i0eekY/QBsRm7uROtEF2whjMzrmaNLc
	2eXd2yIESaRO2c0bnkGWGthr78R+VtI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-pAoU34iFMd26ZVdAZkS3qQ-1; Wed, 02 Jul 2025 05:57:12 -0400
X-MC-Unique: pAoU34iFMd26ZVdAZkS3qQ-1
X-Mimecast-MFC-AGG-ID: pAoU34iFMd26ZVdAZkS3qQ_1751450231
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-450d6768d4dso25230425e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jul 2025 02:57:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751450231; x=1752055031;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=B3XTbmiJEq13XDHOk1FZ1KuGU85tSUiXUu+TUSHg/gY=;
        b=r30i58oyVLNPayiX9g3QCV+asxliNG4G6V4vHc0J6VWqzLQr7LPhNcPUJ/LJrYbZ9O
         MGxHGQR67hYJ7ELDEzHW73r46mLm8gVuNGTUdO1ePZ5FRkGa1KFehAhQ8LgNWPdG5Xvs
         q+jYOtbjZJmetodaBbGdLNDJZcMsZOrJnKAsDYkqKXumyVPJ4BXPxFvkPjtrUhTdu6UN
         9KQSmtSzaQMYNLzATAQhvRDLrEqT8/UJI0kZZfnJCgdaDFEmcc4rHvupZ/cAGvyi8RT0
         CiqxR3noDhnvY/5GpP5oB49Im4DEK254ZB/juq2c6bmldG36Xup9nyOQ+UGy/v6mtkLI
         vk1w==
X-Forwarded-Encrypted: i=1; AJvYcCWTAq/+qt2DLqMgyXZzwEOlAWvcUT9j/fmEVzo8WhRO5G+bOnTX8XpZELiZNbfuK9ylIi+KbwMkRVECNNY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqhkPrilg/vir5g4wsiGDqEzBOI85Y0QDDvk7j39cLspUrHYZ+
	LLVc+IWXeEY14a+kZV1FAIfit8pcB89kSKKxSsAipSpRyyEULhmzsGhj/+67wGVLZ/YBTsHCFqP
	AfA8IxpfxSWJt/agDhygTPjKB2jOnhEeSJgtLB4r0FgJGotY9zZByZ19csmPr9SsHkg==
X-Gm-Gg: ASbGncvhFLxDSY75Byl1wsQBQG44V5GCchQV6PrIqMCIf1PL75R/3oomRlbte781A3c
	vkoTy7sI/9y3/8aqQSUaxx2ho7hoDfS0ogW3afZqugTmrD5z7P8kSycc70T/MLlytqFpFwppUNG
	4r5xh+gcoxLz72B9TBxuQSHTzfNnvicekcly8w//e0VFHzbzla4n4TLOQNrLERY5YLrO0jW2sF1
	baLuZwpJkw9pgQVsjMS/hR5DlbkMJQ2HFcXSfc64IYWRLNPp7hoi/GNch5+XRzGpiPkcVztB6ig
	MqfR/IeLN1NDOje1qJhwzI4NpJO49twSjrU/STOJWtGFSofON2AQ01A=
X-Received: by 2002:a05:600c:3b9c:b0:450:ceb2:67dd with SMTP id 5b1f17b1804b1-454a3741524mr19163515e9.33.1751450230692;
        Wed, 02 Jul 2025 02:57:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzP2YqoikjnnEh7eg0FezTi1nGNM4xV41MMHvMv78Y0WVESxCQVeHHMmC0Qpwtmi+C46p2Xw==
X-Received: by 2002:a05:600c:3b9c:b0:450:ceb2:67dd with SMTP id 5b1f17b1804b1-454a3741524mr19163235e9.33.1751450230171;
        Wed, 02 Jul 2025 02:57:10 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a88c7fa5easm15334671f8f.26.2025.07.02.02.57.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jul 2025 02:57:09 -0700 (PDT)
Message-ID: <c1144447-6b67-48d3-b37c-5f1ca6a9b4a7@redhat.com>
Date: Wed, 2 Jul 2025 11:57:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] vfio/type1: optimize vfio_pin_pages_remote() and
 vfio_unpin_pages_remote() for large folio
To: lizhe.67@bytedance.com
Cc: alex.williamson@redhat.com, jgg@nvidia.com, jgg@ziepe.ca,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org, peterx@redhat.com
References: <6508ccf7-5ce0-4274-9afb-a41bf192d81b@redhat.com>
 <20250702093824.78538-1-lizhe.67@bytedance.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250702093824.78538-1-lizhe.67@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02.07.25 11:38, lizhe.67@bytedance.com wrote:
> On Wed, 2 Jul 2025 10:15:29 +0200, david@redhat.com wrote:
> 
>> Jason mentioned in reply to the other series that, ideally, vfio
>> shouldn't be messing with folios at all.
>>
>> While we now do that on the unpin side, we still do it at the pin side.
> 
> Yes.
> 
>> Which makes me wonder if we can avoid folios in patch #1 in
>> contig_pages(), and simply collect pages that correspond to consecutive
>> PFNs.
> 
> In my opinion, comparing whether the pfns of two pages are contiguous
> is relatively inefficient. Using folios might be a more efficient
> solution.

	buffer[i + 1] == nth_page(buffer[i], 1)

Is extremely efficient, except on

	#if defined(CONFIG_SPARSEMEM) && !defined(CONFIG_SPARSEMEM_VMEMMAP)

Because it's essentially

	buffer[i + 1] == buffer[i] + 1

But with that config it's less efficient

	buffer[i + 1] == pfn_to_page(page_to_pfn(buffer[i]) + 1)

That could be optimized (if we care about the config), assuming that we don't cross
memory sections (e.g., 128 MiB on x86).

See page_ext_iter_next_fast_possible(), that optimized for something similar.

So based on the first page, one could easily determine how far to batch
using the simple

	buffer[i + 1] == buffer[i] + 1

comparison.

That would mean that one could exceed a folio, in theory.

> 
> Given that 'page' is already in use within vfio, it seems that adopting
> 'folio' wouldn't be particularly troublesome? If you have any better
> suggestions, I sincerely hope you would share them with me.

One challenge in the future will likely be that not all pages that we can
GUP will belong to folios. We would possibly be able to handle that by
checking if the page actually belongs to a folio.

Not dealing with folios where avoidable would be easier.

> 
>> What was the reason again, that contig_pages() would not exceed a single
>> folio?
> 
> Regarding this issue, I think Alex and I are on the same page[1]. For a
> folio, all of its pages have the same invalid or reserved state. In
> the function vfio_pin_pages_remote(), we need to ensure that the state
> is the same as the previous pfn (through variable 'rsvd' and function
> is_invalid_reserved_pfn()). Therefore, we do not want the return value
> of contig_pages() to exceed a single folio.

If we obtained a page from GUP, is_invalid_reserved_pfn() would only trigger
for the shared zeropage. but that one can no longer be returned from FOLL_LONGTERM.

So if you know the pages came from GUP, I would assume they are never invalid_reserved?

Again, just a thought on how to apply something similar as done for the unpin case, avoiding
messing with folios.

-- 
Cheers,

David / dhildenb


