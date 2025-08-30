Return-Path: <linux-kernel+bounces-792585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9030FB3C638
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 02:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D66B5A4579
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 00:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB3C156661;
	Sat, 30 Aug 2025 00:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UClwzVJg"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3403678C9C
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 00:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756513393; cv=none; b=WKOY7H4UylqR9OcVdLWfcs95ECpuJF6xIMjFildegYz6N44ehEbz5hVEkED3+evftVB8BIAN8/C/dKzJqB5mGclFlbhCwk6aj+ChO4qMLDtPTfPHuWwo4v91R/Vywrnbzabo4UES0LvkQB20uR69xpWzWknXfTx9FeKiSZ1LdZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756513393; c=relaxed/simple;
	bh=Ehca0mnSJRD6ppoLiHXuwtaX4XwYLAYeehZSVf/evtI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FzI+6c4thQV/mkzUNFeVce7erhUjzc4vVbMqSe52n33L89LoeNGdZHxhoOn2sErSWD+8t25zcskf0d7oO8iT0P3cXi6JXozuuzd3MdmRkpoSaB0eD5WH2jtd34tfPC5Uqs4Z9lBB6NjONAw2weTOHZWRTM/Ij6AHUq1dxEU2xpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UClwzVJg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57TMklbp013697
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 00:23:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yR8ojpGZaE3dckXhUPm62p+tv8/S+wacYcr4NjEKkXY=; b=UClwzVJgdHkDXZo7
	w3HM0F5aHQ2GZ+oRT5p8dn1CO2MLAhjgATxyxp+iakcyr9esh6YHe4ZUpZpeBRjj
	Ik2Gx3v21Yc/5quAu0rD8AjaWkB7FynQ2yGPMT2sdTyQ3p5dLi+8ZWH62WowuuuQ
	lg7kaEmnDKL6WOmc/CutjHol/YWAAKRaPGcX0+g4IoSL8xB/2y4pXhsf9pkzoN3k
	uaoECza7pCvR2bLDT7xtmVAzjw8p+bqzfThSU38R4ssxQrWFLJBYrG4U01wOm8HT
	w6VFuVebCKhIDl8dtJ1o4oJwxidP72REwLXT55tq1sT8XlSEQmJWC1hfwv92yHFu
	UtD4/w==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5w35dsr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 00:23:11 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b109bc103bso56209711cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 17:23:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756513390; x=1757118190;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yR8ojpGZaE3dckXhUPm62p+tv8/S+wacYcr4NjEKkXY=;
        b=Y2h/qdSAdlVoxk4j/5e0jS9QaNmL74y3GVLs5XwQ3IX9E0I4m6EYW3q0ne3qrmOAXm
         yB6U26FuGdzUKusRyspRce39bjiAIHa2cdbgHx9lLHvV4e8G4TjK5gX1j4kXa6hJKIE5
         OlFG+a5ezvQDosG7iYWYK4JCiEvhf7srN+IP+oe6NKMMlaHfQyVrKMgiF3tou79YDFm4
         rBl53hqtztA/axBqUHgrgEAAbdIJegxCUIhYfpdR+3wB4Usm7bNzCvyp6ESHHQ1clSvD
         ohfVs3XEXBMT0snFHt4OM5t+ZgLLD2mnnq9jvoFGVJJufXZdooMLIrt1ZjfHnTIE039+
         KfDw==
X-Forwarded-Encrypted: i=1; AJvYcCWZHPYyKYpmAwkNkbsmjF+ll1hpl3zTfWdNEYEY/ck5JJbeqvbmR6ZV6K2n9/Lyg17Ld95miC7gWf0x3f0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqPIbV1/Ynlm8CCCPA8b8SAqgxFvJ+FFGMgr+/lg2hukt6Woq8
	qj+BzLilun1vUXovCUal/qC+n8iMSd25VA84R4tBo7/t75anHK/rxHn7DpeElds1OfsSciNE1lC
	xDIPJonlC7GdAjAYZNaIqE1LWNYDr4dlsuKqfwd+5fanUt2Nyft3UMDonwRzHLQOE/fs=
X-Gm-Gg: ASbGncum/H4LHHGFvitrkw2OwTqWLVCf60zvJjslarqOWR42EVL/a7LF6jKly229rpR
	VxASzBV0IAh2BiC0ogjA8CgIo9SM9s9bm1qtuWBLzuaqv8lHfH2UCzXpF6x78hV408WaZluK6JZ
	68Oa/aqXarp4ioSam6S+7FqYlS0xtW+n8WAviRICWs44DXQApQuvIBCMtvBKb9UlVB4s0Ire6QS
	fn2WLUWp/B8gPU7oDcr/lI9/UlDCZBA1/3p08Lb3kIxwYk+h31YJodoShgOGaiNrqHdlaKnedH7
	dBjIlrwfuA/Dl+zBm5U9KYuCIjd+nyng/4Ze6VzYUGf0W3wFbdEDLMxg7vZ2+cySk1dtmoYUdKQ
	stAh7HiXfVQnWQN8dRXrjJfjZafoeU7SACfjQVcX1PtVy5ENzPc1x
X-Received: by 2002:a05:622a:1806:b0:4b2:f786:92dd with SMTP id d75a77b69052e-4b31da700f5mr6049001cf.57.1756513390021;
        Fri, 29 Aug 2025 17:23:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7MI5AgeDyZIhBXp4nqzUlr+O9xa2caPrlb9g34SvQBLOsNrDgnfALkKyRc05CDcviHb65Vw==
X-Received: by 2002:a05:622a:1806:b0:4b2:f786:92dd with SMTP id d75a77b69052e-4b31da700f5mr6048661cf.57.1756513389582;
        Fri, 29 Aug 2025 17:23:09 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f676dc52esm1019907e87.8.2025.08.29.17.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 17:23:06 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 30 Aug 2025 03:22:59 +0300
