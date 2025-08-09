Return-Path: <linux-kernel+bounces-760884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99EBAB1F199
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 02:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53FD6A04DEB
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 00:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD4E23BCEB;
	Sat,  9 Aug 2025 00:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZNdW/BzJ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4393239561
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 00:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754699743; cv=none; b=MjBI+saPnptHH49HZy8ZJ2YbqylyFNaI8fUBgBMSBnB2eUNt2yk9RqA3cATleTn/th8V/cvPUKS4a7plHZmgADcWCptg48x4u/USE7GXJwxHz35BuMy8dzH+L1fxFUnGYi1/92eMBO7OcwZhtC/tgUXO6mwyKMCHFc0ZwWxmXRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754699743; c=relaxed/simple;
	bh=50USIutSA8njn6IYfRQMWxI5xMJaaBqIOw1Eii1PLhU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fHMf2wcnVQ7C5OanLo5mpjmA4iTKwhFGAOd2A6YdvjS0f0IBKBuGJTA3wHSUU46bKOUi/e+1HWbRlupwG9rK5HcUfHrLiqF8cwjFjMVlQMEA5I1u3GJ66zcdPfKf0Ty3l+9LedklTnL7vUJDe7Ot/1tODVn4yfgdqeXntuIqnJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZNdW/BzJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 578NJPKq027995
	for <linux-kernel@vger.kernel.org>; Sat, 9 Aug 2025 00:35:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mAlKuYMUBKfxakMSfWgLZizUCrxLq9eDwfE1oN2ywF8=; b=ZNdW/BzJWHMxNjgH
	cG/ZwRGbA06QQXSnIHYaPDXnBuLcIGCC/j0+LeXehIVwGNmRbixdyFc1dnJWgBwj
	k+q++S2Di/I4/RB8I0JBdXwDb2ooIb0ugDQSxLGHNfkV3SLYPdo1keEvEmv8+gqp
	IOVO4MjH9stCisBV14zqlrYuGLK+Q6NAG+8jJ0IjH/yfleFjMHz0dVXmWZ1rzV/b
	i8nSqKUR8pHTuUfGLVHoVCwWCGEqawKIEr3YXL4KrBSFyFAq48NsW7zW/6rHnapB
	mfN+agJm09oJNGdemwG/Bd6NkOzWU4rqCrYRWnhRJBB6MejkRmjVVZyiuJ7tsbFf
	vEObxw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48c8u28k3f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 09 Aug 2025 00:35:40 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2403c86ff97so37969735ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 17:35:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754699740; x=1755304540;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mAlKuYMUBKfxakMSfWgLZizUCrxLq9eDwfE1oN2ywF8=;
        b=pPKr4LdUiRDC92eMZ4PFdU8I4Yj79AcV+BqUd0fIF5IfQ0bK2JwnUxZfPxJE0jdvqh
         jJJZuiy0ylACJbKzmZoeQsjOvL7hujiDMhWV2CrPFl0qH3/APf6pcMJpWPSAlKV382il
         Xm9ZVoSeHwYmZk8xv4+srymljHJore3Pfl8Q36tryIw9pFg7nfxW8v+xUeWHsePae6sD
         jb4/GOT8kgvn9437Jimzk5tKnkM0raFnPIZIrQ4P82QXtSbYgjjyHos+a4X9zKyiewp4
         rhYSx6gak1MKaRbKKQt/CXZSnrFtRqmv76ECZyIgQagk9BIvgL8EqUa2fZ+28idIrXQI
         qpRw==
X-Forwarded-Encrypted: i=1; AJvYcCWDjZK9e4EOej5vC/R2mJ3zUpR2bSpx7c/U8JT1mCA3v6hXOTkxsPoYKFIO9mb6bX5vyXAzAtHHl0/GvLc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6meFPE7G46XV5NrSgcCFE/RB/ACxGRJM8wK6BckBYM4JGk0Ty
	3MzAk0DhaOkelQkERegxorQVwi5K5EZETKDTQjUoNz4z6SOe3Wqk+3dlvvg+kyV0sTMFaXlAxDY
	B2kyLDVhxKKcQMr9ZomtqNO1tH5YHAuci5H5pE7uHDR1i8m4fNDhD3lFiZbRMdaxnX1U=
