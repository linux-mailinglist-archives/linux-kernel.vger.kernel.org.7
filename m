Return-Path: <linux-kernel+bounces-825236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE4EB8B5F8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 23:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B45757E5536
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 21:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CEF82D24AD;
	Fri, 19 Sep 2025 21:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="UNxaMKr4"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55832D23A3;
	Fri, 19 Sep 2025 21:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758317952; cv=none; b=hTTfR3d62IoLJVVWtyBgULFqSZPbLceNIECeZWBHKx9udgAQUZ3JRxl2h7axbmXA1+yLxjRBHnWKHoburqF3B6e0lwElBuSVUHLvYlO6T44HBn1jfwGx36UMOK++A6ULpR3Ac9GC+cMshQidG5jpbkI0Q5XgxCqgTXvBOTURgJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758317952; c=relaxed/simple;
	bh=yC6ufSeRgSofQWCEsHV1eG+/X/yFGSFiTGiMlUZK9oA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KEy2WRY2jX7frFjncoJSthEWd8LPNUeepAOcC38lyTqH099YaQP9/HvtJwmVX8c31B+ylBmbO6i3MhejAO0CxV5Q+LxfGFj6YEsB1caklyWFtqZOmWNoCGEGghe1LnBdVG9lxbGLARP4aKqHK47G2ADFry/+bCb6sJvcajEAiZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=UNxaMKr4; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 3463540506
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1758317937; bh=q5xfT+dJBB4vYAefrW0ua3tMj03HWd5c2CXysHIkD0A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=UNxaMKr48DD/U3TzKSZqQLqhI7TcXA60As4v954moZ9LxaZymVbqSzzmhVtX8h6Sj
	 6F9OBtspiwUPtrFWoBJRqjuT8oBrlIquuguKuvr37QpEM2Ljks+fO9xeLWJuBeW3jg
	 JcSAbPiAun3HdoBepyEnbF3C1yGFi01T9zdpux6ZZtt2SDYCRt9rVbsYBp4NtrKQfO
	 HclZlShqQKe3yISBVNnWp0+M6lfL+ma8/e3mUT5uiU4uhV8t/wnr9bIABCYHunoT2b
	 NSBkFfsXuL5vSKEyNEgOUjP9+5LrfR9pAJVdH9ORk6LCz1K2bfKgBJv1SoG5ROU61i
	 F9KZ86ceC+UMA==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::824])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 3463540506;
	Fri, 19 Sep 2025 21:38:57 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Linux Doc Mailing
 List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Mauro Carvalho Chehab
 <mchehab+huawei@kernel.org>, Kees Cook <mchehab+huawei@kernel.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] docs: conf.py: get rid of load_config.py
In-Reply-To: <65ce87136d8f4a74e88e956a3a5bc3ba9a528be4.1758294450.git.mchehab+huawei@kernel.org>
References: <cover.1758294450.git.mchehab+huawei@kernel.org>
 <65ce87136d8f4a74e88e956a3a5bc3ba9a528be4.1758294450.git.mchehab+huawei@kernel.org>
Date: Fri, 19 Sep 2025 15:38:56 -0600
Message-ID: <87plbmqg0f.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> The code here was meant to handle 3 functions:
> 1. allow having a separate conf.py file, per subdir;
> 2. generate a list of latex documents.
> 3. set "subproject" tag if SPHINXDIRS points to a subdir.
>
> We don't have (1) anymore, and (3) is now properly handled
> entirely inside conf.py.
>
> So, only (3) is still needed, and this is a single-line change
> at conf.py.
>
> So, drop it, moving the remaining code to conf.py.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/Makefile              |  4 --
>  Documentation/conf.py               | 15 +++-----
>  Documentation/sphinx/load_config.py | 60 -----------------------------
>  3 files changed, 5 insertions(+), 74 deletions(-)
>  delete mode 100644 Documentation/sphinx/load_config.py
>
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index 6ccd5db1dcbd..9663e7a31feb 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -24,7 +24,6 @@ SPHINXDIRS    = .
>  DOCS_THEME    =
>  DOCS_CSS      =
>  RUSTDOC       =
> -SPHINX_CONF   = conf.py
>  PAPER         =
>  BUILDDIR      = $(obj)/output
>  PDFLATEX      = xelatex
> @@ -108,9 +107,6 @@ dochelp:
>  	@echo  '  make SPHINXDIRS="s1 s2" [target] Generate only docs of folder s1, s2'
>  	@echo  '  valid values for SPHINXDIRS are: $(_SPHINXDIRS)'
>  	@echo
> -	@echo  '  make SPHINX_CONF={conf-file} [target] use *additional* sphinx-build'
> -	@echo  '  configuration. This is e.g. useful to build with nit-picking config.'
> -	@echo
>  	@echo  '  make DOCS_THEME={sphinx-theme} selects a different Sphinx theme.'

So probably I'm a little slow today, but this confuses me.  Even after
this change, the makefile still uses SPHINX_CONF, so I'm not sure how it
is supposed to be set?

Thanks,

jon

