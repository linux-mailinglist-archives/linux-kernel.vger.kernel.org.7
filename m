Return-Path: <linux-kernel+bounces-721735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 250C1AFCD3C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 16:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2916F172199
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 14:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5013217B402;
	Tue,  8 Jul 2025 14:18:14 +0000 (UTC)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FF32BEC28;
	Tue,  8 Jul 2025 14:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751984293; cv=none; b=shTZ13k+LsQo/d6D37o1oC3KEQxgZnUeI3a+W8LAxvnTmtt73zkPgBJ7a+agxNWY6nBn1Ya8GRnQp4QVhr3MdCLnrm4pDGBZk6KJJRqI8ibhFT51lDVh5DynKU3JO/usEpxCq14eKLJ/FiJ+/3nJI53yT63+s7cXhz0yHXOss3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751984293; c=relaxed/simple;
	bh=mBmRhIHUhdY6n86n8Ks5H5tBcLO3k6zSAihKEwFoLDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FY/qNvyqDLslRPiWhV+fStygklODfje6dsqM53nWD8OiRSTXHAvFNO9cqxN7NnFmA1I1gwqk9HwD9kAGCViBjmxbSY8rR7MNM6i8SA9t2uQmyqJ+USBFMAZhyiWL4o+guV91s6AOnfAXwN6jtIo+E+wDmiYi/x/x5v8aBagH4/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from ofsar (unknown [116.232.48.207])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 624E1340ED3;
	Tue, 08 Jul 2025 14:18:04 +0000 (UTC)
From: Yixun Lan <dlan@gentoo.org>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	p.zabel@pengutronix.de,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	Alex Elder <elder@riscstar.com>
Cc: Yixun Lan <dlan@gentoo.org>,
	heylenay@4d2.org,
	inochiama@outlook.com,
	guodong@riscstar.com,
	devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org,
	spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v12 0/6] reset: spacemit: add K1 reset support
Date: Tue,  8 Jul 2025 22:17:56 +0800
Message-ID: <175198407740.45243.8546777031638869570.b4-ty@gentoo.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250702113709.291748-1-elder@riscstar.com>
References: <20250702113709.291748-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 02 Jul 2025 06:37:02 -0500, Alex Elder wrote:
> This series adds reset controller support for the SpacemiT K1 SoC.
> A SpacemiT reset controller is implemented as an auxiliary device
> associated with a clock controller (CCU).  A new header file
> holds definitions used by both the clock and reset drivers.
> 
> The only change in this version is that three of the the four resets
> associated with each PCIe port have been renamed, to align better
> with their corresponding clocks.  This affects patches 1 and 5.
> For example, for PCIe port 0:
> 
> [...]

Applied, thanks!

[1/6] dt-bindings: soc: spacemit: define spacemit,k1-ccu resets
      https://github.com/spacemit-com/linux/commit/25a59e813cd2ca728047f657d64f9b29480be393
[2/6] soc: spacemit: create a header for clock/reset registers
      https://github.com/spacemit-com/linux/commit/bf6239ddaa6a73a44cd8ea3afec5fc82ed900038
[3/6] clk: spacemit: set up reset auxiliary devices
      https://github.com/spacemit-com/linux/commit/988543522ebd6a9af53c288833503f0501e401b0
[4/6] clk: spacemit: define three reset-only CCUs
      https://github.com/spacemit-com/linux/commit/024b84f661674dcfa1341c90ce654c485c4ab756
[5/6] reset: spacemit: add support for SpacemiT CCU resets
      https://github.com/spacemit-com/linux/commit/c479d7cf06c3d65532442fa368b058e05dbba1a2

Best regards,
-- 
Yixun Lan


