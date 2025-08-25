Return-Path: <linux-kernel+bounces-784902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 612CEB3436E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 16:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C5D93AE716
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 14:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F502FE574;
	Mon, 25 Aug 2025 14:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="f8SqCiI7"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11AF2FE066
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756131478; cv=none; b=KBfdM+6AfMUPwmP1Q01Kcakib3XStdnSsDBMszSizkLbq3U6hBTOWQqdlMN71LfmRUGEhcysHXpxXHobMqkapbHRA2kz+3HrRCC9R6rTQDJxJT+lHXe3yLyXuh7HSSEqpXthWaCWl96RKlTMa7A2dpAGv0p6sBCIvvXvEsPkRKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756131478; c=relaxed/simple;
	bh=Oz7XAr2iLyGy70EQGJQTUcEj4eynjyeRqDgUDR4tgfE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pe+jm2LW1+2LD8woo4Ao9dsUZOrGWQyglcBsg/V8ebbTyuY1IahJTpVhkOLf9edBUiaX+2N2w+Q8y25BTVRRruvYkHk83et5epxXl+imvukoYrQzLPPV1MzMhNaEbYYudxWWspQ52hkFjNBt2XsHWTHkVbr9wiBSAt7OZ20p6RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=f8SqCiI7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57P8Druc019419
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:17:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ehd6Z3j9F6UFJbL1ClLACpAxqFTJVB256eRXwzSO4q4=; b=f8SqCiI7IGyNFm6R
	9lCq+wvmY6Hwj7QyViqHMp0qYMBU6Ll2k6LBaC0CUNKraIhForGHSwe5ktTcZ/Ia
	BAk5ELQRXw7oACjLzvoIUS5b6B5EJQztU1qFL7NgjGVYoYOCkE0cNrUEo5J1zO5/
	if3U+op3nC3W1NR7kFyU1SzM9lzetXsG7/C/bCGo9+gxm1JgXeEwfQlzcn4/wcP7
	DoHT97txjokqOOLeHhudq2oDZVRA1YzGIxXz8Ta1XqPGKzqYofbnh+bcc8nT6UNZ
	tqH0Cl93gPYCCa3bu+AYWx8c26GOy2eZrKYnUHqrNHr07Cvxmp6ZeumXP5rBCJ7G
	ZwqfmQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q6x85b9w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:17:55 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-771e1657d01so864629b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 07:17:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756131475; x=1756736275;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ehd6Z3j9F6UFJbL1ClLACpAxqFTJVB256eRXwzSO4q4=;
        b=lcr+mi9/AAiSIYm5cT8wSdhTYrbVNaQT7sURQcW761WxEpzsgQtsjkUvB5TjLaoTVB
         C7bTa7iw5fokhr8KWX+BGwCfWQ5ryE9N+7R1eaoJRfXdPzf9MOYT70i+WCbDkyBJbcIs
         BcrqsBoHqZsnbQAF7c3shYbneRKfb/tBhZczG/idKNhtmyPYZBbP8JPWDdxc4KDShH3Q
         R4+IIwnhU9FYMYz5KRt58D2Tg55fguQ3KA/4vMH3lpPMQDVW5fZqL1Y/4Qyy0BPQSnDZ
         KaHF+XWnMbmUbrrAIS0IlMLf+QgxQKC9WMJihWV4snybEV8xQ2EWhS7ZmKxCAMq/I0ZR
         PEkg==
X-Forwarded-Encrypted: i=1; AJvYcCWT7UlR56tJts7ynDN35BUSzPn4O4R4Xom8xEbSCbl+HHP07gq7wzViqiSm6xnozWk0vZMwpBzkIfKnRtU=@vger.kernel.org
X-Gm-Message-State: AOJu0YykncZ8rQTORFWaU1vyIc5lSIlOZw+TFJVistOcAJ/pMHgOqAVm
	PinVCTlX+uOAXJvqq7/5vaLLvBk15GTkgx17QIMmLWt3LEAuWFZzxNvDDWdMx1jV+ZNWSqzcPJL
	x8F8Aq2HU7dUAgHZ18jGPuavweIvMu1ZOZQ30k86c5UWdAfB9qOAgQ7Mkwb8B+ISMPZ4=
