Return-Path: <linux-kernel+bounces-835309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF15EBA6B32
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 10:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBF46179B69
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 08:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5715C2C0263;
	Sun, 28 Sep 2025 08:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZIz9ldXK"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7616D2BEC3D
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 08:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759047920; cv=none; b=ku335PPpmqcd3Xd6+ckupJcFF1MjwgC9sJhGFUXzhWuCihIW+Yrn1mjkgAYF4D2bU+lToE99gzqgf0b6lr9bWUOQQuZO+oQodczobEhWDmOoslFPtY2P6Qh5VhWyItPVmCi08Qxl22m7AsiO0PDRswr6xdA+8c4/lbtqh+DJ0ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759047920; c=relaxed/simple;
	bh=vK8TFXgm/6X3TSi0UvfKUVov+3NPXXiYH1OJryZTxNE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HP5GpmUyCCMTFf55X778QQgGAKk5af3xFs5Eb/ZO8JA7rlKIbjEYSzM3+wAkC+K/xMw/+ns3o/08Kwt4YyAdOCwFwC0+RhE5wVsyYkgg/E6xHxtbjF8AqwkPGkJqASLqcvtOtcuYWdhjYiCOBqW11Syc9DfjW258ZwdAYBE8lbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZIz9ldXK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58S7KQbV015961
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 08:25:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	duD+AZtcU7jXcfYcs9q78NTnBJdfETmQFkWPO1aJGZg=; b=ZIz9ldXKvoza1vyG
	ANGsG35rbrWvSDEKBZx4T/x4TOfq6xaMBz23GKsPXm2lmhuonqnh8t9C3QEBtdi5
	Y5ehokjmfi0VWgmUS7ZGZsHiDt80n8wihAudBicKlSKLXgqSvtIq0eIDddewkvV1
	/oGw1x9XiikZ9SpykzOG7FBfsfT0ScdLYie1l0/YZDRMBIqATBGhXyNt7VxZR8VJ
	+GqUrM6iUCgAcTqlN5IwB6FUL6hamlb07036I7Z/jO+6eRmpCZrxfa7ntn1biLPG
	TsNjal6N2ANv5GbZHg8s7cDTDh36ltat/Lc1AmwgyX97gGMoiA8VfdT5UHCfak37
	wKCitA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e6x5jfr3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 08:25:17 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4d7f90350f3so81161221cf.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 01:25:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759047908; x=1759652708;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=duD+AZtcU7jXcfYcs9q78NTnBJdfETmQFkWPO1aJGZg=;
        b=GcSPhhg5x0N7N6blZ2+VsgYFCqGW9F7uaFRIl3WpTeCKHEUtOgHmqwD9yGkadHLb5G
         AK1KG2DKPLam4HdMfQ3zcWgSOgVMpZgovHvBUH7zqhT8BnqVcPEoLIf9pWrLkmD3XvM3
         gQ4HmIbdd5hs72dT4DFVpc8BF65Tbit2NP+gOWQBd8mHUC+0hPW9clVUkt/Vi8xD2yIl
         BnRAqkM2umLYkamSovdLqNKvN9UJZpOM/jyZ5kKRki5No0iR6+ORkBNqG3PTActcMMkV
         d9fBLmxPZ/zRabNJSP/o2xCvbya+WG2PCetunLxaQ0vtkRdSPJyV9Ghos5jTrScqGt/d
         CiJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfp42rYWLF672F8y9cqon4SXc+42g0dZYdDdeHA1UUGuseNuKIp2nr+Mfy6hIt9IXmZFMaxUUbAMEJrkM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoiwghRHI9Vj1nY0RwZppQsI1mlwOBP7PDDudr63EtjM3ZJF+4
	DbCv9oaJ6FvzFftnZDS2pqPC9kI+2TOfl7ZVARazQw8HQIDorSsfeROzCrjDbC/44xqx0J8X3Tm
	RFbxcxceEmnA06e0Sgk9gx9VCHMJs6/r9K+i/3y1RwzBs5dyXQxsLL9tPqs1adKXIbuU=
