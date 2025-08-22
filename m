Return-Path: <linux-kernel+bounces-781460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6556CB312C0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7632AA085A2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5F929E10F;
	Fri, 22 Aug 2025 09:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="QYvFhkIS"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334EF214232;
	Fri, 22 Aug 2025 09:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755854392; cv=none; b=aUVCCVwpnUh7q9SSAfm4wC13omM0c8Wj9XbQmuFWrIkKlLgGj5ipoPLuMpUUKJVNtBht1qfbCfXwWh62LzytUydXcd9moYufxiJGhGAQh2kidDkP/mASTPYXgZ31OaxiPKESTawf196AbvKAshAGO+NzPb3v8ElYO09ZfVOWQLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755854392; c=relaxed/simple;
	bh=gMccoOqcIUBKSBLqPcgd0stFtkhKyCFnWwb2JBVtDxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=el6ZhFPSKV+ryE+m5DoOb1DN909ZhJxjhscojYUVAHIVJysF+NibXUGwa7ZeWkxMZjMYIqfqbqFg5qJNZAOKRDtT48giGPzq6uSlEFkhv2s3VnFrdKYpkd/CqyRqbqDcrdo9LIKIyXXSLGNgSoTa64fYQSlycdzQSN2heBO9Q08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=QYvFhkIS; arc=none smtp.client-ip=1.95.21.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=vk1f6oss+mpwghmtXVYnMqfDZeMdCeY2Y/KyyI4LKrw=;
	b=QYvFhkISzKsktKgmLfHux2upH5Ylju7UuDJ5EQEadelatUYe8cEyNZARt4zqYV
	/PazBnHohbrnibgXyX6Ip3lJXJ+S6Ab09o+Yw8mSf42gekq01VhNwCqae0RrqR5f
	bendSOVvEkF8PMIM6UFV2GOGtV9ssbg+vlSCTkZVKVcr8=
Received: from dragon (unknown [])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgDH_vYLNqhomVgoAw--.12962S3;
	Fri, 22 Aug 2025 17:19:09 +0800 (CST)
Date: Fri, 22 Aug 2025 17:19:06 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Haibo Chen <haibo.chen@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>,
	Frank Li <Frank.Li@nxp.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx95-19x19-evk: correct the phy setting for
 flexcan1/2
Message-ID: <aKg2CmgimiK1OOM_@dragon>
References: <20250819-can-dts-fix-v1-1-e43e7d98a544@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819-can-dts-fix-v1-1-e43e7d98a544@nxp.com>
X-CM-TRANSID:Ms8vCgDH_vYLNqhomVgoAw--.12962S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUI1IUUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiIA-UOmioNg-XQwAA3s

On Tue, Aug 19, 2025 at 10:43:37AM +0800, Haibo Chen wrote:
> 1, the phy support up to 8Mbit/s databitrate for CAN FD.
>    refer to product data sheet:
>      https://www.nxp.com/docs/en/data-sheet/TJA1463.pdf
> 2, the standby pin of the phy is ACTIVE_LOW.
> 3, the phy of flexcan2 connect the standby/en pin to PCAL6408 on i2c4 bus.
> 
> Fixes: 02b7adb791e1 ("arm64: dts: imx95-19x19-evk: add adc0 flexcan[1,2] i2c[2,3] uart5 spi3 and tpm3")
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>

Applied, thanks!


