Return-Path: <linux-kernel+bounces-771088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B82C7B282BD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 17:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A00A5600BAC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 15:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C9528D83C;
	Fri, 15 Aug 2025 15:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cO1BcfT6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609271DF74F;
	Fri, 15 Aug 2025 15:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755270828; cv=none; b=lNjLSlMC2LkDUhmaLpbjNM78RKFcLgQI2vEvhjtVssZedu8dZz0g+Iq7qVvlSmhO+LvXVtDiQ75rTTHPIw9BoA3c8DVOtS/IIa4AikczZAahFDkF+Oir+a2wqJ8biSrRgA+lFe1tlu0MojVBSxT1EDZiHoU17AacL7uzGNze0V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755270828; c=relaxed/simple;
	bh=hJXi1G/2DDX26dlfONr9YP14Wi8XXTZLeCuptxBz6l0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZZHGUtjoURObmQjhw+3lQzK5xGbkmC0FN3WV45EWzyAc6WwR9SLVt6fVGzQNfp3d2cdZjViesnVcWpiZEXiyfHEo8g4n3mSi4nlcevgxGMvlCN5MCm1K6fGlsGOcTuozujUkg6Ifqgjy/C1qXSKjKA7CSahnOs7GnRpdB1nC1Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cO1BcfT6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89A22C4CEEB;
	Fri, 15 Aug 2025 15:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755270827;
	bh=hJXi1G/2DDX26dlfONr9YP14Wi8XXTZLeCuptxBz6l0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cO1BcfT6Q+c/NZXGxkZWETzFcyerM3bQZGY2oy7jUbO1xJiHbm9pZraY+T8pbWISV
	 HmDLWlTsCPfae+l8GgQKEH96pc3dEzfFTeTQ4AwZ/ihbTy2CtUHlWaKH2mVsJPY9h5
	 UnhuZzoidkx5qtaSvElR6tXfH3sbGnqdWB8jshq2Zwwm4l9xNzNq2/ns4OK5Iu+iqe
	 52tRe7Guyg4ZngbYiWnKYAtFogl7emFBLGbDA3NVbzK4XcohU9ucj/wJslP7Fb0rFz
	 IeaCjuDcMhLbvrCUIp0BcOOcrNwmPdRzP1AKiiyxQECEddD6HsR9/Lged4ZM+odfGl
	 e19vLHizPscmg==
Date: Fri, 15 Aug 2025 17:13:42 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 07/13] docs: move sphinx-pre-install to tools/doc
Message-ID: <20250815171342.3006f30a@sal.lan>
In-Reply-To: <87sehsen9g.fsf@trenco.lwn.net>
References: <20250813213218.198582-1-corbet@lwn.net>
	<20250813213218.198582-8-corbet@lwn.net>
	<20250814013600.5aec0521@foz.lan>
	<871ppehcod.fsf@trenco.lwn.net>
	<20250814080539.2218eb4e@foz.lan>
	<87wm76f1t5.fsf@trenco.lwn.net>
	<20250815071829.3d5163fc@foz.lan>
	<87sehsen9g.fsf@trenco.lwn.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Fri, 15 Aug 2025 07:18:51 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
> 
> >> Between "tools/doc" and "tools/docs" I don't really have overly strong
> >> feelings; if you work has the latter we can just stick with that.  If
> >> you propose "tools/Documentation", though, expect resistance :)  
> >
> > <joke>
> > Heh, I'm tempted to propose:
> > 	/Documentation -> /docs
> > or
> > 	/Documentation -> /Docs
> > </joke>  
> 
> I proposed the former at a maintainers summit a few years ago ... the
> response was less than fully positive.  I guess the fact that docs have
> the longest and only capitalized top-level directory name shows their
> relative importance :)

:-)

> > Ok, so let's keep tools/docs then. We need to decide about python
> > lib. On my series, I'm placing at tools/docs/lib, but I guess we
> > can change it later.
> >
> > From my side, I would prefer to have a single directory for tools,
> > as we may place there things that aren't specific to docs.
> >
> > For instance, I have my own class that I use for command execution,
> > using asyncio. The rationale is that it allows output messages in
> > real time without needing to wait for the entire process to end(*).
> >
> > (*) I recently discovered a way to do that without needing asyncio,
> >     which makes the code a little bit simpler.  
> 
> This is just flushing the output buffer?  Asyncio seems like a heavy
> tool for that; I guess I'm missing something.

Yes, flushing output as they arrive while storing results from stdout and
stderr and handling  "stdin", eventually dynamically printing stdin when
debug is enabled. The problem sounds simple, and this is really easy to
implement in Perl. However, on Python, this ends to be a very complex
problem that one can only get all the caveats after implementing unit 
tests and then discovering, for instance, that, if stdin is bigger than 
32KB, Python read logic freezes forever (or until gather() timeout, and
the stdin was incomplete.

To fix it, one needs to implement a different stdin function that can't
wait anymore for the end of a read operation, but instead needs to pick
buffers in small chunks. Plus, the subprocess execution method requires
some unusual buffering parameters.
 
> > Either using asyncio or not, a class for such purpose is something
> > that multiple tools could use. So, a generic dir like tools/lib, 
> > lib/python, ... IMO makes sense.  
> 
> I agree with this, anyway.  "tools/python" might end up as the winning
> suggestion. 
> 
> >> As I said, my series was an RFC to see what it would look like; it did't
> >> take all that long the first time around, and will be even quicker to
> >> redo on top of a new base, whatever that turns out to be.  
> >
> > With regards to the RFC, IMO we still may need to discuss how we'll end 
> > placing libraries under a LIBDIR. IMO, your RFC should also propose
> > a directory structure. I mean, we could have something like:
> >
> > 	LIBDIR     # either tools/docs/lib, tools/lib, lib/python or whatever
> > 	|
> > 	+---> common
> > 	\---> docs
> > 		|
> > 	    	+---> kdoc
> > 	    	\---> abi
> >
> > We could instead do:
> > 	- flatten "common" to LIBDIR; or:
> > 	- flatten "docs" to LIBDIR; or:
> > 	- flatten both but keeping kdoc, abi, ... directories inside
> > 	  LIBDIR; or:
> > 	- have a completely flatten directory with everything
> > 	  under LIBDIR.  
> 
> I'm not sure we need the common/docs intermediate directory.
> 
> Meanwhile, I had a related, possibly unpopular idea...  Start with
> .../tools/python/kernel and put a basic __init__.py file there;
> everything else would go into that directory or before.  The imports
> would then read something like:
> 
>   from kernel import abi_parser

Not against something similar to it, but IMO "kernel" is a bad
name as it sounds something that runs in kernel stace or for Kernel
build. It could be, instead:

	from lib import abi_parser

Yet, I guess it may still need to add something at PATH, depending from
where current working dir the script was called (but tests required).

For instance Documentation/sphinx would need to pick lib from
"../../tools/python". So, I guess Sphinx extensions need first to
do:

	sys.path.insert(0, "../../tools/python")

and then:

	from lib import abi_parser         # or:
	from lib.abi import abi_parser     # or:
	import .abi_parser


Btw, nothing prevents moving extensions from Documentation/sphinx
into tools/sphinx_extensions. We just need to add the path insert
at conf.py.

> That would make it clear which modules are ours and which come from
> elsewhere.
> 
> I was planning to toss together another RFC with that scheme, again to
> see what it would look like in practice.

> Thoughts?

Fine from my side.

Regards,
Mauro

