Return-Path: <linux-kernel+bounces-753570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23986B184B1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 17:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5EAD1624F7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 15:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B9D26D4DE;
	Fri,  1 Aug 2025 15:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3ONOnTNS"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D80A4690
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 15:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754061130; cv=none; b=lZoQ86LFmzkwfKdyyIkZzx0Vn91Tti1tjG614Pp7uh0eSfS67ZHXpHqUpiwu7fqMjozpQrrYA4cjqdINLPySu0D0uCvIy4VjmOiSVz9aGZea93d2kJPdufct9QMUHuezDjrJBBa/1v9TQ3UngNRp2u0e6fefcDvTJBRvmK/0TiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754061130; c=relaxed/simple;
	bh=fxFG5jnZ4dMkX4nyXGKB5dGsWGN4AxI6xsEXNzeIaLI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FSZHUlLTQvG/zZcuIYjXkHlb9abBiw5ojs3Wh/WXuaYo3day3u4ljT5+OfuOyof2zLzUmFFxl6DZ0EqMTbqk/y61uBUa+IEeTRX4XuwFar+Q0pJtkX55WSXhPFAGm1hVPrQeKJKxCMcYtXOHAYkKIGroCkoDtX2HduXUuBNZh7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3ONOnTNS; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4aef56cea5bso186881cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 08:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754061127; x=1754665927; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SoCvDf2STWqjlVzd+8uazfHv+yAfec07kh2ZhHKg+3g=;
        b=3ONOnTNSNDLDqYzXxHbxbKN0GAlOnk1xy6zYNVVrOGB9TOoWGha6lcCm/sMwBT70rH
         DGZq41cI1l6uQHUu9HeHIuRFJxgkI1n4lt9wTo3gmmW7+cPxFcTLR53/edDu337duVZ+
         fAQdbyAJkf7AtJsBY8/M5TE4DaabSV6iJ5ZZtVf9CIpIhQLLQfF/qxo3HOvouFxbPzTm
         pC2Kf+s056NOfEUow1qZLuAgpImtwcrlkPYnubKyqL4RC4MNYYROsjckrjDFirn5UQcD
         7QD+ib+jHwpJD4RgFc+REQMUqVSVOioiY+ykOglp7KjdGd+Rdxlx9WRWCZLNtFqUG6Yw
         dqUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754061127; x=1754665927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SoCvDf2STWqjlVzd+8uazfHv+yAfec07kh2ZhHKg+3g=;
        b=UJW/fXZfoPOHLCOPnmgAR3Iqn1yvdzyXdxeiJLLOcBL06avT7fo6T5FZIWY4RuRbAi
         IMAxtTgJg+WSxLl5txnibt3aq0TvHWYxHAcwc/cBPDgbfSJERnteHOUHivKJ4Erx1w6/
         z7pA9tp/2Anx3MmshCD3ROVD9K4wLNlUirZS6kQjepW6yQ9Qtw9B6qXg9NYamCHAbc10
         jiLYEhlDxFeP2o4wqO1034vZN91j7OBW4qu2rwzOuc5bqM97Pwz/JuXOoB6mUo5C0jpX
         NLCBrtQKzcQUdMvrZ1Yl5hgDUVjp+KEztEredWyHvIrGF2Aw6mOKvqepwWG4Z0Ejl+c9
         dzLg==
X-Forwarded-Encrypted: i=1; AJvYcCXkSD1CrSMWebArKCLpW38gKL7d+bpmWqSfKRJQ0motWndPRBN9LUwegVuibxBeAiBsbloonNpy2MOlO+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR82p1Uh6ALzfehk+KGN68sRLf578oi6D+oa3xFiskXIrrR13P
	5iyGZ8mLOoFhuONpdk22Tj1nE60rHnEVN2JPFp/QGnCWatgCU8l2F1la7fbkjp2+a4T3p3nojSf
	wOybNno/2y2N2KAdl9MZabkvaepr02nq908bKc70y
X-Gm-Gg: ASbGncvOhpd06AufchKb8KMU62fm667JpkjOg1yLHc1BMsKxG+GYGQxq6adn40Tf8mP
	NpnMp2zoQ5aGgIlDJKj/yigFuPpLrOXpZ+jwsSTwqy6e2SXPZQtWosY8o6tu9dQgzLjQsxTUFZG
	7T5S46U7EF/MZKKSQqWaQO5Cq65Ny77ApVW8X5Qu4weFKnWvqKYNAPKRqxalhVav2oH/IMlNskN
	VxmI3NZ0s9S+CzZgckpCnCqBpcF2dirlF65TA==
