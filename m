Return-Path: <linux-kernel+bounces-868509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1B2C055D2
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 11:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2B4A54F7FDE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 09:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA2130AD11;
	Fri, 24 Oct 2025 09:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="n43lT2YI"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E489930BF6A
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 09:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761298425; cv=none; b=aSdOwOLq6SdbKGi9Tj6ffd+3jeurzAW3ySm2TqFO57kCrUw3KeaQvEOjAE+nFi77rvQfPTm8Fu5qomheLibBCwFhuUCyeliAo44JBwNXPXq6FcluVDHLjR7EgjKMzcyvcVgc5cZbq3a551V68ADQIu4IJxCvs03h88fSw7vHRso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761298425; c=relaxed/simple;
	bh=rWAjSbFtiyB04c6nt4HJX+xdhVrF7eu03nOf4isKpPM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KBaGBte6gUM8whYQMMlX6/WOqmVMYFFbgAVO/6OVrtDSXQ+V1rqJ+b4dHO7kZ+GCNWOtRASROcWFTnhuxb2+5yRvfSx7UBn8gEQ53DoCQuJhnq805QLq+6L3oSc9aFYgX3x2TuuWYGRVcacvfIHWDUM6tVhdGbkod0Nr6m04F/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n43lT2YI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59O3FRnK021007
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 09:33:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CMLd+stHl7HCnBT3FoRlbRpIJvQccMUYmaLcGjtU+ZM=; b=n43lT2YIUXEeuVcj
	6ZoRY1rbA+Zneb8qkarH801WB6RpebltStGlhWYGs+YM7WvqVAg8WRGikjF4DicI
	52RcckhoyDqOTkZqJp3B/O7wUw33v9RaJbmyM2Nhlyd3VBv9qriOK4B/bvBpCeiH
	ALl3ZLYoM3FBFrw1vb9IRaZknvOL4YOujrXgAQRSytYmEukUaTqW3tp4J15BdfpT
	4wx0difr+odTkkC3bPNwhYTjEXk68QgQM9Gq5p7BXaZMdSGzzVDEBI1PUEkOfJKn
	aVetgvRucEzkfxBYt69xSse5AlnctZ/+Qf51PxDrRQ+C857nG58ugm4CLV2alrHW
	WiwH+A==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49xhe0shhv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 09:33:41 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7a277277cb7so2801542b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 02:33:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761298420; x=1761903220;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CMLd+stHl7HCnBT3FoRlbRpIJvQccMUYmaLcGjtU+ZM=;
        b=l61n1Q/+b65nmLRji9BltBsv5Zyc4lcjDn8/Y0TNxEPRaf0G52leOrDOlndjAxRwj0
         JCu6tK5Kr65Syc8U0LGgH12NYmF8g1UNDellPJfgu5QFlg4EiOzw+VRFd7/WL9oHVAvm
         364xUj75fIvycyiYQOdScKDs5EwgDu+Ox2U7a40WO1fbNP3tgv0Ydn/Nirz8OXZuwWLk
         3+iLagJopALUnAONIPfKQOE5qSFBv3Hmp1L/Fuu2A/s6ew/lvrPtYcBOge9UB8RxvY7p
         w0mfQhNlj5t65sEZP0UQ0T/lHCOdkj6SwLUsmhHpYpOgeCDyYmWf/rPeN1vHHDm1khja
         FiYA==
X-Forwarded-Encrypted: i=1; AJvYcCVlgQEsSLFwNnYdPrHbdUJ0gHK4ks9wo6Ghx5Kuill+Wfkmfo4XJ8qzRkcBpvmP4pE9eSNDWk+9HM6PCDQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUNukoYECiQqP/H3alXKGHQiajmMWlf6t8IgXa8T/VPbN71Yjf
	T6BIPO6SdcrmkRfMNUJ85gG3RDfwfbj0ep+GUmUKchTZ+8aO+Zovk1EMfmFFrpkHPXhEoVIp8v9
	9/hGS/Jfan2eWi4XXmt2aja4zbpZj/Hv95a42veMmrizg+MrUFor72EM73844UptR8pY=
