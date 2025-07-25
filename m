Return-Path: <linux-kernel+bounces-745909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95636B12056
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 16:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 721501C8615E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 14:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5478C1D9A54;
	Fri, 25 Jul 2025 14:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dtHYh1MZ"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007458F4A
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 14:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753454929; cv=none; b=MF4ll4DZ4cUC+Kcznd7NlxhFs/3vQ1Hw/jDN+bv41Jt4lCtjky5OL7P1qm3cNXYa4j1myoMTc92siuTk2Vj/2v0/LRhiEe4DOiWkFGG2JhtgjIBD+2DWVAi2cH/RTeMTw31AgPz3xXymsoQpVw+ogoEzknIU+DoVKmlNCXue7PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753454929; c=relaxed/simple;
	bh=I4zM1Gv132DVmDNTiP916g1kjFCLGivg9m+ZyNOMhQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VkEjkgoQaUPg2BTXQjqxJMGZPmHRnpeeOnbSi82a/bx+wg/g4uro/P9qI+sjnEt8VwnqkBdnwgCaTekK0j7YEJCsR9ZF4QVUmaOqJXQ9IQPXQQ7+PS6UT9yA417k9NN0TKCTU63OvQvnDgXuvS6RQjdyq7l1uYgkjPbwdyTWPG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dtHYh1MZ; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5f438523d6fso9599a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 07:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753454926; x=1754059726; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6fTiJ/2yQ7EUbjCeVCBz++1COYxUgI84X7sP0FcZaWQ=;
        b=dtHYh1MZ5qSccLBdHQUOdIw1us6PelSb8xY2gJVKso7tT2KHSS0ZnDI8lXdA+wDtBS
         QLDyBeXvxKGlXktOVTZjqHTfEUzgecUXU7yNxxTfGZ8VMBxBF6QZpwtWEO9d7ALZHXvF
         pfZGp8gwbFe58yBFRPCSzBEHAMwUOG6ODXsWZm1wLg3imiSll2LgPdX7CCP3OloLx96/
         dXm6eIJK11wkDxqrVL/tw/TWkpCdNrSrkIelifnkyEkAiYVtgTqBunjLGPOAkDDTEB32
         iDFPg2HWoDQi/Yuyfu8vS1m/LUlvnPT3WIt607dOUX0BvR/tRJzk+DxvgjC87PwIlrdV
         4Tsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753454926; x=1754059726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6fTiJ/2yQ7EUbjCeVCBz++1COYxUgI84X7sP0FcZaWQ=;
        b=k0P8cpfQ9aTBKz+zGr8Gzl0n+beVbgJLI08GKzS7RoMh0VJ1TsGSXvo/FzknnY5pWI
         XAKBUK+Y8kSm3tTG6B6JuqHWd3MR4W+4+rpQqylF2KKgctAV7MtkqMA3pWyXG4AHIlE9
         iVn1IU5nl1FXsXC/2GXzZO07+iGvDZ8oBVg3n5v5quI6quInZc7xGIZVmECIHf6NQtzV
         5bGTAWzMqNPiDqdRVQk3rHFMHyDWUuR4wLVN1A3/UVEh+0o1JLl0fwZwW6seyvTlLV70
         IzQwGK41ThVcUuFg/rohhlHRqM8VuO30xUA66XB/9+2oLAgbR+0cS1KHn3q2Y0m2nYa+
         Ia6A==
X-Forwarded-Encrypted: i=1; AJvYcCXXacfQyLR/OeKVRsns7iMG6Vd8nd+onjmxdee+gYAc1v4QmGvZciXOf5tXRcN6NKEavG9Tt7cNXkz6nsc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo7kngO6ArIkrmzZKgf3iJJlhexFdmITYwJ/N0nqm6wxePJv4O
	UWNhMX32rwGa5ReVhUc6HHFoXL8rGfGChs7QZUXjmuCgoNFxyi4qA7XhRbf62CKcD2mdqd4C0mV
	1uu9POUpFKVxMLpXeJ5UiILDm3FA5GhtNQ9ShRSex
X-Gm-Gg: ASbGncszF5ITjYtWEjO23G1hVNuwPYMbwPG3NnefNA7kqjfv5PuNVB12GY+Ae3Yqzfi
	GtBYO7Ns4GZ8SdJ78em/Or87h8I84Ol55N1+FeDsYyyvmTMdWkfQKUpKOMSJ2SaxodDVCKc/iwn
	Uriy773/jaRLQ7LogDnaWXjmws5qyU/HBP+x7fGkOCr0Oq2vR5h87WWhOZqk5PXqrsEli9g/7Eu
	DqUYkktd/GmKmR5ZI6LtZfF8C19fjrYALs=
