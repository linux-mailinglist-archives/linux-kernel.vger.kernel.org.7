Return-Path: <linux-kernel+bounces-778214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA29B2E2A4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 18:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 756BBA01791
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 16:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A98334382;
	Wed, 20 Aug 2025 16:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mBCpSHLh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC9113B58D;
	Wed, 20 Aug 2025 16:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755708493; cv=none; b=I0CTAt5RK05VHsDh0tKyXxuun7EQ/b6rnYZ6/+24U+bmDqCaFqCPTyi4JZJkhSk1nM35br4CYRzuuwJy2mF4yIHEhA/yudcWLrCHs49yh4LU6jwYOF/KiHgOkjrUzsdicAedzG2+dnPzal0iRB4zv7FKJA2YrgBoJQUJS5DREUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755708493; c=relaxed/simple;
	bh=1oWER/hG7V3nM0s85ICVzIy3Cx4bCWXWzRg6rGeVCU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ry3Z+hG2PC+bRyDn4se8oz7Gfsf0tT2PXa4VJJCqPM3yPIQC+G9kmkl8sCInf4Rx1en58IhFtN+xqzeO0Kqp+31U4PTKg41maiWUFBMoWAE3bDalotsY67U9h9jXmHLL+i/mBEKvidvvkJF/XYjVtapkE0TBlfWci+fGbldL8cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mBCpSHLh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC5BCC4CEE7;
	Wed, 20 Aug 2025 16:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755708492;
	bh=1oWER/hG7V3nM0s85ICVzIy3Cx4bCWXWzRg6rGeVCU0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mBCpSHLhSMPGELJv+pKHMSF8EB9XxAZDQWX1n8oCq7w8Z6KohCOgS5MMxss03rGJw
	 lRA+QUJI0TEXceA3mmdyl9Qp7VCy4tz6OkDCcQs0U8PY63v72B2k8qecZw41kI6YAq
	 iXEd6ncE6RCoHI0MrpisPmMfhIRnNdAHe5euMyAXNhBfmZ6M4Nyh4gtW4fjDHat6SI
	 CM7mXLLTvarFKJkoe5YUmB82o6crqhVdKmsPOReKPRMJEpcE/tg8ucVdcvx01zbI5g
	 ypsbxRLwrrLnKj9KiCvJuTNKFKEFMyOUE2ikxuisjtWy5goHVHmRp+gA1pS+hmM/9U
	 dNwHDrp5XG9bg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uolys-0000000AlCj-2Kyo;
	Wed, 20 Aug 2025 18:48:10 +0200
Date: Wed, 20 Aug 2025 18:48:10 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Akira Yokosawa <akiyks@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/11] Fix PDF doc builds on major distros
Message-ID: <xik6a2kb3mge5xh2mbdtc4p3ikbr4mnjlkk4ujc4sfztb3iqnr@tc76jva4smpm>
References: <20250817154544.78d61029@foz.lan>
 <b6d18aa7-de85-4fd2-8456-c2f6342f1b06@gmail.com>
 <87y0rg7e35.fsf@trenco.lwn.net>
 <16b48826-6634-4ec9-86a0-7ddb59ce3bed@gmail.com>
 <20250819030239.41a2e97f@foz.lan>
 <142b209d-613a-4659-a0f7-27efa8c6be85@gmail.com>
 <20250819153200.3c2b2ff6@foz.lan>
 <08c3a7eb-0425-4709-a3ea-6d1d726fd3c8@gmail.com>
 <20250820091530.068c4b62@foz.lan>
 <3990f1c5-2108-44fe-913f-97ae3bb1ff42@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3990f1c5-2108-44fe-913f-97ae3bb1ff42@gmail.com>
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

On Wed, Aug 20, 2025 at 08:41:05PM +0900, Akira Yokosawa wrote:
> Hi,
> 
> On Wed, 20 Aug 2025 09:15:30 +0200, Mauro Carvalho Chehab wrote:
> > Em Wed, 20 Aug 2025 08:54:52 +0900
> > Akira Yokosawa <akiyks@gmail.com> escreveu:
> > 
> >> On Tue, 19 Aug 2025 15:32:00 +0200, Mauro Carvalho Chehab wrote:
> 
> [...]
> 
> >> I've just built a container "FROM ubuntu:plucky", which has inkscape
> >> instead of imagemagick + rsvg-convert.
> > 
> > I don't think that inkscape x imagemagick/rsvg-convert itself has
> > anyhting to do with the problems I detected, as they're related to
> > font issues (still, I got an issue on one of my builds on kfigure
> > write file: encoding is missing at open, which may cause errors).
> 
> OK, so you have spent a lot of time to paper over the ImageMagick issue
> used as an SVG --> PDF converter.