X-Gm-Gg: ASbGncsvm7r6PCNm+9rFA/jF2Ca24nYdGdQTLo3OOkUv9jLkJCcf/epK9IHoc0OHoul
	HzqsbHBJvREpqo3usqg47SBoK6JmzAw9Ezy8DnEProsQre6gDLYp2ItwybstJdVLVfnzAvFfq0a
	X1dFcg/iBz2+BT71vqwG8SuSkX9N9K5eWvpO431To0hbLpzTXrFqwxAVyl45GRYT6kQ3IOM0dB3
	EfgXShCDpIlxeh+jmFlx550rAyZGc6LO1xjclkVtw5Dc/z/8jyfhQO27mBYJ8gxNCSvpK/nBm/y
	dxYVXZ1OR1BF0/WEWwi8O3aLwOV4C5D6PSb5+o3jgEhg2OjDjINFm7ROSRdaF8OiDCyz5erXbNB
	5tBG9OS5oB52nNeksdSM6fJND4j0nRuKPpA==
X-Received: by 2002:a05:6a00:1394:b0:783:9b67:e96a with SMTP id d2e1a72fcca58-7a2865efc1cmr1894945b3a.0.1761298420006;
        Fri, 24 Oct 2025 02:33:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGl3S6wdGnnL5kcUzBrxlxSlnyZjEhdzflBFPC+ZiDZ07BeDunkPQ9EmriWxHV0ng9iSPLzkg==
X-Received: by 2002:a05:6a00:1394:b0:783:9b67:e96a with SMTP id d2e1a72fcca58-7a2865efc1cmr1894912b3a.0.1761298419377;
        Fri, 24 Oct 2025 02:33:39 -0700 (PDT)
Received: from hu-jprakash-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a274dc33easm5270332b3a.68.2025.10.24.02.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 02:33:38 -0700 (PDT)
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Date: Fri, 24 Oct 2025 15:03:23 +0530
Subject: [PATCH v3 3/3] spmi: spmi-pmic-arb: add support for PMIC arbiter
 v8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-pmic_arb_v8-v3-3-cad8d6a2cbc0@oss.qualcomm.com>
References: <20251024-pmic_arb_v8-v3-0-cad8d6a2cbc0@oss.qualcomm.com>
In-Reply-To: <20251024-pmic_arb_v8-v3-0-cad8d6a2cbc0@oss.qualcomm.com>
To: Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        David Collins <david.collins@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
        aiqun.yu@oss.qualcomm.com, kamal.wadhwa@oss.qualcomm.com,
        jingyi.wang@oss.qualcomm.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761298404; l=19123;
 i=jishnu.prakash@oss.qualcomm.com; s=20251014; h=from:subject:message-id;
 bh=EUTxHm7CeAn35CYzL1L/agjl2XgJqMH40T8awwhQhzI=;
 b=JxXNxG+FxwFbQyBaogmr1iMZ3NOoETM/lYqkgCSEO4vEuMys/ThzuGHvIynf4bhwVdwm4UBvk
 iukK0l16U3pDcxD9000RYnOrF3qnxhbuNG/tE5wyg1i1OkMGLh0BEL/
X-Developer-Key: i=jishnu.prakash@oss.qualcomm.com; a=ed25519;
 pk=g89pXdLVwRjdTeQ+uX1QzvBO346E3hQAc1N7fcTXgmk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIxMDE2NyBTYWx0ZWRfXxbVySJrFkCmr
 MHQ9KM9HVqh27xJLSwZOz55kJflMK7dbkMANs4tk4Dmo3dKyxYgd3weAGz7q8yJZswFIKp0YLDN
 xdfyDSZpRT+wv51Kfe7UXVN9PYFEDNHdwVqZLOaGXquR96s/GII8K17eA0CFTw5867O7y8C7vEw
 KlTBRYPQDPD50Tc+fY9AY1TdB1de16HpzAga/2ppt7UyRMX2isMLECncksyP6TJY6cQunLeHbMK
 HACxaGNljd5wvd3qg84VlXq7+3grCUNe7ISkQtl2uN7g4kk+faMhCAZoK8+BSkQwCLBahPEX1Vq
 45Ucps+0gpPNpI/gOg7cqv2uTg31N3VZzYxB54EEGAcIiZXpxrmhPv261eJBla2eOfWLKanAG6f
 8D2AECHytwlaeEKi/Jp1qQOO9hRToA==
X-Proofpoint-ORIG-GUID: 309blgi_MbItA2jrm6bOB5ev3J4FHAIZ
X-Authority-Analysis: v=2.4 cv=WYUBqkhX c=1 sm=1 tr=0 ts=68fb47f5 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=Ik5BXOhrgj9YKjSFxXcA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: 309blgi_MbItA2jrm6bOB5ev3J4FHAIZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-24_01,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510210167

From: David Collins <david.collins@oss.qualcomm.com>

