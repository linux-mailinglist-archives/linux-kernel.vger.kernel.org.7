Return-Path: <linux-kernel+bounces-803272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B16B45CE5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 17:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79AF0A069CE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 15:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFBF1313290;
	Fri,  5 Sep 2025 15:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bNCLMgyx"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F200309F1E
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 15:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757087089; cv=none; b=Y/V3xuNZw600d8YZvMKrBQW6umn+3uHD3UsNxNXuQB536ClipJZmOBEuW363dW5qCzykYrOoSFw38ILmXLvg7hAIpfG4EQCfWzaeCDzNLn0l1Qv/xa3MfxlHFkM1sWlBkvGsn+AUP2xHxhAt73meqC8WUpHlk9bme61vxP6MSZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757087089; c=relaxed/simple;
	bh=MQs2U7/x/Nh7YK4/KyFeP2f0Q5Ku0GwTfwlYesxR27g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=myN7DZoa05C7R8nLiGCxj75qt4yiZEfbBR3N9F7vyVZXvV6n36pkec5dW7jbsyOWAodPEYNjkOTJcM19ygpMQQReT1l9BmAJU28zGMr0f9D/sPPw6vnXNNkD41e2+8jynC0IkBNY9ah7LgZ8EtfXcDyCJ72My+nJeTo++nsaMDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bNCLMgyx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 585DZh7o018533
	for <linux-kernel@vger.kernel.org>; Fri, 5 Sep 2025 15:44:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=pmkxQz9CST9
	MkZTUVQiyP1vROVnsh4cHHXEC/rF9c9I=; b=bNCLMgyxDdgoDRMGUshFXbJ5x/X
	m0Yn02UrZW0JD6pwVn1DmlQBgCDNvNJCpmaebM8YTnC1wPF3rVBWHmSmei3jODvl
	PjDFUhVkxFVUJlnkNNK1KRtyJ8dRnoGHuv4VLeVOZ/CAD3PTQk1H0SoN73rguNOG
	7XePzahV+s/CWj9ZPSxRROwNFO71Fub+wBlOJ304msZ+wFZQAgLFODQFF7vxX8iy
	46GEHSbjxzBgWHr1SndevJA30NSZU6E2rQgi3ei4UhjX6LIuX6+nfhUvKKqiSg6F
	U+UvYfBIqjVTfkSKVxHF8bPtokZ9nGgeXQGnyc1Tpd0bxI0YWfLfc8Lrglg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48yebuufmy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 15:44:46 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b32fe42b83so38345361cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 08:44:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757087085; x=1757691885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pmkxQz9CST9MkZTUVQiyP1vROVnsh4cHHXEC/rF9c9I=;
        b=mFv1eY29vI1BU537AUjpy1meUEP/tp+KVO3HP4Y0feTi4q/gnlpw2YUs/EVykj82Bf
         EFZvmCsh8u8R0OWOVNrY4k7nMwhBK0Ih4NAbJiGUBa8uWAWgZ9mvRmAj6XYmOCoA3uBI
         PrLz/KRPAdsZnJbg9INt+/uyLaS3hwrxFcMGwbVAPWu6sT6NgL3A/tal2isEzcLayQAQ
         Zn99PIROQC2/c6BDPEVudLEA+bKGJVV+uAVtHHayACxz0xK7JPrv1i/ZesSKKUF7YZwk
         F1GeEkFVUp5ipkkR0p85qPxLizu50QX2RwCuF88WSz3OLBo6eucB7rrAGn161ddMVzJR
         afsQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9Z9EMr4TmCpl7KhCyg1jLuBl5+TOLuviijF+/nxfYbiNNpUTYVLEA1Mqxeme43NYVl9iYuFfmPVetcjs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8BBhVBi+I1tPn51peNGXZa/9LxeUTiJv39F+iP+RnJNttNRbb
	bOMUIn5ofUHBN/1IzxDWJRjOJUQtFAQWv5DFElZo19jlOlNibAYYDakSP7gvPkVSQxZNmlTfHoZ
	JKEsAk49lx/qoEaQe6G2vJFABjHHtyRtJMZng9buS4T/An413wb4liJaDYhLub5zsiiQ=
