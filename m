Return-Path: <linux-kernel+bounces-723138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A6BAFE360
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 10:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C4204E74CB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 08:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3EB5283FDC;
	Wed,  9 Jul 2025 08:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TFtiwSEj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B82283FC8;
	Wed,  9 Jul 2025 08:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752051518; cv=none; b=QMX26q06P/8+lLt7BwsBTwJBaWgZenvmXz0Y6IVPMsrX5qiwCgAzEzBfQpQ+UDAhntyph7AopZ3rqUQkh0seYmdKgUg2qDGZkwHIMwDrBPRkj68j7nQlRYiahDMuMQrjmt6u74GxCYSqjV3M9Wozk6zLIoB7VMW+XBRXLxYuGcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752051518; c=relaxed/simple;
	bh=/0NZDy7r80MqGg2EtP9K8SkjJnkRbWobikENSWLwTj8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OxvpZ2GLFXD6xxFeRqjMXSnaJJfa/hUY7UkySJaLBligVc5RIICJpAQO6Qq+Pmxg6c5XamKXjZVpCPY/On6msI6wWd8JDwZfFk8CkwaTckjgnvRR+VjnWujR/UsrBkRG2SY+GCla6FhlNJnIC0lMwDSV3zsCs7lFlylJMz5JRu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TFtiwSEj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BD68C4CEEF;
	Wed,  9 Jul 2025 08:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752051517;
	bh=/0NZDy7r80MqGg2EtP9K8SkjJnkRbWobikENSWLwTj8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TFtiwSEjtM6k8Cb2bRcr7vgpE0etL1ynwP0lDgq7/UOxFd5CQZ0YGqKi1igdF74eC
	 lycwgz8EbSb8ez9cYvPcDF6EkOMmZuMLHtBOvbT/d+qb+5RddkevvUF07PaXb/KqJ/
	 +l24lWnMpuWU0//j8O9m/Vwaju99zH2t6jJ6dejSCMAodX6nvdOpBZs7/EOgzzfW8U
	 GBMdPRtOvdpd2BT6HjSChmNwte9/FzI4ew7vjJ15xzQg5mtCOcC5P/6vOQLU89OoXy
	 l/XCpbG2mEm+0EBpdsPN5hcG5XM/veDriFbymqfVNEc4lheKrRX5E/p9gZfqcAcTfU
	 6XiQcGebsR1Og==
Date: Wed, 9 Jul 2025 10:58:33 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Akira Yokosawa <akiyks@gmail.com>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, linux-kernel@vger.kernel.org, Sai Vishnu M
 <saivishnu725@gmail.com>
Subject: Re: [PATCH 00/15] Translate sphinx-pre-install to Python
Message-ID: <20250709105833.48a56708@foz.lan>
In-Reply-To: <d37eab74-a034-4be6-b92b-e0da60a99477@gmail.com>
References: <cover.1751318230.git.mchehab+huawei@kernel.org>
	<d37eab74-a034-4be6-b92b-e0da60a99477@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Tue, 8 Jul 2025 12:09:52 +0900
Akira Yokosawa <akiyks@gmail.com> escreveu:

> Hi Mauro,
> 
> On Mon, 30 Jun 2025 23:34:48 +0200, Mauro Carvalho Chehab wrote:
> [...]
> 
> > The test script also ran the install procedure for system,
> > venv and native Sphinx install.  
> 
> Which install procedure did you test?  The short one with the "--no-pdf"
> option?

No, I'm testing it with PDF.

> I am asking because installing the full list of packages in podman run
> of opensuse/leap:15.6 didn't complete successfully for me.

I got a couple of extra fixes for Leap. Will be submitting in a few.

> And by the look of things, you stopped at installation, because you are
> well aware of all the issues in running "make htmldocs" and its friends
> after the install.
> 
> I assume you (or somebody else) are going to update the script once this
> series is applied to make the suggested lists of packages be useful for
> newcomers.

I'm not actually building the docs, just checking that the script will
install Sphinx and required dependencies. There are a couple of reasons
for that:

- the disk space on my desktop. Right now, I'm just copying the
  files instead of doing a Kernel git clone. Even so, testing all
  those distros is requiring about 100GB on my /var partition;
