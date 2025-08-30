Return-Path: <linux-kernel+bounces-792583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85002B3C62F
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 02:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04CAE7BDB52
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 00:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D74B13A265;
	Sat, 30 Aug 2025 00:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DCtz4gtJ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CFD56B81
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 00:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756513389; cv=none; b=FqFvmm2g7YygYigOyrmrzsN9wbk3SUpAa2Z0IBkeR7ZEptWJXucJhh+pM6LmhiYThuZ123zQxY8I9bDNrtIAahncSG+5uXuh5lSUk24YBb7h9e5C+yksOoFMiGW6ES6djhp2ykKIWmSN/opvbdM737g7jgOpvcA3UjcfwBBDXsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756513389; c=relaxed/simple;
	bh=q7eYf8+3RQX7ESv2tHgdRnLYQ1j/MZwxzLEz7NwM9XM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R+Aseq559TZY3bPo5YUUc5oNJuwIRSGTFHsvj+mS4hRHmCFZOXDEl3QF+g5LGUMs582i5aP9ovF1f1zP7DUTngcNDmlwuaG/5oyMEmBkMGd86ccdw9/wqgD8wyfMzlH8j2nc0fKcMrWVFRvB+nBJ1NjwhiT17/snxrjbtXOF8uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DCtz4gtJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57U09CXX013217
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 00:23:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EC24O8coXPxIicmmvFhXHG7RuMMbE2/IeNTru9ezMlw=; b=DCtz4gtJxTkhOa/5
	bgoi8G8kCfWOYQZKf1bnpFYsbO7z1XE+zqrSI8B1k5OLYGFCp92I5Syd9vprgipI
	WapoLgN84xInkHmir17aYOfrY2PnHdsalVYFR0FtH3CtFLu3tZuIfJ5qGPRHbyTV
	ISI+UZF5EnPNhifJjO3IO7DokPGK7/gx3+t0htTE1Rl2NG9zKd5dfwrNTdjIcdTV
	KxrfBkuz0j1e9CMYXZWifYtN2BCfmwAlv4CVWPEZLbAc82r8Gwtn5GR0DfNiHsLW
	wt8l93QTnd4VVRgCZxA74sRRDpCo46WJfwQQUOxKeUhTBmqpi+0psjJBjcnNfJG2
	VDn1zg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q615w3s3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 00:23:07 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b2f7851326so70907921cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 17:23:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756513386; x=1757118186;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EC24O8coXPxIicmmvFhXHG7RuMMbE2/IeNTru9ezMlw=;
        b=HQVhOKG6jfxgx9mZ0lB+d6KK+BXJe2e4vAfRDTzsIytKdvww9JtR+lGuwGZw70jSn5
         7jO/nKN88Pb5sDDjF9aUDpjEzV23tjeZZvIa291NHrGYuHZI3J2jO9aBfv64lvWo0qul
         q20+cdTFByARsq7kpiN6kRHEdkstISwIggN4Ebyozxj8Q37/ZNW0si6B0o0H8TVNq0yP
         v+rVABf6+gAE4OmCFbHn+O1JjGKANnqrSgSAbJ8NUFn4Yb8tkG2Q3UagDWWCASJIfMO6
         QFeuPSmgrBcjU++ElyAnlOdM0+xCuTnfQ+E2hawt6vBEgfaaPhPcAQ5/hNpmYyAiG/W+
         EMBQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2Wzb2qJCp3jgWISJ7QuMNZ1ezT4hYTw2fZ2q8Wut7TmXIgBBR7ER64RnOOwiyIy+a6XlrHzUTg/xLdYI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz43sRNw3JkaVRBnBw/Q/OkVynffnXBCbgjoJB3oi+gmQLuRl2n
	cSw1jK7ssi+gkieHNMHICMkAjtpQdtfbcc+mUAFzPfCp/9R2FYibDus7WZ0l5HRAqzReujDPWRX
	VYGTwLdmzztxC3qblLjB7tScADpsXhR7yUiXsnP/3vy9S0ImY/ea7Hkn6a6UBBq34om8=
X-Gm-Gg: ASbGncvJQQWQHMeFCAXCg7uwGgBtipFyLfbtxcixiH4yduJ2TdvXn4uOskZtL8xMZ+9
	cCuj2KIF42v0eiMXENCn12wfHzq8S7L3x3dVI4NPI6fOtbL/oKiBm7Hh8wTQLL7rg8KnH0XbS5Q
	CEpfzuvsirxnHSBMXNeM2sf3TtOQ1JmLa1QY1q1Pt9XPQb8WKPUtbZ2V4JQkwQngxURbZbDe3De
	f/xxHRkMbVmbWeUcuzdlv9KWgYBLB/jsF6HisEvbtTjJ0UD7zC7w6AFkPIIufHKnFpID9JvC2PO
	1lloBrRDEBJxIohNpb1nB6R5e7tTGBnSWD+lgtnYGpnQ125rAVMYoEoV/6fPX0KdoUmRiSlhCYy
	uaVD28TV2HGquNyx5e+qYo1obBdDVGZmzWhUaDMc6J7FnjGRRzxGj
X-Received: by 2002:ac8:5884:0:b0:4b0:aa5b:7c6d with SMTP id d75a77b69052e-4b31d8450b2mr7951401cf.16.1756513386149;
        Fri, 29 Aug 2025 17:23:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJMWSIAIjCYp1lT9McTj9bQ133h50tPHm6nwV01Yh4DnXv2EmLSxcQOP/1n5kMYt9GTSTzJA==
