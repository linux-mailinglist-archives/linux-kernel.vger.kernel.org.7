Return-Path: <linux-kernel+bounces-811734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1E1B52D2A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 11:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA41516153A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 09:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D772EA462;
	Thu, 11 Sep 2025 09:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="ODKH0lVE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LDduIdzN"
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759292E9EDF;
	Thu, 11 Sep 2025 09:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757582774; cv=none; b=A8+/OA/EqOB1B7PvMoYY1/Ve11O9LQ1OnXc11v1oFNZGc5ryJ9ksnWSICjwPckkOwiVIKIJLaMfF2pRjcxahnR+6zXL8N6860IuLKB9NWuvjPPKTzPYGu+TV7MwH75sBBkIkoZXH4zcOmKN9/T2CjuRpraTruAjeXL658tyoDPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757582774; c=relaxed/simple;
	bh=K+b9lYsKgwPBEZLrO89rsK6poRl0+QIt1SDns//ju6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ER4VP8zUiIJJyz3PZwhlyZ65o0SE3YzZaa9YafT/niiqheBDPLQWe9Bwp1RoXvrkiHu+Qtaa0+N1ZbzO8RkY+mnFqvlWAHEsHECLC9n4dAv2+A9atUTkJw/6tRqi+Wwdj8wTqRde44dd0OQlm1s+BijuPkhH6w19/YSU29Z3r28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=ODKH0lVE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LDduIdzN; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id F21047A001E;
	Thu, 11 Sep 2025 05:26:10 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 11 Sep 2025 05:26:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1757582770; x=1757669170; bh=DJYzLFKfHM
	lCWVvTixCw6+fqr/WXFMRu6AQWZTQqxwE=; b=ODKH0lVErnPnR7NxCH0avYOpFX
	XjZqwPhUkBocQrc1HxqNvcoNPAsTg8DtQh4GaacvXRkk/SRAa73YGencoqxe+AzK
	ftrytTCdEuTcyGZLf5T1lS0u4gSR8dRFWZ3PZL0Y1D0mpZwG1/7by1IR3L19IIAI
	hpQTQzT630SA1617oPE9q2uvgqsArOBFAnrll1PHqON7Pp0RV/a5Wp1A/4wuIboj
	M8zsubKpWK8TSS4Buc7cVQ3W/SeS+fJpk9us4Ep/3Kfl5yd8jTsBbFUndvPRFBZ5
	17DT+KrsugGlh4P5Xs8BBzXlukEw5KzzC3/NluR8CytFaWUGNZDofvaTXH9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757582770; x=1757669170; bh=DJYzLFKfHMlCWVvTixCw6+fqr/WXFMRu6AQ
	WZTQqxwE=; b=LDduIdzN2x0ATkTOWVhzFHHnnu1DGjLVeUSBjrHTr2X4cepa6ga
	m6CiLWjnUPGzd1ds0oCyahfjF3R4CK0fJKN7nIHT+K8VC3O93xz46rbNx2wg2+O6
	h7JPmetptLzAUo6kdX1hdsgcBtwClh8KwQXMSYr/9DUOTgikfwR1YBfCrlO/VXMa
	30JFCijJJLFS8gPoy0bR7KQ4q5OjhcZZtekLO9ps++1Ochu4rPyBTeNAz3oVkRhY
	M4BVomw/jNMPNIEpCauaJa2o/paNDpbUQ6G6sKwpBmfiQs5ui9zcX1UWkQH4RmD1
	ZMUQf1CYA3VANYvdBxmlw4YFlv0FgoSHYmw==
X-ME-Sender: <xms:sJXCaPBIpXSGg7R6w11uO2HG6eahfRi3W9JhbfkC6n7LgFF0w9HOSA>
    <xme:sJXCaAi_A_mnQkwJvcjEV_wv2ZXq4f20BMpx7-zE2QMGvyuUUtRYyeo3EvayPaY2B
    8caGj3YykxUgiUwP8k>
X-ME-Received: <xmr:sJXCaBPZYT6gtfGUfXeao4ajOuCaZoaymte7W4SZfaiEhO4l37m1KtrD9NWUJ7jBIiIDOuAL5_u1sU2tkONXEi_z_Sr2vwFNGTw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvheektdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttdejnecuhfhrohhmpeflrghnnhgvucfi
    rhhunhgruhcuoehjsehjrghnnhgruhdrnhgvtheqnecuggftrfgrthhtvghrnhepgfdvff
    evleegudejfeefheehkeehleehfefgjefffeetudegtefhuedufeehfeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhesjhgrnhhnrghurd
    hnvghtpdhnsggprhgtphhtthhopedvfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepshhvvghnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehgrhgvghhkhheslhhinh
    hugihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehrohgshheskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvghlrdhorhhgpdhrtghpth
    htoheptghonhhorhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegsrghlsghi
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhihshhsrgesrhhoshgvnhiifigvih
    hgrdhiohdprhgtphhtthhopehnvggrlhesghhomhhprgdruggvvhdprhgtphhtthhopehv
    khhouhhlsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:sJXCaPaQfQ8LIBwoQzLV0ENwj57RQqX46GN6LRU9gxqJbnyZakHsAg>
    <xmx:sJXCaO_ibK-UTeLxPNdkTc6n1iJpGfS7cngyXu2Ybo1KODSq-pficA>
    <xmx:sJXCaK2INVTJ02ymTBE3OTB84K8_J-s6pG7-6VyYLz2LW830qeoEcw>
    <xmx:sJXCaP3rXCENuJ2Ygf5nlFuDSFluL0nXCkl0tPzsTo6vVLWB6KYQbw>
    <xmx:spXCaPjqXEXtRIcQAHJS4CSZnUrvzR5kUJZBHpsv538pyFYoaxMTSrkM>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Sep 2025 05:26:08 -0400 (EDT)
Date: Thu, 11 Sep 2025 11:26:06 +0200
From: Janne Grunau <j@jannau.net>
To: Sven Peter <sven@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Felipe Balbi <balbi@kernel.org>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Neal Gompa <neal@gompa.dev>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, Frank Li <Frank.Li@nxp.com>,
	Ran Wang <ran.wang_1@nxp.com>, Peter Chen <peter.chen@nxp.com>,
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org,
	Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH v2 15/22] usb: typec: tipd: Handle mode transitions for
 CD321x
Message-ID: <20250911092606.GE89417@robin.jannau.net>
References: <20250906-atcphy-6-17-v2-0-52c348623ef6@kernel.org>
 <20250906-atcphy-6-17-v2-15-52c348623ef6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

This paragraph needs to be update considering the dwc3 apple glue
driver.

> To be able to control all this we trigger the entire process in the
> correct order directly from the TIPD driver and de-bounce any mode
> changes to avoid tearing down and re-setting DWC3 back up multiple times
> any time a new connection is made.
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> Co-developed-by: Sven Peter <sven@kernel.org>
> Signed-off-by: Sven Peter <sven@kernel.org>
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

&dp_data points to the stack. As it's no longer used after the
typec_mux_set call set cd321x->state.data to NULL to clear the dangling
pointer.

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

same issue as with dp_data

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

and again

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

Should the work be canceled before updating tps->status and calling
cd321x_queue_status()? If so the status updates and rescheduling the
work can be handled by calling cd321x_connect().

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

this comment seems to be outdated and at the wrong place

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

typec_unregister_altmode() is ERR / NULL safe so the if is not needed

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

typec_mux_put is ERR / NULL safe so the if is not needed
for consistency with port_altmode_* the dangling pointer should be
cleared to NULL

Janne

