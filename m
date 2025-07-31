Return-Path: <linux-kernel+bounces-752260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCEA8B17334
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 16:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBD203B0803
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 14:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14F61547EE;
	Thu, 31 Jul 2025 14:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Urfy7wUB"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32D67263D
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 14:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753971848; cv=none; b=cLVqrILeH3IqnIuiKNKpoiAXt5Wq5JdxjlRhACsdwjQ6Lc+a85rZV0NRNgDQaKztg7EBJDxJGJ6JKzhrGnhoThFRfyf+wffpX2qPoCyWiRUfLOgDpnFN1OZo7sydbG4WaCJuxS8NJuDwiMVa+tO80jk/rFec+5OEPbdav+Q9LvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753971848; c=relaxed/simple;
	bh=2zcrs1xswIA1l7tTfNbMKxV75YXhdUEj7fyBQro4ue0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nRbL2c+vZgKFFeb2xidFrNnmsaFvpVRRc++sYBNY0FnSSXSLeF+lMtHSghl5ht0nG3tMsqkrYWUZcx1+oTyCXX6H88MWvV4dSU0RL0QP2D+0E7RlT4qH8UjfckZBEjN/lKrSgRbCOkxJ0MdFBz/VTMLemkgvz3/FUrgV1qBMtww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Urfy7wUB; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4ab3ad4c61fso405621cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 07:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753971845; x=1754576645; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CaEPQlDrJ3xUdOaNniHVDx2+n9iGAETTjj86f/r2NQg=;
        b=Urfy7wUBRNXK1SXcj5S6UCg4eCQBIib9qFDFicziStrkJIaNnTbIatwjfIxDl7rze8
         /gQRbaJbd2FasYpTWASNdVOGBus2itigJ0+AUv+K6MnOPZdm4YFzWEUeRQE76Em9mFcb
         IP3N68UeED4Jo86QUQBSklnfmjmWTMh9+xxm1YMYSEWIud6lWHM+48jDbrHX1SnV9Wle
         x2zP+PxvaoMc+SsBfR+qaGyzCKAKajXPE7V4/diutie2WyUMx5dw8YDqzL0lyhXsXq6q
         7Q2+/SHhQawWaobWLjUr2cxXPcwsnSOrtYF6ZnJ4mMJrAnv443fFMJFLu+dsdp2qZ9kt
         YxNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753971845; x=1754576645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CaEPQlDrJ3xUdOaNniHVDx2+n9iGAETTjj86f/r2NQg=;
        b=VF5YMVaYmXwn7rzYZ3SCZeyHBn+D9kYD//gnNUt2BJzdprMtBp35IIK7o0x6PMDRyB
         PPDTUkwzM1ayzXh80ea5I49Bd8g29fCZpKQIN53NrWQO2M9PQ2HAXmHOTbOsNr1FlowD
         rQU2scx4X0LYNKGMhzifAtQZcBaXfvDmuQfvR1eBioThj8k1kJyZyhZKENoJoEy8sX7w
         y7jk/gVkgfm7koqh4sUp6dcBXOio50txGxzItTH2+vnQLKRXw68XQrC0CqWtLami96U+
         RUdNBjmgyWiFlNW5NH4jkUXt+q1HHkQy31AcOWZq8+CM2brrCcFkWrRpLl/nEaMXwJMe
         MXbA==
X-Forwarded-Encrypted: i=1; AJvYcCUNWjB6KKON43lhnVC8gFfrJ8oB2nTlcWA3kD2jxa2TAdMEzpQlaGoDNnECKnql2ODboC+OnRBR1Nim+xY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTCmqZlrPaqjbHdmTwxba8qGl8qgu4eY7ktldMIRGOSadrKz34
	9cZayJ4uIpeQKlQkw8SXoTISFNrkeF0svIcoufbLWWRF3cvIjiA8pmSCi6IRP5Cis9U6ulVOF5d
	TBZEWk4Yp5pd8dcngtH8E2AH2nL+xEwGnvcKVF2Wp
X-Gm-Gg: ASbGncuewijkt/w4vSy3dVAr+wGLCyfL6xPTkTdtMs/ERS6tLOdi3yJiNzp864/ItK/
	2rKp4KZQ6JZdACf0knEOaXEugOWjrMLESTycpk8pBzFDzPNPS0okKtII1fZqX+u8RZBsdQeW+g3
	qYOREacfvk9ibBI1JansftJD5JucC9aEkC8JdLAy0y5eyqeoQFjv3jmn+PxiHK1YolkCtYLRA27
	nP7kBfc2/uAeTHjY3ZyAXpFez4iDr5za8ezAg==
X-Google-Smtp-Source: AGHT+IH+U7W48iIJwZXQgQOQ/vHHdTop5m5TFsH8fhOVp61+aOVc0QiEilGP1nFKe1yRkmhH6wUYo0aGLXGz+zulmMk=
X-Received: by 2002:ac8:7f14:0:b0:4a8:19d5:e9bb with SMTP id
 d75a77b69052e-4aef1c60a48mr2832411cf.13.1753971845017; Thu, 31 Jul 2025
 07:24:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730170733.3829267-1-surenb@google.com> <20250731015241.3576-1-hdanton@sina.com>
 <CA+EESO4mkiedqVMCV3fEnB-xeBMKyct1_WA=YDFVbqSGU4F+6A@mail.gmail.com>
In-Reply-To: <CA+EESO4mkiedqVMCV3fEnB-xeBMKyct1_WA=YDFVbqSGU4F+6A@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 31 Jul 2025 07:23:54 -0700
X-Gm-Features: Ac12FXy9AeUURppfkgynMqQjKLG3IYh8hvItem-Sdjqlh2M8Jm5M7zE6NTKVTE4
Message-ID: <CAJuCfpGzazWVYzc9XXh+xTP9R7cMffiP2P4G5OJTQ0-Ji4xFEQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] userfaultfd: fix a crash when UFFDIO_MOVE handles a
 THP hole
