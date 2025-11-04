Return-Path: <linux-kernel+bounces-884623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 64948C309D4
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 11:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 75B2A4F2A26
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 10:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01C32D8DB5;
	Tue,  4 Nov 2025 10:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GWvyh1SI"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E01298CC4
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 10:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762253470; cv=none; b=s4KijzfVFhz+KBYM3Ybt0y+ZUu1qIV7iHE25wS4bkGromP/qtuwKdVMA2jIIZBSMvMUL0oEKeOuDdwqUEl683ww33oALtHaTVWi8pXjSIYkw5rx4mZKUvVBjyojGaTtWXf3g7IWFom9JxwqFhBKus964wPvtwzgAuMyncJ0Cw04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762253470; c=relaxed/simple;
	bh=v92f1IS18k+JPBJhpxJta/WPyxLHuiMHaoEDYxPcgSk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MfOKUB4COmYieAW+fVgxvKBW0XwP+c1QWAodP0rUZxrqSDS6AEpP6aoUYLLL6CUHzg63pdcetitfk2qYPS7ToDhdxqGpfPfLC4d1blqf+Z0XbZnjCUESYLeAIlXnj3YVwY1jFY7Oioga+SGQarjLUjiPLUeB7me9r3QZ9oV4JJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GWvyh1SI; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b70406feed3so1209569666b.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 02:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762253466; x=1762858266; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8XiemDZsGarCr+FYxcjdOuySyiUPWndA+UfF0ZPw3VQ=;
        b=GWvyh1SI69WnCdY4WDSgH1dmoNMb9Xea0tnNQdn46YhT4p/6fxbcaVzAbaa8lMW80f
         Pdg+ypmDgdzAyPAsy/zw4zm7DF0Wn7gJCc0/7D2VXklDcMGlpvFukUMpcfsPArln7ZT2
         xfTjot5fdW9eJGjpLNyBXx/Mzb5p52pIlVe4QKrTJD/oSf2XVKWbwlo6tOxJNf63ATXB
         2Eeagyo0BbRE9s/T69tlSw9nvTG/JVjlM7iwcg8olOE8YdmgscZHOB0re7Ln7fCBqjJG
         m7HwQEbkGFN+sGDP+mFTIcTFUn3hgDhe8LVae7dw326tTbqkNCFMAxL4NowVqADFJbAR
         o0eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762253466; x=1762858266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8XiemDZsGarCr+FYxcjdOuySyiUPWndA+UfF0ZPw3VQ=;
        b=lcukEm/wWm+422PMpeh9dEkyQekDRVFxD6BI5s/UIjz2VdVUfktEknNwknQdTctjLI
         RruH2YVoIGxJPLkGJsyFRlafdX99JNlBbjg3jVOVpGLupIS6XfUerOhledtnBN2oXaDD
         YAs4yvH2jGSoWOvbyNL8YCX6ubrf4HfsgtCIRIDnTruhsmylC08bxTevLrzDuA05tfxY
         4vYb5dJQQo+yeRtCMjgi2qNCCbvk96m6z4d2xPz1/U2O0YBaBgYjrG7Zr5GKHzSPBCy+
         Lb8Vn4PUA8iwF0l3XUxbkoMW9ksfbaJTFvj/ZYnb2S5dynYFXGEFJszVRKvyR+xHKLQw
         abGg==
X-Forwarded-Encrypted: i=1; AJvYcCUUJjJ1L6FdTZ4IFYC0V2XD3sMMTQ57bzgU9hPljFhW2QTKBc6mz+ymcaFlGdfc9mynPB5GLugLdvclwWA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHx5FoMFFI/mG8vrl0yyfeCb/o07j+gJ8DjOq7q0SSAs58sXok
	cWlgK6cFu/eAUcBgygstwaZf3n1V/gn7BSenYIi6hnGUKO9WtriN27GHvk7uvsTkFlUSrRYBdV8
	xweU2e+JW/I2yvhtQGSfGGUdf6iXCbt4=
X-Gm-Gg: ASbGncsAkEQVYjJBmN2sN6e8e3KzHATmw8NAntniqLQrv4RcRQAh+mnC42qv2+z3O+c
	+5E+QfAFf6JD4RGb4FALTbC9pB1KNzc9hH6XjvM2CE2BGW4c6JW3rkgH9XP5mm3I19yLniRLile
	pRwLs1nJx7u+Y4BoQhJnk5mFby/BoB13vnDkdcJDIL80zrr94abi4Su7uOO0Ldj5ll4oucqQhJ3
	qaE1XCLhKcUK69Yze4G3vrIETrTVv+tFys40zPLMDiaAwH19Z6uzx93quU0GOmE
X-Google-Smtp-Source: AGHT+IE/p5D3gS5t+TqdhOZRazOjQZJIEZ65iHHwqiCBldoZ805RKHdn+V1p8ktx94/L4MI6LtIrE5XsKt0nm0HgDtI=
X-Received: by 2002:a17:907:3f0c:b0:b3e:580a:184f with SMTP id
 a640c23a62f3a-b70700d6d5bmr1790279066b.4.1762253466001; Tue, 04 Nov 2025
 02:51:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029-swap-table-p2-v1-0-3d43f3b6ec32@tencent.com>
 <20251029-swap-table-p2-v1-6-3d43f3b6ec32@tencent.com> <CAGsJ_4z1gB8x7GNUL4THdC7G9ZGMqbM3UtWM2LXPoT0xcLAQ3A@mail.gmail.com>
