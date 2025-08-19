Return-Path: <linux-kernel+bounces-775853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60592B2C5B2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 15:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD40D1964C48
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2D02EB85B;
	Tue, 19 Aug 2025 13:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mtg7yybS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1138933CEBD;
	Tue, 19 Aug 2025 13:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755610326; cv=none; b=tmaTiQWVYT/hTC0wu7a6wxcnnj63+b9ONpABoEWyyz/9hdK8u8j2y61ErNFBG0D6ay3BbLZbj7Jwn5PAuhvGRTETebY5BwiIsxq8oPmC9rNEN0FZEj0krwWYgYf9R27R4igVo+yZo8UwLpVd5ZEJqmHqqD4lcV++lS7SDawsWaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755610326; c=relaxed/simple;
	bh=LQblbnIfC5gYmuv3Hk+6GKtjD+Do2V4eQ9g1RykUrhI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A2H3krgWIGSMAuLMjke1g5C0W9rnelw58OVSXrZmEXi/VbnpEYOHgCbEav1fZMuV+ajtaK22rLbHpBAFftEkSmucnG6PvAHA4kC9XoJVSU86BMJp4EziYY8XuDnSF83pO4Bom01+6UwiKskFYQcNfVy9zz6N6v6Q+zGbY553Pac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mtg7yybS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CB01C4CEF1;
	Tue, 19 Aug 2025 13:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755610324;
	bh=LQblbnIfC5gYmuv3Hk+6GKtjD+Do2V4eQ9g1RykUrhI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Mtg7yybSrKR878pk/EoxxEqSr7NVBrCLXRMLe7rjk1fEmeqnZ6DFvjEUH94JUGYYl
	 S6RqrxbE5EksMBzyKlHqSVRPVw0XCG/DtWSCgZkeGWn75LXMLeV4H6dh2Enqs1fVQE
	 2Rofm7snRIimanavXh7CR8Z3xY1nEx4GYQ2QU+Vw96B7eVnNrFnxtZndYZ/Mx/xWUc
	 DXHzqvTLMXuWLf3ISXY+GSNj2KfD/twGCiYKO/6dDeBl581BFzICjRaCJY3KJ7Vz7y
	 bgeWbjvsPpIF/EPT2ZmIi1of8Wkz5pSEOuO5Xb9cXTZywdyRsomElMBFng9tiFbzsD
	 zUxREAMiigmQA==
Date: Tue, 19 Aug 2025 15:32:00 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Akira Yokosawa <akiyks@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/11] Fix PDF doc builds on major distros
Message-ID: <20250819153200.3c2b2ff6@foz.lan>
In-Reply-To: <142b209d-613a-4659-a0f7-27efa8c6be85@gmail.com>
References: <cover.1755256868.git.mchehab+huawei@kernel.org>
	<773f4968-8ba5-4b1a-8a28-ff513736fa64@gmail.com>
	<20250816135538.733b80d3@foz.lan>
	<acc71988-4ed7-4df1-aa1f-a9d7a125ca53@gmail.com>
	<20250817133606.79d968ed@sal.lan>
	<b3d97e98-121d-4d12-9624-3efd119b12a4@gmail.com>
	<20250817154544.78d61029@foz.lan>
	<b6d18aa7-de85-4fd2-8456-c2f6342f1b06@gmail.com>
	<87y0rg7e35.fsf@trenco.lwn.net>
	<16b48826-6634-4ec9-86a0-7ddb59ce3bed@gmail.com>
	<20250819030239.41a2e97f@foz.lan>
	<142b209d-613a-4659-a0f7-27efa8c6be85@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Tue, 19 Aug 2025 11:16:29 +0900
Akira Yokosawa <akiyks@gmail.com> escreveu:

