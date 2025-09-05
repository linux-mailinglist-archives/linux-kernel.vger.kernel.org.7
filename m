Return-Path: <linux-kernel+bounces-803205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 974BFB45C1B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 17:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D5C61BC0F5C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 15:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E082931B835;
	Fri,  5 Sep 2025 15:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dQUl1IiD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A4E31B80D
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 15:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757085117; cv=none; b=E5QD5V3AWkHHznN+kfOeXWXqIpzUbgo0thInxtqeS7Dm+XYPQU4ppr939Ee9wUjAygn/tXm+o52VcrShq37lRfe3TMeKhQJmjdLGM9qrqhL8pD11i6Y0wGmIOE7dlcXPYKiw9vv7BTUyTfcZEnl4uQFXw922P1Rh+YlQdNuYc8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757085117; c=relaxed/simple;
	bh=UE2/nf7Y/UOxIwWrF9TDkfHaaHaK8iZ2AocC7fAXFnU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FhG2HDp0wVqoZLIDuTuqjHztIDYlOiIvS4nxU/Vo4AXxRJCv+SYHfLRmhGDLQYT/tAGYh183nmTNA9OWjknYXgV6Zvzfv6xYDrnDhFEvT3CIudxiXUNrt2gGevkPEAqKQtMFoA7BadY/yLZnkawsRAwLLd2zYCumO/rUE9ZPlp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dQUl1IiD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757085114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ejmCL2yZcTEHH96tsoUqx+++Lo7P6eAG10DO6o7H754=;
	b=dQUl1IiDd6AZByjYNo8FHynd8CHmI8dEPSsoakKsyqgKAGkobqv9b8qis4EaPayNGiCYGt
	/5zDNVfQV0/N+KUwUGMnSAXO713JADVPbGOxVvDuchtpdwt+aoAFlb3NFb1z/uU/pihlHJ
	CiS5IZsCWcc4RI9040geXne6HhFpQ4w=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375-3TLwLwNiOOyvhbG38cRNQw-1; Fri, 05 Sep 2025 11:11:52 -0400
X-MC-Unique: 3TLwLwNiOOyvhbG38cRNQw-1
X-Mimecast-MFC-AGG-ID: 3TLwLwNiOOyvhbG38cRNQw_1757085111
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3e2055ce8b7so815616f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 08:11:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757085111; x=1757689911;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ejmCL2yZcTEHH96tsoUqx+++Lo7P6eAG10DO6o7H754=;
        b=GEi2ibOEbymALNTBF57Dbl8fk0uURa3bR4ZO5XnptsJhmyb7bRHRnjsRc0nCg5ttTy
         9Yrc2+hqWXwM0Gj9rOu00hfuX3Z4T1sTOom/0/ky+YXLWwX/ssymmiqjsl6BBTicaSH/
         dYNthOy0PP9HvtL9ckg1xcX/NFpo4L47rZhCz4k+hH6ND/StJkVa5xWQ1ablyZOtXkjf
         droyxJRLDATb7aa7egKe7tEbmh6kkzhBPVDTKELUs+mEas3voY4HVQTrNLTqi6R8DlKj
         yjsgKvqle/aID2uoD6OAzo4fkbel96Q8ImFPQ0wRzRvwO8AVozv11ML27vbQyYdknYPk
         t/rg==
X-Gm-Message-State: AOJu0YxU2Bormuv46onGO/q5ZTbQZqK/BK4QIEjsKzfKBOaHLBBZ232I
	MCbe/g83aQdmtSJs+ebepwM3Im8LoqjcuZC4mkGkpfVwrSv3X3wuFdxIBoz6EH6cINk9/0K5Q1c
	78stfQ44YTVZ1lU2dd6MLApgpLlP3Qp2Unsa6Hdn/lGi9Z6K3ujGKzk3LkM+vwiFZi8xybMMEfR
	Kw8OuPV5gVZrUegRk+bd4QTGGBtH9ze12pcblfdlAYGIiDmg==
X-Gm-Gg: ASbGnctY8m2v4pTAGX15hGeRV0bLP8MtXIhgt11ftD5HM5IcjvLoRcIEhtQKyZO/6J4
	+ARBg0vMoREiM7uCLMXStHHmxHgoN3b/IIMqH0huiIOgI18V0QW872osWjxRN9byM3N090zizJA
	W/WsiaC7naoEHWfTciSoy/K6nFkVlpBSCgAPvlOu8Y6B19eaaTzftOMQGEwv4/KrhnxxUNnTWob
	YdKD5tQKMWAMb7HAluLStYvxxvDJS1sKWHLr9UjTrTiEA//b7SfDKqUtAcQd2YGS4vz84UfRQsQ
	4xcMOoiyj2nUoo3/nipPgNLGF289T/dvoJihPtQQtDsLXIPOclAwYBXzs/cc3wuOX99t7mDmtgP
	SCRJWCTB78xemoiZsuR48X3D25hmlRS78mIeHHubK4s4r8oxz6zj/izdP
X-Received: by 2002:a5d:5d0a:0:b0:3d7:38a7:35de with SMTP id ffacd0b85a97d-3d738a739b2mr11352683f8f.8.1757085110764;
        Fri, 05 Sep 2025 08:11:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXaISg+ckj8PwoQCPDjMhrf572oqtBNgCQOCCZlR9jfeBO9sLv7C/4kvo8ngavi+/aQ5ANGA==
X-Received: by 2002:a5d:5d0a:0:b0:3d7:38a7:35de with SMTP id ffacd0b85a97d-3d738a739b2mr11352641f8f.8.1757085110257;
        Fri, 05 Sep 2025 08:11:50 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4d:e00:298:59cc:2514:52? (p200300d82f4d0e00029859cc25140052.dip0.t-ipconnect.de. [2003:d8:2f4d:e00:298:59cc:2514:52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e7d1319sm369430255e9.5.2025.09.05.08.11.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 08:11:49 -0700 (PDT)
Message-ID: <d93d1f3c-7a83-41b6-8166-be545f6270f5@redhat.com>
Date: Fri, 5 Sep 2025 17:11:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mm/huge_memory: fix shrinking of all-zero THPs with
 max_ptes_none default
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Usama Arif <usamaarif642@gmail.com>
References: <20250905141137.3529867-1-david@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250905141137.3529867-1-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.09.25 16:11, David Hildenbrand wrote:
> We added an early exit in thp_underused(), probably to avoid scanning
> pages when there is no chance for success.
> 
> However, assume we have max_ptes_none = 511 (default).
> 
> Nothing should stop us from freeing all pages part of a THP that
> is completely zero (512) and khugepaged will for sure not try to
> instantiate a THP in that case (512 shared zeropages).
> 
> This can just trivially happen if someone writes a single 0 byte into a
> PMD area, or of course, when data ends up being zero later.
> 
> So let's remove that early exit.
> 
> Do we want to CC stable? Hm, not sure. Probably not urgent.
> 
> Note that, as default, the THP shrinker is active
> (/sys/kernel/mm/transparent_hugepage/shrink_underused = 1), and all
> THPs are added to the deferred split lists. However, with the
> max_ptes_none default we would never scan them. We would not do that. If
> that's not desirable, we should just disable the shrinker as default,
> also not adding all THPs to the deferred split lists.
> 
> Easy to reproduce:
> 

Just a note that I will send a v2 with an updated patch description 
after the discussions here settled.

-- 
Cheers

David / dhildenb


