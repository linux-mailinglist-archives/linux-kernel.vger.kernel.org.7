Return-Path: <linux-kernel+bounces-727202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E8B5B0165E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 10:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4DFF766CC3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 08:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8293E218EB7;
	Fri, 11 Jul 2025 08:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="mKdXnCiZ"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3455C2E371A
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 08:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752222807; cv=none; b=COSegxYHT643RnDJEIEL56QhK7iEMwUH8b/SEgy21vg8KZl+uywS7fagmStIFQXs8xvK8gooLK66jgFoBGkkYvdUU2QPeAWLEVLeGolaVmox8ewbpYartpwz3MAy1MqDgn0Kj6kg2pka77KlNVumzSUTosGSlE20vaoBKpXxyOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752222807; c=relaxed/simple;
	bh=uHGMJA07ypF8Yz/ePKoO231Z6ORtct0fOPIuQmrfRBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bCiWs7dkRiz25p3+DAUdmrLNH8q3SL2dcxTvKyQRS9rITRlIOzJuF+WWkjWxjNB4g5EHGpHvmLaPFyxNdOFCqoogeHd+9nuOqZn0NzLQ9wRuAnEN5jXcfPsK1jS20QuRL3e6pTw417NxpECcckwH+dzjY7ZX6WHltoyG5ndOtj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=mKdXnCiZ; arc=none smtp.client-ip=220.197.32.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=8Y8yX5xQMywwx2BGoeeybXxG1RrCPIPIZg9LEWNi+Ro=;
	b=mKdXnCiZUf47xRIbDuBBOxjfsin0f++eakr7LNJiHSWmspHUYDLbebDA0qS/kL
	RbCf5oo/221nhX+1BHS8NfcT0SFBIuLno0YnufWl1otMcqUaXj6lSblWPEkqCdNs
	RhgMy6gZfj1MA3zVputyRAp2JE4ylScqYni8SogkboY04=
Received: from dragon (unknown [])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgDXTwYnzHBog9pTAA--.57224S3;
	Fri, 11 Jul 2025 16:32:41 +0800 (CST)
Date: Fri, 11 Jul 2025 16:32:39 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Mark Brown <broonie@kernel.org>, Fabio Estevam <festevam@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: Re: [PATCH 1/2] bus: imx-aipstz: allow creating pdevs for child buses
Message-ID: <aHDMJ2U6H88uN6ow@dragon>
References: <20250707234628.164151-1-laurentiumihalcea111@gmail.com>
 <20250707234628.164151-2-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707234628.164151-2-laurentiumihalcea111@gmail.com>
X-CM-TRANSID:Ms8vCgDXTwYnzHBog9pTAA--.57224S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7XFWfur4xXF13Gr48GF4xXrb_yoWkurgE9r
	10qFWkCr1rKwn3K3Zayr13urW093yUZFZ8Jr4vqrZIqa43tr9rJrs09r93ZF1UuFs7ZryU
	Jwnrtw4Y9r45ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8HUDJUUUUU==
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiBBmHZWhwjvrM-wAAsg

On Mon, Jul 07, 2025 at 07:46:27PM -0400, Laurentiu Mihalcea wrote:
> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> 
> devm_of_platform_populate() passes a NULL as the bus OF match table
> to the underlying of_platform_populate(), meaning child bus devices
> of the AIPSTZ bridge will not have its children devices created. Since
> some SoCs (e.g. i.MX8MP) use this particular setup (e.g. SPBA bus, which
> is a child of AIPSTZ5 and has multiple child nodes), the driver needs to
> support it.
> 
> Therefore, replace devm_of_platform_populate() with of_platform_populate()
> and pass a reference to the bus OF match table to it. For now, the only
> possible child buses are simple buses.
> 
> Since the usage of devres is dropped, the complementary operation of
> of_platform_populate() needs to be called during the driver's removal.
> 
> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> Fixes: 796cba2dd4d9 ("bus: add driver for IMX AIPSTZ bridge")
> Reported-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> Closes: https://lore.kernel.org/lkml/5029548.31r3eYUQgx@steina-w/#t

Applied this one, thanks!


