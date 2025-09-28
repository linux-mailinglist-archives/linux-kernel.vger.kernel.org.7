Return-Path: <linux-kernel+bounces-835308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE479BA6B31
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 10:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22B0D178EB1
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 08:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF1A2BEC5E;
	Sun, 28 Sep 2025 08:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Nyi1TU8A"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9443C2BEC21
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 08:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759047919; cv=none; b=YtSobKMvXs2CKutmsJHD7aX460bch/FAMLqfzUtP9OX62Jb7d+Lv+1RPTF1WB0Wx/SCYvL+sjo+EFNXQyByQ22uRkA7fdW7eAT+MxfZ8ZHiLQ5/YDD7QwdGuvAbwXiKFl7jVCqbAH0Akv53r85emtvlJPy0RnPMiEoQg3raSdx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759047919; c=relaxed/simple;
	bh=vJ6MP4HtyLt5a75BuYCv3CbEFdh6+KuelPeaDQZ+OQQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qyfnuO9h4f93jRdBrc9DeW+k/hB987DBxL0SwfWOP/iHiQUSvrMqVOQnHlNV/GeCcyeeiMJdlqQQagNvc27bf+r5gAzCUw1xnfUVu07GgSn7jLmx4PpSKatxSLBUvHnZSFpw9+WWV5uUrkX4ZO11bDjNRVe5y+V6CSO3ODKvQPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Nyi1TU8A; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58S5DAWZ027295
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 08:25:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MFhUEfSaFwySRMaGJYEpZSOFWlmnLOv+5YWLz9EcBTE=; b=Nyi1TU8AJHWkgYCm
	Mgv7R0ZVX0wOcPUovl7wG0Xnz37w+/sVSXo2xOnDA5fZLQfNP04uFmi3XqhnHER8
	V27tyCm1WzBckV7iYoSaOnrk/9YuFhzSuVVh9vBFpnPy2rDlKrJfAxar4Lmw+TxC
	hf30s2KhImMkUW6QTYYpMaE0tmdL2OqqzOGIEVw8wAeaczRpiDMg0RG3NLdhxtM6
	7zSIX4sVPABYEYHGD3xWrebTn236Du6TKM95MHV8ClPVw4dNHlIMU/HorlOlxhX9
	8gl+QObKHjE+BhIiMu44UtsDfk90OACEMIvL3uv7PAfya2vBjsGj+MPB9Dt+uJ57
	a0vPfw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e59mtrcy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 08:25:15 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4dd932741cfso57581621cf.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 01:25:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759047914; x=1759652714;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MFhUEfSaFwySRMaGJYEpZSOFWlmnLOv+5YWLz9EcBTE=;
        b=tWyavKIs4aFYouszaUYN0PnJ7MraMaPTdx+7fIi0+vYcEWk6A+uQ56cdPtUSCqWU69
         bHkW0lH7LsOVKamESfvIBoQEs60PslStTmKU/5366WKAxANx3agx1PYGHsffCUAftcjt
         SVGvnL6iCFHLOZDBLyrKdZd6EQUjgk/NrElfIc6DiHhqyOrm4h3kuku5MZAt8Y2UbAtf
         Xh6ndYbK0vk0OfV+l/FFqllQXP75T9E2JflA+962LMjvZ1QVtYhd11zlhhBCsJsXuBw5
         Ab3PAbV++gjJh6NRAXwkMJo3O/DYGhu2GFWzkHrWOwelWcuJUaAthnaHpGUCDILc+eOw
         J70w==
X-Forwarded-Encrypted: i=1; AJvYcCUP35ZuSyUuZVXWGdizqb3I6UVHTS5lz6kC+q/tS0XvonKzhCz852IYI9BAEBRbdB72QOelImjHILqcZAM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhKHhep6GQshDXHV1+s/b7E1WmUXHtsB3tRFBaO67KyhiyqnEA
	Dkwlj8jRzYGibqTmyCWOrRrKX+W4so9UTsRv/tOHx3FeTc5u0dQLwTgQ0b8wr29sUW1FyOKkT78
	daLbTFXElPj2K8OmLFIInycSGhkzTl2n9Mqm8OoFdlfuxOveHxYpplxZ9C7NGIxDR54A=
X-Gm-Gg: ASbGncus2XuzxiuPiVtInowlHHyl4pJx8gbNLSxBVC79z6EKO9Uw88yUYkdg/Z3oJi3
	vgEZPEchpGv+N5gmAnahnT6IoMkqusQ4VCuGDqnN+ZrE8dSRDdz6h1uZRNri085ssjECPibPFCu
	yZC0+1xgWIWiUO1ffvm5J194tvQ9ixkxWmqUwlilaGmKis07R5U3hJ1woq/ekaWXDxwcYmfTA+q
	VguKPTyKEarIzoYnngoxw6fyAgT6PNROvUP6cQe9+wtORCbqPgcB/YnGT+UOcAr4wWMnHosEXFe
	6CDYQjbHCrR4F57xxhVS7p/+quEZPu6lV7o0ZuJReSEWawlyq5VXLAU0aOFQ0sWY+uyHNsdVlqR
	RThMDvqJJbDDyXsWYvJDHh7/dKOUNI+yslNtBdirG1h2uezU6fp0E
X-Received: by 2002:a05:622a:47c5:b0:4dd:584:1429 with SMTP id d75a77b69052e-4dd05841fd0mr134553321cf.81.1759047914432;
        Sun, 28 Sep 2025 01:25:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwfsS0Q7LOoaRPfQeD9zvDgobB31SXOr4kE+JJnvQnCOXD4rZ+uP+6M8YxXGzoygRLIGjIwA==
