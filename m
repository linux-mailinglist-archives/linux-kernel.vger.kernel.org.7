Return-Path: <linux-kernel+bounces-735183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B5BB08BDE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 13:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF8EC175D9B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 11:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3785929ACF0;
	Thu, 17 Jul 2025 11:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sh64oX4M"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FD5219EB
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 11:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752752633; cv=none; b=Gg96vjEN0dClUp+cTSbc8e4zykrzYp8OOEm5rCCT4fH/TC8IuAeYSAEHp0VT8TFGok1uQPVKVgslNjZDmtkoYzKNDULUHCC56xnBu4/KLbCOSNgN0jlA2FmOO0qsijmrh5Geccd8tzQEZalaPfE68dk/nuviOqL7gn83T87Dht0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752752633; c=relaxed/simple;
	bh=8NgOVC5TWuXLLTumrhHon19hOmU7y9DnEei4mvnV3vo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bTA8HMZdRYvEMxcIVjmirnVpU7Zc81roIezVJl1ZGvTeOIcqsHB98Xd1ZF3ZGDeAo7raxpuIyuv3FQEewuJLwK3RspPyea/uTRG5pj/DWV0MwLi1EBeUCVL6ZVItpVx5HF3dSlqEdUrUaTGSWvPj/yqtmXmh00qfB3AF/llM2Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sh64oX4M; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752752630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jULBQKJrWLUsKU87AiMGbdZPIoRYqIz+YQ5Sy/VjIug=;
	b=Sh64oX4My5i5thG/Nvna7a+ya5ApgsK85T5HYAun3uPZpGpefr34KMRWVKA4TRlRjbTdyp
	8LN0d+a/6FscWin/2+AXHZZu+U7SFt1ODSffMxTrCodLjAWZi6999jjOgwX5TfU8z6gdSw
	e+nkYNgCcdDPx0S2Re1vz4EfYdloPbo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-bGvWpQDPPEGlkZAWHnK9FQ-1; Thu, 17 Jul 2025 07:43:49 -0400
X-MC-Unique: bGvWpQDPPEGlkZAWHnK9FQ-1
X-Mimecast-MFC-AGG-ID: bGvWpQDPPEGlkZAWHnK9FQ_1752752628
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-451d2037f1eso5182035e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 04:43:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752752628; x=1753357428;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jULBQKJrWLUsKU87AiMGbdZPIoRYqIz+YQ5Sy/VjIug=;
        b=lcuFVpH7P61fgZquBSfHwMji47sAPDcs5CbcdOoglAgi+zEV9K232YLaoTSnapwSW1
         +v2NbLG1kNft4jk9YECnWEgohFK6JGAcjWmPzd38YMlVgdONZdkkZXrryj7NCB8GOAVX
         UUBZoiW1TE48NkupKnYZRC9Y5IgEL/5BVKht6YAkXiBu5tZv49t7/4R01NB8fTJsoLTD
         HHdaJBfIQ5KWSFtEfh+XYzG1rNNGEby6cRycEbSwBmg4GprL57gd5/KLyAMHxFbWYP7C
         dVX6rx/KzXEiendTFKnd8uIRAgJLmcEos86Exg8lDbPtjzcYuLmB6DQMWhqj9dGu3oRv
         ZYtw==
X-Forwarded-Encrypted: i=1; AJvYcCUN1N7p2QW/GjFrmPrYImj8YUr4pYwGJ0mE4m0A6VxreyN5CVSQS5lVnlph/doJT84+PpQO6wlg6aboUy4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMxv0LX+0RtEpLlNFZmsPch7CFZVm/FQz9ngCGJ0ZQ8Yg89UXM
	C4Cn2kwS1WGHPH4duiD8OuLNaww7qTWfj8sN+W5YXiRS2rWmoWvZVq2LdZcsP5dlb2bcWUp/P2k
	+HQ/gqt3FZlTH70ZpNuVvzoVzSGzNnWaGy5t/QyOtRSzZWuBpSaqdxHJX9kF/qhS4VQ==
