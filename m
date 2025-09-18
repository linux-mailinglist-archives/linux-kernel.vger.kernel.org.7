Return-Path: <linux-kernel+bounces-784913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F46FB34379
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 16:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E17421882B22
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 14:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837A13009F4;
	Mon, 25 Aug 2025 14:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="c2MD0LD0"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66341301013
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756131522; cv=none; b=ZQbRIVYrVPuy/uIo00wGEFgvOlg241gCAmXsAs6ouKl9OmlDe6q1+E+966A7NkKcmMZhf/GybGTngCGik8aSy0m5XDqANV2CBqpOd0nSPQmh96Y2dTFxFE42whzA2jXHNwbzsN/DcxzrAgHHIy6EDfcgE3kVa/rkA9Y0NtQUb7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756131522; c=relaxed/simple;
	bh=66yBhtWgblZgN3VGwxhVJgnXYK116xU0DvzCrYINLfU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TIpEK9lybmDPBfhO2Ki2AS59kFpvUrgeRBhs/rhUkieMx5LqVztf7whyeGvMgrcIQ115VrP/wUtILFSTP5hrCgW1G2DwzMVgp7RX/Qzn9iAFUZH/+jKvzmeYMKhEQODN4dGCS66e5b7YAjPMJ3rbqLaHNr4uJVky4aF33D0ML/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=c2MD0LD0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57P8I78g021749
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:18:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Gt1Kd8WbN3Mntymw4DR5wvrt37t2QDrxmTEvWz907Ls=; b=c2MD0LD0KNtQ8LXc
	XV7eQ7AO42NDMjcXTvrTkXJQT8Nb+L/3P1v8gRKP4Hm1mdNidWmQn2pf+pMcBs7/
	1GashBKtfESCU5+eXvkJS3wvM0c64GcFBkKQn291e/E623nGL4Z8SfRM4EaHS4YM
	yl0itQZ9ohlqcabPooORsLGBLBJ97u++R2jlek4yLxlZqj+AXTN/dMbfnJN7ekGI
	9TcrY+92yqsImhGII01mYqoE5i0Ogwji6hzggqBeth4OJyuPY+OF69Sb8zgrLlW7
	0dpObKAOa3GpSsT7KQiBDhvi+axg0dPnXCd9tG2MrZr5YJBRphWWx4jvXlhXBXIM
	eSaEAw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5w2nfdr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:18:38 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-76e395107e2so4235411b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 07:18:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756131518; x=1756736318;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gt1Kd8WbN3Mntymw4DR5wvrt37t2QDrxmTEvWz907Ls=;
        b=v6KD6rqnUT0zeIiz2JE/K8hLl4mCbHKQW66yrmdn4Q5nBVZ7vY4a34gwMo7cYkSbkM
         Z/k8I56XnorqnBLKyvKV/jkH1z6DAJtLfLReugWBJM7uegyx+S4S8zB7aWt6IS1NQDmz
         JnN9Z6zPQwEVgmMc2mqe+IQriGS/awxLnwlrs+3AQwx9JZGND+qcZOO5rY/GCBkz5P+o
         qBrFTDlmdU+hYwvTG1+Y3u1Ngny8fa/G0ttO/o1VzkVaK3fvGM/cvN/cBmSW+yTzlqHu
         9a2baMcCi/xgT0VCNsXqvl972MxqbtUWJcazqYgNT8WZVLJAh6M8X3D/rWNBHL4szdJk
         ouMA==
X-Forwarded-Encrypted: i=1; AJvYcCUprnspLCAKeJI/4xcDn+18hxMPIQlq0Lpcyo47X3A8VKCIFBHwPpHYSD9HhwCgiF+CKhSrsmSsyb3hlOU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6ZX4NOo7HGPIZyayereS6yOmbZxwS3Un9S2ks2BzqDsfhXWGJ
	YiJFoHN8btw+VCVlxMXtWdZB/65iqsHbK2APD7bgKWfHXRXhvaDTFH4phesmdoF2hAU8KceJofl
	wZWrpZ/QuLDx1E7+XlYT9Xe0wJVIJAk4ewTEYKeQoco+4FNWZC+ri68c/acR3m7FXJt8=
