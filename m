Return-Path: <linux-kernel+bounces-835307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7805DBA6B2E
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 10:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DBF33A9402
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 08:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684352BEFFE;
	Sun, 28 Sep 2025 08:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LxJ3zEoX"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECC92BEFE4
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 08:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759047906; cv=none; b=bf4Oyoz3EaL/yFDQyJ5BtCoE0+yWFY1Cwkn1YAjkLdZMPa/dSh6tdAvcbEqP7i5BJwHrBdHc3q5DnmDAB4FxCJlrh5Nv/+zGSBot9ildahtjMcEgBuV5gtFnP6R9p+Nk67uvtJEyWLvpPva+cDOt3AaohKHKRFfnhwYBU0nK/mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759047906; c=relaxed/simple;
	bh=RSyQmL3DOBdLluC0mSQhrTNOeUIpwQM2CI/HP9Sdsjg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YKFy0b/X5TJMEhL4Grqo6rhUu3O4R9WCJ+CgPKQPXOAi2dnj506/8mDyFHdq3R/BSm4Wzdqgy/V1T2KD8tYHSvDlBzr0NTl6Q7surLvnJ/6C5XlejNZESLzuzpiQEEhIgAwDVmuEevTLRsmfvvbFzD+klqcdzikGhFbKu4xFeWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LxJ3zEoX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58S5D1Ou019049
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 08:25:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bdzGoFZ5vldYBAKIaUfbr5FtLEdMR0eBXKVSBRB4ksQ=; b=LxJ3zEoXn4xTjN3G
	SQH4Vtq2q0AsIs+qTuvPQ+dRa/vm1wAOkFOy8SYuUba1RRiZu53ndc4LUm2AVtdv
	n4qwjBfmAWnaOEZN0QmdmGgfjDOvAPbwJXkZRM7yyVZp/fionxLbgmuJI9AXSQSM
	o/vfLBOWBuovDrfa8f2CA0yGZ6Wu7fu6kekGx+SivxQa/3gvF92NWMT58OoWFzdD
	AQIx1nnwrYx9VaZiLJxv76sowzdWM3G+W3i9sGI8TMizpb+YlIeMld32g0picEUu
	hOskKdtredV8Cij2Aax/PMmfy96lqLYQAt8o5CRSSF57u63xnU3u08xZfmwen3KO
	h4xrnQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e6x5jfq0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 08:25:03 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4df80d0d4aaso28965551cf.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 01:25:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759047902; x=1759652702;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bdzGoFZ5vldYBAKIaUfbr5FtLEdMR0eBXKVSBRB4ksQ=;
        b=Y13Tm42hA/sqtGJHOfsEVOJRnfSz3jJ10M2GM7zqFx93zGniEysnEIpAtA8GJBqhze
         SXVIMUrUF5fO2X4tyCPofHyUaAx9/JEAkHjZ+EzTKXUdkli0ktnziik6TMMi1xPx6+d+
         Faq2uA3WMlH3bz7PQu0bwdSEwsZbdkgrypXBDxd0NFTtF+SjQUve/nNSdxIBnTv4RUwl
         75LoMxPRDEQCuGfWTqHTAP/jSquDZIjuzTpI0+/A47UryiMPQjyCZw35ScKbXKJRcNzO
         CagMm9464C6yqpuJTvJ5ElQprI1dtY5cpazgJFowPjeRtKiQDE7F33Kcen0mV48HrdQo
         x9aA==
X-Forwarded-Encrypted: i=1; AJvYcCWg1+A3DZ+KHLAp7ZCqR/m37STlrLBqHUdOhoT9ZgKfRSGs0ck6mTAYkwSLBx9VkSHiKswjpHmlZkBFCq0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7gehhnSWdjiq7k/yCorwxRw8WrsoZjV4IfylyWVgkizEKdp7C
	HUT49UKKSe8Cf57seFoG6S93rfsQc082EEupnwiAH4ABXejQuxRHYZAPRjStUEHGm9/T0zxFyPF
	IIlxRBXdZ9pE8bP2OLIYMzBTXhcCcb850wHSiwTvsXxKGsOC5GEJwyKMSpl8B+IZ+q3Q=
X-Gm-Gg: ASbGncvLIM2Rd0GZiBDYYRlCih8wzkY0Si42WCgLr2fgDdWhAwdWSKZp8tOBg6Of5N5
	U8nM8D/2dDjSkq8/kNgX5sA0OemE12EEJZ1zh0vry65rwIysgMSA9vWWQg92MZFbo3EWLwWB+j0
	hGuSj8tNKTNoRD4c0dV5N8MrOv3fW9SYldsSloeHYyR20Ub4OIfO6cLQ+Yyt3biO/bUPMISkeBb
	V1DQDKONK3GdpwFUHiM1QjOTWVay/y1G50wK1GOwXN9dOLr1Sssmc7oKxX0vk+9h0j+qeY+JzSS
	75GCccf0gLpm6Zehkk1a8x/HHX9XRaVci/0o8liGizSsRXi+lIaOTeLz7Uwyuc+0IC9oNkPpLKs
	MgqV2EVfZVxvsBwwc0bE7ncJkYJGccgCwhqIfNr5qF3IREOwtQNtz
X-Received: by 2002:ac8:5716:0:b0:4b3:a2f3:47f9 with SMTP id d75a77b69052e-4da4d220650mr149549761cf.62.1759047902041;
        Sun, 28 Sep 2025 01:25:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtFk8H4RKfXlQWtvvLw51nsL8yQliUuZJcfQS6snZsdM39Enms7DNwGsz+hvLT3ZcB+X6JPQ==
