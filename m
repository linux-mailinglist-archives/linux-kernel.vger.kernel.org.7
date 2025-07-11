Return-Path: <linux-kernel+bounces-727082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B33B014C7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 09:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96CD41AA771A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 07:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B6F1EF397;
	Fri, 11 Jul 2025 07:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="StSQw2gM"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7AE197A6C;
	Fri, 11 Jul 2025 07:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752219312; cv=none; b=RHuw8xzL4PeJCaloZuEHeR3l43x4IePWNd/kmsLSG3aY9kKo20YgPMb1BhcoEUEC6ppBQU7zWtERaENYiuj09H/t3YyB9pf9aJTDyWA3DoseiOBcc5uzScnCqE+Ydav2I4AidQoFQcrMRjsb69/p8B9yGkb6Kp+IODPGWi960dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752219312; c=relaxed/simple;
	bh=IDr+uCskBBsYHok+zDrGdCvQqY8RroogVxQVJtuysK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gPieAMk+IVreQnwlKcLEb71vIGMFL32VQIrATeVng1RfWv9LbjoguV/hOIDLK/lIJ2NVgCmcjFqw1xzQL4n71Y2EspCYw2Qczuc9bAvminDGqwX4d3/kQrbl6FQMsN2iFQ5v1YiXTDh7nUHks6b/PmTvez0EQbqPSo3pDjAO7yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=StSQw2gM; arc=none smtp.client-ip=1.95.21.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=JCOrXCKgge6QOZkLglkzmUiuLURITUpakbtlFPV6PUU=;
	b=StSQw2gMDVcKBlj/kC6pXaz74v2b/6RJZmQOmPuvZ5U9poIWWbaLWyKnIREPGs
	9xtId/de7VmDDL2cJ9fxdZQfq8pcFnrZjc09LVg5WMz0Mn86efAX/DE7uYulYou7
	jb7d2wY0AP+uwA1AWfKZSQTrWHtK/v0smcIMAFAzUk+ZA=
Received: from dragon (unknown [])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgDnzyKKvnBopsxSAA--.57501S3;
	Fri, 11 Jul 2025 15:34:36 +0800 (CST)
Date: Fri, 11 Jul 2025 15:34:34 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: lx2160a-qds: add the two on-board RGMII PHYs
Message-ID: <aHC-ir_1X0RO6MJF@dragon>
References: <20250707153331.1372606-1-ioana.ciornei@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707153331.1372606-1-ioana.ciornei@nxp.com>
X-CM-TRANSID:Ms8vCgDnzyKKvnBopsxSAA--.57501S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUrwZ2UUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiIQwJbmhwvoxSOQAA3L

On Mon, Jul 07, 2025 at 06:33:31PM +0300, Ioana Ciornei wrote:
> Describe the two LX2160AQDS on-board RGMII PHYs on their respective MDIO
> buses behind the MDIO multiplexer.
> 
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>

Applied, thanks!


