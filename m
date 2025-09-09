Return-Path: <linux-kernel+bounces-808513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E8BEB500B6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 17:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 217401C622EC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 15:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2124C350D72;
	Tue,  9 Sep 2025 15:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SJVa9R/d"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A9A255E27
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 15:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757430749; cv=none; b=VHzv/lfOhRIXq3h+WkQ7RTAP2i1kVmFemxBlv2ReDIP3vwr7AioPaSXa8PqDJhSHdZuOKLsrmu2MxtVTiKPvQmlugMo322i7xGODbdnrN+zRQwbiPTShh6d5vitXC5xsNO3AI60LhtMPlgfwpoVFjxC27554rIJXK/5KW4U5vRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757430749; c=relaxed/simple;
	bh=z0pWl5tmXxe8Yr4RnIREU8SsYE2Ww+p+S8VgecNvLR0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cyEDHbIUeej7OUydotTMVvh6AIr+qykmZnVhLfzck5sABvn++WsoFtSO/0iv/BytZUQCnglSkZDCZIY6LaUFHhJBtzy6rFuWLkuc7q42/lsavLMixRNZkOwPxSSY797Vufg15dK0CPzUvPZEWKKg8Vdjq2PNISc1fBbh8ujFXN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SJVa9R/d; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757430743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YTikDlX12kXL3j+5kwkltxNVJHuHuCGZc9SB1ihbGG4=;
	b=SJVa9R/d9JBXok4g28X5XyNlSwCYDy1Z9ugy6mZB8SX7QL4omrAASdlWcbBZOMqsE0+UPR
	/gejcTIxHMMnytu9jWBu7OHWYAw7+xtJkvtCgGPFwF5nti1t3+vx+OoWQ0GZ7Ws1QIHsoz
	4MMqCMfouJ8X6IPvREtIcp01b0wGFc8=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Felix Kuehling <Felix.Kuehling@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amdkfd: Replace kmalloc + copy_from_user with memdup_user
Date: Tue,  9 Sep 2025 17:11:46 +0200
Message-ID: <20250909151146.760450-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace kmalloc() followed by copy_from_user() with memdup_user() to
improve and simplify kfd_criu_restore_queue().

No functional changes intended.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 .../amd/amdkfd/kfd_process_queue_manager.c    | 22 +++++--------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 7fbb5c274ccc..70c17a12cadf 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -1004,13 +1004,9 @@ int kfd_criu_restore_queue(struct kfd_process *p,
 	if (*priv_data_offset + sizeof(*q_data) > max_priv_data_size)
 		return -EINVAL;
 
-	q_data = kmalloc(sizeof(*q_data), GFP_KERNEL);
-	if (!q_data)
-		return -ENOMEM;
-
-	ret = copy_from_user(q_data, user_priv_ptr + *priv_data_offset, sizeof(*q_data));
-	if (ret) {
-		ret = -EFAULT;
+	q_data = memdup_user(user_priv_ptr + *priv_data_offset, sizeof(*q_data));
+	if (IS_ERR(q_data)) {
+		ret = PTR_ERR(q_data);
 		goto exit;
 	}
 
@@ -1022,15 +1018,9 @@ int kfd_criu_restore_queue(struct kfd_process *p,
 		goto exit;
 	}
 
-	q_extra_data = kmalloc(q_extra_data_size, GFP_KERNEL);
-	if (!q_extra_data) {
-		ret = -ENOMEM;
-		goto exit;
-	}
-
-	ret = copy_from_user(q_extra_data, user_priv_ptr + *priv_data_offset, q_extra_data_size);
-	if (ret) {
-		ret = -EFAULT;
+	q_extra_data = memdup_user(user_priv_ptr + *priv_data_offset, q_extra_data_size);
+	if (IS_ERR(q_extra_data)) {
+		ret = PTR_ERR(q_extra_data);
 		goto exit;
 	}
 
-- 
2.51.0


