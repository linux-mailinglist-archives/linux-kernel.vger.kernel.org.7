Return-Path: <linux-kernel+bounces-878616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D1BC211A1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7F2734E60D8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE3718859B;
	Thu, 30 Oct 2025 16:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bvXpcrQK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Il+fTCUn"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507823655D7
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 16:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761840622; cv=none; b=QkIECWreI/dDkxlnymkzH3CkQ5qyctukgV88hvmj1By9tHaA1zTzZA4jnHsd9smqi6snHYfGRXcDelDX7pPbF70NEfQI+uTdtrKfXpcyaFtDTE/CjcDs+YJ81y3voSLSxfajMyJAUGetlPA5S08YNAom3BJO9c6/JnGLjnFUhak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761840622; c=relaxed/simple;
	bh=yEQXkQ1FTuzpO1TclKjPyzVMskrZzQAZP7bbnxUWuFQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gsEfmRAspdwLaPNTeII18s+D1nGuh5JQycecrGgiEsLt6aEWARW0NGvOVmEff94/b0R88YwRayKHsF1eVwehTUQI0y/w7A+NLkndVY1ZKBXpcEloblSTQB4SUXRVcUk0vm/lTEszPY/i+x1kmxKwPNYe1Xm2FQYVO0kdoJh655Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bvXpcrQK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Il+fTCUn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59U9MXwd3115524
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 16:10:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=bLOZCFf9qB6YqjsuRFs4oJ8+at6AFvkEZyz
	MchVJa5w=; b=bvXpcrQK/Pr1hLDY5AoHKCW6FszXXuTwgfRFDDidLCdamFOdbRx
	DeXdB0MxT436bTtJ8Uus63Tl3FA9V8iaP+z5d3A0OJYDOFS2AubNqn5+M5Jf79TN
	x60yg6HPR+LmvQmVmpiCze47z0mgR5JTbyQDGj7UmeNNYjilxPZbsZyR/Hdf7ab9
	rj+XGJYwxu/yIY97KOYqbc7PY9Y+P3Pohgc5jBDF++VTJeAa9kFs/KGLGUHMec8V
	SwNy+WJOxLYG3HRai8Ve/TYcYSJDmNRqFk/VA+nNLS2EqAA4t+jqwEDyhvH0h82q
	dM7QTYRli3vYNB3XN86bdRRQi/ULRN0Eprg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a45b415yv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 16:10:19 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2950509239eso8988805ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 09:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761840618; x=1762445418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bLOZCFf9qB6YqjsuRFs4oJ8+at6AFvkEZyzMchVJa5w=;
        b=Il+fTCUnYfW83/f45EoyXItimVp9q08zUDbzSTgkTs2xZIxyDiU+2gw5l5/94at7tB
         oTDDA2G5K53gnYkl97rKM7e8Jo1iFMxVM5rtEUlSp88I5spWUGpyV4Q4VHnkSEcLkk2b
         hGZ85dkeWlnUdzCeAXrGpyu5H4wtTvrcCLng6WFWUYh93WcoQczwwcUBCZ4bs9DRamkE
         0l2hmuL1HLvQiYTmiVwsdHuvQqfZvm6Dl4G3nuI5gkJ9nReO7KeMdUzZY0ma/U9E0rlD
         Y6RjPfxEOGVyux10LJ1cBhvbRoEsfYB9av7NOxj/h588rG/isSisPjAjhNRIqMahcJXG
         Wg+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761840618; x=1762445418;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bLOZCFf9qB6YqjsuRFs4oJ8+at6AFvkEZyzMchVJa5w=;
        b=b06AJkT01RUoZwfMtUY3ijx4I4vGsVFaFl+EpW5RPQ3F+MFC2ZFQlwYlRld/uCBcDe
         MozjeZl2i7TibSMkXnhdybLW2+bkQQnMjzG6n8GRPEnIHqu+3NqhjS8zpktJ7tksoPQH
         tBjeahWpZ6Es0zQERxYCSpfY036EeZn9O2Wr1jn5L41UxgvuXEHzqtPwFeKchPxY8Jwz
         2BJ2Qfllp0bVdzCxHjvgiW3NCe9Osp/lRit2xyRVJs+o8MHfXn001oJi4uF5f+b3Xazo
         S3NPgrxAVP+KtDbtO4bITknqixMfThf2Ro14zGov1laoyLaGYv7pW+31dPfz/J6qMCxB
         N9dA==
