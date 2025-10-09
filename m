Return-Path: <linux-kernel+bounces-847376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2D0BCAAC3
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 21:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 20E554E78A7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 19:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50CC2254876;
	Thu,  9 Oct 2025 19:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XkhhVSW8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9401E0E1F
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 19:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760037565; cv=none; b=YNlVpRx8DJh1YyEqgFtUrRc0N79tX/gNc3cyOVDkgmvW3M+fwBinTo80LMROB6awdDB6ufuReMH04l7LkC3LcCv0MrAY4S+6cC2XWnegmMQYOpxrhaiiiVmUCE2Uxt5Fx2zzVt1sI6MroivgdT1uNl7A+3TaxUu2ox+SlBEV4nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760037565; c=relaxed/simple;
	bh=9HpnDUUNM1Za7tp008fNatOpyEuNyRIDJRFp+lClZ80=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GKcprFy3zEBIYzlttXPdOW6ukYzc6c8e5Zzu9l+bEjTdMeuu4a7QrHpZt3S6yspxI2tZdJ2G0W9CZ8wDKLKco03Lq5CN0KV5UrSROhswZxG72UkuJB5FRD/B63cJwF8qF8meraYa7qd/gjIjB9aHoTjoVYA2kMi6WoOfAzG/+N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XkhhVSW8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760037563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=TQurpp90SeeCWbZFWp94YAV9HMnF9Yu3um4IgQUYoDg=;
	b=XkhhVSW8W1oo96Z7ThjmMamaIzBE50LhmaQcc5GKOxZeYjFwSOL1DKUUCgQJdf7LbZLK05
	cUHCF1WWp8YDzsrRcMBabtU+QUaJ5aNM8nUa0wjupMEeb7AH1usHLcCgobCwQu5Iw+AAZh
	tABwvnQF8sDbRCZtmbCW19npRF6goNY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-205-oaujvik2NdOKRu_U07zJlw-1; Thu, 09 Oct 2025 15:19:19 -0400
X-MC-Unique: oaujvik2NdOKRu_U07zJlw-1
X-Mimecast-MFC-AGG-ID: oaujvik2NdOKRu_U07zJlw_1760037559
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-46e509374dcso5754865e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 12:19:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760037558; x=1760642358;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TQurpp90SeeCWbZFWp94YAV9HMnF9Yu3um4IgQUYoDg=;
        b=s3Fri3dquwABk723+Q/dGRoYdlfKnAeQc/+38FL3zCTSAZZJ2nPVjTw1QMERuz5NhR
         /x46q/sbWaiHEiCTCCM1ggUOI75m8sTumLcCxYsYUG8CrUYvx5oTXf+E3XzVKw/b9YOv
         O0ThPJaLoBZhAsEKlq/2s+WJjlFZ/wAimUWF9ofwpweZCBc2XAbCn9pLxUjLGyF9tIjB
         o2c9Fdy0Dd0zUrYZtQng9U+OZoBQdbAoW+8bBZG3nHYXYQHUI+EGPNwCAs4dYpLps3+W
         xHkyZjH6xpJbWyCP7XQ7uOooakw8rLRXLtwENo1VfjUQVsECJL1SQGDEn9h0gHiPs11q
         GSlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwydfimC/tAqR3fQwUn1K3yQAB4OXQ6u7q0Y2b571YHVOJIPHo7q880c/bzIN9kc3cNIXBe8axiZHVles=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4b5KpHr9SrPCxs1zoxDXSJbgO/2tk4mJeUm9aioTqSABCUipZ
	fwrPee9rLnZ6e0B/yENC4sCLY6FZ3yxYtVmFaOy4HU3UYO5HD1o25V+LwY5j6cIkfmupWkMHCd4
	EB/38LXhD9OOFA82UXVS8+PDyXQWlQCmjTteulNOXSZHHzvuifAh+wxmKNiNQE4R5LQ==
