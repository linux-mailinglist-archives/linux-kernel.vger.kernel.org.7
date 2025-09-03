Return-Path: <linux-kernel+bounces-799080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD88B426BE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 18:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8679682312
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 16:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF452C0F81;
	Wed,  3 Sep 2025 16:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="m2Gb7edX"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9482C08CC
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 16:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756916496; cv=none; b=OQgUG7c/nYPX+BSeVWeCP2FfOSprro3JnDKmccWJDOXBsIHAd82OnL9YASK6tCAOXewUx8Yj9QhpOvSJqBP1bUA+dOJKU7vawz5a8l3YL961Bk5UMPUvW/aCX4OYhf6+AJX0hJirIDl4bb2vO+5J7313O3cKIeeTs8r9zPMVCBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756916496; c=relaxed/simple;
	bh=pir/G1LGNErUNeDZyuevq3mx0Sxb/EfIMpFh1snKzdU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WPYT+py/7pFWHOZczltLTOEue2k/r0iq9w+VEJuD/yMHFj8A0vtvMy8fT7zRyTMntcApXKgAKlfI9Dta5IJBRhznT+gLnX4SDUW4MgWWY+ePqkVjChoEb/w5eV4ngB1IC0FWRC9xrwxISMQatkG4GaQMv9cH5rSaUq2wJGCo2kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=m2Gb7edX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583Dx18H005455
	for <linux-kernel@vger.kernel.org>; Wed, 3 Sep 2025 16:21:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Wx+UlrREb+3/RGIeIiUTNYYx077VW4T/hjO3EUFT8ZU=; b=m2Gb7edXXVao1k5J
	t84qWBU3WppUi6waOTqqsCXrxGeebyHuJGhr3VMWGyiAsGsUaC8FUvVHxKVIi1IN
	RIsQy71NPm4UrMQjeXv923G+gnWgrIDpogDSg+zDHTCXDhMDaPlUu6SqGZeRjLEe
	3iBEDlEvg+1Ym2BSAQhJmrb9jz7+RDsoMDEth5Nglv2TThbXNg3BXAjvXgn2/Oa9
	mWcUKh5FyLiwW/JVVzN6TA3QlmrTBWZ7lJu+kPHwkqc343RMNczeLBndNLHBgQEc
	geoEhOUNhJBG0GU1GBtcgzaVAvvwrYcdO9gF5OJ0RWw4iZzbW9HNCf2TE4bkKGjn
	mr+jHQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urmjmatm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 16:21:33 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b4980c96c3so2676001cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 09:21:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756916493; x=1757521293;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wx+UlrREb+3/RGIeIiUTNYYx077VW4T/hjO3EUFT8ZU=;
        b=U0n2bE6A7X34Nio04cWt12s6/YDFB8WGUIEnPstTY2oKCKqkqqiUIAzAI43B0ds5dv
         K4yGdXZkECl7U2WuTsLz88ZCIdX7L9NdozOW6Bi5+FAOLmEmYRYuP9i8u6LnU4cDV55v
         TEbobwHKbCbBMjnf5ij+KnF6ZubMfYzcORtuVHdsct7+gbNNpxSak4qd/g2TNIKRyBya
         kk523G2FSMt37nVPs5M0RzjDPcUZP1XujHf2wYXMyWr3p8ikPo8pQJt+8SbiUzb39A/M
         8e9dZMGQg5umx1pK0JA//9h1g3825nOkOgwLsbU8iWfPRHteVvySA5lwdQSl2VH9Vtyc
         LOjw==
X-Forwarded-Encrypted: i=1; AJvYcCVLWiBJNm4uyqu1J/Kv6ycHwwLeSKdL01iuKM4pr6bjSudStTXPf58KWUL6aRMR6Qb3IXE4ppgUcwNFOXo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5KrH2Kt0VyB8qJuO1O/ZlkmwQjnIE9/ohTETDp8wLXly0dP00
	55YAYNQ/8nBUFp5RbwgVdk8/k316vm3pBBOBWU+j4XFkSeiAUTZIWh71oo3HT9IbaBLeWHaFi/O
	YPrhmkGXU/b8Oq7TCuYc60V+/Qxdx/NIN6mbouYqB55MFt/r//MWGtlDWj6aV4hFcO1s=
