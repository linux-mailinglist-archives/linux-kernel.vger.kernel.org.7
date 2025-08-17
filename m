Return-Path: <linux-kernel+bounces-772490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B0EB29353
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 15:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C9441B22E4E
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 13:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC67228C02B;
	Sun, 17 Aug 2025 13:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TM3PQDll"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180C7317705;
	Sun, 17 Aug 2025 13:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755438349; cv=none; b=ZVq7Sk/8J+hrMyy0frR4wmBoFqZC7wjJReM5kdt8V49pd9PhuwE710uE7CS/nTOwZcxnow7zk2PyoO0ZeJ8uNSbY5EXHCqSEkVo4XNKjhVTf++6rraa7GXI1OT0cBeFP+3oFKfGemSYZLM4Sr/pt5J62cz00y3lYQfvwHGITwis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755438349; c=relaxed/simple;
	bh=Vu9n2SLp+Hd3vLQf+FJpjNxx1t+sz7+XIWQRxNm7sqA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VZfilbIf/TQSSlRKIeWs9fvBkO8O3I211sNcp5/WCLMWz1hKolbHSDuUc2JpqeufVgmet3X4UTS78uEnXr/ax96Jyd9eVIByicbQnPsdkd/0ZORxX4zyUknCJsfs7kjUj7E6wwPIaSOAXw/mWOihJh0xyyMoQhAGJ9rFmbO52gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TM3PQDll; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCE76C4CEEB;
	Sun, 17 Aug 2025 13:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755438349;
	bh=Vu9n2SLp+Hd3vLQf+FJpjNxx1t+sz7+XIWQRxNm7sqA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TM3PQDllCwGxnkDL0ZOc0kx6AMJDBExHsylvUGqBrg8dguuGWwV5qREJ3E92SyVwW
	 KGsOYxkwMY2esRLP/9bNHBPjcSit6mBi+aEzhKZOxbiLlwnuB1uZSMgsOuEudpOaPh
	 EUyg94qQa2wGntkZySelrS5rcF+cOpvOe+c0FU5mneiRu35qEODrk0HWEWDkrQjuga
	 PVAO0hiIpo1h9YYsdcT05XR5haTKo02K1q5o6e4U1xa+101JojyHI99q1OoRNs+iO7
	 kPCuKiJNexcoDjCb7gfuWVWblL1abJJSQuDqxtWOm+JgwZHA3urXs5BU6BV7AxkYhM
	 vMuQ8Q94gWO5A==
Date: Sun, 17 Aug 2025 15:45:44 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Akira Yokosawa <akiyks@gmail.com>
Cc: corbet@lwn.net, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/11] Fix PDF doc builds on major distros
Message-ID: <20250817154544.78d61029@foz.lan>
In-Reply-To: <b3d97e98-121d-4d12-9624-3efd119b12a4@gmail.com>
References: <cover.1755256868.git.mchehab+huawei@kernel.org>
	<773f4968-8ba5-4b1a-8a28-ff513736fa64@gmail.com>
	<20250816135538.733b80d3@foz.lan>
	<acc71988-4ed7-4df1-aa1f-a9d7a125ca53@gmail.com>
	<20250817133606.79d968ed@sal.lan>
	<b3d97e98-121d-4d12-9624-3efd119b12a4@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Sun, 17 Aug 2025 21:24:49 +0900
Akira Yokosawa <akiyks@gmail.com> escreveu:

> On Sun, 17 Aug 2025 13:36:06 +0200, Mauro Carvalho Chehab wrote:
> > Em Sun, 17 Aug 2025 18:46:35 +0900
> > Akira Yokosawa <akiyks@gmail.com> escreveu:
> >   
> >> [-CC: bpf@vger]
> >>  
> 
> [...]
> 
> >> I couldn't see what you are talking about at first, because there
> >> have not been any such issues reported.  
> > 
> > Heh, as you reported, you had troubles building pdf on Debian/Ubuntu. 
> > That's mainly why I took some time finding issues and writing this
> > series. Basically, just fixing ImageMagick permissions didn't fix
> > everything, as, at least with the Sphinx versions used at the tests
> > got troubles with Sphinx hyphernation, which required a Polish font.
> > 
> > Debian LaTeX packages seem to have issues with that. Fedora and
> > other rpm-based distros built it fine.
> > 
> > Now, reproducing such bugs could be tricky, specially with LaTeX,
> > which is a complex tool with lots of system-specific stuff.
> > 
> > Eventually, this could be related to LANG/LANGUAGE/LC_ALL/...
> > env vars. Here, I'm using lxc-attach to bind to the container.
> > It doesn't run .bashrc nor set locale vars, and it seems to keep
> > some env vars from the host. In the specific case of LANG,
> > it doesn't set anything. So, my test script sets LANG and LC_ALL
> > to "C". The host has it set to LANG=pt_BR.UTF-8.
> >   
> >> Also, after applying 1/11 ... 4/11 on top of current docs-next
> >> (commit 0bbc2548ea85 ("Merge branch 'pre-install' into docs-mw"),
> >> despite the changelog of 5/11 which claims to fix an issue under
> >> debian, I couldn't reproduce the "! Corrupted NFSS tables" error
> >> under Ubuntu 24.04 (noble).  
> > 
> > Maybe you could try set LANG/LC_ALL to "C".
> > 
> > I tested it on the following lxc containers (picked from lxc
> > download repositories):
> > 
> >   # APT-based (Debian/Ubuntu-like)
> >   debian:
> >     release: "bookworm"
> >     pre_setup_cmds: *apt_pkg_cmd
> >     post_setup_cmds:
> >       - "systemctl enable ssh"
> >     pkg_cmd: *apt_pkg_cmd
> > 
> >   devuan:
> >     release: "daedalus"
> >     pkg_cmd: *apt_pkg_cmd
> > 
> >   kali:
> >     release: "current"
> >     pkg_cmd: *apt_pkg_cmd
> > 
> >   mint:
> >     release: "wilma"
> >     pkg_cmd: *apt_pkg_cmd
> > 
> >   ubuntu:
> >     release: "plucky"
> >     pkg_cmd: *apt_pkg_cmd
> > 
> >   ubuntu-lts:
> >     dist: "ubuntu"
> >     release: "noble"
> >     pkg_cmd: *apt_pkg_cmd
> > 
> > apt_pkg_cmd: &apt_pkg_cmd
> >   - "sudo locale-gen"
> >   - "sudo dpkg-reconfigure --frontend=noninteractive locales"
> >   - "apt-get update && apt-get install -y openssh-server git python3 make"
> >   - |
> >     if [ -f /etc/ImageMagick-6/policy.xml ]; then
> >       # Remove any existing restrictive policies for PDF/PS/EPS/XPS
> >       sed -i '/<policy.*domain="coder".*pattern=".*\(PDF\|PS\|EPS\|XPS\).*"/d' /etc/ImageMagick-6/policy.xml
> >       # Allow PDF patterns at the end </policymap>
> >       sed -i '/<\/policymap>/i \ \ <policy domain="coder" rights="read|write" pattern="{PS,PS2,PS3,EPS,PDF,XPS}" />' /etc/ImageMagick-6/policy.xml
> >     fi
> >   - |
> >     if [ -f /etc/ImageMagick-7/policy.xml ]; then
> >       # Remove any existing restrictive policies for PDF/PS/EPS/XPS
> >       sed -i '/<policy.*domain="coder".*pattern=".*\(PDF\|PS\|EPS\|XPS\).*"/d' /etc/ImageMagick-7/policy.xml
> >       # Allow PDF patterns at the end </policymap>
> >       sed -i '/<\/policymap>/i \ \ <policy domain="coder" rights="read|write" pattern="{PS,PS2,PS3,EPS,PDF,XPS}" />' /etc/ImageMagick-7/policy.xml
> >     fi
> > 
> > Packages are installed according using sphinx-pre-install
> > instructions.
> > 
> > I don't remember what of those got the corrupted tables LaTeX warning,
> > but I got it on more than one Debian-based distro. When I wrote the
> > fix, I guess I logged at the Debian container.
> >   
> 
> That explains!  I've stopped using ImageMagick all together.
> 
> So it sounds to me like there is some issue in debian/ubuntu/...'s
> ImageMagick packaging, probably its build config disables some
> aspect of SVG --> PDF support for security concerns (???).
> I'm not sure at all.
> 
> I think it has nothing to do with XeLaTeX font discovery and I don't
> see any reason to apply 5/11, at least for the time being.
> 
> My suggestion would be to give up ImageMagick and install Inkscape
> instead.  It is provided as a deb package for debian and its derivatives.

The corrupted table error happened with very simple PDF files and has
nothing to do with image generation.

It rises even with very simple PDF targets like this:

	make SPHINXDIRS=peci pdfdocs

Which produces \sphinxhyphen{} inside peci.tex, like this one:

	controller is acting as a PECI originator and the processor \sphinxhyphen{} as

Basically, if this is included, directly or indirectly at the
.tex file:

	\usepackage[T1]{fontenc}

the fonts from T1 fontset aren't UTF-8 compatible, causing troubles
with xelatex. The fixes on this series solved some corner cases, where 
babel tries to include it and use a Polish font (pzdr.tfm) to
handle hyphenation.

Such issue likely depends on Sphinx versions (as it is related to a 
sphinx-specific macro) and what LaTeX packages are installed at 
the system (fonts, babel, polygrossia).

Regards,
Mauro

