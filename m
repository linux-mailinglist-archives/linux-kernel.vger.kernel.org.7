Return-Path: <linux-kernel+bounces-781441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 650D3B31279
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CC416055DD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F902E3718;
	Fri, 22 Aug 2025 09:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="mS1w3EO9"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23E4139D;
	Fri, 22 Aug 2025 09:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755853418; cv=none; b=XwNizeadg5tksAE64KU31rAx7fz0yh/wzg/VRvgI+0J0g8QBbEEKkr7BlLer2M/TYojJhRwadUYCjbe0Uo/tHGED+AD0vwy6Eq6yABlb+K0mOZygjtZ6ETkL5djdnCmuKS4JydqFchWw2oJ8t4rbzhkWxipnrqw/a9iJYU5FfCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755853418; c=relaxed/simple;
	bh=l9CUHp5io/SsrtdEV9UT8NLDKk63RhtZuXM1+luuT10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a25Kn7hGpOrxCNAalyvhnmlLxhPhuu2jhMGT/HbYzropVp5ECvdNTgNlTlTdAnHgvxgfnIExgM6YFgnWNBTs6bE8K5fHXP2Kd3AZpw8SiKsF7n8il+jsTGT9VrwRR9tJzrQeCelhQJs7Dr+vLD5x4Xn3f17pdDFGwQh9ThBN+EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=mS1w3EO9; arc=none smtp.client-ip=220.197.32.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=1QoJKt8nuFIshcMaHm3vCQ4chefDHhKYjix6eCIb2Yw=;
	b=mS1w3EO91fq/WOx6YhNZhywFzujgj0p49cu+a6yFPkpOV78Bu1w63cwQbKudOY
	Be5p44mosPUVq3BmJT4V8hIxh+inyWgjmOEnCqCApKP1RG8IORVoDrdWFr5WdZnD
	JBEciVcCtD1v8cEp8J3vqWhbT5yYSpGpHKn7PhqqiX/I8=
Received: from dragon (unknown [])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgCHi343MqhoFC4cAw--.12096S3;
	Fri, 22 Aug 2025 17:02:49 +0800 (CST)
Date: Fri, 22 Aug 2025 17:02:47 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Alexander Dahl <ada@thorsis.com>
Cc: devicetree@vger.kernel.org, Frank Li <Frank.li@nxp.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] arm64: dts: imx8dxl-ss-conn: Disable USB3 nodes
Message-ID: <aKgyNy_npSiOZpf1@dragon>
References: <20250811063855.46431-1-ada@thorsis.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250811063855.46431-1-ada@thorsis.com>
X-CM-TRANSID:Mc8vCgCHi343MqhoFC4cAw--.12096S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7AF1rCrWDtF1rZF45XrW8Zwb_yoW8Jw17pF
	y8Kr4UtFyvkr1kCaykXF4SgFZIkws5Ja1UWr13GrWfKr45Cwn5Xa93Cr4Sgr4vvr4fA3y5
	tF1xJ3s2ya1j9w7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UcvtAUUUUU=
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiCQmxZWin7jqtdgAAsU

On Mon, Aug 11, 2025 at 08:38:54AM +0200, Alexander Dahl wrote:
> The i.MX 8DualXLite/8SoloXLite has a different connectivity memory map
> than the generic i.MX8 has.  One conflicting resource is usb, where the
> imx8dxl has a second usb2 phy @5b110000, while the generic imx8 dtsi has
> one usb2 phy and one usb3 phy, and the usb3otg @5b110000.  When
> including both imx8dxl-ss-conn.dtsi and imx8-ss-conn.dtsi as done in
> imx8dxl.dtsi this leads to a duplicate unit-address warning.
> 
> The usb3otg node was introduced after the initial imx8dxl support with
> commit a8bd7f155126 ("arm64: dts: imx8qxp: add cadence usb3 support")
> and since then leads to warnings like this (when built with W=2):
> 
>       DTC     arch/arm64/boot/dts/freescale/imx8dxl-evk.dtb
>     …/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi:148.24-182.4: Warning (unique_unit_address): /bus@5b000000/usb@5b110000: duplicate unit-address (also used in node /bus@5b000000/usbphy@5b110000)
>       also defined at …/arch/arm64/boot/dts/freescale/imx8dxl-ss-hsio.dtsi:41.23-50.4
>       also defined at …/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts:645.8-653.3
> 
> Delete usb3 related nodes at dxl to fix above warning.
> 
> Signed-off-by: Alexander Dahl <ada@thorsis.com>

Applied, thanks!


