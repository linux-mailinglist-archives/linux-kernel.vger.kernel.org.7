Return-Path: <linux-kernel+bounces-835945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6056CBA869E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 10:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BBBF16F9E7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 08:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534BF266B52;
	Mon, 29 Sep 2025 08:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VLGBCqIN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999CF258CE7;
	Mon, 29 Sep 2025 08:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759135145; cv=none; b=pSOHLsr+d9zjTNZ5WszbS7wuIzuP7A4MiMSpGjB5Zs/pQxtMuLuw9IfdhiaOkCBXDdLW+rqtffsbNkeKD4LOgwP2c494zvAKfYaDcB8NHjnDpau0TG2AAVAqkeGFLOpuBhZHaI383x5+yF+E9SUiMPZ7SbeA7YaTh+KcAcQxLkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759135145; c=relaxed/simple;
	bh=4ZnJM9NZcxpYBaNkmuPhjRp1VdvB+zXJlpGwKpRLn1k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j73JxhtpmkYpwnNbvnlEHzhtkylBppIdY46L9a2tagrD9yxdt/5alAolz8oYDdrHj9l4EZwJbHm8DW7M2YwYDRAt8FXCwsDedpdOI/TgnmeBsHkIGs5tMS+6wYXUTBvkKQVe5NYY72l5acuhfoRD/sTPoOQcYQexmqka/B3YLr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VLGBCqIN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2955C4CEF4;
	Mon, 29 Sep 2025 08:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759135145;
	bh=4ZnJM9NZcxpYBaNkmuPhjRp1VdvB+zXJlpGwKpRLn1k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VLGBCqINRyKEAaZaQd+3uNgpyfoR6TJTZ09B6EcgPZFEyr2s4Av1p9hiDb1F2RlJU
	 /mC4sRjx+svu6XcNBOq5XAQzE0ouukkw3YRQ5b/mM401E3YGtjiHZxa2ceDoRi38Th
	 GUscUJmVkHVJfW83xa67nFyqpzUxsqbmArDu6GYl+81Fsp2qMzKuOo4j7mTdASGmu/
	 jUq/Q5HKKPM/cbzXdEPAyo6gyWNqA5Ru+S8jLaVnajxrf2nP/nvzZ39+7t+dab6RM8
	 W0MLXCcnQRXmwUlk/SnD281AU3da7jRtoqL9GywieckP+9QXWHof4TyuDifOxNbgrB
	 SQ0+U2xj05BSg==
Date: Mon, 29 Sep 2025 10:39:00 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Akira Yokosawa <akiyks@gmail.com>
Cc: corbet@lwn.net, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 rdunlap@infradead.org
Subject: Re: [PATCH 2/2] docs: Makefile: avoid a warning when using without
 texlive
Message-ID: <20250929103900.19c11b9a@foz.lan>
In-Reply-To: <1d993906-bae3-41eb-963f-de960cc56dd0@gmail.com>
References: <e23e03dd41e044d55e4ae24ffd9e1b49e3f2515a.1758881658.git.mchehab+huawei@kernel.org>
	<f9ceb569-363c-4806-9451-4a4ef83b38ca@gmail.com>
	<1d993906-bae3-41eb-963f-de960cc56dd0@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Sat, 27 Sep 2025 18:12:19 +0900
Akira Yokosawa <akiyks@gmail.com> escreveu:

> Sorry, a quick follow-up.
> 
> On Sat, 27 Sep 2025 16:35:08 +0900, Akira Yokosawa wrote:
> > On Fri, 26 Sep 2025 12:16:19 +0200, Mauro Carvalho Chehab wrote:  
> >> As reported by Randy, running make htmldocs on a machine
> >> without textlive now produce warnings:
> >>
> >>     $ make O=DOCS htmldocs
> >>     ../Documentation/Makefile:70: warning: overriding recipe for target 'pdfdocs'
> >>     ../Documentation/Makefile:61: warning: ignoring old recipe for target 'pdfdocs'
> >>
> >> That's because the code has now two definitions for pdfdocs in
> >> case $PDFLATEX command is not found. With the new script, such
> >> special case is not needed anymore, as the script checks it.
> >>
> >> Drop the special case. Even after dropping it, on a machine
> >> without LaTeX, it will still produce an error as expected,
> >> as running:
> >>
> >>     $ ./tools/docs/sphinx-build-wrapper pdfdocs
> >>     Error: pdflatex or latexmk required for PDF generation
> >>
> >> does the check. After applying the patch we have:
> >>
> >>     $ make SPHINXDIRS=peci htmldocs
> >>     Using alabaster theme
> >>     Using Python kernel-doc
> >>
> >>     $ make SPHINXDIRS=peci pdfdocs
> >>     Error: pdflatex or latexmk required for PDF generation
> >>     make[2]: *** [Documentation/Makefile:64: pdfdocs] Error 1
> >>     make[1]: *** [/root/Makefile:1808: pdfdocs] Error 2
> >>     make: *** [Makefile:248: __sub-make] Error 2
> >>
> >> Which is the expected behavior.
> >>  
> > 
> > There seems to be a related issue.
> > 
> > At current "docs-mw", under build environments who don't have xelatex nor latexmk,
> > 
> >     $ make SPHINXDIRS=peci latexdocs
> > 
> > completes without any issue.
> > 
> > In the resulting .../latex/peci directory, one can run  
> 
>      I meant:      .../peci/latex
> 

True. This is an one-line fix:

	@@ -650,7 +650,7 @@ class SphinxBuilder:
	             if not sphinxbuild and target != "mandocs":
	                 sys.exit(f"Error: {self.sphinxbuild} not found in PATH.\n")
	 
	-        if builder == "latex":
	+        if target == "pdfdocs":
	             if not self.pdflatex_cmd and not self.latexmk_cmd:
	                 sys.exit("Error: pdflatex or latexmk required for PDF generation")

With that:

	$ make SPHINXDIRS=peci latexdocs
	Using alabaster theme
	Using Python kernel-doc
	WARNING: dot(1) not found, for better output quality install graphviz from https://www.graphviz.org

	$ tree Documentation/output/
	Documentation/output/
	`-- peci
	    `-- latex
	...
	        |-- Makefile
	...
        	|-- peci.tex
	...

	$ make SPHINXDIRS=peci pdfdocs
	Error: pdflatex or latexmk required for PDF generation
	make[2]: *** [Documentation/Makefile:64: pdfdocs] Error 1
	make[1]: *** [/root/Makefile:1808: pdfdocs] Error 2
	make: *** [Makefile:248: __sub-make] Error 2

	$ (cd Documentation/output/peci/latex/; make)
	latexmk -pdf -dvi- -ps-  'peci.tex'
	make: latexmk: No such file or directory
	make: *** [Makefile:29: peci.pdf] Error 127

the original behavior is restored.

> > 
> >     $ make PDFLATEX="latexmk -xelatex" LATEXOPTS="-interaction=batchmode -no-shell-escape"
> > 
> > and build peci.pdf.  
> 
> I failed to mention, but of course you need to transfer/share said
> .../peci/latex/ to another build environment who has all the required
> packages for "pdfdocs".
> 
> I often use such heterogeneous combination of running "make latexdocs"
> + running make under each of .../$SPHINXDIRS/latex/ using another
> environment.
> 
> This way, you need only one set of working texlive packages for testing
> against various Sphinx's latex builder releases.
> 
> > 
> > At current "build-scripts", I get this:
> > 
> >     $ make SPHINXDIRS=peci latexdocs
> >     Error: pdflatex or latexmk required for PDF generation
> >     make[2]: *** [Documentation/Makefile:68: latexdocs] Error 1
> >     make[1]: *** [<srcdir>/Makefile:1806: latexdocs] Error 2
> >     make: *** [Makefile:248: __sub-make] Error 2
> > 
> > Patch 2/2 doesn't change the behavior.
> > 
> > This is yet another regression.  Please teach sphinx-build-wrapper of the
> > fact that "latexdocs" does not run those texlive commands.  It is only the
> > "pdfdocs" phase that will run them.
> >   
> 
> You see, "make latexdocs" is supposed to generate all the necessary files
> for building PDFs to be consumed by make + latexmk/xelatex.
> There is a clear boundary between "latexdocs" and "pdfdocs".

True.

Such patch should address your usecase: it will allow building
tex files on one machine and generate pdf on a different one.

Thanks,
Mauro

