Return-Path: <linux-kernel+bounces-738660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8C6B0BB8C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 05:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4CD63B83AA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 03:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C42E213224;
	Mon, 21 Jul 2025 03:59:04 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB921EF36C;
	Mon, 21 Jul 2025 03:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753070344; cv=none; b=WeJPVdNeN/LMlONZCDSwp1kL/ED6r4Hqg76A2hBj/eXjZHyJafy5DzuZuQXMyHgUlH1Cp/10+oUc4OXttfs+9BK1P+urYir2TzNuB4r2cnYcXxTPcCSQ7SZBmYf2xeb/IHeWENFyslMy7t86Ec5BoawHWDS9vSm5gkQ9nUh2D2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753070344; c=relaxed/simple;
	bh=cwTphhtoh6MFh9bdedIBc/YShP7J8BBw4CeQipoay6k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jrTRlfzZlIwetSc6Ku9jMMeFeXUl5PhOMxwVfeBpfNLSJpA4DzMW2jPhadb7Dg5G6BTQ1lncTvmp+X2brXkbt9Kc/wqDtDWI4xQlT1dEfvThibC7L/rhdqpILue1UNL1E30jvhJNEsAcZL0XbxMnQaoWPt63wZt8MBkspzADnnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4blmk94V3Rzdbvn;
	Mon, 21 Jul 2025 11:54:41 +0800 (CST)
Received: from kwepemk100018.china.huawei.com (unknown [7.202.194.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 01E5E180483;
	Mon, 21 Jul 2025 11:58:51 +0800 (CST)
Received: from vm7-217-32-6.huawei.com (7.217.32.6) by
 kwepemk100018.china.huawei.com (7.202.194.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 21 Jul 2025 11:58:50 +0800
From: Tao Xue <xuetao09@huawei.com>
To: <gregkh@linuxfoundation.org>, <Thinh.Nguyen@synopsys.com>,
	<prashanth.k@oss.qualcomm.com>, <m.grzeschik@pengutronix.de>,
	<Chris.Wulff@biamp.com>, <linux-usb@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <caiyadong@huawei.com>, <suzhuangluan@hisilicon.com>,
	<weiwenwen3@huawei.com>, <xuetao09@huawei.com>
Subject: [PATCH v2] usb: gadget : fix use-after-free in composite_dev_cleanup()
Date: Mon, 21 Jul 2025 11:58:49 +0800
Message-ID: <20250721035849.11330-1-xuetao09@huawei.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
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
v2: update Signed-off and commit message
v1: initial submission

 drivers/usb/gadget/composite.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
index 8dbc132a505e..385398a039ea 100644
--- a/drivers/usb/gadget/composite.c
+++ b/drivers/usb/gadget/composite.c
@@ -2489,6 +2489,7 @@ int composite_os_desc_req_prepare(struct usb_composite_dev *cdev,
 	if (!cdev->os_desc_req->buf) {
 		ret = -ENOMEM;
 		usb_ep_free_request(ep0, cdev->os_desc_req);
+		cdev->os_desc_req = NULL;
 		goto end;
 	}
 	cdev->os_desc_req->context = cdev;
-- 
2.17.1


