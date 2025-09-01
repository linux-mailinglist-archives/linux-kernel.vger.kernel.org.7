Return-Path: <linux-kernel+bounces-795165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06778B3EDB6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 20:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0E9E17D123
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 18:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B133064BE;
	Mon,  1 Sep 2025 18:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eNUiiqbk"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844231FF1C8
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 18:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756750687; cv=none; b=FZGaIs4U0QsfJofc8eaFC2Fm1AOJEWPcA9gJzocmDsaD+kk2+IvdUsyBrHeUh0JnBDiD3JAsRmGdTwvx80fQMwdB4+4Y+JnrnGiWCAw4DBAH4Fn0bEvlwFJK1Us8jg6QPnAQBYjcgVPTuF7xjvfI+uzKwruaO8txInkhgcmAgpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756750687; c=relaxed/simple;
	bh=7Rsc9PdLlNKRIM02sxzbpqx4IYYOlOaucTbNtpK70Ac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jIxCpX1gexPM3+fzwRXfwshlavBTjKJyt9Th8cVL7NPa+gPzaPXUbXyxJORtydm2chIA3Eq/LFlKdCjJdr9WF413gpfEYwqxLYXQDLNFU9xfI7kTCOD25i4cSbs5eJNYfbwYDiDFS3EEMhS60xoQU3ok+qg65Ce/TEDuJfEW5fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eNUiiqbk; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b00a9989633so421473566b.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 11:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756750684; x=1757355484; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=71e9jxNAdOB08SDwtASl6UkqHHprrjxNIXBMKywL7Pc=;
        b=eNUiiqbk1kD5uBpxXEyH0g+aFqEiprhavj5Tw5CswjtW88XWuA2SGXhVovivAGgMVx
         X/rR6jXKxkenUmrsMbgNMg0tI0Cru0CQXkaPhN32RAPKs1o10sD/9xHNIem75ZjtaBL8
         6dftmRQg00ZVKFJtP/yeVFgl+ZyMdH0OeUFykDVfzbAA+p07eU0RkOMrZw++yxlm4wZH
         hWpi3to+IH5RgWRicSkMDl+DDixldmc1Vat2KlPt7bUcKG7aOYO4TRFUsWDTqxVhvlzb
         H7qyaW7u4IE7pHmPutAcLShkSsbXDqTcX3nIZLgZgF1oUUQoUZmcr83D6U37FIfqfIdv
         rG2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756750684; x=1757355484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=71e9jxNAdOB08SDwtASl6UkqHHprrjxNIXBMKywL7Pc=;
        b=HKPS5vyZIoCCetxH4UqpMsqlEhElG4iCUEZXHQX3ULiU2ruKb8uxt3T1+MnkbtlUR2
         Byx/dmgG/eIfzdG/V6QIi4kxC/t3M81Z/KTrOAXeLmHASSmUtMEnUiZj39pb8Ba3GSQZ
         M14+bNYNnas9xz9oE6CG/4aFUosfqNhqybCSQALk64sLsieb70dWAv41Sz217dpteXWp
         4rItiXfgDLHssQbb34fqxzXBz8llKCZlGFOisQU2qFT4Z0da2vGcekdHTRkcvZSFoCo6
         dJjiMtaYZ2O5ulKWOLh+BYQQhn3146D/VseskBsIKUhMFReeg0I9FX8iMXgp+vbkIvCP
         M0Xg==
X-Forwarded-Encrypted: i=1; AJvYcCVNSgRCPAczDIYl9vrcLbuGmO4fwHH6R0wvkvMlvhUJvKU9t9Ru8EbB2fH3kLRh9gw60rNgeEsMZMu/dLk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7daDlqjw9+Ai6ecoaNcnIdmWTfFm5kZRCm7Mlej4RajEWCJ+4
	txE6Ag04tEwHmYOLGlysIPb/IsBCKxSxmK4Ko0sjyDOJlPj0LzjSmhmHaPoQQmakK900gdX8/NG
	PFXDIApQK9cHDTqOxlz1O4DMY3TIPjYY=
X-Gm-Gg: ASbGncvemtGCzDd5bNW9KpXbrj+SdFODOMcDp50LTSAWEYfypY/Y001VbD/aRG3BQI3
	rIlxk+d3XlAdDmdm1mIvo6aRl68y8K+XVXi8XbBcz8yRxLut6Uqeu87oGM7uzAiOft5HlyYRHc8
	t4C7hDkBJ5xMl4y7GHebKcD1rODDGEgnjaepHU2uhFSSH6S+vsR5768Vd3+OSfEvo6O3oBh0W6g
	+bhNqHR/B0=
