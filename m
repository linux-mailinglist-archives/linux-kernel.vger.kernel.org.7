Return-Path: <linux-kernel+bounces-897419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EA191C52E7A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 40F265063BE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 14:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430DC33F39A;
	Wed, 12 Nov 2025 14:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="B3pqmOmF"
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B012C0291
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 14:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762958305; cv=none; b=DBSUt0PSpX6BnHZd5etorPjbBSPZEw4pLg3JXJZZ0CKydpy3/6LstVyl4eeBgUiOmAk5WWFzpZ4+CWvf0+k9kfxrjzQk30sfec/bmppzaC94BqSIXBoEla4w8QfSt9hI6izhXxcyf7QNKAvNmvpQTNrTXsKGGlLb7Ghxy/aIm2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762958305; c=relaxed/simple;
	bh=qAG7b6CrmwLKHaVCzWq/kvbmltnv3ETfDbOsvIfJXV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pPf4XRZIg/N7ZT62FT75wwgdgxFJWRmIMAB7vxdCWbutr5ekmzZkj1pNLd0Oc8nWx0vXppzmO6MYF8ZGXBCqTmEde8VTARmioMDfYPZuPsZhDC92xJ/3TdMpoeAPEDVex+6Vzj0fe1eafXwilKAbHk2jTSru7+erGG6Q9wdVmd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=B3pqmOmF; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762958301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mJ9CLcfN3/lUzD4QHZAccL9Pko4Inb0IrARgPU8hdt8=;
	b=B3pqmOmFPFILayUt4AKybr26jCvdalYWj2gBgloX9wmh54weLwrXjasorDANmyKFQVMCDu
	B71ULAC8TqPe42qs0f927ErIupLIiQmH+HXmWWDxMVly2Gt1hJ5ZRNt4BjOKVNFyiPtdJZ
	OVlidgggOL+Frp2YQvmyCjw+XVLeoXA=
From: Yuntao Wang <yuntao.wang@linux.dev>
To: Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Catalin Marinas <catalin.marinas@arm.com>,
	AKASHI Takahiro <takahiro.akashi@linaro.org>,
	James Morse <james.morse@arm.com>,
	Chen Zhou <chenzhou10@huawei.com>,
	Baoquan He <bhe@redhat.com>,
	Zhen Lei <thunder.leizhen@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Changyuan Lyu <changyuanl@google.com>,
	Alexander Graf <graf@amazon.com>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuntao Wang <yuntao.wang@linux.dev>
Subject: [PATCH 08/10] of/fdt: Use dt_root_addr_size_bytes() instead of open-coding it
Date: Wed, 12 Nov 2025 22:35:18 +0800
Message-ID: <20251112143520.233870-9-yuntao.wang@linux.dev>
In-Reply-To: <20251112143520.233870-1-yuntao.wang@linux.dev>
References: <20251112143520.233870-1-yuntao.wang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Use dt_root_addr_size_bytes() instead of open-coding it in
early_init_dt_check_kho() to improve code maintainability.

Signed-off-by: Yuntao Wang <yuntao.wang@linux.dev>
---
 drivers/of/fdt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 0f95f3b356ea..fa1703612530 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -890,14 +890,14 @@ static void __init early_init_dt_check_kho(void)
 		return;
 
 	p = of_get_flat_dt_prop(node, "linux,kho-fdt", &l);
-	if (l != (dt_root_addr_cells + dt_root_size_cells) * sizeof(__be32))
+	if (l != dt_root_addr_size_bytes())
 		return;
 
 	fdt_start = dt_mem_next_cell(dt_root_addr_cells, &p);
 	fdt_size = dt_mem_next_cell(dt_root_addr_cells, &p);
 
 	p = of_get_flat_dt_prop(node, "linux,kho-scratch", &l);
-	if (l != (dt_root_addr_cells + dt_root_size_cells) * sizeof(__be32))
+	if (l != dt_root_addr_size_bytes())
 		return;
 
 	scratch_start = dt_mem_next_cell(dt_root_addr_cells, &p);
-- 
2.51.0


