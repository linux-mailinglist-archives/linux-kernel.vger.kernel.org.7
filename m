Return-Path: <linux-kernel+bounces-811183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 174DFB5258F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 03:12:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B63646247D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 01:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F032B1F4C96;
	Thu, 11 Sep 2025 01:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="ZbOCPlcr"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805254A04;
	Thu, 11 Sep 2025 01:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757553138; cv=none; b=Ho+R7Qh5+sUfRzfHbcRDN7oqL4Oiky14pLeAdBmetPMoX4EzmUh44WbVQbViEpjLbWih3vnLzuOV4kit0AIZioGvMjbr4qea0+2q05TCwwgAVLNH37WsxGFocCALqlomEioO1NI3RDoghCfYrfObu11TEoZe5Meia+0hTtrFmGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757553138; c=relaxed/simple;
	bh=fyZXHoK854tjEwOpIuaemZBSCudAI3GS1VuOve8MKzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ft4xDW9GFwvb/54XwidJG7Xe96+TMvgFeQBk/hGwwn3WiV66t4i85mxv6eb1mBBBwlUQwBfZC5U5lNUApLI5JzwU+5Mgplhf9MtRhYUnUDla3oEml+VrciChyr80HQj0hfIVjA08XQjSOeMiKmfer+XEWPknjZIKhznaC4BM5Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=ZbOCPlcr; arc=none smtp.client-ip=220.197.32.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=WyeQ6QBy2eGOwkZy/NqCFgqeNu/xjPsmyRPEkeSKXF8=;
	b=ZbOCPlcrNDLFDc99xib7U/kQUKxH1R61OILTx+WpSi/uPxA5Xlc1Z31kdoYLYw
	6GJhsHwq+4hI1BFRwXkrzJJSQk4rSmX4Ar3yzh4bXpb6E1jL4IY8adqqmzqitcOY
	aXtgr93NPDVJmBZ7X5gPgE19X9yObNm/pjyVp27qZLfHQ=
Received: from dragon (unknown [])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgD3P9_IIcJoC+dNBA--.47602S3;
	Thu, 11 Sep 2025 09:11:38 +0800 (CST)
Date: Thu, 11 Sep 2025 09:11:36 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH 00/10] arm64: dts: freescale/nxp/imx: Minor GIC
 interrupt-map cleanups
Message-ID: <aMIhyCimN1Jkho25@dragon>
References: <20250822-b4-dts-interrupt-address-cells-imx-v1-0-f1b479da9340@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822-b4-dts-interrupt-address-cells-imx-v1-0-f1b479da9340@linaro.org>
X-CM-TRANSID:Mc8vCgD3P9_IIcJoC+dNBA--.47602S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrKFy7XF4xWFW5ZFy3JFW8JFb_yoWxZrb_Ww
	1j93WxWa15GrsFk3yYy3Z7uryYyw1jyryUJw40grs7Zr4SqFy3Cr9aqry8Cr1UZF4YkFnr
	Cw17J3Z8J3sY9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUU6wZ7UUUUU==
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiCQbFZWjCG7IOxAAAsm

On Fri, Aug 22, 2025 at 03:31:09PM +0200, Krzysztof Kozlowski wrote:
> Krzysztof Kozlowski (10):
>       arm64: dts: fsl-ls1012a: Add default GIC address cells
>       arm64: dts: fsl-ls1043a: Add default GIC address cells
>       arm64: dts: fsl-ls1046a: Add default GIC address cells
>       arm64: dts: imx8dxl: Add default GIC address cells
>       arm64: dts: imx8mm: Add default GIC address cells
>       arm64: dts: imx8mp: Add default GIC address cells
>       arm64: dts: imx8mq: Add default GIC address cells
>       arm64: dts: imx8qm: Add default GIC address cells
>       arm64: dts: imx8qxp: Add default GIC address cells
>       arm64: dts: imx8: Use GIC_SPI for interrupt-map for readability

Applied all, thanks!