X-Gm-Gg: ASbGncuZbAcppG23WPyvN5g2rb+cjjm9Un6dTMegGTDczAWFF2FuUltEJ6lLcvH1xxv
	JqUgSKA9434fIA3MRJajciVMg9OqNghHtoJMmBOOGT6GDfMVjlrY7adf3Ft5aBX1M6e32EI/Viw
	40rAsfk/dj9QrDOVpmOt5LEgXDtEKnlFo0tLUoD2i17CJgi0NR0ZByi17xVNikGbWX3Et4n3u5c
	e0MT0TxV9nkr83BuISsAE5LWjMQfC6TKEDuwK1taA7NdEH5WIElNeyuhOOq3GGrRaVELaJsE+TB
	5XKTTpZXDAAC1AWpwXnYTvCM9rN/iuX5XtZoCG4XiHcxlJ3EwqutCBm1YifFI4EgD3RwPeeTefw
	c2sjvA2Xn
X-Received: by 2002:a05:600c:a14:b0:45f:29ed:2cff with SMTP id 5b1f17b1804b1-46fa9b116f1mr67840665e9.35.1760037558611;
        Thu, 09 Oct 2025 12:19:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPGvbDunIELcWNQQhDPqw6NuTM3NX/huGnUquW01rlLkgxG+DlLb8fYLVnv4s+DldW5Q8i5A==
X-Received: by 2002:a05:600c:a14:b0:45f:29ed:2cff with SMTP id 5b1f17b1804b1-46fa9b116f1mr67840375e9.35.1760037558196;
        Thu, 09 Oct 2025 12:19:18 -0700 (PDT)
Received: from [192.168.3.141] (tmo-083-189.customers.d1-online.com. [80.187.83.189])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e7e44sm407353f8f.46.2025.10.09.12.19.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 12:19:17 -0700 (PDT)
Message-ID: <6a2e341b-7aa2-4bd8-bce5-dfdbd08d92b6@redhat.com>
Date: Thu, 9 Oct 2025 21:19:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/8] mm: Actually mark kernel page table pages
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Jann Horn <jannh@google.com>, Vasant Hegde <vasant.hegde@amd.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@intel.com>,
 Alistair Popple <apopple@nvidia.com>, Peter Zijlstra <peterz@infradead.org>,
 Uladzislau Rezki <urezki@gmail.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Andy Lutomirski <luto@kernel.org>, Yi Lai <yi1.lai@intel.com>
