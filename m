Return-Path: <linux-kernel+bounces-831926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68DFBB9DEAC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 09:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 777311BC2D2D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 07:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AFBF247293;
	Thu, 25 Sep 2025 07:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AFtl34MH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FE61A4F12
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 07:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758786631; cv=none; b=Z/Z6lpnWpsVVz06zEKLdmRJ45s1flDogpVdtJbvDyvs/PaNYodX336YUzLXyE6PH780JkaWH1xz+nsErELfX+B9vZ8YtqXios2G8HDviBI8R+XyObDq9tbEgZo2dSKkjDDdLWIvJhDyE2hw756duCRNX3pfNfD7PJx4EER+vWig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758786631; c=relaxed/simple;
	bh=pG/Q971b1BZFzAfjLzpQOwgWsWGJ89XMSXFxhthPg18=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GiP2DjzUVdg/9k3nIJQmg3SOoT3sw0DAptmPt5b7Eg8xYbUVKEMD0cQzWVzYrR+INnPjtHnWN2+N9wdSjzrmmK4no8JPGK9roTSBdUcYLhCHzxOwfwz5oxeiJQG7jWfTIeRwj74IhFGrHHKu9yK4hA6d7wKpiYho+4bXb0ASsgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AFtl34MH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758786626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=PS5Egckwip3kpQ3auepdZqUlYFAXDV6RIIbMKmniWX0=;
	b=AFtl34MHSDxzWpo3LpSzTfnSThjzHJMNEYkKjqWawmSDb0HbCOfuhTPPAK0qjOdZWgTdyP
	0zMbEite4pWw5vIxjHInjpGz/8u8xDy7kUSUyg4ugs3zQQDNPr6idvAnnWatVQT5Gn5U+j
	GMpWgc7o7sJwAzkartKaZpKIXIKU4IA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-IOka1BbfOZ-eScNdCQIxZQ-1; Thu, 25 Sep 2025 03:50:21 -0400
X-MC-Unique: IOka1BbfOZ-eScNdCQIxZQ-1
X-Mimecast-MFC-AGG-ID: IOka1BbfOZ-eScNdCQIxZQ_1758786620
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45b986a7b8aso3503995e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:50:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758786620; x=1759391420;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PS5Egckwip3kpQ3auepdZqUlYFAXDV6RIIbMKmniWX0=;
        b=YcNeEgWR+tfX8A7atH7SuoumQBjDBF/BEcjjwwFmlqG0u2vX9m51QVyuVc5wJVZzhB
         /M5U/OXOwj8WryuuzS5sFN38UUTIgwWPak0Dx2LzXt9Km2NKucbkVmGNNp5FoUZ4+Ke8
         ON51NiG8WXHIQKkbnK6Tf+v1oeWZpKKk00q5/9LG6sJqUO79fldiwUrPXsb/xVn5gRPn
         bWo2dGLIe/V2ljxNElf6IZ+GiClhYsvGffpR23Y3ZDrt5OywmCz6/01No4rL+9059h9y
         FUaEZjUSOUwWeqj8uxYwUQrHmQSBc6bhoYMebr4f6kErQp+kE6pUXxUSxyNB3ElBQKWQ
         SMvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVY6Bwp9qaxiWWX4tQoQtcsm0xA6Bj5ME8TVy0TNhKxJyCAhVnvkbGluPwE6OE7w6TXv0KzEWNIfgWNXKA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI7Cm1eeFFkfjsyhmlQ3/OtqTXF7glH1cMZoivS1GMnDhswVQ+
	UJLj/DARtP1d4QGItaXOmJ3Kq3feA89sKMQMsQmKZvDQiBgw21NcmAyzNMI/7dYUhThSOKG7vM7
	LouaSqTMZwY2XUc5+a40u09iUstFFXn0A4mvkSfxLpY7G0mw6CosYdWLNi4oDmX3e4g==
X-Gm-Gg: ASbGncv6/Q8OMmZ5TgB1D870HC+NL1tldaG0mO4yRN0tvm7PR1yPelgxEHI6R6uiprK
	M0zIseV3tbNVn+GtR04grN8X5WMcXcTLmFnrA6FEIRhTVoTWzH7co6Ts+xCeQ5H8gHdjdEXGgIE
	TBLj+h/O/rrJbw6wk0npilObB7J2PkC7bqPs2O4CBiqX/YlGVYkwPURVHl9mnlb8trtMkFvhkAH
	pqRSP0HJ8suGt+teh1GA59sYmuYjvHNRPUIo8l3X+LMqzC7nRMCcP1RI78yOLyjO/aSgwUu7Mm5
	+lNQKPRgbJXmQlxZbzuGqndGWmdc42tpg1rv/6fwSWdwx56ta3n/UYh9vKAioLLlNyaW5BupaF2
	V/1PSy8GxA/1eeMpFgY5pfvAkvSyM+q7yGGBkwCR925NoTmkMHlo7v/V9kHY6fcNb3VwQ
X-Received: by 2002:a05:600c:8010:b0:46e:2861:9eb7 with SMTP id 5b1f17b1804b1-46e329a47e3mr23949795e9.5.1758786620283;
        Thu, 25 Sep 2025 00:50:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQPBxj85AmxAty3smB36wxmjDTQBXHlcB5P2ykV/icka50+WwoUgia/33jh3o/rv5KJU1flQ==
X-Received: by 2002:a05:600c:8010:b0:46e:2861:9eb7 with SMTP id 5b1f17b1804b1-46e329a47e3mr23949625e9.5.1758786619856;
        Thu, 25 Sep 2025 00:50:19 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f3f:f800:c101:5c9f:3bc9:3d08? (p200300d82f3ff800c1015c9f3bc93d08.dip0.t-ipconnect.de. [2003:d8:2f3f:f800:c101:5c9f:3bc9:3d08])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc5602df0sm1836031f8f.36.2025.09.25.00.50.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 00:50:19 -0700 (PDT)
Message-ID: <bf5c64c4-cea2-4132-bdbb-6400f852ab52@redhat.com>
Date: Thu, 25 Sep 2025 09:50:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ksm: Fix potential NULL pointer dereference
To: Fushuai Wang <wangfushuai@baidu.com>, akpm@linux-foundation.org,
 xu.xin16@zte.com.cn, chengming.zhou@linux.dev
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, cuigaosheng1@huawei.com
References: <20250925031358.80983-1-wangfushuai@baidu.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250925031358.80983-1-wangfushuai@baidu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25.09.25 05:13, Fushuai Wang wrote:
> The stable_tree_search() function may return an error pointer
> (NULL or ERR_PTR(...)). The current code does not check for
> these cases before dereferencing the returned value.

We discussed this in [1] where Willy clarified that there is no 
de-referencing happening [2].

So no, this is not required.

Consider "&kfolio->page" currently being a "(struct page *) kfolio", 
which is just a pointer cast and no de-referencing.

[1] 
https://lore.kernel.org/linux-mm/20241024032300.2501949-1-cuigaosheng1@huawei.com/
[2] https://lore.kernel.org/linux-mm/Zzdrnod2zcTeI-Nt@casper.infradead.org/

-- 
Cheers

David / dhildenb


