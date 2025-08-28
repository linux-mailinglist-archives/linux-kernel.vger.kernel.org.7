Return-Path: <linux-kernel+bounces-790292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 188C5B3A474
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 17:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75256467CC1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 15:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879AA23D2BF;
	Thu, 28 Aug 2025 15:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="T7XblH1I"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEE2239E70;
	Thu, 28 Aug 2025 15:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756395013; cv=none; b=Bj/iVS7AH5id22vCbald8JLRYXYsvP9iwZq1fqf5zmvnqEnPUASQOkrIex5xiBfR85ZWJR9LcyqaUjdT7idE2SH9OVZFjSQ90DD1gagWVotucWAN9zNC+17ibSWTAhOSjkhsfY1IYx08n/8C8pRFLc84OYT4+KN+jHgXoivEE1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756395013; c=relaxed/simple;
	bh=Cp7WNogN6lDS101N295pNfBIWRm0O7nqKFyVCs34TeM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sxIBUCvym9gJI6saAs8DrcEWKkDiCA/ZT6pkFEdhPp30q/+yuT+jHdGLD0WYpaCHuEq6Evgjmkc1w+dTmceDOwOEuXM3Bqmb/nW330HJhFO88Gm+B4gijce0gLNOWnzngXYQHyjRPxxpi6D6uWKoZ2fO2X7SOG0lgOZv0quTnlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=T7XblH1I; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57SCptZ5028910;
	Thu, 28 Aug 2025 17:29:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	Q+ZOslRtpNRUZ4+XX/3wjkjYQUhaaQzOaxkNs+zbYV4=; b=T7XblH1IKrV6Pegh
	1MrbFDJraMubPXe0LnwuE7uuXeipDfgsOlZ/a0odT+os3JDoRAhJMnwza9k1yI05
	JB+2Eni0xsS8F96DDqlA8950xsGWNZa6gm6VwL9u5AiCUIMfICWm57qEob878CWN
	MRe4If7gUM9i7L7BbAdSORTbljsHLE4FoHgfB6tfgO65fM6S3uo+IUPel1BmXScS
	wn96aGYh3M67qzDgtAJk0TV5KpWF978wFPkAYcfhTrcnnv4yoIrUzdR9CwOtxhRD
	SI6j5qqH/Q1hVQC7JiQrf0WgqrcLRP39Uls9Ete6YjesuJ6SCHxwPoHJOyqfm8Ms
	kHRhig==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48q5tt5rvv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Aug 2025 17:29:49 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 2C40540045;
	Thu, 28 Aug 2025 17:28:14 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4321376B303;
	Thu, 28 Aug 2025 17:27:13 +0200 (CEST)
Received: from [10.48.86.145] (10.48.86.145) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Thu, 28 Aug
 2025 17:27:12 +0200
Message-ID: <4f0d417a-3a57-5ed7-9bbb-758679a9625d@foss.st.com>
Date: Thu, 28 Aug 2025 17:27:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 00/13] Enable display support for STM32MP25
Content-Language: en-US
To: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
        Yannick Fertre
	<yannick.fertre@foss.st.com>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Maxime
 Coquelin" <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Christophe Roullier
	<christophe.roullier@foss.st.com>
CC: <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20250822-drm-misc-next-v5-0-9c825e28f733@foss.st.com>
From: Philippe CORNU <philippe.cornu@foss.st.com>
In-Reply-To: <20250822-drm-misc-next-v5-0-9c825e28f733@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_04,2025-08-28_01,2025-03-28_01



