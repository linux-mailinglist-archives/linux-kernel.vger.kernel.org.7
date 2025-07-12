Return-Path: <linux-kernel+bounces-728469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1DAB028AD
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 03:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D94A18930A7
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 01:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0F71C5D4E;
	Sat, 12 Jul 2025 00:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ElWNkyCk"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C181B415F
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 00:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752281920; cv=none; b=QTU5a9r0KxwdMk90uBLCGG7u+zRUNl2dQc6VoY3xb0InO3C/dAVAkO3fI8TM2PHjbaZTLVOIpABBCGngrRixqCyfXB/C3Az4YV3GlNl5RIeut1OiF8LwwukRQ2NCRJwwD/DzRY5kxei6P78c5KIQVVC5Z5u0cS4SWwaV6WWJowk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752281920; c=relaxed/simple;
	bh=A6qHQe23MoIl3Lo+738gYkpwWYMBFzzH7/YAXqyjDXc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NUsuA5N5uQH3idt/whf9IZA7pbBMbWzlyD4WoO+E0oRvqi3jlFbG33urkBbW4LA8x0JFqla8KiD8Zul1oUGHydoICa9PdX0sp95XJoBHWme1hfdusWEpQqAMV6Pq/YvDYmtsCj2F049JuevWk1MfhidpzsJeWIUAS7m4Dv8/PtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ElWNkyCk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BLkdW6021781
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 00:58:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9sfyzKfbfll0Y6pC9wYmMCCUExx6sAsV9HVVdHNnnk8=; b=ElWNkyCkiT3wToln
	LVY4Npk6MdtzRAiDDoCttMqcCnZYHShCoNI0ukYB8dujUV66yRaFPc/iansUYcE4
	fUCAm0nGO5L2tDCiA1fXzatyYbeSt7lhLoIChlRl98nCJEmLdZ5goy1+yJeQYLEV
	Dajdi8VIY/fa1S4ppLcEAYPvkxrAT0pqhzGdOJivjEL6eDPSpfByJiRXzJR6kDqw
	u4riPtQJCRHVQZk+aPoBMOLLlP8sBzBNTMww+qU0fb5dwIa0ZZ1Y1RP7zZZ1z1Ui
	SNEIl0T+hejtu3YdapNcO8vYp6+TGLTRCqzgwSbX+6prXkrhjYZxFvTHrhoyiQlS
	246vbw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47r9b1b8rm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 00:58:38 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-313fab41f4bso3598703a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 17:58:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752281918; x=1752886718;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9sfyzKfbfll0Y6pC9wYmMCCUExx6sAsV9HVVdHNnnk8=;
        b=qgXAuFFY7lqxc1wGYGRJqSPm6P1UqRgrVzuUBx+TxjzZcSvEgvDrrEhesC0XvzQF40
         E9MpWl/KENWFIUeIjkQ7oj15NgPy1GNwLprRGbwsKEnQxlqmbsPddhfswFXDmVpJc6TR
         rHZy5DmkBMFakUrFcEJuJS9BF/8s8muHH6TC7shDVKOH0uEkmCvERFUp38vLebA8lcmj
         d6X9jDUxc25ahFasFt2tVC8LzIWdxSACVZnIn0cS1w8IgHD9c/52nCGO/CdVht2tGtoN
         dC9yHhYmVUvbeQMDbbFbYQXONx13fC2bswlRJYFrQbZry0TKAy9juT0BBZOgj8tnypQp
         CXcw==
X-Forwarded-Encrypted: i=1; AJvYcCWxuL9h3saXxK8SPVbXxh6jp/5NAWEm9eFubX6Eka8ghv4eTb6APeeF2JMuXzlyjcTlAVHYJ5yvbRyer/4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4OBaq+LR4dZkhaiRakWaE3C4G5D3N0h/1OuJo4K9/ukhcCQan
	hLLfdJuzkB/XCy9uRBBcUgdSfkcJe0gl1NATTKrvxOlanJgxZb7EFSg114hNwQp8gl3k6CZQUxb
	7UT3IkpjoCDQZufGExm+xnapmXnDhk2fJzgq0okkVzXl2WhaQFAlxuwkYYf9kW95Ykl0=
