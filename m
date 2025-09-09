Return-Path: <linux-kernel+bounces-807740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2EB0B4A8AC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 11:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2B091893C35
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 09:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793342D239F;
	Tue,  9 Sep 2025 09:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WiuJqTct"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EDC2D130A;
	Tue,  9 Sep 2025 09:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757410894; cv=none; b=Z6V5dUGsrcD04mnGZcNnN1ZzNw6smY/zzKQeDr7GDWXAiONtzQeivuONdNQuc7OeD1TCvDEelGSsrjOlWnxadpttBX4wessLjwUROM+CYRCUPVdiHQ91DKQZavnG4qzjK0csQy0qvIIK2a0lrCsdu0Hzt3Pz3c3YPXZ9SmpfIbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757410894; c=relaxed/simple;
	bh=iDZvQAjGdFONOD0C7BJifOhr90vJwi4Gs1ZMg3jQOdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NQwY07MY9BDE+aqHJdIoODe94vnIo7dFjtZFcTsRbKKz9KPsrDwBvZqyDj4UyIwwBakgJH9H0XUzWNJpwpPdK2TMauajbDmhASRzX0ANR/azk6ekZC/uRngGOh/v+NmJEK/e7qCQehMiDe/EdSI8ulyQlUTTVmjg8GnFTE56d+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WiuJqTct; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757410892; x=1788946892;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iDZvQAjGdFONOD0C7BJifOhr90vJwi4Gs1ZMg3jQOdU=;
  b=WiuJqTctcrNXsBYQIA5Lw/Q4ua6oji3tR51RSX4tZ8fT2S/NJnoOhQfA
   d26w0wCdnOMPHKKh/hy2nzcqz3qi8ddGldD2rpuvLtdTcCGFtARUNAOkh
   7/I56J+5EC435j4AljPZkLPmPkuidmB7TrTU7CHRmkVcaOamwWy9ORN00
   Whn6FQsEaO/CmvLTARfZgI+qYwjQ5tXSfpPdWoY8jL6V2mWxsXgUNTVkP
   C7/k1zyXaRfyVCR2ZvGUczIQ6MUhWlcbN5OHEL8v3awsLyFkYXhlyrGTz
   PHvj+cZjkvy8ouhsMmFQM4R9hb9OGo7xNeTujLwiQbBUcPXZjzHZgZcfH
   w==;
X-CSE-ConnectionGUID: eXwRG7/zSNOYhdvTI5m9Pg==
X-CSE-MsgGUID: 7Q8xyct2QXGtbrUSSQifeg==
X-IronPort-AV: E=McAfee;i="6800,10657,11547"; a="62315387"
X-IronPort-AV: E=Sophos;i="6.18,251,1751266800"; 
   d="scan'208";a="62315387"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 02:41:32 -0700
X-CSE-ConnectionGUID: y4y1TQowQ3WfYBEL7QqmVw==
X-CSE-MsgGUID: A6PAWP7WSNC5vsBA9uaY2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,251,1751266800"; 
   d="scan'208";a="173163265"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by orviesa008.jf.intel.com with SMTP; 09 Sep 2025 02:41:25 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 09 Sep 2025 12:41:23 +0300
Date: Tue, 9 Sep 2025 12:41:23 +0300
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
Subject: Re: [PATCH v2 10/22] usb: typec: tipd: Read USB4, Thunderbolt and
 DisplayPort status for cd321x
Message-ID: <aL_2Q6obeQdYZuHE@kuha.fi.intel.com>
References: <20250906-atcphy-6-17-v2-0-52c348623ef6@kernel.org>
 <20250906-atcphy-6-17-v2-10-52c348623ef6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250906-atcphy-6-17-v2-10-52c348623ef6@kernel.org>

