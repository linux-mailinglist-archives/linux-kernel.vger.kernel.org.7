Return-Path: <linux-kernel+bounces-784904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F15B3436F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 16:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09FD52070E7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 14:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F98D2FF141;
	Mon, 25 Aug 2025 14:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TOm4xyma"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCA92FE595
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756131491; cv=none; b=iCgkRcZHjqeVMIDAp4wwbTALZD+V5xXEwbJjtZqnVOswaXxpT6EW6hKNceFvMM9hqCJpopGmJDXVP9wmexYGvuiqQeXLd3vMqN0tu0L8JMe2KfScOg7gmReiRHSfd7loYnB0bkDUMoHlBSLImD+RUh3noEXrI7l+zQNp3y5h2T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756131491; c=relaxed/simple;
	bh=g9j4dHhbEalwPYL39kR4TH2YQX9Eywf1+tqHRUmVMPU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mkcMPuz+ykg4REEXXjUMvBiIBLXrIvIshA3f2PCT30k5q2V9SynIj0actg0n/NP3//CxHucs0PLj6unxU7hlWWOFCxm99HGMIj5qxWyuQ1TDdNzfz0SiEucPr3xAckRsps2xL4lk7Z78egqeFjQzbOTwEAEfW1OxXp8ck11U29w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TOm4xyma; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57P8gVvs013270
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:18:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tBwCmuwAHbTtGAcRsBoFJ+AI89eKm8SWnqPMRvJR7FU=; b=TOm4xymaNcdLL6x4
	EAhyFdpyFyADxWKJ9FaqJzq4V8iWphNWr+dbTrnw0FGHarMyco8Ei2a2wNwFnLpf
	kMGxNE/RxzlG+1XsZPy7f8xVlBJV0Y0P0q94C3DwIjhWNupgPD/GZ9IGO0bNcOW3
	q1p0dIbcXGEpCxPUDANlcForNRLV7mIwaJqkLnTTe4TTbPro1y0PTypvHCIeQtx8
	zeAF/FKOaGXRQ6d2fRNhR69e3QP1FFQR+QeUlKuoOSJ2NUpJ5CD9WDG7kyp/jhx9
	HQ2bvAVraYT4w8ItfGfJFj8vLae19MncP5ZKxhuT+STaWPzfaYZyf8w3mxEWXFi8
	Ru1fuQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5xpnenn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:18:04 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-771e7d00fd4so1149190b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 07:18:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756131484; x=1756736284;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tBwCmuwAHbTtGAcRsBoFJ+AI89eKm8SWnqPMRvJR7FU=;
        b=WzKvHdmVDTu5gko3/j1ZVp66VOAUuVSIItnrFds9qQueN0Z9C2m+QDN+qJGy4S0/qD
         Jv5Xz7nEpx2TKSdsP1iWTx7u1Ym5kpQCc4M1TU8UiBRO0d59CKo1NcyugNz0jp9orltp
         6tN+zsO4Qk7COp9wSYE73/w7xHmoQbOXf25oyWUB93d/IDXEQ7wv1jx582GQe6CHzOiX
         aZjirPW6BmBKp1yauRZYE5Ae/5RCnndsLqLTHCbq48un/obRh49BG87CD/0yGsm0aumx
         Pupm4BV5tsPAee3WYd5agCn2KpZu9uqes7EjkUmJBsrFAKP2B1+f51aqyZYF9dsO4j7W
         7UhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrw6oHeIiSZHKfgCCiMW3KqJqc/QjCnY8BIEAsE24XjJxOsIHStl+599mRr5+2lcIXJCgZ5aAQUHuJVcw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUchev1n+jYTcSmJ9JjcnrGWwtnkiNU/VZlW8ACOKoOYq6KsYq
	xwGlcBteyag4ZSOFS7VD52AsiCBLOnmmoF0Gtdc1IMdkCeOvRaXc5TZDBZJcg0JXLwcvwRK72V7
	6Ha7ls84+RoEa9uIgH8Hbs/GF1lkhXFSEOXwNHVT1z5u24Vu+FoxLbXuaPQc3Oe0Jcqo=
