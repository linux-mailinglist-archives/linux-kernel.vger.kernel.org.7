Return-Path: <linux-kernel+bounces-874076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18540C1574D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 563C13A7B80
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 15:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A4D342C8E;
	Tue, 28 Oct 2025 15:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BVMbOC9D"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE4D3446BA
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 15:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761665235; cv=none; b=ag/3r0mWhgnCRnccjKV21/DSiFu9f85dkYKFOV09U+pqYGV9Cfu6+D8vL3SqCLH0F1pc6eEBqUd0z/16ddMclW0O5Y1c8tgzfq7pl4JMjvnvdWgjcHIgc+i9pheBGlXitUHiJLuDggLwG7AgsenSIG2/Vr7n3V3SsDT0Tk51ALg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761665235; c=relaxed/simple;
	bh=HYWjIFO0ntFquQpHN0l24OI9KvjX8KR7IgwrgsomREE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uWWWK+Sm0dCT0YVM8DAooLIxnc2+0yk0Pcly6hmhBoIWmlTiaxNXR3CXK6j0E1AVdy4xNRlb+6Pk/fhgrJJOCy8V0E6qVzxYEpqnyYR6D8jrOkOWRMlzpmYn3ilodi6fNFbFu2GozSQpGms4D4i3v2s2G/EytidJ2Bpg0lwB61Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BVMbOC9D; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59SEneOK1886249
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 15:27:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UGyfXeVKPbjgWlb4WeAZcL6J+OWf0aILgFM3g8oL4Ko=; b=BVMbOC9D3sepW2Gz
	QyriUPQIx6YZ6mfqu0R1PdP/cL6ilQ8O4sCloBogVKj6tivSpKqc0oongrCfRTQU
	ocpuN3XQFe9IB99fZEqxSiTeBsrA0nrLVJshw/d0DNtRvRrZw4NSDu+ULWp/aGcA
	MHKGBk4WhzYAlAFVUdfzZ/TF0vwYI0l34er+RN+5qhgTkxdA0HUZkVZA0WoSqio8
	rMWsTqon1Xxm/CfIszUik6zce/LcppHe/HzE4vU0fIwcubkYf/r9dkrrqNQpNjp2
	zLLxPbY3H5bBMs7XgUS9ygtqJyLUalKWttOOTQu7bGFL/NnOCsGiDZhhSZlQYUau
	kYhTzQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a2xxj0bue-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 15:27:13 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-294a938fa37so66761385ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 08:27:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761665233; x=1762270033;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UGyfXeVKPbjgWlb4WeAZcL6J+OWf0aILgFM3g8oL4Ko=;
        b=qRH5Xu2bEa57QPncV3elpWQJA2bqzsk62ei7C58MFLL4YYIG30F67VzCYWlMdZlaT7
         5yCPhH3Av3a0Tm72qxt43tx97Jb9GJE1Xv74ZfrmKBx2YD/3BZZl0nF0C9O8z798YS4a
         SnME4rcEjmmnhYD3w3bemieGxonGKVWBJpUHtbHYk0D6Tc+wkZVBOwnLoTyYXIAOstc7
         CBU7DZVtSStbKqjfITZzWyVVNMQ13ClSS02UhDWmA5h0R++vWB23n94Ho6SZSjhTNcjR
         g53dROVBlqCI/q9xD85blWbQclHBs/Pia0au9K018t8V2BbuqsC97lHgoHAuJq4U360s
         O61A==
X-Forwarded-Encrypted: i=1; AJvYcCUgPP1GwMJ4deP7BvPag6cjSYIby92oA3j9+K0r57vcHeH8UsSudRjbgiCOi3fpmFdmspqmr/0nR7xxyZg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywkc9748xS0UE0i0kvca9eDvBKvmcfiCsbzlC1tsqdh0pJMToLQ
	vLVaivtRUdNN0pkyRD6WNQ6u5jIchv8dgl10dNqUcTvOBOAIdwJMw+9xaQ2WP9awgOUQDQrlG0p
	RwxLoj2QSMD+XMhJS+Fx+LlftxjLhPRdEkiK9CHLk3wyTwImnN/aCK+kemojJNXRCO3Y=
X-Gm-Gg: ASbGncsp2xFjJ4GYxea7PM5L3g85SdRpF28L94yb74Sd88SgVqP4UM/mB1EAA0+uq1N
	Frdufnbgo2L4qTd+G70G2KMSEynJICrlGIF0T+DG5WDNmBZRHG6qRpeXa14LtkT61GMegYqModM
	mpXGkVVXvEeGmBVj22nrCBpZETL45PXqxCjbBne8JqHdQ5wS0ZAFQmJRJWOl/XJGkudvk1h4vLo
	DO702WX0zqnQcURSXKo/Qfipb7opid6JXAzomh6Lyjpcw4WuJz5vvSW1qo+QvTnckJ8FjU4K90C
	fCHRkJ9rtLvdGlqavvQzydjis/tdaTgzrKYuNpD1bWqzFYUmE1PjyFSfnBApmY4Tdf1/6Rj3do8
	xe5M2YqmNK6s5s+L2mG4b7OXENBHqEBCOu3U=
