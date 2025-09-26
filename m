Return-Path: <linux-kernel+bounces-833712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F171BA2CDE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 09:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ABF41C013B4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 07:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B7D27C842;
	Fri, 26 Sep 2025 07:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h397B1Dp"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2AD18FC86
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 07:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758872050; cv=none; b=qQkjVqiNaAnKFDX79zUHXqosx4vrmHsT0EiKxaeENHubxQV0fe8zl54rcGR7mCGzXq+L2GuDtmkUajQg+eNBkXq3DKGRQbKX/8KRm4dUozmCYe9wYJqV/9PudNfQ4BqrJyr/j8qIjbg/DpH3Pz2O+1RcjAmXY6i5c+6ih+jbWRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758872050; c=relaxed/simple;
	bh=z7of19JO9sgpeNzTCGu8gSVFI4wYGiyFaeZdl5QWmGQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZDaruY+cDaKcKFykRjb5q2AZylANyfUAje9I8s564gEEBO9A1DUpd/Fg9fWgbJ1HHpH36B/52/RFS0ezqLdlAn7nrGJ1BDenQ4JNbhJ+ZYpMfdtEuqnAziHg4WdIp7u9hQoLefhljdc8zjy+caZZFndmOvHs1V9nZ6rsAIJwFdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h397B1Dp; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758872049; x=1790408049;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=z7of19JO9sgpeNzTCGu8gSVFI4wYGiyFaeZdl5QWmGQ=;
  b=h397B1DpSxcJRNMePhte//ugi4l+eA/eI6pcGYnYlA69WiVcF6DubkwA
   CAXEuwT7jEzz/sFt+iwZiAEDAdinu0bz2ET5vC5YeW+Hwjaqw6YdahbZ5
   vcH+U6o6m85oCtwqJgVv2kxI6r5Jo60uMdXZExBwnPapGCzCYjEn6+r5A
   eCdhHRHEHf7dElcg6NPpj698k4cev3CfD6OZSioFKWZpGkGmZ1udaWJDi
   1cpUFSALoI4zbzWVJHC28xgagHJlAe1S6HbMhX0248q77I4hiBUxwzeZb
   kG/aoGWaCs0lLGei/QnOGkyKGB3FxW/GCzz2UgzY2rJj1MuiU9sg9abwk
   A==;
X-CSE-ConnectionGUID: nfo1WgeBSqi82vXlz83N8g==
X-CSE-MsgGUID: v/0Z3f98RLWmKna8L2/+iQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11564"; a="60900203"
X-IronPort-AV: E=Sophos;i="6.18,294,1751266800"; 
   d="scan'208";a="60900203"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2025 00:34:08 -0700
X-CSE-ConnectionGUID: m2s2tBZMRvWZu8pNCDo0wQ==
X-CSE-MsgGUID: ulhKYCILRoWdhMk5A19tcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,294,1751266800"; 
   d="scan'208";a="177934224"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.246.10])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2025 00:34:02 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss
 <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Dmitry Baryshkov
 <dmitry.baryshkov@oss.qualcomm.com>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH 1/2] drm/connector: allow a .destroy callback for
 drmm-allocated connectors
In-Reply-To: <20250925-drm-bridge-alloc-getput-bridge-connector-v1-1-f0736e1c73ee@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20250925-drm-bridge-alloc-getput-bridge-connector-v1-0-f0736e1c73ee@bootlin.com>
 <20250925-drm-bridge-alloc-getput-bridge-connector-v1-1-f0736e1c73ee@bootlin.com>
Date: Fri, 26 Sep 2025 10:33:59 +0300
Message-ID: <46ef67d65591bf18d9d9dc4f8b26ca93ed93304f@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, 25 Sep 2025, Luca Ceresoli <luca.ceresoli@bootlin.com> wrote:
> Some code is going to need connector-specific cleanup actions (namely
> drm_bridge_connector will need to put refcounted bridges).
>
> The .destroy callback is appropriate for this task but it is currently
> forbidden by drmm_connector_init(). Relax this limitation and document it.
>
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
>
> ---
>
> The other obvious approach would be adding a separate .cleanup callback for
> the cleanup-only actions. I tried both, they both apparently work, so any
> arguments and opinions on which approach is best within the overall DRM
> design would be very useful here.
> ---
>  drivers/gpu/drm/drm_connector.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
> index 272d6254ea4784e97ca894ec4d463beebf9fdbf0..bd0220513a23afcb096b0c4c4d2b957b81f21ee1 100644
> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c
> @@ -513,7 +513,8 @@ static void drm_connector_cleanup_action(struct drm_device *dev,
>   *
>   * The connector structure should be allocated with drmm_kzalloc().
>   *
> - * The @drm_connector_funcs.destroy hook must be NULL.
> + * The @drm_connector_funcs.destroy hook must only do connector-specific
> + * cleanups if any is needed, not dealloacte the connector.

It slightly feels like a trap to have different semantics for ->destroy
depending on how the connector was allocated.

BR,
Jani.


>   *
>   * Returns:
>   * Zero on success, error code on failure.
> @@ -526,9 +527,6 @@ int drmm_connector_init(struct drm_device *dev,
>  {
>  	int ret;
>  
> -	if (drm_WARN_ON(dev, funcs && funcs->destroy))
> -		return -EINVAL;
> -
>  	ret = drm_connector_init_and_add(dev, connector, funcs, connector_type, ddc);
>  	if (ret)
>  		return ret;

-- 
Jani Nikula, Intel

