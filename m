Return-Path: <linux-kernel+bounces-780994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBAEAB30C0A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 04:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4971189CCAF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 02:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB8F222590;
	Fri, 22 Aug 2025 02:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="IuSm+NfM"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC8F393DC6;
	Fri, 22 Aug 2025 02:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755831074; cv=none; b=LGt5GGd+Dr+Jkkj+vy1j9v9PkuyNFhqC/zUNeqt8oi7T/epQy6XB99kwgNW0k0BCILXlZ25Xl3pasGM0Czc8OIdteZN49BmW1574j1DFP5Mg49D4OL56m7Q2Jmrodo37V/A4AMdkIHnhvBjWOiTLoAEEwswiif+41HoNGaZ1Mb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755831074; c=relaxed/simple;
	bh=eaXzGANZJk1iNS3eKCdwnCxE9uul3j+htGiO2OfEgAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=St5UmTlWbmW4WCST3R5NiQBz560spCUU3yWGSSFpc9kqy+FI7d10QlSmACgyV0WljA1QKcJLO6GGMmkLpRGsk+7M49KW8obAIDUICfwVXTUZXpfeY7PP79T0W9nJFpZ47/8EJCM3w0SY+iWBAkmf9oBYP3KJzbgLLR9eNtgXn/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=IuSm+NfM; arc=none smtp.client-ip=220.197.32.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=ZAs9F+xYu7ciu6YOpuijDXXwLkud1o/P82ldiFiTdzE=;
	b=IuSm+NfMl5Q3anJ+COm7Un2utOP989WB8doyEr7JPC5HtiLHVDF7ErEk9Udgib
	O6RN+nTBw6Mld0EXbV5s+PLfOlw70zEsQeoa3owb95+/Gs5bEXThNlA2FBmCzllW
	tF7pI6EYZuJtQ21IHhItllg9zmSrycMAxlmOqpqxL7U4k=
Received: from dragon (unknown [])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgD3Zdvx2qdogHskAw--.15069S3;
	Fri, 22 Aug 2025 10:50:27 +0800 (CST)
Date: Fri, 22 Aug 2025 10:50:25 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	shengjiu.wang@gmail.com
Subject: Re: [PATCH v3 0/3] arm64: dts: imx8m: support more sample rates
Message-ID: <aKfa8eHje2642O9r@dragon>
References: <20250815102317.910014-1-shengjiu.wang@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815102317.910014-1-shengjiu.wang@nxp.com>
X-CM-TRANSID:Ms8vCgD3Zdvx2qdogHskAw--.15069S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUwmiiUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiNxP2XGin2vOYNgAA3G

On Fri, Aug 15, 2025 at 06:23:14PM +0800, Shengjiu Wang wrote:
> Shengjiu Wang (3):
>   arm64: dts: imx8mm-evk: support more sample rates for wm8524 card
>   arm64: dts: imx8mq-evk: support more sample rates for wm8524 card
>   arm64: dts: imx8mn-evk: support more sample rates for wm8524 card

Applied all, thanks!


