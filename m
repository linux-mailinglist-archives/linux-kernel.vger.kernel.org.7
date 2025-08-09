Return-Path: <linux-kernel+bounces-760885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 431E8B1F19B
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 02:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 176991AA7177
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 00:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C76F23F40E;
	Sat,  9 Aug 2025 00:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="INIUqQF4"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C484523B61D
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 00:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754699745; cv=none; b=XCeXBePyp219C/UJzBNUYP3vF4B3iFjTj1sfmIQKdH5EHCoeJKKd4e85wbmaNi3Et/rc3MJilZIx6A9mfN/7YH2jIjRSTLBNLWyH4rki1mZY46umJghagjYORgW9mown6ko9VBfcnuNNKbeoeP5BIBw6dIOx0MqyAIlM3LqgpIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754699745; c=relaxed/simple;
	bh=58pz+VUOHj7Z0Ly24ZItrTkzzLlWR66ogd2xqPyF3A4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NURRH+C1z+b/eNVz/V4WyG/xVzrxXwJ+8EUpiGxdWVowBhX0ywfI/RaTJUqZG9OmCdpoI8dSUcMIZYNeKWe+18GiWxGSPK7lljjVZcr4ea5z8KZoubXwyH7BprMSFnAeP8R3Qhj4jzrQq6D0SGRPLqmjp2TOyrSvMRa1CF+tJIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=INIUqQF4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 578NH37o022931
	for <linux-kernel@vger.kernel.org>; Sat, 9 Aug 2025 00:35:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kXOtZj4AG8lm5vvINjpaTa4etK/yY7fA6vbU8dIkBcE=; b=INIUqQF4UXhK3SDP
	GO1CXtEMfLZ+Ne58RgutuB9EckctL1e9qnrhGKCqqnTNNunahUGEjjvCEuRURzWR
	gVPhekfA40jZs6PX6nkJNTpTorueSx0BWIYuTJwwRXhdqP7zR57B3QfhOU7TcN9Y
	M6g6R6S95OHvlY4j4RY0sFV4etKUxiDfXDr/l+s365Qy8qd0dmyreD8APc1GOF4u
	M+Nx/MmzHKpLBTtAvGqwMGT9u9v+cGYi5tj+QnavJV5il+q9Qr66bvU/vVKgcFz6
	6vL5a5/xWBI2nd0hUBleR+gErZrtOP3AqwJAO55O3frzCq6dBS/F2skGLR9Cr/Mw
	J1q1Cw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ddkkt5q7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 09 Aug 2025 00:35:42 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-23fc5b1c983so37978945ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 17:35:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754699741; x=1755304541;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kXOtZj4AG8lm5vvINjpaTa4etK/yY7fA6vbU8dIkBcE=;
        b=lFsutzubUJEjU7pibbPAmshMr+CiMT+S8e8XC9HHMUJGaa/0DZHZsl76hkq8rR1b8X
         HOyxe7D1qHQGtPVr1atC0fhQzoxWZUB5Tjp1UdH4tIYbzUf3nilGXXLsM2RDU/ylM8Tl
         IWtXn5+BuJKnqK9nKSzkFlDVqUBJ+x842PB4sYviqZQoXF7C5rur1tYVAP8zcAc7uEe0
         6ZxItXlsOu+oSh838xbwP48ccNl6qUsGxaRtDm8oGVSa+7tD1aKQsrrhYu0A390pO8u9
         HunvjfVkECnUKm6YbiIMmhUczCo2Hb42IngFdKxN7UJjyOXLmK4bzMpdMgNQmGK4eCp7
         3Siw==
X-Forwarded-Encrypted: i=1; AJvYcCVjuNjmwJxaKH3iFrK23jPWZS5G2vNPkMta3qzQQzCc4FHvfotkIlqX8TDN8DqYaHzt+9z8WpzPIVi6Fiw=@vger.kernel.org
X-Gm-Message-State: AOJu0YydtKgMSGMHzPRdfelsvhMmoaaBcefO0MHNEheSeEo5wNbif48I
	gjhaNO0ZS9EtZ56VxG6m8EQyRSYJv0eDum0pKSPg+13+LX2F4nFuW7KptLASwdPP5UrV/xG8YTf
	o7qr2ivA9IdE6SxBG/dmhuZm6xsis04PgTZvHKgUQCM3+exPCPRtPha3xMYXX0mlQQCI=
X-Gm-Gg: ASbGncvC6TOeSBEFxw64Bq3utYp9kcB1yLkYphj59GK2AKHcdoTcUlkuCNwE2bVoqyg
	QyL7iD/FPYDeldCc+8I9aE3f5eR18A/SqlEIYMEZdC+epjG7HiB21ymayiAGI+iw4chDjuz5eXW
	UqW2baHNscQWwyO9rY/sSkK/mg27HZDlygWn9hYRQYt7eExmzfIEth8fzq2y7mlZWWeo59CknN5
	vTQU2g8bQC6BY3u1dOlXzlAMlx+Frl3I5OBy4SnqLUipHHMGwIOq84YD+quHW774jiugvtHlz2F
	VZj5pkLKe8tDd0ypl5yECGn8YyA1KqlOZ0Jf37FjTIRhMnE3BHL2/DyzqY7k1P7h0tj+RLB2N6d
	GZEWRowHfR92Dwb6otMKlaIns
