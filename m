Return-Path: <linux-kernel+bounces-897413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C3EC5300B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC7CD4A0C34
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 14:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B9133B6D9;
	Wed, 12 Nov 2025 14:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lKpuLYlA"
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6622C08D0
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 14:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762958271; cv=none; b=U5fP/Lo8j2KlTPYvk7/YNL+o3S8bzxott7sVgzW96991uatXkLCsPRSUN9v53mxxBbfWnrUPw9zawkwBV5txP6tpKnUGe4VEc9m9G14c5ivgj5ImGis2dzllZXPSqHsfSozuOEmTxPLWFYth0U5L/4tpxqBTFT4Wyqt817nnB1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762958271; c=relaxed/simple;
	bh=pSEDF0lQrns4O+mgGf/8pTKIHRG1thwFT/osmPdyD/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ntyRxsrc4QLmgaGwcamb2ERNonx/DsF6gE0g/HKz3o6LC17Y99efgslyFjh5v5EITyRpfipdBqOz6ivvDJBRi5Fw2aEE5s9PvO+9mWs8rXigKrEjaSnoy7qai4EI/urDIpITZ0weH106eXJY15M/yB3DgL627/fBWP08n2yzLlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lKpuLYlA; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762958267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=faXAXnUs+8NBBg9gIqemj+jSYNFlpSi8A6Cs8E7MSs8=;
	b=lKpuLYlAiR8M/tyg+m/wkgUplZyhrBFQvlpgQtSFRAxLz21H/UnXLlaDHLwWdXPMr/wOe2
	SjSsdnWIk5yQZiirzmU1sQWDcSGdiZj6bbgopRJfe7hBlN2maeSgPgPsgXZKHxOD1lckCw
	Gh32Dlqjzx0PZGSMGabEE9WuUA+KAUk=
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
Subject: [PATCH 04/10] of/reserved_mem: Use dt_root_addr_size_bytes() instead of open-coding it
Date: Wed, 12 Nov 2025 22:35:14 +0800
Message-ID: <20251112143520.233870-5-yuntao.wang@linux.dev>
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
__reserved_mem_alloc_size() to improve code maintainability.

Signed-off-by: Yuntao Wang <yuntao.wang@linux.dev>
---
 drivers/of/of_reserved_mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 0e6b0e7968a9..8d9139f4297f 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -401,7 +401,7 @@ static int __init __reserved_mem_alloc_in_range(phys_addr_t size,
  */
 static int __init __reserved_mem_alloc_size(unsigned long node, const char *uname)
 {
-	int t_len = (dt_root_addr_cells + dt_root_size_cells) * sizeof(__be32);
+	int t_len = dt_root_addr_size_bytes();
 	phys_addr_t start = 0, end = 0;
 	phys_addr_t base = 0, align = 0, size;
 	int len;
-- 
2.51.0