On Sat, Sep 06, 2025 at 03:43:23PM +0000, Sven Peter wrote:
> CD321x supports various alternate modes and stores information once
> these are entered into separate status registers. Read those when they
> are active when reading TPS_DATA_STATUS to prepare supporting these.
> 
> Signed-off-by: Sven Peter <sven@kernel.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tipd/core.c | 80 ++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 76 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> index 51b0f3be8b66a743ddc3ea96c1b25f597a1e8f6c..afd11b3e1ae596c7f3283e4336aaa57874c9378d 100644
> --- a/drivers/usb/typec/tipd/core.c
> +++ b/drivers/usb/typec/tipd/core.c
> @@ -35,14 +35,18 @@
>  #define TPS_REG_INT_MASK2		0x17
>  #define TPS_REG_INT_CLEAR1		0x18
>  #define TPS_REG_INT_CLEAR2		0x19
> -#define TPS_REG_SYSTEM_POWER_STATE	0x20
>  #define TPS_REG_STATUS			0x1a
> +#define TPS_REG_SYSTEM_POWER_STATE	0x20
> +#define TPS_REG_USB4_STATUS		0x24
>  #define TPS_REG_SYSTEM_CONF		0x28
>  #define TPS_REG_CTRL_CONF		0x29
>  #define TPS_REG_BOOT_STATUS		0x2D
>  #define TPS_REG_POWER_STATUS		0x3f
>  #define TPS_REG_PD_STATUS		0x40
>  #define TPS_REG_RX_IDENTITY_SOP		0x48
> +#define TPS_REG_CF_VID_STATUS		0x5e
> +#define TPS_REG_DP_SID_STATUS		0x58
> +#define TPS_REG_INTEL_VID_STATUS	0x59
>  #define TPS_REG_DATA_STATUS		0x5f
>  #define TPS_REG_SLEEP_CONF		0x70
>  
> @@ -85,6 +89,31 @@ struct tps6598x_rx_identity_reg {
>  	struct usb_pd_identity identity;
>  } __packed;
>  
> +/* TPS_REG_USB4_STATUS */
> +struct tps6598x_usb4_status_reg {
> +	u8 mode_status;
> +	__le32 eudo;
> +	__le32 unknown;
> +} __packed;
> +
> +/* TPS_REG_DP_SID_STATUS */
> +struct tps6598x_dp_sid_status_reg {
> +	u8 mode_status;
> +	__le32 status_tx;
> +	__le32 status_rx;
> +	__le32 configure;
> +	__le32 mode_data;
> +} __packed;
> +
> +/* TPS_REG_INTEL_VID_STATUS */
> +struct tps6598x_intel_vid_status_reg {
> +	u8 mode_status;
> +	__le32 attention_vdo;
> +	__le16 enter_vdo;
> +	__le16 device_mode;
> +	__le16 cable_mode;
> +} __packed;
> +
>  /* Standard Task return codes */
>  #define TPS_TASK_TIMEOUT		1
>  #define TPS_TASK_REJECTED		3
> @@ -121,6 +150,7 @@ struct tipd_data {
>  	int (*apply_patch)(struct tps6598x *tps);
>  	int (*init)(struct tps6598x *tps);
>  	int (*switch_power_state)(struct tps6598x *tps, u8 target_state);
> +	bool (*read_data_status)(struct tps6598x *tps);
>  	int (*reset)(struct tps6598x *tps);
>  };
>  
> @@ -151,6 +181,10 @@ struct tps6598x {
>  
>  struct cd321x {
>  	struct tps6598x tps;
> +
> +	struct tps6598x_dp_sid_status_reg dp_sid_status;
> +	struct tps6598x_intel_vid_status_reg intel_vid_status;
> +	struct tps6598x_usb4_status_reg usb4_status;
>  };
>  
>  static enum power_supply_property tps6598x_psy_props[] = {
> @@ -505,6 +539,41 @@ static bool tps6598x_read_data_status(struct tps6598x *tps)
>  	return true;
>  }
>  
> +static bool cd321x_read_data_status(struct tps6598x *tps)
> +{
> +	struct cd321x *cd321x = container_of(tps, struct cd321x, tps);
> +	int ret;
> +
> +	ret = tps6598x_read_data_status(tps);
> +	if (ret < 0)
> +		return false;
> +
> +	if (tps->data_status & TPS_DATA_STATUS_DP_CONNECTION) {
> +		ret = tps6598x_block_read(tps, TPS_REG_DP_SID_STATUS,
> +				&cd321x->dp_sid_status, sizeof(cd321x->dp_sid_status));
> +		if (ret)
> +			dev_err(tps->dev, "Failed to read DP SID Status: %d\n",
> +				ret);
> +	}
> +
> +	if (tps->data_status & TPS_DATA_STATUS_TBT_CONNECTION) {
> +		ret = tps6598x_block_read(tps, TPS_REG_INTEL_VID_STATUS,
> +				&cd321x->intel_vid_status, sizeof(cd321x->intel_vid_status));
> +		if (ret)
> +			dev_err(tps->dev, "Failed to read Intel VID Status: %d\n", ret);
> +	}
> +
> +	if (tps->data_status & CD321X_DATA_STATUS_USB4_CONNECTION) {
> +		ret = tps6598x_block_read(tps, TPS_REG_USB4_STATUS,
> +				&cd321x->usb4_status, sizeof(cd321x->usb4_status));
> +		if (ret)
> +			dev_err(tps->dev,
> +				"Failed to read USB4 Status: %d\n", ret);
> +	}
> +
> +	return true;
> +}
> +
>  static bool tps6598x_read_power_status(struct tps6598x *tps)
>  {
>  	u16 pwr_status;
> @@ -565,7 +634,7 @@ static irqreturn_t cd321x_interrupt(int irq, void *data)
>  			goto err_unlock;
>  
>  	if (event & APPLE_CD_REG_INT_DATA_STATUS_UPDATE)
> -		if (!tps6598x_read_data_status(tps))
> +		if (!tps->data->read_data_status(tps))
>  			goto err_unlock;
>  
>  	/* Handle plug insert or removal */
> @@ -614,7 +683,7 @@ static irqreturn_t tps25750_interrupt(int irq, void *data)
>  			goto err_clear_ints;
>  
>  	if (event[0] & TPS_REG_INT_DATA_STATUS_UPDATE)
> -		if (!tps6598x_read_data_status(tps))
> +		if (!tps->data->read_data_status(tps))
>  			goto err_clear_ints;
>  
>  	/*
> @@ -688,7 +757,7 @@ static irqreturn_t tps6598x_interrupt(int irq, void *data)
>  			goto err_unlock;
>  
>  	if ((event1[0] | event2[0]) & TPS_REG_INT_DATA_STATUS_UPDATE)
> -		if (!tps6598x_read_data_status(tps))
> +		if (!tps->data->read_data_status(tps))
>  			goto err_unlock;
>  
>  	/* Handle plug insert or removal */
> @@ -1534,6 +1603,7 @@ static const struct tipd_data cd321x_data = {
>  	.trace_power_status = trace_tps6598x_power_status,
>  	.trace_status = trace_tps6598x_status,
>  	.init = cd321x_init,
> +	.read_data_status = cd321x_read_data_status,
>  	.reset = cd321x_reset,
>  	.switch_power_state = cd321x_switch_power_state,
>  };
> @@ -1550,6 +1620,7 @@ static const struct tipd_data tps6598x_data = {
>  	.trace_status = trace_tps6598x_status,
>  	.apply_patch = tps6598x_apply_patch,
>  	.init = tps6598x_init,
> +	.read_data_status = tps6598x_read_data_status,
>  	.reset = tps6598x_reset,
>  };
>  
> @@ -1565,6 +1636,7 @@ static const struct tipd_data tps25750_data = {
>  	.trace_status = trace_tps25750_status,
>  	.apply_patch = tps25750_apply_patch,
>  	.init = tps25750_init,
> +	.read_data_status = tps6598x_read_data_status,
>  	.reset = tps25750_reset,
>  };

-- 
heikki

