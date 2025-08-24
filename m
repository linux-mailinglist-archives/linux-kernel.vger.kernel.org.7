Return-Path: <linux-kernel+bounces-783453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F73B32DCC
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 08:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6E147B0802
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 06:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C3F18DF8D;
	Sun, 24 Aug 2025 06:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qZvwd/T+"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80F91F3B9E
	for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 06:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756017925; cv=none; b=TxNfrksHFW7gBjJJy8/Ytbpr18B4PvXmxc0Ni/OYijj65axOA5nkNUBR0sMJW8537uUuLSr1+/my4PMoJ5x2/RA9Us1WGKmmsqutxCM2DcZjDzmf70+gQ7sa6NVTZozi1Ge9aKdezaCcvwVp9ONlfqZj8scNGDs/khQXBoUrZ/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756017925; c=relaxed/simple;
	bh=NITsCeKtx7QxrmW9zbPcsNyxKsduWWyiKpDTNzAB5Ks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FWqkF96DGcAQ85ln0Nkyc/guwuNQNX3DtkR6FKbRgFtvLmL/ZuHNoUVR4v/Hqt66AdP9vgZ7ReQbgc+VBmFc5fHIRJ87ezIoe1HHMVoJ+dcMjV6saV+saiJGeWqaSNN/yhyWRd0IXHcRucbJHWzPyB5hvT014/42JcFffty5QY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qZvwd/T+; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-618660b684fso5993a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 23:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756017917; x=1756622717; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IHPGeya9AYVT2dtG8NYVwirW5wGAQIjffRF28CeDOJ0=;
        b=qZvwd/T+KRje+7DTOynsT8jZd4MKDwjQeAchXvcL5tGNJQ7fVu1kJUO9BoxFVIVVRh
         4W8KqM6yso9jN3JEk8w94LDY1ypa0EK5+cbOs0vFT+1lG3GS7wlj0UaPN98sL1CWovM9
         nqynjKmQix1sgJ1x52vQ9C0/ZP17mXfLQJ9hmhdV/LAMQ2yPKQ5BsNBthQlelD5aLP5Q
         8viQ8YuTaOYGDKju6MxZAX5OXSA0EOIwOHGVaQSOdmKukeie8pL/LlofiLc/qwrAhFPD
         eh6Pjzwqd8Ds0/nQWnLLmppQRXUFHYyeaxas4P7WxuVY+R8GOs3zpCDOimZMCFiZd8KQ
         DC4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756017917; x=1756622717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IHPGeya9AYVT2dtG8NYVwirW5wGAQIjffRF28CeDOJ0=;
        b=dLxmJ2xYay63m4fcaX7AseSqYdu5924vuL5MAoXwLabTjQQh9O4ZiObMqkaetajp/W
         4GOCDgKgBykYqh7sxPn1VjnZa/9bQhg2cTiUAiljMCkDCxf99v0bY8i7B7P6UyR/LGXw
         sOWl1n3lnOe+UJk1rPL8n8d5gRz/ufeLRy5v0+nMkRPEoeyDXsafmg1i9xuw2IUs9EBj
         eIkbzEtey9/lBPMjlfoT8O79aKI2Kf9gOBQ7YZgcA3YLS/On1UVICBhLKyKyl9h2L9Fe
         X9q4iZOkmaj1rriSEf5JMBotniGiSsX5xPwKftaGIte4aEIghzmAW2NPw0vz9fnxJAe2
         g8nw==
X-Forwarded-Encrypted: i=1; AJvYcCX5Wi6MLGecIvCsLnqFIvdyQhCUAtWmPtF+C84kWHKQ4g8NyPBZtXbnhtQ+OiVPwhpWiRVBkBwzfAcLqkQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3MOvffJOQBg0hzPHkjb9XohsT1bYpls9E0wp2m+Dof2K/ZGcC
	Dkf3cn/x+eJNxwHE0RoMJw6kL/sErXbUqX6kNWN97vXgCFapX+X92InAWePks+/7W1GgQH1/uXW
	14UZl0cnJ+dylxqWzpbaMlKAaBjY6hvsQ5ctaQ0rM
