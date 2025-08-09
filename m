Return-Path: <linux-kernel+bounces-760888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C8A1B1F1A1
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 02:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 724FA16BF89
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 00:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C7824728D;
	Sat,  9 Aug 2025 00:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iQOW6Jk5"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354F924167D
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 00:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754699748; cv=none; b=Wg9Ox/0ZsVPmEUDrIturMpHVvC4TBGRA4EYFFeamcvYhoesTrnrZD1DDk1q7aqtoaUs/ZgDBeWtoDrbtKJjjrTwg7BPK1S3r5aNrI5w9oJMNfbhGgFBZJPcNjV46Id1uWbbzHulOgKtO9xj1gEn0fnV9jN6zRYXkc+l5FLZ747Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754699748; c=relaxed/simple;
	bh=NtDdlTY6ajF5Cn/Kyk0d5E8/TBSy+P52roB0OK+a+7s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zv+m+U6qKYMGxbZ/H5LtHjmGO44IrdQVPKWIOeoAQEebLcKNqIp+U/hTIOhEb+QXuK0eMweUm/c8d0sftSz7biJb1OnwTWE1Vvz3OKCdiS14skyKzCP6CMmoxQ/dtdn3rhzbU/v1zy763pdM8XBTbLsRmG1cDRSjMARRbkGQg44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iQOW6Jk5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 578EvAdI003579
	for <linux-kernel@vger.kernel.org>; Sat, 9 Aug 2025 00:35:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bu9JC9zHNP1OllCJIaZCuXVLfyKeem9bnATi8oCUDNY=; b=iQOW6Jk5GUU0bVVd
	I1yLLuufa0Dp0XT/yBvhy6m6tdQloQG8ZG6GODWIrpFUhQRotWzBRIK9fh/epbhj
	qbuy+htC/toDLwF3Ee6Qmjtay9yAs8tfQeYIuYJTDUn7AEBdpmxJZ//By1qvUURm
	XlQJkrTDQxY8OAsM5iSxv1xejiha0EEQq+bRdVUQzftoN5NCSebpefUpttDFzwdW
	XUShqAY8Um3sy1gOgHAtbsUu7V6Q7HNM1jiVj4o6OWAsDPzK3rYR+vp45n3+QeRw
	2Ob3aadfCaS3x3F47UP9hbpQbqlex52VVMVs5e9E1qT24pKd6u7A7cJIKm7j3QFd
	7PRcaQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpyakhvk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 09 Aug 2025 00:35:46 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-240012b74dfso20676745ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 17:35:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754699746; x=1755304546;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bu9JC9zHNP1OllCJIaZCuXVLfyKeem9bnATi8oCUDNY=;
        b=c4tgTHlWFkk9APX2VtGedu/Bjgv9KU/7SA94gaIUPcxO/W1TpKJVA62Ih4m8Gog9Wr
         yHcC2Z5WDYGhh7Voi15kVxQaDrfdmqnq1cVmlsii9OIzPfsCS8ERpVa9cABprBC2OZ9o
         Yua7JB6pg70M7hSPqqOPtOpDRhoyC4c2coHl3KTl/Vzt0JhFL2V0CZ3+85yWAlx6qy4i
         8GJ4Q6IHhEWx/zF9QicHBgzLj7eoTrTprN+zteQhjpaaPOqkzchAqobmEjO2y6lUAgT/
         h7ne2KGm8Fog82EDu94rBg2JbmjpvsV1P23ohN6WBHm931X9Q8WkRoPNWiduGhBO+Abc
         aMWg==
X-Forwarded-Encrypted: i=1; AJvYcCWdR2Jsm+pRF6Qh3YQ+/85id0F+CMdKOrnkPTk28UbK/qP4Il+0/TSM/K/DUpjV5z6f8Iiq09i7UIkJNdE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrfyvxlHH3IKCP0zhFzXeUFIJDWeCFj2Qyc4ByXBAUr8ZCoWHE
	2KAtHvMXohWIeJcb7CpM2CQmk5UF6Pg2ppHv9BH8YFJDOMWDRgsLKGIYSCnfrb0IXdSK2zRxtlW
	nEHAQF03ohvbWUtVlbTlGL+FU5OM69YTFgtmqCcGni5s741ZOdG74Sb2h9uB9NUztcsc=
