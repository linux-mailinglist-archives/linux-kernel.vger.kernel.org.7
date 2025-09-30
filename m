Return-Path: <linux-kernel+bounces-837825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 857FDBAD45E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 16:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F5A21763E4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 14:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC57B3043A1;
	Tue, 30 Sep 2025 14:50:28 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794C3199939;
	Tue, 30 Sep 2025 14:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759243828; cv=none; b=BDpMqBk+BXF9mV1sVzuzemMicg0lCGlO1PBmTlEPXHCTKSGEAcJxmXWOzDh8RKxdUhFHEoGb0uhI4b/KhbqVjE98vyk54fHSwNhz1xantj3BZFHw6dy3Hm52VmjgOmSzrXqewWH90PO/zpgUYHV/Ky5lEeSQWB9bHbnWncju6bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759243828; c=relaxed/simple;
	bh=bGRvLmBfuagqKuhVTHE+dzZ/1ZOkju5doGxlOLCStME=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uElRfbTFznGRitTUMfwKLinpd+/qSf9ZMX40MIU5iNybgZaqi+hPpGl/O77Q6AANvFEL2q+zqPDerRIi3JlpCHKerAiRXknn9+878QFlmkAUzQDIwHOVFSvg/qzNBNhgkgg+c/3EwcKEF42ba+B5fNjbu+MgKl+hktXO7p845wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34EB4C113D0;
	Tue, 30 Sep 2025 14:50:26 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rahul Pathak <rpathak@ventanamicro.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Paul Walmsley <pjw@kernel.org>
Cc: linux-clk@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] clk: COMMON_CLK_RPMI should depend on RISCV
Date: Tue, 30 Sep 2025 16:50:23 +0200
Message-ID: <ed37635b59b0765ed3dbed6ea33c562a40b9e287.1759243789.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RISC-V platform management interface (RPMI) is only available on
RISC-V platforms.  Hence add a dependency on RISCV, to prevent asking
the user about this driver when configuring a kernel for a different
architecture.

Fixes: 5ba9f520f41a33c9 ("clk: Add clock driver for the RISC-V RPMI clock service group")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
And perhaps the "default RISCV" should be dropped, too?
---
 drivers/clk/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index b03fafb402b19153..5c17a22d59920f5e 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -510,6 +510,7 @@ config COMMON_CLK_LITEX
 
 config COMMON_CLK_RPMI
 	tristate "Clock driver based on RISC-V RPMI"
+	depends on RISCV || COMPILE_TEST
 	depends on MAILBOX
 	default RISCV
 	help
-- 
2.43.0


