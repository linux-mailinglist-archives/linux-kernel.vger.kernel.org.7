Return-Path: <linux-kernel+bounces-834758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 774D9BA574E
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 03:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4511A1C24595
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 01:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A7F202976;
	Sat, 27 Sep 2025 01:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iB0NPyKz"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A541E835D
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 01:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758935092; cv=none; b=AYfP9gMD0TCH7Hcf3HQdVyE/CUbvF+Cvf2BEfdAHP9a8GFt53IdzryKJPFrcIrp6sXn4YHpjoCiZZV15YgmpFLOtbxVssXnyGwuts1HElMIZxEQAJgYSnIM/G2ZX6qGGZ3RFjAY6pRQ698jS9KbF+6EiA4AzD28UmtvDodW116k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758935092; c=relaxed/simple;
	bh=GDJs9stizfNvb2WVbvQCEr8SONIYHFgwY7yHLMQGSzY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eheTTt3h51sv6z8TgeDVVmkEPvr+mfUj2HHVBtgiu9tP8BxmScS6BYUhaB3KenmtIiI9RjS6Fw7JUtTOhL7cMGkKGTKr53FsBSuw/9VijtV1ar1vCENPNZ5N7NCd5tFNDc52T8dffm7bdUBPySKf8q//bv0CHt1DhRz1jzXx9OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iB0NPyKz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58QEX70M007022
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 01:04:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KHBvbs6wVCtvxZAx2wHIzn0cwgfPtQSReWo4Noc9O+4=; b=iB0NPyKzQp9RO4/b
	NiUXUNjL95SnD6VCYC2k7DHEXwm+tErDbCYYEpxZk1PGBnrfOt59d7H6g7nRmYoL
	BmNhvjHiVdK5EQ7VMkDkLu1MFx3iMTtnUVcyOjXHy1S1KceI/8/zJim9fzkkXSxz
	9Heb2J2vhyGp3HaFE35jg+nhzBles9TZ809gOX4xZ62XfO5nweoxK6mZfHlQTqiS
	/8Lk0vJn/Ovja2ENhnXLkTeWkzfbe1jQpc93dZ4Q9ZYgM5WfpYG2XXPGl8/pHH7Q
	Lf/dfoi9jcixGh95tqcKkkTLSvfxoF/n/ARMhqiz3JCqI2kGNEAlPKuBWewgPWAf
	miLiaA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49db0qvh3q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 01:04:50 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4df10fb4a4cso7698461cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 18:04:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758935085; x=1759539885;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KHBvbs6wVCtvxZAx2wHIzn0cwgfPtQSReWo4Noc9O+4=;
        b=FzAc5Sa+sFF48AeKNFRinXmBxO1I17ubDDc4wECXkRs6R/Xni/FPY55/46kBkS3O6W
         lq+2qzVVoQBwdtUPCV9utrrK21Gfa82eD+cFDPoE89rgLCAPdA/+n2YySepG4BU6Qi9p
         bsnhTPIUyXuMYL6hR4VQtqovH+Ls7rIDvJJ3bt7YJm8YYVV+N3BI9cBtS8/5XQc9ChCo
         dsr/YR7GTgecHpS3Wg9zxVMFV4xbeAO9MYN+RF8DDm8Vqo2v4lr7vO4Psg4JzwXvySnE
         forQWvB9Kp9wvdPqYcBC4bt6MHs3XL6ffrYW6TxrQ71Z++uCv+rUPZnpRaaU3HKGhx5J
         Awyg==
X-Forwarded-Encrypted: i=1; AJvYcCUtjuRwu7FFs2gPXrCEsuwfS15ZWHgGDDjxzCwDxr4JxHMF4yO3EKVIeEK/LZ2WgWgFRHQTU43SkRVokzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+LpF5VueXBYhlYnoScRhkSCFKZuH+SqVN1pm+Jwndjjr+8nZU
	mlMPjhhC9YE/jMMYFek1nxLFShHuSaxJW4uSKqTB7BvK1GYdv9OLso5KMHjNejxdNywLszgINPE
	mcirSYs06VqjLH3kOETPXxS3tBOvV2kHZxkiwqYTypWpbJ67kfm8dTw5OMKPXxununK0=
X-Gm-Gg: ASbGnctqMInlmSfOc4hkB9j6H8QTK4I4+izrH+gcUyY8E52h1vmwfR5Tij8Zr43Kput
	DnPbE29ZFAQYrTchehfFGGHYxt5n6WjXsgIO9gffvBq+9ICsL59XQUZZD2XTTA+aa+BZ1t/oFTZ
	APL5BBXVZbsfbWPuPe7SAHN4yE65wdHAe5LKnpe4MHZpzGMD9nG5gPX5YRMZSL4dLTTA8pi8Xoz
	8/M2aaTOi5z5cgA8Sv94U36CccO1UNfAomV2T2IF+rA76aWTMZfVAEp6m7d6CmL4MJOS4XWvCll
	BpCYtkxW14414OwLSCKbRNjYp7fys3er+Mu5YtDQB7riN8m7xvuwwLD9JosSojdtMepsVI5yecV
	Dowzj3YbmjO/iFTA1c91QT/BSuT1fTjBqlGUcEM8GXm2URqi04afh
