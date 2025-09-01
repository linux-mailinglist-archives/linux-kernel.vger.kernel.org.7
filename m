Return-Path: <linux-kernel+bounces-794017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39588B3DB84
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 09:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CC68188AE0B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 07:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A1926D4D8;
	Mon,  1 Sep 2025 07:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d2neTr1z"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9AD258ED9
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 07:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756713146; cv=none; b=fcoFBc9aNIQOUeZk3o6jTdD+DT2suaqHBkQB/+R1+CNaCYsDqVUqp3eaR4qFhpDkvRMO33Z6jMEQxcz9KPY14+52eQt/bpYEgCH+yEOt8C4wmoObCppEnghD13nYZ1EkmVJizr63Ld/hNC+QBgNkNXYp7WoGXgtxCToG7CA/jQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756713146; c=relaxed/simple;
	bh=i+1qCp3beBG8hR67Ml0uTTncFl+n66M6KTgqSeRW5mk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J2h9EJo7V8kclS6Nu2Po/YJzP33ojf4O53G99Z3r4oIQyWXDCVDwj8eHxfG9vCm8AxtoeObU8PHBbUZ78UavGpReTFO9liyUC8c7nnTmMWAJki2Wq2Q29sCHgbD82jF7iZnXmJ6drBFRzI5VHfJaxHQfCRF9ifte2HIp3KBTcq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d2neTr1z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756713143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=HllG5yxgEuvgobHZe1WNgsnnNNSMr0+x2czShD/v46g=;
	b=d2neTr1z+lW0Qw0mpjusjwmEJ9Xzkm0mPaGe+TaAhCkVtSnvohJ9Thi+rtbXYT0XRCV8Ej
	NcL5R2llg+4LOkVEkO4HB1nbSgvPIxhC9Ge217sf9kMtLCu0YYkPa/eaLUzlAOAPETtLtq
	XXm/3xXY61FkXRRwsWAJboi86022sck=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-8O_En15hNUSoPE5c6_7gZA-1; Mon, 01 Sep 2025 03:52:22 -0400
X-MC-Unique: 8O_En15hNUSoPE5c6_7gZA-1
X-Mimecast-MFC-AGG-ID: 8O_En15hNUSoPE5c6_7gZA_1756713141
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3ce059e3d42so2358702f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 00:52:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756713141; x=1757317941;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HllG5yxgEuvgobHZe1WNgsnnNNSMr0+x2czShD/v46g=;
        b=B+IBVz43M5wAyht5VxiVDVJf/6befdATCMIP2pr9Oejy7y+mICk38/G4DMbWQc1MEP
         uVZN1zrdiY7X0dmlBgDMxwFS/32xR7bOFaF2kWPC4hzAuLMaBcicWlk2mDvpKge2J2/P
         jSTUeZ1QCYSsSPfZvawUOUUL+ntky3DEDnK2BQJBs4eifrlf5FDK5RPvxm7RFJrC3yXp
         KXj+S2qbBv9lhWpe5YAeb/6sc52s9xaWYF5WEaWub0wdQNQmwXvWz7fhmAOTijNnjuiK
         1CrrgJUS/nr15dPa8v0Khd8WlrLqheNvrHLV1VHlOArpKJgGTaBNRgd+S60wtlDmCGzn
         +PrA==
X-Forwarded-Encrypted: i=1; AJvYcCVILNnUu79Q+9bNcL/j1gdwTVCkNOD4VyDG8Cats6raY42y/a1xowHt8BDUykHy+9JsGsnvcqG/wW4DwuM=@vger.kernel.org
X-Gm-Message-State: AOJu0YypuZEncDcaGf0PRx1q4kr9MRnsjVf+akjE1Keyr6sxH55XWjv9
	Ko4LA+q1v6ceGS4kV+i3ur2xzSRHCYagms6aMcOIcBTF07ASxxpRE8C14yZf16t3pWjLieAoA76
	B7ZF8ww0l1F1CRLE/0T8yc5wj8Nt+KvPw2eUogbpjrukqlCZA1XNQhYnri3JXLcBZ+A==
