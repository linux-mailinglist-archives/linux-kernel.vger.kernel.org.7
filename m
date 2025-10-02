Return-Path: <linux-kernel+bounces-840202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D857BB3D1B
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 13:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6977325C0C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 11:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51FCE304BC6;
	Thu,  2 Oct 2025 11:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UXYmSuXw"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CDB30F94E
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 11:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759405829; cv=none; b=LCSgy7oDjQ58dBCA8EpsWvN4XvZ5nWN3rA8sJQTWUZ149sBfc+2h3KNEYwNWAMFuaOgkOhRF2tVzfrvpajdHL05sEG+KvCkYeo1dHnBkbb4KUs3XuapoAlVGmC1sbvZARCh/jVBOOM43e4DEuQpYMcOftQiMQEgnAFuOBApUiSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759405829; c=relaxed/simple;
	bh=e846lI4GUrRlmCzbfuyIUQ64r0HkpKJE0dmNFRoRhMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jVz4F0jWrVqi6AJLtChd8QKC1WvGMPukFz+zP2Bi9k6XfxfIf2UV6369If0lARx7tgavQNXIAoH2cLgQ2BAvcRBVp+ThF02t7hG7awdyb6Vuu10M+Xbf8GudYTsXVX19/E66cmm2Dj7/GchRyzxmeEhhuZoRvGKhCMmQHfDU2EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UXYmSuXw; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759405828; x=1790941828;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=e846lI4GUrRlmCzbfuyIUQ64r0HkpKJE0dmNFRoRhMc=;
  b=UXYmSuXwoxFQcY/poeyKn2qUudIP+QcQhyCEp2TZnI4jgV902ygr7CMH
   k8DVaNewqsPA07zWAGauY4k4d3lE9B1mXevjqaA1jAfHDVJWOhWkKTXqP
   +Xbvv+22QCA0opU+0YGIEsmy5B+boutkcIDltJq5CwcjlOS7itCRSVhU2
   KVRgezIpHx1WS6IGwDGMfXVKdbLu533JmZvhYfKYMcftvtyZUq93gPmfs
   zfduELqFbxzDPm+4LVTka5h0Y6V5549UG7THEqkPIwZ0J7S8Zay9XYn4B
   qzA9rSW4WoxG5zn/t/9CA1zk7HsVsnP75N1r1o1GcWzC798VrQTIaDGXi
   A==;
X-CSE-ConnectionGUID: bUga9Ve9R+6LKR7eQaLK7g==
X-CSE-MsgGUID: YudzIMjtR36GyncNaXeBMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="61647195"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="61647195"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 04:50:27 -0700
X-CSE-ConnectionGUID: F7aCYr0aT1S2RHwOL2OtJA==
X-CSE-MsgGUID: GZomKRL3QIyXGFUn6kMYqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,309,1751266800"; 
   d="scan'208";a="183434127"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.245.228])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 04:50:24 -0700
Date: Thu, 2 Oct 2025 14:50:21 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Chintan Patel <chintanlike@gmail.com>
Cc: maarten.lankhorst@linux.intel.com, maxime.ripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	syzbot+147ba789658184f0ce04@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] drm/vblank: downgrade vblank wait timeout from WARN
 to debug
Message-ID: <aN5m_TRNsWSQVtnD@intel.com>
References: <20251002025723.9430-1-chintanlike@gmail.com>
 <aN5klZdl2MZdPSpU@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aN5klZdl2MZdPSpU@intel.com>
X-Patchwork-Hint: comment
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Oct 02, 2025 at 02:40:05PM +0300, Ville Syrjälä wrote:
> On Wed, Oct 01, 2025 at 07:57:23PM -0700, Chintan Patel wrote:
> > When wait_event_timeout() in drm_wait_one_vblank() times out, the
> > current WARN can cause unnecessary kernel panics in environments
> > with panic_on_warn set (e.g. CI, fuzzing). These timeouts can happen
> > under scheduler pressure or from invalid userspace calls, so they are
> > not always a kernel bug.
> 
> "invalid userspace calls" should never reach this far.
> That would be a kernel bug.

I was also wondering how you could get this due to some scheduler
screwup, but I suppose that could theoretically happen with threaded 
irqs, or whatever work/etc is used to update the vblank count on
drivers that don't have hardware interrupts for it. 100+ msec
hw interrupt latency sounds excessive to me though.

But since you reference some syzbot reports below, are you
actually trying to hide real kernel bugs that syzbot found?

> 
> > 
> > Replace the WARN with drm_dbg_kms() messages that provide useful
> > context (last and current vblank counters) without crashing the
> > system. Developers can still enable drm.debug to diagnose genuine
> > problems.
> > 
> > Reported-by: syzbot+147ba789658184f0ce04@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=147ba789658184f0ce04
> > Tested-by: syzbot+147ba789658184f0ce04@syzkaller.appspotmail.com
> > 
> > Signed-off-by: Chintan Patel <chintanlike@gmail.com>
> > 
> > v2:
> >  - Drop unnecessary in-code comment (suggested by Thomas Zimmermann)
> >  - Remove else branch, only log timeout case
> > ---
> >  drivers/gpu/drm/drm_vblank.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
> > index 46f59883183d..a94570668cba 100644
> > --- a/drivers/gpu/drm/drm_vblank.c
> > +++ b/drivers/gpu/drm/drm_vblank.c
> > @@ -1289,7 +1289,7 @@ void drm_wait_one_vblank(struct drm_device *dev, unsigned int pipe)
> >  {
> >  	struct drm_vblank_crtc *vblank = drm_vblank_crtc(dev, pipe);
> >  	int ret;
> > -	u64 last;
> > +	u64 last, curr;
> >  
> >  	if (drm_WARN_ON(dev, pipe >= dev->num_crtcs))
> >  		return;
> > @@ -1305,7 +1305,12 @@ void drm_wait_one_vblank(struct drm_device *dev, unsigned int pipe)
> >  				 last != drm_vblank_count(dev, pipe),
> >  				 msecs_to_jiffies(100));
> >  
> > -	drm_WARN(dev, ret == 0, "vblank wait timed out on crtc %i\n", pipe);
> > +	curr = drm_vblank_count(dev, pipe);
> > +
> > +	if (ret == 0) {
> > +		drm_dbg_kms(dev, "WAIT_VBLANK: timeout crtc=%d, last=%llu, curr=%llu\n",
> > +			pipe, last, curr);
> 
> It should at the very least be a drm_err(). Though the backtrace can
> be useful in figuring out where the problem is coming from, so not
> too happy about this change.
> 
> > +	}
> >  
> >  	drm_vblank_put(dev, pipe);
> >  }
> > -- 
> > 2.43.0
> 
> -- 
> Ville Syrjälä
> Intel

-- 
Ville Syrjälä
Intel

