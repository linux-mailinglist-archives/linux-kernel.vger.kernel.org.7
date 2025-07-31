Return-Path: <linux-kernel+bounces-751761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BEF5B16D1A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 10:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 737BC1773CB
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 08:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE31194A59;
	Thu, 31 Jul 2025 08:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iXx4+DFb"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A7115AF6
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 08:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753949005; cv=none; b=qlC8kGrJnR7kHXJnGYS0eaZDhB7UQaq1SuEoiVuUUVceGNej1myH2rQOUImpEemGvC5qNdZ6pCzElNx0v3tJpRrrJGOjxS7ChZOHEioVJeSAgK+aiuYGfhkucKLQBb6qXi1Esvew7hw5hY7aikyQlO0MqtQaQ2t9JD+QdQ3hoBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753949005; c=relaxed/simple;
	bh=3E6DM/Jj6Uge9ThAztNbddyRb4SKq7tcgFhF6Lyj7vs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tqv+LRE8tosHzwqVngaCqe224UzStexp5Sls0/hp+mL/1E6xnjXA7KhV66LuVGlwDhhs/L4pp0q2NYcRNrxAqe9gDs4zVzPP+O4A6yuK8jv3TFHDhiG9Yyq8J/+u0lBMrD4VbdBexxLkT+6rfBv2O/sRCuLXQuZr4NxteL33Rz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iXx4+DFb; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-7075ccb168bso5945386d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 01:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753949003; x=1754553803; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E0RizqeeSEQXWVsY0Sxzh6E2pfnIevB3317J+qjJefQ=;
        b=iXx4+DFbpv0hdNCCCC2oh6Ijx4TsF+18qHxwWvBfcw4I32TjO5eRCoYgodXxvpS0YD
         Ksj1YecR+ppNVBuDYPPcDcYlEkjznU+fdLQrU5MhmiELRWUsSPskmZB4ANlrtuzof/Ab
         9jzYZsjL+C+QFRwo1xQhLsYAslvyk01QTLmFeNtlagmp0gSzOHiF3PFBkHDmWE5+K2cG
         khmFM9v8FF2htWM/kruvwLJ8DqJ6dZ/8s1hySrOEGLMVB8sMdDcFCThpC7BiJbBe0mdZ
         mutdQ7WffUsDL+zhihSYO5hepE7Tj+Ygkz5+gtefNts9ihef8TkwHOG+GbQk5wxQNUBH
         K5pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753949003; x=1754553803;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E0RizqeeSEQXWVsY0Sxzh6E2pfnIevB3317J+qjJefQ=;
        b=nzBvOYzDhPX0qWqM7Krq9bL+1ST6FDx8LLfGnEZBQCFv8GSFLXc0Lqu48iEHyVdAEi
         uvkak/TnZrBNA3vQa/uHzcQD1/Zi6gedlvfhFAS2DTVyBDmUSCoQSKVNOmB+MCTLeUgn
         rDrR6ScSDTXqHwZtmVGlAn8iXJFAIswznTJoYoeuKFm7i1tOJ2a6pDzeDMGWNeCS81ko
         Tiu74Qr2OrVYfWCk0YhjE+PkKjxMc7U3dNDzLFoCBiRfVSrjfP/AzFPWueNJVd4vngEO
         Jgm4mOzJGj2c6qE4YhGND3SqMnN0zjF1gAxU1xvSIWpNOcGTeOqUAWuQQl1vaEbPp8iC
         01Bg==
X-Forwarded-Encrypted: i=1; AJvYcCWCMd4DHcc9TXQU+CAxRRk/2UCJ4Roef8PXZpXbUCgcE4udvNt9H8hnvgLRvTnDH8FByKTFW2HwhUem0O4=@vger.kernel.org
X-Gm-Message-State: AOJu0YybDyEyyktDtHakX39z9UU16cDy+GWxZHDBBHU3Jjq3mkiFREqi
	fti3ygTO+yThR0gJoHk6Euf07DqxcUFhy29UvoPH9a9MxgX5wgE7nfDXmbXeUUwe/Ve0gXlXjld
	Ljx/8PHQeQoaamdaJVGw+bfNw+MGRsJwqWrPeH5D2ELWWOpNEf9kENdhy
X-Gm-Gg: ASbGncuFgW87lE3LNfUhGjiDXSP0wTuSG35KW5NXyqwNuPuVseJAjpWUdqfaWNz4oHp
	ZK5JG3VTB9X1zvvuy9Mwx0es2TKyaF27qIvZL8i6bFcKE8yLp6LVufGZX9Vp55ZXztCqbe+OOuc
	zA95gCDHZy/q4GfVzFVgk09W7ZFAdeyyWghxReKYZAc0gjIl6e1DEXG2t6MRozpwzPQkx2OGU7J
	ah3iKHyTc2ocbVRZfUSfeen3UHybPtH9l0=
