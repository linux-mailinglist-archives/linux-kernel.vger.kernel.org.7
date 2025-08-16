Return-Path: <linux-kernel+bounces-772009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA4BB28DD3
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 14:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44E811CE0838
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 12:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACEEF2E5411;
	Sat, 16 Aug 2025 12:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XmaFgEny"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E24D2E2DC8
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 12:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755348076; cv=none; b=uQXobFJND09gExwVmEd0B2XwEDiCW171qcWr0VXJBVXEXbRDi1HfOG+WK16CofM74Pwyn4ibxT9uR3bblNiEaEsWMfiCxhrWSko2gzQLExhVKT8bEoBF521u7OUUadlIguLaZbZ+CEPqrL6jh7kG+2duYK7QhZgj0NFGSCmFUPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755348076; c=relaxed/simple;
	bh=DmbRKJHk5oRAB/lPzIwmmFkOQ5dwAtGETzJHeLHHKjI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pmaxCXV9yugoib5HjDKSPRTZHTIvDNDcQjtGAvJ6iJe4l9hR6VisbWd8Ovn39airZ4H8kMUuj8yjSkGH3fYs83Li59O0p0h/zyszAfDvwFQ9qhRLKlqHqYIMP3aqKuyzUkYekx3HI2UxGFFyjT4yPHMkGt8s/h1I/mlbmYStj3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XmaFgEny; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57G6e26v012941
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 12:41:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	g+DN1RQ5iWFy37PJYH5vMr1yt3EhNBuEfrKEgtBjJ44=; b=XmaFgEnygI3wpB6k
	X8YbBP1SJiQ/xkDQkntP14wZ+7biVKQCkNA8IH0We4vdv2/GfwwPzIpsz6fz6ETB
	+O03PMpJ1aMKPGxyCwCW0rd2V5VSoh0mwxrMU3Es4j/hVkSdmoA6JKzq5akntWR0
	OHQUWL6c6JJDrO0EpkdWcViUAgSfX8seGvV9ymg6B0IsCAPDZPMS8/HMkeIxX4zE
	B/LUL6hW/Axr6Dpc6aVb82/4eDVSEICbiyQYqXw6l1H357E/zV6Z4kX+sCeDg98i
	NNSLf1TCdsLsPVHC0lBmMHrHgpSt0GZFhsy7Ingh/1DSQ2zj/TkAHK5Cp6cwyhbU
	8sgcpg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jgxt8qxm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 12:41:14 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-70a9f55eb56so62135966d6.2
        for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 05:41:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755348073; x=1755952873;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g+DN1RQ5iWFy37PJYH5vMr1yt3EhNBuEfrKEgtBjJ44=;
        b=nGC82y0vN4McARF2OIyFwrS5KBdn0VAhx4QdtUU/EtMli95hNH2qn4Mvz5YhMBqiD+
         bPK3ibFiQ0Ytsgusu9PywFCIL2IodomWx9yqP5JLIhRAbf2Rz480n4Ep2Tmz6+4C3j4a
         fLnrKVwcDvw1b7I22yikTWsUEtKRZtG+ZoTJDDVtpYRROzOTKMdWaFuEvB65RdhONQOW
         9OsfbOQWpfcOyBdU+lsA5s8A08lhQDKaUewH9DkM7Bf6ecWD/q+m3tolHY4QhS3EuChL
         3smkvQvc3tJF9XH1bFERSLBAeo6nrWD27OcOp152gVzYUJ0gV6AS77mLYDDNH2qjYcG+
         Hs9A==
X-Forwarded-Encrypted: i=1; AJvYcCV347KaX3/nyhDEoh+y+oWsFl0UVbAQ4nVHVJXQ4fkkEZpD/30XYTQaHcHhnxhHpUZKB3lhBEabezhNMYc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIvFebMOtdgleftkWwxcK5c3hrXGy+ad4tGUKSEikuSIhnJmo9
	N6f5zz81EVv9u0HA9ttnc3rC/mANeM/f2sfW2FuXkZ5XhfdD0FjiZS0A8zNxvxeNe/5qEv5dfnq
	0oVR9gqwMGrQpQBcOdeKsLOLY1WCtRP+SrCDKG5wV/mC4hWe8dsSiitQWDNd/yQ1z5aA=
X-Gm-Gg: ASbGncvLUZJ7GNaYSPmZsiVphSReGDywdDzPlRQPIRDz7uuC378l7RWB5Tc0skI4usK
	Dj2YI2hQpftBzx+WWS20qaH1exuGPdJpQp85vNveVEIm/J6c2wXaYRwsMWJqJzFxYh28p729bhI
	b/kIiZ4MCcarEN1Rf28ziv4jNHpMhBcVHba3B1x08PNDD32+8PZyx7DZ59jOIaEiqg57Z1Mhq2I
	lGhOYD3X3H84ucq4cL28TheGrt1hIEO53CLAOAxD7ofSDDvrTzKCua2ww3f3829B5aHrlLjDJ2I
	KtmDNwuaKg1UUGLHCzaiJzSBukSwoPUfj44yMWLPomiu8Fd0rJtl2j3V7ycKfGHXLI+ui4jCmKg
	2toKtd+9FQAHjJ9wru5Cq4dhmeFi3EwC1FtvM07QtrDShZjtfd703
