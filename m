Return-Path: <linux-kernel+bounces-812087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 959BCB532C1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 14:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4CB5189E432
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 12:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C85322747;
	Thu, 11 Sep 2025 12:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="0cSGvd0V"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D7832143B
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 12:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757595039; cv=none; b=S7K5/Ir6rvEZ4Crudk3h5jV8nkVD8WEhWwjrTz9Wp3Ebt57ukOZxHic/JKFtsE15j+Ao1uYLxuIZHo20kayuilRsX8fl8j62S6r9xxT7QZKL5RNjnAybO/N5v8SBZSYYvVWvQfOO8ZaQ4pb8MVwwLSOSGGKbCsY4E/jYFfXVuB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757595039; c=relaxed/simple;
	bh=lic2gVyra2Fci9kjsobQWbVL/mughWwS6st0tFnXd3M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b4XvaGQomLQXNdMGjsrt0zBWCxFsRDrXnt4heyKSXWtq7b8qf4hHS0/QM2Yk8YjPcTyEiAi78d4pizsT6CnArIytA75opf3+CNFXFCYnSaTPZfODYo30MCmG6UgIjag7SZbDgpdh9d22pqacYZanSCPblAIqBaPcn8+GhN6hOcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=0cSGvd0V; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 86DE81A0DEA;
	Thu, 11 Sep 2025 12:50:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5A76D60630;
	Thu, 11 Sep 2025 12:50:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B85C9102F286D;
	Thu, 11 Sep 2025 14:50:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757595027; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=SLEM14Bc3F7M85qjcLqahAIN620oKBeJlXHCNZSNKo0=;
	b=0cSGvd0V3ky4ridmXNRbRRun5K9w3uXdqT/pIvja9hkdUrZqFZ0xBo97NoHhjP8hPlNk5g
	5uDRFx0/WdkAFxDaIn7rLFDoWp4yBiHTPzVx4F2wiXFGu3RMWH/kZrFzHugLw9vNTYU0oY
	JTsdbiZ8mHtVZis7nGrWam29AgowuPiJfkn/OOWvmrDbD2BxCHf51m2n/NvPHR91vWor69
	9FP9Yjc5p49ye7jRTaVzJNwcHBFE6ObsU754jL6vfKLKsuqiLQ/bwNqtf6hJr/J8RjGnhz
	3+D/ov48BGWxZeUez/ywx9EFeOOZHcfiEeRd+3Ph1fXpsMhFE5xCmZf/sHU0Mw==
Message-ID: <012046ab-d866-4b3a-8c8a-e130bc2b9628@bootlin.com>
Date: Thu, 11 Sep 2025 14:49:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/bridge: ite-it66121: Add drm_connector support
To: Maxime Ripard <mripard@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Phong LE <ple@baylibre.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
 miquel.raynal@bootlin.com, kory.maincent@bootlin.com,
 romain.gantois@bootlin.com, praneeth@ti.com,
 Aradhya Bhatia <a-bhatia1@ti.com>
References: <20250909-it66121-fix-v1-1-bc79ca83df17@bootlin.com>
 <do5zciwcanpiciy52zj3nn6igmwlgmbcfdwbibv2ijxm2fif5s@ib6jhzi5h2jo>
 <6164422a-6265-4726-8da5-68bb8eafb9e6@bootlin.com>
 <20250911-innocent-daffodil-macaque-797f13@houat>
Content-Language: en-US
From: Miguel Gazquez <miguel.gazquez@bootlin.com>
In-Reply-To: <20250911-innocent-daffodil-macaque-797f13@houat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3



Le 11/09/2025 à 11:50, Maxime Ripard a écrit :
> On Thu, Sep 11, 2025 at 10:51:06AM +0200, Miguel Gazquez wrote:
>>
>>
>> Le 10/09/2025 à 04:28, Dmitry Baryshkov a écrit :
>>> On Tue, Sep 09, 2025 at 06:16:43PM +0200, Miguel Gazquez wrote:
>>>> From: Aradhya Bhatia <a-bhatia1@ti.com>
>>>>
>>>> Add support for DRM connector and make the driver support the older
>>>> format of attaching connectors onto the encoder->bridge->connector
>>>> chain.
>>>> This makes the driver compatible with display controller that only
>>>> supports the old format.
>>>>
>>>> [Miguel Gazquez: Rebased + made driver work with or without
>>>> DRM_BRIDGE_ATTACH_NO_CONNECTOR]
>>>
>>> What is the use case for not using DRM_BRIDGE_ATTACH_NO_CONNECTOR?
>>
>> Some display controller drivers (like the tilcdc) call drm_bridge_attach
>> without DRM_BRIDGE_ATTACH_NO_CONNECTOR, so the bridge must support both with
>> and without DRM_BRIDGE_ATTACH_NO_CONNECTOR to be compatible with all display
>> controllers.
> 
> I'd rather convert tilcdc to use DRM_BRIDGE_ATTACH_NO_CONNECTOR then.

The problem is that doing that break devicetrees using the tilcdc and a 
bridge who doesn't support DRM_BRIDGE_ATTACH_NO_CONNECTOR (there are 
multiple bridges that don't support DRM_BRIDGE_ATTACH_NO_CONNECTOR), and 
if my understanding is correct breaking devicetrees is not allowed.

> 
> Maxime

-- 
Miguel Gazquez, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


