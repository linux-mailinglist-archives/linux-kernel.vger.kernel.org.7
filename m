Return-Path: <linux-kernel+bounces-823085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9755AB857CA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 17:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33A327E27B3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59311F09A5;
	Thu, 18 Sep 2025 15:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mYnmGYrC"
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B4B60B8A
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 15:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758208116; cv=none; b=gTGa1URMcbm+posZ40+mvf8EI/bUpcapxxcQ696YzNbwbSsI6q5vKnZXzfSnbwO0BHivJ/7CpNSuOSMmK4rpqvgao/xWFHzX+B92ZZZJDb8Iia7Tmyf/zqAsirXRbi8gUWaZl3uQD7yzLw652zMKpiou9+okD5KlcoN+lDcePRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758208116; c=relaxed/simple;
	bh=OH1cXWh/ceZm2s0pVVZvR2aSkoX+P8HmZ4spkodV/Ew=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sxIVa+Gz1zxyZ0KEHkgEz2Jtu1j2dzQMRRqNRYsdEoU3Anmw0A+zhaE2EsifGfu/bKJk6dnTndhy4xCY9CPMXCE8OxKsnGgdERYCzYN/CJ50IhF4KODHx1zFM5KKLncCsXnIS+XG+pecvuTeUg+Gykn5+a8NP9UvWjaRz1O8nec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mYnmGYrC; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758208111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Bt8ipHYIkaJJgEvMQ5h6jOk88qp19PNj3om5XuureRA=;
	b=mYnmGYrC1K2UGVSpmP7Bo6zNS4ZiGU28CCHwSPuW5eOyLSdMlT8+fkPx2RSQbIAxq+R8Hb
	LbREZOaK5H791nb67+RjrtcFFx74Q/oj4xUV+zAahRJZgEQgGbtxTO2HCwj+r18Ylzma65
	9uG8zhVnXAoXbTx6vF6yNQvpEZKYhCE=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Mike Marshall <hubcap@omnibond.com>,
	Martin Brandenburg <martin@omnibond.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	devel@lists.orangefs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fs/orangefs: Replace kzalloc + copy_from_user with memdup_user_nul
Date: Thu, 18 Sep 2025 17:08:10 +0200
Message-ID: <20250918150811.259596-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace kzalloc() followed by copy_from_user() with memdup_user_nul() to
simplify and improve orangefs_debug_write(). Allocate only 'count' bytes
instead of the maximum size ORANGEFS_MAX_DEBUG_STRING_LEN, and set 'buf'
to NULL to ensure kfree(buf) still works.

No functional changes intended.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 fs/orangefs/orangefs-debugfs.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/orangefs/orangefs-debugfs.c b/fs/orangefs/orangefs-debugfs.c
index 1c375fb65018..79267b3419f2 100644
--- a/fs/orangefs/orangefs-debugfs.c
+++ b/fs/orangefs/orangefs-debugfs.c
@@ -440,14 +440,13 @@ static ssize_t orangefs_debug_write(struct file *file,
 		count = ORANGEFS_MAX_DEBUG_STRING_LEN;
 	}
 
-	buf = kzalloc(ORANGEFS_MAX_DEBUG_STRING_LEN, GFP_KERNEL);
-	if (!buf)
-		goto out;
-
-	if (copy_from_user(buf, ubuf, count - 1)) {
+	buf = memdup_user_nul(ubuf, count - 1);
+	if (IS_ERR(buf)) {
 		gossip_debug(GOSSIP_DEBUGFS_DEBUG,
-			     "%s: copy_from_user failed!\n",
+			     "%s: memdup_user_nul failed!\n",
 			     __func__);
+		rc = PTR_ERR(buf);
+		buf = NULL;
 		goto out;
 	}
 
-- 
2.51.0


