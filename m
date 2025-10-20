Return-Path: <linux-kernel+bounces-860540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 47DA1BF05B1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 12:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 378A24EC0A6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 10:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FFCD2F6561;
	Mon, 20 Oct 2025 09:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="DpsFs9oG"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93EC23EA81;
	Mon, 20 Oct 2025 09:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760954395; cv=none; b=W+qSIBkRszYTyfDeiH0u/LmrCVyRCsytJBApk/rxjMXFXlbcRZffPhQfAEHmz6PdS0f0v4P5vmIZ0sWrKOxeavrrEtR4zTJSwoXqqB2qWv3hOUkFO12ZfjeusH3qZQVWZrWGDd0lB2SSUEUKUPRxok/9SNq9xXrCUqV6xuK5OxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760954395; c=relaxed/simple;
	bh=lcUrzYclEbM4aobDSlbd7tW5FiLJkSG3Kg4si0DtxCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NnBLQah6D135VIwsBoOo0CPBMiJPjLrZvC9mU/xEiDJyMQrN7ff2XbNMl4+VYlH+PKdWdnDmz5CWPuL1zw4qIY8ZcxIzJAp9oempRGNRMSSZu+27WCT86IEDIptrmK0lUxiLe/xlsMVrM31saWgsN9lCeZ72FSQEALNRoZhwv9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=DpsFs9oG; arc=none smtp.client-ip=1.95.21.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=AfyNeX9E/nPanq5c8uUp93ycFbokasvZq+5ZQgrpmno=;
	b=DpsFs9oGajK/aJ/9GIguYCW9Y7AOtN8UB/IQvh7Ol3bq0p0VPqSoxIid1kHb68
	QbJBznXnl22LY/aDJARewDbl4SC6w7/zR+hJw8+aK6iYn88lrS0RTMAIsrknUFtK
	xqIX2zEpGNHFJGb6reHpYHgfCXsUDdYauyb6VQcpagGhc=
Received: from dragon (unknown [])
	by gzsmtp3 (Coremail) with SMTP id M88vCgC3x3rOB_ZoAQJSAA--.25208S3;
	Mon, 20 Oct 2025 17:58:40 +0800 (CST)
Date: Mon, 20 Oct 2025 17:58:38 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Thierry Reding <thierry.reding@gmail.com>,
	Sam Ravnborg <sam@ravnborg.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 5/5] arm64: dts: imx8mp-skov: support new 10" panel
 board
Message-ID: <aPYHzulJa5wpzyZ_@dragon>
References: <20250922-v6-17-topic-imx8mp-skov-dts-jutouch-10inch-v2-0-abbb759cf8ef@pengutronix.de>
 <20250922-v6-17-topic-imx8mp-skov-dts-jutouch-10inch-v2-5-abbb759cf8ef@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922-v6-17-topic-imx8mp-skov-dts-jutouch-10inch-v2-5-abbb759cf8ef@pengutronix.de>
X-CM-TRANSID:M88vCgC3x3rOB_ZoAQJSAA--.25208S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUrWrWUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiEhDsZWj14CleTAAAsN

On Mon, Sep 22, 2025 at 01:10:56PM +0200, Steffen Trumtrar wrote:
> This board is similar to the already upstream
> imx8mp-skov-recv-tian-g07017.dts but uses a different 10" panel with a
> different touch controller.
> 
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>

Applied, thanks!


