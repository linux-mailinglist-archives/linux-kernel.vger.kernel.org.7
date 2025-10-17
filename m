Return-Path: <linux-kernel+bounces-858157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D2DBE929C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91F5D6E30BC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 14:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7967A393DFD;
	Fri, 17 Oct 2025 14:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bXntRByV"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A29236435
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 14:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760710655; cv=none; b=OwSnToryR1V20nmoBubu+dmelSbueE1liMBHi5rsa0igULhox8w+y2ezJ07wqzUOJV7MylgRvb/fF8T5NgJ14VW0NSuEj/ulC21IuS8k5FR/XwZP90zmDsmXSNQ39cXsTlcb+HPJN87+x7D+nxZbQiNI8CI5XhuOm7dBHBXJW7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760710655; c=relaxed/simple;
	bh=pBrsDZpLfL2DuOuLyCbchUHfirFeA+d/Ce9BNWCP3jM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p4w916HfVu7uK74FipCloEaxYIxvcfNDAXKs/GrUBrcPCaWOmWiQ1z3I6OdlozjGLnNxQsfC6R8WglKUGJDzGTKngt7J4/9GL4jH2tdAHw7hRJ99x5ScjO8Zp7kDqFCBtsHiByURBRRY6qOluStusvmjnnFjix9CT8SW9Ed05nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bXntRByV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59H8HZB7001756
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 14:17:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gq+CWg2ZAfiAxiT7FSp+YhSs1Q22gW+tEiLpgbOOJTk=; b=bXntRByV5Y602KlH
	xenneFlDl4ikbNiGGtSX0+Gc0GRUOVm7o83csk5RBOY41moOBJ0UCeZKZ8+S3EW/
	g5LLk/DDe2MdYS4LkitAoeRQTEoVAkkzjjBBFjXND9aO3wHmPiWHuhf7WDaKnkyw
	kyRfdA3K8nKeOcscse0WIqgK5CX/2M1Nf13MrQ0PZA923mb0FzqPxvnipuj1MuZc
	lGmoIwynFFGftksVnFgi2ztmmjTMb4Z6gwItqLfDm0mQSrNHpcjBhRZ0jQMQ8lLJ
	fEdEOTpkq2rO3cnhlMrKAaIMyne0WQdIwLBWpF+/vVDN0gPtVh+wJw3mF50BjfX6
	ls9w8w==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfd9chss-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 14:17:32 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-78106e63bc9so2270278b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 07:17:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760710652; x=1761315452;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gq+CWg2ZAfiAxiT7FSp+YhSs1Q22gW+tEiLpgbOOJTk=;
        b=LYLmiZ+p3FvczOvlYF7DIpGT6dkvKpVZ33TcLXnG3gliYw9FsZp7AnTTqocMtMPoSw
         JUjC7rpmAo/n8XeH/a7Rwm22qxbu3hjW2MHG4fQV7nqem6KWGhLOpiDFyvqZpdTTh5XP
         lExD7JBu25XU+rQnSH9zOgUlkKFkQGpW9JBFj28iElb7rBg9bxyaH/QXFTbIdL2Fh/DU
         z2bZfuuau71kVGhg1HSqBNlmvsN+D0lt/sOSnT2BlkAMDK/meKfCasuF0XQT5QaoVOBW
         JvFrcOhKCBu7g2agD2Kmb0x30ApIQtRarx5DM0w1KAt0N352RvnVP1z+gS9pznDYWfyK
         z1Zw==
X-Forwarded-Encrypted: i=1; AJvYcCUY0eGfbSgymSthX3okPUHesbvPF4jHjT6n4F5N2ITsTHAMpW70ucl/frMGjREPb8dRIGNc9lVHr6aIzRc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMfRPJtpJfT+OjDqj+7B04SNfUNJmcWW5jIw7OZzUv4Y+qS7ob
	5zlzV/LLnukRziysgM0+0iHt7MADh9wPuTbuB0T3ewAF/gbFHdT5V/pOcfS27/+3qU+Yo/OsEOh
	e6QqiRk1zpjfefko9NfOD/vrQkyTJFQrU21RkzxqpoSKi7vc22YBuRSiK5CZRrDNBIFE=
