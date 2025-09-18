Return-Path: <linux-kernel+bounces-808474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 457E9B50045
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 16:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 486414E62E1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 14:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23DC3570DE;
	Tue,  9 Sep 2025 14:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LOVxT9wR"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD09350D77
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 14:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757429559; cv=none; b=bvX0LkHocfJdD+B10djec495b8MxOnWx8g2cXg0o95GEo4lzFMO/EQeWZCD/hJ8gxrTYvnaeGuw8AIF3ijLwLpqE9F7gxhwT82yx0PKWEGv8GTc9DJ2Vjzuys+3JImrFjHMwToyRhLOi8lBoNtSAZavxYHi2nwFGpMhV2YIPYZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757429559; c=relaxed/simple;
	bh=GCdbmTwssKDcXNKgdZbInJ/IsWBy3ZWBjV1zBKp4r0k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LLu0PoymDeGucRlamN9MFQhyroq00xX4YLA7uH0voncanPGaxiflvpaDcxDj22lEhq0Yx3qvPGVqeXAOQ7Kq453Ls2ufruDET9Z5SgNkJK5c6J0FFoHqwa3Bo867OTflBx6U4XE9YGVwGX36sBeDcyI6kohLzqzW195cQnkD18w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LOVxT9wR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5899LRdt032042
	for <linux-kernel@vger.kernel.org>; Tue, 9 Sep 2025 14:52:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6ppe/L523pX1O8Slf7FEFSs+VXXiz+Rko9uu4CzdmWc=; b=LOVxT9wRqIMsdtxq
	cndOMoifYWVHpZc62EvmN7rj0LDQWAcqL3g7/Sl4DM4EXUog/Mxwe/VyUg0QzT2B
	z3MXkIFFVU1vvUsjuf2Q8uF46tuSQ2B8hUQoQZTMElD1fpy5TVBv6EfWoGO/86o4
	0adpamYkKQP5nECPo7ebms3B9bJmH3QuhNBuSAmhzI6LviBqhrZEuxVnF3eTVh87
	DvvYXvQ/4JxGujIctjPv2XB+Yo/1U1cQGa8IO9F894uEnE378XvCuYToH0angsNJ
	qOnafF9a54OBsWShEhA+PnaZ3Cs8DU0kqPeHqfR+38PTVJvvh+jNfOHZqhyzY7sU
	ii+zMw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490e4m0f74-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 14:52:37 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-7296c012f6bso116936326d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 07:52:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757429556; x=1758034356;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6ppe/L523pX1O8Slf7FEFSs+VXXiz+Rko9uu4CzdmWc=;
        b=UVQY/eyCIh4ZCy7hatwQxEgm/rzAiMF/ZUltk02oH7qE1r+zEZ3TDbAv9+gXJBmEHa
         fFFwppM4efNOLndjp0JbgqLpfFqPYu2GFcuOCPWbnVO2v9RiDLVhaQpThqFmWwnZ4EIY
         NBSohhIoqy8b7TOdTbcddQinSeGvJEAAjfiqy9y7ZOcxgIRDoPABhGBzKb+rDGxr+7nu
         us8E2DLrw8svLvrKuRh1w28NTPfOYXgQ1e78ATBI4V2J45nvkI3dLxNULXgKp3FgrsBY
         jAKfuZ5d4thNxt/CX+MPgb38OnDCLsZS4brcbOCaZ2C4PsenmTsbQRWxBpab8ySK+2UV
         bl9Q==
X-Forwarded-Encrypted: i=1; AJvYcCViR7ftdqD1NytM7j0ZvN3o/+qQYoOEa8WvZGNzyY8/lz6/B1+e9DdYegyAFkUgQZb92dfk5MuGUcW3UXg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/9I1N1QcCHTr5+DgCKipycCqu++8mfMWw4HIxQcUi0D2nL/CW
	fpMUAkWBFJOo+i44yIxTaBwth1joZDE3WgeDQJNESmdZ3ubmEhcaDDltJjaFqy93z/D/jRUp705
	QA1of5fu+qzpZ3TIxYeqTFfx+FnjwonjsYDVaykHK21vbx3/LrgRBO+TSo+REksg0v2F/0sa35A
	Y=
X-Gm-Gg: ASbGnct5UvTEKki5LbvUa1vagjsBnmQ4t/3htVCN4TXwgjZDphPErEEtcCiI/r2NYPV
	4UPKL4urxKEztbxIJ7ahOMGKVfO04nnExIgDCZQHpvGlhfFXG8fgC3COwiEyyzmaH3tVj4MkCry
	TONpCfRHsM2igbNn6FcjqqX0aBPU8+tVaQhYftFScyhyX3CH/OfUS5fwyqVX2/CmFspOBECVaFp
	YzDd6LSMkiq6UJKMupDj4AWXoegFKBna/kMF6dS6yx5ITOJZBEd6OTiZebjDunzn7HDBV2QFZfg
	a2jxZUjYTkntBas+TAfOTH7W+hTLgIfHP4u/xXacvjvzSX2oxb6Ffytdtu8kqRXPREKQSsnYuy2
	pBvDNMpNp6hxE8iQnP+VIaWPvX4UGoHKrLCQ+EoWuSbMdGyyMKVra
