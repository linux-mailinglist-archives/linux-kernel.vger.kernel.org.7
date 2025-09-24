Return-Path: <linux-kernel+bounces-831372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 732E4B9C7C8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 01:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 372DB174653
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 23:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085A429D29E;
	Wed, 24 Sep 2025 23:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="khff/Shm"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473B52D24B0
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758755781; cv=none; b=Hp5JXmY4hAtHbk7LzBeVOT2IBmfHKa7Qtz5ZmJSRoIAoS68wdDTbaNjvmMJjbZx8+aUIz5XsmgH7nG8HXCupQze4QPkz+xFVD+jT2CFlSmVNLNcRKy3YIj83JyUG1HlzFfg4a2VkfB5fF48hd1RMMwLKijLPRIAniA2GTnyueGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758755781; c=relaxed/simple;
	bh=XwjJpuMOMq7BISJ4RPudOTebpQlxQfmd6veQP0wZOgg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RSDLuoG8joYyQKueMyUzO1EuJUQVKxVUpbQ/3VPV9Z8ghxb02qaUDGb2/qANKmnIEhwfp6OxTBcjmmlSXQMFcK5MabsgAyXaGb2wE7tGw5+stQvehusYggUT5DF9u0f7lrexOCwc5cWovuEjE/wyIYdYMH9HXbNPWRKLX8xHdhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=khff/Shm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OD85KH027760
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:16:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dbK0nLOoJgC562Sre9RiWxXhq9DvCscrdLVA2y+RRqA=; b=khff/ShmExBMYWnY
	xIVqfTZ0ZytwaOZT6LVaNkLJVR+dWh68va1YtCLJbu0QRp7mXsXkBkKVIc0ZQmhl
	ycbFsKU9IwqZa7Z7MbXtRZflPfGrAxWVTO2DLmnHCxHKt8E03JWWE3wgQxDwWOCP
	wb+i6X443CihWVDJyuulJyLiF3G46K6bqJn0bs9DYReyebpoipV8sTG6LlI7fe9X
	08E48oV+pR1X3H3TJsUfB2sQNXsZA5ZxWcyIo029WbkANswwamyehDoAqbi6ZdZP
	2soYD3Q2Ia8TYF/ORK0A5vEEFMi0sqpyR0GNyKmw6P7JSxeKbyBdpkUMdfGNF1bt
	2E/fOw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499hmnxbjd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:16:16 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-25bdf8126ceso4816615ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 16:16:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758755776; x=1759360576;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dbK0nLOoJgC562Sre9RiWxXhq9DvCscrdLVA2y+RRqA=;
        b=ZTfEV+yeTFxM5yv6s0tUVEZ9UjK7MBF4+188XZbL7Nk/dMMW1O9wm13CkMHhGGdSpQ
         k647uo6zaPCGbI6UKoiQ0vp7v6nCwcMbM9vQGJ3rbVfS3D4ZhNBiayl8qqIF+iC90Ukf
         JXSwpqldqSz61BLabDy5SCGpAnSTJuFv/VSo5bojYmbVImFZTv9Z10oWR+8g3O7dAaVO
         aYvPuQrtcsJixkhrqmYKY47FIrHkxWjM5eaSAvmbXe8xjjjbAkfB6jegE9bIwZnBcTts
         0Y5Ajxmivtd4eXkHjOMFaW76kUerxR7x9pnEzL1m7AWFqJ7pW1iiTHKIuwQU3L2LVUq2
         sSSw==
X-Forwarded-Encrypted: i=1; AJvYcCX0otkjrz9CSbwxgJlTghAUvh4fuiCE/akYL0zHVZZQmRGCEVUMmC+0hZwadQQMTYnzyBUI8D0EP0pLy1A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbatqTihonVK/UrL6esT/FQSp5x3B0LkiRIAMDhnyNWebb4Omt
	lk7WwCAkPkaSVzDFhJmHUXRNmSs6oCUWbfii16xabkSxZ4srHu2AoaYjOB3XhKxecBVRTVImg++
	j+cfmYfqBQCDd59M+BpCf/wlaMlzs/GP+zYHFD8y7mDt0xYLqt+5cliE4nrmM/QvtYsY=
