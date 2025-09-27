Return-Path: <linux-kernel+bounces-834885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3ECBA5C25
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 11:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5766C16E4F5
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 09:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0552D5C92;
	Sat, 27 Sep 2025 09:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EgACOK+1"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC2123BF9B
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 09:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758964345; cv=none; b=f6mmS7rAtwsERiX1wR+oO5h0JNMk5XNygXdYmzW9H9MRUJ/0yR7SkzMlZvNRb3pR6pFKYvYNtSnSt2ArMk+UOD2yqtzB+kWhpU/c+RAhbYTuS0yX3BhvW/yJa17Mz8ZvdjIglPiD8Vasde9B7dgo51WTVSyf4QKCtg0rZ5CdBZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758964345; c=relaxed/simple;
	bh=+pGe3F9Wyt6J36sXviOvj0VrqTw4kZNLOZ6ewjfpf/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YuRpQ4aSxjQgSaSIrtUQXc91iktSzlO3ghYorCt89oSly0IFrfxTACKko7ZYLVuFWuPUllGVRIP0x0tHeTQGDi+5j4EzoRYJKU3+ekSf/5WQMWZqs4EDnlG7WemQyRTnaIwfzfsNbIyACtKvFcC6GC0L/GOtlFd9EyeInJWRyD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EgACOK+1; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-32eb76b9039so3527168a91.1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 02:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758964342; x=1759569142; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mIZgaRKGhoxWkvHAy+1tENSc1M17jx2ezAwOCvUOvKM=;
        b=EgACOK+1PJB6vDJ0SAFrQp5mPgnSve2UKIM77WgcKmuXGkDmIYmOLd0palRUvTUE/0
         X/VQkOndGuXfgZVpbxQFlJHXf0rYAW8tA4mm8YBrb8fumMTEzypMt53G3vcDiCA7RmWc
         3fvwHBTUzGYCwj9iMEAFvJGWdmQ0gzdkBuokHicDphClNhxJeARsDD/jMqD/8Sm+VNyJ
         sn4HlVuDVcXeAi5pFcjnwcXS4lMM1Hje67tJU9jK69v+B70GPh5dnixghjZ2avVjPcZv
         1wol8BiSkJzNhfszOA5cgiaIAL+y1Q+O1fYuIMos3bKgjD2GuiAZbobURPUzTKFVIQU/
         tbEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758964342; x=1759569142;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mIZgaRKGhoxWkvHAy+1tENSc1M17jx2ezAwOCvUOvKM=;
        b=WvX90Xs8DXxbhWedJnx9jAJ3d3ayynRFscnCvCuIaejC+9HJyFB9H8Y9FLpK+KKIzo
         LNSS8Vv5F4GoPaJdXnP94m4ki9cwocuYFn8rIcFmt6Iqtll9n0exKb40I8CQw6xzP5ly
         YemEAPg/KxIeWB25VvTUbUzVjbwaLxHDgBy7aghzr6eE664PERy4WK4iZzQ+Jb/OfU8A
         KLBb1gFAjc6+3zPDy8BM7MdQPLmssA6rt6RV05+4hxEd6EdqlZQxs144mhHY8LjlWhXb
         2uI2BIbTBMUrq5/S06D37nRRL5sazj+rCOxtt9VYlFssP/Zxogtom/stPF8CSC4Bt21K
         inKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhH1PofwUMpxI+uTi/qMx9ZDL2sSeWMHdbPNEqCNK6WNkwf/tCAi+HCz5YznSLo60FelIlpuRsSVnJ71I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ8Cc1NjOEGiCbO1C33je3PV4RD2Lun5aXBCz0uUworSiu4J2g
	sVtWSKaOSoZIAF32xwaOuU+3fNOaapGxJn9ca0q/rhILlkB7g37dMQI3
X-Gm-Gg: ASbGnctGrKb4ytHNapJKwpH1uFlFX/8SbvfIqj0CBC5S+veSch39SL+Ytsk8TSedmnT
	+PvaV0RG6/NAHuta5FVE3WX8+5uHgOqBkX87WHNQp0yUe0n0u85I4Gcx2OPdxAQO89Btn6dtbNe
	J8WPFxNfgd9KhgQs5yPbjikNWfjK+LWBlwLkLvsH3o6hjU9kG7Rm7nMKty2KAWRHorWRSO1x/3+
	BDj/N1jBcAj8STsZvh3Dr8kDVU96c8UeMRJ5uC3okrt6I02CMpRj2QAn1WIyJZO2iGDpDRoai2f
	2dI+5BJf2HJ+EZlc4p2eVYwjRPNdVVLlz1xldH9j+SvddVpDf7gD+cDN69iwsuZ+PCTKcC+O4YJ
	8uRbvpzuzTOZ6K9uF9il5m1QlOrqr/GcIOw72FBL1kEwIezF1owqLwtigI3iP1EBbkeq/
