Return-Path: <linux-kernel+bounces-672035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0FBACCA14
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jun 2025 17:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55363167408
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jun 2025 15:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5F323BD1F;
	Tue,  3 Jun 2025 15:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="V4DUcFk6"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2BA70838
	for <linux-kernel@vger.kernel.org>; Tue,  3 Jun 2025 15:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748964231; cv=none; b=MmqbNgBjLnI80KV7dnJXPN28yK8PivMBvTzX3kQ2P7cluaxgsColFLqRl3S95kXvhNOfzPhJVQf1oRYgljcw0j7Hvi3vUYeMk1p6DU/XVdZ5zTEnu9ivebYSSDW/7uqpkP3n8y7JysZ8JMbBGwGgOS9Qr5fwvILysc58iv1xZxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748964231; c=relaxed/simple;
	bh=xUZjl/f7rrjC7vVvaWGgt0dWXd9uOKQXqsquXVAEHjw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=H6t+IIreqZd4mhkGjHKkVBCjam4HdA0pmxfwd+1nXMPu5cRXQpOfKyqG+c1W3g+KhI9SIZGTpymlF73YYqg1hAV0/SuW5KzZkuDRo9EdtdNGR2716pE45qv6oy7pHVVIBsKO/Gh8p3UbIi6XJMWdkiKbV2voaS+DDBw8lovh2RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=V4DUcFk6; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from DESKTOP-0403QTC.corp.microsoft.com (unknown [40.65.108.177])
	by linux.microsoft.com (Postfix) with ESMTPSA id 200342078636;
	Tue,  3 Jun 2025 08:23:44 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 200342078636
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1748964224;
	bh=wBl0r7kwlo7fnvAPoBKABVO9GEl2mESNh2EVanh8ih4=;
	h=From:To:Cc:Subject:Date:From;
	b=V4DUcFk6jh2Xo4/6WAUrXN3idhSmW6t59RiTXesQZz0HNtUxZV4s5szo8o6L8kflP
	 HbmTclcPQSHn7IgMU7H3ZtY+4L7P38k7LuuZ30S+hy0i1DiBY8FFvqPALKKLETchVD
	 z58dRXswdTGxmPH36/ewvqQSjmTQk/rnfwGGKnXM=
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: linux-kernel@vger.kernel.org,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Alex Williamson <alex.williamson@redhat.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	"jgg@nvidia.com" <jgg@nvidia.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: Zhang Yu <zhangyu1@microsoft.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>
Subject: [PATCH v2 1/2] vfio: Prevent open_count decrement to negative
Date: Tue,  3 Jun 2025 08:23:42 -0700
Message-Id: <20250603152343.1104-1-jacob.pan@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When vfio_df_close() is called with open_count=0, it triggers a warning in
vfio_assert_device_open() but still decrements open_count to -1. This
allows a subsequent open to incorrectly pass the open_count == 0 check,
leading to unintended behavior, such as setting df->access_granted = true.

For example, running an IOMMUFD compat no-IOMMU device with VFIO tests
(https://github.com/awilliam/tests/blob/master/vfio-noiommu-pci-device-open.c)
results in a warning and a failed VFIO_GROUP_GET_DEVICE_FD ioctl on the
first run, but the second run succeeds incorrectly.

Add checks to avoid decrementing open_count below zero.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
---
v2: Added Reviewed-by tags
---
 drivers/vfio/vfio_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
index 1fd261efc582..5046cae05222 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -583,7 +583,8 @@ void vfio_df_close(struct vfio_device_file *df)
 
 	lockdep_assert_held(&device->dev_set->lock);
 
-	vfio_assert_device_open(device);
+	if (!vfio_assert_device_open(device))
+		return;
 	if (device->open_count == 1)
 		vfio_df_device_last_close(df);
 	device->open_count--;
-- 
2.34.1