X-Gm-Gg: ASbGncvavTisDqcZqpC3ECSmI86IqwSnHyRVs4zBAj+z+swWwtgPUvz3ftle2nB3lyg
	uywizUj7qYeD0EiBS65+dQRHHrAfOFb16XUUXxhQRmj+eqgzQ1Konpe5m3WutpqZlm2vVnrRPZA
	CXTNCNxpVJhsGRw7lgrLXFXmdPCsRbf303y9zgRWtyym1jpI2ef8wyYSjoWDO13aYepdazm49Sp
	FidpUsGRH6+nGAGpzWC6NCxTXLEbOtcX9tDW4LFKnlYCSY85GtLxO6fZnRvo9BsVPkBoqQi+lUn
	tLhVXoN1YiP6CdY7qEawdlB2luwTsFx0y6CKWrmHMW22YpYLgU4CzPsy7S8tODgsokqzavOG5kK
	kDX4L8fvy4yAUR15AOOv0TU+u
X-Received: by 2002:a17:902:e74e:b0:240:8369:9b9d with SMTP id d9443c01a7336-242c1fdc961mr74137265ad.9.1754699739980;
        Fri, 08 Aug 2025 17:35:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGriD7dy6Sg8oPpjahvuVk0KyIUeYorIx0HoQ8CSaI46CMni9HLIVrzkTQsXSQEyGkXQKkBHg==
X-Received: by 2002:a17:902:e74e:b0:240:8369:9b9d with SMTP id d9443c01a7336-242c1fdc961mr74136965ad.9.1754699739564;
        Fri, 08 Aug 2025 17:35:39 -0700 (PDT)
Received: from jesszhan-linux.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef678dsm219865355ad.39.2025.08.08.17.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 17:35:39 -0700 (PDT)
From: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
Date: Fri, 08 Aug 2025 17:35:15 -0700
Subject: [PATCH v2 03/12] drm/msm/dp: Read DPCD and sink count in bridge
 detect()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250808-hpd-refactor-v2-3-7f4e1e741aa3@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754699734; l=4040;
 i=jessica.zhang@oss.qualcomm.com; s=20230329; h=from:subject:message-id;
 bh=50USIutSA8njn6IYfRQMWxI5xMJaaBqIOw1Eii1PLhU=;
 b=4j7gDk8sNyixD1Hl/kxqP3JU//WBcuVk/VfmANElISz56rT9N0jAEtgKqEEI77CpPxspmj01L
 p5RwZK7dmsCDdUMwXe3SIjIcMUnqq9RNArmVeW/oEtPcNcx4FcxOay2
X-Developer-Key: i=jessica.zhang@oss.qualcomm.com; a=ed25519;
 pk=gAUCgHZ6wTJOzQa3U0GfeCDH7iZLlqIEPo4rrjfDpWE=
X-Proofpoint-GUID: K_9b9KS9QmDViozbjL86m26D1Xs4kKZU
X-Authority-Analysis: v=2.4 cv=Q/TS452a c=1 sm=1 tr=0 ts=689697dc cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=7iSa1Ozp54svVWoPkB8A:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: K_9b9KS9QmDViozbjL86m26D1Xs4kKZU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDA5MCBTYWx0ZWRfX2NI2bEGPU0CY
 6UDMRegZO6wZm5A6LzTkwZdZzzkqJKwKyttzsfVqIn9VD6yTcHHXQmJffZFS9WvODbopBjMuZtu
 SlyKpz5OrcxDJkU62UbHKChu8F9scJWY8UM7QFoQAyaAoMERPr4kz/dmB/E58N09GvRArustMfp
 mVfRmZZPxvmI1gjXSUtLL4tp9OaQT+r9Tl0dydf8n1Zzp6B6CPtcPH9dkT1hSAwcl8dL3+gNXj3
 guGFQXIkOy+r7kgXpSmsIEeTzLuDTny/zHpwkavaQUmSkhs1qX9Ey9pqoOFTQwMnzoDBqFAyAir
 VAB5PwiA0ee8L3FjRvWiLSM6mPVlVDajk8a8ucbwYb67cBjFTq2vXER12BA7r9lbZsPhScHkPjc
 bCGgLFxU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_08,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508060090

Instead of relying on the link_ready flag to specify if DP is connected,
read the DPCD bits and get the sink count to accurately detect if DP is
connected.

Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 54 +++++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/msm/dp/dp_drm.c     | 18 -------------
 drivers/gpu/drm/msm/dp/dp_drm.h     |  1 +
 3 files changed, 55 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index bfcb39ff89e0..e2556de99894 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -1142,6 +1142,60 @@ static int msm_dp_hpd_event_thread_start(struct msm_dp_display_private *msm_dp_p
 	return 0;
 }
 