X-Google-Smtp-Source: AGHT+IFQ5AMiQfPybrXcmBkRC8UMaPAwiYPs8TQcD30T1QIfVF3Vtd6z6dbAtwTEtc6Dd6Sjmp1+B0ZsJ9Yqhgfl2cw=
X-Received: by 2002:a05:6402:40d1:b0:60e:5391:a9e5 with SMTP id
 4fb4d7f45d1cf-614ea755d34mr89389a12.5.1753454925860; Fri, 25 Jul 2025
 07:48:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250724-anonvma-uaf-debug-v1-1-29989ddc4e2a@google.com>
 <c3f04c75-a73b-48bb-b56e-7b18e57c2382@lucifer.local> <CAG48ez31aVnoBiMMjUczbmThWnRGmod4yppgMVqf2Nu5-hjU2g@mail.gmail.com>
 <50502c3b-903f-4018-b796-4a158f939593@lucifer.local>
In-Reply-To: <50502c3b-903f-4018-b796-4a158f939593@lucifer.local>
From: Jann Horn <jannh@google.com>
Date: Fri, 25 Jul 2025 16:48:09 +0200
X-Gm-Features: Ac12FXzAIpPjC-gw79jtBUmPpJHNu7DPT7TU7_vGFytRzjofambUs1vGAWWcnjY
Message-ID: <CAG48ez1TOULrpJGsUYvRSsrdWBepCJf9jh-xPpurRUXbMmAkuA@mail.gmail.com>
Subject: Re: [PATCH] mm/rmap: Add anon_vma lifetime debug check
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Rik van Riel <riel@surriel.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Harry Yoo <harry.yoo@oracle.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 25, 2025 at 3:49=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
> On Fri, Jul 25, 2025 at 02:00:18PM +0200, Jann Horn wrote:
> > An anon folio may outlive the VMAs it comes from, so it may also
> > outlive its associated anon_vma.
>
> Yes, I will share some diagrams I did a while ago to outline this. They'r=
e
> ASCII and make you want to cry! :)
>
> Hmm, if non-root, I wonder if we

(looks like you stopped typing mid-sentence)

> > 2. Removing an anon folio mapping reduces the anon folio's mapcount
> > before the VMA can go away.
>
> the anon folio's mapcount? You mean the VMA's? :P

I mean folio_mapcount(folio), which reads folio->_mapcount and
folio->_large_mapcount.

> > 4. If the anon-exclusive bit is set, the folio is only mapped in a
> > single place (otherwise swapout+swapin could erroneously set
> > RMAP_EXCLUSIVE, causing the swapped-in folio to be associated with the
> > wrong anon_vma).
>
> I believe (David?) swapin can cause this not to be the case?
>
> > 5. When a VMA is associated with an anon_vma, it is always also
> > associated with the corresponding root anon_vma (necessary because
> > non-RMAP_EXCLUSIVE swapin falls back to associating the folio with the
> > root anon_vma).
>
> OK but we know for sure the UAF is not on a root anon_vma so it's not som=
e
> weirdness with trying to access anon_vma->root

Ah, right.

> > 6. If two VMAs in the same process have the same ->anon_vma, their
> > anonvma chains must be the same (otherwise VMA merging can break
> > stuff).
> >
>
> What do you mean the same?
>
> If you mean they both must have AVC's which ponit to the individual VMAs
> and each point to the same anon_vma, yes.

Yeah, that.

> God simple isn't it? ;)

Yeah, I prefer to think of this at the slightly higher abstraction
layer of "which VMAs are tied to which anon_vmas via AVC" and "which
VMAs use which anon_vmas as their primary anon_vma"; to me, AVCs being
separate objects is a minor implementation detail caused by the kernel
only using intrusive lists instead of the kinds of data structures
that you'd use in almost any other environment.
(Like, you wouldn't need AVC objects if the references between VMAs
and anon_vmas were formed with things like maple trees or xarrays, but
I guess they wouldn't give you the interval tree semantics you want.)

> I verified these numbers with drgn, interesting add a new child doesn't
> increment refcount...

Yeah - AFAIU a single reference is shared by all the VMAs that are
tied to an anon_vma via AVC nodes, and a child anon_vma can't be
associated with a VMA without its parent also being associated with
the VMA...

> > > We're sort of relying on this
> > >
> > > a. being a UAF
> > >
> > > b. the thing we're UAF-ing not either corrupting this field or (if th=
at
> > >     memory is actually reused as an anon_vma - I'm not familiar with =
slab
> > >     caches - so maybe it's quite likely - getting its refcount increm=
ented.
> >
> > KASAN sees the memory read I'm doing with this atomic_read(), so in
> > KASAN builds, if this is a UAF, it should trigger a KASAN splat
> > (modulo KASAN limitations around when UAF can be detected). Basically,
> > in KASAN builds, the actual explicit check I'm doing here is only
> > relevant if the object has not yet been freed. That's why I wrote the
> > comment "Part of the purpose of the atomic_read() is to make KASAN
> > check that the anon_vma is still alive.".
>
> Hm, I'm confused, how can you detect a UAF if the object cannot yet be
> freed? :P
>
> or would that be the case were it not an atomic_read()?
>
> I guess this permits this to be detected in a timely manner.

If the anon_vma hasn't yet been freed, but its refcount is 0, then
that's still a bug because we rely on the anon_vma to have a nonzero
refcount as long as there are folios with a nonzero mapcount that are
tied to it, and it is likely to allow UAF at a later point.

