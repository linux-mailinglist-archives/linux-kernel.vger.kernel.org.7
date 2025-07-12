Return-Path: <linux-kernel+bounces-728481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83012B028C8
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 03:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83F833BC16D
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 01:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A23922B8CF;
	Sat, 12 Jul 2025 00:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JvtJ3mq5"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0022017A2E2
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 00:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752281939; cv=none; b=dqs/PWFzJ2tOlvrsunYyTX3b12y0nwpzuhxZOAU91IenChTjB4isuKjrFsgSWr/itXzmvKgsoW2dKeJS+JBUVpdUg6pqFWrxJAGoEy1Tx+HVp92kg0BKa3ojjDlZYE0L8E2W3ZGcfvwrLiwoAyAsCxFLi6Z2XY4xYBVn39LWosI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752281939; c=relaxed/simple;
	bh=cVrxZLsPS+6RQHt1ufzsG9tg+vHQCxscM1KTv98juZc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G0UeI2TrAtZa08O3GE5tchwTbHuOMOKjPS6BWrVBrAgFl4kb90dv7x3V8TnJW5u3SEB0YsHSKmM36WYH1zV9AP9fNS/f45vX2UfOgVlE6q2bqiZYHAPfsZMLHSZ9dbQzU6q7F+INDJvGTh5u7rhLl5vcKIwfQ/h60Dyuo11ijaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JvtJ3mq5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BNYVCx003817
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 00:58:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	brzXIsHemnuaxFgKGlGWJGmC5q7fHaCKN6Y5ci5Sa70=; b=JvtJ3mq5keG3hAtJ
	S++6Zgv9QIInRxQqSVkuRzN1cACQbPbAWzx+nPqub3t9a7tRHb/5pwzBc7welOst
	H/hqXh1CpgpTghBSEq/dl/uH286XyFxYYMNrVJS96V/nBgKqEI7yfAZXbIjbx2iD
	FWFWQViAYlBoegE+SswzcErnGbGVdUQQcAb+WIWqxqqUZmcBTOd0OcwjSdwMzL0o
	hJCC8ApOP6lDFA2K7dY/nFbzn9wSo+/BHo7uDw8xTJHxkB9P/COgqJ5Uo9cbbG8p
	C6ThQxA4FCafGJb5SnRivWPE+/Evf6MgM420CiPIixrLTpzsmRCvtP3/ES4cU4RG
	3T8irA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47smbp29yd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 00:58:57 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-313d6d671ffso2413403a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 17:58:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752281936; x=1752886736;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=brzXIsHemnuaxFgKGlGWJGmC5q7fHaCKN6Y5ci5Sa70=;
        b=vYYEEExjarPqPho1Ybt/piNtn2oLAS+NCvdM3hHIP5AppThHRsg7gLg3Iut/lWzjoz
         boHDZBxxHl7pEBK51TEsMCqavI5tKgH408grDHBLdxnJaYuz3WWsxtcuQfXYHGFNVAuv
         uAlH1F4ISjMvNlrZsq/zmR55UvPSRBEEz5AJDkTDuhESF24gTG2EXBPQ6MPmLci7vMk3
         lJs75czxCEe6f1wm0kpifxpPKQsAgKVxH5HF65/xZYkAHKuQaCCn+sdddqiNczhPNhGm
         Oq2Lvf9WG1zNha2eJcHTvrlszjtOLkPYxcRabKdyJgejUuIPyjvSGJSnhGbsVDx8yeNS
         Zx0w==
X-Forwarded-Encrypted: i=1; AJvYcCUcdFr5M+69PRx+mYxggzkcDXqVbMsPXC44SFashtf3FAkdUMKTfDN/tWUTIOuFucwlC2gmYS8IEgDxXew=@vger.kernel.org
X-Gm-Message-State: AOJu0YwelUj90/eU3WwJDcDVypeKMEaqJBRnnkpqGs1mrZYn4L28weKM
	vkHP19spapBg0Nmd80jkgj1dSrYhTwgHqZK4X+FcsMCTtuFAr46Zsrv62PAtLCL28Tfi9GknW1N
	u3FT+h6iaduyRD1AySu3VO6WxVvUR+GNCGFx3/TiS7qKxY/2CBiZjR3x1KTUlnZJpaic=
