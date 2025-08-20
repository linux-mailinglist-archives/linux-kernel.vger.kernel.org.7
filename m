Return-Path: <linux-kernel+bounces-776853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85BB0B2D227
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 04:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88408567E3A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 02:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7573426057A;
	Wed, 20 Aug 2025 02:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="lMOvkY1L"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8424A239E61;
	Wed, 20 Aug 2025 02:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755658677; cv=none; b=NQ3A6xQK1yPQdK5elF0GL41GVEnb92noVKMU/rK+ceYcKnCfTUCtsDE0kzTSQwxryRdCFgWEOnZV2LZuCSQNl+W7RsEtQigbm2Sqe0XsyBgWBkARmyElHCeBOQAzuXi/Hplz7nuW7oMZRPKCKAMD6cg0x//qcW/svBAc2e2hgCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755658677; c=relaxed/simple;
	bh=esrTk8+RJg9rwJ1whrYEmIrYncM4ygjPwKYIwzsycX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KPXyDOX9X8GC1CNE2B/ZHyuNXczgVDE5gSzsJbTMnat+EXdYih6H5HYg1jx7hubD7mnZChsU4v+qHyeM45whDdLxOFP2HTpsGs5oNeX8yxb/owZRCuFFj207Txh1vGMlRT9ytbQu8WyHIXlmH75eM1EThqeQUARf7PrCkGNaCq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=lMOvkY1L; arc=none smtp.client-ip=220.197.32.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=eV7434LtfJE9BZlDJGCgsCgIQ+62HrStedVeASbrsMw=;
	b=lMOvkY1LzCLkfwqn+mBkiG1jjmxW8cgpYJd+WnCezQjkqvtW17nGatePD9612y
	yE8borI7zEVkhJMym3LuMWw4t20k1WvdoxIYdrHyhmFlVRM2B0o8c+RWq6lVysU4
	bHT3aeDh8PI3xr5Dh8vVnVU4O4OmQAWNUAOqaWfA4pk0s=
Received: from dragon (unknown [])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgDn3wyAOaVo_eEJAw--.27675S3;
	Wed, 20 Aug 2025 10:57:06 +0800 (CST)
Date: Wed, 20 Aug 2025 10:57:04 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Goran =?utf-8?B?UmHEkWVub3ZpxIc=?= <goran.radni@gmail.com>
Cc: Frank.li@nxp.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, shawnguo@kernel.org,
	boerge.struempfel@gmail.com, s.hauer@pengutronix.de,
	festevam@gmail.com, kernel@pengutronix.de,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 0/3] arm64: dts: Add support for Ultratronik i.MX8MP
 Ultra-MACH SBC
Message-ID: <aKU5gAKdUY5m3msu@dragon>
References: <20250716154808.335138-1-goran.radni@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250716154808.335138-1-goran.radni@gmail.com>
X-CM-TRANSID:Ms8vCgDn3wyAOaVo_eEJAw--.27675S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUYHq2DUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiBB2vZWilGKVrjwAAsH

On Wed, Jul 16, 2025 at 05:48:03PM +0200, Goran Rađenović wrote:
> Goran Rađenović (3):
>   MAINTAINERS: Add i.MX8MP Ultra-MACH SBC to ULTRATRONIK BOARD SUPPORT
>   dt-bindings: arm: imx8mp: Add Ultratronik Ultra-MACH SBC
>   arm64: dts: imx8mp: Add initial support for Ultratronik
>     imx8mp-ultra-mach-sbc board

Applied all, thanks!


