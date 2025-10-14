Return-Path: <linux-kernel+bounces-851865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D00BD77D3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 07:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 437203E7A84
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 05:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28022286887;
	Tue, 14 Oct 2025 05:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="oTAbr2el"
Received: from mx-relay47-hz3.antispameurope.com (mx-relay47-hz3.antispameurope.com [94.100.134.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B40219E8
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 05:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=94.100.134.236
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760421069; cv=pass; b=hMYK+f+nkCxM+psYszYYtGO0hEc7dTzWB2CP0mupTYyBfyXvw3hoACiVkB1oWSnJifsnwI9YURlQO+PwPZk/5DISviMXka6m/SZyIG/dnYTPR9cKOpmNDHeMQ+bzNW8Abw0rex0oO8MukzNZgZfjMvfP5cqw+dfXyRLiqI3x53U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760421069; c=relaxed/simple;
	bh=ZKBXzuLgHnPv9Mp/a52fJXSw1h9XVCMhyxdDTH7YLLA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cPm4O5Ix4BmKI7SHy7cWASPoTfowmruhxBs09xUimmHNDGRfPZW6ke1JszlLrS7bVyJuF3QMvL4+qXMwuccXZQUG+86XOFIffuK2M0tJCh6PrIzcRRh74hxAmbNMRZ+DtjuvXvREgmB7UMGlyWY5swtwOSz7VW1Uk9De6Qtmhow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=oTAbr2el; arc=pass smtp.client-ip=94.100.134.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate47-hz3.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6, headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com
 smtp.helo=hmail-p-smtp01-out03-hz1.hornetsecurity.com; dmarc=pass
 header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=H/kOwDFzfm3IalvPOezvdeJs36K8vMFT5gBD1NEeb8I=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1760421049;
 b=FIkjIXhestt77gUQW5WqLU/854Peo0zJIp9qJ/OO1PxaOrL09dac34ktbvB0Cv54RvlqvU/k
 EeEjDFXNU27m5kuKmwLoO8KXCExSmw0nJ0JBFb5lkws/cONxheIpBG4b6XVKMsN5vc1fKDbtlMA
 riX4kvdyvKibjqU1iz6oxqkhV6Cf+vxjvFL+W752N9LUkLbQ4sq1rZORztNGthJwM9XOanFkgjH
 ID3wEHUkm+WwWoW3bY4Rwe+E5UD4v+9LCvTN7q9WjvkqQuqkdgJuWyx5WeCAwQOcWFmMU3VdEBv
 mgfbA4IiWno3LShZDdspk1z3gxKa4qoPxbod1/GOfxqzQ==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1760421049;
 b=TImOD05EvKDlUwIBucDzEvEh6WWExCFeX7eoRNoOR6+CH5JWT+cZ8M/7OTrQdSE49P0AEGQI
 ZaoqJVX2N4dRTTcu9NFEwVvKWC4YUouvNHuoqeZ+3PA28jM3GONyqbUk+oG2ASM0zcp+2IY5mGk
 4ZUGqbJdarGQXhBcMNhwoWvcNbq7hYBCEntWk/l0NzCnLkRKB2HYgueNlP9t0nx9ATk4BUixmtc
 Y/VAgbZm69/6uR0/X8D7R6DiiGIRjP57cZLDkjf2vV3TWcdLAvXVadodtROO8wLhUQdlBl67pL0
 n0ikhBv54QbhRmvoUWcdH+cMbr0KPvLFEcfndcOOd5ZUw==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by mx-relay47-hz3.antispameurope.com;
 Tue, 14 Oct 2025 07:50:49 +0200
Received: from steina-w.tq-net.de (host-82-135-125-110.customer.m-online.net [82.135.125.110])
	(Authenticated sender: alexander.stein@ew.tq-group.com)
	by hmail-p-smtp01-out03-hz1.hornetsecurity.com (Postfix) with ESMTPSA id 0231ECC0DE1;
	Tue, 14 Oct 2025 07:50:35 +0200 (CEST)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Lizhi Hou <lizhi.hou@amd.com>,
	Brian Xu <brian.xu@amd.com>,
	Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>,
	Vinod Koul <vkoul@kernel.org>,
	Michal Simek <michal.simek@amd.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	dmaengine@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] dmaengine: xilinx: xdma: Add regmap register ranges
Date: Tue, 14 Oct 2025 07:50:33 +0200
Message-ID: <20251014055034.274596-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-cloud-security-sender:alexander.stein@ew.tq-group.com
X-cloud-security-recipient:linux-kernel@vger.kernel.org
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for: alexander.stein@ew.tq-group.com
X-cloud-security-Mailarchivtype:outbound
X-cloud-security-Virusscan:CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay47-hz3.antispameurope.com with 4cm3Gh401Pz4MZvT
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1, IP=94.100.132.6
X-cloud-security-Digest:68dca67b7eb0fd836cb29e646ce2f625
X-cloud-security:scantime:2.704
DKIM-Signature: a=rsa-sha256;
 bh=H/kOwDFzfm3IalvPOezvdeJs36K8vMFT5gBD1NEeb8I=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1760421048; v=1;
 b=oTAbr2elQ/cu5qrtSmsWURpKSPjoms55QDehCWU1Iu6+zuwehmOXhYXc8M58ZriWdFjBg1yG
 i5ahv8CR8VmUtjFwKvDvPPGEnGQ0onyOySdRE0qnicpVlI3sg2zsdk7tv8fdedd3O7k/XO8mqhm
 5JFt08ZsU/QA4PKhg/1gG5Q2QCkZMzLd+OjFJnS5WTsJSPcH+s3jwhLYKdN5kd3/HNnx7XL1JSu
 71eFnc0wtsPmNG6nDWt6vX2m8WIG1WuoMQWPsFAyz9AlyiXbae599I0lKNMxRlq61VEfb08O26y
 wt3zquUgplLA/mryrg+YfUXdg72GuSjB7FuXLjXG9RJJg==

The XDMA bar is 64KiB, way too much for debugfs dump. Add register range
definitions for all defined registers in PG195. As this is PCIe memory
range all readable registers are marked as volatile.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
Although the change itself is independent, this patch context depends on
[1].

[1] https://lore.kernel.org/all/20251013-xdma-max-reg-v5-1-83efeedce19d@amarulasolutions.com/

 drivers/dma/xilinx/xdma.c | 89 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
index 5ecf8223c112e..3d9e92bbc9bb0 100644
--- a/drivers/dma/xilinx/xdma.c
+++ b/drivers/dma/xilinx/xdma.c
@@ -33,12 +33,101 @@
 #include "../virt-dma.h"
 #include "xdma-regs.h"
 
+static const struct regmap_range xdma_wr_ranges[] = {
+	/* H2C channel registers */
+	regmap_reg_range(0x0004, 0x000c),
+	regmap_reg_range(0x0040, 0x0040),
+	regmap_reg_range(0x0088, 0x0098),
+	regmap_reg_range(0x00c0, 0x00c0),
+	/* C2H channel registers */
+	regmap_reg_range(0x1004, 0x100c),
+	regmap_reg_range(0x1040, 0x1040),
+	regmap_reg_range(0x1088, 0x1098),
+	regmap_reg_range(0x10c0, 0x10c0),
+	/* IRQ Block registers */
+	regmap_reg_range(0x2004, 0x2018),
+	regmap_reg_range(0x2080, 0x208c),
+	regmap_reg_range(0x20a0, 0x20a4),
+	/* Config Block registers */
+	regmap_reg_range(0x301c, 0x301c),
+	regmap_reg_range(0x3040, 0x3044),
+	regmap_reg_range(0x3060, 0x3060),
+	/* H2C SGDMA registers */
+	regmap_reg_range(0x4080, 0x408c),
+	/* C2H SGDMA registers */
+	regmap_reg_range(0x5080, 0x508c),
+	/* SGDMA Common registers */
+	regmap_reg_range(0x6010, 0x6018),
+	regmap_reg_range(0x6020, 0x6028),
+	/* MSI-X Vector Table and PBA */
+	regmap_reg_range(0x8000, 0x81fc),
+	regmap_reg_range(0x8fe0, 0x8fe0),
+};
+static const struct regmap_range xdma_rd_ranges[] = {
+	/* H2C channel registers */
+	regmap_reg_range(0x0000, 0x0004),
+	regmap_reg_range(0x0040, 0x004c),
+	regmap_reg_range(0x0088, 0x0090),
+	regmap_reg_range(0x00c0, 0x00d0),
+	/* C2H channel registers */
+	regmap_reg_range(0x1000, 0x1004),
+	regmap_reg_range(0x1040, 0x104c),
+	regmap_reg_range(0x1088, 0x1090),
+	regmap_reg_range(0x10c0, 0x10d0),
+	/* IRQ Block registers */
+	regmap_reg_range(0x2000, 0x2004),
+	regmap_reg_range(0x2010, 0x2010),
+	regmap_reg_range(0x2040, 0x204c),
+	regmap_reg_range(0x2080, 0x208c),
+	regmap_reg_range(0x20a0, 0x20a4),
+	/* Config Block registers */
+	regmap_reg_range(0x3000, 0x301c),
+	regmap_reg_range(0x3040, 0x3044),
+	regmap_reg_range(0x3060, 0x3060),
+	/* H2C SGDMA registers */
+	regmap_reg_range(0x4000, 0x4000),
+	regmap_reg_range(0x4080, 0x408c),
+	/* C2H SGDMA registers */
+	regmap_reg_range(0x5000, 0x5000),
+	regmap_reg_range(0x5080, 0x508c),
+	/* SGDMA Common registers */
+	regmap_reg_range(0x6000, 0x6000),
+	regmap_reg_range(0x6010, 0x6010),
+	regmap_reg_range(0x6020, 0x6020),
+	/* MSI-X Vector Table and PBA */
+	regmap_reg_range(0x8000, 0x81fc),
+	regmap_reg_range(0x8fe0, 0x8fe0),
+};
+static const struct regmap_range xdma_precious_ranges[] = {
+	/* H2C channel registers */
+	regmap_reg_range(0x0044, 0x0044),
+	/* C2H channel registers */
+	regmap_reg_range(0x1044, 0x1044),
+};
+static const struct regmap_access_table xdma_wr_table = {
+	.yes_ranges = xdma_wr_ranges,
+	.n_yes_ranges = ARRAY_SIZE(xdma_wr_ranges),
+};
+static const struct regmap_access_table xdma_rd_table = {
+	.yes_ranges = xdma_rd_ranges,
+	.n_yes_ranges = ARRAY_SIZE(xdma_rd_ranges),
+};
+static const struct regmap_access_table xdma_precious_table = {
+	.yes_ranges = xdma_precious_ranges,
+	.n_yes_ranges = ARRAY_SIZE(xdma_precious_ranges),
+};
+
 /* mmio regmap config for all XDMA registers */
 static const struct regmap_config xdma_regmap_config = {
 	.reg_bits = 32,
 	.val_bits = 32,
 	.reg_stride = 4,
 	.max_register = XDMA_MAX_REG_OFFSET,
+	.wr_table = &xdma_wr_table,
+	.rd_table = &xdma_rd_table,
+	.volatile_table = &xdma_rd_table,
+	.precious_table = &xdma_precious_table,
+	.cache_type = REGCACHE_NONE,
 };
 
 /**
-- 
2.43.0


