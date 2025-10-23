Return-Path: <linux-kernel+bounces-867572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C26C03022
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 20:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22F073B27FA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 18:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139072848AA;
	Thu, 23 Oct 2025 18:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dpBM36SD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3C929408
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 18:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761244260; cv=none; b=ZurlWtO/IJWC/GUq6Tl713hnEEgqlytioOfG9M20dM8+onJz8j1b5vL0A0A/FcDUozOELROiUlE/ZZFDdLMPjRmT9VDc8EcTn/ao9orImn3oC1Vey7AY8InGbyn0xj/zn2GPmqIollKgif7af2ZZEXoAZHedIpr4jzXzjdSS+3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761244260; c=relaxed/simple;
	bh=A2Bq+PLKHAfwonrVt2hcv8KKkm9WD6ETPfw+JsFCKsg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X8LPZT5DBGaBPOFQuhVtEdLQit8hjrA3CPVlok8PyUKeClLwhviHA86jnjlVO+AvnrOppMdrwDlv67u3YoSa0cbB9jLH3Mnk1n8fgOQtBy6ObNB/frhFDUI2Ws9aEI7WkOt2Z68PNa7vvBnStW13LUXyzAD6//8ap7ggtKZcrtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dpBM36SD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03028C19421
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 18:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761244260;
	bh=A2Bq+PLKHAfwonrVt2hcv8KKkm9WD6ETPfw+JsFCKsg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dpBM36SDb862xzZB40EDbUcqSGt7W7I+Up/ecm70gGaSfklUSypE93cxkPMKPm5I6
	 84Q7twKv+8sop8m/AWvO3SbNYGYYbzWP7JQPUlPj1hZzI+8Nq3HoXBYIxEXdwH6DpF
	 eZt/q4tuPJ1S1UdbBKDHTr9fkfVSOpdAe8J5k45Y01xdPgPHzOTR0oPe3SpDiIrAUW
	 mtV3va/dgj66EfssmvVEEJQqOTomRahJybwuueoP6Vyv1yTdVtsnFbqh06eae4elpz
	 BsMC7BCy3rk7MKKgbhBrkOdy3RrKiBUhQH8AK2CI2QhAF2QHXtkYw8zFFfah5qPSKa
	 3QCarvOj79u8A==
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-784a5f53e60so14276287b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 11:30:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVi4GLdlRarKNaAiPg7takafScvU3jFLy5eyUhYz/7ndQEWV3mqRCCdSpGWEXACWOzOseCtpwOF4d7+iI4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOO3R2U/wPSF8LYmeXT5j8Cu5Q0h7vLQ9w8NI4776DRRmp70CT
	toxnm507ktDy4vtLuA2wBHBRBIPYqVbSTslnhiJf++60OTQgBdbvW1gIvWCPrRksp8z0Zu/cCKm
	qcxx7ik8pc1iMZkUeHScfdzVR4kp89TUo+z4BuVz3Cw==
X-Google-Smtp-Source: AGHT+IF8ifj1rtuZPCoOaf0x+QvZRs4dDJNSuNaVxQ3Wv82RLu2LyrovRaBZjoDf7Go7unGrjyaU8WFB7pMLRkuykjY=
X-Received: by 2002:a05:690c:7286:b0:785:c0a9:9dcb with SMTP id
 00721157ae682-785c0a9a8bemr53996657b3.56.1761244259140; Thu, 23 Oct 2025
 11:30:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022233743.1134103-1-mclapinski@google.com> <CAMj1kXFqwOYBNPzNYo2vjPycjyO5SrEnk_wRVDw_dhGd8qT2qQ@mail.gmail.com>
In-Reply-To: <CAMj1kXFqwOYBNPzNYo2vjPycjyO5SrEnk_wRVDw_dhGd8qT2qQ@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Thu, 23 Oct 2025 11:30:47 -0700
X-Gmail-Original-Message-ID: <CACePvbV-vVXPxj1zdbHd_7gfYV3e=Ej52FphYhw_8_V_pNMTjw@mail.gmail.com>
X-Gm-Features: AS18NWBnBtxKXT1ZSID5EBD5lMhF6LTs4s_ybckNmVVvVFPlk99q-2g_GdFcV8U
Message-ID: <CACePvbV-vVXPxj1zdbHd_7gfYV3e=Ej52FphYhw_8_V_pNMTjw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] x86/boot/compressed: Fix avoiding memmap in
 physical KASLR
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Michal Clapinski <mclapinski@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Dan Williams <dan.j.williams@intel.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 1:25=E2=80=AFAM Ard Biesheuvel <ardb@kernel.org> wr=
ote:
>
> Hi Michal,
>
> Thanks for the patch.
>
> On Thu, 23 Oct 2025 at 01:37, Michal Clapinski <mclapinski@google.com> wr=
ote:
>
> > Signed-off-by: Michal Clapinski <mclapinski@google.com>
> > Suggested-by: Chris Li <chrisl@kernel.org>
> > Fixes: d52e7d5a952c ("x86/KASLR: Parse all 'memmap=3D' boot option entr=
ies")
> > ---
> > The patch was suggested by Chris and I modified it a little without his
> > knowledge. I don't know which tags are appropriate.
>
> I think this is fine, unless Chris has a different opinion? In any

No objection. I recall I had a discussion with Michal in which I
wanted to simplify the global variable "memmap_too_large" state
machine but failed at keeping it meaningfully simpler and also covered
all the corner cases. Nice try on my side I guess.

Right now the memmap_too_large state machine is still a bit tricky to
understand the precise execution flow, but it is the best we can do.

Acked-by: Chris Li <chrisl@kernel.org>

Chris

> case, you might add a link to the original submission.
>
>
> > ---
> >  arch/x86/boot/compressed/kaslr.c | 18 +++++++++---------
> >  1 file changed, 9 insertions(+), 9 deletions(-)
> >
> > diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compresse=
d/kaslr.c
> > index 3b0948ad449f..649264503ce6 100644
> > --- a/arch/x86/boot/compressed/kaslr.c
> > +++ b/arch/x86/boot/compressed/kaslr.c
> > @@ -162,14 +162,18 @@ static void mem_avoid_memmap(char *str)
> >  {
> >         static int i;
> >
> > -       if (i >=3D MAX_MEMMAP_REGIONS)
> > -               return;
> > -
> > -       while (str && (i < MAX_MEMMAP_REGIONS)) {
> > +       while (str) {
> >                 int rc;
> >                 u64 start, size;
> > -               char *k =3D strchr(str, ',');
> > +               char *k;
> > +
> > +               if (i >=3D MAX_MEMMAP_REGIONS) {
> > +                       /* Too many memmap regions, disable physical KA=
SLR. */
> > +                       memmap_too_large =3D true;
> > +                       return;
> > +               }
> >
> > +               k =3D strchr(str, ',');
> >                 if (k)
> >                         *k++ =3D 0;
> >
> > @@ -190,10 +194,6 @@ static void mem_avoid_memmap(char *str)
> >                 mem_avoid[MEM_AVOID_MEMMAP_BEGIN + i].size =3D size;
> >                 i++;
> >         }
> > -
> > -       /* More than 4 memmaps, fail kaslr */
> > -       if ((i >=3D MAX_MEMMAP_REGIONS) && str)
> > -               memmap_too_large =3D true;
> >  }
> >
> >  /* Store the number of 1GB huge pages which users specified: */
> > --
> > 2.51.1.814.gb8fa24458f-goog
> >