Why are you insisting with this? Again: 

This series doesn't try to address anything that would be caused
by either imagemagick/rsvg-convert - or inkscape.

It only address:
- wrong dependencies from the existing ones - whatever they are;
- non-UTF-8 fonts inside the produced *.tex files and a couple of other
  issues at conf.py - none of them related to images.

> 
> I have simply given up using ImageMagick and been using inkscape instead.
> 
> I can reliably reproduce the warnings and build errors (see below) without
> inkscape installed, instead with imagemagick + rsvg-convert installed,
> under a ubuntu:plucky based container.
> 
> When I run: "make cleandocs; make SPHINXDIRS=gpu latexdocs",
>     
>      [**NOTE**] SPHINXDIRS=peci is not affected by this issue!
> 
> kfigure.py emits warnings like this:

I did got kfigure.py issues that can affect both inkscape and
imagemagic, but those are **NOT** in this series:

- the first issue is that python tries to write PDF output as
  strings, but Python 3.x can crash because strings have
  encodings. The default ascii encoding crashes with chars > 127
  (and probably when there is a "\0" at the code);

- the second issue is that two files use ForeignObject, which
  is not properly supported by inkscape or ImageMagick.
  Still both seems to be working fine (I only tried to do
  conversions by hand today).

I believe that we need to add kfigure.py on our TODO list
to make it more python 3.x friendly.

Again: this is out of the scope of this series.
               ================

> -----------------------------------------------------------------------------------
> WARNING: Error #1 when calling: /usr/bin/convert /linux/Documentation/gpu/amdgpu/pipe_and_queue_abstraction.svg /linux/Documentation/output/gpu/latex/pipe_and_queue_abstraction.pdf
> WARNING: Warning msg from convert(1): convert: unrecognized color `context-stroke' @ warning/color.c/GetColorCompliance/1064.
> convert: non-conforming drawing primitive definition `fill' @ error/draw.c/RenderMVGContent/4548.
> -----------------------------------------------------------------------------------
> 
> Nevertheless, "make SPHINXDIRS=gpu pdfdocs" continues building gpu.pdf,
> but ends up in this error in the middle of xelatex run.
> 
> -----------------------------------------------------------------------------------
> ------------
> Run number 1 of rule 'xelatex'
> ------------
> ------------
> Running 'xelatex --no-pdf -interaction=batchmode -no-shell-escape -no-pdf -recorder  "gpu.tex"'
> ------------
> This is XeTeX, Version 3.141592653-2.6-0.999996 (TeX Live 2025/dev/Debian) (preloaded format=xelatex)
> entering extended mode
> Latexmk: Getting log file 'gpu.log'
> Latexmk: Examining 'gpu.fls'
> Latexmk: Examining 'gpu.log'
> Latexmk: Index file 'gpu.idx' was written
> Latexmk: References changed.
> Latexmk: Missing input file 'gpu.toc' (or dependence on it) from following:
>   No file gpu.toc.
> Latexmk: Missing input file 'gpu.ind' (or dependence on it) from following:
>   No file gpu.ind.
> Latexmk: References changed.
> Latexmk: References changed.
> Latexmk: Log file says output to 'gpu.xdv'
> Have index file 'gpu.idx', gpu.ind gpu
> Latexmk: Errors, so I did not complete making targets
> Collected error summary (may duplicate other messages):
>   xelatex: Command for 'xelatex' gave return code 1
>       Refer to 'gpu.log' and/or above output for details
> 
> Latexmk: Sometimes, the -f option can be used to get latexmk
>   to try to force complete processing.
>   But normally, you will need to correct the file(s) that caused the
>   error, and then rerun latexmk.
>   In some cases, it is best to clean out generated files before rerunning
>   latexmk after you've corrected the files.
> make[3]: *** [Makefile:29: gpu.pdf] Error 12
> make[2]: *** [Documentation/Makefile:148: pdfdocs] Error 1
> make[1]: *** [/linux/Makefile:1806: pdfdocs] Error 2
> make: *** [Makefile:248: __sub-make] Error 2
> -----------------------------------------------------------------------------------
> 
> I think this is (mostly) the same as the issue you have been trying hard
> to track down.

