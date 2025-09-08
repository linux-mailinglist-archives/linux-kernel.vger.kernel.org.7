Return-Path: <linux-kernel+bounces-806701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7CAB49ABF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 22:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44FD84E25A6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 20:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69A52D7DF2;
	Mon,  8 Sep 2025 20:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="httJjIpt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589471A9FAC
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 20:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757362268; cv=none; b=rO2I2F9iUpNqgOe1MMMkQqvvJCs/7ymohSINDSP5C5E5i2S9AShcF+gY0yItBH1OoQ/WH1fvJ2VewLSDoKOSvDAyLdJNvaTho9l6R6tr8L2oSEJSjxi5pUdKH1kFj98jReflPjmthA7/KVJFczRuXOnXNo5RB8wc+ye9LeaD1F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757362268; c=relaxed/simple;
	bh=kk2i4QxWBEcb8cLMkCHEhzHvYTZ5flgrvizeiDJFKjU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CsKrY11j9Mavlspp5TkFokxMFs+vSa9EL9s1r+7GkbGjsJAVH6nRRYsplEVqTcFYRdSedGjTZ59AS04Ph2A56JnJMVACljtz5JhpCn2euTLr4tPgREOITQ0iI5wCJAOuzkQg2P9TsbahlflGgaKIR9ZBOghToDVl7ESirLbfJBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=httJjIpt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757362266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=yTJ+HCVpQQhD4Z+sGAn0il4Y4FIJa+bkJg1ouzoR6YU=;
	b=httJjIptBbNMRPf2KrY3VEvdH9UfvsLrd6RgChTkzjnopeWR+hNvQI6QmZMTrk5eLCTnJb
	w0hJE6lLSEWxqIwmvzceZ57Yi/9/o1c2Rgo00Aqrp793Tx/BK5/VVZJgveOhTQWgkNUROm
	4IpamFtN3dike2FMTzAx2o4ImF9pEbk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-OrJJ6SIZNiePSE9b0XzDNQ-1; Mon, 08 Sep 2025 16:11:04 -0400
X-MC-Unique: OrJJ6SIZNiePSE9b0XzDNQ-1
X-Mimecast-MFC-AGG-ID: OrJJ6SIZNiePSE9b0XzDNQ_1757362263
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3dbc72f8d32so1978407f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 13:11:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757362263; x=1757967063;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yTJ+HCVpQQhD4Z+sGAn0il4Y4FIJa+bkJg1ouzoR6YU=;
        b=dnAaaGpsmH5Q8bmJFsQBRn3zsX1p5obZhxriMOqtn3VURV2yeJ9YuvL4X8vXN6HCA6
         hEAopu+fMToAIc4zCuIR4JttSHoI6FDF6nKybULBqFYI96b/CDxRW0OZGO2sf/na8AKG
         E8G5KSiOEmO7z2t/9FvXjkzSRSP59j0oBM/HmYX+e1lW5eQlHyGnIUguQOesmdqSmRGS
         8bEaYLYfsIgAJcFlbTNXOqMaLDcifQthaS7LBMNVXdRjRdex7ucyac1uPbVYt3fY2W6B
         Re4t6kmq8+mJwa1g8bshhEKa7HW3UuKo84Bj42kAB4qgC7pBmONVo2IMeEqDJsmuxEI/
         7XwQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9OzRIa4LbTMx01ZG3jjnReXnNIVvH9FnsCDGjF4gnWZCP+9BSSIipMRR79a1TvN+rHmBxu5LSYgAwelo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYmohUz8lJOJkmgjA9iD/e33lK9/mNYSB4oYAlLVW3nek914Y+
	5xFpuOrKmsbH0+8oXC18oLcYT+FoeA7TEhsOr5Cr3FOmLutB0zIUP2c5DI8lLM+mP7mFx5hlm+H
	h65VgEhG6YuTyf0gJcHPLPZ8HWj2v8vFGB4GT2AEQ1P7KDSxF9wP8URrgHVcgfc53QQ==
X-Gm-Gg: ASbGncuCfGNcm3rGYW6bEV9jM+xeKbsaMBoPAbW18vhlTiliBPf799sDXYcSk7YlfF0
	DkFGTdASau8/u9WSnlvfoPs9K2CfmgpdIiG8kDf8rPfeEBXrA9W5X+NNjo8FRalKSfvU+UkhEzz
	cekYKjxROp8fghNRDZzi486P6pnIPEX7Ehbcf/IlRuPNvJzkafan+aqaGX3XCGVqJ45vMCVCpxP
	JFdnSMrsvY78FWMG10ETUapdgTQcPWqxUtcARBDk3vRuEwkbYp+jY6rTdraYK7slVMtel4d9Z4n
	2JEJy55GkuVwQ8IV5b1CwE38Kf8v38bhFRXokiE3SVuMqmeB+9Nmd0dcxkowy7y3Wz23bgg=
