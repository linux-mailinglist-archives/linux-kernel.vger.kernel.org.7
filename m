Return-Path: <linux-kernel+bounces-807814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B03B4A9AC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 12:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C4F51BC778F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 10:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B092741C6;
	Tue,  9 Sep 2025 10:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="miO1SnoU"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6826029993A;
	Tue,  9 Sep 2025 10:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757412630; cv=none; b=Tm1opm3kPowjNOHyGj869PRPXnXGI+RDDTILfCnzJ2pdO9h9LWSslT82VccsfhjhDDjF5wOkaJ1WIUJD4ONhw4YhLD7DGzr2CJY4oU+CiCFZqn2FnMnisubnA5kMqmVohF3w1D33RYi9O33gxn+W9nwpoX9uQjeXFPkaFv7jI2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757412630; c=relaxed/simple;
	bh=gMNjfjMRgGdXnedqzeagPwQAloyWCSOeznRWmXJbD5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jmYsqJETqs03yBw511zD0SlinoJitc+1QopDqGcE466VBsTS6w1OsrVz026vDtVGPYyN3qeM4n/L6k24bHIfqYXemvwvJh5pfnycuCqw/S2tpMjdZG7ta6K4TtX+JMtgNsbFpz6VFRqWD0XJhjA6/JX9+euefLymz6OpQ2eI2bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=miO1SnoU; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757412629; x=1788948629;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gMNjfjMRgGdXnedqzeagPwQAloyWCSOeznRWmXJbD5c=;
  b=miO1SnoU/Bnyf+PszBtPyEKjJ6H5W77fTY8vujUZK0MMNs1rhJSmL9RX
   EQXemSQUgsp7RDYZn4ez9Bvx8m/CYbtpk3KC4gyOhUuy9ZdT02zHbbHqq
   ZE6sywm6Mik0kFwWTMEYMf2j3mFPhVJnfyPcmjyvvEM47C3g24XXxcNCq
   5rlRZpbvNmNK79xhNRg1901xchuSLXjXZmHIJcKcMNnzWXXBeI1EiJicT
   q4YYwyo5aef33bvUDFDDkLeOx0CFFsZvHvtBGNIMZKFoLb7KQIbJZ8VDU
   Dr54VI5ZMsry3vv3Da+SbZHvmW1ePoMFINKiHR7msCTHHowjUfUGC2Rla
   Q==;
X-CSE-ConnectionGUID: 7YFiW3AVRmermgR1UPZYSA==
X-CSE-MsgGUID: EZ876tXATVSjv8yvK232Sw==
X-IronPort-AV: E=McAfee;i="6800,10657,11547"; a="70790808"
X-IronPort-AV: E=Sophos;i="6.18,251,1751266800"; 
   d="scan'208";a="70790808"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 03:10:28 -0700
X-CSE-ConnectionGUID: s0J5BQaFSXm+vy5L4YS1Fw==
X-CSE-MsgGUID: yKHGTP2uTp2Gxeds2WxM2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,251,1751266800"; 
   d="scan'208";a="172314372"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by orviesa010.jf.intel.com with SMTP; 09 Sep 2025 03:10:22 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 09 Sep 2025 13:10:21 +0300
Date: Tue, 9 Sep 2025 13:10:21 +0300
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
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org,
	Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH v2 15/22] usb: typec: tipd: Handle mode transitions for
 CD321x
Message-ID: <aL_9DShYiN1GZKgm@kuha.fi.intel.com>
References: <20250906-atcphy-6-17-v2-0-52c348623ef6@kernel.org>
 <20250906-atcphy-6-17-v2-15-52c348623ef6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250906-atcphy-6-17-v2-15-52c348623ef6@kernel.org>