X-Received: by 2002:a17:903:1a07:b0:294:cc1d:e2b3 with SMTP id d9443c01a7336-294cc1deb8fmr41726675ad.38.1761665232859;
        Tue, 28 Oct 2025 08:27:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE14cBnmetdTEvip2AiuMPqbNocEUBhwvIQ30b1DCC6u6VkGqRobEtLNnL3qD4nV422vPonug==
X-Received: by 2002:a17:903:1a07:b0:294:cc1d:e2b3 with SMTP id d9443c01a7336-294cc1deb8fmr41726245ad.38.1761665232393;
        Tue, 28 Oct 2025 08:27:12 -0700 (PDT)
Received: from hu-vvalluru-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498e4113fsm119490755ad.90.2025.10.28.08.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 08:27:12 -0700 (PDT)
From: Prahlad Valluru <venkata.valluru@oss.qualcomm.com>
Date: Tue, 28 Oct 2025 20:56:50 +0530
Subject: [PATCH 2/2] drm: bridge: add enable gpio for display-connector
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-enable-gpio-dp-connector-v1-2-2babdf1d2289@oss.qualcomm.com>
References: <20251028-enable-gpio-dp-connector-v1-0-2babdf1d2289@oss.qualcomm.com>
In-Reply-To: <20251028-enable-gpio-dp-connector-v1-0-2babdf1d2289@oss.qualcomm.com>
To: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Prahlad Valluru <venkata.valluru@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761665215; l=1210;
 i=venkata.valluru@oss.qualcomm.com; s=20251028; h=from:subject:message-id;
 bh=HYWjIFO0ntFquQpHN0l24OI9KvjX8KR7IgwrgsomREE=;
 b=kZQ9dNvz5d07r2JVyT+l2SWfzUBeDR2/1r/VFgKtBPVDb02OA9jts1ZxG7kCK/+gfgkviLY6x
 tisl04gG8v4DpK/GIpDS7QDZ7hU6OoMaoKF1xlsuWnAogLAJTOP8PYh
X-Developer-Key: i=venkata.valluru@oss.qualcomm.com; a=ed25519;
 pk=KEpJdy7/I8HDmNSf6B83x+sFHUNr+mjMNJ2qe4G/zXI=
X-Proofpoint-ORIG-GUID: uhrtVP37LT6BahHd2y1b0Ycy6mUZdNyM
X-Proofpoint-GUID: uhrtVP37LT6BahHd2y1b0Ycy6mUZdNyM
X-Authority-Analysis: v=2.4 cv=UInQ3Sfy c=1 sm=1 tr=0 ts=6900e0d1 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=aOUc1jQm1-AEEL6HbbgA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDEzMCBTYWx0ZWRfXwQvJjuCZJ5gc
 Y6xk8iVEHBdvJmNPKmDbfHe4PnVHEEyLUJUSUU5vQ3I4Y53iq5teMRsZp/BxNKoBeZda4hHltzA
 BMUEJAe2TRUiYXRDTXxm+MsbKdyUqR91udcmdTYBcE3GtElzMD5udTRFxikuKRFuZOmhEblQ7xt
 avn6ImJ8iXZDPN8dNhN/Lsc2E8qdSStaAh4yXxLdBfRG8Cmx+6iGZ0FDr5/mRZ+KzDKb5CY+N5t
 1SZqzSygtTSD1+O6X87c3H41RrhnExlQ8+nL2aOYENEmUhdrIktg76YJ0UtjzRDpr2vwut4qOQC
 tF8Amhf/FwO0Qgh8Bxj/dPAOzTLD4rpPBJYnBxFECrh9xEZODl4daxdnVe04YFXU7DOFCAEzfrJ
 UvK+7XikU/Dta5PwzozmtxiXey/uFQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_05,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 impostorscore=0 suspectscore=0 adultscore=0
 phishscore=0 clxscore=1011 lowpriorityscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510280130

In some cases, need gpio to be set for the connector
enable. Add optional enable gpio to display-connector.

Signed-off-by: Prahlad Valluru <venkata.valluru@oss.qualcomm.com>
---
 drivers/gpu/drm/bridge/display-connector.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/bridge/display-connector.c b/drivers/gpu/drm/bridge/display-connector.c
index e9f16dbc9535..52f5e4175e64 100644
--- a/drivers/gpu/drm/bridge/display-connector.c
+++ b/drivers/gpu/drm/bridge/display-connector.c
@@ -21,6 +21,7 @@ struct display_connector {
 	struct drm_bridge	bridge;
 
 	struct gpio_desc	*hpd_gpio;
+	struct gpio_desc	*enable_gpio;
 	int			hpd_irq;
 
 	struct regulator	*supply;
@@ -298,6 +299,12 @@ static int display_connector_probe(struct platform_device *pdev)
 					     "Unable to retrieve HPD GPIO\n");
 
 		conn->hpd_irq = gpiod_to_irq(conn->hpd_gpio);
+
+		conn->enable_gpio = devm_gpiod_get_optional(&pdev->dev, "enable",
+							 GPIOD_OUT_HIGH);
+		if (IS_ERR(conn->enable_gpio))
+			return dev_err_probe(&pdev->dev, PTR_ERR(conn->enable_gpio),
+					     "Unable to retrieve enable GPIO\n");
 	} else {
 		conn->hpd_irq = -EINVAL;
 	}

-- 
2.34.1


