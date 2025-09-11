Return-Path: <linux-kernel+bounces-811287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BFB1B52703
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 05:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6607F1C23ED9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 03:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6109F22D4E9;
	Thu, 11 Sep 2025 03:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="WmGY6S1t"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16011DED5B;
	Thu, 11 Sep 2025 03:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757561209; cv=none; b=PAuOLNaypIhpwod3tNUbQO225XtOxj6+ABAaxaGeWAGqmFRxoxctX7JlbOjiRBpDam9PPwL4yA21Zrn1fb4c2dGJePdo5QneLiTZ5FnATKNf6BnAyhDZNkAalwOu70I+EcPsQKzRu/lFMrt1wbCgAxU1/xawv08wMuG+HxM0dCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757561209; c=relaxed/simple;
	bh=opmYNSL9Bkg2+AhPMnSGWCNt7L49Bfmo1aHWyinNS20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DEHib5AMefoM9bTNhgQ5SHnGg9OTDnWgV+le/3zGqjk3cFYDOQgViqF3Avv9xOGg/CmTkuuwGScRAKAsWphoRqpgUQIdFWlxrl4VTnQ3vrodalJL/SSCz5VxEF8ao0treHlp9SRiGbTlzsvg7BdyQhtrydaTBL0SM00ynZPbq40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=WmGY6S1t; arc=none smtp.client-ip=220.197.32.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=y0emQFrKhNRaK9F8r9wT8+xRJD7zvWcKi6l+Zuoa3vU=;
	b=WmGY6S1tqjFy/BldE2CA52isqt8G20G5GJV0T5WeYkKUgwJ6DNMyfUi+jg8g9w
	sEglbfjRxxm46O72IGqWPhkx0prJDjJZzpAiiKTV5x5uIVBYCChyKzqtnhMn6RwT
	2qw0falr7x80qRxvDOCJYszSSrGW0GDVeVm0mT4N/N888=
Received: from dragon (unknown [])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgCXnvYzQcJor49gBA--.42817S3;
	Thu, 11 Sep 2025 11:25:41 +0800 (CST)
Date: Thu, 11 Sep 2025 11:25:39 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Peng Fan <peng.fan@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Amit Kucheria <amit.kucheria@linaro.org>,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx8mp: Correct thermal sensor index
Message-ID: <aMJBM3GANP3NtJkK@dragon>
References: <20250905-imx8mp-thermal-v1-1-64401ac8edb0@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905-imx8mp-thermal-v1-1-64401ac8edb0@nxp.com>
X-CM-TRANSID:Ms8vCgCXnvYzQcJor49gBA--.42817S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU7jg4UUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiEgnFZWjB-SqphAAAso

On Fri, Sep 05, 2025 at 11:01:09AM +0800, Peng Fan wrote:
> The TMU has two temperature measurement sites located on the chip. The
> probe 0 is located inside of the ANAMIX, while the probe 1 is located near
> the ARM core. This has been confirmed by checking with HW design team and
> checking RTL code.
> 
> So correct the {cpu,soc}-thermal sensor index.
> 
> Fixes: 30cdd62dce6b ("arm64: dts: imx8mp: Add thermal zones support")
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied, thanks!


