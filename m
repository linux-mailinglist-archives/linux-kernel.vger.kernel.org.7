Return-Path: <linux-kernel+bounces-776376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7F3B2CCAC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 20:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83E601BC522C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 18:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D0E343202;
	Tue, 19 Aug 2025 18:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="REYuRK7L"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EDD342C83
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 18:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755629872; cv=none; b=jRgSb9492PbrZ0u/v08jPtLAVpb20oIh3/FZXym5Y2gK/IAhbIaIfp6mh54Ecs+1a8seCjo7rOa3DhFXg6v+thfR/UizvJGaad/DH4TqZ7smFEsBzyKMRDMH2zyZ7panK4Nb+cnHc1DGTyyHMvgOLyojp4vGpLo5mEdcI1sEmOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755629872; c=relaxed/simple;
	bh=7eaknZdIIVgkzyGpeqyWY92kXnNZwGkNmo13tFbwgVk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hb9myyvnEMUcV8qr1BK/JcCyrOGpeAJ+Vz8Po0MtbdcunNq9nEgjZXrVoPBbKZAm3ChdKxZCY14FDYLx0t30tYSAxW6BAI+QP0QuFcX8fc+dq5t+hny8PlVgiQW6oVvCchnSwCkIM8p+N4q/GinCmVkXpCNE+AxFYBf98wuUQsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=REYuRK7L; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57JHXBt8005675
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 18:57:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	g+KCHHTqRR+QvQr7TO6S5/RPZnrNqLEy6fhDbfe+NhQ=; b=REYuRK7LpEaB1jrr
	Ps4bdB3jWVAoC4qC190kXkBmvfnqG6tuHQ5TkcYMSpo889j3DVi5EwJkdvGlgiLO
	tUZcMwpnap8pvBftk7CBGDXOo0Z3CBKI0fqwIT6IJ3UgCCM85AP9SYuaFgCTy1n6
	+pGK5/X9/bbSZdE5KdmSLXVHyJIdM0+CrlfiOTvP0VOmAYwjJMwi3gWOTrjT+O+o
	O4oSIuZTJxrGsokxzPk3IJ3fqG2vPApZEoTtZafmoLNpIORV6S7NilvqzGHbLVC8
	wE6NcKfhj8gpllgVo4BjXC3KkTcbZunp6iqHM9bwQZxN2wjMIr2ltLv5r0ToBMII
	wAVHVw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jh079n4n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 18:57:49 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b109ae72caso157708741cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 11:57:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755629869; x=1756234669;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g+KCHHTqRR+QvQr7TO6S5/RPZnrNqLEy6fhDbfe+NhQ=;
        b=pkQJBAWMrxstyY2OpnsSofuGYidj1zPk65OxJItK9mo8WxOe128FUChC6sVAyXqJQF
         2EB4AVsLbj9bdPcuyGV36tFLIui7MnOcooYf03ozfHrPVWq7pdKiiX5iEXZdUAg74AMA
         3QiJhVpiyi/oCIskU2xRNucgIQPiP2Yfy4yp/bfRiJVoepPc9L07p48VgQgzTLd4yDFy
         +UtoI/jRsQRe2L4S0/6zGAy5qiilGXJfVHZLPtG3sI/tHQLaPDj2fTEoW6HIEp+zLgd/
         4q48fJwAlxlTLpH5TLSF5+EENTx2K6mefFq7pmm6OmNH0x+Be8UyI+LOx9WnE8FSBNw3
         E9hg==
X-Forwarded-Encrypted: i=1; AJvYcCX2mIhTZt8cdegvlm2akETK8/hCwALcz92i9XKIGIN5pGpPv0jqmQrMKqFV1Ierft0mK56mPn1o6+3a7tk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAqmx25rJYHPVUHv/pnhVRgPW4RZE6mdBl5xb9jUYCnkitdB/l
	j3D5ENPd46s1/DBVfYQyCS60fl7JrhElM600Q5kpZ39UKDOQ5bc9QptqC/vVnx70/65zpXwNn4Y
	h3UqiByLUYWiHDck8uqURMMu0khPo68DzadV9pSZrMnz6AvaM/qHGWYtceKuI4YfKBCY=
X-Gm-Gg: ASbGncurkeRe1vaoCA1BcdYISOIVK2CkodxzsNQbhSIwbvQVUYZdYlM/xVRBM2sh3QG
	OlA9XX7f4wDD4bkndL85d4iRRlLZxbu1fgUnTNZZ4csL3L2HIDzupewR5R93a6EsVS2KJdz9d3M
	hO+Q06zGT4T0OeSLBkwbzvI4AmUD3wxw6gb6NbbhgIW1zJIP+LybyjuYrbpRDAGhu6Vs6ckQBfU
	cgBwFpmlgBH0nw8gNKc4BVepT6BTHSEIyF2oZ4M5/YJoK+cwdNalw6Z9/FmFSmo9rQubRWAN23D
	a/DNFwDXhdKoya/mKE6/K79EB/f49o5SF52DNqs4UxrP2RKvn4uKKyAX6kgE123TLiC4oz8dENM
	UV34RasqmulVbc4yyXNiE9iIfoEf3UICOn+cFlkzzxZKtJzJFGYSm