X-Gm-Gg: ASbGncsL8j62U/60kruc5XvrN0+JXhwoPSMOsvYHkg0NSacJTBhMhSdDB4UEZajbcJh
	2jVkKWL0tXPlfwK8ixnJWdoImPvm+sFsH+hyy2zgfEMS9EVNBp/AzXRCLV6sNVuVHEI1DW4jMtd
	jiZ/EX58r90NQXiyJ2Zkg3P6zxAFwp9uneuGWGiKTzXsFYhWeqw8mE/iCju3K3ePD0F5IjORg/2
	g5/LzOStCI09jKBwanNWG/7Lf9j3k1zHL9bxjE4qlpRNHBa3YNiAvxQP9EWBro9IlTSwfMt0mH1
	CuKO9UtbhOaT8Os/hsEISNoJ4Dj7SwmFG59WMH0aSUaPLK87Kij15F7Jrg6p3IbS/pjcvRM=
X-Received: by 2002:a05:6a20:2443:b0:243:78a:827d with SMTP id adf61e73a8af0-24340dc46b2mr16682858637.53.1756131517605;
        Mon, 25 Aug 2025 07:18:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHomJT8J2UBNar/NA6E/rkncy7tadfSH1DRguPQKCalJFoL98InY6Oc0JDca7mmJ3MGgGdaiQ==
X-Received: by 2002:a05:6a20:2443:b0:243:78a:827d with SMTP id adf61e73a8af0-24340dc46b2mr16682804637.53.1756131516926;
        Mon, 25 Aug 2025 07:18:36 -0700 (PDT)
Received: from cse-cd01-lnx.ap.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770401eb20dsm7672339b3a.79.2025.08.25.07.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 07:18:36 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Mon, 25 Aug 2025 22:16:07 +0800
Subject: [PATCH v3 21/38] drm/msm/dp: Add support for sending VCPF packets
 in DP controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250825-msm-dp-mst-v3-21-01faacfcdedd@oss.qualcomm.com>
References: <20250825-msm-dp-mst-v3-0-01faacfcdedd@oss.qualcomm.com>
In-Reply-To: <20250825-msm-dp-mst-v3-0-01faacfcdedd@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756131422; l=7673;
 i=yongxing.mou@oss.qualcomm.com; s=20241121; h=from:subject:message-id;
 bh=qlIXBJ1QvKUhgZ3FYzOczLF5vj3ZjmxjVSTdxEltdwk=;
 b=fPJwQQ0kAJqFHkfrjzS7eStp0w1oei2jCw3xHw2NthqM0pjx4VMlLCCNc3kagKeEUODnGmIok
 0/ckcXY4eFVDHh6rxhdVSM020Z3Nl8yQpj0Dy3Fg3baWs854WEUlFag
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=zeCnFRUqtOQMeFvdwex2M5o0Yf67UHYfwCyBRQ3kFbU=
X-Authority-Analysis: v=2.4 cv=Z/vsHGRA c=1 sm=1 tr=0 ts=68ac70be cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=unrKvF7sv23klRea54oA:9 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfXzlaijn+n8eob
 8Ely4filK/JQ+Vdi/h5IXG1qXVpF8U/5G7lvzkxew9INlbWMlgqzql/Xj7i94qLsEvlW7GeXJr0
 ucNVKJlYzh2az2meEeHrG6Pkk8NqWB10FkLciPJwjVmOaLxU/cIzmtiSlvOO0zYMpEdjvvm4Xkf
 FJsteDqYeP6m2VPRMPAIlHfoCEuunfYw5hqRnxpszsmjkaDi3WC4sm6Ok5rqQU3yiYKQrV9ZST/
 zZLF6Sm/ZAojlzHaxG9/1v6Thlgdb7C9QQZ99RFOj46tVP1NYiGNcKDo6TQ2n6x5htBmrytOsH9
 oS/PB04cuZR/ggtvuwO4mQBnQsRVLqq5eN6ho1+0+evgF9oHJikKV45RcrLyILOBAvKJHjGUwP1
 bzxWJeUU
