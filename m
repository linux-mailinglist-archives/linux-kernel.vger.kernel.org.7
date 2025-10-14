Return-Path: <linux-kernel+bounces-852941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BBDE9BDA4BF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 17:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8F2A0504B5E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 15:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D122A2FF170;
	Tue, 14 Oct 2025 15:12:08 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3D12F3C31
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 15:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760454728; cv=none; b=aWqb7+YEvY8QZZRPyDKw0R8NWL5Fsn3Lx3lX06E8Ru0MDimDBPSsIvoX1+IsmcWZkvAy9A5QYXj0r2avLODjPJ6vnRR6Uz19zAOqAfjJmXfR8c5x+26m4W7GcL8Cvi7EYHpLeTrwZKiBBotbbrfLOpJWNnJkvfYs4KVCZsG2Ct0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760454728; c=relaxed/simple;
	bh=V/nxRcpYuHZdJgUcKJeaR45Q4KIySWX/SyuOpNYqGA4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NC54oC4yNGlLFmXI5obFhvSX+B1XNqQvq3MAP/x1k8ovt3TTSeIMJ+5vcki50uYvKfYtGBRo6sDq8x7VJIZ878h01S6OkSKYqdnjsvypvgqewCv6GSDDC8+3RmmTmN0TxSawaCDSu52AZO05utLiPcaEn0DWQEjKE+zamhQRX2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64B3AC4CEE7;
	Tue, 14 Oct 2025 15:12:06 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: cocci@inria.fr,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] coccinelle: of_table: Update Keywords for SPI device ID tables
Date: Tue, 14 Oct 2025 17:12:03 +0200
Message-ID: <843cb14b08b201a1b35b690d4602ac7912a0f8fd.1760454689.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When adding support for SPI device ID tables, the keywords in the header
were not updated.

Fixes: 347b564599fb01d8 ("coccinelle: of_table: handle SPI device ID tables")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 scripts/coccinelle/misc/of_table.cocci | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/coccinelle/misc/of_table.cocci b/scripts/coccinelle/misc/of_table.cocci
index 7ade9766dee89c70..9de406b692a590ba 100644
--- a/scripts/coccinelle/misc/of_table.cocci
+++ b/scripts/coccinelle/misc/of_table.cocci
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /// Make sure (of/i2c/platform)_device_id tables are NULL terminated
 //
-// Keywords: of_table i2c_table platform_table
+// Keywords: of_table i2c_table platform_table spi_table
 // Confidence: Medium
 // Options: --include-headers
 
-- 
2.43.0


