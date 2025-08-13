Return-Path: <linux-kernel+bounces-767322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42964B252D4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 20:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66C87627EF5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 18:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF152C0F76;
	Wed, 13 Aug 2025 18:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HEUvkxYP"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27244242909;
	Wed, 13 Aug 2025 18:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755108792; cv=none; b=a7biaA8q5satU7vWQurErY/CwsoGdwH+SQMC8ao7LfpLgjoc8dJrRuX40dJBArpI4u8dYxV154XOKJCIzwS3Rpx0uqiO3/2Q6WtWExtGwZxJJ2i/nV5uWYxHcwV9HuupDsm7vuPaazJOBg0gFoUh3trhbJFUeTrVJY471dNJ2sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755108792; c=relaxed/simple;
	bh=OzaOo9DC/ZsDSAFEyajzdZJ/+x8UmuZD6g+aohosgr4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TbNJ2v4C4n2iNtpqe6RT5P1VzDsvHx9H87AGd1JP67rLHvlq/3vugUFKU/Y4Sk/oL23g4STbnzLPBbyAXeZ4FsgsD87N1Od8zvoBN2Sr+4FKZv9TpaOJ8YtsbEn0pFQeicfHYVJhegposgS5tL3N3pO5j3jgApm5xpPHQ0Uw5oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=HEUvkxYP; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57DID1bQ2205285;
	Wed, 13 Aug 2025 13:13:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755108781;
	bh=7IebP5jPLEOV9y5xfdECM/kbLF/W1XSjQ1/QWle3e8U=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=HEUvkxYPYVFUykPkuwuYTvUtj4Hd8WtVAkZcURzvpJdBrV+Y+oiRnD0s55+p0ZZqQ
	 NfvXJiL8UfvH+g/ZgsCa0Ll3Y8pTX18yTtlcFTqh0xt8Th5Ovu2RsvFzDpHOGVchj/
	 xkSXqsP4QBwVm9AVuQtXn2bXc9BlJw4SQddnz0ao=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57DID1DW1152224
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 13 Aug 2025 13:13:01 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 13
 Aug 2025 13:13:00 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 13 Aug 2025 13:13:00 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57DID0Oa2390456;
	Wed, 13 Aug 2025 13:13:00 -0500
Date: Wed, 13 Aug 2025 13:13:00 -0500
From: Nishanth Menon <nm@ti.com>
To: Randolph Sapp <rs@ti.com>
CC: <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <d-gole@ti.com>,
        <afd@ti.com>, <bb@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <detheridge@ti.com>, <matt.coster@imgtec.com>
Subject: Re: [PATCH 3/3] arm64: dts: ti: k3-j784s4-j742s2: enable the bxs-4-64
Message-ID: <20250813181300.xfpsu23arx7xy4fy@anointer>
References: <20250808232522.1296240-1-rs@ti.com>
 <20250808232522.1296240-3-rs@ti.com>
 <20250813151819.5rthljjrpryfwezz@skinning>
 <DC1HU458W3QA.YLONSMYKK0C4@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <DC1HU458W3QA.YLONSMYKK0C4@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 12:58-20250813, Randolph Sapp wrote:
> On Wed Aug 13, 2025 at 10:18 AM CDT, Nishanth Menon wrote:
> > On 18:25-20250808, rs@ti.com wrote:
> >> From: Randolph Sapp <rs@ti.com>
> >> 
> >> Add the relevant device tree node for Imagination's BXS-4-64 GPU.
> >> 
> >> These devices uses a similar MSMC configuration to the J721S2. As such,
> >> they also require the use of the dma-coherent attribute.
> >> 
> >> Signed-off-by: Randolph Sapp <rs@ti.com>
> >> ---
> >>  .../boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi  | 14 ++++++++++++++
> >>  1 file changed, 14 insertions(+)
> >> 
> >> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi
> >> index 7c5b0c69897d..a44ca34dda62 100644
> >> --- a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi
> >> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi
> >> @@ -2691,4 +2691,18 @@ bist_main14: bist@33c0000 {
> >>  		bootph-pre-ram;
> >>  		ti,sci-dev-id = <234>;
> >>  	};
> >> +
> >> +	gpu: gpu@4e20000000 {
> >> +		compatible = "ti,j721s2-gpu", "img,img-bxs-4-64", "img,img-rogue";
> >
> > Following  https://lore.kernel.org/linux-arm-kernel/DBE4UO2RGAYX.17V1DAF8MQYJM@kernel.org/
> > Is it worth having ti,j784s4-gpu here? Are there any SoC specific quirks
> > that driver will need to handle?
> 
> No SoC specific quirks, aside from those already being tracked through the
> dma-coherent attribute. If we actually want to register SoC specific
> compatibility entries as advised by the kernel docs, just let me know. I've seen
> this opinion toggle a few times.
> 

Please provide bootlogs on linux-next with just this series applied.
IMHO, based on what I see at the moment on GPU, it might be a good idea
to have SoC specific compatibility entries.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
https://ti.com/opensource

