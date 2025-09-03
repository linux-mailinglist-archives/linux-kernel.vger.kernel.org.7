Return-Path: <linux-kernel+bounces-799081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE6BB426BF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 18:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C88158303E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 16:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4AB2C11F2;
	Wed,  3 Sep 2025 16:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="o3fT6hQB"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6098B2C0F76
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 16:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756916499; cv=none; b=YJnr18Cqg4LVdp+BtMQCMjOD/hp3ld02lP2EVNA1YnTXQQ640liM7Btk+OaO3fdRa4Q7xu/4Oyl8QF7dAv5ZwMadKVu2GaY3Da40BKvK4buPf2w3F/+9ou4pEjDPSYzYEMS1wJHcpGUfUYZbOPcAPdjoru0trTeEzxNDbmO48FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756916499; c=relaxed/simple;
	bh=5y9/LOX9VXnUof4KCobvcMPKBNq7SeIq0vgHO1bIvFk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I+I42FL/anJF+X8k5/wovPNgAL843+miiLgXpJ4XD3ZOcRcZhq1DsB85ky/FatSWoB9LyPkZdPspHp48dXLWUcmkLFeGiJTWms4fQMPLDVjL8mSynZ1I1OL8IFU7VmSVPHLFdnHH69Dk6VJleWXfgI5o9W1tFc2Harlr93RJHPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=o3fT6hQB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583Dx8k6030172
	for <linux-kernel@vger.kernel.org>; Wed, 3 Sep 2025 16:21:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WblTmxyDjkY/Gy6Np0QzctOFtRv2wJUtvij+J2fOPmM=; b=o3fT6hQBKDarPClj
	xKlKuDA1F99ReCeiSW5x3LqlBxMymbxP0+1ZsVAJJQmVdWQ5VQ9w3MmscUQPeWDM
	B9kfuuEIKtRbngubHPqtyZGbdakP9D+wcBOcenHEboo1JB+rYf0kBiKeS1GDMUPL
	XRgswhtEoXWLZS2RAlArSLmNeyf1I+9AU2bitWgOC4UHdj3LaUN2Ri9QR0sc5Eca
	9d4SVxQ6uFTv/YbH3gSizr2i3ml9QbMnzPsk40pxkP8MBdV/k0AlWNVExWV7bcbh
	Hziui7zSG4Mj0bKst92JRGjhQXpPL4TvEPFZMp6CR5bGYv8qY7/Clxp2jXKLu6WF
	eQmu2w==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48upnpchku-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 16:21:36 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b32fe42b83so1660591cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 09:21:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756916494; x=1757521294;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WblTmxyDjkY/Gy6Np0QzctOFtRv2wJUtvij+J2fOPmM=;
        b=kOv2/Yqcg/RcVG+oXcLnkTR5bgdnSweVy+8BG+YAMzuM+l9CyWs37tLr2M9A4xVJv/
         IpT4XcXn4C+9R7jjxvotie3X7gRziIdIqnZilST01wf12sEeM+lX9o9U9v5WF4RUVZ+3
         +RXn62szGlRP2RIC/1G83ZlDp3M7c2K9HPMOg6nDqttvyF3LnZzAPZ32YDo/jiQbBrKb
         nFrtNdU8DsqYlOO1ZQvDDlVh+ORfCvsi29iluR5d2fIyodx2l/wsW+OFzsQMEtiFJlVw
         eHVDtx4U/P1/raHJL12QqKsDNsbVbcLMPQXxEBYgNdXmvmSa5NhRUuOO3LnJdvxjTryx
         O6/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUcE6e6FDXB8X1VQul0lHgfybzwzFNe/f/z5EGi9a3ixb9dsvSlS/Lv7zgQ0ONNlwHelH1cFROQXBDUu9I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIEc8m8MP29W4Laq1u0hqQYc3HbMJMkNr+i+5Z7trhNAxB13HJ
	mScbtVHp6EidkdvLXBaDMfAHTks2giruJ+Jr8TxxSncKXda/MNm2TJWJ9vb1IeU26FmWMflGlq3
	j5dcd65gl44isWkaBtU9/dnW9PEN4SCGoXAhaiESCN7/3Wxymk/SwBzH+Q/WA4Zlriac=
X-Gm-Gg: ASbGncuvgBrmixmiTIoKbX0huvyHwNPBqJalpCVxqtNbl2ldESTPMay7gRDfEQPDeAn
	EMcCJNWt0KWHqFf4cF6Sd8JKeMGxT36zF2jYdqK8Vap1AbgY9OhVfZRhgQ+ymLTZoCyPX77ltOq
	wkrNE/peeOPMxaPhIh2j0G8bR4xs5Hmp+e92KWYub//uVb161WtwlMSR+sJJ6irK2kvcaVAYbph
	ESegC3rCrD9d0e+goZ9IWBPNOkImoL9iXne8XARrTlK82ECZJ2LZLlblIz6n/FiScxP1cYWrVsa
	8yS53CbRrwOofrSuU2GSFGtFRmFQT99dWc7Y1VSCfstzHQNfaj8d0iP6gxvlPs6QUzl14r0ANEj
	RVDOGA2Qy1YKi4Xl6RCNi46zTK20s3QAKOB62nJpkqZUrjv3MAmFW