X-Gm-Gg: ASbGncuuX+o0FQOyeg5kqS3kF7f0BP2S9WUj+oHHL6lMSAI9XBqtfxrPHy1CBp4JFBe
	ip759sJdbYt8cTuLJh5V8ZLaKUbVvTG9p0AFumcbvGpNqATvfJvoKkCHxqtv2DoucfwFOxlZGFW
	0cShOjqFgmLuHecBxW0n7n99aV/WkY7ybZJc8XQ/mrIfpET0K5WsN4t7fyGCJess5+2Dqrk6zrV
	2SC6JOhd9gGnm+CQv1nLSUId9lDtSxKZTZv41iEiReeIk70mBA9+fB6l3x5QOA1ZuNuqCIxoQvH
	ydWfrVQfIMncolZmsD0A9PUsNlRqziWp9n3b+saYsNRhRu5eDWQtJw==
X-Received: by 2002:a05:622a:1f17:b0:4b5:f27c:8609 with SMTP id d75a77b69052e-4b5f27c8f1fmr21958841cf.39.1757087084280;
        Fri, 05 Sep 2025 08:44:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8hsfpkVlm8ZrxP6bgwyelwGF6nP3Wdf1ratliIOWQYNhrjGFviQyG4trTRWCOgThLbdNLAA==
X-Received: by 2002:a05:622a:1f17:b0:4b5:f27c:8609 with SMTP id d75a77b69052e-4b5f27c8f1fmr21958321cf.39.1757087083645;
        Fri, 05 Sep 2025 08:44:43 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b9bcda91dsm165716585e9.6.2025.09.05.08.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 08:44:43 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: broonie@kernel.org
Cc: lgirdwood@gmail.com, tiwai@suse.com, vkoul@kernel.org, srini@kernel.org,
        yung-chuan.liao@linux.intel.com, pierre-louis.bossart@linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        neil.armstrong@linaro.org, krzysztof.kozlowski@linaro.org,
        dmitry.baryshkov@oss.qualcomm.com, linux-sound@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH v3 07/12] ASoC: codecs: wcd-common: move WCD_SDW_CH to common
Date: Fri,  5 Sep 2025 16:44:25 +0100
Message-ID: <20250905154430.12268-8-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250905154430.12268-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20250905154430.12268-1-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 2yVIkbJZMaC4DrxS5WLv4Fy8oCO4AOI0
X-Authority-Analysis: v=2.4 cv=X+ZSKHTe c=1 sm=1 tr=0 ts=68bb056e cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=OwgFr5RAyVMftm7_PUYA:9
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA0MDE2MyBTYWx0ZWRfX0ql3+p1CUxOX
 xC14ELKaYm/ImsiQDCE7W5tKZdB6JaafZvywN/B3hoGn556u92ayo+vIss2NRX7+UIb7PxZcGGH
 Gh8bDhf/JyacKFSmH1do/X4pLZfkUAFdZBSI6g1u4hAkiOCH4p0aZvVcm+HlF932LNC9Duf5wcw
 acyD4rUI4DM8AxPfhxvxQqmU97WpAzmqXzs7ylp8Dae+8C7Tejn21uqiBiNILwd+DpqQALBO+yH
 U48qD0lNfUN+YZS/NpsqGiaRCSlDwiWW61deGooUv9/puoipmr68gtecFW3Y2A4okiIs6UFDx7S
 lZH5VYWXaaPpZrNYf31FHcmjSBK/uu2qrVXhnCmvD2uKc8Vc5sRKnIyP5tPqDtG/vvqJk2UpXD9
 sLxMww1o
X-Proofpoint-ORIG-GUID: 2yVIkbJZMaC4DrxS5WLv4Fy8oCO4AOI0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_05,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 impostorscore=0 phishscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509040163

sdw_ch_info and WCD_SDW_CH macro is duplicated across wcd937x, wcd938x,
wcd939x soundwire codec drivers. Move this to wcd common driver to
remove this code duplication.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 sound/soc/codecs/wcd-common.h  | 11 +++++++++++
 sound/soc/codecs/wcd937x-sdw.c |  4 ++--
 sound/soc/codecs/wcd937x.h     | 16 ++--------------
 sound/soc/codecs/wcd938x-sdw.c |  5 +++--
 sound/soc/codecs/wcd938x.c     |  2 +-
 sound/soc/codecs/wcd938x.h     | 13 +------------
 sound/soc/codecs/wcd939x-sdw.c |  5 +++--
 sound/soc/codecs/wcd939x.c     |  2 +-
 sound/soc/codecs/wcd939x.h     | 13 +------------
 9 files changed, 25 insertions(+), 46 deletions(-)

