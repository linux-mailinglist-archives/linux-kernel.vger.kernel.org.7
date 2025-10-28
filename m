Return-Path: <linux-kernel+bounces-874445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 151E0C165CB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 19:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 212353B2E0F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3CFC347BA3;
	Tue, 28 Oct 2025 17:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZQMZwasl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aV2KYEJn"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B33147C9B
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 17:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761674190; cv=none; b=KdeFeqvIIZntPuD66rdY7Vccy6vwTE4C93+qQpcAvEEFS7V2NWenFHqWE7m92g+0czQvvnbYi9oaK0ujAYsA5Xgor2cRrb0jBddqQi7Jx9HA3kHsTtcQY/eIOhIVbI1XrSWP42dpUDuPQzECVz7B/XENZItUYtVVTgu0VToLqnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761674190; c=relaxed/simple;
	bh=BU+1uKz5/jgwSY1VQmOs7TZswDg7x58zBa+tGrlAkYw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iNbqbUf16lJyfF0cVbLS3vcg1/lDn2A9hXnvhI+r7kpAPIazVlbrMz7Sh7Z7GnX6DLjowRxvs7fjscVFYA+wy5boKcoHJGzswI8Qr2+W6ffuFuWpEV3Jxlj1oHuiHFmyCFe/PpqChqyKu3D1Q30Tt2d1ioJZoRIa0aLrXCcrE0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZQMZwasl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aV2KYEJn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59SEoBqi1966786
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 17:56:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=CY9mwslQZrSmHpkIizgzfQQ2+GJStg23eN8
	tQn05XQo=; b=ZQMZwasldXcYJDgrLA4j0Az+52AFAe0dR2C4SgdrGysElleU/mn
	tkeMymAT+kVlfS8cJGNgXaMrome+6covd/PV9gw0sfqtST9TiWyoEBC96qSntzfC
	sI05m3RZCi3AxGnbpKLmXkPSIfSZDv5g3fKWyzhz8gxjKtbAzrKMUvzYr0fUibMb
	pCJb/CZXtmDA/aiVbU6ldHSUJMLFQnPHL9QWeSznImbh97txzZpmjvpvZPMJRFdX
	J0Avk49y43m0MaoBcqql2PO2/Uoshz81s0tCOC9nKWz+9nLnqLa/54HYNDr+iFZN
	J3EqnxSDaFxNNKe8A0FNSP5kIJ0thtov/IQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a2w51s5wf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 17:56:28 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-294baa12981so1393575ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761674187; x=1762278987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CY9mwslQZrSmHpkIizgzfQQ2+GJStg23eN8tQn05XQo=;
        b=aV2KYEJnKYcGEAsM5ta9OhtcFmm9yACkFf2rBrVz9sKXTcgfY4xz/xyOR7/cQb9xUL
         aFTYDqNzFoyx6zhMgj3JjC/ZyI2yuqlzwysiXfYNn8mUpl31zGPKLr2GDvyZsnm37pYW
         Ad7bO0GN7KC/YEcO/8S4EVtalBnIzm/53DEwkAHWi7BAGLUp0hjdFfGPrFMJx0iNhMam
         CVfXGlQJRicDsLCC6nMgx7SQogDEH10orSYXiWivTgY1ZpSDzk/EPt4LH4uXY+FPSBBN
         I3jWxk+Qw471VdO0MS/x7x3B4B1XwFLWfx9D1DNzPkp+vd6+pxireCpWg5VNO8W4EJ/K
         7jaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761674187; x=1762278987;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CY9mwslQZrSmHpkIizgzfQQ2+GJStg23eN8tQn05XQo=;
        b=ulHWbNA5kKeJZZxhBrfDPLk+Z39agX7IwfSFIByRvOnwYWb6/TQBfIiZQFk9m6lr3m
         /N5YLv0sOLL2jN/V16Fk0OV7UBIqdnHPHu7xfZFcPIll957ym9NIQr0+aXlw7gSZ2HLg
         TNbhSnOJRyKe15Z6sl/uvylT/aSjbtCxhuvd4fVK5idVm21ohy3FWhljz+zG947xmSb7
         a6SJ2QFBjwpumx1M8ylFzklVKjsCp6WmZS/NRZFFVw8p7iSVJDtmZ+X1wQ6U2s9ZwnNV
         eqmvK2E1pwlJkBlk5iIYQmzqmRjdY61ChffND+eJwLtsLGToeSGumHrqHDAwboIYtkJ5
         8BWw==
X-Forwarded-Encrypted: i=1; AJvYcCWwUFaqU9B0GdjAxmgZRq8Pl5p0GrrF8aqrB7Ghk3026sO/LbQkcUd9JNcQz2azeX8x6Snk0vbwd13psFA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdtoILoU8zmdr0coEIGogSgdG3LA9bgbo7JEemNcI5sx5v5Wnh
	xJVBWhdTlD5AA8Jhqmfoxb83x+5k4t7MpCc9ScpOydZtBwAH1xpEAW8nnx1x3wkhLYrM9ZWA/8h
	RkiKQQAR9SIAvxCgScyt0uaJ/9gz7b5D68AZvM9dHbHmN2bn8Jg27m2DtI3tgg4Crg4JPFIE1V1
	M=
X-Gm-Gg: ASbGncsVGpgycXVeELqaDyq9kOgH5sKmfQ521u9FE/7IdGRE39qQhB39DQ54U8soXp5
	GkQr9EinSQTnAcRSVM7I5Cxv7oo9QTqegEXVWk8aSBRNuej2K/PyPeL2P5aCu0bVO2ccjt1bzgO
	5rmcsyAwnPoGCpeOP6hB+JastGasTZq7XLi4/N/A17IHzEXVchUgG0Ru1Mc1bJ5SFoYxErhzUOC
	4Zvx6UqfMZJk2MWdGopwy3l1T3ltDBi0f2Ov+IwWFe/xTZdKcZssEFGVuZ5Zsv/4FJLG0duKaa8
	TYf8kyHTcb5IR6bc8HtTY4TBnOUYnjCCdDj2fCQuJKfsEeXgCWXMxwzOuHvc21YcVDqM5TvZvEx
	2k4BL6KxO11omi7srpppBiDQK4G0Htw==
