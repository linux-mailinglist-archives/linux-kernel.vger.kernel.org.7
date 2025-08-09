Return-Path: <linux-kernel+bounces-760887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 681FCB1F19F
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 02:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88F1D17953A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 00:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4AF2459C9;
	Sat,  9 Aug 2025 00:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E+SL+fuf"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0AF237A4F
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 00:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754699748; cv=none; b=HmRwYdIOGq6iah6G9eY5d2MjiUhPHvu9UTkeIH/tLn/Zrk5TOrk2ybj/4VxkUwCkiBCEof2AVSpxVLgm3Ag4vmHrYbT38y/+JJCF9WcFBIfAHNBh1K0lPx0Xy/e3h07ptrG+u5RFQCtgUXtmDCYIYQehzPtPUiZfm6YDMpiQrQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754699748; c=relaxed/simple;
	bh=29HYP/DXnl5EwK/8eh4LDOHT+urC513pYg2fM9mWL2U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rdvrh73fLYvIrkSKSAjNC0A42gvh8F+Psh6FUCuIliCG5doLgvyvfNGT2y/Hg35PSs0sjXa7aCDLxp+iuwy6kWuvrRHxsfEkiB8mgkOi53KC1ap0w9c8WeEuI4w+qXc6Ac48zlNWyVUs76gnPV3qK8qPgGFJQSbIcKIre1jgybA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E+SL+fuf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 578NvISk013733
	for <linux-kernel@vger.kernel.org>; Sat, 9 Aug 2025 00:35:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1hdCfTP1N1Lll13RFi4QL7o8c/WBGzlCEwL+AMYyzJM=; b=E+SL+fufl61vfuki
	fbXAWnPJNTGbn1TtP32D96aGYWG66TAvIz1ls1heHdVLJhJ6l1leMvSqBGe7l/2u
	+ANgQoqNvvFNAsy0Pm3lHdb1UBsy4Sf8h+R24sF5VbNtQDlw67ZGZdu1QmidD3br
	vjWQ0N+H61kkPE3tThVmZ21ddln1VstzvLQaExVJJOMup4G3nNywTVOiNL8Uq2tP
	bx3R91/G4Z6/9474W9SLawl5Hvyw0WSeN/OdQh01jJUTJLb0NbKZ8Kkj7ZCBroa1
	MWVjTlBzNLeU5a/UW71dGOw6Ib/RR0lozSXh2m4Xg286s2pWr4qx/Lwkr5LOPpuh
	5DGmKA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48cpvy69d6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 09 Aug 2025 00:35:45 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2400a0ad246so21448875ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 17:35:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754699744; x=1755304544;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1hdCfTP1N1Lll13RFi4QL7o8c/WBGzlCEwL+AMYyzJM=;
        b=uk0sRPE1eOc+PQ02T0pu5Qv1Mo3ctpCmubYFKPNZGc4PHMnHTSfcGNY7DBXa/THBWr
         vhYCqTg2Pn7hWd7D/2E0tGMeFJYzdjCnpRZqycb6Yski3dyGGAs/Nawt58IXuO3180mf
         le6O3oKkHm/lQHo+N63tKkNJPDgJmw8NZ6xJjI0PVF5nSxtfQ+EAJ68XT1vu8K3LpGP/
         2crDzZXUzcG2mZ0Dz353oKIj7WJwmjeSY9gJlh0VKwQc+rOLHs0ZRqVBS9EEfm8CDK4c
         4m97CcP4sz3zdsbHdWMSOJ2zYEmvGpZZnDOjZPseJSB3EmTMTrAKm3gVVcR7KN74JAk7
         E+Hg==
X-Forwarded-Encrypted: i=1; AJvYcCXH3ISmEF4VnJWoKfZ2uqhcgsCr+3BwLuktggYfC2pk2aKTW5QnU5yVcqrcTOvf2u3vat4ZqsY09cuh4pI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHf49GqozbYsst5nNeQmwdt59MfNtCM6VZ7SLGbl9FvQ6puVPd
	rdKhZUHCF980JP64NHwWYlNcbwPZfrpmxTAq50XSuO5c60AhalqEjE7kZcorb8toJjl2pwKCJmN
	xnJJh1KtLMctOkcwPUFxz0RmlxRxxL1keaa3Br7oPdoEF8ezAr+xQpnyVKmh55T0eLXY=
X-Gm-Gg: ASbGnct/qNlvUfxHCnBRk9sHKWlj7Q2moY2CyD/T4TQyTxl1VwIAkfjehpQwh3+ukIT
	UzlJ9VfDdSqKLBaeHCsNYrbzdmRGiKna158kukanX842K4ail3Si322sG7jZ3/DB+MTWfsf8xTk
	mMAbdgmklNYmpG+gWIue4sdQXUfSeUFnlJyHImbwHQnVmsPJcbMeQ6RmDo+lufHh0jdXUvZOGOC
	LaWWqvj5rkckcSZsU5nBs6hg1B4qqIbZjZ1rrQtAIQayNYCC/suUCfoVYsMI3vuCwVEsYjwx5bp
	whggDuGBM/pOwVjLBlXCT8X2LyFwbY1RRAPd4t4dDFSqa7EE/CYQ8MOHNDEFwu8sNngTkZjrYDx
	emb8fVRr/DaejIJmRi4LXdB1b
X-Received: by 2002:a17:903:1c9:b0:240:e9d:6c54 with SMTP id d9443c01a7336-242c2271e8dmr79852985ad.48.1754699744034;
        Fri, 08 Aug 2025 17:35:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHiff/ThYc6UuyZtbEXTBnN49IuMPgSQgl9gfWHA+0K+TeLvuc4b9uNZ9TWhJt8aKuTgT0LiQ==
