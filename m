Return-Path: <linux-kernel+bounces-880937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BBEFC26EA5
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 21:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A95FC1B21567
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 20:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C7E329377;
	Fri, 31 Oct 2025 20:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mKCn1nrE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684BF328B72;
	Fri, 31 Oct 2025 20:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761942892; cv=none; b=ub+3lx40WEjJGkOELGK+XKL31IfT7ODBt+SwZB4ut5vcjRpHSZmONkNnk3xPCFj5cxUstddAibnTwDXDC8z5hC32+8eRCDGVzCXBDR2+NJT+XdCm0r3KY+y3WukZD3PRejkbudZf8bsEtvr+fIkJEmSThuFtfkc/UwScYeEHV/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761942892; c=relaxed/simple;
	bh=eaC3FfZxJWWchwEb1p6d5lCoWti7psSYXuw5oCrNqpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Et6o6r66CbuOZIWj46IsquyFiDasgC4ybVfh4sNwOXv/jotczsv1dPKRfp7EZaprgvJXdXGA/qm1z1U14bncR+xHkQp1PcCkdV+5CL27514G3qiEtOVb/hmZyvZj7hNPuFdL4Pw0RWQ02N6GWlE220j1681JuqxqUJv+CEWgRMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mKCn1nrE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00468C116B1;
	Fri, 31 Oct 2025 20:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761942891;
	bh=eaC3FfZxJWWchwEb1p6d5lCoWti7psSYXuw5oCrNqpM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mKCn1nrEXYR+sGYuQPxZG5neXvAlbt0EngVb/GV5zXs8b+1Wc2rkekZzILixCS0Ij
	 2Im4Xkx0kgrfB/SFaa38w5VOmwasbtHrZYFdzD1gn/v4ySgnWf/SSLEtnMwOWJJ/SE
	 MBFD4Z+W9JkdpSaDRItQW/4l7mEUDyq/pgEElBITM4yWKJ0mz89SJbHKjpL9/wvBUO
	 HyXqFLBaZox8WOOMon7PYozUn/DDONnnAqyD/oquhp/jo0VFrrxLf/fyxT753hGEEo
	 eWmFpWl4QJwwRpiyiq7FAe1IUi8OA0UJi0VIFwTrHKvWCArxEIr2aWGePv/okng6+g
	 NUgFx5hG2KfRQ==
Date: Fri, 31 Oct 2025 16:34:46 -0400
From: Nathan Chancellor <nathan@kernel.org>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: LiangCheng Wang <zaq14760@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] drm/tiny: pixpaper: Prevent inlining of send helpers to
 reduce stack usage
Message-ID: <20251031203446.GD2486902@ax162>
References: <20251031-fix_202510270858-v1-1-6b111d475ce2@gmail.com>
 <0d9e5bf4036dc0706fac603764276d2327d0bc69@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d9e5bf4036dc0706fac603764276d2327d0bc69@intel.com>

On Fri, Oct 31, 2025 at 10:40:13AM +0200, Jani Nikula wrote:
> On Fri, 31 Oct 2025, LiangCheng Wang <zaq14760@gmail.com> wrote:
> > Clang reports that pixpaper_panel_hw_init() exceeds the 8 KB stack
> > frame limit:
> >
> >     drivers/gpu/drm/tiny/pixpaper.c:579:12: warning:
> >       stack frame size (20024) exceeds limit (8192)
> >       in 'pixpaper_panel_hw_init'
> >
> > This warning occurs because the compiler aggressively inlines
> > pixpaper_send_cmd() and pixpaper_send_data() into
> > pixpaper_panel_hw_init(), which inflates the estimated stack usage.
> >
> > Mark these two helper functions as 'noinline' to prevent inlining.
> > This significantly reduces the reported stack usage without changing
> > runtime behavior.
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202510270858.1GzE6iQg-lkp@intel.com/
> > Fixes: c9e70639f591 ("drm: tiny: Add support for Mayqueen Pixpaper e-ink panel")
> > Signed-off-by: LiangCheng Wang <zaq14760@gmail.com>
> > ---
> > When building with Clang and frame size warnings enabled
> > (-Wframe-larger-than=8192), the compiler reports that
> > pixpaper_panel_hw_init() consumes over 20 KB of stack space:
> >
> >     drivers/gpu/drm/tiny/pixpaper.c:579:12: warning:
> >       stack frame size (20024) exceeds limit (8192)
> >       in 'pixpaper_panel_hw_init'
> >
> > This happens because Clang aggressively inlines
> > pixpaper_send_cmd() and pixpaper_send_data() into
> > pixpaper_panel_hw_init(), causing the calculated stack usage
> > to balloon far beyond the warning threshold.
> >
> > The fix is straightforward: mark these two helper functions as
> > 'noinline' to prevent inlining. This reduces the reported stack
> > usage to within normal limits without changing runtime behavior.
> 
> I really *really* wish we wouldn't have to go this route at all.
> 
> But if we have to, I think noinline_for_stack is the keyword to use.

For what it's worth, the configuration in the report linked above has
CONFIG_KASAN_STACK=y, which is known to be broken with clang and
requires !COMPILE_TEST to even select it (which the robot should be
using to avoid pathological cases such as this). If I disable
CONFIG_KASAN_STACK, there is no warning even with a 1024 byte limit, so
realistically, I think we can just leave this be.

Cheers,
Nathan

> > ---
> >  drivers/gpu/drm/tiny/pixpaper.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/tiny/pixpaper.c b/drivers/gpu/drm/tiny/pixpaper.c
> > index 32598fb2fee7fcdea3ea0696c2bf54404fcffa2e..70e3239adfd0f86f92551991872486380489fb9b 100644
> > --- a/drivers/gpu/drm/tiny/pixpaper.c
> > +++ b/drivers/gpu/drm/tiny/pixpaper.c
> > @@ -536,7 +536,7 @@ static void pixpaper_spi_sync(struct spi_device *spi, struct spi_message *msg,
> >  		err->errno_code = ret;
> >  }
> >  
> > -static void pixpaper_send_cmd(struct pixpaper_panel *panel, u8 cmd,
> > +static noinline void pixpaper_send_cmd(struct pixpaper_panel *panel, u8 cmd,
> >  			      struct pixpaper_error_ctx *err)
> >  {
> >  	if (err->errno_code)
> > @@ -556,7 +556,7 @@ static void pixpaper_send_cmd(struct pixpaper_panel *panel, u8 cmd,
> >  	pixpaper_spi_sync(panel->spi, &msg, err);
> >  }
> >  
> > -static void pixpaper_send_data(struct pixpaper_panel *panel, u8 data,
> > +static noinline void pixpaper_send_data(struct pixpaper_panel *panel, u8 data,
> >  			       struct pixpaper_error_ctx *err)
> >  {
> >  	if (err->errno_code)
> >
> > ---
> > base-commit: d127176862a93c4b3216bda533d2bee170af5e71
> > change-id: 20251031-fix_202510270858-2e4643b00545
> >
> > Best regards,
> 
> -- 
> Jani Nikula, Intel

