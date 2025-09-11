Return-Path: <linux-kernel+bounces-811244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E99B52660
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 04:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B203956571E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 02:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5185120C037;
	Thu, 11 Sep 2025 02:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="KU++mzmB"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9750F9D9;
	Thu, 11 Sep 2025 02:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757557138; cv=none; b=HyOSP4kS44leKmw59X9pO0C9ALmOy+aJGN8mrxv3zdhXlp7hnY+UjUtbG2CRJUeYmr/IlU7HMSzgEIvlJHnXv7lVMOEMUlVw1cjx9xTP21Mxm9b+sLd0IiNkmdJhqWY836Xi+a/rDNdwOO4Sl+bBfhywlEraT2DBBH14SN0ZTA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757557138; c=relaxed/simple;
	bh=i92KFh/MlBRwAUuJTW7FDoIG9X1z05XchHeork5ON40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gwxmKw9gIMz04Kr4Z3tUzbKTZkexcXF8EEinzpmHj23nugcX1aZu4Ucgqfm3QV+aY2TCCzit/4J1tX9xKqSlha9ElueLiz2lkncmHFl7KgsXIlK2wYm/1qJCJ6zD+y4zWtlSPyv+hlTzSyZi15ww0vXQEsAlp01FGGdt5CEkKG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=KU++mzmB; arc=none smtp.client-ip=220.197.32.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=1sObv9PqypU8I4bvTZcjYI9PEpooVXChWMhFG7PYJt0=;
	b=KU++mzmBdtxEIjEgUkMjy47CTM/a8w6iqjmwb65MHnOWgPQZ8H67yG7JiSCvc/
	v+CgGCTuwTJk/FMfsRfWyLw8Af4k9VhrbEbe+Yz152jcsoTE0JLG21lhW0g/W0mY
	fUNlo6NWrt4ZmqZ84JKpEvMFIb3UraHouj/qLrG9FAfUs=
Received: from dragon (unknown [])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgD399huMcJoGapOBA--.47236S3;
	Thu, 11 Sep 2025 10:18:24 +0800 (CST)
Date: Thu, 11 Sep 2025 10:18:22 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"A.s. Dong" <aisheng.dong@nxp.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] dt-bindings: fsl: fsl,imx7ulp-smc1: Allow clocks and
 clock-names
Message-ID: <aMIxbgrbF4HUy2_w@dragon>
References: <20250827212446.94571-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827212446.94571-1-Frank.Li@nxp.com>
X-CM-TRANSID:Mc8vCgD399huMcJoGapOBA--.47236S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUOTmhUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiCwvFZWjCG0k9lgAAsz

On Wed, Aug 27, 2025 at 05:24:45PM -0400, Frank Li wrote:
> Allow clocks and clock-names to match existed dts file.
> 
> 'hsrun_divcore' should be 'hsrun-divcore'. But use '_' to keep old dts back
> compatible.
> 
> Fix below CHECK_DTBS warnings:
>   arch/arm/boot/dts/nxp/imx/imx7ulp-com.dtb: clock-controller@40410000 (fsl,imx7ulp-smc1): '#clock-cells', 'clock-names', 'clocks' do not match any of the regexes: '^pinctrl-[0-9]+$'
> 	from schema $id: http://devicetree.org/schemas/arm/freescale/fsl,imx7ulp-pm.yaml#
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Applied, thanks!


