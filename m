Return-Path: <linux-kernel+bounces-759388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9EFB1DCE3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 20:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D4D17B189C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 18:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0035225409;
	Thu,  7 Aug 2025 18:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c5aEubFw"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8837C20299E
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 18:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754590089; cv=none; b=NeHP5D/qwHlRoiBepkUJNwIihQ6gSLuCJv9cFWhylfDmPd/w2gcMPM7Mju7TTJ5PN+WC+Iud0UCeS761ZrKYKuqSRA7yt701znWQ71mgF0RdLAR5EsIr34o3vaMuXKM/jG7EoDMi1nesWlWCkBOKUsBc0oP8v7KBi4uqhkILwlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754590089; c=relaxed/simple;
	bh=7H1rVpWbf3l5tKQbNYZlhGFORV7o9SDgT/R+Vfl2LkU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IB20gzfkiGzcA0629auUUxawYBk7vl3ogojOBRoMXOQ4OT8dno5rIcpZ3LZjvnIvy1kKVIDfXBxAMdSuaZCwyyjFT5lieiU3PkUFIUI8cbmL5nJVyXaXn/S2oXMsjdlkJWRJtnt7FBhuRKLGFHoMQ4c7y30jaPMUW0YppoQzg7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c5aEubFw; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754590088; x=1786126088;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=7H1rVpWbf3l5tKQbNYZlhGFORV7o9SDgT/R+Vfl2LkU=;
  b=c5aEubFwgFThRFjhsSDhvcFy6rNpLaP5u+O7iR65M1CEXNANulknkWhJ
   Bz/Z4k1e+g6JZxAAxgQPwsd8upjYC8qyMXFkNNGizSqFKeBpaf6JUploo
   ZFrCds4HahRBZi06Zhc9c2a3ntmn22zis1c5m+i70BrTtyB9HFNxcS3Ny
   0FdtcYb/ixoMlyXisOLKKAxUxpdYcqiLpninZlpqq+FR6gLhwYMipr+TB
   lX0Onr+o2mQvJMiyQboN5igSydWt8AmC1Tp/y58r4oCm60k+PzQYnRoih
   mK3RflN3gzkJpHQDmzTherEP9vpZCeHFahjS7yOEAlZSkgTwHfSMaI4yT
   w==;
X-CSE-ConnectionGUID: krLeVGJJQt+wZPFwksrNVQ==
X-CSE-MsgGUID: eDljwVwRTkymLP1ISEbbKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="60784459"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="60784459"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2025 11:08:06 -0700
X-CSE-ConnectionGUID: d0THkmcPS0GzEri5UiCvYw==
X-CSE-MsgGUID: nL/tGmBzRGCk/KzsqNUFpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="170381101"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.246.96])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2025 11:08:02 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Qianfeng Rong <rongqianfeng@vivo.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, "open list:DRM DRIVERS"
 <dri-devel@lists.freedesktop.org>, open list
 <linux-kernel@vger.kernel.org>
Cc: willy@infradead.org, Qianfeng Rong <rongqianfeng@vivo.com>
Subject: Re: [PATCH v2 1/2] drm/locking: remove redundant __GFP_NOWARN
In-Reply-To: <20250807143919.575439-2-rongqianfeng@vivo.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20250807143919.575439-1-rongqianfeng@vivo.com>
 <20250807143919.575439-2-rongqianfeng@vivo.com>
Date: Thu, 07 Aug 2025 21:07:59 +0300
Message-ID: <2a0a178a0929dc76cd88ec840d52043cd367451d@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, 07 Aug 2025, Qianfeng Rong <rongqianfeng@vivo.com> wrote:
> GFP_NOWAIT already includes __GFP_NOWARN, so let's remove the redundant
> __GFP_NOWARN.
>
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>

Reviewed-by: Jani Nikula <jani.nikula@intel.com>

> ---
>  drivers/gpu/drm/drm_modeset_lock.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_modeset_lock.c b/drivers/gpu/drm/drm_modeset_lock.c
> index beb91a13a312..58eac20a8138 100644
> --- a/drivers/gpu/drm/drm_modeset_lock.c
> +++ b/drivers/gpu/drm/drm_modeset_lock.c
> @@ -88,7 +88,7 @@ static noinline depot_stack_handle_t __drm_stack_depot_save(void)
>  
>  	n = stack_trace_save(entries, ARRAY_SIZE(entries), 1);
>  
> -	return stack_depot_save(entries, n, GFP_NOWAIT | __GFP_NOWARN);
> +	return stack_depot_save(entries, n, GFP_NOWAIT);
>  }
>  
>  static void __drm_stack_depot_print(depot_stack_handle_t stack_depot)
> @@ -98,7 +98,7 @@ static void __drm_stack_depot_print(depot_stack_handle_t stack_depot)
>  	unsigned int nr_entries;
>  	char *buf;
>  
> -	buf = kmalloc(PAGE_SIZE, GFP_NOWAIT | __GFP_NOWARN);
> +	buf = kmalloc(PAGE_SIZE, GFP_NOWAIT);
>  	if (!buf)
>  		return;

-- 
Jani Nikula, Intel

