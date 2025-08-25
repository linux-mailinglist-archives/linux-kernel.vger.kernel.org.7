Return-Path: <linux-kernel+bounces-784931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D17BFB343B3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 16:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAC213B4561
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 14:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54E6308F35;
	Mon, 25 Aug 2025 14:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jxc+lxbv"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB6C308F2F
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756131582; cv=none; b=VWrI9Aip6z2gQPauvqZg2lz5jfdmoA1NWmT1G+4fQij1j5WJdwS+TTMeuzP3r5vUMs+Q0XI0Cmphyiq4iiKf0SHtGDy1+9WrnX9fxEnXoOeht22vHz/dM5MJma1kgahI8ZL8x4b/hRFlMemEupsM9PGq5TwUNkn8XDUwe9n7G1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756131582; c=relaxed/simple;
	bh=zw5evHx5jV2eA3M1QS3eDkuzJEFyEuoNzT6jZZy7sXs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hvnoExgUAZ53u9UTLe53kk2QCaAKQPJkBoAIZn2bTjQKK/rqU5LthwHp19QE18/HVzczdI2a6KTVB5EY4w6YZoLXY+cQJIziMabLQScJfU4eNWutozmWoK+PchbsfLuNFsLd50ygC3mkinGObZ1ZpFBHL1N8Ex6KqO/jvk//Z6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jxc+lxbv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57P81EUq026983
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:19:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6MDHF6EGijp0sPM6TWeUG/trV7o7p3CC/iRMxM6EfKQ=; b=jxc+lxbvGnnOiVpl
	HuYN4LgAYuKfAFeT2G8/S7hQI+3ySUvYBUywsrpgqNQk5AIpHG4DwChjM+xZ9FMI
	Fc5yGkuWw0ibwF8gkI6o2OPwF90g4/yLzhjtYp3JrqEVjRktKeiiexckCBhWJuC2
	7j5QtzqV7wM2ft19XhFn9OP1aMPHOppT+/rsNT/xhPC3GsN1ueT0/uPtTzaGMS6L
	TqBE79H5avrKjOG/3PSmoc/oO4MVEaPAIfNmtO4GHFckxh4YfG7hah/ogywGlusm
	4rnEtruKhdNQwpcq+zqVaJLQoXjEPwfmhDCmOla6RwTK2IPrBGcB2Tv/r2nOBZda
	kyNn9Q==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q6x85bkq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:19:36 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-76e92b3dde9so3907873b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 07:19:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756131576; x=1756736376;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6MDHF6EGijp0sPM6TWeUG/trV7o7p3CC/iRMxM6EfKQ=;
        b=b0uWzAv2NWlbQaOQaVQdZqUlL3zjU9T6Dtr2WCbZIBvZyb5OwN7FXhubfJRUe/Sxo0
         0rIIdCUKYCLCJh8MgPXn9ak9PH3osBsNz3lFxDzuzfV+zA1cFtwq23c1AJXVVbBC1OiS
         pXWbFONExalMr4lvt+dI57KdonnavrNbHBUXokzuQyGEjgqHg+EkGp4I+EDQ+W2/Z1zq
         DDZbxbLs9HQFAMfU8PYUlYVrj7tP+lvsPjCbWyeSAbjNu40mgc/GqLBAdKjQDCbK+Ag5
         Ubssavg3BwkwVknhZMEuLRHwRZkmqJp/BLEmLR9m3902uswdqvSWa05m1KoQtP9GzqLD
         Ilvg==
X-Forwarded-Encrypted: i=1; AJvYcCWGV/cm1hOkZtWjvsfULRSUa1IR1D/5wT+9KHIV98WtnYhxwenL9E4VfBCLmX8NZWMG7JfatVnXSKiIhUw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDo5tWgzvtzqTA7Zx3G6I0VZojpf9iEF0DATebMrEwoMfLvyIo
	7HiROX37V9dk4u14bsMca2s5K12dt9qjCPSGA1rwWMITNasIN7Zmayul2xNJ7uLzZ63Z9KzFxQW
	7qgIYlfwWoYn7nAdQRQXlgZzmyY0DNVs0C8Zu5SQsAtM6j4RzCuOERqAF0Pa42CbYzSM=
X-Gm-Gg: ASbGncuWfsAOc7AYGM5yp/aWkMjmQW1EJ5AnHUgxlZAgA1F0N0qlPR856CYdeF46ven
	g7HMYFg7B6NJ4QqOK5fUSXdwyjjODyz2+5kInsYQoVyiqDDdRJC4GhTSG5/xL/zwj5a3/BTDry8
	qJye2yprJt58qFU2hx02azGFXr2x5T75mSmCw9XfzvHAfUpBvqH7bRKhXx8yUA/kxeU6dQgVnDL
	awI6eWoKvro+Ns7NDAaCedWiCoxIlRWv/xx/4jnUE2RI5Ou8QvwmQ57gjh9jT7pm+jkQOXoKpdD
	pi9iMM1A/i41G2y7felxwwRsRdKt03yS41zXCyQil1pY5PrnP/HI3a6d5wg9d6oPSM/vkYc=
X-Received: by 2002:a05:6a00:2e21:b0:771:e8fd:a817 with SMTP id d2e1a72fcca58-771e8fdabcamr3409684b3a.14.1756131575801;
        Mon, 25 Aug 2025 07:19:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpW6CmWEIQgWCszUSOnMtZ7sW9kbTpGqPkyb0wn89KFA51RGSTymdfLHBWqN+kzflAOfyMuQ==
