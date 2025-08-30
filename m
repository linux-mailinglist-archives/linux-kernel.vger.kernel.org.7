Return-Path: <linux-kernel+bounces-792589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 840FBB3C642
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 02:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46F655A46FB
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 00:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE5A1E102D;
	Sat, 30 Aug 2025 00:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fyLAuIR1"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1245E1A5B8A
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 00:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756513400; cv=none; b=eVkcqnKDushB09upC6RBCIAe/nzb8lSmKG7R2elPkyVzW2Vq2FxGh5B+f/vaM8c22fu/y76JVCvOvFnTsRvGF9B5duLtDxRZRLCT6yc0btIu84rD8DtuampWgr3mKR0C8+Z8+SlJVgrtiVtg/KryTLG9etRc8Sui4M9wO4FoB6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756513400; c=relaxed/simple;
	bh=/A/l0DP2POBzFZyyzIjBAuem9l4ed0fHlnMMJOHp1Ss=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=evTpAfYmK2GWTbvVf0Xr+xlE7i1U7rTsPbpcDResS6wMyrmgCttrzrsLa1W/1YCwxGDAEGvS1tZwOpp5TVktvIh9VKGbHCTpHQC7qFLQsRJUvXkRAOEFx6GC6TwPUDL6jkexuefqcE8q+Y9dC8/ZwpykVyMb3QRHJ8xGmk9XOTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fyLAuIR1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57TMwTtr025398
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 00:23:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	43JahB/w4Q9qr3p194NSk9uDBkqDfwBgTH71oZZD5dE=; b=fyLAuIR1IcILuZsH
	jXu6O6Tque4rEy2YIcJd6RPskLnjiWIEb9VXBaFQ1RRRXB3BKrVXss+Z5saHca8h
	fTx9wZEvMFFI4CXX18xMZKtM1FEee6O4g427IzKzZfnLQn5pEHVagJ/kYSJeYMC0
	rcOseGW9ufIJtlUNi4HD3Zaj/K48YG94k7GkgD2dg0rcwt4+6xyrqtDegL0JFdS4
	D4fMry66nEU0aNHxptwvqrsoOyzNCTCHtb0cKTQMkn2GedJvvIeiwn7b0WlMth1u
	i2LqJ8buj3UBuTQIsshr2yuD8pxGZKrnZZ86ysanf7BfphgLZ/aZIbD6W3hycpJC
	d2ITiA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48u4xyjj4s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 00:23:18 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b109affec8so54201751cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 17:23:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756513397; x=1757118197;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=43JahB/w4Q9qr3p194NSk9uDBkqDfwBgTH71oZZD5dE=;
        b=XZsc+FlYjiW+zcxRGjRTX9ZU3uDNtZMmphixzxmfVWhEHzb0ziaLtaD4NkboK9DNyN
         ysmIt8aWvvu+qBF6fqNqpkrbK8WKJon2zjllZa17YUojOR/Uk+jjlCWjQRrJ4+sYvOYL
         3YYMNqH4Nc9T7i5zZKO+kuigj4ARyftdOWMsQYcRAcNodF/iKS0+xmvfUIOIlJ2G5X2o
         Z1nxBmt+o6j8Jhut5Z3JcabmZuXImNxRyo5e8Nce/lfJp99eWYmV7ACItDokCVI5LEqV
         VNW3RNOGJmk2ynWt37T1N3D7r4aiBoJtqeFOeZV2WvKD7idEVldgtPrkRqZBgDB/K+/U
         67sQ==
X-Forwarded-Encrypted: i=1; AJvYcCXB9JFTwzHfTosuqAGYY5jvlAntHNYAUI2oBVMTpqTgxm6TyRdNLyZ1TXsRSu92SzUcw1J0nVq8nWm0q+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRihxt7P86Bp5iRKP/X3Uj2S2rPoIAZg1Qnwi5PdgpSaJADRZk
	MQSbzfgT25rIsji9Db6J7DZtD7FUn0nlOU6KwwhAdtq/iit/fnSyuYh6eRWF9WuPKo6QwEus2eY
	x6x5jtAx8w+8H6jF/24tDmi2IDdKWWMHikFjdAoLiL8brDaJOQK0eufL9GCPpZXw6HXo=
X-Gm-Gg: ASbGnctYywFc7ZobVjnxFW4DShSmMA9On1w9p+jMoK2jagZxzrcC95pW89bF99FIrJ7
	MsppgowBKMofc4NCifdWm9Rrjic6pm98FOQNxoL5RsYz/fWZoAuwRpSMuD54rPU3qkfi+sVUqpG
	HDjXo0BMtkfsmvxgLMpNAepPSRSsih/diJqqJtdYPLXU5QGJLKSeVsNuwMZB6bwI5Osi8OOWDzL
	mZJ5vKeWEQnO5FQoACGBo3F8qoEBntJmvZouWvbR3A6AofarF67J2nr+1mBRCG1wbApyLPYVTzg
	KWn9v6F6O5jG2BI2k5nkaxS34EmzPKt0HBhdE3Qmm8rXBHllwa9qHkDJQtqDGtCPQnFcchJG5iZ
	djiqfmZAcGyykkaRKB0DBvI/yhp/hWabW6vVBiU8hT7J/14S0GVQN
X-Received: by 2002:ac8:5d14:0:b0:4b3:104:792c with SMTP id d75a77b69052e-4b31dd03c17mr6898851cf.57.1756513396959;
        Fri, 29 Aug 2025 17:23:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4oJ6O6HUL3QeLNimMJy0MJ4h9jyGyWC0EDFCrFCF4+QEafGCozsLgZkA63r60xpdo27y8Fw==
