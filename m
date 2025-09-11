Return-Path: <linux-kernel+bounces-811816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0509B52E3E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 12:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FC3A16BBCB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 10:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E043101C7;
	Thu, 11 Sep 2025 10:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TNbyJizt"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491FE2EA74B;
	Thu, 11 Sep 2025 10:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757586245; cv=none; b=t9JdQrMNdNCp5+7dGR4Mjd8sS5arpxje4b3dsDsco4rjh86H8lR8lY3kuvwQbX5HpRqM0Wx+YuSYt7OBqGoH798mBzcUYCJ4+66RW036ApTtvVOU0tLy/n6YxTFRdGFqmeul/c03ZVvtQbVPeOFt5Xm4u4wCopd5zbp6jepWMJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757586245; c=relaxed/simple;
	bh=l83JyltFbxLN9ZdpMJJt8oCqrMGADRRAdA3f1EVdvj8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GTzPk85iKhUZlzXovbWrGhkg4Pu8B0NM1tGsx6NtcC4Ml0uWJJ3fvb1+km32PmZrrZnVKGe6DnUoJcAD4ybEmY3Nltcc7703b3otLl17kq8jD2M1zjcbo+MkJxxoL65H4YZmkP9P0Vjrejfs6b6a/62s+3lPggmRsQFcuZKugLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TNbyJizt; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757586244; x=1789122244;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=l83JyltFbxLN9ZdpMJJt8oCqrMGADRRAdA3f1EVdvj8=;
  b=TNbyJiztY1vx1Wv34UUr0b0ma7xQgc7p6Z6IVk5IRcZA9+udhbjf47IE
   ZV3NqAU1oj8H6mDEYfYRsWoG83qFz7dzBvzYlHP2X+uHZo1C7NUWdC+Br
   8CYHfR6t/tkR4uWB+j/SrFpFKp1uuuI1020uNevBv1aTWHiVvkwXjyPuZ
   UlDjmrLWFMFtBMj5Ewc4BxEwhkaNC6TybrqtAvMm/PeEAFndx+/8qwaVx
   EBgETazi9RRvwxNS9B5w+DI66LMRJg+tVZOqXYLIWYWAd4EEolK+fgSwM
   bJgoegkaNWhXmgwF8TGJPHK1XGoK3zrmNj2BAstYCQHvSpHoZQgANsI0s
   g==;
X-CSE-ConnectionGUID: Dap+xi0AQ+6K3TgfMg1nBA==
X-CSE-MsgGUID: zjdKUkymRN6/sFIeWDLYSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11549"; a="71013894"
X-IronPort-AV: E=Sophos;i="6.18,257,1751266800"; 
   d="scan'208";a="71013894"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 03:24:03 -0700
X-CSE-ConnectionGUID: VwNRGGacSSin4IlJYcsbww==
X-CSE-MsgGUID: TAgzjslaRlu/9yo2/yeF2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,257,1751266800"; 
   d="scan'208";a="178846753"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.246.136])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 03:23:58 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Linux Doc Mailing List
 <linux-doc@vger.kernel.org>, =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,
 Alex Gaynor <alex.gaynor@gmail.com>, Alice Ryhl <aliceryhl@google.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, Trevor
 Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v4 08/19] tools/docs: sphinx-build-wrapper: add a
 wrapper for sphinx-build
In-Reply-To: <20250910145926.453f5441@foz.lan>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <cover.1756969623.git.mchehab+huawei@kernel.org>
 <e019f951190a732f9ac0b21bcda7e49af3bd5cbd.1756969623.git.mchehab+huawei@kernel.org>
 <e13837a0ac46dffe39c600d11fdf33f538bdc9c3@intel.com>
 <20250910145926.453f5441@foz.lan>
Date: Thu, 11 Sep 2025 13:23:55 +0300
Message-ID: <45888ca6c88071c754784495b4ef69460ea67b4f@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, 10 Sep 2025, Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> Em Wed, 10 Sep 2025 13:46:17 +0300
> Jani Nikula <jani.nikula@linux.intel.com> escreveu:
>
>> On Thu, 04 Sep 2025, Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
>> > There are too much magic inside docs Makefile to properly run
>> > sphinx-build. Create an ancillary script that contains all
>> > kernel-related sphinx-build call logic currently at Makefile.
>> >
>> > Such script is designed to work both as an standalone command
>> > and as part of a Makefile. As such, it properly handles POSIX
>> > jobserver used by GNU make.
>> >
>> > On a side note, there was a line number increase due to the
>> > conversion:
>> >
>> >  Documentation/Makefile          |  131 +++----------
>> >  tools/docs/sphinx-build-wrapper |  293 +++++++++++++++++++++++++++++++
>> >  2 files changed, 323 insertions(+), 101 deletions(-)
>> >
>> > This is because some things are more verbosed on Python and because
>> > it requires reading env vars from Makefile. Besides it, this script
>> > has some extra features that don't exist at the Makefile:
>> >
>> > - It can be called directly from command line;
>> > - It properly return PDF build errors.
>> >
>> > When running the script alone, it will only take handle sphinx-build
>> > targets. On other words, it won't runn make rustdoc after building
>> > htmlfiles, nor it will run the extra check scripts.  
>> 
>> I've always strongly believed we should aim to make it possible to build
>> the documentation by running sphinx-build directly on the
>> command-line. Not that it would be the common way to run it, but to not
>> accumulate things in the Makefile that need to happen before or
>> after. To promote handling the documentation build in Sphinx. To be able
>> to debug issues and try new Sphinx versions without all the hacks.
>
> That would be the better, but, unfortunately, this is not possible, for 
> several reasons:
>
> 1. SPHINXDIRS. It needs a lot of magic to work, both before running
>    sphinx-build and after (inside conf.py);

