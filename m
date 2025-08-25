Return-Path: <linux-kernel+bounces-784930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1BCBB3439D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 16:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF9C01884E39
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 14:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32CC62FDC3D;
	Mon, 25 Aug 2025 14:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gK1o+SQW"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0457307AFB
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756131575; cv=none; b=ZHutFQRiqirZ1QAz8afvv5Fi3efi27ftc+1ZI6nTWxYOs35Bd5oQbrQHKec0i5Ru53LG/fCtjDKlMbUOSZt0NXG/B3nkdDb11w2Tdr15qyKdJcPL2kN1e/NpasZprDtD34jkMf3WVHkXoAY+6YmLCgUjD+wgWyHChVPV5DVGMN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756131575; c=relaxed/simple;
	bh=UzzezGFfnriCX3WekorbmEPLAPHDamwviVHk3T3C4k4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jTCaF/CU66Y0X1yZQpdjbYR/2ocILH+1sMkTlLnMU25G+mEInXUItztxOrbHA8tvbkE8IkgxzizBo8sU1PFupyjL4IDkeeEBoJt5NTVAT3jFWNhXscFvq04Z/ys+80hY78N7+l05u7JYEzrsYLtDNIGBORoPKucyWPVetluOVII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gK1o+SQW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57P897tq022063
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:19:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CZhkbXVUFYW+zS7ofmyWUZHIa7LAHJP5wKa7KCePTVk=; b=gK1o+SQW/eRGtNgY
	cwkKf9XmIqP7EbppONYLbQWhVZQVht1u4T6b2E0FoCAHfSioHSOmFel2bYHghHeR
	tJs+oWCCIZtLI3WX4ODvsHtDYxW+gVN6e9cxtgX+GKynywXqwnC4pKjHPA1oamWj
	lRc59/EwphrFpoZ8x2EImF2j/98E784J3XlDgkUpW8eMa4rWMlzgDk58pWy+yYDz
	n9Ve7JcqN7TmJypPM+Udu42kWKXml0LI05bdfhlVZmMRmWeU7WduRGabHp6vJuiz
	GM0d2qyXoQ5ox86rHAG/fqV0VUMKBeYICI4rbF0HQS6XyBC2V7Ze5i2y+e+wQMF4
	c5aj5w==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q6x85bk8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:19:32 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b47174b3427so3274366a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 07:19:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756131572; x=1756736372;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CZhkbXVUFYW+zS7ofmyWUZHIa7LAHJP5wKa7KCePTVk=;
        b=pdBPjhIlppUYuqdDIXqb/HVUg15fpXH7ttdq1clKPie6iJkpn3YIlgMtbD0fhZBNf6
         2EJm4k/Yx75QXoqFwxB5KnEPxtlm/pgXFymr2ei2yqE8cswmlMPWv2YwuTVhEWdGZ4Cg
         0A6zBrC+SLKIPb0mVbhJZYXdWNfjarWD3Pn0epoZiXTB2QO3ERrAxMHj0rR1QeZYHath
         lCjL/jn/YZJR5c7uj04My9sSer2YOmdX8BO9LeWFP2A+UZCrKOtboBhk3ffhiJp9olQm
         MMYj8imAB32hVI/175DqQPDp65O/4NRAZTQLSLnkitSblTNKpQpNJ+0Iy1IIYCT2dvXP
         LKzw==
X-Forwarded-Encrypted: i=1; AJvYcCUKUmYqI+DrtmmSy8xgpp6VbiJf/MvBkM70Ia3NpUFTm9bHON7OLbRws2nMl2evc5iP1lTDwtNVQ44wQnA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7DPUEAvVfc5OZWwI3wmyTSWvpPZavM40+nW5uQCRYMIFxiXeB
	tJfDFSQV4vk/+qScQsXpFgPFqhjLLUb2AfB4MWOUEhLOx/CP/V6AgPJVRUPadsZdgssaXjwoVdl
	tDZRuS31oVjZIVouzWm0LgRDGyj+mF0ovV5jc76dYtHXqysAx6hFzeTS0v8kHamUjcIU=
