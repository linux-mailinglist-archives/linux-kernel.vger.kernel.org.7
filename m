Return-Path: <linux-kernel+bounces-769869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E80DDB274A5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 03:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A5DA5E562D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 01:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF2D19ADBA;
	Fri, 15 Aug 2025 01:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jTHMTRZN"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E23E81ACA;
	Fri, 15 Aug 2025 01:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755220594; cv=none; b=AkPGoX2tQdQjfkXimrxiO0R3AU2Yn595qaWpMKc3M7cCmIPyljU+5Zw64NP0Ka581x0o7/MrTC8BtqNQ1Rs55FYRF4kk0ra76BFiekbBWB3+/m8LiNgeY7MdOhIo6lI+EKdltxp7gAWbSdS5mx6z3ljYPiu7Dpr8R42bhcyZZ+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755220594; c=relaxed/simple;
	bh=cf6OAfKWwytDfT/RKDEyFgH/ODWfTU0kLyZHUOb9LgE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pbb4ax9Zd5rBV8bUpGMqqDDbayMUZVAGiohkF4qYSGDnIk8+DNIx2rVLdruWRf85gYDO6HZ18QRnyA2yje2kH8ITVZ3Upwh9/iz4jEfLWgG9LFNX7mUN6917rEPbIzpO/rNzlxtR7x0lRnO4GCC0lGvMCzGxyZrhfrSI5I1Etcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=jTHMTRZN; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57F1GMnU1996956;
	Thu, 14 Aug 2025 20:16:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755220582;
	bh=wdqkdGOSCAX4XC81FZy2e5EZ4V68CDUBT+I+D643hSI=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=jTHMTRZN9rbmdBUrj7cy2N0cbMsuuvn/jeXGw/jLPTu7esEOW1Pcu8U3b8ttAmyJc
	 kVnCDJ43L/RrZ+v1l+S0F/B/qiPnsIGZmXo/Q3c54AI2Xg4ZrPePr80VhqqdJgQF7l
	 iOAWWQjeOHrr8f5SIr5g7yPR0ga0JmwHWOxQcMss=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57F1GMh82096866
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 14 Aug 2025 20:16:22 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 14
 Aug 2025 20:16:21 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 14 Aug 2025 20:16:21 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57F1GLQh572247;
	Thu, 14 Aug 2025 20:16:21 -0500
Date: Thu, 14 Aug 2025 20:16:21 -0500
From: Nishanth Menon <nm@ti.com>
To: Randolph Sapp <rs@ti.com>
CC: <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <d-gole@ti.com>,
        <afd@ti.com>, <bb@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <detheridge@ti.com>, <matt.coster@imgtec.com>,
        Michael Walle
	<mwalle@kernel.org>
Subject: Re: [PATCH 2/3] arm64: dts: ti: k3-am62p-j722s: enable the bxs-4-64
Message-ID: <20250815011621.rrdurnk6ueexwldw@hertz>
References: <20250808232522.1296240-1-rs@ti.com>
 <20250808232522.1296240-2-rs@ti.com>
 <20250813151721.nc5fr3qmro5grlda@steam>
 <DC1HS8D8KLIF.2MN7D9EXGQQ45@ti.com>
 <20250813184229.dhgpqvi3b6aat46g@managing>
 <DC2FWE35CXPV.YM6MK820R2PV@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <DC2FWE35CXPV.YM6MK820R2PV@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 15:40-20250814, Randolph Sapp wrote:
> On Wed Aug 13, 2025 at 1:42 PM CDT, Nishanth Menon wrote:
> > On 12:56-20250813, Randolph Sapp wrote:
> > [...]
> >
> >> >> +		reg = <0x00 0x0fd80000 0x00 0x80000>;
> >> >> +		clocks = <&k3_clks 237 1>;
> >> >> +		clock-names = "core";
> >> >> +		assigned-clocks = <&k3_clks 237 1>;
> >> >> +		assigned-clock-rates = <800000000>;
> >
> > btw, as per https://www.ti.com/lit/ds/symlink/tda4aen-q1.pdf (page 86)
> > 720MHz when vdd_core is 0.75v (default)
> > and 800MHz when vdd_core is 0.85v
> >
> > 0.85v is set in the board dts and higher OPPs are enabled depending on
> > board capability.
> >
> > You might want to check the assigned-clock-rates based on data sheet,
> > default should'nt need a assigned-clock-rate.
> 
> Are you suggesting that we set assigned-clock-rates in the board dts instead, or
> do you just want to do away with assigned-clock-rates in general and eat the
> perf difference?

The higher frequency is possible unless you know that the board is setup
for the higher voltage. So, set it board device tree file.

Look at what we did with OPP-High support on AM625 for example. That
frequency can only be reliably achieved if vdd_core is 0.85v. And base
SoC dtsi must assume safe default (min voltage of 0.75v) as the node is
enabled by default.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
https://ti.com/opensource