X-Gm-Gg: ASbGncvfUtZLuAOK1clOatXaWhYgDEmexa1x6mAnZbsFCulRhpXGV2SiHZlXUdR2K5R
	Re0nWhIfUqO8C6pkTZRyb50SP/F+kkVs7ke2K7Nc4B8vB727B635zztZNHUT6ZeTcLF0Oc7PTuY
	cxgE8YnHYOvbYgHSKorM2k6J250klRp48MhpJHWX7Pn5QCYqcXPX/nSPc0BqquAW3NdvwznOGFi
	LjAl8nRZTIKPU5iDLoZpuN4nmt6lVt8Tv1GZE6qoPibSkE8s5dJGnTLoYGSiOYuAJb8Aa1HiZfT
	OXWnol0D4pJJbJfywg+BKZCnbhhxYwVbuYfeL5x2EkxhmFebJsCRNzlvyqizGdV9ekg/IYXQq8L
	tXBTp0MrWAObeic1J799u32a9
X-Received: by 2002:a17:90b:5445:b0:308:7270:d6ea with SMTP id 98e67ed59e1d1-31c4cd542d1mr7102539a91.30.1752281917576;
        Fri, 11 Jul 2025 17:58:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG88ipsfGCVjYqYZ9GRyykBzdr8Y1eqpIyUUX2i5znBDnxgzgMI8LINqhKf5XOyh1wG4OdyZQ==
X-Received: by 2002:a17:90b:5445:b0:308:7270:d6ea with SMTP id 98e67ed59e1d1-31c4cd542d1mr7102502a91.30.1752281917135;
        Fri, 11 Jul 2025 17:58:37 -0700 (PDT)
Received: from jesszhan-linux.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c23006d72sm5202274a91.1.2025.07.11.17.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 17:58:36 -0700 (PDT)
From: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
Date: Fri, 11 Jul 2025 17:58:12 -0700
Subject: [PATCH 07/19] drm/msm/dp: Rework unplug handling
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250711-hpd-refactor-v1-7-33cbac823f34@oss.qualcomm.com>
References: <20250711-hpd-refactor-v1-0-33cbac823f34@oss.qualcomm.com>
In-Reply-To: <20250711-hpd-refactor-v1-0-33cbac823f34@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Yongxing Mou <quic_yongmou@quicinc.com>
X-Mailer: b4 0.15-dev-a9b2a
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752281905; l=3891;
 i=jessica.zhang@oss.qualcomm.com; s=20230329; h=from:subject:message-id;
 bh=A6qHQe23MoIl3Lo+738gYkpwWYMBFzzH7/YAXqyjDXc=;
 b=qFKTKln9ZXCepyzqJoVFRVR9U8ih8agkhM9UBkPU07pTQJRSMBW5iAO6L26B8U13RCmmdqSNl
 0HOeAZDhO53AYTRwHx2HuWbuUBJMnRkPE4pduUu+Ddkws8LUkPuphWa
X-Developer-Key: i=jessica.zhang@oss.qualcomm.com; a=ed25519;
 pk=gAUCgHZ6wTJOzQa3U0GfeCDH7iZLlqIEPo4rrjfDpWE=
X-Authority-Analysis: v=2.4 cv=dYuA3WXe c=1 sm=1 tr=0 ts=6871b33e cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=4KM1mOPumagNCLxjdSoA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEyMDAwNSBTYWx0ZWRfX2eziUgNK8evs
 fqTQ1wZVLlrhXTVQPD5FqyHLSzktYWVgC0qvwG0CatIXP7uYcAYfYp0FdMqmUcu7yX3CHgAhuGz
 G1/DFggSy+gghiWtEYE+JdD+mMrJq6ZJM3OT5A5jUuqKU5Gf7+vsMEn2bi9rc9fhG6BoEAIw4/a
 nCGHXbc7WRv0gZZor0KZovsBd2VS0Ok+nB3S00BB7CR3Z0KbdQkAVk6JjY6IwcLT3VwI0huZ3B3
 YVGPkY0K8MGEvEOR6x3WHSfYqCk+3Il3GBO8N4vMZnGF01k9hN1fLv6Lx8OUf/F3s5ZLucA5CLp
 TYz8XupTg8O3rmPPQ3Z3IomxozGehxUVmSyyzn/NekLz394Xxs1Wigeq/jbFKMmiyGhu/bHQsoI
 QOqBIuV1PlPEUYppeIBLJsJsPvbctMqxlmjt5UbQmiVVZPbtkFFz1rwPViWto5K+j0nSfFW8
X-Proofpoint-GUID: b8kNHb1FOZKitmN8Nozw9e5WsnMYHRoI
X-Proofpoint-ORIG-GUID: b8kNHb1FOZKitmN8Nozw9e5WsnMYHRoI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_07,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507120005

Simplify the unplug event handling by dropping the link teardown (as it
is already handled as part of the atomic post_disable()).

