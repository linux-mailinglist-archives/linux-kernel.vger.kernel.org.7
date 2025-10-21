Return-Path: <linux-kernel+bounces-862418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 060EEBF53BB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 10:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8FEA3B0FBA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 08:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8824D302766;
	Tue, 21 Oct 2025 08:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="ZU0zSUKV"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906F226E71C;
	Tue, 21 Oct 2025 08:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761035444; cv=none; b=aElZbMujfUVf0fcGp00jiMQ16R5Qa6Muebkoz4Kj1WVG7a7ppz7UgugJg6U8fCNIR0eLOqWAbYqiHHBPBDiFiWbcBAzMekOEO7g3CR7ZJ61wk6zQBhPwGiTmrNzIZCRbM4xQtwDtxEKYdba9+ADaBTLbv8xQ0tNHBOmtXRlEXJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761035444; c=relaxed/simple;
	bh=RpIVLJ6D2Dmnv+Buq0ci+vreKvYO2FnvqES5Im31dMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ubct8DaqGIUdwK9lI80VBvrUOegT8kGfKOkYqQUlMvbzUL0QWrZgoOTFxIF6aIRwvfhyb5bb1sxiOXm87z4fZbpXJG9JdoVhtU1E8BMLffV4B1jIyDCYQ+7gZg6Gu68+nU4YBwcdTB+CSw4wLiAByuGwqOUR+dktmvuIN/JSdAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=ZU0zSUKV; arc=none smtp.client-ip=1.95.21.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=VMJOUQmpNHk/jiX02paVM4JctocpFGCuLJbmYhANAlA=;
	b=ZU0zSUKV0Bxoz5ZKaWBVciTCln9AUjCMWCGCZhyoGFTdnCgSvWgPuuzucazuDN
	AMYBLLs1KTnQ3mQ76BK6zvaYhPwmvYfpk5d7z+5HkaKgc8L+X9KrkG9aQQQZyeX/
	xQE3Dlx5n+IH9bxKdeNdjc1IFDonYHFcmM/auw6+RHr/8=
Received: from dragon (unknown [])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgD3H1mIRPdoDG1gAA--.33981S3;
	Tue, 21 Oct 2025 16:30:02 +0800 (CST)
Date: Tue, 21 Oct 2025 16:30:00 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Tim Harvey <tharvey@gateworks.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] various imx8m*-venice dt fixes
Message-ID: <aPdEiMbL2xCeMhP6@dragon>
References: <20250918154451.2531802-1-tharvey@gateworks.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918154451.2531802-1-tharvey@gateworks.com>
X-CM-TRANSID:Ms8vCgD3H1mIRPdoDG1gAA--.33981S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrKw15JFWrJw45Zr48Jr1xAFb_yoW3CFXE9r
	12qFnY9w1UKw4ftw1rtwn0qryqkr1Uur1DWF1xWw4Dtr1fAa4rAr1vv34fXr1qvanxuFs8
	Gr1rX3yrXFW5ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU1D3kJUUUUU==
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiCRftZWj26mT7FQAAso

On Thu, Sep 18, 2025 at 08:44:44AM -0700, Tim Harvey wrote:
> This series contains various imx8m*-venice board dt fixes.
> 
> v2:
>  - add additional info to commit explaining changing TXC slew rate for
>    improved signal quality and emiisions (Peng)
>  - add tags
> 
> Tim Harvey (7):
>   arm64: dts: freescale: imx8mp-venice-gw7905-2x: remove duplicate
>     usdhc1 props
>   arm64: dts: imx8m{m,n,p}-venice: disable unused clk output for TI PHY
>   arm64: dts: imx8mp-venice-gw702x: reduce RGMII CLK drive strength
>   arm64: dts: imx8mm-venice-gw700x: reduce RGMII CLK drive strength
>   arm64: dts: imx8mm-venice-gw72xx: remove unused sdhc1 pinctrl
>   arm64: dts: imx8mp-venice-gw702x: remove off-board uart
>   arm64: dts: imx8mp-venice-gw702x: remove off-board sdhc1

Applied all, thanks!


