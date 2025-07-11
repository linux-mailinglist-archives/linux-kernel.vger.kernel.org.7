Return-Path: <linux-kernel+bounces-727076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A1AB014B5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 09:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E40D1C2177D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 07:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6666B1EFF9B;
	Fri, 11 Jul 2025 07:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sr2JNfMH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DA01E9B08;
	Fri, 11 Jul 2025 07:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752218962; cv=none; b=UVA/qTcfKJvQ0wQp6ETMTwQP1PdkCvA12E6pgMNJsilxuNMI+7OsFGiaE+2bTsR8IGzPb/bmAzAOTReC43scNR0HUExNANR5VM1gK9iJpa1wmcFmMIi+IyNFUtB7Puf8eOHHhB1LGCvAEorYy7ZAfrSdXzaWKv2Y5DDIrKBM1T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752218962; c=relaxed/simple;
	bh=1bYQFKIcAn0s1xDS2MgBRnt8iLRkzAExHI5zhkCBABA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C9TylIC8w8fpflOXX1sj+9/lFkcNwhTDoTuLsG+xNKwI6IqmE6m4gBg+rf7i4khyDEVeO72pZp28aujtSjjoR4k5XbO+CZkpBI5jmS+vO621wpwK5fGPaIvl9gOtM1WvNBAobotAE0L28rSm7RHj5/C0J6S5sGrw/P57rfMWhpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sr2JNfMH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44311C4CEED;
	Fri, 11 Jul 2025 07:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752218961;
	bh=1bYQFKIcAn0s1xDS2MgBRnt8iLRkzAExHI5zhkCBABA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Sr2JNfMHO8x4Zvt10+1DTJTVI3SbUWuUb8UNKm5iDpElYTN1tNSGQPewefAPXNHi1
	 K5JFOhzSpqpUxob1nIi2iIA5iCI0+5vLhWrd6+tvXLb/+VyQ0tSUE07QPg5aUnPxJW
	 DlfK1ta2W2pZIk5TMBb75sg5RwvkgLL7uYfbkP161tk3vAYrYLAsiIMxCjpBgg2o+b
	 +RSev1lt1JQ4vbUIKgwFvFZcBj5rphtd3JUrFm4dnlBtajx8+aXA0uJDfBtg7liStf
	 1L8fFKAdqYeZP1rjT5IzP0lsu+3oiVvyncReT3n0pkG5Typii/i4PbqhD0qynqgtNW
	 duedNyJmZVgMg==
Date: Fri, 11 Jul 2025 09:29:17 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Akira Yokosawa <akiyks@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/12] Thrash up the parser/output interface
Message-ID: <20250711092917.229bcc89@foz.lan>
In-Reply-To: <92ff26c0-6952-4f7e-965e-2f020adb859b@gmail.com>
References: <20250710233142.246524-1-corbet@lwn.net>
	<92ff26c0-6952-4f7e-965e-2f020adb859b@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Fri, 11 Jul 2025 13:29:00 +0900
Akira Yokosawa <akiyks@gmail.com> escreveu:

> On Thu, 10 Jul 2025 17:31:30 -0600, Jonathan Corbet wrote:
> [...]
> 
> > Changes since v1:
> > - Coding-style tweaks requested by Mauro
> > - Drop the reworking of output-text accumulation for now
> > - Add a warning for prehistoric Python versions  
> 
> Serious review of python code is beyond my background, but I did a test
> on this against opensuse/leap:15.6's python3-Sphinx_4_2_0, which comes with
> python 3.6.15.
> 
> Running "./scripts/kernel-doc.py -none include/linux/rcupdate.h" emits this:
> 
> ------------------------------------------------------------------------
> Traceback (most recent call last):
>   File "./scripts/kernel-doc.py", line 315, in <module>
>     main()
>   File "./scripts/kernel-doc.py", line 286, in main
>     kfiles.parse(args.files, export_file=args.export_file)
>   File "/linux/scripts/lib/kdoc/kdoc_files.py", line 222, in parse
>     self.parse_file(fname)
>   File "/linux/scripts/lib/kdoc/kdoc_files.py", line 119, in parse_file
>     doc = KernelDoc(self.config, fname)
>   File "/linux/scripts/lib/kdoc/kdoc_parser.py", line 247, in __init__
>     self.emit_message(0,
> AttributeError: 'KernelDoc' object has no attribute 'emit_message'
> ------------------------------------------------------------------------
> 
> This error appeared in 12/12.  No errors with python3 >=3.9.

This is actually a bug. See:

	+        #
	+        # We need Python 3.7 for its "dicts remember the insertion
	+        # order" guarantee
	+        #
	+        if sys.version_info.major == 3 and sys.version_info.minor < 7:
	+            self.emit_message(0,
	+                              'Python 3.7 or later is required for correct results')
	+
	     def emit_msg(self, ln, msg, warning=True):
	         """Emit a message"""

The answer is just below the modified code: the function name is actually:
	self.emit_msg()

> I'm not sure but asking compatibility with python <3.9 increases
> maintainers/testers' burden.  Obsoleting <3.9 all together would
> make everyone's life easier, wouldn't it?

I'd say that the best is to have:

scripts/sphinx-pre-install:

- be compatible with Python 3.6, as it is needed to detect and
  request Python upgrades where needed.

- For the doc build, based on my tests with the pre-install tool,
  all distros on my testlist have at least Python >= 3.9 as optional
  packages.

Now, kernel-doc is a special case, as it is called during Kernel
builds, with "-none". In the specific case of this patchset, running
Python 3.6 would randomize the order of struct and function arguments.
Not a problem when "-none" is used. So, compilation should not
break.

Shifting kernel-doc minimal version to Python >= 3.9, will
require an extra logic at kerneldoc to abort early if "-none"
is used with too old Python, as otherwise it will break kernel
builds for RHEL8, OpenSUSE Leap, OpenMandriva Lx 4.3 and to 
other distros (those three comes with 3.6).

Jon,

I sent a two-patches series addressing such issues with kernel-doc
exec file.

I would keep patch 12/12, fixing it from:

	 self.emit_message -> self.emit_msg

as the warning is emitted when using kdoc classes, which is now the
default.

-

Btw, if you use Fedora, you can easily install python 3.6 there via 
dnf:

	$ dnf search python 3.6
	Updating and loading repositories:
	Repositories loaded.
	Matched fields: name, summary
	 python3.6.i686: Version 3.6 of the Python interpreter
	 python3.6.x86_64: Version 3.6 of the Python interpreter

	(Fedora 42 also have all python versions from 3.9 to 3.14 beta also
	 via dnf)

Regards,
Mauro