X-Gm-Gg: ASbGncvhSwiVaJYGMlz+1NkpEM2Eoq3w55FH6FtgQFZe9oogbiieOc7LF/uhptWSQCh
	LCKnroWXgVmdzJunq77S7BIg+VZURrDYx0gAYT1rDUyKhkbtuqAaI4r7mJCALVDpMZ0dtVULP/q
	0qtGsbQw337Kwe/MZkGqJI3nKq9MmKEahvQeOnLKxvq4YuvFpxPQL7GNIk5OeSr1DYc30YCqNRu
	51FoYFMA8sTPr88VAx/ZFk1U+uX6uD4/LpOKfLsa05/YmYYFEpeR5R7dw+DHgJLrPCkN//hnBEq
	oPTfwwSzZxtEsr5X1ptU9S51i69VAvGCjAeYTc5rk7rmyPX7+4QVglJqk0tV3Zqa79Cj6rNluuI
	GSf01U4AnfR9+Sg//DWj8Jg8g2YSnoZFPa1gGg/qLBN84QStY/Knl
X-Received: by 2002:a05:622a:a953:10b0:4b4:91f8:3b13 with SMTP id d75a77b69052e-4b491f83e49mr28314121cf.63.1756916492640;
        Wed, 03 Sep 2025 09:21:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEf6v1CkiSW8hvYYfOCZ0HKs9HsNljzMwkvZJAirl8aFo4JvG2SUM6RV5X1TbJS8z39V5tUyg==
X-Received: by 2002:a05:622a:a953:10b0:4b4:91f8:3b13 with SMTP id d75a77b69052e-4b491f83e49mr28313681cf.63.1756916492082;
        Wed, 03 Sep 2025 09:21:32 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608acfc24fsm608343e87.104.2025.09.03.09.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 09:21:31 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 03 Sep 2025 19:21:28 +0300
Subject: [PATCH 1/2] drm/bridge: adv7511: use update latch for AVI
 infoframes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-adv7511-audio-infoframe-v1-1-05b24459b9a4@oss.qualcomm.com>
References: <20250903-adv7511-audio-infoframe-v1-0-05b24459b9a4@oss.qualcomm.com>
In-Reply-To: <20250903-adv7511-audio-infoframe-v1-0-05b24459b9a4@oss.qualcomm.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2179;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=pir/G1LGNErUNeDZyuevq3mx0Sxb/EfIMpFh1snKzdU=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBouGsJ/rUjjvcobAYlgYl9D5anTzOit4VXG0+Vc
 F4pvuMitKmJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaLhrCQAKCRCLPIo+Aiko
 1cyvCACHQjt8qQi+bCnWmNxVD5VJ87xL2pZs6Jrqd8wrltjqGVQc+M+lkfjFUFPtLzrCONN9mom
 5ViUqhdpz00NDmJqvF7VjTXXzjr3+KFtSjEf/p6ua0VnpPVviOYwTVCfJhLGDyPLk1QLaHVfVri
 4ZS0Pa2oOnbvM+p679TsCppO6VQl/1/FsNMoIG1R11N5mTGq/AuDlIOAHCL00DMHGRfsgTmL+Il
 cb7sxF9nDz6grWFYi6Mz93JmwcpM5TRckWJ1HIlEadX/HfNNNrSR+zReGR4b9f6DH59TJ28Gnsj
 LmQoKQSuGfUIPA1DOECIyhMnM7Xqa4EGRRIh84w5KfagAc5B
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=OemYDgTY c=1 sm=1 tr=0 ts=68b86b0d cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=CjEKKNCaXEvhkZk4MagA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: njs4o40_FhdZFm8_6Jm5WBwGA1_6UJnk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNCBTYWx0ZWRfX+XZkHEhiRLds
 QkC3MDLUNQ+8zENDosSMgEpiwanNwuonAunFWrSGeJ+Zw3GiChED0/tF1EOZM+XHO7FXN4X9/Wk
 N3zaQ5K4wweoo4V4T31Pw3TDjx0lU3IOoTFThxF9nZFL4Lsmz3zPhFJAy6o1JOvAiIEnxuuPdu4
 vspKxS8VNCiJkbux+gE5cC2y7+aOLSeOoCbUWr0yNLCKjozFIFnMoYTj1z8D/1j/NxxgAXO/6qZ
 vbHlw+pUL/BRJadUnha1iBUjKtY9HA7gqFlUC5qedrGMGyVDxfaUs6q/4Js+OKg5+i5ubpgpSdB
 lLmkKdoeKfu97N0J1hm2cLIfBYF5IsLg3sTxhnt5mJhSnKYUnzTeYfkZy2+MH0QvtGPmcj4ibvX
 xbdGr+ve
