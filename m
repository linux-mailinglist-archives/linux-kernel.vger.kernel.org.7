Return-Path: <linux-kernel+bounces-738818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E44EB0BDA1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 09:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFE891885574
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 07:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181EC283C8E;
	Mon, 21 Jul 2025 07:29:59 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0616E2820CB;
	Mon, 21 Jul 2025 07:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753082998; cv=none; b=sB6mTR+7zI5upUGCJXkzGO021jRw6I2gmPH5UZwiQsRD76h2w35320zBxwA/0439wi0dt+nnS5l91qG/VMPvTP/S+7zKQsMjOWKtJQPlASxWCU/aLNxiEbRSjsy2GdFrkHLd+wZd5Nej41VFsAcbdIkhZqaXCsRdXIFjfoeG6SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753082998; c=relaxed/simple;
	bh=Mz9TwkSo3ydV8nWX9Gp6aBAPofkwHcWh2RG8PY4PBCw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eXVN2aUXAPnkto7mPhmfdH9hRo4rjEMkrHPeCK9r5nfc8VxblUvXTRNXGEsWkXa9IBGokXH+/bTr9fNyzfznbgQ2wYH9qgEDqOnX4pJpP1SEVB2XfAfwNmMjGevO5/3uWBIrk+e+rfx6pBe4ItY2X2/BmOcoRCZcx1anSp7BqjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4blsPZ3PJNz2CdJV;
	Mon, 21 Jul 2025 15:25:38 +0800 (CST)
Received: from kwepemk100018.china.huawei.com (unknown [7.202.194.66])
	by mail.maildlp.com (Postfix) with ESMTPS id A52FB1A0188;
	Mon, 21 Jul 2025 15:29:47 +0800 (CST)
Received: from vm7-217-32-6.huawei.com (7.217.32.6) by
 kwepemk100018.china.huawei.com (7.202.194.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 21 Jul 2025 15:29:46 +0800
From: Tao Xue <xuetao09@huawei.com>
To: <gregkh@linuxfoundation.org>, <Thinh.Nguyen@synopsys.com>,
	<prashanth.k@oss.qualcomm.com>, <m.grzeschik@pengutronix.de>,
	<Chris.Wulff@biamp.com>, <linux-usb@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <caiyadong@huawei.com>, <suzhuangluan@hisilicon.com>,
	<weiwenwen3@huawei.com>, <xuetao09@huawei.com>
Subject: [PATCH v3] usb: gadget : fix use-after-free in composite_dev_cleanup()
Date: Mon, 21 Jul 2025 15:29:46 +0800
Message-ID: <20250721072946.14638-1-xuetao09@huawei.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemk100018.china.huawei.com (7.202.194.66)

1. In func configfs_composite_bind() -> composite_os_desc_req_prepare():
if kmalloc fails, the pointer cdev->os_desc_req will be freed but not
set to NULL. Then it will return a failure to the upper-level function.
2. in func configfs_composite_bind() -> composite_dev_cleanup():
it will checks whether cdev->os_desc_req is NULL. If it is not NULL, it
will attempt to use it.This will lead to a use-after-free issue.

BUG: KASAN: use-after-free in composite_dev_cleanup+0xf4/0x2c0
Read of size 8 at addr 0000004827837a00 by task init/1

CPU: 10 PID: 1 Comm: init Tainted: G           O      5.10.97-oh #1
 kasan_report+0x188/0x1cc
 __asan_load8+0xb4/0xbc
 composite_dev_cleanup+0xf4/0x2c0
 configfs_composite_bind+0x210/0x7ac
 udc_bind_to_driver+0xb4/0x1ec
 usb_gadget_probe_driver+0xec/0x21c
 gadget_dev_desc_UDC_store+0x264/0x27c

Fixes: 37a3a533429e ("usb: gadget: OS Feature Descriptors support")
Signed-off-by: Tao Xue <xuetao09@huawei.com>
---
v3: add comment in patch
v2: update Signed-off and commit message
v1: initial submission

 drivers/usb/gadget/composite.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
index 8dbc132a505e..adf0a79b3d3d 100644
--- a/drivers/usb/gadget/composite.c
+++ b/drivers/usb/gadget/composite.c
@@ -2489,6 +2489,11 @@ int composite_os_desc_req_prepare(struct usb_composite_dev *cdev,
 	if (!cdev->os_desc_req->buf) {
 		ret = -ENOMEM;
 		usb_ep_free_request(ep0, cdev->os_desc_req);
+		/* composite_dev_cleanup() will check whether cdev->os_desc_req
+		 * is NULL and will use it when it is not NULL, so we need to set
+		 * NULL here.
+		 */
+		cdev->os_desc_req = NULL;
 		goto end;
 	}
 	cdev->os_desc_req->context = cdev;
-- 
2.17.1


