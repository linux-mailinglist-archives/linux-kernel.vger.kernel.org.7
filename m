Return-Path: <linux-kernel+bounces-773318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D5FB29E33
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 11:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE9CD3AF680
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 09:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4359C30E842;
	Mon, 18 Aug 2025 09:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XloTzd4P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E154301497;
	Mon, 18 Aug 2025 09:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755510144; cv=none; b=oqbuRXgTjj5rIMfM3nZEgm0xShGCgWSg/q3UXb9r1ykJVgZqkwxRXxQDoC0wArhLet0vZ4rWSQzr2fV0+retk80D3o33/4P+wJ6+xxtsnDJX7THsa2gN218W8uWze7ee5VelOnX9/OCCNW+cUpAQT4M1BKRb6Bp96lCtr15SQ5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755510144; c=relaxed/simple;
	bh=lYv4K3y+Ra6bJIcIwlGL4nulfBKi+NzWe1NLn9oT9bk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tVi5N4PenZHnK9SxhHmGL5ueGVvjePXobnDwcEkUy7vfm4Tis+0+w7VhQ8ti8xlzUgiKHkn7vhL9mk+IO8EqD480v+JDgMsi+LK13OIT0vcUvzMYAGwzXq0XcREPgi8UH78QzHaMD/KdmRxk8ER8B0VJtViEvlWxWwcVWJ1Cy2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XloTzd4P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2017AC4CEEB;
	Mon, 18 Aug 2025 09:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755510144;
	bh=lYv4K3y+Ra6bJIcIwlGL4nulfBKi+NzWe1NLn9oT9bk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XloTzd4P8+extPBeZsLch0J5Kn11e+ZIvG7pw5k7PTTJZNUl7fj7o4Bngr3Tzfyzh
	 pvbhrwKiIqmmUqa8q36ZA1Mg7aexCRuNDsQEy0oRA5mG0eL5+PZzgkBBYLLOFnRlQE
	 twhDg7XLDadNS2RhBh4u9deUT0QRg3iszdk7OEzrUg1I0n5jpJ/YX7Dt7xNDeWO39r
	 bqFvSHPDBVD/BDdPW22nYM1vzKgetNORwEzmuwBFbJF7mgY+tfyDwIl9rOeYUQ1w9A
	 uk4UYNu9SUMpz09jEx8D8roa46jRbyBN0mjKFmIm6nIMMEuXeQ62ARn+kYArPDnpcw
	 qspq1fMcF5d5g==
Date: Mon, 18 Aug 2025 11:42:20 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Akira Yokosawa <akiyks@gmail.com>
Cc: corbet@lwn.net, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/11] Fix PDF doc builds on major distros
Message-ID: <20250818114220.7f82d2f7@foz.lan>
In-Reply-To: <816ec5d2-33ea-4399-86e6-51ddc20ead28@gmail.com>
References: <cover.1755256868.git.mchehab+huawei@kernel.org>
	<773f4968-8ba5-4b1a-8a28-ff513736fa64@gmail.com>
	<20250816135538.733b80d3@foz.lan>
	<acc71988-4ed7-4df1-aa1f-a9d7a125ca53@gmail.com>
	<20250817133606.79d968ed@sal.lan>
	<b3d97e98-121d-4d12-9624-3efd119b12a4@gmail.com>
	<20250817154544.78d61029@foz.lan>
	<b6d18aa7-de85-4fd2-8456-c2f6342f1b06@gmail.com>
	<816ec5d2-33ea-4399-86e6-51ddc20ead28@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Mon, 18 Aug 2025 09:44:39 +0900
Akira Yokosawa <akiyks@gmail.com> escreveu:

> On Mon, 18 Aug 2025 01:07:24 +0900, Akira Yokosawa wrote:
> [...]
> 
> > 
> > Ah, I have finally understood what 5/11 is trying to do.
> > 
> > Its changelog mainly talks about an issue you saw after adding options
> > to xindy in that same commit, and you added
> > 
> >    \newfontfamily\headingfont{DejaVu Serif}
> > 
> > to resolve it.  
> 
> Sidenote:
> 
> It looks like texlive-xindy is not available for RHEL based distros.

On several rpm-based distros, extra repositories are needed.

So, if you take a look at rpmfind:
	https://rpmfind.net/linux/rpm2html/search.php?query=python3-sphinx

For the limited set of distros supported there, you'll see that sphinx-build
can either be at:
	- main distro repos;
	- CRB;
	- Powertools

But this is only a fraction of the problem, as there are several
exceptions. For instance, RHEL8 from "redhat/ubi8" docker container(*) 
sounds to be an official vendor-provided image.

(*) https://hub.docker.com/r/redhat/ubi8

Yet, if you use it and try to install sphinx-build:

	# dnf install python3-sphinx
	Updating Subscription Management repositories.
	Unable to read consumer identity

	This system is not registered with an entitlement server. You can use subscription-manager to register.

	Last metadata expiration check: 21:10:22 ago on Sun Aug 17 11:30:23 2025.
	No match for argument: python3-sphinx
	Error: Unable to find a match: python3-sphinx

It won't work, because repo management in this case requires to setup
a paywall protected procedure.

> That means, you will need to ask EPEL to provide it.
> Otherwise, you are obsoleting those distros for pdfdocs build
> (under the confinement of "distro packages only").

Recommending a repository setup for rpm distros is complex. When
I wrote sphinx-pre-install, I opted to keep such setup out of it.

The rationale is that the ones using such distros should know
better and may require a paid subscription.

With the exception of rpmfusion on Fedora, where one needs to first
download a RPM file from some site, for most distros, the extra
needed repositories are already installed or can be installed from
a package provided at the main repository. Once downloaded,
all it takes is to enable it. 

For instance, to get what is needed to build both html and pdf on 
RockyLinux, one needs to install a distro package:

	dnf install -y epel-release

Which adds extra repositories to /etc/yum.repos.d/.

Then, either use config-manager:

	# change "enable" flag from /etc/yum.repos.d/ repos
	dnf install 'dnf-command(config-manager)'
	dnf config-manager --set-enabled powertools appstream epel

or pass an extra option to enable the repo(s) during install:

	sudo dnf --enablrepo=powertools --enablrepo=appstream --enablrepo=epel install -y python3-sphinx {other packages}

Now, sphinx-pre-install can later be improved to also contain
repo-management instructions but this is out of the scope of this
series (and I'm not sure if it is worth adding it there).
	
Thanks,
Mauro

