Return-Path: <linux-kernel+bounces-860416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F3CD5BF0164
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 11:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 59A2C4EF938
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 09:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04F52EC54B;
	Mon, 20 Oct 2025 09:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IClDiT7N"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7251B87C0
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 09:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760951195; cv=none; b=GV8XyRqzBDMrFEUZUHfxqhhYj0FOyUp41IOLKPAbBPHnGHeq6+4QF5upIwLKoUd5p/mqe9gMpS5HhZKspjb7yVg8TUFrJcXS2e99Tg8mcgqfdH9L5H2idxCDEqEVj7RJTv6NTgCAkgHyeC+rwWCLtgP8arzdfMFg0HjTHlJ6tjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760951195; c=relaxed/simple;
	bh=iDbh/4t4VFq+SdOajG9kmCfpz2IttDMrfYxcIV0JM3c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I2GYDLmFeUX1Isu4MhPorflT/hdbZfRra50dn98wDsSyalwDRPKMyuBkJk6BC1XWZTrYY77ZMSNoxdLBf961X1DlwKo2+1DEHM0h5AtuaaEAK3+XwDdgUXzrmmFXi0tad75eYacQOGnd9uvIzpX22odedim3XXQPjzkEZULDSUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IClDiT7N; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760951192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0F0AcL+GNjta110vk2zK9kFi7gPz9YyNmnqr5mUKiFY=;
	b=IClDiT7NV5WtyEyXr102ZyST1IsN7IzVCFDmFTVB7QWIMpR3A5WmPDfY0gmnTUBeRe3Peq
	s1tepopShhoFIErQx8JOtLIixSC7bwsj6RtKzHhlPJBwAASBkkW2s5SL4J2f6xiGs+OvGM
	eza/y2R9pwazAFHsUe4VmqBmKg7+XYA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-J-0XBAEdMp6rLflk6ux6ew-1; Mon, 20 Oct 2025 05:06:30 -0400
X-MC-Unique: J-0XBAEdMp6rLflk6ux6ew-1
X-Mimecast-MFC-AGG-ID: J-0XBAEdMp6rLflk6ux6ew_1760951189
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-47111dc7c5dso22492975e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 02:06:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760951189; x=1761555989;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0F0AcL+GNjta110vk2zK9kFi7gPz9YyNmnqr5mUKiFY=;
        b=ow4ZnjeCLu6JzyqftTZY6uBl9gTkckVqom8g9AAo23750YvYRgvwFpyQOeJsPvTQA9
         bhUuGfwSFuGbnPNL78TyqqczAqoU8IYvpMVzC0X9hH9CV4cAPQCPeryIR/6mduEoT++e
         4ht1FAgzv38lS7BdfcB5RchAJX088LGfJRNDOqmvx/83AytCrcKAAIa3Uyzl+NfmaC36
         L47ur3mobHitgRt0uVCLH1b2+fE2dvDwDGgnhm0wN7I3DwcyVQKcaF3gg9ok/M9ZwO60
         qok1kLeb4EUYdQRayyfEvbk79oDf2YF+ExdBkxEjSIKElRDjFxYcGswO6rXihQhQL3hh
         +L4A==
X-Forwarded-Encrypted: i=1; AJvYcCV9wYJp3tXz/kO9Nvy0v43ZRVEMFNkZkxteGcxGif2zsle8aby5kNMYp+Z9nYptvcGe812k0OZweW9t1ZY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8hq++kA9u1gqdE/Wfvrsu5e5ppu7jQZxI5WhobxIPvq4e8+y7
	Ig/pFHt/tXMXe7fGmBfS2yn/eUbhds80RQ8SiFJqdJgC4tSw58nUXSXtzR+iYCV8Ga+9Tg8HEXw
	7r47KnVyX0zbTO3Y4BbTroWm4yNAv4vYqp0U0XCA3lh38pzxGBPGjfwDgx9Eh+FhBXw==
X-Gm-Gg: ASbGncsG2qal/SJqV77FzUcdxxx3LVjIyCR+iSMjkLKS3xWV2+g7lgPl8pifIC60cYT
	BN+Mr3lmi3f52YxgG6uQQbckp2QjPvJbamTMEE7x0KdSxVMM3qcKe1j0SxW4ot3d5zDaqDLOF2T
	Uf8Rl39mpX/rGhZ6LfTOdnQMfgUNeexR/MfIDwozeOta76bWyXxv0yYp7HxYJN6YwVvu6kGzKoT
	BI0CaskzD37kb4l7PsNhLp0K0wXHhbqnWFy96Zfs2+2g9Y6gCetECANaGUBbarl54Bnwn4RcGE1
	2sd9yHRsp4vg6K+Vr4z+QQICOq7qfXzBnzm6KylSa+zgXeWD9wLDIaOvuu5cryH+Ftk7vnRZstS
	TgbWcdhFEmPqtsQSmsHWRdc7ybOIPSMiDx1caimTbv4UmC7GOq4CWmsK6hRZMVvrVFJLIxgQSIk
	qA3Zs5OFwfU2K8FUjYjGOD/pvtxFc=
