Return-Path: <linux-kernel+bounces-840486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B96ABB487A
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 18:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7769C3C5351
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 16:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7D925A2A7;
	Thu,  2 Oct 2025 16:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LjlIrEwO"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B771547C9
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 16:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759422339; cv=none; b=P327g1KWX3xucuFivbbnWbqTqoMceNUWwAkM3EVfRzD2Jf962tGdhvoCwjIEz+rQMvmyrDEl3lGkKPhWwVkIj/R5WooSyfLniuoR8HflDGWg46tx2hp6+qgB1pkqZSOIXVaA7pVKkE8LofBV42nA+nH3+LYMiUBW1sFmTqXRiV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759422339; c=relaxed/simple;
	bh=t6du61VAJtRwD2pHT5Nx2kXbJzbyxz2+XF8gh1dI6e8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AIs2YZKDCgmA96JrFfNKEiFmPoxFDM5UDibvz03uEvgMYZwFY1+3P9xX67qyqHrucXNAM1oQn0XSvqOvwo3rmHbDeQUzHMjqTZ1+/Of4r37P/qcF3lVBFkRSlGgBnuKjrMxUcbGfLt1I5WI+S4hnRQq1tKB4/X6Yd5/AVxfJjF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LjlIrEwO; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3306d93e562so1335365a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 09:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759422337; x=1760027137; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a/LcWwKZNj1HPTQJ9R4ahcJgaN9glTDCL3e/9ocj2YM=;
        b=LjlIrEwO+Xlyfl/zroNXt4z3/2rx0EhPrlPmA/YfMvb16j3cAXXYTd3pc4ygQY6REz
         L7cpw89Ysb+Uhdwe/skKjlqVWb+Jbhawy26bkP3sI+RlBmCeFg7odXtWlFMYdC9uECsd
         rQjRv5kv9LUw0XrAyg34aXY0xcItSoiw1I+4+HfYFK9HIs5o/Q+hC7ATVQhYjVHj7rIT
         vvK3SGnmIZ9Vb1qB13PflsEq21UC4EsM4j0sBqwB6pFHIouPJj8nuDCPlpGcHzYwNxxu
         EpGBRp3ZXtmAENYj/H5hMfi6eTiJ9jLKvdDejD62psKeBpR0ryowDq4uGe/fbVx19Y7B
         TEgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759422337; x=1760027137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a/LcWwKZNj1HPTQJ9R4ahcJgaN9glTDCL3e/9ocj2YM=;
        b=Wy2e80vs7VcSYocyMfxWduX9xuwBW77M62W7fPyQ6Es6UZ0uCjs7kaZZWI8mG6dmts
         GeFScG2OKw+d//exl6HmWzW3kEW6yoFYz4yFJWcIDSqOcSeGS8s57SJW4Q39Kvis0/rU
         YsO+VJMqVrkjapiy3A961XT9CkEnuItM84F7+Q/BJt1beC79XB20C+06f9CX7dYYdPaU
         05vtjctp7BgjMvsRiD/wAjsfMziLHoGTPnlSjAY3Mb6sO++Bfo3g96RjhlEN4IsCbDeM
         Al3yq70amp9vje0eqeOdHE6CVJkfnt2gsAxiXH77J3IryqLpxYRNAJpzm930Pwa8TVQH
         pXmA==
X-Forwarded-Encrypted: i=1; AJvYcCWtO/JmjR70r39pdjpCqQiWkdNH/5uBoopgWRUxveNU1DK5OSxaWof7PQSHYazI61mODbuGobpXn9vwsjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJYI7HGN2dv0TcgxAQ4u2xyAYJAzTEoPMqa0GZYreQJ5rslmiI
	fnQETwVi3ZV1ArTmrrtwc7x9rrCLo+ZdJwtK4S8BqAHppYtCO6mBSSPRC558Vv2akwODkduC4YR
	7uGPvuOkwHNHGorA8AiMi/7nX0pF4iwQ=