X-Proofpoint-ORIG-GUID: njs4o40_FhdZFm8_6Jm5WBwGA1_6UJnk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_08,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300024

Instead of disabling and then reenabling AVI infoframe, use the
recommended way of updating it on the fly: latch current values using
the ADV7511_REG_INFOFRAME_UPDATE register.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
index 26f8ef4824235a9a85b57a9a3a816fe26a59e45c..26f8310382d8d1632dda5185b2b0230b59a6063a 100644
--- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
+++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
@@ -916,22 +916,33 @@ static int adv7511_bridge_hdmi_write_infoframe(struct drm_bridge *bridge,
 {
 	struct adv7511 *adv7511 = bridge_to_adv7511(bridge);
 
-	adv7511_bridge_hdmi_clear_infoframe(bridge, type);
-
 	switch (type) {
 	case HDMI_INFOFRAME_TYPE_AVI:
+		/* send current AVI infoframe values while updating */
+		regmap_update_bits(adv7511->regmap, ADV7511_REG_INFOFRAME_UPDATE,
+				   BIT(6), BIT(6));
+
 		/* The AVI infoframe id is not configurable */
 		regmap_bulk_write(adv7511->regmap, ADV7511_REG_AVI_INFOFRAME_VERSION,
 				  buffer + 1, len - 1);
 
+		regmap_write(adv7511->regmap, ADV7511_REG_AUDIO_INFOFRAME_LENGTH, 0x2);
+		regmap_write(adv7511->regmap, ADV7511_REG_AUDIO_INFOFRAME(1), 0x1);
+
+		/* use AVI infoframe updated info */
+		regmap_update_bits(adv7511->regmap, ADV7511_REG_INFOFRAME_UPDATE,
+				   BIT(6), 0);
+
 		adv7511_packet_enable(adv7511, ADV7511_PACKET_ENABLE_AVI_INFOFRAME);
 		break;
 	case HDMI_INFOFRAME_TYPE_SPD:
+		adv7511_packet_disable(adv7511, ADV7511_PACKET_ENABLE_SPD);
 		regmap_bulk_write(adv7511->regmap_packet, ADV7511_PACKET_SPD(0),
 				  buffer, len);
 		adv7511_packet_enable(adv7511, ADV7511_PACKET_ENABLE_SPD);
 		break;
 	case HDMI_INFOFRAME_TYPE_VENDOR:
+		adv7511_packet_disable(adv7511, ADV7511_PACKET_ENABLE_SPARE1);
 		regmap_bulk_write(adv7511->regmap_packet, ADV7511_PACKET_SPARE1(0),
 				  buffer, len);
 		adv7511_packet_enable(adv7511, ADV7511_PACKET_ENABLE_SPARE1);

-- 
2.47.2


