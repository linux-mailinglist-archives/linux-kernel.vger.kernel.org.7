Return-Path: <linux-kernel+bounces-753718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E56B186DE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 19:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 106497ACA0B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 17:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB334287501;
	Fri,  1 Aug 2025 17:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m8U+XqwE"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65811190685
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 17:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754070325; cv=none; b=K7vqS7XCAr8zpoqOGlw7Ya6434AtCKRc+1PY3rHWOJtGMdjtWqznkJUZvNvPFBzBFKXezjAfkMKksvSljLS4Sv4oE1bRfWPkOczkT9EE1WY6gYqi0X5Fp44F8T+NvnNso75o3jLi27on/bYfVJChRnaqcgBiyX7wcqdn7irwiPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754070325; c=relaxed/simple;
	bh=QkxrClDD/r7ObcszWwRaleCIYfCpwoja1Cbr+1AGO/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SpCrv+bmbTu+dcKPsSnK/FqoqK+3FyxdnGJDdeEjk5cqd6w9ey2KufMZiLUuFUzthGWhCYj362EG4BtJYmm2KscScWji3A6uCmwIGvCS+Lq0p9avIw3miCjQbwdJrho7SN9/MpqzpelGFA1IJ2ngkR29LCAz6RQzN1FVT/kzV4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m8U+XqwE; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4aaf43cbbdcso10491cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 10:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754070322; x=1754675122; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i7IQTebdaJ3TqvzAA9sQ8hmg2eU6dzDaIHSRdOARha0=;
        b=m8U+XqwEhR1CvnQe6RuAzEzT8A86zniB87r8+a2UGERJ938mVjrV5TzanHj8+Pwunh
         2mW8S1/CNw84aggtD9cQKt6t93jRB7dzXkXzr2H7f3PYFOh8803nzpGf+RnKD153WxmO
         MJyWuwdIl2tRv+J7XmIQu8glVxsY2TsWUJADW1hx5IhMf2w1WQXyGbWwo7Qz+GYwN2V0
         tOnQgVtuxaXFLDsxQ68biP0udo1bddbMVva/7JPTOQR3wcck/EbJBw87eRmyYEdDYqqj
         sa+abOBb4wtHf6u9HVs8RKgIu3/4qqSBc8ECJm2UwDeP5rMVIaPiONIvrNbTLbRlv/0S
         ETLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754070322; x=1754675122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i7IQTebdaJ3TqvzAA9sQ8hmg2eU6dzDaIHSRdOARha0=;
        b=L5EYFQIHUnlsa8VCCIEZ/B2ziA8G4wE6rEp8I9P1bRVPPpuXRPWVBdwiCNNbW5aLRL
         DLNj5StTqrviSaqn4w8P1KnRjAFKP44fWCw/HOdJbhhwc1yogyBhGA2xdT/gTzINu1Ew
         R/X/XjHWT3ojPi1kdGN5jmlQcmrfj70QSkKt2PwdXQENnmARZq4ZrMSs81RF1qGvywtx
         wrd6i/CmMRi3mEoI5I4KqHXDP+e2D5lmktOiSbmeEkpsxTk1wKH0D9VyHzJpUrJJfwun
         Duq43pKlvHZIeLr6PBPFNNBZ0OGTU4l9dmAkyh+mBiaTT47xO1s85QMS0LXUaAeMbPRi
         xedw==
X-Forwarded-Encrypted: i=1; AJvYcCUAxdEGuqgquYX3+XpohSoVrgac3+j2BxlfL+O0ZGipwDTyQJ+UQ6SppcZylfYlFBuiT8XhVTxaYJHrDzg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLedAtcmQfQIrDIafbhslgtwGOI02QZZdQ1sMwUshs4dLMphju
	PM08cauujpS0OvT3XxPER/fvG1YioomhEIsNZUFuKGDcZ0c50r8Vz7XS5pscPpT52dKkHz+5MEg
	VIh+j+pbdoDih+6yB374labOPy89xFuwiOu4oH3vY
X-Gm-Gg: ASbGncuQ6vdZLdalRCYbkA6P9QUMSqd6Dw89jrdeEZqGxjF0xgP+aaDybfRSeLl+515
	D/W5UOI7t8q6/zTTfKoCyAPZP+8iIZfL0REOotBCXMoFNxzq63GnEGbkdTeZ8JkOR+90od1eIc0
	hX+/D6R6tWXv0CARN2VQfIzXNw0og6yrh1/QcMwDKzPw+h3Z3VRcwVzUbB/q2ZwbrszQK8HNTck
	ge1EmN/nhHuxOz+4XEhK+SCKQmvW9YqT/U=
