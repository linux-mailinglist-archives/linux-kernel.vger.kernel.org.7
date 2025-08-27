Return-Path: <linux-kernel+bounces-788148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E34ACB38064
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 12:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 724827C0925
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 10:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3861234DCC3;
	Wed, 27 Aug 2025 10:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="k/fQwBny"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D8434F465
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 10:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756292161; cv=none; b=J7OrXGySX7/EJ2fnanf13MCFaoNLuvcccreWXLqi1U062mNZHs4dv4fiaKMuWT+bPiL792BTiJwnPrZnwZkSf361F4/oZFrwN1yutnWjDjlHr8xG/UspZj3zRRz5e/DdrzVV1A3maMbWUFEjGwRthY0Y06pUVmKwC3z/AA5xY88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756292161; c=relaxed/simple;
	bh=1PtJIWLhL4yQWXU3zlGTNITTKz5VrZgF3PzojoCmc58=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C59J6LB1OEcYmLZ0xI8Lh6rPV+zanfwg/z2QBBtfbNdDSjovpp0tZ1arM9ecNsVjzxDWtvMEbzzp/G/cRMBdmM9Z7Kch5WT0KYE7STEsKVN//wHX6X5+CX+p15JLJ35MGYq5DyWg9uz0AxUewwwuKhFPrcEld7/rk/LITobI/yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=k/fQwBny; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57R6kDxj022886
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 10:55:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=QrIK6tX2IWK
	GLbKUtBQLQ4aPT6fPCczMhEz00/Q0PUw=; b=k/fQwBnyW9PjS0ma6JrGdD3HiC3
	/Oo34XL1IZJWz3FP68nVd8oRghlU8w8+rRi/DxDOmcYKgfHIv4yc1YwP2PL/gWeL
	baOD7rBbumE4Tqaamwlh3g8hobuwZSlwgCApRj8T4fQlI0GxycGCl3Z4q8ZhR4B/
	JlqI0kQw1/nNit5XZYHKsxpHwRHzZs4wlBjcHg2elko/RwajKTm+RSPucxfgpHw3
	gmPFGxxi3EPKl/Ar15kVCdGaIRHM1nHHQGbAM86PLU9bS5XxCb+alHsJfWC/T82x
	UFwDGdl9/zusH2u/H7opQV1Lg8AGRjHG1SxQDe6gU52HnLqpK37i7HomL6A==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5y5m7cr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 10:55:58 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b47630f9aa7so5194646a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 03:55:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756292157; x=1756896957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QrIK6tX2IWKGLbKUtBQLQ4aPT6fPCczMhEz00/Q0PUw=;
        b=KhmIIGBEIruHM/PCBY9IfeHNHSUwEkM27qrcbY34xZVSjJz+W8hsk1uaQXYML3N9gt
         NPD3GQz++RD/E1dIurZyjRFI5dt+zrV3XldWOflceWHQv4tKBgY66gHBOTx+4AKnw1J4
         jwKq5PZVHYFzX3x0KOlmTDxso/ugvSRL6a7zA7vWMIZ7KsLL2Fp7UBMqCkTDKOf9hgV7
         RHMHN4IDoLDELGSrkGFnPr2KsHT57s0PIofmYcPr0RKKMXRcGvfOO/7uGkk9uLegesr3
         Sb3Vw47huHrQ+M0gIu5BffSzzjltfuWsJFwjEvJcvq6pADEHJ6ekifg6phcdAerWVcmo
         E/+g==
X-Forwarded-Encrypted: i=1; AJvYcCWy1zKqjGPy+0d0ufRTVMFFUJSJ889J+drdWVgsoP9KfXVrZLtN5hu3JzB1+zKtGSS463ZEKRPus692X9g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPqWE1CAax8ekZKqzzIEWJodLX78Qt3Nga0zA93ye/xuw4MoHv
	j5H2giKK2TY/0jViIpAxJumYTheZyZNPa7jdGDPhrfCgeMTQXtLCSljmgNDOqqIW1JLebcBWHQS
	+oCVHjP8d3n8GXrSXn0u+ikikRTpnjfCUcr1eOjVU0VQdYMKzk77SSj+s6Hqgnvfjuoc=
X-Gm-Gg: ASbGncsdh65H/b6sd6xYDs7vjlYnv1JVPyftTo4DK2pSxaqp8AEGvvDyvrnY+x+pL5F
	RsRSuMCOu+YHjSqG/4Z4tQkFgKyUp1MeC9K2GANWhqnOOjWqGG8x/eV1J2DD2IXisXu+bl4oUbI
	5r0FOnha7HhZNrrhaqY3iXJTW19EB/W4ypvebyhIf+rNFsikzNahCqFt3+PT5dKt4fEyReotI32
	fNnXBHId7O4O5f7pQdkGdHyDRN4ix95OdXtaZ+hZsF3CouxJ8YrudEQxL7zaaqAJ7X8vI3/EaWk
	XrfR/E/WVcKXdfhv8gKX/5u2wBxprEGe5SBTJUiDbOHBlYlPj6IF8ARa141phOVEsrxRD875EpJ
	AOMZKQSNi+VPm4F6II6vu