X-Google-Smtp-Source: AGHT+IGDr7zfGuIAMJSA1MvTb1ljatVa+MfXwdfqyf9as9/ILumMyL4rrQSmaRC64HVvA8ltMX0YLrwYqWd2JVaJlVE=
X-Received: by 2002:a05:6214:23c6:b0:707:4e41:d352 with SMTP id
 6a1803df08f44-707670532a0mr69396966d6.6.1753949002615; Thu, 31 Jul 2025
 01:03:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250728152548.3969143-1-glider@google.com> <20250728152548.3969143-10-glider@google.com>
 <CACT4Y+Y6gkd23+cVEkTs_MDfvOskd=Z4=dVh-LL-F_Jbgf8xnA@mail.gmail.com>
In-Reply-To: <CACT4Y+Y6gkd23+cVEkTs_MDfvOskd=Z4=dVh-LL-F_Jbgf8xnA@mail.gmail.com>
From: Alexander Potapenko <glider@google.com>
Date: Thu, 31 Jul 2025 10:02:45 +0200
X-Gm-Features: Ac12FXwla-B03ct7tMQ3jw6Uy5HlsYMbId5MW3BmN9-L_RLD8ecivdhVV9pI6Zo
Message-ID: <CAG_fn=WDOu2sRv_RhRm8XhgCAgVJsMaPXp9TbcaknTn_84cNOg@mail.gmail.com>
Subject: Re: [PATCH v3 09/10] kcov: selftests: add kcov_test
To: Dmitry Vyukov <dvyukov@google.com>
Cc: quic_jiangenj@quicinc.com, linux-kernel@vger.kernel.org, 
	kasan-dev@googlegroups.com, Aleksandr Nogikh <nogikh@google.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Marco Elver <elver@google.com>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 29, 2025 at 1:20=E2=80=AFPM Dmitry Vyukov <dvyukov@google.com> =
wrote:
>
> On Mon, 28 Jul 2025 at 17:26, Alexander Potapenko <glider@google.com> wro=
te:
> >
> > Implement test fixtures for testing different combinations of coverage
> > collection modes:
> >  - unique and non-unique coverage;
> >  - collecting PCs and comparison arguments;
> >  - mapping the buffer as RO and RW.
> >
> > To build:
> >  $ make -C tools/testing/selftests/kcov kcov_test
> >
> > Signed-off-by: Alexander Potapenko <glider@google.com>
> > ---
> > v3:
> >  - Address comments by Dmitry Vyukov:
> >    - add tools/testing/selftests/kcov/config
> >    - add ifdefs to KCOV_UNIQUE_ENABLE and KCOV_RESET_TRACE
> >  - Properly handle/reset the coverage buffer when collecting unique
> >    coverage
> >
> > Change-Id: I0793f1b91685873c77bcb222a03f64321244df8f
> > ---
> >  MAINTAINERS                              |   1 +
> >  tools/testing/selftests/kcov/Makefile    |   6 +
> >  tools/testing/selftests/kcov/config      |   1 +
> >  tools/testing/selftests/kcov/kcov_test.c | 401 +++++++++++++++++++++++
> >  4 files changed, 409 insertions(+)
> >  create mode 100644 tools/testing/selftests/kcov/Makefile
> >  create mode 100644 tools/testing/selftests/kcov/config
> >  create mode 100644 tools/testing/selftests/kcov/kcov_test.c
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 6906eb9d88dae..c1d64cef693b9 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -13018,6 +13018,7 @@ F:      include/linux/kcov_types.h
> >  F:     include/uapi/linux/kcov.h
> >  F:     kernel/kcov.c
> >  F:     scripts/Makefile.kcov
> > +F:     tools/testing/selftests/kcov/
> >
> >  KCSAN
> >  M:     Marco Elver <elver@google.com>
> > diff --git a/tools/testing/selftests/kcov/Makefile b/tools/testing/self=
tests/kcov/Makefile
> > new file mode 100644
> > index 0000000000000..08abf8b60bcf9
> > --- /dev/null
> > +++ b/tools/testing/selftests/kcov/Makefile
> > @@ -0,0 +1,6 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +LDFLAGS +=3D -static
> > +
> > +TEST_GEN_PROGS :=3D kcov_test
> > +
> > +include ../lib.mk
> > diff --git a/tools/testing/selftests/kcov/config b/tools/testing/selfte=
sts/kcov/config
> > new file mode 100644
> > index 0000000000000..75726b2aa9979
> > --- /dev/null
> > +++ b/tools/testing/selftests/kcov/config
> > @@ -0,0 +1 @@
> > +CONFIG_KCOV=3Dy
>
> Doesn't it also need CONFIG_KCOV_UNIQUE=3Dy since it tests the unique
> mode as well?

You are right, I missed that.
Another option would be to skip the test under #ifndef
CONFIG_KCOV_UNIQUE, but I think for KCOV developers it is important to
enable all the necessary config options.

