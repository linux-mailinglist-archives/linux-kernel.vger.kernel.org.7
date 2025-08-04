Return-Path: <linux-kernel+bounces-755509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71201B1A733
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 18:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0779218A329F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 16:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100FC2853EA;
	Mon,  4 Aug 2025 16:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HfghvHdR"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF44284B3C
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 16:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754325562; cv=none; b=M+J9ggKZR0F7xPlupaQD/gTsg9N7bnKGm46DVlBvsRbY3rJQYZxGCbmOUeArFCxDZa3hJh53RjpcDo8Bf5qZMRM+lQ8HDXN7JGGDuKRcCIJrFVUSj5azxL4SMZMz+HK4hehEqas8N5kfcQBecp6m3Ctp2mDqa4JURjQB2Q9v8v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754325562; c=relaxed/simple;
	bh=2JiMqECXBzZL4ZOZ/Aoaorck/DtLPL5CHdofOw3mxQo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=C2BlYk2NzoZJZU7n08esAg2tC7tCFBO6hlxyaClABO0D7UChMVJmTik1IrHaHN3hJO4dohJvEwzjeng2Jm8DWcZPu5umvzk4zx8sPL2O16tbI5rTalK/8QKDOVlaDsD5/jaeDmIsel5Hws6CZHghZo0rFSj+39//yERA7jFLdzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HfghvHdR; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-76bdc73f363so2771155b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 09:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754325559; x=1754930359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cVPrmbkZ73iVJwd3+ZUBlBPewKbjKO3MTkVJSkmJKWA=;
        b=HfghvHdRlkfI8/EqjEtzYkWcY2Vzn5mSjd9nrK2MGPpch+mVFigHMLWIpoUB7nAMPM
         +RIdtNZEdbvIelpAkVQcfjipeL6VJUNRh0s96BZsD+ADLIeFRWFpuGGsk/cL4AEPfhu+
         sAzLToK0ETs75qQal8TKEj5DimTHeZ+7h3oCGvzL655nIp5tz9Nas2M5Zspyg9LgigbE
         AlGEVe/u4qvF495HRDsK8mS8S33p5iYsQ8NbsJfT8N1k8v2ygNTa8n+ILobRCiJ23lY9
         Eiyv2OrSxVg9HxKkXJoAMcdln8497LfN+iE6+ZD4d3tTxrXEnOvK7nVmF9LPsRIuvASp
         Wj7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754325559; x=1754930359;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cVPrmbkZ73iVJwd3+ZUBlBPewKbjKO3MTkVJSkmJKWA=;
        b=qRglFx8VXvV08hsLLv7YKsFWKRYTf2vWYtr8fdWluxiVzVHmd3cY2ZQGZR0Vy4xSdn
         EK3mrkg4+Ud+e44loNXNqOcVXjz7MR9VZSH2qe+r3OaX/N1BxNpbZFgXBWhKT/XyfI7V
         yuC+k9koYLfM704pM0etDzCkbjPLf9UajUiJlyEGARBVnNdqm1HIs73dKBdjODcdJUPw
         VhEioQnwUM/yZanzbW3dnTe8hdpXcNyCGK7b5xz1jLLiYE2TYIbxpYz9PpDVTIuThWYd
         8NYesBSA4uN1Gy8VGEmqna+QAH2KEvlSRiqYC8D8IKQl4PMqmaB3lsTsKbVfG7QxYGYJ
         zo8A==
X-Forwarded-Encrypted: i=1; AJvYcCVNQuLw6TUSfogc3Qj6BldnIp23dH1Q9dbWsmJgiDsIMliWthSOqKSu/OVunOyJKPPOOVSv3sdVeWTXv9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YykL1D6R95WfxA8/j7znREienvd+e/i97AHshwnd3BdH2DfwegH
	EChGNBk7OZBAIMH7mRlGnuQ3Ofve0ULGSsN2XJT3ZAqWiZHt3YG4q22s
X-Gm-Gg: ASbGnctvDHkEF9FPIJWM8aM9QA7fas1bUW5fShoHeHwuiz0a9HteZBYx1VyHyCTfZPw
	lPl4dBaPKl1IrFSKqFzcCt/88M2Vh25PbC3BH3NUFNER3hq0nr7OofkMSh4pE/4MtdAwvHdWLVq
	lkKWhev0AYZQZldT9hWf5JORS6Il+fLFUj9RskOtAUy/5zfD/9dxIiNxvPG9BLHbySRD2qkEbk3
	0Ud0BCCue3DlfWkS28fg24sZ5ZUzHm1DKtS4FlKk2L8CV9tPYR1q5AJho2mbyrpMfW7PL/+SStJ
	7RKNTr17zsRDF6vwxjrIytskGnmyOm4LXcFRsWwUmxVobWYp440frsJZd5JaegywdQWh9UZgbs2
	xW08RxYLkkePLZ4lVNVeEeKDGvTHZnl5f
X-Google-Smtp-Source: AGHT+IFi79lN/2bT4m6O+DU+KDLEB7fni7m9KzcUQy4aTZNiqS5EEpJ8WsqlPli1870xPayfoD6Bqw==
X-Received: by 2002:a05:6a21:99a0:b0:240:aa7:ba66 with SMTP id adf61e73a8af0-2400aa7bb53mr5414989637.16.1754325559025;
        Mon, 04 Aug 2025 09:39:19 -0700 (PDT)