+/**
+ * msm_dp_bridge_detect - callback to determine if connector is connected
+ * @bridge: Pointer to drm bridge structure
+ * Returns: Bridge's 'is connected' status
+ */
+enum drm_connector_status msm_dp_bridge_detect(struct drm_bridge *bridge)
+{
+	struct msm_dp_bridge *msm_dp_bridge = to_dp_bridge(bridge);
+	struct msm_dp *dp = msm_dp_bridge->msm_dp_display;
+	struct msm_dp_display_private *priv;
+	int ret = 0, sink_count = 0;
+	int status = connector_status_disconnected;
+	u8 dpcd[DP_RECEIVER_CAP_SIZE];
+
+	dp = to_dp_bridge(bridge)->msm_dp_display;
+
+	priv = container_of(dp, struct msm_dp_display_private, msm_dp_display);
+
+	if (!dp->link_ready)
+		return status;
+
+	msm_dp_aux_enable_xfers(priv->aux, true);
+
+	ret = pm_runtime_resume_and_get(&dp->pdev->dev);
+	if (ret) {
+		DRM_ERROR("failed to pm_runtime_resume\n");
+		msm_dp_aux_enable_xfers(priv->aux, false);
+		return status;
+	}
+
+	ret = msm_dp_aux_is_link_connected(priv->aux);
+	if (dp->internal_hpd && !ret)
+		goto end;
+
+	ret = drm_dp_read_dpcd_caps(priv->aux, dpcd);
+	if (ret)
+		goto end;
+
+	sink_count = drm_dp_read_sink_count(priv->aux);
+
+	drm_dbg_dp(dp->drm_dev, "is_branch = %s, sink_count = %d\n",
+		   str_true_false(drm_dp_is_branch(dpcd)),
+		   sink_count);
+
+	if (drm_dp_is_branch(dpcd) && sink_count == 0)
+		status = connector_status_disconnected;
+	else
+		status = connector_status_connected;
+
+end:
+	pm_runtime_put_sync(&dp->pdev->dev);
+	return status;
+}
+
 static irqreturn_t msm_dp_display_irq_handler(int irq, void *dev_id)
 {
 	struct msm_dp_display_private *dp = dev_id;
diff --git a/drivers/gpu/drm/msm/dp/dp_drm.c b/drivers/gpu/drm/msm/dp/dp_drm.c
index f222d7ccaa88..e4622c85fb66 100644
--- a/drivers/gpu/drm/msm/dp/dp_drm.c
+++ b/drivers/gpu/drm/msm/dp/dp_drm.c
@@ -15,24 +15,6 @@
 #include "dp_audio.h"
 #include "dp_drm.h"
 
-/**
- * msm_dp_bridge_detect - callback to determine if connector is connected
- * @bridge: Pointer to drm bridge structure
- * Returns: Bridge's 'is connected' status
- */
-static enum drm_connector_status msm_dp_bridge_detect(struct drm_bridge *bridge)
-{
-	struct msm_dp *dp;
-
-	dp = to_dp_bridge(bridge)->msm_dp_display;
-
-	drm_dbg_dp(dp->drm_dev, "link_ready = %s\n",
-		str_true_false(dp->link_ready));
-
-	return (dp->link_ready) ? connector_status_connected :
-					connector_status_disconnected;
-}
-
 static int msm_dp_bridge_atomic_check(struct drm_bridge *bridge,
 			    struct drm_bridge_state *bridge_state,
 			    struct drm_crtc_state *crtc_state,
diff --git a/drivers/gpu/drm/msm/dp/dp_drm.h b/drivers/gpu/drm/msm/dp/dp_drm.h
index d8c9b905f8bf..0f0d4bacb194 100644
--- a/drivers/gpu/drm/msm/dp/dp_drm.h
+++ b/drivers/gpu/drm/msm/dp/dp_drm.h
@@ -25,6 +25,7 @@ int msm_dp_bridge_init(struct msm_dp *msm_dp_display, struct drm_device *dev,
 		   struct drm_encoder *encoder,
 		   bool yuv_supported);
 
+enum drm_connector_status msm_dp_bridge_detect(struct drm_bridge *bridge);
 void msm_dp_bridge_atomic_enable(struct drm_bridge *drm_bridge,
 				 struct drm_atomic_state *state);
 void msm_dp_bridge_atomic_disable(struct drm_bridge *drm_bridge,

-- 
2.50.1


