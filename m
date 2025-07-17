Return-Path: <linux-kernel+bounces-735960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4A2B095EA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 22:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EA87560769
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 20:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C55224B1B;
	Thu, 17 Jul 2025 20:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="iFrIRVjW"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9507FBF6;
	Thu, 17 Jul 2025 20:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752785160; cv=none; b=RMNN1rbvkFK8O4jFh1PXNZ7dtLOwFxpaXxWwTBSHfN6Xdr3Vncrd2y3nNqOuMutFhNMMyxupPI1+U7nM48Qwyhkv55Pbx6E9gWxgIjMh1sjNmE2r1NtuVFlUyYpOLT1FEgaGTkcmK5F4XmJ/ekVLAr44edY8ri8LE3bPWsm/5Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752785160; c=relaxed/simple;
	bh=Qx8LbgdGFVwaKlS+ogd6fIQ+LTWyts2u6SvzjTN4Nvw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WUI5YklkkOzTvmjpB9E/oZxZw3yLju+pZe3NBSr7Y7TPAnpQ2M8GbB/yH6EIDkCV217GJrLgL8XrDGxt857UbCgSv6hXXlD8jU43Bzrdr4uvk3ONN+b4MMvYt2Om+Q6SpGGDOFWYs5sJMRpvwK0NWLqcUREW5Yg3CU/ugqTTFPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=iFrIRVjW; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56HKjpbd091000;
	Thu, 17 Jul 2025 15:45:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1752785151;
	bh=1KrtjudTMe29tXW2LdCbvkSQKDHUcHyf+mPqGMkyKq4=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=iFrIRVjWfXBJ42olh52TEub21SKxJ4+jtRWYm406wzv9nmhu0XnGmN6zNuhgD21sT
	 uIht8fLS1LXyXVFvw59OI31fB2IiDVwHYeCPZAxiDnBzuyzW70EcV9gkdV/0POMj9/
	 9jBCseJmoxspoEqqASK87HwrRezzPE4ZY4ehYlIk=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56HKjpuJ486769
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 17 Jul 2025 15:45:51 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 17
 Jul 2025 15:45:50 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 17 Jul 2025 15:45:50 -0500
Received: from [128.247.81.81] (uda0499903.dhcp.ti.com [128.247.81.81])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56HKjooN2755246;
	Thu, 17 Jul 2025 15:45:50 -0500
Message-ID: <444774d0-5941-4428-b82e-d10b1fa099f2@ti.com>
Date: Thu, 17 Jul 2025 15:45:50 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] Add Interrupts property for CDNS CSI2RX
To: Yemike Abhilash Chandra <y-abhilashchandra@ti.com>, <nm@ti.com>,
        <vigneshr@ti.com>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <vaishnav.a@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <imx@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <u-kumar1@ti.com>
References: <20250714092708.3944641-1-y-abhilashchandra@ti.com>
Content-Language: en-US
From: Jared McArthur <j-mcarthur@ti.com>
In-Reply-To: <20250714092708.3944641-1-y-abhilashchandra@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 7/14/25 04:27, Yemike Abhilash Chandra wrote:
> The driver patch that adds support for error detection on the
> Cadence CSI2RX by enabling its interrupt lines was recently
> picked up [0].
> 
> Accordingly, this patch adds the required interrupts property
> to the Cadence CSI2RX device tree nodes.
> 
> Test logs:
> (To validate the complete functionality, CRC errors were
> intentionally generated by modifying the sensor overlay)
> 
> AM68: https://gist.github.com/Yemike-Abhilash-Chandra/123fed82e798a76944ec23f8e46d1114
> AM69: https://gist.github.com/Yemike-Abhilash-Chandra/1820e39888cb50e250a83e2d059365f6
> J721E: https://gist.github.com/Yemike-Abhilash-Chandra/63f993a995fd6a12cb113454952c063f
> J722S: https://gist.github.com/Yemike-Abhilash-Chandra/2144fc8ab2f7bcdb3ef868e85424467d 
> J721S2: https://gist.github.com/Yemike-Abhilash-Chandra/f46587ec1ef72671ee31803dd93434b4
> J784S4: https://gist.github.com/Yemike-Abhilash-Chandra/0c594683772f11c70bccb508757e9799
> 
> Driver and Binding patch series: https://lore.kernel.org/all/20250416121938.346435-1-y-abhilashchandra@ti.com/
> 
> [0]: https://lore.kernel.org/all/aG9tuMFOnvwXkcE-@valkosipuli.retiisi.eu/
> 
> Yemike Abhilash Chandra (7):
>   arm64: dts: ti: k3-j721s2-main: Add interrupts property
>   arm64: dts: ti: k3-j721e-main: Add interrupts property
>   arm64: dts: ti: k3-j784s4-j742s2-main-common: Add interrupts property
>   arm64: dts: ti: k3-am62p-j722s-common-main: Add interrupts property
>   arm64: dts: ti: k3-j722s-main: Add interrupts property
>   arm64: dts: ti: k3-am62-main: Add interrupts property
>   arm64: dts: ti: k3-am62a-main: Add interrupts property
> 
>  arch/arm64/boot/dts/ti/k3-am62-main.dtsi                 | 3 +++
>  arch/arm64/boot/dts/ti/k3-am62a-main.dtsi                | 3 +++
>  arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi   | 3 +++
>  arch/arm64/boot/dts/ti/k3-j721e-main.dtsi                | 6 ++++++
>  arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi               | 6 ++++++
>  arch/arm64/boot/dts/ti/k3-j722s-main.dtsi                | 9 +++++++++
>  arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi | 9 +++++++++
>  7 files changed, 39 insertions(+)
> 

For the whole series.

Reviewed-by: Jared McArthur <j-mcarthur@ti.com>

-- 
Best,
Jared McArthur

