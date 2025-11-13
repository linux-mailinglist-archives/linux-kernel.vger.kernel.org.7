Return-Path: <linux-kernel+bounces-899711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F3AC58A6A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 17:17:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 30B2E4F588F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 15:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991EA354ADC;
	Thu, 13 Nov 2025 15:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AbRu5Qpz"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F23E354719
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 15:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763049168; cv=none; b=isvBbjLjmUTFWU1z2PXD1zDYguC/POvTTf55NnsBMQ0XY+kC/G3h18/8w6iztl8Y7n+DzQAQnMZgNxyk+B3+GpQOnLfOtZaUzRjwLwhH2icSlxeSIKSGWcl5pEiTmHVL63NJ/belD6WzUy6+WL+MXxMIcBv+rdIYvQIvlWsELgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763049168; c=relaxed/simple;
	bh=5G5liWqxFwcJ7D8RGsG/gE2IicV/yIFdjGkZjr7uurQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b/LGO4S2elGdY3b+OjPorFsmr/GEBqXhXd48yGVwITchRhUdOQs2zWbxjFOgd2xUbf7/l20+aLhCII+eUpifN1CoZi9PpwwBw1dv2Ju78Au/d8OdM+GC8NyA9qXJTsS35XRKIRVSreN4gu01kCtbvNZqtdbdJbN1mIJ9fNGDfW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AbRu5Qpz; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763049164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qItt33BqcN4ZI2ZReVqmwV+XG/u/w5Cwqt20oaz5aDg=;
	b=AbRu5QpzyVlPqtd8LU36S3Ru7fu4y4YOTEd9tpa7DbdjEukuf3F0exSzOzVnt4IE8TZOlg
	kpDZR4r3/TEXAlUWfpa3eS/82ViLx7kPs9PLYupB7RRHUvaN8yc58p8jA4G3TLeDmx7KS8
	GTpYVka0FageKAGsVDEZnifspLLmOeY=
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
Subject: [PATCH v2 4/7] of/fdt: Fix incorrect use of dt_root_addr_cells in early_init_dt_check_kho()
Date: Thu, 13 Nov 2025 23:51:01 +0800
Message-ID: <20251113155104.226617-5-yuntao.wang@linux.dev>
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

When reading the fdt_size value, the argument passed to dt_mem_next_cell()
is dt_root_addr_cells, but it should be dt_root_size_cells.

The same issue occurs when reading the scratch_size value.

Use a helper function to simplify the code and fix these issues.

Fixes: 274cdcb1c004 ("arm64: add KHO support")
Signed-off-by: Yuntao Wang <yuntao.wang@linux.dev>
---
 drivers/of/fdt.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index d0caaab42aa7..4c45a97d6652 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -918,26 +918,16 @@ static void __init early_init_dt_check_kho(void)
 {
 	unsigned long node = chosen_node_offset;
 	u64 fdt_start, fdt_size, scratch_start, scratch_size;
-	const __be32 *p;
-	int l;
 
 	if (!IS_ENABLED(CONFIG_KEXEC_HANDOVER) || (long)node < 0)
 		return;
 
-	p = of_get_flat_dt_prop(node, "linux,kho-fdt", &l);
-	if (l != (dt_root_addr_cells + dt_root_size_cells) * sizeof(__be32))
+	if (!of_fdt_get_addr_size(node, "linux,kho-fdt", &fdt_start, &fdt_size))
 		return;
 
-	fdt_start = dt_mem_next_cell(dt_root_addr_cells, &p);
-	fdt_size = dt_mem_next_cell(dt_root_addr_cells, &p);
-
-	p = of_get_flat_dt_prop(node, "linux,kho-scratch", &l);
-	if (l != (dt_root_addr_cells + dt_root_size_cells) * sizeof(__be32))
+	if (!of_fdt_get_addr_size(node, "linux,kho-scratch", &scratch_start, &scratch_size))
 		return;
 
-	scratch_start = dt_mem_next_cell(dt_root_addr_cells, &p);
-	scratch_size = dt_mem_next_cell(dt_root_addr_cells, &p);
-
 	kho_populate(fdt_start, fdt_size, scratch_start, scratch_size);
 }
 
-- 
2.51.0


