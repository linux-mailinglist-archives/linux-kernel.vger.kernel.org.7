Return-Path: <linux-kernel+bounces-753648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D54DB185ED
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 18:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E49B91C2728F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 16:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024301A23A0;
	Fri,  1 Aug 2025 16:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VpOLIIL5"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953491E50E
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 16:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754066507; cv=none; b=beFrb6syNVuYJ+EuSrE2vsbdT6T6jS8oTzTqVyhJLcPEDWFL6emIOYtomQcECTUfLYsKjs1plXjJ3ISJ8aHhMR6Tj26TTbYzkx/PG0FUPrkADPSnBy0sUHj+AyHocygRMuY+pRKKQTv9L5zvA5lQE+IkV0PdXM72907jvjL/d9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754066507; c=relaxed/simple;
	bh=8qvdgAa45Q6rq5FrE69BAnygyw7IJ0lO5MKA6CRJorQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AUsC7Zj/+TIMnpTAHnULWt5c452Bnt6YLTnKrMDk4yWkkWLAnytYwpoeKEpdlSQ5PHsJR9Smuwu+jbvxwUT955cos4vwBOYTWGdBaKHJcoYBMvQrmtfLdSBM/X0HQ4mOg4mReuy+qKUuA6W2iU3/3ZUDii0x9QnmO+Y0UT7X0KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VpOLIIL5; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4aef56cea5bso217181cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 09:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754066503; x=1754671303; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aLimaLSF0lRymehoPqMxWNX91cMbYtFkQRKb1ah50F4=;
        b=VpOLIIL54IFZHBp/p7X2vocMCe/EktUfPzAsEhwAdvmiAEpda/AOG82Xekv6pVoF3A
         /xq32s+LXPFUraOkEBlz6qqbJlFExg5Ixus4wfYaCIUoM/jci2Zjo5dZKkWYdF9gmIPr
         HMHtfMVQ+Yhxh5NZSb8MZwnvPmO6IUBZO71DgIbLAk3kCNd1o63b2QwlUlAuxqZE/GQB
         dS2ANnOzyX4rXkoNoetc9R5gxzCyp2BkRdbAFhq5ebHmm/EOxvSgBYuH3hPFt5IqCJe+
         MhXEzhSC20fBkqfONQhTnsEM56wApEy1VrejwbqHtaDEFnE8XdZcUO30o2hv3tnQlbI/
         EDIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754066503; x=1754671303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aLimaLSF0lRymehoPqMxWNX91cMbYtFkQRKb1ah50F4=;
        b=pxU3H0wWwcTgAhwvTXC0MsdBySXa+MeJ0eZBFovbmsgd3lCk8GQtYPGJog/p/ILoSa
         BFt5VuuQQm7LvCfrj5aNWxciuqHdg+HQSDH6xXpmJMie4z+uBGHprof+Ai1rL6KEvWvo
         L4u8PsRr1BFx2cPDCRXfRVfCMs8qgVlETuCv49bJbjfb8F2aWNee68557DkzWkoeDzms
         9kfC3FdTsPfaiOlbQ4LgrmxXAb0Vf0A3orMrCBWHpN5xMQT1dew1z24NIvTVpbFjIjqG
         gXFmXvdCoRQzzNGLGQqm2Lhhb2ceQp0Av8Dr22cff5hl1FgNyTGUDj/POL0qUt/CIFWO
         SxlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvm6RITfzow4jfYahOmn6tMKBYAPpbPCdRg7uupuVELLNfY/yTBGSZo5IDpbXcjqucrUsJN++w99V1dEY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq02+55XlLfWVoQPVlmeIY57BTPPVx2fam8c0UOZzOCgiYjbFd
	gp47MEyHNIJA1FCiMsJmzxG5x7VO/5lFuyK81795BDwNCHrN7FJCd//HRop/eLBQWrhm5UrNABt
	/ys1/Zd0v+EbHLeHQY7AMjZ2GgvS7LCC6m7ZdZTRppRt/2LjTDU8wkJEewsA=
X-Gm-Gg: ASbGncu25GiopYsCzkMEJ/a9TMMvqdtpRlZiqvjJ3gvP+5guYh4o6NDtNm3nriyrtZx
	ms8UPEg7aN96YRz6ffND3ruxtzMCNDo6Gkq/eOnABTStMZZUm4N/1WPLVllI+Qsts/wfSloL8RD
	I/o+QcYrfzeo3ZrOOWQbo83xnNmkSZoQBlwUOETN9QZ3MNZL4mNE6uY7Ad3XPqyY3+HG+9euebZ
	NEt1A==