X-Received: by 2002:ad4:5945:0:b0:707:77be:fc76 with SMTP id 6a1803df08f44-70ba7cae369mr76312436d6.51.1755348072709;
        Sat, 16 Aug 2025 05:41:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFAdZSpkUqvcLouYBz/hMv6ITX2aCNjDHlkgL/LzL/FzF+yIDQWC2R9yzAGQtiDF+Yu7M/Svg==
X-Received: by 2002:ad4:5945:0:b0:707:77be:fc76 with SMTP id 6a1803df08f44-70ba7cae369mr76311876d6.51.1755348072153;
        Sat, 16 Aug 2025 05:41:12 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef3cca21sm856554e87.104.2025.08.16.05.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Aug 2025 05:41:09 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 16 Aug 2025 15:41:03 +0300
Subject: [PATCH 3/7] drm/bridge: ite-it6232: declare supported infoframes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250816-drm-limit-infoframes-v1-3-6dc17d5f07e9@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=830;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=DmbRKJHk5oRAB/lPzIwmmFkOQ5dwAtGETzJHeLHHKjI=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBooHxfulVQQEIFrGQv7TVF5i0bGwohs7DjMO5Bi
 27ClR21i3OJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaKB8XwAKCRCLPIo+Aiko
 1XCZB/4qvtEP/SQNDva3+3vq4krCw9kSzxLGdjGdVw/tgMeW5/3T6SWI0ZXg5Kzt/5ni4P7yvSm
 EDPaT/urG5eS2xX8/WOivyKKxBeSYQv3VWhHqlDBqoOQJW5OkQLPfMBQbHZtIgKoQ7aJCHwTn9d
 HWLCGARgFjYGvtmShrBjydeV4yWinl2EO2WNM0jpELO52mnDHDl/KzegdqSjmhF3DRoNQy600wy
 5K0K6W6ZUvgE865jSkXskg/ayPbsbVVzkYfiqktz3u+K+JXAD4Xf46u7sWS0OI7QNuwI3m5tySd
 nDDSA+Hy4cpHKnNMgVm/ZTHa+IeV4jqqUxQWFvasdgj3YQju
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: HZs8R9zHZYS8KylQDxPMGrBDjerUc-2c
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAyMCBTYWx0ZWRfXyNmsALIX/POK
 ofaTEqon0+SGJQMzxQq8xUMPGBejSbgwPcn2Poq9ecIrDwPE7nHiE/CM3nBWFGk5J0wwEIUnYhr
 xaJAjOXY3A/8+juhdkKeUtho8tAUnjIHy/3//TFFo9OjK1WU/AI0MfNmAwlH0zTVF/BE37SoICz
 tcBiwZjZpp+bpfIhcb/BH4AkJnOA8zOKggXyk1l+mbcMxnnX/yrzw2YyJwH5AVE44HLA+sSBjZJ
 r/QI4Cr92AmAPoH/vLJKxgIPr3opNL/0Wbzspiw9JA94mjm/akatCsWRSA/sOgta08x8vrJOvzN
 AKOLKq7JpBaMY2AFYSDvczoFZVgUx9ALiBjeS6snZzCiAx5xP27u76vpyZKKy6JAenq0/UForvc
 mwMGcFtf
X-Proofpoint-GUID: HZs8R9zHZYS8KylQDxPMGrBDjerUc-2c
X-Authority-Analysis: v=2.4 cv=V7B90fni c=1 sm=1 tr=0 ts=68a07c6a cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=0nAs0j3DZZh6uBALfPUA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-16_04,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 malwarescore=0 adultscore=0 clxscore=1015
 suspectscore=0 impostorscore=0 bulkscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508160020

Declare which infoframes are supported via the .hdmi_write_infoframe()
interface.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/bridge/ite-it6263.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/bridge/ite-it6263.c b/drivers/gpu/drm/bridge/ite-it6263.c
index cf813672b4ffb8ab5c524c6414ee7b414cebc018..b1956891a8388401c13cd2fc5c78f0779063adf4 100644
--- a/drivers/gpu/drm/bridge/ite-it6263.c
+++ b/drivers/gpu/drm/bridge/ite-it6263.c
@@ -875,6 +875,7 @@ static int it6263_probe(struct i2c_client *client)
 	it->bridge.type = DRM_MODE_CONNECTOR_HDMIA;
 	it->bridge.vendor = "ITE";
 	it->bridge.product = "IT6263";
+	it->bridge.supported_infoframes = DRM_CONNECTOR_INFOFRAME_AVI;
 
 	return devm_drm_bridge_add(dev, &it->bridge);
 }

-- 
2.47.2


