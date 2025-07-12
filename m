Return-Path: <linux-kernel+bounces-728479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ABA0B028BF
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 03:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB6C95A5876
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 01:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4C0227EA4;
	Sat, 12 Jul 2025 00:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AsFoYw/H"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B413A224B07
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 00:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752281938; cv=none; b=eEBdmrbo2K8GA0bk1NuiwRKHsKYtPoNUW1kubCKVrQ+VNLq9wyNTFhSzCqGvmN4aqbUTdxlzk6qZpNf4ZtSB528GdkIcEHs6QUxjfdQYhndbdnmVPXzcHqgFbDsWmRdpadMvM8Egq7w3fZsmmPwtkq4EC7acKLK54z+kdlRU734=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752281938; c=relaxed/simple;
	bh=HYg9XWFkcmpF+zp7toVqFdfKLKICGtSNzR5KskC59d4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=az9OUJPWC6ZNjhC7VpJM3kc7Y/1vg0geKYgR/s/9ewWhRZpeLf+gNqsZjxHYF7Y8f/Uw7sMSuTiadg8QdDMgJuAnY4pF1HX97TwrSoCplPv3mmztgYahiwk9EvSFfceHiEoxYxM5UePPew5WCbpdJ2885hj0gsVu0fWCm//0MYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AsFoYw/H; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BMZfCA018395
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 00:58:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0C88ySzlRVkPe1hio0ux/weKP4+LF6gD4q5Pn05V+2c=; b=AsFoYw/H0Y/6cHx/
	+C2RsolKjMFnDo7LMpuiorvS7yob2yWs4rOeezMSrgJbNsQVs66Zti4s7vw5DzgD
	Xtsuwy/k7cl6Cgu3uruw5rrBuvKCOrNP4CuuWKOppxHLO9CsVqUHgIK6S1fNm2Tm
	jQUSwUQQ8+nJhqZeBJUYc5mAQ1Ko55SShmcrNTScTwk/jFfKxFpPL1poYMlRrG8k
	k86wB22n3TJmPwXv0JwrLMR4gcibNgarCah7FsNfXv4JttMWRTqdhg29mhrpDF7t
	qJIGY5X8vtTqsRJOxK9DuKrdkpLNpHfa1hpVdsalWubr4Ytb9jurUq1/PWug611z
	EFSCBA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47tkf34608-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 00:58:55 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-315af08594fso2888457a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 17:58:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752281935; x=1752886735;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0C88ySzlRVkPe1hio0ux/weKP4+LF6gD4q5Pn05V+2c=;
        b=PdefW6q4kXmQCa8pb1ipABqVO3dNXfaZyQGcHgPqadqpWpM0K97fTe+fb8QQmxtVrJ
         YdGvHBABcKr2tDe9M1MEXoJRaaxphi8Tf+DIwBJrY4FAIViNGMndnyQ//4J+NuFtm+CT
         Pfu4Iho2T6VJErpleeWHQGKrZjsq2y4vm0FJd5tZ9PewB9gdKfrKRnVRlULEkknOicM0
         2jjTY20cwK5yhOH6e9UzHQGhnQSCP0hizDH3EyX6ov9YGlyARF36cV4k9y3kuj9c+lYf
         harTabF1Nl5JF+ld7YKjejin3dXu6B57UlaeB8cMgbn+4f2RUNGA/RIAxU9GQKYhbUC0
         GB7w==
X-Forwarded-Encrypted: i=1; AJvYcCVY+zR0l9Xd9gk2b1o52sxgbAd5NBytiJbBOr7nskmD9zweSVcvpl3sLqplLfScF73ct2QR5QVCeOlDUuE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJFZTUCzflCAlTnGfVQXt3hRTV0j51Ml7V6G/C4TEni/ngFtuc
	GP1rtzIpTPDwM8XubAmHkuv9K84LPcUsg9nJT3+Zi4GpnaNZDQAPR2vWl/Z/+Pj65/AutNX0ilM
	qifNRsd3d7/dmOpZShSL0cGP1JsIPuhtcuzbr8ScFpgKtiDL0TB2AdaYLshRqg1tJ5OY=
