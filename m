Return-Path: <linux-kernel+bounces-870469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC046C0AE33
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 17:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77271189E9D0
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 16:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0DA258CCC;
	Sun, 26 Oct 2025 16:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eW68gJKi"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501C03AC39
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 16:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761497237; cv=none; b=COp/4ia5v4zZ2ymVHbAkM1iwSNe+R9csJwkL891MXgfTe54lp8u01JIG0Nd6cSPVTb8WPUOYiMkRmi0vyKtUWrS5YoqS29cCJvI/GU+dcgG5qtx8GnhLEsA0DhVQQtVT6hRUFxI76sKmEcMgZPPB07f+KlpQTMsoG4RA9mZDokM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761497237; c=relaxed/simple;
	bh=MSxjxmhdoFP31asdp8BwwQo3EKrKgcGelDfHqcJ8/cM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=l9E4tvaoU/Gl//tF5GTFqky4KXHw7jmAaUDXv+ywMgP/ixpUnniPilEfEjDqHQzWhcMhOkZ5ZbzZSnVN158oh1ARWc6eKZJJM5cHM6H5dY5pBSXfJ9iAr7AFT6BsJgsOnfe/SoP9mhyfjvlorSQqYfSErItLhzL19ZMec4TFIms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eW68gJKi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59Q9sIWU3703368
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 16:47:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=gtOIQDRkE4jUoGiuibLTec4EJCw31m7i1qU
	bgSeUb7E=; b=eW68gJKi3/d09QhGumwxEknjMSqaUn5bnfiy94Mk4nC5q8uUZY8
	pMJfBRzblQTc3S68i+4FNNBjc5uxCsP7KdFgtjVUS65IGx+IVke8/nrrHCKVDiK8
	mQoF2WpLKIUgCB2ijrnEcrH3vaRI7W6NfkFhk/ggzQqsoEGgbgGTmfoDod1otKKd
	MApQA+GxuPqlzDAhVZ+mIyn1AA7qAPxhILn6aekPzLNQm+Xf6K3G+tPxemv5Pop4
	wdw0+mMVksTOxiUXJF8tFkRExpY8zxM9tjGoJDIM3wmBdW9PRKBnqSfnWVe2L1yY
	+Xh/sd19CPGpqIxeir9wIjHpoF0Q9G+OUkw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a0p2q2a6a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 16:47:13 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2924b3b9d47so35713045ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 09:47:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761497233; x=1762102033;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gtOIQDRkE4jUoGiuibLTec4EJCw31m7i1qUbgSeUb7E=;
        b=VFj839aOQ0xspTRWcKg/QXtElRjwu1xBi24wqVru79Dh1Z8WD6h1kvqHiaxEXHAJZZ
         xGmwRgPAgioUZsZnXKhFFwEU6QG6r8vbsi8mctoKd6j7UwMerVPzzUjcnJbEUax6JZeb
         Tv/hrQGR9YzVJ7j8tbi9PN+UXuEF308YDQXyX8wVrPdjzFvwudAoAisBdP7FPRldqsMx
         WWWJnb8zXgmZ5K586HVE1bdgkk0DoutpirSv2ODiRfcs2yhGFYmJuTDAmpZ4+qM1hdAX
         kBGFVXuAHFAg/Jr+XjbZn54u8H4YkTPa8TBEHBuBs6DIK7f7MPbV9zYPPSkKE+DlmzT7
         JhUQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1Ty0MW39QpitHBBSeret9CfWnX74lPKRRbT4nfU56dCPzAjTtKHBrgCn06EItofQ/g5fotGGbYXDPevU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv4PCx2XCxH/iGciDeRJcrp0kd5M84gmWAyrajXG8hdZbaGUHd
	5UBVBMzWxFSeR20Q5YeMMg9jxJ9hRo/20Pkd5vVWfzkIMWX/O2ksFgUTcY9HgElUZiHxkfZ2hjK
	yJ7SbSZdhAep+gaJ4DYF6PFI/EHe69FYGeij//eY7QJ7TolmYTOzBSYTiV5M3jRgZLmwwROqB6/
	w=
X-Gm-Gg: ASbGncuDPRUtbazAZ2lIhNR71Q878M0iLGyRG/q48WkDrQglYToDvo1rKxOwxTBdwcB
	IMASnONUBfImtnp/FHhJqtXJjYctNlNrp6Z6QHqd8d+XM+ow++1bcRovxnr4NaLjsduKmaXuC+7
	lVhpBKlW50A5d1g9lXwa/5/MXauf+jKapmqL+T91+Drm9fRvUsRDcduO8bYaPaJv3W8uKzAwzIr
	4UR4RG4b1yQEYOxLsB8pG1eQ2hZEoZsIB0KcjkKEvl7+95FJVk1poW4OzJ2Vq1Z1Env7uC9Psf/
	+MXQxzjN64txXapIgEqZUTP5VWl1SBw09YKIzBJn7fVZXOkxPw/GeTN4AC3o+wQuOvFQSp4p9hS
	4Lnpubohyhus1IGBRBB8lacjiQj0nPQ==
X-Received: by 2002:a17:902:e5cc:b0:267:95ad:8cb8 with SMTP id d9443c01a7336-290cb079f2dmr473791615ad.44.1761497232684;
        Sun, 26 Oct 2025 09:47:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElUY1pOphpgAKzA1U30wGs7B7BcP61UTizcuLEFI7VOcVE/KvEUt3scnuKVgrJMAxHJ5Wdhw==
X-Received: by 2002:a17:902:e5cc:b0:267:95ad:8cb8 with SMTP id d9443c01a7336-290cb079f2dmr473791395ad.44.1761497232165;
        Sun, 26 Oct 2025 09:47:12 -0700 (PDT)