X-Gm-Gg: ASbGncv/R1rErrWxosb5C+sjyqcohUkglfYDCJFwfBvhPvG5IS9x4iH4A/NlZTIjpqV
	AsRA24Sr5xsrx9yGwoxjZ2hM3K6ijNvwR0l/6ia2+XsjwSpNjFLv7PZmO5DdND+aJaGUMfa5CDD
	39U08j6FdRUvKn+rrR1P7UYgGnzqXBjKO00QDRZ7fljGe+vvQ0RBjr8GeO/uSQxGT7AhbBny9C/
	O4Ox4b8LVUgXNPi5B0P0VHy0nmFg4pl9wyzV8UUfJp1EWs2jtPmsQ0qINWHENy5cvVQGX+mtRXI
	TCsMpdWXNHBm/h1PkCDj9dqcwlY0mq4MDn9Nz3eojNPzAxAadm+VdpUedwMxbcKmYacaWYnJ1QA
	1XHdiU2BOM6K0/yUnelcWUjwu
X-Received: by 2002:a17:903:46cb:b0:242:9bbc:3647 with SMTP id d9443c01a7336-242c225d0a3mr72360985ad.57.1754699745402;
        Fri, 08 Aug 2025 17:35:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5oheQKh0vVLh3BuayrDEhBZWfIYUi6SiluwbsB/hAdJ7WViVAEgmlUVSgsmClxqPvza/2KA==
X-Received: by 2002:a17:903:46cb:b0:242:9bbc:3647 with SMTP id d9443c01a7336-242c225d0a3mr72360555ad.57.1754699744953;
        Fri, 08 Aug 2025 17:35:44 -0700 (PDT)
Received: from jesszhan-linux.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef678dsm219865355ad.39.2025.08.08.17.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 17:35:44 -0700 (PDT)
From: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
Date: Fri, 08 Aug 2025 17:35:19 -0700
Subject: [PATCH v2 07/12] drm/msm/dp: Handle internal HPD IRQ in
 hpd_notify()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250808-hpd-refactor-v2-7-7f4e1e741aa3@oss.qualcomm.com>
References: <20250808-hpd-refactor-v2-0-7f4e1e741aa3@oss.qualcomm.com>
In-Reply-To: <20250808-hpd-refactor-v2-0-7f4e1e741aa3@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Yongxing Mou <quic_yongmou@quicinc.com>
X-Mailer: b4 0.15-dev-a9b2a
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754699734; l=8145;
 i=jessica.zhang@oss.qualcomm.com; s=20230329; h=from:subject:message-id;
 bh=NtDdlTY6ajF5Cn/Kyk0d5E8/TBSy+P52roB0OK+a+7s=;
 b=64v9EwkavX5hcUROjX+cegb6NBCEoeYw/F/oKT/Tc6EqSzROzgIrBsc2z38w2ux/J6JTTHum6
 sAUi7lWbSrFCV+iW5DyNMJjgX2bi90kVLqy/my+e8KKkhgiY9sKxEnJ
X-Developer-Key: i=jessica.zhang@oss.qualcomm.com; a=ed25519;
 pk=gAUCgHZ6wTJOzQa3U0GfeCDH7iZLlqIEPo4rrjfDpWE=
