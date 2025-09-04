Return-Path: <linux-kernel+bounces-800281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F3CDB435C4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 10:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D66675E1DB6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 08:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F492C158A;
	Thu,  4 Sep 2025 08:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mpO702DB"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6207A2BE65B;
	Thu,  4 Sep 2025 08:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756974567; cv=none; b=Cd/BGjXBFgPx8iBv+j6lKD1pOUVWDqW38omsd/uC7rdzILLGVAvqqw7Phj/p9z1PvfWrXXnryMWyIHCEuQCkKR6XCv0TYSQH9HMd83YUKVNgFYqb2xf69PjQbO0dl3x2Kzj8LBS/5PJ9JbPvPowFehSqskjxiLYm1F6wpbhvi4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756974567; c=relaxed/simple;
	bh=DsH+z8ZqcfRIqx8ipGPbLvscXJDw/h8yLf5Us8UAL2o=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eYeoDBtHs8jOPuj0tLNnB2acFvONFqTR25Al1UQ4T77AYL4zr7NB0R5ocduBg5ihM1s9gqbnCYIad4UfF5gGbKPXJ1NhVHYJeHUnVLrdiwXNwKsDv7VG4CskvNxHTtBjEdmfNuGhpOJZyQDfOrz0H0w39xD4HLZ3xTQksereNNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=mpO702DB; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5848TKKm3034493;
	Thu, 4 Sep 2025 03:29:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756974560;
	bh=PF+871OBmr63RAEPuWLxRZTj4+NEuwut1XCKOb5POuY=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=mpO702DBP25ljkQ+SVuEah13rOMzvpKRuH+2kPRFz61umuLhJwpQ9LPDtQIMuwtDK
	 mDr3kUAlo8lFZVNq5Bpn6vE1UOb6Q79fuewv+sdilWEy499LSERMF5uB2JiWWQJ31E
	 PDw5+OsC50+kt5DSSNCERydSZG60DykGqP5gQ3NY=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5848TKJu734742
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 4 Sep 2025 03:29:20 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 4
 Sep 2025 03:29:20 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 4 Sep 2025 03:29:20 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.233.130])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5848TJWF2972113;
	Thu, 4 Sep 2025 03:29:19 -0500
Date: Thu, 4 Sep 2025 13:59:18 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Akashdeep Kaur <a-kaur@ti.com>
CC: <praneeth@ti.com>, <nm@ti.com>, <afd@ti.com>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <vishalm@ti.com>, <sebin.francis@ti.com>
Subject: Re: [PATCH v3 1/3] arm64: dts: ti: k3-am62p5-sk: Remove the unused
 cfg in USB1_DRVVBUS
Message-ID: <20250904082918.3jn2mcvnpwhbly4b@lcpd911>
References: <20250902071917.1616729-1-a-kaur@ti.com>
 <20250902071917.1616729-2-a-kaur@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250902071917.1616729-2-a-kaur@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Sep 02, 2025 at 12:49:15 +0530, Akashdeep Kaur wrote:
> After the SoC has entered the DeepSleep low power mode, USB1 can be used
> to wakeup the SoC based on USB events triggered by USB devices. This
> requires that the pin corresponding to the Type-A connector remains pulled
> up even after the SoC has entered the DeepSleep low power mode.
> For that, either DeepSleep pullup configuration can be selected or the pin
> can have the same configuration that it had when SoC was in active mode.
> But, in order for DeepSleep configuration to take effect, the DeepSleep
> control bit has to be enabled.
> Remove the unnecessary DeepSleep state configuration from USB1_DRVBUS pin,
> as the DeepSleep control bit is not set and the active configuration is
> sufficient to keep the pin pulled up. This simplifies the setup and removes
> redundant configuration.
> 
> This reverts commit 115290c112952db27009668aa7ae2f29920704f0.
> 
> Signed-off-by: Akashdeep Kaur <a-kaur@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am62p5-sk.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
> index 899da7896563..e8f0ac2c55e2 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
> @@ -360,7 +360,7 @@ AM62PX_IOPAD(0x01b0, PIN_OUTPUT, 2) /* (G20) MCASP0_ACLKR.UART1_TXD */
>  
>  	main_usb1_pins_default: main-usb1-default-pins {
>  		pinctrl-single,pins = <
> -			AM62PX_IOPAD(0x0258, PIN_INPUT | PIN_DS_PULLUD_ENABLE | PIN_DS_PULL_UP, 0) /* (G21) USB1_DRVVBUS */
> +			AM62PX_IOPAD(0x0258, PIN_INPUT, 0) /* (G21) USB1_DRVVBUS */

Reviewed-by: Dhruva Gole <d-gole@ti.com>

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