X-Received: by 2002:a05:622a:4207:b0:4b0:8633:f979 with SMTP id d75a77b69052e-4b31da18e7emr190317601cf.42.1756916494128;
        Wed, 03 Sep 2025 09:21:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGH6zK6ssgJ2R6k42L+9KHbyZ0IHREZqlNOx6b6c/oWVi7dL5fUo5H5X1oTc/ZVSF9H6KnihA==
X-Received: by 2002:a05:622a:4207:b0:4b0:8633:f979 with SMTP id d75a77b69052e-4b31da18e7emr190317081cf.42.1756916493380;
        Wed, 03 Sep 2025 09:21:33 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608acfc24fsm608343e87.104.2025.09.03.09.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 09:21:32 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 03 Sep 2025 19:21:29 +0300
Subject: [PATCH 2/2] drm/bridge: write full Audio InfoFrame
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-adv7511-audio-infoframe-v1-2-05b24459b9a4@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4464;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=5y9/LOX9VXnUof4KCobvcMPKBNq7SeIq0vgHO1bIvFk=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBouGsJveN4HLdRJ8IB5G8+U9Lh400HQd/qR/T00
 LyCEoIaB0OJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaLhrCQAKCRCLPIo+Aiko
 1fxGB/9i3ZzB7usHFqhtwX/AFclaoIjm5lOEq0SjPg3IatQhhYWvXzUKoJgIEx47Ly+sY9XmZG/
 hvVqt0r/1SC1x1ib/bAkJEMBmm+8WBiufKY5J9ox3ne5zMhVE+IO/yF3FfUsdvJBFCvRoX+fySk
 +gOI4L9aTx79Rg+rfgkgManrj+KUMN+Rx44s3IdvccpLMSNbRUe+YOqxQlbjPErz1bTsjJZzXAN
 VCFJD/j6fJDooSxe8URS8RX0dhojc7T+kqRjhf50oG6S07TVCK4hueuZrLiJgSiEVaNEOiN7t/7
 oh4av779flz+47IRLbqZAGwaH8KTc/SK2cnfWHxD84KNa5Ky
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: _d2fdZyftz40d6ajI2OOnkm2t15GSQOW
X-Authority-Analysis: v=2.4 cv=Jt/xrN4C c=1 sm=1 tr=0 ts=68b86b10 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=hApPcyOduhRKQ7iII6kA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: _d2fdZyftz40d6ajI2OOnkm2t15GSQOW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAwMSBTYWx0ZWRfX5xKBpNCdft9+
 /CX5AiBebqr4X+sElaVMZ2jtXeCIU/9eNw9ua8Or3PyYg3XRoDXw8RCDIDk+UjI4uAXNczjt/9E
 ylQCslrCJS6BHtPSG+9JqpwgISRqbw/4Hgv1ikVfQZLL7TV6cIoH0mK8DdgmrMOPK007oIoNv/R
 mDxFGPt39J7M7WsuI7GxDQ+Mlv8pPitdpOMmSOp6qKsXPtxiMOpN0tmjFkxSUzwJFKGX3zb8f4Q
 bUqwFv6F//UzQWEboy+gPANvuAgfYmioEjaGomKzufrH5L2oL+JXBhc4yv9aIYMRchP39ythyUV
 KZyEVyM2nNUSFF8P9YevITW3LkDbRZGk3yqqgU1qHRcU7Bjft9gr9C8bb0CqaFJYG5WH/dUb0MC
 XOUrzygJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_08,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 impostorscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300001

Instead of writing the first byte of the infoframe (and hoping that the
rest is default / zeroes), hook Audio InfoFrame support into the
write_infoframe / clear_infoframes callbacks and use
drm_atomic_helper_connector_hdmi_update_audio_infoframe() to write the
frame.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/bridge/adv7511/adv7511_audio.c | 23 ++++++-----------------
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c   | 18 ++++++++++++++++++
 2 files changed, 24 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_audio.c b/drivers/gpu/drm/bridge/adv7511/adv7511_audio.c
index 766b1c96bc887d228492cd7ab0d61094590fa876..87e7e820810a886af8e899410c51e729200f3222 100644
--- a/drivers/gpu/drm/bridge/adv7511/adv7511_audio.c
+++ b/drivers/gpu/drm/bridge/adv7511/adv7511_audio.c
@@ -12,6 +12,8 @@
 #include <sound/soc.h>
 #include <linux/of_graph.h>
 