X-Gm-Gg: ASbGncstzHrV6Fn0r4w5eCklQAyAfcmaUb6uyc/WiJdUn1x8KOu+pfXPyh/SpoRdL50
	ShEghImq7Cv//c/kcOlFHC/m6p8BRbbMDbIBMQTOKWVNjSZi5C1q/3QUCsqEwsY624SV2TZ7lIy
	pBC6Go4ADp3Bdhw0/7+xpcyYMsmeuIx8or7cFzK66T151uUhl+ktSuydLgsYgbpYSJ06N7oWvha
	nsaGh8rISCm86Ro5eIwoe9+EJdwKC92OZ0H7V8dPEpRDCi+ZVxrjAcnNiCOOchAjCdBn5j2B0ln
	ofx2CrCrCjw4k+6vtUILb5cgX57mfCJVHbWrVY1l6719DZ/EKtrLa/O90QwitwSRNtJY8kZjzFI
	=
X-Received: by 2002:a17:902:e806:b0:267:e097:7a9c with SMTP id d9443c01a7336-27ed4a5ec6dmr11996565ad.53.1758755775485;
        Wed, 24 Sep 2025 16:16:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEspf9bWDL3/QSHrdIwndVRfADOgG8bMSPMELvLNd+5MIS8VU3fMe2eoZF0lZ5mcH2efMAybg==
X-Received: by 2002:a17:902:e806:b0:267:e097:7a9c with SMTP id d9443c01a7336-27ed4a5ec6dmr11996345ad.53.1758755774912;
        Wed, 24 Sep 2025 16:16:14 -0700 (PDT)
Received: from hu-vgarodia-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed671c156sm3964175ad.50.2025.09.24.16.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 16:16:14 -0700 (PDT)
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 04:44:44 +0530
Subject: [PATCH 6/8] media: iris: Move vpu35 specific api to common to use
 for vpu4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-knp_video-v1-6-e323c0b3c0cd@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758755747; l=14083;
 i=vikash.garodia@oss.qualcomm.com; s=20241104; h=from:subject:message-id;
 bh=XwjJpuMOMq7BISJ4RPudOTebpQlxQfmd6veQP0wZOgg=;
 b=cFBGD36A5tYXkyXIrWkQzr6QQZQl1w9dg5fLc8YEO6UEX0smRkfaNxr6fdNJgk4qMJktJTw4a
 GMytH/9Hb9dCtN5uiI+UpvylqhUjVASqr8tShVtRQ1yCWGA4C0+09pc
X-Developer-Key: i=vikash.garodia@oss.qualcomm.com; a=ed25519;
 pk=LY9Eqp4KiHWxzGNKGHbwRFEJOfRCSzG/rxQNmvZvaKE=
X-Authority-Analysis: v=2.4 cv=YPqfyQGx c=1 sm=1 tr=0 ts=68d47bc0 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=PEWMjObkg-UKx6eyHxAA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: mHe0rmx97Uvzzhvc0CVuZlH6tvTunbP1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAwMCBTYWx0ZWRfX67NKIjBv05OI
 jWl/V/9zZiPn8Gv3HmiEzyTaOLrMrQeb4lQ8GuKDuzOF50bJEDPUGkvK1AxRWpsg94YcnuI1NWP
 /DKtHXQnOzdgDAjC0kq7RxPS3sQ41/mdpPGQ+0/qqAObt0j8MxQ4oMtXz0QYT808wj5EPErLQ/R
 3UL3mnf3asq+Iy9dRKpKabDsr0etnfX3QYvEcs3L2q+v/bcmwv67Llu0K2TSxcUamXpS/mL6PXe
 7FhM8EphcPkvvmO2Yzo+cgK8rz0GVjKXk1PR++twuZiIdbEuFwxdBsusUz0GW3qnC0Q88LO/YJP
 VR61CnzT+/DD1o2z8Z2FU5SmqClDC7jEsGFdfK3fmER3ClocT6+eE46U36AZrgWMNQOLpiQFUFV
 GVy+32v3