X-Google-Smtp-Source: AGHT+IEcXXFNQJXhQXaLDDs9kA4bqVnd84TK3sznmDH2mazS4z6rzXjrqdGlkijgDyhkzMQKRWnLp921znoYXPeBhuo=
X-Received: by 2002:a05:622a:86:b0:4ae:e478:268d with SMTP id
 d75a77b69052e-4af0079bc5cmr4436381cf.5.1754061126793; Fri, 01 Aug 2025
 08:12:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250731154442.319568-1-surenb@google.com> <d2b6be85-44d5-4a87-bfe5-4a9e80f95bb8@redhat.com>
In-Reply-To: <d2b6be85-44d5-4a87-bfe5-4a9e80f95bb8@redhat.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 1 Aug 2025 08:11:54 -0700
X-Gm-Features: Ac12FXwHTk6dY4NJRJgP0bh8zoHGQ_RejUiRmgYpnRzf77eWrvYI8LNs-_ARMGI
Message-ID: <CAJuCfpHkxe1Sb3jL6hK02+zQVFw7yOYte3BR5XDnHRvx7aTjNg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] userfaultfd: fix a crash when UFFDIO_MOVE handles
 a THP hole
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, peterx@redhat.com, aarcange@redhat.com, 
	lokeshgidra@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	syzbot+b446dbe27035ef6bd6c2@syzkaller.appspotmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 1, 2025 at 7:21=E2=80=AFAM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 31.07.25 17:44, Suren Baghdasaryan wrote:
>
> Hi!
>
> Did you mean in you patch description:
>
> "userfaultfd: fix a crash in UFFDIO_MOVE with some non-present PMDs"
>
> Talking about THP holes is very very confusing.

Hi David,
Yes, "hole" is not a technical term, so I'll change as you suggested.

>
> > When UFFDIO_MOVE is used with UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES and it
> > encounters a non-present THP, it fails to properly recognize an unmappe=
d
>
> You mean a "non-present PMD that is not a migration entry".

Yes, will fix.


>
> > hole and tries to access a non-existent folio, resulting in
> > a crash. Add a check to skip non-present THPs.
>
> That makes sense. The code we have after this patch is rather
> complicated and hard to read.
>
> >
> > Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
> > Reported-by: syzbot+b446dbe27035ef6bd6c2@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/all/68794b5c.a70a0220.693ce.0050.GAE@go=
ogle.com/
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > Cc: stable@vger.kernel.org
> > ---
> > Changes since v1 [1]
> > - Fixed step size calculation, per Lokesh Gidra
> > - Added missing check for UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES, per Lokesh =
Gidra
> >
> > [1] https://lore.kernel.org/all/20250730170733.3829267-1-surenb@google.=
com/
> >
> >   mm/userfaultfd.c | 45 +++++++++++++++++++++++++++++----------------
> >   1 file changed, 29 insertions(+), 16 deletions(-)
> >
> > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > index cbed91b09640..b5af31c22731 100644
> > --- a/mm/userfaultfd.c
> > +++ b/mm/userfaultfd.c
> > @@ -1818,28 +1818,41 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx,=
 unsigned long dst_start,
> >
> >               ptl =3D pmd_trans_huge_lock(src_pmd, src_vma);
> >               if (ptl) {
> > -                     /* Check if we can move the pmd without splitting=
 it. */
> > -                     if (move_splits_huge_pmd(dst_addr, src_addr, src_=
start + len) ||
> > -                         !pmd_none(dst_pmdval)) {
> > -                             struct folio *folio =3D pmd_folio(*src_pm=
d);
> > +                     if (pmd_present(*src_pmd) || is_pmd_migration_ent=
ry(*src_pmd)) {
> > +                             /* Check if we can move the pmd without s=
plitting it. */
> > +                             if (move_splits_huge_pmd(dst_addr, src_ad=
dr, src_start + len) ||
> > +                                 !pmd_none(dst_pmdval)) {
> > +                                     if (pmd_present(*src_pmd)) {
> > +                                             struct folio *folio =3D p=
md_folio(*src_pmd);
> > +
> > +                                             if (!folio || (!is_huge_z=
ero_folio(folio) &&
> > +                                                            !PageAnonE=
xclusive(&folio->page))) {
> > +                                                     spin_unlock(ptl);
> > +                                                     err =3D -EBUSY;
> > +                                                     break;
> > +                                             }
> > +                                     }
>
> ... in particular that. Is there some way to make this code simpler /
> easier to read? Like moving that whole last folio-check thingy into a
> helper?

Do you mean refactor the section after "if (ptf)" into a separate function?
I was trying to minimize the code changes to simplify backporting but
since additional indentation changes this whole block, I think it does
not make much difference. Please let me know if I understood you
correctly and I'll move the code into a separate function.
Thanks,
Suren.

>
>
> --
> Cheers,
>
> David / dhildenb
>

