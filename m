Return-Path: <linux-kernel+bounces-781042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B9FB30CB2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 05:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7630C1CE2B82
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 03:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0AE28C5BE;
	Fri, 22 Aug 2025 03:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="TwkOHTzk"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396A41C69D;
	Fri, 22 Aug 2025 03:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755834106; cv=none; b=KYrgK10KOLluK2RdVD33nTGPcl1jidZeiQRdYQ1tW6ssEyYBV66PvJSCer6ZhPW0GtldXQ9GgQ1GIVgfgNq4Eq3El9mWgS+3sXjf/N3o12YNWGFgt6nVir9bAoF07E926XH0WUlGm6fGUBaPHHOwN/1cDwnNzKRmwjF2XGJCITY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755834106; c=relaxed/simple;
	bh=Q9UfM2/Z4W7gpExMeCt3SaoVnCq/lAFTCJplijh9VIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aUeajM3FKt58fRzoHX/6XTcr6MBptkwDKmy011wjrKNmCUJD2/i6Ccpwlg2kY9f3iy590uFtiCMb+jvvhD6zwTEc+v5oQfgHx7XzedNjHIBznYMzKKBwcOK9SSiMwVfhNSUgkGdlB1zC+M773qJkM9jqQlVXzpb/Lnpvi5anHY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=TwkOHTzk; arc=none smtp.client-ip=220.197.32.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=kmggs7RjLJziF9Jhj9Okr/khr5ZhLBgBneq+FasNT/Q=;
	b=TwkOHTzkXUOQm9WdVDvOaxVO7M7yC6n0AyT63IVL+3LYBbiLpmaZkzFTvW8tK8
	OQaNwmF+OQGCF/BRf7tJB3fUfNPRe/DujglbY044tEI3AxV1joBDdcSgimnqYVWQ
	Xoe0vVN/9lhYkTuqz0Zdffi/9izIV6Ekd75SyDIhNTmGQ=
Received: from dragon (unknown [])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgCnrvbA5qdoifskAw--.6822S3;
	Fri, 22 Aug 2025 11:40:50 +0800 (CST)
Date: Fri, 22 Aug 2025 11:40:48 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Rob Herring <robh@kernel.org>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Matthias Schiffer <matthias.schiffer@tq-group.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux@ew.tq-group.com, Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: arm: add TQMLS1012AL
Message-ID: <aKfmwG55ajC5Q-AC@dragon>
References: <20250725062454.271191-1-alexander.stein@ew.tq-group.com>
 <20250725195628.GA1747130-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725195628.GA1747130-robh@kernel.org>
X-CM-TRANSID:Ms8vCgCnrvbA5qdoifskAw--.6822S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUYJPEUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiNQPtU2in5sMEsgAA3U

On Fri, Jul 25, 2025 at 02:56:28PM -0500, Rob Herring wrote:
> On Fri, Jul 25, 2025 at 08:24:50AM +0200, Alexander Stein wrote:
> > From: Matthias Schiffer <matthias.schiffer@tq-group.com>
> > 
> 
> The subject could use a 'fsl: '.

Fixed it up, and applied both.


