Return-Path: <linux-kernel+bounces-792592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB24B3C648
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 02:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16CDB3B81D5
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 00:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C0F204583;
	Sat, 30 Aug 2025 00:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gS9etg5k"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A711E990E
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 00:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756513406; cv=none; b=XzwuvI5+ROauK2Q4hR6EvNpbc88lZ552eOKGqqW6t9Rw2+BPGO2f+jXdoA6nNLjfWWdPkPI+Fln2iRODqVIcwCRfSH9aDkDL8yto3OFePyIQnqJ3ZEUnyB7Pjo930hf7S3I5z0XDO301t42+CqjN223l6gdaGC7A//Xkqh5vKuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756513406; c=relaxed/simple;
	bh=DP8WKS09AQHIP1eUa2wMNyM9LpBbwdIRAz41gdvU1po=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PlXSeNrVSnqmZLRdQSxcfcdvHDuRF3yDGqV/g804/j8Fq9/EmMUmCApuF9RQOX+HJsjXMvIK3JKr/5pRyLyImcDP6yQKTU/xduqJVnPqCH/pv0pstPY2I8YM0dQQtxw75GLA93l/kbNsITKo9BmFv4x9BQrfVWXuiS6+QU7Q4a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gS9etg5k; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57TNxK8j015423
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 00:23:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fFElURD5QRZmLsVqoA3hb8tqFcCE4wfhTZP2ZQz0do8=; b=gS9etg5kSlPjOI9q
	Dr4xZBf9qVgqpsTAtzWdD4ln9CuhebiznCcCdFYeV0IxD6Cy2TKTzSMoehX+04Zs
	VyASDMByiEtgL40oZsldbgzADMdmO8rZHMWIZPr9ccKOUx79Q6GzIw//z5WAGGHC
	9MnBfKrs+LVR1r+gODwfqHoePUJ5o5zZHDzFP7aqjG8+2pZrw3QRaol5+RKaPdtO
	vJW/GoCVmwWmMR4HQ7AROXAut5YFecrwigNnR82NxTb1fowPr5Bf3FpYQKDX0Q7S
	JTOflOOfgcIi0p7wUgTJEXN65tNUIEz3R2Kc2Lm+ZpaNVbRhtJzzsd4iokfMqUNx
	vQGa0Q==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5wecthg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 00:23:22 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b10ab0062aso58428131cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 17:23:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756513402; x=1757118202;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fFElURD5QRZmLsVqoA3hb8tqFcCE4wfhTZP2ZQz0do8=;
        b=Bkcwa+pgoHzYLHFS9INEO0epeoQVHtX5fG1m6cNx89Pc6gRee/SVawofqqCXuuBLfW
         uGjlozu/gBC5on2LV6E/eym4SvrKtUaOJxlMS7aia9f3hG8nMLIBpZKdJ0wLdkS4a06U
         IdKyeZkFEb81ekESiyDsbauNdaKakTaW/pLXtcxRbajmteYTms01gPqmeEU8zjvqcyVR
         sQvITMJ+WJYVaQKeZjzd3EOr5UW0CNzxXCYpvXj2A0j04iDAcyh8NbTgJQRrkQ6bIeXm
         UgekogkCcawdyKrHDpSA4v2MWBsEqfbEnpIKSA6cnPpc0xrCHlzHmIspHOMQN0iKF4oF
         ktCQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3DuRTPqMNBFSsKugQhYOk8YnbDzF7M3feDTijfyR1MEZVcd2styDJq3lIWLyeSdcOFQQzpC0Shk290HQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9uPcn6xApiyxGfzbURCUB8/kcNDtJj5quRgCSgE+6t+oVojjA
	WSDZzdTPHCYgPfRNkiK35DQ4IlvjgtwD3qxoLiqt1kF27lWHrvdUlGgBtUkDbbY8M1GD54KkDdh
	SCURZ47jIQjN1R/ckx6Qh7vq9kc2aWw/Vgg50VyemaPSWVHVUqLVkmhVjFitvzbRtLic=
X-Gm-Gg: ASbGncuxso0Niv7A8paBgeT1BiA4WZadLxEsef4rWJyvaZPvj05wXsA7q6yIoFDvkrG
	JgpdsY8MhDlhPugQFbSNRDHKJHBYNn3YblDjAJpG0D19p1rmPJkE5wWXt7ha8QplqXjx04xv8RX
	YzWNIHVo3sGFieckd4PiE2tjdpzkYJv6SnMYemrZFEk4Rw9ky84AMjwrcdgk1qxN09IrHdQhA6V
	liq5NlR3d79n6CshTj9dmCkapX09Tmz4DoduRGyYgjuUr2zYPvPQcYXmRt4jCeyo1f7h4i+H9VL
	EtOM+8HLgrPxwKdqU22qhqDizT5T5SP5MgtceLv9Pk0Uz3NR6JfZ5KkKFjf3IlhLn3Jo8lOtLSe
	5mWvm5OZw5bOcRjfrgfFumaMl5LHIOqntGznnVElxBz3dcQYw0w6I