X-Gm-Gg: ASbGnctjBefc75XTgR2dzodORy3GjiXxWxKRY/q0UGIuZxrW019EhYtapPb+rAMg2+t
	FSy5oqbdi1YK+Le/i/9mrk09aRbWc5m3fMLWrZaNJwwS6PbrSjj1rGrrkE6GoetoI/H/cAjepXc
	QE7luH3Th5Vaptq0qw99S+bvkM3qqatV5eVk0SMmvw0Di5FrWsmrXgO7mL3LHLNHQIW7+7OMr3m
	cUnhs0a+D4Zw7g3G66E5nJrVt+TFRI=
X-Google-Smtp-Source: AGHT+IHGczkjY8pK3fUrKGmmMN98FOE0PhB+bNon8t2TVzWsB01HazSZNv76ksv451jyp5Npy8jpaRipjEN65znWIBg=
X-Received: by 2002:a17:90b:3ec3:b0:330:6c5a:4af4 with SMTP id
 98e67ed59e1d1-339a6f78dc3mr9797809a91.35.1759422336745; Thu, 02 Oct 2025
 09:25:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ceaa9512336444bd148511a4a3bbc336ca317757.1755256868.git.mchehab+huawei@kernel.org>
 <bf58f8ef-5fe8-435c-a2d5-efe0f2fd2ebd@gmail.com>
In-Reply-To: <bf58f8ef-5fe8-435c-a2d5-efe0f2fd2ebd@gmail.com>
From: ChaosEsque Team <chaosesqueteam@gmail.com>
Date: Thu, 2 Oct 2025 12:30:33 -0400
X-Gm-Features: AS18NWC5nXXH51uptSupTru-HwNna4W_npNxx7MMPaM0Ae8CAbeiqwnB0Xia6wE
Message-ID: <CALC8CXdNRwWnQyfA0UK657JOm6vZnH-6nOpDSjMbZkhqyiQb8g@mail.gmail.com>
Subject: Re: [PATCH 05/11] docs: conf.py: fix some troubles for LaTeX output
To: Akira Yokosawa <akiyks@gmail.com>
Cc: mchehab+huawei@kernel.org, corbet@lwn.net, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

AKIRA!

On Wed, Aug 20, 2025 at 4:18=E2=80=AFAM Akira Yokosawa <akiyks@gmail.com> w=
rote:
>
> Hi Mauro,
>
> Looks like my word choice annoyed you.  Apologies again.
>
> I've just realized your response while composing this, but I'm sending
> it anyway.  Please see below.
>
> On Fri, 15 Aug 2025 13:36:21 +0200, Mauro Carvalho Chehab wrote:
> > While PDF docs work fine on RPM-based distros, it causes conflicts
> > on Debian & friends:
> >
> > Documentation/output/process/latex/process.log:
> >
> >       Package: fontenc 2021/04/29 v2.0v Standard LaTeX package
> >       LaTeX Font Info:    Trying to load font information for T1+lmr on=
 input line 11
