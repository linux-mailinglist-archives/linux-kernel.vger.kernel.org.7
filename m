Return-Path: <linux-kernel+bounces-837822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ACDEBAD416
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 16:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 543B51660E2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 14:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93AC1306D5E;
	Tue, 30 Sep 2025 14:48:19 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDF03054EA
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 14:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759243699; cv=none; b=LGNOfjkDaAmSKffdTNNa7IEDKLC+llAqCBBqjC9UbY6V0MzjzeWk/ZokqVdNsCTFn9mtF2FzBuVkSWnpeW+/gOoagw/sT+/+jf2cQYvYUvhpaPQ1HXU/iM989ZIGQ8qJtLMZW2r6JLnCX75bMqsL+abm7GlrkBMP1gmzFFgG2X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759243699; c=relaxed/simple;
	bh=3aCyEKIGbPF3OEeYMXbIpMduZ73hNhc5ATpXgkjIKHE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bWodueBBAGCgB/Scbbk9RKqxG7dUyI/JKF6iq7P49KhOPbGEXbYm3x3vdRX+PLUOay1BAuCrjhFMnRm3e3kHAJe04Ub+GXVaEUUUlpzoo1jXeB3ntuKaMmXMXRFM36UG3mzGaEcBTreLNSv3eNR0EcMWnukZd7bsqKni9YeiyxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3145DC4CEF0;
	Tue, 30 Sep 2025 14:48:16 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Jassi Brar <jassisinghbrar@gmail.com>,
	Rahul Pathak <rpathak@ventanamicro.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Paul Walmsley <pjw@kernel.org>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] mailbox: RISCV_SBI_MPXY_MBOX should be disabled by default
Date: Tue, 30 Sep 2025 16:48:12 +0200
Message-ID: <c458915ba9a4d1ba3413232206c88fcffbf832cb.1759243480.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The help text for RISC-V SBI Message Proxy (MPXY) Mailbox support states
"If unsure say N", so the driver should not default to enabled.

Fixes: bf3022a4eb119c6b ("mailbox: Add RISC-V SBI message proxy (MPXY) based mailbox driver")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/mailbox/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index c488725aa2a5d4b0..acc4bd93136cb720 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -372,7 +372,6 @@ config BCM74110_MAILBOX
 config RISCV_SBI_MPXY_MBOX
 	tristate "RISC-V SBI Message Proxy (MPXY) Mailbox"
 	depends on RISCV_SBI
-	default RISCV
 	help
 	  Mailbox driver implementation for RISC-V SBI Message Proxy (MPXY)
 	  extension. This mailbox driver is used to send messages to the
-- 
2.43.0


