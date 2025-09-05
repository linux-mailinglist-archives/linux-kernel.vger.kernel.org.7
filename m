Return-Path: <linux-kernel+bounces-803641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6277DB4634C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 21:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43FFA1D21FFB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 19:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2C826F2B4;
	Fri,  5 Sep 2025 19:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XgOSuTMr"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17D5315D2E;
	Fri,  5 Sep 2025 19:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757099636; cv=none; b=aVPCkyUrNAle2WWRJ/6kHBpjtKV/CMv12xKzhNcg/LPpixpJKfm9T/PaOnk9UYnLfEN8nwYriO5f9Bhoae0ybKa4mGC/yNGipMu0bD0JoEv6rveVrg5lQMgbeQCq2LDD8xXF95iVkp2hrDwBiI3lRIzr//TgDxT7Vk4EeGFgvO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757099636; c=relaxed/simple;
	bh=COsR3o3jRXtG/eVY0etQxKPn+Y4jPbHMS2dccLQL5VI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HEVuIec9k5QP8wejzkwUEuZvIq+9gxVfpMHqNLB3vnXehW6u4uqc60lcPqU70H2NjptGWdDnw5c2ls4BM4tOprePgsa2+mD23AhRzu4Q+4jGc2r0XlB2XoXEHoX6r1aW3fsAu1rejBwsFTWtgdgkc8kXC0QgT27DhfCLsmFNWlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=XgOSuTMr; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 585JDnsp3818914;
	Fri, 5 Sep 2025 14:13:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757099629;
	bh=QbLWe+luJ8UQUm6A8CsVavRbpzIlHzez8O5PKJ7kgHw=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=XgOSuTMrVHuAOmWF9avWPW01ZpMo1MXttiJrjLD3IUeRFKW9j8vWsj9uAxyOgLWgQ
	 zuGX+fSG2U1FL4ITPsc+15lcb7ukcfHniGHqPweM7dm5PaBZanwqhYTtgONbul5prV
	 N6q6Yjuj9qmEEfHBErjSiUBGU3LICwY5mAx/aOow=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 585JDnGo567808
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 5 Sep 2025 14:13:49 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 5
 Sep 2025 14:13:49 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 5 Sep 2025 14:13:49 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.233.130])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 585JDluN901359;
	Fri, 5 Sep 2025 14:13:48 -0500
Date: Sat, 6 Sep 2025 00:43:47 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Beleswar Padhi <b-padhi@ti.com>
CC: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <afd@ti.com>,
        <u-kumar1@ti.com>, <hnagalla@ti.com>, <jm@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 10/33] arm64: dts: ti: k3-am62: Enable Mailbox nodes
 at the board level
Message-ID: <20250905191347.miywnqwn2jqgyptw@lcpd911>
References: <20250905051846.1189612-1-b-padhi@ti.com>
 <20250905051846.1189612-11-b-padhi@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250905051846.1189612-11-b-padhi@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Sep 05, 2025 at 10:48:23 +0530, Beleswar Padhi wrote:
> Mailbox nodes defined in the top-level AM62x SoC dtsi files are
> incomplete and may not be functional unless they are extended with a
> chosen interrupt and connection to a remote processor.
> 
> As the remote processors depend on memory nodes which are only known at
> the board integration level, these nodes should only be enabled when
> provided with the above information.
> 
> Disable the Mailbox nodes in the dtsi files and only enable the ones
> that are actually used on a given board.
> 
> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
> Acked-by: Andrew Davis <afd@ti.com>
> ---
> v3: Changelog:
> 1. Carried A/B tag.
> 
> Link to v2:
> https://lore.kernel.org/all/20250823160901.2177841-11-b-padhi@ti.com/
> 
> v2: Changelog:
> 1. Re-ordered patch from [PATCH 20/33] to [PATCH v2 10/33].
> 2. Added new-line before sub-nodes in mailboxes.
> 
> Link to v1:
> https://lore.kernel.org/all/20250814223839.3256046-21-b-padhi@ti.com/
> 
>  arch/arm64/boot/dts/ti/k3-am62-main.dtsi         | 1 +
>  arch/arm64/boot/dts/ti/k3-am62-pocketbeagle2.dts | 2 ++
>  arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi       | 2 ++
>  3 files changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> index 029380dc1a35..40fb3c9e674c 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> @@ -808,6 +808,7 @@ mailbox0_cluster0: mailbox@29000000 {
>  		#mbox-cells = <1>;
>  		ti,mbox-num-users = <4>;
>  		ti,mbox-num-fifos = <16>;
> +		status = "disabled";
>  	};
>  
>  	ecap0: pwm@23100000 {
> diff --git a/arch/arm64/boot/dts/ti/k3-am62-pocketbeagle2.dts b/arch/arm64/boot/dts/ti/k3-am62-pocketbeagle2.dts
> index 2e4cf65ee323..2eee5f638e0f 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62-pocketbeagle2.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am62-pocketbeagle2.dts
> @@ -293,6 +293,8 @@ &epwm2 {
>  };
>  
>  &mailbox0_cluster0 {
> +	status = "okay";
> +
>  	mbox_m4_0: mbox-m4-0 {
>  		ti,mbox-rx = <0 0 0>;
>  		ti,mbox-tx = <1 0 0>;
> diff --git a/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi b/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
> index bc2289d74774..bbf2d630b305 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
> @@ -1317,6 +1317,8 @@ &main_i2c3 {
>  };
>  
>  &mailbox0_cluster0 {
> +	status = "okay";
> +

Reviewed-by: Dhruva Gole <d-gole@ti.com>

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

