Return-Path: <linux-kernel+bounces-806013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23FEAB490BB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 16:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE6193C7DAE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 14:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB1B30C603;
	Mon,  8 Sep 2025 14:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SzQwiTNf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E06E30B506
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 14:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757340491; cv=none; b=NzH3ECYYDtSZcoYMF2rO/WQY0xJmR9oKRvnC/XWOn1lEYGOXmWmpSOSVAGYV2qcIvPSZsE5KuWZ2NghcFNWoprcwS0Ey61QclsaQ5dcdZeEhr10wEwFidBC2VgMMq9a5MfWdAbMcFNOQfyVigMJU55DJ4Ezrckt18m3xakJ/ZPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757340491; c=relaxed/simple;
	bh=X708B3BthwF2TvRp/xUgFuErEserdSywZcmU1pfq7bg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MwahQxoO7cot/4iSWk1J+Vg1E76arRT8yH8y4gDkQl0WmXdwAitZAHJGTjouCToa/MJEnt4cB8K4nqB4gQvDhn0ICpvvlixJb79Ool71vuexzhSamhgyXiUtV2GfbBK9Ovf9FxV1BXDr6fqxh2JyCbM1m8drxB6gNTVJsVml29c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SzQwiTNf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757340489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5RW7uj9j6VpLJ7e/ThoSXbMV/AQpqw/iOnSCU64Tv5A=;
	b=SzQwiTNf+rxNUOcQ/XAXSnQSLCAnvMFBqxnooG21nyIyk3l8PCJRxLDSCEJGIfVjI5PCph
	mVq0o6GNTjXGnpP3UrF1F9mOFDob0o0votVCxA0YjGAo4vToUJw1CJ1Fd4NGWpBZTVwpXz
	xo+WpDCu0k5IYN1RP4GMwfJ+uXaaP84=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-112-f0IK7VlaPzGN8LJNvpWF4A-1; Mon, 08 Sep 2025 10:08:08 -0400
X-MC-Unique: f0IK7VlaPzGN8LJNvpWF4A-1
X-Mimecast-MFC-AGG-ID: f0IK7VlaPzGN8LJNvpWF4A_1757340487
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3dc3f943e6eso2783336f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 07:08:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757340487; x=1757945287;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5RW7uj9j6VpLJ7e/ThoSXbMV/AQpqw/iOnSCU64Tv5A=;
        b=Tw0OhfXdurSieCEfFp2iIoybzJE8D3ZBG8jeaXxEbw3FTQhyjThvztbqWBQHvN10JZ
         247EOXtZvaGPjrZ3I6WcFMhYKWXqAPetw4SCb78WiJsZf8tuid42ta6X5Inc/21bsNkk
         zg2NuyCU2WMnmIy2eNaD6Tb+Wwe8zQVH/7gn6CQh/+uB26j65Zz9PkZ2Wux058iCvK8Q
         pPb3ZmT6/fKuAZEStlVzvMzrq4dbyUmJCzOUSX1/rxi1zCATGc2YFuW/DCH+LZcwdjp1
         O4/07KtGTjW59f//zirk3ArmId3Dh5fV6f2qaIEvW0EFtzpTFfjsQV6BKtZ/tRjmGcrE
         DagA==
X-Forwarded-Encrypted: i=1; AJvYcCXp5WFUkStMMdtXolqBnYm1CSjX0vJeBnAdAtse9dclCMI5Qz9B7KkFJZxWE1UOZo+tESE/6plyvPmcZ48=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsf76NMMemXCmWLfflu1mni6Vwll5Flmsiy8gb1bSEr21n1gg1
	pQ8eiXSyKcaDIbGaVdg1QGOcRVp3EVsqQlIhQWMdpxiIX00YbpjY24CgiVl5nzM+tOsODKAnWjv
	mewtmSPnP6KBAmADlKkMIZ8lA3JT1zXHHwa44PT5TfgBRGeuLbZzHqD+Wax+/xx+ZSw==
