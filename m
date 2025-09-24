Return-Path: <linux-kernel+bounces-830271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1142B99419
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 11:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 949662E3A81
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 09:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E572D97BA;
	Wed, 24 Sep 2025 09:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WiAxhADm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FB215624D;
	Wed, 24 Sep 2025 09:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758707748; cv=none; b=GpcG2sHHmESDZzMd3TEhf/QSH8Exr4pnvZ6LkBBP9J6ixSC849GvaRtibP4ySyYVAjmuXNkVvA9B7aJeP6pjt93UulCKQy/3Ste5yIeTfbn0hyAje8QP8Gqcx1Q/6iJMldSQvH1TZUuMqxGpsitMK0mtVK9eeihnb9hEH9Hgkck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758707748; c=relaxed/simple;
	bh=UUAu91fqE7Xy+Ic5qqO/lBwhANClBj2Kose+b7QgGXU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B9B29jlnhjbk13HFraqNR8cjPUDDvCH/rNnx+8RgHLSp2pFaTPA3x8VYJjUN86GGCMvsKkVP4aUWneKDKpVb0O3m7jVdu0oNvsSGzXS9Jh+r1Tv/lfFV5ZkD9rSn1DiKts7z+PCBfjNEz6ibrrZH6B/ZNeGmBUv9BVSz8D6c4PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WiAxhADm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E06BC113CF;
	Wed, 24 Sep 2025 09:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758707747;
	bh=UUAu91fqE7Xy+Ic5qqO/lBwhANClBj2Kose+b7QgGXU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WiAxhADmRH5h6BxFh77wdClx1nAYWa2Jdr+NzS98WMD5E0pWckUTqUCJHkAsnSvWK
	 jHp6NnXGexxytU1U2mnWEHGKGoZJYq7no7w4nOUuLgoUldL6PnuF5u2MHEM/LYRew/
	 M99S0zbiwkaNf/1C6ZDqlrXbxuUKsj69kKzzNvA9ZbXHU0ahY21SZyE14a+bOjae5D
	 HvQKalVI6+KW+UHPMVw0oloHL5UqGmHJqYcO0bjuJbngBVwQQjOZFr6M/hUAONlXsy
	 iGXy6fPeY3EUWicIubcS2wDHQzfF0HyaoLXgciU3iPtmqufBuCOOMvD9x7LnZy50Jw
	 BYdsF9jQF7Hng==
Date: Wed, 24 Sep 2025 11:55:43 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Akira Yokosawa <akiyks@gmail.com>
Cc: linux-kernel@vger.kernel.org, Linux Doc Mailing List
 <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 0/1] sphinx-build-wrapper: add support for skipping
 sphinx-build
Message-ID: <20250924115543.49433321@foz.lan>
In-Reply-To: <e76e4f31-dc95-4d79-a922-7f7d1b68417f@gmail.com>
References: <cover.1758444913.git.mchehab+huawei@kernel.org>
	<f31c2169-cd0e-438a-9e59-d6ebd8eaea6e@gmail.com>
	<20250922142330.7a654919@foz.lan>
	<e76e4f31-dc95-4d79-a922-7f7d1b68417f@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Wed, 24 Sep 2025 16:03:59 +0900
Akira Yokosawa <akiyks@gmail.com> escreveu:

> On Mon, 22 Sep 2025 14:23:30 +0200, Mauro Carvalho Chehab wrote:
> > Em Mon, 22 Sep 2025 20:30:40 +0900
> > Akira Yokosawa <akiyks@gmail.com> escreveu:
> >   
> >> On Sun, 21 Sep 2025 11:13:24 +0200, Mauro Carvalho Chehab wrote:  
> >>> Hi Jon,
> >>>
> >>> This patch adds support for not running sphinx-build at the wrapper
> >>> tool. It was requested by Akira, who wanted to be able to ignore
> >>> Sphinx errors during latex build and still try to build PDF.    
> >>
> >> Thank you for trying to figure out my intention.
> >> However, you failed to see the point.
> >>  
> >>>
> >>> This patch is against docs/build-script and applies after the 3 patch
> >>> series I sent yesterday:
> >>>
> >>>     https://lore.kernel.org/linux-doc/cover.1758361087.git.mchehab+huawei@kernel.org/
> >>>
> >>>
> >>> While Akira's original intention is to have pdfdocs target depend on
> >>> latexdocs, IMO, this is overkill, as probably only Akira and a couple
> >>> of other developers might want to have such behavior.    
> >>
> >> I think it is only you who don't want such behavior.  
> > 
> > Whom else wants to use "make -i" to skip failed latexdocs build and
> > still do pdf builds? For what reason?  
> 
> Hmm, looks like you were suffered from context mismatch.
> 
> My message you tried to understand (archived at:
> 
>     https://lore.kernel.org/5031e0c4-f17e-41b8-8955-959989e797f2@gmail.com/
> 
> ) started this way:
> 
>     Hi, (just got v8, but sending anyway ...),
> 
> , and the message assumed the "make pdfdocs" behavior of v7.
> 
> At the time, I thought it was what you had intended and it looked as though
> you wanted latexmk/xelatex to continue running as much as possible ignoring
> any intermediate errors.

No, this was a bug, as I answered you already and sent the fix:
if sphinx-build fails, the script shall bail out.