X-Proofpoint-ORIG-GUID: uZvbTZbo-bpRQn4niv-tVmpLHxXwlb3P
X-Authority-Analysis: v=2.4 cv=MrlS63ae c=1 sm=1 tr=0 ts=689697e2 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=Wiw9OC-66MpX0Jk431gA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAwOSBTYWx0ZWRfX338yn6JHEzNR
 vrN+9qruwu4b6vpEy8eLpp2TP2nHjXBxmzU/54IRaealstbkLiZyMHClAZs7wMmmvCMOFRsaQDl
 XCvuKzl6rBOwsinjNP92qTl3ohvWaIdqS0x68jHOo1qazkeFVevJ3MNciKPrPNgL7Il6cvqTGT+
 hgmykXRFzdiP6eZpN6+/JFgODa0IoGguJmw4W2Fz1fZDUipLJhrXiSm88+E5VRQFhu70Jc5HuTK
 UTcfxL9BSByMOm9cf0+DZKYyJ7mc0NGpdEdtsUuvvl74kJQQ+KxYQdToeHF9QaMZXM9cHZ/rkUs
 2nH8voPQcJQvMH0AFriXItwGr031heuXgreDYrFgpyw/HAXDcD+F3bgNNhSHPeqNATRZoMioYw3
 jbBLx6ZA
X-Proofpoint-GUID: uZvbTZbo-bpRQn4niv-tVmpLHxXwlb3P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_08,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 adultscore=0 priorityscore=1501 phishscore=0
 spamscore=0 bulkscore=0 clxscore=1015 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508060009

Switch to using a threaded IRQ to handle HPD IRQ events and moving
handling of internal HPD IRQ events to hpd_notify().

This will simplify the handling of HPD events by unifying the handling
of both external and internal HPD events in hpd_notify(). Also, having
internal HPD IRQ use the DRM framework calls removes the need for msm_dp
to track the HPD state internally.

