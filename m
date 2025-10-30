Return-Path: <linux-kernel+bounces-877926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC50C1F5E0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 10:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F11D734A10C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 09:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F41343D9D;
	Thu, 30 Oct 2025 09:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I5AO3Apq"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800DC33CE85
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 09:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761817460; cv=none; b=B12RwY6fqhwJSLZk1TUW7ih2uLyFIgv5JjqGzv50LXJK1fWaRPLARxVPW8uOhBGpBLJ1onEdtPtNPd0HzjHctOIG8GCWPCJ6pEonJnSHGQHYFW6jHihgUidBXBDvLJsGjDkoySGMqqB3f0dwpLl/QVZcH2JtycT3fWvRGIgmh3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761817460; c=relaxed/simple;
	bh=EGglB+ODiW1tXjkIyvNcuCGOQsXWhcqgGRKRweC9pH4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hOg6TayDvzJOoEkJImaifFWc1gE8lp2w2OFlbz2x3Ombp1U3DR8JWnCb/phmi/P3S52T1JtTTDlyLJRJUYF9ULwrctAsAubKt0fYX4LSJhaotIgnNu+ygA2ChI/XXxtVkE/AvurOyNDIVp45KO8TYbeFqQD2pujqF+n6KkmdmJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I5AO3Apq; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761817459; x=1793353459;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=EGglB+ODiW1tXjkIyvNcuCGOQsXWhcqgGRKRweC9pH4=;
  b=I5AO3ApqjO6tCgF0sFEpttuyTqfTd1PdBR7yuv658XBbDNcQqirGt/vl
   ulgWLxrMS20IWKMJj6vizHpXXf83fKyKD9C9UVZBevCwsdo4DCAHwU5oj
   db/PyaOzXulJq2vB1v/B+7KNUjbZHqmZVedsQQKj2t8LFvXCPgLT1DxgU
   aWC51qsBonRRm+lFCVWxDfAN20ViqFzH+BC6mDdG1KBGG2f903n+f3Mul
   QWfCdz0D6DBBC4/385UliEZC++XnXRXzX1ILxjRF9xOVC8xRnc6m40qbq
   mvKzih7Lu6Dm4a+Fnr/7SsmTXd9vsT6Ci1hHngsx6LLahOazw4braIhJG
   Q==;
X-CSE-ConnectionGUID: JxzmwvYxRD+BJUeDb1XeAw==
X-CSE-MsgGUID: aE+4E8vyT0ueq4xUE8g9YA==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="63652074"
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="63652074"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 02:44:18 -0700
X-CSE-ConnectionGUID: n92aF8nQSX+/JFJuViGYsQ==
X-CSE-MsgGUID: YfQ6aFAJSFi3hQqXqaEaIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="185104305"
Received: from ettammin-desk.ger.corp.intel.com (HELO localhost) ([10.245.246.223])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 02:44:14 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Ajye Huang <ajye_huang@compal.corp-partner.google.com>,
 linux-kernel@vger.kernel.org
Cc: Douglas Anderson <dianders@chromium.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, Ajye Huang
 <ajye_huang@compal.corp-partner.google.com>, jazhan@google.com
Subject: Re: [PATCH v1 1/2] drm/panel-edp: Add override bpc quirk for
 generic edp
In-Reply-To: <20251029081048.162374-2-ajye_huang@compal.corp-partner.google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20251029081048.162374-1-ajye_huang@compal.corp-partner.google.com>
 <20251029081048.162374-2-ajye_huang@compal.corp-partner.google.com>
Date: Thu, 30 Oct 2025 11:44:11 +0200
Message-ID: <d6fe55b210888b9279c776b2bbfeaf38bfc44dcb@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, 29 Oct 2025, Ajye Huang <ajye_huang@compal.corp-partner.google.com> wrote:
> Adding override bpc to EDP_PANEL_ENTRY3 quirk.
>
> Signed-off-by: Ajye Huang <ajye_huang@compal.corp-partner.google.com>
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
> index 944c7c70de55..da3e8f223ec3 100644
> --- a/drivers/gpu/drm/panel/panel-edp.c
> +++ b/drivers/gpu/drm/panel/panel-edp.c
> @@ -218,6 +218,9 @@ struct edp_panel_entry {
>  
>  	/** @override_edid_mode: Override the mode obtained by edid. */
>  	const struct drm_display_mode *override_edid_mode;
> +
> +	/** @override_bpc: Override the Bits per color obtained by edid. */
> +	unsigned int override_bpc;
>  };
>  
>  struct panel_edp {
> @@ -586,6 +589,9 @@ static int panel_edp_get_modes(struct drm_panel *panel,
>  	bool has_override_edid_mode = p->detected_panel &&
>  				      p->detected_panel != ERR_PTR(-EINVAL) &&
>  				      p->detected_panel->override_edid_mode;

Unrelated to the patch at hand, since the pattern is there already, but
something like this should be more reliable:

bool has_override_edid_mode = !IS_ERR_OR_NULL(p->detected_panel) &&
	p->detected_panel->override_edid_mode;

It does not look like p->detected_panel could have other error pointer
values than -EINVAL, but it looks awkward to check for NULL and one
error pointer value, and then go on to dereference it.

I guess even better would be to always use either NULL *or* error
pointers, not a mix, but I digress.

BR,
Jani.


> +	bool has_override_bpc = p->detected_panel &&
> +				      p->detected_panel != ERR_PTR(-EINVAL) &&
> +				      p->detected_panel->override_bpc;
>  
>  	/* probe EDID if a DDC bus is available */
>  	if (p->ddc) {
> @@ -611,6 +617,9 @@ static int panel_edp_get_modes(struct drm_panel *panel,
>  			} else {
>  				num += drm_edid_connector_add_modes(connector);
>  			}
> +
> +			if (has_override_bpc)
> +				connector->display_info.bpc = p->detected_panel->override_bpc;
>  		}
>  
>  		pm_runtime_mark_last_busy(panel->dev);
> @@ -1871,6 +1880,17 @@ static const struct panel_delay delay_80_500_e50_d50 = {
>  	.override_edid_mode = _mode \
>  }
>  
> +#define EDP_PANEL_ENTRY3(vend_chr_0, vend_chr_1, vend_chr_2, product_id, _delay, _name, _bpc) \
> +{ \
> +	.ident = { \
> +		.name = _name, \
> +		.panel_id = drm_edid_encode_panel_id(vend_chr_0, vend_chr_1, vend_chr_2, \
> +						     product_id), \
> +	}, \
> +	.delay = _delay, \
> +	.override_bpc = _bpc \
> +}
> +
>  /*
>   * This table is used to figure out power sequencing delays for panels that
>   * are detected by EDID. Entries here may point to entries in the

-- 
Jani Nikula, Intel

