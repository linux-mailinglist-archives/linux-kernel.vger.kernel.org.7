Return-Path: <linux-kernel+bounces-663542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9528AAC49C0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 May 2025 09:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84E707A323F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 May 2025 07:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9FEF248F48;
	Tue, 27 May 2025 07:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="LUTEDqi7"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8BE1A0BD6
	for <linux-kernel@vger.kernel.org>; Tue, 27 May 2025 07:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748332739; cv=none; b=I9by2u7V2cCdnZfhmsRvSyfQPlkH7sI47em5bzaITeKee7EbpQQJ3+gXCoG47N85H6b3GTxeDtVfYiot5eS4GJW1Fqchn0m0tgzUDJH+ppK6D9sUIPPSCGjIoVyTDlYmkHuk6riqWxPaDjn2s6Rty91D1h+cLu3mEOO8OQafKP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748332739; c=relaxed/simple;
	bh=rGTcM0GJJ8KWe4DGMipQC2LPFETTFNoNUGvTTh61xx4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WeS6fcCqjjtIBivVxCGbAYAWzEnzPDnDG62I++Tmd6oY4ahqJaGd3+E4rIWC/LSXiiwTCcYdoX/m3RM7Fjt9WDxlz7qCPhGfuCCzlxGVlGD3c2MYMgZn2NzZO36S4WuwYIaCa7Hni6xgiwF0QtgzjqkhMYRnP0DqFxqv27pUnR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=LUTEDqi7; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [192.168.88.20] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 201F1725;
	Tue, 27 May 2025 09:58:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1748332709;
	bh=rGTcM0GJJ8KWe4DGMipQC2LPFETTFNoNUGvTTh61xx4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LUTEDqi7l9rjlHVOrW7lxOC1vHSWsvuMyKK5U6pVYd7GGe/5fJNSfrmGTY2RBh55x
	 4JHiSdnFH22uNJTvv8Ao9nLRSj9TRar4vHYoAA3YCEBLuJQD43m36kFLQLyCSi9bqn
	 eNfRFLyIBkmLQ7j/W2YkujQBga8OO6V+/wLddInM=
Message-ID: <19dd2795-c693-4c1a-989c-8b3bc2b3cdfd@ideasonboard.com>
Date: Tue, 27 May 2025 10:58:51 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 2/3] drm/bridge: cadence: cdns-mhdp8546*: Change
 drm_connector from pointer to structure
To: Jayesh Choudhary <j-choudhary@ti.com>
Cc: jonas@kwiboo.se, jernej.skrabec@gmail.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, lumag@kernel.org, jani.nikula@intel.com,
 andy.yan@rock-chips.com, mordan@ispras.ru, linux@treblig.org,
 viro@zeniv.linux.org.uk, yamonkar@cadence.com, sjakhade@cadence.com,
 quentin.schulz@free-electrons.com, jsarha@ti.com,
 linux-kernel@vger.kernel.org, devarsht@ti.com, dianders@chromium.org,
 andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
 Laurent.pinchart@ideasonboard.com, dri-devel@lists.freedesktop.org,
 alexander.stein@ew.tq-group.com
References: <20250521073237.366463-1-j-choudhary@ti.com>
 <20250521073237.366463-3-j-choudhary@ti.com>
Content-Language: en-US
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Autocrypt: addr=tomi.valkeinen@ideasonboard.com; keydata=
 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
In-Reply-To: <20250521073237.366463-3-j-choudhary@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 21/05/2025 10:32, Jayesh Choudhary wrote:
> After adding DBANC framework, mhdp->connector is not initialised during
> bridge calls. But the asyncronous work scheduled depends on the connector.
> We cannot get to drm_atomic_state in these asyncronous calls running on
> worker threads. So we need to store the data that we need in mhdp bridge
> structure.
> Like other bridge drivers, use drm_connector pointer instead of structure
> and make appropriate changes to the conditionals and assignments related
> to mhdp->connector.
> Also, in the atomic enable call, move the connector  and connector state
> calls above, so that we do have a connector before we can retry the
> asyncronous work in case of any failure.
> 

