Return-Path: <linux-kernel+bounces-728477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 494DCB028C0
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 03:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B8CD7AABF6
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 01:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94C8223DD9;
	Sat, 12 Jul 2025 00:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TTP6A9el"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9448C221FD4
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 00:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752281935; cv=none; b=uo6e5+uk01Bm7PV3EuNN9lcidezNHoXIC7nxMRE5ULle7iY5QPzYx5Ha4vG9COfaTEbaxgVfvDnzB8ij7uRNkWM0GWmlyYTfhfuqVcLN7KNRHntZQP8sY1silTM5MM7dw80CjxOopIEPN1xEQrhQbUxRAZRyUTSqaF7eoF20+oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752281935; c=relaxed/simple;
	bh=xkdTJkD4WZOtCIaP3g0FoYgCz7GOS4niggFgMMcqAvE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kzXmgFY0cCCCH/Mm1P5gFHMRyNZyohAHStOFxnMxNvqK8MJyLcaBxB52yDE3/VSFOA/5A896hex9TxquLpp9cvk7EwmbhgpcEelUE9dgi3UxmDnbI7U3SS7QhiLX5UMkJfkZC1jjCXiCEi9e21Aay3X2zZIEWkvwNtiA5alMG80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TTP6A9el; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BAmQ7v007998
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 00:58:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	h6MX/4UQ3wXDdbyTB76Y7TSV5eGjDBlTaDUHvPE6J1c=; b=TTP6A9elD9VKFH3z
	MW6ZqLWWpCOtNVM/lZGaP+imvfgkJQviwT9nsNOQydy3FqkcT9EkNXm6DNyz7L3M
	G68rge6s9mOpkSDQOETMrgPmaPmHVzIoFtP9KfdKDQkjYrbhW6omuvXG9epL1Vtg
	pFm3gIHkN70hyhtjju9bpQk7rqMV73eFCADzP1d9JncK6kdnNC9EwQnDqPhOggVj
	qbHiy2EKjXEO/a//o/4HcWxzPt7C21UqvtIJW2/AMsXBwcHVEgyIf9gYIkaBMnOd
	gEsGyOseGjYXKntrHr+24qj36W0SSC13aaZe1QCTMyAoxL/n9VLMq1q81wBakVof
	ASuf/g==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47smcga6tq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 00:58:52 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-313fb0ec33bso2530454a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 17:58:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752281932; x=1752886732;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h6MX/4UQ3wXDdbyTB76Y7TSV5eGjDBlTaDUHvPE6J1c=;
        b=VKpVCpt2d8Hdj3A1Usz1uLW5uAlpJWVVls+QRvrY5vglRK19f+4OZp2Z8PcbGR1RMv
         JwqdJmQZB50Beixup7N+qAEgFtHdLZDCrLoAHi/qBdso0R7xyvYvwj9vk9hzijVZUA1D
         4iSJMlMwHgEBspp4yyUi84snIzuHijnZgJZohoNujNmhECkP8ROB3RqR4TU98rpPfuG2
         Qq0aKb4GtEkHJ9Dv6Eu5xaN/0YPf3H3fD2y0R6TsQh6MkimyCLpkqhSZMn+n6Qvjddfw
         0idgUc9RLbMT6WOxNQ4/EOf4O4HiPedQr3utrvdqbEcbxt0p5RZY5phtXB9KmDx2BX/C
         UYfw==
X-Forwarded-Encrypted: i=1; AJvYcCW0da0Z0vYNlzecadLmYvIJx7UFNIcLfjq83Nm6ANxALUGMqYYEgV3sGRUzLMvdUEi5xoIjnEtpEXxVGHo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFroU8heLEt/8BuXDkqMGa9OjWJX05F1VnQ/KJuLWI4hEVsvPh
	53QUXsQihdMl8yiuOXD7BBTrVUbZl3KGAzht/5yUHuNmcOFnuhReRmygFr01BnBwUp0hvFzGQp5
	6X9Tx89JLyXpd4ifrNU4GCZL3OuUKjUYpX/51/NDE8J7bEaG16gC6U/fm4YUlctGOoIQ=
X-Gm-Gg: ASbGnctsKa/Qr0qZifan0kaLQgDuAfAbci2J7SyY0xkFCbefOKw+nhZ3ziYsovnCiec
	UiWk/SbqbFKDiSOX1noSdlL+nLU7q37uwafZfAhk1GPywSAKHUW7cEUUu7hFLjqwgyoOBvvY070
	YExbiLc+S8NtwpL75OkD4Yg1qCcdIFH2L7UD7Xb/C0r6n/VSBsH45497E40KUe9LGXIu0xVB/rP
	MTpGrLXBBJE9zkUclgurAk6ZCWmiR27dnuUS325qHsk6QLuMF9iaUUa5rfcAJqnQ3zCU4PJxTfn
	26RCc4w2YqG0rL9PWpZ95g81VWqotLagxiwIhMiftn/if9lIc/hh1LmR5ZF9pEfOgJ1YgcNMDHL
	mbLbaEexGQOdhfhs7dCle5je+
