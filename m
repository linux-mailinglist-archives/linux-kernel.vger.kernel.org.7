Return-Path: <linux-kernel+bounces-842875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4D1BBDDA8
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 13:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0205B3BD89A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 11:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DAE426B95B;
	Mon,  6 Oct 2025 11:22:18 +0000 (UTC)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEA6269AEE
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 11:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759749738; cv=none; b=R2Alnz8rULT9btgP4XY6iv8OdL3EIZRawZKHXvqF79bcNA0Ws/TN3+r7y/QF/0LXc1fwJWtIpkYzcoT/jIyq0gOeouJqe6qUH2JY85PoZZeKLdmepVv4oM3wmnvjDWenJDxk5JNOPlfvpIyQYhAL12X53dm2Bsrs0r1pScAn89E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759749738; c=relaxed/simple;
	bh=Y3Atn65xFGH/0e1A2PaPhs3F2p+GKPI48e94fdpGas4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wg1Ke48FVfye4RYW2A1qDQAy0RO4lnU1sqg1dCIHAwY19Jyn0Mt7ZEuc3wV9yEDGj5AIJ9GkHmYbk441GoGtEyA2/xaTRu3G93KhBJl1m2yMkYTLdm83W55DkJF/n0N2KcJbICizYHu0Lh8T8rW85JUjds57jvSAfPE3qmunsM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-8fea25727a9so1373048241.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 04:22:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759749734; x=1760354534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L5v6YXX9bgIrUD9M85TqnlXajae/PoAZkbY3xvYAmEY=;
        b=bbvEZ/6NFWRlYA3soI2WBmnA3DcLv7T3nZZC6ruSyc8V+hn88F4Rk2bPUzEwxWo1wg
         PNovJoKnNt+8mjocqri8Lab3/qmNnt2ytAAuJUFrBrniKqoQozl8JGiCAHOj73qek6Ss
         hk3EfKJ685IH0KDN/VrgjvOQ2V4oLTwp3HhuHzsgOLesSwnIodTqbfMoCp58h7izTbgk
         mPUNQjj02RLbVGQOyz8zc2H3x+wj0pPp+aYTatTca/jjWwhQY5P+fyiWaGpbkjXiMoJ/
         xP07ADHpVulWg6XGiXoaBmKHbTRVofeoonDwOD9bUb3m8kvGO4BVJ2l9JDE+PfIdqguR
         J9og==
X-Forwarded-Encrypted: i=1; AJvYcCX3CzyGC0lOBVKOrJfWxkysC1AwvfkeZFImaQqk+esp5VIlU/ArN6N1K06A83r1J/NRJFY9FPWhu+ehlCI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjvA0GUg9d+aWvaQdLHCC2FG8kDbzjvLuamoW+li219/f/TAEU
	gewgVtNhBESKfkZmCpLJzYG18cpP1RTE2R5Kwn8skUBstwd9e1PTen3iBAADSv8P
X-Gm-Gg: ASbGncsQZlmZYCqwE5BVfc/h5oeMyVH/nS0stjIpNkZFUE+6io/qmVRwPdp6BT6eN7T
	8GKWXph3lQ688UTYn4YGeJKFgWmVRHE4NHbATMCDoVMiVhap6jHOTf9CmWzhCdPllIkbxpHsaxq
	V5pM/KIj2a41Yr3AkKDcQeAKdZ4TmHvMyRSw7EnlRWp9z441Ue/FNKTSZAhwKqCrytZdiHvZsHP
	FhWhfOBp4PBpQgPHOktsMdq2TM7Kfx53RLu91Mutvu2dZg4Z9VESABjmzPSkJOPJG5xuU61hr6X
	LqaJvQyMf7ADKbjsyslq5CWqqZtDqr92jlcoe7LQ10e6Y++TKKHCxIFzVBvxG1d0pnbU/JaQAzP
	agqoIBILqLmQsKurg4goCo41YChBQB0ikn508nmw13faKLTp5p6/X5plOXn2E5BcMjb9L2pXjZ+
	Refd8mJE38coWi9v2BIrQ=