X-Received: by 2002:a05:622a:5c6:b0:4b2:dee2:6498 with SMTP id d75a77b69052e-4b31d8607eamr5634851cf.28.1756513402123;
        Fri, 29 Aug 2025 17:23:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwgTkXP9pj85NxwpdQc0ae5nNZHcprVUGekqFYFf3riFk956UhGONyyTfF4B6OsdIgaiSMUw==
X-Received: by 2002:a05:622a:5c6:b0:4b2:dee2:6498 with SMTP id d75a77b69052e-4b31d8607eamr5634631cf.28.1756513401513;
        Fri, 29 Aug 2025 17:23:21 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f676dc52esm1019907e87.8.2025.08.29.17.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 17:23:20 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 30 Aug 2025 03:23:06 +0300
Subject: [PATCH v3 10/11] drm/display: hdmi-audio: warn if HDMI connector
 doesn't support Audio IF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250830-drm-limit-infoframes-v3-10-32fcbec4634e@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1673;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=DP8WKS09AQHIP1eUa2wMNyM9LpBbwdIRAz41gdvU1po=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBoskRk2UNRsRCHOJKzLD77zC3Q7JVu5+ElSTKGc
 O0A/oyeiyuJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaLJEZAAKCRCLPIo+Aiko
 1d8OB/0RMEMUbmxG0SYUoq630dkm8bopfypsnF25uIBgBqc8fbR40rj2Z6O/aFjiC4pxNRKtv0T
 Pb3wXjEx8igMQQyVkYQs5YH9EizhVoDMP2qbMuQD83N2hhtJsjCO9NIG5nBEgGmQDZXWFDqU4gn
 NbRVO+Cz6af8mXjkexPYvOzEvQceTImFY/x9fqz5j13/z4q3QwePf13Pxhvjbi3Ggp4tvM10wqX
 jp4foOuMAal2wFUF9OzE9JeZB5Kuv5vgwi7qeNFxyo+/bSmE60uO0EtP+Ab9Yhdzc8D/TLSUHnP
 MpGBkAz8OvKT70KC2H3AaYh3YkgsM7FphRVhkLoXKB5BRL88
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: 43lX66WubnnY0BpUOoI0pB1HIvmYKisq
X-Proofpoint-ORIG-GUID: 43lX66WubnnY0BpUOoI0pB1HIvmYKisq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfX9fwrbvgKDdaF
 QXevGd1LCsK3CZEfsXfpt+YcOQyX83YRGZxtyCxB/uvzV2J8xFnFwHrF/YhtU3S2GT3q/VJaCMM
 u562LY1ghLo49Kx0PSpcrsrf7jEYZpZEKt5XLeP0n/KAr67AI/xEOtvToybLMRdYwRUHnqL9daj
 7Ofwg8DMsR8TDs+sJd4tXsbrk8XqBqmKRTaX3VhdJ3drHxwv+UVWMiFotmLn8+HjefVdU3hXLkK
 D1DFU9HXkV8tHUH+7OSUWpffFDeqDmRLqJpmZWz2bpPVS0k8XsmcUQkOLoJ+fc864jM9adC7UmP
 vaMgnE2T/zan9IL9hbNLfhFhhV3fQN8qd1m3y+xqyyjCQ+n1Hx3MxLp0AaIzf6vrUTcRX5wUfb/
 9RYX6mCH
X-Authority-Analysis: v=2.4 cv=BJazrEQG c=1 sm=1 tr=0 ts=68b2447b cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Yc4j0DFJudTMt519TXkA:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-29_07,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508230033

Sending Audio InfoFrames is mandatory for getting audio to work over the
HDMI link. Warn if the driver requests HDMI audio support for the HDMI
connector, but there is no support for Audio InfoFrames (either
software-generated or generated by the hardware).

Suggested-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/display/drm_hdmi_audio_helper.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/display/drm_hdmi_audio_helper.c b/drivers/gpu/drm/display/drm_hdmi_audio_helper.c
index 7d78b02c144621de528b40b1425f25e465edd1ae..dfcd0e3b4b0d7cd6adda78dbe9d6e3f65e8f7ffe 100644
--- a/drivers/gpu/drm/display/drm_hdmi_audio_helper.c
+++ b/drivers/gpu/drm/display/drm_hdmi_audio_helper.c
@@ -10,6 +10,7 @@
 
 #include <drm/drm_connector.h>
 #include <drm/drm_device.h>
+#include <drm/drm_print.h>
 #include <drm/display/drm_hdmi_audio_helper.h>
 
 #include <sound/hdmi-codec.h>
@@ -178,6 +179,17 @@ int drm_connector_hdmi_audio_init(struct drm_connector *connector,
 	    !funcs->shutdown)
 		return -EINVAL;
 
+	if (connector->connector_type == DRM_MODE_CONNECTOR_HDMIA ||
+	    connector->connector_type == DRM_MODE_CONNECTOR_HDMIB) {
+		unsigned long supported_infoframes =
+			connector->hdmi.software_infoframes |
+			connector->hdmi.autogenerated_infoframes;
+
+		if (!(supported_infoframes & DRM_CONNECTOR_INFOFRAME_AUDIO))
+			drm_warn(connector->dev, "HDMI Audio with no support for Audio InfoFrames\n");
+	}
+
+
 	connector->hdmi_audio.funcs = funcs;
 	connector->hdmi_audio.dai_port = dai_port;
 

-- 
2.47.2


