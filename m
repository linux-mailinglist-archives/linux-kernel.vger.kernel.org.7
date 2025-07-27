Return-Path: <linux-kernel+bounces-747166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F99FB1309B
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 18:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF7813BBA91
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 16:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E065122D79F;
	Sun, 27 Jul 2025 16:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="uwpH1cn3"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DECC221DB9
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 16:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753633578; cv=none; b=fqm33X4z3Jw2Q5L32nyMHf/DcKxOQSwCre+jTek9PJvHBK+3InGfQHSUDLbSEctO6mOHPEWfcHBwEp/ILysWFouJkjXpzqlMkuvMtqYqZwuJIgRbtDoPWkhN5LGScgG9J5nKRV7XIJVXTh5v/XgJfrCtjsx/8mJRdm58sizDHOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753633578; c=relaxed/simple;
	bh=tSpa480BxryxHVl7QXWh/TInPIAUuAoO4TN4RAD5RKE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NMRL1OA1rdGcmRhX/5lt6HAGhB0qFayWiZjeWj55WnUCDi8+h1+5OqXMkTZevb6U3q8ennGVlXiK3VX0KtciBfA0dTZqluABpE/apQkgTAkKuuIaDEvpiZUsFYQzEDovTTifHAOlvwQTyJB90DUWxAgq1DjFdRu5iWTSHwQEH6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=uwpH1cn3; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1753633574;
 bh=+IwD9MK//CM9Rt8Um/g7d3JPVvOSWALhDcyNnxAUdjk=;
 b=uwpH1cn3LSf71a3e8njYCqNdxU+eInCNzyaQ5NOux2ZJD5cjvvenkifJjxMXtZ3DyyN4YCDxt
 R+KVK2vl1IjzBdxCaeIlXqVNqrzCsv9gnX1SMjcWDMKliUA82I/qy9OZaraWY2y0vcVDKHku+rj
 a5OzFOXLyFSEwICxYEAoDeDrCwAQ0Q4FANuRaadZCRbfNBIdxAKZ45Spgh8+r38Jgv/yxK64vFU
 Crfb7cvdLLFmLCB4i/dAIQ0obDUTeKWaKgchdVhLp41enRFQT1dNRaLrpmyXSXnNU+fmuP85WcA
 BoNpgojgke3Lgud6xiWSPIWwNHKsRvgaQfRpHQqMu+8A==
X-Forward-Email-ID: 68865320c752737c6c09a5f9
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.1.7
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <91ea1a4e-3b83-4857-a410-38425e4e5de0@kwiboo.se>
Date: Sun, 27 Jul 2025 18:26:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: rockchip: Add Radxa E24C
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Yao Zi <ziyao@disroot.org>,
 Chukun Pan <amadeus@jmu.edu.cn>, devicetree@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250727144409.327740-1-jonas@kwiboo.se>
 <20250727144409.327740-4-jonas@kwiboo.se>
 <72d979e8-005a-4d4d-b5d2-3f59e78574de@lunn.ch>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <72d979e8-005a-4d4d-b5d2-3f59e78574de@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Andrew,

On 7/27/2025 6:15 PM, Andrew Lunn wrote:
>> +&gmac1 {
>> +	clock_in_out = "output";
>> +	phy-mode = "rgmii-id";
>> +	phy-supply = <&avdd_rtl8367rb>;
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&rgmii_miim>, <&rgmii_tx_bus2>, <&rgmii_rx_bus2>,
>> +		    <&rgmii_rgmii_clk>, <&rgmii_rgmii_bus>, <&gmac1_rstn_l>;
>> +	status = "okay";
>> +
>> +	fixed-link {
>> +		speed = <1000>;
>> +		full-duplex;
>> +	};
> 
> A fixed-link without an obvious reason gets me asking questions...
> 
> The schematic indicates there is a realtek 6387 switch on the other
> end. rtl8365mb.c seems to support this. Is there a reason you did not
> include this now?

Sorry, this was mentioned in the cover letter, and patches to enable use
of the switch is incoming in a separate series very shortly.

"""
This also leaves out describing the RTL8367RB-VB switch as support for
the switch requires dt-binding and/or driver changes to make it work,
something that will be handled in a separate follow-up series.
"""

Basically the dt-bindings prevents describing a mdio child node, yet the
driver requires it. I have prepared a patch that relaxes the driver to
make it all work and it should be on the list shortly.

Regards,
Jonas

> 
> 	Andrew