> Hi Mauro,
> 
> Please calm down.
> Apologizes if my wording has annoyed you.
> 
> On Tue, 19 Aug 2025 03:02:39 +0200, Mauro Carvalho Chehab wrote:
> > Em Tue, 19 Aug 2025 08:26:31 +0900
> > Akira Yokosawa <akiyks@gmail.com> escreveu:  
> 
> [...]
> 
> >> Mauro, I can't review on 5/11 unless you provide me exact steps to reproduce
> >> the font discovery issue you said you have observed under debian at 4/11 of
> >> this series.  That is, without assuming your other series of build-wrapper.  
> > 
> > See below.
> >   
> >> The build-wrapper should be upper compatible with the current way of
> >> running sub-make, without any change in conf.py.  
> > 
> > The build-wrapper series doesn't make any changes on conf.py:  
> 
> Of course not, I'm well aware of the fact from the cover letter.
> 
> [...]
> 
> > 4. It prevents the usage of T1 fontenc fonts, which could be
> >    caused by either one of those two reasons:
> > 
> > 	a) \sphinxhyphen{}
> > 	b) index build
> > 
> > I got those when checking what packages were required on some
> > distros (Debian, Ubuntu, Mageia, openMandriva, Gentoo).  
> 
> I couldn't reproduce it at PATCH 4/11 under a Ubnutu-based container
> I've been using, ignoring your sphinx-build-warpper series.

I'm assuming you're referring to patch 5/11, e.g.:

	ceaa95123364 ("docs: conf.py: fix some troubles for LaTeX output")

> I'd really like to see the issue with my eyes on top current way of
> doc building!
> 
> That's all I am asking.
> 
> I have no particular interest in the way you are testing all those
> variety of distros, and have no idea about it.
> 
> Please provide steps to reproduce.
> I'd like to see a Dockerfile based "FROM ubuntu:latest" as the testing
> environment.

Heh, that's why you can't reproduce... you're using a Docker container
and a different Ubuntu version than I.

What I did here was to use a lxc container with 25.04, and used
a script to pick the exact recommendations given by sphinx-pre-install.

The container was created with:

<script>
sudo lxc-create -n ubuntu-test -t download -- --dist ubuntu --release plucky --arch amd64
sudo mkdir -p /var/lib/lxc/ubuntu-test
sudo sh -c cat > /var/lib/lxc/ubuntu-test/config <<EOF
lxc.arch = x86_64
lxc.pty.max = 1024
lxc.tty.max = 4
lxc.net.0.type = veth
lxc.net.0.link = lxcbr0
lxc.net.0.flags = up
lxc.net.0.hwaddr = 00:16:3e:6f:66:8c
lxc.cap.drop = mac_admin mac_override sys_time sys_module sys_rawio
lxc.cgroup.devices.allow = a
lxc.cgroup2.devices.allow = a
lxc.mount.auto = proc sys cgroup
lxc.rootfs.path = /var/lib/lxc/ubuntu-test/rootfs
EOF
</script>

once you get what's needed for make htmldocs work, installing
only the dependencies recommended by sphinx-pre-install, you can
start trying to reproduce the build issues for pdf.

