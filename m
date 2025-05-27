Return-Path: <linux-kernel+bounces-663804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25CCDAC4DBD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 May 2025 13:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1584C1BA095A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 May 2025 11:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1B925D8FA;
	Tue, 27 May 2025 11:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="SWrBKLk2"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F431F790F
	for <linux-kernel@vger.kernel.org>; Tue, 27 May 2025 11:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748345849; cv=none; b=RdqPNYxlYFG4kgritcLuL4jip5BSmra8u6ObV/In+hEdcjipolsFxfaZP2Kku9qj3mCUZmFR5V80ypkm5J25SyW6QwPt3+GI2gev0YM+BNvjoS23oOASQ0yp0FNaLGDcFmtcplU+eljJ/pAHCa3j7t4yeO+/8Nb4Lonc81UEyac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748345849; c=relaxed/simple;
	bh=3xVSu3LAO8ejto8P4HUOR3VlVYE832vsZyyvQ9W40bw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hyM+HIwIT4lfB1wdS1BOWFlvyskcVdTHrprOD05f4N7IaJs4QdR0TNBZIHe6hjbO1OxcUMtHOPAndvxuWwZ/XdP74mZnxW+PC7w1aNNUMPaKufBPplHKxttNeZjyIitku39QlVdA2A8dlp7BX/TpvnLV0zhYWCtdSlO5bFSW+8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=SWrBKLk2; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [192.168.88.20] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 110432B3;
	Tue, 27 May 2025 13:36:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1748345819;
	bh=3xVSu3LAO8ejto8P4HUOR3VlVYE832vsZyyvQ9W40bw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SWrBKLk2Cvg0dEp2NbVCGdD9HP4Dwtn3kMimBL1ZPYfb8dKGyffKKm14NRKrR46u7
	 SDnwvhSBGycZ8qPMGJApcgHxdta7aHvqcBdezKGuKg2HrpCevIJlgsfHFvb3yiGUdP
	 7EBDdVgJxsafr7m1QFpfcaax+gH1jt9oRNXaX7n4=
Message-ID: <027ad6e9-5070-43f2-a082-fd498cc6d31d@ideasonboard.com>
Date: Tue, 27 May 2025 14:37:20 +0300
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
 <19dd2795-c693-4c1a-989c-8b3bc2b3cdfd@ideasonboard.com>
 <493afc6c-59a0-4f6b-9a9e-568dd2eff873@ti.com>
 <2a15263b-2d36-4c46-be0f-4145069d134f@ti.com>
Content-Language: en-US
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Autocrypt: addr=tomi.valkeinen@ideasonboard.com; keydata=
 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
In-Reply-To: <2a15263b-2d36-4c46-be0f-4145069d134f@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 27/05/2025 13:39, Jayesh Choudhary wrote:
> 
> 
> On 27/05/25 14:59, Jayesh Choudhary wrote:
>> Hello Tomi,
>>
>> On 27/05/25 13:28, Tomi Valkeinen wrote:
>>> Hi,
>>>
>>> On 21/05/2025 10:32, Jayesh Choudhary wrote:
>>>> After adding DBANC framework, mhdp->connector is not initialised during
>>>> bridge calls. But the asyncronous work scheduled depends on the
>>>> connector.
>>>> We cannot get to drm_atomic_state in these asyncronous calls running on
>>>> worker threads. So we need to store the data that we need in mhdp
>>>> bridge
>>>> structure.
>>>> Like other bridge drivers, use drm_connector pointer instead of
>>>> structure
>>>> and make appropriate changes to the conditionals and assignments
>>>> related
>>>> to mhdp->connector.
>>>> Also, in the atomic enable call, move the connector  and connector
>>>> state
>>>> calls above, so that we do have a connector before we can retry the
>>>> asyncronous work in case of any failure.
>>>>
>>>
>>> I don't quite understand this patch. You change the mhdp->connector to a
>>> pointer, which is set at bridge_enable and cleared at bridge_disable.
>>> Then you change the "mhdp->connector.dev" checks to "mhdp->connector".
>>>
>>> So, now in e.g. cdns_mhdp_fw_cb(), we check for mhdp->connector, which
>>> is set at bridge_enable(). Can we ever have the bridge enabled before
>>> the fb has been loaded? What is the check even supposed to do there?
>>>
>>> Another in cdns_mhdp_hpd_work(), it checks for mhdp->connector. So...
>>> HPD code behaves differently based on if the bridge has been enabled or
>>> not? What is it supposed to do?
>>>
>>> Isn't the whole "if (mhdp->connector.dev)" code for the legacy
>>> non-DRM_BRIDGE_ATTACH_NO_CONNECTOR case?
>>>
>>>   Tomi
>>
>> I misinterpreted your comment in v1[0] regarding finding the connector
>> from the current state in cdns_mhdp_modeset_retry_fn() and I missed
>> this. I was more focused on finding a connector for that function.
>>
>> For the current code, in all the conditionals involving mhdp->connector,
>> we are entering else statements as connector is not initialised.
>> So I will just drop if statements in cdns_mhdp_fw_cb() and
>> cdns_mhdp_hpd_work() (like you said, its legacy case) while still having
>> mhdp->connector as pointer as we need it for
>> cdns_mhdp_modeset_retry_fn() and in cdns-mhdp8546-hdcp driver.
>>
>> That should be okay?
>>
>> [0]: https://lore.kernel.org/all/e76f94b9-b138-46e7-bb18-
>> b33dd98c9abb@ideasonboard.com/
>>
>> Warm Regards,
>> Jayesh
>>
>>
> 
> Tomi,
> 
> One more thing here. Should this be squashed with the first patch as
> this is sort of removing !(DRM_BRIDGE_ATTACH_NO_CONNECTOR) case and
> associated changes?


