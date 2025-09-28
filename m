Return-Path: <linux-kernel+bounces-835310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF28BA6B46
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 10:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D85F17B282
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 08:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93C92C0323;
	Sun, 28 Sep 2025 08:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mp4uYkh3"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6162BEC41
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 08:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759047921; cv=none; b=sIkVZzfupqFnT3g6qSbAKO9Q4w1xX8JN7iTBtIOP0MlgfbiQ/NzYC15wCI+n1bTyNDHTXUzcEN/ZZvsFn9crbzoSmMMSgsdXyQMazQTRBD+h6DVcnkH17bvQ6hH5/pDuXIfemiQGmPTfakI5gqSl2spjMe8Lx/8HcHu+dquYlsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759047921; c=relaxed/simple;
	bh=1/mrVoFRRvpJKLVB9yIweMc38FlRgmbKvH5lbekmKJM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=URSJh1uPmosDqE7Ua7jnRxCHKXH6b8ZJVz7n9N6lzGD7HsIwDQCWlbz08m7Wq/fsJpgGFbr6AdP1LGbTstwVS2R3u+3zAmxjkdzvEqQLl4h3DepESun89EmEsnibAAs76AqBcKkOx6O0aQmB6Od3RINWpsjsGnFCekCni/ERdas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mp4uYkh3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58S8GuNq012669
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 08:25:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JW7b0AYTyN594l8jjE7IU9Ox23Y6YfPpI2powo8DyoE=; b=mp4uYkh3my/rx1K6
	uqOwewezFIOGTfAWBC4LJiqXSiJqYkSyfHxq24uRT+mIf4ORRgXxNBO1vIH47rSy
	tykT0usK7356iAfJwZYeMFnpv/zxwfiN5BCYkgwenWnIQrDjUdM5DD9rwaYu+6Ch
	ZIDGImYyjvsPMV/ckGhwjS23Mfctwxrt9E/To+vfgSwYazOG6VG/JECbyWiP7v3n
	jwJIAGaAWGWZHrREK3bkxDZt2+JJWyueAGlml6EDioGbF4aiBkiFEP2jbhEKUTNU
	nQNFfiLxGlXw6ViWcpjGOMoK+m9MCrUa+ob3FPzOl4zoUkO9p3LJC285H4tXp7rQ
	Dtscqw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e78ftfjf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 08:25:18 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4de2c597a6eso68688361cf.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 01:25:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759047907; x=1759652707;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JW7b0AYTyN594l8jjE7IU9Ox23Y6YfPpI2powo8DyoE=;
        b=mCN24+ONPHUS9EnkaFcLbLY8+qsGTUFPgjmk2syo21YlmTwPmSxqJWLZFsdAz2D0be
         xM9NF0wxdbG9xR9+Mc32d2KOox6i28UuPtZDjFvztljSEl7o/V9iPHaHK6AXnc6Klu6K
         B/87mxcBg1ThcPO7+hrYRM3K6kv4Yj6bjg3SWAKpUjMXNdR/f+LrALF750s3KV6Kb+ig
         JMTKNFS5GmR2yIKQigQq2CTGT6XigxWEvW4tgPpa4Q0RcRMt0HLxBFFuh+EoAY/V/F7Z
         Fit0DgRRTn5ox+fe2jIFGX9XNaY+GHUc0FVqrBq0SmdanMI7F+pBVMCg0eEErEktZ6Xv
         ikew==
X-Forwarded-Encrypted: i=1; AJvYcCWFSf/FVYnTVp8HHwa3RkpU3ofbSRYjDKKYVI40RzaS1MhPtksNDaFhiss46gnWsllc8C8dHDHYAEiOjqk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8XpluoJYRUpzzaj70obBkU03iaqQMylGmzUh5OtqSRd00a3rA
	fNHMXwJugyelbadb/Evu9fi6VeQuo0NFFMOeK5DdW7zecwIVWEE3Qr/5SkcO9JDOu22yvlTW89T
	MLxm8c5pcSPRv4GfAUP0pBLmTy6xmewcfsqmOZEorcbO8YS7ScsxZAME57810ZJFi/mw=
X-Gm-Gg: ASbGnctLA2aso3/0BHgoLLCqa8Dydj3R+YYwUW46wapdHTBzV4OUrudzjtTmS9+UyfQ
	pw+x8IhbHf0Tp4f70c+ZW0gx4djj3hmiEo4rymUb23KRm5uxMhkQbwV2QnCVFUN8819qyMtFgwR
	m8v4uNtXvD1v6iT4CwHbgOtP9hQ56aGINZ2tgYdfxn3WSse0tgC4kXXAVnbD9CkgqUhbeUD199S
	V8X6m0j3qyGEJpu9L9rWnZLbN/LRE4Ue7Y1JoGk8EDJQVyTt3EopSmh+e0VQr7Ux3uH0FfHmnyQ
	b3g9kZ3Wjgb0aAD9Wp2+EzS9vhv8pIt6NamX0Ip8ZjVEYOER2So+SVygAnn00bh2/+t9QAjd0Vx
	qQ1qyPylrKi9YRbU9JReX21nO3FRsUD0ln0yTA8sVO9IEqjz4OuBP
X-Received: by 2002:a05:622a:4113:b0:4e0:3cdb:d1df with SMTP id d75a77b69052e-4e03cdbd513mr20512901cf.61.1759047906706;
        Sun, 28 Sep 2025 01:25:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4tHD6skIRR3PjbcrlwIurQ9DEwp1HfbyW5F+wYqRDoVlCeVHGTwgYk18z8akZBkWd0ey2Ew==
