Return-Path: <linux-kernel+bounces-859585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9415DBEE046
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 10:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8D9814E6AEF
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 08:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72907238C15;
	Sun, 19 Oct 2025 08:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jNbM4sh7"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E389922FE11
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 08:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760860942; cv=none; b=MpyZaYgwukUTA/wrh6ySpRD6xEvRngXazGovtPNgIgVxpXJJ4raX2vXgAuVRIPCY5vesk0i0EcQ228aGReXjq1P43wR3Fo8jliWI99c9mvxxJ3+51dj0McKmA4CJpTu9KRk1lvruLGRtn1rrPfC0L0Or2/8aCzo90KJb4H5jU3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760860942; c=relaxed/simple;
	bh=GaGviXQd1BmdQPJXtm3IcR1CGQVbHCroCtuSPzMiyZM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TzTWpbF6t2D+VITfWwPwIDiEeORZ32gHeHB49uF5VPGmVhvoOrVqosgafHxGdU//KpDR7I58x63bk3ezSyRwYo4xqitaDVb960m0OfSIGlOu/t+YvPM9g0DzQJsS9or8e2JNr6XzUZ1Pq9dUx7Ofre//lAZokRZSDTDErnhRZsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jNbM4sh7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59J2On2O030782
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 08:02:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=BwC8FmuoUnU
	oxcHFn7z7n4laBB5CxBLWjXPUGBg9F7s=; b=jNbM4sh7ncRMuYWt7JhkzzLwrqZ
	n7EdPrOBV6R5IrgLpRoMWbLStWIjD0jSzoZYbv3eUXScE4/g69PIcjBQADuukvBt
	SCL3uF90CBPhOHrO10FnXYieiVTV+qFUaoMmepcl93VYClHyo8mTbYPmqND5Xy3y
	AoP0UB5JLyTJXmA2rr2sN0E3abZYjP7gltFxZ/EOSr6xp8F/OBjnEqPv7QFQQ6vv
	sP+esU9H4vVYZutjuzEq0Y/4f9M6y0nGLGDsfyJ88T9C2T0OYIjknA1KQn/E2zhn
	gpwc2/QsbDh82bQgyQ5zp9XNdtvmjpcTjLwuNLy5UtWlIB76Vdnaod3WTuw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v3nf9xpy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 08:02:19 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-87c1d4853ddso125437656d6.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 01:02:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760860938; x=1761465738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BwC8FmuoUnUoxcHFn7z7n4laBB5CxBLWjXPUGBg9F7s=;
        b=dmS32AmJx4+/gEqeJYPB89GhHmPGTaVEGrfcSfbDulyXyfNM3Fi6PKhzTbbc4T2sUl
         72M6ij37W74bExaeVr9biUV3rj9Uf2Ek74MAyjQzOGvfQi99mVho3QJECKRWr26fTkwr
         6jp9ESeYPgxR/3LMN3OI4nPSa56g4/hVGl70XBVzgxJUB9jxzwJ+24N5hZismUKkSYny
         wpAo71HbWb23SfdZI7IDrvW8cHDF1c5vT/wPbSd54OJp8+Uj6tO163wZ7YXo/hlrjYP5
         r/XF6elUPMK1GCMXjPQkVSq7SJzGHCnE1YbgWSmYd+CLN2HfmwIMDpBNpEnHrfMv7FkW
         h9bw==
X-Forwarded-Encrypted: i=1; AJvYcCXe78pN7+pU6BsaKaCAUtw9QHBi6qJ8klPblFdo2ymTLV2FmcV4Ek/pR2QH1UylWboyqoowwKWkPJPx8/U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2M827YUjw3k7OtAvyH069Oew6wvk/6NvWCTjl4/kI8NmOOJYY
	KVdtlLqFdrxU0wq2dK2aZEivOhq1BoPKy1iNRrfbHA0BlIBQLK2vdFLHHy2LkJCK2hMl+OJdr+R
	EZi+82j6l0eKOOVNQSeyLjGsZooEtiMg3ic3Maa42KbQaC+iW3KHN28oDnafDnGjpm1E=
