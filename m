Return-Path: <linux-kernel+bounces-860901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 334B3BF1416
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 14:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A329018A5A55
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 12:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D8E31AF25;
	Mon, 20 Oct 2025 12:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="JJWBAiQV"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431E43054FB;
	Mon, 20 Oct 2025 12:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760963667; cv=none; b=EA274ty+AVK5c5hnIWeT9jOpAFoQCHJlWOTA5v08McDMJ0cXlcjHtYoJJcN4+zlGi7mQP+L6l8qwyvgHboAWy+Ao9OOPhZV/W0UB1VeBoELptyBDUzwWHDhg0WzcPutrvRB+S/LxDQoMzKMC7MWcbd+uPJHnL/WZACgshZw7J2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760963667; c=relaxed/simple;
	bh=h0WJFmupmKN0XJHhCP+qudmQBuXxIDkH9/Kp13xFuk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ALa4RXred1tDy4Mbgrp4tp3/xffHKYtxf3sndNjWnfBXDdJfCjgZOkfetaglERONwlh0hUg7+77SSwhV9eWzcrcTeWHl8BjgcFWz3/EVIykcsKRGN3xdFehLhRDXVQoS2CmgqvZHEqY4MCksVL83CKo9y/9NIuGtMXbQpfqfRXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=JJWBAiQV; arc=none smtp.client-ip=220.197.32.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=reS54wtQHBJnB6K8azXiapyA5fEgeenFU64t0v4P6Mw=;
	b=JJWBAiQVrg/NiYwkUfQZee3ahGKYJLfCd1hGqLyttCCXK4nvW1Ty+u40D4CG3V
	/2SJr+7SpgCVCbTnt7kqOUEyTcT50UIGkhz2ZLniW1e1J/LHkP8qt+eVh+3QF1ct
	UMKJBzJUg34+JEKCmZOtan3WcgAsg2Crst7aseJjkvxEw=
Received: from dragon (unknown [])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgD3H1ncK_Zo3plVAA--.16314S3;
	Mon, 20 Oct 2025 20:32:30 +0800 (CST)
Date: Mon, 20 Oct 2025 20:32:28 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Primoz Fiser <primoz.fiser@norik.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, upstream@lists.phytec.de
Subject: Re: [PATCH 1/2] arm64: dts: freescale: imx93-phyboard-nash: Add USB
 vbus regulators
Message-ID: <aPYr3DRVerHvWN0i@dragon>
References: <20250916080635.1520551-1-primoz.fiser@norik.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916080635.1520551-1-primoz.fiser@norik.com>
X-CM-TRANSID:Ms8vCgD3H1ncK_Zo3plVAA--.16314S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU7JKsUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiNB7ZP2j2K94p1wAA3Z

On Tue, Sep 16, 2025 at 10:06:34AM +0200, Primoz Fiser wrote:
> Add USB vbus regulators to silence the following kernel warnings:
> 
>   usb_phy_generic usbphynop1: dummy supplies not allowed for exclusive requests (id=vbus)
>   usb_phy_generic usbphynop2: dummy supplies not allowed for exclusive requests (id=vbus)
> 
> Because generic USB PHY driver requires exclusive vbus regulators since
> commit 75fd6485ccce ("usb: phy: generic: Get the vbus supply").
> 
> Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>

Applied both, thanks!


