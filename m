Return-Path: <linux-kernel+bounces-836947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D04BAAF2D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 04:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0EF01C4F3D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 02:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098291F4CBB;
	Tue, 30 Sep 2025 02:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DKSDeesr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6885E1EA65
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 02:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759197984; cv=none; b=Xjgr8KRpPU6f0wAKZz7TSQuYQ/1WWMNAGqvzODf+Jrrqz8MxJddwlPcI8CFQM2+Ep+D7A9HkWaF01SKM7gYxBlgzHhTf4SI3lFgQelPLq99cGEs0J3MXjM10tjFhXJ3Gf2MRJKhVxzLXe+IFcrPhsofThpwM585EO4ZAlh3vTlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759197984; c=relaxed/simple;
	bh=+TFC4uxivr+Kt82Mvgij3LA3e0HSes26wIQizUcLzCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aM/W3dtDE+c8r7ipeLLbxdotczy4HemGXQ8bjuSGmIgl4sr5F8dviHHdVEjnoknrQgL7Cm+HISuVFpWR2r73BMHa+EEm6t+xp4GFU11CNntOw2qiWBLIKgYLcuKsLhHVwLibRWyp52j31hKrMvHmtXqrMhpVdaVK/zf67t9vQW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DKSDeesr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31A92C4CEF4;
	Tue, 30 Sep 2025 02:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759197984;
	bh=+TFC4uxivr+Kt82Mvgij3LA3e0HSes26wIQizUcLzCg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DKSDeesr8shtE5rQLLWmFl6PMDTyklIkKYRIFUL2hXf5JrDGZByELyYQ3c/pCoebW
	 zmwoXdQJsGCZE7jHhm4qk46YSIj/o8SLkj9+SI0UwlCYxtUDgS169RkdgFq0/NtGht
	 IJt0w3wY4S66z2nxEZXVKicHkhmjrlZhfDg/1OAgVJ2+JpZp9Fmr+Tbfe2kHZWXP8f
	 unwodPviOC9lNcC/fZfqpBstllpCH9NkCZlxJA1F1pSrgZj9G8BLH1KgCwoyEYMjYT
	 ygksthx/1wvf7DP4oxq7/MaaB3wd24tsysn0BiFVtySOdz1+HXrQ1lEwxaOOT2UFMm
	 k3vAjOLruqohw==
Date: Mon, 29 Sep 2025 19:06:23 -0700
From: Kees Cook <kees@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
	Christopher Fore <csfore@posteo.net>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Junjie Cao <junjie.cao@intel.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Vegard Nossum <vegard.nossum@oracle.com>
Subject: Re: [GIT PULL] hardening updates for v6.18-rc1
Message-ID: <202509291904.479E322AE9@keescook>
References: <202509291213.E313986EE@keescook>
 <CAHk-=wgZjUk4Cy2XgNkTrQoO8XCmNUHrTe5D519Fij1POK+3qw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgZjUk4Cy2XgNkTrQoO8XCmNUHrTe5D519Fij1POK+3qw@mail.gmail.com>

On Mon, Sep 29, 2025 at 05:59:17PM -0700, Linus Torvalds wrote:
> On Mon, 29 Sept 2025 at 12:15, Kees Cook <kees@kernel.org> wrote:
> >
> > Please pull these hardening updates for v6.18-rc1. One notable addition
> > is the creation of the "transitional" keyword for kconfig so CONFIG
> > renaming can go more smoothly. This has been a long-standing deficiency,
> > and with the renaming of CONFIG_CFI_CLANG to CONFIG_CFI (since GCC will
> > soon have KCFI support), this came up again. The breadth of the diffstat
> > is mainly this renaming.
> 
> So I really like this addition conceptually, but it doesn't actually
> seem to work.
> 
> My clang-building tree config had
> 
>     CONFIG_ARCH_SUPPORTS_CFI_CLANG=y
>     # CONFIG_CFI_CLANG is not set
>     CONFIG_HAVE_CFI_ICALL_NORMALIZE_INTEGERS_CLANG=y
> 
> but then when I pulled this and did a "make oldconfig" I get Kconfig asking me
> 
>     Use Kernel Control Flow Integrity (kCFI) (CFI) [N/y/?] (NEW)
> 
> anyway, in order to get
> 
>     CONFIG_ARCH_SUPPORTS_CFI=y
>     # CONFIG_CFI is not set
>     CONFIG_HAVE_CFI_ICALL_NORMALIZE_INTEGERS=y
> 
> and I thought the whole point was that it would recognize the old
> Kconfig names and transition them to the new ones. And it very clearly
> does not.
> 
> So I'm a bit disappointed. Possibly because I expected the
> "transitional" keyword to be doing more than it does. But possibly
> because it's buggy and doesn't actually do what it is *supposed* to
> do.

Ah, the existing "=n" didn't persist. That's not expected. I will take
a look.

-- 
Kees Cook

