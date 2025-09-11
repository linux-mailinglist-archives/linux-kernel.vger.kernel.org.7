Return-Path: <linux-kernel+bounces-812910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F343AB53E09
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 23:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C910188DEEF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 21:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6B020E702;
	Thu, 11 Sep 2025 21:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cxxz+vEw"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74BA2DC791
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 21:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757627211; cv=none; b=AIgIuAOZksbQcIfWunUfw/ar/AAvdCooYAlvIucHpVjoCEQWnxZprr67bdBkXtOGFtHNvIWKOSQ6eCNj0BHkuJ/bU/NHTyjWLpvR+tExzQ3GBK0kXnk6mBNDcRviAHaz9ovS4kfuoVrBqeQOjaLKpQGEs6JytUrxWnjTrFxZQm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757627211; c=relaxed/simple;
	bh=05k5hO8WIGfcO8n7ZaBd6+95lgroAl4PspGuhUL7DOw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VyS+ZnPEPB0bLgGqtuGZ1HHUv+SYdG34UNPGstAycM3Zl7YVuCQIaYCccqq/Lrgs4X8JuxpjHQGNkpp3FL/3rZMBA0RC79Hz3Yh7N3sv4PstDkfFqpGW82xK6wKZ191nFZhh8wty+/D7jgQQTyXTSXGxu88iSMceoKrP1QeX0zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cxxz+vEw; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757627206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gJvtzpnT8UuY6/UseMpuukXO7AAd+YqjyZJPLK1pdU4=;
	b=cxxz+vEwTzmDem/JcivptG3cNntfMNFGeqhxqWvmO/ZIDJThMUQTsqVIskajA+PmZf87J/
	zIvTRWY8gNQycG9OcJFjAaRhpvgCgPJ6NRfUPhhId6w640xybMiuscgzMuGyTmlfR3tjEn
	9XtS9wCcfb0YU5JiBZxY8ysvcoSOVNo=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] s390/hypfs_sprp: Replace kzalloc() + copy_from_user() with memdup_user()
Date: Thu, 11 Sep 2025 23:45:38 +0200
Message-ID: <20250911214539.1483234-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace kzalloc() followed by copy_from_user() with memdup_user() to
improve and simplify __hypfs_sprp_ioctl().

Return early if an error occurs instead of trying to allocate memory for
'diag304' when memory allocation for 'data' already failed.

No functional changes intended.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/s390/hypfs/hypfs_sprp.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/s390/hypfs/hypfs_sprp.c b/arch/s390/hypfs/hypfs_sprp.c
index 9fc3f0dae8f0..be11634bc7db 100644
--- a/arch/s390/hypfs/hypfs_sprp.c
+++ b/arch/s390/hypfs/hypfs_sprp.c
@@ -73,15 +73,16 @@ static int __hypfs_sprp_ioctl(void __user *user_area)
 	void *data;
 	int rc;
 
-	rc = -ENOMEM;
 	data = (void *)get_zeroed_page(GFP_KERNEL);
-	diag304 = kzalloc(sizeof(*diag304), GFP_KERNEL);
-	if (!data || !diag304)
-		goto out;
+	if (!data)
+		return -ENOMEM;
 
-	rc = -EFAULT;
-	if (copy_from_user(diag304, user_area, sizeof(*diag304)))
+	diag304 = memdup_user(user_area, sizeof(*diag304));
+	if (IS_ERR(diag304)) {
+		rc = PTR_ERR(diag304);
 		goto out;
+	}
+
 	rc = -EINVAL;
 	if ((diag304->args[0] >> 8) != 0 || diag304->args[1] > DIAG304_CMD_MAX)
 		goto out;
-- 
2.51.0