X-Received: by 2002:a17:903:1c9:b0:240:e9d:6c54 with SMTP id d9443c01a7336-242c2271e8dmr79852665ad.48.1754699743574;
        Fri, 08 Aug 2025 17:35:43 -0700 (PDT)
Received: from jesszhan-linux.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef678dsm219865355ad.39.2025.08.08.17.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 17:35:43 -0700 (PDT)
From: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
Date: Fri, 08 Aug 2025 17:35:18 -0700
Subject: [PATCH v2 06/12] drm/msm/dp: Use drm_bridge_hpd_notify()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250808-hpd-refactor-v2-6-7f4e1e741aa3@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754699734; l=2470;
 i=jessica.zhang@oss.qualcomm.com; s=20230329; h=from:subject:message-id;
 bh=29HYP/DXnl5EwK/8eh4LDOHT+urC513pYg2fM9mWL2U=;
 b=hUDrHjRGa0KSwFA/brYTaqQ3aB1uEyojqFJUPg/WEOdZZ0zMPAQBmtvg12Q6ggaRIFRwqN2hA
 NgI6QAvH7kCA9iTY0rUfx519/9SnrO0gy/ydRL5EGu4CCUm7Fs+e6Ka
X-Developer-Key: i=jessica.zhang@oss.qualcomm.com; a=ed25519;
 pk=gAUCgHZ6wTJOzQa3U0GfeCDH7iZLlqIEPo4rrjfDpWE=
X-Authority-Analysis: v=2.4 cv=TJpFS0la c=1 sm=1 tr=0 ts=689697e1 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=vUZxlgmVQAOzQBO0PGoA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: Dg25MCErl5KM5mBXx3jjQl4LGI5t0e2y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA3MDA0NiBTYWx0ZWRfX3BiHui2Dkgnk
 zb/e7DMgqQ0MokZIyOjVlRz2eDom33QGcML4261QSr7PEQhvGWr+ifK6uL8hJO/5tM6h9nuipU9
 9OM5iNR2kVZ0L2B/yCPb+eDtC6B6t0d4AFJdnDXNbLwwfK647uaH2ROJmHE8hmOJTcwMlqkj9R4
 Uj87NYYyjcJuyn/PCuOQ9sAaekMhXZChIMFN5SV1RXV0O4fE3gygJrVsY45Kp1Epy07rUHaLRx5
 Xe4fa8dU5e11ucfPCY1ZlJQSmpxVtODNVyxGr+AOpZdkp0j8Hnn+dJkOG/aqLQtZFtvEv+mdSO6
 vscgvFjviVU1P5Jore6Q4ZZiGiOKV5VEZMstTWV2deJPU0eKvDqp4D95qGsdEny9QrJkRje8l3c
 bB7gVAN2
X-Proofpoint-ORIG-GUID: Dg25MCErl5KM5mBXx3jjQl4LGI5t0e2y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_08,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 adultscore=0 spamscore=0 malwarescore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508070046

Call drm_bridge_hpd_notify() instead of drm_helper_hpd_irq_event(). This
way, we can directly call hpd_notify() via the bridge connector.

Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 17 +++++------------
 drivers/gpu/drm/msm/dp/dp_display.h |  1 +
 drivers/gpu/drm/msm/dp/dp_drm.c     |  2 ++
 3 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 55fe8c95657e..8779bcd1b27c 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -333,17 +333,6 @@ static const struct component_ops msm_dp_display_comp_ops = {
 	.unbind = msm_dp_display_unbind,
 };
 
-static void msm_dp_display_send_hpd_event(struct msm_dp *msm_dp_display)
-{
-	struct msm_dp_display_private *dp;
-	struct drm_connector *connector;
-
-	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
-
-	connector = dp->msm_dp_display.connector;
-	drm_helper_hpd_irq_event(connector->dev);
-}
-
 static int msm_dp_display_send_hpd_notification(struct msm_dp_display_private *dp,
 					    bool hpd)
 {
@@ -367,7 +356,11 @@ static int msm_dp_display_send_hpd_notification(struct msm_dp_display_private *d
 
 	drm_dbg_dp(dp->drm_dev, "type=%d hpd=%d\n",
 			dp->msm_dp_display.connector_type, hpd);
-	msm_dp_display_send_hpd_event(&dp->msm_dp_display);
+
+	drm_bridge_hpd_notify(dp->msm_dp_display.bridge,
+			      hpd ?
+			      connector_status_connected :
+			      connector_status_disconnected);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
index cc6e2cab36e9..60094061c102 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.h
+++ b/drivers/gpu/drm/msm/dp/dp_display.h
@@ -16,6 +16,7 @@ struct msm_dp {
 	struct platform_device *pdev;
 	struct drm_connector *connector;
 	struct drm_bridge *next_bridge;
+	struct drm_bridge *bridge;
 	bool link_ready;
 	bool audio_enabled;
 	bool power_on;
diff --git a/drivers/gpu/drm/msm/dp/dp_drm.c b/drivers/gpu/drm/msm/dp/dp_drm.c
index e4622c85fb66..f935093c4df4 100644
--- a/drivers/gpu/drm/msm/dp/dp_drm.c
+++ b/drivers/gpu/drm/msm/dp/dp_drm.c
@@ -340,6 +340,8 @@ int msm_dp_bridge_init(struct msm_dp *msm_dp_display, struct drm_device *dev,
 		}
 	}
 
+	msm_dp_display->bridge = bridge;
+
 	return 0;
 }
 

-- 
2.50.1