Note: The setting of linked ready is moved out of
*_send_hpd_notification() as it should only be set after the plug/unplug
handling has been completed.

Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 127 +++++++++++++++++++++++++-----------
 1 file changed, 90 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 8779bcd1b27c..b9e2e368c4a8 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -96,6 +96,10 @@ struct msm_dp_display_private {
 	/* wait for audio signaling */
 	struct completion audio_comp;
 
+	/* HPD IRQ handling */
+	spinlock_t irq_thread_lock;
+	u32 hpd_isr_status;
+
 	/* event related only access by event thread */
 	struct mutex event_mutex;
 	wait_queue_head_t event_q;
@@ -345,14 +349,8 @@ static int msm_dp_display_send_hpd_notification(struct msm_dp_display_private *d
 	/* reset video pattern flag on disconnect */
 	if (!hpd) {
 		dp->panel->video_test = false;
-		if (!dp->msm_dp_display.is_edp)
-			drm_dp_set_subconnector_property(dp->msm_dp_display.connector,
-							 connector_status_disconnected,
-							 dp->panel->dpcd,
-							 dp->panel->downstream_ports);
 	}
 
-	dp->msm_dp_display.link_ready = hpd;
 
 	drm_dbg_dp(dp->drm_dev, "type=%d hpd=%d\n",
 			dp->msm_dp_display.connector_type, hpd);
@@ -407,6 +405,8 @@ static int msm_dp_display_process_hpd_high(struct msm_dp_display_private *dp)
 						 dp->panel->dpcd,
 						 dp->panel->downstream_ports);
 
+	dp->msm_dp_display.link_ready = true;
+
 	dp->msm_dp_display.psr_supported = dp->panel->psr_cap.version && psr_enabled;
 
 	dp->audio_supported = info->has_audio;
@@ -420,7 +420,8 @@ static int msm_dp_display_process_hpd_high(struct msm_dp_display_private *dp)
 
 	msm_dp_link_reset_phy_params_vx_px(dp->link);
 
-	msm_dp_display_send_hpd_notification(dp, true);
+	if (!dp->msm_dp_display.internal_hpd)
+		msm_dp_display_send_hpd_notification(dp, true);
 
 end:
 	return rc;
@@ -489,7 +490,16 @@ static int msm_dp_display_notify_disconnect(struct device *dev)
 {
 	struct msm_dp_display_private *dp = dev_get_dp_display_private(dev);
 
-	msm_dp_display_send_hpd_notification(dp, false);
+	if (!dp->msm_dp_display.is_edp)
+		drm_dp_set_subconnector_property(dp->msm_dp_display.connector,
+						 connector_status_disconnected,
+						 dp->panel->dpcd,
+						 dp->panel->downstream_ports);
+
+	dp->msm_dp_display.link_ready = false;
+
+	if (!dp->msm_dp_display.internal_hpd)
+		msm_dp_display_send_hpd_notification(dp, false);
 
 	return 0;
 }
@@ -1182,40 +1192,56 @@ enum drm_connector_status msm_dp_bridge_detect(struct drm_bridge *bridge)
 static irqreturn_t msm_dp_display_irq_handler(int irq, void *dev_id)
 {
 	struct msm_dp_display_private *dp = dev_id;
-	irqreturn_t ret = IRQ_NONE;
 	u32 hpd_isr_status;
-
-	if (!dp) {
-		DRM_ERROR("invalid data\n");
-		return IRQ_NONE;
-	}
+	unsigned long flags;
+	irqreturn_t ret = IRQ_HANDLED;
 
 	hpd_isr_status = msm_dp_aux_get_hpd_intr_status(dp->aux);
 
 	if (hpd_isr_status & 0x0F) {
 		drm_dbg_dp(dp->drm_dev, "type=%d isr=0x%x\n",
 			dp->msm_dp_display.connector_type, hpd_isr_status);
-		/* hpd related interrupts */
-		if (hpd_isr_status & DP_DP_HPD_PLUG_INT_MASK)
-			msm_dp_add_event(dp, EV_HPD_PLUG_INT, 0, 0);
 
-		if (hpd_isr_status & DP_DP_IRQ_HPD_INT_MASK) {
-			msm_dp_add_event(dp, EV_IRQ_HPD_INT, 0, 0);
-		}
+		spin_lock_irqsave(&dp->irq_thread_lock, flags);
+		dp->hpd_isr_status |= hpd_isr_status;
+		ret = IRQ_WAKE_THREAD;
+		spin_unlock_irqrestore(&dp->irq_thread_lock, flags);
+	}
 
-		if (hpd_isr_status & DP_DP_HPD_REPLUG_INT_MASK) {
-			msm_dp_add_event(dp, EV_HPD_UNPLUG_INT, 0, 0);
-			msm_dp_add_event(dp, EV_HPD_PLUG_INT, 0, 3);
-		}
+	/* DP controller isr */
+	ret |= msm_dp_ctrl_isr(dp->ctrl);
 
-		if (hpd_isr_status & DP_DP_HPD_UNPLUG_INT_MASK)
-			msm_dp_add_event(dp, EV_HPD_UNPLUG_INT, 0, 0);
+	return ret;
+}
 
-		ret = IRQ_HANDLED;
+static irqreturn_t msm_dp_display_irq_thread(int irq, void *dev_id)
+{
+	struct msm_dp_display_private *dp = dev_id;
+	irqreturn_t ret = IRQ_NONE;
+	unsigned long flags;
+	u32 hpd_isr_status;
+
+	if (!dp) {
+		DRM_ERROR("invalid data\n");
+		return IRQ_NONE;
 	}
 
-	/* DP controller isr */
-	ret |= msm_dp_ctrl_isr(dp->ctrl);
+	spin_lock_irqsave(&dp->irq_thread_lock, flags);
+	hpd_isr_status = dp->hpd_isr_status;
+	dp->hpd_isr_status = 0;
+	spin_unlock_irqrestore(&dp->irq_thread_lock, flags);
+
+	/* hpd related interrupts */
+	if (hpd_isr_status & DP_DP_HPD_PLUG_INT_MASK)
+		msm_dp_display_send_hpd_notification(dp, true);
+
+	if (hpd_isr_status & DP_DP_HPD_UNPLUG_INT_MASK)
+		msm_dp_display_send_hpd_notification(dp, false);
+
+	if (hpd_isr_status & DP_DP_IRQ_HPD_INT_MASK)
+		msm_dp_display_send_hpd_notification(dp, true);
+
+	ret = IRQ_HANDLED;
 
 	return ret;
 }
@@ -1231,9 +1257,13 @@ static int msm_dp_display_request_irq(struct msm_dp_display_private *dp)
 		return dp->irq;
 	}
 