X-Gm-Gg: ASbGnctANpmE8G5PyAf6Ld4AjzVTdGINJB6ts05BY1iQcQSrYlbIkw9ubNH+g8lXUA3
	sa66IY8osrxyXq96Mtup0I9EZmPn45FnNeeGP9ZkrIjehxSa1mHxsrvK/38+3ZkoabCYhD74JHG
	0aF0ohfmAbAXU9J8C3sqQs3lZ858hvrNuaIY0lF62h0kqi1Z0zmZrnOXnkSKatasQE7BRzK/yiA
	Z4VCuNUn02+OAVdEwoV1ONxkAV9gjgzRRBtl/s1TBlJPbUjnTSmOEvdvQQc0aJKhb/8pUBGGcZO
	+w1YlKEG4vdG5/6KW5bIWxtqR5K2EkNPl3kMpo2fpU1nGZ0jB4LK9wCkgjaxvL+kgegPnKY=
X-Received: by 2002:a05:6a00:989:b0:771:ebf1:5e45 with SMTP id d2e1a72fcca58-771ebf1660cmr2234348b3a.22.1756131474834;
        Mon, 25 Aug 2025 07:17:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG09CpaFtCh665b+UlMocJfA8OyKjoGgQ9CL/OZNsmGoCPdzMYCFLICiDjOWQzYZdEyXdcfOQ==
X-Received: by 2002:a05:6a00:989:b0:771:ebf1:5e45 with SMTP id d2e1a72fcca58-771ebf1660cmr2234312b3a.22.1756131474287;
        Mon, 25 Aug 2025 07:17:54 -0700 (PDT)
Received: from cse-cd01-lnx.ap.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770401eb20dsm7672339b3a.79.2025.08.25.07.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 07:17:53 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Mon, 25 Aug 2025 22:15:57 +0800
Subject: [PATCH v3 11/38] drm/msm/dp: separate dp_display_prepare() into
 its own API
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250825-msm-dp-mst-v3-11-01faacfcdedd@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756131420; l=3193;
 i=yongxing.mou@oss.qualcomm.com; s=20241121; h=from:subject:message-id;
 bh=JGxMLypPbWKxuAwuwREf9cwiYhjKSbC5pwhS5CeKWxI=;
 b=RznuqTe8L3ZHOURGRmWpwGF4mnaHM1muZz9YRCIleoH0fWDqRblDuLOyyUxyD4TKnrGV1lEjN
 MPHaoI4QpkuDxuQkmdMZuprEovAdbWskxdLf/oo8w9MxRVeU4KmJVxA
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=zeCnFRUqtOQMeFvdwex2M5o0Yf67UHYfwCyBRQ3kFbU=
X-Proofpoint-ORIG-GUID: HYLrk3_vxsS8clBF459LqLaco4yZYzTC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDA0NCBTYWx0ZWRfXxE/0Q2lqh8Cb
 /WYNVlb6ovaPh8S1AOt56dkDmF+m5aNa32OpLAw+z8QsKhzlp0KH4Ws6gQXLfVewObJNSJWlKRS
 WS3Xjn1z1W6c6MHeTvEiLiHz3roS8Mb2eyGt+Sr9+nPJ5n1M1eUCXCtu53ypBRsPIwxHK6J6kJ3
 hPZVAJApGDnigTrjHxyezD62CDhH4CZbx4S2bDiUrZGxbNHu23Gm1ADxGEkXHbp92OdJP5W6YAb
 NUMVMPv8z5UQt3fxDRH1pstfa5v9HQo6ZvH5970ZRyLV/IcJpSbQEyG2jOpEK8gTdf5Hyo0BGwT
 Q9fs8H9E49r1K72J+k9hts6SlyOECgxyBWBCkDbHYaxNgdvVXgE2aBIZ0DnigQYMN+tXl7zaFwG
 5ExDCKxG
