Return-Path: <linux-kernel+bounces-784899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B46AB34359
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 16:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A978B20656D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 14:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D452FDC35;
	Mon, 25 Aug 2025 14:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pB6VFKAn"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C442FD7D7
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756131466; cv=none; b=JyzFNffMTLYUuy2lRah7lQFssydyZC1JLzI4C5fTSdu7xKKxF4NX29v4uXHYrs5GJf6XKuHnT3t2o29mvUwSITBVCC90CzsvLprN5UyvMCVS14HMzm+UG/b2as62E/IDbUWGSI1kwW0jCWm6Q5boxya/QqK/wlmDJUExJD+8GOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756131466; c=relaxed/simple;
	bh=uHsok/LSjjRH5u1NB5xR8K7S+7rsOioV24rr3GH1dtk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O3hz7zJIoXU65AW3N3jzXQ1vFX90MyDDOTbbbgZavdxxjYxi8MQbJS/JlJgvkHf9UyRDMjymb/6WfN7MmgV3LQbUaQtsPTzFZbwW5Xb0M8xhqoyDVtHmijna9qS+HSXcN2NpWqUvRHvXTFqzOgk4lvVzgDELBQcdjy3IDNgOjCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pB6VFKAn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57P8bTrx028657
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:17:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ylX1fqbOkKoSozFRGgeQVfO+D+WkKuR5pGGaL2RByr0=; b=pB6VFKAnnx5MX6p4
	GMY3fnKh8f8r8+HXQr24bRlvfXXkqkNzJpvgC02+vhFhvHUPz4bWrkVLAEwyTzDX
	lqTj2Zpuugm2PtiHPiBk83v4xWqtfiA0d31GmrHm3Ucqj5SiPlU3E/XNYyiZADjA
	oaEq35ygQiii62FwDLbCCGcFTWmbU2qYYOfOe8YMkgfOt0wliEHZU7GtjA+9P35J
	7HXtLP3Rj24XEKm1HB7IJCfDvfO8o8mc3YoIfMmZn6Ldn1J01WHd/vDwpiyS3/8r
	B1hLSiDnHsvPFY4TwJFGXBv/sd8ePyI6lLgC4X4IqwnhPVY90NlZng0yV9lFsOkE
	WsJxDQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q6thwb8d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:17:43 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b4716f9dad2so7250568a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 07:17:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756131462; x=1756736262;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ylX1fqbOkKoSozFRGgeQVfO+D+WkKuR5pGGaL2RByr0=;
        b=LzBRpx/j6Au8iyj2ZUblJPNjnH5ie4ivUPmYbXJNO8E1+OG3Uxc+xRBXJgpI7Tkv7s
         m9zxijzy+w6f15oukHW65Z6rEiMUGiuclKsglfZNybeRfVLldwhGtsjusUYSadEtg/0r
         JOCIgiINffwClDXy6kREri1A2VaynHKPGcBs8O0cwEdcWXZsA/BXBTZGIrSMufz8nG9a
         kHoKskJCWHOcsOZAiMCOig8JLpVazxS5scyMAyEcrFLT9wZijLa7pZpSSYFiob2kaMgi
         3CzppcNuqBK6BL/px8GcXsUCZi3OC4AMkjCZWC57fgQOf5z2HDlHNmvcIX//LdxjRqpU
         4Lng==
X-Forwarded-Encrypted: i=1; AJvYcCXLQU1zcq6r1ylHK8I+puziH79nYn69gpAZL0KdLkm9TY8Bps9I20lMVaJJH66HPYuw9Oq8bKx8isyb4jQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA46DUvG/FGbG0U+8yhJ5n9YqkTj6MjHAFJKq92yCBzphuYhcC
	tBXlw7GgeagMKAU1deATE0Zfji11XzUYO4w0m+Y8TGNTKPUEiZmmSI230Cd+yeOHvCcsAKcXgFv
	HvjTQaw5UYxtaYY++DFnt3GdnvLybErWLCTggDTpfYYwHKWSZ2syNMMi7znXo/QDQ+Hg=
