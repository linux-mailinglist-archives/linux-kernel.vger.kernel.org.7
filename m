Return-Path: <linux-kernel+bounces-752304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2638B173C9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 17:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F6011718A4
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 15:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364E11D54FA;
	Thu, 31 Jul 2025 15:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u0CH1QBK"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984E21A841A
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 15:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753974526; cv=none; b=KIzAVYCuCpeereVfav1ZlwCRlbImh+XvZxRoSdIHoDxxgL1jU9oSsHXSSp/R8zf4qgvYoXhs+2AD/Q7FsYP6AFcA67iXDqxW9Oel38O7raeViWllYJiBdn9InU1aHpbT4Q1/94HOk6Vyd1lKr/JyhfBhqrmC2h6AfsRFVNFGe6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753974526; c=relaxed/simple;
	bh=5Ch2EPDaL3/YaRiCeHOGVQTgZRs5/v0F0jy2C1yq1fI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KS41Qs6f/Mas9ezjxmzesMVwe8LLQaUgmBlC1/CvsGF+JXhpFW0L5PNkD0Rx8W4UXy6+f4iPfzA62Ogm8i1IssRWs3qazaIxMv7ENBRhRsbhdQHt8FAPceAxjO2FOTgGh92MstMyI3Kg2at1rliCX9B3g36VU8kjD3HxzBExvIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u0CH1QBK; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5f438523d6fso10645a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 08:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753974523; x=1754579323; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zmMz7Y87iVAn/fXyg5XDVIpHc/uVHLJxWrjG1qWFlkA=;
        b=u0CH1QBKjfbrrtljROo8rlBWLGT9zMu1N1YJVzxY8Ue62XsVym+33kEyqiLUz7FBC9
         EL6L7Hbs3M7xGQypER57SUMe5i0jeVpwMIrhYnmnkjaEoPIFTz+GM8kufj2zP32ljhZk
         nrbjL2Kali9M/geqDbdMNdrPorf4o0uZrWYygvSqrv1Kw75sSrQUI+3yWoeuiX1gVw8n
         gTOjHOIsYkQsWR0D9yDUEta7M1pz29lLqrg1TBKeP9aFlpnU1oY60mS1ilT2f7yBH0+B
         dfGSsGfBMUG/urMOgHrXXE9lKmaJhCd+1O1QqvF0orxp5CcLpEryHZ1rvyFw53W0yh00
         2ddw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753974523; x=1754579323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zmMz7Y87iVAn/fXyg5XDVIpHc/uVHLJxWrjG1qWFlkA=;
        b=k20E6adRZPcVRGUwqw1ZCZ23bzC0XwU9y0NyPhcGRJ0hdhmowJEIK6WX/0MqC8LpxN
         nf+1OS2u1cHVpnfDHihmap0pWF17JlzaIgv/X9wZHb7aOaVzd6v0XlZaqHM5ymV1YU8z
         fLKvusFE2KVO7tg6/+Yok1Kf1GYZjwU02zh0Xp5b55CQUwh8Cltf4my6cyZhYgguMeYA
         sTseFViO8ZeHjOsav4IAf/KZw7oZ/0T74Qk7z3MmwmtrKT7khzc5zp1xtaR+oso03cIp
         x0+D4rkKs+0A5XDqDWXiiwe0u2unvAJTc8yMDR44ojToahWtm9FWa9j/eWl/VL/0lo+j
         IdwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXB/FnwF+gS4n2YkOtReGT5Dt7+2O0tMt/juUR3RpK1oHRjotJ3eXzO9V36ZMwRCM3dEZ1YwkD348cnW/E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNcnsHed/WQ+z8jFwcG9M0qZq+SxsH/2WOvJW0qPgQThG5Xcwf
	jzwIlioBgQyBiO/fXtDLGWxhEBG4RMDSyhT1p8aUp+cPgNz1h/quJezLmS8nYEFuJQYE8KpKK+q
	LgglWnl165oDBNP9xdydLyDZSQXqvnm4kDnX9GqLM