X-Gm-Gg: ASbGncs8qJylYn+6hi6KBW5sbK6thaQYBIh1+6ww7+FVYDAdWSi4eb8yEJ6+N4I4F+C
	cHNEhhn4fJYUhhrxZKMJA+hbDQTZ+FiUoTLNra5ZbYpZBFW6jJS4SLP1uBXmm2ZNVZ/bJ2Eg2Lx
	3t9ADzWCzPblFqBm3heiEzn0TVbanHXaBi8Iq7LF716SJXngRiy6lmk/enzYJ2DRxA0VkZ2c0wS
	YFN4OHEkHXreLPqjdlg1wasP3uLpa9/pjZ+mbMFPeLvFPkhQLGUwQ/NXN+QyAmuiSOBSayAC/EJ
	HnvG4Uza0haIgT4H/QoebVBxvhZw5HWs7VoGemi/YliJleZNJFYaWdDgIvbbVMvkX6/MsS8=
X-Received: by 2002:a05:6a20:7f85:b0:243:78a:826c with SMTP id adf61e73a8af0-24340dcbc72mr19416776637.50.1756131571696;
        Mon, 25 Aug 2025 07:19:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXv8tBZVC2UoKGO1/3uUglh2y92Zp+Cdn0tJSLzTXFD9surn4Xq1HARP3M1DlH3qrJwl+SIg==
X-Received: by 2002:a05:6a20:7f85:b0:243:78a:826c with SMTP id adf61e73a8af0-24340dcbc72mr19416732637.50.1756131571237;
        Mon, 25 Aug 2025 07:19:31 -0700 (PDT)
Received: from cse-cd01-lnx.ap.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770401eb20dsm7672339b3a.79.2025.08.25.07.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 07:19:30 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Mon, 25 Aug 2025 22:16:20 +0800
Subject: [PATCH v3 34/38] drm/msm: initialize DRM MST encoders for DP
 controllers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250825-msm-dp-mst-v3-34-01faacfcdedd@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756131424; l=4594;
 i=yongxing.mou@oss.qualcomm.com; s=20241121; h=from:subject:message-id;
 bh=ZDHDyo+PGP0KVM/qc1FieiisvNG7qcmF8Qsrn9I5YcA=;
 b=IJWtywfKvZuE1pb21io/8fr6S2zZOE9lbHx1ilz2xgbyuxZb7lpvGT+BHkqz7UJ1bav+k/+rZ
 syLKbD/EHzaAl5ZUlJy8FdXAgX2dGnVSHJu+0l3FtCWMskX8WKDLSSo
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=zeCnFRUqtOQMeFvdwex2M5o0Yf67UHYfwCyBRQ3kFbU=
X-Proofpoint-ORIG-GUID: HF329J5Ve8GnPp72DedgANbpOp6t8q5A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDA0NCBTYWx0ZWRfX2HscdQbECI5g
 m6D39HDfLnG2j9UZ7n0VCKq7UNmgeyy8Ee0bdlQTN99LsLxrSzB1YoIJ36bpw4WEj8y1ykwmWlk
 6T4l4nHFBwUl4RDTbp1wCyQLganViXflKPXhQp4KQXDVJ/h+d9B+jbBbQxlEKBNEeZeaY9ZJ4W2
 HAqVVS1i5Bb20GbKXIUy7QDPSVdm8ks7uqSrLbO0O2WbZWMxKxGQu4+/49Z1jauq4UEGXVR8Fin
 wPI/l/pa+asKRcFB0kvwGxJIu0ReVoVay1iChSM/eBIfBNHVsfl9BeANCZ1c1UvO9BS/YpTd9I2
 h3U830Sx8Pi8N5IAloO7ar/ln4ZSc9ZHaNU54ItFghG6aCwANdWZu2Bb2DBh7APSnBaLUW+MzUe
 MoFyHYas
X-Proofpoint-GUID: HF329J5Ve8GnPp72DedgANbpOp6t8q5A
X-Authority-Analysis: v=2.4 cv=Ep/SrTcA c=1 sm=1 tr=0 ts=68ac70f4 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=z9hH63PmnJvNFBvS1J4A:9 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_06,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 adultscore=0 bulkscore=0 suspectscore=0
 phishscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230044

From: Abhinav Kumar <quic_abhinavk@quicinc.com>

Initialize a DPMST encoder for each  MST capable DP controller
and the number of encoders it supports depends on the number
of streams it supports.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h |  2 ++
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c     | 23 ++++++++++++++++++++++-
 drivers/gpu/drm/msm/dp/dp_mst_drm.h         |  2 --
 drivers/gpu/drm/msm/msm_drv.h               | 13 +++++++++++++
 4 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
