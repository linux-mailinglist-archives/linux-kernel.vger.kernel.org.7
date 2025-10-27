Return-Path: <linux-kernel+bounces-870920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9FE8C0BFB2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 07:44:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 843C61898D74
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 06:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA192D8764;
	Mon, 27 Oct 2025 06:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="J8HYMHYK"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8608A23EAA5;
	Mon, 27 Oct 2025 06:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761547442; cv=none; b=Px9y3MU7oFJXwGByyyhI2bbD9qfy/eH7hhci60Zr4JAZN6rFdNmS09XQdCWJvVmILgVkP1Z+gVh7LSnlT7OyzynDJY2LuWjJE0nbBl0BCDfJlDFZdckXBTlJKWmyz8kD/pusdlmM6IV304tRA9I+zl1gKViT1k8W/Ases7MEk7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761547442; c=relaxed/simple;
	bh=8Ts8bnoJYVaGd8hjxKsPXct/uWQ+Rb7O8dFUbxzpBlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QoCIKfgFaJNn1foM2KefRweiTSV3HflG4+h1uwiI0eMRIIaT+yYGbFgT5LQdp0PNDrIZoJ4o/kY1Of3d8H8UxRlzw6EosYQEIdk+vgWV9X1cNIp8VzGf+3Qjv/QE4HS1aI7KiY+13+OHs94jsQIdvUmklqdQTJM1cFRvPTY2/Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=J8HYMHYK; arc=none smtp.client-ip=220.197.32.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=N0Po5eBoI+p6ziuP9nX8EocpWpS0/rxUwsi2jvun0Ws=;
	b=J8HYMHYKnxAF8/KS1yT8gIJlapMKsJQzlzIlACEEd7stvhhdjyCSnsddwto0eR
	nHV2qPY8YVH9F9WvmCd7I2/dWkWWZXwsr1vsIuih3hqXyekwfEnb8sQ/HoNd0k7P
	pATGgKZvPnBREkQnOk0P08WC26vJpzT+R7/w0afLX2Nd0=
Received: from dragon (unknown [])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgD3n1aKFP9oQve+AA--.28929S3;
	Mon, 27 Oct 2025 14:43:24 +0800 (CST)
Date: Mon, 27 Oct 2025 14:43:22 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/11] ARM: dts: imx6: trivial change to clean up some
 DTB warnings.
Message-ID: <aP8UiqYFJVm81bGf@dragon>
References: <20251016-imx6_dts_cleanup-v3-0-baf2814f8a15@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016-imx6_dts_cleanup-v3-0-baf2814f8a15@nxp.com>
X-CM-TRANSID:Ms8vCgD3n1aKFP9oQve+AA--.28929S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrZryDWw4kXw1xCry8Xw4UXFb_yoW3GFg_W3
	W3C3W7Aw47Cw42kw4aqrnF9FyDKF1Utr4UXrWrWr4Yq3W3AFnxWa4rta4DWFy7Cr4fXw1q
	gr1Uuw17XryxCjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUb3l1DUUUUU==
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiIQ1Cp2j-FI19oAAA3a

On Thu, Oct 16, 2025 at 12:00:04PM -0400, Frank Li wrote:
> Frank Li (11):
>       ARM: dts: imx6: rename stmpgpio to gpio
>       ARM: dts: imx6: rename touch-thermal0 to touch-0-thermal
>       ARM: dts: imx6: rename m95m02 to eeprom
>       ARM: dts: imx6qdl-ts4900: rename ngpio to ngpios
>       ARM: dts: imx6: remove gpio suffix for regulator
>       ARM: dts: imx6: change voltage-divider's io-channel-cells to 1
>       ARM: dts: imx6: remove pinctrl-name if pinctrl-0 doesn't exist
>       ARM: dts: imx6-tbs2910: rename ir_recv to ir-receiver
>       ARM: dts: imx6q-utilite-pro: add missing required property for pci
>       ARM: dts: imx6ull-phytec-tauri: remove extra space before jedec,spi-nor
>       ARM: dts: imx6qdl-nitrogen6_max: rename i2c<n>mux to i2c

Applied all, thanks!


