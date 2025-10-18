Return-Path: <linux-kernel+bounces-859264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D81F1BED299
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 17:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 84FAC34DC2F
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 15:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CBDA221DB1;
	Sat, 18 Oct 2025 15:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="ADudj/tG"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8004220687
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 15:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760801538; cv=none; b=gaNxMbaI5hdj7hZzZ4N5O7Pmt21hYN+GD/4v0Vh+0yJf8/ZSOzOZRozYQOgxCCSrt2fXNZlqVqdyErlgrSxHizYzBz54cvrB6HrT1v3hq5HN5YSRQ1ftAxr926fIWgwMMSSs4bEdYdmTdSfdv54u5+BjXK9VBxOIwUOKWbtYYlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760801538; c=relaxed/simple;
	bh=FkkE+E0KCZbN9pPmPAsIge+ER3LeTZ59UTmWbQqcSik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qCvdzSeiaV+BsRFQFIP42Xk6329dlsCvg7Uc51siBNx/lhuORDKsloWTHkEWqjLlBP9ofuyWj4Sq053hGbNGgWCkC4ovilQmLi2lJoKYph/m+dZq8Plu3Egy74GGtxTPHsA5jx47trzgUgy1el0nAkwnvgyIbZHsJv8Bk4FfDv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=ADudj/tG; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-63bea08a326so3984026a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 08:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1760801534; x=1761406334; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9VsDvzwluOWLRYb/lK+lEAn58q7ZQz+5TWTRfSTNft4=;
        b=ADudj/tGpYFC4+/R3btD8jyWK8QUF4l/RcX9mWl+KrkphvlmTdYxgnrdGB4M7vuT9V
         USsW4NUIevX/zyLTmwMvhDUOV6mW6LiL4nddlo5zaTKeDJLtJcvVkvJxwREL1119gZgT
         TZGDKcIy+kWI5tusuOLbnMvUHLMMd7WxgN8So47B9rqEqUoBZaxb+TafFiKQOEKrk/4H
         CoRHy7CE2Al+2rCEx1NJ1GDi/CHVI6XNPer8zS1CBD8LzFvato5BeBlroDIrSQL4FGGO
         Qi+Xj3+T0z72Yfy10QIgCXsWj1JSDTwof71OJKsRoNN0N1ATse6IDOq/GFvhckr94ZcB
         pPLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760801534; x=1761406334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9VsDvzwluOWLRYb/lK+lEAn58q7ZQz+5TWTRfSTNft4=;
        b=CAiA75vvykSqGyeaQt7AUrYo4gzqA/jgkSMSWFgnZXDxtmUurUxH6u5F26pSp4tRe+
         25dSb20TUZKWF8UQoyvAqymOI2BfP6hUV8Q4lXINiUqGpdEG4pj5P9FMtRZbsTphTHN9
         Zqkkf0usA2gpW8Fm3J+XJTUIzE0NnmL6vq+Yt1dusrYAZBBm3Dd7g1wrurmqHPUmsF/Y
         mYgcU0CIwGx6C7VgAOIDkLmVFpy8vh3r9sgsLP/975HFYMIJS0EUofgOBtnUrsdzu6Sa
         noVWJb3wasPWCAcUhpTTyvVMU81EPk77PLVy5dfJpvajtzzqEgWSNs6aCSIetebnqMgu
         lMRw==
X-Forwarded-Encrypted: i=1; AJvYcCVe+eDv8Caji6MDeHo5rHxZMXid6TGjwuYN1lLHyL0TjnQdN5yJOfts8eG/EvV0CatcRSI/abOPDFqg5qI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGElrFhK/EN4Hmq3QPu1QhUyu/V/pYMeS5sk1zSmI9nbX9unyj
	abaer6854DNOxByZSDWzAXNJwFuqU63tmMSgqKt9UA24aUiuLBLTFRnjmYmxSF7sDXOpPyj85Yb
	O+e0aEHgeC+PU4rhnt1HuRZwSyvhakLjv83XRSYRs/w==
