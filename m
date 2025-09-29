Return-Path: <linux-kernel+bounces-836236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3259BA9132
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 13:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 834283ADC6E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6ED3301498;
	Mon, 29 Sep 2025 11:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QEnD1g1h"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838492FE565
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 11:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759146006; cv=none; b=LPdkm7R0x5XJKxoAeX7ZZnEzO8uT9huzd8goJAPNY1g/hvJf5KhLrO5SZjONwAqTDai0dFRuy2SocGbodbQ18VzN1qaEiatTu+zpSSAgzY10viBOu7db7JyVon66IStAnK8rVBsCc3i68F+D06hmaZBBZAaJIPYKCDGqs/wHReE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759146006; c=relaxed/simple;
	bh=137britwVvpQbX//XWtXu1cRceB9CzfG7jhKto421XM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=skXkOHU+Fa+YcqO5ePO0SPij2GzRsk/P30pT9A2gdOrB09oKcq4LC19268Abv6Oz1LjalSd/yxcvU2EWp3PnUt0wavyK84W/vXgB+JFnijgbpl3mqxI2VxIdW/tOdfzEADglb9QukioCA17ToLJG11mxAzW2vIN/cFV95MgkNDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QEnD1g1h; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759146005; x=1790682005;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=137britwVvpQbX//XWtXu1cRceB9CzfG7jhKto421XM=;
  b=QEnD1g1hlW0hIJZ2P1ErkVGfx5bSDPi1tq/uG4KGeoaI5QVZTfGcfRCa
   7a7vzWKKNNUTbCF8rW5kQYtf3WJnCe58b2W761FlEbsyTxfK3Y6vxGC0I
   jeX4ToiL3Cory+CRK/Bq5onduypUWLau00aiC/pNxy6tR9KomUC6bJLKY
   E1EbYfpnmGBde2bWxuejoJQLUMN+Rx4LRxaJ/1RGfHSDWr6n0rD8pjxO6
   7o/AH//lgICpKpxTJPOMRdxeGdspH6mFm4FayCyzRiIMegvNHEll5rWgC
   pIHpxDCHa77Exhni+yz07kLJPTFfnmMJwNEHw5ZDi/T4fldot9xY+1wZk
   Q==;
X-CSE-ConnectionGUID: t2g/GqJkSZmpic4SpGzpDg==
X-CSE-MsgGUID: mOojZQGGTD+CaTuN5oqRDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11567"; a="71630308"
X-IronPort-AV: E=Sophos;i="6.18,301,1751266800"; 
   d="scan'208";a="71630308"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 04:40:03 -0700
X-CSE-ConnectionGUID: 9SJ6KRVUR763p5b7qdEZnA==
X-CSE-MsgGUID: tD4r/0coR9aVPQ5IqgsqHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,301,1751266800"; 
   d="scan'208";a="201891209"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.246.102])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 04:39:59 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Chu Guangqing <chuguangqing@inspur.com>, tzimmermann@suse.de,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch, dmitry.baryshkov@oss.qualcomm.com
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Chu
 Guangqing <chuguangqing@inspur.com>
Subject: Re: [PATCH v8 1/1] [DRIVER] gpu: drm: add support for YHGCH ZX1000
 soc chipset
In-Reply-To: <20250929104831.8548-2-chuguangqing@inspur.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20250929063103.7375-1-chuguangqing@inspur.com>
 <20250929104831.8548-1-chuguangqing@inspur.com>
 <20250929104831.8548-2-chuguangqing@inspur.com>
Date: Mon, 29 Sep 2025 14:39:56 +0300
Message-ID: <9ab159073b644c83541e4782c30ae9900b0f27d4@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, 29 Sep 2025, Chu Guangqing <chuguangqing@inspur.com> wrote:
> diff --git a/drivers/gpu/drm/yhgch/yhgch_drm_vdac.c b/drivers/gpu/drm/yhgch/yhgch_drm_vdac.c
> new file mode 100644
> index 000000000000..2e222af29f69
> --- /dev/null
> +++ b/drivers/gpu/drm/yhgch/yhgch_drm_vdac.c
> @@ -0,0 +1,134 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/io.h>
> +
> +#include <drm/drm_atomic_helper.h>
> +#include <drm/drm_edid.h>
> +#include <drm/drm_probe_helper.h>
> +#include <drm/drm_print.h>
> +#include <drm/drm_simple_kms_helper.h>
> +
> +#include "yhgch_drm_drv.h"
> +#include "yhgch_drm_regs.h"
> +
> +static int yhgch_connector_get_modes(struct drm_connector *connector)
> +{
> +	int count;
> +	const struct drm_edid *drm_edid;
> +
> +	drm_edid = drm_edid_read(connector);
> +	if (drm_edid) {
> +		drm_edid_connector_update(connector, drm_edid);

You're supposed to do drm_edid_connector_update() even for NULL edid to
reset it.

BR,
Jani.


> +		count =  drm_edid_connector_add_modes(connector);
> +		if (count)
> +			goto out;
> +	}
> +
> +	count = drm_add_modes_noedid(connector,
> +				     connector->dev->mode_config.max_width,
> +				     connector->dev->mode_config.max_height);
> +	drm_set_preferred_mode(connector, 1024, 768);
> +
> +out:
> +	drm_edid_free(drm_edid);
> +	return count;
> +}

-- 
Jani Nikula, Intel

