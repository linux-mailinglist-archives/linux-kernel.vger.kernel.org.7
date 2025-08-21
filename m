Return-Path: <linux-kernel+bounces-779395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B85AB2F37C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 11:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F36331CE00D6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 09:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149342EE617;
	Thu, 21 Aug 2025 09:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iY5lnBm1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C202D47F9;
	Thu, 21 Aug 2025 09:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755767531; cv=none; b=EfpsJgGhu5UcIt57/DpkoT6WCA/7ngVPH9V1nmv0f8jEEo+VS1l0OEUy0CikmGaz8bwbvgtmAH+4LQXxxVyarFa3ujqKZOae5UcIQHOH+u27T/wOlEmQ7mKxI4CTUDQnI+aisZX3DUV9TOQuNUgvfcnB72jHJmxGlqOyVp+K4Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755767531; c=relaxed/simple;
	bh=4ftSy9AZquCD3YWX8ybfUXm27XjKd0BU4eleDXm0U4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sw/mt571HJRyX/zQRXAQotyMGrPceMlyRKiJ/yRGxGmFYbZ4dAlAYNIzSj5q7KMtjSQnfz5HuymaO+NW8UGgpSSIg0odfqJX0xNLYSIIMvd2qbLAOAxGeMgo80HNPGtN6IJv3Xyl/gUtVTEIwH32g/CbrVShFe+Fozmt9QjNwG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iY5lnBm1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0151DC4CEEB;
	Thu, 21 Aug 2025 09:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755767530;
	bh=4ftSy9AZquCD3YWX8ybfUXm27XjKd0BU4eleDXm0U4Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iY5lnBm1olCBsRPpghgXxjzWZdmWakMe3D/6nbyS2OprH7brpDtHHH/UUufrJGZR5
	 B7r/WIwLcEjYDiMmTTFqoNkshhOjUO4blI6LAUBgme+yLpTj64TWn2rdP/Can+daZ3
	 SFTt1jN6qYzZoa2xhi5ymDOsVGR26AcoG53sVjQ43yMoFZsYweql/iA9FMsywjdq38
	 /st3OYMAucW8PRMLoQjfCraPDXPBnjiCljyFCrjt1sOG4HMA59qK4pJkDdvDMgpvrV
	 gAllTDP/NimibpVJ/Fd3bl9C9YbMCO4qljO+V+n1t4pN1TiuZP76w+gLUjdYf0J+18
	 GZOlnoyAoCZFw==
Date: Thu, 21 Aug 2025 11:12:05 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Akira Yokosawa <akiyks@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Inkscape - Was: Re: [PATCH 00/11] Fix PDF doc builds on major
 distros
Message-ID: <20250821111205.15dc7843@foz.lan>
In-Reply-To: <5fb6ce64-747b-46e4-b135-0d987334a12c@gmail.com>
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
	<xik6a2kb3mge5xh2mbdtc4p3ikbr4mnjlkk4ujc4sfztb3iqnr@tc76jva4smpm>
	<526d1aee-d401-4f04-8ddc-122f1fef7905@gmail.com>
	<5fb6ce64-747b-46e4-b135-0d987334a12c@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Thu, 21 Aug 2025 09:09:41 +0900
Akira Yokosawa <akiyks@gmail.com> escreveu:

> Hi,
> 
> Let me do a quick follow up.
> I messed up the table.
> 
> On Thu, 21 Aug 2025 08:53:04 +0900, Akira Yokosawa wrote:
> > Hi,
> > 
> > Commenting on your observation quoted below.
> > 
> > On Wed, 20 Aug 2025 18:48:10 +0200, Mauro Carvalho Chehab wrote:
> > [...]
> >   
> >> If you want a more comprehensive answer:
> >>
> >> LaTeX is highly dependent lots of packages, including fonts. The
> >> reason why you can't reproduce the font issues with Docker
> >> (I wasn't able to reproduce with Docker here as well) is
> >> probably due to either packaging differences between the
> >> two containers, due to different environment technologies
> >> or even due to the way Docker and LXC handles OS virtualization.
> >>  
> > 
> > I'm not saying there is no difference between Docker and LXC.
> > 
> > Can you fill in ???? cells in the table below ?  
> I mean                                          with this series applied
> 
> > Docker column is my observation of "FROM ubuntu:plucky" podman runs.
> > 
> >  "make SPHINXDIRS=gpu pdfdocs" under Ubuntu Plucky
> >   
> 
> I meant:
> 
>      --------------- --------- ----------
>      SVG --> PDF     Docker    LXC
>      --------------- --------- ----------
>      imagemagick     FAIL      ????
>      inkscape        SUCCESS   ????
>      imagemagick [*] FAIL      ????
>      --------------- --------- ----------
> 
> >     --------------- --------- ----------
> >     SVG --> PDF     Docker    LXC
> >     --------------- --------- ----------
> >     imagemagick     FAIL      FAIL
> >     inkscape        SUCCESS   ????
> >     imagemagick [*] FAIL      ????
> >     --------------- --------- ----------
> > 
> > [*] after installing both inkscape and imagemagick, remove inkscape
> >     with all its dependencies kept.
> > 
> > Do you see any difference between Docker and LXC columns in the table?
> > I'm all ears.

I'm repeating my tests again. This time, it has just this
series applied:

	https://lore.kernel.org/linux-doc/cover.1755763127.git.mchehab+huawei@kernel.org/T/#t

(without that, not even simple PDF docs build here via Sphinx on Ubuntu)


LXC container created from scratch, with a couple unrelated packages
to make life easier (things like ssh server) and with locale-gen
executed there.

After its creation, I copied the
relevant files from my machine to the container with:

	for ip in 10.0.3.129; do for d in Documentation scripts Makefile arch include tools; do rsync -av --times --delete "$d" "root@$ip:/root" --exclude output/; done; done

Then, at the container (accessed via ssh):

	# Sphinx pre-install recommendations
        sudo apt-get install dvipng fonts-noto-cjk graphviz imagemagick latexmk librsvg2-bin tex-gyre texlive-fonts-recommended texlive-lang-chinese texlive-xetex
        sudo apt-get install python3-sphinx

	# Needed to avoid sphinx-build crashes
	for i in $(set|grep LC|cut  -d'=' -f1); do unset $i;done
	export LC_ALL=C
	export LANG=C

with that:

imagemagick: FAIL
inkscape: PASS
imagemagick(*): FAIL

I wonder if this is related to the kfigure.py bug of writing
a binary output with a file opened in "w" mode. In Python,
"w" crashes for characters > 127. It should instead be "wb".

Thanks,
Mauro