X-Received: by 2002:a05:6a00:2e21:b0:771:e8fd:a817 with SMTP id d2e1a72fcca58-771e8fdabcamr3409634b3a.14.1756131575307;
        Mon, 25 Aug 2025 07:19:35 -0700 (PDT)
Received: from cse-cd01-lnx.ap.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770401eb20dsm7672339b3a.79.2025.08.25.07.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 07:19:35 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Mon, 25 Aug 2025 22:16:21 +0800
Subject: [PATCH v3 35/38] drm/msm/dp: initialize dp_mst module for each DP
 MST controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250825-msm-dp-mst-v3-35-01faacfcdedd@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756131424; l=3071;
 i=yongxing.mou@oss.qualcomm.com; s=20241121; h=from:subject:message-id;
 bh=C+Go3XquSNn2zh7+j/6tFb34Ivx9VwVNL72WyLqa7OU=;
 b=KljTiOHp3LZXWwkE/6kAiOgOMb9Onx0q0Af2bhmvZWyXdDphfqZwhDjqZYm+TTue559zko5yk
 sKwWYioTEaGD9BKLV3lHWGAw6mqDpoURTwpiWHwagrS1kbtn33gUvfV
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=zeCnFRUqtOQMeFvdwex2M5o0Yf67UHYfwCyBRQ3kFbU=
X-Proofpoint-ORIG-GUID: C26YXv3ZVWRn9Ln1DgRMaaNFZscOnE7a
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDA0NCBTYWx0ZWRfX3aQq3dBtcGI3
 3GcRNRLSC5jbTZJSltOAAnSSQF1pGDebztT+9tjg0fPBNKiAx/7caWd1YKwXo49sakaLG5wZ3Us
 7I0P4M7iVl6TggmEIt3YW2qCllkWhwT/Ex4Zje8rBLRR4FguMd0qrm4NwwmrODxwhVXCzR3RBGE
 kcGv78OMy0Kt7ISgOQxBIS3QBghtW8hB6A1mjyAq3nilKU5FGR9/T4fQnB+OiPWlD3Pn+Mbn8ab
 wdCh3viGD67cwK0rufeQRSk6+kbw6tbXW+wQ+6oY7iwsl4dEIiDOoQ+IM9UT6AIpfNvXxWVCZPh
 rjuBaH0gJ7dIWjY2Vc8hxsBjMpYgmmgWKLf9rfNIVQ01QD5ht3ePX/n0hH/6KpFc3WRr3/ontTZ
 +ND/RzVH
X-Proofpoint-GUID: C26YXv3ZVWRn9Ln1DgRMaaNFZscOnE7a
X-Authority-Analysis: v=2.4 cv=Ep/SrTcA c=1 sm=1 tr=0 ts=68ac70f8 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=AOHtyAuHbwWPpPzu3RYA:9 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
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

For each MST capable DP controller, initialize a dp_mst module to
manage its DP MST operations. The DP MST module for each controller
is the central entity to manage its topology related operations as
well as interfacing with the rest of the DP driver.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 6 ++++++
 drivers/gpu/drm/msm/dp/dp_display.c     | 9 +++++++++
 drivers/gpu/drm/msm/msm_drv.h           | 6 ++++++
 3 files changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index 0b9d9207f4f69e0d0725ff265c624828b5816a8b..4036d3445946930e635401109ac4720ed2282c2f 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -681,6 +681,12 @@ static int _dpu_kms_initialize_displayport(struct drm_device *dev,
 		stream_cnt = msm_dp_get_mst_max_stream(priv->kms->dp[i]);
 
 		if (stream_cnt > 1) {
+			rc = msm_dp_mst_register(priv->kms->dp[i]);
+			if (rc) {
+				DPU_ERROR("dp_mst_init failed for DP, rc = %d\n", rc);
+				return rc;
+			}
+
 			for (stream_id = 0; stream_id < stream_cnt; stream_id++) {
 				info.stream_id = stream_id;
 				encoder = dpu_encoder_init(dev, DRM_MODE_ENCODER_DPMST, &info);
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 909c84a5c97f56138d0d62c5d856d2fd18d36b8c..897ef653b3cea08904bb3595e8ac10fd7fcf811f 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -1586,6 +1586,15 @@ int msm_dp_modeset_init(struct msm_dp *msm_dp_display, struct drm_device *dev,
 	return 0;
 }
 
+inline int msm_dp_mst_register(struct msm_dp *msm_dp_display)
+{
+	struct msm_dp_display_private *dp;
+
+	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
+
+	return msm_dp_mst_init(msm_dp_display, dp->max_stream, dp->aux);
+}
+
 void msm_dp_display_atomic_prepare(struct msm_dp *msm_dp_display)
 {
 	int rc = 0;
diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index 3e64ec7b7dbe1d1107e85def9aa80277131f40bf..c46c88cf06598df996a17c23631570fda078b371 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -365,6 +365,7 @@ bool msm_dp_wide_bus_available(const struct msm_dp *dp_display);
 
 int msm_dp_get_mst_max_stream(struct msm_dp *dp_display);
 int msm_dp_mst_drm_bridge_init(struct msm_dp *dp_display, struct drm_encoder *encoder);
+int msm_dp_mst_register(struct msm_dp *dp_display);
 
 #else
 static inline int __init msm_dp_register(void)
@@ -392,6 +393,11 @@ static inline int msm_dp_mst_drm_bridge_init(struct msm_dp *dp_display, struct d
 	return -EINVAL;
 }
 
+static inline int msm_dp_mst_register(struct msm_dp *dp_display)
+{
+	return -EINVAL;
+}
+
 static inline void msm_dp_snapshot(struct msm_disp_state *disp_state, struct msm_dp *dp_display)
 {
 }

-- 
2.34.1


