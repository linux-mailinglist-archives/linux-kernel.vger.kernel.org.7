Return-Path: <linux-kernel+bounces-807750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3D8B4A8D7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 11:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F89F7BDE4B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 09:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C66D2D2480;
	Tue,  9 Sep 2025 09:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Obor1TMN"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653382D239D;
	Tue,  9 Sep 2025 09:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757411272; cv=none; b=k3HjYQfQfby27/aZwgCQ6KxXAaNYieOkQ5ayymj4Hs9xpMHEg1/NEJvUrnYP4e3AKGAhwp3LBAxEqQ9viJI/ZdzmmojrLs/mj//wa0wkxr2l4QBgHBaSU4Nv8qAiHxuzyfL0MQZqQCpBMVrW2dmVi5BDMvW9FlWOr4j/vkefddw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757411272; c=relaxed/simple;
	bh=JrPGhCJ7nJZqXECYZOjxg/ffsRI6LCeK6wQeJaLY740=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SCzSDqoyLTKab4/gm55SrKTuL1e3lWauzJIGyI7lryqUsxRhQiCLjaRH+OMICs+hH3iUXiqry6js442wB476O+vTMBEPBUaiGbwq5W1nBXSjmLW2PwOscUD/EzuiiV4kPC+cXF6im3QtXga8bBGm/rMfZcEf+0IUvThsySlOt7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Obor1TMN; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757411271; x=1788947271;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JrPGhCJ7nJZqXECYZOjxg/ffsRI6LCeK6wQeJaLY740=;
  b=Obor1TMNaA1nQ3KRNRykQizITzHocfqG2hUBzUdV7zEo5mjbMwZyEUWD
   z2whlB5VlqV4pEWLLDMAIDD1lDf/2xmfOSZQX8u7FHerPg3yyR6l30Dug
   QYocmMa4L1BF69M63+WtpvgNzj9wfDu4ZBSFw6r2BeFX1nzjc9JZ/BIJ9
   wwHC0Z8Ll0G9seic9x1jF57gc6JWH5ccHgHadsRzohl88YWIPqz4S6L2I
   sC6/2r8UtpvKl51QHgQscLDtwFZ43kqIZN4rGoxfMHfm0Ru6pxRcONwGJ
   fu2ogXCAzns/Fzy2O88dzoSlqBwocxt5u6uwW2eNGwj9u2lLDYQ4zMhsD
   Q==;
X-CSE-ConnectionGUID: Nqdti6QESIiBfdypcxbaow==
X-CSE-MsgGUID: DQvlQYsNQaCUrN7+b3jxww==
X-IronPort-AV: E=McAfee;i="6800,10657,11547"; a="59624989"
X-IronPort-AV: E=Sophos;i="6.18,251,1751266800"; 
   d="scan'208";a="59624989"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 02:47:50 -0700
X-CSE-ConnectionGUID: NpxynYzHTfWJfZtZqNyrWQ==
X-CSE-MsgGUID: AHAG1jdMRGmJ/7J4oPLZ8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,251,1751266800"; 
   d="scan'208";a="210194115"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by orviesa001.jf.intel.com with SMTP; 09 Sep 2025 02:47:43 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 09 Sep 2025 12:47:42 +0300
Date: Tue, 9 Sep 2025 12:47:42 +0300
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
	Philipp Zabel <p.zabel@pengutronix.de>, Frank Li <Frank.Li@nxp.com>,
	Ran Wang <ran.wang_1@nxp.com>, Peter Chen <peter.chen@nxp.com>,
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org
Subject: Re: [PATCH v2 11/22] usb: typec: tipd: Register DisplayPort and
 Thunderbolt altmodes for cd321x
Message-ID: <aL_3vn7VYiapI3_N@kuha.fi.intel.com>
References: <20250906-atcphy-6-17-v2-0-52c348623ef6@kernel.org>
 <20250906-atcphy-6-17-v2-11-52c348623ef6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250906-atcphy-6-17-v2-11-52c348623ef6@kernel.org>

