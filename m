Return-Path: <linux-kernel+bounces-772011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75164B28DD6
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 14:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 476871CE2847
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 12:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333DB2E5D17;
	Sat, 16 Aug 2025 12:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VLW2ErZd"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA43C2E2821
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 12:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755348078; cv=none; b=abqwtae4GDujs4SMSWXbubW9AqkcGjyNCvcZ6B5ul0hspo+y6Oza/n8RtX7Rx1YsYoInd6IV4Y5RKHvY4u9gh1AVjvsTym4BM14aug6bTE2W4ziAzPP3KdAIMotSH6uuYH+a/i+1IBxKAGpWdzFgTg7FEEoyKwtqRiYg2Lu7E6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755348078; c=relaxed/simple;
	bh=6MDUGd2gCI/EsaEXrxZU0j17Xf9/Klm/EGghvRMYY3A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BUGz2S+XkkFimnFtfRQ4p1lpEjmfBWGA68Kdt9tPw7zZxZT3F5GchUQxiAp8G4q02WlDTU4b8DDUi4sZKPQ4oC9bybxvJJYH+PPjCh1C/gR9LR4WpTHidneFySTcyCDi8ncg7FgjZaz/r1iHsfgmxat9LOqiK98P5IhwDMacAqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VLW2ErZd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57G4la7w018371
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 12:41:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bZCDNxT84H8d3+/4n1AbLc028ffeXusnvwh4O3/fxcY=; b=VLW2ErZdpDCW/AKF
	Eb4TUwL8MjplBqe2x3FPHhRyH48tvPOKFwg6snGM0nNz6M7+j5WEc41zOXhU/0Sl
	uyBkKXDVw3BdQoyz0PEzfSjgKJsxV/Zurr0DlFa9070Z8QAnIK+KCxAPuvEt0UlY
	CGp/AnaoxY2nujCPlmjkp6WdqZY39FJa3mY2LCoS3ZeESvZYGPsrdUEdwHVhVlot
	SIPNQ2rScWi73XuMo2bGnNJVaYPcaicVStR8wKdsWTaDwmWErwJN8JNR0mU5YUDi
	9B8PIxKed0FJzbugqGtjwSa9Paw+pM5ln15awOAH+/QDuZ96galVAtxhYmkaYdzq
	G1jgng==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jk99ghna-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 12:41:15 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b109bd3fa0so30875631cf.2
        for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 05:41:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755348074; x=1755952874;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bZCDNxT84H8d3+/4n1AbLc028ffeXusnvwh4O3/fxcY=;
        b=u0/ukaiB1Y+/kNkNccjm/0+gYK7SDBMgoNzuyfH2YWxVJ2/Z7aj2Gbpu5h+oRxWBey
         Sh6G4aKixFIKN5auSBEn7BSiMraLIbaKIoYeW6ZUlbS6hEQxoIxdO/k1Ce2e/EbjAAdb
         g3Je/h48SUip0x1gSD/742LDbdq6fn5QcAOF8ixYdEJ7ePujK8BcMK7WwX16Le9G+kAm
         nMe4uaGnWL6ZIF5bTy+CXWxKBmSWEiL78WIDXDxmMl/Gp5xz1oTz6rDoxPGfbpOwbns+
         qedZBBlVzfH4GLACfM8sk1b4Iwl9ew3eDjG+9umhT04Mh4x1fPyxKpOMNC3sFY0+Of+A
         D2yQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYf+3tsXcTTB761yul5YiUqtWn/QWIDzjrKHGmPMSGdUSMmzAsMQxiXK+q/Vyd6olitU0opX5PWT6RE0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWBJh3VIcmCgUfWR+t1pK9ZjSC5woMW8z7/MsTvJ9mJSxlkU09
	JnlWIIiOEenq2dW20frvPa1BmMLHphaMLsOlNkzG+MiLT4nY3PNcp9m24pqhKMWKtOvjGDmql28
	LGrkrtCaydIB3SKY1JW28dlt/3kt072dRqC/YlrZ1A0CX28NXjoA7Xiv+w+BIC9Zpar4=
X-Gm-Gg: ASbGncsr4gf5qkSbKgRiJtrNofYxzsLnLGg4cRZNc949/eQlzIa+e/TOtpQ45o5xzZ8
	6Zd9odAlkjcKLTlEhGB0PC4yvxmhb5VwUbs7Ixr6bxnLhzQEvMl4/YnwuqfFJdwC1iYrtEm52fY
	XHsN0dKONiRopbZ2dDIK+wM+DVZ2sKEF6pgu+98/BFqhHH7kSKhc3z4jnBoNtsoBcHUoWxsWUYB
	E18s/OxerAiFHhBT9EVw+mCrLQyuWELRVHkDC81h608E6Eh96ODiUGfYWMjt/y9vvguQpyeSnY7
	juqQlJeY4uImzWhuGw1reP9K/Ys8zqle/LVTp0bhn6/CMMTPs59Iw71xOoVjMD0MyIOM/ktmZu/
	WABhDO2LjDVtYacL3NkLY5TDh7FI11lOVwJsigwgmEgztQE3R2Z1O
