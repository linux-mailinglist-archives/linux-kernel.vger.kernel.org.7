Return-Path: <linux-kernel+bounces-597919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B79A84028
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 12:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86CCC4C1425
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 10:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2198C26FDBB;
	Thu, 10 Apr 2025 10:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b="x9Yd4Ghu"
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com [91.207.212.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C32426F47C;
	Thu, 10 Apr 2025 10:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744279575; cv=none; b=Meu9YhG1dEUMaN9oxlOtMPJc2JPEF+uZJcZxAjYw+GBOnQQRmEho7lEFMgSrR9m+a10HovwVWgntJ/+sku4etbK3h6h1b4h5EGl/n5qtkntq/7QDw/8fFwg0oJ8vawW0ILzOQQQ3b/laMUTeP/Cqe4CwyhKEk6AtCrr9Fc6J6/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744279575; c=relaxed/simple;
	bh=ItiVnWJD1bnhuLq8JisVSl4DcUuii5wGB8LVoh6N9yk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=umb3RH9EoGMfdex9PkkFIeGAu/lE0IEZGFZkuFCO6Zsi4ylCz+Rg751eb0b3p6u30/PNpJbkTDMZVxKfSkTxMFbHg7dap3D+0LAYV1dTEZE36XnBvAjAdmp+bHPXs1aLgH2Hbx2m4slGDeE8e9LVJx/9FkiwbE34EF1Vdciige0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com; spf=pass smtp.mailfrom=imgtec.com; dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b=x9Yd4Ghu; arc=none smtp.client-ip=91.207.212.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=imgtec.com
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
	by mx08-00376f01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53A62MME009620;
	Thu, 10 Apr 2025 10:55:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=dk201812; bh=O
	kW+rwQWS8KaZmfDvVvJf9o/iE03Y6Xg3NVxn7gNbh0=; b=x9Yd4GhuXV7+BZj6y
	wljaLeyxUs+G+H5O+NiLrq5WTsdwNwr20/JL9mL3kv7L/mEMr81B677HhuDTi9Es
	a/te8TcKI8qJu6yMhcyq+0jpMQDNdhrSeEGwRpoxJkhg4XiXjPtTnDPOfmUrIYJL
	DIt3va6s8EzJsx3hAhW/0sYdXOjtLZvsV0P7qR4R4/gBuu3MOQDXqWYa4mxcx9kg
	2zhe3hfvSrNr3OFI8NF4JBzA4mX7YYhjFwo7AXXlR/4rD5EfQBOPZk4DcQZu2iAR
	doC2E/cw1QeUXF9HYP/C++we1BQii3y8mwbY6vRhDHlt2Selt1d8oGyhj00yXDID
	iYDxg==
Received: from hhmail05.hh.imgtec.org (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
	by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 45ttssbgdy-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 10 Apr 2025 10:55:19 +0100 (BST)
Received: from
 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa
 (172.25.6.134) by HHMAIL05.hh.imgtec.org (10.100.10.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 10 Apr 2025 10:55:18 +0100
From: Matt Coster <matt.coster@imgtec.com>
Date: Thu, 10 Apr 2025 10:55:02 +0100
Subject: [PATCH v6 03/18] drm/imagination: Update register defs for newer
 GPUs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250410-sets-bxs-4-64-patch-v1-v6-3-eda620c5865f@imgtec.com>
References: <20250410-sets-bxs-4-64-patch-v1-v6-0-eda620c5865f@imgtec.com>
In-Reply-To: <20250410-sets-bxs-4-64-patch-v1-v6-0-eda620c5865f@imgtec.com>
To: Frank Binns <frank.binns@imgtec.com>,
        Matt Coster
	<matt.coster@imgtec.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter
	<simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        "Vignesh
 Raghavendra" <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>
CC: <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Randolph Sapp <rs@ti.com>, Darren Etheridge <detheridge@ti.com>,
        "Michal
 Wilczynski" <m.wilczynski@samsung.com>,
        Alessio Belle
	<alessio.belle@imgtec.com>,
        Alexandru Dadu <alexandru.dadu@imgtec.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=11126;
 i=matt.coster@imgtec.com; h=from:subject:message-id;
 bh=Ygi+v45NF6cStTwGRvF6WcioU5/hBhmYlVo0k17OPN4=;
 b=owGbwMvMwCFWuUfy8817WRsYT6slMaR/n9rIMO9ibLbBtj8rA5ad6fXfOVVC4diP8INnlzTI7
 lIVO7XGuaOUhUGMg0FWTJFlxwrLFWp/1LQkbvwqhpnDygQ2hItTACay2ozhn8rNhplGrlmborRV
 L9m8ZdtvYmIvKODmFZSolesn2dwax/BPY13dqoWNry5GmenkBRX0CHBc3XlRe84znXJ23edz7fa
 xAwA=
X-Developer-Key: i=matt.coster@imgtec.com; a=openpgp;
 fpr=05A40CFCE7269D61D97100A1747F0A9036F90DFA
X-EXCLAIMER-MD-CONFIG: 15a78312-3e47-46eb-9010-2e54d84a9631
X-Proofpoint-ORIG-GUID: jMfZn683PPaWgPKFHr_v4jfJB01C0Uew
X-Authority-Analysis: v=2.4 cv=I7hlRMgg c=1 sm=1 tr=0 ts=67f79587 cx=c_pps a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17 a=UtEzwyU9vMAA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=r_1tXGB3AAAA:8 a=cj9k-Jd43VawDxvwHVkA:9
 a=QEXdDO2ut3YA:10 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-GUID: jMfZn683PPaWgPKFHr_v4jfJB01C0Uew

From: Alessio Belle <alessio.belle@imgtec.com>

Update the register define header to a newer version that covers more
recent GPUs, including BXS-4-64.

Signed-off-by: Alessio Belle <alessio.belle@imgtec.com>
Signed-off-by: Matt Coster <matt.coster@imgtec.com>
Reviewed-by: Frank Binns <frank.binns@imgtec.com>
---
Changes in v6:
- Add Frank's Rb
- Link to v5: https://lore.kernel.org/r/20250326-sets-bxs-4-64-patch-v1-v5-3-e4c46e8280a9@imgtec.com
Changes in v5:
- None
- Link to v4: https://lore.kernel.org/r/20250320-sets-bxs-4-64-patch-v1-v4-3-d987cf4ca439@imgtec.com
Changes in v4:
- None
- Link to v3: https://lore.kernel.org/r/20250310-sets-bxs-4-64-patch-v1-v3-3-143b3dbef02f@imgtec.com
Changes in v3:
- Added
---
 drivers/gpu/drm/imagination/pvr_rogue_cr_defs.h | 153 +++++++++++++++++++++---
 1 file changed, 134 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_rogue_cr_defs.h b/drivers/gpu/drm/imagination/pvr_rogue_cr_defs.h
index 2a90d02796d3e071b18e18dead105e29798bcddc..790c97f80a2ac03ac76b933d009a2f9cfc6003f7 100644
--- a/drivers/gpu/drm/imagination/pvr_rogue_cr_defs.h
+++ b/drivers/gpu/drm/imagination/pvr_rogue_cr_defs.h
@@ -827,6 +827,120 @@
 #define ROGUE_CR_EVENT_STATUS_TLA_COMPLETE_CLRMSK 0xFFFFFFFEU
 #define ROGUE_CR_EVENT_STATUS_TLA_COMPLETE_EN 0x00000001U
 
+/* Register ROGUE_CR_EVENT_CLEAR */
+#define ROGUE_CR_EVENT_CLEAR 0x0138U
+#define ROGUE_CR_EVENT_CLEAR__ROGUEXE__MASKFULL 0x00000000E01DFFFFULL
+#define ROGUE_CR_EVENT_CLEAR__SIGNALS__MASKFULL 0x00000000E007FFFFULL
+#define ROGUE_CR_EVENT_CLEAR_MASKFULL 0x00000000FFFFFFFFULL
+#define ROGUE_CR_EVENT_CLEAR_TDM_FENCE_FINISHED_SHIFT 31U
+#define ROGUE_CR_EVENT_CLEAR_TDM_FENCE_FINISHED_CLRMSK 0x7FFFFFFFU
+#define ROGUE_CR_EVENT_CLEAR_TDM_FENCE_FINISHED_EN 0x80000000U
+#define ROGUE_CR_EVENT_CLEAR_TDM_BUFFER_STALL_SHIFT 30U
+#define ROGUE_CR_EVENT_CLEAR_TDM_BUFFER_STALL_CLRMSK 0xBFFFFFFFU
+#define ROGUE_CR_EVENT_CLEAR_TDM_BUFFER_STALL_EN 0x40000000U
+#define ROGUE_CR_EVENT_CLEAR_COMPUTE_SIGNAL_FAILURE_SHIFT 29U
+#define ROGUE_CR_EVENT_CLEAR_COMPUTE_SIGNAL_FAILURE_CLRMSK 0xDFFFFFFFU
+#define ROGUE_CR_EVENT_CLEAR_COMPUTE_SIGNAL_FAILURE_EN 0x20000000U
+#define ROGUE_CR_EVENT_CLEAR_DPX_OUT_OF_MEMORY_SHIFT 28U
+#define ROGUE_CR_EVENT_CLEAR_DPX_OUT_OF_MEMORY_CLRMSK 0xEFFFFFFFU
+#define ROGUE_CR_EVENT_CLEAR_DPX_OUT_OF_MEMORY_EN 0x10000000U
+#define ROGUE_CR_EVENT_CLEAR_DPX_MMU_PAGE_FAULT_SHIFT 27U
+#define ROGUE_CR_EVENT_CLEAR_DPX_MMU_PAGE_FAULT_CLRMSK 0xF7FFFFFFU
+#define ROGUE_CR_EVENT_CLEAR_DPX_MMU_PAGE_FAULT_EN 0x08000000U
+#define ROGUE_CR_EVENT_CLEAR_RPM_OUT_OF_MEMORY_SHIFT 26U
+#define ROGUE_CR_EVENT_CLEAR_RPM_OUT_OF_MEMORY_CLRMSK 0xFBFFFFFFU
+#define ROGUE_CR_EVENT_CLEAR_RPM_OUT_OF_MEMORY_EN 0x04000000U
+#define ROGUE_CR_EVENT_CLEAR_FBA_FC3_FINISHED_SHIFT 25U
+#define ROGUE_CR_EVENT_CLEAR_FBA_FC3_FINISHED_CLRMSK 0xFDFFFFFFU
+#define ROGUE_CR_EVENT_CLEAR_FBA_FC3_FINISHED_EN 0x02000000U
+#define ROGUE_CR_EVENT_CLEAR_FBA_FC2_FINISHED_SHIFT 24U
+#define ROGUE_CR_EVENT_CLEAR_FBA_FC2_FINISHED_CLRMSK 0xFEFFFFFFU
+#define ROGUE_CR_EVENT_CLEAR_FBA_FC2_FINISHED_EN 0x01000000U
+#define ROGUE_CR_EVENT_CLEAR_FBA_FC1_FINISHED_SHIFT 23U
+#define ROGUE_CR_EVENT_CLEAR_FBA_FC1_FINISHED_CLRMSK 0xFF7FFFFFU
+#define ROGUE_CR_EVENT_CLEAR_FBA_FC1_FINISHED_EN 0x00800000U
+#define ROGUE_CR_EVENT_CLEAR_FBA_FC0_FINISHED_SHIFT 22U
+#define ROGUE_CR_EVENT_CLEAR_FBA_FC0_FINISHED_CLRMSK 0xFFBFFFFFU
+#define ROGUE_CR_EVENT_CLEAR_FBA_FC0_FINISHED_EN 0x00400000U
+#define ROGUE_CR_EVENT_CLEAR_RDM_FC3_FINISHED_SHIFT 21U
+#define ROGUE_CR_EVENT_CLEAR_RDM_FC3_FINISHED_CLRMSK 0xFFDFFFFFU
+#define ROGUE_CR_EVENT_CLEAR_RDM_FC3_FINISHED_EN 0x00200000U
+#define ROGUE_CR_EVENT_CLEAR_RDM_FC2_FINISHED_SHIFT 20U
+#define ROGUE_CR_EVENT_CLEAR_RDM_FC2_FINISHED_CLRMSK 0xFFEFFFFFU
+#define ROGUE_CR_EVENT_CLEAR_RDM_FC2_FINISHED_EN 0x00100000U
+#define ROGUE_CR_EVENT_CLEAR_SAFETY_SHIFT 20U
+#define ROGUE_CR_EVENT_CLEAR_SAFETY_CLRMSK 0xFFEFFFFFU
+#define ROGUE_CR_EVENT_CLEAR_SAFETY_EN 0x00100000U
+#define ROGUE_CR_EVENT_CLEAR_RDM_FC1_FINISHED_SHIFT 19U
+#define ROGUE_CR_EVENT_CLEAR_RDM_FC1_FINISHED_CLRMSK 0xFFF7FFFFU
+#define ROGUE_CR_EVENT_CLEAR_RDM_FC1_FINISHED_EN 0x00080000U
+#define ROGUE_CR_EVENT_CLEAR_SLAVE_REQ_SHIFT 19U
+#define ROGUE_CR_EVENT_CLEAR_SLAVE_REQ_CLRMSK 0xFFF7FFFFU
+#define ROGUE_CR_EVENT_CLEAR_SLAVE_REQ_EN 0x00080000U
+#define ROGUE_CR_EVENT_CLEAR_RDM_FC0_FINISHED_SHIFT 18U
+#define ROGUE_CR_EVENT_CLEAR_RDM_FC0_FINISHED_CLRMSK 0xFFFBFFFFU
+#define ROGUE_CR_EVENT_CLEAR_RDM_FC0_FINISHED_EN 0x00040000U
+#define ROGUE_CR_EVENT_CLEAR_TDM_CONTEXT_STORE_FINISHED_SHIFT 18U
+#define ROGUE_CR_EVENT_CLEAR_TDM_CONTEXT_STORE_FINISHED_CLRMSK 0xFFFBFFFFU
+#define ROGUE_CR_EVENT_CLEAR_TDM_CONTEXT_STORE_FINISHED_EN 0x00040000U
+#define ROGUE_CR_EVENT_CLEAR_SHG_FINISHED_SHIFT 17U
+#define ROGUE_CR_EVENT_CLEAR_SHG_FINISHED_CLRMSK 0xFFFDFFFFU
+#define ROGUE_CR_EVENT_CLEAR_SHG_FINISHED_EN 0x00020000U
+#define ROGUE_CR_EVENT_CLEAR_SPFILTER_SIGNAL_UPDATE_SHIFT 17U
+#define ROGUE_CR_EVENT_CLEAR_SPFILTER_SIGNAL_UPDATE_CLRMSK 0xFFFDFFFFU
+#define ROGUE_CR_EVENT_CLEAR_SPFILTER_SIGNAL_UPDATE_EN 0x00020000U
+#define ROGUE_CR_EVENT_CLEAR_COMPUTE_BUFFER_STALL_SHIFT 16U
+#define ROGUE_CR_EVENT_CLEAR_COMPUTE_BUFFER_STALL_CLRMSK 0xFFFEFFFFU
+#define ROGUE_CR_EVENT_CLEAR_COMPUTE_BUFFER_STALL_EN 0x00010000U
+#define ROGUE_CR_EVENT_CLEAR_USC_TRIGGER_SHIFT 15U
+#define ROGUE_CR_EVENT_CLEAR_USC_TRIGGER_CLRMSK 0xFFFF7FFFU
+#define ROGUE_CR_EVENT_CLEAR_USC_TRIGGER_EN 0x00008000U
+#define ROGUE_CR_EVENT_CLEAR_ZLS_FINISHED_SHIFT 14U
+#define ROGUE_CR_EVENT_CLEAR_ZLS_FINISHED_CLRMSK 0xFFFFBFFFU
+#define ROGUE_CR_EVENT_CLEAR_ZLS_FINISHED_EN 0x00004000U
+#define ROGUE_CR_EVENT_CLEAR_GPIO_ACK_SHIFT 13U
+#define ROGUE_CR_EVENT_CLEAR_GPIO_ACK_CLRMSK 0xFFFFDFFFU
+#define ROGUE_CR_EVENT_CLEAR_GPIO_ACK_EN 0x00002000U
+#define ROGUE_CR_EVENT_CLEAR_GPIO_REQ_SHIFT 12U
+#define ROGUE_CR_EVENT_CLEAR_GPIO_REQ_CLRMSK 0xFFFFEFFFU
+#define ROGUE_CR_EVENT_CLEAR_GPIO_REQ_EN 0x00001000U
+#define ROGUE_CR_EVENT_CLEAR_POWER_ABORT_SHIFT 11U
+#define ROGUE_CR_EVENT_CLEAR_POWER_ABORT_CLRMSK 0xFFFFF7FFU
+#define ROGUE_CR_EVENT_CLEAR_POWER_ABORT_EN 0x00000800U
+#define ROGUE_CR_EVENT_CLEAR_POWER_COMPLETE_SHIFT 10U
+#define ROGUE_CR_EVENT_CLEAR_POWER_COMPLETE_CLRMSK 0xFFFFFBFFU
+#define ROGUE_CR_EVENT_CLEAR_POWER_COMPLETE_EN 0x00000400U
+#define ROGUE_CR_EVENT_CLEAR_MMU_PAGE_FAULT_SHIFT 9U
+#define ROGUE_CR_EVENT_CLEAR_MMU_PAGE_FAULT_CLRMSK 0xFFFFFDFFU
+#define ROGUE_CR_EVENT_CLEAR_MMU_PAGE_FAULT_EN 0x00000200U
+#define ROGUE_CR_EVENT_CLEAR_PM_3D_MEM_FREE_SHIFT 8U
+#define ROGUE_CR_EVENT_CLEAR_PM_3D_MEM_FREE_CLRMSK 0xFFFFFEFFU
+#define ROGUE_CR_EVENT_CLEAR_PM_3D_MEM_FREE_EN 0x00000100U
+#define ROGUE_CR_EVENT_CLEAR_PM_OUT_OF_MEMORY_SHIFT 7U
+#define ROGUE_CR_EVENT_CLEAR_PM_OUT_OF_MEMORY_CLRMSK 0xFFFFFF7FU
+#define ROGUE_CR_EVENT_CLEAR_PM_OUT_OF_MEMORY_EN 0x00000080U
+#define ROGUE_CR_EVENT_CLEAR_TA_TERMINATE_SHIFT 6U
+#define ROGUE_CR_EVENT_CLEAR_TA_TERMINATE_CLRMSK 0xFFFFFFBFU
+#define ROGUE_CR_EVENT_CLEAR_TA_TERMINATE_EN 0x00000040U
+#define ROGUE_CR_EVENT_CLEAR_TA_FINISHED_SHIFT 5U
+#define ROGUE_CR_EVENT_CLEAR_TA_FINISHED_CLRMSK 0xFFFFFFDFU
+#define ROGUE_CR_EVENT_CLEAR_TA_FINISHED_EN 0x00000020U
+#define ROGUE_CR_EVENT_CLEAR_ISP_END_MACROTILE_SHIFT 4U
+#define ROGUE_CR_EVENT_CLEAR_ISP_END_MACROTILE_CLRMSK 0xFFFFFFEFU
+#define ROGUE_CR_EVENT_CLEAR_ISP_END_MACROTILE_EN 0x00000010U
+#define ROGUE_CR_EVENT_CLEAR_PIXELBE_END_RENDER_SHIFT 3U
+#define ROGUE_CR_EVENT_CLEAR_PIXELBE_END_RENDER_CLRMSK 0xFFFFFFF7U
+#define ROGUE_CR_EVENT_CLEAR_PIXELBE_END_RENDER_EN 0x00000008U
+#define ROGUE_CR_EVENT_CLEAR_COMPUTE_FINISHED_SHIFT 2U
+#define ROGUE_CR_EVENT_CLEAR_COMPUTE_FINISHED_CLRMSK 0xFFFFFFFBU
+#define ROGUE_CR_EVENT_CLEAR_COMPUTE_FINISHED_EN 0x00000004U
+#define ROGUE_CR_EVENT_CLEAR_KERNEL_FINISHED_SHIFT 1U
+#define ROGUE_CR_EVENT_CLEAR_KERNEL_FINISHED_CLRMSK 0xFFFFFFFDU
+#define ROGUE_CR_EVENT_CLEAR_KERNEL_FINISHED_EN 0x00000002U
+#define ROGUE_CR_EVENT_CLEAR_TLA_COMPLETE_SHIFT 0U
+#define ROGUE_CR_EVENT_CLEAR_TLA_COMPLETE_CLRMSK 0xFFFFFFFEU
+#define ROGUE_CR_EVENT_CLEAR_TLA_COMPLETE_EN 0x00000001U
+
 /* Register ROGUE_CR_TIMER */
 #define ROGUE_CR_TIMER 0x0160U
 #define ROGUE_CR_TIMER_MASKFULL 0x8000FFFFFFFFFFFFULL
@@ -6031,25 +6145,6 @@
 #define ROGUE_CR_MULTICORE_COMPUTE_CTRL_COMMON_GPU_ENABLE_SHIFT 0U
 #define ROGUE_CR_MULTICORE_COMPUTE_CTRL_COMMON_GPU_ENABLE_CLRMSK 0xFFFFFF00U
 
-/* Register ROGUE_CR_ECC_RAM_ERR_INJ */
-#define ROGUE_CR_ECC_RAM_ERR_INJ 0xF340U
-#define ROGUE_CR_ECC_RAM_ERR_INJ_MASKFULL 0x000000000000001FULL
-#define ROGUE_CR_ECC_RAM_ERR_INJ_SLC_SIDEKICK_SHIFT 4U
-#define ROGUE_CR_ECC_RAM_ERR_INJ_SLC_SIDEKICK_CLRMSK 0xFFFFFFEFU
-#define ROGUE_CR_ECC_RAM_ERR_INJ_SLC_SIDEKICK_EN 0x00000010U
-#define ROGUE_CR_ECC_RAM_ERR_INJ_USC_SHIFT 3U
-#define ROGUE_CR_ECC_RAM_ERR_INJ_USC_CLRMSK 0xFFFFFFF7U
-#define ROGUE_CR_ECC_RAM_ERR_INJ_USC_EN 0x00000008U
-#define ROGUE_CR_ECC_RAM_ERR_INJ_TPU_MCU_L0_SHIFT 2U
-#define ROGUE_CR_ECC_RAM_ERR_INJ_TPU_MCU_L0_CLRMSK 0xFFFFFFFBU
-#define ROGUE_CR_ECC_RAM_ERR_INJ_TPU_MCU_L0_EN 0x00000004U
-#define ROGUE_CR_ECC_RAM_ERR_INJ_RASCAL_SHIFT 1U
-#define ROGUE_CR_ECC_RAM_ERR_INJ_RASCAL_CLRMSK 0xFFFFFFFDU
-#define ROGUE_CR_ECC_RAM_ERR_INJ_RASCAL_EN 0x00000002U
-#define ROGUE_CR_ECC_RAM_ERR_INJ_MARS_SHIFT 0U
-#define ROGUE_CR_ECC_RAM_ERR_INJ_MARS_CLRMSK 0xFFFFFFFEU
-#define ROGUE_CR_ECC_RAM_ERR_INJ_MARS_EN 0x00000001U
-
 /* Register ROGUE_CR_ECC_RAM_INIT_KICK */
 #define ROGUE_CR_ECC_RAM_INIT_KICK 0xF348U
 #define ROGUE_CR_ECC_RAM_INIT_KICK_MASKFULL 0x000000000000001FULL
@@ -6163,6 +6258,26 @@
 #define ROGUE_CR_SAFETY_EVENT_CLEAR__ROGUEXE__GPU_PAGE_FAULT_CLRMSK 0xFFFFFFFEU
 #define ROGUE_CR_SAFETY_EVENT_CLEAR__ROGUEXE__GPU_PAGE_FAULT_EN 0x00000001U
 
+/* Register ROGUE_CR_FAULT_FW_STATUS */
+#define ROGUE_CR_FAULT_FW_STATUS 0xF3B0U
+#define ROGUE_CR_FAULT_FW_STATUS_MASKFULL 0x0000000000010001ULL
+#define ROGUE_CR_FAULT_FW_STATUS_CPU_CORRECT_SHIFT 16U
+#define ROGUE_CR_FAULT_FW_STATUS_CPU_CORRECT_CLRMSK 0xFFFEFFFFU
+#define ROGUE_CR_FAULT_FW_STATUS_CPU_CORRECT_EN 0x00010000U
+#define ROGUE_CR_FAULT_FW_STATUS_CPU_DETECT_SHIFT 0U
+#define ROGUE_CR_FAULT_FW_STATUS_CPU_DETECT_CLRMSK 0xFFFFFFFEU
+#define ROGUE_CR_FAULT_FW_STATUS_CPU_DETECT_EN 0x00000001U
+
+/* Register ROGUE_CR_FAULT_FW_CLEAR */
+#define ROGUE_CR_FAULT_FW_CLEAR 0xF3B8U
+#define ROGUE_CR_FAULT_FW_CLEAR_MASKFULL 0x0000000000010001ULL
+#define ROGUE_CR_FAULT_FW_CLEAR_CPU_CORRECT_SHIFT 16U
+#define ROGUE_CR_FAULT_FW_CLEAR_CPU_CORRECT_CLRMSK 0xFFFEFFFFU
+#define ROGUE_CR_FAULT_FW_CLEAR_CPU_CORRECT_EN 0x00010000U
+#define ROGUE_CR_FAULT_FW_CLEAR_CPU_DETECT_SHIFT 0U
+#define ROGUE_CR_FAULT_FW_CLEAR_CPU_DETECT_CLRMSK 0xFFFFFFFEU
+#define ROGUE_CR_FAULT_FW_CLEAR_CPU_DETECT_EN 0x00000001U
+
 /* Register ROGUE_CR_MTS_SAFETY_EVENT_ENABLE */
 #define ROGUE_CR_MTS_SAFETY_EVENT_ENABLE__ROGUEXE 0xF3D8U
 #define ROGUE_CR_MTS_SAFETY_EVENT_ENABLE__ROGUEXE__MASKFULL 0x000000000000007FULL

-- 
2.49.0