X-Received: by 2002:a17:90b:3a8a:b0:313:28e7:af14 with SMTP id 98e67ed59e1d1-31c4cd65a3bmr7425876a91.19.1752281931700;
        Fri, 11 Jul 2025 17:58:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+tFLKCiCnmepc6qucz0dfVj1tK+bY/9vBdgkeSkt43kwJGfNiJkqRtZ8IG3Tjs+Uvv+NhcQ==
X-Received: by 2002:a17:90b:3a8a:b0:313:28e7:af14 with SMTP id 98e67ed59e1d1-31c4cd65a3bmr7425849a91.19.1752281931257;
        Fri, 11 Jul 2025 17:58:51 -0700 (PDT)
Received: from jesszhan-linux.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c23006d72sm5202274a91.1.2025.07.11.17.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 17:58:50 -0700 (PDT)
From: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
Date: Fri, 11 Jul 2025 17:58:21 -0700
Subject: [PATCH 16/19] drm/msm/dp: Drop hpd_state from msm_dp
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250711-hpd-refactor-v1-16-33cbac823f34@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752281905; l=4635;
 i=jessica.zhang@oss.qualcomm.com; s=20230329; h=from:subject:message-id;
 bh=xkdTJkD4WZOtCIaP3g0FoYgCz7GOS4niggFgMMcqAvE=;
 b=+E6l2V/nDb8KhG3CAAg7+kJnHr+MlfA6ctlX5ccgh5qrgoS8D0zCCOUNf12CexedtRsn0uiDv
 Dck1hnnKBUFCogGlFKtRqE0GtzIvTBqejdEVsAUDMO/2tI5UjOGKZ95
X-Developer-Key: i=jessica.zhang@oss.qualcomm.com; a=ed25519;
 pk=gAUCgHZ6wTJOzQa3U0GfeCDH7iZLlqIEPo4rrjfDpWE=
X-Authority-Analysis: v=2.4 cv=P7o6hjAu c=1 sm=1 tr=0 ts=6871b34c cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=K4C07s3wgbYD0KnbiqQA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: equ3GzOsBDJYeb9oQ9wOgbzTm7Xs_cyu
X-Proofpoint-GUID: equ3GzOsBDJYeb9oQ9wOgbzTm7Xs_cyu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEyMDAwNSBTYWx0ZWRfX/nwtoZXRPqS3
 /SA4rTA5/mJ/zcU8AE9p+gMcmuh9ctkpsjgWjyKgkFTOFy1PFMs7SbStmT14CzyFweI8KHoquDk
 YiychxIrcNTKDXChP4lXm42n2hT11zmBcv+OcgIiCFTG/vedMFYWrtMsV2c+cOr3Mm3+eSAtZm5
 /v6Tc9FRrmjnIUtcAkHZWK2a2GCIQXwKbdhpMwY+V0mBBr0DjA4NGP1qnbViUe6oloJIVoxN5Pw
 PQ8l66BlIrXh0pETIGmIzgojJluAhljqOoa/WLQjSJyBWZFe0blLIpqEgsEJe+8TGPd+UXT8tV3
 Kc+VodMkmIjY/cuYhimMrRNM1quqpWOcr/JT1vAD/fjKSukgHrkvk3ds2QVWdgfiu7w/Eh2AFEH
 g8Wsu0qPS3lGFzU0skAu2JRguLbvlY+ylQx3Zf7Wb92/VNwzqBgGAmfQRqotyaC+iqm8GVqF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_07,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 phishscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 adultscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507120005

