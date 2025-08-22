Return-Path: <linux-kernel+bounces-781381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD0BB311D8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 10:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14E02188F71C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 08:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03902EB876;
	Fri, 22 Aug 2025 08:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="AnWz0oyJ"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27288216E26;
	Fri, 22 Aug 2025 08:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755851272; cv=none; b=lrq98xciEuScGakwU//oSg/QQM38qZ73aojqxYRp1pVHusQ6414aiuGPuJspjA3aPcxcicss9kQAGblARXESR551QNeBa0+oaFp9K43zC+Dsa/5DAOQPkPmylXhz3OvRIyumxy3UtUFn4/2RiGpbJmPPJnRFYSaVLYDuzOt5rhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755851272; c=relaxed/simple;
	bh=thenpvWiSLNDmB4c+x2qmtcODgkESbbw9ot/N9LrtU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L0DxgdzokJVp1azutTiCf9bdDcFEBlQt0EqglpdCeDgFrdfYx19qTj88512mdSeRcIHToHKyuV24acSFmaMqQ3n2nX9nzoZPVS2YvI2z28vKn0kjPUleM5Yuz+tiKV0mbiSeOiddSXXZTyiqVBy6lnlVvu2zwTc+DXyHnynP1lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=AnWz0oyJ; arc=none smtp.client-ip=220.197.32.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=xnNoai/6WE+/YlaBeq11xGUrY7PQToHaLx/C4M43Y8c=;
	b=AnWz0oyJz8V/4sZx9Iaz7D0/y3nOogBQQJdsf0NZtHCIHCQjvhHFLHlGeeePh6
	owD6fhuEK+5uCgRf3JXUn+wtHRgi8D4D20Er0tyH02+421ETvx5fHyeWi2dJh5Ae
	0IroioHDWG0gcmTOv1ICe7kRNAB9+rEkKaNxsEuoohghM=
Received: from dragon (unknown [])
	by gzsmtp3 (Coremail) with SMTP id M88vCgDnBYvDKahoGlEVAw--.10154S3;
	Fri, 22 Aug 2025 16:26:45 +0800 (CST)
Date: Fri, 22 Aug 2025 16:26:43 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: mbrugger@suse.com, chester62515@gmail.com,
	ghennadi.procopciuc@oss.nxp.com, shawnguo@kernel.org,
	s.hauer@pengutronix.de, s32@nxp.com, kernel@pengutronix.de,
	festevam@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/8] Add the STM and the SWT nodes for the s32g2 and
 s32g3
Message-ID: <aKgpwzqlmK71Guio@dragon>
References: <20250731140146.62960-1-daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250731140146.62960-1-daniel.lezcano@linaro.org>
X-CM-TRANSID:M88vCgDnBYvDKahoGlEVAw--.10154S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUwg4SUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiNAW-JWioKcXcnAAA3H

On Thu, Jul 31, 2025 at 04:01:33PM +0200, Daniel Lezcano wrote:
> Daniel Lezcano (8):
>   arm64: dts: s32g2: Add the System Timer Module nodes
>   arm64: dts: s32g274-rd2: Enable the STM timers
>   arm64: dts: s32g3: Add the System Timer Module nodes
>   arm64: dts: s32g399a-rdb3: Enable the STM timers
>   arm64: dts: s32g2: Add the Software Timer Watchdog (SWT) nodes
>   arm64: dts: s32g274-rd2: Enable the SWT watchdog
>   arm64: dts: s32g3: Add the Software Timer Watchdog (SWT) nodes
>   arm64: dts: s32g399a-rdb3: Enable the SWT watchdog

Applied all, thanks!


