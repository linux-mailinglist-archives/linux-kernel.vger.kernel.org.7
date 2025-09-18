Return-Path: <linux-kernel+bounces-822734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42669B848C3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 14:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02F52620F53
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 12:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D58C245022;
	Thu, 18 Sep 2025 12:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZdcrRiYG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB6818BBB9
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 12:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758197977; cv=none; b=Nop3uTYx4mSY9Lfi/ZmzF0MRjoIv5w74V46lBTzTzxbfJgsswvQWLJM2FouPZSPKYxktDTKeLBOI7CA/eN14mmoehhZJU7ZAW8peuc430Nnt3VJXyEIbBXGo8VwpZkMtgeupdyP/n2RQG/5Xd2mqbxQH2xenJxlTBZARm+mRmSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758197977; c=relaxed/simple;
	bh=OaCB53Z5SxqHSpEbGWruf27ccEnxMfEFjrfpUpX4zs8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=T2K0CYQl9JZj7DZ0j7cPidrvUc8vUZtaf+FHndUCDHDrstxiEZttLgWpiq/zagGW3BJ//x06ZtKfQTT3ush54XF5ARlCM4APYWUNloi47Nxa5hKyFD0+wJylokwR6bU5R4Ae39IP9Gy3D6N2pH7+3YXkUcjYrsLbY06ef58zFQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZdcrRiYG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758197974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oLHeVQ1V5+rlFvLH0NK0a8N3VCQk3wWRUgjhebQLwJ0=;
	b=ZdcrRiYGVlaQHYQBqqqoxOA5ipdHdMg/89+pftET9IRE6Z7n/w7WHNi1+kr/0A4JAFD0Rb
	mCZB1XpmBcHH2id0PpFsdNTwkooHVmP+B51UtaHWU7/RONSB1XEKci/U1bfXHmBvrwPQX4
	yS+gxrVLhaxvWF2PJlWUC+tzF/Q9XKo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-496-GLAfXEgDNni5Jft2awUMDw-1; Thu,
 18 Sep 2025 08:19:33 -0400
X-MC-Unique: GLAfXEgDNni5Jft2awUMDw-1
X-Mimecast-MFC-AGG-ID: GLAfXEgDNni5Jft2awUMDw_1758197972
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 64ADD1955F0E;
	Thu, 18 Sep 2025 12:19:32 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.90])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B75711955F19;
	Thu, 18 Sep 2025 12:19:30 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH] vfio: Dump migration features under debugfs
Date: Thu, 18 Sep 2025 14:19:28 +0200
Message-ID: <20250918121928.1921871-1-clg@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

A debugfs directory was recently added for VFIO devices. Add a new
"features" file under the migration sub-directory to expose which
features the device supports.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 drivers/vfio/debugfs.c                 | 19 +++++++++++++++++++
 Documentation/ABI/testing/debugfs-vfio |  6 ++++++
 2 files changed, 25 insertions(+)

diff --git a/drivers/vfio/debugfs.c b/drivers/vfio/debugfs.c
index 298bd866f15766b50e342511d8a83f0621cb4f55..8b0ca7a09064072b3d489dab8072dbb1a2871d10 100644
--- a/drivers/vfio/debugfs.c
+++ b/drivers/vfio/debugfs.c
@@ -58,6 +58,23 @@ static int vfio_device_state_read(struct seq_file *seq, void *data)
 	return 0;
 }
 
+static int vfio_device_features_read(struct seq_file *seq, void *data)
+{
+	struct device *vf_dev = seq->private;
+	struct vfio_device *vdev = container_of(vf_dev, struct vfio_device, device);
+
+	if (vdev->migration_flags & VFIO_MIGRATION_STOP_COPY)
+		seq_puts(seq, "stop-copy\n");
+	if (vdev->migration_flags & VFIO_MIGRATION_P2P)
+		seq_puts(seq, "p2p\n");
+	if (vdev->migration_flags & VFIO_MIGRATION_PRE_COPY)
+		seq_puts(seq, "pre-copy\n");
+	if (vdev->log_ops)
+		seq_puts(seq, "dirty-tracking\n");
+
+	return 0;
+}
+
 void vfio_device_debugfs_init(struct vfio_device *vdev)
 {
 	struct device *dev = &vdev->device;
@@ -72,6 +89,8 @@ void vfio_device_debugfs_init(struct vfio_device *vdev)
 							vdev->debug_root);
 		debugfs_create_devm_seqfile(dev, "state", vfio_dev_migration,
 					    vfio_device_state_read);
+		debugfs_create_devm_seqfile(dev, "features", vfio_dev_migration,
+					    vfio_device_features_read);
 	}
 }
 
diff --git a/Documentation/ABI/testing/debugfs-vfio b/Documentation/ABI/testing/debugfs-vfio
index 90f7c262f591306bdb99295ab4e857ca0e0b537a..70ec2d454686290e13380340dfd6a5a67a642533 100644
--- a/Documentation/ABI/testing/debugfs-vfio
+++ b/Documentation/ABI/testing/debugfs-vfio
@@ -23,3 +23,9 @@ Contact:	Longfang Liu <liulongfang@huawei.com>
 Description:	Read the live migration status of the vfio device.
 		The contents of the state file reflects the migration state
 		relative to those defined in the vfio_device_mig_state enum
+
+What:		/sys/kernel/debug/vfio/<device>/migration/features
+Date:		Oct 2025
+KernelVersion:	6.18
+Contact:	Cédric Le Goater <clg@redhat.com>
+Description:	Read the migration features of the vfio device.
-- 
2.51.0


