Return-Path: <linux-kernel+bounces-840135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDBA0BB3A61
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 12:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBBF17A94B9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 10:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190B230AD09;
	Thu,  2 Oct 2025 10:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B15rVzJc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625BD30B530
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 10:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759401365; cv=none; b=Kya+UdKFhiYQK4eJk4B9JiEAQgM5GMI3fmwEwiufBVAtLGRX3fBo/aGuHYVobbYwJdMvV1R7kMn7VwI5W3+buGRTtkuYOcpwq1U9wHm0g4taIX7a/5Cwn4/2OcVt82OJMiC/L19jmxxk8GYoPqEPmlLSwnWwDEGI2Z/cbbGCwfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759401365; c=relaxed/simple;
	bh=goKcmOzmH9ogjIeR/aDjNdtZqVeWTMkhnZhMQaR/02w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hvud4yFbY2TC1jv6BKrrnu8kIlqdV53m+Ppwia/Hio6T6z1dCod8p0d4FWGsEn2j6pgfLe39E6RTck13Aigii9OJ7/DMKl4VmUe2ZRkw28IQyc4OFbXqRBIZfjm6k6NiMKO48Upu0BgEgxpypqN0AKPELgc3o9NhtRdjKLk1/us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B15rVzJc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759401361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iM0cA7tzuiWV6s6TW2GZ8k3Gv110oDPxpMncChVaQDg=;
	b=B15rVzJcR6GlWzPeYRjhklqyPNBFxwDvp5dwZO0fCNB4aQxOQQrD+uyEtchdeDoLPvrpf5
	vvgOWCrNhbVnn6LWxQc65DRPmyFhgYJG9yPWXvDN8KVY60BlLLmdaXFkmeRKH9Wqeg88EN
	dc0zto8PoArw0QfK0d+HG7EH26kYgzw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-369-BOo6szoQOACQRpbdzOvqrQ-1; Thu,
 02 Oct 2025 06:36:00 -0400
X-MC-Unique: BOo6szoQOACQRpbdzOvqrQ-1
X-Mimecast-MFC-AGG-ID: BOo6szoQOACQRpbdzOvqrQ_1759401358
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0B4F01800578;
	Thu,  2 Oct 2025 10:35:58 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.208])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1299A300018D;
	Thu,  2 Oct 2025 10:35:52 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: mst@redhat.com
Cc: Laurent Vivier <lvivier@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Dragos Tatulea DE <dtatulea@nvidia.com>,
	Cindy Lu <lulu@redhat.com>,
	Maxime Coquelin <mcoqueli@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>,
	jasowang@redhat.com,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	linux-kernel@vger.kernel.org,
	Jonah Palmer <jonah.palmer@oracle.com>,
	Si-Wei Liu <si-wei.liu@oracle.com>,
	virtualization@lists.linux.dev,
	=?UTF-8?q?Be=C3=B1at=20Gartzia=20Arruabarrena?= <bgartzia@redhat.com>
Subject: [RFC 2/2] vduse: allow to specify device-specific features if it's multiclass
Date: Thu,  2 Oct 2025 12:35:37 +0200
Message-ID: <20251002103537.308717-3-eperezma@redhat.com>
In-Reply-To: <20251002103537.308717-1-eperezma@redhat.com>
References: <20251002103537.308717-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Even if the device supports more than one class, there are ways to solve
the ambiguity of which device are we creating.  In the VDUSE case it is
the name, for example.

RFC: I fon't understand 100% the motivation of this limitation, as the
backend should be the one filtering out the invalid features if any.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 drivers/vdpa/vdpa.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index 34874beb0152..0fc32f3bd66f 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -688,15 +688,6 @@ static int vdpa_nl_cmd_dev_add_set_doit(struct sk_buff *skb, struct genl_info *i
 		err = -EINVAL;
 		goto err;
 	}
-	if (!(config.mask & VDPA_DEV_NET_ATTRS_MASK) &&
-	    config.mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES) &&
-	    classes & BIT_ULL(VIRTIO_ID_NET) && ncls > 1 &&
-	    config.device_features & VIRTIO_DEVICE_F_MASK) {
-		NL_SET_ERR_MSG_MOD(info->extack,
-				   "Management device supports multi-class while device features specified are ambiguous");
-		err = -EINVAL;
-		goto err;
-	}

 	err = mdev->ops->dev_add(mdev, name, &config);
 err:
--
2.51.0