X-Google-Smtp-Source: AGHT+IHJbkBsvrU+7fOx7ErEa9lY9xRfRzo/H4E1Bt00rA4Vj+AuHAMEyjR/VP1EYIJblFFP3VE5gLCVpcPSPD1Nfak=
X-Received: by 2002:a17:907:6096:b0:b04:3b97:f972 with SMTP id
 a640c23a62f3a-b043b980cb7mr326658366b.3.1756750683635; Mon, 01 Sep 2025
 11:18:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822192023.13477-1-ryncsn@gmail.com> <20250822192023.13477-3-ryncsn@gmail.com>
 <CAF8kJuO0efOE-os=qi=i5jT1YWxspHYc=Ti1KN=uKgyFpWTRbA@mail.gmail.com>
 <CAMgjq7AkUc7hKrEL8cQ7jJTeXYBq7WqM55uQ_SZNNY8vJ7+ODQ@mail.gmail.com> <CACePvbWnsrGxUv15R4kMpc10wsBE2Bc-rapGyBYjekrqFJgJbw@mail.gmail.com>
In-Reply-To: <CACePvbWnsrGxUv15R4kMpc10wsBE2Bc-rapGyBYjekrqFJgJbw@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Tue, 2 Sep 2025 02:17:26 +0800
X-Gm-Features: Ac12FXyoPo1ppk3ETOoVUD0hcfsBLMqtHEJk2Q71pbsaNPHE5LxHxuxlF_aulQI
Message-ID: <CAMgjq7AT79NfcKtsfgOi6LQJViXOz-Xs5LOUmOiJYJS-DwQg=A@mail.gmail.com>
Subject: Re: [PATCH 2/9] mm, swap: always lock and check the swap cache folio
 before use
To: Chris Li <chrisl@kernel.org>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>, Barry Song <baohua@kernel.org>, 
	Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	David Hildenbrand <david@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 30, 2025 at 9:54=E2=80=AFAM Chris Li <chrisl@kernel.org> wrote:
>
> On Wed, Aug 27, 2025 at 7:36=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wr=
ote:
> >
> > On Wed, Aug 27, 2025 at 4:21=E2=80=AFPM Chris Li <chrisl@kernel.org> wr=
ote:
> > >
> > > On Fri, Aug 22, 2025 at 12:21=E2=80=AFPM Kairui Song <ryncsn@gmail.co=
m> wrote:
> > >
> > > > diff --git a/mm/shmem.c b/mm/shmem.c
> > > > index e9d0d2784cd5..b4d39f2a1e0a 100644
> > > > --- a/mm/shmem.c
> > > > +++ b/mm/shmem.c
> > > > @@ -2379,8 +2379,6 @@ static int shmem_swapin_folio(struct inode *i=
node, pgoff_t index,
> > > >                         count_vm_event(PGMAJFAULT);
> > > >                         count_memcg_event_mm(fault_mm, PGMAJFAULT);
> > > >                 }
> > > > -       } else {
> > > > -               swap_update_readahead(folio, NULL, 0);
> > >
> > > Also this update readahead move to later might have a similar problem=
.
> > > All the bail out in the move will lose the readahead status update.
> > >
> > > The readahead deed is already done. Missing the status update seems
> > > incorrect.
> >
> > Thanks for the detailed review.
> >
> > The only change I wanted here is that swap readahead update should be
> > done after checking the folio still corresponds to the swap entry
> > triggering the swapin. That should have slight to none effect compared
> > to before considering the extremely tiny time window. We are only
> > following the convention more strictly.
> >
> > In theory it might even help to reduce false updates: if the folio no
> > longer corresponds to the swap entry, we are hitting an unrelated
> > folio, doing a readahead update will either mislead vma readahead's
> > address hint, or could clean up the readahead flag of an unrelated
> > folio without actually using it. If the folio does get hit in the
> > future, due to the missing readahead flag, the statistic will go
> > wrong.
>
> So the missing readahead stats update behavior is the correct and
> better behavior. I suggest you spit that out as a separate patch with
> appropriate comments about it too. It is also easier to bisect the
> commit if that kind of the subtle change which is considered safe
> turns out causing a problem. Causing problem not happen very often but
> it does happen before.
>

Hmm, after a second thought, maybe we should keep it as it is for now.

I just realized moving the swap_update_readahead after folio_lock is
more than just ensuring the folio is still valid. It will also cause
every swapin to do a readahead update. Previously, only cache hit
swapin will do a swap readahead update.

I did some tests, and didn't see any measurable performance difference
between putting it before / after the folio_lock. But changing it for
no good reason seems not a good idea after all.

So I think I'll keep it before the folio_lock. There is no evidence of
which strategy is better, just keep the current behaviour.

Calling swap_update_readahead even if the swap cache folio
is already invalidated is not really harmful, the only thing it does
that may effect the folio is the folio_test_clear_readahead call in
it, and we have been doing for years with no problem. Calling
swap_update_readahead for every folio might not be a good idea.