X-Proofpoint-GUID: HYLrk3_vxsS8clBF459LqLaco4yZYzTC
X-Authority-Analysis: v=2.4 cv=Ep/SrTcA c=1 sm=1 tr=0 ts=68ac7094 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=rHTcTV9uYuKpyGuOXCsA:9 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
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

dp_display_prepare() only prepares the link in case its not
already ready before dp_display_enable(). Hence separate it into
its own API.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 16 ++++++++++++----
 drivers/gpu/drm/msm/dp/dp_display.h |  1 +
 drivers/gpu/drm/msm/dp/dp_drm.c     |  2 ++
 3 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 8e95cfb98bd08088a707ffb5643a5021a288095f..78d932bceb581ee54116926506b1025bd159108f 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -1438,7 +1438,7 @@ int msm_dp_modeset_init(struct msm_dp *msm_dp_display, struct drm_device *dev,
 	return 0;
 }
 
-void msm_dp_display_atomic_enable(struct msm_dp *msm_dp_display)
+void msm_dp_display_atomic_prepare(struct msm_dp *msm_dp_display)
 {
 	int rc = 0;
 	struct msm_dp_display_private *dp;
@@ -1449,10 +1449,18 @@ void msm_dp_display_atomic_enable(struct msm_dp *msm_dp_display)
 		msm_dp_hpd_plug_handle(dp, 0);
 
 	rc = msm_dp_display_prepare(dp);
-	if (rc) {
+	if (rc)
 		DRM_ERROR("DP display prepare failed, rc=%d\n", rc);
-		return;
-	}
+
+	return;
+}
+
+void msm_dp_display_atomic_enable(struct msm_dp *msm_dp_display)
+{
+	struct msm_dp_display_private *dp;
+	int rc = 0;
+
+	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
 
 	if (msm_dp_display->prepared) {
 		rc = msm_dp_display_enable(dp);
diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
index e12496ac73f853a2bc120e68eeb84e5a2de6aabe..37c6e87db90ce951274cdae61f26d76dc9ef3840 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.h
+++ b/drivers/gpu/drm/msm/dp/dp_display.h
@@ -38,6 +38,7 @@ void msm_dp_display_set_psr(struct msm_dp *dp, bool enter);
 void msm_dp_display_debugfs_init(struct msm_dp *msm_dp_display, struct dentry *dentry, bool is_edp);
 void msm_dp_display_atomic_post_disable(struct msm_dp *dp_display);
 void msm_dp_display_atomic_disable(struct msm_dp *dp_display);
+void msm_dp_display_atomic_prepare(struct msm_dp *dp_display);
 void msm_dp_display_atomic_enable(struct msm_dp *dp_display);
 void msm_dp_display_mode_set(struct msm_dp *dp,
 			     const struct drm_display_mode *mode,
diff --git a/drivers/gpu/drm/msm/dp/dp_drm.c b/drivers/gpu/drm/msm/dp/dp_drm.c
index b6b77ee96c30ca60e31cf76569e262a237493aeb..b0dba97e120566f7376e047b319a60c5bc36ba4e 100644
--- a/drivers/gpu/drm/msm/dp/dp_drm.c
+++ b/drivers/gpu/drm/msm/dp/dp_drm.c
@@ -87,6 +87,7 @@ static void msm_dp_bridge_atomic_enable(struct drm_bridge *drm_bridge,
 	struct msm_dp_bridge *dp_bridge = to_dp_bridge(drm_bridge);
 	struct msm_dp *dp = dp_bridge->msm_dp_display;
 
+	msm_dp_display_atomic_prepare(dp);
 	msm_dp_display_atomic_enable(dp);
 }
 
@@ -196,6 +197,7 @@ static void msm_edp_bridge_atomic_enable(struct drm_bridge *drm_bridge,
 		return;
 	}
 
+	msm_dp_display_atomic_prepare(dp);
 	msm_dp_display_atomic_enable(dp);
 }
 

-- 
2.34.1


