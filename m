Return-Path: <linux-kernel+bounces-899710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD7DC58ADF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 17:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E34333BD617
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 15:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2236346E66;
	Thu, 13 Nov 2025 15:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OcD67eL2"
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9481934572F
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 15:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763049159; cv=none; b=Ig9u7JQueYUBQIda7zVF9yNCsiqzLDHNkfrBuUUhImDf9PGJGPAoNGb9gCcNtjkjYFxMge4BTdJHWok8WYug9XmTjmp+d2j8tVPzwcbOYDKWfdtOKIQOnlhbedEiF0liRaGXTixD4G8+O9g/uvJpU/sn8SnZlyGUWmOCZYIYq4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763049159; c=relaxed/simple;
	bh=7tr+1d/3tzMsJWc39iUs0JefrX9nWMAO5RdM4bye1Ho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uvbF9R/qrsxsj9u5DQl5CCJf6eT7lgVcLF5UDOTGScDQHRVKwucajbhURq9PRyWIqIddLQKlF2LbIGK3wkWWxx3L3W/SAGZM1z8dtkYIVcg5zU80b/FtI0rqE0Zc+OHxRLGK3grCm6WkkKHDMZMskpeLDCD1wnRm4HSKGWN+IkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OcD67eL2; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763049155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0aseI6OseIhLle9z0TIJUXBxDfgB+PP1F776zvPg86w=;
	b=OcD67eL2D/fAb4UMXMVkT6oVR3dO6NqfPBh9x9n2VWLudSuJ8LJtILV8E1mVu1deFE5hkB
	0e+gUUGEzz6JfQd493Rj5TfsMU70llFU8um92qpiSNYmCnjN4VGZUY27EQGjpOeSoI4Fhl
	+73bhc3zZ0xb0X5MykYdR3uU+h4O6Gw=
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
Subject: [PATCH v2 3/7] of/fdt: Fix the len check in early_init_dt_check_for_usable_mem_range()
Date: Thu, 13 Nov 2025 23:51:00 +0800
Message-ID: <20251113155104.226617-4-yuntao.wang@linux.dev>
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

The len value is in bytes, while `dt_root_addr_cells + dt_root_size_cells`
is in cells (4 bytes per cell). Modulo calculation between them is
incorrect, the units must be converted first.

Use helper functions to simplify the code and fix this issue.

Fixes: fb319e77a0e7 ("of: fdt: Add memory for devices by DT property "linux,usable-memory-range"")
Fixes: 2af2b50acf9b9c38 ("of: fdt: Add generic support for handling usable memory range property")
Fixes: 8f579b1c4e347b23 ("arm64: limit memory regions based on DT property, usable-memory-range")
Signed-off-by: Yuntao Wang <yuntao.wang@linux.dev>
---
 drivers/of/fdt.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 80b7236efdc6..d0caaab42aa7 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -884,7 +884,7 @@ static unsigned long chosen_node_offset = -FDT_ERR_NOTFOUND;
 void __init early_init_dt_check_for_usable_mem_range(void)
 {
 	struct memblock_region rgn[MAX_USABLE_RANGES] = {0};
-	const __be32 *prop, *endp;
+	const __be32 *prop;
 	int len, i;
 	unsigned long node = chosen_node_offset;
 
@@ -893,14 +893,14 @@ void __init early_init_dt_check_for_usable_mem_range(void)
 
 	pr_debug("Looking for usable-memory-range property... ");
 
-	prop = of_get_flat_dt_prop(node, "linux,usable-memory-range", &len);
-	if (!prop || (len % (dt_root_addr_cells + dt_root_size_cells)))
+	prop = of_fdt_get_addr_size_prop(node, "linux,usable-memory-range", &len);
+	if (!prop)
 		return;
 
-	endp = prop + (len / sizeof(__be32));
-	for (i = 0; i < MAX_USABLE_RANGES && prop < endp; i++) {
-		rgn[i].base = dt_mem_next_cell(dt_root_addr_cells, &prop);
-		rgn[i].size = dt_mem_next_cell(dt_root_size_cells, &prop);
+	len = min(len, MAX_USABLE_RANGES);
+
+	for (i = 0; i < len; i++) {
+		of_fdt_read_addr_size(prop, &rgn[i].base, &rgn[i].size);
 
 		pr_debug("cap_mem_regions[%d]: base=%pa, size=%pa\n",
 			 i, &rgn[i].base, &rgn[i].size);
-- 
2.51.0


