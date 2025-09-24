Return-Path: <linux-kernel+bounces-831370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 819F4B9C7B0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 01:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3685B4A4431
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 23:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E81296BA5;
	Wed, 24 Sep 2025 23:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cJI+OxJ6"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2602C17A8
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758755776; cv=none; b=Bggy3dVOsbdaFGyPAoSSMVXI4x5EhhhuvfATQi2M+ZdknDFKB3WH6+rpH1SCOnT4DfHubbppXkJ/osTb6/G8I5b3LqGaYeTqB5b607bUkDgXtBsImKjWhlIM1DZmiFRTzaaHqjDZ1d7Zb1cSMHopPBuf9VR7jEQ9vA4VEB/4fBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758755776; c=relaxed/simple;
	bh=tsQgMXRDFCwKV+qNQ1YAoOVRMiqBvD60ZBKD7w2F1ro=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A70Zugn28v84zABRGqjIJsQOWIWJQHO29dpVkuMjweLJw2KlXO+ooCze1h3KyT+oOZlwHkuG1JygTzWVPsnza0N4fPCFotu64Z9TVd054h2aj3EIZskBgWCO8oLWKlvoatDKF7q6G2wevVTW20/aB5TG3qaJQL718BW3xqa67ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cJI+OxJ6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OCf4uS029720
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:16:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tJYvI6Sytt3UmTXqFnCwsgPuZDmrt/rL6kbbwQcYDBI=; b=cJI+OxJ6JG2J6Lxy
	KNbvg373evDQ9X/b/zkRov9eM22qhGlrDhpeBjcUIhC9BrX4r75Ks/pYZSw2vKia
	jdO558grRG7GZmbLGWqi5Wj68x1Kfy1xHKHb8Jlvku2flVwsAtiGC0llvP4DW4KH
	W5GWHMuMGzOBdXYSldrnJcR1LIMIL0HoJnSpw/ltzmUq9G61Vnhhg7cZaEiIQR8l
	NtNI06/RCnAjOyFiDmkT4zBbsWoHQ2iDefrFWVc9CKk3wF0e99K82f72QlC5qHdt
	1RMQ4gO0oTJm1Vde26d4r2a62DEZeM9IhJksnpbbq52Sh8dTMJA9dfye42aHY9Av
	bx5B8w==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499n1fnvm3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:16:12 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-272b7bdf41fso3472235ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 16:16:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758755771; x=1759360571;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tJYvI6Sytt3UmTXqFnCwsgPuZDmrt/rL6kbbwQcYDBI=;
        b=uLuHmRgmWBFh66FuQu9y0BhC38AlMnQDqRL/TJKfoaFv86lrazNctz/P6RU65iW9V7
         UMPs8+VY9LNDJuVG2/tQ+Bx8mqsKqvc/5WMdwj67COmlIowHCfSaVMuvYO5Imd5fA1Wz
         jJ7P/+QksbKHmSV4FsjoJ5zGQkVccW7juag0WgUhk3cLL3uaY0mbDUvlw3ZO0TeeskLq
         XpGzqh1i556MetqxDkk9hVlx++vZlEeu+p7+El2rTkopeK8UANwTvLuhlGV2h7HS6Vv4
         qDqXJJ4feaQw5GPMHaJF/ynKpy9kNgtb9naik3bHoQbVvXQBoyzLmnLtJ0JetvjNKZVX
         5tqg==
X-Forwarded-Encrypted: i=1; AJvYcCXkBderNaxcbk+3K5U7xNOIFIQXopVMEkFr5DZ3IcXkXYtO6SWT/drCoPemmm1Dl7APcS/zDtMd31DJlTU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV5cVc4XC+PRWQXwpXEB90seoyVHgzN1nUXNVie8mWZObyCAv+
	+iBvvIoTNoeSNbMqokkmumQld0TIAp6CIGb80mI6h7wfbwWipCUPjxJa5c9A7Xuoy5E7tlfqkPY
	nuqXuUxhtAfXZRUWibO4pjgirQt9xAu1Ro1HKVXolUOTCvjceXK8PoxAmLCOwUJcwZUY=