Received: from hu-neersoni-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498e41125sm53997555ad.94.2025.10.26.09.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 09:47:11 -0700 (PDT)
From: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
To: andersson@kernel.org, konradybcio@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        neeraj.soni@oss.qualcomm.com
Subject: [PATCH] soc: qcom: Add HWKM v1 support for wrapped keys
Date: Sun, 26 Oct 2025 22:17:08 +0530
Message-Id: <20251026164708.2771213-1-neeraj.soni@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=QvpTHFyd c=1 sm=1 tr=0 ts=68fe5092 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=oDhber50rIFwixT5uKoA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI2MDE2MSBTYWx0ZWRfX+g7nFI4WyW2e
 L5xcccgwCnkom9IkcwBVX7H0YKoNDNu5K5y5d7KEk1gYLgbJnRGWGtXQTU7xTDClgv52Hv/+jaG
 M1JUKO6/mVfI0gZbVYqAcbrds6IN1nmOjg5KjrYjFcMuDKXUWDStsJ3BRaiKJSu4tPjKXWkItyT
 8wszPq/tnRBoALRMn0kHucNO+g6C0DaKI1YAikSawnMsDjb0vXobrCFkp8PVWOLtDP68Naq9VHM
 tOF78p1Uou/fpHhHUJvwxll6sd4cvYyLknIfZy2gPMmmsriEitu1qHynvim/M5DVGZQAcFFvadz
 YvPEQbtag6gMYDDBK3iqenpUsoucU1zajhxmhdFHHu1nME92Vk4IDMGdfBUy1eKx0L5ZAKrgbFM
 uaVx0aInu8nJKnNnSKss8GumXJ5xlw==
X-Proofpoint-GUID: OpdjrxZw0YTCRo0Dxo0YNB5BkCpjndRH
X-Proofpoint-ORIG-GUID: OpdjrxZw0YTCRo0Dxo0YNB5BkCpjndRH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-26_07,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 spamscore=0 suspectscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510260161

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
 drivers/soc/qcom/ice.c | 85 ++++++++++++++++++++++++++++++------------
 1 file changed, 62 insertions(+), 23 deletions(-)

diff --git a/drivers/soc/qcom/ice.c b/drivers/soc/qcom/ice.c
index c467b55b4174..5f213e74c668 100644
--- a/drivers/soc/qcom/ice.c
+++ b/drivers/soc/qcom/ice.c
@@ -22,7 +22,16 @@
 #include <soc/qcom/ice.h>
 
 #define AES_256_XTS_KEY_SIZE			64   /* for raw keys only */
-#define QCOM_ICE_HWKM_WRAPPED_KEY_SIZE		100  /* assuming HWKM v2 */
+
+#define QCOM_ICE_HWKM_V1			1    /* HWKM version 1 */
+#define QCOM_ICE_HWKM_V2			2    /* HWKM version 2 */
+
+/*
+ * Wrapped key size depends upon HWKM version:
+ * HWKM version 1 supports 68 bytes
+ * HWKM version 2 supports 100 bytes
+ */
+#define QCOM_ICE_HWKM_WRAPPED_KEY_SIZE(v)	((v) == QCOM_ICE_HWKM_V1 ? 68 : 100)
 
 /* QCOM ICE registers */
 
@@ -62,13 +71,15 @@ union crypto_cfg {
 
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
@@ -97,6 +108,7 @@ struct qcom_ice {
 	struct clk *core_clk;
 	bool use_hwkm;
 	bool hwkm_init_complete;
+	u8 hwkm_version;
 };
 
 static bool qcom_ice_check_supported(struct qcom_ice *ice)
@@ -114,9 +126,26 @@ static bool qcom_ice_check_supported(struct qcom_ice *ice)
 		return false;
 	}
 
+	/* HWKM version v2 is present from ICE 3.2.1 onwards while version v1
+	 * is present only in ICE 3.2.0.
+	 */
+	if (major == 4 ||
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
+		dev_info(dev, "QC Hard Ware Key Manager (HWKM) not supported\n");
+	else
+		dev_info(dev, "QC Hard Ware Key Manager (HWKM) version v%d\n",
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
+	BUILD_BUG_ON(QCOM_ICE_HWKM_WRAPPED_KEY_SIZE(ice->hwkm_version) >
 		     BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE);
 	/*
 	 * When ICE is in HWKM mode, it only supports wrapped keys.
@@ -238,9 +266,18 @@ static void qcom_ice_hwkm_init(struct qcom_ice *ice)
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
+	} else {
+		dev_err(ice->dev, "Invalid HWKM version\n");
+		return;
+	}
 
 	/* Disable CRC checks.  This HWKM feature is not used. */
 	qcom_ice_writel(ice, QCOM_ICE_HWKM_DISABLE_CRC_CHECKS_VAL,
@@ -298,7 +335,8 @@ EXPORT_SYMBOL_GPL(qcom_ice_suspend);
 
 static unsigned int translate_hwkm_slot(struct qcom_ice *ice, unsigned int slot)
 {
-	return slot * 2;
+	/* The slot offset depends upon HWKM version */
+	return (ice->hwkm_version == QCOM_ICE_HWKM_V1) ? (slot) : (slot * 2);
 }
 
 static int qcom_ice_program_wrapped_key(struct qcom_ice *ice, unsigned int slot,
@@ -451,11 +489,12 @@ int qcom_ice_generate_key(struct qcom_ice *ice,
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
 
@@ -478,13 +517,13 @@ int qcom_ice_prepare_key(struct qcom_ice *ice,
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
 
@@ -506,11 +545,11 @@ int qcom_ice_import_key(struct qcom_ice *ice,
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


