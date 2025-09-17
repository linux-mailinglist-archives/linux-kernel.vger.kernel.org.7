Return-Path: <linux-kernel+bounces-820160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD765B7DB1C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A01BD163F25
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 07:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED142F618A;
	Wed, 17 Sep 2025 07:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D2GkKqfH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E357A2F2913
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 07:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758094741; cv=none; b=o2dfXPPHDoA1XYjW5tOfIu19NhfuRrtPjUFH9kXyXGCX6Jq4/VVclRRmOrFn20FUc5zdCT8VyKFpvST2wh9A5tpsHUwBS9rtYMWHulQNXNYSn1XiUa7jjjHgbhl8p5wZVxQZpmfWmsPUhwiek0xuL2zlHczDCrnFzDxn//kbscM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758094741; c=relaxed/simple;
	bh=V8sUkCv1Do/gjP7DOGDQWYGyQgbg1wWESr1tAGRUIIM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RuiKuU70iqc7VT8vUA+rpAvmKp9LMItzcUiJ/1YbWIikycV6jLbMVJaJ5BBO9/Twsf0Lj7UIdG/P6LZ8DxqYAA2vWeqdXWFoPqhybZx/cOdVltP1koKDXhbfXplYEIKKhJy2edByU80lmTFcr327TCOW9l+sihXfsEGsC5VxjSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D2GkKqfH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758094738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ecjLuFYma2pmjKDGSxmd7rMO1bVxbe6uv0k2p4+S6ME=;
	b=D2GkKqfHStPxRm38PzRG0xoNLj8eNgFJoQPYsj9Vzhd5BfJF6pEFXD6YC+kKokmUxZXoka
	srwxkS5SuQLZfPcKp1bm325CbLn710rc25LDFZDyzZmD5GvSjgGA/9ea2osahxw6OnoSzu
	wUT/cQUjTIjxEQY7Fu3obKaXmOHL7Aw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-gd86ZLxGMXilsJlvUHKjoA-1; Wed, 17 Sep 2025 03:38:57 -0400
X-MC-Unique: gd86ZLxGMXilsJlvUHKjoA-1
X-Mimecast-MFC-AGG-ID: gd86ZLxGMXilsJlvUHKjoA_1758094736
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3ea35489002so2397464f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 00:38:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758094736; x=1758699536;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ecjLuFYma2pmjKDGSxmd7rMO1bVxbe6uv0k2p4+S6ME=;
        b=mLMxOWyCe+pcVGG4TFpt1RaVth8nmslDWD4WL8IKCq1ojjoV4l5cQ3VhxMKIMWEWLA
         PLTdDsmhjd2Qa/bqo58DdULa5YDLVtL2XFjwTpC59DKjWdyzUbym81kwpAkHt/WJ5XGJ
         uTu4RWmt085818BYe7UAGADDoXe/zSDgqUzqWv7aITSh1kYXT2CiMXRi8AzJTYsp6QxI
         R2YAVxl6Cc/lrCBALor6vNZiq1TmKgeLtxQeFufXZZSJky9cnJF1kCyQJGT/nZrqSUJ9
         YgBuOEpedDmmR9cD0G5HagY1jBZvIHhD6eBQxPd5xG5ta6db4H2dOs7OjVUu9cJlBHb9
         O7Cw==
X-Forwarded-Encrypted: i=1; AJvYcCW/CWqmaMD2jET1Y8qD1n847IOGhck3fLL1MA3h19oHUR+ShDlW/B2hAjo5WuMJ9RnCr7wPySeWcFUb454=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyai7tvM2mk+R1f70hVSawraA43Oy2QazsRY7QiBBVNN7rSw7xy
	+gwd+PzgkB8Ve9X4MUqGETMAK0TTVWC7GZ9JWi3oeLmR/fTEyrqH2SAaWN/GtyJriSiDNvGXPMr
	0IR3JNS4bl+D0+zs10PW0MjfJiBlzp8OdHRm7hebu8MzPKBxbGjezzuw8apSDEjsQRQ==
X-Gm-Gg: ASbGncvh/0EftcYCPpyhw+WyOcsrnfUFO7upC1k4e1wqWG9BeMTRNhEg8UmmYEM5v48
	q2NYC4xDuaZfGHq26H9kpDuvMzaldH0/zxHr3dH9auXjabz5rRxSMJb+XlWBfSxOOH9+fPQsdO3
	C0bmoexr0ByedBgPNn04UwrmKvPjCORTIIESNs9nchshPY81uZzuM1AfFFhIv74g9IfFTqe7zUU
	NJkicakNaYwSR/r/y6/zh78v3kdccXuNTYp9LRWvULjplWOMDfkMcVyR7gP6FQ+x0/Hs4dpigmN
	R5qfZSzcNZZxsaD9ROCU57yy1qQKvc/9ryOrJT9QpNY5pEA7mOVXV+jjPjqkUKgeJidlnnOKOdf
	WYhJRSsZrFWcFJsiZmnfEHhP4+/CjzmRvZctZHc8fmsHkQETL4ucH/Fs9WmdSgo7s
X-Received: by 2002:a05:6000:400c:b0:3eb:c276:a353 with SMTP id ffacd0b85a97d-3ecdf9b479amr1090388f8f.10.1758094736413;
        Wed, 17 Sep 2025 00:38:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9bJWm23LysPNDyBnHVvP/fmBhJ1zuxTFboH2BF4Lnv2ayY/DGUm+xwiSt1zWCebC8DkrtCw==
X-Received: by 2002:a05:6000:400c:b0:3eb:c276:a353 with SMTP id ffacd0b85a97d-3ecdf9b479amr1090361f8f.10.1758094736053;
        Wed, 17 Sep 2025 00:38:56 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f27:6d00:7b96:afc9:83d0:5bd? (p200300d82f276d007b96afc983d005bd.dip0.t-ipconnect.de. [2003:d8:2f27:6d00:7b96:afc9:83d0:5bd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7e645d1fcsm19329609f8f.48.2025.09.17.00.38.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 00:38:55 -0700 (PDT)
Message-ID: <c4ba8fa6-246d-4a6d-84fd-3a14b4d0dc1b@redhat.com>
Date: Wed, 17 Sep 2025 09:38:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ksm: Use a folio inside cmp_and_merge_page()
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 akpm@linux-foundation.org, xu.xin16@zte.com.cn, chengming.zhou@linux.dev,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Longlong Xia <xialonglong@kylinos.cn>
References: <20250916080533.2385624-1-xialonglong@kylinos.cn>
 <20250916181219.2400258-1-willy@infradead.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250916181219.2400258-1-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16.09.25 20:11, Matthew Wilcox (Oracle) wrote:
> This removes the last call to page_stable_node(), so delete the
> wrapper.  It also removes a call to trylock_page() and saves a call to
> compound_head(), as well as removing a reference to folio->page.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


