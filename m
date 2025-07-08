Return-Path: <linux-kernel+bounces-720974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45197AFC2C8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 08:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 504FC3B05F0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 06:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384C622154D;
	Tue,  8 Jul 2025 06:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="S+KJ5AK2"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DB4221269;
	Tue,  8 Jul 2025 06:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751956300; cv=none; b=JrhD0vUV1JPyUzewM7QCoxKYuLnnOBRilrhS/ZWhQLZGvkOkpgINTEWue01kW9d5dg+YA57/un3izhQ2WxK57WdRsQeyaJfxJ9JGxjM5nPHVgP3u+oCeq2lscT6TT4BBc/sMKLs+zoKItf/PGPWiC87Rk5pU29MKNZ6bwJzkdvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751956300; c=relaxed/simple;
	bh=8DiGm7JdxqhqiJYsU7wV565PsIViSY8uZBpcx5obpAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ixoxCp+osmMdU2l42NyLkMv0HyDe4fXjt8NfyhIGEtY5WFQslvOyqAp13NedpECOgRfWLMI8awwUDryqBO1DMoDekGHJXQ9Ur0nJ6vbuie1Z0sk3yjBvquyxL2H//dlE79sRMRiWIbMhvzXTia924qpnaUd+pAeh1XBBsC4e1IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=S+KJ5AK2; arc=none smtp.client-ip=220.197.32.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=nE8AnDzlAdTdSngj6L3+BpOpqe9eo0q+LJAko/lAh1k=;
	b=S+KJ5AK23OGLNHolHJf9c6oSpMk54xLgwdvcsRI63T+0DPKe5PFiqg602yto46
	oRgIAsQxhx5Qb0zep12adXbZ114PoRqwXZjTE2kQNvnWdCi7Sq6kWPHUkNCooQTP
	2uegxccet03BMcbpdiu/Fv4218o1vRQxoSsB5oQ08/pWI=
Received: from dragon (unknown [])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgAXt+wWu2xoWjCJAA--.42179S3;
	Tue, 08 Jul 2025 14:30:48 +0800 (CST)
Date: Tue, 8 Jul 2025 14:30:46 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux@ew.tq-group.com,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH 0/8] TQMLS10xxA DT fixes
Message-ID: <aGy7FstpQtetMZ8v@dragon>
References: <20250701062500.515735-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701062500.515735-1-alexander.stein@ew.tq-group.com>
X-CM-TRANSID:Ms8vCgAXt+wWu2xoWjCJAA--.42179S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrGw15Kr4DCr4xAr15KF48Zwb_yoWxXFXE9r
	yfWrn29r18Jw4Sk345Za17tayIgr15ZryUAFWag3Z3Jr1IqFy3Z3s2qryfWFyUXrs09r1D
	Zw15J3Z5XrWYgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjzwZ5UUUUU==
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiBBGEZWhsmnlz4wAAsD

On Tue, Jul 01, 2025 at 08:24:48AM +0200, Alexander Stein wrote:
> Alexander Stein (8):
>   arm64: dts: fsl-ls1043a: Remove superfluous address and size cells
>   arm64: dts: fsl-ls1046a: Remove superfluous address and size cells
>   arm64: dts: fsl-ls1088a: Remove superfluous address and size cells
>   arm64: dts: tqmls10xxa: Move SFP cage definition to common place
>   arm64: dts: tqmls1043a: Enable SFP interface
>   arm64: dts: tqmls1046a: Enable SFP interfaces
>   arm64: dts: freescale: tqmls10xx-mbls10xxa: Add vdd-supply for i2c mux
>   arm64: dts: freescale: tqmls10xx: Add vdd-supply for spi-nor flash

Applied all, thanks!


