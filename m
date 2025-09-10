Return-Path: <linux-kernel+bounces-809884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87907B51326
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 11:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 834C81C833B3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 09:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59DD259CB6;
	Wed, 10 Sep 2025 09:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="esLQqtqC"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419361DFF7
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 09:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757497767; cv=none; b=uZf0G4JHoYc0Yz5cLWxYpAWwy9FDLovKxisHvMMxVhdEYX7lHIdNJM1/WILMBckm3eRfSHm3S7B/fA/mNYYcyOJ2ViQOpD6S/kW//g+v8ytDrqzRt1zcchfO0aQHDS6YUB3xjs0Ja/REFYxl6Dk2LhLZwKIy/dRXL5pxB7Eh75g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757497767; c=relaxed/simple;
	bh=HcM9XESJlPMJw6dGHiWoy4Yh5ln7MuOd4I6/9enYzOA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kNobWQKvpUIZ+yBEZinMkk0XOQfqSgFGkfgYoaT9D6XvEYLOfFMsDnSx4ynYPkKhn3zEA23pPHnXFH7MLobHNFag+tdvxSEedZuZ2VLOharG09IgPJx4y3A+T01V0z5oye8Q6Y2eDPfWTsgVzN4KMduwgXUfG5nr0tmUnLgnwKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=esLQqtqC; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58A9mhor489758;
	Wed, 10 Sep 2025 04:48:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757497723;
	bh=Da8gelHwzK3OZuwiMQj8BkRuCSEPsJz30IOpOdnq3oA=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=esLQqtqC1th+TITWxGr3/Z8umXYzcP+15kfzarvztzYcLHb5CJ1BwTbU6EbUo6uht
	 l5GaQrBl+JJXMetN7i41tLoHjR+wqQLMMEuIIH/OYTxJP/M570m1bRcq3szZrH3gjJ
	 3JSfD8z1/Te5Vracyu7Y4a1o6ahQyfs51HWALT5U=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58A9mglW3835799
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 10 Sep 2025 04:48:42 -0500
Received: from DLEE214.ent.ti.com (157.170.170.117) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 10
 Sep 2025 04:48:42 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 10 Sep 2025 04:48:42 -0500
Received: from [172.24.235.208] (hkshenoy.dhcp.ti.com [172.24.235.208])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58A9mYjV293058;
	Wed, 10 Sep 2025 04:48:35 -0500
Message-ID: <130b1508-82fd-4c90-a04f-e6ddab712ca2@ti.com>
Date: Wed, 10 Sep 2025 15:18:34 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/6] drm/bridge: cadence: cdns-mhdp8546*: Change
 drm_connector from structure to pointer
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
CC: <andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>, <rfoss@kernel.org>,
        <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
        <jernej.skrabec@gmail.com>, <maarten.lankhorst@linux.intel.com>,
        <mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>,
        <simona@ffwll.ch>, <lumag@kernel.org>, <dianders@chromium.org>,
        <andy.yan@rock-chips.com>, <linux@treblig.org>,
        <viro@zeniv.linux.org.uk>, <aradhya.bhatia@linux.dev>,
        <javierm@redhat.com>, <tomi.valkeinen@ideasonboard.com>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <devarsht@ti.com>, <u-kumar1@ti.com>, <s-jain1@ti.com>,
        <lyude@redhat.com>, <luca.ceresoli@bootlin.com>
References: <20250909090824.1655537-1-h-shenoy@ti.com>
 <20250909090824.1655537-3-h-shenoy@ti.com>
 <r4l4dayuhfdqbj3txtyvuffuffe2kxefbeq32pqu226ttwik46@wy23kgtqvfvx>
Content-Language: en-US
From: Harikrishna Shenoy <h-shenoy@ti.com>
In-Reply-To: <r4l4dayuhfdqbj3txtyvuffuffe2kxefbeq32pqu226ttwik46@wy23kgtqvfvx>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea


On 9/9/25 19:42, Dmitry Baryshkov wrote:
> On Tue, Sep 09, 2025 at 02:38:20PM +0530, Harikrishna Shenoy wrote:
>> From: Jayesh Choudhary <j-choudhary@ti.com>
>>
>> After adding DBANC framework, mhdp->connector is not initialised during
>> bridge_attach(). The connector is however required in few driver calls
>> like cdns_mhdp_hdcp_enable() and cdns_mhdp_modeset_retry_fn().
>> Use drm_connector pointer instead of structure, set it in bridge_enable()
>> and clear it in bridge_disable(), and make appropriate changes.
>>
>> Fixes: c932ced6b585 ("drm/tidss: Update encoder/bridge chain connect model")
> Same question. If HDCP was broken, then this should be fixing
> 6a3608eae6d3 ("drm: bridge: cdns-mhdp8546: Enable HDCP") instead.
This patch fixes null pointer de-reference,for which we require 
connector as pointer

and this patch aligns the driver to use pointer instead of connector 
structure.

HDCP state change which was handled in connector helper, have moved it 
to bridge helpers

in patch 6 of series.

Note:HDCP is not supported (Driver is used by only TI K3 Soc and HDCP is 
not supported).

>
>> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
>> ---
>>   drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c | 12 ++++++------
>>   drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.h |  2 +-
>>   drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-hdcp.c |  8 ++++----
>>   3 files changed, 11 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.h b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.h
>> index bad2fc0c7306..b297db53ba28 100644
>> --- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.h
>> +++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.h
>> @@ -375,7 +375,7 @@ struct cdns_mhdp_device {
>>   	 */
>>   	struct mutex link_mutex;
>>   
>> -	struct drm_connector connector;
>> +	struct drm_connector *connector;
>>   	struct drm_bridge bridge;
>>   
>>   	struct cdns_mhdp_link link;
>> diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-hdcp.c b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-hdcp.c
>> index 42248f179b69..59f18c3281ef 100644
>> --- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-hdcp.c
>> +++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-hdcp.c
>> @@ -394,7 +394,7 @@ static int _cdns_mhdp_hdcp_disable(struct cdns_mhdp_device *mhdp)
>>   	int ret;
>>   
>>   	dev_dbg(mhdp->dev, "[%s:%d] HDCP is being disabled...\n",
>> -		mhdp->connector.name, mhdp->connector.base.id);
>> +		mhdp->connector->name, mhdp->connector->base.id);
>>   
>>   	ret = cdns_mhdp_hdcp_set_config(mhdp, 0, false);
>>   
>> @@ -445,7 +445,7 @@ static int cdns_mhdp_hdcp_check_link(struct cdns_mhdp_device *mhdp)
>>   
>>   	dev_err(mhdp->dev,
>>   		"[%s:%d] HDCP link failed, retrying authentication\n",
>> -		mhdp->connector.name, mhdp->connector.base.id);
>> +		mhdp->connector->name, mhdp->connector->base.id);
>>   
>>   	ret = _cdns_mhdp_hdcp_disable(mhdp);
>>   	if (ret) {
>> @@ -487,13 +487,13 @@ static void cdns_mhdp_hdcp_prop_work(struct work_struct *work)
>>   	struct cdns_mhdp_device *mhdp = container_of(hdcp,
>>   						     struct cdns_mhdp_device,
>>   						     hdcp);
>> -	struct drm_device *dev = mhdp->connector.dev;
>> +	struct drm_device *dev = mhdp->connector->dev;
>>   	struct drm_connector_state *state;
>>   
>>   	drm_modeset_lock(&dev->mode_config.connection_mutex, NULL);
>>   	mutex_lock(&mhdp->hdcp.mutex);
>>   	if (mhdp->hdcp.value != DRM_MODE_CONTENT_PROTECTION_UNDESIRED) {
>> -		state = mhdp->connector.state;
>> +		state = mhdp->connector->state;
>>   		state->content_protection = mhdp->hdcp.value;
>>   	}
>>   	mutex_unlock(&mhdp->hdcp.mutex);
>> -- 
>> 2.34.1
>>

