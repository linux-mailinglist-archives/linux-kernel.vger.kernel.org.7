Return-Path: <linux-kernel+bounces-883231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DF108C2CBE2
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 16:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8C55034ACEC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 15:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9DE3191A4;
	Mon,  3 Nov 2025 15:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ExtowJG6"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D333A2E2665
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 15:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762183452; cv=none; b=o7XSJcyZDWBQ7bO0N78VBTCTXmtfeXl5Fgic4YH6nei8yLvREzJNqTRKdtYItpmHvcHV6hpo/BboSmqXE9Rnc1PgXPl4ZPhrDKu/k3jc42g2e3C6j6wNc7b5AzBmLZCT9N6fHx9jIt1iOAdAaoqIG9sx2H5vbcxzsP+4hG4nIwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762183452; c=relaxed/simple;
	bh=ccXE7l8rh76UqpN08+a+SSxEqMoYL8fV38Ef9NR6ecY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=g1KneQkVsuCFYDGt4AD21/JlHMxViKzOShOWsP219HQKWYXd4j2y15133YFZj7Hk2RtxW9/uMgzWPMA+UckrBmU97VJ9riLsiedfl+ekTBRTtAVzKU3gFfnI2V7TNFCAVAPkB4MksULJVPu4PHEmUYrdl27o3fO816BK/LFZttw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ExtowJG6; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762183445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bafh6Qz+/AR0dvxRSvNKPJVNHyEjLHl83jQu2pz2VaQ=;
	b=ExtowJG6k8ibWUtu1chzuZs5NfMgy5tLtx5y0m0R4Ub6M15dCtEAVFjRv23Ly1Z7pZp84Z
	xQXT5HVu4vmDD49ewnTlNwDTeQlPymJIQi6UuZ4fBZhNokaCrgOuPC201pPfMf7qrnx3yd
	VCVHRQ6k3es432+8sGlrBOsfesx6qrY=
From: Dawei Li <dawei.li@linux.dev>
To: catalin.marinas@arm.com,
	will@kernel.org
Cc: mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	dawei.li@linux.dev,
	set_pte_at@outlook.com
Subject: [PATCH] arm64: Remove assertion on CONFIG_VMAP_STACK
Date: Mon,  3 Nov 2025 23:23:45 +0800
Message-Id: <20251103152345.175463-1-dawei.li@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

CONFIG_VMAP_STACK is selected by arm64 arch unconditionly since commit
ef6861b8e6dd ("arm64: Mandate VMAP_STACK").

Remove the redundant assertion and headers.

Signed-off-by: Dawei Li <dawei.li@linux.dev>
---
 arch/arm64/include/asm/vmap_stack.h | 4 ----
 arch/arm64/kernel/sdei.c            | 4 ----
 2 files changed, 8 deletions(-)

diff --git a/arch/arm64/include/asm/vmap_stack.h b/arch/arm64/include/asm/vmap_stack.h
index 20873099c035..75daee1a07e9 100644
--- a/arch/arm64/include/asm/vmap_stack.h
+++ b/arch/arm64/include/asm/vmap_stack.h
@@ -3,9 +3,7 @@
 #ifndef __ASM_VMAP_STACK_H
 #define __ASM_VMAP_STACK_H
 
-#include <linux/bug.h>
 #include <linux/gfp.h>
-#include <linux/kconfig.h>
 #include <linux/vmalloc.h>
 #include <linux/pgtable.h>
 #include <asm/memory.h>
@@ -19,8 +17,6 @@ static inline unsigned long *arch_alloc_vmap_stack(size_t stack_size, int node)
 {
 	void *p;
 
-	BUILD_BUG_ON(!IS_ENABLED(CONFIG_VMAP_STACK));
-
 	p = __vmalloc_node(stack_size, THREAD_ALIGN, THREADINFO_GFP, node,
 			__builtin_return_address(0));
 	return kasan_reset_tag(p);
diff --git a/arch/arm64/kernel/sdei.c b/arch/arm64/kernel/sdei.c
index 95169f7b6531..213ac72ce4fd 100644
--- a/arch/arm64/kernel/sdei.c
+++ b/arch/arm64/kernel/sdei.c
@@ -63,8 +63,6 @@ static void free_sdei_stacks(void)
 {
 	int cpu;
 
-	BUILD_BUG_ON(!IS_ENABLED(CONFIG_VMAP_STACK));
-
 	for_each_possible_cpu(cpu) {
 		_free_sdei_stack(&sdei_stack_normal_ptr, cpu);
 		_free_sdei_stack(&sdei_stack_critical_ptr, cpu);
@@ -88,8 +86,6 @@ static int init_sdei_stacks(void)
 	int cpu;
 	int err = 0;
 
-	BUILD_BUG_ON(!IS_ENABLED(CONFIG_VMAP_STACK));
-
 	for_each_possible_cpu(cpu) {
 		err = _init_sdei_stack(&sdei_stack_normal_ptr, cpu);
 		if (err)
-- 
2.25.1


