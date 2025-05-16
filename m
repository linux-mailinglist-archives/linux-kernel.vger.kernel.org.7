Return-Path: <linux-kernel+bounces-651635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8D1ABA0F9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 May 2025 18:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 736C31C0140A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 May 2025 16:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2771DDC2B;
	Fri, 16 May 2025 16:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="eZshejLz"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548571DC9B8
	for <linux-kernel@vger.kernel.org>; Fri, 16 May 2025 16:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747413925; cv=none; b=htszEcQsyXYnerX9DWgHnF/uaWoN4jiJ71geidSlvCVuN0MbSMyN1ybPslr+xa3SoOWCTEQCZwV+3QGHH/divcn9DyGO7DHwpVyX6wtQXzlPlv4x9ObAwYiS5ajcPO/JwyIhD9RYN4c4IfY0xwntsRyoXUquxxhgWcbzHu/SwLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747413925; c=relaxed/simple;
	bh=YqE+W6jQxuTAJfbi5OS2/chhxfdK57zuGvwqfvYE7XA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=prUWF4CQj36KT9RyN3iV8YPFclc0xG8w/f24ItxppmUmarpBmniKuIPnCS1JpLi494+SM6uDn9+qeypCqWvE4wwKSxILEH6jXxwry0RadBm46fbf/yfUhyBVXSSmPoWGU329ncBuybbmXgnVyhTiwpde8j5+PvOSmP/NDfvz09k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=eZshejLz; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from DESKTOP-0403QTC.corp.microsoft.com (unknown [20.236.11.102])
	by linux.microsoft.com (Postfix) with ESMTPSA id A6044201DB31;
	Fri, 16 May 2025 09:45:23 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A6044201DB31
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1747413923;
	bh=SGcI4wZ1D7VewwWSgrIktnH/ABDLXFaUu5vyh5PjmTc=;
	h=From:To:Cc:Subject:Date:From;
	b=eZshejLzyRgCKiWxdo3juivYXL6ttLoFTZNBVz7eLj+qEBlP0WipqIntMSX5lNYP/
	 vkUCM7LcGQwFu1bpNs+G6BSVFMsF7jPRGiXysdgfr+zX7rY1yq89QO79nNYRXdUW6U
	 cGrxyt65L+tSYJmUQnT2kOaHxr0PKPb3rHCUrpvo=
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: linux-kernel@vger.kernel.org,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Alex Williamson <alex.williamson@redhat.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	"jgg@nvidia.com" <jgg@nvidia.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: Zhang Yu <zhangyu1@microsoft.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>
Subject: [PATCH 1/2] vfio: Fix unbalanced vfio_df_close call in no-iommu mode
Date: Fri, 16 May 2025 09:45:21 -0700
Message-Id: <20250516164522.51905-1-jacob.pan@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For no-iommu enabled devices working under IOMMUFD VFIO compat mode, the
group open path does not call vfio_df_open() and the open_count is 0. So
calling vfio_df_close() in the group close path will trigger warning in
vfio_assert_device_open(device);

E.g. The following warning can be seen by running VFIO test.
https://github.com/awilliam/tests/blob/master/vfio-noiommu-pci-device-open.c
CONFIG_VFIO_CONTAINER = n
[   29.094781] vfio-pci 0000:02:01.0: vfio-noiommu device opened by user (vfio-noiommu-pc:164)
Failed to get device info
[   29.096540] ------------[ cut here ]------------
[   29.096616] WARNING: CPU: 1 PID: 164 at drivers/vfio/vfio_main.c:487 vfio_df_close+0xac/0xb4

This patch adds checks for no-iommu mode and open_count to skip calling vfio_df_close.

Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
---
 drivers/vfio/group.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/vfio/group.c b/drivers/vfio/group.c
index c321d442f0da..834421149ffe 100644
--- a/drivers/vfio/group.c
+++ b/drivers/vfio/group.c
@@ -238,12 +238,13 @@ void vfio_df_group_close(struct vfio_device_file *df)
 	mutex_lock(&device->group->group_lock);
 	mutex_lock(&device->dev_set->lock);
 
-	vfio_df_close(df);
-	df->iommufd = NULL;
-
 	if (device->open_count == 0)
 		vfio_device_put_kvm(device);
 
+	if (!vfio_device_is_noiommu(device))
+		vfio_df_close(df);
+
+	df->iommufd = NULL;
 	mutex_unlock(&device->dev_set->lock);
 	mutex_unlock(&device->group->group_lock);
 }
-- 
2.34.1


