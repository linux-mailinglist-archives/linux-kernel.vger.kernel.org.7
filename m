Return-Path: <linux-kernel+bounces-811171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB786B52535
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 02:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E818C1C21BEB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 00:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0EE1DED63;
	Thu, 11 Sep 2025 00:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="USDNm4tN"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E642C17D2;
	Thu, 11 Sep 2025 00:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757552111; cv=none; b=nGc7ZW5HaYTn2IX43quVuG7ErrmVRatQTdjvNX3CKWOQBwO/b0UH6np9GxZFi24iwf2BbLTvtY7I9Bm+984avTmusLlBe47cAfgDEYXLs8aRxSL2hqF+1mmlUntDmktDwvZj1LjFktf9Uvrd0u8UflCFvW6P59EfMgoEXV7KBYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757552111; c=relaxed/simple;
	bh=lZzCS+MeXaNofG/AVijdQBYuo0tukXfrPem+nM3WxZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lYT0btTPuV0dHkX7YbJJ+vnkcU6AAieb1UNqSCUCp+hgoD7ft4Y5h1xZOO/0E3gU7qDS8o4kryGa+vBt1OiWOIPheMwjqbl5bX3kTYMjyjwX35lB9wKFhN4LK34elb+OfQHGzLtAhcgA/9gUcTDKpNksz9odNX/qTDKzi+0P7L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=USDNm4tN; arc=none smtp.client-ip=1.95.21.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=VWNzekpPLwPTQVybzuyW2DHLqEF96+Dlyy5rNIWbA7o=;
	b=USDNm4tNkU2k64S9XzIbZLGDzVIk/XC/RsjSRoSgD+c3gEduwW9DX55lUZQHyA
	L7y6RVcSz/gQaAE67AWdTUdElPAgD7yA0CmulF/oyjOWRqruFciH0Swpmn2jbcPJ
	pqWimNutWW7FyJzXMfA23UfhFa//WTCZhcZvgFhkQ31iI=
Received: from dragon (unknown [])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgB3b7rOHcJoCbFNBA--.8694S3;
	Thu, 11 Sep 2025 08:54:40 +0800 (CST)
Date: Thu, 11 Sep 2025 08:54:38 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: imx8mp: add interconnect for lcdif-hdmi
Message-ID: <aMIdzu2eLMXk_OLp@dragon>
References: <20250821160137.108735-1-m.felsch@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821160137.108735-1-m.felsch@pengutronix.de>
X-CM-TRANSID:Mc8vCgB3b7rOHcJoCbFNBA--.8694S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUOksqUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiNxBGq2jCHdDDJgAA3I

On Thu, Aug 21, 2025 at 06:01:37PM +0200, Marco Felsch wrote:
> Add the missing interconnect for the lcdif-hdmi.
> 
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>

Applied, thanks!