In-Reply-To: <CAGsJ_4z1gB8x7GNUL4THdC7G9ZGMqbM3UtWM2LXPoT0xcLAQ3A@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Tue, 4 Nov 2025 18:50:29 +0800
X-Gm-Features: AWmQ_bmV_iSb2dhNQMpuo5p-nozPoqBQfWGGMMVyrMWRZ9AARK8AV3WAKMhbzYg
Message-ID: <CAMgjq7CV14FdHvgGtXwWQPqXKwy4W-5vfR=-hUYkBemeMP=Srw@mail.gmail.com>
Subject: Re: [PATCH 06/19] mm, swap: free the swap cache after folio is mapped
To: Barry Song <21cnbao@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>, Nhat Pham <nphamcs@gmail.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosry.ahmed@linux.dev>, 
	David Hildenbrand <david@redhat.com>, Youngjun Park <youngjun.park@lge.com>, 
	Hugh Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	"Huang, Ying" <ying.huang@linux.alibaba.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 5:15=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrote=
:
>
> On Wed, Oct 29, 2025 at 11:59=E2=80=AFPM Kairui Song <ryncsn@gmail.com> w=
rote:
> >
> > From: Kairui Song <kasong@tencent.com>
> >
> > To prevent repeated faults of parallel swapin of the same PTE, remove
> > the folio from the swap cache after the folio is mapped. So any user
> > faulting from the swap PTE should see the folio in the swap cache and
> > wait on it.
> >
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> > ---
> >  mm/memory.c | 21 +++++++++++----------
> >  1 file changed, 11 insertions(+), 10 deletions(-)
> >
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 6c5cd86c4a66..589d6fc3d424 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -4362,6 +4362,7 @@ static vm_fault_t remove_device_exclusive_entry(s=
truct vm_fault *vmf)
> >  static inline bool should_try_to_free_swap(struct swap_info_struct *si=
,
> >                                            struct folio *folio,
> >                                            struct vm_area_struct *vma,
> > +                                          unsigned int extra_refs,
> >                                            unsigned int fault_flags)
> >  {
> >         if (!folio_test_swapcache(folio))
> > @@ -4384,7 +4385,7 @@ static inline bool should_try_to_free_swap(struct=
 swap_info_struct *si,
> >          * reference only in case it's likely that we'll be the exclusi=
ve user.
> >          */
> >         return (fault_flags & FAULT_FLAG_WRITE) && !folio_test_ksm(foli=
o) &&
> > -               folio_ref_count(folio) =3D=3D (1 + folio_nr_pages(folio=
));
> > +               folio_ref_count(folio) =3D=3D (extra_refs + folio_nr_pa=
ges(folio));
> >  }
> >
> >  static vm_fault_t pte_marker_clear(struct vm_fault *vmf)
> > @@ -4935,15 +4936,6 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >          */
> >         arch_swap_restore(folio_swap(entry, folio), folio);
> >
> > -       /*
> > -        * Remove the swap entry and conditionally try to free up the s=
wapcache.
> > -        * We're already holding a reference on the page but haven't ma=
pped it
> > -        * yet.
> > -        */
> > -       swap_free_nr(entry, nr_pages);
> > -       if (should_try_to_free_swap(si, folio, vma, vmf->flags))
> > -               folio_free_swap(folio);
> > -
> >         add_mm_counter(vma->vm_mm, MM_ANONPAGES, nr_pages);
> >         add_mm_counter(vma->vm_mm, MM_SWAPENTS, -nr_pages);
> >         pte =3D mk_pte(page, vma->vm_page_prot);
> > @@ -4997,6 +4989,15 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >         arch_do_swap_page_nr(vma->vm_mm, vma, address,
> >                         pte, pte, nr_pages);
> >
> > +       /*
> > +        * Remove the swap entry and conditionally try to free up the
> > +        * swapcache. Do it after mapping so any raced page fault will
> > +        * see the folio in swap cache and wait for us.
>
> This seems like the right optimization=E2=80=94it reduces the race window=
 where we might
> allocate a folio, perform the read, and then attempt to map it, only
> to find after
> taking the PTL that the PTE has already changed.
>
> Although I am not entirely sure that =E2=80=9Cany raced page fault will s=
ee the folio in
> swapcache,=E2=80=9D it seems there could still be cases where a fault occ=
urs after
> folio_free_swap(), and thus can=E2=80=99t see the swapcache entry.
>
> T1:
> swap in PF, allocate and add swapcache, map PTE, delete swapcache
>
> T2:
> swap in PF before PTE is changed;
> ...........................................................;
> check swapcache after T1 deletes swapcache -> no swapcache found.

Right, that's true. But we will at most only have one repeated fault,
and the time window is much smaller. T2 will PTE !=3D orig_pte and then
return just fine.

So this patch is only reducing the race time window for a potentially
better performance, and this race is basically harmless anyway. I
think it's good enough.

