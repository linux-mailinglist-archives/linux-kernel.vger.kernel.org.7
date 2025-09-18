Return-Path: <linux-kernel+bounces-820716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7F6B7E7FB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F878189ED3C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 12:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91FC1323415;
	Wed, 17 Sep 2025 12:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DLWfJ8m9"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41610323404
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 12:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758113321; cv=none; b=Q9XQHz5LZlzIgHr345S3rcwlOaxPsMeLODnijj7wfIJaxpXRNctmrtM3/QZewr2Z0qED2l187zL2t+ldWj4LraC3ZJzbTItfj2wIBLj3Y/VaeW3VvHWFUk/d1Spu6UaTRbyjK83O4DE3q2NT+QAykLYcsFKEG+yLLKmm+FwI5QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758113321; c=relaxed/simple;
	bh=YbJq3P/TZU2K2ux80KGT2m98HhdtTAbxEFtBXKaEhKY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PhJFaOFnGepsGPViq0Y5dwixZ9uQLKP5ERkEpHnaDus29BrjJa1Cz+xESTs0hCvCULepDY3g3uA5QPUV8kMhtO1ZvLmRHwjTWF/Fac/zoDa9aTDWVAZBlXlBKtPMy43iF0N/84AhotdvT/OQVoyG7yA9rpVNUk32vrjqVwCOuig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DLWfJ8m9; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758113307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RxC0Cr1ehjCehxLTRmCnW2KEy7H4kgU7hqTV5OPVQ4E=;
	b=DLWfJ8m9FnrZpN8BguJme7ABqGmSf3zIFcoWvcLxgdaBycv0s/Ijb+niC6ghLpBZD9CEqb
	NUvhG/2ofU0fRZABlhMCsYKmqNgX/0PfTY+LP95adRmlpjbZS2o6grLy0XZUq7KzlHZEWS
	WvQC3yhtf1D+DZd5zkLbD6jkt1SAvNg=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
	Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
	Oded Gabbay <ogabbay@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] accel/qaic: Replace kzalloc + copy_from_user with memdup_user
Date: Wed, 17 Sep 2025 14:48:04 +0200
Message-ID: <20250917124805.90395-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace kzalloc() followed by copy_from_user() with memdup_user() to
improve and simplify qaic_attach_slice_bo_ioctl().

No functional changes intended.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/accel/qaic/qaic_data.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/accel/qaic/qaic_data.c b/drivers/accel/qaic/qaic_data.c
index 797289e9d780..202bdca58847 100644
--- a/drivers/accel/qaic/qaic_data.c
+++ b/drivers/accel/qaic/qaic_data.c
@@ -18,6 +18,7 @@
 #include <linux/scatterlist.h>
 #include <linux/spinlock.h>
 #include <linux/srcu.h>
+#include <linux/string.h>
 #include <linux/types.h>
 #include <linux/uaccess.h>
 #include <linux/wait.h>
@@ -984,18 +985,12 @@ int qaic_attach_slice_bo_ioctl(struct drm_device *dev, void *data, struct drm_fi
 
 	user_data = u64_to_user_ptr(args->data);
 
-	slice_ent = kzalloc(arg_size, GFP_KERNEL);
-	if (!slice_ent) {
-		ret = -EINVAL;
+	slice_ent = memdup_user(user_data, arg_size);
+	if (IS_ERR(slice_ent)) {
+		ret = PTR_ERR(slice_ent);
 		goto unlock_dev_srcu;
 	}
 
-	ret = copy_from_user(slice_ent, user_data, arg_size);
-	if (ret) {
-		ret = -EFAULT;
-		goto free_slice_ent;
-	}
-
 	obj = drm_gem_object_lookup(file_priv, args->hdr.handle);
 	if (!obj) {
 		ret = -ENOENT;
-- 
2.51.0


