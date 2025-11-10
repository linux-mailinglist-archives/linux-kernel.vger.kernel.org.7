Return-Path: <linux-kernel+bounces-893407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 367B8C474BB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 740C54EBAB3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 14:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0113148DC;
	Mon, 10 Nov 2025 14:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="FX5H9SQu"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FACC313E05
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 14:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762785836; cv=none; b=dvW2J3fwR+fB69O7nv/f/vqKCF86969bpbvWM0dN/BGa2I3JGxNbFGTzhTvpTLpjht4nfKUmUpLJvYaqZDmmfLaOlvFV567kFTfC9QM5DpyXN1N+HJBvhL2lRdLjy3IazC4xV6ZtC18rDMg3SIJftA0D8Ql6aXJ6FgHxqXg0iHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762785836; c=relaxed/simple;
	bh=Bson1PPVrGZlb/SfSMPl2OYVIHIDAfmldLSUbwR78d4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DQ8OQHctAqkXmSfu/O2EpEfPYh2LlUr7AkojPrdhKXUQLll5SyuWYpIwuZ/jI1evE8oADuwdLS0udUDHckzrqySxz81GI1KwtyC8df0wcl2kz4E5AfmiGL2PTwyKl3tq737suZokou3VM11d7TtK9aU3k9xOGyEarOf1CR0SJ8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=FX5H9SQu; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1762785832;
	bh=Bson1PPVrGZlb/SfSMPl2OYVIHIDAfmldLSUbwR78d4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FX5H9SQuEP8ju+YViXuMsCREh/SmnYdcBryygHQU98JZs6NtqRwu3B9Vlju2T3vPZ
	 mCBb0Qaorvh5CdX6xqbxHGnxwesODRoFU4D3rDt8q21JBMPs1e+k0X4E0lOZWcXTLx
	 kDP4zkI55Y1SVT9eVmY9OxeWAVxhliJOHKxuRsrM3SbgYb34KoUjT/Zb4tjoN5tyTj
	 aXNOAqcjb6/c28wzC8W23N3sVJEfX8s0UpgcvMcGsclxfSn+pPY2UvtlN3I+vdwNCX
	 aPDE8ySbPWgguLLrBswMSbHbcZLvC/kZubFRFkJQuLKL8j6rBFn4mCSl61YnYy0+gW
	 sMij4A5SHs/6Q==
Received: from localhost.localdomain (unknown [92.206.121.173])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: gerddie)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 71B2417E13B2;
	Mon, 10 Nov 2025 15:43:52 +0100 (CET)
From: gert.wollny@collabora.com
To: Christian Gmeiner <christian.gmeiner@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>,
	Russell King <linux+etnaviv@armlinux.org.uk>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	etnaviv@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Gert Wollny <gert.wollny@collabora.com>
Subject: [PATCH v4 2/5] drm/etnaviv: move some functions to a header to be able to use them externally
Date: Mon, 10 Nov 2025 15:37:48 +0100
Message-ID: <20251110144625.18653-3-gert.wollny@collabora.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251110144625.18653-1-gert.wollny@collabora.com>
References: <20250630202703.13844-1-gert.wollny@collabora.com>
 <20251110144625.18653-1-gert.wollny@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gert Wollny <gert.wollny@collabora.com>

v2: Add license info to header

Signed-off-by: Gert Wollny <gert.wollny@collabora.com>
---
 drivers/gpu/drm/etnaviv/etnaviv_buffer.c | 71 +------------------
 drivers/gpu/drm/etnaviv/etnaviv_buffer.h | 86 ++++++++++++++++++++++++
 2 files changed, 87 insertions(+), 70 deletions(-)
 create mode 100644 drivers/gpu/drm/etnaviv/etnaviv_buffer.h

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_buffer.c b/drivers/gpu/drm/etnaviv/etnaviv_buffer.c
index d4f1307d574f..5be9978e34d9 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_buffer.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_buffer.c
@@ -10,6 +10,7 @@
 #include "etnaviv_gpu.h"
 #include "etnaviv_gem.h"
 #include "etnaviv_mmu.h"
+#include "etnaviv_buffer.h"
 
 #include "common.xml.h"
 #include "state.xml.h"
@@ -18,76 +19,6 @@
 #include "state_3d.xml.h"
 #include "cmdstream.xml.h"
 
