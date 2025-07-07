Return-Path: <linux-kernel+bounces-720222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7BABAFB8BC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 18:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 735631AA65EF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 16:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB1E221F1F;
	Mon,  7 Jul 2025 16:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="E35Ov+YV"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1791A209F45;
	Mon,  7 Jul 2025 16:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751906288; cv=none; b=kO6uXZhZE2hXggTdXWcXfV0jEf+BqTSnIbmloezfcV8QmM/8Ms2GkwDnr5zVZol2oH0wJDvA5daykePkNdoxYmNb4Ioi/rLhJ9g6gIilJmuE21c69UK0CM6NsMRP62hhWPXhN99ocKJUImiwibzXldT2oFdCeWWBt5uLoJCrDmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751906288; c=relaxed/simple;
	bh=AHhDjJpGtYDejD2bg3JCI/QBOGoi5DDNHs1ypAZCKt0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rgXWMkkiH9vvoedPEnyvXsHDSVg6pjW4Yt8P1kFLIvUR/0SsRSVNRWTzYaAPm26K/FlZY61r4D8otsFd0tomrtCSWAiU7Gym1xCsPYDFchpdfHCwwTCiynBTx0/G7zhZdUTB6N89s/1CURoxF+pUNoC5Au5DLV8nH720YOSeiOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=E35Ov+YV; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 567GbqF1926314;
	Mon, 7 Jul 2025 11:37:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1751906272;
	bh=Yo8GlPlpcPOwxthw7SGsFbB7w1B5S5gcIxQJjPbMTCY=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=E35Ov+YVY96K9q1OgYyC5puitBIa20zxW6pNatRkP71q82KD26a3/rQLdmVHnPP9R
	 EFAe4r3VkujWq3FmdCWpJOGxvlpVK8qPzkmfkIYREG0NoHv4+tohADiOIBtHxvvVXc
	 ElspPq7yY03g2TNGPEfNrMww5ug42ofCRg9xF4rM=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 567Gbq3U603028
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 7 Jul 2025 11:37:52 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 7
 Jul 2025 11:37:51 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 7 Jul 2025 11:37:51 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 567GbpWb522914;
	Mon, 7 Jul 2025 11:37:51 -0500
Date: Mon, 7 Jul 2025 11:37:51 -0500
From: Bryan Brattlof <bb@ti.com>
To: Paresh Bhagat <p-bhagat@ti.com>
CC: <nm@ti.com>, <vigneshr@ti.com>, <praneeth@ti.com>, <kristo@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <khasim@ti.com>, <v-singh1@ti.com>,
        <afd@ti.com>, <devarsht@ti.com>, <s-vadapalli@ti.com>,
        <andrew@lunn.ch>
Subject: Re: [PATCH v6 4/4] arm64: dts: ti: Add support for AM62D2-EVM
Message-ID: <20250707163751.5tr4shordeqwwnqd@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20250704100954.2231853-1-p-bhagat@ti.com>
 <20250704100954.2231853-5-p-bhagat@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20250704100954.2231853-5-p-bhagat@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On July  4, 2025 thus sayeth Paresh Bhagat:
> AM62D-EVM evaluation module (EVM) is a low-cost expandable platform board
> designed for AM62D2 SoC from TI. It supports the following interfaces:
> 
> * 4 GB LPDDR4 RAM
> * x2 Gigabit Ethernet expansion connectors
> * x4 3.5mm TRS Audio Jack Line In
> * x4 3.5mm TRS Audio Jack Line Out
> * x2 Audio expansion connectors
> * x1 Type-A USB 2.0, x1 Type-C dual-role device (DRD) USB 2.0
> * x1 UHS-1 capable micro SD card slot
> * 32 GB eMMC Flash
> * 512 Mb OSPI NOR flash
> * x4 UARTs via USB 2.0-B
> * XDS110 for onboard JTAG debug using USB
> * Temperature sensors, user push buttons and LEDs
> 
> Although AM62D2 and AM62A7 differ in peripheral capabilities example
> multimedia, VPAC, and display subsystems, the core architecture remains
> same. To reduce duplication, AM62D support reuses the AM62A dtsi and the
> necessary overrides will be handled in SOC specific dtsi file and a
> board specific dts.
> 
> Add basic support for AM62D2-EVM.
> 
> Schematics Link - https://www.ti.com/lit/zip/sprcal5
> 
> Signed-off-by: Paresh Bhagat <p-bhagat@ti.com>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
>  arch/arm64/boot/dts/ti/Makefile          |   3 +
>  arch/arm64/boot/dts/ti/k3-am62d2-evm.dts | 617 +++++++++++++++++++++++
>  arch/arm64/boot/dts/ti/k3-am62d2.dtsi    |  20 +
>  3 files changed, 640 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/ti/k3-am62d2-evm.dts
>  create mode 100644 arch/arm64/boot/dts/ti/k3-am62d2.dtsi
>

Reviewed-by: Bryan Brattlof <bb@ti.com>

~Bryan