X-Gm-Gg: ASbGncsCilC5lG2aLibdz54pur/FRUbbhD0MU8oBlJOz+r95mnGEJ1/pmCFPbpEvMST
	0/447o+ZYFqsD23vYgOszfXewL902fxbyWbeffapYnnkvZq5hBb0nffGxM6dz1CgUtMck5KYL3l
	rdTmhQZfRGvV4zZ9jGcChw7ALjhUGsXWK6K+fDhWSS+rdcqUk+mDSQeRfZoFDcLSOpDTN4FrF+/
	oiClflKTZEVUNdAGrVf8glv6A9nUEX8uRCXIGzSgkn+lFhk8OVKqa8ur51IsKf887FLSsNMmdBp
	NyvViXbK59Xhvpq3d8981iH3BoL73TTyBCOys0vCk1G2IedPxJoW/DIHMe7pvO8zpKr9JKw3DjX
	U3MRfNnCmKlQvF7cTdGo1TWoRnmIVbS/ORyLViRe1Pem1XoSD1Mq3NUXPj2FB5pSc
X-Received: by 2002:a05:600c:1d1f:b0:456:27a4:50ad with SMTP id 5b1f17b1804b1-45637292eacmr14012615e9.33.1752752628272;
        Thu, 17 Jul 2025 04:43:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkjE+fWZ5MrjhWxS/kV+A6LCPCtWXb5br97yuhRNTUKIVY46Jn8e9BqorOYSDoZOgt2+4w3w==
X-Received: by 2002:a05:600c:1d1f:b0:456:27a4:50ad with SMTP id 5b1f17b1804b1-45637292eacmr14012345e9.33.1752752627805;
        Thu, 17 Jul 2025 04:43:47 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1f:3600:dc8:26ee:9aa9:fdc7? (p200300d82f1f36000dc826ee9aa9fdc7.dip0.t-ipconnect.de. [2003:d8:2f1f:3600:dc8:26ee:9aa9:fdc7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e89c87esm48000855e9.33.2025.07.17.04.43.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 04:43:47 -0700 (PDT)
Message-ID: <d27e9451-8807-4c86-b2aa-063639f7801d@redhat.com>
Date: Thu, 17 Jul 2025 13:43:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mm: reuse FORCE_READ to replace "asm
 volatile("" : "+r" (XXX));"
To: wang lian <lianux.mm@gmail.com>, akpm@linux-foundation.org
Cc: Liam.Howlett@oracle.com, brauner@kernel.org, broonie@kernel.org,
 gkwang@linx-info.com, jannh@google.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, lorenzo.stoakes@oracle.com, ludovico.zy.wu@gmail.com,
 p1ucky0923@gmail.com, ryncsn@gmail.com, shuah@kernel.org, sj@kernel.org,
 vbabka@suse.cz, zijing.zhang@proton.me, ziy@nvidia.com
References: <20250716151543.998b121a58064011e9ce68cb@linux-foundation.org>
 <20250717104811.3773-1-lianux.mm@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250717104811.3773-1-lianux.mm@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17.07.25 12:48, wang lian wrote:
>> On Wed, 16 Jul 2025 20:31:26 +0800 wang lian <lianux.mm@gmail.com> wrote:
> 
>>> Several mm selftests use the `asm volatile("" : "+r" (variable));`
>>> construct to force a read of a variable, preventing the compiler from
>>> optimizing away the memory access. This idiom is cryptic and duplicated
>>> across multiple test files.
>>>
>>> Following a suggestion from David[1], this patch refactors this
>>> common pattern into a FORCE_READ() macro
>>>
>>>   tools/testing/selftests/mm/cow.c              | 30 +++++++++----------
>>>   tools/testing/selftests/mm/hugetlb-madvise.c  |  5 +---
>>>   tools/testing/selftests/mm/migration.c        | 13 ++++----
>>>   tools/testing/selftests/mm/pagemap_ioctl.c    |  4 +--
>>>   .../selftests/mm/split_huge_page_test.c       |  4 +--
>>>   5 files changed, 24 insertions(+), 32 deletions(-)
> 
>> The patch forgot to move the FORCE_READ definition into a header?
> 
> Hi Andrew,
> You are absolutely right. My apologies for the inconvenience.
> This patch was sent standalone based on a suggestion from David during
> the discussion of a previous, larger patch series. In that original series,
> I had already moved the FORCE_READ() macro definition into vm_util.h.
> 
> You can find the original patch series and discussion at this link:
> https://lore.kernel.org/lkml/20250714130009.14581-1-lianux.mm@gmail.com/
> It should also be in your mailing list archive.
> 
> To make this easier to review and apply, I can send a new, small patch series
> that first introduces the FORCE_READ() macro in vm_util.h and then applies this refactoring.

Please simply perform the move of FORCE_READ() in this very patch where 
you also use it elswehere.

I missed that when skimming over this patch.

-- 
Cheers,

David / dhildenb