index ca1ca2e51d7ead0eb34b27f3168e6bb06a71a11a..2eb4c39b111c1d8622e09e78ffafef017e28bbf6 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
@@ -28,6 +28,7 @@
  * @h_tile_instance:    Controller instance used per tile. Number of elements is
  *                      based on num_of_h_tiles
  * @is_cmd_mode		Boolean to indicate if the CMD mode is requested
+ * @stream_id		stream id for which the interface needs to be acquired
  * @vsync_source:	Source of the TE signal for DSI CMD devices
  */
 struct msm_display_info {
@@ -35,6 +36,7 @@ struct msm_display_info {
 	uint32_t num_of_h_tiles;
 	uint32_t h_tile_instance[MAX_H_TILES_PER_DISPLAY];
 	bool is_cmd_mode;
+	int stream_id;
 	enum dpu_vsync_source vsync_source;
 };
 
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index 12dcb32b472497f9e59619db4e810abfbf610c7c..0b9d9207f4f69e0d0725ff265c624828b5816a8b 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -653,7 +653,8 @@ static int _dpu_kms_initialize_displayport(struct drm_device *dev,
 	struct msm_display_info info;
 	bool yuv_supported;
 	int rc;
-	int i;
+	int i, stream_id;
+	int stream_cnt;
 
 	for (i = 0; i < ARRAY_SIZE(priv->kms->dp); i++) {
 		if (!priv->kms->dp[i])
@@ -676,6 +677,26 @@ static int _dpu_kms_initialize_displayport(struct drm_device *dev,
 			DPU_ERROR("modeset_init failed for DP, rc = %d\n", rc);
 			return rc;
 		}
+
+		stream_cnt = msm_dp_get_mst_max_stream(priv->kms->dp[i]);
+
+		if (stream_cnt > 1) {
+			for (stream_id = 0; stream_id < stream_cnt; stream_id++) {
+				info.stream_id = stream_id;
+				encoder = dpu_encoder_init(dev, DRM_MODE_ENCODER_DPMST, &info);
+				if (IS_ERR(encoder)) {
+					DPU_ERROR("encoder init failed for dp mst display\n");
+					return PTR_ERR(encoder);
+				}
+
+				rc = msm_dp_mst_drm_bridge_init(priv->kms->dp[i], encoder);
+				if (rc) {
+					DPU_ERROR("dp mst bridge %d init failed, %d\n",
+						  stream_id, rc);
+					continue;
+				}
+			}
+		}
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/msm/dp/dp_mst_drm.h b/drivers/gpu/drm/msm/dp/dp_mst_drm.h
index 8fe6cbbe741da4abb232256b3a15ba6b16ca4f3e..d73e3f908439094532e88945ed4d41ed092051c9 100644
--- a/drivers/gpu/drm/msm/dp/dp_mst_drm.h
+++ b/drivers/gpu/drm/msm/dp/dp_mst_drm.h
@@ -82,8 +82,6 @@ struct msm_dp_mst_connector {
 	struct msm_dp_panel *dp_panel;
 };
 
-int msm_dp_mst_drm_bridge_init(struct msm_dp *dp, struct drm_encoder *encoder);
-
 int msm_dp_mst_init(struct msm_dp *dp_display, u32 max_streams, struct drm_dp_aux *drm_aux);
 
 void msm_dp_mst_display_hpd_irq(struct msm_dp *dp_display);
diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index 985db9febd98e35dfed51d39dac1a522abe5a351..3e64ec7b7dbe1d1107e85def9aa80277131f40bf 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -363,6 +363,9 @@ bool msm_dp_needs_periph_flush(const struct msm_dp *dp_display,
 			       const struct drm_display_mode *mode);
 bool msm_dp_wide_bus_available(const struct msm_dp *dp_display);
 
+int msm_dp_get_mst_max_stream(struct msm_dp *dp_display);
+int msm_dp_mst_drm_bridge_init(struct msm_dp *dp_display, struct drm_encoder *encoder);
+
 #else
 static inline int __init msm_dp_register(void)
 {
@@ -379,6 +382,16 @@ static inline int msm_dp_modeset_init(struct msm_dp *dp_display,
 	return -EINVAL;
 }
 
+static inline int msm_dp_get_mst_max_stream(struct msm_dp *dp_display)
+{
+	return -EINVAL;
+}
+
+static inline int msm_dp_mst_drm_bridge_init(struct msm_dp *dp_display, struct drm_encoder *encoder)
+{
+	return -EINVAL;
+}
+
 static inline void msm_dp_snapshot(struct msm_disp_state *disp_state, struct msm_dp *dp_display)
 {
 }

-- 
2.34.1