With the link teardown removed, we can also drop hpd_state-specific
handling to minimize redundant code

Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c    | 22 ----------------------
 drivers/gpu/drm/msm/dp/dp_ctrl.h    |  1 -
 drivers/gpu/drm/msm/dp/dp_display.c | 27 +++++++--------------------
 3 files changed, 7 insertions(+), 43 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index c42fd2c17a32..4cf269b98029 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -2567,28 +2567,6 @@ void msm_dp_ctrl_off_link_stream(struct msm_dp_ctrl *msm_dp_ctrl)
 			phy, phy->init_count, phy->power_count);
 }
 
-void msm_dp_ctrl_off_link(struct msm_dp_ctrl *msm_dp_ctrl)
-{
-	struct msm_dp_ctrl_private *ctrl;
-	struct phy *phy;
-
-	ctrl = container_of(msm_dp_ctrl, struct msm_dp_ctrl_private, msm_dp_ctrl);
-	phy = ctrl->phy;
-
-	msm_dp_ctrl_mainlink_disable(ctrl);
-
-	dev_pm_opp_set_rate(ctrl->dev, 0);
-	msm_dp_ctrl_link_clk_disable(&ctrl->msm_dp_ctrl);
-
-	DRM_DEBUG_DP("Before, phy=%p init_count=%d power_on=%d\n",
-		phy, phy->init_count, phy->power_count);
-
-	phy_power_off(phy);
-
-	DRM_DEBUG_DP("After, phy=%p init_count=%d power_on=%d\n",
-		phy, phy->init_count, phy->power_count);
-}
-
 void msm_dp_ctrl_off(struct msm_dp_ctrl *msm_dp_ctrl)
 {
 	struct msm_dp_ctrl_private *ctrl;
diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.h b/drivers/gpu/drm/msm/dp/dp_ctrl.h
index 124b9b21bb7f..f68bee62713f 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.h
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.h
@@ -19,7 +19,6 @@ struct phy;
 int msm_dp_ctrl_on_link(struct msm_dp_ctrl *msm_dp_ctrl);
 int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, bool force_link_train);
 void msm_dp_ctrl_off_link_stream(struct msm_dp_ctrl *msm_dp_ctrl);
-void msm_dp_ctrl_off_link(struct msm_dp_ctrl *msm_dp_ctrl);
 void msm_dp_ctrl_off(struct msm_dp_ctrl *msm_dp_ctrl);
 void msm_dp_ctrl_push_idle(struct msm_dp_ctrl *msm_dp_ctrl);
 irqreturn_t msm_dp_ctrl_isr(struct msm_dp_ctrl *msm_dp_ctrl);
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 0f1c1fd2b1b7..1ce8051b116a 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -661,32 +661,19 @@ static int msm_dp_hpd_unplug_handle(struct msm_dp_display_private *dp, u32 data)
 	drm_dbg_dp(dp->drm_dev, "Before, type=%d hpd_state=%d\n",
 			dp->msm_dp_display.connector_type, state);
 
+	if (!dp->msm_dp_display.link_ready) {
+		mutex_unlock(&dp->event_mutex);
+		return 0;
+	}
+
 	dp->msm_dp_display.connected = false;
 
 	/* unplugged, no more irq_hpd handle */
 	msm_dp_del_event(dp, EV_IRQ_HPD_INT);
 
-	if (!dp->msm_dp_display.connected) {
-		/* triggered by irq_hdp with sink_count = 0 */
-		if (dp->link->sink_count == 0) {
-			msm_dp_display_host_phy_exit(dp);
-		}
-		msm_dp_display_notify_disconnect(&dp->msm_dp_display.pdev->dev);
-		mutex_unlock(&dp->event_mutex);
-		return 0;
-	} else if (state == ST_DISCONNECT_PENDING) {
-		mutex_unlock(&dp->event_mutex);
-		return 0;
-	} else if (state != ST_CONNECTED && dp->msm_dp_display.link_ready) {
-		msm_dp_ctrl_off_link(dp->ctrl);
+	/* triggered by irq_hdp with sink_count = 0 */
+	if (dp->link->sink_count == 0)
 		msm_dp_display_host_phy_exit(dp);
-		dp->hpd_state = ST_DISCONNECTED;
-		dp->msm_dp_display.connected = false;
-		msm_dp_display_notify_disconnect(&dp->msm_dp_display.pdev->dev);
-		pm_runtime_put_sync(&pdev->dev);
-		mutex_unlock(&dp->event_mutex);
-		return 0;
-	}
 
 	/*
 	 * We don't need separate work for disconnect as

-- 
2.50.1


