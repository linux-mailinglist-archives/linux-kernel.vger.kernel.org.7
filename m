Return-Path: <linux-kernel+bounces-870939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14760C0C064
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 08:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 766DC3B6620
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 07:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E482D63EF;
	Mon, 27 Oct 2025 07:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="Bo0hZqsC"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106AA125A0;
	Mon, 27 Oct 2025 07:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761548473; cv=none; b=o5qfvQiTo/ytwVaJltnEgIqNdMjr5XeTBo4yO87AN9GvN9yxhQdBmtqmSDTyIY85WOr1OZp9c3QE7WQaNS9x/R7u0yM9/4eg9UY7GdAt+WbqYWh7BL6/x+qhNYPS2oOeRd6VnWGHMyucBEqxEmyY2UAi3J1LqYdLD6BV8Rne/No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761548473; c=relaxed/simple;
	bh=OK/OUyZXMSROdAPC5ynR6gn+p0C2kq/Y8b28Jur6MTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bNhZ/HioE/UMmJOpoURMk4R/AkMTvHigYNosQfnjN2Zu1jdNbLeEcmIhzrPygDCeW2jsufCX5dwXtO59ehPo/HbZ8EG9ihSY7TUxY8dtB5WiG62Y8ydGp3WKco0y26oQ8PVYaRfOIWDuKJiUP7LaFysqTESeEDu2NOfI2vkPF4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=Bo0hZqsC; arc=none smtp.client-ip=220.197.32.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=5tZIQZIIeKrKNFriv/H4pggndEajGwOKWlQTygtfGwg=;
	b=Bo0hZqsCtcvx/tAbBboZVSQAtpf5EMIGUbTCfJZbYL6hOBE25YYs4xdcT7qSCJ
	7k3rPqtv8OdTEM/7JBxRoejk0CMJeLz26XxdhKln7U0SMEhYVOuy6DjUja1ejMhE
	9mcswDBNY96eglR7J7By+oWK/byiZ9yq3bYy0EpbCxEJE=
Received: from dragon (unknown [])
	by gzsmtp3 (Coremail) with SMTP id M88vCgBX5g97GP9o2cG6AA--.5331S3;
	Mon, 27 Oct 2025 15:00:12 +0800 (CST)
Date: Mon, 27 Oct 2025 15:00:10 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Christoph Niedermaier <cniedermaier@dh-electronics.com>,
	Marek Vasut <marex@denx.de>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel@dh-electronics.com
Subject: Re: [PATCH v2 0/9] ARM: dtb: imx6 DTB WARNING cleanup 2
Message-ID: <aP8YerA8CtXE-P_u@dragon>
References: <20251020-imx6_dts_clean_2-v2-0-3c12ead5094c@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020-imx6_dts_clean_2-v2-0-3c12ead5094c@nxp.com>
X-CM-TRANSID:M88vCgBX5g97GP9o2cG6AA--.5331S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU5l1vUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiCxPzZWj-BIhL-gAAsg

On Mon, Oct 20, 2025 at 05:06:34PM -0400, Frank Li wrote:
> Frank Li (9):
>       ARM: dts: imx: add power-supply for lcd panel
>       ARM: dts: imx6ull-dhcom-pdk2: rename power-supply to vcc-supply for touchscreen
>       ARM: dts: imx: remove redundant linux,phandle
>       ARM: dts: imx6qdl-skov-cpu fix typo interrupt
>       ARM: dts: imx6q-cm-fx6.dts: add supplies for wm8731
>       ARM: dts: Add bus type for parallel ov5640
>       ARM: dts: add device_type for memory node
>       ARM: dts: remove undocumented clock-names for ov5642
>       ARM: dts: imx7ulp: remove bias-pull-up

Applied, thanks!


