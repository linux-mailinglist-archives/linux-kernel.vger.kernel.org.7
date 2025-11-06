Return-Path: <linux-kernel+bounces-887886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B2BCDC394DC
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 07:55:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7CA6D4E3588
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 06:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BDBF26E143;
	Thu,  6 Nov 2025 06:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uYT7LFs8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EED2745C
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 06:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762412123; cv=none; b=iBOCQ48yhXomlSEl8iTmB6fim+/+43tE/Mv2Kzzv2q8QgGQYH0/FdyYcvA61lXiB5glIjYtUEMHI+ZLBgxfPAnKN7S9/DNX5aP4mzRV1pbaiHjJRNYcVwtTRKJEJvi3HsqS6kQMMRUjAiQkmPn9IATMu5teZdMI0AhM/tcY2tRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762412123; c=relaxed/simple;
	bh=Zt7uNVhFTcDEd+B/geBCv6CtNPI42yN3m1IVCDNfD8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hMADidHIYXvzLiuTCdeN3jJ+NZKSjqtFE+aHK3il7CGihtYhe89SakLZx6zmUWj3sCuVj6RdKeeMpmblWe+XMpiQWnE32FgHP085UrYDb5BKDrZSRd4QeOQELa5mIC/p4FIffTI91P0B+jqM7MW1RNN3rPFi7fnsXxAqa63QOlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uYT7LFs8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D45AC116B1;
	Thu,  6 Nov 2025 06:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762412122;
	bh=Zt7uNVhFTcDEd+B/geBCv6CtNPI42yN3m1IVCDNfD8U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uYT7LFs8UjfQcIdlGjitZz7UjUq2Xca6rYCme9IkAW384XxD6WTQzcUm0oUbCXnQg
	 uJbyET54je81NZ+C5rLvnovF0OqfNH9gGJ2hG5BZ63nhiaa5lNWFD11d6M+xyeqdnd
	 ysZ5n2mcAqG6OnrPXxBeeyIZ3NiuT6t8ZedcE6LKHxlwI/4YhGUQUYeTGxNWpIfKBM
	 vFvFDW5ehTSH1bTifG68xibjs7oT0LF+d32Z6MOnJmITJ2utFB4+wUryPpIC5up4NX
	 rUv7B5sH7mrZ9wwmjnIohpmaXWGtfhalV0Dp8iw3ymQ+6XMs7ko28dz01D1E5i2gYa
	 VPrCWXAint+pw==
Date: Wed, 5 Nov 2025 22:55:19 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] vmlinux.lds: Fix TEXT_MAIN to include .text.start and
 friends
Message-ID: <2fm4yxe6nr6khoyjmo7r7v4u4zxwygz3wch2vb5yolo2tqjsx7@s27lvvoe6x3j>
References: <5c4ca80e52958da289f92157430d2a31d29109d3.1762322973.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5c4ca80e52958da289f92157430d2a31d29109d3.1762322973.git.jpoimboe@kernel.org>

On Tue, Nov 04, 2025 at 10:11:42PM -0800, Josh Poimboeuf wrote:
> Since commit 6568f14cb5ae ("vmlinux.lds: Exclude .text.startup and
> .text.exit from TEXT_MAIN"), the TEXT_MAIN macro uses a series of
> patterns to prevent the .text.startup[.*] and .text.exit[.*] sections
> from getting linked into vmlinux runtime .text.
> 
> That commit is a tad too aggressive: it also inadvertently filters out
> valid runtime text sections like .text.start and
> .text.start.constprop.0, which can be generated for a function named
> start() when -ffunction-sections is enabled.
> 
> As a result, those sections become orphans when building with
> CONFIG_LD_DEAD_CODE_DATA_ELIMINATION for arm:
> 
>   arm-linux-gnueabi-ld: warning: orphan section `.text.start.constprop.0' from `drivers/usb/host/sl811-hcd.o' being placed in section `.text.start.constprop.0'
>   arm-linux-gnueabi-ld: warning: orphan section `.text.start.constprop.0' from `drivers/media/dvb-frontends/drxk_hard.o' being placed in section `.text.start.constprop.0'
>   arm-linux-gnueabi-ld: warning: orphan section `.text.start' from `drivers/media/dvb-frontends/stv0910.o' being placed in section `.text.start'
>   arm-linux-gnueabi-ld: warning: orphan section `.text.start.constprop.0' from `drivers/media/pci/ddbridge/ddbridge-sx8.o' being placed in section `.text.start.constprop.0'
> 
> Fix that by explicitly adding the partial "substring" sections (.text.s,
> .text.st, .text.sta, etc) and their cloned derivatives.
> 
> While this unfortunately means that TEXT_MAIN continues to grow, these
> changes are ultimately necessary for proper support of
> -ffunction-sections.
> 
> Fixes: 6568f14cb5ae ("vmlinux.lds: Exclude .text.startup and .text.exit from TEXT_MAIN")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202511040812.DFGedJiy-lkp@intel.com/
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
> For tip/objtool/core.

Nack.

There are still some additional headaches that need fixing.

For example, .text.startup is ambiguous: it could be constructor code
(for .init.text) or it could be a function named startup() which was
compiled with -ffunction-sections.

And we also have to deal with .text.startup.constprop.0 and
.text.startup.isra.0.

So the unification isn't quite working out, I'll come back with a new
set of patches to fix all this up again.

-- 
Josh