X-Gm-Gg: ASbGnctrT+92uCp96rHa0qozPmt/r/yozVnVBxn9DO15C4tc/XGvVpS9N1rfaIc/ioz
	Yni7OGPRlCy6bUfABR2QPrF3fSmzuYVESfVQSCxitFswx9fiNISduOkSrC+DjPNiaE4PDsSnG+4
	5KJLPLaeXKMfpXXCSeDKeJc9L43/wz1uxhM4SKmlzoTAE3+9GgpEisrmMG85UEkiMyBRmVIersS
	yZp4XLEPXluh1SrjC3VaqquwqzQ9511FdXjVKYV8M4fx0y6pQ2SxWWnoLOsipZbW6PtDysiePFX
	udX3exY7GOH3SecQ
X-Google-Smtp-Source: AGHT+IF3cipF6bc/oqKvCyt+BiwXJFIE1+mPSjPv6l90gLXlAbCAIy8PMbygYaIUPYg1G8/+J8KtWKzhzNqhtzHIHeY=
X-Received: by 2002:a50:c949:0:b0:637:e271:8071 with SMTP id
 4fb4d7f45d1cf-63c1f6d5dd8mr5412618a12.27.1760801534100; Sat, 18 Oct 2025
 08:32:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015053121.3978358-1-pasha.tatashin@soleen.com>
 <20251015053121.3978358-2-pasha.tatashin@soleen.com> <aO9ZiERHff7vQiBL@kernel.org>
 <CA+CK2bA5Eyz6TUMTy3pa5HBvZ7KkiHX3EHn17T=d6LX_X5i3bg@mail.gmail.com> <aPEqDfajAlNnhoeN@kernel.org>
In-Reply-To: <aPEqDfajAlNnhoeN@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Sat, 18 Oct 2025 11:31:37 -0400
X-Gm-Features: AS18NWAgHFUQgLd3GmKT5ixSVjoVgRSpizTftBZSz0idzsJU9vI8LHQCq5QGRPk
Message-ID: <CA+CK2bDkc9POgvZpHFWzTsbic6UjExU+YN5SO=D-ODaHQRMTFQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] liveupdate: kho: warn and fail on metadata or
 preserved memory in scratch area
To: Mike Rapoport <rppt@kernel.org>
Cc: akpm@linux-foundation.org, brauner@kernel.org, corbet@lwn.net, 
	graf@amazon.com, jgg@ziepe.ca, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, masahiroy@kernel.org, 
	ojeda@kernel.org, pratyush@kernel.org, rdunlap@infradead.org, tj@kernel.org, 
	jasonmiu@google.com, dmatlack@google.com, skhawaja@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 1:23=E2=80=AFPM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> On Wed, Oct 15, 2025 at 08:36:25AM -0400, Pasha Tatashin wrote:
> > > > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > > > ---
> > > >  kernel/liveupdate/Kconfig                   | 15 ++++++++++
> > >
> > > Feels like kernel/liveupdate/Makefile change is missing
> >
> > It's not, we already have KEXEC_HANDOVER_DEBUGFS that pulls in
> > kexec_handover_debug.c
> >
> > That debug file contains KHO debugfs and debug code. The debug code
> > adds KEXEC_HANDOVER_DEBUGFS as a dependency, which I think is
> > appropriate for a debug build.
> >
> > However, I do not like ugly ifdefs in .c, so perhaps, we should have tw=
o files:
> > kexec_handover_debugfs.c for debugfs and kexec_handover_debug.c ? What
> > do you think?
> >
> > > >  kernel/liveupdate/kexec_handover.c          | 32 +++++++++++++++++=
+---
> > > >  kernel/liveupdate/kexec_handover_debug.c    | 18 ++++++++++++
> > > >  kernel/liveupdate/kexec_handover_internal.h |  9 ++++++
> > > >  4 files changed, 70 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/kernel/liveupdate/Kconfig b/kernel/liveupdate/Kconfig
> > > > index 522b9f74d605..d119f4f3f4b1 100644
> > > > --- a/kernel/liveupdate/Kconfig
> > > > +++ b/kernel/liveupdate/Kconfig
> > > > @@ -27,4 +27,19 @@ config KEXEC_HANDOVER_DEBUGFS
> > > >         Also, enables inspecting the KHO fdt trees with the debugfs=
 binary
