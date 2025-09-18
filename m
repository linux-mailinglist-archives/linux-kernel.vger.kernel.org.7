Return-Path: <linux-kernel+bounces-784916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55654B34390
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 16:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7823203050
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 14:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1403630103E;
	Mon, 25 Aug 2025 14:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GEUoI8gg"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2124301482
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756131534; cv=none; b=ZUWzVZV4Fh9AZQbnGJH++eb23+bnNqw+BCHRktRNhf7n7ofKM39lM5aML15s4RFys5vt/3Wduddo3+AARBL1lfzUbXTC3fvjYtZ1RLihV1rowRKCdgV1ulWclf0M6bbArLVHncfz7wmhkk/vofdNOIbuukjVfQp1FkPfRdgIWSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756131534; c=relaxed/simple;
	bh=ok2J1ncKZhzq6h8j0iyyMlsBdkk+QSoAY2tlcPlXCOE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Twq93zi0idGAEBXfZXQ0NtQ65jIOGzDRSqLMIDms4wW5qGVF88q/ND5W7b45eSeyycP2rk5HCsvBW2QL8E03gn8puHasqCQ8KICiKv3sDxHF3ZeSZnTC8rcMyCIVU+n7Ywodyai1msZyavhnAE68HuKTyW04rAt/ZuSTHKjhL0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GEUoI8gg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57P8I78k021749
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:18:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qSyq8KcWWc9SY8S9T7BYsynBMQBCpqZsSmzW34yxxkU=; b=GEUoI8ggB360UQD4
	/qhtxeoSHfBYO8ZUmY3haNumkCE9dgCIYWmkjZZziftcH2DZ/5zyKYYCrT29/Wkt
	gqQA/pAwwioZEp2P31p3gG7zoaHV3cpgWUkJBahGoKj2jtHThZ5gxNR6ZiXx1CHR
	TvIybqoX64oh8D6nk2wdddW+E256CTC2yKIGBGXoUBGZDTOiK2fk1vWnt/uLtV/t
	GAQkdeVOAqhjB5dm2TlYwOE71yyB6P0iX/Njqcs2ZDS6DjN3ZxoKxXYW/ykoQmQh
	syUFXesNH9vrZspxtEXws04FrcLZ+qBA7xYXrqIY+SGGs3Cz6tKBHP+Edrr0P8Dr
	rc+YYA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5w2nffm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:18:50 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-76e2e5c4734so4476975b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 07:18:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756131530; x=1756736330;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qSyq8KcWWc9SY8S9T7BYsynBMQBCpqZsSmzW34yxxkU=;
        b=wMHlNl7KvmqjxYYZZx/1L5uv3O7TwLfg90H8p/02B/dJeE9i+Z7h+IS92D9TDomM2/
         6JrI+Dcj0g85DazUlz1ZQOVJeru9UCc+whlxxdYkGPBgIii1GjFtuHnUjusT7y79y/R2
         3myp0LE1+KS3D695jX0dCfdf7CkUKG9nMDF/Fs4oezEE1aayb2VBLgSZEsa9PaubtegK
         puNyS+T1/n5S/yQwnn2Zbzwbh9dScamOkDXgM1a7t4P3qwDhN4NI2DXmChUtnOytdWix
         q2b1euS7P3qzDizVIX6rNkWSDtA4q96GYLrd/1UMp6D8nBDH3bO6CuI6DFXqsHNIEcmA
         /RRw==
X-Forwarded-Encrypted: i=1; AJvYcCUiVo/T9nZYgnjsrxl1aLbxAnA+UaimllfLshwwjVYaPC3O6xWBonPodIg8ni1sddKZxfChbwR+AgZToT4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqy2tt3158p2JMW3J2iki7jYbuZf7+jbNGnv7jLOHlCSRnJfr0
	MUz8rre83/pVV6gBOeNlY51kCWjeCx/OBj0+p1n7xXJwXtcFJ5d3oSAdRbHq0y6ox/QzVH47cLK
	2yjGuFEjWHqwrdWrPIkqn5P8bE0FPXWIq41Y+v5bELBlQ68NlfTM+uY5YxxTv8Unz5FY=