X-Gm-Gg: ASbGncvLSwT6A/Fvo0+4eX1FWMX0eM7wHtrjCCX8YNHlmGn6V5vD0qRRO9EbslEYs3s
	2yPi1IYBFXz4qT0Ax4cxvPuwmoaaij9t1gBbN6CutamXncbTiMY9oO9aJdE7psOHgth+aZDZNyM
	pydkC0PLG/uAMtipPE+oyJTA2bOUHXW0oA0IGuwAWmCga7EQeKVJlX6mS4L9hgMoMjK2Zoz0Cex
	3AUoq1sESMUoD1S6VQRbZRWfUkqOGFg4fuO0cW8zgRYowq+iOSc0TO1RINDBYBv0ZfELGTGLoML
	cQqLs3BtpiKKcwVZZEdlHBBr6qH2g9q0RE4cNq5Suy14TAkM1hIAmsvZh5AE93lTtjaoi9oxyXl
	Z18q32tT4klCcDeMLwevqJEr/PNdDafMMBbDcc5eQqCOzzru81kl5
X-Received: by 2002:a05:622a:5b05:b0:4cf:ce43:540e with SMTP id d75a77b69052e-4dacd52b2cbmr147456301cf.27.1759047908251;
        Sun, 28 Sep 2025 01:25:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEN9pzqLrHlVaT4nT/ykEhCfOzipwXQJ0cAoSSpI3n4X55LPnP5fq5+qWz4znjsC4wVWkA+zA==
X-Received: by 2002:a05:622a:5b05:b0:4cf:ce43:540e with SMTP id d75a77b69052e-4dacd52b2cbmr147455941cf.27.1759047907687;
        Sun, 28 Sep 2025 01:25:07 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-583166561c0sm3244298e87.81.2025.09.28.01.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 01:25:06 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sun, 28 Sep 2025 11:24:49 +0300
Subject: [PATCH v2 4/9] drm/bridge: lontium-lt9611: handle unsupported
 InfoFrames
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250928-limit-infoframes-2-v2-4-6f8f5fd04214@oss.qualcomm.com>
References: <20250928-limit-infoframes-2-v2-0-6f8f5fd04214@oss.qualcomm.com>
In-Reply-To: <20250928-limit-infoframes-2-v2-0-6f8f5fd04214@oss.qualcomm.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Liu Ying <victor.liu@nxp.com>, Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Sandy Huang <hjc@rock-chips.com>,
        =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Andy Yan <andy.yan@rock-chips.com>,
        Samuel Holland <samuel@sholland.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2288;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=vK8TFXgm/6X3TSi0UvfKUVov+3NPXXiYH1OJryZTxNE=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBo2PDUy9QW8cx8zEuP/1bnwMnUwSTpxSXwf562q
 iouLsqfJZ2JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaNjw1AAKCRCLPIo+Aiko
 1eqkB/9KIeG/QwkAeQapUIoOZBz8PG1an8ZjgLawL5OLFmRHTAAt/28ma2YWfxkvVXFuHp2gFqB
 6H2nPhVwDQgUsa2WVpeglWwrkYP/1kvjunotI+ERAR+OCw+0OBi2bitZ1wXmSM0IWTuD7DO1Z66
 t5+tIsQQMthkTRVFZfg2Nd/U+zbzV+JEHdzi4IpALFD1O89IF3UwLMzDk+ZYuD4obZXJOW4SSTH
 uG0kMLdfzCJPei04ea9Sqfyotj1bxd2cklXPqxOutI50grHGHYzvKiZ7ak6MxVAojOSlxTtAN+5
 e315w88hSpwX0p8jBaoDtUUgKZyKmjn8DmAEKFJzzOY8eovY
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: I6-Zes6ecQsiJUH3JoxnOFL_teUEiien
X-Proofpoint-ORIG-GUID: I6-Zes6ecQsiJUH3JoxnOFL_teUEiien
X-Authority-Analysis: v=2.4 cv=ZtPg6t7G c=1 sm=1 tr=0 ts=68d8f0ed cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=XNEcMcDYeHr5uxMbIEwA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAxOCBTYWx0ZWRfXxnoBEYATsKBa
 lNhLENIR1F7d1Ef4mk/5dzmsrkzuA1O9aW449fkjVhB9ZQFVZbE+PU49B8kntrvFBx6/VWV6BfN
 ZDodhrM8g7XCbVlRBuzmpuc+JyXvTQ2woFVsVH1MZLDBYG/GKiCDbqZyqgOO1z4crqo/TwISmfJ
 iUefzuwhcdLHffiJ6XavcBSuLz3adysWDbHxu4s14m2SJ98b9kH3J3ui6pLcrW8qkKrOYj5bFQj
 btFlwn6K7Zbbl55/yXDFReG23zYbgh2UTTqZ9PZareoEMlntO319a9qpm/fO9BDk06IIDTWM8m8
 mkmKGosuPe8AFyp8JFUsKBj4l8BeeHD5RuC8NGjf3I+XzZyzF9uCHEI7pjJPzoupZh9+RdT06co
 CWhHgSOvDgSPzD9uptQjb+T7LHVDww==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-28_04,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270018