X-Received: by 2002:a05:6a20:7345:b0:240:195a:8333 with SMTP id adf61e73a8af0-24340bff9bfmr31909509637.14.1756292157444;
        Wed, 27 Aug 2025 03:55:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyCThp3Fh3qi/ShzD68kw87pJ8DTWN/foHp2PaSMbiSxKV4gSMLtSUTOVTg8XBGz//N7OcSA==
X-Received: by 2002:a05:6a20:7345:b0:240:195a:8333 with SMTP id adf61e73a8af0-24340bff9bfmr31909480637.14.1756292156944;
        Wed, 27 Aug 2025 03:55:56 -0700 (PDT)
Received: from jiegan.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-771f2f2ac7dsm5573035b3a.43.2025.08.27.03.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 03:55:56 -0700 (PDT)
From: Jie Gan <jie.gan@oss.qualcomm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v3 2/3] coresight: tpda: add logic to configure TPDA_SYNCR register
Date: Wed, 27 Aug 2025 18:55:44 +0800
Message-Id: <20250827105545.7140-3-jie.gan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250827105545.7140-1-jie.gan@oss.qualcomm.com>
References: <20250827105545.7140-1-jie.gan@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfXxesnBZCiVee0
 vGfUIYTc2szfVemc7S+yTigWEbMPWLcBytz/tZZB4jIQISu39n6c1AhpjUmd1VhRSVIRLLpwdWE
 fwwfcjRHCekydBy3GSufNdAVlgEosRjicBZQ2PPjtGFP3ht1gPM3dDsRAhxrR1accYn+eyTcC8m
 Xcrt8hxReAGumxHiczGBJSHt6kmC6NmMknJ1kcTmq09jn6DRZooWj+tOEnMCm3pkrIMsKY9pzmp
 ky7gEXwyZpee5cijzRGnIC/Wq6E9nNIS+rhkY4dTr2CKG2FTSFwOIlaDep20/O4nXNrYRAX/uJ6
 aYSUKzhefeeKDFzK2qS7A1BqH3swXmzGrC5T4RLq3HvZa8sYE/1yqq0nuX86Abew+Jq2uZE2Ioi
 flDLuE+v
X-Authority-Analysis: v=2.4 cv=Lco86ifi c=1 sm=1 tr=0 ts=68aee43e cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=6Dbyrv6SX_ztr3m6kfUA:9
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: gwzg21rKzxrKU1t3Iv-ZlIhgO_mCZPMY
X-Proofpoint-ORIG-GUID: gwzg21rKzxrKU1t3Iv-ZlIhgO_mCZPMY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-27_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 malwarescore=0 spamscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230033

From: Tao Zhang <tao.zhang@oss.qualcomm.com>

The TPDA_SYNCR register defines the frequency at which TPDA generates
ASYNC packets, enabling userspace tools to accurately parse each valid
packet.

Signed-off-by: Tao Zhang <tao.zhang@oss.qualcomm.com>
Co-developed-by: Jie Gan <jie.gan@oss.qualcomm.com>
Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
---
 drivers/hwtracing/coresight/coresight-tpda.c | 7 +++++++
 drivers/hwtracing/coresight/coresight-tpda.h | 5 +++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-tpda.c b/drivers/hwtracing/coresight/coresight-tpda.c
index d4d1def5ec15..a1393962b04d 100644
--- a/drivers/hwtracing/coresight/coresight-tpda.c
+++ b/drivers/hwtracing/coresight/coresight-tpda.c
@@ -187,6 +187,13 @@ static void tpda_enable_pre_port(struct tpda_drvdata *drvdata)
 	 */
 	if (drvdata->trig_flag_ts)
 		writel_relaxed(0x0, drvdata->base + TPDA_FPID_CR);
+
+	/* Program the counter value for TPDA_SYNCR */
+	val = readl_relaxed(drvdata->base + TPDA_SYNCR);
+	/* Clear the mode */
+	val &= ~TPDA_SYNCR_MODE_CTRL;
+	val |= TPDA_SYNCR_COUNTER_MASK;
+	writel_relaxed(val, drvdata->base + TPDA_SYNCR);
 }
 
 static int tpda_enable_port(struct tpda_drvdata *drvdata, int port)
diff --git a/drivers/hwtracing/coresight/coresight-tpda.h b/drivers/hwtracing/coresight/coresight-tpda.h
index 0be625fb52fd..0c9bf2fade56 100644
--- a/drivers/hwtracing/coresight/coresight-tpda.h
+++ b/drivers/hwtracing/coresight/coresight-tpda.h
@@ -9,6 +9,7 @@
 #define TPDA_CR			(0x000)
 #define TPDA_Pn_CR(n)		(0x004 + (n * 4))
 #define TPDA_FPID_CR		(0x084)
+#define TPDA_SYNCR		(0x08C)
 
 /* Cross trigger FREQ packets timestamp bit */
 #define TPDA_CR_FREQTS		BIT(2)
@@ -27,6 +28,10 @@
 #define TPDA_Pn_CR_CMBSIZE		GENMASK(7, 6)
 /* Aggregator port DSB data set element size bit */
 #define TPDA_Pn_CR_DSBSIZE		BIT(8)
+/* TPDA_SYNCR mode control bit */
+#define TPDA_SYNCR_MODE_CTRL		BIT(12)
+/* TPDA_SYNCR counter mask */
+#define TPDA_SYNCR_COUNTER_MASK		GENMASK(11, 0)
 
 #define TPDA_MAX_INPORTS	32
 
-- 
2.34.1


