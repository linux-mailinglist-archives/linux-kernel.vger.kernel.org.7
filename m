Return-Path: <linux-kernel+bounces-767685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CEF0B257A9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 01:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 720161C27314
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 23:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748412BD5B0;
	Wed, 13 Aug 2025 23:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZE3u8w1t"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D191C2F60B0;
	Wed, 13 Aug 2025 23:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755128301; cv=none; b=AWCqDmXmJ0a68wg9qU0kMHjR3PVabT77zF/s+aIby1rnb+A5erHAXQx9DLm+PMEC2xmDw2mR7lWO9EoGr+eW69PytHmgmZabeu9FwwOe/Zb+bkPVOTNeNZ7LB/U3AIZ8UoyQ4z/vuier9z3nzmJXXgzcLexPapbFtFFbyoQ4p/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755128301; c=relaxed/simple;
	bh=voTAc7WxHmoLMFKtV7WAZ3Oon/q9j0hk6Q5yX3H8IU4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W8cc4VOvdyMOOuBO72uWRR/nY8N5TvITr8KDs/XeWLFVZqTHkE0mVm13BtfbENQqQ3aBE4YvyevtE/SQYBsVlLsdWei6e/w/foOyCNoVufSNAJx4FUa+PkTL3udEPwMlbP7ug68uyiuBlewuhHs8/8YLVV0WZKnyLHzwHzYN2B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZE3u8w1t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B86BC4CEEB;
	Wed, 13 Aug 2025 23:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755128301;
	bh=voTAc7WxHmoLMFKtV7WAZ3Oon/q9j0hk6Q5yX3H8IU4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZE3u8w1tC0qVvAfbPxJzqC1L56MNY1m3Ce1/BP2e+/fixN/9EaT4Hfwo+6cRhDKP8
	 cd0uKoafToLYMS+jfgBvhO/A/B6YVZFd8IQyu24qDT/0YGuGwy0Np9Buw74ixq8sCs
	 q8g0aLTJddL35ROc/JSTaEBA1ttbne5+j0cMcDbL8TeCwWJC9HQYyXqKp40VhjJ1ST
	 45dMK1u0Ynh+lkuepAVBg0TgcQwfbso5M7e6cx8pkXa4942l0Cexl7g+KwlnLnu6zZ
	 MNWR1c5pLNyymPVrgkhsaMVUc7oO9WLuZW+6nBJf8YhLVe2laNUvxdfUKSpOdzP37A
	 8Hy9tUTSUO5Sg==
Date: Thu, 14 Aug 2025 01:38:17 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 01/13] docs: Move the "features" tools to tools/doc
Message-ID: <20250814013817.249eb3c5@foz.lan>
In-Reply-To: <20250813213218.198582-2-corbet@lwn.net>
References: <20250813213218.198582-1-corbet@lwn.net>
	<20250813213218.198582-2-corbet@lwn.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Wed, 13 Aug 2025 15:32:00 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> The scripts for managing the features docs are found in three different
> directories; unite them all under tools/doc and update references as
> needed.
> 
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> ---
>  Documentation/sphinx/kernel_feat.py                           | 4 ++--
>  .../features/scripts => tools/doc}/features-refresh.sh        | 0
>  {scripts => tools/doc}/get_feat.pl                            | 2 +-

This one is the next on my list to convert to Python, but I didn't
do any changes on it yet.

So,

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>


>  {Documentation/features => tools/doc}/list-arch.sh            | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
>  rename {Documentation/features/scripts => tools/doc}/features-refresh.sh (100%)
>  rename {scripts => tools/doc}/get_feat.pl (99%)
>  rename {Documentation/features => tools/doc}/list-arch.sh (83%)

I wonder if the best wouldn't be to have a single script for
features handling all usecases.

> 
> diff --git a/Documentation/sphinx/kernel_feat.py b/Documentation/sphinx/kernel_feat.py
> index e3a51867f27b..5453a7b1fc9f 100644
> --- a/Documentation/sphinx/kernel_feat.py
> +++ b/Documentation/sphinx/kernel_feat.py
> @@ -13,7 +13,7 @@
>      :license:    GPL Version 2, June 1991 see Linux/COPYING for details.
>  
>      The ``kernel-feat`` (:py:class:`KernelFeat`) directive calls the
> -    scripts/get_feat.pl script to parse the Kernel ABI files.
> +    tools/doc/get_feat.pl script to parse the Kernel ABI files.
>  
>      Overview of directive's argument and options.
>  
> @@ -83,7 +83,7 @@ class KernelFeat(Directive):
>          srctree = os.path.abspath(os.environ["srctree"])
>  
>          args = [
> -            os.path.join(srctree, 'scripts/get_feat.pl'),
> +            os.path.join(srctree, 'tools/doc/get_feat.pl'),
>              'rest',
>              '--enable-fname',
>              '--dir',
> diff --git a/Documentation/features/scripts/features-refresh.sh b/tools/doc/features-refresh.sh
> similarity index 100%
> rename from Documentation/features/scripts/features-refresh.sh
> rename to tools/doc/features-refresh.sh
> diff --git a/scripts/get_feat.pl b/tools/doc/get_feat.pl
> similarity index 99%
> rename from scripts/get_feat.pl
> rename to tools/doc/get_feat.pl
> index 40fb28c8424e..d75e7c85dc85 100755
> --- a/scripts/get_feat.pl
> +++ b/tools/doc/get_feat.pl
> @@ -18,7 +18,7 @@ my $enable_fname;
>  my $basename = abs_path($0);
>  $basename =~ s,/[^/]+$,/,;
>  
> -my $prefix=$basename . "../Documentation/features";
> +my $prefix=$basename . "../../Documentation/features";
>  
>  # Used only at for full features output. The script will auto-adjust
>  # such values for the minimal possible values
> diff --git a/Documentation/features/list-arch.sh b/tools/doc/list-arch.sh
> similarity index 83%
> rename from Documentation/features/list-arch.sh
> rename to tools/doc/list-arch.sh
> index ac8ff7f6f859..96fe83b7058b 100755
> --- a/Documentation/features/list-arch.sh
> +++ b/tools/doc/list-arch.sh
> @@ -8,4 +8,4 @@
>  
>  ARCH=${1:-$(uname -m | sed 's/x86_64/x86/' | sed 's/i386/x86/' | sed 's/s390x/s390/')}
>  
> -$(dirname $0)/../../scripts/get_feat.pl list --arch $ARCH
> +$(dirname $0)/get_feat.pl list --arch $ARCH



Thanks,
Mauro

