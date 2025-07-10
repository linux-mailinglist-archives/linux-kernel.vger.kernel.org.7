Return-Path: <linux-kernel+bounces-725353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97183AFFDF8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 11:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FC274831CE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 09:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E572D2980CD;
	Thu, 10 Jul 2025 09:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="ArHXbaU/"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB23294A06;
	Thu, 10 Jul 2025 09:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752139324; cv=none; b=NFKWGjooQS3tR8LWkfyOszjA7w9Im6PmQLgN5e1jKL6MTVnQWu/r/rQKMkpfUlCu90iJ7U4b5E96SHKiVtGOaTnRysxlHXAStWUDb6rwVdUUzgqRmm3dYNhjnmBbDRkKTxAIvDjdPUox098Er8dABFKrvWe7n3h8+e7UBOT0Cjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752139324; c=relaxed/simple;
	bh=8jv9si5Dm29nc6cOMexjPtTBEsERysb0Yr5v4WL1nzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XPNszIwOfDHE7dgxZ4u0hSraCPYXh2Hd2LGAwGwoEOJSXGeqI7cTZsZW1L190Iq6ucHI1MsdGeuXx3LY/OfHae2ExKIdHhGdJMiYHLCTWpr2etId8m4Wz/yj36uXCJB6qJeJ8x+plVx0qhpjGm8rdsZDVMJunfc7o8IJDNO44Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=ArHXbaU/; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 9AC5620E4F;
	Thu, 10 Jul 2025 11:21:55 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jVRQWH_OPQYW; Thu, 10 Jul 2025 11:21:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1752139314; bh=8jv9si5Dm29nc6cOMexjPtTBEsERysb0Yr5v4WL1nzo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ArHXbaU/7hmjWGqDFqA9UhVGwP8lArLw26t0gSveZ6cI7JqQd1CQ+apBUBAhlK3E9
	 l1EHwYOI68jWpY2MtcJp93hAaKjp770fz9FxUz7VGLGhNwSZ7RTJQjK80DG0BET+jw
	 dbpWJQg3oAJuG4FtiOI+GzqlnK3S9jB2hmM1DgdBnQZIsvWsRHkVlSb8F1MiKBV2Tq
	 5iC7G7RMMv6y2Eqhx+KxzOFGrBrgxnj+fHXMPRKbeQFcZFFmRcKk8ixSCalaw5V5o3
	 JJRoGz8BWaesCGy4GrFLsJYczK/Crme0E7QFHds06iifIIJs5014suMrYxc1eK9LIq
	 Z3hGJHFT8YE1w==
From: Yao Zi <ziyao@disroot.org>
To: Drew Fustini <fustini@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Jisheng Zhang <jszhang@kernel.org>,
	Yangtao Li <frank.li@vivo.com>
Cc: linux-riscv@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yao Zi <ziyao@disroot.org>
Subject: [PATCH v2 1/2] clk: thead: th1520-ap: Correctly refer the parent of osc_12m
Date: Thu, 10 Jul 2025 09:21:34 +0000
Message-ID: <20250710092135.61049-2-ziyao@disroot.org>
In-Reply-To: <20250710092135.61049-1-ziyao@disroot.org>
References: <20250710092135.61049-1-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "osc_12m" fixed factor clock refers the external oscillator by
setting clk_parent_data.fw_name to osc_24m, which is obviously wrong
since no clock-names property is allowed for compatible
thead,th1520-clk-ap.

Refer the oscillator as parent by index instead.

Fixes: ae81b69fd2b1 ("clk: thead: Add support for T-Head TH1520 AP_SUBSYS clocks")
Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 drivers/clk/thead/clk-th1520-ap.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/thead/clk-th1520-ap.c b/drivers/clk/thead/clk-th1520-ap.c
index ebfb1d59401d..42feb4bb6329 100644
--- a/drivers/clk/thead/clk-th1520-ap.c
+++ b/drivers/clk/thead/clk-th1520-ap.c
@@ -582,7 +582,14 @@ static const struct clk_parent_data peri2sys_apb_pclk_pd[] = {
 	{ .hw = &peri2sys_apb_pclk.common.hw }
 };
 
-static CLK_FIXED_FACTOR_FW_NAME(osc12m_clk, "osc_12m", "osc_24m", 2, 1, 0);
+static struct clk_fixed_factor osc12m_clk = {
+	.div		= 2,
+	.mult		= 1,
+	.hw.init	= CLK_HW_INIT_PARENTS_DATA("osc_12m",
+						   osc_24m_clk,
+						   &clk_fixed_factor_ops,
+						   0),
+};
 
 static const char * const out_parents[] = { "osc_24m", "osc_12m" };
 
-- 
2.50.0