X-Received: by 2002:a17:902:c402:b0:25b:e5a2:fb29 with SMTP id d9443c01a7336-294de82e2d6mr1592025ad.12.1761674187320;
        Tue, 28 Oct 2025 10:56:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPuFgeocQDH0Y+5SaMQQ4Is2hmA57zZXLDOQQK2fjGOF5JGuBzPwVO7n9W9+CQy6rRjA3x3A==
X-Received: by 2002:a17:902:c402:b0:25b:e5a2:fb29 with SMTP id d9443c01a7336-294de82e2d6mr1591575ad.12.1761674186643;
        Tue, 28 Oct 2025 10:56:26 -0700 (PDT)
Received: from hu-neersoni-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d4254asm126628705ad.82.2025.10.28.10.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 10:56:26 -0700 (PDT)
From: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
To: andersson@kernel.org, konradybcio@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        neeraj.soni@oss.qualcomm.com
Subject: [PATCH v2] soc: qcom: ice: Add HWKM v1 support for wrapped keys
Date: Tue, 28 Oct 2025 23:26:23 +0530
Message-Id: <20251028175623.1054084-1-neeraj.soni@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: JmdOBaQo3kWjuDIbmbMnNJObIX9BQ8ON
X-Authority-Analysis: v=2.4 cv=YMiSCBGx c=1 sm=1 tr=0 ts=690103cc cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=vY7nf_sd2vNLmu096JAA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: JmdOBaQo3kWjuDIbmbMnNJObIX9BQ8ON
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE1MCBTYWx0ZWRfX3Cso8+O55ow4
 j09kmHXrSOT2GUUHEfeh0y1TMo8cHzFt67LN0V8KBOCgiqLNmlgN+5Hpns3JDbSCfhzXh8iLlNN
 b51z7ek416D711DY75BVW/rkzrD8V+htleK6hUKJvNgPs4SoijSmuj4BDvGzbYMmXb7eByzDHoZ
 UYwVzUR4d9cKDu+KRJdqnRq4G7MtSIeJjvZLSXIXV/7CYNDRR0ilUjnPJp4orcLkM4ykgHbJZii
 eG4XgQBzxRGWB/2t/OvPkcNZCVyTO+kTKomHT7qvHtkKVCCKLBcui2PSDGGcW27xkt7Vbs/GbkX
 VtOse+J0rPbznRLOtzuPe7g0bochqHYVtFPDkPFmAgQSol63+JzB3p8ebVBBcyKJePnAXHcRlpB
 GrlcXCQPHlJm35OPxGxGbJAetIoD5A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_06,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 spamscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510280150

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
 drivers/soc/qcom/ice.c | 84 ++++++++++++++++++++++++++++++------------
 1 file changed, 61 insertions(+), 23 deletions(-)

diff --git a/drivers/soc/qcom/ice.c b/drivers/soc/qcom/ice.c
index c467b55b4174..20584384ed31 100644
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
@@ -114,9 +128,26 @@ static bool qcom_ice_check_supported(struct qcom_ice *ice)
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
 
+	if (!ice->hwkm_version)
+		dev_info(dev, "QC Hardware Key Manager (HWKM) not supported\n");
+	else
+		dev_info(dev, "QC Hardware Key Manager (HWKM) version v%d\n",
+			 ice->hwkm_version);
+
 	/* If fuses are blown, ICE might not work in the standard way. */
 	regval = qcom_ice_readl(ice, QCOM_ICE_REG_FUSE_SETTING);
 	if (regval & (QCOM_ICE_FUSE_SETTING_MASK |
@@ -131,19 +162,18 @@ static bool qcom_ice_check_supported(struct qcom_ice *ice)
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
@@ -212,8 +242,8 @@ static int qcom_ice_wait_bist_status(struct qcom_ice *ice)
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
@@ -230,7 +260,7 @@ static void qcom_ice_hwkm_init(struct qcom_ice *ice)
 	if (!ice->use_hwkm)
 		return;
 
-	BUILD_BUG_ON(QCOM_ICE_HWKM_WRAPPED_KEY_SIZE >
+	BUILD_BUG_ON(QCOM_ICE_HWKM_MAX_WRAPPED_KEY_SIZE >
 		     BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE);
 	/*
 	 * When ICE is in HWKM mode, it only supports wrapped keys.
@@ -238,9 +268,15 @@ static void qcom_ice_hwkm_init(struct qcom_ice *ice)
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
@@ -298,7 +334,8 @@ EXPORT_SYMBOL_GPL(qcom_ice_suspend);
 
 static unsigned int translate_hwkm_slot(struct qcom_ice *ice, unsigned int slot)
 {
-	return slot * 2;
+	/* The slot offset depends upon HWKM version */
+	return ice->hwkm_version == QCOM_ICE_HWKM_V1 ? slot : slot * 2;
 }
 
 static int qcom_ice_program_wrapped_key(struct qcom_ice *ice, unsigned int slot,
@@ -451,11 +488,12 @@ int qcom_ice_generate_key(struct qcom_ice *ice,
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
 
@@ -478,13 +516,13 @@ int qcom_ice_prepare_key(struct qcom_ice *ice,
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
 
@@ -506,11 +544,11 @@ int qcom_ice_import_key(struct qcom_ice *ice,
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


