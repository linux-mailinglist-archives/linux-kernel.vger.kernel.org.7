Return-Path: <linux-kernel+bounces-776863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D92B2D247
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 05:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D553C1C2302F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 03:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8AFA253355;
	Wed, 20 Aug 2025 03:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="WcOh3ZWS"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF8A2185AA;
	Wed, 20 Aug 2025 03:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755659302; cv=none; b=OJJ1dczB/6auE4nEWt6oHM5FfUrmMDiifW9zUB6miaBeKl/9uHpESq5AaOVCKk/fo19tuaWz1QNjen/qMSJ+QhWW0AJYCmaCRSyiaPihRmNhDuPfyLXRoqnAxZEGyztvUxt9Tl56SaF4in7AoJKSsZkah6VxNZbPCJU/QD/p5Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755659302; c=relaxed/simple;
	bh=ZXSSwhiLothcw42T8WV/C2Hk6BN4vEWGCis46vc1PUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RHz44hXRPHh9EED1tpscf6mPXV4jrDrImpvAdfv/JPKYQ1F7PC08sTDocMrt23ThP2ZqmccIaytz3DsrkWAA36N3Wz0KFfgttwrygxF4I7pV1cizxdIrxsABB0Y54oZEzNeFOUS+NU93pWIJd0jRfuWXK1H4qCaFhkOnl9r8aDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=WcOh3ZWS; arc=none smtp.client-ip=220.197.32.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=xhgXz+NGz9dE9bo3AgVhV+r8lEFLGIj0GKiYKAiGm04=;
	b=WcOh3ZWSv2Xk56vJhMpz6KCwCHurEduYoLeL7PSDayXg+xQrZ93ge37SGl8rre
	qbREsrJMJ1iAf4gfl0pxJaV1UcCM62QN2AYFMzqJ7gIp7iWsybmOZFIKrUn6JFfe
	Z4mUlqrF450rsSaU6hCZ39ffVes2sW4EiuAnLV1kfqA/U=
Received: from dragon (unknown [])
	by gzsmtp3 (Coremail) with SMTP id M88vCgAn5W6VNKVobNX3Ag--.59759S3;
	Wed, 20 Aug 2025 10:36:07 +0800 (CST)
Date: Wed, 20 Aug 2025 10:36:04 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Christoph Stoidner <c.stoidner@phytec.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, upstream@lists.phytec.de
Subject: Re: [PATCH v3] arm64: dts: freescale: imx93-phycore-som: Delay the
 phy reset by a gpio
Message-ID: <aKU0lPi485xA5SS9@dragon>
References: <20250524112315.695376-1-c.stoidner@phytec.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250524112315.695376-1-c.stoidner@phytec.de>
X-CM-TRANSID:M88vCgAn5W6VNKVobNX3Ag--.59759S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7GF13Gr47JrWDuryDKry3urg_yoWxuwb_ua
	y8K3ZFkw42yrZYgF4fKF42gr43uaykGFyrXr4rJw4fXryrXa4DWFn5Arn3Zr98X3yS9ry3
	WF909a4xursrWjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUb7PEDUUUUU==
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiNhe1G2ilNJffuAAA3G

On Sat, May 24, 2025 at 01:23:15PM +0200, Christoph Stoidner wrote:
> According to the datasheet the phy needs to be held in reset until the
> reference clock got stable. Even though no issue was observed, fix this
> as the software should always comply with the specification.
> 
> Use gpio4 23, which is connected to the phy reset pin. On the same pin
> RX_ER was used before, but this signal is optional and can be dropped.
> 
> Note: This comes into effect with the phyCOREs SOM hardware revision 4.
> In revisions before, this gpio is not connected, and the phy reset is
> managed with the global hardware reset circuit.
> 
> Signed-off-by: Christoph Stoidner <c.stoidner@phytec.de>

Applied, thanks!


