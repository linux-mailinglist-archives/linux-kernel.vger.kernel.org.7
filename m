Return-Path: <linux-kernel+bounces-808469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7339B50038
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 16:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 833435E526B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 14:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1755A350D43;
	Tue,  9 Sep 2025 14:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="izj5++eI"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97B9352FCE
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 14:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757429548; cv=none; b=Fc7lDPW+p9Re9x+EQskFpObXIfME0N0mOLCg8LeeE95eyGEhWspXcEklUK9pQiqUpTObudn6E53d6aeD3IMLvJFu92H/wPbulilxASChOsHKdb81fTV/oDDI9ltpU0t2bB3O4rkw/9KOZu1nE3ebju+zrSfpvclSOjQDjdKbBmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757429548; c=relaxed/simple;
	bh=UHf2bwt1HahWYSjc39yV+lZLDN/VOziYH17k6fxHegA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YL5zZc2D3IA+CtEW4A/03zorx9h/rMcChlUUvmAUcg7YuxSjeiTa8aKVLwEgR2iB1ElP78xYIJJGS2GhQuz6o54yzHZ0DwA6RLeNIgSNC2+wryO5MkgelVnQW0XlVwHG3/DHUoGhnIsKoaTIJrYptuCkld190/EObFrSzxu1VV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=izj5++eI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5899M2h5002298
	for <linux-kernel@vger.kernel.org>; Tue, 9 Sep 2025 14:52:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5XcVN4la18BIwaO+Gw7JIQ9/7PnLHljWUo62csPu7Ys=; b=izj5++eI83OeW3j+
	lV+SOwHzoLSPiRWmCo73yMg0KmZZPc8mkwAtdeiIcizeR8nnTYEd2RCNYsY/w0+G
	aAbUTV6DA0kcfHdnH2UDbpkG34PYV22/AuSu/mbo8coycZW4c7NUqKbRO/rnNACl
	CG7leAvrXzxEjqhBJpxcryG0hhQ6J0wl9UHv4aZxALseIugZuSuT/BFqk9fYy0/a
	DXFeOxIGBEunloPcgtLbqavURcRDcM9NqmXGDo54C1b+A+0XornFwhs3rZpw5cXN
	KbV+HL6lCeDkQjbBw4q7CNWJ65kO0fspWQdy/tUmfgh9OsDJrGKnA7mfFSoMJwAx
	elV0Hg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490dqg0dye-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 14:52:25 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-72e83eb8cafso91197246d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 07:52:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757429544; x=1758034344;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5XcVN4la18BIwaO+Gw7JIQ9/7PnLHljWUo62csPu7Ys=;
        b=KsyWkUQeM6+iLXKHe5jgY+ND1wh5NC4pZBuuxzYjmi6o1ShU7XsxxBz0r3flsoEArW
         LTqaSodJPBEQipvW7dJd+4/uBkvMyj9j0s6m9Fx5kmqyQ7wRwsItlI5eHJBaZzaVx2hV
         VyYmshC6UZZlJuulUBWNE+jmWZnig9uoDN171QQvLxkLjRFJrlPDNRDxH4Cg7sUDcT5y
         x4vEJuXC1tN4Fgo021sXc+SBRjcMauf7K+vdY6Z9LDx7DuT58ObjbPbMIkWPBuB07tTA
         ZdX0x4/27O/SKoLBSN63qzFcDfc4qo+/atDVHR9jNdGEAUhHqrvnnapsaPGZxbGCra8/
         N8pg==
X-Forwarded-Encrypted: i=1; AJvYcCXD4oEvje7h1fcfemYOoA2mk7OU9iFffly92uV9fw8dac6TWHCZItdIncOZQboqyouo7I+6Q3oTUvBUizU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwegWaCFQ3PZT1pShO8yJII8qan9Ee5vBIVdORv0Xw3MFV9RIQ6
	T/wdPC1l9HNaYGgl1PKfXdX1i26kic0SFHEXMSbiYJBy8CEBOr/NsVsqjzyscTj9v+r6tzHqb6O
	r+oBjwOSzno8dMZAGM+HTlyPgvZ/bZVXqwZ6CMUoDftksFJLIuA+cFj/2xCxsDeLza2A=
X-Gm-Gg: ASbGncvtrRs/LZtMSiyyPzE+4hsd47pWn463qTEc9/dHOt8E91wKHkCoubYuqqmcyBr
	Ts436k1LMtE7tdOiTcTB4GFKfumVJ8Je3CsuCzCbSCfG3l6avfD/4gTmXqZkawg0bLDsNXflfwZ
	UK/jyoAKAzZibuimnmtNIjkNrgRck7Vyn2FOxr9jEU7WpFQS6cmVhn9GINp89znFjGwH9cbrgky
	An8JwGoBOk8SHBkU6DG8jRIwnqgWPNCn/SMR0Y+UoC+k/pFqMfXRx4Rr/dP/Gz480oGGW/d4NNy
	6edYH9rVBPrkhLYa/N3giwSGeKu5PYBOKzTSRFVXGoXB8hoBkoagpYdJkgVQ2w2Wyw710JwHeuE
	kTkIXOv+DxcYzGoBIXgiXhj2BeYQtg2zO8A8nnNaZREhywaZ/c6ll
X-Received: by 2002:a05:6214:448d:b0:741:12df:785b with SMTP id 6a1803df08f44-74112df7c16mr114471396d6.43.1757429544076;
        Tue, 09 Sep 2025 07:52:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3qcUmc5HWgaItJBSMTFOPrjz9C1oV8lSQudH4aunMS3xSVXsDfkPrjvpJJ3ZzD90MSTY/GQ==
