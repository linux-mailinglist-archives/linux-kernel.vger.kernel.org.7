Return-Path: <linux-kernel+bounces-856627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D5ACDBE4A53
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 18:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EB9B5563B9F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 16:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7389532AABE;
	Thu, 16 Oct 2025 16:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="czJoN3ru"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0400132AAC9
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 16:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760632808; cv=none; b=UE9EMM4/tQt5w2Lv9sIm0L7kq1eO/aB6ovN6htgf3+sYMu1ubKF5k4HZvA7qE7d7/3+c51Jj9hOUWh7mrApLZQMDei07rnmPx+UTXuQoO0s4Pmk7R4PicgEbKpGyqBZH+nadFOd03UO8MCoiBcHcAA+SU2gj2HT9N8nRtbPGupQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760632808; c=relaxed/simple;
	bh=prjvjz+M/7rr2btEt2k6ouVNhEZHrzAdMAghfFQAIrA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QH8z4ZyZmqI+MEzb6JphmTAvq7zLAdXnM+SlZa3ll+8CdSfUDiNoMQZHzaz2XkBQDLloGknGSvfg5+hLN/HG2q2wKZ6wINxE1rFqFmWbw3RKbU7yOe8E9gBdbMN4UMWZ46qT+Vgu+FcIxrdhd66L4DH2vBYbO2SuJvaAE7QPpmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=czJoN3ru; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760632807; x=1792168807;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=prjvjz+M/7rr2btEt2k6ouVNhEZHrzAdMAghfFQAIrA=;
  b=czJoN3ruZblWyL7u9kXbgyF94glc5VQ0wjjc+J0ot3SYpCFWe+bgPh/G
   ZXaDsj7dnhboE9uoFvjlCqPYowxnq46CIiXPpZ0JRyudFo02TC/H/tEOI
   YlNwlxKtJqJWDqGQUWU0MQLvl5n+UbTIZvHkJ5kDio9wdVbs5KlPO+TuV
   E9wDQqV8iknvK2uAPipEugkbvPi1Jjkci22Pg20tD3WZac9gcKISB1qIt
   ApUh0+xaFoHUGu+cozOi0qMxB9dpN9buMWX+6mPXSGIFEUEL65sszJbfR
   2dhm/P3918fb2SUvaTgTTlilaCd187Qc/8yblbYl2kSNDUuLq9c59nSS2
   w==;
X-CSE-ConnectionGUID: NT90TqNBQ1+QB9SjvUWpng==
X-CSE-MsgGUID: Crl1uriZQs6udu2xpl1MLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="74176723"
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="74176723"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 09:40:05 -0700
X-CSE-ConnectionGUID: d6aGCxqXSIuq0+rX+521og==
X-CSE-MsgGUID: O3GEdB1FQsSNk/Pamay9jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="187781454"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.246.155])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 09:40:00 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Yaroslav Bolyukin <iam@lach.pw>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>, Alex Deucher
 <alexander.deucher@amd.com>, Christian =?utf-8?Q?K=C3=B6nig?=
 <christian.koenig@amd.com>,
 Wayne Lin <Wayne.Lin@amd.com>, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Yaroslav
 Bolyukin <iam@lach.pw>
Subject: Re: [PATCH v4 2/2] drm/amd: use fixed dsc bits-per-pixel from edid
In-Reply-To: <20251016001038.13611-6-iam@lach.pw>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20251016001038.13611-2-iam@lach.pw>
 <20251016001038.13611-6-iam@lach.pw>
Date: Thu, 16 Oct 2025 19:39:57 +0300
Message-ID: <34407e8d423f0d00e949ba8c6b209cb88e8f5414@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, 16 Oct 2025, Yaroslav Bolyukin <iam@lach.pw> wrote:
> VESA vendor header from DisplayID spec may contain fixed bit per pixel
> rate, it should be respected by drm driver
>
> Signed-off-by: Yaroslav Bolyukin <iam@lach.pw>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 0d03e324d5b9..ebe5bb4eecf8 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -6521,6 +6521,11 @@ static void fill_stream_properties_from_drm_display_mode(
>  
>  	stream->output_color_space = get_output_color_space(timing_out, connector_state);
>  	stream->content_type = get_output_content_type(connector_state);
> +
> +	/* DisplayID Type VII pass-through timings. */
> +	if (mode_in->dsc_passthrough_timings_support && info->dp_dsc_bpp != 0) {
> +		stream->timing.dsc_fixed_bits_per_pixel_x16 = info->dp_dsc_bpp;
> +	}

If we had mode->dp_dsc_bpp_x16 directly, or something better named, this
would be simpler. This will eventually be replicated in a bunch of
drivers.

BR,
Jani.

>  }
>  
>  static void fill_audio_info(struct audio_info *audio_info,
> @@ -7067,6 +7072,13 @@ create_stream_for_sink(struct drm_connector *connector,
>  					&mode, preferred_mode, scale);
>  
>  			preferred_refresh = drm_mode_vrefresh(preferred_mode);
> +
> +			/*
> +			 * HACK: In case of multiple supported modes, we should look at the matching mode to decide this flag.
> +			 * But what is matching mode, how should it be decided?
> +			 * Assuming that only preferred mode would have this flag.
> +			 */
> +			mode.dsc_passthrough_timings_support = preferred_mode->dsc_passthrough_timings_support;
>  		}
>  	}
>  
> @@ -7756,7 +7768,7 @@ create_validate_stream_for_sink(struct drm_connector *connector,
>  			drm_dbg_kms(connector->dev, "%s:%d Validation failed with %d, retrying w/ YUV420\n",
>  				    __func__, __LINE__, dc_result);
>  			aconnector->force_yuv420_output = true;
> -		}
> +}
>  		stream = create_validate_stream_for_sink(connector, drm_mode,
>  							 dm_state, old_stream);
>  		aconnector->force_yuv422_output = false;

-- 
Jani Nikula, Intel

