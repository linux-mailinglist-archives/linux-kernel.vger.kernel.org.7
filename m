Return-Path: <linux-kernel+bounces-745006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 911D8B113A6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 00:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFF1517FCB2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 22:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC0D23F412;
	Thu, 24 Jul 2025 22:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TU0y+bez"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E117F23C50F
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 22:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753395183; cv=none; b=HxQOFmX9QQSAw5ZJdeQH6eBKm0hluAB8iknkl8x00NiACyFcjQkJqRVt7PwnwcUpXIHX4l43YfR2Bfx8cfQuM+cHMOzq4oG2uwaZCteZMTXezmV66eMcoO7MdTgL6oSlHlCvJeUiV5Thg0F2wlWzIVvHxLVaB77DaNQQnrSsv+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753395183; c=relaxed/simple;
	bh=oFaDOiVa3yndTWw+SP8OToGtwqwueGtR4TOp+whoG/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lLhbVImgUwbBzjbpMepLZjE0aJZ6th6n1HglMuZabz+Vfr85F9CIibo4+lpIbVvEFAIUqqzrm3YDeD8R1GbaN6q6JbzJz2Fn3oEsmhSEboq//IQsMHSWs8NhlAY9pIOgu11Xxn4NOnvNQgNp+K5rXricbcPIiNKRpP9tbOVHI/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TU0y+bez; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753395179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hQB1z3Z5kcaFoXcohwY1QQ7EgSZFnKqwqqs0iiIrZ/g=;
	b=TU0y+bezeDwejqPkmsFYY170iKdo3sEqikbms+G2PJXl5iynArYOjRYxTdtEKmJ7lorqhp
	+NJH4bw/BvAzJ/r3eQU94bM6RaIaoKuicBTWJdV4OiCiLFkdx0SnB1Aq9nkWIUVAUjFr5M
	t7vIyj07iM8tjgkqmBAuLfu5aDgjmRs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-oWORDaLEMVCuRUrs0ZRv_w-1; Thu, 24 Jul 2025 18:12:58 -0400
X-MC-Unique: oWORDaLEMVCuRUrs0ZRv_w-1
X-Mimecast-MFC-AGG-ID: oWORDaLEMVCuRUrs0ZRv_w_1753395177
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4538f375e86so11403645e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 15:12:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753395177; x=1753999977;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hQB1z3Z5kcaFoXcohwY1QQ7EgSZFnKqwqqs0iiIrZ/g=;
        b=FcUUivcsfDp/jNZG0Q9TeSbONbIf/wEqJilEFyJcnz5VuAyQcQFeNDZdmzFozxu7/G
         +Rw4D7NhRtEt8epGp8TN/e8ywzn66hyfwLmLBIDYsMj0FmIxXBA1dztqAaunYqpbrN7v
         f1vz31QUS1+Ic+OY34/0D/c+PGYpTWqVEczu/FsL28qKivXAmyRxviEjl1Pf+K+Jrruz
         1BAg14El9xg3xcoeEZPg8zjdUHHfJGRFUeZumXzQ8JJ7NxKgPfdf/ehqY7/4vD5E7/kC
         RKKDzuayOv090hQIedps7GojJn2S4dg7e839UTVLkBXzyQuregc5+BmTazRlSNBoyyNg
         LDKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhR9UqHM0GKLh1D5RpTtkaZ5R/RXn7SIMB3U0patYt4L7XLao+LHj2jIexGyZqLJq/Vb9Gm3kGEqU6gmA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaRjFaAc526FMEtEfyzJod1BzUhDVPYshrxe8NENQEF+C7rRWe
	q8jCa/Tl/vF/XAs1UbSyBfOGHuVptcVVQKlf392UI9ogXyXGSXIqMTeTZjXm4Pt95x+k0Ftlg+1
	yi9EgMGLoTatIw7pOZHSfYZWVSBoZ04Nt8pggVN5cAg5NEMFm0AQkdTZMugc9jyjmKw==
