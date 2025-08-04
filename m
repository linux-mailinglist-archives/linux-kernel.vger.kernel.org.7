Return-Path: <linux-kernel+bounces-754838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12424B19D5E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 10:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D8CF1881261
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 08:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD08823504D;
	Mon,  4 Aug 2025 08:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cRMTjT8J"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9D915539A
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 08:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754294967; cv=none; b=PJk++J2BHEXdZGz8Resd9wNi54a5KN0OjrDeVevWpy/0CoKNheVE6D7Hy42dNbkMH+TVJbCPUvMQ8vWSupKe90nRV6aYK1/0vOWy1Tr1g5j6wMgY/GXYNIntxVu5gOJ0xCa2vO7PA6kDWANH+Dul227Yr5lsYRfqAEq7ZnkFHYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754294967; c=relaxed/simple;
	bh=c8eDqPazIychO3je57U8Kb9JYtLGc5puWSeZgnMHbzY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oR98qO0aRr/aS/30mj/OsqPptqIVq12Yn4LYevV0J74NAVKxKQiVNQHe5M5jCboWT2HnuSGagC5OpWrAv3FsL3n2TG/agz4w5qOJSXOXQb7rUWeYRI+8hJ8LWqkkX2zFeLe1AmPF2teb5iySq4ifj40XSIxy4xe64Z4bqEkiAp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cRMTjT8J; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754294964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=FeBzew9EjpLsssWR/x3cK3CyNtLtRunP4eu5LSewXBw=;
	b=cRMTjT8JNl7Sf1TOVS0atQVnvZIYiLzaU+fh2tuvYGJuO6TIkDbOy+4EvauzjkJs0o/x56
	KKjV/lhN9kMnV7430Y4GxhyBnO++GefNZPqBJnHNz7VYxNe+q7ArcMxf9oabUl91g63SrY
	brIosH0A6G8gYd+N5z+m6sXUvvNPiH8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-189-PfcK_-a6PVm3-gpUHWhuOA-1; Mon, 04 Aug 2025 04:09:21 -0400
X-MC-Unique: PfcK_-a6PVm3-gpUHWhuOA-1
X-Mimecast-MFC-AGG-ID: PfcK_-a6PVm3-gpUHWhuOA_1754294961
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45867ac308dso13356025e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 01:09:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754294961; x=1754899761;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FeBzew9EjpLsssWR/x3cK3CyNtLtRunP4eu5LSewXBw=;
        b=DB0SFsFIzQ5gHLqoNq4QgYgdqf8r9SRJhzWJYPuWmcJH18NRDERiY2W/dYNV0nHFR5
         UI5DTcAJIzlYh2yXDrGzGn8frI35N9uDSCoPYYmhbjFyjVcOIlJZOfI69z0abQPyy+X9
         380tJU6Dh/sbUyXXBBp8MJBr32Zn/4gcleQf6mM3kv824dx1hmNxCySdRqzq1idvZv7E
         HBbTjafdGBHWHvFZcuM5yrnlSoCwdShsenzwtpYmDNJb6VWuOVP1/dnOeTbj2gdIAfHP
         LIKK3A6Hd4p/Mkhu2fHfOLA8xe9wnLSM9qDoRSMTztRXb6+AbjwuGHUaxsYOieOPlUXG
         spqQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0OLMkeg+VwnqBct/sQ+oCLfOud2YVNHWI/YA5DaQkFijsvwBdeJlqQ5goqcFNilLi2+di7rWNoGSXx1s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3mkRt0sw1GrZPj4/W/6Is2RhHpkvydMFGOaQ6aeHfrMMMpsUF
	4KQIJkr1TS27rTlQFJPmaf/wDQui+EVLXnTafSSxrnhP7QIiyWeShPK2OGqoRMEucHzyG/jwgUw
	TZJCS+76tFPlKNVtek0USiWxNQ8xrdTdOUzM9A2UIqpbvexKf40jYRKLGDJt5Ck7vCQ==
