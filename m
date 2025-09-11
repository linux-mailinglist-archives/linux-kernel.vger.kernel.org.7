Return-Path: <linux-kernel+bounces-811237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA9DB52650
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 04:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76DA11BC7AA3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 02:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42FE523A9A8;
	Thu, 11 Sep 2025 02:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="WHdHDVBE"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E649322688C;
	Thu, 11 Sep 2025 02:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757556812; cv=none; b=LBFBSWZ7D7XYUlP6+pFOiO9M3JFiqcLeQ0SZbBWFdHxbIH77xyiJTLSh+FW3fL1vUiYy7bQQUtJ8P/VU6GzKx39p1AwLDUTRwUEEFKLCwmUsgf8SmW4jH1irg3IYFHV4e8MIC9Ev2cgvftABPvVea4r+Wa3sZYYJZRbz/PiRdLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757556812; c=relaxed/simple;
	bh=3R0IfSXCM5JxJLz9PDkMt8H5vrcJv/yrzZqyo3kd8t0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i424G5CQrV5wD3Dmg8ZnlM+ks5GbhC9HceMMB/m4moBVYIoSuYdfovQ2Xqvluwtlkjj9BHQEtdXigsxRj8sEfHZB9waUSqQ/tEZMv+q5ARzbXjPcaxbN5psB8iIrLhX5FuEmuX62QUTtWoV13eQuOWvnYR3fZ/1csq/TgFSo3uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=WHdHDVBE; arc=none smtp.client-ip=1.95.21.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=+kbZIg2zkqWzaa4TZTIFqXZU2NxqBThBQSS8aPSbuJA=;
	b=WHdHDVBE+Qa6rifrjy7uSUzeXvCiFBGCLwSsfxxtlL4cCJ8zegvgtrdTj4+OaA
	8Kg8SPZEhx7Gn3MR2jGyjVHjW0jUQLj3rDXQXYERdCLZ8sqgcx1/gcj1mQPiSOGF
	h09ZW+PF1m6tqZMHykC34U7yoW5meKo6Gda6MHgbreyU0=
Received: from dragon (unknown [])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgDnjyQvMMJo_8tfBA--.20024S3;
	Thu, 11 Sep 2025 10:13:04 +0800 (CST)
Date: Thu, 11 Sep 2025 10:13:02 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Josua Mayer <josua@solid-run.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] arm64: dts: lx2160a-cex7/lx2160a-clearfog-cx: add
 missing descriptions
Message-ID: <aMIwLoRSFQR61UU-@dragon>
References: <20250825-lx2160-clearfog-omissions-v1-0-e3a28c0ea55f@solid-run.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825-lx2160-clearfog-omissions-v1-0-e3a28c0ea55f@solid-run.com>
X-CM-TRANSID:Ms8vCgDnjyQvMMJo_8tfBA--.20024S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU0rWrDUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiBBTFZWjCB7liYQAAsn

On Mon, Aug 25, 2025 at 08:00:54PM +0200, Josua Mayer wrote:
> Josua Mayer (2):
>       arm64: dts: lx2160a-cex7: add interrupts for rtc and ethernet phy
>       arm64: dts: lx2160a-clearfog-itx: enable pcie nodes for x4 and x8 slots

Applied both, thanks!