Subject: [PATCH v3 03/11] drm/bridge: ite-it6263: declare supported
 infoframes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250830-drm-limit-infoframes-v3-3-32fcbec4634e@oss.qualcomm.com>
References: <20250830-drm-limit-infoframes-v3-0-32fcbec4634e@oss.qualcomm.com>
In-Reply-To: <20250830-drm-limit-infoframes-v3-0-32fcbec4634e@oss.qualcomm.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Sandy Huang <hjc@rock-chips.com>,
        =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Andy Yan <andy.yan@rock-chips.com>, Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
        Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
        Liu Ying <victor.liu@nxp.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1689;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=Ehca0mnSJRD6ppoLiHXuwtaX4XwYLAYeehZSVf/evtI=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBoskRj11vVN09hllSph2xCMLc0Do8yrAjG7XStQ
 fWhXkyDAaaJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaLJEYwAKCRCLPIo+Aiko
 1TWWB/4rD0vAi94fpXgnZ/MAOGSejRTzdVcbXAhKRnofFOaPhsGaS/JXnirro1+t0KnU3RTBpDT
 qUILqYS/Jzl/1JMqs/TPPLURpwv0RrtFpmc/HAZYEcLS2ptOq9zgkpx6EKA3Vu0Q5UjMKra/mNg
 TILceD4EvuFfESWUcc2cjZJtjIIwayFwgP+f0GbyaYK7Tg9o6vR7kh37CYQiAVa8c1Gm1YcK3b1
 C/0Mhu0uJEkwcXFROdPZmEItNVR7kZMZOmfUjYFmjVBcYIwIDe69U7eLVRhFCPqPYKs/1Fb2kPY
 E8QdgsNmJMHRw8efstr7kx/kBQWYWUxXpKZuhf6DFZnhA5B+
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=Z/vsHGRA c=1 sm=1 tr=0 ts=68b2446f cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=8AirrxEcAAAA:8 a=EUspDBNiAAAA:8 a=HkIXcrnrDl8JFVr2q_4A:9
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfX6Kf49WzHc6Ak
 Ru9AcX3foG9yLrTszaqaujJYpVsarFC4Uco4CrS0vbyHV3irkHI3tD2pnk3UMNLgnubRq+gU+1k
 QVCSOcaNrerhvC9tveJGRihrEJL1B6rmr/YxlbndNicQoQFte6ghVRPRAV+lylAtZf7JBVyEgiR
 88RVfj7saFYyMX07VxGweT2NZt5djmMs+4v8Hlba6gOi6l2Qtyx69Ld6IqX2Qc0yQb5Bhy8rIPm
 /hha6UIX7Q7hrFq9PKZDXjc2Pnt+79LSGge6O7tNhMKpSlfoC8Qh7W9zj9Csi8JU+18Iu5qQ1QZ
 XN5gsSWTl6u8MWJa7FZj/qLzhQiG4WGRZL+kKGQXJYDjhJIKZHAumZR7bxE+otsgZ4Eh3xtmHfl
 nbYMaa/Q
X-Proofpoint-GUID: 1j7EtMOJy4wdFFDRCrIGm-3-2NDnmph2
X-Proofpoint-ORIG-GUID: 1j7EtMOJy4wdFFDRCrIGm-3-2NDnmph2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-29_07,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 phishscore=0 clxscore=1015
 suspectscore=0 impostorscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230033

Declare which infoframes are supported via the .hdmi_write_infoframe()
interface.

Reviewed-by: Liu Ying <victor.liu@nxp.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/bridge/ite-it6263.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6263.c b/drivers/gpu/drm/bridge/ite-it6263.c
index cf813672b4ffb8ab5c524c6414ee7b414cebc018..f2d54ad8fb64254747f2e8e301f19accf337128f 100644
--- a/drivers/gpu/drm/bridge/ite-it6263.c
+++ b/drivers/gpu/drm/bridge/ite-it6263.c
@@ -755,10 +755,12 @@ static int it6263_hdmi_clear_infoframe(struct drm_bridge *bridge,
 {
 	struct it6263 *it = bridge_to_it6263(bridge);
 
-	if (type == HDMI_INFOFRAME_TYPE_AVI)
-		regmap_write(it->hdmi_regmap, HDMI_REG_AVI_INFOFRM_CTRL, 0);
-	else
+	if (type != HDMI_INFOFRAME_TYPE_AVI) {
 		dev_dbg(it->dev, "unsupported HDMI infoframe 0x%x\n", type);
+		return -EOPNOTSUPP;
+	}
+
+	regmap_write(it->hdmi_regmap, HDMI_REG_AVI_INFOFRM_CTRL, 0);
 
 	return 0;
 }
@@ -772,7 +774,7 @@ static int it6263_hdmi_write_infoframe(struct drm_bridge *bridge,
 
 	if (type != HDMI_INFOFRAME_TYPE_AVI) {
 		dev_dbg(it->dev, "unsupported HDMI infoframe 0x%x\n", type);
-		return 0;
+		return -EOPNOTSUPP;
 	}
 
 	/* write the first AVI infoframe data byte chunk(DB1-DB5) */
@@ -875,6 +877,7 @@ static int it6263_probe(struct i2c_client *client)
 	it->bridge.type = DRM_MODE_CONNECTOR_HDMIA;
 	it->bridge.vendor = "ITE";
 	it->bridge.product = "IT6263";
+	it->bridge.software_infoframes = DRM_CONNECTOR_INFOFRAME_AVI;
 
 	return devm_drm_bridge_add(dev, &it->bridge);
 }

-- 
2.47.2