X-Received: by 2002:a05:6000:178e:b0:3ce:a06e:f24e with SMTP id ffacd0b85a97d-3e64c87e0a1mr5862442f8f.52.1757362263258;
        Mon, 08 Sep 2025 13:11:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmoGWcHGRU2wMNj3AUaA3ve3GL1XOR+7OoKa6K12F32smmVG8lX2G5M5jqlg7p8BKffe6Vzg==
X-Received: by 2002:a05:6000:178e:b0:3ce:a06e:f24e with SMTP id ffacd0b85a97d-3e64c87e0a1mr5862413f8f.52.1757362262811;
        Mon, 08 Sep 2025 13:11:02 -0700 (PDT)
Received: from [192.168.3.141] (p57a1ae98.dip0.t-ipconnect.de. [87.161.174.152])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d978ab6fc7sm27761353f8f.45.2025.09.08.13.11.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 13:11:02 -0700 (PDT)
Message-ID: <be8580b1-38cb-49a4-a916-95c9289059be@redhat.com>
Date: Mon, 8 Sep 2025 22:11:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] mm: folio_may_be_cached() unless folio_test_large()
To: Hugh Dickins <hughd@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Will Deacon <will@kernel.org>,
 Shivank Garg <shivankg@amd.com>, Matthew Wilcox <willy@infradead.org>,
 Christoph Hellwig <hch@infradead.org>, Keir Fraser <keirf@google.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
 Frederick Mayle <fmayle@google.com>, Peter Xu <peterx@redhat.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Vlastimil Babka <vbabka@suse.cz>,
 Alexander Krabler <Alexander.Krabler@kuka.com>, Ge Yang
 <yangge1116@126.com>, Li Zhe <lizhe.67@bytedance.com>,
 Chris Li <chrisl@kernel.org>, Yu Zhao <yuzhao@google.com>,
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>,
 Wei Xu <weixugc@google.com>, Konstantin Khlebnikov <koct9i@gmail.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <a28b44f7-cdb4-8b81-4982-758ae774fbf7@google.com>
 <861c061c-51cd-b940-49df-9f55e1fee2c8@google.com>
 <7fe2380f-a83e-4a9e-8c5e-8459c9af0d5f@redhat.com>
 <7113d289-fb8e-4589-7eb5-1f7139965ade@google.com>
 <3f76748b-8f99-4e63-ba39-adadc2f58838@redhat.com>
 <2ba8984b-8818-2a7f-7544-4c5fce3e0878@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <2ba8984b-8818-2a7f-7544-4c5fce3e0878@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.09.25 22:04, Hugh Dickins wrote:
> On Mon, 8 Sep 2025, David Hildenbrand wrote:
>> On 08.09.25 13:19, Hugh Dickins wrote:
> ...
>>>
>>> (Settimg aside that I've never perceived those pagevecs/batches as a
>>> "cache"; but lru_cache_disable() gave us that terminology, and we've
>>> gone with the flow ever since.  lru_add_drain() would be better named
>>> lru_cache_drain() now, I've always got hung up on "adding a drain".)
>>
>> Yeah, the terminology is not that intuitive :)
>>
>> Not sure if using "batched" instead of "cached" might be clearer long-term?
>>
>>>
>>> "may be" rather than "maybe" was intentional: perhaps too subtle,
>>> but to a native speaker it neatly expresses both the "we can do this"
>>> and "might this have been done" cases.
>>
>> I would wish we could find something that also non-native speakers can
>> immediately understand ;)
>>
>> "may_get_lru_cached" / "may_get_lru_batched"?
>>
>> /me could not even phrase it in German properly
>>
>>>
>>> kernel-doc?  I don't think so, this is very much an mm-internal
>>> matter, and I don't care for the way kernel-doc forces us towards
>>> boilerplate ("@folio: The folio.") rather than helpful comment.
>>
>> So a comment that this is an internal helper might be nice. Or we just move it
>> straight to mm/internal.h ?
> 
> mm/internal.h, where we hide things (GFP_RECLAIM_MASK etc!) that belong
> elsewhere?  No thanks.

Yes, or other mm-internal helpers that actually belong there. Like 
folio_raw_mapping() or folio_nr_pages_mapped().

> 
> David, I think you're over-thinking this: I'm coming to regret not just
> going with your excellent folio_test_large() optimization, and let
> someone else mess around with the naming.

Please don't feel like I'm pushing to hard here. If you feel the current 
naming is fine and for some reason I don't completely understand it 
should not be in mm/internal.h, all good.

-- 
Cheers

David / dhildenb


