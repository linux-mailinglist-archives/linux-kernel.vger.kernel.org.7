Return-Path: <linux-kernel+bounces-765664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D07FB23C3F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 01:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C48F1897F4B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 23:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D57E2DEA99;
	Tue, 12 Aug 2025 23:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="X3WmcE+A"
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D2E2D0620
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 23:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755040831; cv=none; b=RdMLSBKzz31QPhfjsnS3Z1SKs2Euj4s4QtMzrsaSGwZVDLlVN6SuX+tAW7IziPfxaAuZV+t9X1EBhrV++bTOvRusHHPvds4JdTdOhgT2dcdkH6dspsmBhQAKRd26YHRCnA3llDee8irKn7k3uW4lfsOZUnLO3CfPJk6tdxHUofY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755040831; c=relaxed/simple;
	bh=wle9r2gsnhO7JaaLb1bCPkD7qWWf9Zu+D8DM/DNZTjw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=hNKn86l9Z96+CCGoKM5mH03Sfe7CV+Wyk31pT8Pyhh8eyOfT0poc5wMAKtwI5kXOw+E0d719cMg784o4trGiu0GEMQFixtwOmXLPHuhYeLzPB5o7uUiHUrecI3eGTijwWj++VIka+eDxDWXpeAS98o2xDfI58kNkoWthAca1SgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=X3WmcE+A; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250812232026epoutp029b0d820706846c0903e8adda8d7f2661~bKFUqPaZ02603026030epoutp02z
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 23:20:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250812232026epoutp029b0d820706846c0903e8adda8d7f2661~bKFUqPaZ02603026030epoutp02z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1755040826;
	bh=eLnMXqyfqg1qktU4SrlD9F/Y1gqGVc8jfzRmVy/nmCI=;
	h=From:To:Cc:Subject:Date:References:From;
	b=X3WmcE+ALVT0ddLK6NnAClCAj+pEm8KYoJY3fXeIdyJ7dAfQXdjY9GbL7pO0MTvuH
	 PFO3mfeaEDP7OEHC/oJI2v45xYcDxRqybV1wyK63LXGZEGZm93vdZefwJRNdS46c6/
	 DM/uK6QBI1sh+zUY96FFUQiDEC4eTSLIoX4hTKLg=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20250812232025epcas5p14d7f42eedf5b2403536eae76232f848d~bKFTxM57n0474904749epcas5p1D;
	Tue, 12 Aug 2025 23:20:25 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.92]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4c1nY42bxGz6B9mF; Tue, 12 Aug
	2025 23:20:24 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250812095108epcas5p3aebdbf9e790cd259173d54611652a97b~a-CuL4_aG1911819118epcas5p3b;
	Tue, 12 Aug 2025 09:51:08 +0000 (GMT)
Received: from asg29.. (unknown [109.105.129.29]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20250812095107epsmtip14a9258f84c8573280a6948e6f6ea6767~a-Cs27tkY0384203842epsmtip1B;
	Tue, 12 Aug 2025 09:51:07 +0000 (GMT)
From: Ying Gao <ying01.gao@samsung.com>
To: kraxel@redhat.com, mst@redhat.com, jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	ying123.xu@samsung.com, lei19.wang@samsung.com, liping.qi@samsung.com,
	junnan01.wu@samsung.com, Ying Gao <ying01.gao@samsung.com>
Subject: [PATCH] virtio_input: Improve freeze handling
Date: Tue, 12 Aug 2025 17:51:18 +0800
Message-Id: <20250812095118.3622717-1-ying01.gao@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250812095108epcas5p3aebdbf9e790cd259173d54611652a97b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-505,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250812095108epcas5p3aebdbf9e790cd259173d54611652a97b
References: <CGME20250812095108epcas5p3aebdbf9e790cd259173d54611652a97b@epcas5p3.samsung.com>

When executing suspend to ram, if lacking the operations
to reset device and free unused buffers before deleting
a vq, resource leaks and inconsistent device status will
appear.

According to chapter "3.3.1 Driver Requirements: Device Cleanup:"
of virtio-specification:
  Driver MUST ensure a virtqueue isn’t live
  (by device reset) before removing exposed
  buffers.

Therefore, modify the virtinput_freeze function to reset the
device and delete the unused buffers before deleting the
virtqueue, just like virtinput_remove does.

Co-developed-by: Ying Xu <ying123.xu@samsung.com>
Signed-off-by: Ying Xu <ying123.xu@samsung.com>
Co-developed-by: Junnan Wu <junnan01.wu@samsung.com>
Signed-off-by: Junnan Wu <junnan01.wu@samsung.com>
Signed-off-by: Ying Gao <ying01.gao@samsung.com>
---
 drivers/virtio/virtio_input.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/virtio/virtio_input.c b/drivers/virtio/virtio_input.c
index a5d63269f20b..d0728285b6ce 100644
--- a/drivers/virtio/virtio_input.c
+++ b/drivers/virtio/virtio_input.c
@@ -360,11 +360,15 @@ static int virtinput_freeze(struct virtio_device *vdev)
 {
 	struct virtio_input *vi = vdev->priv;
 	unsigned long flags;
+	void *buf;
 
 	spin_lock_irqsave(&vi->lock, flags);
 	vi->ready = false;
 	spin_unlock_irqrestore(&vi->lock, flags);
 
+	virtio_reset_device(vdev);
+	while ((buf = virtqueue_detach_unused_buf(vi->sts)) != NULL)
+		kfree(buf);
 	vdev->config->del_vqs(vdev);
 	return 0;
 }
-- 
2.34.1


