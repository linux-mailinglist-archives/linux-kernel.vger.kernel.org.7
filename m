Return-Path: <linux-kernel+bounces-777151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2588CB2D607
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 10:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E7A51B67E7E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 08:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5CBA2D9485;
	Wed, 20 Aug 2025 08:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PzLyplsk"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E752D8DD6;
	Wed, 20 Aug 2025 08:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755677778; cv=none; b=ce1Fyv3jYfuI5VpU+ycmTgklcd1sSYsqkUV9Zs0jRJInZctVFIStMoqbKzkBjMpXy90Edounlihk/MUmKj/AqHuGlDXO+UpWA84ojN699KpSnl1osfc6e78M+udIZ0XGwuIaxLEetbNpg6BIfJAfsMELz7JQXQ5e53i5ptYe6Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755677778; c=relaxed/simple;
	bh=IudW00VtJS0Q8BurML9WpP7+hMJo0E73F15/H3LBDJQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=jpxyEuXysY/oYC8FtWqPq6DhtXNxNwIozZZS160p9vgFHsufVf05cn8vI4LCXJlXNAlDXsWPtsF2Mnde9b9dQxwjyyNNftMquoW7t/i0xGTZybxJgyn/cBXWX0BkZBfDfJ5PAQdSL9x+aXvPyZh20pdpVcA4b2lY9r6hLxedLB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PzLyplsk; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-76e1fc69f86so531970b3a.0;
        Wed, 20 Aug 2025 01:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755677775; x=1756282575; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fYmhEH4K4d+fDyfESiGyhVvw1HTIEYtbH9NjSIIzwI0=;
        b=PzLyplskcaCqxsZ2xOEtvFTrJMA6UY97065JdJBE2zE4Xkc6LQqXr1SYEAYXKf7i1M
         9xKHw7uACShsIRs0O7vW1XtuckUrqs37SzPIA/YLcAK5eRakDbetTJgBTidaHqS088+q
         Wq1gCmNsA+PbMlAM0AgJiXP0J0fvYeTzK/wDr7CdIHF0wMdbzR5HQDvNyy87jn8+07of
         NMrHfgX375HpqFFFNvQeR7a8KFuJWXYiS7gfBI+GfwS3+G94jWdILLND1/LZb6qPqFN6
         ZBY2TJ8MAZm2RVyx9m4pDBqOoWKW6pwC+rBFiDUT9k/DMLsFjTSyrBMJL/h258sMPuNX
         alZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755677775; x=1756282575;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fYmhEH4K4d+fDyfESiGyhVvw1HTIEYtbH9NjSIIzwI0=;
        b=Xj400rylpk9Ew+tjYx+fHM+2qVGuLwkQ+Ny9l8RDtOR6Kf7h8TWzd25wEAPYLIoIfF
         5SynesVqjPa/Px9m7EA4RMwzee8/Uy1f8dxGGMVhM7LtLVtUpL2F0AXXjgjm1Abryql9
         TEFItl7diEbLFxHniNtfiYwC4wshML+mtUAiA5NJRP+Rsy3iFSRgsJEJYEZTHfcQ5N1H
         XCMC5jPz1sBfQ7IOu4Mv0kGZgp6ST2Bs3NbDGDhWwvsO0BMeSfxBYIrAaLZxxXCvdKzc
         ztUWyOlnV16rW2bDKIkn7cVc44Cl4H9cd1eYZSlfm+6/izEYzOVmAzEayNVBhrQeAnJ5
         3lYA==
X-Forwarded-Encrypted: i=1; AJvYcCV+hIkun0nn98pIjAPbn6fTXC7jPx3cGGVBwHBNwLtM4qcfE6s/RWWwdy/H6ULdPGTBHLx6mO4fEiU=@vger.kernel.org, AJvYcCVlkSo48avG0MHreqGSMeBhfGpCHKgjHQATfMDBvoGvRvk4lQFzfUv//gHXfrfu3Ehg877nt1qFDihcdGyL@vger.kernel.org
X-Gm-Message-State: AOJu0YzTdDdTmqsDqEidgU5gGnWx2N57gJpDuIwjTJdqSM1nd4N1hb04
	qQehYvqkX4b4rwyb84/9Qg9qrmH0rpIAohIMj2695RgZ0D3C+cSgtc00UcBUlA==