X-Gm-Gg: ASbGncsn45zrKKYgHQqhCGNISV6PkhFZeLcbUQh9fr2IzxX2VrBtbqjziJV75trMPfN
	GreAx5Y44Nc4GVf6A4xdsHBCoqw98ZCkLV3attY5Q8Ig+ussKYW/OXhu63/e0dXqwYoOVA3IfsQ
	MPaixaJQ/0kRWqSAUsvjN0Y8hSTdj/3v+a23aKa0bXPjBHH5NNZ6y0K/gQxPwgo2/a7Xm20Bno3
	JL8cHJU0ksTiH3mLqO+NupycroBV6SaXGra2uh3oVyTh373OVSMb/IDx/tS6r0a3Twh4YCUVgkz
	x/TwKqlWOHwDZi/J75Dv4gwtHU1vMh+oiI+zaUaA1G+eKwMS4e7e15POs6xBUbuWBhB1XKzEHhe
	v+7LaIR00mGomGag4tlGUTbs2
X-Received: by 2002:a17:90b:33d1:b0:31c:15d9:8a8 with SMTP id 98e67ed59e1d1-31c50d5dfc7mr5338694a91.1.1752281936307;
        Fri, 11 Jul 2025 17:58:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvo9hbWXSjbIaLy6V9BoL7KWqzJCvsi54CA7ay9HQd27IGhLWtKXupp2h3sOg371TH9ZnR9w==
X-Received: by 2002:a17:90b:33d1:b0:31c:15d9:8a8 with SMTP id 98e67ed59e1d1-31c50d5dfc7mr5338667a91.1.1752281935841;
        Fri, 11 Jul 2025 17:58:55 -0700 (PDT)
Received: from jesszhan-linux.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c23006d72sm5202274a91.1.2025.07.11.17.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 17:58:55 -0700 (PDT)
From: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
Date: Fri, 11 Jul 2025 17:58:24 -0700
Subject: [PATCH 19/19] drm/msm/dp: Log connected and link_ready for event
 handling
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250711-hpd-refactor-v1-19-33cbac823f34@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752281905; l=4119;
 i=jessica.zhang@oss.qualcomm.com; s=20230329; h=from:subject:message-id;
 bh=cVrxZLsPS+6RQHt1ufzsG9tg+vHQCxscM1KTv98juZc=;
 b=FuqweivJeealXfSD8xy2eFBqVIbs56G1r5I9+i1Cn2gvrrUFh80/4K/TytFcQpIvOJpGHGp+J
 QErTeVZWORFBk8y5k9LYBtXb1jKvneKx5O1SPg+6mgQKvSpGhB4WYQ7
X-Developer-Key: i=jessica.zhang@oss.qualcomm.com; a=ed25519;
 pk=gAUCgHZ6wTJOzQa3U0GfeCDH7iZLlqIEPo4rrjfDpWE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEyMDAwNSBTYWx0ZWRfXyjj7mspEDwkW
 WnB/ng9EiFGUGEnI64MJ3Hlp1QUiZOs8lWrIXMD/G9BGDn7mmaRwgS2SU5LfTnXwLWLE1aGEXvq
 a60GzLklx5gWXyUPpC6iPkf1JzLfvcYtRY1jIKJx4DhPqrZU4uJyw9D/A/85aC+zLKHp77pDKD/
 Ul5oZqJ6qkclHnCh4q5c8eWcMFRmd7vdXQAm18aBkmJejacXdtb9fdCkI1NexAPErhm0rlDO8x7
 T7imoArgDM1wRPAmdMh3hDCZ8v9RxaLrOoCaVmg3oNwuCqdHdrSfphycGbIYBkNesLbuR/8Op6P
 G3NC13WM0PvGbc1tWeyRRRpNDU381A77HYHbD/LfWTJQV0eHM+0CdIvBKWPlFe0QhiUR3E/uBJ4
 Xaua1FZnvAYLvxed9dE5vxOM9+b3PS7kp4jDsdzM9Uwz0V4aP0mlfWWbOW4gWwk9ODDdGFwt
X-Authority-Analysis: v=2.4 cv=QM1oRhLL c=1 sm=1 tr=0 ts=6871b351 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=ZRSb5Y5lcQKK3ktpWfgA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: dPtSOBWQT4UXTWefs0M_IdA2nH5ParUg
X-Proofpoint-GUID: dPtSOBWQT4UXTWefs0M_IdA2nH5ParUg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_07,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 adultscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507120005

