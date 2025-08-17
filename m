Return-Path: <linux-kernel+bounces-772454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E28B292D7
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 13:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 593901B235B7
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 11:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3D4236A73;
	Sun, 17 Aug 2025 11:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kT9mi3wL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2B7139D0A;
	Sun, 17 Aug 2025 11:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755430572; cv=none; b=GF3ggj0pXfXjEGOYJXHCYswqwU587bedMmZFTxeZJeUj6fjtHBse5wkQ36K3XQpmIB/8c5Zu5UYdD0EVk3MAkrehgAv6Rd/lixOum4euzNSvQZDi+e5GpSuBlXPDG5X/sHax0U8ziOuT5kJdy/5bQkKx861gVH9MwI2OApYhybU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755430572; c=relaxed/simple;
	bh=GmRpuf1WWiswTGLBZ8QswzjuANRbxc5t6gbEU4uCTdM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EdHNcuJFG6N+l4757KXrHZb5fQuPMYTOUPyfujUTjy+pxRhymJgD39/i3YvIwGv5jFpVBHuSZa4GBaMeDo8ILzz88YAOFRZzCJ06w7KytAemymKo6nTz92D51K4xHnhh5FbgDkKuZ+ZZBCmoAZcJjfa6V9AjSiYeZx9PIyWCDiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kT9mi3wL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A05FFC4CEEB;
	Sun, 17 Aug 2025 11:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755430571;
	bh=GmRpuf1WWiswTGLBZ8QswzjuANRbxc5t6gbEU4uCTdM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kT9mi3wLePKByM7ioIfXteIDxbA9/yX1Sq00Pv4MOjf2Nhkw1lwNcywzaH+el8P4G
	 iM3CcfSZrDt7xwozyuwnrU/zX1IpE+ZHB5TX4DKj0wkU/dUf7dRUD/+BwpHu+dJJIb
	 WW9sK9Xn4z3R4lVkJ/GIqk08uQqH/jev5SyPqQhg2u40xFd/2erZDlcpQjOGAEDk2G
	 Sd7SmiiUT4mhduEoa6cQmzN/s8zly1PyLvMF5Zs9+4Ua9BuBb14XcyeDeVmS2EpQuh
	 V2Q6vo/lgqa8+PgvKIbfOBnup6RITjUEiEJLuCDYV7E2J4Ps3uRYMf35IDFRVbabmh
	 Hv2n1U2K7atbg==
Date: Sun, 17 Aug 2025 13:36:06 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Akira Yokosawa <akiyks@gmail.com>
Cc: corbet@lwn.net, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/11] Fix PDF doc builds on major distros
Message-ID: <20250817133606.79d968ed@sal.lan>
In-Reply-To: <acc71988-4ed7-4df1-aa1f-a9d7a125ca53@gmail.com>
References: <cover.1755256868.git.mchehab+huawei@kernel.org>
	<773f4968-8ba5-4b1a-8a28-ff513736fa64@gmail.com>
	<20250816135538.733b80d3@foz.lan>
	<acc71988-4ed7-4df1-aa1f-a9d7a125ca53@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Sun, 17 Aug 2025 18:46:35 +0900
Akira Yokosawa <akiyks@gmail.com> escreveu:

> [-CC: bpf@vger]
> 
> On Sat, 16 Aug 2025 13:55:38 +0200, Mauro Carvalho Chehab wrote:
> > Em Sat, 16 Aug 2025 14:06:43 +0900
> > Akira Yokosawa <akiyks@gmail.com> escreveu:
> >   
> 
> [...]
> 
> > Works for me, but let's do it on a separate series. I still have more
> > than 100 patches on my pile to be merged. This series is focused on
> > making at least some PDFs to build where possible, addressing major
> > problems at conf.py that are causing LaTeX to not work on several
> > distros and to fix wrong package dependencies(*).
> > 
> > I'll add a TODO item on my queue to replace fom ImageMagick to
> > Inkscape on a separate series.
> > 
> > (*) One of such problem you blamed sphinx-build-wrapper, but 
> >     the issue is actually addressed on this series with fixes to conf.py: 
> >     there are currently several troubles at latex_documents list and at
> >     latex_elements.
> > 
> >     Those are causing wrong font detection on LaTeX.  
> 
> I couldn't see what you are talking about at first, because there
> have not been any such issues reported.

