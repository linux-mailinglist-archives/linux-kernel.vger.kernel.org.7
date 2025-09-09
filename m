Return-Path: <linux-kernel+bounces-807566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C284B4A63B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 10:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE7A13B4FF4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 08:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223AC2741C9;
	Tue,  9 Sep 2025 08:58:57 +0000 (UTC)
Received: from cmccmta1.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1AB21EFF8D
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 08:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757408336; cv=none; b=maKVkmWBXzJXLFrJsushFdYtC6LDDJ5xI2NL8PD5VV/BfFv0i5qz+9RaCVQoIIRc5qbvIYqBnhLK64PBCx3gWlNbI7z1herDsrg7vRhRMf+bgZOpKt2JUmrdpRQmCPcpjkr1ZeCjRqSGc8yB63bZVdz58RtXUol2hpAUTOsnC0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757408336; c=relaxed/simple;
	bh=0Ckiruqy0WYjaQTcvenGUkOAsrfWGSUBjHz1mIkx3l4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AHwqEJcxUhlEfIHAtHcerY/eM2FD9pyKI7c18AMRz79aSSvU+GpWepoYLdB2Q8BJ+9LB8cB3YLGbMXgJOGVCvvUoqhNa4O0K165eSGu3lyQMW0X2FXKabtgmTO1WZEJxT4pkMnTKytfCNio6EuJRKbFZcrqprlWWg4/LkEXsx28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee468bfec4297b-4ea0e;
	Tue, 09 Sep 2025 16:58:43 +0800 (CST)
X-RM-TRANSID:2ee468bfec4297b-4ea0e
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from Z04181454368174 (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee968bfec4028f-5fcc2;
	Tue, 09 Sep 2025 16:58:43 +0800 (CST)
X-RM-TRANSID:2ee968bfec4028f-5fcc2
From: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
To: arnd@arndb.de
Cc: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	zhang jiao <zhangjiao2@cmss.chinamobile.com>
Subject: [PATCH] char: misc: Make the code for allocating minor in misc_register more concise
Date: Tue,  9 Sep 2025 16:58:35 +0800
Message-ID: <20250909085835.2784-1-zhangjiao2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: zhang jiao <zhangjiao2@cmss.chinamobile.com>

There is no need to check the registered misc dev in misc_list. 
If misc_minor_alloc failed, it meens the minor is already alloced 
and the misc dev is linked in misc_list.

Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
---
 drivers/char/misc.c | 32 +++++++-------------------------
 1 file changed, 7 insertions(+), 25 deletions(-)

diff --git a/drivers/char/misc.c b/drivers/char/misc.c
index a0aae0fc7926..fc2f5e8b2f95 100644
--- a/drivers/char/misc.c
+++ b/drivers/char/misc.c
@@ -211,6 +211,7 @@ int misc_register(struct miscdevice *misc)
 	dev_t dev;
 	int err = 0;
 	bool is_dynamic = (misc->minor == MISC_DYNAMIC_MINOR);
+	int minor = 0;
 
 	if (misc->minor > MISC_DYNAMIC_MINOR) {
 		pr_err("Invalid fixed minor %d for miscdevice '%s'\n",
@@ -221,32 +222,13 @@ int misc_register(struct miscdevice *misc)
 	INIT_LIST_HEAD(&misc->list);
 
 	mutex_lock(&misc_mtx);
-
-	if (is_dynamic) {
-		int i = misc_minor_alloc(misc->minor);
-
-		if (i < 0) {
-			err = -EBUSY;
-			goto out;
-		}
-		misc->minor = i;
-	} else {
-		struct miscdevice *c;
-		int i;
-
-		list_for_each_entry(c, &misc_list, list) {
-			if (c->minor == misc->minor) {
-				err = -EBUSY;
-				goto out;
-			}
-		}
-
-		i = misc_minor_alloc(misc->minor);
-		if (i < 0) {
-			err = -EBUSY;
-			goto out;
-		}
+	minor = misc_minor_alloc(misc->minor);
+	if (minor < 0) {
+		err = -EBUSY;
+		goto out;
 	}
+	if (is_dynamic)
+		misc->minor = minor;
 
 	dev = MKDEV(MISC_MAJOR, misc->minor);
 
-- 
2.33.0




