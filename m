Return-Path: <linux-kernel+bounces-781456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B485B312B7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A35E16EF14
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D84F2882CA;
	Fri, 22 Aug 2025 09:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="M/KtJtvM"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF810137750;
	Fri, 22 Aug 2025 09:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755854277; cv=none; b=gigqOXVENrpGzG6JbhiDyZI5zUk1+Zfvh3WyIdMQanrX4FRdpk03YOfF2FBpylpmF2l7LcSLGu3rxeyGbn1BMWI00t1aoTb10tjxqY4EMN755V/jbxTXpifHoB3fhx9SCNuioc984/52+SpFCH0DWMo92UE2rWjHqdsCYIErxIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755854277; c=relaxed/simple;
	bh=7tXYPx2ieDCrkMI7Q7FPajuSN1ccn3q1ErSI9tkhF3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WLZ79qkDTHANO/i6EJzFY6SlzlFME1MaGoaSQqmD+eeKELyF1s0OuHBrMdXbWOxWQOq6ibDrmhtjyKxZZcKXGcwqEv/Fnrog1Jibr0XdJnmqpVO27Ax/s26HLk2tuxc22KOjZFZlTlJulQlwKLT5flJgwBjmWO/Z8ZpvwbRCEwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=M/KtJtvM; arc=none smtp.client-ip=1.95.21.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=oBzQOvbLKOrZCDGuj3oPGBAjjn0+n8NN80uKEiiCKd0=;
	b=M/KtJtvMplcZe67IU8qz2DXQAIi8h2Hr3C2+F7wj7rv+hKf1k0kUCwvX+53YEA
	OQyQYvL7SSQvu1HyXuVnK5KPC++zpFYrQVDHwGHVyLg8JFJVl77IN0UT70J6osEe
	xBiCmgWCbUHgM89J+71Ho4NpYeG56wl2nP2PalGdCQBHU=
Received: from dragon (unknown [])
	by gzsmtp3 (Coremail) with SMTP id M88vCgA39W6YNahoQtcVAw--.16293S3;
	Fri, 22 Aug 2025 17:17:14 +0800 (CST)
Date: Fri, 22 Aug 2025 17:17:12 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Peng Fan <peng.fan@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Joy Zou <joy.zou@nxp.com>, Richard Zhu <hongxing.zhu@nxp.com>,
	Luke Wang <ziniu.wang_1@nxp.com>
Subject: Re: [PATCH v2 00/11] arm64: dts: imx95: various updates
Message-ID: <aKg1mJSZq6Qcrq_r@dragon>
References: <20250818-imx9-dts-v2-0-8ba787fb5280@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818-imx9-dts-v2-0-8ba787fb5280@nxp.com>
X-CM-TRANSID:M88vCgA39W6YNahoQtcVAw--.16293S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrKw1DXFyftr45Wr17tFyxXwb_yoWxZwb_uF
	4rW3WUXw48tF4fA345Aan29FWjqF10yr9rWry5Wwn5Xw13AF1Yy397ZryrGr4rGrnI9r9x
	A3WUXw42qF45WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUj58n5UUUUU==
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiNxq3HWioNZqYHgAA3u

On Mon, Aug 18, 2025 at 09:25:30AM +0800, Peng Fan wrote:
> Joy Zou (1):
>       arm64: dts: imx95: Correct the lpuart7 and lpuart8 srcid
> 
> Luke Wang (1):
>       arm64: dts: imx95-15x15-evk: Change pinctrl settings for usdhc2
> 
> Peng Fan (8):
>       arm64: dts: imx95: Add System Counter node
>       arm64: dts: imx95: Add LMM/CPU nodes
>       arm64: dts: imx95: Add more V2X MUs
>       arm64: dts: imx95: Add OCOTP node
>       arm64: dts: imx95: Add coresight nodes
>       arm64: dts: imx95-evk: Update alias
>       arm64: dts: imx95-19x19-evk: Add pca9632 node
>       arm64: dts: imx95-19x19-evk: Add pf09 and pf53 thermal zones
> 
> Richard Zhu (1):
>       arm64: dts: imx95-19x19-evk: Add Tsettle delay in m2 regulator

Applied all, thanks!