> > > >         blobs.
> > > >
> > > > +config KEXEC_HANDOVER_DEBUG
> > > > +     bool "Enable Kexec Handover debug checks"
> > > > +     depends on KEXEC_HANDOVER_DEBUGFS
> > > > +     help
> > > > +       This option enables extra sanity checks for the Kexec Hando=
ver
> > > > +       subsystem.
> > > > +
> > > > +       These checks verify that neither preserved memory regions n=
or KHO's
> > > > +       internal metadata are allocated from within a KHO scratch a=
rea.
> > > > +       An overlap can lead to memory corruption during a subsequen=
t kexec
> > > > +       operation.
> > > > +
> > > > +       If an overlap is detected, the kernel will print a warning =
and the
> > > > +       offending operation will fail. This should only be enabled =
for
> > > > +       debugging purposes due to runtime overhead.
> > > >  endmenu
> > > > diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate=
/kexec_handover.c
> > > > index 5da21f1510cc..ef1e6f7a234b 100644
> > > > --- a/kernel/liveupdate/kexec_handover.c
> > > > +++ b/kernel/liveupdate/kexec_handover.c
> > > > @@ -141,6 +141,11 @@ static void *xa_load_or_alloc(struct xarray *x=
a, unsigned long index, size_t sz)
> > > >       if (!elm)
> > > >               return ERR_PTR(-ENOMEM);
> > > >
> > > > +     if (WARN_ON(kho_scratch_overlap(virt_to_phys(elm), sz))) {
> > > > +             kfree(elm);
> > >
> > > I think __free() cleanup would be better than this.
> >
> > Sorry, not sure what do you mean. kfree() is already is in this
> > function in case of failure.
>
> There's __free(kfree) cleanup function defined in include/linux/cleanup.h
> that ensures that on return from a function resources are not leaked.
> With kfree we could do something like
>
>         void *elm __free(kfree) =3D NULL;
>
>         if (error)
>                 return ERR_PTR(errno);
>
>         return no_free_ptr(elm);
>
> There's no __free() definition for free_page() though :(
>
> The second best IMHO is to use goto for error handling rather than free()
> inside if (error).

Makes sense, let me try to get it done. I actually like what cleanup.h prov=
ides.

>
> > > > +             return ERR_PTR(-EINVAL);
> > > > +     }
> > > > +
> > > >       res =3D xa_cmpxchg(xa, index, NULL, elm, GFP_KERNEL);
> > > >       if (xa_is_err(res))
> > > >               res =3D ERR_PTR(xa_err(res));
> > > > @@ -354,7 +359,13 @@ static struct khoser_mem_chunk *new_chunk(stru=
ct khoser_mem_chunk *cur_chunk,
> > > >
> > > >       chunk =3D kzalloc(PAGE_SIZE, GFP_KERNEL);
> > > >       if (!chunk)
> > > > -             return NULL;
> > > > +             return ERR_PTR(-ENOMEM);
> > >
> > > I don't think it's important to return -errno here, it's not that it'=
s
> > > called from a syscall and we need to set errno for the userspace.
> > > BTW, the same applies to xa_load_or_alloc() IMO.
> >
> > HM, but they are very different errors: ENOMEM, the KHO user can try
> > again after more memory is available, but the new -EINVAL return from
> > this function tells the caller that there is something broken in the
> > system, and using KHO is futile until this bug is fixed.
>
> Do you really see the callers handling this differently?
> And we already have WARN_ON() because something is broken in the system.

Maybe, also maybe for some self-tests. I think it is more consistent
to return PTR_ERR() based on other code in this file (i.e.
xa_load_or_alloc() already uses it). Let's keep it.

>
> > > > +
> > > > +     if (WARN_ON(kho_scratch_overlap(virt_to_phys(chunk), PAGE_SIZ=
E))) {
> > > > +             kfree(chunk);
> > > > +             return ERR_PTR(-EINVAL);
> > > > +     }
> > > > +
>
> --
> Sincerely yours,
> Mike.

