Return-Path: <linux-kernel+bounces-791410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9FCB3B67B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 10:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00C46981E4C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 08:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C792BD5A1;
	Fri, 29 Aug 2025 08:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YhumcX/j"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744197082F
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 08:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756457778; cv=none; b=LJ+TPtWVPb2PChmgTf3LTh778oqTa2FxGNsN+MqqAaRtW0qieq2mvvhYoe2sHK70mo1VyMmioghL/ImbqkDlq00YVD8iy5PQ5wzQU9YMXyU4oi2UM9Pw1yNTBSsMmjAdSlYIQnZMmUdK+6PiHDzjYeMfnUalHKkVHJvJkREAia8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756457778; c=relaxed/simple;
	bh=CBbuZFjCJ41pnLxjGbRzJvWuKmPTt1JL8xb2VexbBFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ApadAZ8+YUvAFH3t1STChKVUuPwaAxVor4I8KRjFWyKnSz1ajNi06uP7qNrbIBissoer7q6jqYuUwSDDLm9ZoHbq6kYFPJWpjaXtOKlp9edg5PuPlPV67KPtfwCxs/7fMtnDyA3UB6IMPZJ7RjSXgr/npMgtfJm7nQwE5Fe+IBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YhumcX/j; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756457775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=sUg/m1Qobd5H9EiE8Vi7zYDpEBbxK5FBxUfpxpnhqeg=;
	b=YhumcX/jqjccTaj9rEtE26m31XfHlG86v/z+9rFkkYN1k+gEfe25iF0nRVkAdOdknPb7KV
	8ges0m8A3QL8hWjWnVq+d/zhVxipWQfxDp/mSAUUwq9xPWD3Mq4sEEHZz0/LKvaurSBKM0
	3mm3Gs6Ss7+yXGEHwUkaWqIJzouCQps=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-WYG42VJGMHmoVUSb8lgG6Q-1; Fri, 29 Aug 2025 04:56:12 -0400
X-MC-Unique: WYG42VJGMHmoVUSb8lgG6Q-1
X-Mimecast-MFC-AGG-ID: WYG42VJGMHmoVUSb8lgG6Q_1756457771
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3cf48ec9e40so350300f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 01:56:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756457771; x=1757062571;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sUg/m1Qobd5H9EiE8Vi7zYDpEBbxK5FBxUfpxpnhqeg=;
        b=IsU0HRlEs3iMXc9KNtaWYUIWQQSzyMHk96Wv1DWe9MUemEJbNYEyxkvkfzi/lsx357
         M+zoq4IAtO8IHzEoTu0iji3WznHX0xl6LnWK3+msUrHv2xAHc3demxYD+isvAH5CoMRD
         DFkowSxdrDRC5za5AbWWGunM3yDDKeZK6hKyQxFA06my9obIu4dc86i8sTd4I8YVhEqt
         Q2k27Po0UEYP7Q2eWDQjlbW0sZYlDKd3Uzx6TE8eq+xal7+KyCSz7gYcTlMso9uTetbN
         MpIV/N1aDkulyHWzM7zga/b73aMNJmHz1H48A8RC2fpd/mnU9xY9Mg+9rFY9rynFv21J
         DsHw==
X-Forwarded-Encrypted: i=1; AJvYcCWd1HXBs69z6XqBCIko+HSNC9m+hb8VVnQUl10KoDC5LF2tulAGI/fvEV5puRVF48Vhad5T21ka6cfD6gM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhH0NIoT0p/H2u/QXL2tbuYx1JM5oZQkVdKO7N0xLG0nqc016L
	PeO1ti3SPA/Di+8IEaOu/4dI8PYqTdIMobcP8BWUc215bb3XSqAIHQhHYSXpUBrlu3XB9eR5GqS
	96vUwSvbTyg9cEbnBim6JuejcO8QA4cAsym+u/DGWVr5yUrhoGgSXcKFNUlHZn1OQ5Q==
X-Gm-Gg: ASbGncsjLn/Ectpe1QaxO+YJ9W+UM2pDIPiYEcs6z12hvBxAji4TWWdtnYRqkLgzXS1
	+ESsvOOaRbtq7Zzh38vdrG1cvNxrutMBK8aCRQGTEhHKwYA3Or4phupY3hGskcrGZukToZhuT9s
	zgaR9friyUGm2fFDzUTQ9HL6D2696R9nj07FGbTpsPLX1tZrLdfYWh6r4aA3U4tD0puArGKWZB4
	kCoiOOE64drIRiBhYtykNTg6UprNQQq9aCHAczDMALz3zJN9y1dZ55Q6AE00IdgL+eFKc6BlFHb
	+n5dsRCbPD9BHrmdUvU9gGE0OSOyXHDOhLbKiJBm/7agiv2I6J6QGx9e7Cw+ZWBhNWJMleHLnYy
	4op5hCaLNhtYvi+VNid4r94RGQTcTR9mTxWqw+ruSjtv3Yr7D6gN5HQI1vy/glhBZ
X-Received: by 2002:a05:6000:26d2:b0:3d0:d6e6:5d76 with SMTP id ffacd0b85a97d-3d0d6e664b1mr776242f8f.55.1756457771241;
        Fri, 29 Aug 2025 01:56:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKSfhh3dzFG1NHqZK8Z2zwBhi/GiFCA2R8jwRwnPT18iorgM/4FbKEfeknQwqmNPOImPBvwg==