X-Proofpoint-GUID: g_qA_k_G0nxJDSFh2Tnw_vqGyAakxsww
X-Proofpoint-ORIG-GUID: g_qA_k_G0nxJDSFh2Tnw_vqGyAakxsww
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_07,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 phishscore=0 clxscore=1015
 suspectscore=0 impostorscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230033

From: Abhinav Kumar <quic_abhinavk@quicinc.com>

The VC Payload Fill (VCPF) sequence is inserted by the DP controller
when stream symbols are absent, typically before a stream is disabled.
This patch adds support for triggering the VCPF sequence in the MSM DP
controller.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c    | 56 ++++++++++++++++++++++++++++++++++---
 drivers/gpu/drm/msm/dp/dp_ctrl.h    |  2 +-
 drivers/gpu/drm/msm/dp/dp_display.c |  2 +-
 drivers/gpu/drm/msm/dp/dp_reg.h     |  6 ++++
 4 files changed, 60 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index 9d58d9480fc4ab33c58218ef9beb54c64805c34c..58e8c526253f77f306c669d474bdb2d1751b49a5 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -65,9 +65,18 @@
 	(PSR_UPDATE_MASK | PSR_CAPTURE_MASK | PSR_EXIT_MASK | \
 	PSR_UPDATE_ERROR_MASK | PSR_WAKE_ERROR_MASK)
 
+#define DP_INTERRUPT_STATUS5 \
+	(DP_INTR_DP0_VCPF_SENT | DP_INTR_DP1_VCPF_SENT)
+#define DP_INTERRUPT_STATUS5_MASK \
+	(DP_INTERRUPT_STATUS5 << DP_INTERRUPT_STATUS_MASK_SHIFT)
+
 #define DP_CTRL_INTR_READY_FOR_VIDEO     BIT(0)
 #define DP_CTRL_INTR_IDLE_PATTERN_SENT  BIT(3)
 
+#define DP_DP0_PUSH_VCPF		BIT(12)
+#define DP_DP1_PUSH_VCPF		BIT(14)
+#define DP_MSTLINK_PUSH_VCPF		BIT(12)
+
 #define MR_LINK_TRAINING1  0x8
 #define MR_LINK_SYMBOL_ERM 0x80
 #define MR_LINK_PRBS7 0x100
@@ -407,6 +416,8 @@ void msm_dp_ctrl_enable_irq(struct msm_dp_ctrl *msm_dp_ctrl)
 			DP_INTERRUPT_STATUS1_MASK);
 	msm_dp_write_ahb(ctrl, REG_DP_INTR_STATUS2,
 			DP_INTERRUPT_STATUS2_MASK);
+	msm_dp_write_ahb(ctrl, REG_DP_INTR_STATUS5,
+			DP_INTERRUPT_STATUS5_MASK);
 }
 
 void msm_dp_ctrl_disable_irq(struct msm_dp_ctrl *msm_dp_ctrl)
@@ -416,6 +427,7 @@ void msm_dp_ctrl_disable_irq(struct msm_dp_ctrl *msm_dp_ctrl)
 
 	msm_dp_write_ahb(ctrl, REG_DP_INTR_STATUS, 0x00);
 	msm_dp_write_ahb(ctrl, REG_DP_INTR_STATUS2, 0x00);
+	msm_dp_write_ahb(ctrl, REG_DP_INTR_STATUS5, 0x00);
 }
 
 static u32 msm_dp_ctrl_get_psr_interrupt(struct msm_dp_ctrl_private *ctrl)
@@ -435,6 +447,20 @@ static void msm_dp_ctrl_config_psr_interrupt(struct msm_dp_ctrl_private *ctrl)
 	msm_dp_write_ahb(ctrl, REG_DP_INTR_MASK4, DP_INTERRUPT_MASK4);
 }
 
