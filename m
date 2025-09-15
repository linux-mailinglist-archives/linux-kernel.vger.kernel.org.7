Return-Path: <linux-kernel+bounces-816803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC35B57879
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 13:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DCBA1888AB5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 11:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F59A302CC6;
	Mon, 15 Sep 2025 11:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PbUf79EV"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052BF302CB8
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 11:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757935811; cv=none; b=Sbdx/kVhAnNSMjo5V1ZY2MqcR9SX+kyEgAhKFAw8zkwVCEqdqqv5jmlVSoCW/uGjPBkoh0/l9aClAEai9hVxXS4v51/TMXe0gJs1W+XTxIRzQlwOS24d9njMUo2cLG29qWCD4VVYBPdqEEo4dCXo+5zzVRDNipVo7rG6b7VdJIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757935811; c=relaxed/simple;
	bh=JTcx2kpQ7zRIgaRp5h2WvtgL+5DcaVnzBt55fgBf12s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=IYe5sgtyaHocn6/VWtKiw0ViSnBQ7U+g+Rrm4sMwLGbbKjYrY8luRLbOQu9Np2WN3Mek/S5MpJ2zWgFBuR9yMW/08J0I8t+1CE0gCexmhUpns8AlH23dyWDddfkrcOVhtvtuvg+IG0r1+iSG1slhiJ/HuJHzQbX9T66NzUw5Hbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PbUf79EV; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757935811; x=1789471811;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JTcx2kpQ7zRIgaRp5h2WvtgL+5DcaVnzBt55fgBf12s=;
  b=PbUf79EVMPvnacAb9hO+U8s/CkVzKOjqbpghFGEBXvEjS4kdrOWNM6yK
   jpnMLU/p7bAeY7mj+pyrMkUxwwMvPQAyJjepeOhss80v013DgwvREmMld
   bZFyWACtXv1FwPuY0qtHqj4oj8TKT78yFeRNtefgSitv+16BZ/zZY6K8x
   I5DXLTio7KMnAFOZlsFW9nfVadQxW+hPRmysT9bGWIOnYeciArAe7Avo9
   q+bJdDJtzrl0BHCySThmWgSNyQFtgiGx1hyDOCRDnYJB6K3MJ9EMSBOf1
   yBtOQMH8uq8+/Halzs7Dsl71mNhXUn90k3GUvS2ZjPD1lH+/xQn72KSn1
   g==;
X-CSE-ConnectionGUID: IOuLlB1OS/yKTx/8EIK3NA==
X-CSE-MsgGUID: gDMa2qEHT2CdEbMK41/ofQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11553"; a="63819429"
X-IronPort-AV: E=Sophos;i="6.18,266,1751266800"; 
   d="scan'208";a="63819429"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 04:30:10 -0700
X-CSE-ConnectionGUID: JjTz/iX6QVOc56rK3TLXig==
X-CSE-MsgGUID: nl+DxspLSpC5aDH0C6fY5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,266,1751266800"; 
   d="scan'208";a="174202793"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.39])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 04:30:08 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Lee Jones <lee@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 1/1] mfd: intel-lpss: Add Intel Wildcat Lake LPSS PCI IDs
Date: Mon, 15 Sep 2025 14:29:36 +0300
Message-Id: <20250915112936.10696-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add Intel Wildcat Lake PCI IDs.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/mfd/intel-lpss-pci.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/mfd/intel-lpss-pci.c b/drivers/mfd/intel-lpss-pci.c
index 1a5b8b13f8d0..8d92c895d3ae 100644
--- a/drivers/mfd/intel-lpss-pci.c
+++ b/drivers/mfd/intel-lpss-pci.c
@@ -367,6 +367,19 @@ static const struct pci_device_id intel_lpss_pci_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0x4b79), (kernel_ulong_t)&ehl_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0x4b7a), (kernel_ulong_t)&ehl_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0x4b7b), (kernel_ulong_t)&ehl_i2c_info },
+	/* WCL */
+	{ PCI_VDEVICE(INTEL, 0x4d25), (kernel_ulong_t)&bxt_uart_info },
+	{ PCI_VDEVICE(INTEL, 0x4d26), (kernel_ulong_t)&bxt_uart_info },
+	{ PCI_VDEVICE(INTEL, 0x4d27), (kernel_ulong_t)&tgl_spi_info },
+	{ PCI_VDEVICE(INTEL, 0x4d30), (kernel_ulong_t)&tgl_spi_info },
+	{ PCI_VDEVICE(INTEL, 0x4d46), (kernel_ulong_t)&tgl_spi_info },
+	{ PCI_VDEVICE(INTEL, 0x4d50), (kernel_ulong_t)&ehl_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x4d51), (kernel_ulong_t)&ehl_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x4d52), (kernel_ulong_t)&bxt_uart_info },
+	{ PCI_VDEVICE(INTEL, 0x4d78), (kernel_ulong_t)&ehl_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x4d79), (kernel_ulong_t)&ehl_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x4d7a), (kernel_ulong_t)&ehl_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x4d7b), (kernel_ulong_t)&ehl_i2c_info },
 	/* JSL */
 	{ PCI_VDEVICE(INTEL, 0x4da8), (kernel_ulong_t)&spt_uart_info },
 	{ PCI_VDEVICE(INTEL, 0x4da9), (kernel_ulong_t)&spt_uart_info },

base-commit: f83ec76bf285bea5727f478a68b894f5543ca76e
-- 
2.39.5