X-Gm-Gg: ASbGnctzp0IQvwWxdCutm+rW1ToEUt1bDBZ+Z5QOzJ1/78d8t4SFwhQ1hOz0yffUzCL
	g3cwJYhcjddbezO0nPF23AO/Uao42zXq/xLhMuv71YhPP5MeJqm+45bNZ/A8MZVaw1a28kN5liK
	o0Rp75jGrzTFfYu9JcvCn/T5OUkkQ3hXNrdQ1ijqqQMNi0aeir8tuQ/pYtBv5kt2v7x8yd+AYHN
	Eba8vSVDtdY262vNgd+MKqU7fIrmExeFDkHC0VALB88WMFxJg4MQL7EhONmTiLD9OimYEraiYdW
	quC+/W3WCW0Lhbz2+o8tO+Pk9k5BShsAw05aKVAnOcsAv6sBAEVHbFQGAD/gB+CMeOKaaSU=
X-Received: by 2002:a05:6a00:391f:b0:76e:99fc:db8d with SMTP id d2e1a72fcca58-7702fa08e63mr14047918b3a.3.1756131529833;
        Mon, 25 Aug 2025 07:18:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdWfy/69r29Z8S5fLfch/hFfgjrzV796tf8bajnXTxbMLA8UFoOV3MUvUSypvtfuCMn8n0aA==
X-Received: by 2002:a05:6a00:391f:b0:76e:99fc:db8d with SMTP id d2e1a72fcca58-7702fa08e63mr14047878b3a.3.1756131529311;
        Mon, 25 Aug 2025 07:18:49 -0700 (PDT)
Received: from cse-cd01-lnx.ap.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770401eb20dsm7672339b3a.79.2025.08.25.07.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 07:18:48 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Mon, 25 Aug 2025 22:16:10 +0800
Subject: [PATCH v3 24/38] drm/msm/dp: replace power_on with
 active_stream_cnt for dp_display
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250825-msm-dp-mst-v3-24-01faacfcdedd@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756131422; l=6349;
 i=yongxing.mou@oss.qualcomm.com; s=20241121; h=from:subject:message-id;
 bh=Wmlm2KyLe1jBJ73nlakE9DMYOCD/MAofE3UhilE1SZs=;
 b=S7RZjos+LEElqVTvRT9EXfqvPpuPCqk3yJcpgRrk9APeu7hnseMXL4DOodYBGeI148NuqozfJ
 QNdhnoNk/AsDvTadx2oGD5MhSSIQsQLsYSRBg+jJNjlas6LnBaP8OCj
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=zeCnFRUqtOQMeFvdwex2M5o0Yf67UHYfwCyBRQ3kFbU=
X-Authority-Analysis: v=2.4 cv=Z/vsHGRA c=1 sm=1 tr=0 ts=68ac70ca cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=qjupdTMWzssTVndNP84A:9 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfX/2BMr/d4cVQ0
 vCtAIu4YTL59FgehaumPta3TpnTntBsoZac8j0+XCYC1xgWzxMvMeDrlLNq7/2KuLktTFfjbjrp
 uQZtls5EqG73M4RRNE+7EqqkGV2viK2/hKfbwfWL6WM7c2MKT1cNT5Sfq5kEKvdyPDMTMgAqjB+
 LcNTJV1d9evbZ8C13Vdc8rg9zxv/hSLMjoRaesWoP0aW7EjLSVNQQmSGKMZtfECX8rOENhJug0E
 4ZIlvEEeOCyW/VoA5E2eWR7Xh9kqn3Kh4Y91yueFqJr+P5PaNDqfzxOxbBe+GWZAmXsL+O/0fP/
 ftikaZ9To8Ygl4L20QKKH5YiWizxQBp4/G8kLbnRCL6Xt6kfjwNCPRiZZkIVjqXV4Yn5SZsftDe
 AzEryxzh
