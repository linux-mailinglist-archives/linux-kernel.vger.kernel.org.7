Return-Path: <linux-kernel+bounces-802731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95347B45621
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 13:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DE2F7C7E46
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6D1343D9D;
	Fri,  5 Sep 2025 11:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FBP9IBtF"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1969D286898;
	Fri,  5 Sep 2025 11:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757070926; cv=none; b=KNoNRrZ1bu71Lkgge1OPcQcehBnGb1g4m2x2CxsSFfDI5Z/nTEczkQFn1uzI47FfChtMk8d2rzInDUV+nFZpORoaVUBMXmuYqZTKNCPh28A6F4e34twMXePc8oV4qxhn2SrxX1V4BaACvg/sSrXzam3e2xdciZ7Ft9K/i7or3/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757070926; c=relaxed/simple;
	bh=3akFC5IMed+fG2KKB0KQf9NBmC17zIW/9AU0DfJiD7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BYyVzVy+5oFOUM7cLWX7nYS8EFOBwrU+D4hAdAKrMY3cOQEdmX91vPdNi8hTfZKHEc8WkZ9Aau0Z5weErt8/dILvfkF5kqhxKhOmS2QFJTXoOd4Qi6MSRw9yDrDEhpwkgTgjbTteozq3oUngGGp2UOxZgR3ZXiP3+O53Fmqwfq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FBP9IBtF; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757070925; x=1788606925;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3akFC5IMed+fG2KKB0KQf9NBmC17zIW/9AU0DfJiD7Q=;
  b=FBP9IBtFLrJmKvKW2nwyp+b8zJDMIDKk47xPY70ne5GHq08PlbI9bLRy
   3upsVr55R2WBIt6BO6/RAEVZ/5bU6Ok2eJvqxJ77009ip220jeg4ssQAg
   KjvJ5h/MpxZc30cu34R+q0c3jtlWtHTr98sPd7uge5RHvXt+r27qN/kZn
   3GUaDNXsAH2f6/PfRAUrHgoqP32vYggxg+NAuyCMWNeT9PlFK0osDd+J6
   GTh6lXh5JQfJAes+Wwt6iqMpP5HO6vf4j35em5+yEsxdW4dkoufMChz0d
   /z4zUMNR/kr2r1zHJKRHmtRK4uJB0SJ7l2NOwwU+GnUFSW0U75mMBQKUh
   Q==;
X-CSE-ConnectionGUID: DP3B6aelR1qUsAhLm+TGRg==
X-CSE-MsgGUID: QsgF+v8KTRCry6uu+e8p/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63251832"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="63251832"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 04:15:24 -0700
X-CSE-ConnectionGUID: +3HgtWUMTAaK3lJguvuAiQ==
X-CSE-MsgGUID: 0bI3GIRWSgi/mUctC2BkUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,241,1751266800"; 
   d="scan'208";a="172069602"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by fmviesa006.fm.intel.com with SMTP; 05 Sep 2025 04:15:17 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 05 Sep 2025 14:15:16 +0300
Date: Fri, 5 Sep 2025 14:15:16 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Sven Peter <sven@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Felipe Balbi <balbi@kernel.org>,
	Janne Grunau <j@jannau.net>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Neal Gompa <neal@gompa.dev>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-phy@lists.infradead.org
Subject: Re: [PATCH RFC 12/22] usb: typec: tipd: Add cd321x struct with
 separate size
Message-ID: <aLrGRGTjyMhKV9hd@kuha.fi.intel.com>
References: <20250821-atcphy-6-17-v1-0-172beda182b8@kernel.org>
 <20250821-atcphy-6-17-v1-12-172beda182b8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821-atcphy-6-17-v1-12-172beda182b8@kernel.org>

