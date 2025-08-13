Return-Path: <linux-kernel+bounces-767691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B869DB257B8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 01:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAEB51C82B28
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 23:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7902FB999;
	Wed, 13 Aug 2025 23:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pqw1DZcJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE772F60A9;
	Wed, 13 Aug 2025 23:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755128828; cv=none; b=nRV/LuitwiZmjE5zSnVEsh+xT2roMeF3Q70Fq0eLgGA0Haut76ik/gjBB3nEzKCdjlrhnPuoOgbr63hH0FGa/RiHRp207+Oq4onIula6aK5xE6K4D4C9Szl9qe2KK2D2VjneiI+wr0thrmOXnab/B4y7KPjfMuWVyZ6oKQhaf34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755128828; c=relaxed/simple;
	bh=/L+FSaZ82XMloJ0zVGBG3BP+hdIEOVmNti+lDdNw2V0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=saMkrRk108E/1rvlwLQSz7XnLNxWeyGrb8C2ZmqYg2W6ds16vdsT9ARWYHQOSHCf0EliUax03DJqyvY11m/1TR6y2iz76V0ZRqv0Lit5omjkQ8qHxlYrhSTEN89r3c0Svpk4QR0yh2OkruouOPlM/S9VpQlhuBf36wf8qF2G0Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pqw1DZcJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17D87C4CEEB;
	Wed, 13 Aug 2025 23:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755128828;
	bh=/L+FSaZ82XMloJ0zVGBG3BP+hdIEOVmNti+lDdNw2V0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pqw1DZcJz9hb3JEnn+MXoqOoklNeqj0KiLjgZogIfhWDgb7oKsFH/tDYTfQE667qu
	 1WavuBB/06gA3JfVNDo/uzXvjNTp769uWPHynv5ZYZpbgH7ymjbkhtb1h7XCOSpBd3
	 eV/qI2hIj6ZK7LZ5l9FDCj6qFxKtlpgAdwTEtxJw1wq+hEeJR4OVZ/qORklpJhabYo
	 1FyP58WkPcJ+SHmCpYeybkGrnpmdEIsgQ8bRT0vIYbKmbytfUF0hiKYaeulxituvhE
	 FsSjDcfdRASJSpWTD5eTuT9Q+qm9DjCMpRqTTM4tfFclKH6nbY09eVQgMP5m9rxLTL
	 ubfgsvJGXQB1w==
Date: Thu, 14 Aug 2025 01:47:04 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 04/13] docs: move scripts/documentation-file-ref-check
 to tools/doc
Message-ID: <20250814014704.4f072894@foz.lan>
In-Reply-To: <20250813213218.198582-5-corbet@lwn.net>
References: <20250813213218.198582-1-corbet@lwn.net>
	<20250813213218.198582-5-corbet@lwn.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Wed, 13 Aug 2025 15:32:03 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> Add this script to the growing collection of documentation tools.

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> 
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> ---
>  Documentation/Makefile                              | 4 ++--
>  MAINTAINERS                                         | 3 +--
>  scripts/sphinx-pre-install                          | 2 +-
>  {scripts => tools/doc}/documentation-file-ref-check | 2 +-
>  4 files changed, 5 insertions(+), 6 deletions(-)
>  rename {scripts => tools/doc}/documentation-file-ref-check (99%)
> 
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index 70095465dce1..f7b8342f9666 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -8,7 +8,7 @@ subdir- := devicetree/bindings
>  ifneq ($(MAKECMDGOALS),cleandocs)
>  # Check for broken documentation file references
>  ifeq ($(CONFIG_WARN_MISSING_DOCUMENTS),y)
> -$(shell $(srctree)/scripts/documentation-file-ref-check --warn)
> +$(shell $(srctree)/tools/doc/documentation-file-ref-check --warn)
>  endif
>  
>  # Check for broken ABI files
> @@ -167,7 +167,7 @@ endif # HAVE_SPHINX
>  # work or silently pass without Sphinx.
>  
>  refcheckdocs:
> -	$(Q)cd $(srctree);scripts/documentation-file-ref-check
> +	$(Q)cd $(srctree); tools/doc/documentation-file-ref-check
>  
>  cleandocs:
>  	$(Q)rm -rf $(BUILDDIR)
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ca4c7992369d..ec9872642597 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7302,7 +7302,6 @@ P:	Documentation/doc-guide/maintainer-profile.rst
>  T:	git git://git.lwn.net/linux.git docs-next
>  F:	Documentation/
>  F:	tools/doc/
> -F:	scripts/documentation-file-ref-check
>  F:	scripts/get_abi.py
>  F:	scripts/kernel-doc*
>  F:	scripts/lib/abi/*
> @@ -7342,7 +7341,7 @@ M:	Mauro Carvalho Chehab <mchehab@kernel.org>
>  L:	linux-doc@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/sphinx/parse-headers.pl
> -F:	scripts/documentation-file-ref-check
> +F:	tools/doc/
>  F:	scripts/sphinx-pre-install
>  
>  DOCUMENTATION/ITALIAN
> diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
> index b8474848df4e..5d006a037428 100755
> --- a/scripts/sphinx-pre-install
> +++ b/scripts/sphinx-pre-install
> @@ -406,7 +406,7 @@ class MissingCheckers(AncillaryMethods):
>          Right now, we still need Perl for doc build, as it is required
>          by some tools called at docs or kernel build time, like:
>  
> -            scripts/documentation-file-ref-check
> +            tools/doc/documentation-file-ref-check
>  
>          Also, checkpatch is on Perl.
>          """
> diff --git a/scripts/documentation-file-ref-check b/tools/doc/documentation-file-ref-check
> similarity index 99%
> rename from scripts/documentation-file-ref-check
> rename to tools/doc/documentation-file-ref-check
> index 408b1dbe7884..2dc53f5661b1 100755
> --- a/scripts/documentation-file-ref-check
> +++ b/tools/doc/documentation-file-ref-check
> @@ -17,7 +17,7 @@ my %false_positives = (
>  );
>  
>  my $scriptname = $0;
> -$scriptname =~ s,.*/([^/]+/),$1,;
> +$scriptname =~ s,tools/doc/([^/]+/),$1,;
>  
>  # Parse arguments
>  my $help = 0;



Thanks,
Mauro

