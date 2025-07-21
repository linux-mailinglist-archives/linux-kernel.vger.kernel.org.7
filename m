Return-Path: <linux-kernel+bounces-739000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FE1B0C075
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 11:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 877803BF844
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 09:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C42828C2A9;
	Mon, 21 Jul 2025 09:39:16 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C1728A71D;
	Mon, 21 Jul 2025 09:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753090755; cv=none; b=QBqry4JrrsG4jilJy/y2Bo4P4HzdVO4l3WKvDcsZT/LjUeD2CTYv5lF0S0I0jfF+FzZEJE1OKJm4CIl7CHYrRoum8HOLIoHX2sLEZPTrHI1fTJRfCDTm4/pCbwtsClxOJ+N0yEwyRQ08YsZKI4hIOE5QjmckMRtUZ46kcDgMN3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753090755; c=relaxed/simple;
	bh=9vXy3DkSbT7162/dj8Wu7WKK5w/m+Tisceq0XzFo6YA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aDSIYLA1Tg/gtNuA1IUAcVnI+1rosZM9bIxOjOMgjdj3cd7Mj4td2yIFWOuSzvRNLo5B/aOpnzbmkJwR10DWllyRcpLHikauzap70hsWx94A6fkMuT9/3tyHuy/C/J5r4CuFlYxx7QcyfnTuB3i8L3UIkumBVpJa5zMhNMkgnKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4blwGQ4CH8zSjcS;
	Mon, 21 Jul 2025 17:34:38 +0800 (CST)
Received: from kwepemk100018.china.huawei.com (unknown [7.202.194.66])
	by mail.maildlp.com (Postfix) with ESMTPS id BD2171400DC;
	Mon, 21 Jul 2025 17:39:09 +0800 (CST)
Received: from vm7-217-32-6.huawei.com (7.217.32.6) by
 kwepemk100018.china.huawei.com (7.202.194.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 21 Jul 2025 17:39:08 +0800
From: Tao Xue <xuetao09@huawei.com>
To: <gregkh@linuxfoundation.org>, <Thinh.Nguyen@synopsys.com>,
	<prashanth.k@oss.qualcomm.com>, <m.grzeschik@pengutronix.de>,
	<Chris.Wulff@biamp.com>, <linux-usb@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <caiyadong@huawei.com>, <suzhuangluan@hisilicon.com>,
	<weiwenwen3@huawei.com>, <xuetao09@huawei.com>
Subject: [PATCH v4] usb: gadget : fix use-after-free in composite_dev_cleanup()
Date: Mon, 21 Jul 2025 17:39:08 +0800
Message-ID: <20250721093908.14967-1-xuetao09@huawei.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
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
Cc: stable@vger.kernel.org
Signed-off-by: Tao Xue <xuetao09@huawei.com>
---
v4: add cc and modify comment
v3: add comment in code
v2: update Signed-off and commit message
v1: initial submission

 drivers/usb/gadget/composite.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
index 8dbc132a505e..a893a29ebfac 100644
--- a/drivers/usb/gadget/composite.c
+++ b/drivers/usb/gadget/composite.c
@@ -2489,6 +2489,11 @@ int composite_os_desc_req_prepare(struct usb_composite_dev *cdev,
 	if (!cdev->os_desc_req->buf) {
 		ret = -ENOMEM;
 		usb_ep_free_request(ep0, cdev->os_desc_req);
+		/*
+		 * Set os_desc_req to NULL so that composite_dev_cleanup()
+		 * will not try to free it again.
+		 */
+		cdev->os_desc_req = NULL;
 		goto end;
 	}
 	cdev->os_desc_req->context = cdev;
-- 
2.17.1