X-Gm-Gg: ASbGncsVNJpGzQewOhqaGvR1sI2sq0eJHVk/wt2f3v3ya5AvRE91Oh0HGZ7kBDG7pjZ
	arjkBXCs+ycMHZwIxy1+ux2+1xBSyO+F+JyjZtPYygisndu15C6EXHwefR6AB5CFIOpxflNfBpQ
	vc4WAgLjrEGXRt9zIyc+nzMZmTooz8llaKoyVyankrpKTXJ18PqwwQttPH/L74JmVhs7d3xCk2x
	95LJWnC1KSAc7toS/WrPFNeLyTo2XWBMOnZ4bXKBNMQOqsWd3oO2OqBaoeTnJquAFXdjTrKmwRB
	rfuSJ9etOZk0MUqJp6r2Cky1GXc9tzOVpXw+BguMZ15uWqpo57mo/qh15ZKIYT9S4fL1nfJGEtW
	5cQB04D6mkgqxtTx6+49mW6sX
X-Received: by 2002:a17:90b:3806:b0:313:352f:6620 with SMTP id 98e67ed59e1d1-31c4f48b065mr6358983a91.4.1752281934867;
        Fri, 11 Jul 2025 17:58:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSMo65Z+KjgTkv6KVMymiCmYn2CuabOGuLC9Bx4y8ORCEvQnAn1GjeeBbaCqqC88pcfO/NfA==
X-Received: by 2002:a17:90b:3806:b0:313:352f:6620 with SMTP id 98e67ed59e1d1-31c4f48b065mr6358959a91.4.1752281934320;
        Fri, 11 Jul 2025 17:58:54 -0700 (PDT)
Received: from jesszhan-linux.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c23006d72sm5202274a91.1.2025.07.11.17.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 17:58:53 -0700 (PDT)
From: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
Date: Fri, 11 Jul 2025 17:58:23 -0700
Subject: [PATCH 18/19] drm/msm/dp: Move link training to atomic_enable()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250711-hpd-refactor-v1-18-33cbac823f34@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752281905; l=3032;
 i=jessica.zhang@oss.qualcomm.com; s=20230329; h=from:subject:message-id;
 bh=HYg9XWFkcmpF+zp7toVqFdfKLKICGtSNzR5KskC59d4=;
 b=7+gsmDRAKN2VpsBwMET5tAsE9ulwWLuSi/xwkZxe0AroYvNbWoU1IavIh8Q0oGY/KFhURfV7+
 fSMh0NidnKiAc5SKyTQ023CgPOMIPnYaXRICzE7VRl37GEZkUnNC+lK
X-Developer-Key: i=jessica.zhang@oss.qualcomm.com; a=ed25519;
 pk=gAUCgHZ6wTJOzQa3U0GfeCDH7iZLlqIEPo4rrjfDpWE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEyMDAwNSBTYWx0ZWRfX83vuUn289zlN
 q6+6tCkjngwIQGx9lnKi02IUhmmeSQCzMDt69mCj6fHYCWw3DdamPW6s9CPzYmtnBurOy6z4vPq
 VvB7/0xJlXe/61gfPDVYPl2EzWxlyxy6YpPIbbRJhy9JRRCtdelzvzK5ZOfNICRsRO4IaeVgJul
 2OglheL2S5dOOrsgrH9+az03f3fu/mMvVFgQVPlBuQNGIZGXvqR1VNya9FROntUsc/BrjA2Z4x+
 zGuIWgKLBaOkgMqaCFyVDFJYhZsjxyRiDOcIoVYvFjevye37bHvB7jLr5UYboJqLPid1G1uA539
 pHvsw5BJkySi2d9JodZZukZJ94/0TT2dusVzra2epR6bFz9Q4UQNqjP3H3whl9fthMLK1jLR4Yn
 Q++RT1o9TzIREb8s/DlnFwwuGOzUJj5dMY7orwlgcdXAPvwLcnxoOeskcp0xm+jtAMP5vufa