X-Gm-Gg: ASbGnctNd7aSWYlkQeKW1ZKU99EOvKiTKfB23TYJ4ScM6xDAcPk2IcRz4jzpkjUFc+q
	CorssQqQw58gO5q5vFmWvwgZ5jjScN/31L3RugmVV2My3Jk1MvIeAe+/TKmd82kVQprDw1DXg+H
	vjDaiUEGDPCf39Ul7UuBN9mQw/O1o+C8YlGHeT+Xtwx3eimySr42Vuubu69022N8VwP3YGLtZ3v
	Zuuz+4pRZed03NyXdGgZkQ62wGamEGR77yoUlhMi1IGzijnjFNqlGAbSTLQEOoRqxmrO1wnFYxl
	kn+1gesrgNSTPdkOM8Vd5trGxBeFZM92mFFz03/JsKrj2rUXkq73kHLhu+au5Y9lnEHMwcq0fTg
	=
X-Received: by 2002:a17:903:3d0e:b0:271:5bde:697e with SMTP id d9443c01a7336-27ed49b9e58mr14060305ad.3.1758755771397;
        Wed, 24 Sep 2025 16:16:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0b4ciAWhXiasmT/T4BHeukw++1jruMeSMdNFxI21byjyWCzxPJjHLYLMf229mI9nNuTJd/w==
X-Received: by 2002:a17:903:3d0e:b0:271:5bde:697e with SMTP id d9443c01a7336-27ed49b9e58mr14060125ad.3.1758755770945;
        Wed, 24 Sep 2025 16:16:10 -0700 (PDT)
Received: from hu-vgarodia-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed671c156sm3964175ad.50.2025.09.24.16.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 16:16:10 -0700 (PDT)
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 04:44:43 +0530
Subject: [PATCH 5/8] media: iris: Move vpu register defines to common
 header file
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-knp_video-v1-5-e323c0b3c0cd@oss.qualcomm.com>
References: <20250925-knp_video-v1-0-e323c0b3c0cd@oss.qualcomm.com>
In-Reply-To: <20250925-knp_video-v1-0-e323c0b3c0cd@oss.qualcomm.com>
To: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vishnu Reddy <quic_bvisredd@quicinc.com>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758755747; l=7248;
 i=vikash.garodia@oss.qualcomm.com; s=20241104; h=from:subject:message-id;
 bh=tsQgMXRDFCwKV+qNQ1YAoOVRMiqBvD60ZBKD7w2F1ro=;
 b=W5Fu2ojome2I3hJdrCqa06ZJTMpNA8IlgzmbhEAHkqWw6pBvKyhBXCmBDr2bEabCt3gvctcVr
 Z0cjRlMT19nDwwS4fz8+7Ox6mpDiP8QiyL7qo68DDEQKQSK2YJDJuBb
X-Developer-Key: i=vikash.garodia@oss.qualcomm.com; a=ed25519;
 pk=LY9Eqp4KiHWxzGNKGHbwRFEJOfRCSzG/rxQNmvZvaKE=
X-Proofpoint-ORIG-GUID: 1wpLLane9s8CHQ3x8zwdtM0837kWf334
X-Proofpoint-GUID: 1wpLLane9s8CHQ3x8zwdtM0837kWf334
X-Authority-Analysis: v=2.4 cv=No/Rc9dJ c=1 sm=1 tr=0 ts=68d47bbc cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=jbzpjpOmXXXxM5nbaMUA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAzNyBTYWx0ZWRfX4bHBs4tCvoR7
 y5UaLA4XjYNbHFCo411XvjaIcClAiKR0JOmS6Bi1jWNfpXve1O4MKal3t+1V5o8zY0y2OcE0atd
 +//ioEeHK076lMSLaENsPiq8JBpGb2BYtfN5AgjBfOkpW8/xo4gifaME8cLlXNEQWA12pOWF2BO
 TblI8z+LlFldi2FZHPcXQpVU3xlYkV/uQi6k++4iKzmr2H936VaFtE528oWempH9NB9ucE1AH45
 zVuInU9Efpor8Gf/9nsR03MHUeZHdC0gxZLpAmeEqE4cTM/bmmY8QXDrWqDA6opCP1tUEeVbtP7
 UbWlx6jiia6h5zIujeeFKPPdefckM1M+zAhtt9W3S2RX1z3vWPXfj4cO1BWRfivaHix7hx2p/eL
 9fWkeDFp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 suspectscore=0 adultscore=0 malwarescore=0
 phishscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200037

