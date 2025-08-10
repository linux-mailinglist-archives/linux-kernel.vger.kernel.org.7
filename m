Return-Path: <linux-kernel+bounces-761648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A7174B1FD05
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 00:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBB347A920F
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 22:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049012D662E;
	Sun, 10 Aug 2025 22:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MZGHdYvS"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD05E2D8360
	for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 22:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754866775; cv=none; b=c0z06vG7mjHDT82QNhjZk6T17vE5GAtoQIl9n/5mdQJH4iQnKgXOdOw2TLF5s5rD6/p6MBccba7nvZfiZGRA6FE+L1co8kMNDc+lHc+lz7SLyuUm9HLH0F3oI9a2/2lTTNj/gHnqK6NtaPLGJlhXConOmyxwjyW5A5wlUxhkExw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754866775; c=relaxed/simple;
	bh=qqkhZRAcFoOL1L5QSesyB+bxFZyUneytUZmj2MA7yfs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E38X3qkn+hnFyycYuY/MfMaejzbR8KRQOxCvX5eH9cXtnXH6h3h+I/W/00e4w1GO1Myb48fPEpOdcEdY/NYQ5H7fHuH246zpV3NtE2+Tc9QbcgydthBADT2jUVXdatWpXPl7ntBb6IxUmYnj7kECLH+Qw+tx+Q4llxLxcTc9yCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MZGHdYvS; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754866768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0N1CRaaHu/HOmeGu9KNTFLsrGl11YjAguAAfrOW1EjU=;
	b=MZGHdYvS9UaWBojNONJUwnSFNUemTevzz3wuwtnmLmuU3hXGH2I9WZ0k5Wj/h7Jg5GGTpI
	HckJg7PdpuVmQ6fSm52dKJITdfqofLfJzYerQT18vxFn+j7QGBE18f7EfbMvFLzh5gkmRt
	DDgrV1oFDQnWPF1t9859vgfbUe+OV3Y=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vinod Koul <vkoul@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dmaengine: idxd: Replace memset(0) + strscpy() with strscpy_pad()
Date: Mon, 11 Aug 2025 00:58:59 +0200
Message-ID: <20250810225858.2953-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace memset(0) followed by strscpy() with strscpy_pad() to improve
idxd_load_iaa_device_defaults(). This avoids zeroing the memory before
copying the strings and ensures the destination buffers are only written
to once, simplifying the code and improving efficiency.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/dma/idxd/defaults.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/idxd/defaults.c b/drivers/dma/idxd/defaults.c
index c607ae8dd12c..2bbbcd02a0da 100644
--- a/drivers/dma/idxd/defaults.c
+++ b/drivers/dma/idxd/defaults.c
@@ -36,12 +36,10 @@ int idxd_load_iaa_device_defaults(struct idxd_device *idxd)
 	group->num_wqs++;
 
 	/* set name to "iaa_crypto" */
-	memset(wq->name, 0, WQ_NAME_SIZE + 1);
-	strscpy(wq->name, "iaa_crypto", WQ_NAME_SIZE + 1);
+	strscpy_pad(wq->name, "iaa_crypto");
 
 	/* set driver_name to "crypto" */
-	memset(wq->driver_name, 0, DRIVER_NAME_SIZE + 1);
-	strscpy(wq->driver_name, "crypto", DRIVER_NAME_SIZE + 1);
+	strscpy_pad(wq->driver_name, "crypto");
 
 	engine = idxd->engines[0];
 
-- 
2.50.1


