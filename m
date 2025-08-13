Return-Path: <linux-kernel+bounces-767689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30EC1B257B6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 01:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E577C628AA4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 23:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6354F2FB991;
	Wed, 13 Aug 2025 23:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j/mIEowb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98F02FC864;
	Wed, 13 Aug 2025 23:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755128643; cv=none; b=q1fazN6mVFUA6tdvQcl1nJMpvuncqCrUffbUSbHsQafC0LJelDLhaEQ6imX9teVBFP6apA+Cw2Gp4GGM3sEh/Gs/m18uhgOBnO9zFVJ62eAe/aLrntx9FIDT0HriCg1uujHZYvWyWhSh2dqQq1dLDCu/AzH16trINpDy+KqH4YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755128643; c=relaxed/simple;
	bh=x/5aZj+YR0z4D3s71PcwJa3HwmmdL2EdAgXpfnMPipw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jw6QcHOBc+7Cp7AxE2IvYYQZu6yEcpDUrCp7pxC7ZHs4U6nW39fUtUlp3lzGBgaauWJcIlpZLT3rTnLhvw03j1roFV738jUOvghez4NFVq1YcO44+bXvRfZrMr544ADshEF59qfASyK1rNsXMsgbEIdT0k3lCjBCv0h6kPSabsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j/mIEowb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 037D9C4CEEB;
	Wed, 13 Aug 2025 23:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755128643;
	bh=x/5aZj+YR0z4D3s71PcwJa3HwmmdL2EdAgXpfnMPipw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=j/mIEowb7LRkaqK4Egybzq1ew8/VJtbjEwjxQjO56bRCEkQ1wRWTrdAQ408OfaBnV
	 y3N5o2GmtJP/UibJqa/YVECi17FqJDqQX17p4LMIJFPRxvm3pou012vIFAZ9SXKVKs
	 ndLcz9Tdi07WPqC14q7qjnnxFRxEd6yp5mAmOm0/Fu9u4Gm8XTS8Dk0SZmv+taWtCb
	 gSL2MGO5mAEpG2zBvVBERRq/m6qlRLsJrsczTd4alSCMCqLE4DdOPxpmyoC6P8XGFg
	 Jw2ObDWIXnaTX2hJIK614NiJe6D5vIWytHlVXdrQ4HgeFV4hmBMceUpFWo/IIOjJ/u
	 a0ZW6+cWzT/rA==
Date: Thu, 14 Aug 2025 01:43:59 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 06/13] docs: move get_abi.py to tools/doc
Message-ID: <20250814014359.0631931a@foz.lan>
In-Reply-To: <20250813213218.198582-7-corbet@lwn.net>
References: <20250813213218.198582-1-corbet@lwn.net>
	<20250813213218.198582-7-corbet@lwn.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Wed, 13 Aug 2025 15:32:05 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> Move this tool out of scripts/ to join the other documentation tools; fix
> up a couple of erroneous references in the process.
> 
> It's worth noting that this script will fail badly unless one has a
> PYTHONPATH referencing scripts/lib/abi.

Heh, on all Python scripts you're moving, you need to change the logic.

In the case of kernel-doc, you need to change from:

	LIB_DIR = "lib/kdoc"
	SRC_DIR = os.path.dirname(os.path.realpath(__file__))		# Currently scripts/
	sys.path.insert(0, os.path.join(SRC_DIR, LIB_DIR))

to:

	LIB_DIR = "../../scripts/lib/kdoc"
	SRC_DIR = os.path.dirname(os.path.realpath(__file__))		# Currently scripts/
	sys.path.insert(0, os.path.join(SRC_DIR, LIB_DIR))

Here, it is the same, except that LIB_DIR will now be:

	LIB_DIR = "../../scripts/lib/abi"
	

> 
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> ---
>  Documentation/Kconfig              | 2 +-
>  Documentation/Makefile             | 2 +-
>  Documentation/sphinx/kernel_abi.py | 2 +-
>  MAINTAINERS                        | 1 -
>  {scripts => tools/doc}/get_abi.py  | 0
>  5 files changed, 3 insertions(+), 4 deletions(-)
>  rename {scripts => tools/doc}/get_abi.py (100%)
> 
> diff --git a/Documentation/Kconfig b/Documentation/Kconfig
> index 3a0e7ac0c4e3..70178e9e0c6c 100644
> --- a/Documentation/Kconfig
> +++ b/Documentation/Kconfig
> @@ -19,7 +19,7 @@ config WARN_ABI_ERRORS
>  	  described at Documentation/ABI/README. Yet, as they're manually
>  	  written, it would be possible that some of those files would
>  	  have errors that would break them for being parsed by
> -	  scripts/get_abi.pl. Add a check to verify them.
> +	  tools/doc/get_abi.py. Add a check to verify them.
>  
>  	  If unsure, select 'N'.
>  
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index 962c4fab94b0..eef5decb79b8 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -13,7 +13,7 @@ endif
>  
>  # Check for broken ABI files
>  ifeq ($(CONFIG_WARN_ABI_ERRORS),y)
> -$(shell $(srctree)/scripts/get_abi.py --dir $(srctree)/Documentation/ABI validate)
> +$(shell $(srctree)/tools/doc/get_abi.py --dir $(srctree)/Documentation/ABI validate)
>  endif
>  endif
>  
> diff --git a/Documentation/sphinx/kernel_abi.py b/Documentation/sphinx/kernel_abi.py
> index 4c4375201b9e..32e39fb8bc3b 100644
> --- a/Documentation/sphinx/kernel_abi.py
> +++ b/Documentation/sphinx/kernel_abi.py
> @@ -14,7 +14,7 @@
>      :license:    GPL Version 2, June 1991 see Linux/COPYING for details.
>  
>      The ``kernel-abi`` (:py:class:`KernelCmd`) directive calls the
> -    scripts/get_abi.py script to parse the Kernel ABI files.
> +    AbiParser class to parse the Kernel ABI files.
>  
>      Overview of directive's argument and options.
>  
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ec9872642597..b41b78215035 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7302,7 +7302,6 @@ P:	Documentation/doc-guide/maintainer-profile.rst
>  T:	git git://git.lwn.net/linux.git docs-next
>  F:	Documentation/
>  F:	tools/doc/
> -F:	scripts/get_abi.py
>  F:	scripts/kernel-doc*
>  F:	scripts/lib/abi/*
>  F:	scripts/lib/kdoc/*
> diff --git a/scripts/get_abi.py b/tools/doc/get_abi.py
> similarity index 100%
> rename from scripts/get_abi.py
> rename to tools/doc/get_abi.py



Thanks,
Mauro