X-Gm-Gg: ASbGnctCP+YijYFqB7/m9VW3+dncGhKsvwTKQQLkb9ae3PN0G87cXzEtSEc4gvsoQto
	fCa5hvzzQYpjMeYPgEMXLQcy5F9r16cgMuny5FBpK6vPz3RELnCA41a1rhe9bIgBU/uOqHLdEih
	ZVTApaV2u/N0MitoHFB1VkQkzGM9BNvKMxL2YTwTQqMk0U1KSEK57SL9PjbaP4RBT6b5vzrYsS0
	2B7LJjFfZezAgAVW1Lk6nCZsEMNE+fNHjaaXqUJkZku6aWorPqzbHYpq9+ZP/xFKJBVetIRAJk8
	qjGmncUckdjNXPRN3DV/WtldJCXEGCZjZO+ekVNfQcfPd1DqZs9y3EF3UyL9Q694wYuQ/u8JuUw
	PyOKfmTQn86c2Y6m8MAQdyna77Dut4YZPqhU3n1cvj5mT+DsrNUTXE8UYV+5pp+K/7oU=
X-Received: by 2002:a05:6000:22c8:b0:3d4:d572:b8ea with SMTP id ffacd0b85a97d-3d4d582029dmr3197729f8f.34.1756713140933;
        Mon, 01 Sep 2025 00:52:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkxrzk0lP+lzTzium88rZISj1JP6wQQDJHhaGn2DR4npJJgvliAA7HY6y8ULZXDuQ1rwzhPw==
