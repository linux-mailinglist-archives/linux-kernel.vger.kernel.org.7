Return-Path: <linux-kernel+bounces-834757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF78BA5727
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 03:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB15D3817D0
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 01:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BEB41F4606;
	Sat, 27 Sep 2025 01:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="h2aCXGC4"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFDB1F0994
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 01:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758935085; cv=none; b=K5ooNx0jR0pF15DT+SFob/dvmsKJ95aivkIHBVFODXIjwY3DuTpRtJaPcvquCAbs1HM/7rb00gnw/bibtLQbHsfxnOBOHhbgLuGBcSXB3/7XyxfsXGK7pbzbiBNmH4XHNTTOkCe77c/cttBTKONxZK3Y0/7Eh4ZEJuCnyrYNG9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758935085; c=relaxed/simple;
	bh=3Kap+upNT87sFn+7RYq1dDaa62IPE0BRWOyWIEU3S6I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ULa8wPL0sEUQkXOTrVDoHXMwPnmJVf+eSYkRlHK05vprL2k0w6xEXy/U9ecyiDyYuPe16tSajDJ/FmCJEApSFdMuczZjG+V/1l6Q1GByOJtC+pxlOmXP//G7pq3rYWo8DAxZFauCNf/S5+veCsWWDls4Jc+6xxW9r6ZHWePqWNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=h2aCXGC4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58QEWrRa012042
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 01:04:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tqL9/YMiIEc6tsQIKNZIjqHO6NoBtjrbfKTgbxxDbRo=; b=h2aCXGC4I/FFoMnp
	ArCQmvc7Xjl5wqsta2feYFgGDI2uIcwDXCd7J0Gmp2mkXhwM/90qPS3j99QD3eNn
	gu19rTNNMHJt7ZXdsPYO5qHfKW9KUaIGFwJlwA5VrvS8yr/bBE7QDMEitmdf1eZM
	k3bKPYzDMow0aPKNFhQvqlPgCShKom8IyZufpGAsNxFXU57aJFdCrvzRp7HkAwEB
	zV5AjopJDVGM1aGGaWsKrwJVMHBwNcQfhCBSQwYvpAJQuSQijHZ+ie/QXEHvJNrn
	X62z9DjXvsPxYiRBif5ns/q3sqsTLemg4FKeDe0ZM9s4ST3bZz8LvreCGTylgB8V
	MqJ+rA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49db0q4gpf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 01:04:43 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4df10fb4a4cso7695811cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 18:04:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758935082; x=1759539882;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tqL9/YMiIEc6tsQIKNZIjqHO6NoBtjrbfKTgbxxDbRo=;
        b=MonG3qhhhcUOuqT8WXQVMCusf5eQMJMHp0KN2DTB2J4wL6iy4pqaEOacZpu7xcc2vj
         r0c8y2dvCLOUea99u/OJkkXGFIBQWDuv8irj3haPGlqm8rUc30J0OKLz+tP6ejYLeaCN
         1FuEP6KJb7ZwwBUTmpko5EZxB9Yh2iYqOvzETIaCGX5NYjIPs77zRWfyc8C1O/J0J6fe
         x59bX9v+POOwlooKiEZd9f+u+SsZI+NMXw05p0+ojHlwxs19k9GyR+HqWmi/7CEQXTsu
         pArE6iIVaoh9yvTZ28Piz/6RGkngbRdx+XbwMagA7BzlQCg+4uKdX8V5+gw1HMsQck+P
         ttMw==
X-Forwarded-Encrypted: i=1; AJvYcCWbSKAkzq12nxxVwGEdtnQ4F9C68mjiMQwp8x/XtWONnqCQ/hYYzq+OcHA7VoiocHma2G6TIYjmxc00UwM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5stlN1eC8ntNCkco7K1vshnjdwWh7LZ32ZNiPyiFQk2Cnxyzz
	iCbUVzo3Z1cmkRGS7x/T9ORTQznC2qATFUCT4kBg7DwOlGzFWHWjMnUeeX8NEvOEO2fsrjr4oUs
	Fp2Z27gkFWcU7WcOmz8Lx4CXiCb3WuTdCcJ7ocu/51L8gRn/mnvBFudZo+O6Lxh4l/4U=
X-Gm-Gg: ASbGncsp1oKnCZJV4IJUlsSFQsC85hCBD0X/nCPd/2Ni1DHbp88t401xcdvGHcNnwnY
	5OA+lLSp90yr380QrFPE6+HI2jR+dGu6GgG2/oYtPQ2Fi73NYGeIP/bKXL8aG5qJzCD21k6f20L
	UMWd6f5WIEDH+9lJT6Gb6RnNFJovrWRQc9yBDw67AiGnIN0+wzl2IzrqF6OJFxk+tv450+gyJfs
	xdqZ/lbEBu4a87sTA5Psn5h5gJlvl7uJV/2aCOqZR9FIYawyh/sPT3ANc5CBZYhPKVqj7xtZ3xu
	qRCF+b6UJtwgT+H5WroKvrnSILCM1jzJwH798ZXEmYFzGNdBL6/AGfkauLt+O2OcJpAPUjoF5ho
	4hO1Br+LBBF7n4Qtwft0tcNyZbSaNLJgE5Hb7Qvk1JBMpEVIXvK16