X-Received: by 2002:a05:6214:448d:b0:741:12df:785b with SMTP id 6a1803df08f44-74112df7c16mr114470966d6.43.1757429543548;
        Tue, 09 Sep 2025 07:52:23 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-337f4c90eb9sm38735781fa.22.2025.09.09.07.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 07:52:22 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 09 Sep 2025 17:52:02 +0300
Subject: [PATCH v4 04/10] drm/bridge: lontium-lt9611: declare supported
 infoframes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-drm-limit-infoframes-v4-4-53fd0a65a4a2@oss.qualcomm.com>
References: <20250909-drm-limit-infoframes-v4-0-53fd0a65a4a2@oss.qualcomm.com>
In-Reply-To: <20250909-drm-limit-infoframes-v4-0-53fd0a65a4a2@oss.qualcomm.com>
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
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Daniel Stone <daniels@collabora.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1743;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=UHf2bwt1HahWYSjc39yV+lZLDN/VOziYH17k6fxHegA=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ8YBe6mOiGmmn935q5ct0cr/1pS1u83FZ5P13mkK/k89p
 azua//tZDRmYWDkYpAVU2TxKWiZGrMpOezDjqn1MINYmUCmMHBxCsBEAuTZ/2fxTphaase6a52x
 1oaTii/vV/TfvytiaMfGldjbGWgZYH9IRNfivDu7klVbM69V5pWcToEHezsZP0/Ke8Hklx9XWGF
 U1DXfrp+78se8z+v/SU+zv7VzBWOSMmtrQ39OtLml+TUW0xclu5P0Rbnfbeq4Ulpy75r6FrNT//
 V2rdsewHFOepogxx6zj3PP9zLlhZXMUJPPvBa6tJz147wmyy5XQ0OHuEkCc+5a2om/3/Z4sXH5r
 pczrnzn1GcPfpmruPKrveGz0mcMv9qvrWzr/V4kzrPWtsBw+oHIu9LLN15OlGXwdD8mHFBWveqM
 UK1S4KQ6xZUsB/Y/zVnW88I622/h77iPW1/HpF8J5NsMAA==
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: Ye8BJqW0NSbtHQFTaCtRNtKLMB58_Kfi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzNSBTYWx0ZWRfX80zQL8lMr6Ac
 krXBeTPcHf5A0altFLRJs1c0GFCU6N86D5ucqg4hxrD92UPY51ixBeTgKhUmTdRSjKUj3NbwNF6
 rbYn8Fg8s/WVASPyetTN6ua6NMPeRvHSMYVUHGWC+TESfWXXdSLSkCA6nWkWh5EiXqAMN6iOYhb
 8oxwaTuXj1dDPZzC24jOKYhU4gb9Xq0LFghXw9OaE7yCDQS8DSgK6bUAP/DbazY3GPDbWIO9k+G
 D3yX8CKDxtvhzJSHoBqEWlcsssvLl8i6MzcF3U8izLIjS7/OiIYT7l1WzLcqVsyrWFZctdwyDnQ
 ZlUKOkVtrQkvvE92Al2ePmx4LDE2Cs0aGJp9mED/DN/M6RONSDqwsVW3zt3WpjEepuD1eu3WPM3
 CStSJqVS
X-Proofpoint-GUID: Ye8BJqW0NSbtHQFTaCtRNtKLMB58_Kfi
X-Authority-Analysis: v=2.4 cv=N8UpF39B c=1 sm=1 tr=0 ts=68c03f29 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=QX4gbG5DAAAA:8 a=EUspDBNiAAAA:8 a=AMvF8s34Jxw15HKoVo4A:9
 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_02,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060035

Declare which infoframes are supported via the .hdmi_write_infoframe()
interface. Return -EOPNOTSUPP if the driver is asked to write or clear
the unsupported InfoFrame.

Acked-by: Daniel Stone <daniels@collabora.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/bridge/lontium-lt9611.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/lontium-lt9611.c b/drivers/gpu/drm/bridge/lontium-lt9611.c
index a2d032ee4744715b88eb66883edf69bab4c274b0..019114eb343764dbc3da36ab02d53ece11f46adc 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9611.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9611.c
@@ -870,8 +870,7 @@ static int lt9611_hdmi_clear_infoframe(struct drm_bridge *bridge,
 
 	default:
 		drm_dbg_driver(lt9611->bridge.dev, "Unsupported HDMI InfoFrame %x\n", type);
-		mask = 0;
-		break;
+		return -EOPNOTSUPP;
 	}
 
 	if (mask)
@@ -911,8 +910,7 @@ static int lt9611_hdmi_write_infoframe(struct drm_bridge *bridge,
 
 	default:
 		drm_dbg_driver(lt9611->bridge.dev, "Unsupported HDMI InfoFrame %x\n", type);
-		mask = 0;
-		break;
+		return -EOPNOTSUPP;
 	}
 
 	if (mask) {
@@ -1136,6 +1134,11 @@ static int lt9611_probe(struct i2c_client *client)
 	lt9611->bridge.type = DRM_MODE_CONNECTOR_HDMIA;
 	lt9611->bridge.vendor = "Lontium";
 	lt9611->bridge.product = "LT9611";
+	lt9611->bridge.supported_infoframes =
+		DRM_CONNECTOR_INFOFRAME_AUDIO |
+		DRM_CONNECTOR_INFOFRAME_AVI |
+		DRM_CONNECTOR_INFOFRAME_SPD |
+		DRM_CONNECTOR_INFOFRAME_VENDOR;
 	lt9611->bridge.hdmi_audio_dev = dev;
 	lt9611->bridge.hdmi_audio_max_i2s_playback_channels = 8;
 	lt9611->bridge.hdmi_audio_dai_port = 2;

-- 
2.47.3


