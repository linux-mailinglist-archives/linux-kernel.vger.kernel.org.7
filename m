Return-Path: <linux-kernel+bounces-856720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E637BE4E57
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 19:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD6B11A61D67
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 17:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9908218ADD;
	Thu, 16 Oct 2025 17:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="uSAD+5cf"
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916961FC110;
	Thu, 16 Oct 2025 17:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760636425; cv=none; b=jkSKRZ2ZwcbAZF+ADx4/BOvNuk8JMxc8yEaDw6EDZy7BobI3RUszxySOyPHOlJewhBkX2TgkdaFKfVxsQqKn6ekhJb/uBStn6D9EKQv+qZPF0EfAQ8kTdb4oX2Oc6+pTP6bV2eiYNhTR/1c3cQb0LeRuyggRIP4NYTDMxUMPDEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760636425; c=relaxed/simple;
	bh=Wq3pp60rA3hdopTYWj2BZO4WQdhVCiSXHOABuF5YnCM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VOvj7wWHRx/eRfQOSXk2NHlbIYInohmc0h8a6Mecem4GrgVcU2RV7HOlyLY+GaH8xyule2HZiwKkSqMjuCP7nkCAvpkm/Ful1kxBgJYThEkjslBGaTcIsc9jn5mU+4h8UrVoTThbWQYGwP9+do4oMyHARD0k6MtF0lKJIRAPDjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=uSAD+5cf; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4cnZwX3zWhz9tHQ;
	Thu, 16 Oct 2025 19:40:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1760636412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZxP0Op2GOPJGCmVQfhpVi9OKM831NuQf5A5nCw+dZv4=;
	b=uSAD+5cfZSmQYp83bqgCZJ2GFHuuQhmPjHL/wN/5mHexJACIMaAVV+lt/vEBlttehdTl28
	eEGLhxwyU7vQRgALRAV8NAQEzMqaJiVtYNBbV2ib9G/rQblwYzxhZZOxWuBiUpr5yD74OG
	N/nf9nemOKlaXVUVo0kriTvuDpV/ik6jDF0IMYpBfNu4OzqHNTkcR/lSnwV+czwWXkrTxR
	T6BnyiZzrG8Xwfrv1a+RPavCsuU7dgc9HBKTfXiH5y90zKUKLtLahQ5S2j/a8ScaDBx8bB
	Srzn/G0HBPbRhDnoTJohEiB7CRI9xQu3XNqYz5kfGWHWvNc09KH0S2WkKb/YLQ==
Message-ID: <174bdb5a-b5a8-4856-a0ac-8caaaefde136@mailbox.org>
Date: Thu, 16 Oct 2025 19:39:58 +0200
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
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20251016-imx8-dc-prefetch-v4-7-dfda347cb3c5@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: oisd1xzkoiz1sooehr5hspunmxjz571t
X-MBO-RS-ID: eee63f1da7d39cab528

On 10/16/25 8:32 AM, Liu Ying wrote:

Hello Liu,

> +++ b/drivers/gpu/drm/imx/dc/Kconfig
> @@ -1,6 +1,7 @@
>   config DRM_IMX8_DC
>   	tristate "Freescale i.MX8 Display Controller Graphics"
>   	depends on DRM && COMMON_CLK && OF && (ARCH_MXC || COMPILE_TEST)
> +	depends on IMX_SCU
Can the SCU dependency be made optional, or per-module, or somehow 
abstracted out (via regmap?), so iMX95 support can be added into the 
driver easily too ?

Thank you