Add the connected and link_ready states to the debug logs for [un]plug
and HPD IRQ handling.

Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 38 ++++++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 32e1ee40c2c3..6cff87e4ad9a 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -543,7 +543,9 @@ static int msm_dp_display_usbpd_attention_cb(struct device *dev)
 	rc = msm_dp_link_process_request(dp->link);
 	if (!rc) {
 		sink_request = dp->link->sink_request;
-		drm_dbg_dp(dp->drm_dev, "sink_request=%d\n", sink_request);
+		drm_dbg_dp(dp->drm_dev, "sink_request=%d connected=%d\n",
+			   sink_request, dp->msm_dp_display.connected);
+
 		if (sink_request & DS_PORT_STATUS_CHANGED)
 			rc = msm_dp_display_handle_port_status_changed(dp);
 		else
@@ -562,8 +564,10 @@ static int msm_dp_hpd_plug_handle(struct msm_dp_display_private *dp, u32 data)
 
 	mutex_lock(&dp->event_mutex);
 
-	drm_dbg_dp(dp->drm_dev, "Before, type=%d\n",
-			dp->msm_dp_display.connector_type);
+	drm_dbg_dp(dp->drm_dev, "Before, type=%d connected=%d, link_ready=%d\n",
+			dp->msm_dp_display.connector_type,
+			dp->msm_dp_display.connected,
+			dp->msm_dp_display.link_ready);
 
 	if (dp->msm_dp_display.link_ready) {
 		mutex_unlock(&dp->event_mutex);
@@ -585,8 +589,9 @@ static int msm_dp_hpd_plug_handle(struct msm_dp_display_private *dp, u32 data)
 		pm_runtime_put_sync(&pdev->dev);
 	}
 
-	drm_dbg_dp(dp->drm_dev, "After, type=%d\n",
-			dp->msm_dp_display.connector_type);
+	drm_dbg_dp(dp->drm_dev, "After, type=%d connected=%d\n",
+			dp->msm_dp_display.connector_type,
+			dp->msm_dp_display.connected);
 	mutex_unlock(&dp->event_mutex);
 
 	/* uevent will complete connection part */
@@ -615,8 +620,11 @@ static int msm_dp_hpd_unplug_handle(struct msm_dp_display_private *dp, u32 data)
 
 	mutex_lock(&dp->event_mutex);
 
-	drm_dbg_dp(dp->drm_dev, "Before, type=%d\n",
-			dp->msm_dp_display.connector_type);
+	drm_dbg_dp(dp->drm_dev, "Before, type=%d connected=%d, link_ready=%d, sink_count=%d\n",
+			dp->msm_dp_display.connector_type,
+			dp->msm_dp_display.connected,
+			dp->msm_dp_display.link_ready,
+			dp->link->sink_count);
 
 	if (!dp->msm_dp_display.link_ready) {
 		mutex_unlock(&dp->event_mutex);
@@ -641,8 +649,9 @@ static int msm_dp_hpd_unplug_handle(struct msm_dp_display_private *dp, u32 data)
 	/* signal the disconnect event early to ensure proper teardown */
 	msm_dp_display_handle_plugged_change(&dp->msm_dp_display, false);
 
-	drm_dbg_dp(dp->drm_dev, "After, type=%d\n",
-			dp->msm_dp_display.connector_type);
+	drm_dbg_dp(dp->drm_dev, "After, type=%d connected=%d\n",
+			dp->msm_dp_display.connector_type,
+			dp->msm_dp_display.connected);
 
 	/* uevent will complete disconnection part */
 	pm_runtime_put_sync(&pdev->dev);
@@ -655,8 +664,10 @@ static int msm_dp_irq_hpd_handle(struct msm_dp_display_private *dp, u32 data)
 	mutex_lock(&dp->event_mutex);
 
 	/* irq_hpd can happen at either connected or disconnected state */
-	drm_dbg_dp(dp->drm_dev, "Before, type=%d\n",
-			dp->msm_dp_display.connector_type);
+	drm_dbg_dp(dp->drm_dev, "Before, type=%d connected=%d, link_ready=%d\n",
+			dp->msm_dp_display.connector_type,
+			dp->msm_dp_display.connected,
+			dp->msm_dp_display.link_ready);
 
 	if (dp->msm_dp_display.link_ready != dp->msm_dp_display.connected) {
 		/* wait until connect/disconnect handling is completed */
@@ -667,8 +678,9 @@ static int msm_dp_irq_hpd_handle(struct msm_dp_display_private *dp, u32 data)
 
 	msm_dp_display_usbpd_attention_cb(&dp->msm_dp_display.pdev->dev);
 
-	drm_dbg_dp(dp->drm_dev, "After, type=%d\n",
-			dp->msm_dp_display.connector_type);
+	drm_dbg_dp(dp->drm_dev, "After, type=%d connected=%d\n",
+			dp->msm_dp_display.connector_type,
+			dp->msm_dp_display.connected);
 
 	mutex_unlock(&dp->event_mutex);
 

-- 
2.50.1