X-Received: by 2002:a05:6000:26d2:b0:3d0:d6e6:5d76 with SMTP id ffacd0b85a97d-3d0d6e664b1mr776218f8f.55.1756457770796;
        Fri, 29 Aug 2025 01:56:10 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1d:100:4f8e:bb13:c3c7:f854? (p200300d82f1d01004f8ebb13c3c7f854.dip0.t-ipconnect.de. [2003:d8:2f1d:100:4f8e:bb13:c3c7:f854])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d12c90a01bsm61847f8f.31.2025.08.29.01.56.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 01:56:10 -0700 (PDT)
Message-ID: <eaba0af3-c531-47f4-bc4e-714a25dfc686@redhat.com>
Date: Fri, 29 Aug 2025 10:56:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/gup: Drain batched mlock folio processing before
 attempting migration
To: Hugh Dickins <hughd@google.com>
Cc: Will Deacon <will@kernel.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Keir Fraser <keirf@google.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
 Frederick Mayle <fmayle@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>,
 Rik van Riel <riel@surriel.com>, Vlastimil Babka <vbabka@suse.cz>,
 Ge Yang <yangge1116@126.com>
References: <20250815101858.24352-1-will@kernel.org>
 <c5bac539-fd8a-4db7-c21c-cd3e457eee91@google.com>
 <aKMrOHYbTtDhOP6O@willie-the-truck> <aKM5S4oQYmRIbT3j@willie-the-truck>
 <9e7d31b9-1eaf-4599-ce42-b80c0c4bb25d@google.com>
 <8376d8a3-cc36-ae70-0fa8-427e9ca17b9b@google.com>
 <a0d1d889-c711-494b-a85a-33cbde4688ba@redhat.com>
 <3194a67b-194c-151d-a961-08c0d0f24d9b@google.com>
 <56819052-d3f5-4209-824d-5cfbf49ff6e9@redhat.com>
 <d8e8c6d9-2b58-a1e8-d3cb-3f578f3f5889@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <d8e8c6d9-2b58-a1e8-d3cb-3f578f3f5889@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>>>
>>>> :/ If so, I really rally
>>>> hope that we can find another way and not go back to that old handling.
>>>
>>> For what reason?  It sounded like a nice "invariant" to keep in mind,
>>> but it's a limitation, and  what purpose was it actually serving?
>>
>> I liked the semantics that if !lru, there could be at most one reference from
>> the LRU caches.
>>
>> That is, if there are two references, you don't even have to bother with
>> flushing anything.
> 
> If that assumption is being put into practice anywhere (not that I know of),
> then it's currently wrong and needs currecting.

We do make use of that property in wp_can_reuse_anon_folio(), to just 
fail fast -- that's what Linus argued for back then: give up fast and 
just create a page copy.

Essentially hidden in the "folio_ref_count(folio) > 3" and 
"!folio_test_lru(folio)" code path. mlock caches would not be considered 
right now.

Now, in contrast to page pinning, that code is pure best effort, and we 
don't care that much about always getting it right (e.g., no remote 
draining, no draining if there is a clear indication that it might help).

> 
> It would be nice and simple if it worked, but I couldn't get it to work
> with mlock/munlock batching, so it seemed better to give up on the
> pretence.

Thanks for trying!

[...]

>> Regarding the issue at hand:
>>
>> There were discussions at LSF/MM about also putting (some) large folios onto
>> the LRU caches.
>>
>> In that context, GUP could take multiple references on the same folio, and a
>> simple folio_expected_ref_count() + 1 would no longer do the trick.
>>
>> I thought about this today, and likely it could be handled by scanning the
>> page array for same folios etc. A bit nasty when wanting to cover all corner
>> cases (folio pages must not be consecutive in the passed array ) ...
> 
> I haven't thought about that problem at all (except when working around
> a similar issue in mm/mempolicy.c's folio queueing), but can sympathize.
> 
> It had irritated me to notice how the flush-immediately code for 512-page
> folios now extends to 2-page folios: you've enlightened me why that remains
> so, I hadn't thought of the implications.  Perhaps even more reason to
> allow for multiple references on the pagevecs/batches?

Not sure TBH if multiple references from pagevecs/batches really play a 
role here :)

> 
>>
>> Apart from that issue, I liked the idea of a "single entry in the cache" for
>> other reasons: it gives clear semantics. We cannot end up in a scenario where
>> someone performs OPX and later someone OPY on a folio, but the way the lru
>> caches are flushed we might end up processing OPX after OPY -- this should be
>> able to happen in case of local or remote flushes IIRC.
> 
> It's been that way for many years, that's how they are.

Yeah, but I enjoyed clearer semantics: like a folio_activate() actually 
resulting in an activation, not getting swallowed by a 
folio_deactivate() stranded somewhere.

>>
>> Maybe we just want to limit it to !folio_test_large(), because flushing there
>> really doesn't give us any chance in succeeding right now? Not sure if it
>> makes any difference in practice, though, we'll likely be flushing remote LRU
>> caches now more frequently either way.
> 
> Ah, good idea. with or without my changes.  Maybe material for a separate
> patch.  I wonder if we would do better to add a folio_is_batchable() and
> use that consistently in all of the places which are refusing to batch
> when folio_test_large() - I wonder if a !folio_test_large() here will
> get missed if there's a change there.

You read my mind.

-- 
Cheers

David / dhildenb