PMIC arbiter v8 supports up to 4 SPMI buses and up to 8192 PMIC
peripherals.  Its register map differs from v7 as several fields
increased in size. Add support for PMIC arbiter version 8.

Signed-off-by: David Collins <david.collins@oss.qualcomm.com>
Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
---
 drivers/spmi/spmi-pmic-arb.c | 324 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 294 insertions(+), 30 deletions(-)

diff --git a/drivers/spmi/spmi-pmic-arb.c b/drivers/spmi/spmi-pmic-arb.c
index 91581974ef84..612736973e4b 100644
--- a/drivers/spmi/spmi-pmic-arb.c
+++ b/drivers/spmi/spmi-pmic-arb.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2012-2015, 2017, 2021, The Linux Foundation. All rights reserved.
  */
 #include <linux/bitmap.h>
+#include <linux/bitfield.h>
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
@@ -25,10 +26,12 @@
 #define PMIC_ARB_VERSION_V3_MIN		0x30000000
 #define PMIC_ARB_VERSION_V5_MIN		0x50000000
 #define PMIC_ARB_VERSION_V7_MIN		0x70000000
+#define PMIC_ARB_VERSION_V8_MIN		0x80000000
 #define PMIC_ARB_INT_EN			0x0004
 
 #define PMIC_ARB_FEATURES		0x0004
 #define PMIC_ARB_FEATURES_PERIPH_MASK	GENMASK(10, 0)
+#define PMIC_ARB_FEATURES_V8_PERIPH_MASK	GENMASK(12, 0)
 
 #define PMIC_ARB_FEATURES1		0x0008
 
@@ -50,9 +53,10 @@
 #define SPMI_MAPPING_BIT_IS_1_RESULT(X)	(((X) >> 0) & 0xFF)
 
 #define SPMI_MAPPING_TABLE_TREE_DEPTH	16	/* Maximum of 16-bits */
-#define PMIC_ARB_MAX_PPID		BIT(12) /* PPID is 12bit */
+#define PMIC_ARB_MAX_PPID		BIT(13)
 #define PMIC_ARB_APID_VALID		BIT(15)
 #define PMIC_ARB_CHAN_IS_IRQ_OWNER(reg)	((reg) & BIT(24))
+#define PMIC_ARB_V8_CHAN_IS_IRQ_OWNER(reg)	((reg) & BIT(31))
 #define INVALID_EE				0xFF
 
 /* Ownership Table */
@@ -96,30 +100,33 @@ enum pmic_arb_channel {
 	PMIC_ARB_CHANNEL_OBS,
 };
 
-#define PMIC_ARB_MAX_BUSES		2
+#define PMIC_ARB_MAX_BUSES		4
+#define PMIC_ARB_MAX_BUSES_V8		4
 
 /* Maximum number of support PMIC peripherals */
 #define PMIC_ARB_MAX_PERIPHS		512
 #define PMIC_ARB_MAX_PERIPHS_V7		1024
+#define PMIC_ARB_MAX_PERIPHS_V8		8192
 #define PMIC_ARB_TIMEOUT_US		1000
 #define PMIC_ARB_MAX_TRANS_BYTES	(8)
 
 #define PMIC_ARB_APID_MASK		0xFF
 #define PMIC_ARB_PPID_MASK		0xFFF
+#define PMIC_ARB_V8_PPID_MASK		0x1FFF
 
 /* interrupt enable bit */
 #define SPMI_PIC_ACC_ENABLE_BIT		BIT(0)
 
 #define spec_to_hwirq(slave_id, periph_id, irq_id, apid) \
-	((((slave_id) & 0xF)   << 28) | \
-	(((periph_id) & 0xFF)  << 20) | \
-	(((irq_id)    & 0x7)   << 16) | \
-	(((apid)      & 0x3FF) << 0))
+	(FIELD_PREP(GENMASK(28, 24), (slave_id))  | \
+	FIELD_PREP(GENMASK(23, 16), (periph_id)) | \
+	FIELD_PREP(GENMASK(15, 13), (irq_id))    | \
+	FIELD_PREP(GENMASK(12, 0),  (apid)))
 