X-Received: by 2002:a05:6000:22c8:b0:3d4:d572:b8ea with SMTP id ffacd0b85a97d-3d4d582029dmr3197620f8f.34.1756713139105;
        Mon, 01 Sep 2025 00:52:19 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f37:2b00:948c:dd9f:29c8:73f4? (p200300d82f372b00948cdd9f29c873f4.dip0.t-ipconnect.de. [2003:d8:2f37:2b00:948c:dd9f:29c8:73f4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d0a1f807f9sm13185017f8f.38.2025.09.01.00.52.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 00:52:18 -0700 (PDT)
Message-ID: <92def216-ca9c-402d-8643-226592ca1a85@redhat.com>
Date: Mon, 1 Sep 2025 09:52:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] mm: fix folio_expected_ref_count() when PG_private_2
To: Hugh Dickins <hughd@google.com>, Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Will Deacon <will@kernel.org>,
 Shivank Garg <shivankg@amd.com>, Christoph Hellwig <hch@infradead.org>,
 Keir Fraser <keirf@google.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 John Hubbard <jhubbard@nvidia.com>, Frederick Mayle <fmayle@google.com>,
 Peter Xu <peterx@redhat.com>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Vlastimil Babka <vbabka@suse.cz>,
 Alexander Krabler <Alexander.Krabler@kuka.com>, Ge Yang
 <yangge1116@126.com>, Li Zhe <lizhe.67@bytedance.com>,
 Chris Li <chrisl@kernel.org>, Yu Zhao <yuzhao@google.com>,
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>,
 Wei Xu <weixugc@google.com>, Konstantin Khlebnikov <koct9i@gmail.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <a28b44f7-cdb4-8b81-4982-758ae774fbf7@google.com>
 <f91ee36e-a8cb-e3a4-c23b-524ff3848da7@google.com>
 <aLTcsPd4SUAAy5Xb@casper.infradead.org>
 <52da6c6a-e568-38bd-775b-eff74f87215b@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <52da6c6a-e568-38bd-775b-eff74f87215b@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01.09.25 03:17, Hugh Dickins wrote:
> On Mon, 1 Sep 2025, Matthew Wilcox wrote:
>> On Sun, Aug 31, 2025 at 02:01:16AM -0700, Hugh Dickins wrote:
>>> 6.16's folio_expected_ref_count() is forgetting the PG_private_2 flag,
>>> which (like PG_private, but not in addition to PG_private) counts for
>>> 1 more reference: it needs to be using folio_has_private() in place of
>>> folio_test_private().
>>
>> No, it doesn't.  I know it used to, but no filesystem was actually doing
>> that.  So I changed mm to match how filesystems actually worked.
>> I'm not sure if there's still documentation lying around that gets
>> this wrong or if you're remembering how things used to be documented,
>> but it's never how any filesystem has ever worked.
>>
>> We're achingly close to getting rid of PG_private_2.  I think it's just
>> ceph and nfs that still use it.
> 
> I knew you were trying to get rid of it (hurrah! thank you), so when I
> tried porting my lru_add_drainage to 6.12 I was careful to check whether
> folio_expected_ref_count() would need to add it to the accounting there:
> apparently yes; but then I was surprised to find that it's still present
> in 6.17-rc, I'd assumed it gone long ago.
> 
> I didn't try to read the filesystems (which could easily have been
> inconsistent about it) to understand: what convinced me amidst all
> the confusion was this comment and code in mm/filemap.c:
> 
> /**
>   * folio_end_private_2 - Clear PG_private_2 and wake any waiters.
>   * @folio: The folio.
>   *
>   * Clear the PG_private_2 bit on a folio and wake up any sleepers waiting for
>   * it.  The folio reference held for PG_private_2 being set is released.
>   *
>   * This is, for example, used when a netfs folio is being written to a local
>   * disk cache, thereby allowing writes to the cache for the same folio to be
>   * serialised.
>   */
> void folio_end_private_2(struct folio *folio)
> {
> 	VM_BUG_ON_FOLIO(!folio_test_private_2(folio), folio);
> 	clear_bit_unlock(PG_private_2, folio_flags(folio, 0));
> 	folio_wake_bit(folio, PG_private_2);
> 	folio_put(folio);
> }
> EXPORT_SYMBOL(folio_end_private_2);
> 
> That seems to be clear that PG_private_2 is matched by a folio reference,
> but perhaps you can explain it away - worth changing the comment if so.
> 
> I was also anxious to work out whether PG_private with PG_private_2
> would mean +1 or +2: I don't think I found any decisive statement,
> but traditional use of page_has_private() implied +1; and I expect
> there's no filesystem which actually could have both on the same folio.

I think it's "+1", like we used to have.

I was seriously confused when discovering (iow, concerned about false 
positives):

	PG_fscache = PG_private_2,

But in the end PG_fscache is only used in comments and e.g., 
__fscache_clear_page_bits() calls folio_end_private_2(). So both are 
really just aliases.

[Either PG_fscache should be dropped and referred to as PG_private_2, or 
PG_private_2 should be dropped and PG_fscache used instead. It's even 
inconsistently used in that fscache. file.

Or both should be dropped, of course, once we can actually get rid of it 
...]

So PG_private_2 should not be used for any other purpose.

folio_start_private_2() / folio_end_private_2() indeed pair the flag 
with a reference. There are no other callers that would set/clear the 
flag without involving a reference.

The usage of private_2 is declared deprecated all over the place. So the 
question is if we really still care.

The ceph usage is guarded by CONFIG_CEPH_FSCACHE, the NFS one by 
NFS_FSCACHE, nothing really seems to prevent it from getting configured 
in easily.

Now, one problem would be if migration / splitting / ... code where we 
use folio_expected_ref_count() cannot deal with that additional 
reference properly, in which case this patch would indeed cause harm.

If all folio_expected_ref_count() callers can deal with updating that 
reference, all good.

nfs_migrate_folio(), for example, has folio_test_private_2() handling in 
there (just wait until it is gone). ceph handles it during 
ceph_writepages_start(), but uses ordinary filemap_migrate_folio.

Long story short: this patch is problematic if one 
folio_expected_ref_count() users is not aware of how to handle that 
additional reference.

-- 
Cheers

David / dhildenb


