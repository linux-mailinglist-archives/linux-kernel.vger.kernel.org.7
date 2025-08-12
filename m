Return-Path: <linux-kernel+bounces-764223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4786B22020
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 10:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EA813B2613
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 07:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37BBD2DFA2A;
	Tue, 12 Aug 2025 07:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="r7yb3X2/"
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E214529BDAC
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 07:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754985549; cv=none; b=r/GCqrnsyKJt9foC82PLZH0DERg4cTSSrrT+eBoj9I1aJvtzFRdbfrdvI4ai7SH/186aNaHvZGm+PKW9WO8noW7TR3vz0q881f1YEYeuRAotH1INaksOZJnCubiK1oI4sB37IbZiAtOY7BESwmqkffsXQHkni43zhecbDANP/Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754985549; c=relaxed/simple;
	bh=DbCYlvp+Nqq/DkXn254DLcWQPyJQDF1pLJoekwIQSiM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=cLlkfKLvchWGsHI638xlCAv19pA+YpDpki1l+G62W86mVKtu8WDFohVTRjmeLqiWR8j9MR+p+tM1qTLeiEUYB9dtGRPEYMC/Y6yenwj6YEGHAfSlguXzKuGzDRWw1ymRFVOwfQyg433jg3OnOS8IyIdGOR4fXxu5MCSN+cTzXfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=r7yb3X2/; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250812075903epoutp02093716469e57ad14b49af112f27d8dc6~a9g3H1Lzs3015430154epoutp02R
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 07:59:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250812075903epoutp02093716469e57ad14b49af112f27d8dc6~a9g3H1Lzs3015430154epoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1754985543;
	bh=Zti1wjO1UjlveyU0dr46ymgnEgQrPxfFkW7q08MyKpY=;
	h=From:To:Cc:Subject:Date:References:From;
	b=r7yb3X2/8+SPzA6B4rLauW2+VJaqMO3XutcJmH4tY0Ja8Yd+/NemxjLIGnI1fAcgV
	 FFwqVnwnj+39mBHd9izfHWiC7Af7nLGOYZsmyJh2ynLWOw473jvGabKTQywG/QkMyC
	 fZj0PLcPzf0VWhLPa7uMZgX0aPwhZq1qTSmksC60=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20250812075903epcas5p278fb107a87ca7067f6c307eca48d83b9~a9g2kA0502927829278epcas5p24;
	Tue, 12 Aug 2025 07:59:03 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.89]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4c1P5x6lpPz2SSKm; Tue, 12 Aug
	2025 07:59:01 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250812075350epcas5p1cc4533582704978ec3a4a8b73dc1535c~a9cTo56871942019420epcas5p1h;
	Tue, 12 Aug 2025 07:53:50 +0000 (GMT)
Received: from asg29.. (unknown [109.105.129.29]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20250812075349epsmtip29897c66a9d79b3d305ada139381f8afe~a9cSEItUW1933319333epsmtip2I;
	Tue, 12 Aug 2025 07:53:49 +0000 (GMT)
From: Junnan Wu <junnan01.wu@samsung.com>
To: sudeep.holla@arm.com, cristian.marussi@arm.com
Cc: florian.fainelli@broadcom.com, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	lei19.wang@samsung.com, q1.huang@samsung.com, Junnan Wu
	<junnan01.wu@samsung.com>
Subject: [PATCH] firmware: arm_scmi: Set device ready before register
 scmi_virtio_driver
Date: Tue, 12 Aug 2025 15:53:43 +0800
Message-Id: <20250812075343.3201365-1-junnan01.wu@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250812075350epcas5p1cc4533582704978ec3a4a8b73dc1535c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-505,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250812075350epcas5p1cc4533582704978ec3a4a8b73dc1535c
References: <CGME20250812075350epcas5p1cc4533582704978ec3a4a8b73dc1535c@epcas5p1.samsung.com>

Fix irregularities in scmi driver probe.

After 'commit 20bda12a0ea0 ("firmware: arm_scmi: Make VirtIO transport a standalone driver")'
making SCMI VirtIO transport a standalone driver,
`scmi_virtio_probe` will follow `scmi_vio_probe`,
and during `scmi_virtio_probe`, it will do `scmi_probe` which will invoke
function `scmi_protocol_acquire(handle, SCMI_PROTOCOL_BASE)`,
and this function will send message via virtqueue and wait device's reply

Before this patch, only after `scmi_vio_probe`,
frontend will mark device DRIVER_OK by function `virtio_dev_probe`
in 'drivers/virtio/virtio.c' itself.

Accroding to chapter '3.1 Device Initialization' in virtio-spec,
```
The driver MUST NOT send any buffer available notifications
to the device before setting DRIVER_OK.
```

In some type1-hypervisor, available buffer notifications
will be intercepted until virtio driver is okay. In this case,
`scmi_vio_probe` will be blocked at `scmi_wait_for_reply`
and probe can never complete.

Therefore, the operation to set DRIVER_OK must follow
perform device-specific setup immediately,
then available buffer notifications can be sent in function `scmi_probe`.

Fixes: 20bda12a0ea0 ("firmware: arm_scmi: Make VirtIO transport a standalone driver")
Signed-off-by: Junnan Wu <junnan01.wu@samsung.com>
---
 drivers/firmware/arm_scmi/transports/virtio.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/firmware/arm_scmi/transports/virtio.c b/drivers/firmware/arm_scmi/transports/virtio.c
index cb934db9b2b4..326c4a93e44b 100644
--- a/drivers/firmware/arm_scmi/transports/virtio.c
+++ b/drivers/firmware/arm_scmi/transports/virtio.c
@@ -871,6 +871,9 @@ static int scmi_vio_probe(struct virtio_device *vdev)
 	/* Ensure initialized scmi_vdev is visible */
 	smp_store_mb(scmi_vdev, vdev);
 
+	/* Set device ready */
+	virtio_device_ready(vdev);
+
 	ret = platform_driver_register(&scmi_virtio_driver);
 	if (ret) {
 		vdev->priv = NULL;
-- 
2.34.1


