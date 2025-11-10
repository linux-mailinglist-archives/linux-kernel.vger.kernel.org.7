Return-Path: <linux-kernel+bounces-892408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DBD9C45074
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 06:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 40D884E7BB2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 05:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C6728E59E;
	Mon, 10 Nov 2025 05:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O3hUALDC"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D5823BD01
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 05:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762752825; cv=none; b=HX28Q9oyVRRP4rLIuge3O8HqC5ikOUnt2JzhD8PjikcpAUwMrJnYqlmmMJGXXdYIt9wxvAq3lnDwowpV77FZeQbVRy2r0YUVrzWFRoB5aH2btiG5JwZ1d2MrPgiivxEgBqnVjoVq3coHDV9TslbmByxR4eyzJk1DiEVm951n9Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762752825; c=relaxed/simple;
	bh=s06XNi/Hhu/yWCnO+JKkYUMMuOx1UTaMkm1QBjZeMDo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iGqQ39hvOxFLl28GzRUO9Th27VRdb5HRLyCosafuTS3gC3vb5KtnyjujT3xnbHhqKg4yqsNVy8tUft0U16JIWJ8xRWpb2+XYyFA20mkUTTNIYK07j6W0dlengoOZWCE2lsZzpwS0zKWMB/qPz0HdQTLPbF1SGB7mLYEW4gMG2kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O3hUALDC; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-64180bd67b7so937255a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 21:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762752822; x=1763357622; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2YPse+AqWc5TNScb2DsIrm8BhXLhTwQmVOCKCe+y8NY=;
        b=O3hUALDCxG9yn9HUsRVgVMJi/LUm7H4Ig9JO+B5Ya5Yr+z0FWL7eTCaJ/j3PjRBg83
         6WOUJqGcGJqjPAz0clTDq2jLXR1T5lPxIYa2zKL9GbsV42TfRpjNoPT6DSQpW9SqrGaA
         h5MNfG3IlJANaShHs6BJZRc+lQm77xbzNz/WzCP02YfgCugo6E0wDuw+P9GSdmug8pLc
         jbb8mzHbu2vBtwzwHevrrRvJvgROzZ219pV2t0Hdju6Q0AU9tMx2/XbdvdK5LaAOlwTf
         AouKkV/NDCFiQNswYQpmC/tKLEA2VTbbMq8khGCJd18JmHuPqixKNFICvniPOntUiezn
         rXSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762752822; x=1763357622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2YPse+AqWc5TNScb2DsIrm8BhXLhTwQmVOCKCe+y8NY=;
        b=JXKXBFGN723CujKbDnZXPU8g4QqbNXVUbfjcJgKHmuSUZprvVLmrjY/7Y7gNXCdaTb
         EGl/93aXA9D/R7Chs0CJVsFTKg5X+BidmGvI9mcISYOsHryAaBVU41WSHuy4Bm+Yvx0+
         Ditw26rx/3K1Vib5aFG+F88YyOekeFNfybjImEhsoEhh/63i/mhtgen/LbVucxMEE4g6
         RAFZqW69RWKtOpFNizUTDajpjrOuzxDZirdsA3+cmjrW73LDvQ2hlOcGzJEWIP2EnXg5
         KbyRnHK59HAp/P9YIDEcehlPTaKzG9rLmKa/gfjprKbhpZwOSVzDq4rIhi0GMtI2odgi
         LXWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHSpS8FrpVcGtV0IOaHa/EGXcpKsVw9XYP7vx7fRQ5QBcyV+lZ928lknH257h7mB4oOaf5mov6BD6Qg7o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya59TGZvVQWxRkfjz0AIejl13A6lNY6O+TFutHKg4eYuxCH+Ro
	Bq1oaX4QUjMNM1UkQv4pJ+x/kxQAmckzJWvBxsAEwO8nGv1cTwQ3LfDPVEPNln/CkRCRLcMb7ZM
	eWJi4PWOkdJFL42d3bFmpoW9vp5bazVU=
