Return-Path: <linux-kernel+bounces-880053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F4EC24C37
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A22F64E5603
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5AAE336ECF;
	Fri, 31 Oct 2025 11:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TJxTgbNA"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1621E9919
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 11:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761909752; cv=none; b=KgB2x8tt7BWvGnpWsjXpqhFjXoXIRyalmeV1J2cGczHOitLal7DWzSzV3vrqT6Kypult/IyJMm/KnZEa5K1qffDS8iDq4CSVIobqsuAct/CSWc0GNq+d+TkDM+vdh3u0GDdzXeS1204BfBkfjmbencJC7hHM9MVOI2zc7vsGaTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761909752; c=relaxed/simple;
	bh=B7jR6ssxmsS5H5d9N9znDsqwxKPS3sua7wFOZowWSzs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aNCFHaYs6mJf02XJHsI+7dsDCeelGCBXq7wUJW5N6O+ngwTJMvoQ8JFXEKNKMa48JIA1SZwjE/HtHQYQyjb6VqCSWI4lTy4rbOrgq1jTCwaEZ63iUZx4BbYG8FHNTc5fvGjXB8b4nLTSs+vtYxFVxJ5qxmuqN6orbz5Wp0WOQqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TJxTgbNA; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761909748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nyjzKpu22Trt/0gzyWsVXEu/Jh7s7rdQVLQems4ZlKQ=;
	b=TJxTgbNAv6VQC/hclzu8aspYLQyOkrXQZO59TNSwY65Pe4LtclsZA/dkNjOxHW9lsO/Ia1
	2OLlRAqRn94pA94cVA1jijQmAdVFm8V8jNTYin0Qjy9afBu8cDrxvLaU0aJ8+vyAh+kQ7e
	6DXvLLY2U7vmg9GDTWFZ0H8BfGkuoQE=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Jason Andryuk <jason.andryuk@amd.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Thorsten Blum <thorsten.blum@linux.dev>
Cc: xen-devel@lists.xenproject.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 RESEND] drivers/xen/xenbus: Replace deprecated strcpy in xenbus_transaction_end
Date: Fri, 31 Oct 2025 12:21:31 +0100
Message-ID: <20251031112145.103257-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strcpy() is deprecated; inline the read-only string instead. Fix the
function comment and use bool instead of int while we're at it.

Link: https://github.com/KSPP/linux/issues/88
Reviewed-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
Changes in v2:
- Use an inline ternary expression and remove 'char abortstr[2]' as
  suggested by Jürgen
- Link to v1: https://lore.kernel.org/lkml/20251012195514.39003-2-thorsten.blum@linux.dev/
---
 drivers/xen/xenbus/xenbus_xs.c | 14 ++++----------
 include/xen/xenbus.h           |  2 +-
 2 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/xen/xenbus/xenbus_xs.c b/drivers/xen/xenbus/xenbus_xs.c
index 528682bf0c7f..5d95a5f83119 100644
--- a/drivers/xen/xenbus/xenbus_xs.c
+++ b/drivers/xen/xenbus/xenbus_xs.c
@@ -546,18 +546,12 @@ int xenbus_transaction_start(struct xenbus_transaction *t)
 EXPORT_SYMBOL_GPL(xenbus_transaction_start);
 
 /* End a transaction.
- * If abandon is true, transaction is discarded instead of committed.
+ * If abort is true, transaction is discarded instead of committed.
  */
-int xenbus_transaction_end(struct xenbus_transaction t, int abort)
+int xenbus_transaction_end(struct xenbus_transaction t, bool abort)
 {
-	char abortstr[2];
-
-	if (abort)
-		strcpy(abortstr, "F");
-	else
-		strcpy(abortstr, "T");
-
-	return xs_error(xs_single(t, XS_TRANSACTION_END, abortstr, NULL));
+	return xs_error(xs_single(t, XS_TRANSACTION_END, abort ? "F" : "T",
+				  NULL));
 }
 EXPORT_SYMBOL_GPL(xenbus_transaction_end);
 
diff --git a/include/xen/xenbus.h b/include/xen/xenbus.h
index 7dab04cf4a36..c94caf852aea 100644
--- a/include/xen/xenbus.h
+++ b/include/xen/xenbus.h
@@ -158,7 +158,7 @@ int xenbus_exists(struct xenbus_transaction t,
 		  const char *dir, const char *node);
 int xenbus_rm(struct xenbus_transaction t, const char *dir, const char *node);
 int xenbus_transaction_start(struct xenbus_transaction *t);
-int xenbus_transaction_end(struct xenbus_transaction t, int abort);
+int xenbus_transaction_end(struct xenbus_transaction t, bool abort);
 
 /* Single read and scanf: returns -errno or num scanned if > 0. */
 __scanf(4, 5)
-- 
2.51.1


