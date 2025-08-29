Return-Path: <linux-kernel+bounces-792257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D45FB3C1ED
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 19:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9653A642E9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 17:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C84342C8C;
	Fri, 29 Aug 2025 17:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XQpGV7oa"
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D61342C91
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 17:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756489059; cv=none; b=ayy/AzbStrxUUCBCXGrqKP1o2Pncvz8ueZpVDKHPkYBfhTYyBnPaJK6O8S4qYjrfSFq6YE8vtdg3ZDtar6AH8U/YBQFqQTvPeBWvIDS+jHdKyF9oQ7HYzsCKs0ceBqteaIJCwwHk2Re2LhSg48zcuOKoVVvAsr2v7sN8TmkVvJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756489059; c=relaxed/simple;
	bh=M/hExav9Xf8wlFlLlJR3qGS+Zsw4qlq2yy3Q39AMSKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o6d67vfkUqJh9YRJ/U55sRrgLI5Zh1cnCIFndLR8fSNTxoES50bN2BMBCLUOPRZkEvALY37eFIvnPPbNY7zA6kkz5fXxFUpFmV3PuKRoBBvqVmatoZx00MRL6GWC24ENrHsEvOILoWHw4GPzBoq1onFNd7KsWIGB922AWIk1+7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XQpGV7oa; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756489045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fQHgnqOU9CkWBF0G4dgcqMNTJNphTU7t7PVKAz+jZPE=;
	b=XQpGV7oaHrRy7WAW4Z2XHEp4cYENzpLyk90t2X/pWbtEq8biVo9vgG6k8o0vdmdtlfH17g
	btIRlhRE4sCOk8pDYVJ+ZUMhRb5m8UXd6EHgqvLcm535my9ZnivQsS4NIQGObIhtUUxtkx
	qlJS3ZbcCUWfrnwuWmVoL2PrGupscL0=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Pete Zaitcev <zaitcev@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] usb: usblp: Use min_t() to improve usblp_read()
Date: Fri, 29 Aug 2025 19:37:12 +0200
Message-ID: <20250829173713.56222-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Use min_t() to improve usblp_read() and avoid calculating
'avail - usblp->readcount' twice. Use min_t(ssize_t,,) instead of min()
to avoid a signedness error.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/usb/class/usblp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/class/usblp.c b/drivers/usb/class/usblp.c
index acbefccbdb2a..a7a1d38b6bef 100644
--- a/drivers/usb/class/usblp.c
+++ b/drivers/usb/class/usblp.c
@@ -34,6 +34,7 @@
 
 #include <linux/module.h>
 #include <linux/kernel.h>
+#include <linux/minmax.h>
 #include <linux/sched/signal.h>
 #include <linux/signal.h>
 #include <linux/poll.h>
@@ -871,7 +872,7 @@ static ssize_t usblp_read(struct file *file, char __user *buffer, size_t len, lo
 		goto done;
 	}
 
-	count = len < avail - usblp->readcount ? len : avail - usblp->readcount;
+	count = min_t(ssize_t, len, avail - usblp->readcount);
 	if (count != 0 &&
 	    copy_to_user(buffer, usblp->readbuf + usblp->readcount, count)) {
 		count = -EFAULT;
-- 
2.50.1