X-Gm-Gg: ASbGnctzruLxPTRHE0xCwh5Oa+UDwcBOx51AlhzCrNN/3IcjaAbYn0mwNFnZlKvfl6s
	Y2D3HvlDGQKm3Tv8JiTSWD897bIbIrE6NKOmzzh8TfjToZk+lxfp/QMjRlCRs6M0GuZTXzOIy98
	IiBOkc3MvpeGahD+Wqcl/zQmei7HfiBNfRtDpXHMh0NQbILvISMlShCuGsZiOfS2ckY1JNqeV36
	YXNg3Jhn/slRjvCJNinVJAdn1yW++Eqw7A32QnmXd8zez1KpXqsRsUrvDJy06FGD0NxBbjijKoZ
	3VZgyXUEqH1DsmjF110vxsaCo7y7hSFRdYGoZJMIIUDI7jwdZkcySGMEUWBsr8MClwcKIkc=
X-Received: by 2002:a17:903:3845:b0:21f:1202:f2f5 with SMTP id d9443c01a7336-2462edabc8fmr150254795ad.8.1756131462285;
        Mon, 25 Aug 2025 07:17:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFy2Vro9AeMJiaynIza+7nP5Vby8B3bd7ehTdif/Ao4hMYbAsTqPKk+bTwETCz0iWQaj9644A==
X-Received: by 2002:a17:903:3845:b0:21f:1202:f2f5 with SMTP id d9443c01a7336-2462edabc8fmr150254475ad.8.1756131461800;
        Mon, 25 Aug 2025 07:17:41 -0700 (PDT)
Received: from cse-cd01-lnx.ap.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770401eb20dsm7672339b3a.79.2025.08.25.07.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 07:17:41 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Mon, 25 Aug 2025 22:15:54 +0800
Subject: [PATCH v3 08/38] drm/msm/dp: move the pixel clock control to its
 own API
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250825-msm-dp-mst-v3-8-01faacfcdedd@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756131419; l=3942;
 i=yongxing.mou@oss.qualcomm.com; s=20241121; h=from:subject:message-id;
 bh=uHsok/LSjjRH5u1NB5xR8K7S+7rsOioV24rr3GH1dtk=;
 b=77C6GNp9DHtOlGJdk1AxhxPkPC/mFy6dOlZiCa+J/fUyAuzdsNIRcNAwfqCLf27wkNFOje5BR
 Ut7PWTTdvqOBYFgQEq8ITbTLfHUl+SvfUsEg2iI7pqluOF4kHoiC1Lk
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=zeCnFRUqtOQMeFvdwex2M5o0Yf67UHYfwCyBRQ3kFbU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDA0MyBTYWx0ZWRfX47qsxQell0fo
 bM97Nl0v5OdhAW7/TUbR+Qw3vOyUIwvBYxJlV4yo8/LOlzKZatd2Ypm3bLyLCVsvcbKcD7MScaw
 J/dDqq7p2XAQb1EgQnrIz3GG4+RnRBXleKlJM6opXoB6kznGinzm+s3HAl9OrehyRnC0SNKodTd
 aLRe81MjDLhCye+0cjUFGWDwCpqhLZCtvdeaINwz2hNCBv5ZQnCFkRYceeiLaXILnljOkzcaU9i
 JA8Vaz0NxPTLcukOSo0kldrMkDT/IyVshnbt1UuHJ66agKKyVUP6JlCOoRqnxYXeg/BINUbVI8o
 K0eXpHou0WnO7hPAK9h7SuFcCirPrII7Gje3KwgJh57QRCC+812ZyhPX0tt/IDg9q1tYcKiBEF4
 sFfIxA/B
X-Proofpoint-ORIG-GUID: hPYlwsTDShS3E4QzfYjCi0BHDkj_IzxK
X-Proofpoint-GUID: hPYlwsTDShS3E4QzfYjCi0BHDkj_IzxK
X-Authority-Analysis: v=2.4 cv=W544VQWk c=1 sm=1 tr=0 ts=68ac7087 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=FjMX0bmgnFGAle5WrLgA:9 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_06,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 clxscore=1015 suspectscore=0 phishscore=0
 bulkscore=0 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230043

Enable/Disable of DP pixel clock happens in multiple code paths
leading to code duplication. Move it into individual helpers so that
the helpers can be called wherever necessary.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c | 77 +++++++++++++++++++++-------------------
 1 file changed, 41 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index 261907446135904a9e479f18051974f5fea88ef1..c0001b93a194821927507028f392877db585fd2c 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -2162,6 +2162,42 @@ static bool msm_dp_ctrl_send_phy_test_pattern(struct msm_dp_ctrl_private *ctrl)
 	return success;
 }
 
