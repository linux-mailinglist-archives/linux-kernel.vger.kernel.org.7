Return-Path: <linux-kernel+bounces-806101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D90B491E4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 16:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 436DF16271D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 14:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9523F2E7BA7;
	Mon,  8 Sep 2025 14:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L6YMuCRu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2AB259C9A
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 14:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757342372; cv=none; b=OMCoocAll59paC1sJcBjnHDPHfEtKOMsY64eC+Z1eNBRuv8yH0jOqStSpesgHExOo//hILI2IqCLNbFVSaPuiJBDwJ85vbJimbTFyCUgsrYnUpkJIaxopZ4sgDTmIx7cZdYlS9ldoEq/nW45vmWnWWyNbwSy2IKZCX1/8iJ9Nk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757342372; c=relaxed/simple;
	bh=HF9KcOUQumIo0EqBE8ioYikDa/jQMZfSkGLVFS9PM3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tPjtTiKt/avXhKyBftHpyfy9zlkPXeB+8lNLa0An82mmgVQZ0C8od7Ya2zbSM/Q0tgkos7KtIuWNgbMimaK+qDZJYslwaEFVCKN9vao2z/aJmyG37sXqcJLa/w3wCEXQ7/IL7oAlxpJVxZ0nmFifOxmb0njjXU1nbgjdT1V90Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L6YMuCRu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757342370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=eRKrbV6N+yXcBvX5Xr1RCzbreOC0YbswLK/9bZDg2dI=;
	b=L6YMuCRuz/102TUUq+RAUDXjCWGPn5HyJq2oAtGQLUYhyYi1Rm4qQb4ETaN/slnibLeTAp
	Fm1r0aZwcuYAH+xcPxqIgkrnM2A9xKlAnA2qLp9hTAf84NFUIAXqLEfju1Piji7drncrPJ
	RI3CKifq556l8YNWp4N+XjueLbm5PL4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-sBnYId5WMqetkdCz4sogwg-1; Mon, 08 Sep 2025 10:39:28 -0400
X-MC-Unique: sBnYId5WMqetkdCz4sogwg-1
X-Mimecast-MFC-AGG-ID: sBnYId5WMqetkdCz4sogwg_1757342367
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3e40057d90aso1573902f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 07:39:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757342367; x=1757947167;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eRKrbV6N+yXcBvX5Xr1RCzbreOC0YbswLK/9bZDg2dI=;
        b=mwbUjh0Jc7RoEg9yXEeHa7SbWlTj6q2vwItE+D0i0n8Qp2aK41TQzy8ZT5Rbr/dqk8
         iTRuJvMjGAF0UMPZXB98YeW2fFPbTtlmDsJgutG4dWXncOEMBWjM07emZ+ZqgPohO3S+
         ihyYtEF8BRqEIcP9TVgja7GAwm/ZzPKL0dBzkrG7f9Fai4BIhq0gqRwZSqBzPGMP0y5E
         7RXa2zQlYlOSK2EWVbV1LDDoM0IiOw4jYf5byQBm4/7nG6wtEQ0hfsjHXQ4etH239RVI
         JybxX5Kficw61+e2SvMT5jnqKNuxhXeuIO8wBerNp0vQE962yfH29njOb4S7EKZg2Tgj
         2kGg==
X-Forwarded-Encrypted: i=1; AJvYcCWssKPVm2/Eld0Yt2Tsh9i88HVoKXPTst4N259LkGVpWFYzsjOo4zsJQooGMbsGOMXhwblCgPocynhqTEg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhxVC1elkvzEdX0Qv9OIKMlvo1hcoSNGcubtHwyxMy6sWbNv0Q
	x3QamNh8VUDb7ZzQVtYX2UIUzb4e5bgKe/U4LvXu+vu2D9zM+WP88gJBSTQJfgdg0XyYIe17c3h
	0gRSKSr55jufgbH06sYxG4UOvdaMReUlKLKb34oQQdPShi9Gm2E5gvGnWPoCHqrQzVw==
X-Gm-Gg: ASbGncu1ZzASw7jVGAgBOUy8oNPmrqYyN3BxYClI8I7qbOkSZ5mQqvzjZEEo4hPPLTe
	dlUu0doHNhnThdIzVbOMDpw8+9FTP8qBoTQhc5x1LZ5xFaNhupVuVvyySsRi3FoC+DUEYGowJzd
	ncNwTms2qrTimIgf3groOiv6b0uBb07d0/DkN0EB4cYFBSQUyZd23VECQBqq9gyqHrnyDa/TCVz
	N/sIUbz/KxxXzHn2fNk1KePXGJElg4dThqhyBLFpPDeFlLuMZS/+hFIHW5O4bepF1eNpMJ0MP+Q
	dgBPSg5VRE4ioOmEuy85Qr6mrClsxy3mCzik4Cr7T/dEeaigIH2ubVXwfg2At4j96yXpXnGBufm
	kA8Qb/3zPwQ7Izo1rDpraaVJSO647Ca6OCBerhVTLNy9PZCDlonDxg9Hfs4SZ5XpL
