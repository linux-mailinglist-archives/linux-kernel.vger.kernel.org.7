Return-Path: <linux-kernel+bounces-784926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9330B343A7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 16:27:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC20417E00B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 14:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D952FDC38;
	Mon, 25 Aug 2025 14:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GcldEwMH"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D951A2FD1D6
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756131562; cv=none; b=fjCyCPpkzec4r7RM1GRA/ag/8z/G1wQ+hodMdSxPSa1in4ZQ7wevU1H3Ocgs/Eg9n+9P4glXOR27P1qGCDsX/btssKKM2WJvstK0A1JkygKDMXWefDx9RY8aHGofyhNU1y2blgdzqMfnSLBj9vqHfmMW6fGu6Yb1QnUAfBlfyWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756131562; c=relaxed/simple;
	bh=UxwVJ2bDQxzOtssmJBpiVFYp9fKhl9QGHLtUyTkNlNI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dI4wSrptOP8jvUX1jA1LPf7Jry3mC8ZAmdbUHB2pvWpR77Nxeg//1kng22oRfF4wm/hbo+aQv13fiMJA5elQUV27zrZorbFS/lHy/kUc5n+PEnhhDeE/+UnjTtkSS63vjda08BkU3dXGXuoPSa9Jsi7Hl5FeY/mpRViI2yqVumM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GcldEwMH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57P8h5Dm009314
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:19:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7R+hTtTaw5ToTCdndEqM/Un8EO0K3ITnYySHNRTUxeU=; b=GcldEwMHV/S/D5Jg
	QOiE5JgBkxKkLgrkkDstCWZ/mtTcV5BHCCX0FHXEC0LtpQZt+HwBWOxRpZtEOmgH
	fMq4ZS3SG+YZZbGtsiZTF1AC3rjh+aF//mM8JILL0Y+wyOPIW+SYTrd+D7ioM1hE
	mQNOwiauHRo62Ory+bL6i2ivuVa4j9HD9w1znb0AsjAEVMeiwThjRpzwTGpxHJMD
	H8pWGKWDuNAHInjpJLi3ALERkxIqnFPHAyjEZRx7QZjwYtFJEh9JZ6awMHnUnWGK
	0qzLtEkXePHv1088mp2UROBxpo1buf1ZweaZsgpnCtn22PeblepOrmk36Vudmkt4
	f/k+nQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q6de5dtv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:19:20 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-771e43782aaso914042b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 07:19:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756131559; x=1756736359;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7R+hTtTaw5ToTCdndEqM/Un8EO0K3ITnYySHNRTUxeU=;
        b=oc0XsTlO3WyjJBeh6VTa2nw2gCMA/6FnObeki4PYiqLrZBR9UiDubQWWbA8kDxyZTj
         0dXpGkVqnxB9NpVlp+8JpmmZiiNAiiro1q2PpSmjnHTUhaMzWQEq+DjzzVMO8aW2Xeiv
         JAv+m0vMciKQZ+k8UaR2Cf5GdSoEBhEZurhcK8IOEYvmIgt5SMwMbzAGE+Dxn+Jm70//
         bNUO6v+ZoIejuCAWd5/lStQd0Ydlij+gVtRSvTwb8GqEROj0VAztQz4dIRvtwjpnCeNS
         GoLbg7+BIlWZrpEwhPzJvt3JZABe5lVUrc9P26DcxixbbeqvOkiLRh4OCMSQiGf2Y9TK
         nKew==
X-Forwarded-Encrypted: i=1; AJvYcCW3EukhgVJTclikZnTSW7NIqFSEFcwmEubg4fiywpelStBhspmSDH9S4e6GY4Fm5NNRQEPAgj3X4+MD/bA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNoHB4gIXu+vaxibr2fyr76zWaHSPDXL79fq/3wCOASPnUDoKx
	0c1JT9F+/9Hz2AtL0kbO9VjqTlLV6PNwj6/ABWEJq6a13uVNukG/5d/oTzWzoIYVqzfzQS0Jm5A
	/E6XaLC1/2+Y6wIZW6vBcTVbGPVQU6TjX7mljAxvnS08wllaH+oo8HN0q9xyv+Ylx7b8=