X-Proofpoint-GUID: mHe0rmx97Uvzzhvc0CVuZlH6tvTunbP1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0
 clxscore=1011 impostorscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200000

Some of the sequence and calculations for vpu4 is identical to vpu35,
namely power sequence for vpu controller and the clock frequency
calculation. Move those to common file that can be shared for both vpu35
and vpu4. This patch prepares for power sequence for vpu4 which is added
in subsequent patch.

Co-developed-by: Vishnu Reddy <quic_bvisredd@quicinc.com>
Signed-off-by: Vishnu Reddy <quic_bvisredd@quicinc.com>
Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/iris_vpu3x.c      | 159 +--------------------
 drivers/media/platform/qcom/iris/iris_vpu_common.c | 143 ++++++++++++++++++
 drivers/media/platform/qcom/iris/iris_vpu_common.h |   4 +
 3 files changed, 153 insertions(+), 153 deletions(-)

diff --git a/drivers/media/platform/qcom/iris/iris_vpu3x.c b/drivers/media/platform/qcom/iris/iris_vpu3x.c
index 0ac6373c33b7ced75ac94ac86a1a8fc303f28b5d..3abfb74dbb10974c8fe3cedaf67e8b4fca421015 100644
--- a/drivers/media/platform/qcom/iris/iris_vpu3x.c
+++ b/drivers/media/platform/qcom/iris/iris_vpu3x.c
@@ -12,8 +12,6 @@
 #include "iris_vpu_register_defines.h"
 
 #define CORE_CLK_RUN				0x0
-/* VPU v3.5 */
-#define WRAPPER_IRIS_VCODEC_VPU_WRAPPER_SPARE_0	(WRAPPER_BASE_OFFS + 0x78)
 
 #define VIDEO_NOC_RESET_REQ			(BIT(0) | BIT(1))
 
@@ -22,8 +20,6 @@
 #define AON_WRAPPER_MVP_NOC_CORE_CLK_CONTROL	(AON_BASE_OFFS + 0x20)
 #define NOC_HALT				BIT(0)
 #define AON_WRAPPER_SPARE			(AON_BASE_OFFS + 0x28)
-#define AON_WRAPPER_MVP_VIDEO_CTL_NOC_LPI_CONTROL	(AON_BASE_OFFS + 0x2C)
-#define AON_WRAPPER_MVP_VIDEO_CTL_NOC_LPI_STATUS	(AON_BASE_OFFS + 0x30)
 
 static bool iris_vpu3x_hw_power_collapsed(struct iris_core *core)
 {
@@ -268,155 +264,12 @@ static void iris_vpu35_power_off_hw(struct iris_core *core)
 	iris_disable_unprepare_clock(core, IRIS_AXI_CLK);
 }
 
