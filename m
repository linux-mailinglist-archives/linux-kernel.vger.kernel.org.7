Return-Path: <linux-kernel+bounces-783886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F006B333D9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 04:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9921C189E36A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 02:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C5522576C;
	Mon, 25 Aug 2025 02:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="nWJvpIq9"
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC59131E49
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 02:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756087638; cv=none; b=OrAJ4NNS/0Z6+Ik2H8U5NDuEcZ4v7TQxoDEXEV5AXPT4+znoE0PJ3tNp7PDMS7ZQ1F+jM3bxmGRG24Qnm9wC+5zbCO/XrySPJ93YwViGKaqJdvbHWYN8QFKNdQOwEhKA+P205RYEICvq6yZ+srTUCIzyTc55o5LmjY4PJCdsEpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756087638; c=relaxed/simple;
	bh=wle9r2gsnhO7JaaLb1bCPkD7qWWf9Zu+D8DM/DNZTjw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=Qkqo1f0IibM3Y7rartQsFFHleKZ54yw7OevYeaJWPF0aYFFIn5Mx3iQO4PXWakeTnsKDbSNUotYV5Tu0LzIqSmdr9oNEeQQ21AEE9KxnY2H6vv2B1PA3ikiLLH9rxAOLDtX+ar8o/90/KGeIG+aib0bXwefpzxyfUXHnEbf2AJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=nWJvpIq9; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250825020707epoutp041cfb100363d350d15cf5ffe5bf65e258~e4GSqRprv0871708717epoutp04z
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 02:07:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250825020707epoutp041cfb100363d350d15cf5ffe5bf65e258~e4GSqRprv0871708717epoutp04z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1756087627;
	bh=eLnMXqyfqg1qktU4SrlD9F/Y1gqGVc8jfzRmVy/nmCI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nWJvpIq9v4HQuO53y9CEaOIw+/g6Lt3XgWw7aKZtNkJbrCL+2G+U/pW42aZvZQvU2
	 bzKOepmXBzXyx/ivLpbCmnkFQ5XGjoEgz/ZP0EHO05BCH8K1ZAM5CVTYFO6CJOL7Sj
	 luBy3Vfpjh2Y7QBuMnKARLj+y8hMO3YBZ+nTfr1o=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20250825020707epcas5p456f163e3bca934301a8cdcd40f8874f6~e4GSF1zka1083410834epcas5p46;
	Mon, 25 Aug 2025 02:07:07 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.87]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4c9Dgs6xxCz3hhT8; Mon, 25 Aug
	2025 02:07:05 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250825020428epcas5p16a3306486407502504ca75bbe549927e~e4D_J20hW2609326093epcas5p1A;
	Mon, 25 Aug 2025 02:04:28 +0000 (GMT)
Received: from asg29.. (unknown [109.105.129.29]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20250825020426epsmtip2664683fd89c1dd09d5a8c452b6061d25~e4D89fvNJ2221922219epsmtip2a;
	Mon, 25 Aug 2025 02:04:26 +0000 (GMT)
From: Ying Gao <ying01.gao@samsung.com>
To: ying01.gao@samsung.com
Cc: eperezma@redhat.com, jasowang@redhat.com, junnan01.wu@samsung.com,
	kraxel@redhat.com, lei19.wang@samsung.com, linux-kernel@vger.kernel.org,
	liping.qi@samsung.com, mst@redhat.com, virtualization@lists.linux.dev,
	xuanzhuo@linux.alibaba.com, ying123.xu@samsung.com
Subject: [PATCH V2 RESEND] virtio_input: Improve freeze handling
Date: Mon, 25 Aug 2025 10:04:24 +0800
Message-Id: <20250825020424.1436159-1-ying01.gao@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250812095118.3622717-1-ying01.gao@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250825020428epcas5p16a3306486407502504ca75bbe549927e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-505,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250825020428epcas5p16a3306486407502504ca75bbe549927e
References: <20250812095118.3622717-1-ying01.gao@samsung.com>
	<CGME20250825020428epcas5p16a3306486407502504ca75bbe549927e@epcas5p1.samsung.com>

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


