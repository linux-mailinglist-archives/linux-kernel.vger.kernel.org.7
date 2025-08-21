Return-Path: <linux-kernel+bounces-779179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 107E4B2F025
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 09:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADA593BB8D6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 07:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539E0283FCB;
	Thu, 21 Aug 2025 07:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Be/X0u3d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A099A146A66;
	Thu, 21 Aug 2025 07:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755762749; cv=none; b=m8CR7XB3VKSm1zHyrk4oWtb1wP8h6hLBxKzCifcWG73WJdi518RUQsN57xQaBFLYrur10sUW/TWDopmSZ6XYrq4aPLk9GgFt+oGxSyZgex0tiRTsqVDLH+dJS/r6w+n8oVC1nVqyC5VVazqFW4azifbdEQMa6AeXQTHsV6P3RUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755762749; c=relaxed/simple;
	bh=/l4XzB64no1cnceTKlRthQJzeqiG8NZWL842mVON6AQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d1fI79qUqFohBHclH7XmcNDRtTdHfklxMkLqgjVtuV4oEZzOkA32QtNf2/8PBOB1jEkpepBVE5+MUr4brq4EVQBh0PkXF+rcYxgagPLoT/20rOK+xvyP0R4qNEFDuuyUiSb8CKgMpSpF4ZGfCSKGWZg2H7unj7EoTrzL+tHtRaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Be/X0u3d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 142FFC4CEF4;
	Thu, 21 Aug 2025 07:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755762749;
	bh=/l4XzB64no1cnceTKlRthQJzeqiG8NZWL842mVON6AQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Be/X0u3dH4tR5CiH4/9JHi7OqCVZCfp9Lcqe5RciCQtItV804bJH3H1MTVtS2PWom
	 53jHYUDRMt2n5BWxjlye9EfAwL9nnaCOS3TCiXsOUUjigyxHMoYQy8U3r6li2OYP6B
	 Ra6S64CXjDbTQJmhg+Ed1CBK57qQclVuM9rjjIW4AW/cehVKg1/hi/1dc2P5J8nNZN
	 SNoJhCy8zV5R7i9hVRXNUcuJLgRTyzF1GlAPJZtOgyggcYDBtVp5d6iT6ozRuyKI7u
	 +NcpLjTsklI+eAlWWNF3rE33p7hqr4ftW+CqTGBq2pxULDO+EEl0fK5i4WudG3vy3r
	 TzYf6HKCwO1yg==
Date: Thu, 21 Aug 2025 09:52:21 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Akira Yokosawa <akiyks@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/11] Fix PDF doc builds on major distros
Message-ID: <20250821095221.5e6510f5@foz.lan>
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

This is after my series, with doesn't deal with imagemagick/inkscape,
it only fixes broken texlive dependencies and fix font handling:

# (dpkg -l |grep -i magick; dpkg -l |grep inkscape)|grep ii
ii  imagemagick                   8:7.1.1.43+dfsg1-1                    amd64        image manipulation programs -- binaries
ii  imagemagick-7-common          8:7.1.1.43+dfsg1-1                    all          image manipulation programs -- infrastructure
ii  imagemagick-7.q16             8:7.1.1.43+dfsg1-1                    amd64        image manipulation programs -- quantum depth Q16
ii  libmagickcore-7.q16-10:amd64  8:7.1.1.43+dfsg1-1                    amd64        low-level image manipulation library -- quantum depth Q16
ii  libmagickwand-7.q16-10:amd64  8:7.1.1.43+dfsg1-1                    amd64        image manipulation library -- quantum depth Q16

# make SPHINXDIRS=gpu pdfdocs

Summary
=======
gpu: gpu/pdf/gpu.pdf

All PDF files were built.

# rm -rf Documentation/output/gpu/*
# (dpkg -l |grep -i magick; dpkg -l |grep inkscape)|grep ii
ii  imagemagick                     8:7.1.1.43+dfsg1-1                    amd64        image manipulation programs -- binaries
ii  imagemagick-7-common            8:7.1.1.43+dfsg1-1                    all          image manipulation programs -- infrastructure
ii  imagemagick-7.q16               8:7.1.1.43+dfsg1-1                    amd64        image manipulation programs -- quantum depth Q16
ii  libimage-magick-perl            8:7.1.1.43+dfsg1-1                    all          Perl interface to the ImageMagick graphics routines
ii  libimage-magick-q16-perl        8:7.1.1.43+dfsg1-1                    amd64        Perl interface to the ImageMagick graphics routines -- Q16 version
ii  libmagickcore-7.q16-10:amd64    8:7.1.1.43+dfsg1-1                    amd64        low-level image manipulation library -- quantum depth Q16
ii  libmagickwand-7.q16-10:amd64    8:7.1.1.43+dfsg1-1                    amd64        image manipulation library -- quantum depth Q16
ii  inkscape                   

# rm -rf Documentation/output/gpu/*
# (dpkg -l |grep -i magick; dpkg -l |grep inkscape)|grep ii
ii  inkscape                        1.2.2-8build1                         amd64        vector-based drawing program

# make SPHINXDIRS=gpu pdfdocs

Summary
=======
gpu: gpu/pdf/gpu.pdf

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

Yes. After having texlive dependencies fixed, and addressing the broken
conf.py file that is not aligned with modern Sphinx practices, it passed
on all three scenarios.

Please notice that addressing image was not the intent of this series.

The goal was *just* to fix texlive dependencies and fix text font
mapping that were causing troubles on Ubuntu and on other distros.


Thanks,
Mauro