X-Received: by 2002:ac8:5d14:0:b0:4b3:104:792c with SMTP id d75a77b69052e-4b31dd03c17mr6898491cf.57.1756513396484;
        Fri, 29 Aug 2025 17:23:16 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f676dc52esm1019907e87.8.2025.08.29.17.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 17:23:15 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 30 Aug 2025 03:23:03 +0300
Subject: [PATCH v3 07/11] drm/rockchip: rk3066: declare supported
 infoframes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250830-drm-limit-infoframes-v3-7-32fcbec4634e@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1590;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=/A/l0DP2POBzFZyyzIjBAuem9l4ed0fHlnMMJOHp1Ss=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ8YmlxT5296sO5kLeZM2n3p1M+/z9QjmgHnJS6tXfjsTZ
 fvOL6auk9GYhYGRi0FWTJHFp6Blasym5LAPO6bWwwxiZQKZwsDFKQATOb2Z/Q+H+Z4t1z+UTCpr
 ihGM63rdtftGwUyFjQpvlqzSYNPI4bvaq+/7ZDU3T0azBUvytver33ccXfDWvORvXfD7mddcUs1
 rdH/aTFs4xc1r74unr3IzNjDwTfGbMbPZ58gS530c7UarUzolFvoH+lVVF8XFy2R2N7a8VnnTHC
 T75EnMTp/5a89vdik/E+p7tWh7meDOLXOY2Bs3yhR+11XR85kcUh4b01V8bMaTK3xmvwSmsraty
 zf/m3cqesWWcKuS9a3J4loOd/nvpDOf8xd8VLA277VoHkeaSdYEX4Gq2q41y69v2JuwNbesx7s3
 smeXjsQmySCPlfze9gs0C97zHYvj/M8WuO7ctByN+ervAQ==
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI5MDAzMyBTYWx0ZWRfXwDRNAjjJh+Zk
 HmpwvYGnK35vKM+FrTYJdJLhT2JgYNfh3akvbf+vpCFzuvvPzSF0U89kYgwNlg63jfKH6Nn8ITN
 8NXlZTe+Lx3XQ2WEFJRF4HrFZNinZ+J5v9C4cBkbdkjUsnG4LgqmBUZW+WtAmRt20MrU7AU5NsO
 GHPtUq0QfTL+HM/QBTiu2q6Wtp+AD8h2/YUTXYNfkUimvOXO6AR0NGvJtCIbn+gNItgmH5J1H3E
 F2zbO7rwVIjgN6lrWuIrMzPj7W578UD33NR4Vw8RmFyzBtFi9Q7mFDloK3EezP/wKoPVntkfL0a
 sO++DgG4XEOh5dU3g5ymWghOzMeE5A+kZXRx/D39ZMz/uc8v+KhkQxCEupFvJEMPXFmN0+kkxg5
 fGtsC3J9
X-Proofpoint-ORIG-GUID: uq0EANVaqEZ7kIAmjAj4M8KvaAWgBKo0
X-Authority-Analysis: v=2.4 cv=PYL/hjhd c=1 sm=1 tr=0 ts=68b24476 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=8AirrxEcAAAA:8 a=EUspDBNiAAAA:8 a=xyXfUSUFIH5c4GhWOVcA:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-GUID: uq0EANVaqEZ7kIAmjAj4M8KvaAWgBKo0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-29_07,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 impostorscore=0 clxscore=1015 suspectscore=0
 adultscore=0 malwarescore=0 phishscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508290033

Declare which infoframes are supported via the .hdmi_write_infoframe()
interface.

Reviewed-by: Liu Ying <victor.liu@nxp.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/rockchip/rk3066_hdmi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rk3066_hdmi.c b/drivers/gpu/drm/rockchip/rk3066_hdmi.c
index ae4a5ac2299a93a49f87df7604752f6b651c839c..330c3e6ecaaca1602aee497c1a1be9599d1f886e 100644
--- a/drivers/gpu/drm/rockchip/rk3066_hdmi.c
+++ b/drivers/gpu/drm/rockchip/rk3066_hdmi.c
@@ -164,7 +164,7 @@ static int rk3066_hdmi_bridge_clear_infoframe(struct drm_bridge *bridge,
 
 	if (type != HDMI_INFOFRAME_TYPE_AVI) {
 		drm_err(bridge->dev, "Unsupported infoframe type: %u\n", type);
-		return 0;
+		return -EOPNOTSUPP;
 	}
 
 	hdmi_writeb(hdmi, HDMI_CP_BUF_INDEX, HDMI_INFOFRAME_AVI);
@@ -182,7 +182,7 @@ rk3066_hdmi_bridge_write_infoframe(struct drm_bridge *bridge,
 
 	if (type != HDMI_INFOFRAME_TYPE_AVI) {
 		drm_err(bridge->dev, "Unsupported infoframe type: %u\n", type);
-		return 0;
+		return -EOPNOTSUPP;
 	}
 
 	rk3066_hdmi_bridge_clear_infoframe(bridge, type);
@@ -696,6 +696,7 @@ rk3066_hdmi_register(struct drm_device *drm, struct rk3066_hdmi *hdmi)
 	hdmi->bridge.type = DRM_MODE_CONNECTOR_HDMIA;
 	hdmi->bridge.vendor = "Rockchip";
 	hdmi->bridge.product = "RK3066 HDMI";
+	hdmi->bridge.supported_infoframes = DRM_CONNECTOR_INFOFRAME_AVI;
 
 	hdmi->bridge.ddc = rk3066_hdmi_i2c_adapter(hdmi);
 	if (IS_ERR(hdmi->bridge.ddc))

-- 
2.47.2


