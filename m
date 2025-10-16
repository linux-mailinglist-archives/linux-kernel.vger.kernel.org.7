Return-Path: <linux-kernel+bounces-856847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECDB3BE53AF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 21:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F0D7189E6D6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 19:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7BA2D94BB;
	Thu, 16 Oct 2025 19:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y4DlvKcJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287D02D9EEF
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 19:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760642796; cv=none; b=WBtGz4OHwfbqluCok6RURrqSWuaBN07EPhD72hNnSf/+Rzp5USNFti+BbuEFmsFBdw+V2Ioynn2z7MFbJOWyS5t0I1OIo2UnvFtYdySzP4b4raoUQ7ltaBqe9eW9ZrIe5ZL9hUZFiDySUjCJ420H7tYQXwUwbf1PpWtGG3m5lco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760642796; c=relaxed/simple;
	bh=+d8sCIyWUEcliU3+55WdrPS52+T1lYhla5/vqQbvBVo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qgx+HZhXecc8T/3ux5uFXmuzMdXhBZr/rI09Epb9VcX3hsum9zrHNFozC0ynzQU6U3QV4BIC4gneXj3PmE1k0fSC3WJ/OGA0vx2FKZSQlxx1CFyhgtcgtJIYs7AHhV/qG/8QElsXamoH3rRlYX9cMRJJycgDvkxJaomM479qXb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y4DlvKcJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760642794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=msR0ZBpYEHAnmAg4rddKbDGdznbasqHjFLWWxAmY12M=;
	b=Y4DlvKcJ+D4No0gJbv3W9J4PeFmJO9XA5jMktVyGlOi4i0t1Ih0nvi7Wfhwf0Re7gt6Bln
	oVnVNx74vIz79mHtZKojwDC5SYO2nkW78uVljXeo1qSbTVRBZhR2s59Rpz5RvvKiUmGc/T
	gaRCjmlo8VnPpc+7+w4/4unWn+BYd1s=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-I8TzYpqZPnq9oOwLmZ1YmQ-1; Thu, 16 Oct 2025 15:26:32 -0400
X-MC-Unique: I8TzYpqZPnq9oOwLmZ1YmQ-1
X-Mimecast-MFC-AGG-ID: I8TzYpqZPnq9oOwLmZ1YmQ_1760642791
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3f030846a41so725482f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 12:26:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760642790; x=1761247590;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=msR0ZBpYEHAnmAg4rddKbDGdznbasqHjFLWWxAmY12M=;
        b=aTUsqkTvvG8ci40m8RM8OdkTC24IF99MIBO29IxaYCQnjTZ/nWgG9Q1ILZpWY5P+eB
         uQS4Bm63Qe4gwVOcJT4GeEKp63CNqqPDXYkNbVHGplWI8nDyX6EV8yaeN6Q1HPZpfOGJ
         qmwcDE6vSMkm+4PD5MhutMxphXRjEueg/XHLkS+cxlPkQygKllvnoV7FEHfvCWDAlWBy
         nF7hWsjMpMicYNUJoll1EHq3Lz+kC1r/CadZA71lt82pcX7UrJMfFaKtUwm85vMPiHWT
         sy57aYaOvGHk+dMQV12LY690u3iJ08Rn5YDlvF73YZLp6w/SvvW+rVgqjIjhX9AWNU00
         lHJg==
X-Forwarded-Encrypted: i=1; AJvYcCWK3tNAFPiZ3hetqXInl5p+6wVYDtNM+vbWYXapZDny+Oeivz8Qq4QyMozKFRNa8wVDdZvZd6D7qRoOdVo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/2dC9U/f175pat8RAM+HSjU4oXIsV0Zqq830hV/nYtgurY+hR
	YDJtJV8yTJfjB7nZiI+hZjYI7PZUBtLLWrKKT4VAVg4Ojnjz5o/yYq9nmKLuU0GIUNc/45cUrdy
	uJwxO7VUdG2kQdE9Zh/2rD46jOquWDIgj7VDHLbsW6rRBKO9PH+adluO1iuhr+CWt8Q==