Received: from avinash ([2406:8800:9014:d938:f647:9d6a:9509:bc41])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422bb0a4b0sm9500306a12.59.2025.08.04.09.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 09:39:18 -0700 (PDT)
From: Abinash Singh <abinashsinghlalotra@gmail.com>
To: min.ma@amd.com,
	lizhi.hou@amd.com
Cc: ogabbay@kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Abinash Singh <abinashsinghlalotra@gmail.com>
Subject: [RFC PATCH] drivers/accel/amdxdna : refactor resource cleanup in aie2_{ctx, error} to use scope-based helpers
Date: Mon,  4 Aug 2025 22:09:46 +0530
Message-ID: <20250804163947.630568-1-abinashsinghlalotra@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This refactors the `aie2_error_async_events_alloc` function in `aie2_ctx.c`
And `aie2_hwctx_init` function in `aie2_error.c` to replace traditional
goto-based error handling with scope-based cleanup helpers.

No functional changes intended.

Signed-off-by: Abinash Singh <abinashsinghlalotra@gmail.com>
---
Hi ,
This patch will improve code quaility and will support
using cleanup helpers in future.

Reference : https://docs.kernel.org/core-api/cleanup.html
......
The “goto error” pattern is notorious for introducing subtle resource leaks.
It is tedious and error prone to add new resource acquisition constraints into 
code paths that already have several unwind conditions. The “cleanup” helpers 
enable the compiler to help with this tedium and can aid in maintaining
LIFO (last in first out) unwind ordering to avoid unintentional leaks.
...

I will look into other places where we can use this auto cleanup feature.
If you have any suggestion/feedback I will be happy hearing that.

Thank You!
Have a great day..!!
---
 drivers/accel/amdxdna/aie2_ctx.c   | 9 +++------
 drivers/accel/amdxdna/aie2_error.c | 9 +++------
 2 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie2_ctx.c
index e04549f64d69..b860859c643d 100644
--- a/drivers/accel/amdxdna/aie2_ctx.c
+++ b/drivers/accel/amdxdna/aie2_ctx.c
@@ -13,7 +13,7 @@
 #include <linux/types.h>
 #include <linux/xarray.h>
 #include <trace/events/amdxdna.h>
-
+#include <linux/cleanup.h>
 #include "aie2_msg_priv.h"
 #include "aie2_pci.h"
 #include "aie2_solver.h"
@@ -528,7 +528,7 @@ int aie2_hwctx_init(struct amdxdna_hwctx *hwctx)
 		.dev = xdna->ddev.dev,
 	};
 	struct drm_gpu_scheduler *sched;
-	struct amdxdna_hwctx_priv *priv;
+	struct amdxdna_hwctx_priv *priv __free(kfree) = NULL;
 	struct amdxdna_gem_obj *heap;
 	struct amdxdna_dev_hdl *ndev;
 	int i, ret;
@@ -543,8 +543,7 @@ int aie2_hwctx_init(struct amdxdna_hwctx *hwctx)
 	if (!heap) {
 		XDNA_ERR(xdna, "The client dev heap object not exist");
 		mutex_unlock(&client->mm_lock);
-		ret = -ENOENT;
-		goto free_priv;
+		return -ENOENT;
 	}
 	drm_gem_object_get(to_gobj(heap));
 	mutex_unlock(&client->mm_lock);
@@ -648,8 +647,6 @@ int aie2_hwctx_init(struct amdxdna_hwctx *hwctx)
 	amdxdna_gem_unpin(heap);
 put_heap:
 	drm_gem_object_put(to_gobj(heap));
-free_priv:
-	kfree(priv);
 	return ret;
 }
 
diff --git a/drivers/accel/amdxdna/aie2_error.c b/drivers/accel/amdxdna/aie2_error.c
index 5ee905632a39..bea36e7fe14f 100644
--- a/drivers/accel/amdxdna/aie2_error.c
+++ b/drivers/accel/amdxdna/aie2_error.c
@@ -10,7 +10,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/kthread.h>
 #include <linux/kernel.h>
-
+#include <linux/cleanup.h>
 #include "aie2_msg_priv.h"
 #include "aie2_pci.h"
 #include "amdxdna_mailbox.h"
@@ -308,7 +308,7 @@ int aie2_error_async_events_alloc(struct amdxdna_dev_hdl *ndev)
 	struct amdxdna_dev *xdna = ndev->xdna;
 	u32 total_col = ndev->total_col;
 	u32 total_size = ASYNC_BUF_SIZE * total_col;
-	struct async_events *events;
+	struct async_events *events __free(kfree) = NULL;
 	int i, ret;
 
 	events = kzalloc(struct_size(events, event, total_col), GFP_KERNEL);
@@ -318,8 +318,7 @@ int aie2_error_async_events_alloc(struct amdxdna_dev_hdl *ndev)
 	events->buf = dma_alloc_noncoherent(xdna->ddev.dev, total_size, &events->addr,
 					    DMA_FROM_DEVICE, GFP_KERNEL);
 	if (!events->buf) {
-		ret = -ENOMEM;
-		goto free_events;
+		return -ENOMEM;
 	}
 	events->size = total_size;
 	events->event_cnt = total_col;
@@ -352,7 +351,5 @@ int aie2_error_async_events_alloc(struct amdxdna_dev_hdl *ndev)
 free_buf:
 	dma_free_noncoherent(xdna->ddev.dev, events->size, events->buf,
 			     events->addr, DMA_FROM_DEVICE);
-free_events:
-	kfree(events);
 	return ret;
 }
-- 
2.50.1