X-Received: by 2002:ac8:5716:0:b0:4b3:a2f3:47f9 with SMTP id d75a77b69052e-4da4d220650mr149549611cf.62.1759047901607;
        Sun, 28 Sep 2025 01:25:01 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-583166561c0sm3244298e87.81.2025.09.28.01.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 01:24:59 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sun, 28 Sep 2025 11:24:47 +0300
Subject: [PATCH v2 2/9] drm/bridge: adv7511: handle unsupported InfoFrames
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250928-limit-infoframes-2-v2-2-6f8f5fd04214@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2261;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=RSyQmL3DOBdLluC0mSQhrTNOeUIpwQM2CI/HP9Sdsjg=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBo2PDTzUzaZJp29ycMmG2wiJQ8CQv6AiE3Huv86
 QOzLbdX9AWJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaNjw0wAKCRCLPIo+Aiko
 1bRHB/9ZjQ3i6ODCvlC8kHJqQmp+BMbnjHu7eHQ6dlWCRwTGbec8cJ8pUEOwXVArbsB/tXUek1Q
 HgczeUkd/5Yk6k1Fji2tKIa1Kvje94YIVlPsM0F3BO3kANjvD8z/jeiMrM7drR2iyWyKl+erXzy
 17ORLOpVUUbSI1WqursgSTSOWhhotsqgAbGiZWKjtxK+bhwA3yAFucPTQsInzOhaGtxfkxx1766
 o7UfybNWfhI1RVmA6KLPi84+IKf1vS+nsFU/vjt8C9bKTkS2pO8nDf6a+sLwRIuwjsWXd40lkWv
 kWFbjZS8V0oblNyrBSDE9iBEqUAdfJoQJu4ViT33wChiVcvX
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: 5RxXDopfePULnQzon4cZDhGOE336Kg2R
X-Proofpoint-ORIG-GUID: 5RxXDopfePULnQzon4cZDhGOE336Kg2R
X-Authority-Analysis: v=2.4 cv=ZtPg6t7G c=1 sm=1 tr=0 ts=68d8f0df cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=XNEcMcDYeHr5uxMbIEwA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAxOCBTYWx0ZWRfX3wXxOtmhsvDr
 1ry1sjQSmUSnLC8cDxKjnEmdPNS7353sy2Q8XtysYia36iC6hBL9wnce3fx+9Ov+i5xucY8fcWW
 rMavSCNVJ7uecntVr3f4wBh25jNcgylirL9BAVX8hV2agBBhjQfgjlQ1eJWSBZOeajyTGkzfxFU
 UiO4nlEJzKzU//zQBWnqGVSwGfQlCqaLFZVLb6wcadnkoCvT2a1GxORSEB6FTPN2edaUN4bxwQQ
 Kau1sRyjibbofn/+zo8ZJXh2HmCnB281J9ZsFStmVoBEUraL0u5eYo8U8m7bZRSem2/Xm3UBYe6
 petT++CDvnlRnKD7HjqZXP+JT2SJ1ttBMncbgWYFr1bxTmCJj8YjR7Q9MztEIbZuvs0ESxuni7I
 UGkKIji7tgQwp9rol7dS6NZI15eXBg==
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
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
index b9be8654130758e69ac7ccbc73a82cc25d731a5c..241f02143f59322a814b4b277082637d59be7d5f 100644
--- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
+++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
@@ -906,8 +906,7 @@ static int adv7511_bridge_hdmi_clear_infoframe(struct drm_bridge *bridge,
 		adv7511_packet_disable(adv7511, ADV7511_PACKET_ENABLE_SPARE1);
 		break;
 	default:
-		drm_dbg_driver(adv7511->bridge.dev, "Unsupported HDMI InfoFrame %x\n", type);
-		break;
+		return -EOPNOTSUPP;
 	}
 
 	return 0;
@@ -966,19 +965,32 @@ static int adv7511_bridge_hdmi_write_infoframe(struct drm_bridge *bridge,
 		adv7511_packet_enable(adv7511, ADV7511_PACKET_ENABLE_SPARE1);
 		break;
 	default:
-		drm_dbg_driver(adv7511->bridge.dev, "Unsupported HDMI InfoFrame %x\n", type);
-		break;
+		return -EOPNOTSUPP;
 	}
 
 	return 0;
 }
 
+static int adv7511_bridge_atomic_check(struct drm_bridge *bridge,
+				       struct drm_bridge_state *bridge_state,
+				       struct drm_crtc_state *crtc_state,
+				       struct drm_connector_state *conn_state)
+{
+	/* should not happen, HDR support not enabled */
+	if (drm_WARN_ON_ONCE(bridge->encoder->dev,
+			     conn_state->hdmi.infoframes.hdr_drm.set))
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
 static const struct drm_bridge_funcs adv7511_bridge_funcs = {
 	.mode_valid = adv7511_bridge_mode_valid,
 	.attach = adv7511_bridge_attach,
 	.detect = adv7511_bridge_detect,
 	.edid_read = adv7511_bridge_edid_read,
 
+	.atomic_check = adv7511_bridge_atomic_check,
 	.atomic_enable = adv7511_bridge_atomic_enable,
 	.atomic_disable = adv7511_bridge_atomic_disable,
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,

-- 
2.47.3


