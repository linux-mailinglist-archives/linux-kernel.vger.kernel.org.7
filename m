Return-Path: <linux-kernel+bounces-856853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 442F6BE5400
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 21:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1CAA54EBE0B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 19:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A152DBF49;
	Thu, 16 Oct 2025 19:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ja6KBC9S"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063F41917CD
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 19:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760643321; cv=none; b=gQVBtz/ivjjCmAqldpt3L9+BvJYqfJURBmgljLgST7+ubxoVqOmwM7wgiTADiI96fsjI/PHWx7MdoEJgMajG/ZXkGr5aptDXFT+u2P/SOk9arkRIRNpCp2l5XzXApYcge+/NQkP6L+AL5xlOc7Vj/j8F/gLRwo5P49j/ovgZdHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760643321; c=relaxed/simple;
	bh=nreNVeYUBbg9i70ecdEVMZOQbQA1QCcWewf5uIYnUpY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=To6D6rAGLmfwZ0fMnn/fIhjFkR1mMmXjMnnLvnZZ0P2I0tsCuQobYlOr59EyTFeR8un50V+MZLO8Q2lAy2IoTITR4a8zaLWxB0wX9xIdeofxSkrI+tLYFh2jVKY1LtChsfknUk1q4vjnf7HJxIUTaq6kJbO/LCpyTSrI5xf/Ozk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ja6KBC9S; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760643319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Mzf2KOoxYTwPszQZbnCr3w1S1PHGYisO4oTStjZPcT8=;
	b=Ja6KBC9SCqXuODVlajVVKheYEtrc0IhIGw4tDpbjrCCMoeAkuueZRIY1OneLFew4XmBC2+
	T36q73XxqbeHx4WCN9JO5v1pw4ZtAeqfaUeqCW8xMI3yPQ0YDh3A0Dd9J18pwt6KpYW6ST
	yki8mTcB0mkUNvMA+blKFRELkPERxNo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-P7NOerJSP7uDAoibr4-s5A-1; Thu, 16 Oct 2025 15:35:16 -0400
X-MC-Unique: P7NOerJSP7uDAoibr4-s5A-1
X-Mimecast-MFC-AGG-ID: P7NOerJSP7uDAoibr4-s5A_1760643315
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-471168953bdso6084295e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 12:35:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760643315; x=1761248115;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mzf2KOoxYTwPszQZbnCr3w1S1PHGYisO4oTStjZPcT8=;
        b=lSK6CiLvXKAkqU81cWxlieSRMa2kS4poO91uuwIu5+ECp0BE9vTDC2Hazk+Zgj2AjJ
         Yz+k3jZnKMvkVT7ElELYl3OA4a4PQqVzty9u3CBsWjU6XMDBoxoPuEQVQDpz2QkAlMi9
         eQPftD5TIlyDomhkOSlzJhWxKUE9p9lfWValVNfovUMVTw4tm1bWfMijUC4rTfw3aAnk
         /0zIPM5cR+VZpwLlFnhlqvjNanFYXR9WshhyumARTa73stn1vutAxGtLKbe3zt1cKLlQ
         +jSFqHNcZTKa39WfNNcs4kTbzRdPf59/bNUixU3t5vIDCrWcA1AQbN7MHeV1MPdnCR/n
         BcwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEfXR5/TNnBSALU4rSB8W9lHCDFwRn1GqanSmWGOQVXa/w0EwCJRQ14VHTRU24N0HTm92oeHCgdmPeGgM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGibj+62Pfb2Zn/7XXPkHloPwyre7YADHSNngc+bleRPw4ukKh
	kwnZc1eOlFgs0TyGVCBA87BwabHQAnEzSEWQmdqpnJ8WMvKhNl/YdY8s2IrGD1s6yDS56yRo6G/
	NlvaQX4RAc10L5XxSPwJYjD9TJA65+uI2kkyU/CkW2to6cDgUIgwyfb5/okOFxUBVJQ==