diff --git a/sound/soc/codecs/wcd-common.h b/sound/soc/codecs/wcd-common.h
index 42d84e42d40f..ca602718c9ba 100644
--- a/sound/soc/codecs/wcd-common.h
+++ b/sound/soc/codecs/wcd-common.h
@@ -14,6 +14,17 @@ enum sdw_slave_status;
 
 #define WCD_MAX_MICBIAS		4
 
+struct wcd_sdw_ch_info {
+	int port_num;
+	unsigned int ch_mask;
+};
+
+#define WCD_SDW_CH(id, pn, cmask)	\
+	[id] = {			\
+		.port_num = pn,		\
+		.ch_mask = cmask,	\
+	}
+
 struct wcd_common {
 	struct device *dev;
 	int max_bias;
diff --git a/sound/soc/codecs/wcd937x-sdw.c b/sound/soc/codecs/wcd937x-sdw.c
index e7cc699bd8bc..8f2819163527 100644
--- a/sound/soc/codecs/wcd937x-sdw.c
+++ b/sound/soc/codecs/wcd937x-sdw.c
@@ -19,7 +19,7 @@
 #include <sound/soc.h>
 #include "wcd937x.h"
 
-static struct wcd937x_sdw_ch_info wcd937x_sdw_rx_ch_info[] = {
+static struct wcd_sdw_ch_info wcd937x_sdw_rx_ch_info[] = {
 	WCD_SDW_CH(WCD937X_HPH_L, WCD937X_HPH_PORT, BIT(0)),
 	WCD_SDW_CH(WCD937X_HPH_R, WCD937X_HPH_PORT, BIT(1)),
 	WCD_SDW_CH(WCD937X_CLSH, WCD937X_CLSH_PORT, BIT(0)),
@@ -30,7 +30,7 @@ static struct wcd937x_sdw_ch_info wcd937x_sdw_rx_ch_info[] = {
 	WCD_SDW_CH(WCD937X_DSD_R, WCD937X_DSD_PORT, BIT(1)),
 };
 
-static struct wcd937x_sdw_ch_info wcd937x_sdw_tx_ch_info[] = {
+static struct wcd_sdw_ch_info wcd937x_sdw_tx_ch_info[] = {
 	WCD_SDW_CH(WCD937X_ADC1, WCD937X_ADC_1_PORT, BIT(0)),
 	WCD_SDW_CH(WCD937X_ADC2, WCD937X_ADC_2_3_PORT, BIT(0)),
 	WCD_SDW_CH(WCD937X_ADC3, WCD937X_ADC_2_3_PORT, BIT(0)),
diff --git a/sound/soc/codecs/wcd937x.h b/sound/soc/codecs/wcd937x.h
index 0f96b7108a7e..3d0ba3cc0ee6 100644
--- a/sound/soc/codecs/wcd937x.h
+++ b/sound/soc/codecs/wcd937x.h
@@ -7,6 +7,7 @@
 
 #include <linux/soundwire/sdw.h>
 #include <linux/soundwire/sdw_type.h>
+#include "wcd-common.h"
 
 #define WCD937X_BASE_ADDRESS			0x3000
 #define WCD937X_ANA_BIAS			0x3001
@@ -507,26 +508,13 @@ enum wcd937x_rx_sdw_ports {
 	WCD937X_MAX_SWR_PORTS = WCD937X_DSD_PORT,
 };
 
-struct wcd937x_sdw_ch_info {
-	int port_num;
-	unsigned int ch_mask;
-	unsigned int master_ch_mask;
-};
-
-#define WCD_SDW_CH(id, pn, cmask)	\
-	[id] = {			\
-		.port_num = pn,		\
-		.ch_mask = cmask,	\
-		.master_ch_mask = cmask,	\
-	}
-
 struct wcd937x_priv;
 struct wcd937x_sdw_priv {
 	struct sdw_slave *sdev;
 	struct sdw_stream_config sconfig;
 	struct sdw_stream_runtime *sruntime;
 	struct sdw_port_config port_config[WCD937X_MAX_SWR_PORTS];
-	struct wcd937x_sdw_ch_info *ch_info;
+	struct wcd_sdw_ch_info *ch_info;
 	bool port_enable[WCD937X_MAX_SWR_CH_IDS];
 	unsigned int master_channel_map[SDW_MAX_PORTS];
 	int active_ports;
diff --git a/sound/soc/codecs/wcd938x-sdw.c b/sound/soc/codecs/wcd938x-sdw.c
index 8bcd8396f375..1dc13b6fabfa 100644
--- a/sound/soc/codecs/wcd938x-sdw.c
+++ b/sound/soc/codecs/wcd938x-sdw.c
@@ -18,10 +18,11 @@
 #include <sound/soc.h>
 #include <sound/soc-dapm.h>
 #include "wcd938x.h"
+#include "wcd-common.h"
 
 #define SWRS_SCP_HOST_CLK_DIV2_CTL_BANK(m) (0xE0 + 0x10 * (m))
 
-static const struct wcd938x_sdw_ch_info wcd938x_sdw_rx_ch_info[] = {
+static const struct wcd_sdw_ch_info wcd938x_sdw_rx_ch_info[] = {
 	WCD_SDW_CH(WCD938X_HPH_L, WCD938X_HPH_PORT, BIT(0)),
 	WCD_SDW_CH(WCD938X_HPH_R, WCD938X_HPH_PORT, BIT(1)),
 	WCD_SDW_CH(WCD938X_CLSH, WCD938X_CLSH_PORT, BIT(0)),
@@ -32,7 +33,7 @@ static const struct wcd938x_sdw_ch_info wcd938x_sdw_rx_ch_info[] = {
 	WCD_SDW_CH(WCD938X_DSD_R, WCD938X_DSD_PORT, BIT(1)),
 };
 
-static const struct wcd938x_sdw_ch_info wcd938x_sdw_tx_ch_info[] = {
+static const struct wcd_sdw_ch_info wcd938x_sdw_tx_ch_info[] = {
 	WCD_SDW_CH(WCD938X_ADC1, WCD938X_ADC_1_2_PORT, BIT(0)),
 	WCD_SDW_CH(WCD938X_ADC2, WCD938X_ADC_1_2_PORT, BIT(1)),
 	WCD_SDW_CH(WCD938X_ADC3, WCD938X_ADC_3_4_PORT, BIT(0)),
diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
index c8b6e543986d..e495f98972f1 100644
--- a/sound/soc/codecs/wcd938x.c
+++ b/sound/soc/codecs/wcd938x.c
@@ -394,7 +394,7 @@ static int wcd938x_io_init(struct wcd938x_priv *wcd938x)
 
 }
 
-static int wcd938x_sdw_connect_port(const struct wcd938x_sdw_ch_info *ch_info,
+static int wcd938x_sdw_connect_port(const struct wcd_sdw_ch_info *ch_info,
 				    struct sdw_port_config *port_config,
 				    u8 enable)
 {
diff --git a/sound/soc/codecs/wcd938x.h b/sound/soc/codecs/wcd938x.h
index 54ee56b7fbd6..c18610466d7d 100644
--- a/sound/soc/codecs/wcd938x.h
+++ b/sound/soc/codecs/wcd938x.h
@@ -587,17 +587,6 @@
 
 #define WCD938X_MAX_SWR_CH_IDS	15
 
-struct wcd938x_sdw_ch_info {
-	int port_num;
-	unsigned int ch_mask;
-};
-
-#define WCD_SDW_CH(id, pn, cmask)	\
-	[id] = {			\
-		.port_num = pn,		\
-		.ch_mask = cmask,	\
-	}
-
 enum wcd938x_tx_sdw_ports {
 	WCD938X_ADC_1_2_PORT = 1,
 	WCD938X_ADC_3_4_PORT,
@@ -649,7 +638,7 @@ struct wcd938x_sdw_priv {
 	struct sdw_stream_config sconfig;
 	struct sdw_stream_runtime *sruntime;
 	struct sdw_port_config port_config[WCD938X_MAX_SWR_PORTS];
-	const struct wcd938x_sdw_ch_info *ch_info;
+	const struct wcd_sdw_ch_info *ch_info;
 	bool port_enable[WCD938X_MAX_SWR_CH_IDS];
 	int active_ports;
 	bool is_tx;
diff --git a/sound/soc/codecs/wcd939x-sdw.c b/sound/soc/codecs/wcd939x-sdw.c
index 477d6cf27d32..97a829e3ce4f 100644
--- a/sound/soc/codecs/wcd939x-sdw.c
+++ b/sound/soc/codecs/wcd939x-sdw.c
@@ -20,10 +20,11 @@
 #include <sound/soc.h>
 #include <sound/soc-dapm.h>
 #include "wcd939x.h"
+#include "wcd-common.h"
 
 #define SWRS_SCP_HOST_CLK_DIV2_CTL_BANK(m) (0xE0 + 0x10 * (m))
 
-static const struct wcd939x_sdw_ch_info wcd939x_sdw_rx_ch_info[] = {
+static const struct wcd_sdw_ch_info wcd939x_sdw_rx_ch_info[] = {
 	WCD_SDW_CH(WCD939X_HPH_L, WCD939X_HPH_PORT, BIT(0)),
 	WCD_SDW_CH(WCD939X_HPH_R, WCD939X_HPH_PORT, BIT(1)),
 	WCD_SDW_CH(WCD939X_CLSH, WCD939X_CLSH_PORT, BIT(0)),
@@ -36,7 +37,7 @@ static const struct wcd939x_sdw_ch_info wcd939x_sdw_rx_ch_info[] = {
 	WCD_SDW_CH(WCD939X_HIFI_PCM_R, WCD939X_HIFI_PCM_PORT, BIT(1)),
 };
 
-static const struct wcd939x_sdw_ch_info wcd939x_sdw_tx_ch_info[] = {
+static const struct wcd_sdw_ch_info wcd939x_sdw_tx_ch_info[] = {
 	WCD_SDW_CH(WCD939X_ADC1, WCD939X_ADC_1_4_PORT, BIT(0)),
 	WCD_SDW_CH(WCD939X_ADC2, WCD939X_ADC_1_4_PORT, BIT(1)),
 	WCD_SDW_CH(WCD939X_ADC3, WCD939X_ADC_1_4_PORT, BIT(2)),
diff --git a/sound/soc/codecs/wcd939x.c b/sound/soc/codecs/wcd939x.c
index 59c920c50c00..a414cd99b946 100644
--- a/sound/soc/codecs/wcd939x.c
+++ b/sound/soc/codecs/wcd939x.c
@@ -413,7 +413,7 @@ static int wcd939x_io_init(struct snd_soc_component *component)
 	return 0;
 }
 
-static int wcd939x_sdw_connect_port(const struct wcd939x_sdw_ch_info *ch_info,
+static int wcd939x_sdw_connect_port(const struct wcd_sdw_ch_info *ch_info,
 				    struct sdw_port_config *port_config,
 				    u8 enable)
 {
diff --git a/sound/soc/codecs/wcd939x.h b/sound/soc/codecs/wcd939x.h
index e70445b1a4bc..ca6353222ea0 100644
--- a/sound/soc/codecs/wcd939x.h
+++ b/sound/soc/codecs/wcd939x.h
@@ -844,17 +844,6 @@
 
 #define WCD939X_MAX_SWR_CH_IDS		(15)
 
-struct wcd939x_sdw_ch_info {
-	int port_num;
-	unsigned int ch_mask;
-};
-
-#define WCD_SDW_CH(id, pn, cmask)	\
-	[id] = {			\
-		.port_num = pn,		\
-		.ch_mask = cmask,	\
-	}
-
 enum wcd939x_tx_sdw_ports {
 	WCD939X_ADC_1_4_PORT = 1,
 	WCD939X_ADC_DMIC_1_2_PORT,
@@ -909,7 +898,7 @@ struct wcd939x_sdw_priv {
 	struct sdw_stream_config sconfig;
 	struct sdw_stream_runtime *sruntime;
 	struct sdw_port_config port_config[WCD939X_MAX_SWR_PORTS];
-	const struct wcd939x_sdw_ch_info *ch_info;
+	const struct wcd_sdw_ch_info *ch_info;
 	bool port_enable[WCD939X_MAX_SWR_CH_IDS];
 	int active_ports;
 	bool is_tx;
-- 
2.50.0


