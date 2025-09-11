Return-Path: <linux-kernel+bounces-811258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4369DB52690
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 04:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B0141C804CE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 02:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29EEA212F98;
	Thu, 11 Sep 2025 02:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="LNUxbfE6"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73017154423;
	Thu, 11 Sep 2025 02:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757558244; cv=none; b=RoWEMVyUSVFYLfgONpNv2PlgbHvIkKDAVytDrCBvolmxPmMxlXxBQOX7eu3jDXa+aGGlCuhGad4+ygCuUCrQI/mDO1OVXjm7ZV4auVgfaNju883KyFUqYBDqOc9NpJlAHzLFR7twtkoy3FLJwNIXUdbuYoC7fS28c01beEi+xXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757558244; c=relaxed/simple;
	bh=fZnQdAvO46ck0hoeOgRAeVwDLANdJVf4Jk/B6m+N1PU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tR7CqF2DOq+68BeU0y7ldVCOL7YUZDBBEbm9Vuan775KN4wPFiQP/HqU7Yoe/kybLft5G78MtvYHmYk0noD+HI+b1kNx9oPB85j/21p8yvxHTFi3DyCIjqmFK1tZI5V7uWNPjmIY+GDeYP7r7QOYcwHCbYKNRDgxAZnq5ON0zuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=LNUxbfE6; arc=none smtp.client-ip=1.95.21.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=Zu/ILIakLLn37rYFw5PvXVXf22PCnsMSBiyyFDARzl8=;
	b=LNUxbfE6VV4SLAXXaUc2enyKWX3CzNsQeTquFa24c/YqA3DtbIWaWxSlZL2QTY
	j6r6RKdmhYJgOsiVLuvuKFbEgPyZaPGWzN61nCOmjZfyZ0X5u7dwNL1V0cjh+Lae
	eI51un27bmcSFLxOLoGJoerqTZZUZrqziKt9H752u3gjk=
Received: from dragon (unknown [])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgDnX_mnNcJo1g9gBA--.44535S3;
	Thu, 11 Sep 2025 10:36:25 +0800 (CST)
Date: Thu, 11 Sep 2025 10:36:22 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Chester Lin <chester62515@gmail.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
	NXP S32 Linux Team <s32@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linaro-s32@linaro.org
Subject: Re: [PATCH v3 3/3] arm64: dts: s32g: Add device tree information for
 the OCOTP driver
Message-ID: <aMI1pidrSAIAwab9@dragon>
References: <cover.1756800543.git.dan.carpenter@linaro.org>
 <7877e1958fa92df92b2b5229365c86493c620c8c.1756800543.git.dan.carpenter@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7877e1958fa92df92b2b5229365c86493c620c8c.1756800543.git.dan.carpenter@linaro.org>
X-CM-TRANSID:Ms8vCgDnX_mnNcJo1g9gBA--.44535S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUzcTmUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiNAlCp2jCNanx7wAA3w

On Tue, Sep 02, 2025 at 12:47:57PM +0300, Dan Carpenter wrote:
> Add the device tree information for the S32G On Chip One-Time
> Programmable Controller (OCOTP) chip.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

It doesn't apply to imx/dt64 branch.  Could you rebase?

Shawn


