Return-Path: <linux-kernel+bounces-827193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9554DB911A3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 14:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70CA17A11DD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 12:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11DE530648D;
	Mon, 22 Sep 2025 12:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UqIN8KiB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FB927B516;
	Mon, 22 Sep 2025 12:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758543815; cv=none; b=SfEIeitR4+QoSoGgVIVIvfGyBW5roQdfcHRbOygfUU3J0/d8IeT8gF7DuIa5gPEy76PHOuJ/VlNZxBqQsrgyY47LwSBbeOQyz1UiGjJHLE98ntyWZT5iXik1zzIl530nj/6fAPsjkPgRV08DDF3XBMDzx1YxQI7KkMxgPJ2W2lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758543815; c=relaxed/simple;
	bh=hQOEH2/WkuCSldegZsmsmHaiQ4zSV6xULfl4GRnZw9o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IJ469cIdTLFd/zQI5jn9VV+cUh6A69x17HaC3//1E8ls39T1Ub0gemS2l8PiYasxObkEFbA20bW4712z2f26asRgC6S/OaEjDkYQib2zzuivIYvqJbYjVYPx6zMU4sW6Kgs2LdyeUZ/AqpqbyFKzFcN1V8VGumCif1ljytzFS48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UqIN8KiB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5391C4CEF0;
	Mon, 22 Sep 2025 12:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758543814;
	bh=hQOEH2/WkuCSldegZsmsmHaiQ4zSV6xULfl4GRnZw9o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UqIN8KiBC222WP9aNAwoXUBk6nmDWcjQu3ZfKj6Zzk/cAhZECmjn1QYW73aFji3GO
	 nMswLzDScPh1emi6zJIu+JCMYD51GNlZZyDpKXJaREeKza0Vl6+UBEWuVXC88idA/g
	 mgkOXnGEcP4taevow2+Hh/zNmcKDfS/hO4TrZB+5t7ldp1pHbW1rgL6rW4A94ECSlB
	 zUCyDNIaXlXyXP4q285HoJsW7nXDVsa4ogRK5Kp6YoTDE9FUs0PDspS/erLhogyxHF
	 NDPJofDsKUxWfMmnx7L7WHpeMQWQxa8kumadP6guVTgRgzgOmspF+9QkmcAZy2m5cb
	 VXVKkNCzNUUkg==
Date: Mon, 22 Sep 2025 14:23:30 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Akira Yokosawa <akiyks@gmail.com>
Cc: linux-kernel@vger.kernel.org, Linux Doc Mailing List
 <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 0/1] sphinx-build-wrapper: add support for skipping
 sphinx-build
Message-ID: <20250922142330.7a654919@foz.lan>
In-Reply-To: <f31c2169-cd0e-438a-9e59-d6ebd8eaea6e@gmail.com>
References: <cover.1758444913.git.mchehab+huawei@kernel.org>
	<f31c2169-cd0e-438a-9e59-d6ebd8eaea6e@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Mon, 22 Sep 2025 20:30:40 +0900
Akira Yokosawa <akiyks@gmail.com> escreveu:

> On Sun, 21 Sep 2025 11:13:24 +0200, Mauro Carvalho Chehab wrote:
> > Hi Jon,
> > 
> > This patch adds support for not running sphinx-build at the wrapper
> > tool. It was requested by Akira, who wanted to be able to ignore
> > Sphinx errors during latex build and still try to build PDF.  
> 
> Thank you for trying to figure out my intention.
> However, you failed to see the point.
> 
> > 
> > This patch is against docs/build-script and applies after the 3 patch
> > series I sent yesterday:
> > 
> >     https://lore.kernel.org/linux-doc/cover.1758361087.git.mchehab+huawei@kernel.org/
> > 
> > 
> > While Akira's original intention is to have pdfdocs target depend on
> > latexdocs, IMO, this is overkill, as probably only Akira and a couple
> > of other developers might want to have such behavior.  
> 
> I think it is only you who don't want such behavior.

Whom else wants to use "make -i" to skip failed latexdocs build and
still do pdf builds? For what reason?

> > See, after all changes, the makefile rule for *all* doc build targets
> > is simple:
> > 
> >         $(Q)@$(srctree)/tools/docs/sphinx-pre-install --version-check
> >         +$(Q)$(PYTHON3) $(BUILD_WRAPPER) $@ \
> >                 --sphinxdirs="$(SPHINXDIRS)" $(RUSTDOC) \
> >                 --builddir="$(BUILDDIR)" --deny-vf=$(FONTS_CONF_DENY_VF) \
> >                 --theme=$(DOCS_THEME) --css=$(DOCS_CSS) --paper=$(PAPER)
> > 
> > After applying patch 1 from this series, it is really easy to replicate 
> > "make -i" by writing a small script that does:
> > 
> > 	tools/docs/sphinx-pre-install --version-check	
> > 	tools/docs/sphinx-build-wrapper latexdocs || echo "LaTeX build failed, but we'll try build PDF anyway"
> > 	tools/docs/sphinx-build-wrapper -s pdfdocs
> >   
> 
> Hello?
> 
> You are the one who is changing the way "make pdfdocs" behaves.

It doesn't change. if latex is not built, it won't try to build
PDF files, just like before.

See, for almost all targets, docs build is a two-step procedure. That
includes htmldocs as well, as it requires a post-build step to copy
css and static files. Right now, the logic is hidden inside complex
make macros.

The new logic place the target-dependent extra steps on separate functions
which are now properly documented, executing them only if the first
step works.

With the "-s" parameter, one can skip the first step, running only
the second one.

> All I want is to restore the current behavior, without any need to
> use such an ad-hoc script.

Huh?

You said you want to be able to do just the reverse: to ignore
failures at latex build ("make -i").  If you want to have exactly
the same behavior, you don't need anything.

> Sorry, but I think I have to NAK this.
> 
> Furthermore, your "cleanup" is obfuscating the very fact that "pdfdocs"
> needs a successful "latexdocs" stage.
> 
> I believe Documentation/Makefile is the right place to describe it.

If you want to propose such change, be my guest. As I said, *I* won't propose
it, as IMO it is a bad idea, but if you want, feel free to submit a patch 
after this one similar to:

	-htmldocs mandocs infodocs texinfodocs latexdocs epubdocs xmldocs pdfdocs linkcheckdocs:
	+htmldocs mandocs infodocs texinfodocs latexdocs epubdocs xmldocs linkcheckdocs:
	+
	+pdfdocs: latexdocs
	+        +$(Q)$(PYTHON3) $(BUILD_WRAPPER) $@ -s \
	+                --sphinxdirs="$(SPHINXDIRS)" \
	+                --builddir="$(BUILDDIR)" --deny-vf=$(FONTS_CONF_DENY_VF) \
	+                --paper=$(PAPER)

and let's discuss its pros/cons in separate.

Thanks,
Mauro