X-Google-Smtp-Source: AGHT+IE7jTp06+1/B/HvPXKXnzSMflRllAiRRQS5xDxthQyL5W90KUUmbib79VXEYr+Tf3jInm1VMds+8WcQQgIzQnA=
X-Received: by 2002:a05:622a:164b:b0:4a9:a4ef:35c2 with SMTP id
 d75a77b69052e-4af00895293mr5522311cf.23.1754070321651; Fri, 01 Aug 2025
 10:45:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250731154442.319568-1-surenb@google.com> <d2b6be85-44d5-4a87-bfe5-4a9e80f95bb8@redhat.com>
 <aIzMGlrR1SL5Y_Gp@x1.local> <CAJuCfpEqOUj8VPybstQjoJvCzyZtG6Q5Vr4WT0Lx_r3LFVS7og@mail.gmail.com>
 <aIzp6WqdzhomPhhf@x1.local> <CAJuCfpGWLnu+r2wvY2Egy2ESPD=tAVvfVvAKXUv1b+Z0hweeJg@mail.gmail.com>
 <aIz1xrzBc2Spa2OH@x1.local>
In-Reply-To: <aIz1xrzBc2Spa2OH@x1.local>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 1 Aug 2025 17:45:10 +0000
X-Gm-Features: Ac12FXwZOx_WXSa-qtibQWiRqYk9c7J105y71GpiIr-2l8CCMOLx2rXPFV1awyg
Message-ID: <CAJuCfpFJGaDaFyNLa3JsVh19NWLGNGo1ebC_ijGTgPGNyfUFig@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] userfaultfd: fix a crash when UFFDIO_MOVE handles
 a THP hole
To: Peter Xu <peterx@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org, aarcange@redhat.com, 
	lokeshgidra@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	syzbot+b446dbe27035ef6bd6c2@syzkaller.appspotmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 1, 2025 at 5:13=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> On Fri, Aug 01, 2025 at 09:41:31AM -0700, Suren Baghdasaryan wrote:
> > On Fri, Aug 1, 2025 at 9:23=E2=80=AFAM Peter Xu <peterx@redhat.com> wro=
te:
> > >
> > > On Fri, Aug 01, 2025 at 08:28:38AM -0700, Suren Baghdasaryan wrote:
> > > > On Fri, Aug 1, 2025 at 7:16=E2=80=AFAM Peter Xu <peterx@redhat.com>=
 wrote:
> > > > >
> > > > > On Fri, Aug 01, 2025 at 09:21:30AM +0200, David Hildenbrand wrote=
:
> > > > > > On 31.07.25 17:44, Suren Baghdasaryan wrote:
> > > > > >
> > > > > > Hi!
> > > > > >
> > > > > > Did you mean in you patch description:
> > > > > >
> > > > > > "userfaultfd: fix a crash in UFFDIO_MOVE with some non-present =
PMDs"
> > > > > >
> > > > > > Talking about THP holes is very very confusing.
> > > > > >
> > > > > > > When UFFDIO_MOVE is used with UFFDIO_MOVE_MODE_ALLOW_SRC_HOLE=
S and it
> > > > > > > encounters a non-present THP, it fails to properly recognize =
an unmapped
> > > > > >
> > > > > > You mean a "non-present PMD that is not a migration entry".
> > > > > >
> > > > > > > hole and tries to access a non-existent folio, resulting in
> > > > > > > a crash. Add a check to skip non-present THPs.
> > > > > >
> > > > > > That makes sense. The code we have after this patch is rather c=
omplicated
> > > > > > and hard to read.
> > > > > >
> > > > > > >
> > > > > > > Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
> > > > > > > Reported-by: syzbot+b446dbe27035ef6bd6c2@syzkaller.appspotmai=
l.com
> > > > > > > Closes: https://lore.kernel.org/all/68794b5c.a70a0220.693ce.0=
050.GAE@google.com/
> > > > > > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > > > > > Cc: stable@vger.kernel.org
> > > > > > > ---
> > > > > > > Changes since v1 [1]
> > > > > > > - Fixed step size calculation, per Lokesh Gidra
> > > > > > > - Added missing check for UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES, p=
er Lokesh Gidra
> > > > > > >
> > > > > > > [1] https://lore.kernel.org/all/20250730170733.3829267-1-sure=
nb@google.com/
> > > > > > >
> > > > > > >   mm/userfaultfd.c | 45 +++++++++++++++++++++++++++++--------=
--------
> > > > > > >   1 file changed, 29 insertions(+), 16 deletions(-)
> > > > > > >
> > > > > > > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > > > > > > index cbed91b09640..b5af31c22731 100644
> > > > > > > --- a/mm/userfaultfd.c
> > > > > > > +++ b/mm/userfaultfd.c
> > > > > > > @@ -1818,28 +1818,41 @@ ssize_t move_pages(struct userfaultfd=
_ctx *ctx, unsigned long dst_start,
> > > > > > >             ptl =3D pmd_trans_huge_lock(src_pmd, src_vma);
> > > > > > >             if (ptl) {
> > > > > > > -                   /* Check if we can move the pmd without s=
plitting it. */
> > > > > > > -                   if (move_splits_huge_pmd(dst_addr, src_ad=
dr, src_start + len) ||
> > > > > > > -                       !pmd_none(dst_pmdval)) {
> > > > > > > -                           struct folio *folio =3D pmd_folio=
(*src_pmd);
> > > > > > > +                   if (pmd_present(*src_pmd) || is_pmd_migra=
tion_entry(*src_pmd)) {
> > > > >
> > > > > [1]
> > > > >
> > > > > > > +                           /* Check if we can move the pmd w=
ithout splitting it. */
> > > > > > > +                           if (move_splits_huge_pmd(dst_addr=
, src_addr, src_start + len) ||
> > > > > > > +                               !pmd_none(dst_pmdval)) {
> > > > > > > +                                   if (pmd_present(*src_pmd)=
) {
> > >
> > > [2]
> > >
> > > > > > > +                                           struct folio *fol=
io =3D pmd_folio(*src_pmd);
> > >
> > > [3]
> > >
> > > > > > > +
> > > > > > > +                                           if (!folio || (!i=
s_huge_zero_folio(folio) &&
> > > > > > > +                                                          !P=
ageAnonExclusive(&folio->page))) {
> > > > > > > +                                                   spin_unlo=
ck(ptl);
> > > > > > > +                                                   err =3D -=
EBUSY;
> > > > > > > +                                                   break;
> > > > > > > +                                           }
> > > > > > > +                                   }
> > > > > >
> > > > > > ... in particular that. Is there some way to make this code sim=
pler / easier
> > > > > > to read? Like moving that whole last folio-check thingy into a =
helper?
> > > > >
> > > > > One question might be relevant is, whether the check above [1] ca=
n be
> > > > > dropped.
> > > > >
> > > > > The thing is __pmd_trans_huge_lock() does double check the pmd to=
 be !none
> > > > > before returning the ptl.  I didn't follow closely on the recent =
changes on
> > > > > mm side on possible new pmd swap entries, if migration is the onl=
y possible
> > > > > one then it looks like [1] can be avoided.
> > > >
> > > > Hi Peter,
> > > > is_swap_pmd() check in __pmd_trans_huge_lock() allows for (!pmd_non=
e()
> > > > && !pmd_present()) PMD to pass and that's when this crash is hit.
> > >
> > > First for all, thanks for looking into the issue with Lokesh; I am st=
ill
> > > catching up with emails after taking weeks off.
> > >
> > > I didn't yet read into the syzbot report, but I thought the bug was a=
bout
> > > referencing the folio on top of a swap entry after reading your curre=
nt
> > > patch, which has:
> > >
> > >         if (move_splits_huge_pmd(dst_addr, src_addr, src_start + len)=
 ||
> > >             !pmd_none(dst_pmdval)) {
> > >                 struct folio *folio =3D pmd_folio(*src_pmd); <----
> > >
> > > Here looks like *src_pmd can be a migration entry. Is my understandin=
g
> > > correct?
> >
> > Correct.
> >
> > >
> > > > If we drop the check at [1] then the path that takes us to
> > >
> > > If my above understanding is correct, IMHO it should be [2] above tha=
t
> > > makes sure the reference won't happen on a swap entry, not necessaril=
y [1]?
> >
> > Yes, in case of migration entry this is what protects us.
> >
> > >
> > > > split_huge_pmd() will bail out inside split_huge_pmd_locked() with =
no
> > > > indication that split did not happen. Afterwards we will retry
> > >
> > > So we're talking about the case where it's a swap pmd entry, right?
> >
> > Hmm, my understanding is that it's being treated as a swap entry but
> > in reality is not. I thought THPs are always split before they get
> > swapped, no?
>
> Yes they should be split, afaiu.
>
> >
> > > Could you elaborate why the split would fail?
> >
> > Just looking at the code, split_huge_pmd_locked() checks for
> > (pmd_trans_huge(*pmd) || is_pmd_migration_entry(*pmd)).
> > pmd_trans_huge() is false if !pmd_present() and it's not a migration
> > entry, so __split_huge_pmd_locked() will be skipped.
>
> Here might be the major part of where confusion came from: I thought it
> must be a migration pmd entry to hit the issue, so it's not?
>
> I checked the code just now:
>
> __handle_mm_fault:
>                 if (unlikely(is_swap_pmd(vmf.orig_pmd))) {
>                         VM_BUG_ON(thp_migration_supported() &&
>                                           !is_pmd_migration_entry(vmf.ori=
g_pmd));
>
> So IIUC pmd migration entry is still the only possible way to have a swap
> entry.  It doesn't look like we have "real" swap entries for PMD (which c=
an
> further points to some swapfiles)?

Correct. AFAIU here we stumble on a pmd entry which was allocated but
never populated.

>
> --
> Peter Xu
>

