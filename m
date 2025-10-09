Return-Path: <linux-kernel+bounces-846815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18EE4BC91D7
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 14:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A39D23A501E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 12:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29822E2DF3;
	Thu,  9 Oct 2025 12:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JopefJMY"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AFCBA3F;
	Thu,  9 Oct 2025 12:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760014145; cv=none; b=J9dEhNjUgJ1lo3XEWpcb5CwL6iPp5tmCXNNN9Vq2WId3u3GSV4h8O1VOZMnspbI6t0SFZz0ddWdR9/LDxItXv/8Msib2tppgB6EYRO5JdKaSkJn/N+83v/tVg0t+0Y2LaecLkRczCE349AHdghVkIXGnmvb6E02ec42BldgGVP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760014145; c=relaxed/simple;
	bh=OSFdQafboDaUi8Wy4vbAAqnWvuafTu2QD+cLsjQEGus=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mHHfRKS3sH0QE3ez4+hRR/uXzEXXyk+j+rIw/Fj5dgjdyd724NZYvNLJwfHgPyZHgzS2eoBO36FeifwnG9jUhkp9rIla6IWRT8Rk8/j7lsM4GO+rzuJN6DxFPz936+xA1ljuhsN2w18HpqxGVoj1ysUgdw+iRAdkYomTGe9OjNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JopefJMY; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760014144; x=1791550144;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=OSFdQafboDaUi8Wy4vbAAqnWvuafTu2QD+cLsjQEGus=;
  b=JopefJMYDLlXf0LPIJwLVmpAAItYKKSzxe+/9eAx5BMk5kMZRHqRjdUB
   Y7CyL4QThf23Zwj6YTI7DyS9QYPFo6gjuvHagGdkvnsQx9fnyvKiO0UvS
   s7uNBZTq+LGbdjkRZFtSgUmFl/3V3xPAeKLphvtKnHWHiefwwxRfzsnGg
   c++IidBnCoYJHmTH/+TZqm04O4QGrNldWyi+A6O2KI/L2d/nWMlZpZsMM
   st3sa7fNIFLvrUb6RWzyKWg+iyH75GI9KZ2br63Bt3bGYkW1O63Kp9x8M
   ZzwqpbfJGU6ZYaJUJJEaoy+c/kyqE3v6qSGRUCxhxMxIqO49fgEJeHyl/
   A==;
X-CSE-ConnectionGUID: G3WlB3/hSK6vmnvi63IyWA==
X-CSE-MsgGUID: h5VK8ek9SDK7gBM07Ir5GA==
X-IronPort-AV: E=McAfee;i="6800,10657,11577"; a="84842104"
X-IronPort-AV: E=Sophos;i="6.19,216,1754982000"; 
   d="scan'208";a="84842104"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2025 05:49:03 -0700
X-CSE-ConnectionGUID: f0f9xGnmTki9Z4zY4Af96A==
X-CSE-MsgGUID: qSApt77rQmKInxe4CHo9rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,216,1754982000"; 
   d="scan'208";a="180650592"
Received: from ettammin-desk.ger.corp.intel.com (HELO localhost) ([10.245.246.113])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2025 05:48:56 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Pet Weng <pet.weng@ite.com.tw>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss
 <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Hermes Wu <hermes.Wu@ite.com.tw>, Kenneth
 Hung <kenneth.Hung@ite.com.tw>, Pet Weng <pet.weng@ite.com.tw>, Pin-yen Lin
 <treapking@google.com>
Subject: Re: [PATCH v3 2/3] drm/bridge: Add ITE IT61620 MIPI DSI to HDMI
 bridge driver
In-Reply-To: <20251009-it61620-0714-v3-2-5d682d028441@ite.com.tw>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20251009-it61620-0714-v3-0-5d682d028441@ite.com.tw>
 <20251009-it61620-0714-v3-2-5d682d028441@ite.com.tw>
Date: Thu, 09 Oct 2025 15:48:54 +0300
Message-ID: <088cbc524dbb05757f244a6c7f26f3228e554f61@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, 09 Oct 2025, Pet Weng <pet.weng@ite.com.tw> wrote:
> +static void it61620_set_capability_from_edid_parse(struct it61620 *it61620,
> +						   const struct edid *edid)
> +{
> +	struct drm_device *drm = it61620->drm;
> +
> +	it61620->is_hdmi = drm_detect_hdmi_monitor(edid);
> +	it61620->en_audio = drm_detect_monitor_audio(edid);

Please don't add new users of drm_detect_monitor_audio() or
drm_detect_hdmi_monitor(). They're basically deprecated.

Use drm_edid_connector_update() and you can get at the same info via
connector->display_info.{is_hdmi,has_audio} members.

> +
> +	drm_dbg(drm, "%s mode, monitor %ssupport audio",
> +		it61620->is_hdmi ? "HDMI" : "DVI",
> +		it61620->en_audio ? "" : "not ");
> +}

> +static const struct drm_edid *it61620_bridge_edid_read(struct drm_bridge *bridge,
> +						       struct drm_connector *connector)
> +{
> +	struct it61620 *it61620 = bridge_to_it61620(bridge);
> +	struct device *dev = it61620->dev;
> +	const struct drm_edid *cached_edid;
> +
> +	cached_edid = drm_edid_read_custom(connector, it61620_get_edid_block,
> +					   it61620);
> +
> +	if (!cached_edid) {
> +		dev_dbg(dev, "failed to get edid!");
> +		return NULL;
> +	}
> +
> +	it61620_set_capability_from_edid_parse(it61620,
> +					       drm_edid_raw(cached_edid));

Please don't add new users of drm_edid_raw(). It's for transitioning
from struct edid to struct drm_edid only, and you should not add new
uses of struct edid either.

BR,
Jani.

> +	return cached_edid;
> +}

-- 
Jani Nikula, Intel