X-Gm-Gg: ASbGncv2/g4tggPcbvdWKW3V4WZTKUCXw5xi1RFfLwrFz1D/RkA6jXK0sXyaVyxNyPJ
	e9Fp3YK1zxAiRM5kD4mZsw4WHFbsKT/39W5oBT5GuR31SaxaqR7gPUMl4lQ7J0z5L+D9ykTYKF0
	GaXf8d061FQKeRjTYqFGs7VQ1FwiW7iq6oeJXrLeSwb3pkyk+A/macaqaHuWK3VIGTWTLcLdcYC
	jcQERJY15syEzNoIkYZG9ulY7UJ91TzjrWe3mQApm3207nPa3R0QcRQ0w3Cijo8fsVqK+78CKbo
	Y7rmzoBKsRSQ9R8BLGp9JcP8AYC4+/u9oOWCKxv3+yUkoYkhz4aB/r4txJSzL8AUyTrfg85jduU
	AY2eLkS7LAKsLMgy2dGPTFm7qdsrpZ5APyMvSZtWOwrKZZpm0sL1HN7TR9xg1tOnLRTAVBY0L/A
	pldQFg1fu8GvQ=
X-Received: by 2002:a05:622a:1105:b0:4e8:bb14:d974 with SMTP id d75a77b69052e-4e8bb14db56mr14028271cf.79.1760860937733;
        Sun, 19 Oct 2025 01:02:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFgROKJadVhIUNVMF01hU3nVkXc/7jxLb8qkxJ3NF/RnkVk/qap4lUw3OWoXvUlCtfMQ2i+Q==
X-Received: by 2002:a05:622a:1105:b0:4e8:bb14:d974 with SMTP id d75a77b69052e-4e8bb14db56mr14027871cf.79.1760860937290;
        Sun, 19 Oct 2025 01:02:17 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-591def1695fsm1353170e87.61.2025.10.19.01.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 01:02:16 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vishnu Reddy <quic_bvisredd@quicinc.com>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Subject: [PATCH 2/2] media: iris: move more common register definitions to the header
Date: Sun, 19 Oct 2025 10:59:02 +0300
Message-ID: <20251019080212.142623-4-dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251019080212.142623-3-dmitry.baryshkov@oss.qualcomm.com>
References: <0251017-knp_video-v2-5-f568ce1a4be3@oss.qualcomm.com>
 <20251019080212.142623-3-dmitry.baryshkov@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: fgsyCzseN9glMmw2i_y2FZv_ZLPK9Mh3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyNyBTYWx0ZWRfXyUFw7a+cLuc8
 E2krbbyi0pn5cZlttloOkRktC4JA9S7Xk/tSABaZFinHIAfos4HXzvSlMz8FfXpKiBaJ9qKd9rm
 csJnHSXdSkguWKMRtiC3BDk3JlwcoS6OTNIFtiuoOq/xE/eZTaQS4BgajIELrUQqL0ucZxM+kOb
 TW/SWoSZewyLZREbAAOj4EaLCPJVC1lyzoDFsVdXR21APa62MBvQj7rj9hdeDWJrKG+xiDJoaBj
 NSCvDtaWuPv/7KvftXc1G6PDTP2k8tyFKUWcWM8MMHXdNSeOQCQXZeiYohrBMduSjFRCtyqtQ5F
 FlugoCVaZ02qJqzIFHSfXZLoeDopq5AnEDODeFlY8QD60fRwkXemvaFLl0KvmQIzpBJL7evCFdO
 H7eRgFQPWRTazyyR1CWLCyrbIK37eg==
X-Proofpoint-GUID: fgsyCzseN9glMmw2i_y2FZv_ZLPK9Mh3
X-Authority-Analysis: v=2.4 cv=EYjFgfmC c=1 sm=1 tr=0 ts=68f49b0b cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=q6RJ1b41Wj0UoLORaoAA:9
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-19_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180027

