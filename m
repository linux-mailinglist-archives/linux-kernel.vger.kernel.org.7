Return-Path: <linux-kernel+bounces-839916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F0B1BB2B98
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 09:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03DF7164D8C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 07:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA6B18B0F;
	Thu,  2 Oct 2025 07:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RUOD2yIr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4F0169AD2
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 07:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759391146; cv=none; b=Gr0yPWst7EDGDHuhdB96AHr/mBB1vaQPVn9hw90/GLkrMFR/StBO4diyHdbVXN6nV8CTJIscSkJPOgzGh1Z9Oq74Wu4oLsLEb5GbVfSMybTGbLE1uH4gZpKikx2toTORCBD1fVqOmgqepgQIKymFBMrLcgWitI7MW7177jIjbP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759391146; c=relaxed/simple;
	bh=nHBX/wZLutz9dbY9hPcdh5UfDZj4Rw1LGxu4ix6i1ts=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ohpFUGYouURxt2BbDNC+jGygBOOEf2EuX1/vJI3GeGVXhVaNWf5/I+wn7ufYoYSePCIRC6zSOCV6DcxQhdFDt8mu9YNLBZMhQ/aRL2UuubqHzqh/YYhLzrxBxcWwf9QpD4EJx42M6JBSB4VAXOyg0JOSFSx8dOnzeh5KqfwyGHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RUOD2yIr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759391143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=SP/dY3VkQHLVxg99pk5ub4ghhIabgLfHHyUzpk8h1d4=;
	b=RUOD2yIrjC/SApcqdQP7jg+UHb558dTLFzN8ojpxHCDkE06kyvAz7LwLGvAY536lzqowu+
	JV+NdnSE/eiFf6i9e/t8tUFuuKs8CMeu8vXEGUZhKjOKuhR0SF23BpXqNVzyNnNjqBBes9
	ICtUVfFUoNuhScg8MaELvSFsTV/wnJ8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-u_URdRW8NEGWb56GrUWKwQ-1; Thu, 02 Oct 2025 03:45:42 -0400
X-MC-Unique: u_URdRW8NEGWb56GrUWKwQ-1
X-Mimecast-MFC-AGG-ID: u_URdRW8NEGWb56GrUWKwQ_1759391141
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-46e375dab7dso2432235e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 00:45:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759391141; x=1759995941;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SP/dY3VkQHLVxg99pk5ub4ghhIabgLfHHyUzpk8h1d4=;
        b=XkFl5fgkSL/n3dnZUyrLzjOWWs+0GQMsnnNKtHgh0/peLg/vxSPkWeJw2TCYuZLATy
         bd104jNLMYlmh+PDlLFueLxi/FW+R5IXtfolDKv3mHmhzAQJxIIwqliv2GPwLwQNesiq
         7bSP4h+HrfysbzyzBnmJ6CTgpIY3Q4l97A9BargBicIiGJ8yQRgt0MlgP9nX6qPxnzbk
         sJs8yLP1FoG5CIsIYj8DY61M+Powte9Bzvzx0dsG+ecfoSFo/fV7jWoK0t/LPT10ZdfO
         dITGD2w4mDOhhqDtEyhkToWWRLvUwq3kFgnBNOOUIq4d/OjDiNrkXUAsgQ9dH3jUlYD2
         sNgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYbgO5ihdZPhGnppHryTYVj3Zbg5nrN3teX7xnChORHdGlPUUWnQPoSmWTamC4J4Bh7qi3J0b5g1KyQX4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt4Zx314r5qJmyAP554RXsnhEZhghg5aFqrrN/cY3lz1cxPkiz
	2IyphPSgV4/bgEjBvAX75wHo20SKXRTuNcBTph3qKJ3A2/cu5mFU8fVo0y+5u0cW2/Kfn7lxrP5
	WChCYnFjr4J+I3h0cESLbCGruEti1r0m/SXR4JDPU48b7x6olbTBld78rwzQu0coq0g==
X-Gm-Gg: ASbGnctH22PzSAYM6kuZNepKWKmSAIjfIxTBT7UwU3Gf1bkCGKhII3ej7xIwnq+t8rW
	pdmO6b3ydf/LfqfJn1L7HLA0Ni5TrGw6rHlykzMaY/SIPDLpLI2y988+NbuGizI7+hRcTyBa9jg
	x1DsdBhqIAM0AKP/L1XeD0W6iWXNik3qE7asqih4NcV87TU4SnOSl7boaJmKC5TjnOTg5uEZGCl
	gQjr4hNNEmqF6uZqWNjSPRwHD9LiMvTLdWQAxjyKHtghy3QBbBP11/mXxoqBxrkwOzko4stYypr
	FkLDC6fH66vx69m4HmwsW5qBCEgx3ZSVm+4GxnoySD4OMDbLz4a8zz5rsiQj5AFMnSi8YoIrXlw
	IECSiCDQm
