Return-Path: <linux-kernel+bounces-895270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15FA9C4D664
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 12:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FB693AA357
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 11:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2AA3559F9;
	Tue, 11 Nov 2025 11:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RoBpfm4m"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13BB30E82E;
	Tue, 11 Nov 2025 11:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762860159; cv=none; b=fDg7MwbmsxDY+fuWOykgMUAKrL/NqTLq6qM5vPLxpRKee8gRKDK1gMtX93fIabWpQAIKOLwHT+Eeqwjt+qG0mMIs6W2X1+8LPdPaZq8clqqzfXcxqEKa3IXLOsBsuvx6YpqdDEL/06JX5gwL7PnvfKGMjch9NDReEwR++6UN9is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762860159; c=relaxed/simple;
	bh=Qqa7vlU2LmRoidNI3H+dtyzXwYS/YoqLxD8vZyRNneA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TdO/OrUe8P6PmuFIYxS5xEhCH6CyuRLBGqK+nrHsXoz0rbeaBjX1qzMbncAxqBI/JtkN4uS+gCMgMzJMcFDw0OxAFnYRHH0+8D0cMJM6pv4dNuAiN374yoPAWCKsyP3Rx3pGw6PMrdqP0Jfy4ohLtfIdHY4QUuaccPp3bEOnIRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RoBpfm4m; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762860157; x=1794396157;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Qqa7vlU2LmRoidNI3H+dtyzXwYS/YoqLxD8vZyRNneA=;
  b=RoBpfm4mN3Ccq0oaYBH+DO1xHGTyxBATqmNpiysmawt3TZZzUgiXM+Ev
   OKzxwa42NsK1nBIn15kz3nO1MOSC3/jK6ra7JqK0OICXz6K23dJ1ybyXP
   pVWV3z7ulZQ+Utve6qSC5Kz/AHDvr7fBT6pPGNDBIfzHOoS2XxDgGXjvz
   FTXEMEIP2yByXP8YFdZ2dsfcFfk7jldNzHd5lwlIonNZOQArHNbBSqCLY
   0yq4puj35Z10gp64ioLGxXJdXrubhu503CMf1Af0QMzZ27sChB/C3jmCg
   T4op95f832Y04ICgguHeLMnbTlP9DpYwUHADN47Pen1Lh9CGYRSWB9xm6
   A==;
X-CSE-ConnectionGUID: W4qDxJSHRBeAZayS9VJa/A==
X-CSE-MsgGUID: 04ygD0CXSoO3k5qKSivwZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="82317624"
X-IronPort-AV: E=Sophos;i="6.19,296,1754982000"; 
   d="scan'208";a="82317624"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 03:22:37 -0800
X-CSE-ConnectionGUID: M2uXnUFfQjK85tdzgDm3Dg==
X-CSE-MsgGUID: +qtUA1mmS5eAjAEeHoet1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,296,1754982000"; 
   d="scan'208";a="193053753"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.244.96])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 03:22:31 -0800
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id DEC9011F983;
	Tue, 11 Nov 2025 13:22:28 +0200 (EET)
Date: Tue, 11 Nov 2025 13:22:28 +0200
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Matthias Fend <matthias.fend@emfend.at>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Hans Verkuil <hverkuil@kernel.org>,
	Hans de Goede <hansg@kernel.org>,
	Ricardo Ribalda <ribalda@chromium.org>,
	=?iso-8859-1?Q?Andr=E9?= Apitzsch <git@apitzsch.eu>,
	Tarang Raval <tarang.raval@siliconsignals.io>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
	Sylvain Petinot <sylvain.petinot@foss.st.com>,
	Dongcheng Yan <dongcheng.yan@intel.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Jingjing Xiong <jingjing.xiong@intel.com>,
	Heimir Thor Sverrisson <heimir.sverrisson@gmail.com>,
	Mehdi Djait <mehdi.djait@linux.intel.com>,
	Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>,
	linux-media@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Hao Yao <hao.yao@intel.com>,
	bsp-development.geo@leica-geosystems.com
Subject: Re: [PATCH v5 2/2] media: i2c: add Himax HM1246 image sensor driver
Message-ID: <aRMcdD43ShUFQKkN@kekkonen.localdomain>
References: <20251104-hm1246-v5-0-97c8f25b5419@emfend.at>
 <20251104-hm1246-v5-2-97c8f25b5419@emfend.at>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104-hm1246-v5-2-97c8f25b5419@emfend.at>

Hi Matthias,