Simplify adding new platforms by moving common registers definitions
from VPU 3.x and "common" file to the header with other register
defines.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/iris_vpu3x.c |  6 -----
 .../platform/qcom/iris/iris_vpu_common.c      | 20 ----------------
 .../qcom/iris/iris_vpu_register_defines.h     | 23 +++++++++++++++++++
 3 files changed, 23 insertions(+), 26 deletions(-)

diff --git a/drivers/media/platform/qcom/iris/iris_vpu3x.c b/drivers/media/platform/qcom/iris/iris_vpu3x.c
index 0ac6373c33b7..cd53bcda3b3e 100644
--- a/drivers/media/platform/qcom/iris/iris_vpu3x.c
+++ b/drivers/media/platform/qcom/iris/iris_vpu3x.c
@@ -11,12 +11,6 @@
 #include "iris_vpu_common.h"
 #include "iris_vpu_register_defines.h"
 
-#define CORE_CLK_RUN				0x0
-/* VPU v3.5 */
-#define WRAPPER_IRIS_VCODEC_VPU_WRAPPER_SPARE_0	(WRAPPER_BASE_OFFS + 0x78)
-
-#define VIDEO_NOC_RESET_REQ			(BIT(0) | BIT(1))
-
 #define AON_WRAPPER_MVP_NOC_CORE_SW_RESET	(AON_BASE_OFFS + 0x18)
 #define SW_RESET				BIT(0)
 #define AON_WRAPPER_MVP_NOC_CORE_CLK_CONTROL	(AON_BASE_OFFS + 0x20)
diff --git a/drivers/media/platform/qcom/iris/iris_vpu_common.c b/drivers/media/platform/qcom/iris/iris_vpu_common.c
index 4dc7aac78553..2d6548e47d47 100644
--- a/drivers/media/platform/qcom/iris/iris_vpu_common.c
+++ b/drivers/media/platform/qcom/iris/iris_vpu_common.c
@@ -11,10 +11,6 @@
 #include "iris_vpu_common.h"
 #include "iris_vpu_register_defines.h"
 
-#define CPU_IC_BASE_OFFS			(CPU_BASE_OFFS)
-
-#define CPU_CS_A2HSOFTINTCLR			(CPU_CS_BASE_OFFS + 0x1C)
-#define CLEAR_XTENSA2HOST_INTR			BIT(0)
 
 #define CTRL_INIT				(CPU_CS_BASE_OFFS + 0x48)
 #define CTRL_STATUS				(CPU_CS_BASE_OFFS + 0x4C)
@@ -32,22 +28,6 @@
 #define UC_REGION_ADDR				(CPU_CS_BASE_OFFS + 0x64)
 #define UC_REGION_SIZE				(CPU_CS_BASE_OFFS + 0x68)
 