X-Google-Smtp-Source: AGHT+IEpaLl/A+9aL/diYC+pE/kX9Ys6qSrIphoEP7QJcRER5WfcbYHZMpuH0caPX2vRoiH3NPCvKbvZRwD9xI3Pl5s=
X-Received: by 2002:ac8:5d94:0:b0:48a:ba32:370 with SMTP id
 d75a77b69052e-4aefe36d9fdmr6003651cf.10.1754066502880; Fri, 01 Aug 2025
 09:41:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250731154442.319568-1-surenb@google.com> <d2b6be85-44d5-4a87-bfe5-4a9e80f95bb8@redhat.com>
 <aIzMGlrR1SL5Y_Gp@x1.local> <CAJuCfpEqOUj8VPybstQjoJvCzyZtG6Q5Vr4WT0Lx_r3LFVS7og@mail.gmail.com>
 <aIzp6WqdzhomPhhf@x1.local>
In-Reply-To: <aIzp6WqdzhomPhhf@x1.local>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 1 Aug 2025 09:41:31 -0700
X-Gm-Features: Ac12FXypqQI2y88pBWYtFSUzrdqaOmVf2bSfcWinVsHrN_bkOmTXLjklNn0Swe0
Message-ID: <CAJuCfpGWLnu+r2wvY2Egy2ESPD=tAVvfVvAKXUv1b+Z0hweeJg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] userfaultfd: fix a crash when UFFDIO_MOVE handles
 a THP hole
To: Peter Xu <peterx@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org, aarcange@redhat.com, 
	lokeshgidra@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	syzbot+b446dbe27035ef6bd6c2@syzkaller.appspotmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 1, 2025 at 9:23=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:
>
> On Fri, Aug 01, 2025 at 08:28:38AM -0700, Suren Baghdasaryan wrote:
> > On Fri, Aug 1, 2025 at 7:16=E2=80=AFAM Peter Xu <peterx@redhat.com> wro=
te:
> > >
> > > On Fri, Aug 01, 2025 at 09:21:30AM +0200, David Hildenbrand wrote:
> > > > On 31.07.25 17:44, Suren Baghdasaryan wrote:
> > > >
> > > > Hi!
> > > >
> > > > Did you mean in you patch description:
> > > >
> > > > "userfaultfd: fix a crash in UFFDIO_MOVE with some non-present PMDs=
"
> > > >
> > > > Talking about THP holes is very very confusing.
> > > >
> > > > > When UFFDIO_MOVE is used with UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES an=
d it
> > > > > encounters a non-present THP, it fails to properly recognize an u=
nmapped
> > > >
> > > > You mean a "non-present PMD that is not a migration entry".
> > > >
> > > > > hole and tries to access a non-existent folio, resulting in
> > > > > a crash. Add a check to skip non-present THPs.
> > > >
> > > > That makes sense. The code we have after this patch is rather compl=
icated
> > > > and hard to read.
> > > >
> > > > >
> > > > > Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
> > > > > Reported-by: syzbot+b446dbe27035ef6bd6c2@syzkaller.appspotmail.co=
m
> > > > > Closes: https://lore.kernel.org/all/68794b5c.a70a0220.693ce.0050.=
GAE@google.com/
> > > > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > > > Cc: stable@vger.kernel.org
> > > > > ---
> > > > > Changes since v1 [1]
> > > > > - Fixed step size calculation, per Lokesh Gidra
> > > > > - Added missing check for UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES, per L=
okesh Gidra
> > > > >
> > > > > [1] https://lore.kernel.org/all/20250730170733.3829267-1-surenb@g=
oogle.com/
> > > > >
> > > > >   mm/userfaultfd.c | 45 +++++++++++++++++++++++++++++------------=
----
> > > > >   1 file changed, 29 insertions(+), 16 deletions(-)
> > > > >
> > > > > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > > > > index cbed91b09640..b5af31c22731 100644
> > > > > --- a/mm/userfaultfd.c
> > > > > +++ b/mm/userfaultfd.c
> > > > > @@ -1818,28 +1818,41 @@ ssize_t move_pages(struct userfaultfd_ctx=
 *ctx, unsigned long dst_start,
> > > > >             ptl =3D pmd_trans_huge_lock(src_pmd, src_vma);
> > > > >             if (ptl) {
> > > > > -                   /* Check if we can move the pmd without split=
ting it. */
> > > > > -                   if (move_splits_huge_pmd(dst_addr, src_addr, =
src_start + len) ||
> > > > > -                       !pmd_none(dst_pmdval)) {
> > > > > -                           struct folio *folio =3D pmd_folio(*sr=
c_pmd);
> > > > > +                   if (pmd_present(*src_pmd) || is_pmd_migration=
_entry(*src_pmd)) {
> > >
> > > [1]
> > >
> > > > > +                           /* Check if we can move the pmd witho=
ut splitting it. */
> > > > > +                           if (move_splits_huge_pmd(dst_addr, sr=
c_addr, src_start + len) ||
> > > > > +                               !pmd_none(dst_pmdval)) {
> > > > > +                                   if (pmd_present(*src_pmd)) {
>
> [2]
>
> > > > > +                                           struct folio *folio =
=3D pmd_folio(*src_pmd);
>
> [3]
>
> > > > > +
> > > > > +                                           if (!folio || (!is_hu=
ge_zero_folio(folio) &&
> > > > > +                                                          !PageA=
nonExclusive(&folio->page))) {
> > > > > +                                                   spin_unlock(p=
tl);
> > > > > +                                                   err =3D -EBUS=
Y;
> > > > > +                                                   break;
> > > > > +                                           }
> > > > > +                                   }
> > > >
> > > > ... in particular that. Is there some way to make this code simpler=
 / easier
> > > > to read? Like moving that whole last folio-check thingy into a help=
er?
> > >
> > > One question might be relevant is, whether the check above [1] can be
> > > dropped.
> > >
> > > The thing is __pmd_trans_huge_lock() does double check the pmd to be =
!none
> > > before returning the ptl.  I didn't follow closely on the recent chan=
ges on
> > > mm side on possible new pmd swap entries, if migration is the only po=
ssible
> > > one then it looks like [1] can be avoided.
> >
> > Hi Peter,
> > is_swap_pmd() check in __pmd_trans_huge_lock() allows for (!pmd_none()
> > && !pmd_present()) PMD to pass and that's when this crash is hit.
>
> First for all, thanks for looking into the issue with Lokesh; I am still
> catching up with emails after taking weeks off.
>
> I didn't yet read into the syzbot report, but I thought the bug was about
> referencing the folio on top of a swap entry after reading your current
> patch, which has:
>
>         if (move_splits_huge_pmd(dst_addr, src_addr, src_start + len) ||
>             !pmd_none(dst_pmdval)) {
>                 struct folio *folio =3D pmd_folio(*src_pmd); <----
>
> Here looks like *src_pmd can be a migration entry. Is my understanding
> correct?

Correct.

>
> > If we drop the check at [1] then the path that takes us to
>
> If my above understanding is correct, IMHO it should be [2] above that
> makes sure the reference won't happen on a swap entry, not necessarily [1=
]?

Yes, in case of migration entry this is what protects us.

>
> > split_huge_pmd() will bail out inside split_huge_pmd_locked() with no
> > indication that split did not happen. Afterwards we will retry
>
> So we're talking about the case where it's a swap pmd entry, right?

Hmm, my understanding is that it's being treated as a swap entry but
in reality is not. I thought THPs are always split before they get
swapped, no?

> Could you elaborate why the split would fail?

Just looking at the code, split_huge_pmd_locked() checks for
(pmd_trans_huge(*pmd) || is_pmd_migration_entry(*pmd)).
pmd_trans_huge() is false if !pmd_present() and it's not a migration
entry, so __split_huge_pmd_locked() will be skipped.

>  AFAIU, split_huge_pmd_locked()
> should still work for a migration pmd entry.

That is correct because the above mentioned is_pmd_migration_entry()
check will pass.

>
> Thanks,
>
> > thinking that PMD got split and leaving further remapping to
> > move_pages_pte() (see the comment before "continue"). I think in this
> > case it will end up in the same path again instead (infinite loop). I
> > didn't test this but from the code I think that's what would happen.
> > Does that make sense?
> >
> > >
> > > And it also looks applicable to also drop the "else" later, because i=
n "if
> > > (ptl)" it cannot hit pmd_none().
> > >
> > > Thanks,
> > >
> > > --
> > > Peter Xu
> > >
> >
>
> --
> Peter Xu
>