> You have since fixed the missed exception handling at the latexdocs phase,
> but your rapid respins of this series simply overwhelmed me and I have
> failed to see "make pdfdocs" now gives up at latexdocs error.
> 
> My intention of mentioning GNU Make's options of -i, -k, etc. in the message
> was to show you that the make--sub-make scheme is so flexible and it can
> even emulate the buggy behavior of then sphinx-build-wrapper.
> 
> In normal cases, I won't use any of those options.
> But as a human developer, I sometimes use them when I observe build errors
> somewhere in "make pdfdocs".
...
> >> All I want is to restore the current behavior, without any need to
> >> use such an ad-hoc script.  
> > 
> > Huh?
> > 
> > You said you want to be able to do just the reverse: to ignore
> > failures at latex build ("make -i").  
> 
> No, as I said above, I don't want it in most cases.
> But in rare occasions, I might want it.  That depends on the situation
> at hand.

There is exactly the usecase where running directly via makefile
may not be enough, as you may want to play with different scenarios.

On such cases, you'll be better served by calling the script directly, 
as it provides more flexibility without requiring to pass parameters via
env vars nor nor enable/disable different venvs to test with different
versions of docutils/spinx packages.

On an hypothetical scenario where pdfdocs is not working fine, calling
the script directly allows to easily test different scenarios, and it is
faster, as you won't do anything else but running directly the doc build
logic:

	# equivalent to "make pdfdocs":
	# build tex. If sphinx-build succeeds, build pdf for each tex
	./tools/docs/sphinx-build-wrapper pdfdocs

	# equivalent to "make latexdocs"
	./tools/docs/sphinx-build-wrapper latexdocs

	# generate latex with Sphinx 3.4.3 in verbose mode
	# equivalent to:
	#	. Sphinx_3.4.3/bin/activate
	#	make V=1 latexdocs
	#	deactivate
	./tools/docs/sphinx-build-wrapper latexdocs -V Sphinx_3.4.3 -v

	# build only translations.tex with Sphinx 5.2.0 in verbose mode
	./tools/docs/sphinx-build-wrapper latexdocs -V Sphinx_5.2.0 -v --sphinxdirs translations

Once you're happy with the above, you could proceed with the pdf build step,
forcing the script to skip sphinx-build step with:

	# Run just PDF build step, producing a summary at the end
	$ ./tools/docs/sphinx-build-wrapper pdfdocs  -s -v
	...
	Summary
	=======
	...
	translations/pdf/translations.pdf: FAILED
	...

	# After building latexdocs for translations.tex and core-api.tex
	# run the run test PDF build, producing a single line
	# with all failures for each generated .tex file:
	$ ./tools/docs/sphinx-build-wrapper pdfdocs  -s  --sphinxdirs translations core-api
	...
	Error: Can't build 1 PDF file(s): translations/pdf/translations.pdf

	# Use a different variable font deny configuration directory
	$ ./tools/docs/sphinx-build-wrapper pdfdocs  -s  --sphinxdirs translations --deny-vf ~/new-deny-vf/
	
> >> Furthermore, your "cleanup" is obfuscating the very fact that "pdfdocs"
> >> needs a successful "latexdocs" stage.
> >>
> >> I believe Documentation/Makefile is the right place to describe it.  
> > 
> > If you want to propose such change, be my guest. As I said, *I* won't propose
> > it, as IMO it is a bad idea, but if you want, feel free to submit a patch 
> > after this one similar to:
> > 
> > 	-htmldocs mandocs infodocs texinfodocs latexdocs epubdocs xmldocs pdfdocs linkcheckdocs:
> > 	+htmldocs mandocs infodocs texinfodocs latexdocs epubdocs xmldocs linkcheckdocs:
> > 	+
> > 	+pdfdocs: latexdocs
> > 	+        +$(Q)$(PYTHON3) $(BUILD_WRAPPER) $@ -s \
> > 	+                --sphinxdirs="$(SPHINXDIRS)" \
> > 	+                --builddir="$(BUILDDIR)" --deny-vf=$(FONTS_CONF_DENY_VF) \
> > 	+                --paper=$(PAPER)
> > 
> > and let's discuss its pros/cons in separate.  
> 
> OK. This looks like the way forward to me.
> 
> I'll prepare a patch (set) and submit it after v6.18-rc1.

Ok, but as I said, IMO we're better served running the script
directly while debugging issues.

> In the meantime, I think we might be better off if we could root-cause
> the "latexmk bug" you repeatedly claimed you had observed, without providing
> any steps to reproduce.

This is on my todo list. 

With regards to the steps to reproduce you need to remove this from make:

	|| sh $(srctree)/scripts/check-variable-fonts.sh || exit

to ensure that errors will be handled by make.

As we depend on error handling logic, it means that you may need to build docs
with different configurations, different types of latex errors produced by
sphinx-build, and test with different versions of docutils, sphinx, xelatex and
latexmk, and hope to have a .tex file that has errors but still generate .pdf. 

Getting such issues is time consuming and it needs a certain amount of luck
to catch it, as you depend on changes at the *.rst files that will produce
a .tex file with the exact amount of spicy to produce such behavior.

With me, it only happens when I don't want it to happen ;-)

-

Another option would be to try to manually generate a defective *.tex file
that doesn't produce a critical error but still generates a.pdf output when
xelatex is called by hand.

Anyway, this requires a calm week where you don't have anything else
to do, and you're prepared to waste several hours trying to pick the
hot spot on away that it would be reproducible by others.

So, this has low priority.

> Let me continue in another thread.
> It would be far more interesting for me to (try to) figure out what you
> had observed.
> 
> Thanks,
> Akira
> 



Thanks,
Mauro

