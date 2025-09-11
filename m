Return-Path: <linux-kernel+bounces-811187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CC0B525A9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 03:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EB33179423
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 01:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4196817BB35;
	Thu, 11 Sep 2025 01:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="c5Jzhewp"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9AD146BF;
	Thu, 11 Sep 2025 01:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757553394; cv=none; b=cCCAcSaqNdmUKlSpwu/sJLQ2ki69tYmL5nLBrbQXOtcgcGteDck8RRXNnsF5o/qclVee3DNQqSHSsEVPNZcs2mcjy1Fr+k/7i3I0ZKxnjHcnCmGhlmsImMkORCa198KgJgLVnD6c7qaCLWuSPnkg8rvcrYiJf29Zs+fQDGy+JeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757553394; c=relaxed/simple;
	bh=TNfS1Hh2qDVkwp9g09AAfhxKpsuDn8HCPg4JSdtr2jc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rFgqCXZ3RvtMTa91bLc6CpNy7CqqRlOV/so+pkIUmNgh/BoiTStP8Vd3HGQpi0YHpBD/4VA/FPVMWgKN19cOXfNUitLlGUFIEKDZGXbaNvyu1v7L0+0iK1ZCdT5hExubSSJ0TP348Ane7lDNeo2BioC+3tB3waA7oor9y7QMuSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=c5Jzhewp; arc=none smtp.client-ip=1.95.21.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=OANMSXSGbzYV2Jbq+Hxc7epsRFSMcP+fVcz9O3WcUGU=;
	b=c5JzhewptWMmVhFVc7D/bgU2nsO8dbCyPPfwINcNGBHwYqR3TrZ/Q3qX5iHOfA
	auFAozEiNugEZkdS/J1vWTW4pFBoL7YJ4Bycbih6s/6FJkRK1h0CIGqtwzv7YSCQ
	+pt7t9r8fyfmCdA3XER6FLSaVt0Yd4XBJAH03VqD1Lnhc=
Received: from dragon (unknown [])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgCn1rLRIsJokvRNBA--.58394S3;
	Thu, 11 Sep 2025 09:16:03 +0800 (CST)
Date: Thu, 11 Sep 2025 09:16:01 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux@ew.tq-group.com,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] ARM: dts: mba6ul: Add MicIn routing
Message-ID: <aMIi0WuQQJpyJYXG@dragon>
References: <20250822134955.3321137-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822134955.3321137-1-alexander.stein@ew.tq-group.com>
X-CM-TRANSID:Mc8vCgCn1rLRIsJokvRNBA--.58394S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUouWlUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiNxOH7GjCItPSEwAA3V

On Fri, Aug 22, 2025 at 03:49:54PM +0200, Alexander Stein wrote:
> MicIn is connected to IN3_L. Add routing including the Mic Bias.
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>

Applied, thanks!