X-Proofpoint-GUID: EhyYWqU3jaDYIVaEFw6MWyhBDIwgJ1y3
X-Proofpoint-ORIG-GUID: EhyYWqU3jaDYIVaEFw6MWyhBDIwgJ1y3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_07,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 phishscore=0 clxscore=1015
 suspectscore=0 impostorscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230033

From: Abhinav Kumar <quic_abhinavk@quicinc.com>

For DP MST, the link clock and power domain resources stay on until
both streams have been disabled OR we receive hotplug. Introduce an
active_stream_cnt to track the number of active streams and necessary
state handling. Replace the power_on variable with active_stream_cnt
as power_on boolean works only for a single stream.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_audio.c   |  2 +-
 drivers/gpu/drm/msm/dp/dp_display.c | 50 ++++++++++++++++++++++++-------------
 drivers/gpu/drm/msm/dp/dp_display.h |  3 ++-
 3 files changed, 36 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_audio.c b/drivers/gpu/drm/msm/dp/dp_audio.c
index 41018e82efa10ec863eb4b60d8df66c23c432fa5..e84c8b8e83d9ec689c0d29e8ac69860a745a4877 100644
--- a/drivers/gpu/drm/msm/dp/dp_audio.c
+++ b/drivers/gpu/drm/msm/dp/dp_audio.c
@@ -284,7 +284,7 @@ int msm_dp_audio_prepare(struct drm_bridge *bridge,
 	 * such cases check for connection status and bail out if not
 	 * connected.
 	 */
-	if (!msm_dp_display->power_on) {
+	if (!msm_dp_display_get_active_stream_cnt(msm_dp_display)) {
 		rc = -EINVAL;
 		goto end;
 	}
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 0815973e6597492e09f33359d9777c0e8ce31e0d..e2e6b0ea2f9dbfe49a599ca19b1d205669365c4c 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -73,6 +73,8 @@ struct msm_dp_display_private {
 
 	bool wide_bus_supported;
 
+	u32 active_stream_cnt;
+
 	struct msm_dp_audio *audio;
 
 	void __iomem *ahb_base;
@@ -175,6 +177,15 @@ static const struct of_device_id msm_dp_dt_match[] = {
 	{}
 };
 
+int msm_dp_display_get_active_stream_cnt(struct msm_dp *msm_dp_display)
+{
+	struct msm_dp_display_private *dp;
+
+	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
+
+	return dp->active_stream_cnt;
+}
+
 static struct msm_dp_display_private *dev_get_dp_display_private(struct device *dev)
 {
 	struct msm_dp *dp = dev_get_drvdata(dev);
@@ -709,15 +720,17 @@ static int msm_dp_display_prepare(struct msm_dp_display_private *dp)
 	if (dp->link->sink_count == 0)
 		return rc;
 
-	if (msm_dp_display->link_ready && !msm_dp_display->power_on) {
+	if (msm_dp_display->link_ready && !dp->active_stream_cnt) {
 		msm_dp_display_host_phy_init(dp);
 		force_link_train = true;
 	}
 
-	rc = msm_dp_ctrl_on_link(dp->ctrl, msm_dp_display->mst_active);
-	if (rc) {
-		DRM_ERROR("Failed link training (rc=%d)\n", rc);
-		msm_dp_display->connector->state->link_status = DRM_LINK_STATUS_BAD;
+	if (!dp->active_stream_cnt) {
+		rc = msm_dp_ctrl_on_link(dp->ctrl, msm_dp_display->mst_active);
+		if (rc) {
+			DRM_ERROR("Failed link training (rc=%d)\n", rc);
+			msm_dp_display->connector->state->link_status = DRM_LINK_STATUS_BAD;
+		}
 	}
 
 	rc = msm_dp_ctrl_prepare_stream_on(dp->ctrl, force_link_train);
@@ -731,17 +744,10 @@ static int msm_dp_display_enable(struct msm_dp_display_private *dp,
 				 struct msm_dp_panel *msm_dp_panel)
 {
 	int rc = 0;
-	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
 
 	drm_dbg_dp(dp->drm_dev, "sink_count=%d\n", dp->link->sink_count);
-	if (msm_dp_display->power_on) {
-		drm_dbg_dp(dp->drm_dev, "Link already setup, return\n");
-		return 0;
-	}
 
 	rc = msm_dp_ctrl_on_stream(dp->ctrl, msm_dp_panel, dp->max_stream);
-	if (!rc)
-		msm_dp_display->power_on = true;
 
 	return rc;
 }
@@ -788,16 +794,14 @@ static void msm_dp_display_audio_notify_disable(struct msm_dp_display_private *d
 static int msm_dp_display_disable(struct msm_dp_display_private *dp,
 				  struct msm_dp_panel *msm_dp_panel)
 {
-	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
-
-	if (!msm_dp_display->power_on)
+	if (!dp->active_stream_cnt)
 		return 0;
 
 	msm_dp_panel_disable_vsc_sdp(msm_dp_panel);
 
 	msm_dp_ctrl_off_pixel_clk(dp->ctrl, msm_dp_panel->stream_id);
 
-	msm_dp_display->power_on = false;
+	dp->active_stream_cnt--;
 
 	drm_dbg_dp(dp->drm_dev, "sink count: %d\n", dp->link->sink_count);
 	return 0;
@@ -934,7 +938,7 @@ void msm_dp_snapshot(struct msm_disp_state *disp_state, struct msm_dp *dp)
 	 * power_on status before dumping DP registers to avoid crash due
 	 * to unclocked access
 	 */
-	if (!dp->power_on)
+	if (!msm_dp_display->active_stream_cnt)
 		return;
 
 	msm_disp_snapshot_add_block(disp_state, msm_dp_display->ahb_len,
@@ -1543,6 +1547,8 @@ void msm_dp_display_enable_helper(struct msm_dp *msm_dp_display, struct msm_dp_p
 		}
 	}
 
+	dp->active_stream_cnt++;
+
 	drm_dbg_dp(msm_dp_display->drm_dev, "type=%d Done\n", msm_dp_display->connector_type);
 }
 
@@ -1564,6 +1570,11 @@ void msm_dp_display_disable_helper(struct msm_dp *msm_dp_display,
 
 	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
 
+	if (!dp->active_stream_cnt) {
+		drm_dbg_dp(dp->drm_dev, "no active streams\n");
+		return;
+	}
+
 	msm_dp_ctrl_push_idle(dp->ctrl, msm_dp_panel);
 	msm_dp_ctrl_mst_stream_channel_slot_setup(dp->ctrl,
 		dp->max_stream);
@@ -1590,6 +1601,11 @@ void msm_dp_display_unprepare(struct msm_dp *msm_dp_display)
 		return;
 	}
 
+	if (dp->active_stream_cnt) {
+		drm_dbg_dp(dp->drm_dev, "stream still active, return\n");
+		return;
+	}
+
 	/* dongle is still connected but sinks are disconnected */
 	if (dp->link->sink_count == 0)
 		msm_dp_link_psm_config(dp->link, &dp->panel->link_info, true);
diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
index 20b7ed735b3f428e894b82ae2756d0efcfa47624..b1ea027438d952c94f3ae80725c92e46c631bdb2 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.h
+++ b/drivers/gpu/drm/msm/dp/dp_display.h
@@ -19,7 +19,6 @@ struct msm_dp {
 	struct drm_bridge *bridge;
 	bool link_ready;
 	bool audio_enabled;
-	bool power_on;
 	bool prepared;
 	bool mst_active;
 	unsigned int connector_type;
@@ -64,4 +63,6 @@ void msm_dp_display_atomic_post_disable_helper(struct msm_dp *msm_dp_display,
 
 void msm_dp_display_unprepare(struct msm_dp *dp);
 
+int msm_dp_display_get_active_stream_cnt(struct msm_dp *msm_dp_display);
+
 #endif /* _DP_DISPLAY_H_ */

-- 
2.34.1


