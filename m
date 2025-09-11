Return-Path: <linux-kernel+bounces-811660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03564B52C35
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 10:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B96BC483FAA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 08:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C9A2E0904;
	Thu, 11 Sep 2025 08:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YCjnomzE"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0303D1A275
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 08:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757580693; cv=none; b=RsfcLd5necVNFMTAuzboruaeRHJfGHm2L3Lcnou8c25P67LvEJ+0zlKEBRKb3rL3lAPVgO2LEhu24Z9b+dip1NXQ2ldwqZJyXaJ2OSWkFQ0Kx+IgLF0Aci5Kpv6U8rF7/7RwCRNPE946MauGS+fzFhc0LUP776jg76O3OudxJd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757580693; c=relaxed/simple;
	bh=idpBnNgN2z4/QFS8Ri23fSHMIUrPWsT1AavJOrkuqLM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LTueE6BIyVDYVdJPu5drkihf/F09SKjotmtTmCAqCATJyn1tgTsMQhkLuE/qqncDRZTM6D02jCrFCFTq94bK/XxHGq6HxQjYPAZkSBYzZxrw8VZjlsrmPg3BYQuyrid3QsxIDWe5Id9zYNFVMl0UNw7ZQNaNTPSJVMFmJjJXsoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YCjnomzE; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 8C4F91A0DB4;
	Thu, 11 Sep 2025 08:51:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 54A16606BB;
	Thu, 11 Sep 2025 08:51:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B3F47102F23C4;
	Thu, 11 Sep 2025 10:51:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757580688; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=HkTdsZbLO97tK8E1nYuzjnMh7ih75HUJcnF1foWniqU=;
	b=YCjnomzEqyHWq2NwMhl7WJxduiIP2EXo9CVThuad5rrNX5p69ncUDQUsF+D2fpN4Pi2iyL
	ZSXK3Z9DaNN4kNEDuhiAjylWpxWkG1KgF4GL8WMftZsQ8jR7pybXCwe3prTZwFlExnla90
	6mItP+Zukyc4qgVnW3kZ9Y+fGZJFtEm1JxnELk+uiPhK4Lu3g7FLBYNGsCTgUP+8mJ4ps+
	acioccsXtJcYSb4FWkxyExAoj3dCMtGDM5q3MnfLMPgjo2hDhIixKbS1ok8D4xl6af9VZM
	hjNz+2YecHMUB7OOl4aOtF8XP8QSHYSfploiJjQ9LayF7LUIfV1kIquFETku4g==
Message-ID: <6164422a-6265-4726-8da5-68bb8eafb9e6@bootlin.com>
Date: Thu, 11 Sep 2025 10:51:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/bridge: ite-it66121: Add drm_connector support
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Phong LE <ple@baylibre.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com,
 kory.maincent@bootlin.com, romain.gantois@bootlin.com, praneeth@ti.com,
 Aradhya Bhatia <a-bhatia1@ti.com>
References: <20250909-it66121-fix-v1-1-bc79ca83df17@bootlin.com>
 <do5zciwcanpiciy52zj3nn6igmwlgmbcfdwbibv2ijxm2fif5s@ib6jhzi5h2jo>
Content-Language: en-US
From: Miguel Gazquez <miguel.gazquez@bootlin.com>
In-Reply-To: <do5zciwcanpiciy52zj3nn6igmwlgmbcfdwbibv2ijxm2fif5s@ib6jhzi5h2jo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3



Le 10/09/2025 à 04:28, Dmitry Baryshkov a écrit :
> On Tue, Sep 09, 2025 at 06:16:43PM +0200, Miguel Gazquez wrote:
>> From: Aradhya Bhatia <a-bhatia1@ti.com>
>>
>> Add support for DRM connector and make the driver support the older
>> format of attaching connectors onto the encoder->bridge->connector
>> chain.
>> This makes the driver compatible with display controller that only
>> supports the old format.
>>
>> [Miguel Gazquez: Rebased + made driver work with or without
>> DRM_BRIDGE_ATTACH_NO_CONNECTOR]
> 
> What is the use case for not using DRM_BRIDGE_ATTACH_NO_CONNECTOR?

Some display controller drivers (like the tilcdc) call drm_bridge_attach 
without DRM_BRIDGE_ATTACH_NO_CONNECTOR, so the bridge must support both 
with and without DRM_BRIDGE_ATTACH_NO_CONNECTOR to be compatible with 
all display controllers.

> 
>>
>> Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
>> Signed-off-by: Miguel Gazquez <miguel.gazquez@bootlin.com>
>> ---
>>   drivers/gpu/drm/bridge/ite-it66121.c | 121 ++++++++++++++++++++++++++++++++---
>>   1 file changed, 112 insertions(+), 9 deletions(-)
> 

-- 
Miguel Gazquez, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


