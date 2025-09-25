Return-Path: <linux-kernel+bounces-831710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD03B9D5F5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 06:12:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B910B2E27AF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 04:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450B52E54BB;
	Thu, 25 Sep 2025 04:12:23 +0000 (UTC)
Received: from out28-194.mail.aliyun.com (out28-194.mail.aliyun.com [115.124.28.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E7B2E1C4E
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 04:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758773542; cv=none; b=rK7l+voLMGOxfl63oSIE/iY8rc65AsPqcRX5+G3TRuOAdPdma+b09vUl6GobKuYC6pdIppxIIqPPUww77/isem6f03F7vRoJTYldi7YPqdVCDOmBd6kPKpQSWYkiJEajY8FZ9z8yZrfmKe3hZSjpsNYFEolkn1bIHOEwK03ph2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758773542; c=relaxed/simple;
	bh=FLv6LGcd1tKqqHQ7u99I/zUG860O5FcjU5A7HuY8n6o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U6xyxli+8Xi2PqS8y7mOFTZUiW9/Eg6hvZ9W0TXMpWbgp2smUqSaMhdNiFDOP04rDeEaErppZNvGC5yEu/aEgIkUjcpKk0xW8WS8NdwT4LiLoml8ZGCqsjuZgWeKToJaLUdtBkR/nR0wTA74DGDsJCNMHEKV3TWxKNsHDxhvWV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bosc.ac.cn; spf=pass smtp.mailfrom=bosc.ac.cn; arc=none smtp.client-ip=115.124.28.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bosc.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bosc.ac.cn
Received: from guoyaxing.localdomain(mailfrom:guoyaxing@bosc.ac.cn fp:SMTPD_---.emomPLE_1758773209 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 25 Sep 2025 12:06:51 +0800
From: Yaxing Guo <guoyaxing@bosc.ac.cn>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	anxu@bosc.ac.cn,
	zhangjian@bosc.ac.cn,
	wangran@bosc.an.cn,
	guoyaxing@bosc.ac.cn
Subject: [RFC v1 2/2] uio: Add Kconfig and Makefile support for UIO_PCI_GENERIC_SVA
Date: Thu, 25 Sep 2025 12:06:37 +0800
Message-Id: <20250925040637.14511-2-guoyaxing@bosc.ac.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250925040637.14511-1-guoyaxing@bosc.ac.cn>
References: <20250925040637.14511-1-guoyaxing@bosc.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add config symbol and build infrastructure for the UIO PCI generic
driver with SVA (Shared Virtual Addressing) support.

This introduces:
- A new tristate config option 'UIO_PCI_GENERIC_SVA' in Kconfig,
  dependent on PCI and IOMMU_SVA.
- Build rule in Makefile to compile uio_pci_generic_sva.o when enabled.

Signed-off-by: Yaxing Guo <guoyaxing@bosc.ac.cn>
---
 drivers/uio/Kconfig  | 5 +++++
 drivers/uio/Makefile | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/uio/Kconfig b/drivers/uio/Kconfig
index b060dcd7c635..9849e53d1932 100644
--- a/drivers/uio/Kconfig
+++ b/drivers/uio/Kconfig
@@ -164,4 +164,9 @@ config UIO_DFL
 	    opae-sdk/tools/libopaeuio/
 
 	  If you compile this as a module, it will be called uio_dfl.
+
+config UIO_PCI_GENERIC_SVA
+	tristate "Generic driver for PCI Express that supports sva"
+	depends on PCI && IOMMU_SVA
+
 endif
diff --git a/drivers/uio/Makefile b/drivers/uio/Makefile
index 1c5f3b5a95cf..5352e21e918d 100644
--- a/drivers/uio/Makefile
+++ b/drivers/uio/Makefile
@@ -11,3 +11,4 @@ obj-$(CONFIG_UIO_MF624)         += uio_mf624.o
 obj-$(CONFIG_UIO_FSL_ELBC_GPCM)	+= uio_fsl_elbc_gpcm.o
 obj-$(CONFIG_UIO_HV_GENERIC)	+= uio_hv_generic.o
 obj-$(CONFIG_UIO_DFL)	+= uio_dfl.o
+obj-$(CONFIG_UIO_PCI_GENERIC_SVA)  += uio_pci_generic_sva.o
-- 
2.34.1


