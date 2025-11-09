Return-Path: <linux-kernel+bounces-892112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04875C445B0
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 20:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1EE13A91BB
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 19:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F12523B61E;
	Sun,  9 Nov 2025 19:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="pqjUqaiY"
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E2623535E;
	Sun,  9 Nov 2025 19:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762715474; cv=none; b=QykxfTAlvjntRC0wUcTrADgejOL6SeabTWxmW6rRwQNzvH+s16a3gMDedblKiY0BzUCqjNBynS2MBaodwhr8HJrhL85avOtIK7MbHy+liQ0swHMP/ITT3PUgVRm4bqw7X4jlN/kVP/QKQjiknr9N62QBGTUGTqZ+PVXwQ3J0onA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762715474; c=relaxed/simple;
	bh=WQbP85mNUpbVUclIBabFyBk3p/akXLGRmYlcffdHo2w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nC3V0RaDq9AKpp3Eu+mlELvx6uT37GYrt18MHH1nkI/YiJ08d90VEA8XuNz7ZggEVnPJgDVD7NdYvxd7pz/A0bZsBA6FGEvzoRJy4rtkt/GfzV2mBiJY7OAzg8uI9SpdEP8BPuIcS4F9ZXoPXvHUked0AodavRf3x7fkaR8Qe1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=pqjUqaiY; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4d4MpN00fPz9spj;
	Sun,  9 Nov 2025 20:11:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1762715468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qz9lQGFdKGtpGf5hNxRCycqEsoFiqWsV2nAo7e2G5M8=;
	b=pqjUqaiYzH2r+VQqOdcmBRU+enBbdlqmrTYJSzdshiwz0O/zE9LE4Z2VNctOktKqe2Dh7V
	Oudu+mYseqqa25zOZnjTspizxf+CCYzfo/sMyP2uOkJEPxOQ/4KUK9kyOQnoLZI4cnIlWR
	T2ajUQD2GcZjMF/K+y/raXnwI8BCGVSpXZSr9+z0J6RrL4O9UqyvWYAYCCWkWbpMqX/rHE
	fkw4/s0L6KW9IUg5pZfNUYC82zOgD+nBPbykzD4XcUjpZ/fIciOP8Nl7qh3w5UXtFAR/hz
	bTqmgcRMfhtED/dnvrGveSJ6Sld7u+V139YrngA5cX5J9SdHZrKSJ8MJrXzMEQ==
Message-ID: <de695268-1241-4658-871c-30dbf068ad92@mailbox.org>
Date: Sun, 9 Nov 2025 20:11:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 07/14] drm/imx: dc: Add DPR channel support
To: Liu Ying <victor.liu@nxp.com>, Philipp Zabel <p.zabel@pengutronix.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Dmitry Baryshkov <lumag@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
References: <20251016-imx8-dc-prefetch-v4-0-dfda347cb3c5@nxp.com>
 <20251016-imx8-dc-prefetch-v4-7-dfda347cb3c5@nxp.com>
 <174bdb5a-b5a8-4856-a0ac-8caaaefde136@mailbox.org>
 <24f99c46-ca5d-43cc-a2eb-a6e5029e9f86@nxp.com>
 <500852c9-2cd5-4897-a139-4e93988f5469@mailbox.org>
 <df8751ba-7215-4635-98b0-ca659ec786cd@nxp.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <df8751ba-7215-4635-98b0-ca659ec786cd@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: sinmtj6ays4tudk4uae5k9qryfi8goyt
X-MBO-RS-ID: cff78c7cf3058c1fefc

On 11/4/25 8:18 AM, Liu Ying wrote:

Hello Liu,

>>>>> +++ b/drivers/gpu/drm/imx/dc/Kconfig
>>>>> @@ -1,6 +1,7 @@
>>>>>     config DRM_IMX8_DC
>>>>>         tristate "Freescale i.MX8 Display Controller Graphics"
>>>>>         depends on DRM && COMMON_CLK && OF && (ARCH_MXC || COMPILE_TEST)
>>>>> +    depends on IMX_SCU
>>>> Can the SCU dependency be made optional,
>>>
>>> I don't think this can be done.  If you grep 'depends on IMX_SCU' in
>>> kernel, you may find a handful of existing dependancies.
>>
>> Sure, I do not dispute this part.
>>
>> But the SCU dependency can be contained in a component of this driver,
>> which is not used by MX95, and used only by MX8Q . Then there will be
>> no problem.
> 
> Which component?  You mean PRG and DPRC?
> 
> If we add something like CONFIG_DRM_IMX8_DC_PRG and make CONFIG_DRM_IMX8_DC_PRG
> depend on SCU, then should we make CONFIG_DRM_IMX8_DC depend on
> CONFIG_DRM_IMX8_DC_PRG?  That's yet another dependency.

I would say, if possible, put the SCU-dependent parts behind 
CONFIG_DRM_IMX8_DC_PRG symbol, and make that symbol configurable via 
Kconfig . Users of iMX95-only can turn it off, generic kernel config 
should keep it on.

>>>> or per-module,
>>>
>>> Well, DRM_IMX8_DC(for the imx8_dc_drm module) depends on IMX_SCU just as
>>> this patch does.
>>
>> I assume it shouldn't have to, because the SCU dependency is only relevant
>> for the prefetch engine ?
> 
> The SCU dependency is only relevant for the prefetch engine, agreed.
> But, how to avoid the dependency?

How about containing the SCU parts in a single file and put it behind a 
Kconfig symbol ? The common code can call the SCU parts and they would 
either use SCU (on MX8QXP) or do nothing (on MX95) . It should even be 
possible to discern this at runtime.

>>>> or somehow abstracted out (via regmap?),
>>>
>>> Like I replied to your i.MX95 DC patch series's cover letter, SCU accesses
>>> registers via Cortex-M core instead of Cortex-A core IIUC.  I really don't
>>> know how to abstract IMX_SCU out, especially via regmap.
>>
>> The simplest way would be to use regmap_config .reg_read and .reg_write ,
>> if there is no better way.
> 
> Can you shed more light on this?  Any examples?

I'll just reply to this part, because that is probably the most relevant 
to this whole conversation.

git grep '\.reg_write' drivers -> drivers/hwmon/aspeed-pwm-tacho.c as a 
simple example.

Then such a reg_write implementation can do:

if (SCU)
   use SCU accessor
else
   use writel() or so

>>>> so iMX95 support can be added into the driver easily too ?
>>>
>>> Like I replied to your i.MX95 DC patch series, I think i.MX95 DC support
>>> can be in drivers/gpu/drm/imx/dc, but it should be in a separate module
>>> (something like imx95_dc_drm) plus an additional common module(like
>>> imx_dc_drm_common).
>> This design part is something I do not fully understand. Sure, it can be
>> two modules, but in the end, the result would have to be capable of being
>> compiled into single kernel binary if both modules would be =y in Kconfig
>> anyway.
> 
> This is something like imx8qm_ldb, imx8qxp_ldb and imx_ldb_helper modules -
> DRM_IMX8QM_LDB and DRM_IMX8QXP_LDB select DRM_IMX_LDB_HELPER.
> 
> Note you may make CONFIG_DRM_IMX8QM_LDB=y and CONFIG_DRM_IMX8QXP_LDB=m with
> CONFIG_DRM_IMX_LDB_HELPER=y.
Do we have to make it this complicated right from the start ? Maybe we 
can start simple, with one module, and then split it up if it turns out 
to be unsuitable ?

