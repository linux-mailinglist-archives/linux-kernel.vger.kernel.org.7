Return-Path: <linux-kernel+bounces-868295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCD8C04CFA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 09:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC8D61AA1FC1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 07:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304D02F1FE6;
	Fri, 24 Oct 2025 07:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C7PgXgZI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC722ECD33
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 07:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761291823; cv=none; b=I/6pH3bs5OQWHkNSe5IR+0FsG35FvHDHQ1Wk+OVUQXQ/7fWj8B0zLLWTnTvWgumNI3uhVwPNbppCugdOX9icjzdedSudBeWXYm1RDDCxiGZkRCxo05f9E/cVT9wUCu6iojArq/bV3c3S2BgZROkPkQWI5PwI/plnkh7dFamBbSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761291823; c=relaxed/simple;
	bh=RPSEvxeK8W2qEMwlGfeFhP4NAWGF2FELvFTl0EMRVSw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lWPmYyDH+LEkFTtXCHyZEnd/mKPhtbbpxkJX+4WePaKOyHUtWdKu3ma9aPXxdumKPr9hzFnrBRifgBHXnTfGs+JFgJFlIdPQBY8wxnxEC/8Bjq01prauXwg57Zxki58S1K2H7Gtl/N+tGYpyK+2iHjOc16Gwteb+AanrohRzzlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C7PgXgZI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761291820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ygtMJr7lCz2zBOJcy/xlUwclo5GLonX1M9l6w+G0o/Y=;
	b=C7PgXgZI2oEFcga0SpnaZ2U+6C02qEiTojfXiRXJ8puoR2JyAn00Jv4KgFpIxhbg6ZQ8pa
	XHlKo67yCboqU/UGghKkfqMDyxkIa5okasOx/6MrTbntBcMa2WKDMJoY0sIZxRbAaufqOH
	IQUcwVzTcdVRCCKO485+LcPwWqCYIOU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-8EV_G-JAMzC_PG4oAcjelA-1; Fri, 24 Oct 2025 03:43:37 -0400
X-MC-Unique: 8EV_G-JAMzC_PG4oAcjelA-1
X-Mimecast-MFC-AGG-ID: 8EV_G-JAMzC_PG4oAcjelA_1761291808
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-428567f67c5so1083642f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 00:43:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761291808; x=1761896608;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ygtMJr7lCz2zBOJcy/xlUwclo5GLonX1M9l6w+G0o/Y=;
        b=XFpFO0jrnqD6QOyESqrrh5OX39mQRZZJppt4agoXscd7ulUqgMCz4LgbQdYkiYIY8+
         XIxYAjFwsVIl1gjbTi9LrXZUZJnJ/W04KiZ267uv5Rq15KCnNMLBmTH8t+/FKrDkA18M
         SIdicIUrR6JVyczPWGAB2JClxqlZXERxyYc1USDnOSjvFCUly9lqA2a1CZdfiHw/6jHA
         A+2Geh3qK6xq6sokm7R9B4PEl6trYtp0PhSaz4S6xd/+CfKRn+kiyUy/WqUwA998U+ym
         e2MTzNu12ZNczxWaHi9ob5iCrFaeBdKuOJLD32VekjPQjOw+7dOwQ/fEpcbSsk9erM98
         QPww==
X-Forwarded-Encrypted: i=1; AJvYcCUMMvtzqKveNBxLnoz+grKEDPhvssdBB+SKeojAyetATpMbd7FbMDE5Y2A9vBQv4f6JQ1h/ZgxwPwP1fMI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJHXBnOybKbfipel2eajJfCyGLgLyR8WVd34xsrraCEh+lWijs
	WyMaeJuYGIWCljVEW3Gpz19zQSjnQBooIQMhh6dwRTqgktfB5LZ5lobjYmtz3K08jOEWL8712DY
	GUYb9xjs7UOFOmc7rKlfQ8fu9mnxoGRyt9jPPt/vA+OX6cyQgx/aLJe+Htpn+Knlb7g==
X-Gm-Gg: ASbGncsF3AYiMogCWe1yuEbD1Kn8he6K/l+T7Khs2xNj2xIII/nuzyCIql3Q3B6Btnd
	TKAQhGJyVGBve0JBAnWgHGfr9EZJwWe6rdorXUyeC53YX7z8Xxg2Nd1yA3r8OOLKg80CHOIsipe
	IN1jOmmAlHi6FWaK+ABE3cElKEOcDcGgxOPBmZrADF8vl6IqXOUT12CQfDkKx+IrPO9WorCMsUV
	YggmH+mqIsVQ3p7srs1b/TFOGZ36a3EwjYNBlaEWkgtnGPgIVKOrZYpS6HY01idLGxB0h8p5dWG
	06nFK+zgafhOo4PeV7DmdJcbfofOkSOuFAySr0eVgPVAkTxhtoI/3yORjK4y5GGbLbG6gFN8cqr
	STZfyDf4Oc+Skx3S+Omt9PgfTgySEvYq0CT53DKmtnW+7LQ2oun2r1KrZOrDJMOXl3lLSVI6W2a
	leIVDx5mqlTPfQyrobpdr41Ipj3dk=
X-Received: by 2002:a05:6000:1445:b0:429:8d0f:e91 with SMTP id ffacd0b85a97d-4298d0f101fmr2145804f8f.3.1761291808147;
        Fri, 24 Oct 2025 00:43:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuzdzaDgFKtnHrcm/Lod7mOzyuAWHQUr2N7K0uuanDY4JiUSZCT2EploISrXTL5ZI5AMbDFw==