X-Forwarded-Encrypted: i=1; AJvYcCVwuVYjc9tSsLjQ9UYEWRM/Ohzgkxh6ie2FRL1xGADGsWQIprFsGYSrgfUjLruzlqZgI5VfHudvkG+D+V8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgFKPIMuhcFy+1ZD8zXE3Vu/H57cI2skbNSVp9sQieeJq+ZTPl
	5KK3Do4fnM5XBcmKVQ8ThNdyM9U5TRv7YPJdcU5Z3XODw3RRfztgN6DC6k92DwpANsCNkALMuN0
	7WkNlgxshrZIBZisaZscz+hFtKLQc3jlngHrzZV/TjsECBnh77llnFsHItIrGuURbquHl93licc
	g=
X-Gm-Gg: ASbGnctrjgR39gkSQQX09w1ESewZTXJGXLMVCtvcpyw38WtdYEcfY3091/DMNzInIq2
	/MvOsKeo1lW04HehVNWQsHv7GE6JmW1Ei6QQm563M3+UIcVxBdLSkDfdv/m/rLIAKbTDHE9mT/w
	FI/i6eMBpJTI4/XqdIRaC9HXuOybcTS/kOexZOQCQsOf0PO/eYg8pUkwHeVxY+2RFeJEU3dYSqt
	4EBvAAQe4YwEHksUSxjc34Dghnc16L5sAymvhxVAwuM0/iMlRdNjTTNCGTSa/KWmld9ExCZqfvJ
	7vW56FnBLmXcu7Mzw9s7x9QX3dw/3QXz5a3lOvrnjnbe+MpSE77umWNGM55xM5EV0VqIs3X/T+m
	xJh2xBYf9+1kOcBLsPOcaYSEGlCpQHw==
X-Received: by 2002:a17:903:1111:b0:267:9931:dbfb with SMTP id d9443c01a7336-2951a526f47mr2694125ad.54.1761840617305;
        Thu, 30 Oct 2025 09:10:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHx/2v2Y6iiTLClD49fJ3bL9a8X/OSoHQEzOrEjzy1EurunGNHqRezxw7ERXZMD8sAa0EW21Q==
X-Received: by 2002:a17:903:1111:b0:267:9931:dbfb with SMTP id d9443c01a7336-2951a526f47mr2693415ad.54.1761840616567;
        Thu, 30 Oct 2025 09:10:16 -0700 (PDT)
Received: from hu-neersoni-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf4a40sm195475275ad.0.2025.10.30.09.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 09:10:15 -0700 (PDT)
From: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
To: andersson@kernel.org, konradybcio@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        neeraj.soni@oss.qualcomm.com
Subject: [PATCH v3] soc: qcom: ice: Add HWKM v1 support for wrapped keys
Date: Thu, 30 Oct 2025 21:40:12 +0530
Message-Id: <20251030161012.3391239-1-neeraj.soni@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDEzMiBTYWx0ZWRfX+d1oA4Mk22KC
 GoYODzrWia7pyUJ238LOibfkeVfLQPsfMBPe551G0xs2Wbr56auhsevVIjuFFzMdJCLryMG83n7
 CPhKri1KZJ3aYU4YibSYLiI53rH4pTDeomFTU24x+1OpA8DK74HM8St8CAYMd/pTiZYdiakGetg
 VoL78qn3zrhCesrYO7KOlmSuwZoVkYnx7VJKxPyHNfRstm6EPBlELFP3n2WX42CYniYbe8crA4N
 Ol2OOlzrO59ClSwbYAYSgT/3i6GUY/qyM9w/xjFg8KBwbxdQYoUgpwPwXsK1ClFoV9XG1asPfsX
 H6X5W7i+q/qULBvl2ThTBzAHOMFnVKUi7EZ81Gvc6zoST8+lKfuhq2rctvBaCrkF6FKryux20q9
 wVyMcrGkE4UvIC1EUwSiRo0Z8S7ZUA==
X-Authority-Analysis: v=2.4 cv=KePfcAYD c=1 sm=1 tr=0 ts=69038deb cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=vY7nf_sd2vNLmu096JAA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: VWjl6UHNR6PWRbhLC9va8dfBB5zJ0M7s
X-Proofpoint-GUID: VWjl6UHNR6PWRbhLC9va8dfBB5zJ0M7s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_05,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510300132

HWKM v1 and v2 differ slightly in wrapped key size and the bit fields for
certain status registers and operating mode (legacy or standard).

Add support to select HWKM version based on the major and minor revisions.
Use this HWKM version to select wrapped key size and to configure the bit
fields in registers for operating modes and hardware status.

