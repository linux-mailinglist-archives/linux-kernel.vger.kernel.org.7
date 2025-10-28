Return-Path: <linux-kernel+bounces-874330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7B2C16141
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 18:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5E7F420483
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15179346E69;
	Tue, 28 Oct 2025 17:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GAc4R7Rr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660F87081E;
	Tue, 28 Oct 2025 17:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761671135; cv=none; b=G5/ZJ4Q6XrPwn4RquQ0EjeCX+Zx2Vxef47ExoCSV+qDdV4YKPtpamkiMYS6viTp4devQAso6MZB/PeCFC4OVA6bmLHy3imxeRAdij94/Z3Q5jX0GP/3nKdgrC9zBSNC7V+b/IXCevIKCN2bSE82S86wOvHRch795cvKJCTMbfJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761671135; c=relaxed/simple;
	bh=oL0rXXmMHbcR3EvMkdJ0IKxdFjgk39YWymPhTwNMDgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GUYuObwHAo7hCum6Xh+dZkNXf8yCmJn/pHDjfco3GuViCmvnFL9riRNAWsXcdcMtN0a8qWKraNqxJBlWuHJ+ARD058M3OKYjQmjunm1ROT5OXb5YX5wSJqpSJQZEaZP65aLyWz3YmU6MOawZNGi4CIz66+p8TPpBdDt2aSG0SOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GAc4R7Rr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0592C4CEE7;
	Tue, 28 Oct 2025 17:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761671134;
	bh=oL0rXXmMHbcR3EvMkdJ0IKxdFjgk39YWymPhTwNMDgw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GAc4R7RrcicVl5PeahubF+TfLli3xATxMXRSgNiesCP4FlAu9VGhv4daehI46gO3t
	 YdHl4NcawireCvk/sBo4Azw3sJfkZADoxK7hWgThsdwGxQv0LWx37SyEnoFJXQnFkc
	 fg+aaheIUkRocD6+64eu7paqvkKQ/DSpVWcEiTuJElMCyfGc2LiclFQDx+zdVYqojG
	 anSZI/vwWlsw3nc1UUGe3i9AKZ5Ft4y514OUiwYDcbSXE2I9ALHWxC1Q4sd7rB8FvQ
	 jv7/p0goh4MSQI0HzGXw0pyIkbio0QbHKE8itMZ7ybLs90DcIHeYH/iNvG5rpkGqxU
	 DHXj6ifX+xy5A==
Received: by wens.tw (Postfix, from userid 1000)
	id D9CDC5FCB3; Wed, 29 Oct 2025 01:05:31 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Richard Genoud <richard.genoud@bootlin.com>
Cc: Chen-Yu Tsai <wens@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Wentao Liang <vulab@iscas.ac.cn>,
	Johan Hovold <johan@kernel.org>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-mtd@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v4 00/16] Introduce Allwinner H6/H616 NAND controller support
Date: Wed, 29 Oct 2025 01:05:29 +0800
Message-ID: <176167109288.1159653.8613197052957076565.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251028073534.526992-1-richard.genoud@bootlin.com>
References: <20251028073534.526992-1-richard.genoud@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 28 Oct 2025 08:34:53 +0100, Richard Genoud wrote:
> This patch series introduce H6/H616 NAND controller support (but not yet
> the DMA/MDMA part).
> 
> All the work was done on a H616 board with a Kioxia TC58NVG1S3HTA00 NAND
> chip.
> ECC is supported, as well as scrambling.
> 
> [...]

Applied to sunxi/dt-for-6.19 in local tree, thanks!

[16/16] arm64: dts: allwinner: h616: add NAND controller
        commit: f55a2526317aca8ecc1b21b346dbdebbc6aad97d

I also fixed up alignment of the clocks property in the nand-controller
node.

Best regards,
-- 
Chen-Yu Tsai <wens@kernel.org>