X-Gm-Gg: ASbGnctlcIC09VB7476LkR8Dya+mV8ZFLQQ2h+ADWOZSngxUrncbvq/JYKTDuZANuXu
	1Jpbrf+jJrRmpyHemu2E0WfDYHLD4wbCkxTVMVBJgQ6I3ec4sibteMrvYbvobd3n+f3Utz7qBTl
	TTMi02AWo+RxY8DmiAWm+TfCYQQGihCyS8UMzuQ5lFUc5jYv2RtRWxCG6ZR22Z8Ebb85vdw2/2N
	zkW5IOQ9KEv0JanY1OD7sapqNQ9ogHm4WDQy0uTdrnydf8/7Z/u/eWMJejcBfQ7R66lZSwMdHew
	TB0vdYwCxDd80eFIEvQu3QF9iagCbV0/LMxoT3FW+L97QnF3seVPWqGEOteuoR5gWBcUKlEBXgT
	emnmOOYZkVqxi5avNgUpTE0FK2J+fKJE9N1qciNjIT9tif9S5C+IymK7SojCXplpO5aip8/+fhA
	cPaP64pyI1+qP2lY/+hLIB/ge7Jog=
X-Received: by 2002:a05:6000:310b:b0:3eb:8395:e2e0 with SMTP id ffacd0b85a97d-42704dab124mr776099f8f.51.1760642790422;
        Thu, 16 Oct 2025 12:26:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyMIju1bud+5UvtGP+4+k2+lDXhOQIehYLmTBnYw4ldcLbEqw/fyQAEb5hw8VUiraCPtRD+w==
X-Received: by 2002:a05:6000:310b:b0:3eb:8395:e2e0 with SMTP id ffacd0b85a97d-42704dab124mr776067f8f.51.1760642789941;
        Thu, 16 Oct 2025 12:26:29 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f0c:c200:fa4a:c4ff:1b32:21ce? (p200300d82f0cc200fa4ac4ff1b3221ce.dip0.t-ipconnect.de. [2003:d8:2f0c:c200:fa4a:c4ff:1b32:21ce])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5cf71dsm34704508f8f.29.2025.10.16.12.26.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 12:26:29 -0700 (PDT)
Message-ID: <7f5fe813-5921-4331-aa81-8be9aaa6a8d4@redhat.com>
Date: Thu, 16 Oct 2025 21:26:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/7] mm: Add a ptdesc flag to mark kernel page tables
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
 <20251014130437.1090448-2-baolu.lu@linux.intel.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251014130437.1090448-2-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.10.25 15:04, Lu Baolu wrote:
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> The page tables used to map the kernel and userspace often have very
> different handling rules. There are frequently *_kernel() variants of
> functions just for kernel page tables. That's not great and has lead
> to code duplication.
> 
> Instead of having completely separate call paths, allow a 'ptdesc' to
> be marked as being for kernel mappings. Introduce helpers to set and
> clear this status.
> 
> Note: this uses the PG_referenced bit. Page flags are a great fit for
> this since it is truly a single bit of information.  Use PG_referenced
> itself because it's a fairly benign flag (as opposed to things like
> PG_lock). It's also (according to Willy) unlikely to go away any time
> soon.
> 
> PG_referenced is not in PAGE_FLAGS_CHECK_AT_FREE. It does not need to
> be cleared before freeing the page, and pages coming out of the
> allocator should have it cleared. Regardless, introduce an API to
> clear it anyway. Having symmetry in the API makes it easier to change
> the underlying implementation later, like if there was a need to move
> to a PAGE_FLAGS_CHECK_AT_FREE bit.
> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>


[...]

> +
> +/**
> + * ptdesc_test_kernel - Check if a ptdesc is used to map the kernel
> + * @ptdesc: The ptdesc being tested
> + *
> + * Call to tell if the ptdesc used to map the kernel.
> + */
> +static inline bool ptdesc_test_kernel(struct ptdesc *ptdesc)

We fancy const-correctness now:

static inline bool ptdesc_test_kernel(const struct ptdesc *ptdesc)

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


