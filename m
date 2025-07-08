Return-Path: <linux-kernel+bounces-721726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90497AFCD21
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 16:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 459EC189613E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 14:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A022DFA20;
	Tue,  8 Jul 2025 14:14:07 +0000 (UTC)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F467EEA8;
	Tue,  8 Jul 2025 14:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751984046; cv=none; b=feMYVYzFMxu0YnLMvWcXR4TawGUCdDiFyT2FWz1ZPGQS23bCTX2ypBoB1Jfh1VGUVWqHUH6mm6j2NzIlvwiolVtKYnOahtPlGOCQwbo/lkkAtOvzxaKvDvdUCMEcZjzmG49gNfV/6vDBeD8Gtf4C3rqJc6IkAD6H2kjBlZO4QLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751984046; c=relaxed/simple;
	bh=+3hyckLp0sAyzw4/lXidGfAC/QfKjCEo4pECdj/xYsg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D6FKQ4VxiYCmhEhfqMm9D6OXrInzBzhqwxQF+AylNBQotmlVH/AOU0HWn7Oj+EhvZZ6pv/5WR0EX60SxRif1nU2QVT7ENvY5uaBSgWAN134XzkcfjfNSUBILZ2Q6ZyFH2P86slqClh9d485/OINcf+E0mKLvIA447rsQsFZw+tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from ofsar (unknown [116.232.48.207])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 2077F341083;
	Tue, 08 Jul 2025 14:14:00 +0000 (UTC)
From: Yixun Lan <dlan@gentoo.org>
To: mturquette@baylibre.com,
	sboyd@kernel.org,
	Alex Elder <elder@riscstar.com>
Cc: Yixun Lan <dlan@gentoo.org>,
	heylenay@4d2.org,
	inochiama@outlook.com,
	guodong@riscstar.com,
	linux-clk@vger.kernel.org,
	spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] clk: spacemit: mark K1 pll1_d8 as critical
Date: Tue,  8 Jul 2025 22:13:35 +0800
Message-ID: <175198385024.26233.3929868919272228663.b4-ty@gentoo.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250612224856.1105924-1-elder@riscstar.com>
References: <20250612224856.1105924-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 12 Jun 2025 17:48:55 -0500, Alex Elder wrote:
> The pll1_d8 clock is enabled by the boot loader, and is ultimately a
> parent for numerous clocks, including those used by APB and AXI buses.
> Guodong Xu discovered that this clock got disabled while responding to
> getting -EPROBE_DEFER when requesting a reset controller.
> 
> The needed clock (CLK_DMA, along with its parents) had already been
> enabled.  To respond to the probe deferral return, the CLK_DMA clock
> was disabled, and this led to parent clocks also reducing their enable
> count.  When the enable count for pll1_d8 was decremented it became 0,
> which caused it to be disabled.  This led to a system hang.
> 
> [...]

Applied, thanks!

[1/1] clk: spacemit: mark K1 pll1_d8 as critical
      https://github.com/spacemit-com/linux/commit/7554729de27daf6d54bcf8689d863bbe267828bf

Best regards,
-- 
Yixun Lan