Cc: iommu@lists.linux.dev, security@kernel.org, x86@kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Dave Hansen <dave.hansen@linux.intel.com>
References: <20250919054007.472493-1-baolu.lu@linux.intel.com>
 <20250919054007.472493-3-baolu.lu@linux.intel.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZoEEwEIAEQCGwMCF4ACGQEFCwkIBwICIgIG
 FQoJCAsCBBYCAwECHgcWIQQb2cqtc1xMOkYN/MpN3hD3AP+DWgUCaJzangUJJlgIpAAKCRBN
 3hD3AP+DWhAxD/9wcL0A+2rtaAmutaKTfxhTP0b4AAp1r/eLxjrbfbCCmh4pqzBhmSX/4z11
 opn2KqcOsueRF1t2ENLOWzQu3Roiny2HOU7DajqB4dm1BVMaXQya5ae2ghzlJN9SIoopTWlR
 0Af3hPj5E2PYvQhlcqeoehKlBo9rROJv/rjmr2x0yOM8qeTroH/ZzNlCtJ56AsE6Tvl+r7cW
 3x7/Jq5WvWeudKrhFh7/yQ7eRvHCjd9bBrZTlgAfiHmX9AnCCPRPpNGNedV9Yty2Jnxhfmbv
 Pw37LA/jef8zlCDyUh2KCU1xVEOWqg15o1RtTyGV1nXV2O/mfuQJud5vIgzBvHhypc3p6VZJ
 lEf8YmT+Ol5P7SfCs5/uGdWUYQEMqOlg6w9R4Pe8d+mk8KGvfE9/zTwGg0nRgKqlQXrWRERv
 cuEwQbridlPAoQHrFWtwpgYMXx2TaZ3sihcIPo9uU5eBs0rf4mOERY75SK+Ekayv2ucTfjxr
 Kf014py2aoRJHuvy85ee/zIyLmve5hngZTTe3Wg3TInT9UTFzTPhItam6dZ1xqdTGHZYGU0O
 otRHcwLGt470grdiob6PfVTXoHlBvkWRadMhSuG4RORCDpq89vu5QralFNIf3EysNohoFy2A
 LYg2/D53xbU/aa4DDzBb5b1Rkg/udO1gZocVQWrDh6I2K3+cCs7BTQRVy5+RARAA59fefSDR
 9nMGCb9LbMX+TFAoIQo/wgP5XPyzLYakO+94GrgfZjfhdaxPXMsl2+o8jhp/hlIzG56taNdt
 VZtPp3ih1AgbR8rHgXw1xwOpuAd5lE1qNd54ndHuADO9a9A0vPimIes78Hi1/yy+ZEEvRkHk
 /kDa6F3AtTc1m4rbbOk2fiKzzsE9YXweFjQvl9p+AMw6qd/iC4lUk9g0+FQXNdRs+o4o6Qvy
 iOQJfGQ4UcBuOy1IrkJrd8qq5jet1fcM2j4QvsW8CLDWZS1L7kZ5gT5EycMKxUWb8LuRjxzZ
 3QY1aQH2kkzn6acigU3HLtgFyV1gBNV44ehjgvJpRY2cC8VhanTx0dZ9mj1YKIky5N+C0f21
 zvntBqcxV0+3p8MrxRRcgEtDZNav+xAoT3G0W4SahAaUTWXpsZoOecwtxi74CyneQNPTDjNg
 azHmvpdBVEfj7k3p4dmJp5i0U66Onmf6mMFpArvBRSMOKU9DlAzMi4IvhiNWjKVaIE2Se9BY
 FdKVAJaZq85P2y20ZBd08ILnKcj7XKZkLU5FkoA0udEBvQ0f9QLNyyy3DZMCQWcwRuj1m73D
 sq8DEFBdZ5eEkj1dCyx+t/ga6x2rHyc8Sl86oK1tvAkwBNsfKou3v+jP/l14a7DGBvrmlYjO
 59o3t6inu6H7pt7OL6u6BQj7DoMAEQEAAcLBfAQYAQgAJgIbDBYhBBvZyq1zXEw6Rg38yk3e
 EPcA/4NaBQJonNqrBQkmWAihAAoJEE3eEPcA/4NaKtMQALAJ8PzprBEXbXcEXwDKQu+P/vts
 IfUb1UNMfMV76BicGa5NCZnJNQASDP/+bFg6O3gx5NbhHHPeaWz/VxlOmYHokHodOvtL0WCC
 8A5PEP8tOk6029Z+J+xUcMrJClNVFpzVvOpb1lCbhjwAV465Hy+NUSbbUiRxdzNQtLtgZzOV
 Zw7jxUCs4UUZLQTCuBpFgb15bBxYZ/BL9MbzxPxvfUQIPbnzQMcqtpUs21CMK2PdfCh5c4gS
 sDci6D5/ZIBw94UQWmGpM/O1ilGXde2ZzzGYl64glmccD8e87OnEgKnH3FbnJnT4iJchtSvx
 yJNi1+t0+qDti4m88+/9IuPqCKb6Stl+s2dnLtJNrjXBGJtsQG/sRpqsJz5x1/2nPJSRMsx9
 5YfqbdrJSOFXDzZ8/r82HgQEtUvlSXNaXCa95ez0UkOG7+bDm2b3s0XahBQeLVCH0mw3RAQg
 r7xDAYKIrAwfHHmMTnBQDPJwVqxJjVNr7yBic4yfzVWGCGNE4DnOW0vcIeoyhy9vnIa3w1uZ
 3iyY2Nsd7JxfKu1PRhCGwXzRw5TlfEsoRI7V9A8isUCoqE2Dzh3FvYHVeX4Us+bRL/oqareJ
 CIFqgYMyvHj7Q06kTKmauOe4Nf0l0qEkIuIzfoLJ3qr5UyXc2hLtWyT9Ir+lYlX9efqh7mOY
 qIws/H2t
In-Reply-To: <20250919054007.472493-3-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19.09.25 07:40, Lu Baolu wrote:
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> Now that the API is in place, mark kernel page table pages just
> after they are allocated. Unmark them just before they are freed.
> 
> Note: Unconditionally clearing the 'kernel' marking (via
> ptdesc_clear_kernel()) would be functionally identical to what
> is here. But having the if() makes it logically clear that this
> function can be used for kernel and non-kernel page tables.
> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


