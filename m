Return-Path: <linux-kernel+bounces-899708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 237C8C58A7F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 17:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D89CE36595D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 15:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15EEC346FA4;
	Thu, 13 Nov 2025 15:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TOUbEjPg"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB47346FAB
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 15:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763049142; cv=none; b=V0mzMhiUwy282Cqt5dNRgA3y9TDaooaRZkfdC6kFGs3gU34+iXHhAT5YWuza28EXfQk/uXs5ydd7wL9Z3yencUFTce7s92E2J4Z7C0uSHOrqLJH2+LWosZqImTCegDLXR6zCObL3mym6QRdajQDi3bTRtQsIx0OO8iNWuANYckg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763049142; c=relaxed/simple;
	bh=0NhSeTl/snE7z5Fdpm4OWzOjQK7ApfL9mhPE8pL+RqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ugd8iDzvfSXlvo/H8GAqJQOq5yhWTh2qX/Ey+fadzAnspYETmXV4SmEaEx6rpHLfk+60Us4/9BtnUiSIWaeFpeU2LbnGoMcvwNGXcV/N3wl1yga9mrd4ff+LJB8rRyeNmnvAcoqIryubnrQzFF4BS2mZN3QpIJOq1ugz3DEIhgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TOUbEjPg; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763049138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2FL1PcC0VA6JulAHPdLFNyV1ulA8PzIof8YPayCQbY4=;
	b=TOUbEjPgaprY6ccn37/B8m5bUQqZ8UYWTaxdKlUnLDvhn5Vwf5SmJnZJEpDnL0o/shAoGH
	svyYOYJxXZPCeoWAqgC1G948IMVTiA5zP3FgE+nJPZyxtu6AFGAKr9fLXUffU9IcCKeirg
	y+uDRtIkQnAcfWxGs9FChr887kVAEjU=
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
Subject: [PATCH v2 1/7] of/fdt: Consolidate duplicate code into helper functions
Date: Thu, 13 Nov 2025 23:50:58 +0800
Message-ID: <20251113155104.226617-2-yuntao.wang@linux.dev>
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

Currently, there are many pieces of nearly identical code scattered across
different places. Consolidate the duplicate code into helper functions to
improve maintainability and reduce the likelihood of errors.

Signed-off-by: Yuntao Wang <yuntao.wang@linux.dev>
---
 drivers/of/fdt.c       | 41 +++++++++++++++++++++++++++++++++++++++++
 include/linux/of_fdt.h |  5 +++++
 2 files changed, 46 insertions(+)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 0edd639898a6..5e0eabc1449f 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -625,6 +625,47 @@ const void *__init of_get_flat_dt_prop(unsigned long node, const char *name,
 	return fdt_getprop(initial_boot_params, node, name, size);
 }
 
+const __be32 *__init of_fdt_get_addr_size_prop(unsigned long node,
+                                               const char *name, int *entries)
+{
+	const __be32 *prop;
+	int len, elen = (dt_root_addr_cells + dt_root_size_cells) * sizeof(__be32);
+
+	prop = of_get_flat_dt_prop(node, name, &len);
+	if (!prop) {
+		*entries = 0;
+		return NULL;
+	}
+
+	if (len % elen) {
+		*entries = -1;
+		return NULL;
+	}
+
+	*entries = len / elen;
+	return prop;
+}
+
+bool __init of_fdt_get_addr_size(unsigned long node, const char *name,
+                                 u64 *addr, u64 *size)
+{
+	const __be32 *prop;
+	int len, elen = (dt_root_addr_cells + dt_root_size_cells) * sizeof(__be32);
+
+	prop = of_get_flat_dt_prop(node, name, &len);
+	if (!prop || len < elen)
+		return false;
+
+	of_fdt_read_addr_size(prop, addr, size);
+	return true;
+}
+
+void __init of_fdt_read_addr_size(const __be32 *prop, u64 *addr, u64 *size)
+{
+	*addr = dt_mem_next_cell(dt_root_addr_cells, &prop);
+	*size = dt_mem_next_cell(dt_root_size_cells, &prop);
+}
+
 /**
  * of_fdt_is_compatible - Return true if given node from the given blob has
  * compat in its compatible list
diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
index b8d6c0c20876..3a0805ff6c7b 100644
--- a/include/linux/of_fdt.h
+++ b/include/linux/of_fdt.h
@@ -55,6 +55,11 @@ extern int of_get_flat_dt_subnode_by_name(unsigned long node,
 					  const char *uname);
 extern const void *of_get_flat_dt_prop(unsigned long node, const char *name,
 				       int *size);
+extern const __be32 *of_fdt_get_addr_size_prop(unsigned long node,
+                                               const char *name, int *entries);
+extern bool of_fdt_get_addr_size(unsigned long node, const char *name,
+                                 u64 *addr, u64 *size);
+extern void of_fdt_read_addr_size(const __be32 *prop, u64 *addr, u64 *size);
 extern int of_flat_dt_is_compatible(unsigned long node, const char *name);
 extern unsigned long of_get_flat_dt_root(void);
 extern uint32_t of_get_flat_dt_phandle(unsigned long node);
-- 
2.51.0


