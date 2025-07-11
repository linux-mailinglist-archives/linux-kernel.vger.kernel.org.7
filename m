Return-Path: <linux-kernel+bounces-727135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D4B4B01577
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 10:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BA645A5269
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 08:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B141FECB4;
	Fri, 11 Jul 2025 08:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="YGRijOPN"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656C21F8690;
	Fri, 11 Jul 2025 08:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752221205; cv=none; b=F1ng2Gxiu6ztpOR4f8F3QxPIfDd3mdy1domdn45nss9rIFYxOBxsPmIAZNvzZhnbWg3kHJ7JpZ2xeMcTnO6HVZS0l2pjOSCa9z9yHmjvVnOrSJ6NeDxXMtFcRS+iMFtjybMvAqOqjInwnbrLmZnUBnJSM5opSBH2YVIG/jaOPBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752221205; c=relaxed/simple;
	bh=ZwY8hUAjzJDwY+ccRv673BoBqFV3812/3VWzODBWC90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mAQ4PtF+ffhOzqVHpzRhBKBLH/v/3PVD4Q0ZaeLlyRXA/8oKDNV86aypw0ejHxUo77AkeWxD/0IiMMbf4iZ2r2vJtLn+/GqAtHmwLdap/vIh/AqvYjBXWFHZapi2/+Loez+VKqE7xb/zCHXKsO/X///TQCLF9z8KDMRIjvmzpO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=YGRijOPN; arc=none smtp.client-ip=1.95.21.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=f//MRChZFcP5XIL4mb8oxZ7K1cGhRbiRX/pH6Xavkpc=;
	b=YGRijOPNm8XEsZj90dG3t/VTs87/yllFVhcTeBganDd6/72iDbj50NEATPTt4C
	55PejR7yfL8NSSoImyX892vzk5o/qklxbAMXyYs44qRQdsnZ5haQWhjfgOxPY2qV
	hpRunqyPjjIxC6hT2C5o8xPIKpCUVHM0/l5uvtPyNdFgQ=
Received: from dragon (unknown [])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgDXv_jZxXBoUV9TAA--.19772S3;
	Fri, 11 Jul 2025 16:05:47 +0800 (CST)
Date: Fri, 11 Jul 2025 16:05:45 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Frieder Schrempf <frieder@fris.de>
Cc: linux-arm-kernel@lists.infradead.org,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Fabio Estevam <festevam@gmail.com>,
	Frieder Schrempf <frieder.schrempf@kontron.de>, imx@lists.linux.dev,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Annette Kobou <annette.kobou@kontron.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH] ARM: dts: imx6ul-kontron-bl-common: Fix RTS polarity for
 RS485 interface
Message-ID: <aHDF2VPGraI5ceXZ@dragon>
References: <20250708122442.53829-1-frieder@fris.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708122442.53829-1-frieder@fris.de>
X-CM-TRANSID:Ms8vCgDXv_jZxXBoUV9TAA--.19772S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU0g4SUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiCwGHZWhwilDNbwAAsI

On Tue, Jul 08, 2025 at 02:24:41PM +0200, Frieder Schrempf wrote:
> From: Annette Kobou <annette.kobou@kontron.de>
> 
> The polarity of the DE signal of the transceiver is active-high for
> sending. Therefore rs485-rts-active-low is wrong and needs to be
> removed to make RS485 transmissions work.
> 
> Signed-off-by: Annette Kobou <annette.kobou@kontron.de>
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> Fixes: 1ea4b76cdfde ("ARM: dts: imx6ul-kontron-n6310: Add Kontron i.MX6UL N6310 SoM and boards")

Applied, thanks!


