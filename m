Return-Path: <linux-kernel+bounces-800641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25DAEB43A07
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 13:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F0E27A56A2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 11:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5082FF147;
	Thu,  4 Sep 2025 11:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L6tO1+kv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77E12FE565
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 11:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756985179; cv=none; b=ntuKhq53PEFMpqSauPvfdKIc2qQrrz4fU5+tscLUoT9Zhe243Zi4oejiQfHMKti10pA2yxmaBtYifS1bYi7gqnetgnvKiOQFtgm3fy86s1Lbi6B0EhWs/p9CufO0pMMIXvAr+aIPZ0DAWbQAcq/BuRSooMh9SyDFLXHRKb0/z7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756985179; c=relaxed/simple;
	bh=WXmJsqps93AYIF0lgIoiWVlPCHEYDrumINGmpH/eqSo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gu4Aq6s0yKfDt/V66ahVLreJECPMq4YCDQNkKXmDSgYvHb2Y13u/5miRQdqWUqNPwCPYAdJMJp9UfKPlL9cs6WUqJKfVUXG9a2kgOdvQg6O6/9tRYhKDlTIZ+GMryc6h3JDYCZs914rrFNtovk5ApEwtSdleFs1mzZ8xgMJS8JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L6tO1+kv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756985175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=FYj7vNnXdBif94nkLRSjqJE0U4PgTPFgog7KMgt+5Lw=;
	b=L6tO1+kvx0aTpxn9Xppn+1eb84NthxI+d5Ves8ms8tmG9iQc5fnBiIYLojTncZDzfTPVgu
	fbAAKVxL5l+N0nhW4Xzu5ulONT5aXxnmNhvzWryReUvRLndQK+DsyIKG1vIJ1Gr4/WConE
	ruAS1Rw+9OouEyECryOk5zYwEcN2rWY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-459-w3RySAx6NwS5hlgqwlxdug-1; Thu, 04 Sep 2025 07:26:14 -0400
X-MC-Unique: w3RySAx6NwS5hlgqwlxdug-1
X-Mimecast-MFC-AGG-ID: w3RySAx6NwS5hlgqwlxdug_1756985173
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45b869d3572so4638165e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 04:26:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756985173; x=1757589973;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FYj7vNnXdBif94nkLRSjqJE0U4PgTPFgog7KMgt+5Lw=;
        b=DdvEqlaCNzMeUb8XI4hQ8jJ4gSEq3kLfNCyAJ65JOA++AOY08TgdMEGEJ5ncHwvLbz
         Xy2D0pc4cg+ZsMUPHDlH1lmr+wTNmasqkC28NubyFohUcedq8r0WOPeiDvScQAJ5epzK
         xnXVNVyFniPKKwsb/KqM7hsft6FT2cvASkj1AyCl57TbR2/+2I56iSQJhvnTWK1Ykyp2
         YktjL7Sr0+6h6/pC0m22UvpsHbeITDxmaRA9d4UmOJyuGAPw9D2zELAX2r2EZLlTVh7g
         ncU/bEIMGfqgUy9n34hzwMIqsD9RdAPPJqvmnLMA7WLcFSh5zOAO6SHLquV5j4unkz+G
         waRw==
X-Gm-Message-State: AOJu0YxAHv4VVeDCPnRH7/Zjfy+8mInWGrfSHzD2gsy6uwy7lRMcCXnV
	Bv6gcSbvnke0WDZzSzE5OqqzCao7XT8jR98EK2zCylZX7i7mQ3309q4DC+WF0UvlN0inKPx7BCf
	GsL5Fug8W09CqKDUiRk8B0bH9Lr/c0TvUnCYJ3L8M4eowQvGo/+03xDjRBgPNkDUD5A==
X-Gm-Gg: ASbGncsvgw3Jyn/cfGPeFiu+OXFgt8npXLQSSjzgYDL1Kcs3IIFpwhZVJKSaCpldWGn
	dZbAiSc4XaFZXdwKB81X++exkj1nmirmRPpyCs44Pmty4wdYGP6nKT8OV1BJpmTqzhcUPbwAiJo
	T/B40W8eMZnt0PvorrgsXNe1Yv2lNSXILjT6Npp480ZWD71Vqp5UzsmjfVch9ZHanLEsTo8WATM
	FyWWt90Arif/OhwImcSQOh2wTn0y5pjO1TCzdiqRZ0V7az8IgcAaqFej78CbW+udhtnah57MT9p
	EUwGj5+B314DpxgjMso6Opg4+aYPTpfL4o1AiyDRDt31co5rwMUTBDqbpXRp7rIfgB9s//EgxTv
	Cyk1+qhZ0VEiHysoUrYtbta9Woa3bmNjtTsByz5BKUVoppYpXgDplqJXP1gnwnnVO
X-Received: by 2002:a05:600c:1c0d:b0:45b:9a76:ebea with SMTP id 5b1f17b1804b1-45b9a76ed12mr67521325e9.20.1756985173018;
        Thu, 04 Sep 2025 04:26:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHA1kxxSVjg9EPss1WbdwZlOW60kNPkZEhsIHevJbu19C93SnnQw25G1XfcOFYBQHy8oHojpA==
X-Received: by 2002:a05:600c:1c0d:b0:45b:9a76:ebea with SMTP id 5b1f17b1804b1-45b9a76ed12mr67521145e9.20.1756985172620;
        Thu, 04 Sep 2025 04:26:12 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f25:1e00:ce4c:be3:97b3:6587? (p200300d82f251e00ce4c0be397b36587.dip0.t-ipconnect.de. [2003:d8:2f25:1e00:ce4c:be3:97b3:6587])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d0a1f807f9sm26554201f8f.38.2025.09.04.04.26.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 04:26:11 -0700 (PDT)
Message-ID: <8984f395-9043-49dd-a53d-bd344fd419bc@redhat.com>
Date: Thu, 4 Sep 2025 13:26:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] mm: remove zpool
To: Vlastimil Babka <vbabka@suse.cz>, Vitaly Wool <vitaly.wool@konsulko.se>,
 hannes@cmpxchg.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Christoph Hellwig <hch@infradead.org>
References: <20250829162212.208258-1-hannes@cmpxchg.org>
 <20250904093325.2768507-1-vitaly.wool@konsulko.se>
 <7b1ca42d-1b89-44f4-bffb-e6b09f86fdc5@suse.cz>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <7b1ca42d-1b89-44f4-bffb-e6b09f86fdc5@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 04.09.25 12:13, Vlastimil Babka wrote:
> On 9/4/25 11:33, Vitaly Wool wrote:
>>> With zswap using zsmalloc directly, there are no more in-tree users of
>>> this code. Remove it.
>>>
>>> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
>>
>> Per the previous discussions, this gets a *NACK* from my side. There is
>> hardly anything _technical_ preventing new in-tree users of zpool API.
>> zpool API is neutral and well-defined, I don’t see *any* good reason for
>> it to be phased out.
> 
> AFAIK it's a policy that unused code should be removed ASAP. And that's the
> case for zpool after Patch 1, no? It could be different if another user was
> about to be merged (to avoid unnecessary churn), but that doesn't seem the
> case for zblock?

Right, and

  13 files changed, 84 insertions(+), 715 deletions(-)

speaks for itself if there is no new user anticipated.

IIRC, we did a similar approach when we removed frontswap.

-- 
Cheers

David / dhildenb


