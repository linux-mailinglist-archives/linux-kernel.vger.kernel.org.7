Return-Path: <linux-kernel+bounces-881823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B04D9C29023
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 15:18:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76FD7188D6CE
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 14:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92083221DB6;
	Sun,  2 Nov 2025 14:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="g9JIT4zb"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFD634D3BD
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 14:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762093112; cv=none; b=jKzgj2TFKO69TK7TZaJ9K4IKxA6hCWoTa0vVc0gtbqFeu7QyIFZpM50DjZ13Yd4oyTlBtenazg+YJc7TtjmFBVSEEQw6DyGIga1zpUTOE8Pf2L+dQOl14Y2FJ9UkgoM9mIITCLhXvCNdFitFr6uMGIrePade8XK8z9agPl6evAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762093112; c=relaxed/simple;
	bh=odmiv7j66umnneGAIRzkhz59fjHjPe49QLyX9JRICCU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jk1WM/QZd4mYkMExJgDQUiBg8Gja11mwiQmE9WkxywDGKs+p28YbplatnLU9XF11uegvW5BlsNJWjRNMvxN8SfhxDMBbBtCbYPAUiktYpoLOMIUlkFc+GXzumoW5EAms9kKjDJRUqeCOLUByrPak1eURMT4A8FvhGAROiWIZc0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=g9JIT4zb; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762093107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DwAmpZ0OhnkimfiVCLS+4vl8FTT7dy6wBUyJ70P/nm4=;
	b=g9JIT4zbB/XsNTdOqN9J435F2LcOwio3ZOSj5OZuoYoqnUHtyGMxRe4uUoYsEWwlqOu25/
	xHixLMiIH0NnAJnQm98AZ7tnv6ghFaJcAetcpEOvrCrp4TcI/xahblMjeRV9M07WvIKTDx
	9uR5VPrkgOU2Z7ifSte2uEQ1UWzP/gc=
From: Yuntao Wang <yuntao.wang@linux.dev>
To: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Yuntao Wang <yuntao.wang@linux.dev>
Subject: [PATCH] of: fdt: Fix the len check in early_init_dt_check_for_elfcorehdr()
Date: Sun,  2 Nov 2025 22:17:33 +0800
Message-ID: <20251102141733.160640-1-yuntao.wang@linux.dev>
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

Comparing them directly is incorrect. Convert units before comparison.

Fixes: f7e7ce93aac1 ("of: fdt: Add generic support for handling elf core headers property")
Signed-off-by: Yuntao Wang <yuntao.wang@linux.dev>
---
 drivers/of/fdt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 0edd639898a6..f79461f5cffc 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -812,6 +812,7 @@ static void __init early_init_dt_check_for_initrd(unsigned long node)
  */
 static void __init early_init_dt_check_for_elfcorehdr(unsigned long node)
 {
+	int t_len = (dt_root_addr_cells + dt_root_size_cells) * sizeof(__be32);
 	const __be32 *prop;
 	int len;
 
@@ -821,7 +822,7 @@ static void __init early_init_dt_check_for_elfcorehdr(unsigned long node)
 	pr_debug("Looking for elfcorehdr property... ");
 
 	prop = of_get_flat_dt_prop(node, "linux,elfcorehdr", &len);
-	if (!prop || (len < (dt_root_addr_cells + dt_root_size_cells)))
+	if (!prop || len < t_len)
 		return;
 
 	elfcorehdr_addr = dt_mem_next_cell(dt_root_addr_cells, &prop);
-- 
2.51.0


