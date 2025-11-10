Return-Path: <linux-kernel+bounces-893147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 687A2C46A21
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 13:37:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C86F04E6EE3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9CAF30E82E;
	Mon, 10 Nov 2025 12:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RUhEo0rk"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1B723EA88
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 12:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762778212; cv=none; b=SvH6JAypnCpAN/nDUYAum3LwjJtNllHENTjlew0xoMqhmBC/grJLDwsKBq4MGByCWN/4E0kuu0gLnhO1W0dcdT2BscKw0yGhCIUZJvW1sTBRRlB2ZRv8QItGBQlK6LWyk3Y/sbGTnb8vuVm2aNVM86q+1uj+XmgTGySWOf5vm/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762778212; c=relaxed/simple;
	bh=/F8CU/GYM3kJa4k9M7OB1gti3rW5dpGB1vRfRxNdvqk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rUOOomA1D/cOrMPHCsr8LiTTQmaFNhlIWKZG010Ki2UeRKNW6oG3qNRvEOuq+LBdxhqEifSXQSRwzabgRkhhvGNu340UcIMIim7LSod0huu9MIjzIf+ppa4NUNCVoOu4ahvqHFFnDNWxUC85bi/2TuzGU36jurexprYBK8JN8H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RUhEo0rk; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-477563e28a3so19980695e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 04:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762778209; x=1763383009; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BDisWXX1Y3E46k0LejRtyhxBgaWtSH2jsdovoZRUi74=;
        b=RUhEo0rkhRjV++knqGkaySZb1GLgWwjX7bwtxtCfI+o7t8NY6h19pKjXoHMCT/AMDJ
         yi7ZpIJy9xCUm5k+4gpsEd+CmztFQC2oi1QzVFLwYNc/Af1zuW8F3QLd+AhYIu3nwJJn
         Kih8u7RkMNdsyUeG0/Dm+qmiy8FdUhJi5Tkq3ThMiqL5kc32uX9TvXgTKtxEYl41ZMt2
         rQyKMdXCxbrAlvJyboox8C5T4l5kGw2FTP31quOb2Hbt8Xzi3MtNPMb+kB0O5Xx2nUiX
         cFfMNZ/IdFxZr8nsWaZgnA5+Juo1mMbWTLPzidYquR1xFY+csrT+oBNf5bQgcJFeNSxH
         UuoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762778209; x=1763383009;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BDisWXX1Y3E46k0LejRtyhxBgaWtSH2jsdovoZRUi74=;
        b=RSHZbB1ViLgx+TNMCpK1G90G8EGv0NReeMSmKfOiaf0rsk6GXe4fifomoylaZXzNNL
         B6xUqgbIRs9k/LWItF3uPmuSsENkLxZyhZ3z6pCKQ6hqAd6qcEIwu7vsIXP2OZGdyXCu
         1ftEQokyES+ipMef3mb4N1oFGYL49ueo5OCDCJKTR24yYZzUmMWoMTnyXDoUJgOHmuQ2
         gOEGseV8hD5QVBDs20nk8/+h9u0SBd/qlQVl7svYGnk3ePD6KTN/gLMtdcay+jp013uA
         pidGfl+/3irY/azK2Yoi8wdgNggo+H7eNy/2vDgtOCCaoD02znByF3JRLTMrA+PyIRVn
         45pw==
X-Forwarded-Encrypted: i=1; AJvYcCV96akfW94zBYhe2T5Kj2kynuihuriq93rNZQk8d9Mu7HbLEdFvFe+x85qi20hUphMqs+sTxcROzYDpvEM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9aIn/jT9bjJmBtiPOrz5i+cWLi2h8R86yjWf3m4FPv3/hwvGi
	q03Bmjx+bN3pIsrVqggAnrVKN5d2vwjK7jN5r+F2nid98i0Y1Yopf9V0
X-Gm-Gg: ASbGncu/dyrZfF6AFtznBWEYDkMIbOFOJrIYVrp7LMwhS/rfGb4lUgXCQmu+Ov8iEIO
	F/Sl9ZkTI/9ZGIoh0L6eTPso1kynbucEC7jt0geKm74jb3th9rsve6INZ72qmtAf6lknGx9G5U/
	2v77jeH3Ue2N6fVmol4gyDsI+4CbOpPr+ZWEfBNOBeCS+/txjUpfaJWyQBP/SxU6PyzG/sc7aU7
	slF9dQZNXqqe5ibGKJhXHiwleh7aNXQFr3rxUddTaEsfBQ7v40hQ9y1txBHJbOAW/GGeWy2VxAF
	RABejmwv6niw/5+XimvQSvKXaG9ZKRQf8eO6YCwSbC4bqrkKZ8jL5AlR957RnH1Ag07puyz5dCN
	x5c6qUu+PGDgDc7ExzvET2UWYrNvmNczsoi5Ej9It5mzhmIvitI3N24do95nUopnoEGS/gllXeM
	1TIEWGEuC0Aiw970OL87bjqkXMkTBCZKaFOdlZU/ZhHVg75/24b9M=