X-Received: by 2002:a05:600c:8284:b0:46e:5302:7751 with SMTP id 5b1f17b1804b1-4711726487cmr96469395e9.9.1760951189320;
        Mon, 20 Oct 2025 02:06:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9h56vHiACaFnw/WwPIBJz7YodPPKQckecz4ERg6tBOQGl3/aEulaAlxiFGwpwSpHvjVLl6g==
X-Received: by 2002:a05:600c:8284:b0:46e:5302:7751 with SMTP id 5b1f17b1804b1-4711726487cmr96468965e9.9.1760951188891;
        Mon, 20 Oct 2025 02:06:28 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f0c:c200:fa4a:c4ff:1b32:21ce? (p200300d82f0cc200fa4ac4ff1b3221ce.dip0.t-ipconnect.de. [2003:d8:2f0c:c200:fa4a:c4ff:1b32:21ce])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4710e8037aasm113630195e9.2.2025.10.20.02.06.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 02:06:28 -0700 (PDT)
Message-ID: <553ccfd0-a931-4f2f-98d3-702e8fccff32@redhat.com>
Date: Mon, 20 Oct 2025 11:06:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] mm: treewide: make get_free_pages() and return void *
To: Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Brendan Jackman <jackmanb@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 Julia Lawall <Julia.Lawall@inria.fr>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Michal Hocko
 <mhocko@suse.com>, Suren Baghdasaryan <surenb@google.com>,
 Zi Yan <ziy@nvidia.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Al Viro <viro@ZenIV.linux.org.uk>
References: <20251018093002.3660549-1-rppt@kernel.org>
 <aPQxN7-FeFB6vTuv@casper.infradead.org> <aPT0zNMZqt89cIXH@kernel.org>
 <3301af1f-c24a-4e43-ad59-402e244d5552@suse.cz>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <3301af1f-c24a-4e43-ad59-402e244d5552@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20.10.25 10:54, Vlastimil Babka wrote:
> On 10/19/25 16:25, Mike Rapoport wrote:
>> On Sun, Oct 19, 2025 at 01:30:47AM +0100, Matthew Wilcox wrote:
>>> On Sat, Oct 18, 2025 at 12:29:59PM +0300, Mike Rapoport wrote:
>>>> Vast majority of allocations that use get_free_pages() and its derivatives
>>>> cast the returned unsigned long to a pointer and then cast it back to
>>>> unsigned long when freeing the memory.
>>>>
>>>> These castings are useless and only obfuscate the code.
>>>>
>>>> Make get_free_pages() and friends return 'void *' and free_pages() accept
>>>> 'void *' as its address parameter.
>>>
>>> No.  Linus has rejected this change before.  I can't find it now, it was
>>> a long time ago.
> 
> Here's a lore link
> https://lore.kernel.org/all/CA+55aFwp4iy4rtX2gE2WjBGFL=NxMVnoFeHqYa2j1dYOMMGqxg@mail.gmail.com/

You beat me to it :)

[...]

>>> Most of them shouldn't be using get_free_pages() at all, they should be
>>> using kmalloc().
> 
> Changing to kmalloc() would have to be careful, what if the callers rely on
> doing e.g. get_page() later. It would however be useful to dintinguish "I
> want a page-sized buffer" (note that it's guaranteed to be aligned by
> kmalloc() these days, which it wasn't in 2015) from "I really want a page".
> But many of the latter cases maybe want a struct page then and are using
> alloc_pages()?

I agree. I guess whoever wants a "struct page" (e.g., to use a different 
memdesc later) should be asking for a page in the first place, not 
something that will be slab-typed right from the start.

>> Don't know if most but some of them could. Still, we'd have a bunch of
>> get_free_pages() users with needless castings.
>> And converting callers that should use kmalloc() is a long and tedious
>> process, while here we get an API improvement in a single automated change.
> Maybe a more feasible way would be to rename to something more coherent,
> while keeping the old interfaces alive for a while for easier backporting.
> because __get_free_pages() / free_pages() is not really great naming.
> If possible it would be nice to also make __GFP_COMP implicit in the new API.

Agreed to all. But we will have to be a bit careful with __GFP_COMP.

-- 
Cheers

David / dhildenb