+static u32 msm_dp_ctrl_get_mst_interrupt(struct msm_dp_ctrl_private *ctrl)
+{
+	u32 intr, intr_ack;
+
+	intr = msm_dp_read_ahb(ctrl, REG_DP_INTR_STATUS5);
+	intr &= ~DP_INTERRUPT_STATUS5_MASK;
+	intr_ack = (intr & DP_INTERRUPT_STATUS5)
+			<< DP_INTERRUPT_STATUS_ACK_SHIFT;
+	msm_dp_write_ahb(ctrl, REG_DP_INTR_STATUS5,
+			 intr_ack | DP_INTERRUPT_STATUS5_MASK);
+
+	return intr;
+}
+
 static void msm_dp_ctrl_psr_mainlink_enable(struct msm_dp_ctrl_private *ctrl)
 {
 	u32 val;
@@ -518,14 +544,29 @@ static bool msm_dp_ctrl_mainlink_ready(struct msm_dp_ctrl_private *ctrl)
 	return true;
 }
 
-void msm_dp_ctrl_push_idle(struct msm_dp_ctrl *msm_dp_ctrl)
+void msm_dp_ctrl_push_idle(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *msm_dp_panel)
 {
 	struct msm_dp_ctrl_private *ctrl;
+	u32 state = 0x0;
 
 	ctrl = container_of(msm_dp_ctrl, struct msm_dp_ctrl_private, msm_dp_ctrl);
 
+	if (!ctrl->mst_active)
+		state |= DP_STATE_CTRL_PUSH_IDLE;
+	else if (msm_dp_panel->stream_id == DP_STREAM_0)
+		state |= DP_DP0_PUSH_VCPF;
+	else if (msm_dp_panel->stream_id == DP_STREAM_1)
+		state |= DP_DP1_PUSH_VCPF;
+	else
+		state |= DP_MSTLINK_PUSH_VCPF;
+
 	reinit_completion(&ctrl->idle_comp);
-	msm_dp_write_link(ctrl, REG_DP_STATE_CTRL, DP_STATE_CTRL_PUSH_IDLE);
+
+	if (msm_dp_panel->stream_id > DP_STREAM_1)
+		msm_dp_write_mstlink(ctrl, msm_dp_panel->stream_id,
+			REG_DP_MSTLINK_STATE_CTRL, state);
+	else
+		msm_dp_write_link(ctrl, REG_DP_STATE_CTRL, state);
 
 	if (!wait_for_completion_timeout(&ctrl->idle_comp,
 			IDLE_PATTERN_COMPLETION_TIMEOUT_JIFFIES))
@@ -2074,7 +2115,7 @@ void msm_dp_ctrl_set_psr(struct msm_dp_ctrl *msm_dp_ctrl, bool enter)
 			return;
 		}
 
-		msm_dp_ctrl_push_idle(msm_dp_ctrl);
+		msm_dp_ctrl_push_idle(msm_dp_ctrl, ctrl->panel);
 		msm_dp_write_link(ctrl, REG_DP_STATE_CTRL, 0);
 
 		msm_dp_ctrl_psr_mainlink_disable(ctrl);
@@ -2184,7 +2225,7 @@ static int msm_dp_ctrl_link_maintenance(struct msm_dp_ctrl_private *ctrl)
 	int ret = 0;
 	int training_step = DP_TRAINING_NONE;
 
-	msm_dp_ctrl_push_idle(&ctrl->msm_dp_ctrl);
+	msm_dp_ctrl_push_idle(&ctrl->msm_dp_ctrl, ctrl->panel);
 
 	ctrl->link->phy_params.p_level = 0;
 	ctrl->link->phy_params.v_level = 0;
@@ -2994,6 +3035,13 @@ irqreturn_t msm_dp_ctrl_isr(struct msm_dp_ctrl *msm_dp_ctrl)
 		ret = IRQ_HANDLED;
 	}
 
