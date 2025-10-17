Return-Path: <linux-kernel+bounces-858407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 70AC0BEACAA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 18:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 564E65A2A03
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6880A29BD90;
	Fri, 17 Oct 2025 16:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JhRrWIif"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D708B28312E;
	Fri, 17 Oct 2025 16:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760717772; cv=none; b=p9nfryvGvkTLkIU3CZDd08MLYf+GDbfmnTJWYfRVvw+XxCUEg40vs5ZCW71EVnVZCH/EFcpEn4vMu8bv5ZWJHBUUUHyECTA+wQbWZEU0IyWEc+Dyc/UdgwkWjWNEprmpijUdiy/HmbqPG+Jc0MBGCA2JoVMUYCjfuHNs18vHNqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760717772; c=relaxed/simple;
	bh=HAk5XarQfseeqeP7zVYEUF8QINQ4zYPsmcKTZ1AN/VI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j1ARuL9GSRVlga2S1PVwGmIBBiws/vc7j3ZDRhWWTCixieAlhbR+j14yUEXmhAITYb8glp+gMw/mieNHi3X6BX3rPQAVrgcDW2d8UI9a4OhDJubeEesC0mygscCElilvVS9FzDchXNMaBNj6zgSdUVXekbBJCGa3I1o8oSpAtkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JhRrWIif; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760717771; x=1792253771;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=HAk5XarQfseeqeP7zVYEUF8QINQ4zYPsmcKTZ1AN/VI=;
  b=JhRrWIif2EBbxV2f13ZNtXvlOttnJVHiiUvAe510mBWwvMmSzFlkYM+Z
   E0Z98N6xNKZRMR3dj1Gky1Sw2EZ7WiUy+tMyKYqJyGcrniYejW7o2S6Sk
   6OvNi4PsXOl57+bZGA+KF0Zr8j70yL4ZM/s1wXF1nYDTFWztv+xCoW9bJ
   3Bb7yNxj7rRFcJ/jXxkwdA7HA1MOARnCyMVP1ou+xpdIepD5xOw9L6Nng
   KEYYQQvF3hIHSHZuL8L2QUqH3KX7O6pkK+SpzAiYqq5hGYO9PRC0JRJ0O
   HkvBD+DtpkC/tbdV44kxfgcvmO3JuMCMFe41HSlvKSfuefoICJd3G7kNO
   w==;
X-CSE-ConnectionGUID: acaoi076QSmzrV1vHFE54A==
X-CSE-MsgGUID: t5IAMHs0Rm6fM7n3ajvYsg==
X-IronPort-AV: E=McAfee;i="6800,10657,11585"; a="62978112"
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; 
   d="scan'208";a="62978112"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2025 09:15:53 -0700
X-CSE-ConnectionGUID: zrBRjgAaQuOVNryk6/wZVA==
X-CSE-MsgGUID: XToEUZ7rRImx/pOoImC1/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; 
   d="scan'208";a="182712153"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.129])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2025 09:15:50 -0700
Date: Fri, 17 Oct 2025 19:15:47 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] drm/sysfb: Fix a NULL vs IS_ERR() bug
Message-ID: <aPJrs7_u8KcalNsC@intel.com>
References: <aPJo1W5Dl4rmGX_P@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aPJo1W5Dl4rmGX_P@stanley.mountain>
X-Patchwork-Hint: comment
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Oct 17, 2025 at 07:03:33PM +0300, Dan Carpenter wrote:
> The drm_atomic_get_crtc_state() function never returns NULL, it returns
> error pointers.  Update the error checking to match.
> 
> Fixes: cb71de092553 ("drm/sysfb: Lookup blit function during atomic check")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/gpu/drm/sysfb/drm_sysfb_modeset.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/sysfb/drm_sysfb_modeset.c b/drivers/gpu/drm/sysfb/drm_sysfb_modeset.c
> index 8517c490e815..d2c4d8f3d4d0 100644
> --- a/drivers/gpu/drm/sysfb/drm_sysfb_modeset.c
> +++ b/drivers/gpu/drm/sysfb/drm_sysfb_modeset.c
> @@ -259,7 +259,7 @@ int drm_sysfb_plane_helper_begin_fb_access(struct drm_plane *plane,
>  	ret = -EINVAL;
>  
>  	crtc_state = drm_atomic_get_crtc_state(plane_state->state, plane_state->crtc);

Looking at where this gets called, that should be
drm_atomic_get_new_crtc_state(). Either that or the
code is more seriously borked.

I'll send out a patch that warns about invalid use of 
*_get_state()...

> -	if (drm_WARN_ON_ONCE(dev, !crtc_state))
> +	if (drm_WARN_ON_ONCE(dev, IS_ERR(crtc_state)))
>  		goto err_drm_gem_end_shadow_fb_access;
>  	sysfb_crtc_state = to_drm_sysfb_crtc_state(crtc_state);
>  
> -- 
> 2.51.0

-- 
Ville Syrjälä
Intel

