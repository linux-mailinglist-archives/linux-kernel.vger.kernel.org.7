Return-Path: <linux-kernel+bounces-829028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 818A8B96177
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 15:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14FE8188674B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 13:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A491FDE01;
	Tue, 23 Sep 2025 13:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RAX4jeqN"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAACF8834
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 13:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758635510; cv=none; b=ktUErmDfiLwfv0rfMJ/xKH74z6RSQCEom/6ZThJD+up751UrQnu+h9i2S1iJvDr9uuhH6IPpyZfOb9/vsVI1Re1ZgvrGkazkmd6dteDe0GSf038q7JnTgJzafSmBPOg/B6fwHx/XuCA5pZCRyzZrY1+RXxxtnPpznufRJDTBaCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758635510; c=relaxed/simple;
	bh=KNsHfCNP5BcDpTQ3p9SIHGa9nh0HGDtnumDcWKGG+V0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Xhh7plPmGzFFNUj0kFr19eSMecWcGH9mmiOQ/g5Q5fLomexeOEPElgU2GeEZ1LnlgDIUFjMpGvamd9vniBJXk16DI8FpFsbwa6OPGXNo7xu9JWLstvb22vlGVDOgAHfeqfSHAUn/K/DGeWXJY+LQYHVCVUISp6SrP4298p8QUaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RAX4jeqN; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758635508; x=1790171508;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=KNsHfCNP5BcDpTQ3p9SIHGa9nh0HGDtnumDcWKGG+V0=;
  b=RAX4jeqNntM/TQJNLrnfQhBVknl2M8vRfd8xNKP/KVQZFD05LHFUC41Q
   weIryhpGfJj3C8zbTLQx3N+LulO/747kGUejHeLysNroAcReI+DyquPGb
   7sPBye9mXhFTuBtdSyCDh3XsOFLFSwJezXHzGhiO80HOi7X/9UizrfUFn
   Lzln4bX7M9ZkB43TE96cAPbS15wKlRatmrXf3LO/nCf4id2Iu7XyN2ZXm
   f073L//Zo5xm+o8G4/uUx9aqreXZ+uI3ROywXyIMZALXuavczn6722yi6
   /pKPkmmRqCBpe44G/CIj7XtSPA0JecoOnrl/XGrDZV2lNEMXME954WP6t
   A==;
X-CSE-ConnectionGUID: gyziRBxkTY6Bi0E5k6VaLA==
X-CSE-MsgGUID: 9jqPRAzSQi2oxvQH2XAgbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="64550598"
X-IronPort-AV: E=Sophos;i="6.18,288,1751266800"; 
   d="scan'208";a="64550598"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2025 06:51:47 -0700
X-CSE-ConnectionGUID: NPFOkG42QwKwZ+wCXwUQmg==
X-CSE-MsgGUID: ae/oMbIkS7me6pQQdxZZ3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,288,1751266800"; 
   d="scan'208";a="181940449"
Received: from mwiniars-desk2.ger.corp.intel.com (HELO localhost) ([10.245.246.94])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2025 06:51:43 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Rahul Kumar <rk0006818@gmail.com>, lanzano.alex@gmail.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org, skhan@linuxfoundation.org,
 rk0006818@gmail.com
Subject: Re: [PATCH] drm/tiny: Use kmalloc_array() instead of kmalloc()
In-Reply-To: <20250923110025.1358920-1-rk0006818@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20250923110025.1358920-1-rk0006818@gmail.com>
Date: Tue, 23 Sep 2025 16:51:40 +0300
Message-ID: <712a27fc6c4060e67b3da58cb8564387b40b5971@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, 23 Sep 2025, Rahul Kumar <rk0006818@gmail.com> wrote:
> Documentation/process/deprecated.rst recommends against the use of
> kmalloc with dynamic size calculations due to the risk of overflow and
> smaller allocation being made than the caller was expecting.
>
> Replace kmalloc() with kmalloc_array() in drivers/gpu/drm/tiny/repaper.c
> to make the intended allocation size clearer and avoid potential overflow
> issues.
>
> Signed-off-by: Rahul Kumar <rk0006818@gmail.com>
> ---
>  drivers/gpu/drm/tiny/repaper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/tiny/repaper.c b/drivers/gpu/drm/tiny/repaper.c
> index 5c3b51eb0a97..4d439a2d973a 100644
> --- a/drivers/gpu/drm/tiny/repaper.c
> +++ b/drivers/gpu/drm/tiny/repaper.c
> @@ -535,7 +535,7 @@ static int repaper_fb_dirty(struct drm_framebuffer *fb,
>  	DRM_DEBUG("Flushing [FB:%d] st=%ums\n", fb->base.id,
>  		  epd->factored_stage_time);
>  
> -	buf = kmalloc(fb->width * fb->height / 8, GFP_KERNEL);
> +	buf = kmalloc_array(fb->width, fb->height / 8, GFP_KERNEL);

That's just not the same thing, though.

BR,
Jani.

>  	if (!buf) {
>  		ret = -ENOMEM;
>  		goto out_exit;

-- 
Jani Nikula, Intel

