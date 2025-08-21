Return-Path: <linux-kernel+bounces-779100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 358D6B2EF19
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 09:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D0FD1BC5109
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 07:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B4D27B4F2;
	Thu, 21 Aug 2025 07:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="B4Ps3rxA"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805021EA7D2;
	Thu, 21 Aug 2025 07:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755760223; cv=none; b=ZJYH2DLQTEZvYN7UXmEF6L6MS3Soqu517BpVt7ZHcPoSxdYdcW/CG+4tqFvrq6ZqFyQ+qZ4hLDILXpNNODlmjqDOkzwzIqv2xxxT1fYziPWOyo7Z4OvLEIykTPcMK1tR8hnHqP66y/j9eH5JMSwVWYz2mhfYkV6+HibndTy0UZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755760223; c=relaxed/simple;
	bh=TzFoYkNr5uKeSEk4nj8rTmur2plu1IDT7LnjbDvYEWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d4WYb76+xa4+GyaD8pesA9nlIxutGglocF3IywDyWxVfhoDnBMu6aiAmpf+PuvQA69WkD21xsb+CnxtV7VkCE5P9YnJo0cMb3s8Y3Rzih+XGrxe8EsJA6Rj0Y/JNfgk8YdZzjVEiVb+3OHYK6z/9m8T0kp//y30eHoUgDksK2lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=B4Ps3rxA; arc=none smtp.client-ip=1.95.21.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=RfPOWbVRUC2ftEQ8/ZhtZEj1I9GSOS1lR3GmPpWbzms=;
	b=B4Ps3rxA5lTLKOMX9qz4KLmfQrRInSuwWyASzKpE8BzdORqUVxYMRs7LRTHMd7
	SAziTySrOi108CliGQfaDT4Jng65U7PMGDioaXIl/eTKtTdsMJYgjIf4kMP7bXMD
	JW8f3za/C4lYET9Jp2+PH+kM1G2bjYBqw+5h88X9xYpJY=
Received: from dragon (unknown [])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgAHe3sUxqZoZKcNAw--.5607S3;
	Thu, 21 Aug 2025 15:09:10 +0800 (CST)
Date: Thu, 21 Aug 2025 15:09:08 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Martin Kepplinger <martink@posteo.de>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
	kernel@pengutronix.de, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: dts: imx8mp: add idle cooling devices to cpu
 core
Message-ID: <aKbGFMnmM4OHiimg@dragon>
References: <20250715055903.1806961-1-martink@posteo.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715055903.1806961-1-martink@posteo.de>
X-CM-TRANSID:Mc8vCgAHe3sUxqZoZKcNAw--.5607S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7tF13XF18WFy8Xw1Uuw48JFb_yoW8ZrWUpr
	48uwn5W3Wvgr47C3yaqwnYkrnY9ws5tFW5Wr12gryfK345Zr90gayYyF13Wr18Xw18ua1f
	ZF4avryI9r4DJaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UyCJQUUUUU=
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiNhZ632imxhaGowAA3+

On Tue, Jul 15, 2025 at 05:59:22AM +0000, Martin Kepplinger wrote:
> The thermal framework can use the cpu-idle-states as
> described for imx8mp as an alternative or in parallel to
> cpufreq.
> 
> Add the DT node to the cpu so the cooling devices will be present
> and the thermal zone descriptions can use them.
> 
> Signed-off-by: Martin Kepplinger <martink@posteo.de>
> ---
>  arch/arm64/boot/dts/freescale/imx8mp.dtsi | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> index bb24dba7338ea..66e1a27d6eed9 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> @@ -80,6 +80,11 @@ A53_0: cpu@0 {
>  			operating-points-v2 = <&a53_opp_table>;
>  			#cooling-cells = <2>;
>  			cpu-idle-states = <&cpu_pd_wait>;
> +			cpu0_therm: thermal-idle {

Have a newline between properties and child node.

Shawn

> +				#cooling-cells = <2>;
> +				duration-us = <10000>;
> +				exit-latency-us = <700>;
> +			};
>  		};
>  
>  		A53_1: cpu@1 {
> @@ -98,6 +103,11 @@ A53_1: cpu@1 {
>  			operating-points-v2 = <&a53_opp_table>;
>  			#cooling-cells = <2>;
>  			cpu-idle-states = <&cpu_pd_wait>;
> +			cpu1_therm: thermal-idle {
> +				#cooling-cells = <2>;
> +				duration-us = <10000>;
> +				exit-latency-us = <700>;
> +			};
>  		};
>  
>  		A53_2: cpu@2 {
> @@ -116,6 +126,11 @@ A53_2: cpu@2 {
>  			operating-points-v2 = <&a53_opp_table>;
>  			#cooling-cells = <2>;
>  			cpu-idle-states = <&cpu_pd_wait>;
> +			cpu2_therm: thermal-idle {
> +				#cooling-cells = <2>;
> +				duration-us = <10000>;
> +				exit-latency-us = <700>;
> +			};
>  		};
>  
>  		A53_3: cpu@3 {
> @@ -134,6 +149,11 @@ A53_3: cpu@3 {
>  			operating-points-v2 = <&a53_opp_table>;
>  			#cooling-cells = <2>;
>  			cpu-idle-states = <&cpu_pd_wait>;
> +			cpu3_therm: thermal-idle {
> +				#cooling-cells = <2>;
> +				duration-us = <10000>;
> +				exit-latency-us = <700>;
> +			};
>  		};
>  
>  		A53_L2: l2-cache0 {
> -- 
> 2.39.5
> 


