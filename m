Return-Path: <linux-kernel+bounces-862433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DA959BF5466
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 10:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9F3774FCF17
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 08:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F73304BA0;
	Tue, 21 Oct 2025 08:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="ZMisxgFw"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D897B29617D;
	Tue, 21 Oct 2025 08:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761035618; cv=none; b=o1rx4dhif5RJS5szvORLb7izd0DguRO3ZvWnRQn3eE2leK2ceg51XxsTnC9V+0jvemx3XM+HHuogU6I1tWYzj2ViSZ7HtV6267wMwEY1wcBdnEn6/WwNTs2zJ0iI54CCNpmN+PrU2IZ+2vYZIbd/ev6Pr+eUH61LE5ItAC5hm5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761035618; c=relaxed/simple;
	bh=7iU7CJTvsGK9QB7AoMy91TybH/xefVCLXzcsEBKxdlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A2yLFLaICyedk3S1bxy36AaG9ZEjjqdjqx3et3siUj1NiQqlRcw+juUtWvJEvA/UHGqfdBJfLBaaRvKw5Yd1/cBmeCkV59cpGv+b7fAfg2ufTbnJEU2wMJlaae17fe2CYmoMf52nqe0iFvPl25gwF5jciCQZMHupHLXRY2U2ARA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=ZMisxgFw; arc=none smtp.client-ip=1.95.21.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=wVH8qj8Pg0otsfGSWfNaf2orFhrbu2S797ibxbYfU1o=;
	b=ZMisxgFwfZYcUxQVgOeJ8r907ZvHQcT3D08YfXgNn0ihnWGJZcHh+PCWeTEuW/
	LGIH2YC/aIhi/PZbv3FmY8n0az1rD0T71PjmNsvS0L1AAFtdcm2nZffuot/zOEP2
	7evX+vB1UfaNzgSg+ZV6rCLhTEEg34mPwvoDIKXa2uLm4=
Received: from dragon (unknown [])
	by gzsmtp3 (Coremail) with SMTP id M88vCgD3d7A9Rfdo_wZeAA--.47555S3;
	Tue, 21 Oct 2025 16:33:03 +0800 (CST)
Date: Tue, 21 Oct 2025 16:33:01 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Joy Zou <joy.zou@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx95-15x15-evk: add fan-supply property for
 pwm-fan
Message-ID: <aPdFPdXD6MhZRvQZ@dragon>
References: <20250919-b4-imx95-fan-v1-1-c9127bd975e9@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919-b4-imx95-fan-v1-1-c9127bd975e9@nxp.com>
X-CM-TRANSID:M88vCgD3d7A9Rfdo_wZeAA--.47555S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUxwvKUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiNB943Wj3RT81VwAA3J

On Fri, Sep 19, 2025 at 10:27:04AM +0800, Joy Zou wrote:
> Add fan-supply regulator to pwm-fan node to specify power source.
> 
> Fixes: e3e8b199aff8 ("arm64: dts: imx95: Add imx95-15x15-evk support")
> Signed-off-by: Joy Zou <joy.zou@nxp.com>

Applied, thanks!