All the legacy code should be removed in the previous patch, yes. But
it's not quite clear to me what's going on here. At least parts of this
patch seem to be... fixing some previous code? You move the
drm_atomic_get_new_connector_for_encoder() call to be earlier in the
bridge_enable. That doesn't sound like removing the legacy code. But
it's not quite clear to me why that's done (or why it wasn't needed
earlier. or was it?).

 Tomi

> 
>>>
>>>> Fixes: fb43aa0acdfd ("drm: bridge: Add support for Cadence MHDP8546
>>>> DPI/DP bridge")
>>>> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
>>>> ---
>>>>   .../drm/bridge/cadence/cdns-mhdp8546-core.c   | 28 ++++++++
>>>> +----------
>>>>   .../drm/bridge/cadence/cdns-mhdp8546-core.h   |  2 +-
>>>>   .../drm/bridge/cadence/cdns-mhdp8546-hdcp.c   |  8 +++---
>>>>   3 files changed, 19 insertions(+), 19 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c b/
>>>> drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
>>>> index 66bd916c2fe9..5388e62f230b 100644
>>>> --- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
>>>> +++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
>>>> @@ -740,7 +740,7 @@ static void cdns_mhdp_fw_cb(const struct
>>>> firmware *fw, void *context)
>>>>       bridge_attached = mhdp->bridge_attached;
>>>>       spin_unlock(&mhdp->start_lock);
>>>>       if (bridge_attached) {
>>>> -        if (mhdp->connector.dev)
>>>> +        if (mhdp->connector)
>>>>               drm_kms_helper_hotplug_event(mhdp->bridge.dev);
>>>>           else
>>>>               drm_bridge_hpd_notify(&mhdp->bridge,
>>>> cdns_mhdp_detect(mhdp));
>>>> @@ -1759,17 +1759,25 @@ static void cdns_mhdp_atomic_enable(struct
>>>> drm_bridge *bridge,
>>>>       struct cdns_mhdp_device *mhdp = bridge_to_mhdp(bridge);
>>>>       struct cdns_mhdp_bridge_state *mhdp_state;
>>>>       struct drm_crtc_state *crtc_state;
>>>> -    struct drm_connector *connector;
>>>>       struct drm_connector_state *conn_state;
>>>>       struct drm_bridge_state *new_state;
>>>>       const struct drm_display_mode *mode;
>>>>       u32 resp;
>>>> -    int ret;
>>>> +    int ret = 0;
>>>>       dev_dbg(mhdp->dev, "bridge enable\n");
>>>>       mutex_lock(&mhdp->link_mutex);
>>>> +    mhdp->connector = drm_atomic_get_new_connector_for_encoder(state,
>>>> +                                   bridge->encoder);
>>>> +    if (WARN_ON(!mhdp->connector))
>>>> +        goto out;
>>>> +
>>>> +    conn_state = drm_atomic_get_new_connector_state(state, mhdp-
>>>> >connector);
>>>> +    if (WARN_ON(!conn_state))
>>>> +        goto out;
>>>> +
>>>>       if (mhdp->plugged && !mhdp->link_up) {
>>>>           ret = cdns_mhdp_link_up(mhdp);
>>>>           if (ret < 0)
>>>> @@ -1789,15 +1797,6 @@ static void cdns_mhdp_atomic_enable(struct
>>>> drm_bridge *bridge,
>>>>       cdns_mhdp_reg_write(mhdp, CDNS_DPTX_CAR,
>>>>                   resp | CDNS_VIF_CLK_EN | CDNS_VIF_CLK_RSTN);
>>>> -    connector = drm_atomic_get_new_connector_for_encoder(state,
>>>> -                                 bridge->encoder);
>>>> -    if (WARN_ON(!connector))
>>>> -        goto out;
>>>> -
>>>> -    conn_state = drm_atomic_get_new_connector_state(state, connector);
>>>> -    if (WARN_ON(!conn_state))
>>>> -        goto out;
>>>> -
>>>>       if (mhdp->hdcp_supported &&
>>>>           mhdp->hw_state == MHDP_HW_READY &&
>>>>           conn_state->content_protection ==
>>>> @@ -1857,6 +1856,7 @@ static void cdns_mhdp_atomic_disable(struct
>>>> drm_bridge *bridge,
>>>>           cdns_mhdp_hdcp_disable(mhdp);
>>>>       mhdp->bridge_enabled = false;
>>>> +    mhdp->connector = NULL;
>>>>       cdns_mhdp_reg_read(mhdp, CDNS_DP_FRAMER_GLOBAL_CONFIG, &resp);
>>>>       resp &= ~CDNS_DP_FRAMER_EN;
>>>>       resp |= CDNS_DP_NO_VIDEO_MODE;
>>>> @@ -2157,7 +2157,7 @@ static void cdns_mhdp_modeset_retry_fn(struct
>>>> work_struct *work)
>>>>       mhdp = container_of(work, typeof(*mhdp), modeset_retry_work);
>>>> -    conn = &mhdp->connector;
>>>> +    conn = mhdp->connector;
>>>>       /* Grab the locks before changing connector property */
>>>>       mutex_lock(&conn->dev->mode_config.mutex);
>>>> @@ -2234,7 +2234,7 @@ static void cdns_mhdp_hpd_work(struct
>>>> work_struct *work)
>>>>       int ret;
>>>>       ret = cdns_mhdp_update_link_status(mhdp);
>>>> -    if (mhdp->connector.dev) {
>>>> +    if (mhdp->connector) {
>>>>           if (ret < 0)
>>>>               schedule_work(&mhdp->modeset_retry_work);
>>>>           else
>>>> diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.h b/
>>>> drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.h
>>>> index bad2fc0c7306..b297db53ba28 100644
>>>> --- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.h
>>>> +++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.h
>>>> @@ -375,7 +375,7 @@ struct cdns_mhdp_device {
>>>>        */
>>>>       struct mutex link_mutex;
>>>> -    struct drm_connector connector;
>>>> +    struct drm_connector *connector;
>>>>       struct drm_bridge bridge;
>>>>       struct cdns_mhdp_link link;
>>>> diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-hdcp.c b/
>>>> drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-hdcp.c
>>>> index 42248f179b69..59f18c3281ef 100644
>>>> --- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-hdcp.c
>>>> +++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-hdcp.c
>>>> @@ -394,7 +394,7 @@ static int _cdns_mhdp_hdcp_disable(struct
>>>> cdns_mhdp_device *mhdp)
>>>>       int ret;
>>>>       dev_dbg(mhdp->dev, "[%s:%d] HDCP is being disabled...\n",
>>>> -        mhdp->connector.name, mhdp->connector.base.id);
>>>> +        mhdp->connector->name, mhdp->connector->base.id);
>>>>       ret = cdns_mhdp_hdcp_set_config(mhdp, 0, false);
>>>> @@ -445,7 +445,7 @@ static int cdns_mhdp_hdcp_check_link(struct
>>>> cdns_mhdp_device *mhdp)
>>>>       dev_err(mhdp->dev,
>>>>           "[%s:%d] HDCP link failed, retrying authentication\n",
>>>> -        mhdp->connector.name, mhdp->connector.base.id);
>>>> +        mhdp->connector->name, mhdp->connector->base.id);
>>>>       ret = _cdns_mhdp_hdcp_disable(mhdp);
>>>>       if (ret) {
>>>> @@ -487,13 +487,13 @@ static void cdns_mhdp_hdcp_prop_work(struct
>>>> work_struct *work)
>>>>       struct cdns_mhdp_device *mhdp = container_of(hdcp,
>>>>                                struct cdns_mhdp_device,
>>>>                                hdcp);
>>>> -    struct drm_device *dev = mhdp->connector.dev;
>>>> +    struct drm_device *dev = mhdp->connector->dev;
>>>>       struct drm_connector_state *state;
>>>>       drm_modeset_lock(&dev->mode_config.connection_mutex, NULL);
>>>>       mutex_lock(&mhdp->hdcp.mutex);
>>>>       if (mhdp->hdcp.value != DRM_MODE_CONTENT_PROTECTION_UNDESIRED) {
>>>> -        state = mhdp->connector.state;
>>>> +        state = mhdp->connector->state;
>>>>           state->content_protection = mhdp->hdcp.value;
>>>>       }
>>>>       mutex_unlock(&mhdp->hdcp.mutex);
>>>


