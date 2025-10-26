Return-Path: <linux-kernel+bounces-870287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF2BC0A619
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 11:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F14E2189889A
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 10:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BDD8212542;
	Sun, 26 Oct 2025 10:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OUrM6ixL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B40C335C7;
	Sun, 26 Oct 2025 10:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761474856; cv=none; b=AlUfBFY8Hn9PPxZ0Y/MeGTzBKmyOPHiX8m1O47pFvZmdlu6CopVXoyLS43OyYgwcPCNajYUaUd1BgEbZIvSX9ggPwyDUtHZ0jDCrkr4LjKcaUQwXrxjWfB0lFaZgNz5A68Fd3JHxJPAnoYinUInohXqI18IF2pggfC0KGKWlU3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761474856; c=relaxed/simple;
	bh=hUsqkIixaeDcBz0S0BS43AUlXWbznsf2hkfqXr0Ln9I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eJG1Wm0c3LOHM86fEXcB10Bvc9EqkCAbiyMzLArDQ6iyFSS6z6bbEdd4/sILxd9ffcTpJIQ5gXrWXSHk3mBKhzM1ntO59mR44JaRFld91zXKS00zf0imrpcOtWdPRysA2ZkgHJVFsCbXqj/a8plZBmhahUdVdjpHUftYyGD76XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OUrM6ixL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70765C4CEE7;
	Sun, 26 Oct 2025 10:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761474855;
	bh=hUsqkIixaeDcBz0S0BS43AUlXWbznsf2hkfqXr0Ln9I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OUrM6ixLdYffHB1B6FnpTDXMokQ5DxXZtrHvRxhujzHHpX8p9fI9WM5b52Z1Mdoom
	 kqTQO1NaT/lCi1slZc5WNgx0IopnDJalltCBZF4GHRaP485sRqylxzPCSXVtkmoscu
	 k9cBamU75Jkvp38r0KIcbipzIm+TMpcnJ2Yqgqicrq+tlqLEZKA3+HwvV+7jbvBtBY
	 +9DTPPlvhIJKJ3n/xSr0v8mDwf3dSlJ+CLeWoj5xEFshCRhOidnWjS1FQEfXeKVV5r
	 fpPBulVwHWVl2O6PMGoqDLSonVQzrA/Vxo/IE0Grm469kOKLXY0GKOxPuvDWxT1xpJ
	 P/FVXsVgtTYkA==
Date: Sun, 26 Oct 2025 07:34:05 -0300
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Akira Yokosawa <akiyks@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>, Jani
 Nikula <jani.nikula@linux.intel.com>
Subject: Re: [PATCH v3 0/8] Collect documentation-related tools under
 /tools/docs
Message-ID: <20251026073405.0672c9dd@sal.lan>
In-Reply-To: <d3f4c7ee-6351-4c6f-ae93-f423245c4c9e@gmail.com>
References: <20251024200834.20644-1-corbet@lwn.net>
	<d3f4c7ee-6351-4c6f-ae93-f423245c4c9e@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Sun, 26 Oct 2025 00:14:23 +0900
Akira Yokosawa <akiyks@gmail.com> escreveu:

> On Fri, 24 Oct 2025 14:08:21 -0600, Jonathan Corbet wrote:
> > Our documentation-related tools are spread out over various directories;
> > several are buried in the scripts/ dumping ground.  That makes them harder
> > to discover and harder to maintain.
> > 
> > Recent work has started accumulating our documentation-related tools in
> > /tools/docs.  This series completes that task, moving the rest of our
> > various utilities there, hopefully fixing up all of the relevant references
> > in the process.
> > 
> > At the end, rather than move the old, Perl kernel-doc, I simply removed it.
> > 
> > The big elephant lurking in this small room is the home for Python modules;
> > I left them under scripts/lib, but that is an even less appropriate place
> > than it was before.  I would propose either tools/python or lib/python;
> > thoughts on that matter welcome.
> > 
> > Changes in v3:
> >   - Now with more caffeine! Properly based on docs-next.  
> 
> :-) :-)
> 
> WRT the build error from test robot, it looks to me like we need these
> final touches:
> 
> diff --git a/Documentation/conf.py b/Documentation/conf.py
> index 8e3df5db858e..fbd8e3ae23ea 100644
> --- a/Documentation/conf.py
> +++ b/Documentation/conf.py
> @@ -582,7 +582,7 @@ pdf_documents = [
>  # kernel-doc extension configuration for running Sphinx directly (e.g. by Read
>  # the Docs). In a normal build, these are supplied from the Makefile via command
>  # line arguments.
> -kerneldoc_bin = "../tools/docs/kernel-doc.py"
> +kerneldoc_bin = "../tools/docs/kernel-doc"
>  kerneldoc_srctree = ".."
>  
>  def setup(app):
> diff --git a/Documentation/sphinx/kerneldoc.py b/Documentation/sphinx/kerneldoc.py
> index 2586b4d4e494..3c815b40026b 100644
> --- a/Documentation/sphinx/kerneldoc.py
> +++ b/Documentation/sphinx/kerneldoc.py
> @@ -289,13 +289,8 @@ def setup_kfiles(app):
>  
>      kerneldoc_bin = app.env.config.kerneldoc_bin
>  
> -    if kerneldoc_bin and kerneldoc_bin.endswith("kernel-doc.py"):
> -        print("Using Python kernel-doc")
> -        out_style = RestFormat()
> -        kfiles = KernelFiles(out_style=out_style, logger=logger)
> -    else:
> -        print(f"Using {kerneldoc_bin}")
> -
> +    out_style = RestFormat()
> +    kfiles = KernelFiles(out_style=out_style, logger=logger)

Patch is incomplete, as it doesn't drop the logic which forks
kernel-doc script run, but see below.

>  def setup(app):
>      app.add_config_value('kerneldoc_bin', None, 'env')
> diff --git a/Makefile b/Makefile
> index d6ff0af5cca6..33b1db1cc0cf 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -460,7 +460,7 @@ HOSTPKG_CONFIG	= pkg-config
>  
>  # the KERNELDOC macro needs to be exported, as scripts/Makefile.build
>  # has a logic to call it
> -KERNELDOC       = $(srctree)/tools/docs/kernel-doc.py
> +KERNELDOC       = $(srctree)/tools/docs/kernel-doc
>  export KERNELDOC
>  
>  KBUILD_USERHOSTCFLAGS := -Wall -Wmissing-prototypes -Wstrict-prototypes \
> 
> -----------------------------------------------------------------
> 
> The change in Documentation/sphinx/kerneldoc.py is needed because
> 
>     kerneldoc_bin == ".../kernel-doc.py"
> 
> indicated loading it as python lib into the extension, while
> 
>     kerneldoc_bin == ".../kernel-doc"
> 
> indicated invoking it as a script.
> 
> Now that we don't have kernel-doc.py, loading python lib looks to me
> as a natural choice.
> 
> Mauro, what do you think?

Good point. I'm not sure about this. Yeah, on normal cases, we
just want to run kernel-doc classes, instead of actually
executing its binary. Yet, for debugging purposes, it might
still be interesting to run it as separate processes.

See, right now, if KERNELDOC is not used, it will use imported
Python classes, running them directly without creating processes.
So, it won't actually call ".../kernel-doc". On such case, in
practice, it will actually ignore KERNELDOC when building docs.

Now, (after this series), if one runs:

	KERNELDOC=tools/docs/kernel-doc make htmldocs

it will run kernel-doc script as a process. This might be useful
for debugging purposes.

Also, please notice that KERNELDOC is used on several files:

	$ git grep -l KERNELDOC
	Makefile
	drivers/gpu/drm/Makefile
	drivers/gpu/drm/i915/Makefile
	include/drm/Makefile
	scripts/Makefile.build
	tools/docs/sphinx-build-wrapper

IMHO, we have some alternatives here:

1. completely drop support for KERNELDOC variable.
   On such case, we need to drop from the script:

	- kerneldoc_bin
	- run_cmd() function
	- remove KERNELDOC from Makefiles and sphinx-build-wrapper

2. keep it as is, which would help debugging (and eventually
   would allow testing two different implementations of kernel-doc
   without needing to bisect);

3. change the core of the logic to be something like:

	# kerneldoc_bin = env.config.kerneldoc_bin
	kerneldoc_bin = os.environ.get("KERNELDOC")

	if not kerneldoc_bin:
	   out_style = RestFormat()
	   kfiles = KernelFiles(out_style=out_style, logger=logger)
	else:
	    print(f"Generating C documentation by running {kerneldoc_bin} binary")

   this would still allow using KERNELDOC to point to a binary
   that will handle C files executed as a separate process.

   Please notice that the current code does:

	kerneldoc_bin = env.config.kerneldoc_bin

   This requires an extra logic at the wrapper tool, as this needs
   to be passed via -D command line option to sphinx-build. That's
   the reason why several Makefiles also use KERNELDOC env var.

   If we're willing to adopt this solution, I would simplify
   the wrapper and the makefiles to not touching KERNELDOC var
   anymore.

For (2) and (3), I would document KERNELDOC somewhere.

My personal preference would be (3), but I don't have strong
feelings.

Regards,
Mauro

