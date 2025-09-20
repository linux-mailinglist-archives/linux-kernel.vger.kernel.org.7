Return-Path: <linux-kernel+bounces-825678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11BE9B8C7B4
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 14:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B78FF5621B1
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 12:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9CC13002DC;
	Sat, 20 Sep 2025 12:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tVSGdpXR"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722D92FC882
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 12:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758370123; cv=none; b=rzzupAw7a7d5qPW5BAw+0wyrChM+hVk5Vn6KBEU7R0qU2P0ZyDiyi1y7csNc1pByT/AMk35QbhKWSTRPkspsk9nAbnQpvH916kcoT6JAMd4ZhbkXVpbO5xZlxv7DjORJyvOaRP6PSHkvwuPIVhan0Zd60SSjxy2a79yv0/XWtQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758370123; c=relaxed/simple;
	bh=+75owp6BZWWn6qzgOUeJYK1AlGCtYCoTHjw8eiK6KJo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DSYlSwliszxSTe8gK0SoRsTN164ACnV59W+3oJnasJGghdker0ewEDRw897PZgbcPvqcyktDa2wb/NMSxo7QKPgxgNYWKrnkrlX9K8jpYCKnJqLgGOE+5x5lrEh517NM0SjZJerYjsyo7WEkffbHJcOLvMyPWia2OS0DXj21sX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tVSGdpXR; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-78ea15d3489so29018196d6.3
        for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 05:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758370120; x=1758974920; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rg0aAAaEFwb8WUGfzZYLj8KGkf4Q3J2CuRbPLZDHdFI=;
        b=tVSGdpXRZH8lfkU7KGdh4r039dOHQafqSRc2hBddNTss500mSXaNCsx8+nBbMIP5XY
         XPDjPvomVS4hCk5+1J8CCy9K0qEt7qJIKKG9NNSDSumrJRN6W+kHPfqqX1brMRV3p55W
         r0DqJ8Ql7nBhekb0dJBwbUCOE1cjyLLZ64ymMXDmrzuh6Ql7EDrjmNurIN++ZgK13nQ8
         5b+0TFXY+6ZzdAo82krbCJyaPLnTssUHoJhNNjlrSYQ4+1RgbHvpzbicU6Osk4ghhf/j
         tItJ3QnO85yEUfkbf3WHO8BmXMoIURaQucu53UKgWF+PUcwbc2LKb6mhIBcgchPKb8QD
         5gzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758370120; x=1758974920;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rg0aAAaEFwb8WUGfzZYLj8KGkf4Q3J2CuRbPLZDHdFI=;
        b=Lwj6rk41N/bsRcYhYI11iMY9/i8sOdxwbloWb/Rw3oiJr/1LfL6BoIyOdy0oq9QFO5
         6FCrH2r5tRIhWX04PzoWuoWZFRj3+LRFw4iJVINrp2h3Nqbk40DZ92kg41RHK5IHAzZY
         yb22/IlB29cCcAkujgiYhZSvtCf6A+uo8nVpx6iMMpI9AweyMV59uaCPeROeK4J2SWDY
         RzAIstFSi5kSgXkZr8DPpLqqax+onAC2oowu5XqWsuN4sVeBWC77Ln97AYBX8b/YUTiS
         kIgNk0ETz0iv2O+4GFHEAZnxSmhs+16ZvnYaqLE3UyTpRfm56GOZv1GGqGznO7Zsf+Rr
         C0tA==
X-Forwarded-Encrypted: i=1; AJvYcCV0tX5+eFhQRUir4sxGq276UhVcOZufQH65wsRD5ikVPC3S7QXsyvqqqwDmOIvwmaocOoPT/FNnsySUrNg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn1FAANVAi2sXpHhIDim3m/4DdqlIfwm6lDoKoOT3gmGhiJ2or
	TN4MaBD0RqorB3aHcjUfKI7dIf9FP2Z6r8tKxy6zCnMFjY+9dfPw/H3Wk8mT1hSoDqAaiTC1ATg
	5uFgIGZGsT3f3YerLE3DFxQ6FjHsarhpEyJoZc4HB
X-Gm-Gg: ASbGncsGSsCcgZfA+txFxOwhPPpyoOP9HBHHAzJN9voaYyx9J3zf6gWpTGT5fSy4lrj
	dwLJ0jQEIYYB6Zr2mjno4RM3v9T5YuRtSmhG3tS5w+xyc9Ji1dnuU8N35IZp+ETOEHTqkDjl8eC
	wpMqGrUztL6PDzDA+lGSca5NgkMQk+g1baqO6vi1tnKoQ9iYvrmXi1HCspbfXMWUyZfljL/vDib
	K26RGaaot1tZ31saiBwKIqDoPrYF61fMdymxg==
