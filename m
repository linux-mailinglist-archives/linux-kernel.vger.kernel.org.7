Return-Path: <linux-kernel+bounces-813723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD1BB549EF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FDF91892FFE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B4B2EA756;
	Fri, 12 Sep 2025 10:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bvXNL7oM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D014A41;
	Fri, 12 Sep 2025 10:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757673289; cv=none; b=CQqlIQoa2B9O6y2G/NmLgCoHY8JS7fP79MSTg3YOEXIrumOXxitNehjGWKEVjaLhwWHxpcvcqJe567HTFPWzGIyevOWbRfflKbXeGeMvN4tZ1Eu1dN+6ZU5dWUpZ0uMegEulr99AJYZy8cTIkf5HfVnv+XrHUnOte7w/Fu+42x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757673289; c=relaxed/simple;
	bh=z3yR9R772fLiKsgdbDgvnz8p7a4gJHXRkZsnhNQBv6w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XqZ/YjIp5P751YB/6ShrCObQo7f1BOcIv1FMAQUEIMpvYIA8BE1vFPNiwMw3Zk/Y3o+TuLILlPgKt4a2x5O01yIyojm4YVafHq6edyCj0Jj+DLXEOxff4zMSmdx5WJty1ehDqJRm6QMMJUmsiTa1/wj933pSS1sgKS97owjOSWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bvXNL7oM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B928DC4CEF1;
	Fri, 12 Sep 2025 10:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757673287;
	bh=z3yR9R772fLiKsgdbDgvnz8p7a4gJHXRkZsnhNQBv6w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bvXNL7oMxMrjWNObyESOmIxgjIWUhUpH0nm/VL9uybsU1gkYu2CL/wgOSc0EdZeQQ
	 tfPVKqONJ9L1ALleHlX7IM1nuABcmpdzm/rtn8MprwBexHZGW+yxZClZvpIw85mFmg
	 JTprNbZlFRHx6FZLsb9/6Xxo9q52RtCOqrNe8XNthUgCgCXEvu0Yu+7b8CTFyWxKc0
	 JPc+x5TndyZjwOibqKlfJw1ty/mE6eLgdg1W9xiKLlJ/rYGav8Ak21cjiL+dtV6ZRm
	 aF79BmJJ0xR/txAcn4pRk05TL2hul6mYvoxgQ0Ag8kHP7domBLFw5T7VXdVlfONz8y
	 xQgWTfJ5Kw47w==
Date: Fri, 12 Sep 2025 12:34:43 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Linux Doc Mailing List
 <linux-doc@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 12/19] docs: Makefile: document latex/PDF PAPER=
 parameter
Message-ID: <20250912123443.49f15a0e@foz.lan>
In-Reply-To: <afdbf04ade2d9bc0eb9b83639b31ffe65e0ad2c7@intel.com>
References: <cover.1756969623.git.mchehab+huawei@kernel.org>
	<52411bce7bf0d068bfc8e33b35db3259c3ae0c64.1756969623.git.mchehab+huawei@kernel.org>
	<d20b612ee510c65dcd60183eda5068b164294759@intel.com>
	<20250912105618.10e7953e@foz.lan>
	<afdbf04ade2d9bc0eb9b83639b31ffe65e0ad2c7@intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Fri, 12 Sep 2025 12:23:38 +0300
Jani Nikula <jani.nikula@linux.intel.com> escreveu:

> On Fri, 12 Sep 2025, Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> > Em Wed, 10 Sep 2025 13:54:07 +0300
> > Jani Nikula <jani.nikula@linux.intel.com> escreveu:
> >  
> >> On Thu, 04 Sep 2025, Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:  
> >> > While the build system supports this for a long time, this was
> >> > never documented. Add a documentation for it.
> >> >
> >> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> >> > ---
> >> >  Documentation/Makefile | 2 ++
> >> >  1 file changed, 2 insertions(+)
> >> >
> >> > diff --git a/Documentation/Makefile b/Documentation/Makefile
> >> > index 4736f02b6c9e..0e1d8657a5cc 100644
> >> > --- a/Documentation/Makefile
> >> > +++ b/Documentation/Makefile
> >> > @@ -126,4 +126,6 @@ dochelp:
> >> >  	@echo
> >> >  	@echo  '  make DOCS_CSS={a .css file} adds a DOCS_CSS override file for html/epub output.'
> >> >  	@echo
> >> > +	@echo  '  make PAPER={a4|letter} Specifies the paper size used for LaTeX/PDF output.'
> >> > +	@echo
> >> >  	@echo  '  Default location for the generated documents is Documentation/output'    
> >> 
> >> The Sphinx make mode 'sphinx-build -M help' provides all of this and
> >> more...  
> >
> > So? Relying on a help message from sphinx-build would just make
> > our makefile fragile.
> >
> > btw, it didn't work here:
> >
> > 	$ ./sphinx_latest/bin/sphinx-build --version
> > 	sphinx-build 8.2.3
> >
> > 	 $ ./sphinx_latest/bin/sphinx-build  -M help
> > 	Error: at least 3 arguments (builder, source dir, build dir) are required.  
> 
> 'sphinx-build -M help . .'

I'm still missing the point:

	$ ./sphinx_latest/bin/sphinx-build -M help . .
	Sphinx v8.2.3
	Please use `make target' where target is one of
	  html        to make standalone HTML files
	  dirhtml     to make HTML files named index.html in directories
	  singlehtml  to make a single large HTML file
	  pickle      to make pickle files
	  json        to make JSON files
	  htmlhelp    to make HTML files and an HTML help project
	  qthelp      to make HTML files and a qthelp project
	  devhelp     to make HTML files and a Devhelp project
	  epub        to make an epub
	  latex       to make LaTeX files, you can set PAPER=a4 or PAPER=letter
	  latexpdf    to make LaTeX and PDF files (default pdflatex)
	  latexpdfja  to make LaTeX files and run them through platex/dvipdfmx
	  text        to make text files
	  man         to make manual pages
	  texinfo     to make Texinfo files
	  info        to make Texinfo files and run them through makeinfo
	  gettext     to make PO message catalogs
	  changes     to make an overview of all changed/added/deprecated items
	  xml         to make Docutils-native XML files
	  pseudoxml   to make pseudoxml-XML files for display purposes
	  linkcheck   to check all external links for integrity
	  doctest     to run all doctests embedded in the documentation (if enabled)
	  coverage    to run coverage check of the documentation (if enabled)
	  clean       to remove everything in the build directory

Why is it related to this change?

	+	@echo  '  make PAPER={a4|letter} Specifies the paper size used for LaTeX/PDF output.'

Regards,
Mauro

