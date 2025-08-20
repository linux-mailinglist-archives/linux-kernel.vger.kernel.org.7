Return-Path: <linux-kernel+bounces-776855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4506B2D22C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 05:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D19781C229EC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 02:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600B22185AA;
	Wed, 20 Aug 2025 02:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="pOPwXL3E"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1493239E61;
	Wed, 20 Aug 2025 02:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755658762; cv=none; b=o+55+zG6flWHKm7n7E18ljzeQog+oMrM5mBHnBMqqUtR7auQulwj1soNVcToZO1UzqhhXZwOm9CShZJgShQTC6ROsLRJf04cUus+L/Aki1gCvF1mKGb+t/r9HFWF6wsQkq1B0pk/kml2vqDscC9X2CagasTsZNJ2P5cl9T8e/OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755658762; c=relaxed/simple;
	bh=SuvMZPXVoAnqidhK37kJ3/oPrLPh3Axcg+AGIQaJlBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kp9Uf/VqlTabyVbbOCnpg98X2/TqFMOknnYg3QgjIkjweME8P+Fcc3ewi3IpCJpiSiRMKpHTLTrHIW9nhZp7Jzh0fzgpZDouzhw8wlx5TNZviGqizG/X1u1p4jPfg/yKzsLiwHSD6Mugfc+fubG1DzWZEIu8owG5rLnMSFac68A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=pOPwXL3E; arc=none smtp.client-ip=220.197.32.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=Yc5lcecJxiwtEE0Af0MunMTBMcGQkaxRIJrARkZNSok=;
	b=pOPwXL3EiV0xsVgk5GMwiUrF18UOtPsIYMTTDufGQvrwpO+ImuAYaoHQs60lhN
	cZ4I6h/ejWc7/EDsrOzfzZAwbyfx5BE1//FyVL/t46DpS72v9+/WDM4lnAFuvKFQ
	PDCfPzNtq21PYS/4PSJLJs1tIgukvOMiVEU4p1np/B1So=
Received: from dragon (unknown [])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgD3t9tDN6VoS0n+Ag--.60563S3;
	Wed, 20 Aug 2025 10:47:33 +0800 (CST)
Date: Wed, 20 Aug 2025 10:47:31 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Mark Brown <broonie@kernel.org>,
	Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>, Frank Li <Frank.Li@nxp.com>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 4/6] arm64: dts: imx8mp: convert 'aips5' to 'aipstz5'
Message-ID: <aKU3Q69B_MFswwZX@dragon>
References: <20250610160152.1113930-1-laurentiumihalcea111@gmail.com>
 <20250610160152.1113930-5-laurentiumihalcea111@gmail.com>
 <aHDNmVE23O4V4rqJ@dragon>
 <69f6a044-be90-490f-b0ad-e7867a4825da@gmail.com>
 <59b874bf-e23b-40c4-b095-016fe6b14ed6@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59b874bf-e23b-40c4-b095-016fe6b14ed6@sirena.org.uk>
X-CM-TRANSID:Mc8vCgD3t9tDN6VoS0n+Ag--.60563S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrtw47Zw47tw4UtFWrtrWxCrg_yoWxZFg_Xr
	WjqrZF9rn8XrsxGF4fZF45tFy7KFW8Z3s5urWrXr1UZ3yYqF93JFZagFZ3Xw1xJrWIkFsI
	9as8G343tr4IvjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjgyCJUUUUU==
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiIQVix2ilN0Uc-gAA3c

On Fri, Aug 01, 2025 at 01:55:47PM +0100, Mark Brown wrote:
> On Fri, Aug 01, 2025 at 03:36:01PM +0300, Laurentiu Mihalcea wrote:
> 
> > How should we proceed with this? The fix for the issue reported by Alexander
> > Stein was already picked up by Shawn via [1]. We also have [2], which is meant
> > to fix the Verdin issues pointed out by Mark. However, I'm still unsure about the
> > EVK issues reported by Mark, which I was not able to reproduce on my local setup.
> 
> FWIW the EVK issues are still present in -next.

It sounds like that EVK issue is a separate one and has nothing to do
with this patch set.

Laurentiu,

I suggest you resend the dropped patches with defconfig fix in a
new series.

Shawn


