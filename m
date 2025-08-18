Return-Path: <linux-kernel+bounces-773101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A44A3B29B6C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 09:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA9EF18A6391
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 07:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1AB629D27A;
	Mon, 18 Aug 2025 07:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PAthyycl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0132798E1
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 07:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755503821; cv=none; b=fbJpBjWn0Uwy8v9WKlL4WLXuR4hAtVULMKxWUHRFlYJxf4ClJUh8pNugtL9K6PMDBrs823gAxajOSiNtm7JlJskHuNRzRqzTc7zVW6TgiHch1etz+lCZaIx3UTohwt0OJeak+NXAoUb/FIdm75Ok+9xE9bn0q7GC74C3rXspUQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755503821; c=relaxed/simple;
	bh=K0dZwX9WTtx/x2BEJYu3yffZw1uIj+EcVsnjsBwJmkQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q9CLeOOgrf9EzZdURiXiNm7TDYnklwtwmQCEkELcoqPVknU8Cg1EP391SxyZsABZJNDr5iaXjYM8IkxpaGd5VrZGdp66qwUrHrk2YnU5F4cW5rygjA1eHmMIMxpctcHEWWQ0TDg0k2dB/l08CedD2gBb0fYiQxml1QKYxf+eIJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PAthyycl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755503818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=BJ/waxf7shlm26D4jZ2oS7S6MeDF1K+mmlGn6PRutyk=;
	b=PAthyyclQWdrDgNtzUF+humolfwfYNaztnFBLuKyHdYorrNLaS33CEkyLdMFY1tmWF1b/T
	bPlemwVgzJRlI6dv6q6vcU5G9BtD8ny9Gnfi30laeAr3EQSDWyGhytnRNYZCjdxRN8DOpB
	kXtJNlotzU4TArS4YbMg7f+JLqtxA28=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-Ad-0cRFnN5ivhGGtIEiZDg-1; Mon, 18 Aug 2025 03:56:57 -0400
X-MC-Unique: Ad-0cRFnN5ivhGGtIEiZDg-1
X-Mimecast-MFC-AGG-ID: Ad-0cRFnN5ivhGGtIEiZDg_1755503816
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45a1b0d0feaso23296795e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 00:56:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755503816; x=1756108616;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BJ/waxf7shlm26D4jZ2oS7S6MeDF1K+mmlGn6PRutyk=;
        b=a/EfV9GhOtxW1exyPQ31bH9dhs91iW8E0O/GXuJTJD08QuWdvfcsuVPDDayhfn2M+B
         6TkAi859Hkx9uJoaw3qHMd+xBD7jinLfIGNvruXdIb/ldU6DjldWAcsClwLtZc1Y+XuB
         TdV/pVumeOayUeRX/yemj6T4izFKGyHWIpn/6J2xJDH4ktbLiGO9Uk12Nn+v72x/YYN2
         A7MeOgk1MIrLuaZyEwGYtJAeaxXPSnTtekjn8N7NwQeV6Ux09/VUVQNg9IzQmQ/H60S6
         7dN9xeAhCUlrlaH3JJQSME1VQOIm4k64epvPM126HSTuOn7BFqNI/udpbh7etrngskFy
         oznQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5Jwjc51AFY1oKg3oVXKMlLCYNGvj8/kkwvkHi5q4gpLL8lIlkbOH/ig5wALcJfxAxRZe1yzNHV904T7U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY7ocmjkP6puKMG84/Qo9SHB5vsBEG5U1n/TH+flK0z+22fMLJ
	ui0fEhM6rrsH+FSEfEiq9kM0s2jWqH+1cq1rBA9kt3Vo4tqRf7RjzMM3GFNixCmN+4j6ZEm+ZV+
	ymY9HgYIVteI5A/IBiQfDlP+NYarstmvp7dxG9SuHZWaaB1zHFB8MJTX6itIP9sfCjw==
X-Gm-Gg: ASbGncuDG9x2VtXasDLpGbWrx41f0eq0XscXXGNdSxWn+BidLsa9zIh4MudXvc5QFe+
	s6iq6RKBY0bL+P0yaxp2wXPxyVCCwnM51bVR8T1D2lsZeAE/J6me+F0KEIm4qHuoG8rySUSBten
	foO90Qov+xIWaPYw362GAeVHnFAtobu0Rg9VjuX4os7MGSg0mBf/yCk9anyP1ZR4Ikegp5ejAhl
	XAtX0SHORmuoRC/afhICXYFiJ8TfOMCchd0e5lIum/pz1ag1BKkp0gxAC2kiAqnj4h7QtHloPHX
	s3Nk8/JXjVdfIDbpvSurl2SLmDJFA+/6UiBz7UR5xxHDrGgjaNDbV7/kK63bYuMg5XxjQoypjHr
	3QOcmd26kqG2bmU5gYC5qK5Xhw3ko67TnlqDTD4Dl9En1t+iOKR7HlBBNwW1eR3L4
X-Received: by 2002:a05:6000:2485:b0:3b7:99cb:16e5 with SMTP id ffacd0b85a97d-3bb68cfaedfmr8252290f8f.28.1755503816003;
        Mon, 18 Aug 2025 00:56:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5lIFG/pwp9cWcad1i1QkSJoxL9baJo8KcsDGdZ6bqql9vBoqBBDo9o9ETypZV9s2yLKqg8w==
X-Received: by 2002:a05:6000:2485:b0:3b7:99cb:16e5 with SMTP id ffacd0b85a97d-3bb68cfaedfmr8252265f8f.28.1755503815615;
        Mon, 18 Aug 2025 00:56:55 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f22:600:53c7:df43:7dc3:ae39? (p200300d82f22060053c7df437dc3ae39.dip0.t-ipconnect.de. [2003:d8:2f22:600:53c7:df43:7dc3:ae39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bb6863d9a4sm11799764f8f.61.2025.08.18.00.56.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 00:56:55 -0700 (PDT)
Message-ID: <36a05826-76e4-4723-8f9a-592c745af38c@redhat.com>
Date: Mon, 18 Aug 2025 09:56:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/5] selftests/mm: mark all functions static in
 split_huge_page_test.c
To: Zi Yan <ziy@nvidia.com>, Wei Yang <richard.weiyang@gmail.com>,
 wang lian <lianux.mm@gmail.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20250815023915.1394655-1-ziy@nvidia.com>
 <20250815023915.1394655-3-ziy@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250815023915.1394655-3-ziy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.08.25 04:39, Zi Yan wrote:
> All functions are only used within the file.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