X-Gm-Gg: ASbGncvXD263FUclVyqRvLpB/y7t48VGMA4NKAYyoAdl3KGJt+rRtYCMdqHjE+miPCS
	or87pdgtZ4oOHnuyz4CX4jBkKxi6QN+KxCk15UhQJjgKhPTQAx2JeoXX6eZuje7uddTYZ8egNHF
	vSj03bLm8IcDfDA106t3lB8DHFxDDtLuF9bV/6eMFsvkqrHcynKElS3qG3ugJwboPv+yeGx4unU
	ch3ez6t6C52NxkXSSPE1WIS77civdkgOFQoOYyPSUo6R54=
X-Google-Smtp-Source: AGHT+IGZlZyU1kr5NXFGP7MaqKFLiWA6g6rEs5ntJymCQzs9YJFCKhJG40wdBtKxd587lL8fhh/XGyjRZX28d1LbXus=
X-Received: by 2002:a05:6402:27d4:b0:61a:c827:f84 with SMTP id
 4fb4d7f45d1cf-61c38db9c28mr64351a12.7.1756017916943; Sat, 23 Aug 2025
 23:45:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+EESO4Z6wtX7ZMdDHQRe5jAAS_bQ-POq5+4aDx5jh2DvY6UHg@mail.gmail.com>
 <CA+EESO7j4dY3KjBWybTG6uQmXJ8kyhBrid3rTk5XAP7poZOhYQ@mail.gmail.com> <aKqjWqn8lrITKI7P@hyeyoo>
In-Reply-To: <aKqjWqn8lrITKI7P@hyeyoo>
From: Lokesh Gidra <lokeshgidra@google.com>
Date: Sat, 23 Aug 2025 23:45:03 -0700
X-Gm-Features: Ac12FXwBQFPzIWu-CuhS4k4sD34BSAjJ_EWFH1stI-Mt6FmgMU5PRf6X-yr3Jdc
Message-ID: <CA+EESO6PFJ9A0kbRWd-ARBLmQ9pwNOF=GBuAzMCOyFvps4euGA@mail.gmail.com>
Subject: Re: [DISCUSSION] Unconditionally lock folios when calling rmap_walk()
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>, 
	Barry Song <21cnbao@gmail.com>, "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>, Peter Xu <peterx@redhat.com>, 
	Suren Baghdasaryan <surenb@google.com>, Kalesh Singh <kaleshsingh@google.com>, 
	android-mm <android-mm@google.com>, linux-kernel <linux-kernel@vger.kernel.org>, 
	Jann Horn <jannh@google.com>, Rik van Riel <riel@surriel.com>, Vlastimil Babka <vbabka@suse.cz>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, David Hildenbrand <david@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 23, 2025 at 10:31=E2=80=AFPM Harry Yoo <harry.yoo@oracle.com> w=
rote:
>
> On Sat, Aug 23, 2025 at 09:18:11PM -0700, Lokesh Gidra wrote:
> > On Fri, Aug 22, 2025 at 10:29=E2=80=AFAM Lokesh Gidra <lokeshgidra@goog=
le.com> wrote:
> > >
> > > Hi all,
> > >
> > > Currently, some callers of rmap_walk() conditionally avoid try-lockin=
g
> > > non-ksm anon folios. This necessitates serialization through anon_vma
> > > write-lock elsewhere when folio->mapping and/or folio->index (fields
> > > involved in rmap_walk()) are to be updated. This hurts scalability du=
e
> > > to coarse granularity of the lock. For instance, when multiple thread=
s
> > > invoke userfaultfd=E2=80=99s MOVE ioctl simultaneously to move distin=
ct pages
> > > from the same src VMA, they all contend for the corresponding
> > > anon_vma=E2=80=99s lock. Field traces for arm64 android devices revea=
l over
> > > 30ms of uninterruptible sleep in the main UI thread, leading to janky
> > > user interactions.
> > >
> > > Among all rmap_walk() callers that don=E2=80=99t lock anon folios,
> > > folio_referenced() is the most critical (others are
> > > page_idle_clear_pte_refs(), damon_folio_young(), and
> > > damon_folio_mkold()). The relevant code in folio_referenced() is:
> > >
> > > if (!is_locked && (!folio_test_anon(folio) || folio_test_ksm(folio)))=
 {
> > >         we_locked =3D folio_trylock(folio);
> > >         if (!we_locked)
> > >                 return 1;
> > > }
> > >
> > > It=E2=80=99s unclear why locking anon_vma exclusively (when updating
> > > folio->mapping, like in uffd MOVE) is beneficial over walking rmap
> > > with folio locked. It=E2=80=99s in the reclaim path, so should not be=
 a