X-Received: by 2002:a05:6214:d83:b0:70b:a525:be29 with SMTP id 6a1803df08f44-70d76f5bc39mr1350706d6.5.1755629868707;
        Tue, 19 Aug 2025 11:57:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7Rup7AhSw4BJ9NwhIDAaqvNpzhK90eK4MaobbpgThtVtwvxC7zzjZweXs4ATCoIwbiBFBpw==
X-Received: by 2002:a05:6214:d83:b0:70b:a525:be29 with SMTP id 6a1803df08f44-70d76f5bc39mr1350296d6.5.1755629868153;
        Tue, 19 Aug 2025 11:57:48 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef35f11csm2207314e87.51.2025.08.19.11.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 11:57:47 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 19 Aug 2025 21:57:36 +0300
Subject: [PATCH v2 7/8] drm/rockchip: rk3066: declare supported infoframes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-drm-limit-infoframes-v2-7-7595dda24fbd@oss.qualcomm.com>
References: <20250819-drm-limit-infoframes-v2-0-7595dda24fbd@oss.qualcomm.com>
In-Reply-To: <20250819-drm-limit-infoframes-v2-0-7595dda24fbd@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=916;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=7eaknZdIIVgkzyGpeqyWY92kXnNZwGkNmo13tFbwgVk=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBopMkcSLkRBvL0pMwSNLmEAMo80IQ6eKzuBYdmQ
 c/Ssrh2nvOJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaKTJHAAKCRCLPIo+Aiko
 1UjBB/0bEDK9goN07vzlvUrx4/uSf/QCLfLAHGPDaDSCPqe7Wl54y4kNyRCy+aLt4LJ3bP6rTlB
 8etPp+lpeftFkzYybXjLoha1F8bnExHGkttCagiyw/qETQUEea62dP6vYL+vczmXkKuzax9ChhS
 4njNZ0Bqe+i226T9H1brFHCpfAvuenLiOkFeu21UGrpXDSa6KvlzbniugRK53i7qR0MA1fdDfwu
 drLueW09uFn5fxOhbe2nFGWXm1I6T2bscZ1qs0XFtT+YcT9AeGuMmIXvMzaJ5Wd87o4kQzA4qQi
 /zKuVtV3uKZfeat3nHuFrrUfMmgch27HUc/CFJvruhmgfCS9
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: fhL0sh26jmws2N_0kmiaz3ZQKFRZ4CMs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAyMCBTYWx0ZWRfX3UCBBZzQbidE
 /IeiFl3gQ8hW469mixaJ6h/v4/LOgUQeFEvBfaJNR+mwtHgSxKdBDZOQr6GlP2cl+3UshCy87zg
 ot5dNV+6ierfAtu1xD9Ls1WjFNeEEP923fGnck6duv/9/IcqaSp/uWS8dDcm85ueQL+wddK+6A2
 WUTJSRojYQPGQ/e9tcKF91nncNNwlw60ZwmPvvbOxA+bvJy9qtHbHXhh1me+gefXCr54ppYEujn
 ln/5L2KTEjcZJQNIZuAf2Xv7zUGdSjkZHrDnspKIfi7uJn8auLLTtNPj3rW6AgFa2NyA5Xlyxy9
 Sr+6I2siagy/62YIcnvINWv2DgUa4VAJeEysK+aOnDKPQlDAJ3xaK2YwJUyN6rnYZAS6U9+yp43
 Rd1WtaYz
X-Authority-Analysis: v=2.4 cv=a+Mw9VSF c=1 sm=1 tr=0 ts=68a4c92d cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=iNCKscWTIkh_2y45CzQA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: fhL0sh26jmws2N_0kmiaz3ZQKFRZ4CMs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 impostorscore=0 phishscore=0
 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160020

Declare which infoframes are supported via the .hdmi_write_infoframe()
interface.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/rockchip/rk3066_hdmi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/rockchip/rk3066_hdmi.c b/drivers/gpu/drm/rockchip/rk3066_hdmi.c
index ae4a5ac2299a93a49f87df7604752f6b651c839c..75bf9a13d8cde1471e8b7e8a8f5f4c0457dd0a14 100644
--- a/drivers/gpu/drm/rockchip/rk3066_hdmi.c
+++ b/drivers/gpu/drm/rockchip/rk3066_hdmi.c
@@ -696,6 +696,7 @@ rk3066_hdmi_register(struct drm_device *drm, struct rk3066_hdmi *hdmi)
 	hdmi->bridge.type = DRM_MODE_CONNECTOR_HDMIA;
 	hdmi->bridge.vendor = "Rockchip";
 	hdmi->bridge.product = "RK3066 HDMI";
+	hdmi->bridge.supported_infoframes = DRM_CONNECTOR_INFOFRAME_AVI;
 
 	hdmi->bridge.ddc = rk3066_hdmi_i2c_adapter(hdmi);
 	if (IS_ERR(hdmi->bridge.ddc))

-- 
2.47.2