No. Up to today(*), I was simply ignoring any warnings/errors related to
kfigure.py. 

(*) earlier today I submitted exactly one patch related to it:

	https://lore.kernel.org/linux-doc/df1602df0da3a6254d58a782654e7f2e60512dc8.1755680997.git.mchehab+huawei@kernel.org/

Even such patch is unrelated to Inkscape x ImageMagick. It is meant
to fix troubles during SVG/dot read and during PDF output writes.

- 

As I've been replying over and over and over:

The issue was with [T1]{fontenc} added at the *.tex files
and/or the usage of other non-UTF-8 fonts.

That happens on very simple files. There are also font issues on some
distros affecting CJK related fonts due to missing packages and such.

What I pointed is:

I Don't know how you can setup an environment identical to
mine to reproduce the font issues I got.

-

If you want a more comprehensive answer:

LaTeX is highly dependent lots of packages, including fonts. The
reason why you can't reproduce the font issues with Docker
(I wasn't able to reproduce with Docker here as well) is
probably due to either packaging differences between the
two containers, due to different environment technologies
or even due to the way Docker and LXC handles OS virtualization.

Docker, for instance, doesn't have systemd running on it,
which could affect install logic at packages that could be
trying do something via systemd. I guess it also doesn't
implement cgroups. It also requires to download locales
package to setup locales (such package is already on lxc,
although not configured).

As the issue is related to fonts, different defaults with
regards to the fonts already installed at the containers
could be the root cause.

Also, installing any package (you name it) that might have
a direct or indirect dependency to a font can affect the
bug reproduction.

Installing inkscape, for instance, would directly require:


<snip>
# apt-cache depends inkscape
inkscape
  Depends: librsvg2-common
  Depends: <python3:any>
    python3
  Depends: lib2geom1.2.0t64
  Depends: libatkmm-1.6-1v5
  Depends: libboost-filesystem1.83.0
  Depends: libc6
  Depends: libcairo-gobject2
  Depends: libcairo2
  Depends: libcairomm-1.0-1v5
  Depends: libcdr-0.1-1
  Depends: libfontconfig1
  Depends: libfreetype6
  Depends: libgc1
  Depends: libgcc-s1
  Depends: libgdk-pixbuf-2.0-0
  Depends: libglib2.0-0t64
  Depends: libglibmm-2.4-1t64
  Depends: libgomp1
  Depends: libgsl28
  Depends: libgspell-1-3
  Depends: libgtk-3-0t64
  Depends: libgtkmm-3.0-1t64
  Depends: libharfbuzz0b
  Depends: libjpeg8
  Depends: liblcms2-2
  Depends: libpango-1.0-0
  Depends: libpangocairo-1.0-0
  Depends: libpangoft2-1.0-0
  Depends: libpangomm-1.4-1v5
  Depends: libpng16-16t64
  Depends: libpoppler-glib8t64
  Depends: libpoppler147
  Depends: libpotrace0
  Depends: libreadline8t64
  Depends: librevenge-0.0-0
  Depends: libsigc++-2.0-0v5
  Depends: libsoup-2.4-1
  Depends: libstdc++6
  Depends: libvisio-0.1-1
  Depends: libwpg-0.3-3
  Depends: libx11-6
  Depends: libxml2
  Depends: libxslt1.1
  Depends: zlib1g
  Recommends: aspell
  Recommends: fig2dev
  Recommends: imagemagick
    graphicsmagick-imagemagick-compat
    imagemagick-7.q16
  Recommends: libimage-magick-perl
  Recommends: libwmf-bin
  Recommends: python3-cssselect
  Recommends: python3-lxml
  Recommends: python3-numpy
  Recommends: python3-scour
  Suggests: dia
  Suggests: inkscape-tutorials
  Suggests: libsvg-perl
  Suggests: pstoedit
  Suggests: python3-packaging
  Suggests: <python3-uniconvertor>
  Suggests: ruby
</snip>

No fonts listed there at the direct dependencies, so in principle,
installing or not Inkscape or imagemagik won't make any difference
at the installed fonts, or on installed texlive packages. 

Thanks,
Mauro