> > > critical path that necessitates some special treatment, unless I=E2=
=80=99m
> > > missing something.
> > >
> > > Therefore, I propose simplifying the locking mechanism by ensuring th=
e
> > > folio is locked before calling rmap_walk(). This helps avoid locking
> > > anon_vma when updating folio->mapping, which, for instance, will help
> > > eliminate the uninterruptible sleep observed in the field traces
> > > mentioned earlier. Furthermore, it enables us to simplify the code in
> > > folio_lock_anon_vma_read() by removing the re-check to ensure that th=
e
> > > field hasn=E2=80=99t changed under us.
> > Hi Harry,
> >
> > Your comment [1] in the other thread was quite useful and also needed
> > to be responded to. So bringing it here for continuing discussion.
>
> Hi Lokesh,
>
> Here I'm quoting my previous comment for discussion. I should have done i=
t
> earlier but you know, it was Friday night in Korea :)

No problem at all. :)
>
> My previous comment was:
>   Simply acquiring the folio lock instead of anon_vma lock isn't enough
>   1) because the kernel can't stablize anon_vma without anon_vma lock
>   (an anon_vma cannot be freed while someone's holding anon_vma lock,
>   see anon_vma_free()).
>
>   2) without anon_vma lock the kernel can't reliably unmap folios because
>   they can be mapped to other processes (by fork()) while the kernel is
>   iterating list of VMAs that can possibly map the folio. fork() doens't
>   and shouldn't acquire folio lock.
>
>   3) Holding anon_vma lock also prevents anon_vma_chains from
>      being freed while holding the lock.
>
>   [Are there more things to worry about that I missed?
>    Please add them if so]
>
>   Any idea to relax locking requirements while addressing these
>   requirements?
>
>   If some users don't care about missing some PTE A bits due to race
>   against fork() (perhaps folio_referenced()?), a crazy idea might be to
>   RCU-protect anon_vma_chains (but then we need to check if the VMA is
>   still alive) and use refcount to stablize anon_vmas?
>
> > It seems from your comment that you misunderstood my proposal. I am
> > not suggesting replacing anon_vma lock with folio lock during rmap
> > walk. Clearly, it is essential for all the reasons that you
> > enumerated. My proposal is to lock anon folios during rmap_walk(),
> > like file and KSM folios.
>
> Still not sure if I follow your proposal. Let's clarify a little bit.
>
> As anon_vma lock is reader-writer semaphore, maybe you're saying
> 1) readers should acquire both folio lock and anon_vma lock, and
>
> > This helps in improving scalability (and also simplifying code in
> > folio_lock_anon_vma_read()) as then we can serialize on folio lock
> > instead of anon_vma lock when moving the folio to a different root
> > anon_vma in folio_move_anon_rmap() [2].
>
> 2) some of existing writers (e.g., move_pages_pte() in mm/userfaultfd.c)
>    simply update folio->index and folio->mapping, and they should be able
>    to run in parallel if they're not updating the same folio,
>    by taking folio lock and avoiding anon_vma lock?

Yes, that's exactly what I am hoping to achieve.
>
> I see a comment in move_pages_pte():
> /*
>  * folio_referenced walks the anon_vma chain
>  * without the folio lock. Serialize against it with
>  * the anon_vma lock, the folio lock is not enough.
>  */
>
> > [1] https://lore.kernel.org/all/aKhIL3OguViS9myH@hyeyoo
> > [2] https://lore.kernel.org/all/e5d41fbe-a91b-9491-7b93-733f67e75a54@re=
dhat.com
> > > > > Thanks,
> > > Lokesh
>
> --
> Cheers,
> Harry / Hyeonggon