- test time. Right now, I'm starting dozens of machines in
  lxc or podman in parallel. Still, it takes a lot of time to
  download and install all packages;
- compilation build itself is out of the scope of the script.
  I'm pretty sure we'll have compilation issues(*).

(*) on some RHEL-based distros, for instance, texlive-ctex package
    is not there (I guess version 8). so, I suspect that CJK
    builds may fail.

Anyway, fore sure there will be space for improvements after it, and
I really appreciate if you could send patches on the top of the new
series addressing the issues. 

> > The tests were done with those containers, obtained from
> > lxc download templates or via podman run:  
> [...]
> 
> > It also properly detected RHEL 8 string:
> > 
> > Detected OS                : Red Hat Enterprise Linux release 8.10 (Ootpa).
> > Installing venv            : WARNING: No such file or directory: 'sphinx-build'
> > Installing package_install : WARNING: No such file or directory: 'sphinx-build'
> > 
> > But, at this particular docker container, no repositories had
> > python3-sphinx nor python3-virtualenv, but I suspect that this
> > is a problem on this particular image, as I'm almost sure we
> > tested RHEL 8 in the past, so, I have hopes that this could
> > still work with real RHEL, if it has Python >= 3.7.  

On this container, you can only install Sphinx with packages with
a subscription, as the repository where it sits can't be enabled
without registering. 

> FWIW, almalinux 8 provides python3-sphinx in the "PowerTools" repo.
> It installs Sphinx 1.7.6 on top of python 3.6.8.
> python3-virtualenv is in the "AppStream" repo. It also comes with
> python 3.6.8.

I added a version check on my test script. I'm opting to use
rockylinux 8 instead, as it is meant to be 1:1 binary compatible
with RHEL.

I will provide the output for it at the next version.

> > 
> > Yet, our goal is to support the latest LTS version, so
> > RHEL 8 is out of scope.  
> 
> Yes, I think it is reasonable to ignore RHEL 8 and its clones.

Yes, but still it may work with venv. I'm adjusting the script
right now for it to propose installing python39 package and
accepting install on venv.

> For the record, here is a WIP scorecard of suggested procedure by
> actually running "make htmldocs" and its friends after installing distro
> packages (if it succeeds):
> 
> ------------------------------------------------------------------------
> * debian:12
> 
> htmldocs:  OK
> latexdocs: NG
> 
> Debian and its derivative prohibit convert(1) (of ImageMagick) from
> generating PDF by their default policy, so you'll get a bunch of:
> 
> [while building userspace-api.tex]
> 
> WARNING: Error #1 when calling: /usr/bin/convert /<srcdir>/Documentation/userspace-api/media/typical_media_device.svg /<srcdir>/Documentation/output/userspace-api/latex/typical_media_device.pdf
> WARNING: Warning msg from convert(1): convert: attempt to perform an operation not allowed by the security policy `PDF' @ error/constitute.c/IsCoderAuthorized/426.
> 
> , and if you ignore them and try to build PDF, you'll get:
> 
> [while building userspace-api.pdf]
> 
> ! Dimension too large.
> \spx@boxes@fcolorbox ...dimexpr \ht \spx@tempboxa 
>                                                   +\spx@boxes@border@top +\s...
> l.54887 \end{sphinxVerbatim}
>                             
> ? 
> ! Emergency stop.
> \spx@boxes@fcolorbox ...dimexpr \ht \spx@tempboxa 
>                                                   +\spx@boxes@border@top +\s...
> l.54887 \end{sphinxVerbatim}

I use Debian to regularly produce html results. It requires a
change at ImageMagick policies for it to run.

> * fedora:latest (42)
> 
> htmldocs:  NG
> 
> Container images of fedora has stopped having "which" as a command.
> You need to install it manually.  After installing "which": OK

Thanks for the feedback! I'm installing which on my container's
setup, as my test scripts require it. I'll add a check to install
it.

> 
> pdfdocs:  OK
> 
> * opensuse/leap:15.6
> 
> htmldocs:  NG
> After installing "which": OK

Will do the same here.

> 
> latexdocs: NG
> Can't complete "zypper install" inside a podman container run using the
> full package list ???

I added some fixes for it.

> Having look at these poor results, I don't see any reason to continue
> testing further.

Thanks for the feedback!

Thanks,
Mauro

