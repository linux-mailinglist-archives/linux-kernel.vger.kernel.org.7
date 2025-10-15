Return-Path: <linux-kernel+bounces-854457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB1DBDE6F6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 14:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4222519C3FF4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 12:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85CF326D64;
	Wed, 15 Oct 2025 12:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lh8Y5SDd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AB623A99E
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 12:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760530621; cv=none; b=C14eJZECIPLveGxasB4Foy0K/naFKS02EHnuCWwV+831pfrx1NeV6Mzn0CjChDyTQ8T5maCIL2LBPFfsIKjZWcYIMgJizeok7gHv3VRrRScgvCUoXwZ4HWq9m8a21+fJMmYfahksr9KBXvojLxa/HgvrREF8hcNDhWfnwSbeiWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760530621; c=relaxed/simple;
	bh=xexL53J9fX4OtVKPoRtIJOORhhJeA0n8xbPhWx9Ni70=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gmC+F2D8pd31BPWcXBFqyhmq8ipaJxixPQlURTPKJrhATM1iK0UXpj/dt9h/nLzFNBXOnte01xfIcehURCTmepmSd8bIyaiXLZqiKKrxDNrzvwB+ZHAs19Rca6RBuZg5quVbBk6yz05tVx2NomINLJONF8gMs9n3Fz9ATqyQa+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lh8Y5SDd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760530618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=SmdyKylOCiMWsvGvR0pe6Xd5Vwb++Tytv/QZyA45ONk=;
	b=Lh8Y5SDdIsDqzdZexGjtYCkhTk0+3cLT1orlvwmtTRgmtQLAwnXJ/RWtv/DZqt9H1airJL
	Ldn7R1COYkimIEP91vJDBRMuQwX3TtDhy2Z7Bk1X6NyfN985XMxSonRYJM2KlVCABKqLcG
	4unAbfvUNi25NMWvswP6T7p2qVd6Ors=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-sI5on_ZmN0yEJyDTX5qqzg-1; Wed, 15 Oct 2025 08:16:57 -0400
X-MC-Unique: sI5on_ZmN0yEJyDTX5qqzg-1
X-Mimecast-MFC-AGG-ID: sI5on_ZmN0yEJyDTX5qqzg_1760530616
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3efe4fcc9ccso5351385f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 05:16:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760530616; x=1761135416;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SmdyKylOCiMWsvGvR0pe6Xd5Vwb++Tytv/QZyA45ONk=;
        b=wlHmYW+fDKl3wLflgo+Jm7cIzm5FJuo7WbWiqg7Kz1+8tANjSIRqYRUJ6POHOnOOmY
         0EWTuC8wXCMTPsS8N3HPUTMDdGxKCrGf7lO9AmsdYi720iDzw8/HaOk8W/tLaWS1GxAf
         7hN/7bg4EaZUR6uiTGf0XAMJ0XqADQLqcjqBWWmHYgfecYXjaQendOs5Eyg6oaUV3GQp
         +2PYYEBLsDwMJTzMNAc9guHBhOCxpiWpMO02bD5IVj+HJCaFgVz5RlykMZe2J4T973My
         tmxPLmPVd9ewmMNi5KmS7aUVo3kMJFC10zE/D3NfjfavJFQ8ErVaR0Mfjiy1grLD3Yjb
         tmJg==
X-Forwarded-Encrypted: i=1; AJvYcCVNUUytdGbyuaqp88qKrkAjrfHSHAqlH5AYRZG6+vYZD4EcYqEpaynLSD+Pc9/VNlFehaUEUEUetEfZyTg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTIRo6aW0yHxLwDfPQc6RpUKLezjKyEWY2X6+IKKBz3lL6wCE1
	F0f7Xad/H/OwDizpKgzTWKhyqa79AqXqQQRwaD04l0WDiPQy58W8y5lUnv72opEr2ovuk3182NL
	F4yuMs0h5NfOb2L34oF2/Z5BOU6+oE0bXjGxQSb3J0kXWWTb1TzbgDJYVqrApQI6O9g==
X-Gm-Gg: ASbGncuw66+6nK5NXmOno+ertQHFwVFxf0t4BIULFkzCMSmlRP6ZnJRMn9HVU7KKpdN
	poeWCzonuZe3AqcblKyIVF6oH98wpRHZ8TJ9PblMIRDSkX0rkRKaW/Jn3iWeam5kxtG1ULPCTQo
	4iEwhGup+0O9DQ2OY6hMlpITSRtTXjadOovXEY/LP2M3T+MUzG9ZDDQYMle8NIcL+tYKTDjCNzV
	qE9Vyg5SdbBlTP5etw9NSPbt3I5ZTOK4qa7AljeqFHZzDmSaue6ga4l+dHiSPX77LFzTsfCQ0Rf
	DXl4pzK77xfNzyH1AhtTcrHkOcAQSuN5MpR1YVjOrZdzFwRtY6Du9gL4DKHE5Bo=
X-Received: by 2002:a05:6000:3101:b0:3ff:d5c5:6b01 with SMTP id ffacd0b85a97d-4266e7bf0c2mr19302334f8f.19.1760530615704;
        Wed, 15 Oct 2025 05:16:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHq6JiR82m9bDrKg8Wop7vTO6rx81ModfpoM4Z+5IMKNQIQwLb7JjpU9QbP1EvGWm7Gd0fGdQ==
X-Received: by 2002:a05:6000:3101:b0:3ff:d5c5:6b01 with SMTP id ffacd0b85a97d-4266e7bf0c2mr19302294f8f.19.1760530615229;
        Wed, 15 Oct 2025 05:16:55 -0700 (PDT)
Received: from [10.32.64.156] (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5cfe4esm27898783f8f.26.2025.10.15.05.16.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Oct 2025 05:16:54 -0700 (PDT)
Message-ID: <f807f3bf-a05d-4e0f-af4c-bb0167dde51c@redhat.com>
Date: Wed, 15 Oct 2025 14:16:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm: call back alloc_pages_bulk_list since it is
 useful
To: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>,
 Mel Gorman <mgorman@techsingularity.net>, Vlastimil Babka <vbabka@suse.cz>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>,
 "T . J . Mercier" <tjmercier@google.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Zhaoyang Huang <huangzhaoyang@gmail.com>,
 steve.kang@unisoc.com
References: <20251014083230.1181072-1-zhaoyang.huang@unisoc.com>
 <20251014083230.1181072-2-zhaoyang.huang@unisoc.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251014083230.1181072-2-zhaoyang.huang@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.10.25 10:32, zhaoyang.huang wrote:
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

Probably the subject should be "mm: reintroduce alloc_pages_bulk_list()"

> 
> commit c8b979530f27 ("mm: alloc_pages_bulk_noprof: drop page_list
> argument") drops alloc_pages_bulk_list. This commit would like to call back
> it since it is proved to be helpful to the drivers which allocate a bulk of
> pages(see patch of 2 in this series ).

"Let's reintroduce it so we can us for bulk allocation in the context of 
XXX next."

> I do notice that Matthew's comment of the time cost of iterating a list.
> However, I also observed in our test that the extra page_array's allocation
> could be more expensive than cpu iteration when direct reclaiming happens
> when ram is low[1]. IMHO, could we leave the API here to have the users
> choose between the array or list according to their scenarios.

I'd prefer if we avoid reintroducing this interface.

How many pages are you intending to allocate? Wouldn't a smaller array 
on the stack be sufficient?


-- 
Cheers

David / dhildenb