X-Gm-Gg: ASbGncv0Cvu4WwlTjtskifHvDojlrwP12eO7aiQOYr5W2Wg3kCz96wInpTGPFZL/mRv
	dfLvVW+mbEnc6NS2o3+VC2v81DIzhzQok3wXyq+wr1E5BWR/vwHxtoK38conqTxFfYMzF50fq48
	l3a/KnRGuH4iWNWDASlFDL6APik7YabiGDbTy6LzLtQPTYMXj/6kpHAOTlH1zFdv6BvO7OkOnUn
	CWB90UJvBhW3dULjCWhe0liWOvhV/FUnaUKya9kKQFkrjRgNHXU+8BBjxH40PogkJMTDqzHZba2
	GH2olKQRfnWRiwgAalsgrxXgfvaeTNnrpfUq6bQA8cC8cOrtabWjkyF/8/Ax/q37ZsJVEUU5O36
	jwJIxqGB4dPJztKJE/W6enHnUWr7wIlKUIVRrluAop1n+BM7I1N4iQbQ4v/17gZp4pcx73fLQe6
	oP/ypsCn3U1TxR9EgU02ReTq9Kouo=
X-Received: by 2002:a05:600c:548c:b0:45d:5c71:769d with SMTP id 5b1f17b1804b1-4711726289cmr12476915e9.8.1760643314704;
        Thu, 16 Oct 2025 12:35:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHM6TLgln996pR3E0IOQ8FhCXzoWThxFAhFVfWLmNgeZg4GR6X6l66UDma89Hxbe82/HUeJxw==
X-Received: by 2002:a05:600c:548c:b0:45d:5c71:769d with SMTP id 5b1f17b1804b1-4711726289cmr12476595e9.8.1760643314233;
        Thu, 16 Oct 2025 12:35:14 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f0c:c200:fa4a:c4ff:1b32:21ce? (p200300d82f0cc200fa4ac4ff1b3221ce.dip0.t-ipconnect.de. [2003:d8:2f0c:c200:fa4a:c4ff:1b32:21ce])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4710f2ab58bsm26257825e9.10.2025.10.16.12.35.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 12:35:13 -0700 (PDT)
Message-ID: <e62bad6a-bd49-48d9-aa2d-9e2022f829b3@redhat.com>
Date: Thu, 16 Oct 2025 21:35:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 6/7] mm: Introduce deferred freeing for kernel page
 tables
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Jann Horn <jannh@google.com>, Vasant Hegde <vasant.hegde@amd.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@intel.com>,
 Alistair Popple <apopple@nvidia.com>, Peter Zijlstra <peterz@infradead.org>,
 Uladzislau Rezki <urezki@gmail.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Andy Lutomirski <luto@kernel.org>, Yi Lai <yi1.lai@intel.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>,
 Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@kernel.org>,
 Matthew Wilcox <willy@infradead.org>
Cc: iommu@lists.linux.dev, security@kernel.org, x86@kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Dave Hansen <dave.hansen@linux.intel.com>
References: <20251014130437.1090448-1-baolu.lu@linux.intel.com>
 <20251014130437.1090448-7-baolu.lu@linux.intel.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251014130437.1090448-7-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.10.25 15:04, Lu Baolu wrote:
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> This introduces a conditional asynchronous mechanism, enabled by
> CONFIG_ASYNC_KERNEL_PGTABLE_FREE. When enabled, this mechanism defers the
> freeing of pages that are used as page tables for kernel address mappings.
> These pages are now queued to a work struct instead of being freed
> immediately.
> 
> This deferred freeing allows for batch-freeing of page tables, providing
> a safe context for performing a single expensive operation (TLB flush)
> for a batch of kernel page tables instead of performing that expensive
> operation for each page table.
> 
> On x86, CONFIG_ASYNC_KERNEL_PGTABLE_FREE is selected if CONFIG_IOMMU_SVA
> is enabled, because both Intel and AMD IOMMU architectures could
> potentially cache kernel page table entries in their paging structure
> cache, regardless of the permission.

See below, I assume this is patch #7 material.

> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> ---
>   arch/x86/Kconfig     |  1 +
>   mm/Kconfig           |  3 +++
>   include/linux/mm.h   | 16 +++++++++++++---
>   mm/pgtable-generic.c | 37 +++++++++++++++++++++++++++++++++++++
>   4 files changed, 54 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index fa3b616af03a..ded29ee848fd 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -279,6 +279,7 @@ config X86
>   	select HAVE_PCI
>   	select HAVE_PERF_REGS
>   	select HAVE_PERF_USER_STACK_DUMP
> +	select ASYNC_KERNEL_PGTABLE_FREE 	if IOMMU_SVA

That should belong into patch #7, no?

-- 
Cheers

David / dhildenb