X-Gm-Gg: ASbGnctDDxCF3wf1Frh+CkwzsQw+3UZLQcbptAQS4VOfBNCGNx+M2+LwxfsB90v7Dq4
	NCL36PFe2cIItKOABAMrcCBkqq0beYEZb5dIKiYE3pFxHJRXE3CSgVJD4gQ36It5wVPCyOA8ToX
	IHg9J8YxG5adjKp+fxpMp1OckQJ6nWJAY0VhNElG9l8NzOdVu4+LlTiUfvQK1zmaT0J3M0cdJpU
	/f6J6+v2ocJLgfWl/PQpARVczZJxudAWCw3tPFX3NedoIfWOUDKW0rBWIAuv0oLreQg2x1g9lm6
	3Nmsy1A1LryIpQidYKmJEQfXQeVWXLrngoa8Ma+/TPa6O6Ifxkhr4tsNcx7ZzwbqRyRowgQ=
X-Received: by 2002:a05:6a00:138c:b0:770:2c2f:6435 with SMTP id d2e1a72fcca58-7702faafbcemr14035366b3a.20.1756131483524;
        Mon, 25 Aug 2025 07:18:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGjxr5F6lod1JbDLr/GUPk8FxbZXGeIugi3bH9jK5M1cKAfiGwJzXfKF8Hm8LHnfmSC1FdLQ==
X-Received: by 2002:a05:6a00:138c:b0:770:2c2f:6435 with SMTP id d2e1a72fcca58-7702faafbcemr14035327b3a.20.1756131482840;
        Mon, 25 Aug 2025 07:18:02 -0700 (PDT)
Received: from cse-cd01-lnx.ap.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770401eb20dsm7672339b3a.79.2025.08.25.07.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 07:18:02 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Mon, 25 Aug 2025 22:15:59 +0800
Subject: [PATCH v3 13/38] drm/msm/dp: introduce stream_id for each DP panel
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250825-msm-dp-mst-v3-13-01faacfcdedd@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756131420; l=12337;
 i=yongxing.mou@oss.qualcomm.com; s=20241121; h=from:subject:message-id;
 bh=8mqJWU084vDxzCM+Kcn603L6BY3TiY78EJVx8yyw1MM=;
 b=ufHWehrJK/WfU/3m4tznClnPqHyNs67vJ3ZIVkpU5r6KGcSbNBOJidQk4EhrorYYqA5cWB5RC
 2Soq7FwFV+RDt+ksCITiXA3hpyKI0yBNMugKXFpnYzmgJuUAS7g0qSD
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=zeCnFRUqtOQMeFvdwex2M5o0Yf67UHYfwCyBRQ3kFbU=
X-Authority-Analysis: v=2.4 cv=KOlaDEFo c=1 sm=1 tr=0 ts=68ac709c cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=3Q5v3ENETf2jWLhp-IIA:9 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: kzPa7XQkjWT7Zq1SqvRkaOL-NBmp2XHT
X-Proofpoint-ORIG-GUID: kzPa7XQkjWT7Zq1SqvRkaOL-NBmp2XHT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfX2s/N3jGMMzoL
 Oog48KNHmThqUjR3ZiY+n3kUIdNM6hIzhEnmvDrHgRPT/85rAOePwa/mxTfz3qL2QsFyYUVNEWT
 ZPLoi9Rb0LVBTFYvheeHt5Ntqhsmlay1US7FySMbSUupNx/vLWPoHK1mcjg1tId15Uw3TIy0zDH
 VW/EaQgiPt49cE/gmRtXx8YLkDEtNh1uVrIOmNE4IunZTSweVI3iH2XdTqD3LyO4+uTbUoCtsOQ
 jn/u588TJ9eaVOK1ngcHRVgqqiS3nRj98VMM1NfAvG5DG60MutywFuZozqOs0ODkXUwUceu+5q4
 hKA/kZxqJBtD8ZW7zH8qWlP3OFvl69z76x65kgYbyywGdLizHXrOD4jsrVFMCcXtFYp0dbDO2a6
 oH8u2ohV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_07,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 bulkscore=0 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230033

From: Abhinav Kumar <quic_abhinavk@quicinc.com>

