Return-Path: <linux-kernel+bounces-749044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0A7B14946
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 09:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 779C55451B9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 07:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83FD726658F;
	Tue, 29 Jul 2025 07:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PTaYC16P"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25403264A74
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 07:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753774779; cv=none; b=TyA6cIRfqoUgG4cUI9lIclmOl8BFT+SxUO0nVCBKU2Ypc0osv4PMAy7fRgJYGg7Abyyq7vJqnORbf+skNxCWXyiRbyerkxwBLMXn3Qpq1P4TqcACMV3pOJWWV/Q4WhelltXxNUZJztBl/VtvYLVLkqh8+rMTyzicqN8UHU4jJZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753774779; c=relaxed/simple;
	bh=+Ysl3if1SXWQNZXdxFII6Dm8CGdVoYzAanR1NGAweUc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rIaO1XqIkhcnWKESI1LhQUonGG4HnMOg4Iav5R3vkh8P8HyDl3XchqzrtRlmdBg3eoyt3NCY+r1uJs5VQ24vuUsIpetkyH2JxkPPyBDulruztLFD1bxoaOjolHOwzTGZoP3vHBVhOSEHjHmlXc5yhrYjV4Z8qijs9Fipb+onyyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PTaYC16P; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753774776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nlhCSY/x94o/wsdtYQRoNxvT9uh4LXdBuYPdAR6ApYw=;
	b=PTaYC16Pyu/mvr6sw/7kguG07IN7sjb0OYnKU4HTa4rDfwhKrYvdx8BsxY2TnxrGpwX/3A
	d/P/5wwZTVYuLJN1foV5+7iRe+iM/NvQpA0D6XENn1qVIesVULSXKAUUEEv13Rt2cWfGpY
	0DKIqZWkyUxh4Uu2iFzFOOwj1wuPw+g=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-259-f6heyX8hODe7jUb8lZsN3w-1; Tue,
 29 Jul 2025 03:39:29 -0400
X-MC-Unique: f6heyX8hODe7jUb8lZsN3w-1
X-Mimecast-MFC-AGG-ID: f6heyX8hODe7jUb8lZsN3w_1753774766
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 851AB19560AE;
	Tue, 29 Jul 2025 07:39:25 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.89])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 10DD41800285;
	Tue, 29 Jul 2025 07:39:19 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	eperezma@redhat.com
Cc: kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sgarzare@redhat.com,
	will@kernel.org,
	JAEHOON KIM <jhkim@linux.ibm.com>,
	Breno Leitao <leitao@debian.org>
Subject: [PATCH] vhost: initialize vq->nheads properly
Date: Tue, 29 Jul 2025 15:39:16 +0800
Message-ID: <20250729073916.80647-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Commit 7918bb2d19c9 ("vhost: basic in order support") introduces
vq->nheads to store the number of batched used buffers per used elem
but it forgets to initialize the vq->nheads to NULL in
vhost_dev_init() this will cause kfree() that would try to free it
without be allocated if SET_OWNER is not called.

Reported-by: JAEHOON KIM <jhkim@linux.ibm.com>
Reported-by: Breno Leitao <leitao@debian.org>
Fixes: 7918bb2d19c9 ("vhost: basic in order support")
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/vhost.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index a4873d116df1..b4dfe38c7008 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -615,6 +615,7 @@ void vhost_dev_init(struct vhost_dev *dev,
 		vq->log = NULL;
 		vq->indirect = NULL;
 		vq->heads = NULL;
+		vq->nheads = NULL;
 		vq->dev = dev;
 		mutex_init(&vq->mutex);
 		vhost_vq_reset(dev, vq);
-- 
2.39.5


