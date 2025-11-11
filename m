Return-Path: <linux-kernel+bounces-895459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D014C4DE6F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 13:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D716D34E87A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 12:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C76E352947;
	Tue, 11 Nov 2025 12:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TteFs+rV"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F963AA186;
	Tue, 11 Nov 2025 12:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762865414; cv=none; b=XqVjiPxUWNS0+cbV0qhSvkTMKXBQLWbKfdgDuXP0HKkIlf+wx94PWW8fdPDdvf8Q9VrUKsewIv4F2AW1e5axW4EUlx3z28vJuEz6W0W898DBtxW+NOy98o/IWKZCcAF2ClWaTnjL8OKLFPQNXE9u4m49WE81cSB83kK3dumTCYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762865414; c=relaxed/simple;
	bh=1bnxLAQbVIMtxhVwA07iseK+u3QN8a+3xy9ltcFSBKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=slq1MqNkO6cZhosgAYYFn128ZbbsIMkMwD0UffuEmDqZNDQRiYXciBU495T9P+prrRURgQ7pHP3k+89wR1AwK3xRMO4MM74/POcVk/EsdL33TjuNAgkOoFfZ7Mz8TvVcTFHCGESaFkOJmarb6WQL/rZutLB5af6X5dPvhUDrwt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TteFs+rV; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762865413; x=1794401413;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1bnxLAQbVIMtxhVwA07iseK+u3QN8a+3xy9ltcFSBKQ=;
  b=TteFs+rVJSBY381wRKGdQ9Yf2Egr5YgE4yktWhTfNkFpBeF6f9+neEnf
   b1EsFuk2ppYFSrY0wpzvlsvCygoMDG7rhH6xhrtz7DO6Ubh1YIUC5FRTW
   vfGwi6EgiEJvyrC8xQUf0QVVEcuHeo4hGgMXPONJXA+sENRrE1VQAw79z
   ih6P9qErdOTwXjWZKntgjKS8DqlWwtG3o53Nfw5/fxE4JlyiPf8uuzYAi
   vltiWop85pLYQOTGmHzj3CL7XImqg+HCisq1JfacBCmrwMA5JwjhmOBaf
   sI8FaOlKIIa5Jujdcc0Efo6tynT1jU9izZ110+U91SL5xAZDreWPeq+K4
   w==;
X-CSE-ConnectionGUID: DyxHymXOTFeywHAYEk2HsQ==
X-CSE-MsgGUID: rKEp9W4ZTDyZjdG2vMW6Ng==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="68772857"
X-IronPort-AV: E=Sophos;i="6.19,296,1754982000"; 
   d="scan'208";a="68772857"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 04:50:12 -0800
X-CSE-ConnectionGUID: nseLvvlHQ1O5Qbm2PPK2uA==
X-CSE-MsgGUID: 7sf9lcoUSk6QhjnbK/2L9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,296,1754982000"; 
   d="scan'208";a="188920696"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.244.96])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 04:50:07 -0800
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id CB28A11F983;
	Tue, 11 Nov 2025 14:50:05 +0200 (EET)
Date: Tue, 11 Nov 2025 14:50:05 +0200
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Hans Verkuil <hverkuil@xs4all.nl>, Hans de Goede <hansg@kernel.org>,
	=?iso-8859-1?Q?Andr=E9?= Apitzsch <git@apitzsch.eu>,
	Sylvain Petinot <sylvain.petinot@foss.st.com>,
	Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
	Dongcheng Yan <dongcheng.yan@intel.com>,
	Heimir Thor Sverrisson <heimir.sverrisson@gmail.com>,
	Tarang Raval <tarang.raval@siliconsignals.io>,
	linux-media@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] media: i2c: add Sony IMX111 CMOS camera sensor
 driver
Message-ID: <aRMw_Qre1FY94soi@kekkonen.localdomain>
References: <20251103145629.21588-1-clamor95@gmail.com>
 <20251103145629.21588-3-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103145629.21588-3-clamor95@gmail.com>

Hi Svyatoslav,

A few comments below...

On Mon, Nov 03, 2025 at 04:56:29PM +0200, Svyatoslav Ryhel wrote:

...

