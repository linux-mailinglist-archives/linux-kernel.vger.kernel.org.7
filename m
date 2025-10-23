Return-Path: <linux-kernel+bounces-866140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF62BBFEFCF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 05:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65BA819A1960
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 03:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A0E21A421;
	Thu, 23 Oct 2025 03:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Jqx9qei2"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72151ACEDA
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 03:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761190089; cv=none; b=k5sMOmeBikj4XRtR18bchjowXJ5hTkR7AbF5UGIBQRI9Jwrxk195haEXddr2wwKU25yRkzJhsRP9VzY4OMSUGEpitDoE/GULEnX0tqNeWPa3FvvW5MsVoNkQUwAC5TDv8xOvXcBOps4ejfPTytJmsl48VQh0+UbompaELDEWkIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761190089; c=relaxed/simple;
	bh=HDvsJVerANB6k8ZYzF4IUiyGfN9gVazoO/auRD7zCq4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SHRi8XZKgJ4AcFuR6s0ui2EPAc6C2JMnC0/KHQkjvmH7fht7FErPE2MIBIAjBOiSvtUYmj8jzD3mlqz/H/bKsC1yNsXO2Bib+RHNJUprvMIjjNRYPvz7q2fX2Rtx3ibQAxDgHTpABZQZqnDBY0HXw/AwwpiQXIamacyJON9lQHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Jqx9qei2; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761190080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AoeKjWwnaxUejuF8nD7wrOVnfoZCZt8LH0kxVtkpQJY=;
	b=Jqx9qei2JfA4DYBsArsRFkV6WKvjQ5Y2ZXjogunLhi35O4h2vjHC3WaxYroYkkO3ZmQoQ9
	rtNRmbJ9gpDqJPFyOOgRSvXW9c/htmZCe8WDZBxmuiLokvqwOUORqYK16InrqngY/rpw3D
	fMLtyakARgEpQU1feVHtKdhrVozNDFM=
From: Kunwu Chan <kunwu.chan@linux.dev>
To: paulmck@kernel.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com,
	josh@joshtriplett.org,
	boqun.feng@gmail.com,
	urezki@gmail.com,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang@linux.dev
Cc: rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH] rcu: Improve comments for RCU_FANOUT and RCU_FANOUT_LEAF
Date: Thu, 23 Oct 2025 11:27:42 +0800
Message-Id: <20251023032742.2850029-1-kunwu.chan@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Kunwu Chan <chentao@kylinos.cn>

The original comments introduced in commit 05c5df31afd1
("rcu: Make RCU able to tolerate undefined CONFIG_RCU_FANOUT"),
contained confusing annotations.

Specifically, the #else and #endif comments did not clearly reflect
their corresponding condition blocks, hampering readability.

Fixes condition branch comments. And adds explicit explanations of
the overall purpose:
defining middle/leaf fan-out parameters, their relation to Kconfig,
and how they shape the RCU hierarchy based on CPU count.

Make the hierarchical configuration logic of the RCU easier to understand.

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 include/linux/rcu_node_tree.h | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/include/linux/rcu_node_tree.h b/include/linux/rcu_node_tree.h
index 78feb8ba7358..b03c0ce91dec 100644
--- a/include/linux/rcu_node_tree.h
+++ b/include/linux/rcu_node_tree.h
@@ -25,26 +25,34 @@
 /*
  * Define shape of hierarchy based on NR_CPUS, CONFIG_RCU_FANOUT, and
  * CONFIG_RCU_FANOUT_LEAF.
+ * - RCU_FANOUT: Controls fan-out of middle levels in the RCU hierarchy.
+ * - RCU_FANOUT_LEAF: Controls fan-out of the leaf level (directly managing CPUs).
+ *
+ * These parameters are determined by Kconfig options if configured; otherwise,
+ * they use sensible defaults based on system architecture (for RCU_FANOUT)
+ * or a fixed default (for RCU_FANOUT_LEAF).
  * In theory, it should be possible to add more levels straightforwardly.
  * In practice, this did work well going from three levels to four.
  * Of course, your mileage may vary.
  */
 
+/* Define RCU_FANOUT: middle-level fan-out parameter */
 #ifdef CONFIG_RCU_FANOUT
 #define RCU_FANOUT CONFIG_RCU_FANOUT
-#else /* #ifdef CONFIG_RCU_FANOUT */
+#else /* #ifndef CONFIG_RCU_FANOUT */
 # ifdef CONFIG_64BIT
 # define RCU_FANOUT 64
 # else
 # define RCU_FANOUT 32
 # endif
-#endif /* #else #ifdef CONFIG_RCU_FANOUT */
+#endif
 
+/* Define RCU_FANOUT_LEAF: leaf-level fan-out parameter (manages CPUs directly) */
 #ifdef CONFIG_RCU_FANOUT_LEAF
 #define RCU_FANOUT_LEAF CONFIG_RCU_FANOUT_LEAF
-#else /* #ifdef CONFIG_RCU_FANOUT_LEAF */
+#else /* #ifndef CONFIG_RCU_FANOUT_LEAF */
 #define RCU_FANOUT_LEAF 16
-#endif /* #else #ifdef CONFIG_RCU_FANOUT_LEAF */
+#endif
 
 #define RCU_FANOUT_1	      (RCU_FANOUT_LEAF)
 #define RCU_FANOUT_2	      (RCU_FANOUT_1 * RCU_FANOUT)
-- 
2.25.1


