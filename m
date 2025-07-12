Return-Path: <linux-kernel+bounces-728474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8DCB028BA
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 03:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99182563F83
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 01:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FADC21B1B9;
	Sat, 12 Jul 2025 00:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y6SwqmYO"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BA221766A
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 00:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752281930; cv=none; b=XZpDUHPOHVVLGUQWCCgIOGB41ePeGAGbyDna87BgUsIQAK6Xo5jPvEDe6sXS+IjqSB+MyvEwOU5eLXUG1TwFppBqpuoTohzl86HQ92pO7cFU0K3XbjO+DwTvc/N0ZNKnvRznz6FeA3BLzefSLH998tamBWU1Jv8AiM0EwV4jTBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752281930; c=relaxed/simple;
	bh=fjQ46wtHnJ8FY9wdYiHjF2udiecElMVze21Qux1/Y+0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sh4B8Li3sU1BId/tdYYqy1DZ85iXT5VBMCZgQSBOwNzEcXp5NM0UAEldoc0wBjlQhI5XMSLfCv3hBcPviqpyoPWnwk4Y4KJ15NF8hiN9ppvbT9lWE6ldetDgWyJDJzw90C0vdnWSLzypSFWDtE/RgLaBdPh3hT2nroqgbEYHSNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Y6SwqmYO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BAjmQS008142
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 00:58:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	X44+EY0MMh66SQSLKZsrsjmtnAL6ZSI0nRwBgvyoyyM=; b=Y6SwqmYODZD9Xzw5
	CWZBlVJuMXC0j8tdCk8R7xlovwGem/qAUpGMSmnMrth4Hm7/muGdF/bWLg2zK85k
	QXQ2kqyxqj/RUJM3Hsrhp8jhDF8Pgd6gBregEpR0StAqeWGCRjXu7XEB2xJYD7Uc
	GTX+Wzi8rCu2FAENHpuunGheD+fYz5nTDtlXCYm0RcNGNE7qhLfBYE806kN5KFgu
	EvD95Tlz8HFge58uUEtaXNwf9O0XlA329r5HPdmIrJuEe6k1tAG6ilg+U8Bmw3WO
	aX/m4lBeUs9Usm0S5yfC4gOS/powQ9sjWoVWjc8EiQHRzuiTW2BVZwr4tdf1utWj
	q6bF4w==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47smcga6t9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 00:58:48 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-313d346dc8dso4113151a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 17:58:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752281927; x=1752886727;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X44+EY0MMh66SQSLKZsrsjmtnAL6ZSI0nRwBgvyoyyM=;
        b=MfTiFM8TAwGUWYN8kUid7q0p0H5M3SUG4H12qaSOL41dCJdl85guUuv9mD302j06Ln
         wzXOgtX+OyOCMunH+dE/azWf7vhQBuKRx4rX0lRxMg85zivvSfGWAVi2giiyi2yyZrvi
         8VWzlIc3ihTC0679pE1VeU4XTr4I9n9GbzTQJLV5lKFI1wS93rHHkN8Av5tQcUknwNF0
         JfYEN6ScbSw7AowzU3AKp2k77Kg/mvKEAtCnfWIDw955Nwvdb0eIFvQika3/jdI3sTow
         sbGnVzPnqfiEKf/bGLqVnCf+8UV/dQ/Pl7xThH0s8XS1jQJliouPxe3T+ZSqfZlKZhGP
         ozeA==
X-Forwarded-Encrypted: i=1; AJvYcCUKIzIYAkFbbyq1vy2TWQPEQdAGgQIsP4j5TPfnJpyhtm99k1omYz7SoG36PR06NWs5cv5vvTM9cAM1DAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk/wQa6+qXSz7K/BOkeLnN1lZv4CoqPBEKteRRhPTT59TQ4HWa
	4cOo6lNZUZbOS5czzfUaIgn5R2Xw6yTUEtM2N5a2WKZdm6veA22vHlisJYmykOiJXzBxh2zPu/0
	sZeefupBAI9hn9F1/yurFsLWc/tzxk2/FYqg9Vww679c5XvUrsDH1WGCpljtGhKEjURE=
