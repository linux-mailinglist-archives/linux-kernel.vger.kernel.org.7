Return-Path: <linux-kernel+bounces-819233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4F3B59CF6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 18:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD4D87A82C1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 16:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA18288C26;
	Tue, 16 Sep 2025 16:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="Prnrg91n"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F3E285C98;
	Tue, 16 Sep 2025 16:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758038839; cv=none; b=NQ0DaTVqaHN4FAt6wwYqKXDi0FsBAZ5ybywdvxy8S4Y27Bfn5dwmZafWkv6igTze+mFPuqAYJUkGOFfxeimAlf84Xg2kZ+ypT4JR6nMAXxaZgl+Fft6I6PYCe7SDsV23Lyple2aH9lW9l8AkODaX0qtfbEu0AK+Fwx7Eqmg2574=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758038839; c=relaxed/simple;
	bh=kMJqNMCJNOVmtXLnOBtOnyQmmRYIqBImTttfwm1qHvE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Uih0cELbXswoPYnwkABdGGclGJs/wc0rHmJh8Au4bWR3I7QRQIQKgItw30f4XdOnxWJwknjdaby2S9dwBHq4y08184Elv15rJ+mY3Yljh1Xi2YdAgdsJInqow9P+R/CbirhoiSmH1k3ygEjqJhJNSDbbmW0GhgoGNWLgdJ96m44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=Prnrg91n; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 5119140ADA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1758038837; bh=NSZkUbt1a8rV14ly3m5h7t1U10pewL0kns7Nz8f3xVs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Prnrg91nrzCwhi/XheSDRiWhldfBwlIdZ4ppB53h7Z4dMvcPNR6HjxBX3SxOpgI82
	 Gh/z/AS22cb9XGeNmCjGq2zvrSn17v7TCOjk8aIwksvxjraX2UR+kvHsfrM6GI1oho
	 y/Pa6i6LoRcqdQBBefTrQMjH7+8PCVUedXcJqELcG5Nuae+PiC7/4v0mM7grHFPP3X
	 rZAUC9XL6Vu5bHokTLg8eve5hdU6jYd3WvnJ4C0IZ2zGWDOoxJtykirZN+evbyvtQi
	 wB26CeLEa9375thWKXzkCvOG09utby2GRh0IPpSA1aFjnR2ZrXTyNulM3oJUNc9pE0
	 9C/GwDD07eSSA==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 5119140ADA;
	Tue, 16 Sep 2025 16:07:17 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Bagas Sanjaya <bagasdotme@gmail.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Documentation
 <linux-doc@vger.kernel.org>, Linux Kernel Workflows
 <workflows@vger.kernel.org>
Cc: Dante Strock <dantestrock@hotmail.com>, Randy Dunlap
 <rdunlap@infradead.org>, Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH] Documentation: process: Do not hardcode kernel major
 version number
In-Reply-To: <20250913015147.9544-1-bagasdotme@gmail.com>
References: <20250913015147.9544-1-bagasdotme@gmail.com>
Date: Tue, 16 Sep 2025 10:07:16 -0600
Message-ID: <87tt12e5zf.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> The big picture section of 2.Process.rst currently hardcodes major
> version number to 5 since fb0e0ffe7fc8e0 ("Documentation: bring process
> docs up to date"). As it can get outdated when it is actually
> incremented (the recent is 6 and will be 7 in the near future), replace
> it with the placeholder.
>
> Note that the version number examples are kept to illustrate the
> numbering scheme.
>
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  Documentation/process/2.Process.rst | 40 ++++++++++++-----------------
>  1 file changed, 17 insertions(+), 23 deletions(-)
>
> diff --git a/Documentation/process/2.Process.rst b/Documentation/process/2.Process.rst
> index ef3b116492df08..668d5559ded039 100644
> --- a/Documentation/process/2.Process.rst
> +++ b/Documentation/process/2.Process.rst
> @@ -13,24 +13,18 @@ how the process works is required in order to be an effective part of it.
>  The big picture
>  ---------------
>  
> -The kernel developers use a loosely time-based release process, with a new
> -major kernel release happening every two or three months.  The recent
> -release history looks like this:
> +Linux kernel uses a loosely time-based, rolling release development model.
> +A new major kernel release (a.x) [1]_ happens every two or three monts, which
> +comes with new features, internal API changes, and more. A typical release
> +can contain about 13,000 changesets with changes to several hundred thousand
> +lines of code. Recent releases, along with their dates, can be found at
> +`Wikipedia <https://en.wikipedia.org/wiki/Linux_kernel_version_history>`_.

I have to admit that I'm not at all convinced that this change brings
clarity to the document; using real numbers grounds the text in a way
that "a.x" does not.

If we really think it's embarrassing to still say "5.whatever" here,
perhaps we should just change it to "9.whatever" and be good for a long
time?

Thanks,

jon

