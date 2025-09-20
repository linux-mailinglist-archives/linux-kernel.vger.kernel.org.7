Return-Path: <linux-kernel+bounces-825597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE3A4B8C4BE
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 11:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA96D4670AA
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 09:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98842296BA7;
	Sat, 20 Sep 2025 09:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BLOtVyj4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC7126D4EB;
	Sat, 20 Sep 2025 09:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758361009; cv=none; b=IAmeSB4e89qAbc2eyg5GcGBpb4g2WoCGvdGdAwmPPr9CJkh4pbpyZsZJ7SC3oldYUrOLFkj1+lGAV6DCV+uEB+v3PUjGsng1SNrjVyV+9MPMO04ZP5qmwuv043g5OkNrSsA0+8PWw2+KEhtdlmZEjSYgiJaXiJLZlSp+OJMACSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758361009; c=relaxed/simple;
	bh=ioK/g2FFEI+gdbItPz3WVvnNTK2pU8RZwhRi41dmYSw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dwetq6ry+TEm24oiQYfn48hVJuwYLPkPTwZl18UWBuCdOnfy4R5yFHdStLHbc5ZOYZd8VCI5NbELOkqYNFGGMnVI37PHquGWMvvb3WZ43GEMFj3M2rreLsEHsVoAhM0easa3kBZmsx0uRfZKxtxNjVvq87R+QGKfCyfE+rGDUl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BLOtVyj4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD725C4CEEB;
	Sat, 20 Sep 2025 09:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758361008;
	bh=ioK/g2FFEI+gdbItPz3WVvnNTK2pU8RZwhRi41dmYSw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BLOtVyj4wCwPDI9nzN5gZAFdCantdboLMD41sk+sTEBfYmAgliAgLIP5omhFSaPw3
	 zAzfqSoJWhtSdOd2Mg4Ez7wjbNcrkgaVPkVS1SjyJfeJkMH31Ne5hJcmqxmynsJSXr
	 PISlfdyReDXEMNtwpBhCOLbx+E0f2LIS5PyctHBpYXsncZj5PTr6k+YHkUTWrQeWmV
	 tDyWMQynUGVFeNAXzJM3bNVje1eA3/fq4ktPGIQpF2nAcukUaTImiYjNAwmoS4Gj9b
	 q4u8dmsiX8ZNqE8k3lRM+VesUA4oHs1H9Aq4NIh+Ubsxvx6vGZwO6ZUKpLdQUQdXN5
	 jzfyR3DfpNSxg==
Date: Sat, 20 Sep 2025 11:36:44 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] docs: conf.py: get rid of load_config.py
Message-ID: <20250920113644.67194409@foz.lan>
In-Reply-To: <87plbmqg0f.fsf@trenco.lwn.net>
References: <cover.1758294450.git.mchehab+huawei@kernel.org>
	<65ce87136d8f4a74e88e956a3a5bc3ba9a528be4.1758294450.git.mchehab+huawei@kernel.org>
	<87plbmqg0f.fsf@trenco.lwn.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Fri, 19 Sep 2025 15:38:56 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
> 
> > The code here was meant to handle 3 functions:
> > 1. allow having a separate conf.py file, per subdir;
> > 2. generate a list of latex documents.
> > 3. set "subproject" tag if SPHINXDIRS points to a subdir.
> >
> > We don't have (1) anymore, and (3) is now properly handled
> > entirely inside conf.py.
> >
> > So, only (3) is still needed, and this is a single-line change
> > at conf.py.
> >
> > So, drop it, moving the remaining code to conf.py.
> >
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >  Documentation/Makefile              |  4 --
> >  Documentation/conf.py               | 15 +++-----
> >  Documentation/sphinx/load_config.py | 60 -----------------------------
> >  3 files changed, 5 insertions(+), 74 deletions(-)
> >  delete mode 100644 Documentation/sphinx/load_config.py
> >
> > diff --git a/Documentation/Makefile b/Documentation/Makefile
> > index 6ccd5db1dcbd..9663e7a31feb 100644
> > --- a/Documentation/Makefile
> > +++ b/Documentation/Makefile
> > @@ -24,7 +24,6 @@ SPHINXDIRS    = .
> >  DOCS_THEME    =
> >  DOCS_CSS      =
> >  RUSTDOC       =
> > -SPHINX_CONF   = conf.py
> >  PAPER         =
> >  BUILDDIR      = $(obj)/output
> >  PDFLATEX      = xelatex
> > @@ -108,9 +107,6 @@ dochelp:
> >  	@echo  '  make SPHINXDIRS="s1 s2" [target] Generate only docs of folder s1, s2'
> >  	@echo  '  valid values for SPHINXDIRS are: $(_SPHINXDIRS)'
> >  	@echo
> > -	@echo  '  make SPHINX_CONF={conf-file} [target] use *additional* sphinx-build'
> > -	@echo  '  configuration. This is e.g. useful to build with nit-picking config.'
> > -	@echo
> >  	@echo  '  make DOCS_THEME={sphinx-theme} selects a different Sphinx theme.'  
> 
> So probably I'm a little slow today, but this confuses me.  Even after
> this change, the makefile still uses SPHINX_CONF, so I'm not sure how it
> is supposed to be set?

Heh, incomplete patch, sorry for that. I'll send a v2 of this series.


Thanks,
Mauro

