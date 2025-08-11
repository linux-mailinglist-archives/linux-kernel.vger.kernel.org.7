Return-Path: <linux-kernel+bounces-762178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09954B20308
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 11:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B6B21896919
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD572DD5E0;
	Mon, 11 Aug 2025 09:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SB+K/hNx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C1E2DECD2
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 09:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754903683; cv=none; b=Ch5Q0gidUBOQhbqbamtasX3gHZ1hogOE9UrJK9u/cQA0CznJrFE8N8hjx8Wn+WM+4iL1gpghxvWuF5moUwm4v7Xrix3z3Us+uRlFLxcRsNzy5QMQndOG7yXA5/15Qk9r/vIfe9X9BL0M/p4qSi9NnbU7XjaUO8CaVabLrowb2hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754903683; c=relaxed/simple;
	bh=f+UEjoiYns9C1Dx5UcfZskikv1NWHUCTfmse7Isu4a4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jdaU+JasYjO5V+O7Ah0MoE0eSlkKeMFZ95sQ0hEgMiySpi/zNtX37S5VfrYAeKdOybnlUK4F0CNa/kKp+7CEEJqAwk/0CBWkBbOgo2jQ5AI0D8QOqndYZLQfg27t/tIETAVJ5v1V6He7/ppPSvUrEYITgCou0wjdtGs5f8I34Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SB+K/hNx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754903681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2fNyDVtwXcFVF6hLJIgYOOwH0KI1rT63plVaXWTcfnI=;
	b=SB+K/hNxAqkPS9+PnbmqiPsGQb8U2OFjlQfhAiDbKsxCVqzAdv0OzdhtyMdHGRkM9EC4C/
	K+cnWTSCkty1t5YPykbMp4HBlSGzQxyGasFjYtbiHX+pQT6An8s+9e+2RQfUjv5z4dJLsJ
	6uJmMoju9ypTXtIMSiIYtm8vk2iNDLI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-le8yL9oNPZqNHF4nT2KerQ-1; Mon, 11 Aug 2025 05:14:39 -0400
X-MC-Unique: le8yL9oNPZqNHF4nT2KerQ-1
X-Mimecast-MFC-AGG-ID: le8yL9oNPZqNHF4nT2KerQ_1754903678
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-459e30e4477so36550095e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 02:14:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754903678; x=1755508478;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2fNyDVtwXcFVF6hLJIgYOOwH0KI1rT63plVaXWTcfnI=;
        b=s6F+39WuzuullY7RXl0WOM1RMKgPRfIHqlCqoRTahYSTj7S9y68Tq2wVxDUtnOk61/
         fSkADpk5hvXHpLT1VE52RNuWNFXfrJ4MvUFOaoNxS4fnVxzyXNRE8FL1xQ2WWFiz3Yg+
         B81wGNKrNSqtWMWAVUUmwJe1q9udiLPmgloI0pb9yj+bDrtvq2IwjK2ZV8dpyBQgBnfG
         pSJQgynupXz0pbkoJn/ZOEDtj3UVEXPS70H3u1iptUemjGG8ZzcIHp9s4QpbkwfYVNlY
         lx5/9JApri3ms7mP3m0p6BNvcJSd+R2y5ZFhYDHlxgAiYNQhlqzhjIiLCwxI5/7cVOFR
         MKvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWf38fSEeFxo0xieiGdujsU0lO83e9V/UQNtj07GTfJdJ1i4xaB+mAsFgacPHSOQVTscRGGjRUdechGFs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMcOFriJyA6rESEz7nU1wa0BwLjSyBaltqh7cHpnYcHMwOljF9
	F3iz0s9a4KHfklah/Yyv0DO2ySr0tc+5dLCks4VWod/GDs0tg8dnB6TDko7lpdi9fJWoZijAX96
	SH8Vok4mlVLhMjTiIrdiB11uigcCBDnnVAKR+w858qRwj/UVM2/B/Tr0e+NP7xAQEP82wvcu+6A
	==
X-Gm-Gg: ASbGncsfj9V01Wy7j+veDBIMmNlp+5A23VkW2DkR+kfT8Y7f3pEHltCS7MAA2p8UahY
	5XatiVAanxkhoNXTg68Xg6fcTVHLGTzbP3ywnM2ZKWYCoMzEVN1uwgQi4Lm9hUJJA8w8Qgr8ShK
	TDYErkZu6LuakZ9PTCObeeYpXmPlsx1SLhO2LTDnZpWimXCrHeyjnwVIw03CzWCJqw1c0hcNyK/
	MfK63BHkpX3rnZ4yEpm54KFARQnAtk4fWcaQmB5FrZuZgBT4wMEBv3aZ7grCtfevcxAoFWC5irS
	x5E3MYTW87kmlr9wsrNRow4PbutIpW/nMz3Y9yoT15G6mt2o3DNFJydE0Dqrg2K/7l58AEuPNcO
	H/CuT8rzAfiIr0DMYsL1Vm5XP76g6G4HNmx/usR/SmZ2i3NMwZ/i7+/D3edBduIC+uXE=
X-Received: by 2002:a05:600c:468b:b0:456:25aa:e9b0 with SMTP id 5b1f17b1804b1-459f4f9b5f6mr103953025e9.16.1754903678195;
        Mon, 11 Aug 2025 02:14:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPHMRHycPiy+F4MFFVFoafh5fxhbK676vx41t1mXGx/HiUt0UauyCHEIlhjR8E0T6r8o4KUg==
X-Received: by 2002:a05:600c:468b:b0:456:25aa:e9b0 with SMTP id 5b1f17b1804b1-459f4f9b5f6mr103952825e9.16.1754903677809;
        Mon, 11 Aug 2025 02:14:37 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f06:a600:a397:de1d:2f8b:b66f? (p200300d82f06a600a397de1d2f8bb66f.dip0.t-ipconnect.de. [2003:d8:2f06:a600:a397:de1d:2f8b:b66f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459db13fc9fsm319376765e9.7.2025.08.11.02.14.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 02:14:37 -0700 (PDT)
Message-ID: <ac364fac-4ca7-41a9-86c2-f19388b32ec1@redhat.com>
Date: Mon, 11 Aug 2025 11:14:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/hugetlb: Use max() to simplify
 hugetlb_vmemmap_optimizable_size()
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Matthew Wilcox <willy@infradead.org>, Muchun Song
 <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20250810214745.2368-2-thorsten.blum@linux.dev>
 <aJk2IygsxWKYf17u@casper.infradead.org>
 <7fb6ce41-a5e7-496f-979b-775b8e30e764@redhat.com>
 <C6C36750-2C87-4C2B-B683-9789F55D34C2@linux.dev>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <C6C36750-2C87-4C2B-B683-9789F55D34C2@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11.08.25 11:08, Thorsten Blum wrote:
> On 11. Aug 2025, at 10:26, David Hildenbrand wrote:
>> On 11.08.25 02:15, Matthew Wilcox wrote:
>>> On Sun, Aug 10, 2025 at 11:47:45PM +0200, Thorsten Blum wrote:
>>>> Use max() to simplify hugetlb_vmemmap_optimizable_size() and improve its
>>>> readability.
>>> That ... isn't clearer.
>>
>> No, it isn't.
> 
> I guess it's personal preference. I'd prefer max(0, x) over a ternary
> operator any time.

if (size > 0)
	return size;
/* Nothing can be optimized out. */
return 0;

-- 
Cheers,

David / dhildenb