X-Gm-Gg: ASbGncuek46r2gP6Kvp/pVraZR+s2ERBd/VD2GViamDkQJOWt66O3vTAx/UH3u1wDrH
	HbeXG6dGFR7e0QxOE2FJ9lADmGMR5vD1Pmqd2Omyx4Ec12gB1eKBGFqFXLio452CrBXlb/fYyXv
	2yvl7FkU7qBFXK976jnwj1bde+FUcG3LlBayLSFOyfXRDvulNg/m4Ei04dHKU84pVsEfWf60LK3
	uD+pLc/ybUuvDhxsdhF82L+J7IMd9qIQ8v9SDGGcOA1b2JncDF2YIs8O+Y96XT8wD3l0XLo8FOt
	olHfAHb+B/6xBh9IgCczcKyKT8tDQhCkrewzTDgSAb+sKyj/ovaXZm/6KBo60kMESSwpKIDVNyv
	yqeTpnFqGOgg/pbhG5JyNzIl/klim5M2LsA==
X-Received: by 2002:a05:6a00:9501:b0:783:7de9:d3c5 with SMTP id d2e1a72fcca58-7a220d377d9mr4913414b3a.29.1760710651643;
        Fri, 17 Oct 2025 07:17:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEso39skOdGnHnIdhnxRSYveSiPHXARNShqQv5LqtIDC99FC4CfH49L1jFLwA6JO2/fdGHrg==
X-Received: by 2002:a05:6a00:9501:b0:783:7de9:d3c5 with SMTP id d2e1a72fcca58-7a220d377d9mr4913366b3a.29.1760710651146;
        Fri, 17 Oct 2025 07:17:31 -0700 (PDT)
Received: from hu-vgarodia-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d0966d7sm25895826b3a.40.2025.10.17.07.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 07:17:30 -0700 (PDT)
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Date: Fri, 17 Oct 2025 19:46:26 +0530
Subject: [PATCH v2 5/8] media: iris: Move vpu register defines to common
 header file
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-knp_video-v2-5-f568ce1a4be3@oss.qualcomm.com>
References: <20251017-knp_video-v2-0-f568ce1a4be3@oss.qualcomm.com>
In-Reply-To: <20251017-knp_video-v2-0-f568ce1a4be3@oss.qualcomm.com>
To: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vishnu Reddy <quic_bvisredd@quicinc.com>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760710621; l=7259;
 i=vikash.garodia@oss.qualcomm.com; s=20241104; h=from:subject:message-id;
 bh=pBrsDZpLfL2DuOuLyCbchUHfirFeA+d/Ce9BNWCP3jM=;
 b=AzUJ1y/C5COJb4mjwvfT40x9nZGReqDaRJqKTGjuCniFToydUWcs+6EZao0os4P95RDydmIuh
 azgEGW4NUdQDg3GumwF/075X78wGlxwDJ8Ter1DdeQR7+8aI0A74px3
X-Developer-Key: i=vikash.garodia@oss.qualcomm.com; a=ed25519;
 pk=LY9Eqp4KiHWxzGNKGHbwRFEJOfRCSzG/rxQNmvZvaKE=
X-Proofpoint-ORIG-GUID: dbbIvEDBrRu39eNiowpfzDAZMmaV-bSf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX8kowabJt89wH
 ET71RdcJvu8IZMTatsSo9P1aghA4+zEnOXv7iLi0HexeboG0mzqqFNMVp6ryOmfdOYqF8lx5hcT
 chYXq3msHBq92NUyBOzeOPihPahz2SB9MVc2K2WJGKuLjtCQK7Jsg7Y4SV45gXlRhoFHgs0AG1y
 ZGQBExCvpYoQ3usEAc0PAcGh+79q6zuS8wyMSGdv8rmyx+Kw/zTxbadCLn1PI9Ohb+tkYetx4SK
 DlMuG7Kmn7wRX1dHpASadg4some++scRlF3tA9bDAPZ5NIA9oKIVVNIJr7HZcWiZJq5/rGy7i3E
 gZhnKcXCoWOH5V0v1c8jezqsCsDZiZE+YzWkUJ71UDLGxiIYMFPCGUqmsUE9PaBS3Etyxj/yK5t
 Mv2DdF8YyjYtsCLCi5J3LCjkXiR5pg==