With MST, each DP controller can handle multiple streams.
There shall be one dp_panel for each stream but the dp_display
object shall be shared among them. To represent this abstraction,
create a stream_id for each DP panel which shall be set by the
MST stream. For SST, default this to stream 0.

Use the stream ID to control the pixel clock of that respective
stream by extending the clock handles and state tracking of the
DP pixel clock to an array of max supported streams. The maximum
streams currently is 4.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c    | 58 ++++++++++++++++++++++---------------
 drivers/gpu/drm/msm/dp/dp_ctrl.h    |  3 +-
 drivers/gpu/drm/msm/dp/dp_display.c | 27 +++++++++++++++--
 drivers/gpu/drm/msm/dp/dp_display.h |  2 ++
 drivers/gpu/drm/msm/dp/dp_panel.h   | 11 +++++++
 5 files changed, 73 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index b25eb2fa2835f660073b5109496ac9f2f4e038d2..d4a74c6b70fb182ad8a0a786f85a0f50982d3858 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -127,7 +127,7 @@ struct msm_dp_ctrl_private {
 	unsigned int num_link_clks;
 	struct clk_bulk_data *link_clks;
 
-	struct clk *pixel_clk;
+	struct clk *pixel_clk[DP_STREAM_MAX];
 
 	union phy_configure_opts phy_opts;
 
@@ -139,7 +139,7 @@ struct msm_dp_ctrl_private {
 
 	bool core_clks_on;
 	bool link_clks_on;
-	bool stream_clks_on;
+	bool stream_clks_on[DP_STREAM_MAX];
 };
 
 static inline u32 msm_dp_read_ahb(const struct msm_dp_ctrl_private *ctrl, u32 offset)
@@ -2162,39 +2162,40 @@ static bool msm_dp_ctrl_send_phy_test_pattern(struct msm_dp_ctrl_private *ctrl)
 	return success;
 }
 