On Sat, Sep 06, 2025 at 03:43:28PM +0000, Sven Peter wrote:
> From: Hector Martin <marcan@marcan.st>
> 
> On Apple Silicon machines there is no control over which alt mode is
> chosen. The CD321x' firmware negotiates the target mode on its own and
> only lets the main CPU know after the mode has already been chosen.
> Especially after plugging a new cable in this can result to quick mode
> changes from e.g. power only -> USB3 only -> USB3+DisplayPort in a short
> time. It is not possile to influence this in any way and we also do not
> get direct access to the PDOs or VDOs exchanged via USB PD.
> 
> Additionally, mode changes must be tightly synchronized between DWC3 and
> the Type C PHY and most mode changes require a full reset of DWC3 to
> make the port work correctly.
> On the machines the usb role change is used to reset the controller.
> The role change is additionally done synchronously from the callback
> instead of relying on a workqueue as usual in order to avoid any races
> which can, in the worst case, result in resetting the entire SoC if
> Type-C PHY and DWC3 are out of sync.
> 
> To be able to control all this we trigger the entire process in the
> correct order directly from the TIPD driver and de-bounce any mode
> changes to avoid tearing down and re-setting DWC3 back up multiple times
> any time a new connection is made.
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> Co-developed-by: Sven Peter <sven@kernel.org>
> Signed-off-by: Sven Peter <sven@kernel.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tipd/core.c | 297 +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 293 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> index b558fc5ecbc35a9dabbf33c444f38173740af7c3..95218e8be65dbbb594465961b1fda76eed1e266c 100644
> --- a/drivers/usb/typec/tipd/core.c
> +++ b/drivers/usb/typec/tipd/core.c
> @@ -17,6 +17,7 @@
>  #include <linux/usb/typec.h>
>  #include <linux/usb/typec_altmode.h>
>  #include <linux/usb/typec_dp.h>
> +#include <linux/usb/typec_mux.h>
>  #include <linux/usb/typec_tbt.h>
>  #include <linux/usb/role.h>
>  #include <linux/workqueue.h>
> @@ -120,6 +121,9 @@ struct tps6598x_intel_vid_status_reg {
>  #define TPS_TASK_TIMEOUT		1
>  #define TPS_TASK_REJECTED		3
>  
> +/* Debounce delay for mode changes, in milliseconds */
> +#define CD321X_DEBOUNCE_DELAY_MS 500
> +
>  enum {
>  	TPS_MODE_APP,
>  	TPS_MODE_BOOT,
> @@ -145,6 +149,7 @@ struct tipd_data {
>  	irq_handler_t irq_handler;
>  	u64 irq_mask1;
>  	size_t tps_struct_size;
> +	void (*remove)(struct tps6598x *tps);
>  	int (*register_port)(struct tps6598x *tps, struct fwnode_handle *node);
>  	void (*unregister_port)(struct tps6598x *tps);
>  	void (*trace_data_status)(u32 status);
> @@ -155,6 +160,7 @@ struct tipd_data {
>  	int (*switch_power_state)(struct tps6598x *tps, u8 target_state);
>  	bool (*read_data_status)(struct tps6598x *tps);
>  	int (*reset)(struct tps6598x *tps);
> +	int (*connect)(struct tps6598x *tps, u32 status);
>  };
>  
>  struct tps6598x {
> @@ -183,6 +189,17 @@ struct tps6598x {
>  	const struct tipd_data *data;
>  };
>  
> +struct cd321x_status {
> +	u32 status;
> +	u32 pwr_status;
> +	u32 data_status;
> +	u32 status_changed;
> +	struct usb_pd_identity partner_identity;
> +	struct tps6598x_dp_sid_status_reg dp_sid_status;
> +	struct tps6598x_intel_vid_status_reg intel_vid_status;
> +	struct tps6598x_usb4_status_reg usb4_status;
> +};
> +
>  struct cd321x {
>  	struct tps6598x tps;
>  
> @@ -192,6 +209,13 @@ struct cd321x {
>  
>  	struct typec_altmode *port_altmode_dp;
>  	struct typec_altmode *port_altmode_tbt;
> +
> +	struct typec_mux *mux;
> +	struct typec_mux_state state;
> +
> +	struct cd321x_status update_status;
> +	struct delayed_work update_work;
> +	struct usb_pd_identity cur_partner_identity;
>  };
>  
>  static enum power_supply_property tps6598x_psy_props[] = {
> @@ -613,9 +637,229 @@ static void tps6598x_handle_plug_event(struct tps6598x *tps, u32 status)
>  	}
>  }
>  
> +static void cd321x_typec_update_mode(struct tps6598x *tps, struct cd321x_status *st)
> +{
> +	struct cd321x *cd321x = container_of(tps, struct cd321x, tps);
> +
> +	if (!(st->data_status & TPS_DATA_STATUS_DATA_CONNECTION)) {
> +		if (cd321x->state.mode == TYPEC_STATE_SAFE)
> +			return;
> +		cd321x->state.alt = NULL;
> +		cd321x->state.mode = TYPEC_STATE_SAFE;
> +		cd321x->state.data = NULL;
> +		typec_mux_set(cd321x->mux, &cd321x->state);
> +	} else if (st->data_status & TPS_DATA_STATUS_DP_CONNECTION) {
> +		struct typec_displayport_data dp_data;
> +		unsigned long mode;
> +
> +		switch (TPS_DATA_STATUS_DP_SPEC_PIN_ASSIGNMENT(st->data_status)) {
> +		case TPS_DATA_STATUS_DP_SPEC_PIN_ASSIGNMENT_A:
> +			mode = TYPEC_DP_STATE_A;
> +			break;
> +		case TPS_DATA_STATUS_DP_SPEC_PIN_ASSIGNMENT_B:
> +			mode = TYPEC_DP_STATE_B;
> +			break;
> +		case TPS_DATA_STATUS_DP_SPEC_PIN_ASSIGNMENT_C:
> +			mode = TYPEC_DP_STATE_C;
> +			break;
> +		case TPS_DATA_STATUS_DP_SPEC_PIN_ASSIGNMENT_D:
> +			mode = TYPEC_DP_STATE_D;
> +			break;
> +		case TPS_DATA_STATUS_DP_SPEC_PIN_ASSIGNMENT_E:
> +			mode = TYPEC_DP_STATE_E;
> +			break;
> +		case TPS_DATA_STATUS_DP_SPEC_PIN_ASSIGNMENT_F:
> +			mode = TYPEC_DP_STATE_F;
> +			break;
> +		default:
> +			dev_err(tps->dev, "Invalid DP pin assignment\n");
> +			return;
> +		}
> +
> +		if (cd321x->state.alt == cd321x->port_altmode_dp &&
> +		   cd321x->state.mode == mode) {
> +			return;
> +		}
> +
> +		dp_data.status = le32_to_cpu(st->dp_sid_status.status_rx);
> +		dp_data.conf = le32_to_cpu(st->dp_sid_status.configure);
> +		cd321x->state.alt = cd321x->port_altmode_dp;
> +		cd321x->state.data = &dp_data;
> +		cd321x->state.mode = mode;
> +		typec_mux_set(cd321x->mux, &cd321x->state);
> +	} else if (st->data_status & TPS_DATA_STATUS_TBT_CONNECTION) {
> +		struct typec_thunderbolt_data tbt_data;
> +
> +		if (cd321x->state.alt == cd321x->port_altmode_tbt &&
> +		   cd321x->state.mode == TYPEC_TBT_MODE)
> +			return;
> +
> +		tbt_data.cable_mode = le16_to_cpu(st->intel_vid_status.cable_mode);
> +		tbt_data.device_mode = le16_to_cpu(st->intel_vid_status.device_mode);
> +		tbt_data.enter_vdo = le16_to_cpu(st->intel_vid_status.enter_vdo);
> +		cd321x->state.alt = cd321x->port_altmode_tbt;
> +		cd321x->state.mode = TYPEC_TBT_MODE;
> +		cd321x->state.data = &tbt_data;
> +		typec_mux_set(cd321x->mux, &cd321x->state);
> +	} else if (st->data_status & CD321X_DATA_STATUS_USB4_CONNECTION) {
> +		struct enter_usb_data eusb_data;
> +
> +		if (cd321x->state.alt == NULL && cd321x->state.mode == TYPEC_MODE_USB4)
> +			return;
> +
> +		eusb_data.eudo = le32_to_cpu(st->usb4_status.eudo);
> +		eusb_data.active_link_training =
> +			!!(st->data_status & TPS_DATA_STATUS_ACTIVE_LINK_TRAIN);
> +
> +		cd321x->state.alt = NULL;
> +		cd321x->state.data = &eusb_data;
> +		cd321x->state.mode = TYPEC_MODE_USB4;
> +		typec_mux_set(cd321x->mux, &cd321x->state);
> +	} else {
> +		if (cd321x->state.alt == NULL && cd321x->state.mode == TYPEC_STATE_USB)
> +			return;
> +		cd321x->state.alt = NULL;
> +		cd321x->state.mode = TYPEC_STATE_USB;
> +		cd321x->state.data = NULL;
> +		typec_mux_set(cd321x->mux, &cd321x->state);
> +	}
> +}
> +
> +static void cd321x_update_work(struct work_struct *work)
> +{
> +	struct cd321x *cd321x = container_of(to_delayed_work(work),
> +					    struct cd321x, update_work);
> +	struct tps6598x *tps = &cd321x->tps;
> +	struct cd321x_status st;
> +
> +	guard(mutex)(&tps->lock);
> +
> +	st = cd321x->update_status;
> +	cd321x->update_status.status_changed = 0;
> +
> +	bool old_connected = !!tps->partner;
> +	bool new_connected = st.status & TPS_STATUS_PLUG_PRESENT;
> +	bool was_disconnected = st.status_changed & TPS_STATUS_PLUG_PRESENT;
> +
> +	bool usb_connection = st.data_status &
> +			      (TPS_DATA_STATUS_USB2_CONNECTION | TPS_DATA_STATUS_USB3_CONNECTION);
> +
> +	enum usb_role old_role = usb_role_switch_get_role(tps->role_sw);
> +	enum usb_role new_role = USB_ROLE_NONE;
> +	enum typec_pwr_opmode pwr_opmode = TYPEC_PWR_MODE_USB;
> +	enum typec_orientation orientation = TYPEC_ORIENTATION_NONE;
> +
> +	if (usb_connection) {
> +		if (tps->data_status & TPS_DATA_STATUS_USB_DATA_ROLE)
> +			new_role = USB_ROLE_DEVICE;
> +		else
> +			new_role = USB_ROLE_HOST;
> +	}
> +
> +	if (new_connected) {
> +		pwr_opmode = TPS_POWER_STATUS_PWROPMODE(st.pwr_status);
> +		orientation = TPS_STATUS_TO_UPSIDE_DOWN(st.status) ?
> +			TYPEC_ORIENTATION_REVERSE : TYPEC_ORIENTATION_NORMAL;
> +	}
> +
> +	bool is_pd = pwr_opmode == TYPEC_PWR_MODE_PD;
> +	bool partner_changed = old_connected && new_connected &&
> +		(was_disconnected ||
> +		 (is_pd && memcmp(&st.partner_identity,
> +				  &cd321x->cur_partner_identity, sizeof(struct usb_pd_identity))));
> +
> +	/* If we are switching from an active role, transition to USB_ROLE_NONE first */
> +	if (old_role != USB_ROLE_NONE && (new_role != old_role || was_disconnected))
> +		usb_role_switch_set_role(tps->role_sw, USB_ROLE_NONE);
> +
> +	/* Process partner disconnection or change */
> +	if (!new_connected || partner_changed) {
> +		if (!IS_ERR(tps->partner))
> +			typec_unregister_partner(tps->partner);
> +		tps->partner = NULL;
> +	}
> +
> +	/* If there was a disconnection, set PHY to off */
> +	if (!new_connected || was_disconnected) {
> +		cd321x->state.alt = NULL;
> +		cd321x->state.mode = TYPEC_STATE_SAFE;
> +		cd321x->state.data = NULL;
> +		typec_set_mode(tps->port, TYPEC_STATE_SAFE);
> +	}
> +
> +	/* Update Type-C properties */
> +	typec_set_pwr_opmode(tps->port, pwr_opmode);
> +	typec_set_pwr_role(tps->port, TPS_STATUS_TO_TYPEC_PORTROLE(st.status));
> +	typec_set_vconn_role(tps->port, TPS_STATUS_TO_TYPEC_VCONN(st.status));
> +	typec_set_orientation(tps->port, orientation);
> +	typec_set_data_role(tps->port, TPS_STATUS_TO_TYPEC_DATAROLE(st.status));
> +	power_supply_changed(tps->psy);
> +
> +	/* If the plug is disconnected, we are done */
> +	if (!new_connected)
> +		return;
> +
> +	/* Set up partner if we were previously disconnected (or changed). */
> +	if (!tps->partner) {
> +		struct typec_partner_desc desc;
> +
> +		desc.usb_pd = is_pd;
> +		desc.accessory = TYPEC_ACCESSORY_NONE; /* XXX: handle accessories */
> +		desc.identity = NULL;
> +
> +		if (desc.usb_pd)
> +			desc.identity = &st.partner_identity;
> +
> +		tps->partner = typec_register_partner(tps->port, &desc);
> +		if (IS_ERR(tps->partner))
> +			dev_warn(tps->dev, "%s: failed to register partnet\n", __func__);
> +
> +		if (desc.identity) {
> +			typec_partner_set_identity(tps->partner);
> +			cd321x->cur_partner_identity = st.partner_identity;
> +		}
> +	}
> +
> +	/* Update the TypeC MUX/PHY state */
> +	cd321x_typec_update_mode(tps, &st);
> +
> +	/* Launch the USB role switch */
> +	usb_role_switch_set_role(tps->role_sw, new_role);
> +
> +	power_supply_changed(tps->psy);
> +}
> +
> +static void cd321x_queue_status(struct tps6598x *tps)
> +{
> +	struct cd321x *cd321x = container_of(tps, struct cd321x, tps);
> +
> +	cd321x->update_status.status_changed |= cd321x->update_status.status ^ tps->status;
> +
> +	cd321x->update_status.status = tps->status;
> +	cd321x->update_status.pwr_status = tps->pwr_status;
> +	cd321x->update_status.data_status = tps->data_status;
> +
> +	cd321x->update_status.partner_identity = tps->partner_identity;
> +	cd321x->update_status.dp_sid_status = cd321x->dp_sid_status;
> +	cd321x->update_status.intel_vid_status = cd321x->intel_vid_status;
> +	cd321x->update_status.usb4_status = cd321x->usb4_status;
> +}
> +
> +static int cd321x_connect(struct tps6598x *tps, u32 status)
> +{
> +	struct cd321x *cd321x = container_of(tps, struct cd321x, tps);
> +
> +	tps->status = status;
> +	cd321x_queue_status(tps);
> +	schedule_delayed_work(&cd321x->update_work, msecs_to_jiffies(CD321X_DEBOUNCE_DELAY_MS));
> +
> +	return 0;
> +}
> +
>  static irqreturn_t cd321x_interrupt(int irq, void *data)
>  {
>  	struct tps6598x *tps = data;
> +	struct cd321x *cd321x = container_of(tps, struct cd321x, tps);
>  	u64 event = 0;
>  	u32 status;
>  	int ret;
> @@ -652,9 +896,15 @@ static irqreturn_t cd321x_interrupt(int irq, void *data)
>  		if (!tps->data->read_data_status(tps))
>  			goto err_unlock;
>  
> -	/* Handle plug insert or removal */
> -	if (event & APPLE_CD_REG_INT_PLUG_EVENT)
> -		tps6598x_handle_plug_event(tps, status);
> +	tps->status = status;
> +	cd321x_queue_status(tps);
> +
> +	/*
> +	 * Cancel pending work if not already running.
> +	 * We will requeue the work after CD321X_DEBOUNCE_DELAY_MS regardless.
> +	 */
> +	cancel_delayed_work(&cd321x->update_work);
> +	schedule_delayed_work(&cd321x->update_work, msecs_to_jiffies(CD321X_DEBOUNCE_DELAY_MS));
>  
>  err_unlock:
>  	mutex_unlock(&tps->lock);
> @@ -1014,6 +1264,13 @@ cd321x_register_port(struct tps6598x *tps, struct fwnode_handle *fwnode)
>  	struct cd321x *cd321x = container_of(tps, struct cd321x, tps);
>  	int ret;
>  
> +	/*
> +	 * This is only called from _probe such that update_work can be
> +	 * initialized and then scheduled for the first time to handle
> +	 * plugs already connected at boot time.
> +	 */
> +	INIT_DELAYED_WORK(&cd321x->update_work, cd321x_update_work);
> +
>  	ret = tps6598x_register_port(tps, fwnode);
>  	if (ret)
>  		return ret;
> @@ -1022,10 +1279,26 @@ cd321x_register_port(struct tps6598x *tps, struct fwnode_handle *fwnode)
>  	if (ret)
>  		goto err_unregister_port;
>  
> +	cd321x->mux = fwnode_typec_mux_get(fwnode);
> +	if (IS_ERR(cd321x->mux)) {
> +		ret = PTR_ERR(cd321x->mux);
> +		goto err_unregister_altmodes;
> +	}
> +
> +	cd321x->state.alt = NULL;
> +	cd321x->state.mode = TYPEC_STATE_SAFE;
> +	cd321x->state.data = NULL;
>  	typec_set_mode(tps->port, TYPEC_STATE_SAFE);
>  
>  	return 0;
>  
> +err_unregister_altmodes:
> +	if (cd321x->port_altmode_dp)
> +		typec_unregister_altmode(cd321x->port_altmode_dp);
> +	if (cd321x->port_altmode_tbt)
> +		typec_unregister_altmode(cd321x->port_altmode_tbt);
> +	cd321x->port_altmode_dp = NULL;
> +	cd321x->port_altmode_tbt = NULL;
>  err_unregister_port:
>  	typec_unregister_port(tps->port);
>  	return ret;
> @@ -1042,6 +1315,8 @@ cd321x_unregister_port(struct tps6598x *tps)
>  {
>  	struct cd321x *cd321x = container_of(tps, struct cd321x, tps);
>  
> +	if (cd321x->mux)
> +		typec_mux_put(cd321x->mux);
>  	typec_unregister_altmode(cd321x->port_altmode_dp);
>  	cd321x->port_altmode_dp = NULL;
>  	typec_unregister_altmode(cd321x->port_altmode_tbt);
> @@ -1454,6 +1729,13 @@ tps25750_register_port(struct tps6598x *tps, struct fwnode_handle *fwnode)
>  	return 0;
>  }
>  
> +static void cd321x_remove(struct tps6598x *tps)
> +{
> +	struct cd321x *cd321x = container_of(tps, struct cd321x, tps);
> +
> +	cancel_delayed_work_sync(&cd321x->update_work);
> +}
> +
>  static int tps6598x_probe(struct i2c_client *client)
>  {
>  	const struct tipd_data *data;
> @@ -1555,7 +1837,7 @@ static int tps6598x_probe(struct i2c_client *client)
>  			goto err_unregister_port;
>  		if (!tps->data->read_data_status(tps))
>  			goto err_unregister_port;
> -		ret = tps6598x_connect(tps, status);
> +		ret = tps->data->connect(tps, status);
>  		if (ret)
>  			dev_err(&client->dev, "failed to register partner\n");
>  	}
> @@ -1612,6 +1894,9 @@ static void tps6598x_remove(struct i2c_client *client)
>  	else
>  		devm_free_irq(tps->dev, client->irq, tps);
>  
> +	if (tps->data->remove)
> +		tps->data->remove(tps);
> +
>  	tps6598x_disconnect(tps, 0);
>  	tps->data->unregister_port(tps);
>  	usb_role_switch_put(tps->role_sw);
> @@ -1682,6 +1967,7 @@ static const struct tipd_data cd321x_data = {
>  		     APPLE_CD_REG_INT_DATA_STATUS_UPDATE |
>  		     APPLE_CD_REG_INT_PLUG_EVENT,
>  	.tps_struct_size = sizeof(struct cd321x),
> +	.remove = cd321x_remove,
>  	.register_port = cd321x_register_port,
>  	.unregister_port = cd321x_unregister_port,
>  	.trace_data_status = trace_cd321x_data_status,
> @@ -1691,6 +1977,7 @@ static const struct tipd_data cd321x_data = {
>  	.read_data_status = cd321x_read_data_status,
>  	.reset = cd321x_reset,
>  	.switch_power_state = cd321x_switch_power_state,
> +	.connect = cd321x_connect,
>  };
>  
>  static const struct tipd_data tps6598x_data = {
> @@ -1708,6 +1995,7 @@ static const struct tipd_data tps6598x_data = {
>  	.init = tps6598x_init,
>  	.read_data_status = tps6598x_read_data_status,
>  	.reset = tps6598x_reset,
> +	.connect = tps6598x_connect,
>  };
>  
>  static const struct tipd_data tps25750_data = {
> @@ -1725,6 +2013,7 @@ static const struct tipd_data tps25750_data = {
>  	.init = tps25750_init,
>  	.read_data_status = tps6598x_read_data_status,
>  	.reset = tps25750_reset,
> +	.connect = tps6598x_connect,
>  };
>  
>  static const struct of_device_id tps6598x_of_match[] = {
> 
> -- 
> 2.34.1
> 

-- 
heikki

