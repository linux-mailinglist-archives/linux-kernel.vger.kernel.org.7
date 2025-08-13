Return-Path: <linux-kernel+bounces-767678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0073B25797
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 01:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 512531BC34F2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 23:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5297B2F60A4;
	Wed, 13 Aug 2025 23:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q+o/ecNp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28F02F60A5;
	Wed, 13 Aug 2025 23:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755127918; cv=none; b=AbEeAuFI0dBNr8fiJrBzbRwKH1GkcRdC+l02tgSS+IQQgKu8jp9/BLLePCv64aJbsxk4vib4gDv4FI4/oVH/46B9krjx3L55t75qmdPDXXRbOeyqugcFOJU4uRY/ePMnJOk2S6/X3IEXo6LZRh6eQVQgEDB+wGS2dqTRjz+XUbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755127918; c=relaxed/simple;
	bh=nF7toL7Yj0MDeijA8jPHl59MTK7TzqVBJffEbOipCdw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mz9iR0iRjbfSrJFg+YPrqB0DMfW3BTuRIs3Bdqb/1rGR1rMooeBqqwMpzlNZKzdBnnqG8YBSpX5lS6lzwC0X+8JC9CbxUnDWU9ct7v7/8iG46vNnUfHQzxlkjGP5D+kSEAfUdl37zW8p0/gc9KkxLHwITviAqowfZ9oJtZKwTHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q+o/ecNp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19CE9C4CEEB;
	Wed, 13 Aug 2025 23:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755127918;
	bh=nF7toL7Yj0MDeijA8jPHl59MTK7TzqVBJffEbOipCdw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=q+o/ecNpafpF95IK6OOv23aJF/5tP2XkfGZUCKl+gJsPndu40zqNZskJlOhmAZSjb
	 lpr8noavNJaL5WWqoLFSXIkPnyQcx1xH8WwDvFd3KUC7Ebzcx/7P+Ys8imlfvnoy1Z
	 lXhcFiuvQJl1s6hF6ryahiFFrwnCllh0RrTNxrU4HXWp5THcVsgoKNbOW2XmoovBLA
	 UtGy2VjXq+fxYqv1f0iw9RNudsd36t2tMSZipB7Emt/79MM+piO1sNCTBAZEXmvlGD
	 oJyu+QHEiGeXgixh20mj1iGb8z1XpmtgDL1trDq0hUtfrD8oysh2sCc/2Rx4dpKRUr
	 l7/mK24/aqKVA==
Date: Thu, 14 Aug 2025 01:31:54 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 05/13] docs: move parallel-wrapper.sh to tools/doc/
Message-ID: <20250814013154.623955ed@foz.lan>
In-Reply-To: <20250813213218.198582-6-corbet@lwn.net>
References: <20250813213218.198582-1-corbet@lwn.net>
	<20250813213218.198582-6-corbet@lwn.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Wed, 13 Aug 2025 15:32:04 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> This little script was buried in Documentation/sphinx/; put it with the
> other documentation-related tools.

This will conflict with my series getting rid of it and touching Makefile.

I prefer if you don't merge this one.

> 
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> ---
>  Documentation/Makefile                                  | 2 +-
>  {Documentation/sphinx => tools/doc}/parallel-wrapper.sh | 0
>  2 files changed, 1 insertion(+), 1 deletion(-)
>  rename {Documentation/sphinx => tools/doc}/parallel-wrapper.sh (100%)
> 
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index f7b8342f9666..962c4fab94b0 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -91,7 +91,7 @@ quiet_cmd_sphinx = SPHINX  $@ --> file://$(abspath $(BUILDDIR)/$3/$4)
>  	PYTHONPYCACHEPREFIX="$(PYTHONPYCACHEPREFIX)" \
>  	BUILDDIR=$(abspath $(BUILDDIR)) SPHINX_CONF=$(abspath $(src)/$5/$(SPHINX_CONF)) \
>  	$(PYTHON3) $(srctree)/scripts/jobserver-exec \
> -	$(CONFIG_SHELL) $(srctree)/Documentation/sphinx/parallel-wrapper.sh \
> +	$(CONFIG_SHELL) $(srctree)/tools/doc/parallel-wrapper.sh \
>  	$(SPHINXBUILD) \
>  	-b $2 \
>  	-c $(abspath $(src)) \
> diff --git a/Documentation/sphinx/parallel-wrapper.sh b/tools/doc/parallel-wrapper.sh
> similarity index 100%
> rename from Documentation/sphinx/parallel-wrapper.sh
> rename to tools/doc/parallel-wrapper.sh



Thanks,
Mauro