X-Google-Smtp-Source: AGHT+IHaJg4dHImv6wsjXivv+eH0xv3qmlqiUA3ELNxaY4YHxl0i1sgYrjR3kpZPWHUErts99XbHaA==
X-Received: by 2002:a17:90b:1d8a:b0:335:2eef:4ca8 with SMTP id 98e67ed59e1d1-3352eef4edcmr5690404a91.33.1758964342131;
        Sat, 27 Sep 2025 02:12:22 -0700 (PDT)
Received: from [10.0.2.15] (KD106167137155.ppp-bb.dion.ne.jp. [106.167.137.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3341be3a010sm11164207a91.28.2025.09.27.02.12.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Sep 2025 02:12:21 -0700 (PDT)
Message-ID: <1d993906-bae3-41eb-963f-de960cc56dd0@gmail.com>
Date: Sat, 27 Sep 2025 18:12:19 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] docs: Makefile: avoid a warning when using without
 texlive
To: mchehab+huawei@kernel.org
Cc: corbet@lwn.net, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 rdunlap@infradead.org, Akira Yokosawa <akiyks@gmail.com>
References: <e23e03dd41e044d55e4ae24ffd9e1b49e3f2515a.1758881658.git.mchehab+huawei@kernel.org>
 <f9ceb569-363c-4806-9451-4a4ef83b38ca@gmail.com>
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <f9ceb569-363c-4806-9451-4a4ef83b38ca@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Sorry, a quick follow-up.

On Sat, 27 Sep 2025 16:35:08 +0900, Akira Yokosawa wrote:
> On Fri, 26 Sep 2025 12:16:19 +0200, Mauro Carvalho Chehab wrote:
>> As reported by Randy, running make htmldocs on a machine
>> without textlive now produce warnings:
>>
>>     $ make O=DOCS htmldocs
>>     ../Documentation/Makefile:70: warning: overriding recipe for target 'pdfdocs'
>>     ../Documentation/Makefile:61: warning: ignoring old recipe for target 'pdfdocs'
>>
>> That's because the code has now two definitions for pdfdocs in
>> case $PDFLATEX command is not found. With the new script, such
>> special case is not needed anymore, as the script checks it.
>>
>> Drop the special case. Even after dropping it, on a machine
>> without LaTeX, it will still produce an error as expected,
>> as running:
>>
>>     $ ./tools/docs/sphinx-build-wrapper pdfdocs
>>     Error: pdflatex or latexmk required for PDF generation
>>
>> does the check. After applying the patch we have:
>>
>>     $ make SPHINXDIRS=peci htmldocs
>>     Using alabaster theme
>>     Using Python kernel-doc
>>
>>     $ make SPHINXDIRS=peci pdfdocs
>>     Error: pdflatex or latexmk required for PDF generation
>>     make[2]: *** [Documentation/Makefile:64: pdfdocs] Error 1
>>     make[1]: *** [/root/Makefile:1808: pdfdocs] Error 2
>>     make: *** [Makefile:248: __sub-make] Error 2
>>
>> Which is the expected behavior.
>>
> 
> There seems to be a related issue.
> 
> At current "docs-mw", under build environments who don't have xelatex nor latexmk,
> 
>     $ make SPHINXDIRS=peci latexdocs
> 
> completes without any issue.
> 
> In the resulting .../latex/peci directory, one can run

     I meant:      .../peci/latex

> 
>     $ make PDFLATEX="latexmk -xelatex" LATEXOPTS="-interaction=batchmode -no-shell-escape"
> 
> and build peci.pdf.

I failed to mention, but of course you need to transfer/share said
.../peci/latex/ to another build environment who has all the required
packages for "pdfdocs".

I often use such heterogeneous combination of running "make latexdocs"
+ running make under each of .../$SPHINXDIRS/latex/ using another
environment.

This way, you need only one set of working texlive packages for testing
against various Sphinx's latex builder releases.

> 
> At current "build-scripts", I get this:
> 
>     $ make SPHINXDIRS=peci latexdocs
>     Error: pdflatex or latexmk required for PDF generation
>     make[2]: *** [Documentation/Makefile:68: latexdocs] Error 1
>     make[1]: *** [<srcdir>/Makefile:1806: latexdocs] Error 2
>     make: *** [Makefile:248: __sub-make] Error 2
> 
> Patch 2/2 doesn't change the behavior.
> 
> This is yet another regression.  Please teach sphinx-build-wrapper of the
> fact that "latexdocs" does not run those texlive commands.  It is only the
> "pdfdocs" phase that will run them.
> 

You see, "make latexdocs" is supposed to generate all the necessary files
for building PDFs to be consumed by make + latexmk/xelatex.
There is a clear boundary between "latexdocs" and "pdfdocs".

Thanks,
Akira

> Regards,
> Akira
> 
>> Reported-by: Randy Dunlap <rdunlap@infradead.org>
>> Link: https://lore.kernel.org/linux-doc/e7c29532-71de-496b-a89f-743cef28736e@infradead.org/
>> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>


