Return-Path: <linux-kernel+bounces-767690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7480AB257BA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 01:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 509E6176626
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 23:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2235B2FC884;
	Wed, 13 Aug 2025 23:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E/IByDMg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822782F60A9;
	Wed, 13 Aug 2025 23:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755128789; cv=none; b=aJB+RbbcnWeHl285cDfA3mc8JJ2HWY3aKPldgiZmC7ChyYDXyLEyy1QYdFCtEmUOFp2SAFE1SFz7ynkXOEkWHQxdqk2aqGCJNt6D2hXgmspmJzYWRAbjvPKxqoFd8wAnxDinssFbesO73O6oQiRTr9ewslW29cEEoluaYqqr4Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755128789; c=relaxed/simple;
	bh=nBTz2chrvUjJYAXQdPhAJpzO7bG75Yi+i25bdiMJYAw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ghMBmIz6LWtkODory133f8n+o5PQxt/WZCEVydYGBGkR+ZMusVgLjacs8m0dJ8O5gg/aB1f/Ocrdd/BE7cnGQjXFmxXG4urw5XU8c6yykHKVsiFujRwRoN78+5rdSSzWXe4DbHGInOSFmDjtsK7dAgSPVn1/R2YHOyEZyuRuVIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E/IByDMg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CACCAC4CEEB;
	Wed, 13 Aug 2025 23:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755128789;
	bh=nBTz2chrvUjJYAXQdPhAJpzO7bG75Yi+i25bdiMJYAw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=E/IByDMgS5nbffRYrpOCGM4c+pRpSsy4FYj/Fe3KX6BGQQSPgeZfHpksQvH7xDnta
	 gVIEd+9cCMgdymHi7rBbRynH6ZmxCab0usFzIX/TEttR0kroa/1e1E8UuvDvg0bp3v
	 vE+J8WAo2ou3vMzPv/3wBL9hSKTUlO3UxvXPsPkjqf8lV9KRoYVsrw8ZnoYA8bGBp/
	 duunoKzmY77LpONID0/D7AL1G8lTVI7F58SMUNh1n4zWBS970JIOgaxD2LdxePYEDA
	 1XUi5hUB2U1Wg0x9yNsFbsslUJhoZoy0Gz98JxMygA/dDzY9ziy+XNfcOEiE+wzTAK
	 lJ50zAnPGJmvg==
Date: Thu, 14 Aug 2025 01:46:25 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 03/13] docs: move scripts/check-variable-fonts.sh to
 tools/doc
Message-ID: <20250814014625.6be2eabc@foz.lan>
In-Reply-To: <20250813213218.198582-4-corbet@lwn.net>
References: <20250813213218.198582-1-corbet@lwn.net>
	<20250813213218.198582-4-corbet@lwn.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Wed, 13 Aug 2025 15:32:02 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> Move this script to live with the rest of the documentation tools.

This one will also be obsoleted with the new sphinx-build-wrapper tool.

Please don't touch on it yet.

> 
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> ---
>  Documentation/Makefile                         | 2 +-
>  MAINTAINERS                                    | 1 -
>  {scripts => tools/doc}/check-variable-fonts.sh | 2 +-
>  3 files changed, 2 insertions(+), 3 deletions(-)
>  rename {scripts => tools/doc}/check-variable-fonts.sh (98%)
> 
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index 820f07e0afe6..70095465dce1 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -146,7 +146,7 @@ pdfdocs: DENY_VF = XDG_CONFIG_HOME=$(FONTS_CONF_DENY_VF)
>  pdfdocs: latexdocs
>  	@$(srctree)/scripts/sphinx-pre-install --version-check
>  	$(foreach var,$(SPHINXDIRS), \
> -	   $(MAKE) PDFLATEX="$(PDFLATEX)" LATEXOPTS="$(LATEXOPTS)" $(DENY_VF) -C $(BUILDDIR)/$(var)/latex || sh $(srctree)/scripts/check-variable-fonts.sh || exit; \
> +	   $(MAKE) PDFLATEX="$(PDFLATEX)" LATEXOPTS="$(LATEXOPTS)" $(DENY_VF) -C $(BUILDDIR)/$(var)/latex || sh $(srctree)/tools/doc/check-variable-fonts.sh || exit; \
>  	   mkdir -p $(BUILDDIR)/$(var)/pdf; \
>  	   mv $(subst .tex,.pdf,$(wildcard $(BUILDDIR)/$(var)/latex/*.tex)) $(BUILDDIR)/$(var)/pdf/; \
>  	)
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a3a396fc1c3f..ca4c7992369d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7302,7 +7302,6 @@ P:	Documentation/doc-guide/maintainer-profile.rst
>  T:	git git://git.lwn.net/linux.git docs-next
>  F:	Documentation/
>  F:	tools/doc/
> -F:	scripts/check-variable-fonts.sh
>  F:	scripts/documentation-file-ref-check
>  F:	scripts/get_abi.py
>  F:	scripts/kernel-doc*
> diff --git a/scripts/check-variable-fonts.sh b/tools/doc/check-variable-fonts.sh
> similarity index 98%
> rename from scripts/check-variable-fonts.sh
> rename to tools/doc/check-variable-fonts.sh
> index ce63f0acea5f..9660df53d716 100755
> --- a/scripts/check-variable-fonts.sh
> +++ b/tools/doc/check-variable-fonts.sh
> @@ -106,7 +106,7 @@ if [ "x$notocjkvffonts" != "x" ] ; then
>  	echo 'Or, CJK pages can be skipped by uninstalling texlive-xecjk.'
>  	echo
>  	echo 'For more info on denylisting, other options, and variable font, see header'
> -	echo 'comments of scripts/check-variable-fonts.sh.'
> +	echo 'comments of tools/doc/check-variable-fonts.sh.'
>  	echo '============================================================================='
>  fi
>  



Thanks,
Mauro