X-Gm-Gg: ASbGnctIr9Xi7EIT+rHoju1nWS1fVIa92+jJiOXB3QfHUqWvx2Af74Hf1+/RObUm3wt
	iABOK/FJGU4XbV6lcdBn0GfDOsGUbS5jktg/WeE2LloByaIfhwpO9Icc50SxzSzMUkMz5Y+yfWd
	qtIW1SKp4nAK0Lxu9VQ7qeoZe8cZI8FDKxnTMlNK8x+ZnHmSuv5G3in1ChsbU/d375htaOhjhKB
	SCP8gDKM6SHlqe2HLy6x/dvhdfO2hdDYB2ExxMMaij74rhfe78uEp0nW3yBlr+5HEhH+IZgkrkG
	CjNbwbowp7zQL6weebOJvv6IvmTzHq9E9jn72pXtR5i+nVERivU5Rhytse8Zr7B1keheBQPnrWk
	b8G3HxMJYwuE+S5EsPrH4Yp+788C0cgdMGagqjlySlJeQuBqD8E959HqxGDWo7r+ghQg=
X-Received: by 2002:a05:600c:a43:b0:456:1b93:76b with SMTP id 5b1f17b1804b1-458b69cbdd9mr59436355e9.4.1754294960630;
        Mon, 04 Aug 2025 01:09:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHb1/hcPJTdy6j2wd+h4JIDrwPdLrVhFCdL8k5R5TQqequE53RFilWzQbkiLFan+5oyRU6hfg==
X-Received: by 2002:a05:600c:a43:b0:456:1b93:76b with SMTP id 5b1f17b1804b1-458b69cbdd9mr59436005e9.4.1754294960183;
        Mon, 04 Aug 2025 01:09:20 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f0e:2c00:d6bb:8859:fbbc:b8a9? (p200300d82f0e2c00d6bb8859fbbcb8a9.dip0.t-ipconnect.de. [2003:d8:2f0e:2c00:d6bb:8859:fbbc:b8a9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458a7c91c0esm136644785e9.11.2025.08.04.01.09.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Aug 2025 01:09:19 -0700 (PDT)
Message-ID: <56331143-0532-4b6d-b23c-d15ca82f17c6@redhat.com>
Date: Mon, 4 Aug 2025 10:09:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/userfaultfd: fix kmap_local LIFO ordering for
 CONFIG_HIGHPTE
To: Sasha Levin <sashal@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: surenb@google.com, aarcange@redhat.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20250731144431.773923-1-sashal@kernel.org>
 <20250801141101.9f3555a172609cb64fde7f71@linux-foundation.org>
 <aI04CQZZzgCDO2A5@lappy>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <aI04CQZZzgCDO2A5@lappy>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01.08.25 23:56, Sasha Levin wrote:
> On Fri, Aug 01, 2025 at 02:11:01PM -0700, Andrew Morton wrote:
>> On Thu, 31 Jul 2025 10:44:31 -0400 Sasha Levin <sashal@kernel.org> wrote:
>>
>>> With CONFIG_HIGHPTE on 32-bit ARM, move_pages_pte() maps PTE pages using
>>> kmap_local_page(), which requires unmapping in Last-In-First-Out order.
>>>
>>> The current code maps dst_pte first, then src_pte, but unmaps them in
>>> the same order (dst_pte, src_pte), violating the LIFO requirement.
>>> This causes the warning in kunmap_local_indexed():
>>>
>>>    WARNING: CPU: 0 PID: 604 at mm/highmem.c:622 kunmap_local_indexed+0x178/0x17c
>>>    addr \!= __fix_to_virt(FIX_KMAP_BEGIN + idx)
>>>
>>> Fix this by reversing the unmap order to respect LIFO ordering.
>>>
>>> This issue follows the same pattern as similar fixes:
>>> - commit eca6828403b8 ("crypto: skcipher - fix mismatch between mapping and unmapping order")
>>> - commit 8cf57c6df818 ("nilfs2: eliminate staggered calls to kunmap in nilfs_rename")
>>>
>>> Both of which addressed the same fundamental requirement that kmap_local
>>> operations must follow LIFO ordering.
>>>
>>> Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
>>> Co-developed-by: Claude claude-opus-4-20250514
>>
>> Well this is innovative.  I doubt if Co-developed-by: is appropriate
>> for this (where's Claude's Signed-off-by:?)
> 
> Claude (or any other AI) can't legally sign off on code :)

I think we need a different tag than Co-developed-by. Avocado [1] seems 
to use

	Assisted-by:

Which I prefer over things like Generated-by o co-developed-by:

[1] 
https://avocado-framework.readthedocs.io/en/latest/guides/contributor/chapters/ai_policy.html

-- 
Cheers,

David / dhildenb


