Return-Path: <linux-kernel+bounces-725352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C38B5AFFDF4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 11:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F23303B726E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 09:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7485F294A0D;
	Thu, 10 Jul 2025 09:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="B1jj4Udr"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BB7214210;
	Thu, 10 Jul 2025 09:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752139321; cv=none; b=DJuniKjfVQAX76/Xc48iB8pkl8ulofb/o33NCYZalWKcitdpp7hlFoV0/OeK/F6Ma2Ei4HSiwSnfFqgC/4i4aOeU+Y2kodrAR7zGxV/RawQ/moHkHS029qbQP077poJIPPM4+9aGqcoJi5Rt2j28A2OfPUZNf6NklNf0SauZiVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752139321; c=relaxed/simple;
	bh=YWiKfFUpvY0CTSU08o1Vxmml9LYBSTSxuK4Xhb+tbVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Az/1VMJyEoKjaPnMFw5YYdBsWSiaFyxJwSYatu6yeZC0aHUR/54mVYpaJzVjTWbCFUFCEmlgLWtjGWcapXsBy7RruPiwJd5WVeWa3NH5KLm0lX1xRDUTiI9T8nXa6C60LW+FPEYxxebf+VamyW+evJswqo8kxZy4HCqIZYcly9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=B1jj4Udr; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id A3EF120D9B;
	Thu, 10 Jul 2025 11:21:58 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jWSHtPzeUuRu; Thu, 10 Jul 2025 11:21:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1752139318; bh=YWiKfFUpvY0CTSU08o1Vxmml9LYBSTSxuK4Xhb+tbVU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B1jj4Udrnr8mHo8CZcvxkAtHXrp4J7GrDWUcMyH722pC+J30FTb3M3XcKkRlzQ9ga
	 KgICluIXnabEbGFRD7awmtE/6kUJpMHopz5JCkc9CsPn4JTMa+/RMv/t67KQnUp+7I
	 JCVmXnqZMWQe2u/p9IOqblLIivktz//obRGVKbAnNkhcv4CHHF32YKTvpmVJiM1KMD
	 vpHoKOPLFGCTumAVXOM3OUMqSaL40H96vtAo+ck57jAjWBxRArT7/C6docPRKv4nwH
	 r5Ae8gLNXIXo5nM85BBr8+aFmIklItqZBCBfyjMVH3sThyau48MlOAHtsWSTqHdSPn
	 DZznr9sQRHHCA==
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
Subject: [PATCH v2 2/2] clk: thead: th1520-ap: Correctly refer the parent of c910-i0
Date: Thu, 10 Jul 2025 09:21:35 +0000
Message-ID: <20250710092135.61049-3-ziyao@disroot.org>
In-Reply-To: <20250710092135.61049-1-ziyao@disroot.org>
References: <20250710092135.61049-1-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The correct parent of c910, c910-i0, is registered with
devm_clk_hw_register_mux_parent_data_table(), which creates a clk_hw
structure from scratch. But it's assigned as c910's parent by
referring &c910_i0_clk.common.hw, confusing the CCF since this clk_hw
structure is never registered.

Refer c910-i0 by its name instead to avoid turning c910 into an orphan
clock.

Fixes: ae81b69fd2b1 ("clk: thead: Add support for T-Head TH1520 AP_SUBSYS clocks")
Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 drivers/clk/thead/clk-th1520-ap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/thead/clk-th1520-ap.c b/drivers/clk/thead/clk-th1520-ap.c
index 42feb4bb6329..41ed72b1a915 100644
--- a/drivers/clk/thead/clk-th1520-ap.c
+++ b/drivers/clk/thead/clk-th1520-ap.c
@@ -427,7 +427,7 @@ static struct ccu_mux c910_i0_clk = {
 };
 
 static const struct clk_parent_data c910_parents[] = {
-	{ .hw = &c910_i0_clk.common.hw },
+	{ .index = -1, .name = "c910-i0" },
 	{ .hw = &cpu_pll1_clk.common.hw }
 };
 
-- 
2.50.0


