Return-Path: <linux-kernel+bounces-832092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3621CB9E50A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 11:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E890F1BC5AA8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 09:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDEB42E8B71;
	Thu, 25 Sep 2025 09:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="s6RMm+4h"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827682DE1F0;
	Thu, 25 Sep 2025 09:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758792424; cv=none; b=C2fAkNTaPjOjd1t6MuogJVCs1NK/cxKwKK78jZx6iaMRwGJXFRtieDNnck71y2rF/6mGvPLpRAvbNKNVDtwlUulKppH5y3zseZxMkFfPhjlH1RizcczI3HEm5RQS/Gvxr81KuC4qCuXi4TEaNwIy+0LizIAFtKmv8cCD+hKCZjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758792424; c=relaxed/simple;
	bh=5GbnpJKURpsHUqWRYxL0lezka5JHS1Xf8f75syigD5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mp95Ny0fdhoS49B6x9kZpV/7WMc/xD9wte0Dy8L7C6RRIa8WMkseyRVLiC5JOBl9y11lszYa4PY6Mf1/8YVagKwXF+rPM3Fay4OQjnTNvaug9C0xqcQRVkCmhkmwmvgJWeIlItfEC9KYKVbQ0Xe73W4RNwBOMl++peyhoqlXRns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=s6RMm+4h; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=76q1OAIbWzsCuKoQwsNyMbJZPYklly4WZ986Ya6JeA4=; b=s6RMm+4h6CxXXGd4nuCdWwwZhb
	3cMJIRtOA+1IzJ3XrBcy7tY+wNR8uNj8KB1shy/sVyqHiMTKVtcEBYwrN7D2BrQW/g9lZNKpOO0Mz
	sWPWmocZIsm5docjMWQW/gDkrLdEvf1h0JoegVhvTOpxviENR2vRPJn7XaQc1OpDvA4B+IiDIgN6r
	21cctmRbuprrDDZWO1dslwRIzVsqcIsvdOgcbuoRat/9uvc/mOZclN5RgbfgY0q/shTzfPihxpwr+
	YbXJMYADcLS0yMc5HZH3XBfA6A7qSpwhSF4ugCcvcOl8QkF2iqQ05bampl2rpVS/zjXD0cVf5O40M
	sY8BTiLQ==;
Received: from i53875a54.versanet.de ([83.135.90.84] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1v1iFE-0001MQ-H3; Thu, 25 Sep 2025 11:26:32 +0200
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 quentin.schulz@cherry.de, kever.yang@rock-chips.com, naoki@radxa.com,
 honyuenkwun@gmail.com, inindev@gmail.com, ivan8215145640@gmail.com,
 neil.armstrong@linaro.org, mani@kernel.org, dsimic@manjaro.org,
 pbrobinson@gmail.com, alchark@gmail.com, didi.debian@cknow.org,
 jjm2473@gmail.com, jbx6244@gmail.com, Liangbin Lian <jjm2473@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] arm64: dts: rockchip: introduce LinkEase EasePi R1
Date: Thu, 25 Sep 2025 11:26:29 +0200
Message-ID: <2320204.Dhsi8hcfAM@diego>
In-Reply-To: <20250925092037.13582-1-jjm2473@gmail.com>
References: <20250925092037.13582-1-jjm2473@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Donnerstag, 25. September 2025, 11:20:34 Mitteleurop=C3=A4ische Sommerze=
it schrieb Liangbin Lian:
> LinkEase EasePi R1 [1] is a high-performance mini router.
>=20
> Specification:
> - Rockchip RK3568
> - 2GB/4GB LPDDR4 RAM
> - 16GB on-board eMMC
> - 1x M.2 key for 2280 NVMe (PCIe 3.0)
> - 1x USB 3.0 Type-A
> - 1x USB 2.0 Type-C (for USB flashing)
> - 2x 1000 Base-T (native, RTL8211F)
> - 2x 2500 Base-T (PCIe, RTL8125B)
> - 1x HDMI 2.0 Output
> - 12v DC Jack
> - 1x Power key connected to PMIC
> - 2x LEDs (one static power supplied, one GPIO controlled)
>=20
> [1] https://doc.linkease.com/zh/guide/easepi-r1/hardware.html
>=20
> Signed-off-by: Liangbin Lian <jjm2473@gmail.com>
> ---
> Changes in v2:
> - Change deprecated "rockchip,system-power-controller" to "system-power-c=
ontroller"
> - Link to v1: https://lore.kernel.org/r/20250925055906.83375-1-jjm2473@gm=
ail.com/

general process comment,  please don't send multiple versions on the
same day.

This splits reviewers attention (possibly reviewing outdated submissions),
doesn't give people actual time to review and also just fills up inboxes :-)


Heiko



