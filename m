Return-Path: <linux-kernel+bounces-892545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39866C45532
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:14:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCC55188F474
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 08:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811F52F693D;
	Mon, 10 Nov 2025 08:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NZnOuVf8"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C9E1DE8B5;
	Mon, 10 Nov 2025 08:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762762456; cv=none; b=VlDa2+ZVjrd9c9MSmfS7bc66E2KuoKCv/gyZ5g7RbuRIOXylkPesmdUPnaJ/prmo/rxv/NZt6o8tieD1M/r5YHBuX+PZwKJ3ybRLjfpOKiw5ifs7eMSZlm3vo7a1+C/aLeknl0rTMjfTrOHY3M3F+xePAUtuG0frmWijJcelPmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762762456; c=relaxed/simple;
	bh=Yr6LCvAA9OxlFpD/Zmy6//LNLn2xNE6XhRQnlP5LVXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OBJJK2PYgzxdGMm/HP6GuXqODxb9NATPJg11RLS5o+lV4aOAvA7pPQmJ0mkVsKG0/NBy4u+Wu9RteYZZeoEuceGJb4hkrGp+wiGM1+7bx0+o3fNYRM11IEQXg2+qziGlp4DxEUi+CKjMM1+WuuuMzXJaNC8R3Xqiq+8CDjYorsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NZnOuVf8; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762762455; x=1794298455;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Yr6LCvAA9OxlFpD/Zmy6//LNLn2xNE6XhRQnlP5LVXI=;
  b=NZnOuVf8VAjZpQrRbPiGFgOW671FkWRB+O1dlhYn18GI+ZGK9Qh3lc8b
   h1+iL3EfkLTx1Np4Z3P1nnW5/arNffUm5CLGAIftLZsTN5T4w7xC1Tz/i
   tiPeqBibdAQwG2x9nR50JwX5VZPaqsecHQ0A/iowfg1GWxD0VlIJ1vSUX
   iODMZztvp15vmuEWLvTECSTsW37V91NSMXWrcKIBmoOWmYCKVWbavUtSB
   Urt3DpMyj1XeMEjAUkcJURq/sZWbYLSRezZ5k/pM5Ed8grJtGNRQOmJ8y
   Z8dcRGhDwqUIB30aBcbaV1vLnOPNQe/SYa7BzQS4HsRjr4XfNDLHC7a29
   A==;
X-CSE-ConnectionGUID: Lh52cWzLTFyPYtrSzn+Xfg==
X-CSE-MsgGUID: 7JFP5zaLSA2lShETxycLGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11608"; a="64897675"
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="64897675"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 00:14:14 -0800
X-CSE-ConnectionGUID: TE/LResuTn2cOoGBFdJYLA==
X-CSE-MsgGUID: 5DemK79tR3KEGjeOWHNvBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="212011046"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.238])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 00:14:13 -0800
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 8E6FA1205FC;
	Mon, 10 Nov 2025 10:14:12 +0200 (EET)
Date: Mon, 10 Nov 2025 10:14:12 +0200
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Alex Tran <alex.t.tran@gmail.com>
Cc: Pavel Machek <pavel@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] media: i2c: et8ek8: et8ek8_driver: add support
 for crc configuration via device tree
Message-ID: <aRGe1NkDHYtDOfnw@kekkonen.localdomain>
References: <20251108232923.2067131-1-alex.t.tran@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251108232923.2067131-1-alex.t.tran@gmail.com>

Hi Alex,

Thanks for the patch.

On Sat, Nov 08, 2025 at 03:29:23PM -0800, Alex Tran wrote:
> Retrieve the configuration for CRC from the device tree instead
> using the hard coded USE_CRC directive. If there is an issue
> retrieving the endpoint node or the CRC property then the default
> of 1 is used and the driver does not fail to maintain backward
> compatibility.

Is there a need for making this configurable? I have to say I can't recall
the specifics of CCP2 but presumably the receiver side would need to be
aligned with this as well, requiring such configuration on both sides.

If you want to pursue this further, please also cc me to the DT binding
patch.

