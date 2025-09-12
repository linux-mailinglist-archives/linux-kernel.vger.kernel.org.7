Return-Path: <linux-kernel+bounces-814009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC255B54E3F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 14:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B72A91890AC4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC94305973;
	Fri, 12 Sep 2025 12:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C+7TX9oq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123682DC77B
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 12:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757680548; cv=none; b=QZW2Bsik2QzxFCaqKYwC6Y2jkB5CeD1NQ2hKYuWU5P8vq+gXDwug6ouK+q5MHCsn2B4IN5cfJuLzJlNqg1ZPZ/oDdkE55RPwLz4ISYpXcVEH7ZUhHDCp8vBqOE1a+OBmPI6R27VA8M7Ckuu19sKzYB43S2ksMD1U5N1Y+Ve2EIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757680548; c=relaxed/simple;
	bh=9naDuZ89ohkhST9nPdyMsS/odQGyMK2ICA4KVhv0buU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mccz92O/XWNc7wp1TCQb+pl9YAMjxjtY5F8Bu28cMMVVzTH7zejZFA53YNjAUqVsKRTUU5NnWPZqKK276njeIKVjKDuGhu3tn20l4UYguu2PJLKLM17mHi8ZPYOqfczqlVlzBjOVM31zfEtY0SQDF3TLFYKJIoRYpd2ErkC1oQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C+7TX9oq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757680546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Vl4F3QETQ6Qmt3iYKAH8GUoCSTGHR7l04Sg9h/MZCJE=;
	b=C+7TX9oqLrppOBbv0t16W93Jb5oOgC1Btl7zBitJYbOFuUy2ceKkmTc35wa0osncv8DLt2
	UDunEMw9PeHKyqkddSd/95wh+j0WBnp1ybYrP2uz3ZNx4v7Z7XcBBG10Q9dvBYie2QrbsF
	HkI5d/noJ4motv/7s198c5ihsYOybTo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-ALZ12K6GNMCTKBuJpt1oAg-1; Fri, 12 Sep 2025 08:35:44 -0400
X-MC-Unique: ALZ12K6GNMCTKBuJpt1oAg-1
X-Mimecast-MFC-AGG-ID: ALZ12K6GNMCTKBuJpt1oAg_1757680544
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45b9a856d58so17620315e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 05:35:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757680544; x=1758285344;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vl4F3QETQ6Qmt3iYKAH8GUoCSTGHR7l04Sg9h/MZCJE=;
        b=pZRPzSJCeFrUsXijtEZnMYEKoNDy+5Mst5i4oAlc0U+MXJJDpk67Fiquqt+CBkHbDe
         AQ2MbzdUGUGoNLneToO0StMlLIi50SfdjfijX/xewNxqAmsESLP3+E4vTc2j5K1s8/E5
         wAoGS23EexWKV/O73+UIZhuvs+iIo1uR/ozptGBt6N865sXD/Ko8jQgLc1loEoq63g1P
         ijQPGC+bGTS8uOg3Sn/uLP4I15Vi1+tPAeGa4w3lgpj86tum4gC4MbfDAYRAQY63/QRZ
         S4dkkD1jxET/1f9qBAHI0TPW4zEgWT8Er3llOayMPqpwWWH433oqRXLFe7Qe06IMMkgI
         BZ6A==
X-Forwarded-Encrypted: i=1; AJvYcCXx4B31nBN1VZAjliHrjOuon6oqAF+uDvdspLCsLANwweMUeCX8zCERTE/apP/mn7HMkA0ScqDrJzXuGlM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwyA/c9qa2abNsXF+6Rjmj6ij4K+NcR9Wvbeo3vaSPd4McwUYQ
	gN2Lr1ZnM1ttUhVDbSYC0pw9Vie4VQ6mJoaJVER1sxLIo8Ca1BFLeTJO0t5idzmATzRCM2F+JYF
	uquu+/ZodKTe/GFHA7/S8xuYHA7fqZomNV/5Htw54EbP2FPAmeAh8Fj8opH6AVBFnFA==
X-Gm-Gg: ASbGncs637TvpD3bKakWRRueHPtQo0D5Ur5I73qsdKuCNzZxIHLC/J0iGZIKv/kkxB3
	yYqM3/UVo+VkJicGJ3886a4xMmAPVBPSc4HEbHtnr3bIGUBJY+P+ToOvK6n4u2TrtFlpFYNa7TH
	7zhCDa2P1pdRFQ9+ZupnE/CvXgWs2zPWhjD/jjIG4NZrurrmgfLaAqcCQ5qoGTYS0piCq9pMwnx
	mEVLPLBNf+mxUOZkTPo5sCEkt0AEEv4j3YbVR6Y5lmGLpeXErE9C1TbDahzUzMiEa7XaFvH7jdL
	9edLs6Z47pcZYilJdZTi+lizZIqTlwEqxJnuZtKK6PsvZLmk+1aO0BUmRqUsMeleaHlAcpUPCPX
	dOXoPiS6S20SUtYMuSQoZnFUFyM/KEH3zOyX/h6Nh/Q2gGUXGw8LCANshHHiKexZXyAY=
X-Received: by 2002:a05:600c:6d41:b0:45b:47e1:ef68 with SMTP id 5b1f17b1804b1-45f21208123mr19824065e9.35.1757680543629;
        Fri, 12 Sep 2025 05:35:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEN/oqbYA0X7f4pVcp67reuoA98LJhkZr0rCtEodluWIHcTYO0r2jSI0s6HquK2fSwltZexZQ==
X-Received: by 2002:a05:600c:6d41:b0:45b:47e1:ef68 with SMTP id 5b1f17b1804b1-45f21208123mr19823715e9.35.1757680543157;
        Fri, 12 Sep 2025 05:35:43 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f20:da00:b70a:d502:3b51:1f2d? (p200300d82f20da00b70ad5023b511f2d.dip0.t-ipconnect.de. [2003:d8:2f20:da00:b70a:d502:3b51:1f2d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e037b922csm65908345e9.15.2025.09.12.05.35.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 05:35:42 -0700 (PDT)
Message-ID: <175479c6-d43f-48b1-8fb5-c78a555cd315@redhat.com>
Date: Fri, 12 Sep 2025 14:35:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] selftests/mm: Add -Wunreachable-code and fix warnings
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Shuah Khan <shuah@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: kernel@collabora.com, Sidhartha Kumar <sidhartha.kumar@oracle.com>,
 Kevin Brodsky <kevin.brodsky@arm.com>
References: <20250912123025.1271051-1-usama.anjum@collabora.com>
 <20250912123025.1271051-2-usama.anjum@collabora.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250912123025.1271051-2-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.09.25 14:30, Muhammad Usama Anjum wrote:
> Enable -Wunreachable-code flag to catch dead code and fix them.
> 
> 1. Remove the dead code and write a comment instead:
> hmm-tests.c:2033:3: warning: code will never be executed
> [-Wunreachable-code]
>                  perror("Should not reach this\n");
>                  ^~~~~~
> 
> 2. ksft_exit_fail_msg() calls exit(). So cleanup isn't done. Replace it
>     with ksft_print_msg().
> split_huge_page_test.c:301:3: warning: code will never be executed
> [-Wunreachable-code]
>                  goto cleanup;
>                  ^~~~~~~~~~~~
> 
> 3. Remove duplicate inline.
> pkey_sighandler_tests.c:44:15: warning: duplicate 'inline' declaration
> specifier [-Wduplicate-decl-specifier]
> static inline __always_inline
> 
> Reviewed-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---


Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