X-Gm-Gg: ASbGnctpKxHt3G1wMLu3i60lvoz8Uw9L4jW+sr3anJ8mQN7QX/TyMheesS6jM86iLS3
	2jzZsbdGtGxfflHny/nELnYP0ql0/F7hPN4koqsDlhyo3aJxGbi7fWUN/mGGRKhfvAGHdJrUyeh
	+iNHwLReQMEJ9sfki0WfBZ6lQRZw97x3UnVxXD+R4PkqG+C0ooHdykbvSHsT3ydS/gMGzqyAOtr
	SMV9hZevDlmCDdNY1N9iAM+qKMzIwDI1qwgqdHLeQQZVsg2RCJRot/JWCAg3957OsRA8O88jTbU
	d2JHYt07ufWGoEYmp9yEh7U0MzmDyPSsA5YDZB0WLTMdu0w99aLRh/syp27bk9bS03ihMQ7gn+u
	HIlA1EAQWv2nuY/5EBkGdH+i8
X-Received: by 2002:a17:90b:2790:b0:312:1ae9:152b with SMTP id 98e67ed59e1d1-31c4cd04544mr6586945a91.23.1752281927159;
        Fri, 11 Jul 2025 17:58:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEoLPLd8me4X8XPt7V2tzzU0N8EU2ZNyg5wcTau9plhMwtdyz+45J7Cbb8YmssvpxzQ7F9HA==
X-Received: by 2002:a17:90b:2790:b0:312:1ae9:152b with SMTP id 98e67ed59e1d1-31c4cd04544mr6586918a91.23.1752281926709;
        Fri, 11 Jul 2025 17:58:46 -0700 (PDT)
Received: from jesszhan-linux.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c23006d72sm5202274a91.1.2025.07.11.17.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 17:58:46 -0700 (PDT)
From: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
Date: Fri, 11 Jul 2025 17:58:18 -0700
Subject: [PATCH 13/19] drm/msm/dp: Drop ST_DISCONNECTED
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250711-hpd-refactor-v1-13-33cbac823f34@oss.qualcomm.com>
References: <20250711-hpd-refactor-v1-0-33cbac823f34@oss.qualcomm.com>
In-Reply-To: <20250711-hpd-refactor-v1-0-33cbac823f34@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Yongxing Mou <quic_yongmou@quicinc.com>
X-Mailer: b4 0.15-dev-a9b2a
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752281905; l=2475;
 i=jessica.zhang@oss.qualcomm.com; s=20230329; h=from:subject:message-id;
 bh=fjQ46wtHnJ8FY9wdYiHjF2udiecElMVze21Qux1/Y+0=;
 b=a2mpv0CIxX8rOFkYRUChcCtBBnHir6lhM1QupbemCr+UDu0A66v5VkIgBVwZWzeDdtz17c5GU
 dW5pQKU6HxuDR5Yv3N1+X/l+jAuAB8B+XMOvGSDmTTpKCzIyi6hChSD
X-Developer-Key: i=jessica.zhang@oss.qualcomm.com; a=ed25519;
 pk=gAUCgHZ6wTJOzQa3U0GfeCDH7iZLlqIEPo4rrjfDpWE=