X-Google-Smtp-Source: AGHT+IEv9whYcEya9jCschq1rleUv41y8TAJ2+mSj/OSaoBMBqiQqId2ounWqu0GKx2Jj9wk3SeiiQ==
X-Received: by 2002:a05:6102:3051:b0:5a3:acb7:55c7 with SMTP id ada2fe7eead31-5d41d0e7ce5mr3983222137.18.1759749733934;
        Mon, 06 Oct 2025 04:22:13 -0700 (PDT)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com. [209.85.222.48])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5d40c34ae98sm3596410137.0.2025.10.06.04.22.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 04:22:13 -0700 (PDT)
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-90f6d66e96dso1359579241.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 04:22:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXtPoZXze8TjPfXaaQL5zFp2VXy+aa0V1ofpzM67Yvd/JJMvsUGci8pDaUYCXgdwnLgqXgygxthzoibIQw=@vger.kernel.org
X-Received: by 2002:a05:6102:5086:b0:51f:66fc:53b8 with SMTP id
 ada2fe7eead31-5d41d10c1e6mr3769193137.25.1759749732995; Mon, 06 Oct 2025
 04:22:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6e68ab921a728caea4f3f37bfae9b1896edfa97a.1759740354.git.geert@linux-m68k.org>
 <20251006122254-b3b3f96f-67e5-4223-a040-79c845097f6d@linutronix.de>
In-Reply-To: <20251006122254-b3b3f96f-67e5-4223-a040-79c845097f6d@linutronix.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 6 Oct 2025 13:22:01 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWydvUtYUiT23HcgRA3+6di0sZmVqrAPMGM_v5B208=zw@mail.gmail.com>
X-Gm-Features: AS18NWCyOXitXU3rGEXUiPmnEZfW-xN2u5xkzC9-zt4O_5XgyELmHdg8FqqTPME
Message-ID: <CAMuHMdWydvUtYUiT23HcgRA3+6di0sZmVqrAPMGM_v5B208=zw@mail.gmail.com>
Subject: Re: [PATCH] kbuild: uapi: Strip comments before size type check
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>, 
	linux-kbuild@vger.kernel.org, linux-m68k@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thomas,

On Mon, 6 Oct 2025 at 12:31, Thomas Wei=C3=9Fschuh
<thomas.weissschuh@linutronix.de> wrote:
> On Mon, Oct 06, 2025 at 10:49:28AM +0200, Geert Uytterhoeven wrote:
> > On m68k, check_sizetypes in headers_check reports:
> >
> >     ./usr/include/asm/bootinfo-amiga.h:17: found __[us]{8,16,32,64} typ=
e without #include <linux/types.h>
> >
> > This header file does not use any of the Linux-specific integer types,
> > but merely refers to them from comments, so this is a false positive.
> > As of commit c3a9d74ee413bdb3 ("kbuild: uapi: upgrade check_sizetypes()
> > warning to error"), this check was promoted to an error, breaking m68k
> > all{mod,yes}config builds.
>
> This commit has been in -next for some time. Any idea why the issue did
> not show up there?

No idea. Looks like the build bots that are still running don't exercise m6=
8k
builds on linux-next?
Perhaps this is just collateral damage of the loss of the kisskb build serv=
ice?

> > Fix this by stripping simple comments before looking for Linux-specific
> > integer types.
> >
> > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
>
> Reviewed-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>

Thanks!

>
> > ---
> >  usr/include/headers_check.pl | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/usr/include/headers_check.pl b/usr/include/headers_check.p=
l
> > index 21c2fb9520e6af2d..75dfdce39e7f4610 100755
> > --- a/usr/include/headers_check.pl
> > +++ b/usr/include/headers_check.pl
> > @@ -155,6 +155,9 @@ sub check_sizetypes
> >       if (my $included =3D ($line =3D~ /^\s*#\s*include\s+[<"](\S+)[>"]=
/)[0]) {
> >               check_include_typesh($included);
> >       }
> > +     # strip comments (single-line and C99 only)
> > +     $line =3D~ s@\/\*.*?\*\/@@;
> > +     $line =3D~ s@\/\/.*$@@;
>
> C99/C++ comments are rejected in UAPI headers, so this line can be droppe=
d.

'git grep "//" -- "*uapi*.h"' disagrees...

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

