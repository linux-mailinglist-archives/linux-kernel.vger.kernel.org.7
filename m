Return-Path: <linux-kernel+bounces-789957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 375AFB39D4C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 14:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBB993BA629
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 12:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02D330F935;
	Thu, 28 Aug 2025 12:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jE8rIba6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D768930F7FD
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 12:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756384146; cv=none; b=jUUf4QtrYaFRL8Ewobe58uuP9wWaak2LmJkHwkPZkzbYn+0+pmdRw864UW//DWORAd7Cq655Rw9e0T0Du2vGJPYf32I3s8ci9fM+zeIMG35El3AFHPPzuzp5lelbHHp5TCMqdKPfKAQbPGQkMKqm5Wyq/j+ixMGEL7+/KP3cZWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756384146; c=relaxed/simple;
	bh=cER8H1ktO9pt1qbI9RhqbDZStXboUSwM5rqVQRUOqjE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q3n4qa1FUXTTvp2s7yeb/aQBEmAi5v8XSpbliCnqo5Ev/uXiRmL7vjai3ufw1Uu3OnoAndhB5cIeUo/fQIJO4UQxOkemiFWMGQFsSBVps7n29M8WU4la3Po28GJDQaYrpzCS5JVTj6Enf4lOZ88MF95vSYCi58WAETeGLqWehZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jE8rIba6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756384143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=A4aU0uEHOZFRgEo14ahRrdffnM9KY2ffZbdFZGoZwIU=;
	b=jE8rIba6KPjW/23HodOCu3H4CEVUtm7Qvhf9PlaoGESi0oaq/+CKfiJXZx231k+RcQAqnf
	ZMgTZASvszsmCu02VuqkR3eI6kHnnR61sZVp268SzQjZJKOXyKx4BQm9sc1vpe/t2qC3rh
	6FbeU4c1uNBLrkUsu2zho0kJEo2kjNo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-xopphw0JMo6no_il-4GiDQ-1; Thu, 28 Aug 2025 08:29:02 -0400
X-MC-Unique: xopphw0JMo6no_il-4GiDQ-1
X-Mimecast-MFC-AGG-ID: xopphw0JMo6no_il-4GiDQ_1756384141
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45b645707f1so3963565e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 05:29:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756384141; x=1756988941;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A4aU0uEHOZFRgEo14ahRrdffnM9KY2ffZbdFZGoZwIU=;
        b=rVThQNYU17E/gpX/0rlFvPFDuSMQaFEz6Dy2YRwrYxSNSkxDpAmOlDfHKdHujJm1bF
         cE7UuNyhhZLxFV+mxen0pDYOHBJvF+++zjCKG1/vsXbPEIK6U8VvrNfhE4/T21qcZWS/
         eCnqxXhaqT4ZFKlAi6Bg+Kht05SpKdNh16dndrIEda39i8Ghol/POJ5YAiPEp4bEPWLd
         UFZyDopVF7xNQf7I6Dz1Tz5BJwtO6clcz/u5NC+Pxqm3x61tjaLr+AbOtrBnZypM3e7a
         Eywp73klxcKmCJSrydqFR4hTAuHnfnBI2QVH7fnLE+SRuPMWVo4gUYCd6aFXLap2xSbg
         Ptfg==
X-Forwarded-Encrypted: i=1; AJvYcCXedB9DAXVFpjqWlFNKAu7qG0QhggvRVyqboFBBoHftJPIIYDdjljM3PLOLGGPzUUnfHz30eCVO25W1A1U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiVtjZ4fdqYUGs9hxFcq9msb5Rv7qfo/jFioX1wDEZy7AsYdM6
	uY8rHlRGl9lgHzRMhSJoe3Cp6GCKUgltUBJH/4eJxv1NEbMnbo8ftd3pPk1GUGlyD/e57nbNgRf
	YkaE/INeDL91BeE8o7VBqHpKRAIiyTB3+8z02kf1LHRdqb1OpSQR2T/+IVNrmglwpaw==
X-Gm-Gg: ASbGnctCYDF5gBVAqu/zNydvz1KlhocVBOX1ursPUi0OePcdbQG9vQcH3lmvr5cVT+b
	bdyY0jF1jSPzNfWuN/+PqQvPQ+vcGvy4btrEdh5PDIx0rII+qkilCbtgVuvCC5Nue3/Y8Anfidj
	xXJFNtiC5N2lLRYRBo2bFX2m+C/++znjr9IDI5CDXCskKvmiQ72pN45numgZtrDpFHb+knY1iez
	2pUX7GeovI43n278epureTdOnBNs1/zMnMdiY6gH7Zs9jpF6rL/xVzNtmkHq3+bCgpyIJEdIepT
	3ikolkgKRjaYHEUzU+Xg9YqxCMvPXRGuXuiC9f0kaJ/4wSosGjoJhxRwy+xpG2U8O4iqHAzWxph
	nq5tmXIlz/6yKJTZjq4OhlOKF5pX68k8DuoXp2HAvQMP93297ToR4q0KLEM+vgd9Enbk=
X-Received: by 2002:a05:600c:1f95:b0:453:78f:fa9f with SMTP id 5b1f17b1804b1-45b5179cfa5mr199731965e9.11.1756384141028;
        Thu, 28 Aug 2025 05:29:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGK3MX5lHCe0T4jC6Xgyog17ATNhq4neX8rCMwBOuVu2rIRWQg/r6Yth5zxxMIPiF4hGTLSlg==