X-Proofpoint-GUID: Bw7PIeJ20BfgGRV3wemud4nulmdlNIEw
X-Authority-Analysis: v=2.4 cv=Xuf6OUF9 c=1 sm=1 tr=0 ts=6871b350 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=lFCKDqVE_jtoW-ZCWqQA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: Bw7PIeJ20BfgGRV3wemud4nulmdlNIEw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_07,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 adultscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507120005

Currently, the DP link training is being done during HPD. Move
link training to atomic_enable() in accordance with the atomic_enable()
documentation.

In addition, don't disable the link until atomic_post_disable() (as part
of the dp_ctrl_off[_link_stream]() helpers).

Since the link training is moved to a later part of the enable sequence,
change the bridge detect() to return true when the display is physically
connected instead of when the link is ready.

Finally, call the plug/unplug handlers directly in hpd_notify() instead
of queueing them in the event thread so that they aren't preempted by
other events.

Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 15 ++++++++-------
 drivers/gpu/drm/msm/dp/dp_drm.c     |  6 +++---
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 87f2750a99ca..32e1ee40c2c3 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -410,11 +410,6 @@ static int msm_dp_display_process_hpd_high(struct msm_dp_display_private *dp)
 	msm_dp_link_psm_config(dp->link, &dp->panel->link_info, false);
 
 	msm_dp_link_reset_phy_params_vx_px(dp->link);
-	rc = msm_dp_ctrl_on_link(dp->ctrl);
-	if (rc) {
-		DRM_ERROR("failed to complete DP link training\n");
-		goto end;
-	}
 
 	msm_dp_add_event(dp, EV_USER_NOTIFICATION, true, 0);
 
@@ -1561,6 +1556,12 @@ void msm_dp_bridge_atomic_enable(struct drm_bridge *drm_bridge,
 		force_link_train = true;
 	}
 
+	rc = msm_dp_ctrl_on_link(msm_dp_display->ctrl);
+	if (rc) {
+		DRM_ERROR("Failed link training (rc=%d)\n", rc);
+		dp->connector->state->link_status = DRM_LINK_STATUS_BAD;
+	}
+
 	msm_dp_display_enable(msm_dp_display, force_link_train);
 
 	rc = msm_dp_display_post_enable(dp);
@@ -1706,7 +1707,7 @@ void msm_dp_bridge_hpd_notify(struct drm_bridge *bridge,
 		return;
 
 	if (!msm_dp_display->link_ready && status == connector_status_connected)
-		msm_dp_add_event(dp, EV_HPD_PLUG_INT, 0, 0);
+		msm_dp_hpd_plug_handle(dp, 0);
 	else if (msm_dp_display->link_ready && status == connector_status_disconnected)
-		msm_dp_add_event(dp, EV_HPD_UNPLUG_INT, 0, 0);
+		msm_dp_hpd_unplug_handle(dp, 0);
 }
diff --git a/drivers/gpu/drm/msm/dp/dp_drm.c b/drivers/gpu/drm/msm/dp/dp_drm.c
index b12a43499c54..3bcdf00b2d95 100644
--- a/drivers/gpu/drm/msm/dp/dp_drm.c
+++ b/drivers/gpu/drm/msm/dp/dp_drm.c
@@ -26,10 +26,10 @@ static enum drm_connector_status msm_dp_bridge_detect(struct drm_bridge *bridge)
 
 	dp = to_dp_bridge(bridge)->msm_dp_display;
 
-	drm_dbg_dp(dp->drm_dev, "link_ready = %s\n",
-		str_true_false(dp->link_ready));
+	drm_dbg_dp(dp->drm_dev, "connected = %s\n",
+		str_true_false(dp->connected));
 
-	return (dp->link_ready) ? connector_status_connected :
+	return (dp->connected) ? connector_status_connected :
 					connector_status_disconnected;
 }
 

-- 
2.50.1


