Return-Path: <linux-kernel+bounces-899712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 76ABEC58985
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 17:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5497C3601F2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 15:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5051F355049;
	Thu, 13 Nov 2025 15:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="U7z4KQXq"
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E359F355022
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 15:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763049176; cv=none; b=CPfjGEs6AUKmj1CRl+MoSeIChZ0zWt3FfmUDcy9YQ+5MWXISPKMOsq6PWBY4IiIeVJuCxY643/Si4HjGR3NJfRxeSU2Pd00vv+Z+n/741KXF0fyR7btzhDtwqmSbg46ASOi3T7+Xku9NYFTtoAwEMdkfZokSHGV7lReryWZeLaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763049176; c=relaxed/simple;
	bh=fXl+mXM/AgH4+gWKzqK1XQgPchHG6fLIdy11kWGVzq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F25tcohO+m9RjIfki598qIMplMNPKFUUG6CVa28dQd9MQaUgL2PVmtws1TaFtVZm48xcyisTdGfJTlaBQkfZoCxtUu+ndDbanAB7gC/Ipr6gBcKycU+5WBz+XjKOTy34W+l9FWG57Yg/kkCINE6+IEFX5/URo3rOlpu8ENpe8pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=U7z4KQXq; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763049173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J9UNF6c7GepepH7wr+REukLkpUqCyIFHcXGXKzxLcbU=;
	b=U7z4KQXqc+YTUJVB7A/GcWVkKVsCw933NyXN+fw7bGYJIyvMts5CS5KtYXgsDci7ks2c7J
	BqfrkfTGc04oNJotEh9zzUT7ZWE3B9zgcFzd5JfSquhW6UZpopo2dTBATR+VW95vQGACLw
	7A9LN0zKX7fFzlKjUrdaCoebdukPCQo=
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
Subject: [PATCH v2 5/7] of/fdt: Simplify the logic of early_init_dt_scan_memory()
Date: Thu, 13 Nov 2025 23:51:02 +0800
Message-ID: <20251113155104.226617-6-yuntao.wang@linux.dev>
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
early_init_dt_scan_memory()

Signed-off-by: Yuntao Wang <yuntao.wang@linux.dev>
---
 drivers/of/fdt.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 4c45a97d6652..b6b059960fc2 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -1027,7 +1027,7 @@ int __init early_init_dt_scan_memory(void)
 
 	fdt_for_each_subnode(node, fdt, 0) {
 		const char *type = of_get_flat_dt_prop(node, "device_type", NULL);
-		const __be32 *reg, *endp;
+		const __be32 *reg;
 		int l;
 		bool hotpluggable;
 
@@ -1038,23 +1038,21 @@ int __init early_init_dt_scan_memory(void)
 		if (!of_fdt_device_is_available(fdt, node))
 			continue;
 
-		reg = of_get_flat_dt_prop(node, "linux,usable-memory", &l);
+		reg = of_fdt_get_addr_size_prop(node, "linux,usable-memory", &l);
 		if (reg == NULL)
-			reg = of_get_flat_dt_prop(node, "reg", &l);
+			reg = of_fdt_get_addr_size_prop(node, "reg", &l);
 		if (reg == NULL)
 			continue;
 
-		endp = reg + (l / sizeof(__be32));
 		hotpluggable = of_get_flat_dt_prop(node, "hotpluggable", NULL);
 
-		pr_debug("memory scan node %s, reg size %d,\n",
+		pr_debug("memory scan node %s, reg {addr,size} entries %d,\n",
 			 fdt_get_name(fdt, node, NULL), l);
 
-		while ((endp - reg) >= (dt_root_addr_cells + dt_root_size_cells)) {
+		while (l-- > 0) {
 			u64 base, size;
 
-			base = dt_mem_next_cell(dt_root_addr_cells, &reg);
-			size = dt_mem_next_cell(dt_root_size_cells, &reg);
+			of_fdt_read_addr_size(reg, &base, &size);
 
 			if (size == 0)
 				continue;
-- 
2.51.0