X-Received: by 2002:a05:600c:8889:10b0:46e:67c8:729f with SMTP id 5b1f17b1804b1-46e67c879a8mr16420525e9.7.1759391141409;
        Thu, 02 Oct 2025 00:45:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtg0CUJ7svXVqUDtw0OZIK/6abcmBaw177Cf33RxxgmXLfoTe+SvEZlnZfZl5+aJi+r0Tu6Q==
X-Received: by 2002:a05:600c:8889:10b0:46e:67c8:729f with SMTP id 5b1f17b1804b1-46e67c879a8mr16420215e9.7.1759391140974;
        Thu, 02 Oct 2025 00:45:40 -0700 (PDT)
Received: from [192.168.3.141] (tmo-080-144.customers.d1-online.com. [80.187.80.144])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e675c67f7sm21440265e9.2.2025.10.02.00.45.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Oct 2025 00:45:40 -0700 (PDT)
Message-ID: <44082771-a35b-4e8d-b08a-bd8cd340c9f2@redhat.com>
Date: Thu, 2 Oct 2025 09:45:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Discuss] First steps for ASI (ASI is fast again)
To: Brendan Jackman <jackmanb@google.com>, peterz@infradead.org,
 bp@alien8.de, dave.hansen@linux.intel.com, mingo@redhat.com,
 tglx@linutronix.de
Cc: akpm@linux-foundation.org, derkling@google.com, junaids@google.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, reijiw@google.com,
 rientjes@google.com, rppt@kernel.org, vbabka@suse.cz, x86@kernel.org,
 yosry.ahmed@linux.dev, Patrick Roy <roypat@amazon.co.uk>,
 Zi Yan <ziy@nvidia.com>
References: <20250812173109.295750-1-jackmanb@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250812173109.295750-1-jackmanb@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> I won't re-hash the details of the problem here (see [1]) but in short: file
> pages aren't mapped into the physmap as seen from ASI's restricted address space.
> This causes a major overhead when e.g. read()ing files. The solution we've
> always envisaged (and which I very hastily tried to describe at LSF/MM/BPF this
> year) was to simply stop read() etc from touching the physmap.
> 
> This is achieved in this prototype by a mechanism that I've called the "ephmap".
> The ephmap is a special region of the kernel address space that is local to the
> mm (much like the "proclocal" idea from 2019 [2]). Users of the ephmap API can
> allocate a subregion of this, and provide pages that get mapped into their
> subregion. These subregions are CPU-local. This means that it's cheap to tear
> these mappings down, so they can be removed immediately after use (eph =
> "ephemeral"), eliminating the need for complex/costly tracking data structures.
> 
> (You might notice the ephmap is extremely similar to kmap_local_page() - see the
> commit that introduces it ("x86: mm: Introduce the ephmap") for discussion).
> 
> The ephmap can then be used for accessing file pages. It's also a generic
> mechanism for accessing sensitive data, for example it could be used for
> zeroing sensitive pages, or if necessary for copy-on-write of user pages.
> 

At some point we discussed on how to make secretmem pages movable so we 
end up having less unmovable pages in the system.

Secretmem pages have their directmap removed once allocated, and 
restored once free (truncated from the page cache).

In order to migrate them we would have to temporarily map them, and we 
obviously don't want to temporarily map them into the directmap.

Maybe the ephmap could be user for that use case, too.

Another, similar use case, would be guest_memfd with a similar approach 
that secretmem took: removing the direct map. While guest_memfd does not 
support page migration yet, there are some prototypes that allow 
migrating pages for non-CoCo (IOW: ordinary) VMs.

Maybe using the ephmap could be used here too.


I guess an interesting question would be: which MM to use when we are 
migrating a page out of random context: memory offlining, page 
compaction, memory-failure, alloc_contig_pages, ...

[...]

> 
> Despite my title these numbers are kinda disappointing to be honest, it's not
> where I wanted to be by now,

"ASI is faster again" :)

> but it's still an order-of-magnitude better than
> where we were for native FIO a few months ago. I believe almost all of this
> remaining slowdown is due to unnecessary ASI exits, the key areas being:
> 
> - On every context_switch(). Google's internal implementation has fixed this (we
>    only really need it when switching mms).
> 
> - Whenever zeroing sensitive pages from the allocator. This could potentially be
>    solved with the ephmap but requires a bit of care to avoid opening CPU attack
>    windows.
> 
> - In copy-on-write for user pages. The ephmap could also help here but the
>    current implementation doesn't support it (it only allows one allocation at a
>    time per context).
> 

But only the first point would actually be relevant for the FIO 
benchmark I assume, right?

So how confident are you that this is really going to be solvable. Or to 
ask from another angle: long-term how much slowdown do you expect and 
target?

-- 
Cheers

David / dhildenb