X-Gm-Gg: ASbGncu7AMIQVU40PblaMU+XyK0wVyYaRedueqXxcCsx3Od9m03MHIwTrMD+JzSpC3y
	n1pmq3TktFj5cNdQ2GP9zXLQ/IZeo61F7u0NFYXFf5hpB1TRIIspPvcBKok7Ls6dTZ03epErX3H
	qWfVhbcgGL7j2sALetT1EPSa1k8+BnTYkV83j7C/0ZUvfprbvLUxHOBESp7JKfAW/Uw/3qvD8B6
	lV6ESH54qaaNcVU9T1FCKqCQ26jA6nlOr+Npb/wJ8kVrhNvYU5V6bb2zkNbbEe2UZh9cO0xlIzg
	xhk2xA+Ym0yT2+OuYhMx3SfrndXplC0CBno4PAEltEpif1VortWgHppVjaPaN6/vruy0r9Z2u8v
	K9/7o3CBD3ebA21ArSg70VMxpQ60ltzD3TIVF8p9vIaF2MFHR9xFMoqKJclvkUW/1
X-Received: by 2002:a05:6000:230c:b0:3d0:64c1:1a40 with SMTP id ffacd0b85a97d-3e64374116cmr6007210f8f.46.1757340486712;
        Mon, 08 Sep 2025 07:08:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyB0IO3PALAsa1/2Q9RjoytWxnek+k4rCfl8hh9plqBM6DuIG8BW9C6h/pNo7GIvytXSRWWw==
X-Received: by 2002:a05:6000:230c:b0:3d0:64c1:1a40 with SMTP id ffacd0b85a97d-3e64374116cmr6007154f8f.46.1757340486206;
        Mon, 08 Sep 2025 07:08:06 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f25:700:d846:15f3:6ca0:8029? (p200300d82f250700d84615f36ca08029.dip0.t-ipconnect.de. [2003:d8:2f25:700:d846:15f3:6ca0:8029])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e74893acecsm4580959f8f.36.2025.09.08.07.08.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 07:08:05 -0700 (PDT)
Message-ID: <1f714ba0-cdda-4122-b6a1-e1e0ea44b1f2@redhat.com>
Date: Mon, 8 Sep 2025 16:08:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] mm/gup: check ref_count instead of lru before
 migration
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
 <47c51c9a-140f-1ea1-b692-c4bae5d1fa58@google.com>
 <e54b1d8c-ad63-4c7a-8b1b-b7c3d76446f2@redhat.com>
 <b008aef2-f69f-e2fb-d4d7-71a42d308529@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <b008aef2-f69f-e2fb-d4d7-71a42d308529@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.09.25 12:40, Hugh Dickins wrote:
> On Mon, 1 Sep 2025, David Hildenbrand wrote:
>> On 31.08.25 11:05, Hugh Dickins wrote:
>>> diff --git a/mm/gup.c b/mm/gup.c
>>> index adffe663594d..82aec6443c0a 100644
>>> --- a/mm/gup.c
>>> +++ b/mm/gup.c
>>> @@ -2307,7 +2307,8 @@ static unsigned long
>>> collect_longterm_unpinnable_folios(
>>>      	continue;
>>>      }
>>>    -		if (!folio_test_lru(folio) && drain_allow) {
>>> +		if (drain_allow && folio_ref_count(folio) !=
>>> +				   folio_expected_ref_count(folio) + 1) {
>>>       lru_add_drain_all();
>>>       drain_allow = false;
>>>      }
>>
>> In general, to the fix idea
>>
>> 	Acked-by: David Hildenbrand <david@redhat.com>
> 
> Thanks, but I'd better not assume that in v2, even though code the same.
> Will depend on how you feel about added paragraph in v2 commit message.
> 
>>
>> But as raised in reply to patch #1, we have to be a bit careful about
>> including private_2 in folio_expected_ref_count() at this point.
>>
>> If we cannot include it in folio_expected_ref_count(), it's all going to be a
>> mess until PG_private_2 is removed for good.
>>
>> So that part still needs to be figured out.
> 
> Here's that added paragraph:
> 
> Note on PG_private_2: ceph and nfs are still using the deprecated
> PG_private_2 flag, with the aid of netfs and filemap support functions.
> Although it is consistently matched by an increment of folio ref_count,
> folio_expected_ref_count() intentionally does not recognize it, and ceph
> folio migration currently depends on that for PG_private_2 folios to be
> rejected.  New references to the deprecated flag are discouraged, so do
> not add it into the collect_longterm_unpinnable_folios() calculation:
> but longterm pinning of transiently PG_private_2 ceph and nfs folios
> (an uncommon case) may invoke a redundant lru_add_drain_all(). 

Would we also loop forever trying to migrate these folios if they reside 
on ZONE_MOVABLE? I would assume that is already the case, that migration 
will always fail due to the raised reference.

-- 
Cheers

David / dhildenb