Drop the now unused hpd_state field from msm_dp and adjust debug logs
accordingly

Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 36 +++++++++++++-----------------------
 1 file changed, 13 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 529e30193168..3aaa603da4f9 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -91,7 +91,6 @@ struct msm_dp_display_private {
 	/* event related only access by event thread */
 	struct mutex event_mutex;
 	wait_queue_head_t event_q;
-	u32 hpd_state;
 	u32 event_pndx;
 	u32 event_gndx;
 	struct task_struct *ev_tsk;
@@ -556,8 +555,7 @@ static int msm_dp_display_usbpd_attention_cb(struct device *dev)
 	rc = msm_dp_link_process_request(dp->link);
 	if (!rc) {
 		sink_request = dp->link->sink_request;
-		drm_dbg_dp(dp->drm_dev, "hpd_state=%d sink_request=%d\n",
-					dp->hpd_state, sink_request);
+		drm_dbg_dp(dp->drm_dev, "sink_request=%d\n", sink_request);
 		if (sink_request & DS_PORT_STATUS_CHANGED)
 			rc = msm_dp_display_handle_port_status_changed(dp);
 		else
@@ -569,7 +567,6 @@ static int msm_dp_display_usbpd_attention_cb(struct device *dev)
 
 static int msm_dp_hpd_plug_handle(struct msm_dp_display_private *dp, u32 data)
 {
-	u32 state;
 	int ret;
 	struct platform_device *pdev = dp->msm_dp_display.pdev;
 
@@ -577,9 +574,8 @@ static int msm_dp_hpd_plug_handle(struct msm_dp_display_private *dp, u32 data)
 
 	mutex_lock(&dp->event_mutex);
 
-	state =  dp->hpd_state;
-	drm_dbg_dp(dp->drm_dev, "Before, type=%d hpd_state=%d\n",
-			dp->msm_dp_display.connector_type, state);
+	drm_dbg_dp(dp->drm_dev, "Before, type=%d\n",
+			dp->msm_dp_display.connector_type);
 
 	if (dp->msm_dp_display.link_ready) {
 		mutex_unlock(&dp->event_mutex);
@@ -601,8 +597,8 @@ static int msm_dp_hpd_plug_handle(struct msm_dp_display_private *dp, u32 data)
 		pm_runtime_put_sync(&pdev->dev);
 	}
 
-	drm_dbg_dp(dp->drm_dev, "After, type=%d hpd_state=%d\n",
-			dp->msm_dp_display.connector_type, state);
+	drm_dbg_dp(dp->drm_dev, "After, type=%d\n",
+			dp->msm_dp_display.connector_type);
 	mutex_unlock(&dp->event_mutex);
 
 	/* uevent will complete connection part */
@@ -625,17 +621,14 @@ static void msm_dp_display_handle_plugged_change(struct msm_dp *msm_dp_display,
 
 static int msm_dp_hpd_unplug_handle(struct msm_dp_display_private *dp, u32 data)
 {
-	u32 state;
 	struct platform_device *pdev = dp->msm_dp_display.pdev;
 
 	msm_dp_aux_enable_xfers(dp->aux, false);
 
 	mutex_lock(&dp->event_mutex);
 
-	state = dp->hpd_state;
-
-	drm_dbg_dp(dp->drm_dev, "Before, type=%d hpd_state=%d\n",
-			dp->msm_dp_display.connector_type, state);
+	drm_dbg_dp(dp->drm_dev, "Before, type=%d\n",
+			dp->msm_dp_display.connector_type);
 
 	if (!dp->msm_dp_display.link_ready) {
 		mutex_unlock(&dp->event_mutex);
@@ -660,8 +653,8 @@ static int msm_dp_hpd_unplug_handle(struct msm_dp_display_private *dp, u32 data)
 	/* signal the disconnect event early to ensure proper teardown */
 	msm_dp_display_handle_plugged_change(&dp->msm_dp_display, false);
 
-	drm_dbg_dp(dp->drm_dev, "After, type=%d hpd_state=%d\n",
-			dp->msm_dp_display.connector_type, state);
+	drm_dbg_dp(dp->drm_dev, "After, type=%d\n",
+			dp->msm_dp_display.connector_type);
 
 	/* uevent will complete disconnection part */
 	pm_runtime_put_sync(&pdev->dev);
@@ -671,14 +664,11 @@ static int msm_dp_hpd_unplug_handle(struct msm_dp_display_private *dp, u32 data)
 
 static int msm_dp_irq_hpd_handle(struct msm_dp_display_private *dp, u32 data)
 {
-	u32 state;
-
 	mutex_lock(&dp->event_mutex);
 
 	/* irq_hpd can happen at either connected or disconnected state */
-	state =  dp->hpd_state;
-	drm_dbg_dp(dp->drm_dev, "Before, type=%d hpd_state=%d\n",
-			dp->msm_dp_display.connector_type, state);
+	drm_dbg_dp(dp->drm_dev, "Before, type=%d\n",
+			dp->msm_dp_display.connector_type);
 
 	if (dp->msm_dp_display.link_ready != dp->msm_dp_display.connected) {
 		/* wait until connect/disconnect handling is completed */
@@ -689,8 +679,8 @@ static int msm_dp_irq_hpd_handle(struct msm_dp_display_private *dp, u32 data)
 
 	msm_dp_display_usbpd_attention_cb(&dp->msm_dp_display.pdev->dev);
 
-	drm_dbg_dp(dp->drm_dev, "After, type=%d hpd_state=%d\n",
-			dp->msm_dp_display.connector_type, state);
+	drm_dbg_dp(dp->drm_dev, "After, type=%d\n",
+			dp->msm_dp_display.connector_type);
 
 	mutex_unlock(&dp->event_mutex);
 

-- 
2.50.1