-static int iris_vpu35_power_off_controller(struct iris_core *core)
-{
-	u32 clk_rst_tbl_size = core->iris_platform_data->clk_rst_tbl_size;
-	unsigned int count = 0;
-	u32 val = 0;
-	bool handshake_done, handshake_busy;
-	int ret;
-
-	writel(MSK_SIGNAL_FROM_TENSILICA | MSK_CORE_POWER_ON, core->reg_base + CPU_CS_X2RPMH);
-
-	writel(REQ_POWER_DOWN_PREP, core->reg_base + WRAPPER_IRIS_CPU_NOC_LPI_CONTROL);
-
-	ret = readl_poll_timeout(core->reg_base + WRAPPER_IRIS_CPU_NOC_LPI_STATUS,
-				 val, val & BIT(0), 200, 2000);
-	if (ret)
-		goto disable_power;
-
-	writel(0, core->reg_base + WRAPPER_IRIS_CPU_NOC_LPI_CONTROL);
-
-	/* Retry up to 1000 times as recommended by hardware documentation */
-	do {
-		/* set MNoC to low power */
-		writel(REQ_POWER_DOWN_PREP, core->reg_base + AON_WRAPPER_MVP_VIDEO_CTL_NOC_LPI_CONTROL);
-
-		udelay(15);
-
-		val = readl(core->reg_base + AON_WRAPPER_MVP_VIDEO_CTL_NOC_LPI_STATUS);
-
-		handshake_done = val & NOC_LPI_STATUS_DONE;
-		handshake_busy = val & (NOC_LPI_STATUS_DENY | NOC_LPI_STATUS_ACTIVE);
-
-		if (handshake_done || !handshake_busy)
-			break;
-
-		writel(0, core->reg_base + AON_WRAPPER_MVP_VIDEO_CTL_NOC_LPI_CONTROL);
-
-		udelay(15);
-
-	} while (++count < 1000);
-
-	if (!handshake_done && handshake_busy)
-		dev_err(core->dev, "LPI handshake timeout\n");
-
-	ret = readl_poll_timeout(core->reg_base + AON_WRAPPER_MVP_VIDEO_CTL_NOC_LPI_STATUS,
-				 val, val & BIT(0), 200, 2000);
-	if (ret)
-		goto disable_power;
-
-	writel(0, core->reg_base + AON_WRAPPER_MVP_VIDEO_CTL_NOC_LPI_CONTROL);
-
-	writel(0, core->reg_base + WRAPPER_DEBUG_BRIDGE_LPI_CONTROL);
-
-	ret = readl_poll_timeout(core->reg_base + WRAPPER_DEBUG_BRIDGE_LPI_STATUS,
-				 val, val == 0, 200, 2000);
-	if (ret)
-		goto disable_power;
-
-disable_power:
-	iris_disable_unprepare_clock(core, IRIS_CTRL_CLK);
-	iris_disable_unprepare_clock(core, IRIS_CTRL_FREERUN_CLK);
-	iris_disable_unprepare_clock(core, IRIS_AXI1_CLK);
-
-	iris_disable_power_domains(core, core->pmdomain_tbl->pd_devs[IRIS_CTRL_POWER_DOMAIN]);
-
-	reset_control_bulk_reset(clk_rst_tbl_size, core->resets);
-
-	return 0;
-}
-
-static int iris_vpu35_power_on_controller(struct iris_core *core)
-{
-	int ret;
-
-	ret = iris_enable_power_domains(core, core->pmdomain_tbl->pd_devs[IRIS_CTRL_POWER_DOMAIN]);
-	if (ret)
-		return ret;
-
-	ret = iris_prepare_enable_clock(core, IRIS_AXI1_CLK);
-	if (ret)
-		goto err_disable_power;
-
-	ret = iris_prepare_enable_clock(core, IRIS_CTRL_FREERUN_CLK);
-	if (ret)
-		goto err_disable_axi1_clk;
-
-	ret = iris_prepare_enable_clock(core, IRIS_CTRL_CLK);
-	if (ret)
-		goto err_disable_ctrl_free_clk;
-
-	return 0;
-
-err_disable_ctrl_free_clk:
-	iris_disable_unprepare_clock(core, IRIS_CTRL_FREERUN_CLK);
-err_disable_axi1_clk:
-	iris_disable_unprepare_clock(core, IRIS_AXI1_CLK);
-err_disable_power:
-	iris_disable_power_domains(core, core->pmdomain_tbl->pd_devs[IRIS_CTRL_POWER_DOMAIN]);
-
-	return ret;
-}
-
-static void iris_vpu35_program_bootup_registers(struct iris_core *core)
-{
-	writel(0x1, core->reg_base + WRAPPER_IRIS_VCODEC_VPU_WRAPPER_SPARE_0);
-}
-
-static u64 iris_vpu3x_calculate_frequency(struct iris_inst *inst, size_t data_size)
-{
-	struct platform_inst_caps *caps = inst->core->iris_platform_data->inst_caps;
-	struct v4l2_format *inp_f = inst->fmt_src;
-	u32 height, width, mbs_per_second, mbpf;
-	u64 fw_cycles, fw_vpp_cycles;
-	u64 vsp_cycles, vpp_cycles;
-	u32 fps = DEFAULT_FPS;
-
-	width = max(inp_f->fmt.pix_mp.width, inst->crop.width);
-	height = max(inp_f->fmt.pix_mp.height, inst->crop.height);
-
-	mbpf = NUM_MBS_PER_FRAME(height, width);
-	mbs_per_second = mbpf * fps;
-
-	fw_cycles = fps * caps->mb_cycles_fw;
-	fw_vpp_cycles = fps * caps->mb_cycles_fw_vpp;
-
-	vpp_cycles = mult_frac(mbs_per_second, caps->mb_cycles_vpp, (u32)inst->fw_caps[PIPE].value);
-	/* 21 / 20 is minimum overhead factor */
-	vpp_cycles += max(div_u64(vpp_cycles, 20), fw_vpp_cycles);
-
-	/* 1.059 is multi-pipe overhead */
-	if (inst->fw_caps[PIPE].value > 1)
-		vpp_cycles += div_u64(vpp_cycles * 59, 1000);
-
-	vsp_cycles = fps * data_size * 8;
-	vsp_cycles = div_u64(vsp_cycles, 2);
-	/* VSP FW overhead 1.05 */
-	vsp_cycles = div_u64(vsp_cycles * 21, 20);
-
-	if (inst->fw_caps[STAGE].value == STAGE_1)
-		vsp_cycles = vsp_cycles * 3;
-
-	return max3(vpp_cycles, vsp_cycles, fw_cycles);
-}
-
 const struct vpu_ops iris_vpu3_ops = {
 	.power_off_hw = iris_vpu3_power_off_hardware,
 	.power_on_hw = iris_vpu_power_on_hw,
 	.power_off_controller = iris_vpu_power_off_controller,
 	.power_on_controller = iris_vpu_power_on_controller,
-	.calc_freq = iris_vpu3x_calculate_frequency,
+	.calc_freq = iris_vpu3x_vpu4x_calculate_frequency,
 };
 
 const struct vpu_ops iris_vpu33_ops = {
@@ -424,14 +277,14 @@ const struct vpu_ops iris_vpu33_ops = {
 	.power_on_hw = iris_vpu_power_on_hw,
 	.power_off_controller = iris_vpu33_power_off_controller,
 	.power_on_controller = iris_vpu_power_on_controller,
-	.calc_freq = iris_vpu3x_calculate_frequency,
+	.calc_freq = iris_vpu3x_vpu4x_calculate_frequency,
 };
 
 const struct vpu_ops iris_vpu35_ops = {
 	.power_off_hw = iris_vpu35_power_off_hw,
 	.power_on_hw = iris_vpu35_power_on_hw,
-	.power_off_controller = iris_vpu35_power_off_controller,
-	.power_on_controller = iris_vpu35_power_on_controller,
-	.program_bootup_registers = iris_vpu35_program_bootup_registers,
-	.calc_freq = iris_vpu3x_calculate_frequency,
+	.power_off_controller = iris_vpu35_vpu4x_power_off_controller,
+	.power_on_controller = iris_vpu35_vpu4x_power_on_controller,
+	.program_bootup_registers = iris_vpu35_vpu4x_program_bootup_registers,
+	.calc_freq = iris_vpu3x_vpu4x_calculate_frequency,
 };
diff --git a/drivers/media/platform/qcom/iris/iris_vpu_common.c b/drivers/media/platform/qcom/iris/iris_vpu_common.c
index a7b1fb8173e02d22e6f2af4ea170738c6408f65b..dd0990d143a624d83e241d9970297ce1abe37f74 100644
--- a/drivers/media/platform/qcom/iris/iris_vpu_common.c
+++ b/drivers/media/platform/qcom/iris/iris_vpu_common.c
@@ -8,6 +8,7 @@
 #include <linux/reset.h>
 
 #include "iris_core.h"
+#include "iris_instance.h"
 #include "iris_vpu_common.h"
 #include "iris_vpu_register_defines.h"
 
@@ -48,6 +49,10 @@
 
 #define WRAPPER_TZ_CPU_STATUS			(WRAPPER_TZ_BASE_OFFS + 0x10)
 
+#define WRAPPER_IRIS_VCODEC_VPU_WRAPPER_SPARE_0	(WRAPPER_BASE_OFFS + 0x78)
+#define AON_WRAPPER_MVP_VIDEO_CTL_NOC_LPI_CONTROL	(AON_BASE_OFFS + 0x2C)
+#define AON_WRAPPER_MVP_VIDEO_CTL_NOC_LPI_STATUS	(AON_BASE_OFFS + 0x30)
+
 static void iris_vpu_interrupt_init(struct iris_core *core)
 {
 	u32 mask_val;
@@ -309,6 +314,144 @@ int iris_vpu_power_on_hw(struct iris_core *core)
 	return ret;
 }
 
+int iris_vpu35_vpu4x_power_off_controller(struct iris_core *core)
+{
+	u32 clk_rst_tbl_size = core->iris_platform_data->clk_rst_tbl_size;
+	bool handshake_done, handshake_busy;
+	u32 count = 0, val = 0;
+	int ret;
+
+	writel(MSK_SIGNAL_FROM_TENSILICA | MSK_CORE_POWER_ON, core->reg_base + CPU_CS_X2RPMH);
+
+	writel(REQ_POWER_DOWN_PREP, core->reg_base + WRAPPER_IRIS_CPU_NOC_LPI_CONTROL);
+
+	ret = readl_poll_timeout(core->reg_base + WRAPPER_IRIS_CPU_NOC_LPI_STATUS,
+				 val, val & BIT(0), 200, 2000);
+	if (ret)
+		goto disable_power;
+
+	writel(0, core->reg_base + WRAPPER_IRIS_CPU_NOC_LPI_CONTROL);
+
+	/* Retry up to 1000 times as recommended by hardware documentation */
+	do {
+		/* set MNoC to low power */
+		writel(REQ_POWER_DOWN_PREP, core->reg_base +
+		       AON_WRAPPER_MVP_VIDEO_CTL_NOC_LPI_CONTROL);
+		usleep_range(10, 20);
+		val = readl(core->reg_base + AON_WRAPPER_MVP_VIDEO_CTL_NOC_LPI_STATUS);
+
+		handshake_done = val & NOC_LPI_STATUS_DONE;
+		handshake_busy = val & (NOC_LPI_STATUS_DENY | NOC_LPI_STATUS_ACTIVE);
+
+		if (handshake_done || !handshake_busy)
+			break;
+
+		writel(0, core->reg_base + AON_WRAPPER_MVP_VIDEO_CTL_NOC_LPI_CONTROL);
+		usleep_range(10, 20);
+
+	} while (++count < 1000);
+
+	if (!handshake_done && handshake_busy)
+		dev_err(core->dev, "LPI handshake timeout\n");
+
+	ret = readl_poll_timeout(core->reg_base + AON_WRAPPER_MVP_VIDEO_CTL_NOC_LPI_STATUS,
+				 val, val & BIT(0), 200, 2000);
+	if (ret)
+		goto disable_power;
+
+	writel(0, core->reg_base + AON_WRAPPER_MVP_VIDEO_CTL_NOC_LPI_CONTROL);
+
+	writel(0, core->reg_base + WRAPPER_DEBUG_BRIDGE_LPI_CONTROL);
+
+	readl_poll_timeout(core->reg_base + WRAPPER_DEBUG_BRIDGE_LPI_STATUS,
+			   val, val == 0, 200, 2000);
+
+disable_power:
+	iris_disable_unprepare_clock(core, IRIS_CTRL_CLK);
+	iris_disable_unprepare_clock(core, IRIS_CTRL_FREERUN_CLK);
+	iris_disable_unprepare_clock(core, IRIS_AXI1_CLK);
+
+	iris_disable_power_domains(core, core->pmdomain_tbl->pd_devs[IRIS_CTRL_POWER_DOMAIN]);
+
+	reset_control_bulk_reset(clk_rst_tbl_size, core->resets);
+
+	return 0;
+}
+
+int iris_vpu35_vpu4x_power_on_controller(struct iris_core *core)
+{
+	int ret;
+
+	ret = iris_enable_power_domains(core, core->pmdomain_tbl->pd_devs[IRIS_CTRL_POWER_DOMAIN]);
+	if (ret)
+		return ret;
+
+	ret = iris_prepare_enable_clock(core, IRIS_AXI1_CLK);
+	if (ret)
+		goto err_disable_power;
+
+	ret = iris_prepare_enable_clock(core, IRIS_CTRL_FREERUN_CLK);
+	if (ret)
+		goto err_disable_axi1_clk;
+
+	ret = iris_prepare_enable_clock(core, IRIS_CTRL_CLK);
+	if (ret)
+		goto err_disable_ctrl_free_clk;
+
+	return 0;
+
+err_disable_ctrl_free_clk:
+	iris_disable_unprepare_clock(core, IRIS_CTRL_FREERUN_CLK);
+err_disable_axi1_clk:
+	iris_disable_unprepare_clock(core, IRIS_AXI1_CLK);
+err_disable_power:
+	iris_disable_power_domains(core, core->pmdomain_tbl->pd_devs[IRIS_CTRL_POWER_DOMAIN]);
+
+	return ret;
+}
+
+void iris_vpu35_vpu4x_program_bootup_registers(struct iris_core *core)
+{
+	writel(0x1, core->reg_base + WRAPPER_IRIS_VCODEC_VPU_WRAPPER_SPARE_0);
+}
+
+u64 iris_vpu3x_vpu4x_calculate_frequency(struct iris_inst *inst, size_t data_size)
+{
+	struct platform_inst_caps *caps = inst->core->iris_platform_data->inst_caps;
+	struct v4l2_format *inp_f = inst->fmt_src;
+	u32 height, width, mbs_per_second, mbpf;
+	u64 fw_cycles, fw_vpp_cycles;
+	u64 vsp_cycles, vpp_cycles;
+	u32 fps = DEFAULT_FPS;
+
+	width = max(inp_f->fmt.pix_mp.width, inst->crop.width);
+	height = max(inp_f->fmt.pix_mp.height, inst->crop.height);
+
+	mbpf = NUM_MBS_PER_FRAME(height, width);
+	mbs_per_second = mbpf * fps;
+
+	fw_cycles = fps * caps->mb_cycles_fw;
+	fw_vpp_cycles = fps * caps->mb_cycles_fw_vpp;
+
+	vpp_cycles = mult_frac(mbs_per_second, caps->mb_cycles_vpp, (u32)inst->fw_caps[PIPE].value);
+	/* 21 / 20 is minimum overhead factor */
+	vpp_cycles += max(div_u64(vpp_cycles, 20), fw_vpp_cycles);
+
+	/* 1.059 is multi-pipe overhead */
+	if (inst->fw_caps[PIPE].value > 1)
+		vpp_cycles += div_u64(vpp_cycles * 59, 1000);
+
+	vsp_cycles = fps * data_size * 8;
+	vsp_cycles = div_u64(vsp_cycles, 2);
+	/* VSP FW overhead 1.05 */
+	vsp_cycles = div_u64(vsp_cycles * 21, 20);
+
+	if (inst->fw_caps[STAGE].value == STAGE_1)
+		vsp_cycles = vsp_cycles * 3;
+
+	return max3(vpp_cycles, vsp_cycles, fw_cycles);
+}
+
 int iris_vpu_power_on(struct iris_core *core)
 {
 	u32 freq;
diff --git a/drivers/media/platform/qcom/iris/iris_vpu_common.h b/drivers/media/platform/qcom/iris/iris_vpu_common.h
index d636e287457adf0c44540af5c85cfa69decbca8b..7cf4304604cca590544a938c7e811c202cea3d93 100644
--- a/drivers/media/platform/qcom/iris/iris_vpu_common.h
+++ b/drivers/media/platform/qcom/iris/iris_vpu_common.h
@@ -33,5 +33,9 @@ int iris_vpu_power_on(struct iris_core *core);
 int iris_vpu_power_off_controller(struct iris_core *core);
 void iris_vpu_power_off_hw(struct iris_core *core);
 void iris_vpu_power_off(struct iris_core *core);
+int iris_vpu35_vpu4x_power_off_controller(struct iris_core *core);
+int iris_vpu35_vpu4x_power_on_controller(struct iris_core *core);
+void iris_vpu35_vpu4x_program_bootup_registers(struct iris_core *core);
+u64 iris_vpu3x_vpu4x_calculate_frequency(struct iris_inst *inst, size_t data_size);
 
 #endif

-- 
2.34.1