X-Received: by 2002:a05:622a:47c5:b0:4dd:584:1429 with SMTP id d75a77b69052e-4dd05841fd0mr134553161cf.81.1759047914018;
        Sun, 28 Sep 2025 01:25:14 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-583166561c0sm3244298e87.81.2025.09.28.01.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 01:25:12 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sun, 28 Sep 2025 11:24:51 +0300
Subject: [PATCH v2 6/9] drm/msm: hdmi: handle unsupported InfoFrames
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250928-limit-infoframes-2-v2-6-6f8f5fd04214@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2210;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=vJ6MP4HtyLt5a75BuYCv3CbEFdh6+KuelPeaDQZ+OQQ=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBo2PDUyU7rCSa5YzapriRO9eRiYkhaqCHGmx40e
 u2QgQMrjL+JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaNjw1AAKCRCLPIo+Aiko
 1c1+B/48g8XIA1mGiOfBerCYJp2Fs5T0zJCKW9Jx4v3PO9b+8QxLYHib6tzym0IumYyly/k7z4p
 aUIpTczb+3zc4DGKfWFnoVBBcTbT+7bBq4805NeNbG7sEYGN5sH64Dx1u+jhfGRODdGJ/E+hDt3
 JpTbshDXWQN/kpzysIXBESgmxv1QN9TZLzCY36KK8KZcY2UZJZ3BuJ+BsHvTwvqrBLm+DD9MXZw
 vI3gknUTNjHrk5YskzwrvFAzYF9tGB9mA9SHw9SegZAAmf7YWzW8SJldbp4vPyMDTLmT6TOGA4F
 JXeghLBFIPITZh4fDuHuLiz5X/nbdlBhKMJwMBQJqDnFjqqw
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: XmKZ86OZGdpV3CnLax-mXFopXjH0jCQU
X-Authority-Analysis: v=2.4 cv=O4g0fR9W c=1 sm=1 tr=0 ts=68d8f0eb cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=B-oVSsyST8MYkDpc_wEA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: XmKZ86OZGdpV3CnLax-mXFopXjH0jCQU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAwMSBTYWx0ZWRfX4sgRovQboPxD
 clrKUrzH5YvARfGVoPbMn3YdqzQqAbNk866htby+ZyD4uqVuz6rWgwd89S9JAbM81yJF53BDxa3
 MrtUIt6eT+qIExqXaLdoIOo927GO86nszAA2RtS4bqB3iQRzsZMkrYxEzAK+0IBForFozh5yTed
 /elBbbC4H8eMq3L7BfZVbIZy/8kL2FWuGEgRk25RQ+EFb5B+5OMGM3T4BI8Jx/I/M1GejbMqrn1
 w4GA2wtBwF9NHQyytgg6lkp5EgeOWBbSd3TIaco+6la5VAeP9yBbmxa5wWzYupXZbAha/81m7vI
 6fllcNtypodUJXsFyFkFBwQh2QsT90WQNVzQ/3+DMMHAEaNClskOgomLRhy8+3434+rju+7v/Ii
 +hzH5LNDm4KUhpvuBlDj0NPqyssMrA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-28_04,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 spamscore=0 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270001

Make hdmi_write_hdmi_infoframe() and hdmi_clear_infoframe() callbacks
return -EOPNOTSUPP for unsupported InfoFrames and make sure that
atomic_check() callback doesn't allow unsupported InfoFrames to be
enabled.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/hdmi/hdmi_bridge.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
index 46fd58646d32fd0611192595826a3aa680bd0d02..121239a01cea334c3e7c789ebfb54df71515db28 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
@@ -248,7 +248,7 @@ static int msm_hdmi_bridge_clear_infoframe(struct drm_bridge *bridge,
 		break;
 
 	default:
-		drm_dbg_driver(hdmi_bridge->base.dev, "Unsupported infoframe type %x\n", type);
+		return -EOPNOTSUPP;
 	}
 
 	return 0;
@@ -273,11 +273,23 @@ static int msm_hdmi_bridge_write_infoframe(struct drm_bridge *bridge,
 	case HDMI_INFOFRAME_TYPE_VENDOR:
 		return msm_hdmi_config_hdmi_infoframe(hdmi, buffer, len);
 	default:
-		drm_dbg_driver(hdmi_bridge->base.dev, "Unsupported infoframe type %x\n", type);
-		return 0;
+		return -EOPNOTSUPP;
 	}
 }
 
+static int msm_hdmi_bridge_atomic_check(struct drm_bridge *bridge,
+					struct drm_bridge_state *bridge_state,
+					struct drm_crtc_state *crtc_state,
+					struct drm_connector_state *conn_state)
+{
+	/* should not happen, HDR support not enabled */
+	if (drm_WARN_ON_ONCE(bridge->encoder->dev,
+			     conn_state->hdmi.infoframes.hdr_drm.set))
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
 static void msm_hdmi_set_timings(struct hdmi *hdmi,
 				 const struct drm_display_mode *mode);
 
@@ -452,6 +464,7 @@ static enum drm_mode_status msm_hdmi_bridge_tmds_char_rate_valid(const struct dr
 }
 
 static const struct drm_bridge_funcs msm_hdmi_bridge_funcs = {
+	.atomic_check = msm_hdmi_bridge_atomic_check,
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
 	.atomic_reset = drm_atomic_helper_bridge_reset,

-- 
2.47.3