I don't quite understand this patch. You change the mhdp->connector to a
pointer, which is set at bridge_enable and cleared at bridge_disable.
Then you change the "mhdp->connector.dev" checks to "mhdp->connector".

So, now in e.g. cdns_mhdp_fw_cb(), we check for mhdp->connector, which
is set at bridge_enable(). Can we ever have the bridge enabled before
the fb has been loaded? What is the check even supposed to do there?

Another in cdns_mhdp_hpd_work(), it checks for mhdp->connector. So...
HPD code behaves differently based on if the bridge has been enabled or
not? What is it supposed to do?

Isn't the whole "if (mhdp->connector.dev)" code for the legacy
non-DRM_BRIDGE_ATTACH_NO_CONNECTOR case?

 Tomi

> Fixes: fb43aa0acdfd ("drm: bridge: Add support for Cadence MHDP8546 DPI/DP bridge")
> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> ---
>  .../drm/bridge/cadence/cdns-mhdp8546-core.c   | 28 +++++++++----------
>  .../drm/bridge/cadence/cdns-mhdp8546-core.h   |  2 +-
>  .../drm/bridge/cadence/cdns-mhdp8546-hdcp.c   |  8 +++---
>  3 files changed, 19 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> index 66bd916c2fe9..5388e62f230b 100644
> --- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> +++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> @@ -740,7 +740,7 @@ static void cdns_mhdp_fw_cb(const struct firmware *fw, void *context)
>  	bridge_attached = mhdp->bridge_attached;
>  	spin_unlock(&mhdp->start_lock);
>  	if (bridge_attached) {
> -		if (mhdp->connector.dev)
> +		if (mhdp->connector)
>  			drm_kms_helper_hotplug_event(mhdp->bridge.dev);
>  		else
>  			drm_bridge_hpd_notify(&mhdp->bridge, cdns_mhdp_detect(mhdp));
> @@ -1759,17 +1759,25 @@ static void cdns_mhdp_atomic_enable(struct drm_bridge *bridge,
>  	struct cdns_mhdp_device *mhdp = bridge_to_mhdp(bridge);
>  	struct cdns_mhdp_bridge_state *mhdp_state;
>  	struct drm_crtc_state *crtc_state;
> -	struct drm_connector *connector;
>  	struct drm_connector_state *conn_state;
>  	struct drm_bridge_state *new_state;
>  	const struct drm_display_mode *mode;
>  	u32 resp;
> -	int ret;
> +	int ret = 0;
>  
>  	dev_dbg(mhdp->dev, "bridge enable\n");
>  
>  	mutex_lock(&mhdp->link_mutex);
>  
> +	mhdp->connector = drm_atomic_get_new_connector_for_encoder(state,
> +								   bridge->encoder);
> +	if (WARN_ON(!mhdp->connector))
> +		goto out;
> +
> +	conn_state = drm_atomic_get_new_connector_state(state, mhdp->connector);
> +	if (WARN_ON(!conn_state))
> +		goto out;
> +
>  	if (mhdp->plugged && !mhdp->link_up) {
>  		ret = cdns_mhdp_link_up(mhdp);
>  		if (ret < 0)
> @@ -1789,15 +1797,6 @@ static void cdns_mhdp_atomic_enable(struct drm_bridge *bridge,
>  	cdns_mhdp_reg_write(mhdp, CDNS_DPTX_CAR,
>  			    resp | CDNS_VIF_CLK_EN | CDNS_VIF_CLK_RSTN);
>  
> -	connector = drm_atomic_get_new_connector_for_encoder(state,
> -							     bridge->encoder);
> -	if (WARN_ON(!connector))
> -		goto out;
> -
> -	conn_state = drm_atomic_get_new_connector_state(state, connector);
> -	if (WARN_ON(!conn_state))
> -		goto out;
> -
>  	if (mhdp->hdcp_supported &&
>  	    mhdp->hw_state == MHDP_HW_READY &&
>  	    conn_state->content_protection ==
> @@ -1857,6 +1856,7 @@ static void cdns_mhdp_atomic_disable(struct drm_bridge *bridge,
>  		cdns_mhdp_hdcp_disable(mhdp);
>  
>  	mhdp->bridge_enabled = false;
> +	mhdp->connector = NULL;
>  	cdns_mhdp_reg_read(mhdp, CDNS_DP_FRAMER_GLOBAL_CONFIG, &resp);
>  	resp &= ~CDNS_DP_FRAMER_EN;
>  	resp |= CDNS_DP_NO_VIDEO_MODE;
> @@ -2157,7 +2157,7 @@ static void cdns_mhdp_modeset_retry_fn(struct work_struct *work)
>  
>  	mhdp = container_of(work, typeof(*mhdp), modeset_retry_work);
>  
> -	conn = &mhdp->connector;
> +	conn = mhdp->connector;
>  
>  	/* Grab the locks before changing connector property */
>  	mutex_lock(&conn->dev->mode_config.mutex);
> @@ -2234,7 +2234,7 @@ static void cdns_mhdp_hpd_work(struct work_struct *work)
>  	int ret;
>  
>  	ret = cdns_mhdp_update_link_status(mhdp);
> -	if (mhdp->connector.dev) {
> +	if (mhdp->connector) {
>  		if (ret < 0)
>  			schedule_work(&mhdp->modeset_retry_work);
>  		else
> diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.h b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.h
> index bad2fc0c7306..b297db53ba28 100644
> --- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.h
> +++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.h
> @@ -375,7 +375,7 @@ struct cdns_mhdp_device {
>  	 */
>  	struct mutex link_mutex;
>  
> -	struct drm_connector connector;
> +	struct drm_connector *connector;
>  	struct drm_bridge bridge;
>  
>  	struct cdns_mhdp_link link;
> diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-hdcp.c b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-hdcp.c
> index 42248f179b69..59f18c3281ef 100644
> --- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-hdcp.c
> +++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-hdcp.c
> @@ -394,7 +394,7 @@ static int _cdns_mhdp_hdcp_disable(struct cdns_mhdp_device *mhdp)
>  	int ret;
>  
>  	dev_dbg(mhdp->dev, "[%s:%d] HDCP is being disabled...\n",
> -		mhdp->connector.name, mhdp->connector.base.id);
> +		mhdp->connector->name, mhdp->connector->base.id);
>  
>  	ret = cdns_mhdp_hdcp_set_config(mhdp, 0, false);
>  
> @@ -445,7 +445,7 @@ static int cdns_mhdp_hdcp_check_link(struct cdns_mhdp_device *mhdp)
>  
>  	dev_err(mhdp->dev,
>  		"[%s:%d] HDCP link failed, retrying authentication\n",
> -		mhdp->connector.name, mhdp->connector.base.id);
> +		mhdp->connector->name, mhdp->connector->base.id);
>  
>  	ret = _cdns_mhdp_hdcp_disable(mhdp);
>  	if (ret) {
> @@ -487,13 +487,13 @@ static void cdns_mhdp_hdcp_prop_work(struct work_struct *work)
>  	struct cdns_mhdp_device *mhdp = container_of(hdcp,
>  						     struct cdns_mhdp_device,
>  						     hdcp);
> -	struct drm_device *dev = mhdp->connector.dev;
> +	struct drm_device *dev = mhdp->connector->dev;
>  	struct drm_connector_state *state;
>  
>  	drm_modeset_lock(&dev->mode_config.connection_mutex, NULL);
>  	mutex_lock(&mhdp->hdcp.mutex);
>  	if (mhdp->hdcp.value != DRM_MODE_CONTENT_PROTECTION_UNDESIRED) {
> -		state = mhdp->connector.state;
> +		state = mhdp->connector->state;
>  		state->content_protection = mhdp->hdcp.value;
>  	}
>  	mutex_unlock(&mhdp->hdcp.mutex);