Support for SCM calls for wrapped keys is being added in the TrustZone for
few SoCs with HWKM v1. Existing check of qcom_scm_has_wrapped_key_support()
API ensures that HWKM is used only if these SCM calls are supported in
TrustZone for that SoC.

Signed-off-by: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
---

Changes in [v3]
- Removed the dev_info() log in qcom_ice_check_supported() if HWKM is not
  supported.
- Removed the comment which described the slot offset calculation in
  translate_hwkm_slot().

Changes in [v2]
- Added "ice:" in subject.
- Introduced QCOM_ICE_HWKM_MAX_WRAPPED_KEY_SIZE macro for maximum HWKM
  wrapped key size.
- Updated comment for HWKM availability in qcom_ice_check_supported() for
  ICE version earlier to "3.2.0".
- Updated the if (major == 4) check in qcom_ice_check_supported() to
  if (major > 3) to select HWKM v2 version for all ICE revisions after
  "3.2.0".
- Fixed "Hard Ware" to "Hardware" in dev_info() print for HWKM version in
  qcom_ice_check_supported().
- Used QCOM_ICE_HWKM_MAX_WRAPPED_KEY_SIZE in BUILD_BUG_ON() in
  qcom_ice_hwkm_init().
- Removed redundant else condition for HWKM version in qcom_ice_hwkm_init()
  as it was impossible to reach.
- Removed redundant parentheses in translate_hwkm_slot().

Change in [v1]
- Added initial support for HWKM v1 for wrapped keys.
---
 drivers/soc/qcom/ice.c | 81 ++++++++++++++++++++++++++++++------------
 1 file changed, 58 insertions(+), 23 deletions(-)

diff --git a/drivers/soc/qcom/ice.c b/drivers/soc/qcom/ice.c
index c467b55b4174..b203bc685cad 100644
--- a/drivers/soc/qcom/ice.c
+++ b/drivers/soc/qcom/ice.c
@@ -22,7 +22,18 @@
 #include <soc/qcom/ice.h>
 
 #define AES_256_XTS_KEY_SIZE			64   /* for raw keys only */
-#define QCOM_ICE_HWKM_WRAPPED_KEY_SIZE		100  /* assuming HWKM v2 */
+
+#define QCOM_ICE_HWKM_V1			1    /* HWKM version 1 */
+#define QCOM_ICE_HWKM_V2			2    /* HWKM version 2 */
+
+#define QCOM_ICE_HWKM_MAX_WRAPPED_KEY_SIZE	100  /* Maximum HWKM wrapped key size */
+
+/*
+ * Wrapped key size depends upon HWKM version:
+ * HWKM version 1 supports 68 bytes
+ * HWKM version 2 supports 100 bytes
+ */
+#define QCOM_ICE_HWKM_WRAPPED_KEY_SIZE(v)	((v) == QCOM_ICE_HWKM_V1 ? 68 : 100)
 
 /* QCOM ICE registers */
 
@@ -62,13 +73,15 @@ union crypto_cfg {
 
 #define QCOM_ICE_REG_HWKM_TZ_KM_CTL		(HWKM_OFFSET + 0x1000)
 #define QCOM_ICE_HWKM_DISABLE_CRC_CHECKS_VAL	(BIT(1) | BIT(2))
+/* In HWKM v1 the ICE legacy mode is controlled from HWKM register space */
+#define QCOM_ICE_HWKM_ICE_LEGACY_MODE_ENABLED	BIT(5)
 
 #define QCOM_ICE_REG_HWKM_TZ_KM_STATUS		(HWKM_OFFSET + 0x1004)
 #define QCOM_ICE_HWKM_KT_CLEAR_DONE		BIT(0)
 #define QCOM_ICE_HWKM_BOOT_CMD_LIST0_DONE	BIT(1)
 #define QCOM_ICE_HWKM_BOOT_CMD_LIST1_DONE	BIT(2)
-#define QCOM_ICE_HWKM_CRYPTO_BIST_DONE_V2	BIT(7)
-#define QCOM_ICE_HWKM_BIST_DONE_V2		BIT(9)
+#define QCOM_ICE_HWKM_CRYPTO_BIST_DONE(v)	(((v) == QCOM_ICE_HWKM_V1) ? BIT(14) : BIT(7))
+#define QCOM_ICE_HWKM_BIST_DONE(v)		(((v) == QCOM_ICE_HWKM_V1) ? BIT(16) : BIT(9))
 
 #define QCOM_ICE_REG_HWKM_BANK0_BANKN_IRQ_STATUS (HWKM_OFFSET + 0x2008)
 #define QCOM_ICE_HWKM_RSP_FIFO_CLEAR_VAL	BIT(3)
@@ -97,6 +110,7 @@ struct qcom_ice {
 	struct clk *core_clk;
 	bool use_hwkm;
 	bool hwkm_init_complete;
+	u8 hwkm_version;
 };
 
 static bool qcom_ice_check_supported(struct qcom_ice *ice)
@@ -114,9 +128,24 @@ static bool qcom_ice_check_supported(struct qcom_ice *ice)
 		return false;
 	}
 