-#define CPU_CS_H2XSOFTINTEN			(CPU_CS_BASE_OFFS + 0x148)
-#define HOST2XTENSA_INTR_ENABLE			BIT(0)
-
-#define CPU_IC_SOFTINT				(CPU_IC_BASE_OFFS + 0x150)
-#define CPU_IC_SOFTINT_H2A_SHFT			0x0
-
-#define WRAPPER_INTR_STATUS			(WRAPPER_BASE_OFFS + 0x0C)
-#define WRAPPER_INTR_STATUS_A2HWD_BMSK		BIT(3)
-#define WRAPPER_INTR_STATUS_A2H_BMSK		BIT(2)
-
-#define WRAPPER_INTR_MASK			(WRAPPER_BASE_OFFS + 0x10)
-#define WRAPPER_INTR_MASK_A2HWD_BMSK		BIT(3)
-#define WRAPPER_INTR_MASK_A2HCPU_BMSK		BIT(2)
-
-#define WRAPPER_TZ_CPU_STATUS			(WRAPPER_TZ_BASE_OFFS + 0x10)
-
 static void iris_vpu_interrupt_init(struct iris_core *core)
 {
 	u32 mask_val;
diff --git a/drivers/media/platform/qcom/iris/iris_vpu_register_defines.h b/drivers/media/platform/qcom/iris/iris_vpu_register_defines.h
index 1c3ff6cab343..72168b9ffa73 100644
--- a/drivers/media/platform/qcom/iris/iris_vpu_register_defines.h
+++ b/drivers/media/platform/qcom/iris/iris_vpu_register_defines.h
@@ -16,10 +16,21 @@
 #define VCODEC_SS_IDLE_STATUSN			(VCODEC_BASE_OFFS + 0x70)
 
 #define AON_WRAPPER_MVP_NOC_RESET_REQ		(AON_MVP_NOC_RESET + 0x000)
+#define VIDEO_NOC_RESET_REQ			(BIT(0) | BIT(1))
 
 #define AON_WRAPPER_MVP_NOC_RESET_ACK		(AON_MVP_NOC_RESET + 0x004)
 
 #define CPU_CS_BASE_OFFS			(CPU_BASE_OFFS)
+#define CPU_IC_BASE_OFFS			(CPU_BASE_OFFS)
+
+#define CPU_CS_A2HSOFTINTCLR			(CPU_CS_BASE_OFFS + 0x1C)
+#define CLEAR_XTENSA2HOST_INTR			BIT(0)
+
+#define CPU_CS_H2XSOFTINTEN			(CPU_CS_BASE_OFFS + 0x148)
+#define HOST2XTENSA_INTR_ENABLE			BIT(0)
+
+#define CPU_IC_SOFTINT				(CPU_IC_BASE_OFFS + 0x150)
+#define CPU_IC_SOFTINT_H2A_SHFT			0x0
 
 #define CPU_CS_AHB_BRIDGE_SYNC_RESET		(CPU_CS_BASE_OFFS + 0x160)
 #define CORE_BRIDGE_SW_RESET			BIT(0)
@@ -29,6 +40,14 @@
 #define MSK_SIGNAL_FROM_TENSILICA		BIT(0)
 #define MSK_CORE_POWER_ON			BIT(1)
 
+#define WRAPPER_INTR_STATUS			(WRAPPER_BASE_OFFS + 0x0C)
+#define WRAPPER_INTR_STATUS_A2HWD_BMSK		BIT(3)
+#define WRAPPER_INTR_STATUS_A2H_BMSK		BIT(2)
+
+#define WRAPPER_INTR_MASK			(WRAPPER_BASE_OFFS + 0x10)
+#define WRAPPER_INTR_MASK_A2HWD_BMSK		BIT(3)
+#define WRAPPER_INTR_MASK_A2HCPU_BMSK		BIT(2)
+
 #define WRAPPER_DEBUG_BRIDGE_LPI_CONTROL	(WRAPPER_BASE_OFFS + 0x54)
 #define WRAPPER_DEBUG_BRIDGE_LPI_STATUS		(WRAPPER_BASE_OFFS + 0x58)
 #define WRAPPER_IRIS_CPU_NOC_LPI_CONTROL	(WRAPPER_BASE_OFFS + 0x5C)
@@ -39,8 +58,12 @@
 #define NOC_LPI_STATUS_DENY			BIT(1) /* Indicates the NOC handshake is denied */
 #define NOC_LPI_STATUS_ACTIVE			BIT(2) /* Indicates the NOC is active */
 
+#define WRAPPER_IRIS_VCODEC_VPU_WRAPPER_SPARE_0	(WRAPPER_BASE_OFFS + 0x78)
 #define WRAPPER_CORE_POWER_STATUS		(WRAPPER_BASE_OFFS + 0x80)
 #define WRAPPER_CORE_CLOCK_CONFIG		(WRAPPER_BASE_OFFS + 0x88)
+#define CORE_CLK_RUN				0x0
+
+#define WRAPPER_TZ_CPU_STATUS			(WRAPPER_TZ_BASE_OFFS + 0x10)
 
 #define WRAPPER_TZ_CTL_AXI_CLOCK_CONFIG		(WRAPPER_TZ_BASE_OFFS + 0x14)
 #define CTL_AXI_CLK_HALT			BIT(0)
-- 
2.47.3


