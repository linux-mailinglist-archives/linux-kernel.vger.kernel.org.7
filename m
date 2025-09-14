Return-Path: <linux-kernel+bounces-815626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 327D2B5691E
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 15:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF4D07A2089
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 13:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A881F1302;
	Sun, 14 Sep 2025 13:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="ZzSGU+PG"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E35E2AC17;
	Sun, 14 Sep 2025 13:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757855442; cv=none; b=euvJAzXsAwCe/km7/pHiWs9rxEnUQnq+wQXptUOieKbpcu3iLxYUYnVHwIORkSaPzWFlW/Ba/J/xuhZTHZNOHOFJ7A3z+f0bOZu1TsqJJRtVRCfgQVChV6UGmko48NnsOPIsth7urnnKlq3ZS0m37NUI9/1eSvIXXa1h07JGYCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757855442; c=relaxed/simple;
	bh=nrS8XtxZZMRt1EatFOzFAbiJT2r7mks4tK/1EanKGFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PhUNDxIEiwaMhtBqeYKtvCoQhgFr9si0EuEqB+pSRVlpss0gVIiSmdFK2t8A9AN7z+N3HAHFRvJ3ctNfBhhw9EmB5fD8xeaAAOJxfXnQz+NXdqIRM9MO607jN0Wi66mYbrDKmtdh0A91cMAaOKmTV/8Z9Uwm1ZllkBPFe3GzJBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=ZzSGU+PG; arc=none smtp.client-ip=220.197.32.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=O3XuAyG0R3H+3LQFQk1AODhxNQ122XGCYmRDMRRxkhg=;
	b=ZzSGU+PG9JJSOq53wQhRwkhBjD2u7LpmqXpm0i3B9J25GMdb7YdvJwTdnimVqi
	1TdXunU1QRcHQYHMdbycJz844Uq7g2bgzQV2P+TdiUKAl7EXhhniZrL4MFO+CZsW
	8krXjNzUSBB0W2EzNxFiIy83409FqZiItke5wMoXiKaf0=
Received: from dragon (unknown [])
	by gzsmtp3 (Coremail) with SMTP id M88vCgAHxW6PvsZoh8JvBA--.65403S3;
	Sun, 14 Sep 2025 21:09:37 +0800 (CST)
Date: Sun, 14 Sep 2025 21:09:34 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Josua Mayer <josua@solid-run.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Yazan Shhady <yazan.shhady@solid-run.com>,
	Mikhail Anikin <mikhail.anikin@solid-run.com>,
	Jon Nettleton <jon@solid-run.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 2/2] arm64: dts: add description for solidrun imx8mp
 hummingboard variants
Message-ID: <aMa-jgcY3KMyQeYO@dragon>
References: <20250911-imx8mp-sr-som-v4-0-1b1fae6135e0@solid-run.com>
 <20250911-imx8mp-sr-som-v4-2-1b1fae6135e0@solid-run.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911-imx8mp-sr-som-v4-2-1b1fae6135e0@solid-run.com>
X-CM-TRANSID:M88vCgAHxW6PvsZoh8JvBA--.65403S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7GFWfury8Cry5Zw4UXw13Jwb_yoWfCrg_Z3
	Z5WF1DX3yxtryfJw4rAw4Y9a4I9w1qgr18Gr1rtrW8X3yS9wnIvrZ2q3sa9F45Z3y7JFn2
	gw13KFy0kryxujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbhvtJUUUUU==
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiNRGfBWjGvpECXAAA3h

On Thu, Sep 11, 2025 at 12:20:04PM +0300, Josua Mayer wrote:
> Add descriptions for the SolidRun i.MX8M Plus System on Module based
> HummingBoard product-line. They share a common designed based on the
> "Pulse" version, defined by various assembly options.
> 
> The HummingBoard Pulse features:
> - 2x RJ45 Ethernet
> - 2x USB-3.0 Type A
> - HDMI connector
> - mini-HDMI connector
> - microSD connector
> - mini-PCI-E connector with SIM slot supporting USB-2.0/3.0 interfaces
> - M.2 connector with SIM slot supporting USB-2.0/3.0 interfaces
> - MIPI-CSI Camera Connector (not described without specific camera)
> - 3.5mm Analog Stereo Out / Microphone In Headphone Jack
> - RTC with backup battery
> 
> The variants Mate and Ripple are reduced versions of Pulse.
> 
> The HummingBoard Pro extends Pulse with PCI-E on M.2 connector.
> 
> Signed-off-by: Josua Mayer <josua@solid-run.com>

Applied, thanks!