X-Gm-Gg: ASbGnctLsvUxMw6P4enV4H99niTZOyorruOCGvtIYkEEnoy8LnuI0L/1VjZNO2lVwUZ
	rceoPYytD02da5mhNokoj0OTKgtNHoWYgycZFxIQStSfErU/ARJBFMZzEC05pekqgOyPQw9m4G2
	3aq44ULN44JkSgopN95sdY6FMRt9yyGQH3iwBzrJfOE6oGJACUlgbryvfOCBxO5+Nv9cLdXE7hT
	Tt9PUvUIVsbs4R2Z3Tr+m6rcyVZC1TtjzKlhp6cckpr30CbhLqafK3DWlnqo5lrindHahWpEXTX
	Ctv37m1Ya1uKDx/BJ8XL7iEPgl0grK5XEXieXIyDOi2PhHaFZm0Xw+5gTBBbqrd1Kqvyft3jDyR
	+F6Jp8i8hY5X4rKm+FL7TqkQs/Cmk+tmo6DJw/zdp9UXyqiOk8qXwDg6OICVjDtqY4Vg=
X-Received: by 2002:a05:600c:c1d7:10b0:453:8bc7:5cbb with SMTP id 5b1f17b1804b1-45869ea2734mr42647265e9.25.1753395177215;
        Thu, 24 Jul 2025 15:12:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEROFhkwgqCWtdtoJL6+oZxLZCC7+h69SF6EW0ZZkD/1W4EzDWnn/aPK3tJVe82t2BNZ84VXg==
X-Received: by 2002:a05:600c:c1d7:10b0:453:8bc7:5cbb with SMTP id 5b1f17b1804b1-45869ea2734mr42647125e9.25.1753395176734;
        Thu, 24 Jul 2025 15:12:56 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f01:5500:ba83:3fd7:6836:62f6? (p200300d82f015500ba833fd7683662f6.dip0.t-ipconnect.de. [2003:d8:2f01:5500:ba83:3fd7:6836:62f6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458705378ffsm32532115e9.1.2025.07.24.15.12.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 15:12:55 -0700 (PDT)
Message-ID: <4f66d89a-631a-43eb-b4f9-c9a0b44caaae@redhat.com>
Date: Fri, 25 Jul 2025 00:12:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] mm/mseal: update madvise() logic
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Jeff Xu <jeffxu@chromium.org>
References: <cover.1752687069.git.lorenzo.stoakes@oracle.com>
 <ec480dc1fd4ce04bb11c0acac6c6da78dc6f4156.1752687069.git.lorenzo.stoakes@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <ec480dc1fd4ce04bb11c0acac6c6da78dc6f4156.1752687069.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16.07.25 19:38, Lorenzo Stoakes wrote:
> The madvise() logic is inexplicably performed in mm/mseal.c - this ought
> to be located in mm/madvise.c.
> 
> Additionally can_modify_vma_madv() is inconsistently named and, in
> combination with is_ro_anon(), is very confusing logic.
> 
> Put a static function in mm/madvise.c instead - can_madvise_modify() -
> that spells out exactly what's happening.  Also explicitly check for an
> anon VMA.
> 
> Also add commentary to explain what's going on.
> 
> Essentially - we disallow discarding of data in mseal()'d mappings in
> instances where the user couldn't otherwise write to that data.
> 
> Shared mappings are always backed, so no discard will actually truly
> discard the data.  Read-only anonymous and MAP_PRIVATE file-backed
> mappings are the ones we are interested in.
> 
> We make a change to the logic here to correct a mistake - we must disallow
> discard of read-only MAP_PRIVATE file-backed mappings, which previously we
> were not.
> 
> The justification for this change is to account for the case where:
> 
> 1. A MAP_PRIVATE R/W file-backed mapping is established.
> 2. The mapping is written to, which backs it with anonymous memory.
> 3. The mapping is mprotect()'d read-only.
> 4. The mapping is mseal()'d.

Thinking about this a bit (should have realized this implication 
earlier) ... assuming we have:

1. A MAP_PRIVATE R/O file-backed mapping.
2. The mapping is mseal()'d.

We only really have anon folios in there with things like (a) uprobe (b) 
debugger access (c) similarly weird FOLL_FORCE stuff.

Now, most executables/libraries are mapped that way. If someone would 
rely on MADV_DONTNEED to zap pages in there (to free up memory), that 
would get rejected.

Does something like that rely on MADV_DONTNEED working? Good question.

Checking for anon_vma in addition, ad mentioned in the other thread, 
would be a "cheap" check to rule out that there are currently anon vmas 
in there.

Well, not 100% reliable, because MADV_DONTNEED can race with page faults ...

-- 
Cheers,

David / dhildenb