X-Received: by 2002:a05:600c:1f95:b0:453:78f:fa9f with SMTP id 5b1f17b1804b1-45b5179cfa5mr199731685e9.11.1756384140573;
        Thu, 28 Aug 2025 05:29:00 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f28:c100:2225:10aa:f247:7b85? (p200300d82f28c100222510aaf2477b85.dip0.t-ipconnect.de. [2003:d8:2f28:c100:2225:10aa:f247:7b85])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b6f30fe02sm71235425e9.18.2025.08.28.05.28.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 05:28:59 -0700 (PDT)
Message-ID: <27a21510-e9e8-4eb2-9e26-618c103d49c6@redhat.com>
Date: Thu, 28 Aug 2025 14:28:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: add `const` to lots of pointer parameters
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Max Kellermann <max.kellermann@ionos.com>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20250827192233.447920-1-max.kellermann@ionos.com>
 <c688a2f6-375e-4a00-8d44-6a833e3d30ef@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <c688a2f6-375e-4a00-8d44-6a833e3d30ef@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28.08.25 14:24, Lorenzo Stoakes wrote:
> You've not cc'd the right people here.
> 
> Please run scripts/get_maintainers.pl on your patch series and cc all
> maintainers and reviewers on every series please, as well as all of the mailing
> lists referenced.
> 
> For this change you needed to CC:
> 
> Alexander Viro <viro@zeniv.linux.org.uk> (maintainer:FILESYSTEMS (VFS and infrastructure))
> Christian Brauner <brauner@kernel.org> (maintainer:FILESYSTEMS (VFS and infrastructure))
> Jan Kara <jack@suse.cz> (reviewer:FILESYSTEMS (VFS and infrastructure))
> Andrew Morton <akpm@linux-foundation.org> (maintainer:MEMORY MANAGEMENT - CORE,commit_signer:1/1=100%)
> David Hildenbrand <david@redhat.com> (maintainer:MEMORY MANAGEMENT - CORE)
> Lorenzo Stoakes <lorenzo.stoakes@oracle.com> (reviewer:MEMORY MANAGEMENT - CORE)
> "Liam R. Howlett" <Liam.Howlett@oracle.com> (reviewer:MEMORY MANAGEMENT - CORE)
> Vlastimil Babka <vbabka@suse.cz> (reviewer:MEMORY MANAGEMENT - CORE)
> Mike Rapoport <rppt@kernel.org> (reviewer:MEMORY MANAGEMENT - CORE)
> Suren Baghdasaryan <surenb@google.com> (reviewer:MEMORY MANAGEMENT - CORE)
> Michal Hocko <mhocko@suse.com> (reviewer:MEMORY MANAGEMENT - CORE)
> Axel Rasmussen <axelrasmussen@google.com> (maintainer:MEMORY MANAGEMENT - MGLRU (MULTI-GEN LRU))
> Yuanchu Xie <yuanchu@google.com> (maintainer:MEMORY MANAGEMENT - MGLRU (MULTI-GEN LRU))
> Wei Xu <weixugc@google.com> (reviewer:MEMORY MANAGEMENT - MGLRU (MULTI-GEN LRU))
> "Matthew Wilcox (Oracle)" <willy@infradead.org> (maintainer:PAGE CACHE)
> Hugh Dickins <hughd@google.com> (maintainer:TMPFS (SHMEM FILESYSTEM))
> Baolin Wang <baolin.wang@linux.alibaba.com> (reviewer:TMPFS (SHMEM FILESYSTEM))
> David Rientjes <rientjes@google.com> (reviewer:MEMORY MANAGEMENT - OOM KILLER)
> Shakeel Butt <shakeel.butt@linux.dev> (reviewer:MEMORY MANAGEMENT - OOM KILLER)
> linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS (VFS and infrastructure))
> linux-kernel@vger.kernel.org (open list)
> linux-mm@kvack.org (open list:MEMORY MANAGEMENT - CORE)
> 
> Usually I'd cc for you here but that's too many :)
> 
> On Wed, Aug 27, 2025 at 09:22:33PM +0200, Max Kellermann wrote:
>> For improved const-correctness.
> 
> 'const-correctness' in C is extremely weak.
> 
>>
>> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> 
> It feels like this is a bit of an arbitrary subset and this churn is going
> to make merge conflicts much more likely.
> 
> I mean, if it's just that all this functions accept non-const VMA and for
> all callers _from_ these functions most accept const - it's not really
> accomplishing much other than adding a bunch of noise.
> 
> Any meaningful change would require pretty huge amounts of change that
> would be horrendous git blame, merge conflict, etc. wise for really not a
> huge amount of benefit.
> 
> I feel like the ship has sailed for this and I really question the value of
> doing this in this way.

I recall that Willy did some more targeted conversions of that kind in the past regarding folios.

E.g.,

commit 68158bfa3dbd4af8461ef75a91ffc03be942c8fe
Author: Matthew Wilcox (Oracle) <willy@infradead.org>
Date:   Sat Oct 5 21:01:15 2024 +0100

     mm: mass constification of folio/page pointers
     
     Now that page_pgoff() takes const pointers, we can constify the pointers
     to a lot of functions.

I would appreciate similarly doing it in logical chunks.

-- 
Cheers

David / dhildenb


