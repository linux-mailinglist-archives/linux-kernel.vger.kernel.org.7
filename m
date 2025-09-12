Return-Path: <linux-kernel+bounces-813204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B13B541F1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 07:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C8B61C84F47
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 05:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3722274FC1;
	Fri, 12 Sep 2025 05:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="rL3KrVZ8"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425C7271450;
	Fri, 12 Sep 2025 05:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757654521; cv=none; b=PeDFFwPzpfdKhKCtPrMtCs26gXe5lDPo1sFUrEspOXFeBtV4Ud9yjcz7pf7fuRsIcm9MnQlwD/GR9XHvljdofv5F7gVeFgWr38wjLjbKcH0i+W0Qb0pCtV454YzJYcoZI+VAkW5ajN2/5UvSsffaToHPNEKS5MuE8gBWYlsEiXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757654521; c=relaxed/simple;
	bh=r0mvUk8mybpiZxEvr84ojekidNNDY5rdkVeR3nJbYaw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CMS9jgaX4riLlI3D0mNMZkjS0I7m3T2FtMQpzVzWhbWbS4vAYyaUbqa1Vcz5y1erbOJJ3g8Pti1tSN+tRtx05r//vdeEU3ToOkLj2MF/BVkmoFVoIsePWZ1cIZnJaCJlVPPWO8ute43krXlmd049TKPLv3Ct6Hj5rw3gHnBsPS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=rL3KrVZ8; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 5D95F4E40C85;
	Fri, 12 Sep 2025 05:21:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3417860638;
	Fri, 12 Sep 2025 05:21:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 29188102F294F;
	Fri, 12 Sep 2025 07:21:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757654516; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=BuA+9G1MgDGktxBk2o730ckdqkOi9cCLmcl8CANG0Mc=;
	b=rL3KrVZ8NuDQXLLncfAhWK3ahM9lQDtploEbdU4OCWpTlyHaUkcjnm0LXQBhki4fBxAeqe
	fQy1EjK00vZ5AXQnohIK1FY9I7IAfYtTj03buZxQ2RID4jv119R5S1YSbSZoR33nbTyZ3y
	i2dAwoNX5jUEN+h9RzuCMQ4GsKthJjLerWWQ37su6uAiCQ97k10tGqQT+NfqP52XowAcKZ
	avjX9eXJCtkg9YxXLl9pnYAzd/UI8KosnyN9x8nq1TqQeORxoiAC3fV8qTEX8a+3nMyP7v
	MujEX2skECJX1Czq79h9i5QwvGYXHrPjxQ9OevH8qkp8+YtLlBYG8oCJ258itA==
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Andrew Lunn
 <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 2/2] arm64: dts: marvell: armada-cp11x: Add default ICU
 address cells
In-Reply-To: <20250822133329.312326-4-krzysztof.kozlowski@linaro.org>
References: <20250822133329.312326-3-krzysztof.kozlowski@linaro.org>
 <20250822133329.312326-4-krzysztof.kozlowski@linaro.org>
Date: Fri, 12 Sep 2025 07:21:54 +0200
Message-ID: <875xdop7nx.fsf@BLaptop.bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> writes:

> Add missing address-cells 0 to the ICU interrupt node to silence W=3D1
> warning:
>
>   armada-cp11x.dtsi:547.3-47: Warning (interrupt_map): /cp0-bus/pcie@f260=
0000:interrupt-map:
>     Missing property '#address-cells' in node /cp0-bus/bus@f2000000/inter=
rupt-controller@1e0000/interrupt-controller@10, using 0 as fallback
>
> Value '0' is correct because:
> 1. GIC interrupt controller does not have children,
> 2. interrupt-map property (in PCI node) consists of five components and
>    the fourth component "parent unit address", which size is defined by
>    '#address-cells' of the node pointed to by the interrupt-parent
>    component, is not used (=3D0)
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied on mvebu/dt64

Thanks,

Gregory
> ---
>  arch/arm64/boot/dts/marvell/armada-cp11x.dtsi | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi b/arch/arm64/b=
oot/dts/marvell/armada-cp11x.dtsi
> index a057e119492f..d9d409eac259 100644
> --- a/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
> @@ -202,6 +202,7 @@ CP11X_LABEL(icu): interrupt-controller@1e0000 {
>  			CP11X_LABEL(icu_nsr): interrupt-controller@10 {
>  				compatible =3D "marvell,cp110-icu-nsr";
>  				reg =3D <0x10 0x20>;
> +				#address-cells =3D <0>;
>  				#interrupt-cells =3D <2>;
>  				interrupt-controller;
>  				msi-parent =3D <&gicp>;
> --=20
> 2.48.1
>

--=20
Gr=C3=A9gory CLEMENT, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

