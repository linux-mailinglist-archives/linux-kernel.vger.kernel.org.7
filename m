Return-Path: <linux-kernel+bounces-899713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 960D9C58AEB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 17:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80C273BAC14
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 15:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A74355056;
	Thu, 13 Nov 2025 15:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JwjvrLB8"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42866355054
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 15:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763049184; cv=none; b=crgYcftkLJYSVSf4IVFZdiMRlaZQ2kfBx5Fr9PtILRYuzIB7I3N6lNgv+raMd3CPrIa+6fDp9qy63hFnhW8Q4qYRvophrclX8S4tu7XydMPedfOQxEdptr8ctp7n+tfZT7qpwsNAjoB0j8hnysof8PwGdBvXv2ePc0jjWZhogBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763049184; c=relaxed/simple;
	bh=tprO6N0gVwnG1G8yHuIS5dI+Sf8VvxGP72vdtdY0NV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WfXMAirL/3vqlwp+Z5+YVE3ESTKJTnA12OYItXefwXZwWBCRrHuuEBRBuJecgiR54CqQv66Cc8r0j1N+UnOkQm2IzETYnsKB2soP2gQrZ1MwGcnfps8CQMpQWxWJ2kKzlfhMqmjhutFjqhnqI+YOZYngY0kwk7StAmdM60uZkno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JwjvrLB8; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763049181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SdhoUiNDDhmkZBcf7Fv2t++iSbCGwWq7uyL4ru5W8uw=;
	b=JwjvrLB85U9mDl3W5zTWCoQjGKz4VB6mH1x+vEyjfprXPhN8PSNUYyzt/KDnsfbHgxe05q
	voihqUjWWU3cx2RzJsxdlLnlzKwPRzrrqoceOe80sxX4FF/5uvTDahgys5djzy3Os/2Il3
	3RxDPG0uMlTB+1JwzoD0Q/BeuVvlnek=
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
Subject: [PATCH v2 6/7] of/reserved_mem: Simplify the logic of __reserved_mem_reserve_reg()
Date: Thu, 13 Nov 2025 23:51:03 +0800
Message-ID: <20251113155104.226617-7-yuntao.wang@linux.dev>
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
__reserved_mem_reserve_reg()

Signed-off-by: Yuntao Wang <yuntao.wang@linux.dev>
---
 drivers/of/of_reserved_mem.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 2e9ea751ed2d..b8527f3e335e 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -154,17 +154,16 @@ static int __init early_init_dt_reserve_memory(phys_addr_t base,
 static int __init __reserved_mem_reserve_reg(unsigned long node,
 					     const char *uname)
 {
-	int t_len = (dt_root_addr_cells + dt_root_size_cells) * sizeof(__be32);
 	phys_addr_t base, size;
 	int len;
 	const __be32 *prop;
 	bool nomap;
 
-	prop = of_get_flat_dt_prop(node, "reg", &len);
-	if (!prop)
+	prop = of_fdt_get_addr_size_prop(node, "reg", &len);
+	if (!len)
 		return -ENOENT;
 
-	if (len && len % t_len != 0) {
+	if (len < 0) {
 		pr_err("Reserved memory: invalid reg property in '%s', skipping node.\n",
 		       uname);
 		return -EINVAL;
@@ -172,9 +171,8 @@ static int __init __reserved_mem_reserve_reg(unsigned long node,
 
 	nomap = of_get_flat_dt_prop(node, "no-map", NULL) != NULL;
 
-	while (len >= t_len) {
-		base = dt_mem_next_cell(dt_root_addr_cells, &prop);
-		size = dt_mem_next_cell(dt_root_size_cells, &prop);
+	while (len-- > 0) {
+		of_fdt_read_addr_size(prop, &base, &size);
 
 		if (size && early_init_dt_reserve_memory(base, size, nomap) == 0) {
 			/* Architecture specific contiguous memory fixup. */
@@ -187,8 +185,6 @@ static int __init __reserved_mem_reserve_reg(unsigned long node,
 			pr_err("Reserved memory: failed to reserve memory for node '%s': base %pa, size %lu MiB\n",
 			       uname, &base, (unsigned long)(size / SZ_1M));
 		}
-
-		len -= t_len;
 	}
 	return 0;
 }
-- 
2.51.0


