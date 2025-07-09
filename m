Return-Path: <linux-kernel+bounces-722610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CCFAAFDCDC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 03:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 211D33A7B1A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 01:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB4415E5C2;
	Wed,  9 Jul 2025 01:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LmPRQZuN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81AA1F948
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 01:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752024098; cv=none; b=C3DjZJ+1p0tWZyrILv+E7v7cbJKiUMh1MiN2D3gKsoQCTUpV+/NXTJ9iI7Zqy8l6feyNctFvVE65N/tmEMniO5DD8advJhPtrKEHzAL5YvPohxP0Hc7t8natQ0568aUwu6GaEDjdFpx8uWdBSeLKhtTnHENPQF+V8yPkBdttiBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752024098; c=relaxed/simple;
	bh=PrbBICA3NNs4hfUwHx+bIOiAj9282vkiXfbstW+6NBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P8Iy42I9RD5veqLz2V7ATGi2188gTADmA9dBFaYunR2TBY1MJegnPFxtyuvArokL8i6ssK5lH2wHIZUoOhJW9GLfYtyDgJFR2JFLrEU4kw/HfUYgQOBfl6KaoIQeCgPgxRBdt2hFru1jftZ7OI3jE7e8wFDCxdOqVRfePQNH14g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LmPRQZuN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A203C4CEED;
	Wed,  9 Jul 2025 01:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752024098;
	bh=PrbBICA3NNs4hfUwHx+bIOiAj9282vkiXfbstW+6NBk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LmPRQZuN+R1ssGpiXwqOHMRjxHNN5ADHenwMK3onGd13CofFM+xZ7Z+oHN5f0eGLh
	 q3NYY2Othz61NXhdeZb92Ie2ed/rKp97LCZuBR6VLYOsMHuvulF31Vspur+ejaf/Ld
	 NNonyx0TJklZIx4n7jn+5Npo4FLJHYJUXlRWEUq5j18wD+seYV5ABC+oTywzAvjWN3
	 la8s0DPM2xB91ohf55zh/QR/C51aWgVCRFDWvs3dh5b4Sf1+kgQi08ZIqwW3Ynut8w
	 9Ji41Zwh+sefgpTHIJy9jAuqN5jUTL1xZ635kN2BezS4rEVkdTf09fTEBC6mKUmfoO
	 Tm48VIEJstdgA==
Date: Tue, 8 Jul 2025 18:21:34 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Martin Wetterwald <martin@wetterwald.eu>
Cc: linus.walleij@linaro.org, linux@armlinux.org.uk,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: Linux linking stage broken on ARM with binutils 2.33.1 (BFD)
Message-ID: <20250709012134.GA1785682@ax162>
References: <CAFERDQ0zPoya5ZQfpbeuKVZEo_fKsonLf6tJbp32QnSGAtbi+Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFERDQ0zPoya5ZQfpbeuKVZEo_fKsonLf6tJbp32QnSGAtbi+Q@mail.gmail.com>

Hi Martin,

On Tue, Jul 08, 2025 at 09:44:44PM +0200, Martin Wetterwald wrote:
> When I upgraded from 6.12.22 to 6.12.23 (without changing anything else), the
> linking stage of vmlinux broke (arch ARM).
> 
> > /home/.../linux-6.12.23/scripts/link-vmlinux.sh: line 49: 136961 Segmentation fault      (core dumped) ${ld} ${ldflags} -o ${output} ${wl}--whole-archive ${objs} ${wl}--no-whole-archive ${wl}--start-group ${libs} ${wl}--end-group ${kallsymso} ${btf_vmlinux_bin_o} ${ldlibs}
> > make[2]: *** [/home/.../linux-6.12.23/scripts/Makefile.vmlinux:34: vmlinux] Error 139
> > make[1]: *** [/home/.../linux-6.12.23/Makefile:1179: vmlinux] Error 2
> > make: *** [/home/.../linux-6.12.23/Makefile:224: __sub-make] Error 2
> 
> This patch seems related:
> 
> > commit 59fc42318305cb38efb4f5565408150419be8451
> > Author: Nathan Chancellor <nathan@kernel.org>
> > Date:   Thu Mar 20 22:33:49 2025 +0100
> >
> >     ARM: 9443/1: Require linker to support KEEP within OVERLAY for DCE
> >
> >     commit e7607f7d6d81af71dcc5171278aadccc94d277cd upstream.
> >
> >     ld.lld prior to 21.0.0 does not support using the KEEP keyword within an
> >     overlay description, which may be needed to avoid discarding necessary
> >     sections within an overlay with '--gc-sections', which can be enabled
> >     for the kernel via CONFIG_LD_DEAD_CODE_DATA_ELIMINATION.
> >
> >     Disallow CONFIG_LD_DEAD_CODE_DATA_ELIMINATION without support for KEEP
> >     within OVERLAY and introduce a macro, OVERLAY_KEEP, that can be used to
> >     conditionally add KEEP when it is properly supported to avoid breaking
> >     old versions of ld.lld.
> >
> >     Cc: stable@vger.kernel.org
> >     Link: https://github.com/llvm/llvm-project/commit/381599f1fe973afad3094e55ec99b1620dba7d8c
> >     Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> >     Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> >     Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> >     [nathan: Fix conflict in init/Kconfig due to lack of RUSTC symbols]
> >     Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> >     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> I'm using BFD linker from GNU binutils 2.33.1 (built using musl-cross-make with
> musl 1.2.5 and GCC 14).
> 
> > scripts/ld-version.sh /tmp/arm-linux-musleabihf-ld
> > BFD 23301
> 
> I don't know if it was the intention of the patch, but it is not only changing
> a behavior for LLD, but also for BFD:
> - Before the patch, ld BFD 2.33.1 was not selecting
>   HAVE_LD_DEAD_CODE_DATA_ELIMINATION, and my build worked.
> - After the patch, ld BFD 2.33.1 is activating
>   HAVE_LD_DEAD_CODE_DATA_ELIMINATION, and it is segfaulting.
> Shouldn't we keep the previous behavior and only select this option when BFD is
> >= 2.36.0 (and not just when we have a BFD linker) ?
> 
> The issue is the interaction between LD_CAN_USE_KEEP_IN_OVERLAY and
> HAVE_LD_DEAD_CODE_DATA_ELIMINATION.
> 
> Nathan, I've seen your proposal here: https://lkml.org/lkml/2025/7/5/431.
> I confirm it also fixes the issue on my side. Should I propose the patch?

Yes, your analysis is spot on, sorry again for the breakage :(

I sent that diff to the list formally yesterday:

https://lore.kernel.org/all/20250707-arm-fix-dce-older-binutils-v1-1-3b5e59dc3b26@kernel.org/

I plan to put it in Russell's patch tracker for application in the next
couple of days, I wanted to wait a few days for the opportunity for
review.

Cheers,
Nathan