+static int msm_dp_ctrl_on_pixel_clk(struct msm_dp_ctrl_private *ctrl, unsigned long pixel_rate)
+{
+	int ret;
+
+	ret = clk_set_rate(ctrl->pixel_clk, pixel_rate * 1000);
+	if (ret) {
+		DRM_ERROR("Failed to set pixel clock rate. ret=%d\n", ret);
+		return ret;
+	}
+
+	if (ctrl->stream_clks_on) {
+		drm_dbg_dp(ctrl->drm_dev, "pixel clks already enabled\n");
+	} else {
+		ret = clk_prepare_enable(ctrl->pixel_clk);
+		if (ret) {
+			DRM_ERROR("Failed to start pixel clocks. ret=%d\n", ret);
+			return ret;
+		}
+		ctrl->stream_clks_on = true;
+	}
+
+	return ret;
+}
+
+static void msm_dp_ctrl_off_pixel_clk(struct msm_dp_ctrl *msm_dp_ctrl)
+{
+	struct msm_dp_ctrl_private *ctrl;
+
+	ctrl = container_of(msm_dp_ctrl, struct msm_dp_ctrl_private, msm_dp_ctrl);
+
+	if (ctrl->stream_clks_on) {
+		clk_disable_unprepare(ctrl->pixel_clk);
+		ctrl->stream_clks_on = false;
+	}
+}
+
 static int msm_dp_ctrl_process_phy_test_request(struct msm_dp_ctrl_private *ctrl)
 {
 	int ret;
@@ -2187,22 +2223,7 @@ static int msm_dp_ctrl_process_phy_test_request(struct msm_dp_ctrl_private *ctrl
 	}
 
 	pixel_rate = ctrl->panel->msm_dp_mode.drm_mode.clock;
-	ret = clk_set_rate(ctrl->pixel_clk, pixel_rate * 1000);
-	if (ret) {
-		DRM_ERROR("Failed to set pixel clock rate. ret=%d\n", ret);
-		return ret;
-	}
-
-	if (ctrl->stream_clks_on) {
-		drm_dbg_dp(ctrl->drm_dev, "pixel clks already enabled\n");
-	} else {
-		ret = clk_prepare_enable(ctrl->pixel_clk);
-		if (ret) {
-			DRM_ERROR("Failed to start pixel clocks. ret=%d\n", ret);
-			return ret;
-		}
-		ctrl->stream_clks_on = true;
-	}
+	ret = msm_dp_ctrl_on_pixel_clk(ctrl, pixel_rate);
 
 	msm_dp_ctrl_send_phy_test_pattern(ctrl);
 
@@ -2518,21 +2539,10 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *
 
 	drm_dbg_dp(ctrl->drm_dev, "pixel_rate=%lu\n", pixel_rate);
 
-	ret = clk_set_rate(ctrl->pixel_clk, pixel_rate * 1000);
+	ret = msm_dp_ctrl_on_pixel_clk(ctrl, pixel_rate);
 	if (ret) {
-		DRM_ERROR("Failed to set pixel clock rate. ret=%d\n", ret);
-		goto end;
-	}
-
-	if (ctrl->stream_clks_on) {
-		drm_dbg_dp(ctrl->drm_dev, "pixel clks already enabled\n");
-	} else {
-		ret = clk_prepare_enable(ctrl->pixel_clk);
-		if (ret) {
-			DRM_ERROR("Failed to start pixel clocks. ret=%d\n", ret);
-			goto end;
-		}
-		ctrl->stream_clks_on = true;
+		DRM_ERROR("failed to enable pixel clk\n");
+		return ret;
 	}
 
 	/*
@@ -2566,7 +2576,6 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *
 	drm_dbg_dp(ctrl->drm_dev,
 		"mainlink %s\n", mainlink_ready ? "READY" : "NOT READY");
 
-end:
 	return ret;
 }
 
@@ -2600,11 +2609,7 @@ void msm_dp_ctrl_off(struct msm_dp_ctrl *msm_dp_ctrl)
 
 	msm_dp_ctrl_reset(&ctrl->msm_dp_ctrl);
 
-	if (ctrl->stream_clks_on) {
-		clk_disable_unprepare(ctrl->pixel_clk);
-		ctrl->stream_clks_on = false;
-	}
-
+	msm_dp_ctrl_off_pixel_clk(msm_dp_ctrl);
 	dev_pm_opp_set_rate(ctrl->dev, 0);
 	msm_dp_ctrl_link_clk_disable(&ctrl->msm_dp_ctrl);
 

-- 
2.34.1