X-Received: by 2002:a05:6000:1445:b0:429:8d0f:e91 with SMTP id ffacd0b85a97d-4298d0f101fmr2145765f8f.3.1761291807710;
        Fri, 24 Oct 2025 00:43:27 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3? (p200300d82f4e3200c99da38b3f3ad4b3.dip0.t-ipconnect.de. [2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429898adda1sm7943559f8f.29.2025.10.24.00.43.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Oct 2025 00:43:27 -0700 (PDT)
Message-ID: <9c1450ba-ade4-4236-8d3e-c5658a3a26c3@redhat.com>
Date: Fri, 24 Oct 2025 09:43:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC, PATCH 0/2] Large folios vs. SIGBUS semantics
To: Dave Chinner <david@fromorbit.com>, Andreas Dilger <adilger@dilger.ca>
Cc: Kiryl Shutsemau <kirill@shutemov.name>,
 Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>,
 Matthew Wilcox <willy@infradead.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Shakeel Butt <shakeel.butt@linux.dev>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Darrick J. Wong" <djwong@kernel.org>, linux-mm <linux-mm@kvack.org>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251020163054.1063646-1-kirill@shutemov.name>
 <aPbFgnW1ewPzpBGz@dread.disaster.area>
 <d7s4dpxtfwf2kdp4zd7szy22lxrhdjilxrsrtpm7ckzsnosdmo@bq43jwx7omq3>
 <aPoTw1qaEhU5CYmI@dread.disaster.area>
 <AF891D9F-C006-411C-BC4C-3787622AB189@dilger.ca>
 <aPshzHsqp2Srau5T@dread.disaster.area>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <aPshzHsqp2Srau5T@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24.10.25 08:50, Dave Chinner wrote:
> On Thu, Oct 23, 2025 at 09:48:58AM -0600, Andreas Dilger wrote:
>>> On Oct 23, 2025, at 5:38 AM, Dave Chinner <david@fromorbit.com> wrote:
>>> On Tue, Oct 21, 2025 at 07:16:26AM +0100, Kiryl Shutsemau wrote:
>>>> On Tue, Oct 21, 2025 at 10:28:02AM +1100, Dave Chinner wrote:
>>>>> In critical paths like truncate, correctness and safety come first.
>>>>> Performance is only a secondary consideration.  The overlap of
>>>>> mmap() and truncate() is an area where we have had many, many bugs
>>>>> and, at minimum, the current POSIX behaviour largely shields us from
>>>>> serious stale data exposure events when those bugs (inevitably)
>>>>> occur.
>>>>
>>>> How do you prevent writes via GUP racing with truncate()?
>>>>
>>>> Something like this:
>>>>
>>>> 	CPU0				CPU1
>>>> fd = open("file")
>>>> p = mmap(fd)
>>>> whatever_syscall(p)
>>>>   get_user_pages(p, &page)
>>>>   				truncate("file");
>>>>   <write to page>
>>>>   put_page(page);
>>>
>>> Forget about truncate, go look at the comment above
>>> writable_file_mapping_allowed() about using GUP this way.
>>>
>>> i.e. file-backed mmap/GUP is a known broken anti-pattern. We've
>>> spent the past 15+ years telling people that it is unfixably broken
>>> and they will crash their kernel or corrupt there data if they do
>>> this.
>>>
>>> This is not supported functionality because real world production
>>> use ends up exposing problems with sync and background writeback
>>> races, truncate races, fallocate() races, writes into holes, writes
>>> into preallocated regions, writes over shared extents that require
>>> copy-on-write, etc, etc, ad nausiem.
>>>
>>> If anyone is using filebacked mappings like this, then when it
>>> breaks they get to keep all the broken pieces to themselves.
>>
>> Should ftruncate("file") return ETXTBUSY in this case, so that users
>> and applications know this doesn't work/isn't safe?
> 
> No, it is better to block waiting for the GUP to release the
> reference (see below), but the general problem is that we cannot
> reliably discriminate GUP references from other page cache based
> references just by looking at the folio resident in the page cache.

Right. folio_maybe_dma_pinned() can have false positives for small 
folios, but also temporarily for large folios (speculative pins from 
GUP-fast).

In the future it might get more reliable at least for small folios when 
we are able to have a dedicated pincount.

(there is still the issue that some mechanisms that should be using 
pin_user_pages() are still using get_user_pages())

> 
> However, when FSDAX is being used, trucate does, in fact, block
> waiting for GUP references to be release. fsdax does not use page
> references to track in use pages - the filesystem metadata tracks
> allocated and free pages, not the mm/ subsystem. There are no
> page cache references to the pages, because there is no page
> cache. Hence we can use the difference between the map count and the
> reference count to determine if there are any references we cannot
> forcibly unmap (e.g. GUP) just by looking at the backing store folio
> state.

We can do the same for other folios as well. See folio_expected_ref_count().

Unexpected references can be from GUP, lru caches or other temporary 
ones from page migration etc.

As we document for folio_expected_ref_count() it's racy for mapped 
folios, though: "Calling this function on a mapped folio will not result 
in a stable result, because nothing stops additional page table mappings 
from coming (e.g.,fork()) or going (e.g., munmap())."

It only works reliably on unmapped folios when holding the folio lock.


-- 
Cheers

David / dhildenb


