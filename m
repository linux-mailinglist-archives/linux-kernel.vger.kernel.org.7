Return-Path: <linux-kernel+bounces-844276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 812CFBC16F4
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 15:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE1401893EDC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 13:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAEA42E093B;
	Tue,  7 Oct 2025 13:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZzP9Ozgs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AC12E090A
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 13:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759842404; cv=none; b=T4r9yxtEx7AuxgQcc2Utt4/fE8M9CfbG7QoNkd3wElkseFykihXGpWiwHbE9sNbQn4lzrGaa2/8EqVnadXvIp0p+nqQcYnO0tDoS3d8BPFiBqgHovQvsXb8sVdv5ZlotcZ8seyViKLtifITWx50yBAHhfTWY/kmZKcFmrSsVfE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759842404; c=relaxed/simple;
	bh=jH8USJFHz+TatYvQZyvEvjcRufE0ISgWbue5iU4IKbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o4nNTc7Evv3w3QgBv+sgRAbe3Q1sorpG+RoPdkme0Z/tAi5dErpNNT5sT7/zq3h6iK0KwHF3YKPPb3KQ9LR3TkVpEWHrD3TEfc28clmxDVD+f3xQ+BcjZzFtwualyjjuaW8M7fX7CMQuVApY3CO4EnKZy/+QCj34QniZCouTm68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZzP9Ozgs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759842401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aT4NoVByCHa+UoA8fJzK7MRZDygxEBVSeNmApVyKU04=;
	b=ZzP9OzgsuDgGM9tD+E/ZKZ4INHuxV1K2ZSTqD/hr2Wk1/Nm7nclJVusVJgaOLEjEPZImKs
	ONOA6HqL9o7BwKDy6F9QpzPTZS3zOBVY4l8Uv+4dEYoER4en+RYy7XFPaVGMtOOJcE5fvz
	Dxe7aSAB2Tg7P/5nrv55UsAiPyEGTXg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-281-13BoF1p0OoK1U4tSRjAaQA-1; Tue,
 07 Oct 2025 09:06:38 -0400
X-MC-Unique: 13BoF1p0OoK1U4tSRjAaQA-1
X-Mimecast-MFC-AGG-ID: 13BoF1p0OoK1U4tSRjAaQA_1759842397
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9FE811956095;
	Tue,  7 Oct 2025 13:06:36 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.223])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2FA321800446;
	Tue,  7 Oct 2025 13:06:32 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: mst@redhat.com
Cc: Yongji Xie <xieyongji@bytedance.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Maxime Coquelin <mcoqueli@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Dragos Tatulea DE <dtatulea@nvidia.com>,
	jasowang@redhat.com
Subject: [RFC 2/2] vduse: lift restriction about net devices with CVQ
Date: Tue,  7 Oct 2025 15:06:22 +0200
Message-ID: <20251007130622.144762-3-eperezma@redhat.com>
In-Reply-To: <20251007130622.144762-1-eperezma@redhat.com>
References: <20251007130622.144762-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Now that the virtio_net driver is able to recover from a stall
virtqueue, let's lift the restriction.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index e7bced0b5542..95d2b898171d 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -1726,9 +1726,6 @@ static bool features_is_valid(struct vduse_dev_config *config)
 	if ((config->device_id == VIRTIO_ID_BLOCK) &&
 			(config->features & BIT_ULL(VIRTIO_BLK_F_CONFIG_WCE)))
 		return false;
-	else if ((config->device_id == VIRTIO_ID_NET) &&
-			(config->features & BIT_ULL(VIRTIO_NET_F_CTRL_VQ)))
-		return false;
 
 	if ((config->device_id == VIRTIO_ID_NET) &&
 			!(config->features & BIT_ULL(VIRTIO_F_VERSION_1)))
-- 
2.51.0