Some of vpu4 register defines are common with vpu3x. Move those into the
common register defines header. This is done to reuse the defines for
vpu4 in subsequent patch which enables the power sequence for vpu4.

Co-developed-by: Vishnu Reddy <quic_bvisredd@quicinc.com>
Signed-off-by: Vishnu Reddy <quic_bvisredd@quicinc.com>
Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/iris_vpu3x.c      | 36 ----------------------
 drivers/media/platform/qcom/iris/iris_vpu_common.c | 23 --------------
 .../platform/qcom/iris/iris_vpu_register_defines.h | 29 +++++++++++++++++
 3 files changed, 29 insertions(+), 59 deletions(-)

diff --git a/drivers/media/platform/qcom/iris/iris_vpu3x.c b/drivers/media/platform/qcom/iris/iris_vpu3x.c
index 339776a0b4672e246848c3a6a260eb83c7da6a60..0ac6373c33b7ced75ac94ac86a1a8fc303f28b5d 100644
--- a/drivers/media/platform/qcom/iris/iris_vpu3x.c
+++ b/drivers/media/platform/qcom/iris/iris_vpu3x.c
@@ -11,48 +11,12 @@
 #include "iris_vpu_common.h"
 #include "iris_vpu_register_defines.h"
 
-#define WRAPPER_TZ_BASE_OFFS			0x000C0000
-#define AON_BASE_OFFS				0x000E0000
-#define AON_MVP_NOC_RESET			0x0001F000
-
-#define WRAPPER_DEBUG_BRIDGE_LPI_CONTROL	(WRAPPER_BASE_OFFS + 0x54)
-#define WRAPPER_DEBUG_BRIDGE_LPI_STATUS		(WRAPPER_BASE_OFFS + 0x58)
-#define WRAPPER_IRIS_CPU_NOC_LPI_CONTROL	(WRAPPER_BASE_OFFS + 0x5C)
-#define REQ_POWER_DOWN_PREP			BIT(0)
-#define WRAPPER_IRIS_CPU_NOC_LPI_STATUS		(WRAPPER_BASE_OFFS + 0x60)
-#define NOC_LPI_STATUS_DONE			BIT(0) /* Indicates the NOC handshake is complete */
-#define NOC_LPI_STATUS_DENY			BIT(1) /* Indicates the NOC handshake is denied */
-#define NOC_LPI_STATUS_ACTIVE		BIT(2) /* Indicates the NOC is active */
-#define WRAPPER_CORE_CLOCK_CONFIG		(WRAPPER_BASE_OFFS + 0x88)
 #define CORE_CLK_RUN				0x0
 /* VPU v3.5 */
 #define WRAPPER_IRIS_VCODEC_VPU_WRAPPER_SPARE_0	(WRAPPER_BASE_OFFS + 0x78)
 
-#define WRAPPER_TZ_CTL_AXI_CLOCK_CONFIG		(WRAPPER_TZ_BASE_OFFS + 0x14)
-#define CTL_AXI_CLK_HALT			BIT(0)
-#define CTL_CLK_HALT				BIT(1)
-
-#define WRAPPER_TZ_QNS4PDXFIFO_RESET		(WRAPPER_TZ_BASE_OFFS + 0x18)
-#define RESET_HIGH				BIT(0)
-
-#define CPU_CS_AHB_BRIDGE_SYNC_RESET		(CPU_CS_BASE_OFFS + 0x160)
-#define CORE_BRIDGE_SW_RESET			BIT(0)
-#define CORE_BRIDGE_HW_RESET_DISABLE		BIT(1)
-
-#define CPU_CS_X2RPMH				(CPU_CS_BASE_OFFS + 0x168)
-#define MSK_SIGNAL_FROM_TENSILICA		BIT(0)
-#define MSK_CORE_POWER_ON			BIT(1)
-
-#define AON_WRAPPER_MVP_NOC_RESET_REQ		(AON_MVP_NOC_RESET + 0x000)
 #define VIDEO_NOC_RESET_REQ			(BIT(0) | BIT(1))
 