To: Lokesh Gidra <lokeshgidra@google.com>
Cc: Hillf Danton <hdanton@sina.com>, akpm@linux-foundation.org, peterx@redhat.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, 
	syzbot <syzbot+b446dbe27035ef6bd6c2@syzkaller.appspotmail.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 31, 2025 at 12:35=E2=80=AFAM Lokesh Gidra <lokeshgidra@google.c=
om> wrote:
>
> On Wed, Jul 30, 2025 at 6:58=E2=80=AFPM Hillf Danton <hdanton@sina.com> w=
rote:
> >
> > #syz test
> >
> > When UFFDIO_MOVE is used with UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES and it
> > encounters a non-present THP, it fails to properly recognize an unmappe=
d
> > hole and tries to access a non-existent folio, resulting in
> > a crash. Add a check to skip non-present THPs.
> >
> Thanks Suren for promptly addressing this issue.
>
> > Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
> > Reported-by: syzbot+b446dbe27035ef6bd6c2@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/all/68794b5c.a70a0220.693ce.0050.GAE@go=
ogle.com/
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > Cc: stable@vger.kernel.org
> > ---
> >  mm/userfaultfd.c | 38 +++++++++++++++++++++++---------------
> >  1 file changed, 23 insertions(+), 15 deletions(-)
> >
> > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > index cbed91b09640..60be8080ddd0 100644
> > --- a/mm/userfaultfd.c
> > +++ b/mm/userfaultfd.c
> > @@ -1818,27 +1818,35 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx,=
 unsigned long dst_start,
> >
> >                 ptl =3D pmd_trans_huge_lock(src_pmd, src_vma);
> >                 if (ptl) {
> > -                       /* Check if we can move the pmd without splitti=
ng it. */
> > -                       if (move_splits_huge_pmd(dst_addr, src_addr, sr=
c_start + len) ||
> > -                           !pmd_none(dst_pmdval)) {
> > -                               struct folio *folio =3D pmd_folio(*src_=
pmd);
> > +                       if (pmd_present(*src_pmd) || is_pmd_migration_e=
ntry(*src_pmd)) {
> > +                               /* Check if we can move the pmd without=
 splitting it. */
> > +                               if (move_splits_huge_pmd(dst_addr, src_=
addr, src_start + len) ||
> > +                                   !pmd_none(dst_pmdval)) {
> > +                                       if (pmd_present(*src_pmd)) {
> > +                                               struct folio *folio =3D=
 pmd_folio(*src_pmd);
> > +
> > +                                               if (!folio || (!is_huge=
_zero_folio(folio) &&
> > +                                                              !PageAno=
nExclusive(&folio->page))) {
> > +                                                       spin_unlock(ptl=
);
> > +                                                       err =3D -EBUSY;
> > +                                                       break;
> > +                                               }
> > +                                       }
> >
> > -                               if (!folio || (!is_huge_zero_folio(foli=
o) &&
> > -                                              !PageAnonExclusive(&foli=
o->page))) {
> >                                         spin_unlock(ptl);
> > -                                       err =3D -EBUSY;
> > -                                       break;
> > +                                       split_huge_pmd(src_vma, src_pmd=
, src_addr);
> > +                                       /* The folio will be split by m=
ove_pages_pte() */
> > +                                       continue;
> >                                 }
> >
> > +                               err =3D move_pages_huge_pmd(mm, dst_pmd=
, src_pmd,
> > +                                                         dst_pmdval, d=
st_vma, src_vma,
> > +                                                         dst_addr, src=
_addr);
> > +                       } else {
> > +                               /* nothing to do to move a hole */
> >                                 spin_unlock(ptl);
> > -                               split_huge_pmd(src_vma, src_pmd, src_ad=
dr);
> > -                               /* The folio will be split by move_page=
s_pte() */
> > -                               continue;
> > +                               err =3D 0;
> I think we need to act here depending on whether
> UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES is set or not.

Hmm, yes, I think you are right. I thought we would bail out earlier
if !UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES but I think it's possible to get
here if the PMD was established earlier but then unmapped.

>
>            err =3D (mode & UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES) ? 0 : -ENOEN=
T;
>
> Also, IMO, the step_size in this case should be the minimum of
> remaining length and HPAGE_PMD_SIZE.

Ah, ok. I think it matters only for incrementing "moved" correctly
because otherwise the functionality is the same.

> >                         }
> > -
> > -                       err =3D move_pages_huge_pmd(mm, dst_pmd, src_pm=
d,
> > -                                                 dst_pmdval, dst_vma, =
src_vma,
> > -                                                 dst_addr, src_addr);
> >                         step_size =3D HPAGE_PMD_SIZE;
> >                 } else {
> >                         if (pmd_none(*src_pmd)) {
> I have a related question/doubt: why do we populate the page-table
> hierarchy on the src side [1] (and then also at line 1857) when a hole
> is found? IMHO, it shouldn't be needed. Depending on whether
> UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES is set or not, it should either
> return -ENOENT, or continue past the hole. Please correct me if I'm
> wrong.

I thought about that too. I think it's done to simplify the logic.
This way we can treat the cases when PMD was never allocated and when
PMD was allocated, mapped and then unmapped the same way.

>
> [1] https://elixir.bootlin.com/linux/v6.16/source/mm/userfaultfd.c#L1797
>
> >
> > base-commit: 01da54f10fddf3b01c5a3b80f6b16bbad390c302
> > --
> > 2.50.1.552.g942d659e1b-goog

