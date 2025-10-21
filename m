Return-Path: <linux-kernel+bounces-862466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B9120BF55E6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 10:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8F9843514FB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 08:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA94329C76;
	Tue, 21 Oct 2025 08:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J7jmNfQ2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9D2329C50
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 08:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761036910; cv=none; b=OXZbZOjrJm+WfoaZW1dvpg2qhZaG14C6lDCSgmPTdbyNIN1r1j/wWnOrz8uBGI7XgyEX1KqeR2Ta91ol5xOiDG3oLETskfZO0hQbWuERdvTz7KD0rkIgDrQTdNiweB84RVUg6Vk8UEzEKe48RBCyUEmLfPPUkQy4aGAjs6kbTYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761036910; c=relaxed/simple;
	bh=VswKoNYWqbxDAkBE7g2SLuE51cwjYRCIW4OtJaiJOJo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h/95DPT4ZBzXmRaEh+GGViyXDZ4C0QONshSU4uygifdZyj0W9RTsWVabZz6EzfXYN/XJjvA/lizLscj3/qq6+9hcWiuxWL6yl7ut6hOsOjNFAwHvRltO0oV028KW/9iDOM9c7sOClQEsS44B3HcYX8B59ZD7682Opbt4LgsaC1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J7jmNfQ2; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761036908; x=1792572908;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=VswKoNYWqbxDAkBE7g2SLuE51cwjYRCIW4OtJaiJOJo=;
  b=J7jmNfQ2dGSqNzHQed4zxdMqk49qi/t+jgrGEa43KGPt9pjZAZ2e8wSW
   dsEXsGyNWVzXBdfURk1Uu00/JW6WCG3lHwheVHjeHMl41gjfWa3W7WSww
   xA+dlmZcsr+TnA7/kDB0FNwnYTw1sKaKnEjY5exOJr9ZuI29pGF20YHxu
   iYYtPEV/oaAuzToFPa6D5WUkHVewR4leiU/pNUgRNLJKXJAbHGG3xi/Ie
   yF3D+jTAfFuLp2br9Itp6d0bwaC5hT5CQOlXZnbWxa6lIYK4hemxNSbnQ
   QduLWN6frc38sR5Qckwh8l+rBuawTNExJU4odNmk5RFJ3+y2Pk0GI3CoT
   g==;
X-CSE-ConnectionGUID: xBa0KKouQPSxwxUhj3gQkA==
X-CSE-MsgGUID: GouDFVhTQXOKJjh9pN8tSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="65774226"
X-IronPort-AV: E=Sophos;i="6.19,244,1754982000"; 
   d="scan'208";a="65774226"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 01:55:08 -0700
X-CSE-ConnectionGUID: al+HkUXbSR+qPKDIYLKN2A==
X-CSE-MsgGUID: 7BIqSOfRSkmufTPq7jzz0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,244,1754982000"; 
   d="scan'208";a="183101095"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.246.52])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 01:55:04 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Chu Guangqing <chuguangqing@inspur.com>, alain.volmat@foss.st.com,
 rgallaispou@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Chu
 Guangqing <chuguangqing@inspur.com>
Subject: Re: [PATCH v2 1/1] drm/sti: hdmi: call drm_edid_connector_update
 when edid is NULL
In-Reply-To: <20251020013039.1800-2-chuguangqing@inspur.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20251020013039.1800-1-chuguangqing@inspur.com>
 <20251020013039.1800-2-chuguangqing@inspur.com>
Date: Tue, 21 Oct 2025 11:55:01 +0300
Message-ID: <4cf3050675a7090a87c80d525601b226e5e70f06@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, 20 Oct 2025, Chu Guangqing <chuguangqing@inspur.com> wrote:
> call drm_edid_connector_update to reset the information when edid is NULL.
> We can see the following comments in drm_edid.c
> If EDID is NULL, reset the information.
>
> Signed-off-by: Chu Guangqing <chuguangqing@inspur.com>
> ---
>  drivers/gpu/drm/sti/sti_hdmi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/sti/sti_hdmi.c b/drivers/gpu/drm/sti/sti_hdmi.c
> index 4e7c3d78b2b9..e0be1be8bcdd 100644
> --- a/drivers/gpu/drm/sti/sti_hdmi.c
> +++ b/drivers/gpu/drm/sti/sti_hdmi.c
> @@ -1008,7 +1008,7 @@ static int sti_hdmi_connector_get_modes(struct drm_connector *connector)
>  	return count;
>  
>  fail:
> -	DRM_ERROR("Can't read HDMI EDID\n");
> +	drm_edid_connector_update(connector, NULL);

The context above has:

	drm_edid = drm_edid_read(connector);

	drm_edid_connector_update(connector, drm_edid);

	cec_notifier_set_phys_addr(hdmi->notifier,
				   connector->display_info.source_physical_address);

	if (!drm_edid)
		goto fail;

i.e. drm_edid_connector_update() already gets called regardless of
whether drm_edid is NULL or not. Precisely as intended in commit
f7945d9fa8b7 ("drm/sti/sti_hdmi: convert to struct drm_edid").


BR,
Jani.


>  	return 0;
>  }

-- 
Jani Nikula, Intel

