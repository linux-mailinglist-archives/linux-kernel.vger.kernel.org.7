Return-Path: <linux-kernel+bounces-795981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD56B3FA4C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 11:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42B442C0424
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 09:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A162E7F2D;
	Tue,  2 Sep 2025 09:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="m449y+po"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCEF3246778
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 09:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756805287; cv=none; b=ZrBtWN4XMBKITrLrYsv+5lROLn54bVPbzdubeuLekIvKjn1raC2vVm1x7VcG1d1pcCDgLrNyAPQNSkUF7sjt6futCzszknMRjk7fkxdlgO/8I6IrJp2NNylAPCzYSAeYz5KQ3rqGrRzcFwm0PfCAeiC+zoSR2mgCGVJdpcyBkfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756805287; c=relaxed/simple;
	bh=0+ph69MRZ9Nqr9ZBRwTjxiqfrFcjuSDwmTo3tNbn0WM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=oAj9/mKEF52ret7bsifd8slNLsg6ZMYbILHZ/GpIqmMjRL6Zc15CTlwpwAjHBTQ/d0ZEI7816iK/7M1J0seBopmyUitPjXlr3mFuVd/WwCjhjMikXpGId67qUKyYMeByWmnTfTEJmu56wKGd9Fk+96x/JIlhWS8qvM4eaSXA8zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=m449y+po; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5829RbNs2954196;
	Tue, 2 Sep 2025 04:27:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756805257;
	bh=vE9iAHYq75eYvQEHVqllo047tep+ROLMiBTF8/YwkvE=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=m449y+poAqcKE9AbgacHKx8a4ooNXiuTqSKcAce+qjTZTPPJLr86yNO08LUkddkNZ
	 bTBIdiBBrzEq7i8IocdRWp927WJ+qXDCSK+J65OGtZyhtJbcgVnO3yZMGNLZ8E9yjz
	 +1EyM2xrmAUL3Dp6e534kaxJeYGVTOFsP//5S3qE=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5829RbJj3384826
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 2 Sep 2025 04:27:37 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 2
 Sep 2025 04:27:36 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 2 Sep 2025 04:27:36 -0500
Received: from [172.24.235.208] (hkshenoy.dhcp.ti.com [172.24.235.208])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5829RTbJ3567947;
	Tue, 2 Sep 2025 04:27:30 -0500
Message-ID: <7c0957a9-a970-4332-9df9-26ba432a0aec@ti.com>
Date: Tue, 2 Sep 2025 14:57:29 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/6] drm/bridge: cadence: cdns-mhdp8546-core: Set the
 mhdp connector earlier in atomic_enable()
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
CC: <jonas@kwiboo.se>, <jernej.skrabec@gmail.com>,
        <maarten.lankhorst@linux.intel.com>, <tzimmermann@suse.de>,
        <airlied@gmail.com>, <simona@ffwll.ch>, <lyude@redhat.com>,
        <luca.ceresoli@bootlin.com>, <viro@zeniv.linux.org.uk>,
        <andy.yan@rock-chips.com>, <linux@treblig.org>, <javierm@redhat.com>,
        <linux-kernel@vger.kernel.org>, <devarsht@ti.com>,
        <j-choudhary@ti.com>, <u-kumar1@ti.com>, <s-jain1@ti.com>,
        <andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>,
        <rfoss@kernel.org>, <Laurent.pinchart@ideasonboard.com>,
        <mripard@kernel.org>, <lumag@kernel.org>, <dianders@chromium.org>,
        <dri-devel@lists.freedesktop.org>
References: <20250811075904.1613519-1-h-shenoy@ti.com>
 <20250811075904.1613519-4-h-shenoy@ti.com>
 <6fa1a8d5-149e-437d-aef0-587c49957197@ideasonboard.com>
Content-Language: en-US
From: Harikrishna Shenoy <h-shenoy@ti.com>
In-Reply-To: <6fa1a8d5-149e-437d-aef0-587c49957197@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea


On 9/1/25 15:35, Tomi Valkeinen wrote:
> Hi,
>
> On 11/08/2025 10:59, Harikrishna Shenoy wrote:
>> From: Jayesh Choudhary <j-choudhary@ti.com>
>>
>> In case if we get errors in cdns_mhdp_link_up() or cdns_mhdp_reg_read()
>> in atomic_enable, we will go to cdns_mhdp_modeset_retry_fn() and will hit
>> NULL pointer while trying to access the mutex. We need the connector to
>> be set before that. Unlike in legacy !(DBANC) cases, we do not have
>> connector initialised in bridge_attach(). So set the mhdp->connector
>> in atomic_enable() earlier to avoid possible NULL pointer.
>>
>> Fixes: c932ced6b585 ("drm/tidss: Update encoder/bridge chain connect model")
>> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
>> ---
>>   .../drm/bridge/cadence/cdns-mhdp8546-core.c   | 20 +++++++++----------
>>   1 file changed, 10 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
>> index c2ce3d6e5a88..b2f5a48cac2d 100644
>> --- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
>> +++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
>> @@ -1759,12 +1759,21 @@ static void cdns_mhdp_atomic_enable(struct drm_bridge *bridge,
>>   	struct drm_bridge_state *new_state;
>>   	const struct drm_display_mode *mode;
>>   	u32 resp;
>> -	int ret;
>> +	int ret = 0;
>>   
>>   	dev_dbg(mhdp->dev, "bridge enable\n");
>>   
>>   	mutex_lock(&mhdp->link_mutex);
>>   
>> +	mhdp->connector = drm_atomic_get_new_connector_for_encoder(state,
>> +								   bridge->encoder);
>> +	if (WARN_ON(!mhdp->connector))
>> +		goto out;
>> +
>> +	conn_state = drm_atomic_get_new_connector_state(state, mhdp->connector);
>> +	if (WARN_ON(!conn_state))
>> +		goto out;
> You are just moving code here, but... Shouldn't these be errors? If I
> read this right, ret is 0 here, and thus if we hit either of those
> issues above, we'll return 0.
>
>   Tomi
>
This is a void function, no need to return
>> +
>>   	if (mhdp->plugged && !mhdp->link_up) {
>>   		ret = cdns_mhdp_link_up(mhdp);
>>   		if (ret < 0)
>> @@ -1784,15 +1793,6 @@ static void cdns_mhdp_atomic_enable(struct drm_bridge *bridge,
>>   	cdns_mhdp_reg_write(mhdp, CDNS_DPTX_CAR,
>>   			    resp | CDNS_VIF_CLK_EN | CDNS_VIF_CLK_RSTN);
>>   
>> -	mhdp->connector = drm_atomic_get_new_connector_for_encoder(state,
>> -								   bridge->encoder);
>> -	if (WARN_ON(!mhdp->connector))
>> -		goto out;
>> -
>> -	conn_state = drm_atomic_get_new_connector_state(state, mhdp->connector);
>> -	if (WARN_ON(!conn_state))
>> -		goto out;
>> -
>>   	if (mhdp->hdcp_supported &&
>>   	    mhdp->hw_state == MHDP_HW_READY &&
>>   	    conn_state->content_protection ==

