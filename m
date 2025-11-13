Return-Path: <linux-kernel+bounces-899715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B8EC58A6D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 17:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C6CAC4EFD16
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 15:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2513557F2;
	Thu, 13 Nov 2025 15:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JlCWmwV6"
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302C73559EC
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 15:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763049193; cv=none; b=kgFEk7rxl3FqjquMpQjOQOukczI9E1hTIWbQQnW0VUmJAApup9eWwoPiudzDoBqex49556XOUhVEQDSopGx49XZc0qG8K9c8KTjcSWngS0sCUWXqrO3cl4YTpu98cCwr0Xsn7Nrzfen/yozCsjfHSgr7DTuY8ovpFiZrB1cHoeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763049193; c=relaxed/simple;
	bh=h0I4DiDc6GNRbFsL/Gt4N1M9ywNyj1x0U7W30l0Ik28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bMR2jUbR7faw1tsq2lRtYahoWahX8uY1N6207cm0jrsYLb4JmM8ddQ/oKMbGnGACtRyrYfQSJZqnoamVh7ixqfFGqempV5XrOL4tSy9iWSjG99cTHIMOtS+tmRVbOTitWWU9a9DQiIIrZZ0Wshat94655v9DM8b/iKG6rp7U8N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JlCWmwV6; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763049190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pShwBBnHbUhZjtMedCnDarjH+85reRacRSdZz081jWs=;
	b=JlCWmwV6LNHVwM35IYShejrxG9OpkFm7eSFGRK/PQRfeyKvrIL6nq7ONQTALg1D8NnmXmA
	eKJK0iTYF8y4TxH73SIIb71XGFhJaGDkouvQndOVfQrq+0nRvbHPaNJdHAQ+kJ1IR2fwSz
	pfbQC9yAifND6ZNZ4qxy3v+KqB++rSM=
From: Yuntao Wang <yuntao.wang@linux.dev>
To: Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Catalin Marinas <catalin.marinas@arm.com>,
	James Morse <james.morse@arm.com>,
	Baoquan He <bhe@redhat.com>,
	Zhen Lei <thunder.leizhen@huawei.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Geoff Levand <geoff@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Changyuan Lyu <changyuanl@google.com>,
	Alexander Graf <graf@amazon.com>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuntao Wang <yuntao.wang@linux.dev>
Subject: [PATCH v2 7/7] of/reserved_mem: Simplify the logic of fdt_scan_reserved_mem_reg_nodes()
Date: Thu, 13 Nov 2025 23:51:04 +0800
Message-ID: <20251113155104.226617-8-yuntao.wang@linux.dev>
In-Reply-To: <20251113155104.226617-1-yuntao.wang@linux.dev>
References: <20251113155104.226617-1-yuntao.wang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Use the existing helper functions to simplify the logic of
fdt_scan_reserved_mem_reg_nodes()

Signed-off-by: Yuntao Wang <yuntao.wang@linux.dev>
---
 drivers/of/of_reserved_mem.c | 23 ++++-------------------
 1 file changed, 4 insertions(+), 19 deletions(-)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index b8527f3e335e..96771ab073c0 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -226,12 +226,9 @@ static void __init __rmem_check_for_overlap(void);
  */
 void __init fdt_scan_reserved_mem_reg_nodes(void)
 {
-	int t_len = (dt_root_addr_cells + dt_root_size_cells) * sizeof(__be32);
 	const void *fdt = initial_boot_params;
 	phys_addr_t base, size;
-	const __be32 *prop;
 	int node, child;
-	int len;
 
 	if (!fdt)
 		return;
@@ -253,28 +250,16 @@ void __init fdt_scan_reserved_mem_reg_nodes(void)
 	fdt_for_each_subnode(child, fdt, node) {
 		const char *uname;
 
-		prop = of_get_flat_dt_prop(child, "reg", &len);
-		if (!prop)
-			continue;
 		if (!of_fdt_device_is_available(fdt, child))
 			continue;
 
-		uname = fdt_get_name(fdt, child, NULL);
-		if (len && len % t_len != 0) {
-			pr_err("Reserved memory: invalid reg property in '%s', skipping node.\n",
-			       uname);
+		if (!of_fdt_get_addr_size(child, "reg", &base, &size))
 			continue;
-		}
-
-		if (len > t_len)
-			pr_warn("%s() ignores %d regions in node '%s'\n",
-				__func__, len / t_len - 1, uname);
 
-		base = dt_mem_next_cell(dt_root_addr_cells, &prop);
-		size = dt_mem_next_cell(dt_root_size_cells, &prop);
-
-		if (size)
+		if (size) {
+			uname = fdt_get_name(fdt, child, NULL);
 			fdt_reserved_mem_save_node(child, uname, base, size);
+		}
 	}
 
 	/* check for overlapping reserved regions */
-- 
2.51.0