X-Google-Smtp-Source: AGHT+IE8JnaqwYx1qAF2XhA4+KMEvpg0Zw8lsdqb6Uo4fgD6jKgMhNhYdA+4ok4hdFeiyUu/ZLO15g==
X-Received: by 2002:a05:600c:c177:b0:471:665:e688 with SMTP id 5b1f17b1804b1-47772dfcf3emr65298225e9.17.1762778208522;
        Mon, 10 Nov 2025 04:36:48 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b303386f1sm13557436f8f.3.2025.11.10.04.36.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 04:36:47 -0800 (PST)
Message-ID: <ca3899b0-f9b7-4b38-a6fd-a964a1746873@gmail.com>
Date: Mon, 10 Nov 2025 12:36:46 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1 2/2] gve: use max allowed ring size for ZC
 page_pools
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Joshua Washington <joshwash@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>,
 ziweixiao@google.com, Vedant Mathur <vedantmathur@google.com>,
 Jakub Kicinski <kuba@kernel.org>
References: <20251105200801.178381-1-almasrymina@google.com>
 <20251105200801.178381-2-almasrymina@google.com>
 <20251105171142.13095017@kernel.org>
 <CAHS8izNg63A9W5GkGVgy0_v1U6_rPgCj1zu2_5QnUKcR9eTGFg@mail.gmail.com>
 <20251105182210.7630c19e@kernel.org>
 <CAHS8izP0y1t4LU3nBj4h=3zw126dMtMNHUiXASuqDNyVuyhFYQ@mail.gmail.com>
 <qhi7uuq52irirmviv3xex6h5tc4w4x6kcjwhqh735un3kpcx5x@2phgy3mnmg4p>
 <20251106171833.72fe18a9@kernel.org>
 <k3h635mirxo3wichhpxosw4hxvfu67khqs2jyna3muhhj5pmvm@4t2gypnckuri>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <k3h635mirxo3wichhpxosw4hxvfu67khqs2jyna3muhhj5pmvm@4t2gypnckuri>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/7/25 13:35, Dragos Tatulea wrote:
> On Thu, Nov 06, 2025 at 05:18:33PM -0800, Jakub Kicinski wrote:
>> On Thu, 6 Nov 2025 17:25:43 +0000 Dragos Tatulea wrote:
>>> On Wed, Nov 05, 2025 at 06:56:46PM -0800, Mina Almasry wrote:
>>>> On Wed, Nov 5, 2025 at 6:22 PM Jakub Kicinski <kuba@kernel.org> wrote:
>>>>> Increasing cache sizes to the max seems very hacky at best.
>>>>> The underlying implementation uses genpool and doesn't even
>>>>> bother to do batching.
>>>>
>>>> OK, my bad. I tried to think through downsides of arbitrarily
>>>> increasing the ring size in a ZC scenario where the underlying memory
>>>> is pre-pinned and allocated anyway, and I couldn't think of any, but I
>>>> won't argue the point any further.
>>>>    
>>> I see a similar issue with io_uring as well: for a 9K MTU with 4K ring
>>> size there are ~1% allocation errors during a simple zcrx test.
>>>
>>> mlx5 calculates 16K pages and the io_uring zcrx buffer matches exactly
>>> that size (16K * 4K). Increasing the buffer doesn't help because the
>>> pool size is still what the driver asked for (+ also the
>>> internal pool limit). Even worse: eventually ENOSPC is returned to the
>>> application. But maybe this error has a different fix.
>>
>> Hm, yes, did you trace it all the way to where it comes from?
>> page pool itself does not have any ENOSPC AFAICT. If the cache
>> is full we free the page back to the provider via .release_netmem
>>
> Yes I did. It happens in io_cqe_cache_refill() when there are no more
> CQEs:
> https://elixir.bootlin.com/linux/v6.17.7/source/io_uring/io_uring.c#L775

-ENOSPC here means io_uring's CQ got full. It's non-fatal, the user
is expected to process completions and reissue the request. And it's
best to avoid that for performance reasons, e.g. by making the CQ
bigger as you already noted.

-- 
Pavel Begunkov


