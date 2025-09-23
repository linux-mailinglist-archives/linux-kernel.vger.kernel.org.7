Return-Path: <linux-kernel+bounces-829474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C07A7B9727F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 20:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8945C320408
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 18:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63D92BE058;
	Tue, 23 Sep 2025 18:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rRv9AYN6"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A2B296BCB;
	Tue, 23 Sep 2025 18:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758650596; cv=none; b=AhJ1146HBNXezz2/igAITgBhVbwVwgC4pEwwhzA3HFjZH1Rt9ny5NgPq+vsqHzGhV+73SgFyCMb4J6eKzczdr4qRvNZCPQspWQp6ivRfIje20MOo/wZhvhAzuYvEtzJOvCqdbU0lMQP0/YmX9THEvDZnT2nu9bUEde/EWDopnsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758650596; c=relaxed/simple;
	bh=fARKIZXCivIL6H1ia9QrtOaj50XQn23yezu5UTy/HrY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IdVbQmydHB2f16t0LbiQMygvAlkdHYK2IsU3vp2kv3IoNct676gm4KFUet2HsjlZFQRb4QJ7TR1owwK9K6sO4ZWv5pHI8R0WJJjCgoSFjgPpMGYfazkDInHiYxquAYA3P00IqfBvWN03znv+KvvN3CDqikb4iIUB3f3wZFzb8Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=rRv9AYN6; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58NI36hW1528658;
	Tue, 23 Sep 2025 13:03:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1758650586;
	bh=6kQZdYtmLgeO7HVe3TJI/wyYZG/yCXy6uR7Y9L+JxWM=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=rRv9AYN6qyYUSYa4Jy5uWY3rTjphWK+wwJR0hlU/1KOsVju+rXVHraxJdOnt3cdZZ
	 hn39h/KYu0VQYDVZuUSVu3JCZy+toJ3OE7lw6lihglTze+26FwgdVzEN4aetffrw+V
	 mSokbRjqc3A8iymUaDYSq1AWLiXYfpAV97mm4eZQ=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58NI35sd2156284
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 23 Sep 2025 13:03:05 -0500
Received: from DLEE207.ent.ti.com (157.170.170.95) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 23
 Sep 2025 13:03:05 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 23 Sep 2025 13:03:05 -0500
Received: from localhost (uda0506412.dhcp.ti.com [128.247.81.19])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58NI35iK698776;
	Tue, 23 Sep 2025 13:03:05 -0500
Date: Tue, 23 Sep 2025 13:03:05 -0500
From: Kendall Willis <k-willis@ti.com>
To: Markus Schneider-Pargmann <msp@baylibre.com>
CC: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Vishal Mahaveer <vishalm@ti.com>,
        Kevin
 Hilman <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>,
        Sebin Francis
	<sebin.francis@ti.com>, Akashdeep Kaur <a-kaur@ti.com>
Subject: Re: [PATCH v2 2/7] arm64: dts: ti: k3-am62: Define possible system
 states
Message-ID: <20250923180305.qmgjilxhujgkvfcp@uda0506412>
References: <20250812-topic-am62-dt-partialio-v6-15-v2-0-25352364a0ac@baylibre.com>
 <20250812-topic-am62-dt-partialio-v6-15-v2-2-25352364a0ac@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250812-topic-am62-dt-partialio-v6-15-v2-2-25352364a0ac@baylibre.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 11:15-20250812, Markus Schneider-Pargmann wrote:
> Add the system states that are available on am62 SoCs.
>

nit: Change "am62 SoCs" to "TI AM62x SoCs"

Additionally, it would be nice to add what sleep states are supported in
the commit message.

These comments also go for the other two patches that are titled
"Define possible system states".

Best,
Kendall Willis

> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am62.dtsi | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62.dtsi b/arch/arm64/boot/dts/ti/k3-am62.dtsi
> index 59f6dff552ed40e4ac0f9c7077aa25d68d3b5283..b08b7062060ca12ecae83917a831ee779f1a288f 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62.dtsi
> @@ -46,6 +46,28 @@ pmu: pmu {
>  		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
>  	};
>  
> +	system-idle-states {
> +		system_partial_io: system-partial-io {
> +			compatible = "system-idle-state";
> +			idle-state-name = "off-wake";
> +		};
> +
> +		system_deep_sleep: system-deep-sleep {
> +			compatible = "system-idle-state";
> +			idle-state-name = "mem";
> +		};
> +
> +		system_mcu_only: system-mcu-only {
> +			compatible = "system-idle-state";
> +			idle-state-name = "mem-mcu-active";
> +		};
> +
> +		system_standby: system-standby {
> +			compatible = "system-idle-state";
> +			idle-state-name = "standby";
> +		};
> +	};
> +
>  	cbass_main: bus@f0000 {
>  		bootph-all;
>  		compatible = "simple-bus";
> 
> -- 
> 2.50.1
> 