X-Gm-Gg: ASbGncsZSGI5T3Cm/mFx/AD4+Fs/NQqeS/UgiXJvZVeh9yUm37/xAHRO/quW1F9IrxS
	jGod4UlK2xO7ftnR4Bp5RNafrdYR8p5YYQXOe4ivdWdHGdOXZmwqwUqxzdAqOgAIwXoEIBbIiYY
	om4GIAOaaAdLYHoTVPaELiwgI23XXdkxKGkrwMfbdakTtbm3v9NHA6OwwGh+DMnvjtQgyY6yjNr
	+fnei7Tx+WGoJqDQP1TmpEiTpofmkQVXuFk/QPL+2AFu+k+dIeevrltJ7RIGLpHvuuvr/g=
X-Google-Smtp-Source: AGHT+IHIgpKw2JS/4nW9GWH99xD30wamSLuWzRvjpP+v876+1IW6dPW88z704lMHVQvozZxjzLX+eTNtmZCa8pvUdhM=
X-Received: by 2002:a05:6402:270f:b0:640:b7f1:1cc8 with SMTP id
 4fb4d7f45d1cf-6415e822f52mr5145100a12.18.1762752821989; Sun, 09 Nov 2025
 21:33:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110-revert-78524b05f1a3-v1-1-88313f2b9b20@tencent.com> <2025111053-saddlebag-maybe-0edc@gregkh>
In-Reply-To: <2025111053-saddlebag-maybe-0edc@gregkh>
From: Kairui Song <ryncsn@gmail.com>
Date: Mon, 10 Nov 2025 13:33:05 +0800
X-Gm-Features: AWmQ_bkULrKqEl-qbo8niCo2wz3BnMM2b5Qc9JZ7etDw2JSDO9jzr5c_pKKh-b8
Message-ID: <CAMgjq7DnaD-bH1efF9c1X0XAvZaMufzBUGxxeRrRAJBzBe59+g@mail.gmail.com>
Subject: Re: [PATCH] Revert "mm, swap: avoid redundant swap device pinning"
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, Chris Li <chrisl@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosry.ahmed@linux.dev>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Youngjun Park <youngjun.park@lge.com>, 
	LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Greg KH <gregkh@linuxfoundation.org> =E4=BA=8E 2025=E5=B9=B411=E6=9C=8810=