-#define AON_WRAPPER_MVP_NOC_RESET_ACK		(AON_MVP_NOC_RESET + 0x004)
-
-#define VCODEC_SS_IDLE_STATUSN			(VCODEC_BASE_OFFS + 0x70)
-
-#define AON_WRAPPER_MVP_NOC_LPI_CONTROL		(AON_BASE_OFFS)
-#define AON_WRAPPER_MVP_NOC_LPI_STATUS		(AON_BASE_OFFS + 0x4)
-
 #define AON_WRAPPER_MVP_NOC_CORE_SW_RESET	(AON_BASE_OFFS + 0x18)
 #define SW_RESET				BIT(0)
 #define AON_WRAPPER_MVP_NOC_CORE_CLK_CONTROL	(AON_BASE_OFFS + 0x20)
diff --git a/drivers/media/platform/qcom/iris/iris_vpu_common.c b/drivers/media/platform/qcom/iris/iris_vpu_common.c
index bbd999a41236dca5cf5700e452a6fed69f4fc922..a7b1fb8173e02d22e6f2af4ea170738c6408f65b 100644
--- a/drivers/media/platform/qcom/iris/iris_vpu_common.c
+++ b/drivers/media/platform/qcom/iris/iris_vpu_common.c
@@ -11,9 +11,6 @@
 #include "iris_vpu_common.h"
 #include "iris_vpu_register_defines.h"
 
-#define WRAPPER_TZ_BASE_OFFS			0x000C0000
-#define AON_BASE_OFFS				0x000E0000
-
 #define CPU_IC_BASE_OFFS			(CPU_BASE_OFFS)
 
 #define CPU_CS_A2HSOFTINTCLR			(CPU_CS_BASE_OFFS + 0x1C)
@@ -38,10 +35,6 @@
 #define CPU_CS_H2XSOFTINTEN			(CPU_CS_BASE_OFFS + 0x148)
 #define HOST2XTENSA_INTR_ENABLE			BIT(0)
 
-#define CPU_CS_X2RPMH				(CPU_CS_BASE_OFFS + 0x168)
-#define MSK_SIGNAL_FROM_TENSILICA		BIT(0)
-#define MSK_CORE_POWER_ON			BIT(1)
-
 #define CPU_IC_SOFTINT				(CPU_IC_BASE_OFFS + 0x150)
 #define CPU_IC_SOFTINT_H2A_SHFT			0x0
 
@@ -53,23 +46,7 @@
 #define WRAPPER_INTR_MASK_A2HWD_BMSK		BIT(3)
 #define WRAPPER_INTR_MASK_A2HCPU_BMSK		BIT(2)
 
-#define WRAPPER_DEBUG_BRIDGE_LPI_CONTROL	(WRAPPER_BASE_OFFS + 0x54)
-#define WRAPPER_DEBUG_BRIDGE_LPI_STATUS		(WRAPPER_BASE_OFFS + 0x58)
-#define WRAPPER_IRIS_CPU_NOC_LPI_CONTROL	(WRAPPER_BASE_OFFS + 0x5C)
-#define WRAPPER_IRIS_CPU_NOC_LPI_STATUS		(WRAPPER_BASE_OFFS + 0x60)
-
 #define WRAPPER_TZ_CPU_STATUS			(WRAPPER_TZ_BASE_OFFS + 0x10)
