Return-Path: <linux-kernel+bounces-870929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5968DC0BFFD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 07:54:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B32CA4E4FB3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 06:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2DC12BEC53;
	Mon, 27 Oct 2025 06:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="FYn1Hudf"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9A01991C9;
	Mon, 27 Oct 2025 06:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761548061; cv=none; b=N60WFz3+Sh3A7lrQuildcYH4L/Bebaxn8Air2Zm9Dz9FGWKM3oMnDhjB5oRY1b2FyXVgizNgl7eLPjzs5uCiZL7ZF/hVyWNIdT3YAxGx9P4ly3H5xucuCVYTi0OjzZ03jTPVxIXTJXUzzn5GYwfcS+bUJi8bW69+ZeZKN5P0fqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761548061; c=relaxed/simple;
	bh=6jUWtN8aVXsZhcQMBNUEm7MHtJYAISSEkk0g0vkKLA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SkdTkKRK7ArQLUoabOOvchBSlMIhqUYAFzKHuJnON6AGf8ny4EUQKHyA36wGeQlmQUgiY5bcJ94V2uET9dIdmmzaGaI9JYLI8AOIpGKpxJW9UBS++HSNUUJ+NIsY5r1KnzECK1eH664LDFi72e3Y4o0UUo7SLcTNueHJPKsMT0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=FYn1Hudf; arc=none smtp.client-ip=220.197.32.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=1Ig3mNz2cheWdXRa0cEaI1NEjXM1NYmX/2zCvx3pS2c=;
	b=FYn1Hudf6ZDELCRyVnzshezFUNPcDA/bBhg5NDYmrezNvvtySQhpMVX67lmbOh
	sTznv8a2r4/p1P1F6SU2VVMw4QSB2QWu0c5TGskGdi7C6KID9eyVR6iMNyxJeewR
	kv0SKy3jz1IMK3Ds0HUq0aI5TFSXiDAbft2moKNVg85xM=
Received: from dragon (unknown [])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgDn76jtFv9o8hu_AA--.25236S3;
	Mon, 27 Oct 2025 14:53:34 +0800 (CST)
Date: Mon, 27 Oct 2025 14:53:32 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Frieder Schrempf <frieder@fris.de>
Cc: Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Frieder Schrempf <frieder.schrempf@kontron.de>, imx@lists.linux.dev,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Annette Kobou <annette.kobou@kontron.de>,
	Fabio Estevam <festevam@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH] arm64: dts: imx8mp-kontron: Fix USB OTG role switching
Message-ID: <aP8W7CE2rpLIbcDx@dragon>
References: <20251020132155.630512-1-frieder@fris.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020132155.630512-1-frieder@fris.de>
X-CM-TRANSID:Ms8vCgDn76jtFv9o8hu_AA--.25236S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7JFWxAw4DXFWfKF17Ww1kGrg_yoWxCwc_ua
	yrWa1DC34xZFWkKFn3KF18KrWvqa1jk34DKw4a9w45JF95AayrGFW8Kry5Zw15u3yDC34D
	WasrXa1qka1UujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbo7K7UUUUU==
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiNg-aQGj-Fu9eXwAA3M

On Mon, Oct 20, 2025 at 03:21:51PM +0200, Frieder Schrempf wrote:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> The VBUS supply regulator is currently assigned to the PHY node.
> This causes the VBUS to be always on, even when the controller
> needs to be switched to peripheral mode.
> 
> Fix the OTG role switching by adding a connector node and moving
> the VBUS supply regulator to that node. This way the VBUS gets
> correctly switched according to the current role.
> 
> Fixes: 827c007db5f2 ("arm64: dts: Add support for Kontron OSM-S i.MX8MP SoM and BL carrier board")
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>

Applied, thanks!


