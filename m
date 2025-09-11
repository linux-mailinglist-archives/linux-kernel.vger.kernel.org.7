Return-Path: <linux-kernel+bounces-811168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C77B52523
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 02:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69B517A578D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 00:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F7F1DED5B;
	Thu, 11 Sep 2025 00:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="eMwmFZ7e"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CBD282F5;
	Thu, 11 Sep 2025 00:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757551818; cv=none; b=I/H60xRI8PUIknDaxKhxYinEmVk5oVecpiSGD6v7+eZXdu3vFQbOiT/RwR3/b6s8rSCpx89NtgiKgYUpROiMU4AFomrXXjdOkMie3gqUjKMDcifXWn6mBczPEIsDLD0unjnmBABA8jKLhpztHeM1hEEL4e/u7iPAlF98ePa5E5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757551818; c=relaxed/simple;
	bh=APrZJGPv+l+iHtKtFVwV1M4sey/ipAgYWtDMsv/WApE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qkI4QBcToum6+9rKXQnoxkqWbn/YDndEWcPQd0dYlWOuQEaFKsbkwE3BaQ8GtHw+nJFRFJu/knAxxMMBlNGRAS3v52oGLMwjoMHCnXx5Uade51Y7YC1psZ2yr2RnbgPLMjLLQxGqiS7CRTkrdCQGmagb9ReRIspJii5A//aqy+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=eMwmFZ7e; arc=none smtp.client-ip=220.197.32.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=e6HRqJKQ35qnhgZrk2aOMpdCfroMKThTD5K3U4AQ0eg=;
	b=eMwmFZ7eTDio4xTLBQVOu0WsaerTWu9389r4tBcwaN+2Fgi41ZMOr4fP10whD9
	OnCZ1HLG+qpChQySgNVXyAa5Sl0LxBlWb/UKHc/aPoZiOq+P7NS3tR5tOzyU0RR2
	uwG1iOzCurK3OCurBwxHmdcmTlgDEYL79DRXGsg6B9gKk=
Received: from dragon (unknown [])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgA3ptuoHMJows1eBA--.50607S3;
	Thu, 11 Sep 2025 08:49:46 +0800 (CST)
Date: Thu, 11 Sep 2025 08:49:44 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Frank Li <Frank.Li@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH v3 0/4] ARM: dts: clean up most ls1021a CHECK_DTB warning
Message-ID: <aMIcqBHl74Lhy6Dp@dragon>
References: <20250822-ls1021a_dts_warning-v3-0-6b611a2f23a4@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822-ls1021a_dts_warning-v3-0-6b611a2f23a4@nxp.com>
X-CM-TRANSID:Ms8vCgA3ptuoHMJows1eBA--.50607S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU1HqcUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiIAr7YWjCHKpThAAA37

On Fri, Aug 22, 2025 at 10:49:57AM -0400, Frank Li wrote:
> Frank Li (4):
>       ARM: dts: ls1021a: Rename node name nor to flash
>       ARM: dts: ls1021a: Rename 'mdio-mux-emi1' to 'mdio-mux@54'
>       ARM: dts: ls1021a: Rename esdhc@1560000 to mmc@1560000
>       ARM: dts: ls1021a-tsn: Remove redundant #address-cells for ethernet-switch@1

Applied all, thanks!


