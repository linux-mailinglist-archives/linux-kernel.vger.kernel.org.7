Return-Path: <linux-kernel+bounces-840191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 720F9BB3CBB
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 13:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38B0E7AF85F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 11:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC8230FC26;
	Thu,  2 Oct 2025 11:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cG/7F70V"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DE13093BF
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 11:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759405213; cv=none; b=WLjnu3MVK9thCU/77gA/mxMjzCEm7LOnp18le/18W89tb8AC9fZ/lCugqd7pmcphKdtPp+U8p7PtD3lwGdHm8KKhducbwx21Yb4RTeAjqB0/NN5gOqfWlPkwaG+vMflhpXNOovSr5AYl44e3CuEpYVMYsJ2kHQ3O49CGYV9aMrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759405213; c=relaxed/simple;
	bh=vWzodoQgqiLu0pXyZfRnw5dcWNrHKmXYDfqUz9i4RoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fi9P2myNgUmcg6HZu4sFeakP7u07eIkdtLVykzuR5JrCl5NCGpn/nEUWcnNQJICGE8qYb2TKzltDdx/37BMhoN8xMqIlhhbT//S9NL4xcml9PTpJlbR92hvV3HkYNLmLqgOtQrpKUxlxCk9LfeBkjG9zNaWYX1C5c2Oge3WLoyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cG/7F70V; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759405212; x=1790941212;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=vWzodoQgqiLu0pXyZfRnw5dcWNrHKmXYDfqUz9i4RoU=;
  b=cG/7F70VZCEvAA1lkFPdCxYIX4hHF/LpXHbyaAQ+yyiFlBWw+9qbeCzS
   6MvnQ3/iVHs3pseRhl5EMCfGP6hvEuPMHjNSF+lrChp1iC5Zf1cxZpoFK
   NpmqntC7I717CWCXzI6lqnqReVL66aQRlx+5xCVMVWgVhW/gLD29cy8Z5
   9svG0OY91RbTStolgWfGkkSliOmWWV9TprBrKT/PHS8OTtgA8RDZP6Km0
   58zQaUjyr1+Wvn6Zuo6DWLaX5N6morC0sKbwxH+qh0gaKthdUghYBS3Gu
   CUJJU99YgyfbbY+Xt1vbBa3hDUBswlZ9DStk7MDOZIRbjerkLwrJkKGs2
   A==;
X-CSE-ConnectionGUID: /QHSXoD3QLe0SXK4tMiTfg==
X-CSE-MsgGUID: 1etkicwFRPuWdqndMIaCnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="79337986"
X-IronPort-AV: E=Sophos;i="6.18,309,1751266800"; 
   d="scan'208";a="79337986"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 04:40:11 -0700
X-CSE-ConnectionGUID: vyYSF09PRJaTpofzcJnjDg==
X-CSE-MsgGUID: O9GCZXuXTjWwkrgSjbrZVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,309,1751266800"; 
   d="scan'208";a="183321130"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.245.228])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 04:40:08 -0700
Date: Thu, 2 Oct 2025 14:40:05 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Chintan Patel <chintanlike@gmail.com>
Cc: maarten.lankhorst@linux.intel.com, maxime.ripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	syzbot+147ba789658184f0ce04@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] drm/vblank: downgrade vblank wait timeout from WARN
 to debug
Message-ID: <aN5klZdl2MZdPSpU@intel.com>
References: <20251002025723.9430-1-chintanlike@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251002025723.9430-1-chintanlike@gmail.com>
X-Patchwork-Hint: comment
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Oct 01, 2025 at 07:57:23PM -0700, Chintan Patel wrote:
> When wait_event_timeout() in drm_wait_one_vblank() times out, the
> current WARN can cause unnecessary kernel panics in environments
> with panic_on_warn set (e.g. CI, fuzzing). These timeouts can happen
> under scheduler pressure or from invalid userspace calls, so they are
> not always a kernel bug.

"invalid userspace calls" should never reach this far.
That would be a kernel bug.

> 
> Replace the WARN with drm_dbg_kms() messages that provide useful
> context (last and current vblank counters) without crashing the
> system. Developers can still enable drm.debug to diagnose genuine
> problems.
> 
> Reported-by: syzbot+147ba789658184f0ce04@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=147ba789658184f0ce04
> Tested-by: syzbot+147ba789658184f0ce04@syzkaller.appspotmail.com
> 
> Signed-off-by: Chintan Patel <chintanlike@gmail.com>
> 
> v2:
>  - Drop unnecessary in-code comment (suggested by Thomas Zimmermann)
>  - Remove else branch, only log timeout case
> ---
>  drivers/gpu/drm/drm_vblank.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
> index 46f59883183d..a94570668cba 100644
> --- a/drivers/gpu/drm/drm_vblank.c
> +++ b/drivers/gpu/drm/drm_vblank.c
> @@ -1289,7 +1289,7 @@ void drm_wait_one_vblank(struct drm_device *dev, unsigned int pipe)
>  {
>  	struct drm_vblank_crtc *vblank = drm_vblank_crtc(dev, pipe);
>  	int ret;
> -	u64 last;
> +	u64 last, curr;
>  
>  	if (drm_WARN_ON(dev, pipe >= dev->num_crtcs))
>  		return;
> @@ -1305,7 +1305,12 @@ void drm_wait_one_vblank(struct drm_device *dev, unsigned int pipe)
>  				 last != drm_vblank_count(dev, pipe),
>  				 msecs_to_jiffies(100));
>  
> -	drm_WARN(dev, ret == 0, "vblank wait timed out on crtc %i\n", pipe);
> +	curr = drm_vblank_count(dev, pipe);
> +
> +	if (ret == 0) {
> +		drm_dbg_kms(dev, "WAIT_VBLANK: timeout crtc=%d, last=%llu, curr=%llu\n",
> +			pipe, last, curr);

It should at the very least be a drm_err(). Though the backtrace can
be useful in figuring out where the problem is coming from, so not
too happy about this change.

> +	}
>  
>  	drm_vblank_put(dev, pipe);
>  }
> -- 
> 2.43.0

-- 
Ville Syrjälä
Intel