+#include <drm/display/drm_hdmi_state_helper.h>
+
 #include "adv7511.h"
 
 static void adv7511_calc_cts_n(unsigned int f_tmds, unsigned int fs,
@@ -155,17 +157,8 @@ int adv7511_hdmi_audio_prepare(struct drm_bridge *bridge,
 	regmap_update_bits(adv7511->regmap, ADV7511_REG_I2C_FREQ_ID_CFG,
 			   ADV7511_I2C_FREQ_ID_CFG_RATE_MASK, rate << 4);
 
-	/* send current Audio infoframe values while updating */
-	regmap_update_bits(adv7511->regmap, ADV7511_REG_INFOFRAME_UPDATE,
-			   BIT(5), BIT(5));
-
-	regmap_write(adv7511->regmap, ADV7511_REG_AUDIO_INFOFRAME(0), 0x1);
-
-	/* use Audio infoframe updated info */
-	regmap_update_bits(adv7511->regmap, ADV7511_REG_INFOFRAME_UPDATE,
-			   BIT(5), 0);
-
-	return 0;
+	return drm_atomic_helper_connector_hdmi_update_audio_infoframe(connector,
+								       &hparms->cea);
 }
 
 int adv7511_hdmi_audio_startup(struct drm_bridge *bridge,
@@ -188,15 +181,9 @@ int adv7511_hdmi_audio_startup(struct drm_bridge *bridge,
 	/* not copyrighted */
 	regmap_update_bits(adv7511->regmap, ADV7511_REG_AUDIO_CFG1,
 				BIT(5), BIT(5));
-	/* enable audio infoframes */
-	regmap_update_bits(adv7511->regmap, ADV7511_REG_PACKET_ENABLE1,
-				BIT(3), BIT(3));
 	/* AV mute disable */
 	regmap_update_bits(adv7511->regmap, ADV7511_REG_GC(0),
 				BIT(7) | BIT(6), BIT(7));
-	/* use Audio infoframe updated info */
-	regmap_update_bits(adv7511->regmap, ADV7511_REG_INFOFRAME_UPDATE,
-				BIT(5), 0);
 
 	/* enable SPDIF receiver */
 	if (adv7511->audio_source == ADV7511_AUDIO_SOURCE_SPDIF)
@@ -214,4 +201,6 @@ void adv7511_hdmi_audio_shutdown(struct drm_bridge *bridge,
 	if (adv7511->audio_source == ADV7511_AUDIO_SOURCE_SPDIF)
 		regmap_update_bits(adv7511->regmap, ADV7511_REG_AUDIO_CONFIG,
 				   BIT(7), 0);
+
+	drm_atomic_helper_connector_hdmi_clear_audio_infoframe(connector);
 }
diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
index 26f8310382d8d1632dda5185b2b0230b59a6063a..b9be8654130758e69ac7ccbc73a82cc25d731a5c 100644
--- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
+++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
@@ -893,6 +893,9 @@ static int adv7511_bridge_hdmi_clear_infoframe(struct drm_bridge *bridge,
 	struct adv7511 *adv7511 = bridge_to_adv7511(bridge);
 
 	switch (type) {
+	case HDMI_INFOFRAME_TYPE_AUDIO:
+		adv7511_packet_disable(adv7511, ADV7511_PACKET_ENABLE_AUDIO_INFOFRAME);
+		break;
 	case HDMI_INFOFRAME_TYPE_AVI:
 		adv7511_packet_disable(adv7511, ADV7511_PACKET_ENABLE_AVI_INFOFRAME);
 		break;
@@ -917,6 +920,21 @@ static int adv7511_bridge_hdmi_write_infoframe(struct drm_bridge *bridge,
 	struct adv7511 *adv7511 = bridge_to_adv7511(bridge);
 
 	switch (type) {
+	case HDMI_INFOFRAME_TYPE_AUDIO:
+		/* send current Audio infoframe values while updating */
+		regmap_update_bits(adv7511->regmap, ADV7511_REG_INFOFRAME_UPDATE,
+				   BIT(5), BIT(5));
+
+		/* The Audio infoframe id is not configurable */
+		regmap_bulk_write(adv7511->regmap, ADV7511_REG_AUDIO_INFOFRAME_VERSION,
+				  buffer + 1, len - 1);
+
+		/* use Audio infoframe updated info */
+		regmap_update_bits(adv7511->regmap, ADV7511_REG_INFOFRAME_UPDATE,
+				   BIT(5), 0);
+
+		adv7511_packet_enable(adv7511, ADV7511_PACKET_ENABLE_AUDIO_INFOFRAME);
+		break;
 	case HDMI_INFOFRAME_TYPE_AVI:
 		/* send current AVI infoframe values while updating */
 		regmap_update_bits(adv7511->regmap, ADV7511_REG_INFOFRAME_UPDATE,

-- 
2.47.2


