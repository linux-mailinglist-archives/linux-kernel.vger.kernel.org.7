Return-Path: <linux-kernel+bounces-849852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B99BBD1166
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 03:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9FBC3BC38D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 01:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D88022157B;
	Mon, 13 Oct 2025 01:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r7TKOik8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D576D34BA2C
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 01:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760318666; cv=none; b=s+AnTfepWLKyEpTZO6AZDreKk2oZYt5Tdv/Th5XCaevSVXWsUttTkTwpnWIoaATpcfnU1P1nNdmJM/7PlfozQY2/mNL4rXFoQ+Q8SmXCgUNqm/TBlIJAnw61tTU8dFK/0QTaJMBRbkIzJrVxLZGXDaMhaLFeNJcFeIEeDh/aRQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760318666; c=relaxed/simple;
	bh=Zv9tVEJsq3S9yAm+gfE3WY8Ra9Au/I/BrK2Dl5dPqmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XRnYgGGIlfMullT/hUT2Gy80xE68Ey0/1JNGdMpgdjxDoU0DgvO5SGlmKOC+27QG7ux+8We045kgu7ap1tdGqHzSh1LefiY3WzlB4uD5a+ggvofBVyM19dSfqdxihZckzFm4aJTZfKo6/qZ10tESmG3+8xShO7ZKW3FQ4iw7FH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r7TKOik8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB5A7C4CEE7;
	Mon, 13 Oct 2025 01:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760318666;
	bh=Zv9tVEJsq3S9yAm+gfE3WY8Ra9Au/I/BrK2Dl5dPqmA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r7TKOik8P1vJuaAUvJLmfI0/37SFj1TCsT7gpgW4a48TQg3pBfVE/X2Gd158zYRJv
	 vokdF5xOVV/yF0AxUjp67lViD8ZoudQTsi8ajpvSjyiIAX0S0BQGMNrIvtvgqQP8+l
	 s+KIUgool6k7kUKJs4W+vloGvh9Q9rqsmcA0Ka9Zq12UOunjZqAdUFYgT7NoHANveJ
	 ghwj2pFi24Hbx1YUGiG2HxTAGY1qrNCJN1N0DbkX1J4D4r/mOanznNzOV1gHUpNfef
	 rv/K4YsSvZqSpFJDIyznF2crPxJVKuXm8bLmONETF74HU8TyhoY9etsgjErkNNUyjR
	 ZjL9tuPSuDA5g==
Date: Sun, 12 Oct 2025 18:24:23 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Jesper Juhl <jesperjuhl76@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Building a allyesconfig kernel fails because macros are being
 redefined
Message-ID: <20251013012423.GA331@ax162>
References: <CAHaCkme7C8LDpWVX8TnDQQ+feWeQy_SA3HYfpyyPNFee_+Z2EA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHaCkme7C8LDpWVX8TnDQQ+feWeQy_SA3HYfpyyPNFee_+Z2EA@mail.gmail.com>

On Mon, Oct 13, 2025 at 01:47:54AM +0200, Jesper Juhl wrote:
> My current git HEAD is at  3a8660878839faadb4f1a6dd72c3179c1df56787
> 
> If I do :
>     make mrproper
>     make allyesconfig
>     make -j 33
> it eventually fails with :
> 
> ...
>  INSTALL libsubcmd_headers
>  CALL    scripts/checksyscalls.sh
>  CC [U]  samples/vfs/test-statx
>  CC [U]  samples/watch_queue/watch_test
> In file included from samples/vfs/test-statx.c:23:
> usr/include/linux/fcntl.h:160:9: error: ‘AT_RENAME_NOREPLACE’
> redefined [-Werror]
>  160 | #define AT_RENAME_NOREPLACE     0x0001
>      |         ^~~~~~~~~~~~~~~~~~~
> In file included from samples/vfs/test-statx.c:13:
> /usr/include/stdio.h:171:10: note: this is the location of the
> previous definition
>  171 | # define AT_RENAME_NOREPLACE RENAME_NOREPLACE
>      |          ^~~~~~~~~~~~~~~~~~~
> usr/include/linux/fcntl.h:161:9: error: ‘AT_RENAME_EXCHANGE’ redefined [-Werror]
>  161 | #define AT_RENAME_EXCHANGE      0x0002
>      |         ^~~~~~~~~~~~~~~~~~
> /usr/include/stdio.h:173:10: note: this is the location of the
> previous definition
>  173 | # define AT_RENAME_EXCHANGE RENAME_EXCHANGE
>      |          ^~~~~~~~~~~~~~~~~~
> usr/include/linux/fcntl.h:162:9: error: ‘AT_RENAME_WHITEOUT’ redefined [-Werror]
>  162 | #define AT_RENAME_WHITEOUT      0x0004
>      |         ^~~~~~~~~~~~~~~~~~
> /usr/include/stdio.h:175:10: note: this is the location of the
> previous definition
>  175 | # define AT_RENAME_WHITEOUT RENAME_WHITEOUT
>      |          ^~~~~~~~~~~~~~~~~~

This is a bug in glibc:

https://inbox.sourceware.org/libc-alpha/20250823052706.GA4056405@ax162/
https://sourceware.org/git?p=glibc.git;a=commit;h=1166170d95863e5a6f8121a5ca9d97713f524f49

Cheers,
Nathan

