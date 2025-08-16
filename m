Return-Path: <linux-kernel+bounces-771853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39129B28C3D
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 11:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E4DE188C1AF
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 09:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A60223D7E9;
	Sat, 16 Aug 2025 09:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="NjlEWXzx"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EC5220F5A;
	Sat, 16 Aug 2025 09:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755335507; cv=pass; b=YPySygW8gQ6PqWeQXHvgBAZ9fD2G8+d9MjImHa3yWJE1WkIsTuUeCX7bhRx0pJ/ynLrPBOdxjaL56dIgDk53beulxWQfqDS0IgLlOEo4YL89mAY26NeiAcVJfVdynmXyVIGXZv5vevVa3LCmZp8Kcd5VNC+U94gnVaNbTtsNsTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755335507; c=relaxed/simple;
	bh=6qEGNlZBl3nshdyBz68x/pPxPeW3I8lNiBJOr2saN/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sSdEKc1lQJNJS0mJJt2AITXHg2MLU36+Ki/GPd8zxqcsJYAO85/oGYQUAIhk7R7ZmkxwH7O1Gp/7ZZk/wUgQZvXh+3vatQ9XrCFEZZWMHzcFrGXDGdNBZq2lmLhnAurmdjeWjll7Pv1xC9MkN409zrJbmdwigDyjuYXFjOlqwqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=NjlEWXzx; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1755335492; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=SHB+yKqKj3znfyW4qsXKvi0RIZ0ujnDNddLFa1dG4IW4VOlFrJ4EJ8VfzHt5qNshxpRcUDZjPVRKNu41FM5Y5YcSPc+RdO2xpZg6AhZmpcbQFBmkAYMoPUqrVzaJ4/uM15pVYydJC4l1XZVo/VpuogASWlo0cx/e3740bpT3w7w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755335492; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=RK3+SKipm275XQslhB+Q0sSWLYBre0x6UlqY2Qv7VME=; 
	b=DGryvI/nUIK9vrh4yL8cn/wdPC+iS+Mf5sEEpn3c51k4igovGpKFqwK+PVflRT3WYY382/vnzjPgCaaOsJzQiVzUuGIwbc3FzqNaCUj079P61qJaXngsq5LN6+mAAmXUQVFPo7OJx9QA8CjMZYIHT3ynr+zCNrcr34n0cfa8xLA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755335491;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=RK3+SKipm275XQslhB+Q0sSWLYBre0x6UlqY2Qv7VME=;
	b=NjlEWXzxLZW2tVHMo5m4ZURN/7Lhb9UudEj7Caup9Ex90Wks41iQka0dpUbfKC2q
	PZq0syHnMn7KfjeAgVVFTJVtdYYJJdiLJ1Xh79WoNTy5AO9e1QlPpAcN/ULtENP4aSM
	MyU363etz1HftOqhm6UXgm+Fqt/3CK5jygyK0yheR0ItyqdkzbyMhbOby42YULtPyvu
	c3Nc5EktLKtuQyOuDf3yyVp1qrCzFuX2rvuH423Wte8iIR9ABa16lYGXtx2Q4Zh7+h1
	ZWTx8pRwqvvyKK4NGNWl5iIpmaZQyqlcwuJF+vdM9CyEKjoS46y4mlabUEQ+PVoAn9C
	ZITq5wAbCA==
Received: by mx.zohomail.com with SMTPS id 1755335489822449.85694866578626;
	Sat, 16 Aug 2025 02:11:29 -0700 (PDT)
From: Icenowy Zheng <uwu@icenowy.me>
To: Drew Fustini <fustini@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Han Gao <rabenda.cn@gmail.com>,
	Yao Zi <ziyao@disroot.org>,
	linux-riscv@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Icenowy Zheng <uwu@icenowy.me>
Subject: [PATCH v3 0/4] clk: thead: Changes to TH1520 clock driver for disp
Date: Sat, 16 Aug 2025 17:11:09 +0800
Message-ID: <20250816091113.2596048-1-uwu@icenowy.me>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

This patchset is my changes to the TH1520 clock driver, mainly for
supporting the display controller.

The first patch is previously a dependency of this patchset before v3,
but a rebase operation in v3 changed it and it's now pulled into this
patchset.

The 2nd and 3rd ones are functionality additions, with the first one
adding support for enabling/disabling PLLs (for DPU PLL) and the second
one adding support for changing DPU dividers.

The 4th one is to address hang issues met when testing the DPU driver
w/o clk_ignore_unused command line option.

The patchset is rebased atop the padctrl0 parent fix patchset (which
contains refactor of ccu_gate) at [1] in v3.

[1] https://lore.kernel.org/linux-riscv/20250816084445.2582692-1-uwu@icenowy.me/

Icenowy Zheng (3):
  clk: thead: add support for enabling/disabling PLLs
  clk: thead: support changing DPU pixel clock rate
  clk: thead: th1520-ap: set all AXI clocks to CLK_IS_CRITICAL

Michal Wilczynski (1):
  clk: thead: Correct parent for DPU pixel clocks

 drivers/clk/thead/clk-th1520-ap.c | 153 +++++++++++++++++++++++-------
 1 file changed, 121 insertions(+), 32 deletions(-)

-- 
2.50.1