X-Gm-Gg: ASbGncumjYvH8yQbtRhREbenvpOrWeTwqZu459//2+z/mOqUY75ADXQBQViewZG3I5V
	nkfBVmF3Meu9IO/Gy4jgY15bKMiZURjkNTY8vnqsUDRf6c21lbE4fedEIoVrPsQ6kuLXhLVa1Xk
	Fp2D0yNxClRy90NTtEIEPVix8JXR17vQ6b7FSSm64UdX3VHUkGwQ/8Fu2aNseNHT9HkTLcwC3CX
	Yypclpbt4M2nwqhxJ8kMu5+Ujgg9z6v3174F/S46HMmB80Rmht+ohqmUVtv5e8KlTPA7mEmjFMR
	inzhMNRE8FLsQQo1B29BccxLukecMjyUVK3IqqFG34Rsz9aSdpzViaPv45i4Vba96hU4mvQ=
X-Received: by 2002:a05:6a00:66ea:b0:770:573f:fc60 with SMTP id d2e1a72fcca58-770573ffe32mr6197207b3a.0.1756131559041;
        Mon, 25 Aug 2025 07:19:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjmJ7NV1t2qumG5euFKY+e++axraVSZFOy8I/JF9oxRhd3vr0G6AVqJ5TJ0WdytlSZ+NXJMw==
X-Received: by 2002:a05:6a00:66ea:b0:770:573f:fc60 with SMTP id d2e1a72fcca58-770573ffe32mr6197171b3a.0.1756131558524;
        Mon, 25 Aug 2025 07:19:18 -0700 (PDT)
Received: from cse-cd01-lnx.ap.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770401eb20dsm7672339b3a.79.2025.08.25.07.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 07:19:18 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Mon, 25 Aug 2025 22:16:17 +0800
Subject: [PATCH v3 31/38] drm/msm/dp: add HPD callback for dp MST
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250825-msm-dp-mst-v3-31-01faacfcdedd@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756131423; l=3991;
 i=yongxing.mou@oss.qualcomm.com; s=20241121; h=from:subject:message-id;
 bh=1chu/CyRFrYOIwyNnb7S1JG/A8QXA7TWXcBAfK9Edbc=;
 b=gEe8hTvRJJLhsQmmiybBLmIQrG2tiZ4F0jIKl5ZuNvwsnEohg7D4bYN8sSFgu8jgmUYzGWHCn
 C+HuY+eRJ0bD+s84EKfVlrAooZa3aw+Jn0tJ4b8uaCks7YEKleczjoo
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=zeCnFRUqtOQMeFvdwex2M5o0Yf67UHYfwCyBRQ3kFbU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzNyBTYWx0ZWRfX8rK/qxZZo1hr
 32fN9frYxkeshnelipiQ4WkWMMvnBZafbAHyxi3qGlH+OOYRqTee11Ie3WJz0crD9fItL2iuTBd
 rDqdo7Kvx84F+NPQuQzBOYvksnNMMykTiyQimYFU6b0eOuCyPDJW688mQgQs+Mr7pncz4ew0zLT
 zXjc2WXaIlBSD8AcjhLNUvzxDeGN60hDzSqhiObGCuFcIsgqTRbApMHHOtsfFntE2keAofgwTrI
 5bpZ3MDgtZiwynxRNrW2/5jvvERCehSjrL7Tk7WmSH/UuWsoIx46bXKJxAH6eZbDDH95BxNdGlS
 FbuIt2jcCRtUfUXFGb9zpOj7tlVZgJ5YU6MmGRuXDwhXzrFlCqPcs4sHsJjQx+teeDEUFgUznS/
 51rYNDqq
X-Proofpoint-ORIG-GUID: JCBnU4k8ko4h7auhhB28U1rbdyJWFLox
X-Proofpoint-GUID: JCBnU4k8ko4h7auhhB28U1rbdyJWFLox
X-Authority-Analysis: v=2.4 cv=K7UiHzWI c=1 sm=1 tr=0 ts=68ac70e8 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=bKAP0W6k1q0hwOPLvAEA:9 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_07,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 malwarescore=0 suspectscore=0 adultscore=0
 bulkscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230037

From: Abhinav Kumar <quic_abhinavk@quicinc.com>

