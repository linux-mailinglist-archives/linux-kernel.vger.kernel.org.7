Return-Path: <linux-kernel+bounces-682947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B758AAD66DC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jun 2025 06:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66DCE7ABC15
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jun 2025 04:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F36F1C860E;
	Thu, 12 Jun 2025 04:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="j2LX2uXk"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F0710E5
	for <linux-kernel@vger.kernel.org>; Thu, 12 Jun 2025 04:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749703203; cv=none; b=ncJLj4gQHFH24ELX1j1vUxlxy9L/48xSU1GitV6PP32x/63V9jj+ijMBYpH/Seaj8FDIF9lXOnr78KbD0IPIjJYJRGviAoegsxYK03o6V1HeIVpNxPBUVu6Ss9SlfXBFokOsEU36XUTNNNkgEoDtCUBwxjW+1Q5IYRi/PJuC5Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749703203; c=relaxed/simple;
	bh=TzrB5ln5BEwd6+5oPJTvdv9bORW1mr/Afd6LEpVbqbo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jb0+ZgTXtSRVSnElNFa020X3OJnZmNHqzcpHEbJUpv3nlsLl67p18QEfIQ/ZXJ6OOdlkpFGfwmB9CwUcSuTwA0Z6AqCXS1LdKqi86ccyLK8H8pKjm/ltHGZBc4niVJJ4US+VkA+eG12IogiG9a6J/7d8ix/G4/tyr1PJvxIfskQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=j2LX2uXk; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55C4dWOW1576748;
	Wed, 11 Jun 2025 23:39:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1749703172;
	bh=hQmgZzGREthGmoNBCC+PlQ5o5+kf+VtcbzCJpE4Ljxw=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=j2LX2uXkWeHl+IfDUkTlljjlGwPCLubacRzJvVoBb//c8uF0j5R8ZzRdv++eY/3CT
	 CcrDWYBvAfSuy0IKCBXU0RwvU0P1dZWg6Xpql3Gawv575pG4n3jDGFtZPTJbNloNlX
	 Qd4f0agEZLzAZvZgL0vZu0WpSRBwY+tSqKBNBehk=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55C4dWEx3357119
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 11 Jun 2025 23:39:32 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 11
 Jun 2025 23:39:31 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 11 Jun 2025 23:39:31 -0500
Received: from [172.24.227.14] (jayesh-hp-z2-tower-g5-workstation.dhcp.ti.com [172.24.227.14])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55C4dPMo1577019;
	Wed, 11 Jun 2025 23:39:26 -0500
Message-ID: <547a35f4-abc0-4808-9994-ccc70eb3c201@ti.com>
Date: Thu, 12 Jun 2025 10:09:24 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] drm/bridge: ti-sn65dsi86: Add HPD for DisplayPort
 connector type
To: Doug Anderson <dianders@chromium.org>
CC: <andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>, <rfoss@kernel.org>,
        <Laurent.pinchart@ideasonboard.com>, <dri-devel@lists.freedesktop.org>,
        <tomi.valkeinen@ideasonboard.com>, <max.krummenacher@toradex.com>,
        <ernestvanhoecke@gmail.com>, <jonas@kwiboo.se>,
        <jernej.skrabec@gmail.com>, <maarten.lankhorst@linux.intel.com>,
        <mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>,
        <simona@ffwll.ch>, <kieran.bingham+renesas@ideasonboard.com>,
        <linux-kernel@vger.kernel.org>, <max.oss.09@gmail.com>,
        <devarsht@ti.com>, <geert@linux-m68k.org>
References: <20250611052947.5776-1-j-choudhary@ti.com>
 <CAD=FV=WvH73d78De3PrbiG7b6OaS_BysGtxQ=mJTj4z-h0LYWA@mail.gmail.com>
Content-Language: en-US
From: Jayesh Choudhary <j-choudhary@ti.com>
In-Reply-To: <CAD=FV=WvH73d78De3PrbiG7b6OaS_BysGtxQ=mJTj4z-h0LYWA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hello Doug,