X-Received: by 2002:a05:622a:4113:b0:4e0:3cdb:d1df with SMTP id d75a77b69052e-4e03cdbd513mr20512631cf.61.1759047906284;
        Sun, 28 Sep 2025 01:25:06 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-583166561c0sm3244298e87.81.2025.09.28.01.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 01:25:03 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sun, 28 Sep 2025 11:24:48 +0300
Subject: [PATCH v2 3/9] drm/bridge: ite-it6263: handle unsupported
 InfoFrames
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250928-limit-infoframes-2-v2-3-6f8f5fd04214@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2493;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=1/mrVoFRRvpJKLVB9yIweMc38FlRgmbKvH5lbekmKJM=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBo2PDTbRA2Db0kLZgBdJccCkRJyGWafvFK3UwlK
 Og2krTm2XmJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaNjw0wAKCRCLPIo+Aiko
 1XK6B/92TZdiTuBfCGlRC4tos6HVjULlKxbSlGenYR7KxEuZIHS4Dk0YnbH092fpCdLBVwu+HPU
 ujJ62abOk2Im0tkGhv2TcH17QXLGxsVHTeyqEaTyUrXZ6CY6h0NkastGwiYHf7g8QlADuFs1GxS
 lW1oQ+pI4hic2KPX/aJrg1zgAtNlypZ9RCJ68akVjorGwphcyKNLVN+zLiaMTr2sw721zRXl6Ds
 +du/mKltWJZ2dFgc9hP/NUj79ScuZN5JP25DmLz0AaFvVGCMmY3VVDSzl16zxQo/N0sdcQr0wd1
 8zhPxNihWZjFB9JMpn9yvj1d4yupQZF+el6CWN1CghvEARSl
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=DZAaa/tW c=1 sm=1 tr=0 ts=68d8f0ee cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=yMgUBx0mNp5KM1AuerMA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAyMiBTYWx0ZWRfX604/V6ZfCb1k
 +4jXIRMdCNVW2vqi3IdQaroz4iJnEleywvS1+xZC2vhqYeEeFuw4OxFMT4PF8Ji+7TQ9uvvsSd+
 kc1d1wqd+87c1vTmEG+Go0/gAlRudnBTE3WZFWJyzBp6KoADeCkXGAYkZ6IqclT/I2Z3AEw46Tj
 sJVqvR4GvhqkZSfR5XBmizmhlSc174wWmb0wnzVfl/CectRdPMoLfhVDb0kV0bWQMIV/BgJpeS+
 ravxrMEoN9DuseQElwIkL6RpvKI6coQPTbG8DjuHHROd6fTcvaFnujtMdYknnYQLCXjflnErz1O
 w3zGIlUHor2L0YmqpnOXHTgMWMqObDjQFkPjlXcdNxkLmWXMpaMfrVWErnG7QaUm81XhFbMIvui
 w0GWcbN4h0hE2aKq3+cNsfRV97mtNA==
X-Proofpoint-GUID: n9YBMwZ_LX14IcB5xwZCXljnZabVaWCg
X-Proofpoint-ORIG-GUID: n9YBMwZ_LX14IcB5xwZCXljnZabVaWCg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-28_04,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 bulkscore=0 clxscore=1015 adultscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270022

Make hdmi_write_hdmi_infoframe() and hdmi_clear_infoframe() callbacks
return -EOPNOTSUPP for unsupported InfoFrames and make sure that
atomic_check() callback doesn't allow unsupported InfoFrames to be
enabled.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/bridge/ite-it6263.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6263.c b/drivers/gpu/drm/bridge/ite-it6263.c
index 2eb8fba7016cbf0dcb19aec4ca8849f1fffaa64c..cf3d76d748dde51e93b2b19cc2cbe023ca2629b8 100644
--- a/drivers/gpu/drm/bridge/ite-it6263.c
+++ b/drivers/gpu/drm/bridge/ite-it6263.c
@@ -26,6 +26,7 @@
 #include <drm/drm_crtc.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_of.h>
+#include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
 
 /* -----------------------------------------------------------------------------
@@ -772,7 +773,7 @@ static int it6263_hdmi_clear_infoframe(struct drm_bridge *bridge,
 		regmap_write(it->hdmi_regmap, HDMI_REG_PKT_NULL_CTRL, 0);
 		break;
 	default:
-		dev_dbg(it->dev, "unsupported HDMI infoframe 0x%x\n", type);
+		return -EOPNOTSUPP;
 	}
 
 	return 0;
@@ -812,13 +813,35 @@ static int it6263_hdmi_write_infoframe(struct drm_bridge *bridge,
 			     ENABLE_PKT | REPEAT_PKT);
 		break;
 	default:
-		dev_dbg(it->dev, "unsupported HDMI infoframe 0x%x\n", type);
+		return -EOPNOTSUPP;
 	}
 
 	return 0;
 }
 
+static int it6263_bridge_atomic_check(struct drm_bridge *bridge,
+				      struct drm_bridge_state *bridge_state,
+				      struct drm_crtc_state *crtc_state,
+				      struct drm_connector_state *conn_state)
+{
+	/* not supported by the driver */
+	conn_state->hdmi.infoframes.spd.set = false;
+
+	/* should not happen, audio support not enabled */
+	if (drm_WARN_ON_ONCE(bridge->encoder->dev,
+			     conn_state->connector->hdmi.infoframes.audio.set))
+		return -EOPNOTSUPP;
+
+	/* should not happen, HDR support not enabled */
+	if (drm_WARN_ON_ONCE(bridge->encoder->dev,
+			     conn_state->hdmi.infoframes.hdr_drm.set))
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
 static const struct drm_bridge_funcs it6263_bridge_funcs = {
+	.atomic_check = it6263_bridge_atomic_check,
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
 	.atomic_reset = drm_atomic_helper_bridge_reset,

-- 
2.47.3


