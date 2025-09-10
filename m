Return-Path: <linux-kernel+bounces-809811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 279F1B5124E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 11:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 250D81B27853
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 09:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051483126C0;
	Wed, 10 Sep 2025 09:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bk7liKNZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC020311C21
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 09:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757496073; cv=none; b=aMmwqEpK93JvVsFLSSNOJpafqrn6Xdvpx48wI8UKQhtay8L5FioyLnJ5pirBl6c0z9SelbfcnRFRnQ3688lppRVc36wTvE3QawI5qbBB89srJOHuiPHpKGvGttmZV/yOtF9wS9HD+Olh+Mo/vTAH7dExjnMZZimQVe7JmmaT1DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757496073; c=relaxed/simple;
	bh=umrSFJLvax1nJGHbQCZt0adE5BTTV5Lcal0ybaH4HiE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=phvKKNfpdEIEgTA3iYZgmUtRstLdP7WUMILBSB9VzkcBljn0zAoE33k/gbaLWr2BrAoiRE8xIa/LC6xAtOuCPUSJ6ceV7nEeiKbdswqEhcqB+Jx+1XCvtYeCvtG3PVPmHw32xXBz48N2fFqWD5uQlKVYAjzKPrB7KVHmCMpfXq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bk7liKNZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757496070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=IXsx9Ic7O7zZ84RSI3WUTXXDbyazumVEbCuc+kUHkxc=;
	b=Bk7liKNZJoHBWy32ylkkfZVsiO4dMXyKZB/+W0yZcqX2wm3Ka2FXAcuYSeNCub55z6XopQ
	Yjfm+jWRHe0kDZe4ZJXpHBUwiHhXSgRAEL8oCxfjVVRUlhduPcdCKCyR0BRyVcaIjr21aA
	JKWElBDzooAt0Iu8tJLG0sHZbbwqOyI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572-oPmJQCIBPC-Fr9Y_p49yYg-1; Wed, 10 Sep 2025 05:21:09 -0400
X-MC-Unique: oPmJQCIBPC-Fr9Y_p49yYg-1
X-Mimecast-MFC-AGG-ID: oPmJQCIBPC-Fr9Y_p49yYg_1757496068
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3e3b77972cbso2524775f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 02:21:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757496068; x=1758100868;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IXsx9Ic7O7zZ84RSI3WUTXXDbyazumVEbCuc+kUHkxc=;
        b=NhbuL4hJPEKyh4MoNy1fFBYm3SyyTvDJ45krRipty32QcQvCNWgpdf6XKMawazmaX9
         07Bs9gnG3w3coPEhdebg/AH7JHJLz8RVjJKxTJQCkBeH7vqzV/aKSNLNfRj0WoYltA8M
         UvBs8uZ5Mkme8pGIOxUaIT5CULg6oD0hjhvsyAOSTPYBzwiq5yTgJ42xHGwOLwa/V5Er
         NeoZ/3TcUNNfWH+Q4rvFZSLuT78gXnLF5iVPQlJaRFnoNSeY6P4n3BSXBdkcpmO+YA2+
         df3Mtkhqw4Xh6ThREF3i+zorx435l51u3SQ1ucN/mLrS+pivkS+udNJ00qc3421+BYBm
         b3Ug==
X-Forwarded-Encrypted: i=1; AJvYcCXbcp9nm3ix7WudXR8jgv5TSLQBHMqFQcG2Cieb8NYTYVdYgj/4IlAE9S3iWYZAoau1uJIvBvbz7ATbMwk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRYEiiKatWA3dq0OWLAF/PEExoWH8yoa77Or2t3HCR47bgFIc6
	m1q7dwRtOo+SbU4qsofAmWf9AsJ9xcH8B5nF6BcWikEPOhBDPildglPr7XzeW6NjvjPjEzIuJ2O
	CP+nWQFJzLgXxrN+0WpZY4j7Vh/Gp+xRe44zvmI2UkvYawV0RWzceoWuZHvVTH94qQQ==
X-Gm-Gg: ASbGncuW/lHeaLzeJftkvI7oLvlZdOMQoVmfTXM7Lu7xaCZNMaAT6s/865UBsRBimDX
	JYFvSVvp0/LH6oMFjs4+lAUxuyXchGj1sWTUsGS7rfVEg8k05WJo2m7EvBULQQASQEKvTuWhIE5
	BvESIpazbBuOc4cYfEl21b1ZoeQ0icrvcsDUDlwYnsJznEksMjl0JtA4rjKh2IzPFmstACh5/j2
	0t6PHrjmkTjkcv2XG/JV50uVuN7/SrOoITnqrSXWUh7VSYblBmG9hgOCZENgGlKci68O5xxf4iN
	al9QNoIQ2vZjDlMSKCkDW6STvlpy7jFN4vMkAsB3sFm2rDIz/4tBJxsuzRrCGxbFvTerynQREnf
	bGMJ6IpWXk26geJyRwj+Gr/VJKBC3nu5kpUOSM+c37REGBtCOJEHyJg8ngDt8atPH/n0=
X-Received: by 2002:a5d:64c3:0:b0:3d0:3eae:576d with SMTP id ffacd0b85a97d-3e642f8f76fmr10290441f8f.22.1757496068105;
        Wed, 10 Sep 2025 02:21:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCnT1FVklH7nbjNgKoM/He/fVrE4yAXPhgf7MBYTl2+m5PkmwhD6Q2MRLgU+UZH+dNGP9RYQ==
X-Received: by 2002:a5d:64c3:0:b0:3d0:3eae:576d with SMTP id ffacd0b85a97d-3e642f8f76fmr10290400f8f.22.1757496067526;
        Wed, 10 Sep 2025 02:21:07 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f17:9c00:d650:ab5f:74c2:2175? (p200300d82f179c00d650ab5f74c22175.dip0.t-ipconnect.de. [2003:d8:2f17:9c00:d650:ab5f:74c2:2175])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e752238997sm6493544f8f.37.2025.09.10.02.21.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 02:21:07 -0700 (PDT)
Message-ID: <2fe10966-521f-4af5-a9cd-f55d04b12eb8@redhat.com>
Date: Wed, 10 Sep 2025 11:21:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mm: remove PROT_EXEC req from file-collapse
 tests
To: Wei Yang <richard.weiyang@gmail.com>, Zach O'Keefe <zokeefe@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250909190534.512801-1-zokeefe@google.com>
 <20250910091622.n25zvgw27olskao2@master>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250910091622.n25zvgw27olskao2@master>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.09.25 11:16, Wei Yang wrote:
> On Tue, Sep 09, 2025 at 12:05:34PM -0700, Zach O'Keefe wrote:
>> As of v6.8 commit 7fbb5e188248 ("mm: remove VM_EXEC requirement for THP eligibility")
>> thp collapse no longer requires file-backed mappings be created with
>> PROT_EXEC.
>>
> 
> One question, what if user run this new version test on old kernel?
> 
> Is there a guideline for user?

We try to keep some older kernel working as long as it is easy, so 
people have to do less manual work of filtering out false positives if 
they happen to run these tests on older kernels.

6.8 was from end 2023, not sure if we still care about that.

-- 
Cheers

David / dhildenb