On Sat, Sep 06, 2025 at 03:43:24PM +0000, Sven Peter wrote:
> Ports equipped with a CD321x are only found on Apple Silicon machines
> and always support DisplayPort, Thunderbolt and USB4. Register these
> port modes unconditionally.
> 
> Signed-off-by: Sven Peter <sven@kernel.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tipd/core.c | 85 +++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 82 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> index afd11b3e1ae596c7f3283e4336aaa57874c9378d..c7cf936e5a61a331271c05b68ff1b77b89c0f643 100644
> --- a/drivers/usb/typec/tipd/core.c
> +++ b/drivers/usb/typec/tipd/core.c
> @@ -16,6 +16,8 @@
>  #include <linux/interrupt.h>
>  #include <linux/usb/typec.h>
>  #include <linux/usb/typec_altmode.h>
> +#include <linux/usb/typec_dp.h>
> +#include <linux/usb/typec_tbt.h>
>  #include <linux/usb/role.h>
>  #include <linux/workqueue.h>
>  #include <linux/firmware.h>
> @@ -144,6 +146,7 @@ struct tipd_data {
>  	u64 irq_mask1;
>  	size_t tps_struct_size;
>  	int (*register_port)(struct tps6598x *tps, struct fwnode_handle *node);
> +	void (*unregister_port)(struct tps6598x *tps);
>  	void (*trace_data_status)(u32 status);
>  	void (*trace_power_status)(u16 status);
>  	void (*trace_status)(u32 status);
> @@ -185,6 +188,9 @@ struct cd321x {
>  	struct tps6598x_dp_sid_status_reg dp_sid_status;
>  	struct tps6598x_intel_vid_status_reg intel_vid_status;
>  	struct tps6598x_usb4_status_reg usb4_status;
> +
> +	struct typec_altmode *port_altmode_dp;
> +	struct typec_altmode *port_altmode_tbt;
>  };
>  
>  static enum power_supply_property tps6598x_psy_props[] = {
> @@ -964,6 +970,76 @@ tps6598x_register_port(struct tps6598x *tps, struct fwnode_handle *fwnode)
>  	return 0;
>  }
>  
> +static int cd321x_register_port_altmodes(struct cd321x *cd321x)
> +{
> +	struct typec_altmode_desc desc;
> +	struct typec_altmode *amode;
> +
> +	memset(&desc, 0, sizeof(desc));
> +	desc.svid = USB_TYPEC_DP_SID;
> +	desc.mode = USB_TYPEC_DP_MODE;
> +	desc.vdo = DP_CONF_SET_PIN_ASSIGN(BIT(DP_PIN_ASSIGN_C) | BIT(DP_PIN_ASSIGN_D));
> +	desc.vdo |= DP_CAP_DFP_D;
> +	amode = typec_port_register_altmode(cd321x->tps.port, &desc);
> +	if (IS_ERR(amode))
> +		return PTR_ERR(amode);
> +	cd321x->port_altmode_dp = amode;
> +
> +	memset(&desc, 0, sizeof(desc));
> +	desc.svid = USB_TYPEC_TBT_SID;
> +	desc.mode = TYPEC_ANY_MODE;
> +	amode = typec_port_register_altmode(cd321x->tps.port, &desc);
> +	if (IS_ERR(amode)) {
> +		typec_unregister_altmode(cd321x->port_altmode_dp);
> +		cd321x->port_altmode_dp = NULL;
> +		return PTR_ERR(amode);
> +	}
> +	cd321x->port_altmode_tbt = amode;
> +
> +	return 0;
> +}
> +
> +static int
> +cd321x_register_port(struct tps6598x *tps, struct fwnode_handle *fwnode)
> +{
> +	struct cd321x *cd321x = container_of(tps, struct cd321x, tps);
> +	int ret;
> +
> +	ret = tps6598x_register_port(tps, fwnode);
> +	if (ret)
> +		return ret;
> +
> +	ret = cd321x_register_port_altmodes(cd321x);
> +	if (ret)
> +		goto err_unregister_port;
> +
> +	typec_set_mode(tps->port, TYPEC_STATE_SAFE);
> +
> +	return 0;
> +
> +err_unregister_port:
> +	typec_unregister_port(tps->port);
> +	return ret;
> +}
> +
> +static void
> +tps6598x_unregister_port(struct tps6598x *tps)
> +{
> +	typec_unregister_port(tps->port);
> +}
> +
> +static void
> +cd321x_unregister_port(struct tps6598x *tps)
> +{
> +	struct cd321x *cd321x = container_of(tps, struct cd321x, tps);
> +
> +	typec_unregister_altmode(cd321x->port_altmode_dp);
> +	cd321x->port_altmode_dp = NULL;
> +	typec_unregister_altmode(cd321x->port_altmode_tbt);
> +	cd321x->port_altmode_tbt = NULL;
> +	typec_unregister_port(tps->port);
> +}
> +
>  static int tps_request_firmware(struct tps6598x *tps, const struct firmware **fw,
>  				const char **firmware_name)
>  {
> @@ -1505,7 +1581,7 @@ static int tps6598x_probe(struct i2c_client *client)
>  err_disconnect:
>  	tps6598x_disconnect(tps, 0);
>  err_unregister_port:
> -	typec_unregister_port(tps->port);
> +	tps->data->unregister_port(tps);
>  err_role_put:
>  	usb_role_switch_put(tps->role_sw);
>  err_fwnode_put:
> @@ -1529,7 +1605,7 @@ static void tps6598x_remove(struct i2c_client *client)
>  		devm_free_irq(tps->dev, client->irq, tps);
>  
>  	tps6598x_disconnect(tps, 0);
> -	typec_unregister_port(tps->port);
> +	tps->data->unregister_port(tps);
>  	usb_role_switch_put(tps->role_sw);
>  
>  	/* Reset PD controller to remove any applied patch */
> @@ -1598,7 +1674,8 @@ static const struct tipd_data cd321x_data = {
>  		     APPLE_CD_REG_INT_DATA_STATUS_UPDATE |
>  		     APPLE_CD_REG_INT_PLUG_EVENT,
>  	.tps_struct_size = sizeof(struct cd321x),
> -	.register_port = tps6598x_register_port,
> +	.register_port = cd321x_register_port,
> +	.unregister_port = cd321x_unregister_port,
>  	.trace_data_status = trace_cd321x_data_status,
>  	.trace_power_status = trace_tps6598x_power_status,
>  	.trace_status = trace_tps6598x_status,
> @@ -1615,6 +1692,7 @@ static const struct tipd_data tps6598x_data = {
>  		     TPS_REG_INT_PLUG_EVENT,
>  	.tps_struct_size = sizeof(struct tps6598x),
>  	.register_port = tps6598x_register_port,
> +	.unregister_port = tps6598x_unregister_port,
>  	.trace_data_status = trace_tps6598x_data_status,
>  	.trace_power_status = trace_tps6598x_power_status,
>  	.trace_status = trace_tps6598x_status,
> @@ -1631,6 +1709,7 @@ static const struct tipd_data tps25750_data = {
>  		     TPS_REG_INT_PLUG_EVENT,
>  	.tps_struct_size = sizeof(struct tps6598x),
>  	.register_port = tps25750_register_port,
> +	.unregister_port = tps6598x_unregister_port,
>  	.trace_data_status = trace_tps6598x_data_status,
>  	.trace_power_status = trace_tps25750_power_status,
>  	.trace_status = trace_tps25750_status,
> 
> -- 
> 2.34.1
> 

-- 
heikki