On Thu, Aug 21, 2025 at 03:39:04PM +0000, Sven Peter wrote:
> We're about to add more fields to struct tps6598x which are only relevant
> for Apple's CD321x and to ensure that we don't waste memory everywhere for
> those add a separate struct for cd321x and prepare to allocate more space
> inside probe.
> 
> Signed-off-by: Sven Peter <sven@kernel.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tipd/core.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> index 19d713937870304e68325a441b0de63eb5db3b80..51b0f3be8b66a743ddc3ea96c1b25f597a1e8f6c 100644
> --- a/drivers/usb/typec/tipd/core.c
> +++ b/drivers/usb/typec/tipd/core.c
> @@ -113,6 +113,7 @@ struct tps6598x;
>  struct tipd_data {
>  	irq_handler_t irq_handler;
>  	u64 irq_mask1;
> +	size_t tps_struct_size;
>  	int (*register_port)(struct tps6598x *tps, struct fwnode_handle *node);
>  	void (*trace_data_status)(u32 status);
>  	void (*trace_power_status)(u16 status);
> @@ -148,6 +149,10 @@ struct tps6598x {
>  	const struct tipd_data *data;
>  };
>  
> +struct cd321x {
> +	struct tps6598x tps;
> +};
> +
>  static enum power_supply_property tps6598x_psy_props[] = {
>  	POWER_SUPPLY_PROP_USB_TYPE,
>  	POWER_SUPPLY_PROP_ONLINE,
> @@ -1297,18 +1302,24 @@ tps25750_register_port(struct tps6598x *tps, struct fwnode_handle *fwnode)
>  
>  static int tps6598x_probe(struct i2c_client *client)
>  {
> +	const struct tipd_data *data;
>  	struct tps6598x *tps;
>  	struct fwnode_handle *fwnode;
>  	u32 status;
>  	u32 vid;
>  	int ret;
>  
> -	tps = devm_kzalloc(&client->dev, sizeof(*tps), GFP_KERNEL);
> +	data = i2c_get_match_data(client);
> +	if (!data)
> +		return -EINVAL;
> +
> +	tps = devm_kzalloc(&client->dev, data->tps_struct_size, GFP_KERNEL);
>  	if (!tps)
>  		return -ENOMEM;
>  
>  	mutex_init(&tps->lock);
>  	tps->dev = &client->dev;
> +	tps->data = data;
>  
>  	tps->reset = devm_gpiod_get_optional(tps->dev, "reset", GPIOD_OUT_LOW);
>  	if (IS_ERR(tps->reset))
> @@ -1334,10 +1345,6 @@ static int tps6598x_probe(struct i2c_client *client)
>  	if (i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
>  		tps->i2c_protocol = true;
>  
> -	tps->data = i2c_get_match_data(client);
> -	if (!tps->data)
> -		return -EINVAL;
> -
>  	if (tps->data->switch_power_state) {
>  		ret = tps->data->switch_power_state(tps, TPS_SYSTEM_POWER_STATE_S0);
>  		if (ret)
> @@ -1521,6 +1528,7 @@ static const struct tipd_data cd321x_data = {
>  	.irq_mask1 = APPLE_CD_REG_INT_POWER_STATUS_UPDATE |
>  		     APPLE_CD_REG_INT_DATA_STATUS_UPDATE |
>  		     APPLE_CD_REG_INT_PLUG_EVENT,
> +	.tps_struct_size = sizeof(struct cd321x),
>  	.register_port = tps6598x_register_port,
>  	.trace_data_status = trace_cd321x_data_status,
>  	.trace_power_status = trace_tps6598x_power_status,
> @@ -1535,6 +1543,7 @@ static const struct tipd_data tps6598x_data = {
>  	.irq_mask1 = TPS_REG_INT_POWER_STATUS_UPDATE |
>  		     TPS_REG_INT_DATA_STATUS_UPDATE |
>  		     TPS_REG_INT_PLUG_EVENT,
> +	.tps_struct_size = sizeof(struct tps6598x),
>  	.register_port = tps6598x_register_port,
>  	.trace_data_status = trace_tps6598x_data_status,
>  	.trace_power_status = trace_tps6598x_power_status,
> @@ -1549,6 +1558,7 @@ static const struct tipd_data tps25750_data = {
>  	.irq_mask1 = TPS_REG_INT_POWER_STATUS_UPDATE |
>  		     TPS_REG_INT_DATA_STATUS_UPDATE |
>  		     TPS_REG_INT_PLUG_EVENT,
> +	.tps_struct_size = sizeof(struct tps6598x),
>  	.register_port = tps25750_register_port,
>  	.trace_data_status = trace_tps6598x_data_status,
>  	.trace_power_status = trace_tps25750_power_status,
> 
> -- 
> 2.34.1
> 

-- 
heikki