-#define hwirq_to_sid(hwirq)  (((hwirq) >> 28) & 0xF)
-#define hwirq_to_per(hwirq)  (((hwirq) >> 20) & 0xFF)
-#define hwirq_to_irq(hwirq)  (((hwirq) >> 16) & 0x7)
-#define hwirq_to_apid(hwirq) (((hwirq) >> 0)  & 0x3FF)
+#define hwirq_to_sid(hwirq)  FIELD_GET(GENMASK(28, 24), (hwirq))
+#define hwirq_to_per(hwirq)  FIELD_GET(GENMASK(23, 16), (hwirq))
+#define hwirq_to_irq(hwirq)  FIELD_GET(GENMASK(15, 13), (hwirq))
+#define hwirq_to_apid(hwirq) FIELD_GET(GENMASK(12, 0), (hwirq))
 
 struct pmic_arb_ver_ops;
 
@@ -138,11 +145,12 @@ struct spmi_pmic_arb;
  * @domain:		irq domain object for PMIC IRQ domain
  * @intr:		address of the SPMI interrupt control registers.
  * @cnfg:		address of the PMIC Arbiter configuration registers.
+ * @apid_owner:		on v8: address of APID owner mapping table registers
  * @spmic:		spmi controller registered for this bus
  * @lock:		lock to synchronize accesses.
- * @base_apid:		on v7: minimum APID associated with the particular SPMI
- *			bus instance
- * @apid_count:		on v5 and v7: number of APIDs associated with the
+ * @base_apid:		on v7 and v8: minimum APID associated with the
+ *			particular SPMI bus instance
+ * @apid_count:		on v5, v7 and v8: number of APIDs associated with the
  *			particular SPMI bus instance
  * @mapping_table:	in-memory copy of PPID -> APID mapping table.
  * @mapping_table_valid:bitmap containing valid-only periphs
