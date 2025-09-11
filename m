Return-Path: <linux-kernel+bounces-811283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27146B526FB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 05:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BCB81893030
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 03:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4CE522A817;
	Thu, 11 Sep 2025 03:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="TEm9BVS6"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5738D21B9E0;
	Thu, 11 Sep 2025 03:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757560926; cv=none; b=oz6eBKXEY1BYCRkDzG8VwIjyR2bU2fwbaZq2Szf0rcZpuAuYf7GOiGHOjScSPuAano1Nd7dL02Yb6Z0Q0pVtkUQKANp/HOIP8v1tzvVKAOpGyo4NvWgoe1SBCcjLD67LhK9b30j7AgV2kbFbhAloqpZKjYd/Z/zfkj8nnQY4XNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757560926; c=relaxed/simple;
	bh=5+trMH77q83uEF1WKVmk+BogVGEkoTEwb0o1fDY/+p8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ObZ0HGQXSegC0tnlLmVyZHTsYE7wzYjYRqWjwKFK0VK7Wh4R7SWgcnSoi1JZVDxEXsM65ZwR610qZeSEuxXJYG4plnccoiCfrKUP9h56BmOHBLNxCA0VbIMNqrxoF+qqRPmd600uls3wa3RkW8/gpJU+nkeb7jyPPe6yJ11WJ30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=TEm9BVS6; arc=none smtp.client-ip=1.95.21.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=ZafrnNnDKJ160LOPQFJ9xF6eobBS3Hu2Wi+AoCGeUIc=;
	b=TEm9BVS6kxFJ1+fIAzNB6mb0OUFFX6gvB8pZqZ2MKL3mXTDiDoyWCUJScCH+/u
	RN9TinW1LIKg5bxEMtGIo187hpczUT+A2T3mf3PZJb0gLDnQTqO9FoSMFBPDcx4B
	5gD4jxBVFlCr30Sd+4AlONq0VeJHRKXziwJ50DH/4lZSw=
Received: from dragon (unknown [])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgD3Fx4yQMJohYVgBA--.16969S3;
	Thu, 11 Sep 2025 11:21:24 +0800 (CST)
Date: Thu, 11 Sep 2025 11:21:22 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/16] ARM: dts: imx6: clean up some dtb check warnings
Message-ID: <aMJAMimvJ_eIzr9F@dragon>
References: <20250903-imx6_dts_warning-v1-0-1e883d72e790@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903-imx6_dts_warning-v1-0-1e883d72e790@nxp.com>
X-CM-TRANSID:Ms8vCgD3Fx4yQMJohYVgBA--.16969S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrZryDuF18Aw4ruw1fZry5Arb_yoWDZrX_Xw
	13Ga12ya13Gr47Aw1aqr1q9F98Kr1Utr48Wry0gr1Yq3ZxC3ZxGFWrta4UWr17CrW3tw1q
	gr47XwnrX34xCjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU1sNVDUUUUU==
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiIhTnTWjCQDTSswAA3j

On Wed, Sep 03, 2025 at 04:19:53PM -0400, Frank Li wrote:
> Frank Li (16):
>       ARM: dts: imx6: add #address-cells for gsc@20
>       ARM: dts: imx6: add key- prefix for gpio-keys
>       ARM: dts: imx6: align rtc chip node name to 'rtc'
>       ARM: dts: imx6: add interrupt-cells for dlg,da9063 pmic
>       ARM: dts: imx6qdl-aristainetos2: rename ethernet-phy to ethernet-phy@0
>       ARM: dts: imx6: remove redundant pinctrl-names
>       ARM: dts: imx6: rename touch screen's node name to touchscreen
>       ARM: dts: imx6: rename node i2c-gpio to i2c.
>       ARM: dts: imx6: rename node name flash to eeprom
>       ARM: dts: imx6: rename i2c<n>mux i2c-mux-<n>
>       ARM: dts: imx6: replace gpio-key with gpio-keys compatible string
>       ARM: dts: imx6: replace isl,isl12022 with isil,isl12022 for RTC
>       ARM: dts: imx6ul-14x14-evk: add regulator for ov5640
>       ARM: dts: imx6ul-pico: add power-supply for vxt,vl050-8048nt-c01
>       ARM: dts: imx6: remove undefined linux,default-trigger source
>       ARM: dts: imx6: change rtc compatible string to st,m41t00 from m41t00

Applied all, thanks!