On 8/22/25 16:34, Raphael Gallais-Pou wrote:
> This series aims to add and enable sufficient LVDS display support for
> STM32MP257F-EV1 board.
> 
> LVDS is the default use case to drive a display panel on STM32MP257F-EV,
> even though DSI panels will be supported in the near future.
> 
> The LTDC needs a pixel rate in sync with the bridge currently in use.
> For that both DSI and LVDS bridges need to declare an internal clock and
> become clock provider to the mux. The mux then selects the reference
> clock for the LTDC pixel rate generation.
> 
> For now this mux is handled internally in the LTDC, while waiting for
> the STM32 clock framework to merge a 'clk-mux' based on the SYSCFG.
> This explains the link done in the patch [7/8] between the LVDS,
> providing the reference clock for the LTDC internals.
> 
>    +----------+              |\
>    |  DSI PHY |------------->| \           +------------+
>    |          |ck_dsi_phy    |  |          |            |
>    +----------+              |  |--------->|    LTDC    |
>    +----------+              |  |pixel_clk |            |
>    | LVDS PHY |------------->|  |          +------------+
>    |          |clk_pix_lvds  |  |
>    +----------+              |  |
>                              |  |
>     ck_ker_ltdc ------------>| /
>                              |/|
>                                └- SYSCFG
> 
> Clock selection applies as follow:
> - 0b00: Selects ck_dsi_phy
> - 0b01: Selects clk_pix_lvds
> - 0b10: Selects ck_ker_ltdc (for parallel or DSI display).
> - 0b11: Reserved
> 
> The reset value of the register controlling the mux is 0b01, meaning
> that the default clock assigned is the clk_pix_lvds.  This causes two
> things:
> 
> - In order to get basic display on the LVDS encoder, like intended,
> nothing has to be done on this mux within the LTDC driver (which for now
> explains the unused syscfg phandle on the LTDC node in the device-tree).
> 
> - 'pixel_clk' is dependent from 'clk_pix_lvds' because of the LTDC clock
> domains.  They also need to be sync to get a coherent pixel rate though
> the display clock tree (which explains the LVDS phandle on the LTDC node
> in the device-tree).
> 
> Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
> ---
> Changes in v5:
> - Documentation:
>    - LTDC: Clamp correctly min/maxItems value (again)
> - Add Yannick's trailers where relevant except in patch [01/13] which
>    has been modified
> - Link to v4: https://lore.kernel.org/r/20250821-drm-misc-next-v4-0-7060500f8fd3@foss.st.com
> 
> Changes in v4:
> - Documentation:
>    - LTDC: Add "st,stm32mp255-ltdc" compatible.  After internal
>      discussion, we came to the solution that the LTDC on STM32MP255 SoC
>      needs its own compatible, since it does have the same amount of
>      clocks than on STM32MP251 SoC.
> - Devicetree:
>    - Add "st,stm32mp255" compatible on corresponding dtsi
> - Drivers:
>    - LTDC: Handle "st,stm32mp255" compatible
> - Remove Rob's r-b from patch [01/13] since it was modified.
> - Link to v3: https://lore.kernel.org/r/20250819-drm-misc-next-v3-0-04153978ebdb@foss.st.com
> 
> Changes in v3:
> - Rebased on latest drm-misc-next
> - Documentation:
>    - LTDC: Clamp correctly min/maxItems value
>    - LVDS: Remove second 'items' keyword
> - Add Krzysztof's trailer where relevant
> - Link to v2: https://lore.kernel.org/r/20250812-drm-misc-next-v2-0-132fd84463d7@foss.st.com
> 
> Changes in v2:
> - Documentation:
>    - Add support for new compatible "st,stm32mp255-lvds"
>    - Change LTDC compatible for SoC compliant one
>    - Make clearer LTDC clock-names property
> - Devicetree:
>    - Change compatible according to the documentation
>    - Change clock and clock-names order to match documentation (and avoid
>      warnings)
> - Drivers:
>    - Change LTDC compatible
> - Add Rob's trailer where relevant
> - Link to v1: https://lore.kernel.org/r/20250725-drm-misc-next-v1-0-a59848e62cf9@foss.st.com
> 
> ---
> Raphael Gallais-Pou (11):
>        dt-bindings: display: st: add two new compatibles to LTDC device
>        dt-bindings: display: st,stm32-ltdc: add access-controllers property
>        dt-bindings: display: st: add new compatible to LVDS device
>        dt-bindings: display: st,stm32mp25-lvds: add access-controllers property
>        dt-bindings: display: st,stm32mp25-lvds: add power-domains property
>        dt-bindings: arm: stm32: add required #clock-cells property
>        arm64: dts: st: add ltdc support on stm32mp251
>        arm64: dts: st: add ltdc support on stm32mp255
>        arm64: dts: st: add lvds support on stm32mp255
>        arm64: dts: st: add clock-cells to syscfg node on stm32mp251
>        arm64: dts: st: enable display support on stm32mp257f-ev1 board
> 
> Yannick Fertre (2):
>        drm/stm: ltdc: support new hardware version for STM32MP25 SoC
>        drm/stm: ltdc: handle lvds pixel clock
> 
>   .../bindings/arm/stm32/st,stm32-syscon.yaml        | 31 ++++++---
>   .../devicetree/bindings/display/st,stm32-ltdc.yaml | 55 ++++++++++++++-
>   .../bindings/display/st,stm32mp25-lvds.yaml        | 13 +++-
>   arch/arm64/boot/dts/st/stm32mp251.dtsi             | 19 ++++++
>   arch/arm64/boot/dts/st/stm32mp255.dtsi             | 20 +++++-
>   arch/arm64/boot/dts/st/stm32mp257f-ev1.dts         | 79 ++++++++++++++++++++++
>   drivers/gpu/drm/stm/drv.c                          | 12 +++-
>   drivers/gpu/drm/stm/ltdc.c                         | 58 +++++++++++++++-
>   drivers/gpu/drm/stm/ltdc.h                         |  6 ++
>   9 files changed, 275 insertions(+), 18 deletions(-)
> ---
> base-commit: c8cea4371e5eca30cda8660aabb337747dabc51d
> change-id: 20250617-drm-misc-next-4af406c1c45f
> 
> Best regards,

Hi Raphael,
Thank you for these great patches.

If you agree, I think you can merge 01-08 in misc.

Best regards
Philippe :-)