-#define WRAPPER_TZ_CTL_AXI_CLOCK_CONFIG		(WRAPPER_TZ_BASE_OFFS + 0x14)
-#define CTL_AXI_CLK_HALT			BIT(0)
-#define CTL_CLK_HALT				BIT(1)
-
-#define WRAPPER_TZ_QNS4PDXFIFO_RESET		(WRAPPER_TZ_BASE_OFFS + 0x18)
-#define RESET_HIGH				BIT(0)
-
-#define AON_WRAPPER_MVP_NOC_LPI_CONTROL		(AON_BASE_OFFS)
-#define REQ_POWER_DOWN_PREP			BIT(0)
-
-#define AON_WRAPPER_MVP_NOC_LPI_STATUS		(AON_BASE_OFFS + 0x4)
 
 static void iris_vpu_interrupt_init(struct iris_core *core)
 {
diff --git a/drivers/media/platform/qcom/iris/iris_vpu_register_defines.h b/drivers/media/platform/qcom/iris/iris_vpu_register_defines.h
index fe8a39e5e5a3fc68dc3a706ffdba07a5558163cf..6474f561c8dc29d1975bb44792595d86f16b6cff 100644
--- a/drivers/media/platform/qcom/iris/iris_vpu_register_defines.h
+++ b/drivers/media/platform/qcom/iris/iris_vpu_register_defines.h
@@ -9,9 +9,38 @@
 #define VCODEC_BASE_OFFS			0x00000000
 #define CPU_BASE_OFFS				0x000A0000
 #define WRAPPER_BASE_OFFS			0x000B0000
+#define AON_BASE_OFFS				0x000E0000
+#define WRAPPER_TZ_BASE_OFFS			0x000C0000
+#define AON_MVP_NOC_RESET			0x0001F000
 
 #define CPU_CS_BASE_OFFS			(CPU_BASE_OFFS)
 
 #define WRAPPER_CORE_POWER_STATUS		(WRAPPER_BASE_OFFS + 0x80)
+#define WRAPPER_CORE_CLOCK_CONFIG		(WRAPPER_BASE_OFFS + 0x88)
+#define AON_WRAPPER_MVP_NOC_LPI_CONTROL		(AON_BASE_OFFS)
+#define WRAPPER_DEBUG_BRIDGE_LPI_CONTROL	(WRAPPER_BASE_OFFS + 0x54)
+#define WRAPPER_DEBUG_BRIDGE_LPI_STATUS		(WRAPPER_BASE_OFFS + 0x58)
+#define WRAPPER_IRIS_CPU_NOC_LPI_CONTROL	(WRAPPER_BASE_OFFS + 0x5C)
+#define WRAPPER_IRIS_CPU_NOC_LPI_STATUS		(WRAPPER_BASE_OFFS + 0x60)
+#define WRAPPER_TZ_CTL_AXI_CLOCK_CONFIG		(WRAPPER_TZ_BASE_OFFS + 0x14)
+#define CPU_CS_AHB_BRIDGE_SYNC_RESET		(CPU_CS_BASE_OFFS + 0x160)
+#define CPU_CS_X2RPMH				(CPU_CS_BASE_OFFS + 0x168)
+#define AON_WRAPPER_MVP_NOC_RESET_REQ		(AON_MVP_NOC_RESET + 0x000)
+#define AON_WRAPPER_MVP_NOC_RESET_ACK		(AON_MVP_NOC_RESET + 0x004)
+#define VCODEC_SS_IDLE_STATUSN			(VCODEC_BASE_OFFS + 0x70)
+#define AON_WRAPPER_MVP_NOC_LPI_STATUS		(AON_BASE_OFFS + 0x4)
+#define WRAPPER_TZ_QNS4PDXFIFO_RESET		(WRAPPER_TZ_BASE_OFFS + 0x18)
+
+#define CORE_BRIDGE_SW_RESET			BIT(0)
+#define CORE_BRIDGE_HW_RESET_DISABLE		BIT(1)
+#define MSK_SIGNAL_FROM_TENSILICA		BIT(0)
+#define MSK_CORE_POWER_ON			BIT(1)
+#define CTL_AXI_CLK_HALT			BIT(0)
+#define CTL_CLK_HALT				BIT(1)
+#define REQ_POWER_DOWN_PREP			BIT(0)
+#define RESET_HIGH				BIT(0)
+#define NOC_LPI_STATUS_DONE			BIT(0) /* Indicates the NOC handshake is complete */
+#define NOC_LPI_STATUS_DENY			BIT(1) /* Indicates the NOC handshake is denied */
+#define NOC_LPI_STATUS_ACTIVE			BIT(2) /* Indicates the NOC is active */
 
 #endif

-- 
2.34.1


