Return-Path: <linux-kernel+bounces-781576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58BCCB31428
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57061BA1920
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55402F1FF3;
	Fri, 22 Aug 2025 09:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="oylgM3tF"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D2C2F2909;
	Fri, 22 Aug 2025 09:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755855700; cv=none; b=mOzBzeqZLNSiqfEmo1FbWngrWpDgvJrdHtB41i2IEtI0JW6z6UJt8/Jqx4rcVSofUJHKVBub/CRjVMjkw8yMZtCugYJ+ZC4bmLDgf1BAs/h+qNjlEOiaXFO6fQIRJavHiIuOu+ZUpHUvTxbuWvTLfg2wCm9fN3v6xG8LzANb4sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755855700; c=relaxed/simple;
	bh=Q82BPiYlkrUkVnpiR/I5Ymj+miavXyg2dafU90RnLp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mE+nkfb1YW5347FE9jfOsdRYaRV3K6iEU9Qy0NZA8xeLW694zwizJD/squz8NtOTx9m/THULpYQ6wUJ1X8WobNieApAEhAxaIBkOj7MWK6QGQiGBcYBPrud8MsmLyZbYPW6o+tpAWqPs1orzOMWJgqwH8mEU5IwYhe9TK1TVr3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=oylgM3tF; arc=none smtp.client-ip=220.197.32.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=gVmUHKrtpOYQxCJmFxIgVTMfEmr948Q51zk/Mp4w9sA=;
	b=oylgM3tFSnx4A5WIBcMnNR2bRmfU2hMq+L/eFtSkHY6D6n8fmoggMckqx4TQzx
	aK7N4fozcEq0igDoFMqSDBk62BYarjt7Nn4FnOPKMdsOutEHo+N92VQnbLuUopE8
	qyUdzVJ/X5zF0orwPecLDe1Y5SELceBeIkdtY7uPeLw2w=
Received: from dragon (unknown [])
	by gzsmtp3 (Coremail) with SMTP id M88vCgD3T6cjO6hoXhEWAw--.33224S3;
	Fri, 22 Aug 2025 17:40:52 +0800 (CST)
Date: Fri, 22 Aug 2025 17:40:50 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Frank Li <Frank.Li@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Stefan Agner <stefan@agner.ch>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH 2/4] ARM: dts: vf610: add grp surfix to pinctrl
Message-ID: <aKg7IhnulkotjNub@dragon>
References: <20250819-vfxxx_warning-v1-0-080930d8e1ea@nxp.com>
 <20250819-vfxxx_warning-v1-2-080930d8e1ea@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819-vfxxx_warning-v1-2-080930d8e1ea@nxp.com>
X-CM-TRANSID:M88vCgD3T6cjO6hoXhEWAw--.33224S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU2LZ2UUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiARuxZWioHpBJPAAAs1

On Tue, Aug 19, 2025 at 03:44:07PM -0400, Frank Li wrote:
> Add grp surfix for pinctrl to fix below CHECK_DTBS warnings:
>   arch/arm/boot/dts/nxp/vf/vf610-zii-dev-rev-b.dtb: pinctrl@40048000 (fsl,vf610-iomuxc): i2c0grp-gpio: {'fsl,pins': [[144, 0, 0, 0, 12738, 148, 0, 0, 0, 12738]], 'phandle': 19} is not of type 'array'
> 	from schema $id: http://devicetree.org/schemas/gpio/gpio-consumer.yaml#
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Applied, thanks!