X-Received: by 2002:a05:622a:1f09:b0:4b7:9f68:52cb with SMTP id d75a77b69052e-4da4bbe54e6mr141708521cf.54.1758935085229;
        Fri, 26 Sep 2025 18:04:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDgxekAFYTmTTqmCZefeEPl+nSUzBiwY3LbANe6dbEILxpaj8AQRwYb+0/9qkitC+FpZtBTQ==
X-Received: by 2002:a05:622a:1f09:b0:4b7:9f68:52cb with SMTP id d75a77b69052e-4da4bbe54e6mr141708011cf.54.1758935084695;
        Fri, 26 Sep 2025 18:04:44 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-583139f99c1sm2156143e87.35.2025.09.26.18.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 18:04:42 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 27 Sep 2025 04:04:31 +0300
Subject: [PATCH 2/9] drm/bridge: adv7511: handle unsupported InfoFrames
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250927-limit-infoframes-2-v1-2-697511bd050b@oss.qualcomm.com>
References: <20250927-limit-infoframes-2-v1-0-697511bd050b@oss.qualcomm.com>
In-Reply-To: <20250927-limit-infoframes-2-v1-0-697511bd050b@oss.qualcomm.com>
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
        Andy Yan <andy.yan@rock-chips.com>, Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2270;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=GDJs9stizfNvb2WVbvQCEr8SONIYHFgwY7yHLMQGSzY=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ8Z1C4WwP9P/BahfUM7J/q38y+eoSdQLBoWi9c1+S95+v
 sn2RUOjk9GYhYGRi0FWTJHFp6Blasym5LAPO6bWwwxiZQKZwsDFKQAT4f3B/k9v8b97bhIf9U8U
 rWn0L+vfdMc+z9ONLZFtWkd73NlfAtP52OZ9fr5zUayhl/rpazf/lhyvCPNVZLlvN2eaaEvRF7t
 M/RtdPk8PKW1gqT8RmhWS+fDiynlZNom/N/mnfeTKCb/hO+Ovzualbg1512M7InnKQ/p+9Qde6G
 vR8O0/s95ngpGb24U5mc0Vz67N2jhbrCcgpqDGsn7ZwbCKYleeUzyFj/lDhBTmSYZ5q75Wjt3Kf
 Vk1o2NBbWNF/IerWYqvNVZvzdWLWtXKv+is/+R5LVFN5o8X7kjexSmg+/brZ5PqSs5HffbavMEZ
 q1zs5186cY/dRH661Msb39SCc6bVOgZ0nkowVN1rOv0iAA==
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: lo7A1znM8Pci-G7zcEO4B8FqHifrpR28
X-Proofpoint-ORIG-GUID: lo7A1znM8Pci-G7zcEO4B8FqHifrpR28
X-Authority-Analysis: v=2.4 cv=api/yCZV c=1 sm=1 tr=0 ts=68d73832 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=XNEcMcDYeHr5uxMbIEwA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3MSBTYWx0ZWRfX03DBArfhV4V+
 9oEv4OylqRzVX59n+m9Cl6bND+jpvJKX45OsenZcLp4fDkkmktPQ00E1mnxV1t13tWQeOTOUQsd
 u2KIC3gy6a7HdOSO0v4ozMcaqdKif0hDt41Esn5FXVOXRu8QK5oObeU7TNw57JinR6d2A9i9EeD
 tDt+rw5VnqW2XM53Vl4P19vlMOwQ81KtAG67VXzwjhd560pG0EWF1Zu1txHHRk79PCES8IvEGLz
 hYN5pa7I2Nu8s2RIlSeBWKinaxRcezSvFhOGB99IFngS60VmNyV/BfARugYkIT0QZITLstijlD7
 uB2JjZZ4pvDg7X9+YpyQ8TEHX24GS/QGYbuz3odhu7sQn6qcthUQhhP+afrYkQB/YcDRwqFC4LE
 +RScK5ipQhc2s+urvZm4QTBHQ2acQQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_08,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 adultscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250171

Make hdmi_write_hdmi_infoframe() and hdmi_clear_infoframe() callbacks
return -EOPNOTSUPP for unsupported InfoFrames and make sure that
atomic_check() callback doesn't allow unsupported InfoFrames to be
enabled.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
index b9be8654130758e69ac7ccbc73a82cc25d731a5c..452265c2d81269e158c83850279a3a58302faf03 100644
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
+			     conn_state->connector->hdmi.infoframes.audio.set))
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