X-Authority-Analysis: v=2.4 cv=P7o6hjAu c=1 sm=1 tr=0 ts=6871b348 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=geG2uR4XrXNgRqKXHj0A:9
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: QRnHXO8c7abHAEC7FR4yl1sx2YZAjmVt
X-Proofpoint-GUID: QRnHXO8c7abHAEC7FR4yl1sx2YZAjmVt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEyMDAwNSBTYWx0ZWRfX7Ud1vBN8AZmV
 3rW/DZVPItHErkA7wxkijRLLs8pLNJPUp+TPzTvZW1EKzEO5PS5z22bu7Dk1UdtT9mnvX+fJh+T
 +eK7jWkNH5KJ9RQlzOSIxnEWgJ9PIjf2mtcTAJZVcLkVKLJ7YduVjskWp+EOJz/sB+VxSiaQ+N+
 +zyuywck5779m0/vLRgkWAGiuhhxiCBPnSnfptQQSfTWvnCsLHyhQ0wlf57eo0z3/osXmvO4Yse
 PydfEuJb7BM/SMgSX0JKjvddX+cGgiUC2Xxv9OZOd0nuU2U0RTv+3pPSrWJnkaIKhyq89EijpIG
 b5sx5gKMArUOtO4npL/PQs7eSs/ffpSldoGLm3YwCAOkKnGTYNLrcW8WjyThvvcAMS2oO1G1VYp
 pwX7uiEPYaeeqfyFPJO2GPW1W5NXmM67F0kImo8T9Q4JUSb6jU9xSvuz5gtvcaVVqwFc1KMF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_07,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 phishscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 adultscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507120005

Drop the now unused ST_DISCONNECTED state

Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 5efc8d4ecf54..dac5078a849d 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -45,7 +45,6 @@ enum {
 
 /* event thread connection state */
 enum {
-	ST_DISCONNECTED,
 	ST_CONNECTED,
 	ST_DISCONNECT_PENDING,
 };
@@ -526,8 +525,6 @@ static int msm_dp_display_handle_port_status_changed(struct msm_dp_display_priva
 	} else {
 		if (!dp->msm_dp_display.connected) {
 			rc = msm_dp_display_process_hpd_high(dp);
-			if (rc)
-				dp->hpd_state = ST_DISCONNECTED;
 			dp->msm_dp_display.connected = true;
 		}
 	}
@@ -608,7 +605,6 @@ static int msm_dp_hpd_plug_handle(struct msm_dp_display_private *dp, u32 data)
 
 	ret = msm_dp_display_usbpd_configure_cb(&pdev->dev);
 	if (ret) {	/* link train failed */
-		dp->hpd_state = ST_DISCONNECTED;
 		dp->msm_dp_display.connected = false;
 		pm_runtime_put_sync(&pdev->dev);
 	}
@@ -669,12 +665,6 @@ static int msm_dp_hpd_unplug_handle(struct msm_dp_display_private *dp, u32 data)
 	 */
 	msm_dp_display_notify_disconnect(&dp->msm_dp_display.pdev->dev);
 
-	if (!dp->msm_dp_display.power_on) {
-		dp->hpd_state = ST_DISCONNECTED;
-	} else {
-		dp->hpd_state = ST_DISCONNECT_PENDING;
-	}
-
 	/* signal the disconnect event early to ensure proper teardown */
 	msm_dp_display_handle_plugged_change(&dp->msm_dp_display, false);
 
@@ -1628,7 +1618,6 @@ void msm_dp_bridge_atomic_post_disable(struct drm_bridge *drm_bridge,
 {
 	struct msm_dp_bridge *msm_dp_bridge = to_dp_bridge(drm_bridge);
 	struct msm_dp *dp = msm_dp_bridge->msm_dp_display;
-	u32 hpd_state;
 	struct msm_dp_display_private *msm_dp_display;
 
 	msm_dp_display = container_of(dp, struct msm_dp_display_private, msm_dp_display);
@@ -1643,12 +1632,6 @@ void msm_dp_bridge_atomic_post_disable(struct drm_bridge *drm_bridge,
 
 	msm_dp_display_disable(msm_dp_display);
 
-	hpd_state =  msm_dp_display->hpd_state;
-	if (hpd_state == ST_DISCONNECT_PENDING) {
-		/* completed disconnection */
-		msm_dp_display->hpd_state = ST_DISCONNECTED;
-	}
-
 	drm_dbg_dp(dp->drm_dev, "type=%d Done\n", dp->connector_type);
 
 	pm_runtime_put_sync(&dp->pdev->dev);

-- 
2.50.1


