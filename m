Return-Path: <linux-kernel+bounces-894800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98828C4C1EA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 08:33:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC4853BE882
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 07:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6B9343D63;
	Tue, 11 Nov 2025 07:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="pCGrPFo8"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D903332ECC;
	Tue, 11 Nov 2025 07:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762846412; cv=none; b=JI81qR4sfuSR3E1Omu3ybPFCC+NzQrdvvX0pZ5E+VT/NeERqvwgbPLDi1LneG7td7WaogJXFZMhNy3O5oUt73v07Bhy2OOpZg4kEf8MdHVfG6tdD4t4S4a6OJdyfk/aRLlWMpPF1rkB0OVTZbc6ruCBRu3mi/bY0RABwj/SS1SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762846412; c=relaxed/simple;
	bh=uplPXJMzKcAVAjzc8AdoyO3MKm4Opeor6rUmaY7BFP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fOZKMFZKsMLjQC9COymNXKOIX/X4/wuk8xeQvvC2Qx1kIMrcg/Vzv2mvaFI8SCViF+hpZ3PCG1qSgz5UpANr+MszxtbWRB6eApTtGikBIb36T6u/3Tg8S/7e4ouIaqbY7av2LC/vgvrSJuBQ+hWkHgnvooh0qDUR6mb0Uem+Vk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=pCGrPFo8; arc=none smtp.client-ip=1.95.21.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=A6MYlnhD622vn+jskvtP2u3P8TmkgrkKitICNkrmhfs=;
	b=pCGrPFo8uuYBh8CwNEyIz8LkgTxF1S38/tKl8mkLe/rQnC/7CQYUhVlPCthal5
	Y444dprs5ZCeKf2knL9EpU9B1bjhxloPOCCCvCnPUPKOux+XPpaSs/8Ug/mhfPnu
	/UzJ+eSFO7gcOQoad+30bFkU4r/XwELH+eVZBtB5lQ+iE=
Received: from dragon (unknown [])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgDHDpuV5hJp_hnNAQ--.5255S3;
	Tue, 11 Nov 2025 15:32:39 +0800 (CST)
Date: Tue, 11 Nov 2025 15:32:37 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
Subject: Re: [PATCH 0/2] dts: imx: cleanup warning cause by fsl,mpl3115
Message-ID: <aRLmlQHs5tF2lBb7@dragon>
References: <20251022-fsl-mpl3115-v1-0-93187d095efc@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022-fsl-mpl3115-v1-0-93187d095efc@nxp.com>
X-CM-TRANSID:Ms8vCgDHDpuV5hJp_hnNAQ--.5255S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrGF17CF4xGFyrJF43uFWDXFb_yoWxWFcEk3
	y8GFWkZ348Cw47K342kr1FvFWkG34UAw4qgryYg3y2vayI9rWxWrsrKFy3W34DGFW0vr4v
	v348Kr4DXrW3KjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU86wZ3UUUUU==
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiNhe9I2kS5peamgAA31

On Wed, Oct 22, 2025 at 04:43:20PM -0400, Frank Li wrote:
> After commit f11e4374b(dt-bindings: iio: pressure: add binding for mpl3115 )
> vdd-supply and vddio-supply is required properties.
> 
> thread:
> https://lore.kernel.org/imx/0e00bb14-19c7-493a-9629-354bac3a273e@baylibre.com/T/#t
> not prefer change both to optional. So update dts to fix CHECK_DTB
> warnings for both ARM and ARM64 platform.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Frank Li (2):
>       arm64: dts: imx8: add vdd-supply and vddio-supply for fsl,mpl3115
>       ARM: dts: imx: add vdd-supply and vddio-supply for fsl,mpl3115

Applied both, thanks!


