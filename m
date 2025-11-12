Return-Path: <linux-kernel+bounces-896400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A21C50452
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 03:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 057813A973E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 01:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C442BEC53;
	Wed, 12 Nov 2025 01:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="HLILyDSY"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4982BE7DB;
	Wed, 12 Nov 2025 01:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762912742; cv=none; b=KOi2B9OwqiNTW1h9Pd+4ZqDmqXe6m0eAY8QBKAmGP9u7KT89t1QIxNA37UCaDlFzaCVQGiUfEHRjYpumavPhFKnBULBXZleV9cJIX7iIFWWBov1Wls9c1EyyCibg1cbVgNoWVk7P1NSbXy3kwaaNml5dLwDM9hDiHFhwGDklApQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762912742; c=relaxed/simple;
	bh=APAKyQvFVIBcKOgb0uEOcq1Ddyo8JI5mya0p3PDa9LQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d6OJjGlCIHdJ3IftNZjCnTUn1Oz4EJ6Z1TjO2azugVa6ixDOQGjTDnq7TZBsqHASlwMpzIrsXTMlPR/ZXmx5++ef7T1KyMINovYEISTw+OnhuSfJoc3b+ACuplurxbVJvSeIRbcaku/L8sXo/waqxTIDUcLm4hcLJy5xfl6TxCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=HLILyDSY; arc=none smtp.client-ip=220.197.32.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=APAKyQvFVIBcKOgb0uEOcq1Ddyo8JI5mya0p3PDa9LQ=;
	b=HLILyDSYnDXEUpkIEhUHcKPLevgW3I2zFhuK/HL7Op8/kgiF1TT70cO9sH9gJ8
	P4lmLuTlJrjVrgOthd7OJo8MYTLp/XCKjpUOBxGUV/2/k2yB2VV6CKUHbKopoM2x
	XYuRz4WJ34IO4oXGvWtuL3aHMASNXoZiM5nwMgXPHyVec=
Received: from dragon (unknown [])
	by gzsmtp3 (Coremail) with SMTP id M88vCgAnLZPA6RNpuzvPAQ--.5587S3;
	Wed, 12 Nov 2025 09:58:25 +0800 (CST)
Date: Wed, 12 Nov 2025 09:58:23 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, frank.li@nxp.com, s.hauer@pengutronix.de,
	festevam@gmail.com, kernel@pengutronix.de,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/7] Add vpcie3v3aux regulator for i.MX PCIe M.2
 connector
Message-ID: <aRPpvy2TtCyCCegm@dragon>
References: <20251024073152.902735-1-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024073152.902735-1-hongxing.zhu@nxp.com>
X-CM-TRANSID:M88vCgAnLZPA6RNpuzvPAQ--.5587S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU0EfOUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiNgLJL2kT6cJyogAA3T

On Fri, Oct 24, 2025 at 03:31:45PM +0800, Richard Zhu wrote:
> [PATCH v1 1/7] arm64: dts: imx8dxl-evk: Add vpcie3v3aux regulator for
> [PATCH v1 2/7] arm64: dts: imx8mp-evk: Add vpcie3v3aux regulator for
> [PATCH v1 3/7] arm64: dts: imx8mq-evk: Add vpcie3v3aux regulator for
> [PATCH v1 4/7] arm64: dts: imx8qm-mek: Add vpcie3v3aux regulator for
> [PATCH v1 5/7] arm64: dts: imx8qxp-mek: Add vpcie3v3aux regulator for
> [PATCH v1 6/7] arm64: dts: imx95-15x15-evk: Add vpcie3v3aux regulator
> [PATCH v1 7/7] arm64: dts: imx95-19x19-evk: Add vpcie3v3aux regulator

Applied all, thanks!