X-Received: by 2002:a17:903:3d06:b0:23f:b00a:d4c with SMTP id d9443c01a7336-242c29cdd3amr60381435ad.2.1754699741447;
        Fri, 08 Aug 2025 17:35:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDyEuI8cudsyGtLHsEqiFHexgdl0zgq5jG1/dngt6evbM2Zkgpc/LBc1GnzKw2QMS85nXS1A==
X-Received: by 2002:a17:903:3d06:b0:23f:b00a:d4c with SMTP id d9443c01a7336-242c29cdd3amr60381135ad.2.1754699741056;
        Fri, 08 Aug 2025 17:35:41 -0700 (PDT)
Received: from jesszhan-linux.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef678dsm219865355ad.39.2025.08.08.17.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 17:35:40 -0700 (PDT)
From: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
Date: Fri, 08 Aug 2025 17:35:16 -0700
Subject: [PATCH v2 04/12] drm/msm/dp: Move link training to atomic_enable()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250808-hpd-refactor-v2-4-7f4e1e741aa3@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754699734; l=2088;
 i=jessica.zhang@oss.qualcomm.com; s=20230329; h=from:subject:message-id;
 bh=58pz+VUOHj7Z0Ly24ZItrTkzzLlWR66ogd2xqPyF3A4=;
 b=eSNm82PX5XDbPsqU0qhNfwtEkv99SM1nnMQfbj8CUV4Yiqt32zqfug2mQbHMfdphj2pXeeZq+
 a5+8ZGyjM2+Atpl7P0zmlxH63kdl24dOubtns2aknTDjXqXQGWkE6tQ
X-Developer-Key: i=jessica.zhang@oss.qualcomm.com; a=ed25519;
 pk=gAUCgHZ6wTJOzQa3U0GfeCDH7iZLlqIEPo4rrjfDpWE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA4MDA2NiBTYWx0ZWRfX6F+15/khZKz7
 Gxx1379PcEHNk8HNSWYhFjlQgaUu7n4E59JLJk9x9S55ZCC1TvnehclAYWQtGRk9V6rl2h3dBsf
 R97WKvG3/wSrQV+lSmWmf4YTd7hrMBbizM6gJ9lw99hnQZ+VxWsYWfWvCURFn0CEZErnAq8P+Aw
 rsctOHYWOZPy1tK6tn5scoXHPZiTaeRer7WxRBQOYpjCAH3P4khOjovv5FoqdkNq4ArcEwAxlz0
 2E4etq6/TE0CpxtGX06RtGwtPdGJoD/Lj5sIFoV8FwffOpxcuG16a1IbOl2n8G/nKjFSRa0EUBi
 HG6bGeGbIL2By6ZtzL68H3h3uqzv4/weBkIwpDnVsUrERcY6f6RNnvoVzTqlONMW5dh6OIGQgyX
 iVJl72TX
X-Proofpoint-GUID: 5P4wj2eLPQM1TZCMI5vWnKD669MI-Z4y
X-Proofpoint-ORIG-GUID: 5P4wj2eLPQM1TZCMI5vWnKD669MI-Z4y
X-Authority-Analysis: v=2.4 cv=Xpv6OUF9 c=1 sm=1 tr=0 ts=689697de cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=3k-UeYenDjfnnxpotcMA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_08,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 malwarescore=0 adultscore=0 phishscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508080066

Currently, the DP link training is being done during HPD. Move
link training to atomic_enable() in accordance with the atomic_enable()
documentation.

Link disabling is already done in atomic_post_disable() (as part of the
dp_ctrl_off_link_stream() helper).

Finally, call the plug/unplug handlers directly in hpd_notify() instead
of queueing them in the event thread so that they aren't preempted by
other events.

Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index e2556de99894..c849befe58f0 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -427,11 +427,6 @@ static int msm_dp_display_process_hpd_high(struct msm_dp_display_private *dp)
 	msm_dp_link_psm_config(dp->link, &dp->panel->link_info, false);
 
 	msm_dp_link_reset_phy_params_vx_px(dp->link);
-	rc = msm_dp_ctrl_on_link(dp->ctrl);
-	if (rc) {
-		DRM_ERROR("failed to complete DP link training\n");
-		goto end;
-	}
 
 	msm_dp_add_event(dp, EV_USER_NOTIFICATION, true, 0);
 
@@ -1680,6 +1675,12 @@ void msm_dp_bridge_atomic_enable(struct drm_bridge *drm_bridge,
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
@@ -1839,7 +1840,7 @@ void msm_dp_bridge_hpd_notify(struct drm_bridge *bridge,
 		return;
 
 	if (!msm_dp_display->link_ready && status == connector_status_connected)
-		msm_dp_add_event(dp, EV_HPD_PLUG_INT, 0, 0);
+		msm_dp_hpd_plug_handle(dp, 0);
 	else if (msm_dp_display->link_ready && status == connector_status_disconnected)
-		msm_dp_add_event(dp, EV_HPD_UNPLUG_INT, 0, 0);
+		msm_dp_hpd_unplug_handle(dp, 0);
 }

-- 
2.50.1