> >       6.
> >       LaTeX Font Info:    No file T1lmr.fd. on input line 116.
> >
> >       LaTeX Font Warning: Font shape `T1/lmr/m/n' undefined
> >       (Font)              using `T1/lmr/m/n' instead on input line 116.
> >
> >       ! Corrupted NFSS tables.
> >       wrong@fontshape ...message {Corrupted NFSS tables}
> >                                                   error@fontshape else =
let f...
> >       l.116 ...\familydefault\seriesdefault\shapedefault
> >
> > Change some logic inside latex_elements to avoid such issues,
> > following the example from Sphinx documentation:
> >
> >       https://www.sphinx-doc.org/en/master/latex.html
> >
>
> I spotted a wrong looking LaTeX macro use.  See below:
>
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >  Documentation/conf.py | 39 +++++++++++++++++++++++----------------
> >  1 file changed, 23 insertions(+), 16 deletions(-)
> >
> > diff --git a/Documentation/conf.py b/Documentation/conf.py
> > index 6e12c7d8e07e..712e0a016727 100644
> > --- a/Documentation/conf.py
> > +++ b/Documentation/conf.py
> > @@ -9,6 +9,8 @@ import os
> >  import shutil
> >  import sys
> >
> > +from  textwrap import dedent
> > +
> >  import sphinx
> >
> >  # If extensions (or modules to document with autodoc) are in another d=
irectory,
> > @@ -454,19 +456,38 @@ htmlhelp_basename =3D "TheLinuxKerneldoc"
> >  latex_elements =3D {
> >      # The paper size ('letterpaper' or 'a4paper').
> >      "papersize": "a4paper",
> > +    "passoptionstopackages": dedent(r"""
> > +        \PassOptionsToPackage{svgnames}{xcolor}
> > +        % Avoid encoding troubles when creating indexes
> > +        \PassOptionsToPackage{xindy}{language=3Denglish,codepage=3Dutf=
8,noautomatic}
> > +    """),
>
> This use of \PassOptionsToPackage{}{} looks very wrong, because its 1st
> argument is the option string you would like to pass to a latex package
> given in the 2nd argument.
>
> See: https://latexref.xyz/_005cPassOptionsToClass-_0026-_005cPassOptionsT=
oPackage.html
>
> Furthermore, as there is no such latex package named "xindy",
> this will have any effect even if you reverse the argument order.
>
> I imagine you had some illusion and believed it would fix some issue
> you had observed.
>
> Also, I don't see the need of \PassOptionsToPackage{svgnames}{xcolor}.
> Please clarify who needs that color namespace option in the changelog.
>
> >      # The font size ('10pt', '11pt' or '12pt').
> >      "pointsize": "11pt",
> > +    # Needed to generate a .ind file
> > +    'printindex': r'\footnotesize\raggedright\printindex',
>
> I would mention this as an improvement in the changelog.
>
> And the following changes look good to me.
>
> Thanks, Akira
>
> >      # Latex figure (float) alignment
> >      # 'figure_align': 'htbp',
> >      # Don't mangle with UTF-8 chars
> > +    "fontenc": "",
> >      "inputenc": "",
> >      "utf8extra": "",
> > +    'fontpkg': dedent(r'''
> > +        \usepackage{fontspec}
> > +        \setmainfont{DejaVu Serif}
> > +        \setsansfont{DejaVu Sans}
> > +        \setmonofont{DejaVu Sans Mono}
> > +        \newfontfamily\headingfont{DejaVu Serif}
> > +    '''),
> >      # Set document margins
> > -    "sphinxsetup": """
> > +    "sphinxsetup": dedent(r"""
> >          hmargin=3D0.5in, vmargin=3D1in,
> >          parsedliteralwraps=3Dtrue,
> >          verbatimhintsturnover=3Dfalse,
> > -    """,
> > +    """),
> > +    "preamble": dedent(r"""
> > +        % Load kerneldoc specific LaTeX settings
> > +        \input{kerneldoc-preamble.sty}
> > +    """),
> >      #
> >      # Some of our authors are fond of deep nesting; tell latex to
> >      # cope.
> > @@ -474,22 +495,8 @@ latex_elements =3D {
> >      "maxlistdepth": "10",
> >      # For CJK One-half spacing, need to be in front of hyperref
> >      "extrapackages": r"\usepackage{setspace}",
> > -    # Additional stuff for the LaTeX preamble.
> > -    "preamble": """
> > -        % Use some font with UTF-8 support with XeLaTeX
> > -        \\usepackage{fontspec}
> > -        \\setsansfont{DejaVu Sans}
> > -        \\setromanfont{DejaVu Serif}
> > -        \\setmonofont{DejaVu Sans Mono}
> > -    """,
> >  }
> >
> > -# Load kerneldoc specific LaTeX settings
> > -latex_elements["preamble"] +=3D """
> > -        % Load kerneldoc specific LaTeX settings
> > -        \\input{kerneldoc-preamble.sty}
> > -"""
> > -
> >  # This will be filled up by config-inited event
> >  latex_documents =3D []
> >
>