X-Received: by 2002:a05:6214:5192:b0:719:12cf:50ef with SMTP id 6a1803df08f44-739203491camr137707086d6.28.1757429555427;
        Tue, 09 Sep 2025 07:52:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvay4HegD7TczvnDmBbJppLQ/NXiZM/9CH2gAkzzaVEPN2RKdPsH+OPvsw7n0MbNu3XwLaHw==
X-Received: by 2002:a05:6214:5192:b0:719:12cf:50ef with SMTP id 6a1803df08f44-739203491camr137706716d6.28.1757429554861;
        Tue, 09 Sep 2025 07:52:34 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-337f4c90eb9sm38735781fa.22.2025.09.09.07.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 07:52:34 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 09 Sep 2025 17:52:07 +0300
Subject: [PATCH v4 09/10] drm/connector: verify that HDMI connectors
 support necessary InfoFrames
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-drm-limit-infoframes-v4-9-53fd0a65a4a2@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1240;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=GCdbmTwssKDcXNKgdZbInJ/IsWBy3ZWBjV1zBKp4r0k=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBowD8bLgmA9Afor/SCSMBp6lvcMJNLH+y+3RLsg
 Edds4lkZH6JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaMA/GwAKCRCLPIo+Aiko
 1bQjB/wIC+5fSLnstfGoZMGUfVuruiseL2SNqJJstUfTxGaowQkInoHQfnrNqiPYpowcSvPCRNl
 UHnaRFcqNgqF2eWsCXtVaCx10y4Xj3MtGesm0e5fNl/X47wnuZX1RlKVA+7gTnlshcZ1F1PyHq7
 4O3HqSqvwF+066FKwZL94tPSzVrV5ca4n9uB3H4tEJ1CodYONpSf5XEXIbVmBHdBZz6F5Gns117
 nYTWg54k1WItlRdXqTB1OhJ/BoctGr79fhRFb8LTSDBfGG/G7xLshm7FznkSl5DmrmqCsv9fJqw
 58UPBF9WUpSazqCvVhovhZ2tXkAQKvB4Xu+5lsWd/6WbhhXH
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzOCBTYWx0ZWRfXybv+ho5sFlQO
 FeeCvey6uc7TkH7BR0XfreQdGzq71CHJimqpDUJV/XgYQFYG4tsbOLF+8HW6FGTRya3uKdKwH4t
 SqCTqjCS8A2U31viAfe3WdaUVEQWgUXqEujWWMoZlwyYQItzsVwqqAI1V3ZODjJP6uC6SHQDu+a
 BBnV0rDRH0z7SHUjKiDvzeBNRVWcV9dl/YiU+KOQfxaGv9m5nWkIpO5qLicSd1j6J1JD3ZRy8e5
 2++wx6llnBeh1R/UvQcJPoIPElBpAtTRGRaqOWALqVBjah6vsH53wK7xb5YfmJcH3kvi1mHFDp9
 cWGnsmB5/XAwQCbsmKx3Hb6OrqPJon4HBDCWIbCkbRWrcgmTbT1cSdGmXGD/lA8w8Kvn3Cczbuk
 P/5621KO
X-Authority-Analysis: v=2.4 cv=J66q7BnS c=1 sm=1 tr=0 ts=68c03f35 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=QX4gbG5DAAAA:8 a=EUspDBNiAAAA:8
 a=NnPSNIktjdB4Ge1gQTIA:9 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-GUID: SAVjnv98mi5G4w3zjEx1wEnX7R2vaqeJ
X-Proofpoint-ORIG-GUID: SAVjnv98mi5G4w3zjEx1wEnX7R2vaqeJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_02,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1015 spamscore=0 phishscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060038

Check that connector initialized by drmm_connector_hdmi_init() supports
AVI InfoFrames and warn if it doesn't support Vendor-Specific
InfofRames (HDMI InfoFrames are more or less required).

Suggested-by: Maxime Ripard <mripard@kernel.org>
Acked-by: Daniel Stone <daniels@collabora.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/drm_connector.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index 92a75684a0f7375d3a94e8c666cb71064ecc8035..222a0ef66d9fdbdb56108ceeb40e7f369d810350 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -602,6 +602,13 @@ int drmm_connector_hdmi_init(struct drm_device *dev,
 	if (!(max_bpc == 8 || max_bpc == 10 || max_bpc == 12))
 		return -EINVAL;
 
+	/* AVI is required */
+	if (!(supported_infoframes & DRM_CONNECTOR_INFOFRAME_AVI))
+		return -EINVAL;
+
+	if (!(supported_infoframes & DRM_CONNECTOR_INFOFRAME_VENDOR))
+		drm_info(dev, "HDMI connector with no support for Vendor-Specific InfoFrame\n");
+
 	ret = drmm_connector_init(dev, connector, funcs, connector_type, ddc);
 	if (ret)
 		return ret;

-- 
2.47.3