> 
> Signed-off-by: Alex Tran <alex.t.tran@gmail.com>
> ---
>  drivers/media/i2c/et8ek8/et8ek8_driver.c | 49 +++++++++++++++++++-----
>  1 file changed, 39 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/media/i2c/et8ek8/et8ek8_driver.c b/drivers/media/i2c/et8ek8/et8ek8_driver.c
> index 2cb7b7187..4ef92359c 100644
> --- a/drivers/media/i2c/et8ek8/et8ek8_driver.c
> +++ b/drivers/media/i2c/et8ek8/et8ek8_driver.c
> @@ -29,6 +29,7 @@
>  #include <media/media-entity.h>
>  #include <media/v4l2-ctrls.h>
>  #include <media/v4l2-device.h>
> +#include <media/v4l2-fwnode.h>
>  #include <media/v4l2-subdev.h>
>  
>  #include "et8ek8_reg.h"
> @@ -45,6 +46,7 @@ struct et8ek8_sensor {
>  	struct regulator *vana;
>  	struct clk *ext_clk;
>  	u32 xclk_freq;
> +	u32 use_crc;
>  
>  	u16 version;
>  
> @@ -130,8 +132,6 @@ static struct et8ek8_gain {
>  
>  #define ET8EK8_I2C_DELAY	3	/* msec delay b/w accesses */
>  
> -#define USE_CRC			1
> -
>  /*
>   * Register access helpers
>   *
> @@ -844,20 +844,16 @@ static int et8ek8_power_on(struct et8ek8_sensor *sensor)
>  	if (rval)
>  		goto out;
>  
> -#ifdef USE_CRC
>  	rval = et8ek8_i2c_read_reg(client, ET8EK8_REG_8BIT, 0x1263, &val);
>  	if (rval)
>  		goto out;
> -#if USE_CRC /* TODO get crc setting from DT */
> -	val |= BIT(4);
> -#else
> -	val &= ~BIT(4);
> -#endif
> +	if (sensor->use_crc)
> +		val |= BIT(4);
> +	else
> +		val &= ~BIT(4);
>  	rval = et8ek8_i2c_write_reg(client, ET8EK8_REG_8BIT, 0x1263, val);
>  	if (rval)
>  		goto out;
> -#endif
> -
>  out:
>  	if (rval)
>  		et8ek8_power_off(sensor);
> @@ -1396,6 +1392,34 @@ static int __maybe_unused et8ek8_resume(struct device *dev)
>  	return __et8ek8_set_power(sensor, true);
>  }
>  
> +static int et8ek8_parse_fwnode(struct device *dev, struct et8ek8_sensor *sensor)
> +{
> +	struct v4l2_fwnode_endpoint bus_cfg = {
> +		.bus_type = V4L2_MBUS_CCP2,
> +	};
> +	struct fwnode_handle *ep;
> +	int ret;
> +
> +	ep = fwnode_graph_get_endpoint_by_id(dev_fwnode(dev), 0, 0,
> +					     FWNODE_GRAPH_ENDPOINT_NEXT);
> +	if (!ep) {
> +		dev_warn(dev, "could not get endpoint node\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = v4l2_fwnode_endpoint_alloc_parse(ep, &bus_cfg);
> +	if (ret) {
> +		dev_warn(dev, "parsing endpoint node failed\n");
> +		goto done;
> +	}
> +
> +	fwnode_property_read_u32(ep, "crc", &sensor->use_crc);
> +done:
> +	v4l2_fwnode_endpoint_free(&bus_cfg);
> +	fwnode_handle_put(ep);
> +	return ret;
> +}
> +
>  static int et8ek8_probe(struct i2c_client *client)
>  {
>  	struct et8ek8_sensor *sensor;
> @@ -1406,6 +1430,11 @@ static int et8ek8_probe(struct i2c_client *client)
>  	if (!sensor)
>  		return -ENOMEM;
>  
> +	sensor->use_crc = 1;
> +	ret = et8ek8_parse_fwnode(dev, sensor);
> +	if (ret)
> +		dev_warn(dev, "parsing endpoint failed\n");
> +
>  	sensor->reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
>  	if (IS_ERR(sensor->reset)) {
>  		dev_dbg(&client->dev, "could not request reset gpio\n");

-- 
Kind regards,

Sakari Ailus