X-Gm-Gg: ASbGncuSgDDGk4Je3J5cNqJCgu8sdkX6DGJGty3KWN708WIoNrPOebGYS+Jy3lFFzKT
	YanZTBwyfkbO60Q6f43DunVmrR5C+VOsmcQZysT8rw8GwKJ6dLvtjlQCCihlnT+PWTTkdJx+FYL
	WiVS3CmqJ5NdV4CVshvfhudZfBvIxYFKjZ1K7VOzZvOn9IpIM1dtbDC5OSggVfAwq4P/JAbtVyL
	2XAzkO04s30F0sqrk0jXT8A5Wnbwx5JjAu48Eqm/jiqQviDhwXeNOjs1ueirP+1WabXoO99bz0n
	pZjV9DzAY9Zy7hE3QfeLXGBpx1BxPkiopRjgD4hkKCDREtgoUr2eAVZzz8StC3bDs0oLb1snPfg
	/Yxw3z3GFpiBbs9nIHxTMVXiOJfPNUiAK/AoAuNZ6BLgLjPyBNhiTkH62dN/20wbyJlk6
X-Google-Smtp-Source: AGHT+IE7bxhpAJ+akfdkUWBiA7hScOD3JNt2fRrJY/N0X4615uixr90zSZzDnI7omvoMF1q8M8zELw==
X-Received: by 2002:a17:902:d60d:b0:245:f6aa:1cd0 with SMTP id d9443c01a7336-245f6aa2147mr3016945ad.17.1755677774532;
        Wed, 20 Aug 2025 01:16:14 -0700 (PDT)