X-Received: by 2002:ac8:5884:0:b0:4b0:aa5b:7c6d with SMTP id d75a77b69052e-4b31d8450b2mr7950821cf.16.1756513385504;
        Fri, 29 Aug 2025 17:23:05 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f676dc52esm1019907e87.8.2025.08.29.17.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 17:23:04 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 30 Aug 2025 03:22:58 +0300
Subject: [PATCH v3 02/11] drm/bridge: adv7511: declare supported infoframes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250830-drm-limit-infoframes-v3-2-32fcbec4634e@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1675;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=q7eYf8+3RQX7ESv2tHgdRnLYQ1j/MZwxzLEz7NwM9XM=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBoskRjIMzK+I5pUhzNv/gzIuu0qrnQQAgGGLA/8
 sqWoDGr3RmJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaLJEYwAKCRCLPIo+Aiko
 1X46B/4ttG1//Uf3yzHz2UVvm8cP5B96gro5PvEoK3vjNCYja8hOZmVu6v9GW5CkmnOb+3jEy/A
 F3O2JkCE9qbaSinFwCxDG2IviHDn3R2MSLm0Oz38JU3THj1JqiqN9tkLVzqGWianYbVicOFDWLw
 ffgaoAshYzXH5V7xc09KzxsPqxBXnlpZraDTgrv8ahuF/tN7ra1jWUyA/Xa06DhQLj0cQZ/mOdT
 NVO7QobdWHWByEfRjFJEbZhhBnXbOVtNPRvwF3NyvPQcEcFZGp+KzxZI3EoIkBu34mYwHoNE+d9
 BT4naoD0RmK4tSKFUCczE4M+TIsdHkuH61/HLPB/sDlW+nSz
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzNCBTYWx0ZWRfX8FmKL3eRlnA5
 tpjWRytzSN6tQklFryahaBazlZroj5vK+WC74ubobnfXuUKozv+2jTfUL7dN20vQliDZnVdH036
 7iUEQ/P44fEMk6r8O58jq+3hB0CT9FUDgrsmMNpDm7skqm6lckrgxoBMJI+bnQ+2qb0CTZmBj1g
 FXA3hoO0h7F0UuBDE3ucQBO4NNfTYgv3mi8H/QTAyojj9J9cC6foY64TWIG8ny8A7T0fYcRiQjN
 Fyhr7yliF4Q0ZHTUUvksdx8jmdP+LqcStU3fl8fCewlqcKiFyJiCn/Kiy2QyC/jP+ZaipADqE/t
 R3SUW+GvhF/d9+ATig+1YJbXrXuftPnFZL/4r92ravLDu+Fq8MGFrXXJrgvrqcpA4CiDHoMtQMp
 sDdGEq4x
X-Proofpoint-GUID: 5-84ZPUiYCXp1oNpZu8X-LDUj7s8n1UG
X-Authority-Analysis: v=2.4 cv=K+AiHzWI c=1 sm=1 tr=0 ts=68b2446b cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=8AirrxEcAAAA:8 a=EUspDBNiAAAA:8 a=4euzTov2hVyL0VtTdw4A:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-ORIG-GUID: 5-84ZPUiYCXp1oNpZu8X-LDUj7s8n1UG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-29_07,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015 adultscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230034

Declare which infoframes are supported via the .hdmi_write_infoframe()
interface. Audio infoframe is handled separately.

Reviewed-by: Liu Ying <victor.liu@nxp.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
index 26f8ef4824235a9a85b57a9a3a816fe26a59e45c..fe30567b56b4f600683f0545ed270665e692b12c 100644
--- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
+++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
@@ -904,7 +904,7 @@ static int adv7511_bridge_hdmi_clear_infoframe(struct drm_bridge *bridge,
 		break;
 	default:
 		drm_dbg_driver(adv7511->bridge.dev, "Unsupported HDMI InfoFrame %x\n", type);
-		break;
+		return -EOPNOTSUPP;
 	}
 
 	return 0;
@@ -938,7 +938,7 @@ static int adv7511_bridge_hdmi_write_infoframe(struct drm_bridge *bridge,
 		break;
 	default:
 		drm_dbg_driver(adv7511->bridge.dev, "Unsupported HDMI InfoFrame %x\n", type);
-		break;
+		return -EOPNOTSUPP;
 	}
 
 	return 0;
@@ -1299,6 +1299,12 @@ static int adv7511_probe(struct i2c_client *i2c)
 
 	adv7511->bridge.vendor = "Analog";
 	adv7511->bridge.product = adv7511->info->name;
+	adv7511->bridge.software_infoframes =
+		DRM_CONNECTOR_INFOFRAME_AVI |
+		DRM_CONNECTOR_INFOFRAME_SPD |
+		DRM_CONNECTOR_INFOFRAME_VENDOR;
+	adv7511->bridge.autogenerated_infoframes =
+		DRM_CONNECTOR_INFOFRAME_AUDIO;
 
 #ifdef CONFIG_DRM_I2C_ADV7511_AUDIO
 	adv7511->bridge.ops |= DRM_BRIDGE_OP_HDMI_AUDIO;

-- 
2.47.2


