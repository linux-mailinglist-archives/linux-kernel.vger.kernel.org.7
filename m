Return-Path: <linux-kernel+bounces-806773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD41B49BB2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 23:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9816E4E6204
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 21:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC932DEA62;
	Mon,  8 Sep 2025 21:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SZVNXgjb"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E246235050
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 21:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757366210; cv=none; b=Z5BiMj51MQGQ4x3OfaF4JnGGG0wCTNHU6oeSIlEeUAIwEOBpRAw84DkCmATKyHbHS7FOWwQz+DgeJwxsrXOmHmr29lB3vZkGbt3rR7OfhSMns2XmA00GxBgdV47ijwHshGJHwgsp0a5MX4R2vUMeySMXG6PExypvkbWnx/daEOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757366210; c=relaxed/simple;
	bh=xSbZYXzjRt/DluUSiUuRueLHw7WiHnROC6mNiO/p5Js=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RMSpbSFeWVwxDHqmKJJ5aFrSUjnL5v/xMetIPK8ujr6Z991sU1Ky6Tqihb+HjYPZm0JZV26TNuvrXlSjR6oIyDFk+QBOuAYfvv5fb5sFP/3SuYqUlHef1YZtYzOb9e+2vH38M99toRThYtZrgfz+4IXs+bkXyW5QqYRtlnQojcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SZVNXgjb; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757366205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QZs1MddN1kGIVjCYk+noKB3uCgeYjjNDvqCYGlqZzmg=;
	b=SZVNXgjb9TnYg2XcQ9CFKP0Qu82TKnE8YlVs6g7p/R22Jgq8Qo+SV+ZfhhqZpjaZqo0qNZ
	/R0b/0VH1oYOuCXUORdj8Dfm56YLe4zAzueii2cJh9+BVjt6/zY/l1tOeZVQS2U33/oBMt
	SzkZIe7g6277KvWd5pyPN44fgBO8zyk=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amdgpu: Replace kzalloc + copy_from_user with memdup_user
Date: Mon,  8 Sep 2025 23:15:54 +0200
Message-ID: <20250908211559.519892-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace kzalloc() followed by copy_from_user() with memdup_user() to
improve and simplify ta_if_load_debugfs_write() and
ta_if_invoke_debugfs_write().

No functional changes intended.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
index 38face981c3e..6e8aad91bcd3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
@@ -171,13 +171,9 @@ static ssize_t ta_if_load_debugfs_write(struct file *fp, const char *buf, size_t
 
 	copy_pos += sizeof(uint32_t);
 
-	ta_bin = kzalloc(ta_bin_len, GFP_KERNEL);
-	if (!ta_bin)
-		return -ENOMEM;
-	if (copy_from_user((void *)ta_bin, &buf[copy_pos], ta_bin_len)) {
-		ret = -EFAULT;
-		goto err_free_bin;
-	}
+	ta_bin = memdup_user(&buf[copy_pos], ta_bin_len);
+	if (IS_ERR(ta_bin))
+		return PTR_ERR(ta_bin);
 
 	/* Set TA context and functions */
 	set_ta_context_funcs(psp, ta_type, &context);
@@ -327,13 +323,9 @@ static ssize_t ta_if_invoke_debugfs_write(struct file *fp, const char *buf, size
 		return -EFAULT;
 	copy_pos += sizeof(uint32_t);
 
-	shared_buf = kzalloc(shared_buf_len, GFP_KERNEL);
-	if (!shared_buf)
-		return -ENOMEM;
-	if (copy_from_user((void *)shared_buf, &buf[copy_pos], shared_buf_len)) {
-		ret = -EFAULT;
-		goto err_free_shared_buf;
-	}
+	shared_buf = memdup_user(&buf[copy_pos], shared_buf_len);
+	if (IS_ERR(shared_buf))
+		return PTR_ERR(shared_buf);
 
 	set_ta_context_funcs(psp, ta_type, &context);
 
-- 
2.51.0