=E6=97=A5=E5=91=A8=E4=B8=80 09:01=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Nov 10, 2025 at 02:06:03AM +0800, Kairui Song via B4 Relay wrote:
> > From: Kairui Song <kasong@tencent.com>
> >
> > This reverts commit 78524b05f1a3e16a5d00cc9c6259c41a9d6003ce.
> >
> > While reviewing recent leaf entry changes, I noticed that commit
> > 78524b05f1a3 ("mm, swap: avoid redundant swap device pinning") isn't
> > correct. It's true that most all callers of __read_swap_cache_async are
> > already holding a swap entry reference, so the repeated swap device
> > pinning isn't needed on the same swap device, but it is possible that
> > VMA readahead (swap_vma_readahead()) may encounter swap entries from a
> > different swap device when there are multiple swap devices, and call
> > __read_swap_cache_async without holding a reference to that swap device=
.
> >
> > So it is possible to cause a UAF if swapoff of device A raced with
> > swapin on device B, and VMA readahead tries to read swap entries from
> > device A. It's not easy to trigger but in theory possible to cause real
> > issues. And besides, that commit made swap more vulnerable to issues
> > like corrupted page tables.
> >
> > Just revert it. __read_swap_cache_async isn't that sensitive to
> > performance after all, as it's mostly used for SSD/HDD swap devices wit=
h
> > readahead. SYNCHRONOUS_IO devices may fallback onto it for swap count >
> > 1 entries, but very soon we will have a new helper and routine for
> > such devices, so they will never touch this helper or have redundant
> > swap device reference overhead.
> >
> > Fixes: 78524b05f1a3 ("mm, swap: avoid redundant swap device pinning")
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> > ---
> >  mm/swap_state.c | 14 ++++++--------
> >  mm/zswap.c      |  8 +-------
> >  2 files changed, 7 insertions(+), 15 deletions(-)
> >
> > diff --git a/mm/swap_state.c b/mm/swap_state.c
> > index 3f85a1c4cfd9..0c25675de977 100644
> > --- a/mm/swap_state.c
> > +++ b/mm/swap_state.c
> > @@ -406,13 +406,17 @@ struct folio *__read_swap_cache_async(swp_entry_t=
 entry, gfp_t gfp_mask,
> >               struct mempolicy *mpol, pgoff_t ilx, bool *new_page_alloc=
ated,
> >               bool skip_if_exists)
> >  {
> > -     struct swap_info_struct *si =3D __swap_entry_to_info(entry);
> > +     struct swap_info_struct *si;
> >       struct folio *folio;
> >       struct folio *new_folio =3D NULL;
> >       struct folio *result =3D NULL;
> >       void *shadow =3D NULL;
> >
> >       *new_page_allocated =3D false;
> > +     si =3D get_swap_device(entry);
> > +     if (!si)
> > +             return NULL;
> > +
> >       for (;;) {
> >               int err;
> >
> > @@ -499,6 +503,7 @@ struct folio *__read_swap_cache_async(swp_entry_t e=
ntry, gfp_t gfp_mask,
> >       put_swap_folio(new_folio, entry);
> >       folio_unlock(new_folio);
> >  put_and_return:
> > +     put_swap_device(si);
> >       if (!(*new_page_allocated) && new_folio)
> >               folio_put(new_folio);
> >       return result;
> > @@ -518,16 +523,11 @@ struct folio *read_swap_cache_async(swp_entry_t e=
ntry, gfp_t gfp_mask,
> >               struct vm_area_struct *vma, unsigned long addr,
> >               struct swap_iocb **plug)
> >  {
> > -     struct swap_info_struct *si;
> >       bool page_allocated;
> >       struct mempolicy *mpol;
> >       pgoff_t ilx;
> >       struct folio *folio;
> >
> > -     si =3D get_swap_device(entry);
> > -     if (!si)
> > -             return NULL;
> > -
> >       mpol =3D get_vma_policy(vma, addr, 0, &ilx);
> >       folio =3D __read_swap_cache_async(entry, gfp_mask, mpol, ilx,
> >                                       &page_allocated, false);
> > @@ -535,8 +535,6 @@ struct folio *read_swap_cache_async(swp_entry_t ent=
ry, gfp_t gfp_mask,
> >
> >       if (page_allocated)
> >               swap_read_folio(folio, plug);
> > -
> > -     put_swap_device(si);
> >       return folio;
> >  }
> >
> > diff --git a/mm/zswap.c b/mm/zswap.c
> > index 5d0f8b13a958..aefe71fd160c 100644
> > --- a/mm/zswap.c
> > +++ b/mm/zswap.c
> > @@ -1005,18 +1005,12 @@ static int zswap_writeback_entry(struct zswap_e=
ntry *entry,
> >       struct folio *folio;
> >       struct mempolicy *mpol;
> >       bool folio_was_allocated;
> > -     struct swap_info_struct *si;
> >       int ret =3D 0;
> >
> >       /* try to allocate swap cache folio */
> > -     si =3D get_swap_device(swpentry);
> > -     if (!si)
> > -             return -EEXIST;
> > -
> >       mpol =3D get_task_policy(current);
> >       folio =3D __read_swap_cache_async(swpentry, GFP_KERNEL, mpol,
> > -                     NO_INTERLEAVE_INDEX, &folio_was_allocated, true);
> > -     put_swap_device(si);
> > +                             NO_INTERLEAVE_INDEX, &folio_was_allocated=
, true);
> >       if (!folio)
> >               return -ENOMEM;
> >
> >
> > ---
> > base-commit: 02dafa01ec9a00c3758c1c6478d82fe601f5f1ba
> > change-id: 20251109-revert-78524b05f1a3-04a1295bef8a
> >
> > Best regards,
> > --
> > Kairui Song <kasong@tencent.com>
> >
> >
> >
>
> <formletter>
>
> This is not the correct way to submit patches for inclusion in the
> stable kernel tree.  Please read:
>     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.ht=
ml
> for how to do this properly.
>
> </formletter>

Thanks for the info, my bad, I was trying new tools to send patches so
the Cc tags were missing, will fix it. This patch is meant to be
merged into the mainline first.

