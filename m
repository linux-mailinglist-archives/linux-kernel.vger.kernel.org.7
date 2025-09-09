Return-Path: <linux-kernel+bounces-807870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8EE3B4AA92
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 12:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 163D6189ABFD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 10:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6047731C56F;
	Tue,  9 Sep 2025 10:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gz2LuBn4"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F422D23A9
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 10:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757413576; cv=none; b=ddencY8FDmQ0M32J8wuKOIloUkvN3UgKWtLLTQGIaW07iVaO+2YeiODUUiltFvrycXjY6P5X9a8JaYfroYly124o45l0ku2Bpu+kGC+3JTtHQRXc0XpWijZTolIb1JnzujcM5lc7P8v/Hsd1OYPtg8BtrgXMuQp1TT8uM6zMyJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757413576; c=relaxed/simple;
	bh=n7HirHHHaQCQxQOKz+etVY9ivZN4zg6ySzMaDPqtWe0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ILPRvo3vO1d61awBWA1uUGc6zW2Xiduc9rLCJyfNzRlT8a5SRF4+DSE+rDyvsi4+DWy2yBjv7ScygAjW08RRTcCS6UeGqCeMo2lYfHdO+iTy2mEjNb+1pUVz94bngiTwqBAHqcaK1LCP4zAmglBXVmFD97kVCxJ4+ottj5wgL34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gz2LuBn4; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757413572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fW0tKmArF4zWTnzVKm0mzR07hZtUDU+CloW06fiXIm4=;
	b=gz2LuBn4Kz9SohMA7ramk/sb7qcJNdTDI1ykKVyC4oJqUFC7NUlJMt4JVeQeUdZqxpe1IM
	8k+pqWdG5w0MszaMjPwJc8Kj0F3IdDTtzQ1ez0nqkkkoa2GHq3AKjbQ57VcvAhifvBOhYA
	E5Mli3lTsYs56sYgHA9NtAhckTiA7aI=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] stm class: Replace kzalloc() + copy_from_user() with memdup_user_nul()
Date: Tue,  9 Sep 2025 12:25:14 +0200
Message-ID: <20250909102512.694203-4-thorsten.blum@linux.dev>
In-Reply-To: <20250909102512.694203-2-thorsten.blum@linux.dev>
References: <20250909102512.694203-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace kzalloc() followed by copy_from_user() with memdup_user_nul() to
improve and simplify stm_char_policy_set_ioctl(). Remove the obsolete
comment.

No functional changes intended.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/hwtracing/stm/core.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/hwtracing/stm/core.c b/drivers/hwtracing/stm/core.c
index 5834f796e86b..335bcf749214 100644
--- a/drivers/hwtracing/stm/core.c
+++ b/drivers/hwtracing/stm/core.c
@@ -733,18 +733,9 @@ static int stm_char_policy_set_ioctl(struct stm_file *stmf, void __user *arg)
 	if (size < sizeof(*id) || size >= PATH_MAX + sizeof(*id))
 		return -EINVAL;
 
-	/*
-	 * size + 1 to make sure the .id string at the bottom is terminated,
-	 * which is also why memdup_user() is not useful here
-	 */
-	id = kzalloc(size + 1, GFP_KERNEL);
-	if (!id)
-		return -ENOMEM;
-
-	if (copy_from_user(id, arg, size)) {
-		ret = -EFAULT;
-		goto err_free;
-	}
+	id = memdup_user_nul(arg, size);
+	if (IS_ERR(id))
+		return PTR_ERR(id);
 
 	if (id->__reserved_0 || id->__reserved_1)
 		goto err_free;
-- 
2.51.0


