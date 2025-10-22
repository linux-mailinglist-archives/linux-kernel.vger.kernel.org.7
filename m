Return-Path: <linux-kernel+bounces-864929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B0ABFBE2B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 14:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7451E4F035B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED645344032;
	Wed, 22 Oct 2025 12:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wghXhO4Y"
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8801833C52C
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 12:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761136603; cv=none; b=JQeFuMQlLoXG7fwNViYZP1uiGoR3QijIycDw7XG8KQTHZBQu6IYGMiZtVUzAOIFhRK79v9n9qyop3iz0BA72VkeM5khkpMsm9wF40ysGJp6SXMa7iUmPzK1GK0mknFYX20nv4KOJayC9t//sCia0hWZaOdAKr6NI6HXR0M/kEKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761136603; c=relaxed/simple;
	bh=G6/4RV+/hyEImD5Tjx7E3DcexAe5ffRKGf9PUm2hzkc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EI9eQSr6t65WP9OoL5OILLqceVZd75YXkX1HZWGWTSkU0mDXh/ixhQV3tpMi0GPLnxqAsgQf98WdmFkoQglc1BN/TwJdzQz5lGNgOzwbW50peRwJxHFhaWgD0IqSb7gA3RLLe/aDYc/QNUQ+MC92FdBjrf2aPADL8Xpz2E3ulLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wghXhO4Y; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761136598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tpFUwbpm7eC7NH+fV3rtn/zOowNizHjNm0vznqUq8k4=;
	b=wghXhO4YXwSNLlDCbffYanV3ZiR+drLtyTrMd/PkNWWvsZUF6RYtRqISyK29M5P3s5tLJY
	Ur854kMJ9PkWCQkZ+j/LELgfaGM573/TfssaLaIGFFKLOwVgsvbOLYV46zHZQTyvbfAx8W
	g8mlpp384LfIkJNlrIkUkkUx9WRXhus=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jack Xu <jack.xu@intel.com>,
	Suman Kumar Chakraborty <suman.kumar.chakraborty@intel.com>,
	Qianfeng Rong <rongqianfeng@vivo.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	qat-linux@intel.com,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: qat - use strscpy_pad to simplify buffer initialization
Date: Wed, 22 Oct 2025 14:36:19 +0200
Message-ID: <20251022123622.349544-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Use strscpy_pad() to copy the string and zero-pad the destination buffer
in a single step instead of zero-initializing the buffer first and then
immediately overwriting it using strscpy().

Replace the magic number 16 with sizeof(buf) and remove the redundant
parentheses around kstrtoul() while we're at it.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/crypto/intel/qat/qat_common/qat_uclo.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/intel/qat/qat_common/qat_uclo.c b/drivers/crypto/intel/qat/qat_common/qat_uclo.c
index 18c3e4416dc5..41a7bd434e97 100644
--- a/drivers/crypto/intel/qat/qat_common/qat_uclo.c
+++ b/drivers/crypto/intel/qat/qat_common/qat_uclo.c
@@ -200,18 +200,18 @@ qat_uclo_cleanup_batch_init_list(struct icp_qat_fw_loader_handle *handle,
 
 static int qat_uclo_parse_num(char *str, unsigned int *num)
 {
-	char buf[16] = {0};
+	char buf[16] = {};
 	unsigned long ae = 0;
 	int i;
 
-	strscpy(buf, str, sizeof(buf));
-	for (i = 0; i < 16; i++) {
+	strscpy_pad(buf, str);
+	for (i = 0; i < sizeof(buf); i++) {
 		if (!isdigit(buf[i])) {
 			buf[i] = '\0';
 			break;
 		}
 	}
-	if ((kstrtoul(buf, 10, &ae)))
+	if (kstrtoul(buf, 10, &ae))
 		return -EFAULT;
 
 	*num = (unsigned int)ae;
-- 
2.51.0