On 12/06/25 03:08, Doug Anderson wrote:
> Hi,
> 
> On Tue, Jun 10, 2025 at 10:29 PM Jayesh Choudhary <j-choudhary@ti.com> wrote:
>>
>> @@ -1195,9 +1203,17 @@ static enum drm_connector_status ti_sn_bridge_detect(struct drm_bridge *bridge)
>>          struct ti_sn65dsi86 *pdata = bridge_to_ti_sn65dsi86(bridge);
>>          int val = 0;
>>
>> -       pm_runtime_get_sync(pdata->dev);
>> +       /*
>> +        * The chip won't report HPD right after being powered on as
>> +        * HPD_DEBOUNCED_STATE reflects correct state only after the
>> +        * debounce time (~100-400 ms).
>> +        * So having pm_runtime_get_sync() and immediately reading
>> +        * the register in detect() won't work, and adding delay()
>> +        * in detect will have performace impact in display.
>> +        * So remove runtime calls here.
> 
> That last sentence makes sense in a commit message, but not long term.
> Someone reading the code later won't understand what "remove" means.
> If you change "remove" to "omit" then it all makes sense, though. You
> could also say that a pm_runtime reference will be grabbed by
> ti_sn_bridge_hpd_enable().

Okay. Will edit this.

> 
> 
>> +        */
>> +
>>          regmap_read(pdata->regmap, SN_HPD_DISABLE_REG, &val);
>> -       pm_runtime_put_autosuspend(pdata->dev);
>>
>>          return val & HPD_DEBOUNCED_STATE ? connector_status_connected
>>                                           : connector_status_disconnected;
>> @@ -1220,6 +1236,20 @@ static void ti_sn65dsi86_debugfs_init(struct drm_bridge *bridge, struct dentry *
>>          debugfs_create_file("status", 0600, debugfs, pdata, &status_fops);
>>   }
>>
>> +static void ti_sn_bridge_hpd_enable(struct drm_bridge *bridge)
>> +{
>> +       struct ti_sn65dsi86 *pdata = bridge_to_ti_sn65dsi86(bridge);
>> +
>> +       pm_runtime_get_sync(pdata->dev);
>> +}
>> +
>> +static void ti_sn_bridge_hpd_disable(struct drm_bridge *bridge)
>> +{
>> +       struct ti_sn65dsi86 *pdata = bridge_to_ti_sn65dsi86(bridge);
>> +
>> +       pm_runtime_put_sync(pdata->dev);
>> +}
>> +
>>   static const struct drm_bridge_funcs ti_sn_bridge_funcs = {
>>          .attach = ti_sn_bridge_attach,
>>          .detach = ti_sn_bridge_detach,
>> @@ -1234,6 +1264,8 @@ static const struct drm_bridge_funcs ti_sn_bridge_funcs = {
>>          .atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
>>          .atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
>>          .debugfs_init = ti_sn65dsi86_debugfs_init,
>> +       .hpd_enable = ti_sn_bridge_hpd_enable,
>> +       .hpd_disable = ti_sn_bridge_hpd_disable,
>>   };
>>
>>   static void ti_sn_bridge_parse_lanes(struct ti_sn65dsi86 *pdata,
>> @@ -1322,7 +1354,8 @@ static int ti_sn_bridge_probe(struct auxiliary_device *adev,
>>                             ? DRM_MODE_CONNECTOR_DisplayPort : DRM_MODE_CONNECTOR_eDP;
>>
>>          if (pdata->bridge.type == DRM_MODE_CONNECTOR_DisplayPort)
>> -               pdata->bridge.ops = DRM_BRIDGE_OP_EDID | DRM_BRIDGE_OP_DETECT;
>> +               pdata->bridge.ops = DRM_BRIDGE_OP_EDID | DRM_BRIDGE_OP_DETECT |
>> +                                   DRM_BRIDGE_OP_HPD;
> 
> I think you also need this in the "DRM_MODE_CONNECTOR_DisplayPort" if test:
> 
> /*
>   * If comms were already enabled they would have been enabled
>   * with the wrong value of HPD_DISABLE. Update it now. Comms
>   * could be enabled if anyone is holding a pm_runtime reference
>   * (like if a GPIO is in use). Note that in most cases nobody
>   * is doing AUX channel xfers before the bridge is added so
>   * HPD doesn't _really_ matter then. The only exception is in
>   * the eDP case where the panel wants to read the EDID before
>   * the bridge is added. We always consistently have HPD disabled
>   * for eDP.
>   */
> mutex_lock(&pdata->comms_mutex);
> if (pdata->comms_enabled)
>    regmap_update_bits(pdata->regmap, SN_HPD_DISABLE_REG,
>      HPD_DISABLE, 0);
> mutex_unlock(&pdata->comms_mutex);
> 
> Does that sound right?


Here I don't think it is necessary to add this because enable_comms
will be called again after probe either in hpd_enable() (in case
refclk exist) or pre_enable() (in case it doesn't) with correct value.

If this seems okay then I will roll v5 with just the typo fixed in the
comments in detect().

Warm Regards,
Jayesh


