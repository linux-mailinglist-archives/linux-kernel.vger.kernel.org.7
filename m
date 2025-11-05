Return-Path: <linux-kernel+bounces-885956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C99CBC345F9
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 09:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D15B34E1B74
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 08:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038432580F2;
	Wed,  5 Nov 2025 08:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WvWIRhaJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD65A19D093
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 08:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762329737; cv=none; b=HSVYU7//rSJYYqN3WuDkF8+cC4qcI4FRHCX/+4S43hT3BjzvNSguSS4zQJixz7POvQELggW0rojvfrnkdB1VsiU0BdTaCQJ+9KjnRIIJ5lDCUxaSjZo6/U/1ny0J8P71LkzT3QfcFXoZKjrmIeKjgKm+XCBtnxiIOHdmtNs0Sno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762329737; c=relaxed/simple;
	bh=eMxORmOzUuI5OdwDROOfx+2eROrvTAMSvHg6lfs+y/Q=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=oGpAaCulCitWnl/oaySQeOUFr7Gy3u380OCITEw781xcbHUyIihoBL/319928ysa3d7QkL4YgLuKUC/kQGbWFDUrojk4jFOIsS8eUiHxFmzY7IqM2t/H0GD/gOTfKVmS9dIaOcXiBNn9yKXPz8N7IDJBU1awGkGPpcQsN1SWzfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WvWIRhaJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762329734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=w6f8wSwHsRTwr+h58t/mZjZ7NV8Io6r807CbA2kYWRE=;
	b=WvWIRhaJ1Hmxjk1wheqI5Oz1VMtMnQqyJSOIqF+gqfpAXRue5VPQaTMM4qHIqM1u4HFinm
	dzd/fOwBOZPL9vW3xMQf6oRzUTSDjnX13WpSGgTyCPcASXaDteDo+IO/f33orL7sjHDN4N
	84FSmctE0Lyvd6C+7m8T9Vv4a2N1Fng=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-612-C-jwHh3MN1SrklTbB3Q5Dw-1; Wed,
 05 Nov 2025 03:02:11 -0500
X-MC-Unique: C-jwHh3MN1SrklTbB3Q5Dw-1
X-Mimecast-MFC-AGG-ID: C-jwHh3MN1SrklTbB3Q5Dw_1762329730
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1D8D71956080;
	Wed,  5 Nov 2025 08:02:10 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.48])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2F3001800451;
	Wed,  5 Nov 2025 08:02:05 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	dtatulea@nvidia.com,
	mst@redhat.com,
	jasowang@redhat.com,
	netdev@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] vdpa/mlx5: update mlx_features with driver state check
Date: Wed,  5 Nov 2025 16:01:41 +0800
Message-ID: <20251105080151.1115698-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Add logic in mlx5_vdpa_set_attr() to ensure the VIRTIO_NET_F_MAC
feature bit is properly set only when the device is not yet in
the DRIVER_OK (running) state.

This makes the MAC address visible in the output of:

 vdpa dev config show -jp

when the device is created without an initial MAC address.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 82034efb74fc..e38aa3a335fc 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -4057,6 +4057,12 @@ static int mlx5_vdpa_set_attr(struct vdpa_mgmt_dev *v_mdev, struct vdpa_device *
 	ndev = to_mlx5_vdpa_ndev(mvdev);
 	mdev = mvdev->mdev;
 	config = &ndev->config;
+	if (!(ndev->mvdev.status & VIRTIO_CONFIG_S_DRIVER_OK)) {
+		ndev->mvdev.mlx_features |= BIT_ULL(VIRTIO_NET_F_MAC);
+	} else {
+		mlx5_vdpa_warn(mvdev, "device running, skip updating MAC\n");
+		return err;
+	}
 
 	down_write(&ndev->reslock);
 	if (add_config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR)) {
-- 
2.45.0