X-Proofpoint-GUID: dbbIvEDBrRu39eNiowpfzDAZMmaV-bSf
X-Authority-Analysis: v=2.4 cv=PdTyRyhd c=1 sm=1 tr=0 ts=68f24ffc cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=jbzpjpOmXXXxM5nbaMUA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018

Some of vpu4 register defines are common with vpu3x. Move those into the
common register defines header. This is done to reuse the defines for
vpu4 in subsequent patch which enables the power sequence for vpu4.

Co-developed-by: Vishnu Reddy <quic_bvisredd@quicinc.com>
Signed-off-by: Vishnu Reddy <quic_bvisredd@quicinc.com>
Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/iris_vpu3x.c      | 36 ----------------------
 drivers/media/platform/qcom/iris/iris_vpu_common.c | 23 --------------
 .../platform/qcom/iris/iris_vpu_register_defines.h | 32 +++++++++++++++++++
 3 files changed, 32 insertions(+), 59 deletions(-)

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
index fe8a39e5e5a3fc68dc3a706ffdba07a5558163cf..bfe7ecceda894f6464970f9db2578c92dcb6c1ad 100644
--- a/drivers/media/platform/qcom/iris/iris_vpu_register_defines.h
+++ b/drivers/media/platform/qcom/iris/iris_vpu_register_defines.h
@@ -9,9 +9,41 @@
 #define VCODEC_BASE_OFFS			0x00000000
 #define CPU_BASE_OFFS				0x000A0000
 #define WRAPPER_BASE_OFFS			0x000B0000
+#define AON_BASE_OFFS				0x000E0000
+#define AON_MVP_NOC_RESET			0x0001F000
+#define WRAPPER_TZ_BASE_OFFS			0x000C0000
+
+#define AON_WRAPPER_MVP_NOC_LPI_CONTROL		(AON_BASE_OFFS)
+#define AON_WRAPPER_MVP_NOC_LPI_STATUS		(AON_BASE_OFFS + 0x4)
+#define AON_WRAPPER_MVP_NOC_RESET_REQ		(AON_MVP_NOC_RESET + 0x000)
+#define AON_WRAPPER_MVP_NOC_RESET_ACK		(AON_MVP_NOC_RESET + 0x004)
 
 #define CPU_CS_BASE_OFFS			(CPU_BASE_OFFS)
+#define CPU_CS_AHB_BRIDGE_SYNC_RESET		(CPU_CS_BASE_OFFS + 0x160)
+#define CPU_CS_X2RPMH				(CPU_CS_BASE_OFFS + 0x168)
+
+#define VCODEC_SS_IDLE_STATUSN			(VCODEC_BASE_OFFS + 0x70)
 
+#define WRAPPER_TZ_CTL_AXI_CLOCK_CONFIG		(WRAPPER_TZ_BASE_OFFS + 0x14)
+#define WRAPPER_TZ_QNS4PDXFIFO_RESET		(WRAPPER_TZ_BASE_OFFS + 0x18)
+
+#define WRAPPER_DEBUG_BRIDGE_LPI_CONTROL	(WRAPPER_BASE_OFFS + 0x54)
+#define WRAPPER_DEBUG_BRIDGE_LPI_STATUS		(WRAPPER_BASE_OFFS + 0x58)
+#define WRAPPER_IRIS_CPU_NOC_LPI_CONTROL	(WRAPPER_BASE_OFFS + 0x5C)
+#define WRAPPER_IRIS_CPU_NOC_LPI_STATUS		(WRAPPER_BASE_OFFS + 0x60)
 #define WRAPPER_CORE_POWER_STATUS		(WRAPPER_BASE_OFFS + 0x80)
+#define WRAPPER_CORE_CLOCK_CONFIG		(WRAPPER_BASE_OFFS + 0x88)
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