-	rc = devm_request_irq(&pdev->dev, dp->irq, msm_dp_display_irq_handler,
-			      IRQF_TRIGGER_HIGH|IRQF_NO_AUTOEN,
-			      "dp_display_isr", dp);
+	spin_lock_init(&dp->irq_thread_lock);
+	irq_set_status_flags(dp->irq, IRQ_NOAUTOEN);
+	rc = devm_request_threaded_irq(&pdev->dev, dp->irq,
+				       msm_dp_display_irq_handler,
+				       msm_dp_display_irq_thread,
+				       IRQ_TYPE_LEVEL_HIGH,
+				       "dp_display_isr", dp);
 
 	if (rc < 0) {
 		DRM_ERROR("failed to request IRQ%u: %d\n",
@@ -1413,6 +1443,7 @@ static int msm_dp_display_probe(struct platform_device *pdev)
 	dp->wide_bus_supported = desc->wide_bus_supported;
 	dp->msm_dp_display.is_edp =
 		(dp->msm_dp_display.connector_type == DRM_MODE_CONNECTOR_eDP);
+	dp->hpd_isr_status = 0;
 
 	rc = msm_dp_display_get_io(dp);
 	if (rc)
@@ -1822,13 +1853,35 @@ void msm_dp_bridge_hpd_notify(struct drm_bridge *bridge,
 	struct msm_dp_bridge *msm_dp_bridge = to_dp_bridge(bridge);
 	struct msm_dp *msm_dp_display = msm_dp_bridge->msm_dp_display;
 	struct msm_dp_display_private *dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
+	u32 hpd_link_status = 0;
 
-	/* Without next_bridge interrupts are handled by the DP core directly */
-	if (msm_dp_display->internal_hpd)
-		return;
+	if (msm_dp_display->internal_hpd) {
+		if (pm_runtime_resume_and_get(&msm_dp_display->pdev->dev)) {
+			DRM_ERROR("failed to pm_runtime_resume\n");
+			return;
+		}
+
+		hpd_link_status = msm_dp_aux_is_link_connected(dp->aux);
+	}
 
-	if (!msm_dp_display->link_ready && status == connector_status_connected)
+	drm_dbg_dp(dp->drm_dev, "type=%d link connected=0x%x, link_ready=%d, status=%d\n",
+		   msm_dp_display->connector_type, hpd_link_status,
+		   msm_dp_display->link_ready, status);
+
+	if ((!msm_dp_display->internal_hpd || hpd_link_status == ISR_CONNECTED) &&
+	    status == connector_status_connected)
+		msm_dp_hpd_plug_handle(dp, 0);
+	else if ((hpd_link_status == ISR_IRQ_HPD_PULSE_COUNT) &&
+	    status == connector_status_connected)
+		msm_dp_irq_hpd_handle(dp, 0);
+	else if (hpd_link_status == ISR_HPD_REPLUG_COUNT) {
 		msm_dp_hpd_plug_handle(dp, 0);
-	else if (msm_dp_display->link_ready && status == connector_status_disconnected)
 		msm_dp_hpd_unplug_handle(dp, 0);
+	} else if ((!msm_dp_display->internal_hpd ||
+		    hpd_link_status == ISR_DISCONNECTED) &&
+		 status == connector_status_disconnected)
+		msm_dp_hpd_unplug_handle(dp, 0);
+
+	if (msm_dp_display->internal_hpd)
+		pm_runtime_put_sync(&msm_dp_display->pdev->dev);
 }

-- 
2.50.1


