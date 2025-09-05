Return-Path: <linux-kernel+bounces-802702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB7AB455C0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 13:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F3C75C3313
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77AF7342C8D;
	Fri,  5 Sep 2025 11:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="btMw55hj"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A47296BB0;
	Fri,  5 Sep 2025 11:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757070582; cv=none; b=OUqnLq+1KfiH3nLjZ5dvwVQw7DB32ibNrKNWWdreKZ1Un42tiasuHGqNfG2ifdMgJaTyJNm3m9ULrsNHdX19bPvSdLe7/rNykbwIhLZsCq5d3Z1q9LywCyy9HpGMjJ3JoaQEh3RCxYydwqqXBgra/UwW1bpTz8JDmncgpLSw5Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757070582; c=relaxed/simple;
	bh=7m/86o3yQ77TEdGSH2MiSbmes09C1SQZCM+n87rz7fg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OoNuWo6SDAO0eQiq4dE/3eN0w2BI4lMnPQVOpJNoCf72jvK7+h81IHzoSuhR7pmGZcPQRyWvzx1R1GEtcD+IHjySMo1iCBfHhmWAdwjwcCw5PNWV5L4JsGnubNrqVPOielaQCh5qSq3KRBIc66FaBRtdBFqKVpnzm5Ctjv8Dgag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=btMw55hj; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757070581; x=1788606581;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7m/86o3yQ77TEdGSH2MiSbmes09C1SQZCM+n87rz7fg=;
  b=btMw55hjbBZs6N/QPh47X4FjGcefjA4z+UmuZG5jcrM9XXjd9jbsgQhg
   Z4RnK8wP1i0w8bSypqZ/FNU45tFfqXIqPyeROlII+vrOiBUIrzSU+8Ihr
   Tj4hDO+aiuRpI+AlazFkxh32nMHnegT9D4z7o+SKCbnAHpoqS5f9wILkO
   J46UbmxS7BUcpZpPsw7drfPk3axRm3hKsL/zv/ETEAXUUDryykI07+rc8
   Enpu91XHMzTdWk+WMYUjM2vYXXDbhB5baCAjBXjclz4COsZMff9B7514V
   dZpvhJ9808hJAtpS/RDB92In2lZ49Sg8FC0kPZLnZ1XlM2js2Jh8EoBwo
   g==;
X-CSE-ConnectionGUID: 2DmGJfxPSe6pezeaP5nM3Q==
X-CSE-MsgGUID: 1HMOVnrDQs2fRjR+ORZejw==
X-IronPort-AV: E=McAfee;i="6800,10657,11543"; a="58454999"
X-IronPort-AV: E=Sophos;i="6.18,241,1751266800"; 
   d="scan'208";a="58454999"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 04:09:40 -0700
X-CSE-ConnectionGUID: Q+k0m8w6TqGxOoJFGC8I5g==
X-CSE-MsgGUID: NcHeEyL0SVK7RRDj8ZOf7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,241,1751266800"; 
   d="scan'208";a="202960490"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by orviesa002.jf.intel.com with SMTP; 05 Sep 2025 04:09:35 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 05 Sep 2025 14:09:34 +0300
Date: Fri, 5 Sep 2025 14:09:34 +0300
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
Subject: Re: [PATCH RFC 10/22] usb: typec: tipd: Move switch_power_state to
 tipd_data
Message-ID: <aLrE7uzHH-ZloOWS@kuha.fi.intel.com>
References: <20250821-atcphy-6-17-v1-0-172beda182b8@kernel.org>
 <20250821-atcphy-6-17-v1-10-172beda182b8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821-atcphy-6-17-v1-10-172beda182b8@kernel.org>

On Thu, Aug 21, 2025 at 03:39:02PM +0000, Sven Peter wrote:
> When support for CD321x was originally added no other hardware variant
> was supported and there was no need for struct tipd_data. Now that it
> exists move the special case in there so that we can drop the
> of_device_is_compatible_check entirely.
> 
> Signed-off-by: Sven Peter <sven@kernel.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tipd/core.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> index 6d8bcbc9cad8a1394e066504d4c5ca570edd4e4f..4815c5c462837865a5f9d37bbc139249c82c2f75 100644
> --- a/drivers/usb/typec/tipd/core.c
> +++ b/drivers/usb/typec/tipd/core.c
> @@ -118,6 +118,7 @@ struct tipd_data {
>  	void (*trace_status)(u32 status);
>  	int (*apply_patch)(struct tps6598x *tps);
>  	int (*init)(struct tps6598x *tps);
> +	int (*switch_power_state)(struct tps6598x *tps, u8 target_state);
>  	int (*reset)(struct tps6598x *tps);
>  };
>  
> @@ -1293,7 +1294,6 @@ tps25750_register_port(struct tps6598x *tps, struct fwnode_handle *fwnode)
>  
>  static int tps6598x_probe(struct i2c_client *client)
>  {
> -	struct device_node *np = client->dev.of_node;
>  	struct tps6598x *tps;
>  	struct fwnode_handle *fwnode;
>  	u32 status;
> @@ -1331,18 +1331,16 @@ static int tps6598x_probe(struct i2c_client *client)
>  	if (i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
>  		tps->i2c_protocol = true;
>  
> -	if (np && of_device_is_compatible(np, "apple,cd321x")) {
> -		/* Switch CD321X chips to the correct system power state */
> -		ret = cd321x_switch_power_state(tps, TPS_SYSTEM_POWER_STATE_S0);
> -		if (ret)
> -			return ret;
> -
> -	}
> -
>  	tps->data = i2c_get_match_data(client);
>  	if (!tps->data)
>  		return -EINVAL;
>  
> +	if (tps->data->switch_power_state) {
> +		ret = tps->data->switch_power_state(tps, TPS_SYSTEM_POWER_STATE_S0);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	/* Make sure the controller has application firmware running */
>  	ret = tps6598x_check_mode(tps);
>  	if (ret < 0)
> @@ -1525,6 +1523,7 @@ static const struct tipd_data cd321x_data = {
>  	.trace_status = trace_tps6598x_status,
>  	.init = cd321x_init,
>  	.reset = cd321x_reset,
> +	.switch_power_state = cd321x_switch_power_state,
>  };
>  
>  static const struct tipd_data tps6598x_data = {
> 
> -- 
> 2.34.1
> 

-- 
heikki