-static int msm_dp_ctrl_on_pixel_clk(struct msm_dp_ctrl_private *ctrl, unsigned long pixel_rate)
+static int msm_dp_ctrl_on_pixel_clk(struct msm_dp_ctrl_private *ctrl, unsigned long pixel_rate,
+				    enum msm_dp_stream_id stream_id)
 {
 	int ret;
 
-	ret = clk_set_rate(ctrl->pixel_clk, pixel_rate * 1000);
+	ret = clk_set_rate(ctrl->pixel_clk[stream_id], pixel_rate * 1000);
 	if (ret) {
 		DRM_ERROR("Failed to set pixel clock rate. ret=%d\n", ret);
 		return ret;
 	}
 
-	if (ctrl->stream_clks_on) {
+	if (ctrl->stream_clks_on[stream_id]) {
 		drm_dbg_dp(ctrl->drm_dev, "pixel clks already enabled\n");
 	} else {
-		ret = clk_prepare_enable(ctrl->pixel_clk);
+		ret = clk_prepare_enable(ctrl->pixel_clk[stream_id]);
 		if (ret) {
 			DRM_ERROR("Failed to start pixel clocks. ret=%d\n", ret);
 			return ret;
 		}
-		ctrl->stream_clks_on = true;
+		ctrl->stream_clks_on[stream_id] = true;
 	}
 
 	return ret;
 }
 
-void msm_dp_ctrl_off_pixel_clk(struct msm_dp_ctrl *msm_dp_ctrl)
+void msm_dp_ctrl_off_pixel_clk(struct msm_dp_ctrl *msm_dp_ctrl, enum msm_dp_stream_id stream_id)
 {
 	struct msm_dp_ctrl_private *ctrl;
 
 	ctrl = container_of(msm_dp_ctrl, struct msm_dp_ctrl_private, msm_dp_ctrl);
 
-	if (ctrl->stream_clks_on) {
-		clk_disable_unprepare(ctrl->pixel_clk);
-		ctrl->stream_clks_on = false;
+	if (ctrl->stream_clks_on[stream_id]) {
+		clk_disable_unprepare(ctrl->pixel_clk[stream_id]);
+		ctrl->stream_clks_on[stream_id] = false;
 	}
 }
 
@@ -2214,7 +2215,7 @@ static int msm_dp_ctrl_process_phy_test_request(struct msm_dp_ctrl_private *ctrl
 	 * running. Add the global reset just before disabling the
 	 * link clocks and core clocks.
 	 */
-	msm_dp_ctrl_off_pixel_clk(&ctrl->msm_dp_ctrl);
+	msm_dp_ctrl_off_pixel_clk(&ctrl->msm_dp_ctrl, ctrl->panel->stream_id);
 	msm_dp_ctrl_off_link(&ctrl->msm_dp_ctrl);
 
 	ret = msm_dp_ctrl_on_link(&ctrl->msm_dp_ctrl);
@@ -2224,7 +2225,7 @@ static int msm_dp_ctrl_process_phy_test_request(struct msm_dp_ctrl_private *ctrl
 	}
 
 	pixel_rate = ctrl->panel->msm_dp_mode.drm_mode.clock;
-	ret = msm_dp_ctrl_on_pixel_clk(ctrl, pixel_rate);
+	ret = msm_dp_ctrl_on_pixel_clk(ctrl, pixel_rate, ctrl->panel->stream_id);
 
 	msm_dp_ctrl_send_phy_test_pattern(ctrl);
 
@@ -2499,9 +2500,8 @@ int msm_dp_ctrl_prepare_stream_on(struct msm_dp_ctrl *msm_dp_ctrl, bool force_li
 		ctrl->link->link_params.rate,
 		ctrl->link->link_params.num_lanes);
 
-	drm_dbg_dp(ctrl->drm_dev,
-		"core_clk_on=%d link_clk_on=%d stream_clk_on=%d\n",
-		ctrl->core_clks_on, ctrl->link_clks_on, ctrl->stream_clks_on);
+	drm_dbg_dp(ctrl->drm_dev, "core_clk_on=%d link_clk_on=%d\n",
+		ctrl->core_clks_on, ctrl->link_clks_on);
 
 	if (!ctrl->link_clks_on) { /* link clk is off */
 		ret = msm_dp_ctrl_enable_mainlink_clocks(ctrl);
@@ -2540,7 +2540,7 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *
 
 	drm_dbg_dp(ctrl->drm_dev, "pixel_rate=%lu\n", pixel_rate);
 
-	ret = msm_dp_ctrl_on_pixel_clk(ctrl, pixel_rate);
+	ret = msm_dp_ctrl_on_pixel_clk(ctrl, pixel_rate, msm_dp_panel->stream_id);
 	if (ret) {
 		DRM_ERROR("failed to enable pixel clk\n");
 		return ret;
@@ -2604,8 +2604,6 @@ void msm_dp_ctrl_off_link(struct msm_dp_ctrl *msm_dp_ctrl)
 	ctrl = container_of(msm_dp_ctrl, struct msm_dp_ctrl_private, msm_dp_ctrl);
 	phy = ctrl->phy;
 
-	msm_dp_panel_disable_vsc_sdp(ctrl->panel);
-
 	msm_dp_ctrl_mainlink_disable(ctrl);
 
 	msm_dp_ctrl_reset(&ctrl->msm_dp_ctrl);
@@ -2677,10 +2675,11 @@ static const char *ctrl_clks[] = {
 	"ctrl_link_iface",
 };
 
-static int msm_dp_ctrl_clk_init(struct msm_dp_ctrl *msm_dp_ctrl)
+static int msm_dp_ctrl_clk_init(struct msm_dp_ctrl *msm_dp_ctrl, int max_stream)
 {
 	struct msm_dp_ctrl_private *ctrl;
 	struct device *dev;
+	char stream_id_str[15];
 	int i, rc;
 
 	ctrl = container_of(msm_dp_ctrl, struct msm_dp_ctrl_private, msm_dp_ctrl);
@@ -2710,9 +2709,19 @@ static int msm_dp_ctrl_clk_init(struct msm_dp_ctrl *msm_dp_ctrl)
 	if (rc)
 		return rc;
 
-	ctrl->pixel_clk = devm_clk_get(dev, "stream_pixel");
-	if (IS_ERR(ctrl->pixel_clk))
-		return PTR_ERR(ctrl->pixel_clk);
+	ctrl->pixel_clk[DP_STREAM_0] = devm_clk_get(dev, "stream_pixel");
+	if (IS_ERR(ctrl->pixel_clk[DP_STREAM_0]))
+		return PTR_ERR(ctrl->pixel_clk[DP_STREAM_0]);
+
+	for (i = DP_STREAM_1; i < max_stream; i++) {
+		sprintf(stream_id_str, "stream_%d_pixel", i);
+		ctrl->pixel_clk[i] = devm_clk_get(dev, stream_id_str);
+
+		if (IS_ERR(ctrl->pixel_clk[i])) {
+			DRM_DEBUG_DP("failed to get stream %d pixel clock", i);
+			break;
+		}
+	}
 
 	return 0;
 }
@@ -2720,6 +2729,7 @@ static int msm_dp_ctrl_clk_init(struct msm_dp_ctrl *msm_dp_ctrl)
 struct msm_dp_ctrl *msm_dp_ctrl_get(struct device *dev, struct msm_dp_link *link,
 			struct msm_dp_panel *panel,	struct drm_dp_aux *aux,
 			struct phy *phy,
+			int max_stream,
 			void __iomem *ahb_base,
 			void __iomem *link_base)
 {
@@ -2762,7 +2772,7 @@ struct msm_dp_ctrl *msm_dp_ctrl_get(struct device *dev, struct msm_dp_link *link
 	ctrl->ahb_base = ahb_base;
 	ctrl->link_base = link_base;
 
-	ret = msm_dp_ctrl_clk_init(&ctrl->msm_dp_ctrl);
+	ret = msm_dp_ctrl_clk_init(&ctrl->msm_dp_ctrl, max_stream);
 	if (ret) {
 		dev_err(dev, "failed to init clocks\n");
 		return ERR_PTR(ret);
diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.h b/drivers/gpu/drm/msm/dp/dp_ctrl.h
index 6ff3e9d9fa6ff0afa325a7a6f72a15009635f340..32ff1455caf0e7fcb1bd74b1f3192c6c3c03ee74 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.h
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.h
@@ -20,7 +20,7 @@ int msm_dp_ctrl_on_link(struct msm_dp_ctrl *msm_dp_ctrl);
 int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *msm_dp_panel);
 int msm_dp_ctrl_prepare_stream_on(struct msm_dp_ctrl *msm_dp_ctrl, bool force_link_train);
 void msm_dp_ctrl_off_link(struct msm_dp_ctrl *msm_dp_ctrl);
-void msm_dp_ctrl_off_pixel_clk(struct msm_dp_ctrl *msm_dp_ctrl);
+void msm_dp_ctrl_off_pixel_clk(struct msm_dp_ctrl *msm_dp_ctrl, enum msm_dp_stream_id stream_id);
 void msm_dp_ctrl_push_idle(struct msm_dp_ctrl *msm_dp_ctrl);
 irqreturn_t msm_dp_ctrl_isr(struct msm_dp_ctrl *msm_dp_ctrl);
 void msm_dp_ctrl_handle_sink_request(struct msm_dp_ctrl *msm_dp_ctrl);
@@ -29,6 +29,7 @@ struct msm_dp_ctrl *msm_dp_ctrl_get(struct device *dev,
 				    struct msm_dp_panel *panel,
 				    struct drm_dp_aux *aux,
 				    struct phy *phy,
+				    int max_stream,
 				    void __iomem *ahb_base,
 				    void __iomem *link_base);
 
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index a8477a0a180137f15cbb1401c3964636aa32626c..3422f18bdec71a99407edfe943d31957d0e8847a 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -628,7 +628,7 @@ static int msm_dp_init_sub_modules(struct msm_dp_display_private *dp)
 	}
 
 	dp->ctrl = msm_dp_ctrl_get(dev, dp->link, dp->panel, dp->aux,
-			       phy, dp->ahb_base, dp->link_base);
+			       phy, dp->max_stream, dp->ahb_base, dp->link_base);
 	if (IS_ERR(dp->ctrl)) {
 		rc = PTR_ERR(dp->ctrl);
 		DRM_ERROR("failed to initialize ctrl, rc = %d\n", rc);
@@ -789,7 +789,7 @@ static int msm_dp_display_disable(struct msm_dp_display_private *dp)
 
 		/* set dongle to D3 (power off) mode */
 		msm_dp_link_psm_config(dp->link, &dp->panel->link_info, true);
-		msm_dp_ctrl_off_pixel_clk(dp->ctrl);
+		msm_dp_ctrl_off_pixel_clk(dp->ctrl, dp->panel->stream_id);
 		msm_dp_ctrl_off_link(dp->ctrl);
 		/* re-init the PHY so that we can listen to Dongle disconnect */
 		msm_dp_ctrl_reinit_phy(dp->ctrl);
@@ -798,7 +798,7 @@ static int msm_dp_display_disable(struct msm_dp_display_private *dp)
 		 * unplugged interrupt
 		 * dongle unplugged out of DUT
 		 */
-		msm_dp_ctrl_off_pixel_clk(dp->ctrl);
+		msm_dp_ctrl_off_pixel_clk(dp->ctrl, dp->panel->stream_id);
 		msm_dp_ctrl_off_link(dp->ctrl);
 		msm_dp_display_host_phy_exit(dp);
 	}
@@ -809,6 +809,25 @@ static int msm_dp_display_disable(struct msm_dp_display_private *dp)
 	return 0;
 }
 
+int msm_dp_display_set_stream_id(struct msm_dp *dp,
+				 struct msm_dp_panel *panel, enum msm_dp_stream_id stream_id)
+{
+	int rc = 0;
+	struct msm_dp_display_private *msm_dp_display;
+
+	msm_dp_display = container_of(dp, struct msm_dp_display_private, msm_dp_display);
+
+	if (!msm_dp_display) {
+		DRM_ERROR("invalid input\n");
+		return -EINVAL;
+	}
+
+	if (panel)
+		panel->stream_id = stream_id;
+
+	return rc;
+}
+
 /**
  * msm_dp_bridge_mode_valid - callback to determine if specified mode is valid
  * @dp: Pointer to dp display structure
@@ -1483,6 +1502,8 @@ void msm_dp_display_atomic_enable(struct msm_dp *msm_dp_display)
 
 	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
 
+	msm_dp_display_set_stream_id(msm_dp_display, dp->panel, 0);
+
 	if (msm_dp_display->prepared) {
 		rc = msm_dp_display_enable(dp);
 		if (rc)
diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
index 7727cf325a89b4892d2370a5616c4fa76fc88485..a839d0a3941eac3e277185e42fddea15ca05a17f 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.h
+++ b/drivers/gpu/drm/msm/dp/dp_display.h
@@ -47,5 +47,7 @@ void msm_dp_display_mode_set(struct msm_dp *dp,
 enum drm_mode_status msm_dp_display_mode_valid(struct msm_dp *dp,
 					       const struct drm_display_info *info,
 					       const struct drm_display_mode *mode);
+int msm_dp_display_set_stream_id(struct msm_dp *dp,
+				 struct msm_dp_panel *panel, enum msm_dp_stream_id stream_id);
 
 #endif /* _DP_DISPLAY_H_ */
diff --git a/drivers/gpu/drm/msm/dp/dp_panel.h b/drivers/gpu/drm/msm/dp/dp_panel.h
index 618d0253b525308b392b9282098e8ca78bf32f1c..23b3e78e40479d133893a8afe1a69cfe8c16abdf 100644
--- a/drivers/gpu/drm/msm/dp/dp_panel.h
+++ b/drivers/gpu/drm/msm/dp/dp_panel.h
@@ -27,6 +27,15 @@ struct msm_dp_panel_psr {
 	u8 capabilities;
 };
 
+/* stream id */
+enum msm_dp_stream_id {
+	DP_STREAM_0,
+	DP_STREAM_1,
+	DP_STREAM_2,
+	DP_STREAM_3,
+	DP_STREAM_MAX,
+};
+
 struct msm_dp_panel {
 	/* dpcd raw data */
 	u8 dpcd[DP_RECEIVER_CAP_SIZE];
@@ -40,6 +49,8 @@ struct msm_dp_panel {
 	bool vsc_sdp_supported;
 	u32 hw_revision;
 
+	enum msm_dp_stream_id stream_id;
+
 	u32 max_dp_lanes;
 	u32 max_dp_link_rate;
 

-- 
2.34.1


