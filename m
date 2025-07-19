Return-Path: <linux-kernel+bounces-737856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DFA6B0B14E
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 20:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02DEB16A9D3
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 18:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CAC72264D7;
	Sat, 19 Jul 2025 18:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ne+csaHt"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F643A923
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 18:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752949393; cv=none; b=Lt9Vo2v4JSzsA6AnhN4Lc8cM6CYXmoGUmokU0jk6Y5iOzliI1kYj6zI2A+bMh2/F4SRVPYqlZTdZkzdFzxlfNrl7byN2ioq8lzT6NiuoOEAmMiyTboEf8gVORPQt0TpfhGc0U7QRvooOPSTLPbU8tPmtJJcmfeEHXknsOeLyOzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752949393; c=relaxed/simple;
	bh=norkHxz8yxnk58XydmAoXQnBoaw/0mN9mBKqltfKkiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SLKoQvwvDSwksDpVDS+f0dxUQJfb6G3IiVPi/0XJShyU96GMTG+2v8uPCW5zs5CQMvQSEnPYeh3yYHMSpOYPctQiE7qOlqzAWdnSP3+kvPuo18wInnGN0X6CHfQYqnvimQqkDjHIdz4yIn623mmhF7egobxQSpkPqGe1Nmss4J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ne+csaHt; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752949391; x=1784485391;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=norkHxz8yxnk58XydmAoXQnBoaw/0mN9mBKqltfKkiU=;
  b=ne+csaHtjbmmiRYieT3eWGRngZu8DUEixqJ60OLs9NmZh30QHnkzR3kZ
   yY7yNlckXspd4V/LyuYwBGocCGX8A0hKwkobmKM9qnwLor6r8XkAWJrxt
   dtsKp+03ajdJM2KCm9dca4esOUJaghmJTOVVtrBIzIu3bG0GU4vOjJcJk
   aqDgZACjhdacQf6c3CZ210v9DSdBTxx+B53qxa1H3dQlLGao8HR/Cf/3M
   ZKHkXotMfAsCoL8r4peThWmfIqZiKkYmgUYw4LipY+3MnrUz89iNbnq/e
   hD6KSzyuushFo8a/JwB3aiyqDyV2kgLgJuCDujCZKRbWnNv/F4PIITT1Z
   Q==;
X-CSE-ConnectionGUID: pc91SuEuTtWESzqSohH5lA==
X-CSE-MsgGUID: sDdiaA5gTXmIpu9LOCAV6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11497"; a="55304361"
X-IronPort-AV: E=Sophos;i="6.16,324,1744095600"; 
   d="scan'208";a="55304361"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2025 11:23:11 -0700
X-CSE-ConnectionGUID: MlmxtoMwTl2ma06tPXyaGg==
X-CSE-MsgGUID: eJ4hZavaRu+uyYInUO9f7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,324,1744095600"; 
   d="scan'208";a="164120833"
Received: from sschumil-mobl2.ger.corp.intel.com (HELO stinkbox) ([10.245.245.152])
  by orviesa005.jf.intel.com with SMTP; 19 Jul 2025 11:23:05 -0700
Received: by stinkbox (sSMTP sendmail emulation); Sat, 19 Jul 2025 21:23:04 +0300
Date: Sat, 19 Jul 2025 21:23:04 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Jocelyn Falempe <jfalempe@redhat.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Christian Koenig <christian.koenig@amd.com>,
	Huang Rui <ray.huang@amd.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 03/10] drm/i915/display/i9xx: Add a disable_tiling()
 for i9xx planes
Message-ID: <aHviiKb0EnQbNksL@intel.com>
References: <20250618094011.238154-1-jfalempe@redhat.com>
 <20250618094011.238154-4-jfalempe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250618094011.238154-4-jfalempe@redhat.com>
X-Patchwork-Hint: comment

On Wed, Jun 18, 2025 at 11:31:21AM +0200, Jocelyn Falempe wrote:
> drm_panic draws in linear framebuffer, so it's easier to re-use the
> current framebuffer, and disable tiling in the panic handler, to show
> the panic screen.
> This assumes that the alignment restriction is always smaller in
> linear than in tiled.
> It also assumes that the linear framebuffer size is always smaller
> than the tiled.
> 
> Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
> ---
> 
> v7:
>  * Reword commit message about alignment/size when disabling tiling (Ville Syrjälä)
> 
>  drivers/gpu/drm/i915/display/i9xx_plane.c     | 23 +++++++++++++++++++
>  .../drm/i915/display/intel_display_types.h    |  2 ++
>  2 files changed, 25 insertions(+)
> 
> diff --git a/drivers/gpu/drm/i915/display/i9xx_plane.c b/drivers/gpu/drm/i915/display/i9xx_plane.c
> index 8f15333a4b07..0807fae12450 100644
> --- a/drivers/gpu/drm/i915/display/i9xx_plane.c
> +++ b/drivers/gpu/drm/i915/display/i9xx_plane.c
> @@ -905,6 +905,27 @@ static const struct drm_plane_funcs i8xx_plane_funcs = {
>  	.format_mod_supported_async = intel_plane_format_mod_supported_async,
>  };
>  
> +static void i9xx_disable_tiling(struct intel_plane *plane)
> +{
> +	struct intel_display *display = to_intel_display(plane);
> +	enum i9xx_plane_id i9xx_plane = plane->i9xx_plane;
> +	u32 dspcntr;
> +	u32 reg;
> +
> +	dspcntr = intel_de_read_fw(display, DSPCNTR(display, i9xx_plane));
> +	dspcntr &= ~DISP_TILED;
> +	intel_de_write_fw(display, DSPCNTR(display, i9xx_plane), dspcntr);
> +
> +	if (DISPLAY_VER(display) >= 4) {
> +		reg = intel_de_read_fw(display, DSPSURF(display, i9xx_plane));
> +		intel_de_write_fw(display, DSPSURF(display, i9xx_plane), reg);
> +
> +	} else {
> +		reg = intel_de_read_fw(display, DSPADDR(display, i9xx_plane));
> +		intel_de_write_fw(display, DSPADDR(display, i9xx_plane), reg);
> +	}
> +}

I thought I already shot this down before, but apparently this
got merged now :(

Just to reiterate why we don't want these 'disable tiling' hacks:
- different tiling formats have different stride/alignment/watermark
  requirements so one can't safely change from one tiling to another
- this completely fails to account for the TILEOFF vs. LINOFF stuff
- etc.

So IMO these hacks must be removed and instead the code must learn how
to propetly write the tiled data. igt has all the code for that btw
(twice over IIRC) so shouldn't be that hard.

I suppose the only hack we need to keep is to disable compression,
mainly because (IIRC) on flat CCS systems the CPU doesn't have access
to the AUX data to clear it manually.

I also wonder if there are actual igts for this? I think what is needed
is a test that sets random things (different panning, rotation, pixel
foramts, etc.) and triggers the dumper. Not quite sure how the test
could validate that the output is correct though. CRCs might be a bit
tricky since you need an identical reference image.

/me off to summer vacation. Good luck

-- 
Ville Syrjälä
Intel