X-Gm-Gg: ASbGncun4bvMUrCtClgABRnIzHPGEOUoWfjc8BeY7aJVGV2+FFCDYLIwkJwkO/M+g2W
	dI0C/0qj+M/m+HcYQunzXTZGrdbFrVbqqT6jG8fmuxYzwjz+t5w7HmOx7pu7TNNxFgjhCu0tbJb
	djN/ulwQF99j2ooTsUT/YM5OGo2AYAmuOvJ/ZNJKhhzqdOAJam/gdFMy/QxyyjoYbMbdCIlKG6M
	ix+nEPpJz9Aj2j/+71PQyKUJb0GAcVfuG7f5szsLQ==
X-Google-Smtp-Source: AGHT+IHpZroMnR8gNbnJ6Hl9Azyb+Hb8r/YpRDMj/t8qAd1gcDSdLIfF7iA0Z5SXN0Jk5/1OoME3F4GcnV0AJtVw4OA=
X-Received: by 2002:a50:d75c:0:b0:607:d206:7657 with SMTP id
 4fb4d7f45d1cf-615ab47613amr78190a12.2.1753974522596; Thu, 31 Jul 2025
 08:08:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730170733.3829267-1-surenb@google.com> <20250731015241.3576-1-hdanton@sina.com>
 <CA+EESO4mkiedqVMCV3fEnB-xeBMKyct1_WA=YDFVbqSGU4F+6A@mail.gmail.com> <CAJuCfpGzazWVYzc9XXh+xTP9R7cMffiP2P4G5OJTQ0-Ji4xFEQ@mail.gmail.com>
In-Reply-To: <CAJuCfpGzazWVYzc9XXh+xTP9R7cMffiP2P4G5OJTQ0-Ji4xFEQ@mail.gmail.com>
From: Lokesh Gidra <lokeshgidra@google.com>
Date: Thu, 31 Jul 2025 08:08:30 -0700
X-Gm-Features: Ac12FXxDR_jDXV2_itlIrHvfQvtXRY2GLBRhyzMxKRUo0_JmXQBqs2eQDyu-PXM
Message-ID: <CA+EESO7axBaw7zWhG=Asuu3d5mR+QMw=cht64xdGdJGi7URhsg@mail.gmail.com>
Subject: Re: [PATCH 1/1] userfaultfd: fix a crash when UFFDIO_MOVE handles a
 THP hole
To: Suren Baghdasaryan <surenb@google.com>
Cc: Hillf Danton <hdanton@sina.com>, akpm@linux-foundation.org, peterx@redhat.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, 
	syzbot <syzbot+b446dbe27035ef6bd6c2@syzkaller.appspotmail.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 31, 2025 at 7:24=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Thu, Jul 31, 2025 at 12:35=E2=80=AFAM Lokesh Gidra <lokeshgidra@google=
.com> wrote:
> >
> > On Wed, Jul 30, 2025 at 6:58=E2=80=AFPM Hillf Danton <hdanton@sina.com>=
 wrote:
> > >
> > > #syz test
> > >
> > > When UFFDIO_MOVE is used with UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES and it
> > > encounters a non-present THP, it fails to properly recognize an unmap=
ped
> > > hole and tries to access a non-existent folio, resulting in
> > > a crash. Add a check to skip non-present THPs.
> > >
> > Thanks Suren for promptly addressing this issue.
> >
> > > Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
> > > Reported-by: syzbot+b446dbe27035ef6bd6c2@syzkaller.appspotmail.com
> > > Closes: https://lore.kernel.org/all/68794b5c.a70a0220.693ce.0050.GAE@=
google.com/
> > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > Cc: stable@vger.kernel.org
> > > ---
> > >  mm/userfaultfd.c | 38 +++++++++++++++++++++++---------------
> > >  1 file changed, 23 insertions(+), 15 deletions(-)
> > >
> > > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > > index cbed91b09640..60be8080ddd0 100644
> > > --- a/mm/userfaultfd.c
> > > +++ b/mm/userfaultfd.c
> > > @@ -1818,27 +1818,35 @@ ssize_t move_pages(struct userfaultfd_ctx *ct=
x, unsigned long dst_start,
> > >
> > >                 ptl =3D pmd_trans_huge_lock(src_pmd, src_vma);
> > >                 if (ptl) {
> > > -                       /* Check if we can move the pmd without split=
ting it. */
> > > -                       if (move_splits_huge_pmd(dst_addr, src_addr, =
src_start + len) ||
> > > -                           !pmd_none(dst_pmdval)) {
> > > -                               struct folio *folio =3D pmd_folio(*sr=
c_pmd);
> > > +                       if (pmd_present(*src_pmd) || is_pmd_migration=
_entry(*src_pmd)) {
> > > +                               /* Check if we can move the pmd witho=
ut splitting it. */
> > > +                               if (move_splits_huge_pmd(dst_addr, sr=
c_addr, src_start + len) ||
> > > +                                   !pmd_none(dst_pmdval)) {
> > > +                                       if (pmd_present(*src_pmd)) {
> > > +                                               struct folio *folio =
=3D pmd_folio(*src_pmd);
> > > +
> > > +                                               if (!folio || (!is_hu=
ge_zero_folio(folio) &&
> > > +                                                              !PageA=
nonExclusive(&folio->page))) {
> > > +                                                       spin_unlock(p=
tl);
> > > +                                                       err =3D -EBUS=
Y;
> > > +                                                       break;
> > > +                                               }
> > > +                                       }
> > >
> > > -                               if (!folio || (!is_huge_zero_folio(fo=
lio) &&
> > > -                                              !PageAnonExclusive(&fo=
lio->page))) {
> > >                                         spin_unlock(ptl);
> > > -                                       err =3D -EBUSY;
> > > -                                       break;
> > > +                                       split_huge_pmd(src_vma, src_p=
md, src_addr);
> > > +                                       /* The folio will be split by=
 move_pages_pte() */
> > > +                                       continue;
> > >                                 }
> > >
> > > +                               err =3D move_pages_huge_pmd(mm, dst_p=
md, src_pmd,
> > > +                                                         dst_pmdval,=
 dst_vma, src_vma,
> > > +                                                         dst_addr, s=
rc_addr);
> > > +                       } else {
> > > +                               /* nothing to do to move a hole */
> > >                                 spin_unlock(ptl);
> > > -                               split_huge_pmd(src_vma, src_pmd, src_=
addr);
> > > -                               /* The folio will be split by move_pa=
ges_pte() */
> > > -                               continue;
> > > +                               err =3D 0;
> > I think we need to act here depending on whether
> > UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES is set or not.
>
> Hmm, yes, I think you are right. I thought we would bail out earlier
> if !UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES but I think it's possible to get
> here if the PMD was established earlier but then unmapped.

That makes sense too. My thinking was that the
!UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES check above is only when !src_pmd,
which means the src pmd-page itself isn't present. However, the case
where pmd-page is present, but the pmd entry is not; continuing
skipping the hole even when user cannot tolerate src-holes would break
the userspace logic.
>
> >
> >            err =3D (mode & UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES) ? 0 : -ENO=
ENT;
> >
> > Also, IMO, the step_size in this case should be the minimum of
> > remaining length and HPAGE_PMD_SIZE.
>
> Ah, ok. I think it matters only for incrementing "moved" correctly
> because otherwise the functionality is the same.
>
Right. Returning an incorrect "moved" value to userspace can break the
logic, possibly causing data corruption.

> > >                         }
> > > -
> > > -                       err =3D move_pages_huge_pmd(mm, dst_pmd, src_=
pmd,
> > > -                                                 dst_pmdval, dst_vma=
, src_vma,
> > > -                                                 dst_addr, src_addr)=
;
> > >                         step_size =3D HPAGE_PMD_SIZE;
> > >                 } else {
> > >                         if (pmd_none(*src_pmd)) {
> > I have a related question/doubt: why do we populate the page-table
> > hierarchy on the src side [1] (and then also at line 1857) when a hole
> > is found? IMHO, it shouldn't be needed. Depending on whether
> > UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES is set or not, it should either
> > return -ENOENT, or continue past the hole. Please correct me if I'm
> > wrong.
>
> I thought about that too. I think it's done to simplify the logic.
> This way we can treat the cases when PMD was never allocated and when
> PMD was allocated, mapped and then unmapped the same way.
>
Makes sense. Thanks for clarifying.
> >
> > [1] https://elixir.bootlin.com/linux/v6.16/source/mm/userfaultfd.c#L179=
7
> >
> > >
> > > base-commit: 01da54f10fddf3b01c5a3b80f6b16bbad390c302
> > > --
> > > 2.50.1.552.g942d659e1b-goog