Makes you wonder if that's the right solution to the original
problem. It was added as a kind of hack, and it stuck.

> 2. Several extensions require kernel-specific environment variables to
>    work. Calling sphinx-build directly breaks them;

The extensions shouldn't be using environment variables for
configuration anyway. Add config options and set them in conf.py like
everything else?

> 3. Sphinx itself doesn't build several targets alone. Instead, they create
>    a Makefile, and an extra step is needed to finish the build. That's 
>    the case for pdf and texinfo, for instance;

That's not true for the Makefile currently generated by
sphinx-quickstart. Granted, I haven't used Sphinx much for pdf output.

> 4. Man pages generation. Sphinx support to generate it is very poor;

In what way?

> 5. Rust integration adds more complexity to the table;
>
> I'm not seeing sphinx-build supporting the above needs anytime soon,
> and, even if we push our needs to Sphinx and it gets accepted there,
> we'll still need to wait for quite a while until LTS distros merge
> them.

I'm not suggesting to add anything to Sphinx upstream.

>> This patch moves a bunch of that logic into a Python wrapper, and I feel
>> like it complicates matters. You can no longer rely on 'make V=1' to get
>> the build commands, for instance.
>
> Quite the opposite. if you try using "make V=1", it won't show the
> command line used to call sphinx-build anymore.
>
> This series restore it.
>
> See, if you build with this series with V=1, you will see exactly
> what commands are used on the build:
>
> 	$ make V=1 htmldocs
> 	...
> 	python3 ./tools/docs/sphinx-build-wrapper htmldocs \
> 	        --sphinxdirs="." --conf="conf.py" \
>         	--builddir="Documentation/output" \
> 	        --theme= --css= --paper=
> 	python3 /new_devel/docs/sphinx_latest/bin/sphinx-build -j25 -b html -c /new_devel/docs/Documentation -d /new_devel/docs/Documentation/output/.doctrees -D kerneldoc_bin=scripts/kernel-doc.py -D version=6.17.0-rc1 -D release=6.17.0-rc1+ -D kerneldoc_srctree=. /new_devel/docs/Documentation /new_devel/docs/Documentation/output
> 	...
>
>
>
>> Newer Sphinx versions have the -M option for "make mode". The Makefiles
>> produced by sphinx-quickstart only have one build target:
>> 
>> # Catch-all target: route all unknown targets to Sphinx using the new
>> # "make mode" option.  $(O) is meant as a shortcut for $(SPHINXOPTS).
>
> I didn't know about this, but from [1] it sounds it covers just two
> targets: "latexpdf" and "info".

sphinx-build -M help gives a list of 24 targets.

> The most complex scenario is still not covered: SPHINXDIRS.
>
> [1] https://www.sphinx-doc.org/en/master/man/sphinx-build.html
>
>> %: Makefile
>>         @$(SPHINXBUILD) -M $@ "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)
>> 
>> That's all.
>
> Try doing such change on your makefile. it will break:
>
> 	- SPHINXDIRS;
> 	- V=1;
> 	- rustdoc

I know it does. That's the problem.

> and will still be dependent on variables that are passed via
> env from Kernel makefile. So, stil you can't run from command
> line. Also, if you call sphinx-build from command line:
>
> 	$ sphinx-build -j25 -b html Documentation Documentation/output
> 	...
> 	      File "<frozen os>", line 717, in __getitem__
> 	    KeyError: 'srctree'
>
> It won't work, as several parameters that are required by conf.py and by
> Sphinx extensions would be missing (the most important one is srctree, but
> there are others in the line too).
>
>> The proposed wrapper duplicates loads of code that's supposed to be
>> handled by sphinx-build directly.
>
> Once we get the wrapper, we can work to simplify it, but still I
> can't see how to get rid of it.

I just don't understand the mentality of first adding something complex,
and then working to simplify it.

Don't make it a Rube Goldberg machine in the first place.

>> Including the target/builder names.
>
> True, but this was a design decision taken lots of years ago: instead
> of:
> 	make html
>
> we're using:
>
> 	make htmldocs
>
> This series doesn't change that: either makefile or the script need
> to tho the namespace conversion.

In the above Makefile snippet that conversion would be $(@:docs=)

The clean Makefile way of checking for having Sphinx and the required
versions of Python and dependencies etc. would be a .PHONY target that
just checks, and doesn't do *anything* else. It shouldn't be part of the
sphinx-build rules.

PHONY += check-versions
check-versions:
	sphinx-pre-install --version-check

htmldocs: check-versions
	...

Or something like that.

>> Seems to me the goal should be to figure out *generic* wrappers for
>> handling parallelism, not Sphinx aware/specific.
>> 
>> 
>> BR,
>> Jani.

-- 
Jani Nikula, Intel