> +static int imx111_set_format(struct v4l2_subdev *sd,
> +			     struct v4l2_subdev_state *state,
> +			     struct v4l2_subdev_format *format)
> +{
> +	struct imx111 *sensor = sd_to_imx111(sd);
> +	struct v4l2_mbus_framefmt *mbus_fmt = &format->format;
> +	struct v4l2_mbus_framefmt *fmt;
> +	const struct imx111_mode *mode;
> +
> +	mode = v4l2_find_nearest_size(imx111_modes, ARRAY_SIZE(imx111_modes),
> +				      width, height,
> +				      mbus_fmt->width, mbus_fmt->height);
> +
> +	fmt = v4l2_subdev_state_get_format(state, format->pad);

You should set the fields below after changing the controls. Albeit... it
won't be perfect in that case either, as only some controls may have been
applied. How about just moving the lines below after changing the controls?

> +
> +	fmt->code = imx111_get_format_code(sensor, mbus_fmt->code, false);
> +	fmt->width = mode->width;
> +	fmt->height = mode->height;
> +	fmt->colorspace = V4L2_COLORSPACE_RAW;
> +
> +	*mbus_fmt = *fmt;
> +
> +	if (format->which == V4L2_SUBDEV_FORMAT_ACTIVE)	{
> +		int ret;
> +
> +		sensor->cur_mode = mode;
> +		sensor->data_depth = imx111_get_format_bpp(fmt);
> +
> +		ret = __v4l2_ctrl_s_ctrl_int64(sensor->pixel_rate,
> +					       div_u64(sensor->pixel_clk_raw,
> +						       2 *
> +						       sensor->data_depth));
> +		if (ret)
> +			return ret;
> +
> +		ret = __v4l2_ctrl_modify_range(sensor->vblank,
> +					       IMX111_VBLANK_MIN,
> +					       IMX111_VTL_MAX - mode->height,
> +					       1,
> +					       mode->vtl_def - mode->height);
> +		if (ret)
> +			return ret;
> +
> +		ret = __v4l2_ctrl_s_ctrl(sensor->vblank, mode->vtl_def -
> +					 mode->height);
> +		if (ret)
> +			return ret;
> +
> +		ret = __v4l2_ctrl_modify_range(sensor->hblank,
> +					       IMX111_HBLANK_MIN,
> +					       IMX111_HTL_MAX - mode->width,
> +					       1,
> +					       mode->htl_def - mode->width);
> +		if (ret)
> +			return ret;
> +
> +		ret = __v4l2_ctrl_s_ctrl(sensor->hblank, mode->htl_def -
> +					 mode->width);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}

...

> +static int imx111_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct imx111 *sensor;
> +	int ret;
> +
> +	sensor = devm_kzalloc(dev, sizeof(*sensor), GFP_KERNEL);
> +	if (!sensor)
> +		return -ENOMEM;
> +
> +	sensor->regmap = devm_cci_regmap_init_i2c(client, 16);
> +	if (IS_ERR(sensor->regmap))
> +		return dev_err_probe(dev, PTR_ERR(sensor->regmap),
> +				     "Failed to allocate register map\n");
> +
> +	sensor->extclk = devm_v4l2_sensor_clk_get(dev, NULL);
> +	if (IS_ERR(sensor->extclk))
> +		return dev_err_probe(dev, PTR_ERR(sensor->extclk),
> +				     "Failed to get clock\n");
> +
> +	sensor->reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
> +	if (IS_ERR(sensor->reset))
> +		return dev_err_probe(dev, PTR_ERR(sensor->reset),
> +				     "Failed to get reset GPIO\n");
> +
> +	ret = devm_regulator_bulk_get_const(dev, ARRAY_SIZE(imx111_supplies),
> +					    imx111_supplies,
> +					    &sensor->supplies);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Failed to get regulators\n");
> +
> +	ret = imx111_parse_dt(sensor);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = imx111_clk_init(sensor);
> +	if (ret < 0)
> +		goto error_ep_free;
> +
> +	ret = imx111_power_on(sensor);
> +	if (ret < 0) {
> +		dev_err_probe(dev, ret, "Could not power on the device\n");
> +		goto error_ep_free;
> +	}
> +
> +	ret = imx111_identify_module(sensor);
> +	if (ret < 0) {
> +		dev_err_probe(dev, ret, "Could not identify module\n");
> +		goto error_power_off;
> +	}
> +
> +	sensor->cur_mode = &imx111_modes[IMX111_MODE_3280x2464];
> +	sensor->data_depth = IMX111_DATA_DEPTH_RAW10;
> +
> +	ret = imx111_initialize(sensor);
> +	if (ret < 0)
> +		goto error_power_off;
> +
> +	ret = imx111_init_subdev(sensor, client);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to init controls: %d", ret);
> +		goto error_v4l2_ctrl_handler_free;
> +	}
> +
> +	ret = v4l2_subdev_init_finalize(&sensor->sd);
> +	if (ret)
> +		goto error_v4l2_ctrl_handler_free;
> +
> +	pm_runtime_set_active(dev);
> +	pm_runtime_enable(dev);
> +
> +	ret = v4l2_async_register_subdev_sensor(&sensor->sd);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to register V4L2 subdev: %d", ret);
> +		goto error_pm;
> +	}
> +
> +	pm_runtime_idle(dev);
> +	pm_runtime_set_autosuspend_delay(dev, 1000);
> +	pm_runtime_use_autosuspend(dev);

The autosuspend should be set before pm_runtime_idle() call(), shouldn't
it?

I can make the two changes before applying, too, if that's ok.

-- 
Regards,

Sakari Ailus

