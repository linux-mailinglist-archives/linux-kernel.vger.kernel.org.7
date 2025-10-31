Return-Path: <linux-kernel+bounces-879738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11292C23DAA
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 09:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFF82188328B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 08:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2402EC0B9;
	Fri, 31 Oct 2025 08:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QKM4FtVO"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676452236E9
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 08:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761900023; cv=none; b=e4nxDFb9cKMxyuf2TI1Nf1OMG0zdYfSnHrfLi4Yj6iFkfRATyu8DKLr7sHCMPZPd54BYh6+tUn72l4ZAjQ7PNbn+K9opf4AC89BJBf3D8Bq6XSBbdUiVtzWfAaKYd0nDWoA4Z4lMuYbZJh0PqVJMyReyXdEyPAkApvgCu7shr0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761900023; c=relaxed/simple;
	bh=lEobPRPLUtvLJgGm6D2oVp+iskg4CGJ/ERaKYRsF7Q8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=idsKyc1/lX1Y1WXNFDFtYJKlj7k8nK+39j2eBlHJx3yeXXAp4mK/OILHO7dsXBMmgW7P1H8OOuLSh9H4YdsKX1As9tyItKPbNEoYHr2NyXHjkdnq3wU+UbHtXObAUxtKFC728Efdr0bVDpZuG+bIXHJVLTIx9iy0X39rFz2nXQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QKM4FtVO; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761900021; x=1793436021;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=lEobPRPLUtvLJgGm6D2oVp+iskg4CGJ/ERaKYRsF7Q8=;
  b=QKM4FtVO90neArAmc9GFTDlI69bHOb++BDa9RfAwQpTFS26WwqX4Gkqx
   +7O+sOVBSf7k+4PCW/WLei4ALiD9/Foy2fOdqY3TMyqpyfLpthR+sqsTI
   61r2mfewPpmnWkfTct+XvDjkGAAlJiBX6sFUs7v8+8ofu84VKF7VwAnNF
   h7+IvpC8HC0WXTJkiGKhENrSWMHh9Za/lfmk1STpxglrF04CBtzWlRxla
   OAFfy8UhHgSeGPFrqt4oLwOzlPaUfayjjp9sPfqr38JXaxuUXCxtiSbub
   Cp0iQUtFoB6DLnHNA+vwwL7KXtHpoB9Cb2QwJjUYdDxReDjbM/+APajB/
   w==;
X-CSE-ConnectionGUID: 74etEsbpTYaNjwhgSEJDOA==
X-CSE-MsgGUID: ghK7Vvm7TZa41xAPBSt8DA==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="75505594"
X-IronPort-AV: E=Sophos;i="6.19,268,1754982000"; 
   d="scan'208";a="75505594"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 01:40:21 -0700
X-CSE-ConnectionGUID: qkmpKIy1S6uCeUj21pgabA==
X-CSE-MsgGUID: VyVZpSNZQkeGHUAbFOUW1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,268,1754982000"; 
   d="scan'208";a="185388996"
Received: from carterle-desk.ger.corp.intel.com (HELO localhost) ([10.245.246.37])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 01:40:16 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: LiangCheng Wang <zaq14760@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, kernel test robot <lkp@intel.com>, LiangCheng Wang
 <zaq14760@gmail.com>
Subject: Re: [PATCH] drm/tiny: pixpaper: Prevent inlining of send helpers to
 reduce stack usage
In-Reply-To: <20251031-fix_202510270858-v1-1-6b111d475ce2@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20251031-fix_202510270858-v1-1-6b111d475ce2@gmail.com>
Date: Fri, 31 Oct 2025 10:40:13 +0200
Message-ID: <0d9e5bf4036dc0706fac603764276d2327d0bc69@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, 31 Oct 2025, LiangCheng Wang <zaq14760@gmail.com> wrote:
> Clang reports that pixpaper_panel_hw_init() exceeds the 8 KB stack
> frame limit:
>
>     drivers/gpu/drm/tiny/pixpaper.c:579:12: warning:
>       stack frame size (20024) exceeds limit (8192)
>       in 'pixpaper_panel_hw_init'
>
> This warning occurs because the compiler aggressively inlines
> pixpaper_send_cmd() and pixpaper_send_data() into
> pixpaper_panel_hw_init(), which inflates the estimated stack usage.
>
> Mark these two helper functions as 'noinline' to prevent inlining.
> This significantly reduces the reported stack usage without changing
> runtime behavior.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202510270858.1GzE6iQg-lkp@intel.com/
> Fixes: c9e70639f591 ("drm: tiny: Add support for Mayqueen Pixpaper e-ink panel")
> Signed-off-by: LiangCheng Wang <zaq14760@gmail.com>
> ---
> When building with Clang and frame size warnings enabled
> (-Wframe-larger-than=8192), the compiler reports that
> pixpaper_panel_hw_init() consumes over 20 KB of stack space:
>
>     drivers/gpu/drm/tiny/pixpaper.c:579:12: warning:
>       stack frame size (20024) exceeds limit (8192)
>       in 'pixpaper_panel_hw_init'
>
> This happens because Clang aggressively inlines
> pixpaper_send_cmd() and pixpaper_send_data() into
> pixpaper_panel_hw_init(), causing the calculated stack usage
> to balloon far beyond the warning threshold.
>
> The fix is straightforward: mark these two helper functions as
> 'noinline' to prevent inlining. This reduces the reported stack
> usage to within normal limits without changing runtime behavior.

I really *really* wish we wouldn't have to go this route at all.

But if we have to, I think noinline_for_stack is the keyword to use.


BR,
Jani.

> ---
>  drivers/gpu/drm/tiny/pixpaper.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/tiny/pixpaper.c b/drivers/gpu/drm/tiny/pixpaper.c
> index 32598fb2fee7fcdea3ea0696c2bf54404fcffa2e..70e3239adfd0f86f92551991872486380489fb9b 100644
> --- a/drivers/gpu/drm/tiny/pixpaper.c
> +++ b/drivers/gpu/drm/tiny/pixpaper.c
> @@ -536,7 +536,7 @@ static void pixpaper_spi_sync(struct spi_device *spi, struct spi_message *msg,
>  		err->errno_code = ret;
>  }
>  
> -static void pixpaper_send_cmd(struct pixpaper_panel *panel, u8 cmd,
> +static noinline void pixpaper_send_cmd(struct pixpaper_panel *panel, u8 cmd,
>  			      struct pixpaper_error_ctx *err)
>  {
>  	if (err->errno_code)
> @@ -556,7 +556,7 @@ static void pixpaper_send_cmd(struct pixpaper_panel *panel, u8 cmd,
>  	pixpaper_spi_sync(panel->spi, &msg, err);
>  }
>  
> -static void pixpaper_send_data(struct pixpaper_panel *panel, u8 data,
> +static noinline void pixpaper_send_data(struct pixpaper_panel *panel, u8 data,
>  			       struct pixpaper_error_ctx *err)
>  {
>  	if (err->errno_code)
>
> ---
> base-commit: d127176862a93c4b3216bda533d2bee170af5e71
> change-id: 20251031-fix_202510270858-2e4643b00545
>
> Best regards,

-- 
Jani Nikula, Intel

