Return-Path: <linux-kernel+bounces-597874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4BC5A83FA2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 11:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 508AF4A2E2C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 09:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897AC26B95B;
	Thu, 10 Apr 2025 09:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b="QU/XYhg1"
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com [185.132.180.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916E626A0D4;
	Thu, 10 Apr 2025 09:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.180.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744278967; cv=none; b=pMFr98ZLsSn3iCE8ji6fizrZcNJexbIc5a42zizrMSA0fUKT8i0nE/jvj7UnBiCEyj6evvjIzpm5irJYbcdreYUjSrgInQFqv8mQxDZ6ydU4d2+vGpAgHAuAk7X2rfWTAJPN9fU0erOCcGdFFTLct61bkVdW3ao53z7VCFfRvzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744278967; c=relaxed/simple;
	bh=Elvr0cwUtgQSXkE4fWkgzVrD+iNrOuoCb/V9+9bbdFQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=WX2e5jie93H/a3Skfk3mQ1cVpjcYDxTqUNyweJGrRganguieM/VSdxm9BCDyBS0SnUaOARJXZHe/rbX3xEl9rcKvHA5prcN6CR4Qc4X6fg402iQCjSdk1spd8AKE0FV5CgBR9wDTNGJeGSd8BpLwBbY1PiR/yr3ceBaGsGisjNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com; spf=pass smtp.mailfrom=imgtec.com; dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b=QU/XYhg1; arc=none smtp.client-ip=185.132.180.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=imgtec.com
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
	by mx07-00376f01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53A60F8S032471;
	Thu, 10 Apr 2025 10:55:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=dk201812; bh=9
	06RLKvUODeSurQWLv7yCIosXrq3a0l0V3MKYmfdWH0=; b=QU/XYhg1Qk4d2liyo
	TKPmkGeNiR3NhRjL4HCWXM1CmIZGjcgR5GynJwx/c4VXpKfiYguk2vWElmwt/zYV
	vBGQf4cqqg/Dc9z8J51Cmpv+W52s1EJi1h08zy8M0BsnDIlUbiCpxNDmE63axKf4
	Cy2GEq/mj3b42vVD13DCMUm5LXop2z1wxKZgwgJqTTM1gUZyFnet+LCxTuhXaGmF
	3NYeYyqkLYF/SuKnKC+L7UrHG6JkNQiL4ywlIeiqNfjaikM9uaNmw5gNuXLv3y4s
	WO30upjXJszO84BGVAXtt5d+8bWSFm9VuzUdkBbV3Wrr25IjPzvCSusxFFfNF9Ne
	+6k9Q==
Received: from hhmail05.hh.imgtec.org (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
	by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 45w86h1d34-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 10 Apr 2025 10:55:24 +0100 (BST)
Received: from
 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa
 (172.25.6.134) by HHMAIL05.hh.imgtec.org (10.100.10.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 10 Apr 2025 10:55:23 +0100
From: Matt Coster <matt.coster@imgtec.com>
Date: Thu, 10 Apr 2025 10:55:08 +0100
Subject: [PATCH v6 09/18] drm/imagination: Rename event_mask -> status_mask
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250410-sets-bxs-4-64-patch-v1-v6-9-eda620c5865f@imgtec.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3556;
 i=matt.coster@imgtec.com; h=from:subject:message-id;
 bh=Elvr0cwUtgQSXkE4fWkgzVrD+iNrOuoCb/V9+9bbdFQ=;
 b=owGbwMvMwCFWuUfy8817WRsYT6slMaR/n9okJLon/YdTX8ZkMwveGfxyc4PPXT95bWLeq22bu
 0wtXJWCOkpZGMQ4GGTFFFl2rLBcofZHTUvixq9imDmsTCBDGLg4BWAiDDsZ/op4tmknRMX8vfVz
 4qzysmmLz5rUlG9fKLBByHF33IVDc64x/E+ISTDY9O5KvOuTy8dXmPSu7l0eajchqLRJIWR64fw
 lm9gA
X-Developer-Key: i=matt.coster@imgtec.com; a=openpgp;
 fpr=05A40CFCE7269D61D97100A1747F0A9036F90DFA
X-EXCLAIMER-MD-CONFIG: 15a78312-3e47-46eb-9010-2e54d84a9631
X-Authority-Analysis: v=2.4 cv=MLNgmNZl c=1 sm=1 tr=0 ts=67f7958c cx=c_pps a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17 a=UtEzwyU9vMAA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=r_1tXGB3AAAA:8 a=eQCmySvtvC0styh21agA:9
 a=QEXdDO2ut3YA:10 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-GUID: PjGsNZMSlasg16onleDm2WmMzKl_40xF
X-Proofpoint-ORIG-GUID: PjGsNZMSlasg16onleDm2WmMzKl_40xF

Now that enable_reg isn't used, rename the previously shared event_mask to
status_mask since it's only used with status_reg.

Signed-off-by: Matt Coster <matt.coster@imgtec.com>
Reviewed-by: Frank Binns <frank.binns@imgtec.com>
---
Changes in v6:
- Add Frank's Rb
- Link to v5: https://lore.kernel.org/r/20250326-sets-bxs-4-64-patch-v1-v5-9-e4c46e8280a9@imgtec.com
Changes in v5:
- None
- Link to v4: https://lore.kernel.org/r/20250320-sets-bxs-4-64-patch-v1-v4-9-d987cf4ca439@imgtec.com
Changes in v4:
- None
- Link to v3: https://lore.kernel.org/r/20250310-sets-bxs-4-64-patch-v1-v3-9-143b3dbef02f@imgtec.com
Changes in v3:
- None
- Link to v2: https://lore.kernel.org/r/20241118-sets-bxs-4-64-patch-v1-v2-11-3fd45d9fb0cf@imgtec.com
Changes in v2:
- None
- Link to v1: https://lore.kernel.org/r/20241105-sets-bxs-4-64-patch-v1-v1-11-4ed30e865892@imgtec.com
---
 drivers/gpu/drm/imagination/pvr_fw.h      | 6 +++---
 drivers/gpu/drm/imagination/pvr_fw_meta.c | 2 +-
 drivers/gpu/drm/imagination/pvr_fw_mips.c | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_fw.h b/drivers/gpu/drm/imagination/pvr_fw.h
index 29bae4bc244a243a6a95bcf838d924060cc043e2..eead744835726712622d5aba9b3480fe264a089f 100644
--- a/drivers/gpu/drm/imagination/pvr_fw.h
+++ b/drivers/gpu/drm/imagination/pvr_fw.h
@@ -199,8 +199,8 @@ struct pvr_fw_defs {
 		 */
 		u32 clear_reg;
 
-		/** @event_mask: Bitmask of events to listen for in the status_reg. */
-		u32 event_mask;
+		/** @status_mask: Bitmask of events to listen for in the status_reg. */
+		u32 status_mask;
 
 		/** @clear_mask: Value to write to the clear_reg in order to clear FW IRQs. */
 		u32 clear_mask;
@@ -404,7 +404,7 @@ struct pvr_fw_device {
 	pvr_cr_write32((pvr_dev), (pvr_dev)->fw_dev.defs->irq.name ## _reg, value)
 
 #define pvr_fw_irq_pending(pvr_dev) \
-	(pvr_fw_irq_read_reg(pvr_dev, status) & (pvr_dev)->fw_dev.defs->irq.event_mask)
+	(pvr_fw_irq_read_reg(pvr_dev, status) & (pvr_dev)->fw_dev.defs->irq.status_mask)
 
 #define pvr_fw_irq_clear(pvr_dev) \
 	pvr_fw_irq_write_reg(pvr_dev, clear, (pvr_dev)->fw_dev.defs->irq.clear_mask)
diff --git a/drivers/gpu/drm/imagination/pvr_fw_meta.c b/drivers/gpu/drm/imagination/pvr_fw_meta.c
index 77596a2a6c4e9c9e2b3af6b9b2aea3ad49062550..892823826bf235362d6ae12b34541cea1e10e1d0 100644
--- a/drivers/gpu/drm/imagination/pvr_fw_meta.c
+++ b/drivers/gpu/drm/imagination/pvr_fw_meta.c
@@ -549,7 +549,7 @@ const struct pvr_fw_defs pvr_fw_defs_meta = {
 	.irq = {
 		.status_reg = ROGUE_CR_META_SP_MSLVIRQSTATUS,
 		.clear_reg = ROGUE_CR_META_SP_MSLVIRQSTATUS,
-		.event_mask = ROGUE_CR_META_SP_MSLVIRQSTATUS_TRIGVECT2_EN,
+		.status_mask = ROGUE_CR_META_SP_MSLVIRQSTATUS_TRIGVECT2_EN,
 		.clear_mask = ROGUE_CR_META_SP_MSLVIRQSTATUS_TRIGVECT2_CLRMSK,
 	},
 };
diff --git a/drivers/gpu/drm/imagination/pvr_fw_mips.c b/drivers/gpu/drm/imagination/pvr_fw_mips.c
index c73902bcf8e46ee58174a503cc7f235f2d45d180..567251a663de1dd179159c27288308364619e8dc 100644
--- a/drivers/gpu/drm/imagination/pvr_fw_mips.c
+++ b/drivers/gpu/drm/imagination/pvr_fw_mips.c
@@ -243,7 +243,7 @@ const struct pvr_fw_defs pvr_fw_defs_mips = {
 	.irq = {
 		.status_reg = ROGUE_CR_MIPS_WRAPPER_IRQ_STATUS,
 		.clear_reg = ROGUE_CR_MIPS_WRAPPER_IRQ_CLEAR,
-		.event_mask = ROGUE_CR_MIPS_WRAPPER_IRQ_STATUS_EVENT_EN,
+		.status_mask = ROGUE_CR_MIPS_WRAPPER_IRQ_STATUS_EVENT_EN,
 		.clear_mask = ROGUE_CR_MIPS_WRAPPER_IRQ_CLEAR_EVENT_EN,
 	},
 };

-- 
2.49.0