Received: from [10.0.2.15] (KD106167137155.ppp-bb.dion.ne.jp. [106.167.137.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed374f81sm19132735ad.55.2025.08.20.01.16.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Aug 2025 01:16:14 -0700 (PDT)
Message-ID: <bf58f8ef-5fe8-435c-a2d5-efe0f2fd2ebd@gmail.com>
Date: Wed, 20 Aug 2025 17:16:11 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH 05/11] docs: conf.py: fix some troubles for LaTeX output
To: mchehab+huawei@kernel.org
Cc: corbet@lwn.net, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Akira Yokosawa <akiyks@gmail.com>
References: <ceaa9512336444bd148511a4a3bbc336ca317757.1755256868.git.mchehab+huawei@kernel.org>
Content-Language: en-US
In-Reply-To: <ceaa9512336444bd148511a4a3bbc336ca317757.1755256868.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mauro,

Looks like my word choice annoyed you.  Apologies again.

I've just realized your response while composing this, but I'm sending
it anyway.  Please see below.

On Fri, 15 Aug 2025 13:36:21 +0200, Mauro Carvalho Chehab wrote:
> While PDF docs work fine on RPM-based distros, it causes conflicts
> on Debian & friends:
> 
> Documentation/output/process/latex/process.log:
> 
> 	Package: fontenc 2021/04/29 v2.0v Standard LaTeX package
> 	LaTeX Font Info:    Trying to load font information for T1+lmr on input line 11
> 	6.
> 	LaTeX Font Info:    No file T1lmr.fd. on input line 116.
> 
> 	LaTeX Font Warning: Font shape `T1/lmr/m/n' undefined
> 	(Font)              using `T1/lmr/m/n' instead on input line 116.
> 
> 	! Corrupted NFSS tables.
> 	wrong@fontshape ...message {Corrupted NFSS tables}
>                                                   error@fontshape else let f...
> 	l.116 ...\familydefault\seriesdefault\shapedefault
> 
> Change some logic inside latex_elements to avoid such issues,
> following the example from Sphinx documentation:
> 
> 	https://www.sphinx-doc.org/en/master/latex.html
> 

I spotted a wrong looking LaTeX macro use.  See below:

> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/conf.py | 39 +++++++++++++++++++++++----------------
>  1 file changed, 23 insertions(+), 16 deletions(-)
> 
> diff --git a/Documentation/conf.py b/Documentation/conf.py
> index 6e12c7d8e07e..712e0a016727 100644
> --- a/Documentation/conf.py
> +++ b/Documentation/conf.py
> @@ -9,6 +9,8 @@ import os
>  import shutil
>  import sys
>  
> +from  textwrap import dedent
> +
>  import sphinx
>  
>  # If extensions (or modules to document with autodoc) are in another directory,
> @@ -454,19 +456,38 @@ htmlhelp_basename = "TheLinuxKerneldoc"
>  latex_elements = {
>      # The paper size ('letterpaper' or 'a4paper').
>      "papersize": "a4paper",
> +    "passoptionstopackages": dedent(r"""
> +        \PassOptionsToPackage{svgnames}{xcolor}
> +        % Avoid encoding troubles when creating indexes
> +        \PassOptionsToPackage{xindy}{language=english,codepage=utf8,noautomatic}
> +    """),

This use of \PassOptionsToPackage{}{} looks very wrong, because its 1st
argument is the option string you would like to pass to a latex package
given in the 2nd argument.

See: https://latexref.xyz/_005cPassOptionsToClass-_0026-_005cPassOptionsToPackage.html

Furthermore, as there is no such latex package named "xindy",
this will have any effect even if you reverse the argument order.

I imagine you had some illusion and believed it would fix some issue
you had observed.

Also, I don't see the need of \PassOptionsToPackage{svgnames}{xcolor}.
Please clarify who needs that color namespace option in the changelog.

>      # The font size ('10pt', '11pt' or '12pt').
>      "pointsize": "11pt",
> +    # Needed to generate a .ind file
> +    'printindex': r'\footnotesize\raggedright\printindex',

I would mention this as an improvement in the changelog.

And the following changes look good to me.

Thanks, Akira

>      # Latex figure (float) alignment
>      # 'figure_align': 'htbp',
>      # Don't mangle with UTF-8 chars
> +    "fontenc": "",
>      "inputenc": "",
>      "utf8extra": "",
> +    'fontpkg': dedent(r'''
> +        \usepackage{fontspec}
> +        \setmainfont{DejaVu Serif}
> +        \setsansfont{DejaVu Sans}
> +        \setmonofont{DejaVu Sans Mono}
> +        \newfontfamily\headingfont{DejaVu Serif}
> +    '''),
>      # Set document margins
> -    "sphinxsetup": """
> +    "sphinxsetup": dedent(r"""
>          hmargin=0.5in, vmargin=1in,
>          parsedliteralwraps=true,
>          verbatimhintsturnover=false,
> -    """,
> +    """),
> +    "preamble": dedent(r"""
> +        % Load kerneldoc specific LaTeX settings
> +        \input{kerneldoc-preamble.sty}
> +    """),
>      #
>      # Some of our authors are fond of deep nesting; tell latex to
>      # cope.
> @@ -474,22 +495,8 @@ latex_elements = {
>      "maxlistdepth": "10",
>      # For CJK One-half spacing, need to be in front of hyperref
>      "extrapackages": r"\usepackage{setspace}",
> -    # Additional stuff for the LaTeX preamble.
> -    "preamble": """
> -        % Use some font with UTF-8 support with XeLaTeX
> -        \\usepackage{fontspec}
> -        \\setsansfont{DejaVu Sans}
> -        \\setromanfont{DejaVu Serif}
> -        \\setmonofont{DejaVu Sans Mono}
> -    """,
>  }
>  
> -# Load kerneldoc specific LaTeX settings
> -latex_elements["preamble"] += """
> -        % Load kerneldoc specific LaTeX settings
> -        \\input{kerneldoc-preamble.sty}
> -"""
> -
>  # This will be filled up by config-inited event
>  latex_documents = []
>  