+	/* HWKM version v2 is present from ICE 3.2.1 onwards while version v1
+	 * is present only in ICE 3.2.0. Earlier ICE version don't have HWKM.
+	 */
+	if (major > 3 ||
+	   (major == 3 && (minor >= 3 || (minor == 2 && step >= 1))))
+		ice->hwkm_version = QCOM_ICE_HWKM_V2;
+	else if ((major == 3) && (minor == 2))
+		ice->hwkm_version = QCOM_ICE_HWKM_V1;
+	else
+		ice->hwkm_version = 0;
+
 	dev_info(dev, "Found QC Inline Crypto Engine (ICE) v%d.%d.%d\n",
 		 major, minor, step);
 
+	if (ice->hwkm_version)
+		dev_info(dev, "QC Hardware Key Manager (HWKM) version v%d\n",
+			 ice->hwkm_version);
+
 	/* If fuses are blown, ICE might not work in the standard way. */
 	regval = qcom_ice_readl(ice, QCOM_ICE_REG_FUSE_SETTING);
 	if (regval & (QCOM_ICE_FUSE_SETTING_MASK |
@@ -131,19 +160,18 @@ static bool qcom_ice_check_supported(struct qcom_ice *ice)
 	 * v3.2.1 and later have HWKM v2.  ICE v3.2.0 has HWKM v1.  Earlier ICE
 	 * versions don't have HWKM at all.  However, for HWKM to be fully
 	 * usable by Linux, the TrustZone software also needs to support certain
-	 * SCM calls including the ones to generate and prepare keys.  That
-	 * effectively makes the earliest supported SoC be SM8650, which has
-	 * HWKM v2.  Therefore, this driver doesn't include support for HWKM v1,
-	 * and it checks for the SCM call support before it decides to use HWKM.
+	 * SCM calls including the ones to generate and prepare keys. Support
+	 * for these SCM calls is present for SoCs with HWKM v2 and is being
+	 * added for SoCs with HWKM v1 as well but not every SoC with HWKM v1
+	 * currently supports this. So, this driver checks for the SCM call
+	 * support before it decides to use HWKM.
 	 *
 	 * Also, since HWKM and legacy mode are mutually exclusive, and
 	 * ICE-capable storage driver(s) need to know early on whether to
 	 * advertise support for raw keys or wrapped keys, HWKM cannot be used
 	 * unconditionally.  A module parameter is used to opt into using it.
 	 */
-	if ((major >= 4 ||
-	     (major == 3 && (minor >= 3 || (minor == 2 && step >= 1)))) &&
-	    qcom_scm_has_wrapped_key_support()) {
+	if (ice->hwkm_version && qcom_scm_has_wrapped_key_support()) {
 		if (qcom_ice_use_wrapped_keys) {
 			dev_info(dev, "Using HWKM. Supporting wrapped keys only.\n");
 			ice->use_hwkm = true;
@@ -212,8 +240,8 @@ static int qcom_ice_wait_bist_status(struct qcom_ice *ice)
 	    (QCOM_ICE_HWKM_KT_CLEAR_DONE |
 	     QCOM_ICE_HWKM_BOOT_CMD_LIST0_DONE |
 	     QCOM_ICE_HWKM_BOOT_CMD_LIST1_DONE |
-	     QCOM_ICE_HWKM_CRYPTO_BIST_DONE_V2 |
-	     QCOM_ICE_HWKM_BIST_DONE_V2)) {
+	     QCOM_ICE_HWKM_CRYPTO_BIST_DONE(ice->hwkm_version) |
+	     QCOM_ICE_HWKM_BIST_DONE(ice->hwkm_version))) {
 		dev_err(ice->dev, "HWKM self-test error!\n");
 		/*
 		 * Too late to revoke use_hwkm here, as it was already
@@ -230,7 +258,7 @@ static void qcom_ice_hwkm_init(struct qcom_ice *ice)
 	if (!ice->use_hwkm)
 		return;
 
-	BUILD_BUG_ON(QCOM_ICE_HWKM_WRAPPED_KEY_SIZE >
+	BUILD_BUG_ON(QCOM_ICE_HWKM_MAX_WRAPPED_KEY_SIZE >
 		     BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE);
 	/*
 	 * When ICE is in HWKM mode, it only supports wrapped keys.
@@ -238,9 +266,15 @@ static void qcom_ice_hwkm_init(struct qcom_ice *ice)
 	 *
 	 * Put ICE in HWKM mode.  ICE defaults to legacy mode.
 	 */
-	regval = qcom_ice_readl(ice, QCOM_ICE_REG_CONTROL);
-	regval &= ~QCOM_ICE_LEGACY_MODE_ENABLED;
-	qcom_ice_writel(ice, regval, QCOM_ICE_REG_CONTROL);
+	if (ice->hwkm_version == QCOM_ICE_HWKM_V2) {
+		regval = qcom_ice_readl(ice, QCOM_ICE_REG_CONTROL);
+		regval &= ~QCOM_ICE_LEGACY_MODE_ENABLED;
+		qcom_ice_writel(ice, regval, QCOM_ICE_REG_CONTROL);
+	} else if (ice->hwkm_version == QCOM_ICE_HWKM_V1) {
+		regval = qcom_ice_readl(ice, QCOM_ICE_REG_HWKM_TZ_KM_CTL);
+		regval &= ~QCOM_ICE_HWKM_ICE_LEGACY_MODE_ENABLED;
+		qcom_ice_writel(ice, regval, QCOM_ICE_REG_HWKM_TZ_KM_CTL);
+	}
 
 	/* Disable CRC checks.  This HWKM feature is not used. */
 	qcom_ice_writel(ice, QCOM_ICE_HWKM_DISABLE_CRC_CHECKS_VAL,
@@ -298,7 +332,7 @@ EXPORT_SYMBOL_GPL(qcom_ice_suspend);
 
 static unsigned int translate_hwkm_slot(struct qcom_ice *ice, unsigned int slot)
 {
-	return slot * 2;
+	return ice->hwkm_version == QCOM_ICE_HWKM_V1 ? slot : slot * 2;
 }
 
 static int qcom_ice_program_wrapped_key(struct qcom_ice *ice, unsigned int slot,
@@ -451,11 +485,12 @@ int qcom_ice_generate_key(struct qcom_ice *ice,
 {
 	int err;
 
-	err = qcom_scm_generate_ice_key(lt_key, QCOM_ICE_HWKM_WRAPPED_KEY_SIZE);
+	err = qcom_scm_generate_ice_key(lt_key,
+					QCOM_ICE_HWKM_WRAPPED_KEY_SIZE(ice->hwkm_version));
 	if (err)
 		return err;
 
-	return QCOM_ICE_HWKM_WRAPPED_KEY_SIZE;
+	return QCOM_ICE_HWKM_WRAPPED_KEY_SIZE(ice->hwkm_version);
 }
 EXPORT_SYMBOL_GPL(qcom_ice_generate_key);
 
@@ -478,13 +513,13 @@ int qcom_ice_prepare_key(struct qcom_ice *ice,
 	int err;
 
 	err = qcom_scm_prepare_ice_key(lt_key, lt_key_size,
-				       eph_key, QCOM_ICE_HWKM_WRAPPED_KEY_SIZE);
+				       eph_key, QCOM_ICE_HWKM_WRAPPED_KEY_SIZE(ice->hwkm_version));
 	if (err == -EIO || err == -EINVAL)
 		err = -EBADMSG; /* probably invalid key */
 	if (err)
 		return err;
 
-	return QCOM_ICE_HWKM_WRAPPED_KEY_SIZE;
+	return QCOM_ICE_HWKM_WRAPPED_KEY_SIZE(ice->hwkm_version);
 }
 EXPORT_SYMBOL_GPL(qcom_ice_prepare_key);
 
@@ -506,11 +541,11 @@ int qcom_ice_import_key(struct qcom_ice *ice,
 	int err;
 
 	err = qcom_scm_import_ice_key(raw_key, raw_key_size,
-				      lt_key, QCOM_ICE_HWKM_WRAPPED_KEY_SIZE);
+				      lt_key, QCOM_ICE_HWKM_WRAPPED_KEY_SIZE(ice->hwkm_version));
 	if (err)
 		return err;
 
-	return QCOM_ICE_HWKM_WRAPPED_KEY_SIZE;
+	return QCOM_ICE_HWKM_WRAPPED_KEY_SIZE(ice->hwkm_version);
 }
 EXPORT_SYMBOL_GPL(qcom_ice_import_key);
 
-- 
2.34.1