X-Received: by 2002:a05:6000:2003:b0:3e4:471e:3c91 with SMTP id ffacd0b85a97d-3e64ce4fd7bmr6231239f8f.63.1757342367130;
        Mon, 08 Sep 2025 07:39:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHb/kakovac8mr4rbvPDrcKOg6cfu0Yow2z3Nhfp4hslKCb3WIHrScQnsGPat9hnCS18bzntg==
X-Received: by 2002:a05:6000:2003:b0:3e4:471e:3c91 with SMTP id ffacd0b85a97d-3e64ce4fd7bmr6231197f8f.63.1757342366611;
        Mon, 08 Sep 2025 07:39:26 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f25:700:d846:15f3:6ca0:8029? (p200300d82f250700d84615f36ca08029.dip0.t-ipconnect.de. [2003:d8:2f25:700:d846:15f3:6ca0:8029])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e748171834sm4787288f8f.5.2025.09.08.07.39.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 07:39:26 -0700 (PDT)
Message-ID: <9b4808cd-3239-4bb2-8073-7eb1412c4529@redhat.com>
Date: Mon, 8 Sep 2025 16:39:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/15] mm, swap: wrap swap cache replacement with a
 helper
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>,
 Chris Li <chrisl@kernel.org>, Barry Song <baohua@kernel.org>,
 Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>,
 Kemeng Shi <shikemeng@huaweicloud.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>,
 linux-kernel@vger.kernel.org
References: <20250905191357.78298-1-ryncsn@gmail.com>
 <20250905191357.78298-11-ryncsn@gmail.com>
 <c2ff433c-35d4-45e4-bf06-e725726fa515@redhat.com>
 <CAMgjq7AsYz+pDTCU5PWoNPN1VJ5Vx8ZLQgF6MT26JUSXr=6__A@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <CAMgjq7AsYz+pDTCU5PWoNPN1VJ5Vx8ZLQgF6MT26JUSXr=6__A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 08.09.25 16:20, Kairui Song wrote:
> On Mon, Sep 8, 2025 at 8:35 PM David Hildenbrand <david@redhat.com> wrote:
>>
>>
>>>
>>> +/**
>>> + * __swap_cache_replace_folio - Replace a folio in the swap cache.
>>> + * @mapping: Swap mapping address space.
>>> + * @entry: The first swap entry that the new folio corresponds to.
>>> + * @old: The old folio to be replaced.
>>> + * @new: The new folio.
>>> + *
>>> + * Replace a existing folio in the swap cache with a new folio.
>>> + *
>>> + * Context: Caller must ensure both folios are locked, and lock the
>>> + * swap address_space that holds the entries to be replaced.
>>> + */
>>> +void __swap_cache_replace_folio(struct address_space *mapping,
>>> +                             swp_entry_t entry,
>>> +                             struct folio *old, struct folio *new)
>>
>> Can't we just use "new->swap.val" directly and avoid passing in the
>> entry, documenting that new->swap.val must be setup properly in advance?
> 
> Thanks for the suggestion.
> 
> I was thinking about the opposite. I think maybe it's better that the
> caller never sets the new folio's entry value, so folio->swap is always
> modified in mm/swap_state.c, and let __swap_cache_replace_folio set
> new->swap, to make it easier to track the folio->swap
> usage.
> 
> This can be done easily for migration and shmem parts, the huge split
> code will need a bit more cleanup.

Right, but it's probably worth it.

> 
> It's a trivial change I think. But letting __swap_cache_replace_folio
> setup new's swap and flags may deduplicate some code. So I thought
> maybe this can be better cleaned up later. So for now I just add a
> debug check here that `entry == new->swap`.
> 
> And the debug check does imply that we can just drop the entry params
> in this patch, there will be no feature change.

Well, the current API as you introduce it here is confusing, as it's not 
clear who is supposed to initialize what.

So better to it cleanly right from the start.

> 
>> Similarly, can't we obtain "mapping" from new?
> 
> This is doable. But this patch is only an intermediate patch, next
> commit will let the pass in ci instead. Of course the `ci` can be
> retrieved from `entry` directly too, but it's the caller's
> responsibility to lock the `ci`, so passing in a locked ci explicitly
> might be more intuitive? Also might save a tiny bit of CPU time from
> recalculating and load the `ci`.

Well, no other swap_cache_* functions consumes an address space, right?

-- 
Cheers

David / dhildenb