For the steps below, I installed Sphinx latest using venv:

	$ make SPHINXDIRS=peci pdfdocs
	...
	This is XeTeX, Version 3.141592653-2.6-0.999996 (TeX Live 2025/dev/Debian) (preloaded format=xelatex)
	entering extended mode
	Latexmk: Getting log file 'peci.log'
	Latexmk: Examining 'peci.fls'
	Latexmk: Examining 'peci.log'
	Latexmk: Missing input file 'tgtermes.sty' (or dependence on it) from following:
	  ! LaTeX Error: File `tgtermes.sty' not found.
	Latexmk: Log file says no output from latex
	Latexmk: For rule 'xelatex', no output was made
	Latexmk: Errors, so I did not complete making targets
	Collected error summary (may duplicate other messages):
	  xelatex: Command for 'xelatex' gave return code 1
	      Refer to 'peci.log' and/or above output for details

	Latexmk: Sometimes, the -f option can be used to get latexmk
	  to try to force complete processing.
	  But normally, you will need to correct the file(s) that caused the
	  error, and then rerun latexmk.
	  In some cases, it is best to clean out generated files before rerunning
	  latexmk after you've corrected the files.
	make[3]: *** [Makefile:29: peci.pdf] Error 12
	make[2]: *** [Documentation/Makefile:148: pdfdocs] Error 1
	make[1]: *** [/root/Makefile:1806: pdfdocs] Error 2
	make: *** [Makefile:248: __sub-make] Error 2

Fix the broken font dependencies require installing other packages:

	# apt install tex-gyre texlive-fonts-recommended texlive-lang-chinese
	texlive-lang-chinese is already the newest version (2024.20250309-1).
	Installing:
	  tex-gyre  texlive-fonts-recommended
	
	Installing dependencies:
	  fonts-texgyre  fonts-texgyre-math

As described at sphinx-pre-install patch:

  commit a888d353ac1eb0d558fda5482c6955d6c4a29f23
  Author: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
  Date:   Mon Jul 28 15:54:09 2025 +0200

    scripts: sphinx-pre-install: fix PDF build issues on Ubuntu
    
    PDF output with current Debian-based distros require other
    packages for it to work. The main one is pzdr.tfm. Without
    that, \sphinxhyphen{} won't work, affecting multiple docs.
    
    For CJK, tex-gyre is required.
    
    Add the missing packages to the list.

Now, here's the thing: to get the above dependencies, I played with 
installing/uninstalling multiple packages, until I discovered where
each font dependency was, and where CJK fonts were placed.

Still, the above is not enough:

	$ make cleandocs; LANG=C LC_ALL=C make SPHINXDIRS=peci pdfdocs
	...
	entering extended mode
	Latexmk: Getting log file 'peci.log'
	Latexmk: Examining 'peci.fls'
	Latexmk: Examining 'peci.log'
	Latexmk: Index file 'peci.idx' was written
	Latexmk: References changed.
	Latexmk: Missing input file 'peci.toc' (or dependence on it) from following:
	  No file peci.toc.
	Latexmk: Missing input file 'peci.ind' (or dependence on it) from following:
	  No file peci.ind.
	Latexmk: References changed.
	Latexmk: References changed.
	Latexmk: Log file says output to 'peci.xdv'
	Have index file 'peci.idx', peci.ind peci
	Latexmk: Errors, so I did not complete making targets
	Collected error summary (may duplicate other messages):
	  xelatex: Command for 'xelatex' gave return code 1
      Refer to 'peci.log' and/or above output for details
	
	Latexmk: Sometimes, the -f option can be used to get latexmk
	  to try to force complete processing.
	  But normally, you will need to correct the file(s) that caused the
	  error, and then rerun latexmk.
	  In some cases, it is best to clean out generated files before rerunning
	  latexmk after you've corrected the files.
	make[3]: *** [Makefile:29: peci.pdf] Error 12
	make[2]: *** [Documentation/Makefile:148: pdfdocs] Error 1
	make[1]: *** [/root/Makefile:1806: pdfdocs] Error 2
	make: *** [Makefile:248: __sub-make] Error 2

	$ ls Documentation/output/peci/latex/|grep pdf
	<none>

PS.: such error is intermitent: re-creating containers sometimes
fix the issues; sometimes not. It sounds to be that this is due
to some race condition somewhere.

Also, if you look at the *.tex output, you'll see it is messing with
fonts:

	# grep usepackage Documentation/output/peci/latex/peci.tex 
	\usepackage{cmap}
	\usepackage[T1]{fontenc}
	\usepackage{amsmath,amssymb,amstext}
	\usepackage{babel}
	\usepackage{tgtermes}
	\usepackage{tgheros}
	\usepackage[Bjarne]{fncychap}
	\usepackage[,maxlistdepth=10]{sphinx}
	\usepackage{geometry}
	\usepackage{setspace}
	\usepackage{hyperref}
	\usepackage{hypcap}% it must be loaded after hyperref.
	\usepackage{sphinxmessages}
	        \usepackage{fontspec}

e.g.:

- The tex file is trying to use T1 fontenc and fontspec;

- The fontspec usage came from conf.py preamble, which is not indented
  well:

	# grep -A7 fontspec Documentation/output/peci/latex/peci.tex
	        \usepackage{fontspec}
	        \setsansfont{DejaVu Sans}
	        \setromanfont{DejaVu Serif}
	        \setmonofont{DejaVu Sans Mono}
    
	        % Load kerneldoc specific LaTeX settings
	        \input{kerneldoc-preamble.sty}

On several of my attempts, I got those errors:

	Package: fontenc 2021/04/29 v2.0v Standard LaTeX package
	LaTeX Font Info:    Trying to load font information for T1+lmr on input line 11
	6.
	LaTeX Font Info:    No file T1lmr.fd. on input line 116.

	LaTeX Font Warning: Font shape `T1/lmr/m/n' undefined
	(Font)              using `T1/lmr/m/n' instead on input line 116.

	! Corrupted NFSS tables.
	wrong@fontshape ...message {Corrupted NFSS tables}
                                                  error@fontshape else let f...
	l.116 ...\familydefault\seriesdefault\shapedefault

If you search for it, you would get references like:
	https://tex.stackexchange.com/questions/740050/corrupted-nfss-tables

explaining that using T1 together with fontenc is a very bad idea,
recommending to use instead:

	\usepackage{fontspec}
	\newfontfamily<sometthing>

and not use T1 fontenc.

Unfortunately, I was not able to reproduce this exact error anymore,
at least on Ubuntu. Perhaps I got this one on Gentoo or on some other
distro, but I can't remember anymore how to reproduce this specific
error message.

-

Yet, using my today's container, this specific scenario can be fixed by moving
the font config data from preamble to "fontenc":

<patch>
+from textwrap import dedent
+
 # If extensions (or modules to document with autodoc) are in another directory,
 # add these directories to sys.path here. If the directory is relative to the
 # documentation root, use os.path.abspath to make it absolute, like shown here.
@@ -441,20 +443,18 @@ latex_elements = {
     # For CJK One-half spacing, need to be in front of hyperref
     "extrapackages": r"\usepackage{setspace}",
     # Additional stuff for the LaTeX preamble.
-    "preamble": """
+    "fontenc": dedent("""
         % Use some font with UTF-8 support with XeLaTeX
         \\usepackage{fontspec}
         \\setsansfont{DejaVu Sans}
         \\setromanfont{DejaVu Serif}
         \\setmonofont{DejaVu Sans Mono}
-    """,
-}
-
-# Load kerneldoc specific LaTeX settings
-latex_elements["preamble"] += """
+    """),
+    "preamble": dedent("""
         % Load kerneldoc specific LaTeX settings
         \\input{kerneldoc-preamble.sty}
-"""
+    """)
+}
</patch> 

which is one of the main changes I made. At the actual change, I opted to
use raw strings, to avoid "\\" e.g.:

	"fontenc": dedent(r"""
             % Use some font with UTF-8 support with XeLaTeX
             \usepackage{fontspec}
             \setsansfont{DejaVu Sans}
             \setromanfont{DejaVu Serif}
             \setmonofont{DejaVu Sans Mono}
	"""),

With that, we have now:

	# grep usepackage Documentation/output/peci/latex/*.tex
	\usepackage{cmap}
	\usepackage{fontspec}
	\usepackage{amsmath,amssymb,amstext}
	\usepackage{babel}
	\usepackage{tgtermes}
	\usepackage{tgheros}
	\usepackage[Bjarne]{fncychap}
	\usepackage[,maxlistdepth=10]{sphinx}
	\usepackage{geometry}
	\usepackage{setspace}
	\usepackage{hyperref}
	\usepackage{hypcap}% it must be loaded after hyperref.
	\usepackage{sphinxmessages}

However, on other tests, including other distros, I found that this
is not enough, because:

1) the *.ind creation may use xindy on some distros and xindy could try
   to use T1 fontenc. So, I had to add this line:

	\PassOptionsToPackage{xindy}{language=english,codepage=utf8,noautomatic}

  to ensure that, if xindy is used, it will get codepage=utf8. 

2) there were some other corner cases that required to add 

	\newfontfamily\headingfont{DejaVu Serif}

Again related to T1 fontenc.

Thanks,
Mauro

