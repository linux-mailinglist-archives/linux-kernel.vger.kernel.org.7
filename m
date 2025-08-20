Return-Path: <linux-kernel+bounces-777063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2C1B2D4A8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 09:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83B90189C989
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 07:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE6D16F0FE;
	Wed, 20 Aug 2025 07:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hDVl03nq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B9227B500;
	Wed, 20 Aug 2025 07:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755674134; cv=none; b=Sg3QmE9UWten7JD8Ob2NhCAD0tUEh+o3Sw7fdbHRTQG7hCIyC1CzWurijHITDYJt6iFomCYkvebfG8hXKvpT+lU0FKh8uGqn62T4u6BO87q/VZ1SrGpAORL++rv2Ilmt7uIpODE4mfnDSz8mqh5WSfZfWAzph4MTB+zJnYqIbtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755674134; c=relaxed/simple;
	bh=1zSdyzJIBXMoAaRMvgYTuw241oUQN7ZyJKqcvWRpilQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r6XQmGlmPgxuOlfFVFL9TF6HNnqbt8pCmSRTbyau5MxXm18Ax5fASxBFWGM3zsSPaUWnEn2c2BdTe8XucVNXDi79ffenMx384NmQoj7lwt8QI1IwaJIvYh3MSvdc9b5oUIKXy7VcZBQRwEwS4svOMpbq4dTjMPMdu7jD6mgKxTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hDVl03nq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82CB0C4CEEB;
	Wed, 20 Aug 2025 07:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755674134;
	bh=1zSdyzJIBXMoAaRMvgYTuw241oUQN7ZyJKqcvWRpilQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hDVl03nqhGm7GjdYzV7y2+NEigb2qGneyyRRCF9U1p+KRCp6c3/cg2RDceHQm7XqD
	 js1lMFWZVQkKeCCbJUk/2HsOOYRjNdcLX6N4d6msEKelFCeejImGBPWR/4yqBXpg53
	 jVFrZ1WdYMPw3OB5WoKQhQfPevMDO1txjK8pgwthSLWEsWZDAxu6rZLwtJ7xD2BHPx
	 m3StMwAYrs2WDZhgFljUiYHK9ph4mXgHg/FqEaFSKULvRwtt8/kRZLQ+MidRA3tfU7
	 nNVmnENtWjT0qvvy3iLexgqQKrin0IBWN4hkaFdnnAs9KxvytJ5Sv/1+Z2bQ3tijd9
	 kmBDqnd8BPa8A==
Date: Wed, 20 Aug 2025 09:15:30 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Akira Yokosawa <akiyks@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/11] Fix PDF doc builds on major distros
Message-ID: <20250820091530.068c4b62@foz.lan>
In-Reply-To: <08c3a7eb-0425-4709-a3ea-6d1d726fd3c8@gmail.com>
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
	<20250819153200.3c2b2ff6@foz.lan>
	<08c3a7eb-0425-4709-a3ea-6d1d726fd3c8@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Wed, 20 Aug 2025 08:54:52 +0900
Akira Yokosawa <akiyks@gmail.com> escreveu:

> On Tue, 19 Aug 2025 15:32:00 +0200, Mauro Carvalho Chehab wrote:
> > Em Tue, 19 Aug 2025 11:16:29 +0900
> > Akira Yokosawa <akiyks@gmail.com> escreveu:  
> 
> [...]
> 
> >> That's all I am asking.
> >>
> >> I have no particular interest in the way you are testing all those
> >> variety of distros, and have no idea about it.
> >>
> >> Please provide steps to reproduce.
> >> I'd like to see a Dockerfile based "FROM ubuntu:latest" as the testing
> >> environment.  
> > 
> > Heh, that's why you can't reproduce... you're using a Docker container
> > and a different Ubuntu version than I.
> > 
> > What I did here was to use a lxc container with 25.04, and used
> > a script to pick the exact recommendations given by sphinx-pre-install.
> > 
> > The container was created with:
> >  
> 
> [...]
> 
> > once you get what's needed for make htmldocs work, installing
> > only the dependencies recommended by sphinx-pre-install, you can
> > start trying to reproduce the build issues for pdf.  
> 
> I've just built a container "FROM ubuntu:plucky", which has inkscape
> instead of imagemagick + rsvg-convert.

I don't think that inkscape x imagemagick/rsvg-convert itself has
anyhting to do with the problems I detected, as they're related to
font issues (still, I got an issue on one of my builds on kfigure
write file: encoding is missing at open, which may cause errors).

Yet, installing imagemagick + rsvg-convert might affect some other
packages that LaTeX would use.

> I don't see any font issue at 4/11 of this series under the container
> (I'm using podman).
> 
> Furthermore, after I applied both of your series and the change for
> parallel runs of xelatex/latexmk and reverting the 5/11, I don't see
> any issue.
> 
> Which strongly suggests 5/11 is not fixing any realistic issues.
> 
> FWIW, Dockerfile I'm using for building the container is derived from the
> one I've been taking care of since 2021 as a LaTeX advisor to perfbook.
> 
> If you are interested, here is its repo of Paul:
> 
>     git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/perfbook.git
> 
> You might be interested in seeing docker/Dockerfile.
> 
> I think there is something you are missing in the boot strapping phases
> of building your container.
> 
> Just my wild guess.

Just because you can't reproduce the issue, it doesn't mean it doesn't
exist. LaTeX builds are complex having it has lots of dependencies,
and may be affected by installed fonts, LC_* and LANG env vars, etc.

It should be noticed that a Docker container doesn't have the same
packages installed when compared with a LXC one.

-

IMO, instead of trying to reproduce the bug that was already fixed
by my patches, it would be a way more important if you can double
check if the changes introduce regressions.

I'm planning to submit a new version of this series, with this
patch split into 3 patches, with a better description, plus a
couple of other fixes. If you notice a regression caused by any
of the patches, please let us know, preferably pointing the the exact
patch that broke it. 

Thanks,
Mauro