On Tue, Nov 04, 2025 at 11:31:34AM +0100, Matthias Fend wrote:
> +static int hm1246_init_controls(struct hm1246 *hm1246)
> +{
> +	const struct hm1246_mode *mode = &hm1246_modes[0];
> +	struct v4l2_fwnode_device_properties props;
> +	struct v4l2_ctrl_handler *ctrl_hdlr;
> +	s64 pixel_rate, exposure_max, vblank_min, hblank;
> +	int ret;
> +
> +	ctrl_hdlr = &hm1246->ctrls;
> +	v4l2_ctrl_handler_init(ctrl_hdlr, 11);
> +
> +	hm1246->hflip_ctrl = v4l2_ctrl_new_std(ctrl_hdlr, &hm1246_ctrl_ops,
> +					       V4L2_CID_HFLIP, 0, 1, 1, 0);
> +	if (hm1246->hflip_ctrl)
> +		hm1246->hflip_ctrl->flags |= V4L2_CTRL_FLAG_MODIFY_LAYOUT;
> +
> +	hm1246->vflip_ctrl = v4l2_ctrl_new_std(ctrl_hdlr, &hm1246_ctrl_ops,
> +					       V4L2_CID_VFLIP, 0, 1, 1, 0);
> +	if (hm1246->vflip_ctrl)
> +		hm1246->vflip_ctrl->flags |= V4L2_CTRL_FLAG_MODIFY_LAYOUT;
> +
> +	v4l2_ctrl_cluster(2, &hm1246->hflip_ctrl);
> +
> +	hm1246->link_freq_ctrl =
> +		v4l2_ctrl_new_int_menu(ctrl_hdlr, &hm1246_ctrl_ops,
> +				       V4L2_CID_LINK_FREQ,
> +				       ARRAY_SIZE(hm1246_link_freqs) - 1, 0,
> +				       hm1246_link_freqs);
> +	if (hm1246->link_freq_ctrl)
> +		hm1246->link_freq_ctrl->flags |= V4L2_CTRL_FLAG_READ_ONLY;
> +
> +	pixel_rate = div_u64(hm1246_link_freqs[mode->link_freq_index],
> +			     mode->clocks_per_pixel);
> +	hm1246->pixel_rate_ctrl = v4l2_ctrl_new_std(ctrl_hdlr, &hm1246_ctrl_ops,
> +						    V4L2_CID_PIXEL_RATE,
> +						    pixel_rate, pixel_rate, 1,
> +						    pixel_rate);
> +
> +	vblank_min = mode->vts_min - mode->height;
> +	hm1246->vblank_ctrl = v4l2_ctrl_new_std(ctrl_hdlr, &hm1246_ctrl_ops,
> +						V4L2_CID_VBLANK, vblank_min,
> +						HM1246_VTS_MAX - mode->height,
> +						1, vblank_min);
> +
> +	hblank = mode->hts - mode->width;
> +	hm1246->hblank_ctrl = v4l2_ctrl_new_std(ctrl_hdlr, &hm1246_ctrl_ops,
> +						V4L2_CID_HBLANK, hblank, hblank,
> +						1, hblank);
> +	if (hm1246->hblank_ctrl)
> +		hm1246->hblank_ctrl->flags |= V4L2_CTRL_FLAG_READ_ONLY;
> +
> +	v4l2_ctrl_new_std(ctrl_hdlr, &hm1246_ctrl_ops, V4L2_CID_ANALOGUE_GAIN,
> +			  HM1246_ANALOG_GLOBAL_GAIN_MIN,
> +			  HM1246_ANALOG_GLOBAL_GAIN_MAX,
> +			  HM1246_ANALOG_GLOBAL_GAIN_STEP,
> +			  HM1246_ANALOG_GLOBAL_GAIN_MIN);
> +
> +	exposure_max = mode->vts_min - HM1246_COARSE_INTG_MARGIN;
> +	hm1246->exposure_ctrl = v4l2_ctrl_new_std(ctrl_hdlr, &hm1246_ctrl_ops,
> +						  V4L2_CID_EXPOSURE,
> +						  HM1246_COARSE_INTG_MIN,
> +						  exposure_max,
> +						  HM1246_COARSE_INTG_STEP,
> +						  exposure_max);
> +
> +	v4l2_ctrl_new_std_menu_items(ctrl_hdlr, &hm1246_ctrl_ops,
> +				     V4L2_CID_TEST_PATTERN,
> +				     ARRAY_SIZE(hm1246_test_pattern_menu) - 1,
> +				     0, 0, hm1246_test_pattern_menu);
> +
> +	ret = v4l2_fwnode_device_parse(hm1246->dev, &props);
> +	if (ret)
> +		goto err_v4l2_ctrl_handler_free;

If you move this to the beginning of the function, you can return if this
fails.

> +
> +	ret = v4l2_ctrl_new_fwnode_properties(ctrl_hdlr, &hm1246_ctrl_ops,
> +					      &props);
> +	if (ret)
> +		goto err_v4l2_ctrl_handler_free;

I'd omit the error check for this altogether. See also
<20251111112057.95655-1-sakari.ailus@linux.intel.com> on LMML.

> +
> +	if (ctrl_hdlr->error) {
> +		ret = ctrl_hdlr->error;
> +		goto err_v4l2_ctrl_handler_free;
> +	}

-- 
Kind regards,

Sakari Ailus

