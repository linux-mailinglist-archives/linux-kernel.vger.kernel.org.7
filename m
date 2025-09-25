Return-Path: <linux-kernel+bounces-832293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB26B9ED58
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 12:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7025F7B5BFC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 10:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BDD82F5A18;
	Thu, 25 Sep 2025 10:56:25 +0000 (UTC)
Received: from out198-7.us.a.mail.aliyun.com (out198-7.us.a.mail.aliyun.com [47.90.198.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF4614658D
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 10:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758797784; cv=none; b=IiG9Uw82bJNz9CmjgDsJvMGZI6nzEuhBEWB96rXZufiqRQM1N6H2wo25s8ZA7OB/mJnswuGgvj8iojdUGiMHMOrdtxeOZfJhbQrQPIth+YjXe7kVbQsnmi13VFWm3N82M7AE+xn7lkUF0FLaRCxNoZWONMf1jKJ3nHmXVxzYQYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758797784; c=relaxed/simple;
	bh=3G3Y+AWzit3fpqOTYiBWzRQkvvmf0vgVueTgeuaEk5U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iAskW8tt5D5JwdI0awGAZNtg6bPq14/akc2ixnZfxNFbbdGTg+xnyVPSC7HFLl3qNDbylJJjvRJBeVnDE7ScHOJ8AG6tXYJ/+vBxeNTejeJYrX3lpuCzzRtaXt2G/iC8/1YAK7FKdyd8RMrYCRTbYVcFkUL1EUZMViYNMPYvvLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bosc.ac.cn; spf=pass smtp.mailfrom=bosc.ac.cn; arc=none smtp.client-ip=47.90.198.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bosc.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bosc.ac.cn
Received: from guoyaxing.localdomain(mailfrom:guoyaxing@bosc.ac.cn fp:SMTPD_---.enEG1Zm_1758796830 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 25 Sep 2025 18:40:30 +0800
From: Yaxing Guo <guoyaxing@bosc.ac.cn>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	wangran@bosc.ac.cn,
	zhangjian@bosc.ac.cn,
	anxu@bosc.ac.cn,
	guoyaxing@bosc.ac.cn
Subject: [PATCH v2 3/3] doc: Add ABI documentation for uio_pci_sva driver sysfs attributes
Date: Thu, 25 Sep 2025 18:40:18 +0800
Message-Id: <20250925104018.57053-3-guoyaxing@bosc.ac.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250925104018.57053-1-guoyaxing@bosc.ac.cn>
References: <20250925104018.57053-1-guoyaxing@bosc.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add ABI documentation for the sysfs interface provided by the
uio_pci_sva driver, specifically the 'pasid' attribute.

The 'pasid' attribute exposes the Process Address Space ID (PASID)
assigned by the IOMMU to the device for use with Shared Virtual
Addressing (SVA). User-space UIO applications read this attribute
to obtain the PASID and program it into the device's configuration
registers, enabling the device to perform DMA using user-space
virtual addresses.

This attribute appears under:
/sys/bus/pci/drivers/uio_pci_sva/<pci_dev>/pasid

Signed-off-by: Yaxing Guo <guoyaxing@bosc.ac.cn>
---
 .../ABI/testing/sysfs-driver-uio_pci_sva-pasid    | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-uio_pci_sva-pasid

diff --git a/Documentation/ABI/testing/sysfs-driver-uio_pci_sva-pasid b/Documentation/ABI/testing/sysfs-driver-uio_pci_sva-pasid
new file mode 100644
index 000000000000..a6afa8c2775c
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-driver-uio_pci_sva-pasid
@@ -0,0 +1,15 @@
+What:		/sys/bus/pci/drivers/uio_pci_sva/<pci_dev>/pasid
+Date:		September 2025
+Contact:	Yaxing Guo <guoyaxing@bosc.ac.cn>
+Description:
+		Process Address Space ID (PASID) assigned by IOMMU driver to
+		the device for use witch Shared Virtual Addressing (SVA).
+
+		This read-only attribute exposes the PASID allocated by the
+		IOMMU driver during sva device binding.
+
+		User-space UIO applications must read this attribute to
+		obtain the PASID and program it into the device's configuration
+		registers. This enables the device to perform DMA using
+		user-space virtual address, with address translation handled
+		by IOMMU.
-- 
2.34.1