+	isr = msm_dp_ctrl_get_mst_interrupt(ctrl);
+	if (isr & (DP_INTR_DP0_VCPF_SENT | DP_INTR_DP1_VCPF_SENT)) {
+		drm_dbg_dp(ctrl->drm_dev, "vcpf sent\n");
+		complete(&ctrl->idle_comp);
+		ret = IRQ_HANDLED;
+	}
+
 	/* DP aux isr */
 	isr = msm_dp_ctrl_get_aux_interrupt(ctrl);
 	if (isr)
diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.h b/drivers/gpu/drm/msm/dp/dp_ctrl.h
index 751f00c97b94dc3b9e8fae2a86e261f71f293425..356030fda9a749f0caa4438ffad88c3f34ce8960 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.h
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.h
@@ -22,7 +22,7 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl,
 int msm_dp_ctrl_prepare_stream_on(struct msm_dp_ctrl *msm_dp_ctrl, bool force_link_train);
 void msm_dp_ctrl_off_link(struct msm_dp_ctrl *msm_dp_ctrl);
 void msm_dp_ctrl_off_pixel_clk(struct msm_dp_ctrl *msm_dp_ctrl, enum msm_dp_stream_id stream_id);
-void msm_dp_ctrl_push_idle(struct msm_dp_ctrl *msm_dp_ctrl);
+void msm_dp_ctrl_push_idle(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *msm_dp_panel);
 irqreturn_t msm_dp_ctrl_isr(struct msm_dp_ctrl *msm_dp_ctrl);
 void msm_dp_ctrl_handle_sink_request(struct msm_dp_ctrl *msm_dp_ctrl);
 struct msm_dp_ctrl *msm_dp_ctrl_get(struct device *dev,
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 17633ba79aa7642856051b69227e8f5b23d76730..e02ada7a3dc3b89618aeadd998e9a41236ee6bbf 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -1568,7 +1568,7 @@ void msm_dp_display_atomic_disable(struct msm_dp *msm_dp_display)
 
 	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
 
-	msm_dp_ctrl_push_idle(dp->ctrl);
+	msm_dp_ctrl_push_idle(dp->ctrl, dp->panel);
 	msm_dp_ctrl_mst_stream_channel_slot_setup(dp->ctrl,
 		dp->max_stream);
 	msm_dp_ctrl_mst_send_act(dp->ctrl);
diff --git a/drivers/gpu/drm/msm/dp/dp_reg.h b/drivers/gpu/drm/msm/dp/dp_reg.h
index ee4debf796910e00d370ab4c687009747bae5378..70fb647a25c05dc89f6aaf21456ddf2918cecbc3 100644
--- a/drivers/gpu/drm/msm/dp/dp_reg.h
+++ b/drivers/gpu/drm/msm/dp/dp_reg.h
@@ -42,9 +42,13 @@
 #define DP_INTR_FRAME_END		BIT(6)
 #define DP_INTR_CRC_UPDATED		BIT(9)
 
+#define DP_INTR_DP0_VCPF_SENT		BIT(0)
+#define DP_INTR_DP1_VCPF_SENT		BIT(3)
+
 #define REG_DP_INTR_STATUS3			(0x00000028)
 
 #define REG_DP_INTR_STATUS4			(0x0000002C)
+#define REG_DP_INTR_STATUS5			(0x00000034)
 #define PSR_UPDATE_INT				(0x00000001)
 #define PSR_CAPTURE_INT				(0x00000004)
 #define PSR_EXIT_INT				(0x00000010)
@@ -377,6 +381,8 @@
 #define REG_DP_DP0_RG				(0x000004F8)
 #define REG_DP_DP1_RG				(0x000004FC)
 
+#define REG_DP_MSTLINK_STATE_CTRL		(0x00000000)
+
 /* DP HDCP 1.3 registers */
 #define DP_HDCP_CTRL                                   (0x0A0)
 #define DP_HDCP_STATUS                                 (0x0A4)

-- 
2.34.1