X-Google-Smtp-Source: AGHT+IGrLhGnLin4JPn3IEJL16TDaAaIyPUzt4DPnDcGALtByT5b0deWvFSW43f3QYgleVc8ho2F2zEcC/AGvOdoPJI=
X-Received: by 2002:a05:6214:5712:b0:7b0:d5a0:c60d with SMTP id
 6a1803df08f44-7b0d5a0c6c5mr11507116d6.10.1758370120098; Sat, 20 Sep 2025
 05:08:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919145750.3448393-1-ethan.w.s.graham@gmail.com>
 <20250919145750.3448393-9-ethan.w.s.graham@gmail.com> <CAHp75VdyZudJkskL0E9DEzYXgFeUwCBEwXEVUMuKSx0R9NUxmQ@mail.gmail.com>
In-Reply-To: <CAHp75VdyZudJkskL0E9DEzYXgFeUwCBEwXEVUMuKSx0R9NUxmQ@mail.gmail.com>
From: Alexander Potapenko <glider@google.com>
Date: Sat, 20 Sep 2025 14:08:01 +0200
X-Gm-Features: AS18NWBVqpbu6_S8igqrpC6d_4rlaGzIrca9Y3paJY9H7AfaiH53k8LL1oZq4JA
Message-ID: <CAG_fn=XTcPrsgxg+MpFqnj9t2OoYa=SF1ts8odHFaMqD+YpZ_w@mail.gmail.com>
Subject: Re: [PATCH v2 08/10] drivers/auxdisplay: add a KFuzzTest for parse_xy()
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Ethan Graham <ethan.w.s.graham@gmail.com>, ethangraham@google.com, 
	andreyknvl@gmail.com, andy@kernel.org, brauner@kernel.org, 
	brendan.higgins@linux.dev, davem@davemloft.net, davidgow@google.com, 
	dhowells@redhat.com, dvyukov@google.com, elver@google.com, 
	herbert@gondor.apana.org.au, ignat@cloudflare.com, jack@suse.cz, 
	jannh@google.com, johannes@sipsolutions.net, kasan-dev@googlegroups.com, 
	kees@kernel.org, kunit-dev@googlegroups.com, linux-crypto@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lukas@wunner.de, 
	rmoar@google.com, shuah@kernel.org, sj@kernel.org, tarasmadan@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 20, 2025 at 12:54=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Fri, Sep 19, 2025 at 5:58=E2=80=AFPM Ethan Graham <ethan.w.s.graham@gm=
ail.com> wrote:
> >
> > From: Ethan Graham <ethangraham@google.com>
> >
> > Add a KFuzzTest fuzzer for the parse_xy() function, located in a new
> > file under /drivers/auxdisplay/tests.
> >
> > To validate the correctness and effectiveness of this KFuzzTest target,
> > a bug was injected into parse_xy() like so:
> >
> > drivers/auxdisplay/charlcd.c:179
> > - s =3D p;
> > + s =3D p + 1;
> >
> > Although a simple off-by-one bug, it requires a specific input sequence
> > in order to trigger it, thus demonstrating the power of pairing
> > KFuzzTest with a coverage-guided fuzzer like syzkaller.
>
> ...
>
> > --- a/drivers/auxdisplay/charlcd.c
> > +++ b/drivers/auxdisplay/charlcd.c
> > @@ -682,3 +682,11 @@ EXPORT_SYMBOL_GPL(charlcd_unregister);
> >
> >  MODULE_DESCRIPTION("Character LCD core support");
> >  MODULE_LICENSE("GPL");
> > +
> > +/*
> > + * When CONFIG_KFUZZTEST is enabled, we include this _kfuzz.c file to =
ensure
> > + * that KFuzzTest targets are built.
> > + */
> > +#ifdef CONFIG_KFUZZTEST
> > +#include "tests/charlcd_kfuzz.c"
> > +#endif /* CONFIG_KFUZZTEST */
>
> No, NAK. We don't want to see these in each and every module. Please,
> make sure that nothing, except maybe Kconfig, is modified in this
> folder (yet, you may add a _separate_ test module, as you already have
> done in this patch).

This is one of the cases in which we can't go without changing the
original code, because parse_xy() is a static function.
Including the test into the source is not the only option, we could as
well make the function visible unconditionally, or introduce a macro
similar to VISIBLE_IF_KUNIT.
Do you prefer any of those?

