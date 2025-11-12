Return-Path: <linux-kernel+bounces-897418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A0DB0C52DD2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 647C7505D29
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 14:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1009833F363;
	Wed, 12 Nov 2025 14:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="m/6pSkkz"
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6B2338F23
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 14:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762958296; cv=none; b=i3lBcnb8GsuNbxV9hsmj1Y/OY86niy5PY97qFklc1aaHpW1eJhjbXMqIEX4aymt4bpPLtgj2Jw1tpXQiW10ExyqWnfvCxWrgvdS5eqVv8zEo/ZYXGoRa+8sDBX8zA80gcZWqGwQaye32j5Z3zUg/HD+YRZ3IKthaGu92ikIG/JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762958296; c=relaxed/simple;
	bh=SVrdZokn4Lg3YZClW7Ovq1EP/NlP9+GFaTssSuYuBNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k+HQKSTumqqU68+nq+Di8HC4a9gWK/aVUFfDhZSczVhu5Ftn/ro/rRSoRtimE2QFko6GZ2XE8FNHUgGSLStlZeclKPFwYe35NJuCZexRsxiVWpfUEcWO1PYCaMmtBfX4dgIdzQZIGV4NwzweQEft1gNiyiV2GbFRMc/1X27EziY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=m/6pSkkz; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762958293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g+5LIko+l4oTBneHg9zMPQiGx1ZkBFSa9O+/fWSP2Kc=;
	b=m/6pSkkzPaGWn3w1k8m6Mx3J6tBEDh4LMCobyaYJQJGhNox3kBUUysBW/zgqsdWBc7vGgr
	c1cJQKUgFf+9ugfCcIl41hdQ6FX0hMeY088TGLhtNXnH2Q4whramE+hJxY1f0s9yERwK8J
	gEZtK5djniqHZxCBht/kGF8XMNjOwPo=
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
Subject: [PATCH 07/10] of/fdt: Fix the len check in early_init_dt_check_for_usable_mem_range()
Date: Wed, 12 Nov 2025 22:35:17 +0800
Message-ID: <20251112143520.233870-8-yuntao.wang@linux.dev>
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

The len value is in bytes, while `dt_root_addr_cells + dt_root_size_cells`
is in cells (4 bytes per cell).

The modulo calculation between them is incorrect, the units must be
converted first.

Fixes: fb319e77a0e7 ("of: fdt: Add memory for devices by DT property "linux,usable-memory-range"")
Signed-off-by: Yuntao Wang <yuntao.wang@linux.dev>
---
 drivers/of/fdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 716ebe8c23d3..0f95f3b356ea 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -859,7 +859,7 @@ void __init early_init_dt_check_for_usable_mem_range(void)
 	pr_debug("Looking for usable-memory-range property... ");
 
 	prop = of_get_flat_dt_prop(node, "linux,usable-memory-range", &len);
-	if (!prop || (len % (dt_root_addr_cells + dt_root_size_cells)))
+	if (!prop || len % dt_root_addr_size_bytes())
 		return;
 
 	endp = prop + (len / sizeof(__be32));
-- 
2.51.0