X-Received: by 2002:ac8:5f53:0:b0:4b6:38f8:4edf with SMTP id d75a77b69052e-4da48c83a55mr117773551cf.29.1758935081775;
        Fri, 26 Sep 2025 18:04:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF75VibNMp5O2UtPKi1lry6nSqkB5lKg4XgBP9p5gbrQo+2jtHOvdb5uGII3iLSHRo8cejMHA==
X-Received: by 2002:ac8:5f53:0:b0:4b6:38f8:4edf with SMTP id d75a77b69052e-4da48c83a55mr117773001cf.29.1758935081126;
        Fri, 26 Sep 2025 18:04:41 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-583139f99c1sm2156143e87.35.2025.09.26.18.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 18:04:38 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 27 Sep 2025 04:04:30 +0300
Subject: [PATCH 1/9] drm/display: hdmi-state-helpers: warn on unsupported
 InfoFrame types
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250927-limit-infoframes-2-v1-1-697511bd050b@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1357;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=3Kap+upNT87sFn+7RYq1dDaa62IPE0BRWOyWIEU3S6I=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBo1zgfX/GIreKBwo6aCquZZY/wID5t6jipXzkNi
 wTF056wjFeJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaNc4HwAKCRCLPIo+Aiko
 1f55B/9KVdsAJOIT3RmBfdpKQySqJj7khLyWlEyFtjy3loB2+1eEOtJi2XVpH99c6q6m5nmgika
 FDWK4UD2Q/faYp488okDacpcRd7LG2k1I/KXafk68W0yMIvO5PU37KKyl7UkZWxNov7p7+aHt5R
 Wwp8mCubhX8mMCmlOVFpNKA5ARDnIbuY5e3+fAnV7hsW1ppyyJaXajCEmTQZvwpQoU0oH5PmzTa
 OwUPXQEUskF5wjmeV0dhV8YVx7YAksWi40g7yInbW6g+Q9eVi2VGdPoFWcdBj1TOGc2d7/j1rgU
 PZOjdrVKqzO/S8m9Bgk8t7Er/wOQS12w80Pibwbavv/Oj8jS
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3MSBTYWx0ZWRfX4ceUhaz7ROVT
 9edpyI4MBTVp3rtgVonynyQyueiMzTGvimUukRajbJPfKXBVh494LjyfXhwt4x9cL399rgrvIey
 c3LMeCLgWjBjfkVkXLoaM9T/tlh/ZAI9kX6R2k45W6r5CaqnvIFK0pAQLsykCsxzRYCvTJ+oi4n
 1MTuxp0eTMKR4iaxmR6ZutYXS2b62Jpfi2hTbNlR+GasfkaZlBL56YNUir37AJn1a0sII2dBqy6
 ujT7qQjismeuJZ5NnTIB9rNiCA/LFHhDDCTFp/AjZA2n7LfgK8MHWsupGXq4NCnJI9ZFvWrFSEl
 +hyiVkysJYED2PhyQjMmnmVV9/y3Jd2msHxkW4XAkvZtdRVry7XzGc11de14AEaMa6shSdgHl3U
 BefjBiMXyxYj+4sNipdUX5owdQpJ2Q==
X-Proofpoint-GUID: 7uZpG2gI7QUWSWv5FQmEcU70D7lgOoLG
X-Proofpoint-ORIG-GUID: 7uZpG2gI7QUWSWv5FQmEcU70D7lgOoLG
X-Authority-Analysis: v=2.4 cv=JsX8bc4C c=1 sm=1 tr=0 ts=68d7382b cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=9qaGXxVFTICEpRVd4z0A:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_08,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250171

In preparation to tightening driver control over generated InfoFrames,
make sure to warn the user if the driver rejects the InfoFrames on the
grounds of it being unsupported.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/display/drm_hdmi_state_helper.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
index a561f124be99a0cd4259dbacf5f5f6651ff8a0ea..361912de2741939cfb5ec350c08d738a92e2ad37 100644
--- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
+++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
@@ -920,6 +920,8 @@ static int clear_infoframe(struct drm_connector *connector,
 	int ret;
 
 	ret = clear_device_infoframe(connector, old_frame->data.any.type);
+	if (ret == -EOPNOTSUPP)
+		dev_warn_once(it->dev, "unsupported HDMI infoframe 0x%x\n", frame->any.type);
 	if (ret)
 		return ret;
 
@@ -947,6 +949,8 @@ static int write_device_infoframe(struct drm_connector *connector,
 		return len;
 
 	ret = funcs->write_infoframe(connector, frame->any.type, buffer, len);
+	if (ret == -EOPNOTSUPP)
+		dev_warn_once(it->dev, "unsupported HDMI infoframe 0x%x\n", frame->any.type);
 	if (ret) {
 		drm_dbg_kms(dev, "Call failed: %d\n", ret);
 		return ret;

-- 
2.47.3


