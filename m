Return-Path: <linux-kernel+bounces-860864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CFA9BF12DB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 14:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 270694F496A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 12:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84CB313E27;
	Mon, 20 Oct 2025 12:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="JKAqWX5X"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C319C3128DC;
	Mon, 20 Oct 2025 12:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760963380; cv=none; b=bsdb6E7x6FkI9RjnKAUe6KMD2+qLEvde2jSVRRk6T9V9L9g62RcQqa4w4BQyidiIfwarhA1s9flhemtCFX19102zuQ15m5vAsfl7i+VNunAZWxJ+C9GE12dVFJbFBjVOxs57nXM1PW+WpDi5XwVhQTou8BdoY0CbV+WlZ//0KVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760963380; c=relaxed/simple;
	bh=C5o/D+uvtyWHzdNhyg9IExSHWIVjy3lpGv0CFy/MZk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RDAxd5n/RAXOPI3NdMFHARreFrknetaU5AxLjUdnobKE4vBX8NfBBQG64G/vfPJVRRKPnebyVeNxtyJtkMfxyg2ur3UesixyRZUsWaq4o59VRe7rH4NSGnmrDko+qZpRHxwA1Hsh5SjVnqFmwpNXFL0/MP/iychsNWj6xSJINK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=JKAqWX5X; arc=none smtp.client-ip=1.95.21.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=LJn9fnOUcCS1mQTvgDWkMQL7/Wza3X8Ei2QFf8PWwBE=;
	b=JKAqWX5XH3ilwfNgT/VBxvt0be3Q3kSdPjrNHVAs0shs2gQMEKcmP5j+ymvCCK
	jLmLvzIRBZeu1WmyE/yFMugqDZboC5RCHWFt9twb3C9CvX7bHVDKnAT9Dt9h71Xq
	I8Y8NuNVJvY9jiBzaYGuMDAptqE/SxI1zZBuqv40lhMq0=
Received: from dragon (unknown [])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgCHtQQNK_ZoIc1TAA--.8980S3;
	Mon, 20 Oct 2025 20:29:03 +0800 (CST)
Date: Mon, 20 Oct 2025 20:29:01 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux@ew.tq-group.com,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] arm64: dts: tqma8mpql-mba8mpxl: Add MicIn routing
Message-ID: <aPYrDW1lrlWFKw8X@dragon>
References: <20250916055119.135637-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916055119.135637-1-alexander.stein@ew.tq-group.com>
X-CM-TRANSID:Mc8vCgCHtQQNK_ZoIc1TAA--.8980S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU4knYUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiNg+lC2j2Kw8e1AAA3n

On Tue, Sep 16, 2025 at 07:51:18AM +0200, Alexander Stein wrote:
> MicIn is connected to IN3_L. Add routing including the Mic Bias.
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>

Applied, thanks!