-/*
- * Command Buffer helper:
- */
-
-
-static inline void OUT(struct etnaviv_cmdbuf *buffer, u32 data)
-{
-	u32 *vaddr = (u32 *)buffer->vaddr;
-
-	BUG_ON(buffer->user_size >= buffer->size);
-
-	vaddr[buffer->user_size / 4] = data;
-	buffer->user_size += 4;
-}
-
-static inline void CMD_LOAD_STATE(struct etnaviv_cmdbuf *buffer,
-	u32 reg, u32 value)
-{
-	u32 index = reg >> VIV_FE_LOAD_STATE_HEADER_OFFSET__SHR;
-
-	buffer->user_size = ALIGN(buffer->user_size, 8);
-
-	/* write a register via cmd stream */
-	OUT(buffer, VIV_FE_LOAD_STATE_HEADER_OP_LOAD_STATE |
-		    VIV_FE_LOAD_STATE_HEADER_COUNT(1) |
-		    VIV_FE_LOAD_STATE_HEADER_OFFSET(index));
-	OUT(buffer, value);
-}
-
-static inline void CMD_END(struct etnaviv_cmdbuf *buffer)
-{
-	buffer->user_size = ALIGN(buffer->user_size, 8);
-
-	OUT(buffer, VIV_FE_END_HEADER_OP_END);
-}
-
-static inline void CMD_WAIT(struct etnaviv_cmdbuf *buffer,
-			    unsigned int waitcycles)
-{
-	buffer->user_size = ALIGN(buffer->user_size, 8);
-
-	OUT(buffer, VIV_FE_WAIT_HEADER_OP_WAIT | waitcycles);
-}
-
-static inline void CMD_LINK(struct etnaviv_cmdbuf *buffer,
-	u16 prefetch, u32 address)
-{
-	buffer->user_size = ALIGN(buffer->user_size, 8);
-
-	OUT(buffer, VIV_FE_LINK_HEADER_OP_LINK |
-		    VIV_FE_LINK_HEADER_PREFETCH(prefetch));
-	OUT(buffer, address);
-}
-
-static inline void CMD_STALL(struct etnaviv_cmdbuf *buffer,
-	u32 from, u32 to)
-{
-	buffer->user_size = ALIGN(buffer->user_size, 8);
-
-	OUT(buffer, VIV_FE_STALL_HEADER_OP_STALL);
-	OUT(buffer, VIV_FE_STALL_TOKEN_FROM(from) | VIV_FE_STALL_TOKEN_TO(to));
-}
-
-static inline void CMD_SEM(struct etnaviv_cmdbuf *buffer, u32 from, u32 to)
-{
-	CMD_LOAD_STATE(buffer, VIVS_GL_SEMAPHORE_TOKEN,
-		       VIVS_GL_SEMAPHORE_TOKEN_FROM(from) |
-		       VIVS_GL_SEMAPHORE_TOKEN_TO(to));
-}
-
 static void etnaviv_cmd_select_pipe(struct etnaviv_gpu *gpu,
 	struct etnaviv_cmdbuf *buffer, u8 pipe)
 {
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_buffer.h b/drivers/gpu/drm/etnaviv/etnaviv_buffer.h
new file mode 100644
index 000000000000..ae1ba1db6c8a
--- /dev/null
+++ b/drivers/gpu/drm/etnaviv/etnaviv_buffer.h
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2014-2025 Etnaviv Project
+ */
+
+#ifndef etnaviv_buffer_h
+#define etnaviv_buffer_h
+
+#include "etnaviv_cmdbuf.h"
+#include "etnaviv_gpu.h"
+#include "etnaviv_gem.h"
+#include "etnaviv_mmu.h"
+
+#include "common.xml.h"
+#include "linux/printk.h"
+#include "state.xml.h"
+#include "state_blt.xml.h"
+#include "state_hi.xml.h"
+#include "state_3d.xml.h"
+#include "cmdstream.xml.h"
+
+static inline void OUT(struct etnaviv_cmdbuf *buffer, u32 data)
+{
+	u32 *vaddr = (u32 *)buffer->vaddr;
+
+	BUG_ON(buffer->user_size >= buffer->size);
+
+	vaddr[buffer->user_size / 4] = data;
+	buffer->user_size += 4;
+}
+
+static inline void CMD_LOAD_STATE(struct etnaviv_cmdbuf *buffer, u32 reg,
+				  u32 value)
+{
+	u32 index = reg >> VIV_FE_LOAD_STATE_HEADER_OFFSET__SHR;
+
+	buffer->user_size = ALIGN(buffer->user_size, 8);
+
+	/* write a register via cmd stream */
+	OUT(buffer, VIV_FE_LOAD_STATE_HEADER_OP_LOAD_STATE |
+			    VIV_FE_LOAD_STATE_HEADER_COUNT(1) |
+			    VIV_FE_LOAD_STATE_HEADER_OFFSET(index));
+	OUT(buffer, value);
+}
+
+static inline void CMD_END(struct etnaviv_cmdbuf *buffer)
+{
+	buffer->user_size = ALIGN(buffer->user_size, 8);
+
+	OUT(buffer, VIV_FE_END_HEADER_OP_END);
+}
+
+static inline void CMD_WAIT(struct etnaviv_cmdbuf *buffer,
+			    unsigned int waitcycles)
+{
+	buffer->user_size = ALIGN(buffer->user_size, 8);
+
+	OUT(buffer, VIV_FE_WAIT_HEADER_OP_WAIT | waitcycles);
+}
+
+static inline void CMD_LINK(struct etnaviv_cmdbuf *buffer, u16 prefetch,
+			    u32 address)
+{
+	buffer->user_size = ALIGN(buffer->user_size, 8);
+
+	OUT(buffer,
+	    VIV_FE_LINK_HEADER_OP_LINK | VIV_FE_LINK_HEADER_PREFETCH(prefetch));
+	OUT(buffer, address);
+}
+
+static inline void CMD_STALL(struct etnaviv_cmdbuf *buffer, u32 from, u32 to)
+{
+	buffer->user_size = ALIGN(buffer->user_size, 8);
+
+	OUT(buffer, VIV_FE_STALL_HEADER_OP_STALL);
+	OUT(buffer, VIV_FE_STALL_TOKEN_FROM(from) | VIV_FE_STALL_TOKEN_TO(to));
+}
+
+static inline void CMD_SEM(struct etnaviv_cmdbuf *buffer, u32 from, u32 to)
+{
+	CMD_LOAD_STATE(buffer, VIVS_GL_SEMAPHORE_TOKEN,
+		       VIVS_GL_SEMAPHORE_TOKEN_FROM(from) |
+			       VIVS_GL_SEMAPHORE_TOKEN_TO(to));
+}
+
+#endif
-- 
2.51.0


