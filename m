Return-Path: <linux-kernel+bounces-781003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C0BB30C27
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 05:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF11D7AFAB9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 03:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8BE26D4F1;
	Fri, 22 Aug 2025 03:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="YrNZTWg9"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45348266568;
	Fri, 22 Aug 2025 03:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755832001; cv=none; b=adq1xpDFzs0D30YzldKptYhO28YpejeNfk5Y1cqv93xG/mTriJrVeaHpjyejF3roYuLElQZm1dWHKGox0GzuBUWY6A94A9xY2omUwmm8DIwloAOxwSom3mOa/AucEM2pVqPCQRUoXRsxqRuB2F8PHZ1Y400Fa+9lcD6ukAdbTOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755832001; c=relaxed/simple;
	bh=TXwLsMZ2s0ltb5fnspir6s1oWLxBswi04VmI3jQBTu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ADQ16QIcPTQF6IQsVEGxZ+tQSWs764RFNM1ldjzREoYaiwk7/+ILO6Gkw0XvKYBmmQ70XlbNALzI0h49tFikWO7aIvhzig7JDNSDp7JCSJ8CPi+D4v1VIEKNvNbEc9/T1uE6kqojdSqLU/ThOeWMc62e1XjxxWCmVcIy0rCaPZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=YrNZTWg9; arc=none smtp.client-ip=1.95.21.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=uyXE9z92I4PX0TtZ5pXguce6WvvMl3Q/lq0kSB/sMdk=;
	b=YrNZTWg9J/AdumbnX/n6jAWEoVVEOVi7g/6rUn2Xf1pW9g49cvJznInVK8iBmw
	sjH8CgMYKRaMXypEuUiVmBdawzQm941OU/0L/SGcXzxGF0CZGuTqNFNbkVejp399
	xkyDVb/6yNU4KNajjjN4ILJesEudsFCElSFDTFYRP9ueQ=
Received: from dragon (unknown [])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgAnlttq3qdoPKAkAw--.15496S3;
	Fri, 22 Aug 2025 11:05:16 +0800 (CST)
Date: Fri, 22 Aug 2025 11:05:14 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Frieder Schrempf <frieder@fris.de>
Cc: linux-arm-kernel@lists.infradead.org,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Frieder Schrempf <frieder.schrempf@kontron.de>, imx@lists.linux.dev,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Andrej Picej <andrej.picej@norik.com>,
	Annette Kobou <annette.kobou@kontron.de>,
	Eberhard Stoll <eberhard.stoll@kontron.de>,
	Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>,
	Liu Ying <victor.liu@nxp.com>,
	Oualid Derouiche <oualid.derouiche@kontron.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Teresa Remmet <t.remmet@phytec.de>,
	Tim Harvey <tharvey@gateworks.com>
Subject: Re: [PATCH v2 00/12] Misc fixups and changes for Kontron i.MX8M and
 i.MX93 DTs
Message-ID: <aKfeaiYasvynXGbn@dragon>
References: <20250721100701.115548-1-frieder@fris.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721100701.115548-1-frieder@fris.de>
X-CM-TRANSID:Ms8vCgAnlttq3qdoPKAkAw--.15496S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7trW5ZF47KFW7Wr45KF47twb_yoW8JFWxpF
	W8G39rKFWktr4rua4UX3ZrKFW5A343GFn8A3s8J39ag3sxCa43XF15K398WFWUCr47XF4k
	tFy7J3s7K3s5ZF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UdgA7UUUUU=
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiIQzWPGin3mzS8gAA3a

On Mon, Jul 21, 2025 at 12:05:34PM +0200, Frieder Schrempf wrote:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> This is a collection of changes for several Kontron ARM64
> board devicetrees. Some are related to hardware changes,
> some are bugfixes and some are improvements.
> 
> Changes for v2:
> * fix touchscreen node name
> * add touchscreen labels
> * fix commit message for RTC interrupt patch
> 
> Annette Kobou (3):
>   arm64: dts: imx8mm-kontron: Add overlay for LTE extension board
>   arm64: dts: imx8mp-kontron: Fix CAN_ADDR0 and CAN_ADDR1 GPIOs
>   arm64: dts: imx93-kontron: Fix GPIO for panel regulator
> 
> Eberhard Stoll (1):
>   arm64: dts: imx8mm-kontron: Use GPIO for RS485 transceiver control
> 
> Frieder Schrempf (7):
>   arm64: dts: imx8mm-kontron: Remove unused regulator
>   arm64: dts: imx8mm-kontron: Sort reg nodes alphabetically
>   arm64: dts: imx8mm-kontron: Name USB regulators according to OSM
>     scheme
>   arm64: dts: imx8mp-kontron: Fix GPIO labels for latest BL board
>   arm64: dts: imx8mp-kontron: Fix USB hub reset
>   arm64: dts: imx93-kontron: Add RTC interrupt signal
>   arm64: dts: imx93-kontron: Fix USB port assignment
> 
> Oualid Derouiche (1):
>   arm64: dts: imx8mm-kontron: Add Sitronix touch controller in DL
>     devicetree

Applied all, thanks!