X-Received: by 2002:ac8:5984:0:b0:4ab:5277:a5ab with SMTP id d75a77b69052e-4b11e0c2db9mr68298271cf.6.1755348074335;
        Sat, 16 Aug 2025 05:41:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEq+2D8bA6Exv7xwHUunlo4e1X/zZ2ZI/TlCYJHV66Jzf0On30yfS3pYH+kbbOYRboEDBH3bA==
X-Received: by 2002:ac8:5984:0:b0:4ab:5277:a5ab with SMTP id d75a77b69052e-4b11e0c2db9mr68298071cf.6.1755348073839;
        Sat, 16 Aug 2025 05:41:13 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef3cca21sm856554e87.104.2025.08.16.05.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Aug 2025 05:41:12 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 16 Aug 2025 15:41:04 +0300
Subject: [PATCH 4/7] drm/bridge: lontium-lt9611: declare supported
 infoframes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250816-drm-limit-infoframes-v1-4-6dc17d5f07e9@oss.qualcomm.com>
References: <20250816-drm-limit-infoframes-v1-0-6dc17d5f07e9@oss.qualcomm.com>
In-Reply-To: <20250816-drm-limit-infoframes-v1-0-6dc17d5f07e9@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1071;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=6MDUGd2gCI/EsaEXrxZU0j17Xf9/Klm/EGghvRMYY3A=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBooHxfeZjvuIKMDxc3NNDqA14HuD3rogLXgG1/x
 40vIEmKjtmJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaKB8XwAKCRCLPIo+Aiko
 1Vr7B/9KbGoKGY0G6Zbc0PFJqwOln6oTx3g2EnrCz9bTxS7nuNcHvo4V4hVcxg3JHEn9XLW0aBq
 rcL64poAiL+A/Tk7OSFz76/ZS28ruSlHbEBfJykODqDlllZ89HEWOPZeQbxzH/SHmsO3bwa6Vzs
 gl9U1/yEFKmMWqDrHZKk7wJ/k8s+PAu66cGZrI2IJVQWiV6Or4n6hKa9wvloaFF7hKJdMqEUi9B
 QDjr0YsT5PqjevpATnBWoALz9MsgAIXYPDNDAsg+k9oWjqPJj9FAQq5ZHbLj4bCTPqetj50s9NP
 5ynpi+G/iWc0A4DOc71d38M10F3TXnligAlbQthOBFCoGKJJ
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: g-iYXGGCMHruL7zc0QMAZQ9mN11sxF8S
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDA0NSBTYWx0ZWRfX5tFbtWhUXtyh
 De1j3QK37M2bnywhzWlYX/ZR6D+xeTs9KTf7JkImM6MqhA5XOCQWsuXJQKf+fKXmHZTRpXrTERG
 7W2mK2I4HnEiEKAI6XWrxPCPa59ff2zcnAZWZpoIEcqBMhMsja1qH1QYnD+VR/WNW+y2sj3qOIc
 6S+sw4mSGGTCgZ0+MYKfgOKHjdMsYwI9/GY3REuVGuI19S5fAa+iPxrSrXj9eeEwrZ5XDzEvJJN
 UOlnzxPBW2p61pKEshWurnKGKJJoU6kPpW1xKkU1SXTwH38gWXvz0kgSn+AFWn0WV1p2fbE7Ypo
 CS8zUzB9VfoPo8U55m25+HwdYvmucArb7us6L/FNBtob1u+cmunw07+TPJq4L+xVPdmXv9TucG9
 icNnSv1u
X-Authority-Analysis: v=2.4 cv=IIMCChvG c=1 sm=1 tr=0 ts=68a07c6b cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=AMvF8s34Jxw15HKoVo4A:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: g-iYXGGCMHruL7zc0QMAZQ9mN11sxF8S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-16_04,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 clxscore=1015 impostorscore=0 phishscore=0
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508160045

Declare which infoframes are supported via the .hdmi_write_infoframe()
interface.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/bridge/lontium-lt9611.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/bridge/lontium-lt9611.c b/drivers/gpu/drm/bridge/lontium-lt9611.c
index a2d032ee4744715b88eb66883edf69bab4c274b0..08cb6958b9154dbc516aeb0623a8fb5e4af1df92 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9611.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9611.c
@@ -1136,6 +1136,10 @@ static int lt9611_probe(struct i2c_client *client)
 	lt9611->bridge.type = DRM_MODE_CONNECTOR_HDMIA;
 	lt9611->bridge.vendor = "Lontium";
 	lt9611->bridge.product = "LT9611";
+	lt9611->bridge.supported_infoframes = DRM_CONNECTOR_INFOFRAME_AUDIO |
+		DRM_CONNECTOR_INFOFRAME_AVI |
+		DRM_CONNECTOR_INFOFRAME_SPD |
+		DRM_CONNECTOR_INFOFRAME_VENDOR,
 	lt9611->bridge.hdmi_audio_dev = dev;
 	lt9611->bridge.hdmi_audio_max_i2s_playback_channels = 8;
 	lt9611->bridge.hdmi_audio_dai_port = 2;

-- 
2.47.2