@@ -159,6 +167,7 @@ struct spmi_pmic_arb_bus {
 	struct irq_domain	*domain;
 	void __iomem		*intr;
 	void __iomem		*cnfg;
+	void __iomem		*apid_owner;
 	struct spmi_controller	*spmic;
 	raw_spinlock_t		lock;
 	u16			base_apid;
@@ -181,6 +190,7 @@ struct spmi_pmic_arb_bus {
  * @wr_base:		on v1 "core", on v2 "chnls"    register base off DT.
  * @core:		core register base for v2 and above only (see above)
  * @core_size:		core register base size
+ * @apid_map:		on v8, APID mapping table register base
  * @channel:		execution environment channel to use for accesses.
  * @ee:			the current Execution Environment
  * @ver_ops:		version dependent operations.
@@ -193,6 +203,7 @@ struct spmi_pmic_arb {
 	void __iomem		*wr_base;
 	void __iomem		*core;
 	resource_size_t		core_size;
+	void __iomem		*apid_map;
 	u8			channel;
 	u8			ee;
 	const struct pmic_arb_ver_ops *ver_ops;
@@ -206,6 +217,7 @@ struct spmi_pmic_arb {
  *
  * @ver_str:		version string.
  * @get_core_resources:	initializes the core, observer and channels
+ * @get_bus_resources:	requests per-SPMI bus register resources
  * @init_apid:		finds the apid base and count
  * @ppid_to_apid:	finds the apid for a given ppid.
  * @non_data_cmd:	on v1 issues an spmi non-data command.
@@ -227,6 +239,9 @@ struct spmi_pmic_arb {
 struct pmic_arb_ver_ops {
 	const char *ver_str;
 	int (*get_core_resources)(struct platform_device *pdev, void __iomem *core);
+	int (*get_bus_resources)(struct platform_device *pdev,
+				 struct device_node *node,
+				 struct spmi_pmic_arb_bus *bus);
 	int (*init_apid)(struct spmi_pmic_arb_bus *bus, int index);
 	int (*ppid_to_apid)(struct spmi_pmic_arb_bus *bus, u16 ppid);
 	/* spmi commands (read_cmd, write_cmd, cmd) functionality */
@@ -656,7 +671,7 @@ static int periph_interrupt(struct spmi_pmic_arb_bus *bus, u16 apid)
 	unsigned int irq;
 	u32 status, id;
 	int handled = 0;
-	u8 sid = (bus->apid_data[apid].ppid >> 8) & 0xF;
+	u8 sid = (bus->apid_data[apid].ppid >> 8) & 0x1F;
 	u8 per = bus->apid_data[apid].ppid & 0xFF;
 
 	status = readl_relaxed(pmic_arb->ver_ops->irq_status(bus, apid));
@@ -686,7 +701,7 @@ static void pmic_arb_chained_irq(struct irq_desc *desc)
 	int last = bus->max_apid;
 	/*
 	 * acc_offset will be non-zero for the secondary SPMI bus instance on
-	 * v7 controllers.
+	 * v7 and v8 controllers.
 	 */
 	int acc_offset = bus->base_apid >> 5;
 	u8 ee = pmic_arb->ee;
@@ -913,7 +928,7 @@ static int qpnpint_irq_domain_translate(struct irq_domain *d,
 		return -EINVAL;
 	if (fwspec->param_count != 4)
 		return -EINVAL;
-	if (intspec[0] > 0xF || intspec[1] > 0xFF || intspec[2] > 0x7)
+	if (intspec[0] > 0x1F || intspec[1] > 0xFF || intspec[2] > 0x7)
 		return -EINVAL;
 
 	ppid = intspec[0] << 8 | intspec[1];
@@ -1160,6 +1175,24 @@ static int pmic_arb_ppid_to_apid_v2(struct spmi_pmic_arb_bus *bus, u16 ppid)
 	return apid_valid & ~PMIC_ARB_APID_VALID;
 }
 
+static void pmic_arb_dump_apid_map(struct spmi_pmic_arb_bus *bus)
+{
+	struct apid_data *apidd;
+	u16 apid, ppid;
+
+	/* Dump the mapping table for debug purposes. */
+	dev_dbg(&bus->spmic->dev, "PPID APID Write-EE IRQ-EE\n");
+	for (ppid = 0; ppid < PMIC_ARB_MAX_PPID; ppid++) {
+		apid = bus->ppid_to_apid[ppid];
+		if (apid & PMIC_ARB_APID_VALID) {
+			apid &= ~PMIC_ARB_APID_VALID;
+			apidd = &bus->apid_data[apid];
+			dev_dbg(&bus->spmic->dev, "%#03X %3u %2u %2u\n",
+				ppid, apid, apidd->write_ee, apidd->irq_ee);
+		}
+	}
+}
+
 static int pmic_arb_read_apid_map_v5(struct spmi_pmic_arb_bus *bus)
 {
 	struct spmi_pmic_arb *pmic_arb = bus->pmic_arb;
@@ -1222,17 +1255,7 @@ static int pmic_arb_read_apid_map_v5(struct spmi_pmic_arb_bus *bus)
 		bus->last_apid = i;
 	}
 
-	/* Dump the mapping table for debug purposes. */
-	dev_dbg(&bus->spmic->dev, "PPID APID Write-EE IRQ-EE\n");
-	for (ppid = 0; ppid < PMIC_ARB_MAX_PPID; ppid++) {
-		apid = bus->ppid_to_apid[ppid];
-		if (apid & PMIC_ARB_APID_VALID) {
-			apid &= ~PMIC_ARB_APID_VALID;
-			apidd = &bus->apid_data[apid];
-			dev_dbg(&bus->spmic->dev, "%#03X %3u %2u %2u\n",
-				ppid, apid, apidd->write_ee, apidd->irq_ee);
-		}
-	}
+	pmic_arb_dump_apid_map(bus);
 
 	return 0;
 }
@@ -1346,7 +1369,7 @@ static int pmic_arb_get_core_resources_v7(struct platform_device *pdev,
 }
 
 /*
- * Only v7 supports 2 buses. Each bus will get a different apid count, read
+ * Arbiter v7 supports 2 buses. Each bus will get a different apid count, read
  * from different registers.
  */
 static int pmic_arb_init_apid_v7(struct spmi_pmic_arb_bus *bus, int index)
@@ -1424,6 +1447,185 @@ static int pmic_arb_offset_v7(struct spmi_pmic_arb_bus *bus, u8 sid, u16 addr,
 	return offset;
 }
 
+static int pmic_arb_get_core_resources_v8(struct platform_device *pdev,
+					  void __iomem *core)
+{
+	struct spmi_pmic_arb *pmic_arb = platform_get_drvdata(pdev);
+
+	pmic_arb->apid_map = devm_platform_ioremap_resource_byname(pdev,
+								   "chnl_map");
+	if (IS_ERR(pmic_arb->apid_map))
+		return PTR_ERR(pmic_arb->apid_map);
+
+	pmic_arb->core = core;
+
+	pmic_arb->max_periphs = PMIC_ARB_MAX_PERIPHS_V8;
+
+	return pmic_arb_get_obsrvr_chnls_v2(pdev);
+}
+
+static int pmic_arb_get_bus_resources_v8(struct platform_device *pdev,
+					 struct device_node *node,
+					 struct spmi_pmic_arb_bus *bus)
+{
+	int index;
+
+	index = of_property_match_string(node, "reg-names", "chnl_owner");
+	if (index < 0) {
+		dev_err(&pdev->dev, "chnl_owner reg region missing\n");
+		return -EINVAL;
+	}
+
+	bus->apid_owner = devm_of_iomap(&pdev->dev, node, index, NULL);
+
+	return PTR_ERR_OR_ZERO(bus->apid_owner);
+}
+
+static int pmic_arb_read_apid_map_v8(struct spmi_pmic_arb_bus *bus)
+{
+	struct spmi_pmic_arb *pmic_arb = bus->pmic_arb;
+	struct apid_data *apidd;
+	struct apid_data *prev_apidd;
+	u16 i, apid, ppid, apid_max;
+	bool valid, is_irq_ee;
+	u32 regval, offset;
+
+	/*
+	 * In order to allow multiple EEs to write to a single PPID in arbiter
+	 * version 8, there can be more than one APID mapped to each PPID.  The
+	 * owner field for each of these mappings specifies the EE which is
+	 * allowed to write to the APID.  The owner of the last (highest) APID
+	 * which has the IRQ owner bit set for a given PPID will receive
+	 * interrupts from the PPID.
+	 *
+	 * In arbiter version 8, the APID numbering space is divided between
+	 * the SPMI buses according to this mapping:
+	 * APID = 0     to N-1       --> bus 0
+	 * APID = N     to N+M-1     --> bus 1
+	 * APID = N+M   to N+M+P-1   --> bus 2
+	 * APID = N+M+P to N+M+P+Q-1 --> bus 3
+	 * where N = number of APIDs supported by bus 0
+	 *       M = number of APIDs supported by bus 1
+	 *       P = number of APIDs supported by bus 2
+	 *       Q = number of APIDs supported by bus 3
+	 */
+	apidd = &bus->apid_data[bus->base_apid];
+	apid_max = bus->base_apid + bus->apid_count;
+	for (i = bus->base_apid; i < apid_max; i++, apidd++) {
+		offset = pmic_arb->ver_ops->apid_map_offset(i);
+		regval = readl_relaxed(pmic_arb->apid_map + offset);
+		if (!regval)
+			continue;
+		ppid = regval & PMIC_ARB_V8_PPID_MASK;
+		is_irq_ee = PMIC_ARB_V8_CHAN_IS_IRQ_OWNER(regval);
+
+		regval = readl_relaxed(pmic_arb->ver_ops->apid_owner(bus, i));
+		apidd->write_ee = SPMI_OWNERSHIP_PERIPH2OWNER(regval);
+
+		apidd->irq_ee = is_irq_ee ? apidd->write_ee : INVALID_EE;
+
+		valid = bus->ppid_to_apid[ppid] & PMIC_ARB_APID_VALID;
+		apid = bus->ppid_to_apid[ppid] & ~PMIC_ARB_APID_VALID;
+		prev_apidd = &bus->apid_data[apid];
+
+		if (!valid || apidd->write_ee == pmic_arb->ee) {
+			/* First PPID mapping or one for this EE */
+			bus->ppid_to_apid[ppid] = i | PMIC_ARB_APID_VALID;
+		} else if (valid && is_irq_ee &&
+			   prev_apidd->write_ee == pmic_arb->ee) {
+			/*
+			 * Duplicate PPID mapping after the one for this EE;
+			 * override the irq owner
+			 */
+			prev_apidd->irq_ee = apidd->irq_ee;
+		}
+
+		apidd->ppid = ppid;
+		bus->last_apid = i;
+	}
+
+	pmic_arb_dump_apid_map(bus);
+
+	return 0;
+}
+
+static int pmic_arb_init_apid_v8(struct spmi_pmic_arb_bus *bus, int index)
+{
+	struct spmi_pmic_arb *pmic_arb = bus->pmic_arb;
+	int ret, i;
+
+	if (index < 0 || index >= PMIC_ARB_MAX_BUSES_V8) {
+		dev_err(&bus->spmic->dev, "Unsupported bus index %d detected\n",
+			index);
+		return -EINVAL;
+	}
+
+	bus->base_apid = 0;
+	bus->apid_count = 0;
+	for (i = 0; i <= index; i++) {
+		bus->base_apid += bus->apid_count;
+		bus->apid_count = readl_relaxed(pmic_arb->core + PMIC_ARB_FEATURES + i * 4) &
+						PMIC_ARB_FEATURES_V8_PERIPH_MASK;
+	}
+
+	if (bus->apid_count == 0) {
+		dev_err(&bus->spmic->dev, "Bus %d not implemented\n", index);
+		return -EINVAL;
+	} else if (bus->base_apid + bus->apid_count > pmic_arb->max_periphs) {
+		dev_err(&bus->spmic->dev, "Unsupported max APID %d detected\n",
+			bus->base_apid + bus->apid_count);
+		return -EINVAL;
+	}
+
+	ret = pmic_arb_init_apid_min_max(bus);
+	if (ret)
+		return ret;
+
+	ret = pmic_arb_read_apid_map_v8(bus);
+	if (ret) {
+		dev_err(&bus->spmic->dev, "could not read APID->PPID mapping table, rc= %d\n",
+			ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+/*
+ * v8 offset per ee and per apid for observer channels and per apid for
+ * read/write channels.
+ */
+static int pmic_arb_offset_v8(struct spmi_pmic_arb_bus *bus, u8 sid, u16 addr,
+			      enum pmic_arb_channel ch_type)
+{
+	struct spmi_pmic_arb *pmic_arb = bus->pmic_arb;
+	u16 apid;
+	int rc;
+	u32 offset = 0;
+	u16 ppid = (sid << 8) | (addr >> 8);
+
+	rc = pmic_arb->ver_ops->ppid_to_apid(bus, ppid);
+	if (rc < 0)
+		return rc;
+
+	apid = rc;
+	switch (ch_type) {
+	case PMIC_ARB_CHANNEL_OBS:
+		offset = 0x40000 * pmic_arb->ee + 0x20 * apid;
+		break;
+	case PMIC_ARB_CHANNEL_RW:
+		if (bus->apid_data[apid].write_ee != pmic_arb->ee) {
+			dev_err(&bus->spmic->dev, "disallowed SPMI write to sid=%u, addr=0x%04X\n",
+				sid, addr);
+			return -EPERM;
+		}
+		offset = 0x200 * apid;
+		break;
+	}
+
+	return offset;
+}
+
 static u32 pmic_arb_fmt_cmd_v1(u8 opc, u8 sid, u16 addr, u8 bc)
 {
 	return (opc << 27) | ((sid & 0xf) << 20) | (addr << 4) | (bc & 0x7);
@@ -1490,6 +1692,14 @@ pmic_arb_acc_enable_v7(struct spmi_pmic_arb_bus *bus, u16 n)
 	return pmic_arb->wr_base + 0x100 + 0x1000 * n;
 }
 
+static void __iomem *
+pmic_arb_acc_enable_v8(struct spmi_pmic_arb_bus *bus, u16 n)
+{
+	struct spmi_pmic_arb *pmic_arb = bus->pmic_arb;
+
+	return pmic_arb->wr_base + 0x100 + 0x200 * n;
+}
+
 static void __iomem *
 pmic_arb_irq_status_v1(struct spmi_pmic_arb_bus *bus, u16 n)
 {
@@ -1516,6 +1726,14 @@ pmic_arb_irq_status_v7(struct spmi_pmic_arb_bus *bus, u16 n)
 	return pmic_arb->wr_base + 0x104 + 0x1000 * n;
 }
 
+static void __iomem *
+pmic_arb_irq_status_v8(struct spmi_pmic_arb_bus *bus, u16 n)
+{
+	struct spmi_pmic_arb *pmic_arb = bus->pmic_arb;
+
+	return pmic_arb->wr_base + 0x104 + 0x200 * n;
+}
+
 static void __iomem *
 pmic_arb_irq_clear_v1(struct spmi_pmic_arb_bus *bus, u16 n)
 {
@@ -1542,6 +1760,14 @@ pmic_arb_irq_clear_v7(struct spmi_pmic_arb_bus *bus, u16 n)
 	return pmic_arb->wr_base + 0x108 + 0x1000 * n;
 }
 
+static void __iomem *
+pmic_arb_irq_clear_v8(struct spmi_pmic_arb_bus *bus, u16 n)
+{
+	struct spmi_pmic_arb *pmic_arb = bus->pmic_arb;
+
+	return pmic_arb->wr_base + 0x108 + 0x200 * n;
+}
+
 static u32 pmic_arb_apid_map_offset_v2(u16 n)
 {
 	return 0x800 + 0x4 * n;
@@ -1557,6 +1783,12 @@ static u32 pmic_arb_apid_map_offset_v7(u16 n)
 	return 0x2000 + 0x4 * n;
 }
 
+static u32 pmic_arb_apid_map_offset_v8(u16 n)
+{
+	/* For v8, offset is from "chnl_map" base register, not "core". */
+	return 0x4 * n;
+}
+
 static void __iomem *
 pmic_arb_apid_owner_v2(struct spmi_pmic_arb_bus *bus, u16 n)
 {
@@ -1564,7 +1796,7 @@ pmic_arb_apid_owner_v2(struct spmi_pmic_arb_bus *bus, u16 n)
 }
 
 /*
- * For arbiter version 7, APID ownership table registers have independent
+ * For arbiter version 7 and 8, APID ownership table registers have independent
  * numbering space for each SPMI bus instance, so each is indexed starting from
  * 0.
  */
@@ -1574,6 +1806,12 @@ pmic_arb_apid_owner_v7(struct spmi_pmic_arb_bus *bus, u16 n)
 	return bus->cnfg + 0x4 * (n - bus->base_apid);
 }
 
+static void __iomem *
+pmic_arb_apid_owner_v8(struct spmi_pmic_arb_bus *bus, u16 n)
+{
+	return bus->apid_owner + 0x4 * (n - bus->base_apid);
+}
+
 static const struct pmic_arb_ver_ops pmic_arb_v1 = {
 	.ver_str		= "v1",
 	.get_core_resources	= pmic_arb_get_core_resources_v1,
@@ -1654,6 +1892,23 @@ static const struct pmic_arb_ver_ops pmic_arb_v7 = {
 	.apid_owner		= pmic_arb_apid_owner_v7,
 };
 
+static const struct pmic_arb_ver_ops pmic_arb_v8 = {
+	.ver_str		= "v8",
+	.get_core_resources	= pmic_arb_get_core_resources_v8,
+	.get_bus_resources	= pmic_arb_get_bus_resources_v8,
+	.init_apid		= pmic_arb_init_apid_v8,
+	.ppid_to_apid		= pmic_arb_ppid_to_apid_v5,
+	.non_data_cmd		= pmic_arb_non_data_cmd_v2,
+	.offset			= pmic_arb_offset_v8,
+	.fmt_cmd		= pmic_arb_fmt_cmd_v2,
+	.owner_acc_status	= pmic_arb_owner_acc_status_v7,
+	.acc_enable		= pmic_arb_acc_enable_v8,
+	.irq_status		= pmic_arb_irq_status_v8,
+	.irq_clear		= pmic_arb_irq_clear_v8,
+	.apid_map_offset	= pmic_arb_apid_map_offset_v8,
+	.apid_owner		= pmic_arb_apid_owner_v8,
+};
+
 static const struct irq_domain_ops pmic_arb_irq_domain_ops = {
 	.activate = qpnpint_irq_domain_activate,
 	.alloc = qpnpint_irq_domain_alloc,
@@ -1731,6 +1986,12 @@ static int spmi_pmic_arb_bus_init(struct platform_device *pdev,
 	bus->spmic = ctrl;
 	bus->id = bus_index;
 
+	if (pmic_arb->ver_ops->get_bus_resources) {
+		ret = pmic_arb->ver_ops->get_bus_resources(pdev, node, bus);
+		if (ret)
+			return ret;
+	}
+
 	ret = pmic_arb->ver_ops->init_apid(bus, bus_index);
 	if (ret)
 		return ret;
@@ -1825,8 +2086,10 @@ static int spmi_pmic_arb_probe(struct platform_device *pdev)
 		pmic_arb->ver_ops = &pmic_arb_v3;
 	else if (hw_ver < PMIC_ARB_VERSION_V7_MIN)
 		pmic_arb->ver_ops = &pmic_arb_v5;
-	else
+	else if (hw_ver < PMIC_ARB_VERSION_V8_MIN)
 		pmic_arb->ver_ops = &pmic_arb_v7;
+	else
+		pmic_arb->ver_ops = &pmic_arb_v8;
 
 	err = pmic_arb->ver_ops->get_core_resources(pdev, core);
 	if (err)
@@ -1875,6 +2138,7 @@ static void spmi_pmic_arb_remove(struct platform_device *pdev)
 static const struct of_device_id spmi_pmic_arb_match_table[] = {
 	{ .compatible = "qcom,spmi-pmic-arb", },
 	{ .compatible = "qcom,x1e80100-spmi-pmic-arb", },
+	{ .compatible = "qcom,glymur-spmi-pmic-arb", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, spmi_pmic_arb_match_table);

-- 
2.25.1