Heh, as you reported, you had troubles building pdf on Debian/Ubuntu. 
That's mainly why I took some time finding issues and writing this
series. Basically, just fixing ImageMagick permissions didn't fix
everything, as, at least with the Sphinx versions used at the tests
got troubles with Sphinx hyphernation, which required a Polish font.

Debian LaTeX packages seem to have issues with that. Fedora and
other rpm-based distros built it fine.

Now, reproducing such bugs could be tricky, specially with LaTeX,
which is a complex tool with lots of system-specific stuff.

Eventually, this could be related to LANG/LANGUAGE/LC_ALL/...
env vars. Here, I'm using lxc-attach to bind to the container.
It doesn't run .bashrc nor set locale vars, and it seems to keep
some env vars from the host. In the specific case of LANG,
it doesn't set anything. So, my test script sets LANG and LC_ALL
to "C". The host has it set to LANG=pt_BR.UTF-8.

> Also, after applying 1/11 ... 4/11 on top of current docs-next
> (commit 0bbc2548ea85 ("Merge branch 'pre-install' into docs-mw"),
> despite the changelog of 5/11 which claims to fix an issue under
> debian, I couldn't reproduce the "! Corrupted NFSS tables" error
> under Ubuntu 24.04 (noble).

Maybe you could try set LANG/LC_ALL to "C".

I tested it on the following lxc containers (picked from lxc
download repositories):

  # APT-based (Debian/Ubuntu-like)
  debian:
    release: "bookworm"
    pre_setup_cmds: *apt_pkg_cmd
    post_setup_cmds:
      - "systemctl enable ssh"
    pkg_cmd: *apt_pkg_cmd

  devuan:
    release: "daedalus"
    pkg_cmd: *apt_pkg_cmd

  kali:
    release: "current"
    pkg_cmd: *apt_pkg_cmd

  mint:
    release: "wilma"
    pkg_cmd: *apt_pkg_cmd

  ubuntu:
    release: "plucky"
    pkg_cmd: *apt_pkg_cmd

  ubuntu-lts:
    dist: "ubuntu"
    release: "noble"
    pkg_cmd: *apt_pkg_cmd

apt_pkg_cmd: &apt_pkg_cmd
  - "sudo locale-gen"
  - "sudo dpkg-reconfigure --frontend=noninteractive locales"
  - "apt-get update && apt-get install -y openssh-server git python3 make"
  - |
    if [ -f /etc/ImageMagick-6/policy.xml ]; then
      # Remove any existing restrictive policies for PDF/PS/EPS/XPS
      sed -i '/<policy.*domain="coder".*pattern=".*\(PDF\|PS\|EPS\|XPS\).*"/d' /etc/ImageMagick-6/policy.xml
      # Allow PDF patterns at the end </policymap>
      sed -i '/<\/policymap>/i \ \ <policy domain="coder" rights="read|write" pattern="{PS,PS2,PS3,EPS,PDF,XPS}" />' /etc/ImageMagick-6/policy.xml
    fi
  - |
    if [ -f /etc/ImageMagick-7/policy.xml ]; then
      # Remove any existing restrictive policies for PDF/PS/EPS/XPS
      sed -i '/<policy.*domain="coder".*pattern=".*\(PDF\|PS\|EPS\|XPS\).*"/d' /etc/ImageMagick-7/policy.xml
      # Allow PDF patterns at the end </policymap>
      sed -i '/<\/policymap>/i \ \ <policy domain="coder" rights="read|write" pattern="{PS,PS2,PS3,EPS,PDF,XPS}" />' /etc/ImageMagick-7/policy.xml
    fi

Packages are installed according using sphinx-pre-install
instructions.

I don't remember what of those got the corrupted tables LaTeX warning,
but I got it on more than one Debian-based distro. When I wrote the
fix, I guess I logged at the Debian container.

> I'm confused ...  How can I reproduce this?
> 
> It's getting really hard for me to keep up with your pace of changes
> in doc build scripts, really.
> 
> Akira