Add HPD callback for the MST module which shall be invoked from the
dp_display's HPD handler to perform MST specific operations in case
of HPD. In MST case, route the HPD messages to MST module.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 15 ++++++++++++---
 drivers/gpu/drm/msm/dp/dp_mst_drm.c | 34 ++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/msm/dp/dp_mst_drm.h |  2 ++
 3 files changed, 48 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index abcab3ed43b6da5ef898355cf9b7561cd9fe0404..59720e1ad4b1193e33a4fc6aad0c401eaf9cbec8 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -500,9 +500,16 @@ static int msm_dp_display_handle_irq_hpd(struct msm_dp_display_private *dp)
 
 static int msm_dp_display_usbpd_attention_cb(struct device *dev)
 {
-	int rc = 0;
-	u32 sink_request;
 	struct msm_dp_display_private *dp = dev_get_dp_display_private(dev);
+	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
+	u32 sink_request;
+	int rc = 0;
+
+	if (msm_dp_display->mst_active) {
+		if (msm_dp_aux_is_link_connected(dp->aux) != ISR_DISCONNECTED)
+			msm_dp_mst_display_hpd_irq(&dp->msm_dp_display);
+		return 0;
+	}
 
 	/* check for any test request issued by sink */
 	rc = msm_dp_link_process_request(dp->link);
@@ -1129,8 +1136,10 @@ static irqreturn_t msm_dp_display_irq_thread(int irq, void *dev_id)
 	if (hpd_isr_status & DP_DP_HPD_UNPLUG_INT_MASK)
 		msm_dp_display_send_hpd_notification(dp, false);
 
-	if (hpd_isr_status & DP_DP_IRQ_HPD_INT_MASK)
+	if (hpd_isr_status & DP_DP_IRQ_HPD_INT_MASK) {
 		msm_dp_display_send_hpd_notification(dp, true);
+		msm_dp_irq_hpd_handle(dp, 0);
+	}
 
 	ret = IRQ_HANDLED;
 
diff --git a/drivers/gpu/drm/msm/dp/dp_mst_drm.c b/drivers/gpu/drm/msm/dp/dp_mst_drm.c
index b4f640134af544c77ab262d2cbe0b67e1e2e1b3a..331d08854049d9c74d49aa231f3507539986099e 100644
--- a/drivers/gpu/drm/msm/dp/dp_mst_drm.c
+++ b/drivers/gpu/drm/msm/dp/dp_mst_drm.c
@@ -567,6 +567,40 @@ static struct msm_dp_mst_bridge_state *msm_dp_mst_br_priv_state(struct drm_atomi
 	return to_msm_dp_mst_bridge_state_priv(obj_state);
 }
 
+/* DP MST HPD IRQ callback */
+void msm_dp_mst_display_hpd_irq(struct msm_dp *dp_display)
+{
+	int rc;
+	struct msm_dp_mst *mst = dp_display->msm_dp_mst;
+	u8 ack[8] = {};
+	u8 esi[4];
+	unsigned int esi_res = DP_SINK_COUNT_ESI + 1;
+	bool handled;
+
+	rc = drm_dp_dpcd_read(mst->dp_aux, DP_SINK_COUNT_ESI,
+			      esi, 4);
+	if (rc != 4) {
+		DRM_ERROR("dpcd sink status read failed, rlen=%d\n", rc);
+		return;
+	}
+
+	drm_dbg_dp(dp_display->drm_dev, "mst irq: esi1[0x%x] esi2[0x%x] esi3[%x]\n",
+		   esi[1], esi[2], esi[3]);
+
+	rc = drm_dp_mst_hpd_irq_handle_event(&mst->mst_mgr, esi, ack, &handled);
+
+	/* ack the request */
+	if (handled) {
+		rc = drm_dp_dpcd_writeb(mst->dp_aux, esi_res, ack[1]);
+
+		if (rc != 1)
+			DRM_ERROR("dpcd esi_res failed. rc=%d\n", rc);
+
+		drm_dp_mst_hpd_irq_send_new_request(&mst->mst_mgr);
+	}
+	drm_dbg_dp(dp_display->drm_dev, "mst display hpd_irq handled:%d rc:%d\n", handled, rc);
+}
+
 /* DP MST Connector OPs */
 static int
 msm_dp_mst_connector_detect(struct drm_connector *connector,
diff --git a/drivers/gpu/drm/msm/dp/dp_mst_drm.h b/drivers/gpu/drm/msm/dp/dp_mst_drm.h
index 1484fabd92ad0075eac5369aac8ca462acbd3eda..5e1b4db8aea4506b0e1cc1cc68980dd617d3f72a 100644
--- a/drivers/gpu/drm/msm/dp/dp_mst_drm.h
+++ b/drivers/gpu/drm/msm/dp/dp_mst_drm.h
@@ -86,4 +86,6 @@ int msm_dp_mst_drm_bridge_init(struct msm_dp *dp, struct drm_encoder *encoder);
 
 int msm_dp_mst_init(struct msm_dp *dp_display, u32 max_streams, struct drm_dp_aux *drm_aux);
 
+void msm_dp_mst_display_hpd_irq(struct msm_dp *dp_display);
+
 #endif /* _DP_MST_DRM_H_ */

-- 
2.34.1


