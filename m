Return-Path: <linux-kernel+bounces-860669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C92CABF0A9D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 12:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B1AB24F1DDA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 10:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C32424EF76;
	Mon, 20 Oct 2025 10:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Y/BAatgs"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141C4258EE0;
	Mon, 20 Oct 2025 10:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760957379; cv=none; b=e3ED/2hU9IA63otSo3e/oU8GG33JIrmEEfC6WTO32y/LfMW4VmbRZwo2DFnXocxs5XruwzOhm0ttUmhfF3045/73sRW5OIU48giQUbUOdpEDBhiZAnru7rIooROk2bIMAB+fH0amxdDVHMIbIAtC8tTqKTPeVgmoZMgNZZBPao0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760957379; c=relaxed/simple;
	bh=O6G4Lmo1b6GenJxk36NYz2xHRekTKQUPL28rSfRMHZA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y7lU+tD5aiJklOH6+JcaAckCISBAwaZ6jjqzB0v4rjIra+sxjMdcAT4kimosXauEtsXncHwKdvsD2bve6B1g9sMJUUV+I608Ji7Qi4Ik4EuECp1x9AQtJ5FfEVP0hbQGlidh38ZQ8lx5QbcU5jK02lmWytIL1AJVaAP5/2YNZq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Y/BAatgs; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760957376;
	bh=O6G4Lmo1b6GenJxk36NYz2xHRekTKQUPL28rSfRMHZA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Y/BAatgsJOYxHtPQDNhAuyMZsml6L4Scuy5tsLzWPBGL0O2AbuYMUPHZdMYi2ZRdh
	 TgdHkABRsYrxGKJTZbHR0fEP6CQN29giQuEjtX/PULzG3t4wAzbNmTPWxSGXQkEZBy
	 xavl+K4On1fq78R+Ve8UE2wDYZGvM2ghdoB8pQubiwV1hoTlP5j2lQoDwVsERCJcZK
	 pBL8tNtvGEgYsh/2wQGa6Qls4WKWNYjggTcVvNwfQMmeaEaVOtYqJEBO4FI3B96dsA
	 e+sjzv8sj+k39UWceuZEYwZrYsJLku3oh9Jt0G1moRqN/j8XF/W7JDJ1JSc0ftCTGO
	 icfKv2NanlWYA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D27ED17E13A5;
	Mon, 20 Oct 2025 12:49:35 +0200 (CEST)
Message-ID: <698d4715-2727-4353-9abf-637bcab56494@collabora.com>
Date: Mon, 20 Oct 2025 12:49:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 11/13] soc: mediatek: add mmsys support for MT8189
To: Xiandong Wang <xiandong.wang@mediatek.com>,
 Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Yongqiang Niu <yongqiang.niu@mediatek.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 sirius.wang@mediatek.com, vince-wl.liu@mediatek.com, jh.hsu@mediatek.com,
 Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20251020074211.8942-1-xiandong.wang@mediatek.com>
 <20251020074211.8942-12-xiandong.wang@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20251020074211.8942-12-xiandong.wang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 20/10/25 09:40, Xiandong Wang ha scritto:
> Add driver data for MT8189 and add the routing table for each mmsys.
> 
> Signed-off-by: Xiandong Wang <xiandong.wang@mediatek.com>
> ---
>   drivers/soc/mediatek/mt8189-mmsys.h    | 300 +++++++++++++++++++++++++
>   drivers/soc/mediatek/mtk-mmsys.c       |  12 +
>   include/linux/soc/mediatek/mtk-mmsys.h |   5 +
>   3 files changed, 317 insertions(+)
>   create mode 100644 drivers/soc/mediatek/mt8189-mmsys.h
> 
> diff --git a/drivers/soc/mediatek/mt8189-mmsys.h b/drivers/soc/mediatek/mt8189-mmsys.h
> new file mode 100644
> index 000000000000..31378b6ee100
> --- /dev/null
> +++ b/drivers/soc/mediatek/mt8189-mmsys.h
> @@ -0,0 +1,300 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2024 MediaTek Inc.
> + */
> +
> +#ifndef __SOC_MEDIATEK_MT8189_MMSYS_H
> +#define __SOC_MEDIATEK_MT8189_MMSYS_H
> +
> +#include <linux/soc/mediatek/mtk-mmsys.h>
> +
> +#define MT8189_MMSYS_SW0_RST_B				0x190
> +
> +#define MT8189_MMSYS_GCE_EVENT_SEL			0x308
> +#define MT8189_EVENT_GCE_EN					(BIT(0) | BIT(1))
> +
> +#define MT8189_DISP_OVL0_OUT0_MOUT_EN 0xc10
> +	#define MT8189_MOUT_DISP_OVL0_TO_DISP_RSZ0 BIT(0)

two spaces are fine instead of a tab, makes things (just a little) more readable.

#define MT8189_DISP_OVL0_OUT0_MOUT_EN				0xc10
   #define MT8189_MOUT_DISP_OVL0_TO_DISP_RSZ0			BIT(0)

> +	#define MT8189_MOUT_DISP_OVL0_TO_DISP_RDMA0 BIT(1)
> +	#define MT8189_MOUT_DISP_OVL0_TO_DISP_WDMA0 BIT(2)
> +
> +#define MT8189_DISP_OVL1_OUT0_MOUT_EN 0xc14
> +	#define MT8189_MOUT_DISP_OVL1_TO_DISP_RSZ1 BIT(0)
> +	#define MT8189_MOUT_DISP_OVL1_TO_DISP_RDMA1 BIT(1)
> +	#define MT8189_MOUT_DISP_OVL1_TO_DISP_WDMA1 BIT(2)
> +#define MT8189_DISP_OVL_OUT0_MOUT_MASK 0x7
> +

..snip..

> +
> +#define MT8189_OVL_PQ_OUT_CROSSBAR0_SEL_IN 0xc8c
> +	#define MT8189_SEL_IN_OVL_PQ_OUT_CROSSBAR0_FROM_DISP_DITER0 (0)

Parenthesis are not needed on those numbers. Please drop ( ).

> +	#define MT8189_SEL_IN_OVL_PQ_OUT_CROSSBAR0_FROM_DISP_RDMA0_RSZ0_SOUT (1)
> +	#define MT8189_SEL_IN_OVL_PQ_OUT_CROSSBAR0_FROM_DISP_OVL0_OUT0_MOUT (2)
> +	#define MT8189_SEL_IN_OVL_PQ_OUT_CROSSBAR0_FROM_DISP_DITER1 (3)
> +	#define MT8189_SEL_IN_OVL_PQ_OUT_CROSSBAR0_FROM_DISP_RDMA1_RSZ1_SOUT (4)
> +	#define MT8189_SEL_IN_OVL_PQ_OUT_CROSSBAR0_FROM_DISP_OVL1_OUT0_MOUT (5)
> +

Regards,
Angelo