Make hdmi_write_hdmi_infoframe() and hdmi_clear_infoframe() callbacks
return -EOPNOTSUPP for unsupported InfoFrames and make sure that
atomic_check() callback doesn't allow unsupported InfoFrames to be
enabled.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/bridge/lontium-lt9611.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/bridge/lontium-lt9611.c b/drivers/gpu/drm/bridge/lontium-lt9611.c
index a2d032ee4744715b88eb66883edf69bab4c274b0..9c2c9887d2d66968eb1d50544a257d5999bbdded 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9611.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9611.c
@@ -869,9 +869,7 @@ static int lt9611_hdmi_clear_infoframe(struct drm_bridge *bridge,
 		break;
 
 	default:
-		drm_dbg_driver(lt9611->bridge.dev, "Unsupported HDMI InfoFrame %x\n", type);
-		mask = 0;
-		break;
+		return -EOPNOTSUPP;
 	}
 
 	if (mask)
@@ -910,9 +908,7 @@ static int lt9611_hdmi_write_infoframe(struct drm_bridge *bridge,
 		break;
 
 	default:
-		drm_dbg_driver(lt9611->bridge.dev, "Unsupported HDMI InfoFrame %x\n", type);
-		mask = 0;
-		break;
+		return -EOPNOTSUPP;
 	}
 
 	if (mask) {
@@ -925,6 +921,19 @@ static int lt9611_hdmi_write_infoframe(struct drm_bridge *bridge,
 	return 0;
 }
 
+static int lt9611_bridge_atomic_check(struct drm_bridge *bridge,
+				      struct drm_bridge_state *bridge_state,
+				      struct drm_crtc_state *crtc_state,
+				      struct drm_connector_state *conn_state)
+{
+	/* should not happen, HDR support not enabled */
+	if (drm_WARN_ON_ONCE(bridge->encoder->dev,
+			     conn_state->hdmi.infoframes.hdr_drm.set))
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
 static enum drm_mode_status
 lt9611_hdmi_tmds_char_rate_valid(const struct drm_bridge *bridge,
 				 const struct drm_display_mode *mode,
@@ -993,6 +1002,7 @@ static const struct drm_bridge_funcs lt9611_bridge_funcs = {
 	.edid_read = lt9611_bridge_edid_read,
 	.hpd_enable = lt9611_bridge_hpd_enable,
 
+	.atomic_check = lt9611_bridge_atomic_check,
 	.atomic_pre_enable = lt9611_bridge_atomic_pre_enable,
 	.atomic_enable = lt9611_bridge_atomic_enable,
 	.atomic_disable = lt9611_bridge_atomic_disable,

-- 
2.47.3


