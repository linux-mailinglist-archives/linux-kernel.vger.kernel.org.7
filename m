Return-Path: <linux-kernel+bounces-733516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE34B075B7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 14:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9B933B0A79
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 12:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08322F509E;
	Wed, 16 Jul 2025 12:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QpobCLBF"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E554A2F509A
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 12:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752669215; cv=none; b=qHjWivj/bitnhq7siAl0ZMW15BjjH4grkSJMV+1txECqDff5eG06lLx7c7hsfMqfFfCJ4c4iiguQH6SYtWDkMdyQ1qyFGHgfVT7i/17bFvFdLadzPFpNLuJH4mNe06nQHU5/+p+IrLB+CTSnISFTVbXKaathYtluaJrCKYVW5MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752669215; c=relaxed/simple;
	bh=pwUXcN/tYFpUKUiZQ9vbe6DzhnD4SjUoa6LqKayVcrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qi/xZjLZSPO8stl7sp48IhlIBKy7b1v62nOWCNBD3mG2BoPVJtXNn81iosSuASRyw5goFJBe31FrveWRa3WMZTSpoWOE/fhpm/sBsI/eIF6RQjfKHAf8cHOod33iNCep741k4YJwRwf7CuSxrOhAdM5AWTGQCmdcMWuZtYofgaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QpobCLBF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56G5xBtP007286
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 12:33:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=ILZwIdqXKUz
	HsZ/3SNiY+HSM17zGHVzMqnAliKbqiUU=; b=QpobCLBFUMRP+4LZL+sabHXTMxI
	PNjbjwNBf31+kFbAk2Raa4ZyDYNcBCetrPIOLwOdnb+4pMWt9lBLYSq45obZKfu7
	1CVMFjmURJeF6L6g7k/QLuttoV1egTkBR5F4INrPgNSY99fOLPlJNFQ8B4Ypp+uc
	XSmaqsHyF5/INQIoyB3CKtZPaAFJSskobPDEwx9rngGhaWLLeheyhtyijzBWpSIk
	giF2kVcj75eMOdrUg9rC2kz30T0NBp8fJ1pULp94p7bZQlGjm/j9Be5U2NEHQd78
	EUzS//+HJrRl7URIuK6InwqOJGY3b3N5yKbLiUyRlTfC2l718dVurNwSWNA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47wnh5v2a7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 12:33:33 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4ab60125e3dso67172421cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 05:33:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752669211; x=1753274011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ILZwIdqXKUzHsZ/3SNiY+HSM17zGHVzMqnAliKbqiUU=;
        b=GOY+CpSG4DepORPezW1MtSjzCCeLg+Upe27A4uWLyToNli7hFmbD8qRjqCZ4XqT2A7
         KZzok7aLexDsW7pihq5w0iEoO/oleeOoVeiND8kracDp7eF4F/qlT9x5s6KhKnJEjnsf
         JC8pAKwC2rHGaSBdRK+Pb/cZRlSfUfeSpOWuJX7xhHKK4wPt2j3CmnaEYY+q/Sd2aYx0
         N3/W1C8UQ1qODW8tCAn/croLVjDPW6GccL78FYyugIfnQaZdZT6bdm7n8b3MslrmSU8h
         ul+3pzwakOKCeT+SC1yzkVFvY+1rL4ZdQPMv5kkpKe1Ox21MUnVhj/4wBJNjFRRJyAQp
         tqQw==
X-Forwarded-Encrypted: i=1; AJvYcCUd1Vsl56QRrI0IKY4jDVa9shGKodkFYFd0ryISWISK/Ospj1qTOg+b3+DiwzVXS4EJdooTkDSMi0o1Hb0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+DN7XbVi63W0zqJ/K8VL91xo6Jh43xDEBnbIQICS2/DEl0YDx
	dTFRHC7hhUggjMR1URjYui5i06pCG/BF6Sqpx5ebfd/Kqr5tvJrP3De2uVFX3cF+e7Wn9Q1rini
	i2oD0tVPPIfToXvMTjpASeMB3ipu+J5ePNsSeLSrF4x4jN6AH3yKU4oVlHDTrJcr67ew=
X-Gm-Gg: ASbGncsVURpjh7YbkyA6qi6cfE72IgZlTpSQGj7qAli9Ch1T1r0p6qM+bcNtGISEN5v
	RIEeOmCJ5b3KUnKIjVA+544Jn7PHYONIxXPWnRxQCuaHxnWWoqhYyGTzAkJDbpoWJkXEUCseuuq
	gU6BEd8jVwev94zxAwqrUGcacZtshj4jxQLRN9YyIr+nCgWbLp+NkT0PlCMI9L3RRXRYAi1+vVO
	QfmWHI/OckWAAwSIKkFWPSTyu4NuNqArwUhYh4FU5oYnCGkFL6rQs+paNW43jbHJuytWm/KTzv/
	+uYZi8qgL+LPHy+/1DjzI8MCKKNzFtbDFahCaYO5+rMbB9ypi4HUlg==
X-Received: by 2002:a05:622a:1a8d:b0:4a3:4d46:c2a6 with SMTP id d75a77b69052e-4ab93c6d086mr39094221cf.7.1752669211236;
        Wed, 16 Jul 2025 05:33:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDy9BVKcG+tyN/VAXcRAsDaOYTfPP9joPVVd8YCEddeMx0YjTzda0WPIBrtsaF2giE4NQYcA==
X-Received: by 2002:a05:622a:1a8d:b0:4a3:4d46:c2a6 with SMTP id d75a77b69052e-4ab93c6d086mr39093281cf.7.1752669210366;
        Wed, 16 Jul 2025 05:33:30 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e89c739sm19453335e9.32.2025.07.16.05.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 05:33:29 -0700 (PDT)
From: srinivas.kandagatla@oss.qualcomm.com
To: broonie@kernel.org
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, srini@kernel.org,
        linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, neil.armstrong@linaro.org,
        krzysztof.kozlowski@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH 2/5] ASoC: codecs: wcd-common: move WCD_SDW_CH to common
Date: Wed, 16 Jul 2025 13:33:20 +0100
Message-ID: <20250716123323.5831-3-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250716123323.5831-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20250716123323.5831-1-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=dKimmPZb c=1 sm=1 tr=0 ts=68779c1d cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=AbvtZVZmey0OcoHPdAYA:9
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: ZW3_UnLRdnip--_k9X06lw_3o3XQqagu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDExMiBTYWx0ZWRfX0W2EiS3iTgEL
 a3hEgNmmlMC2iM6OmaYJs/XkTYkNH5A5JwccjpfrMc7xbtO/AGq+SDUA9HeuBAQxhN59W3yJ+al
 tQo2ccDm0CzWfGzSn7b2Yx2ufGvah2mX8w7oFQjJnH73t7COn+983LVbvUgiuzVZOrNZerWAzag
 w9DmdBCGQ/bgMYL3pY1/R+oT01ftyt0xT3kUe0qBELkm0idNCzn6Bsjf2lsVvnum6FdqR3CI+nl
 G6utzpwTPJsOjZhVc2oJjkR2zTJgHpOy5jcqQBHBaA/ubHo4fkT61Y8MBz+6wZZdbzJib5IgzlB
 hGSo2rmvKJ+Ab23n24m9+AWyNHFDRQuHCpBf7FeVWJP3ir1b9wqeAgyFDBhCYVJ7E7oYaXxahl8
 WNGRrCF+juQsWNa+hUsYpLp19kc2eO/1TzpQWkzRZP88dyNByZHEogRDl4u1N6kW8kZp/8KG
X-Proofpoint-ORIG-GUID: ZW3_UnLRdnip--_k9X06lw_3o3XQqagu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_01,2025-07-16_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 mlxlogscore=999 mlxscore=0 spamscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507160112

From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>

sdw_ch_info and WCD_SDW_CH macro is duplicated across wcd937x, wcd938x,
wcd939x soundwire codec drivers. Move this to wcd common driver to
remove this code duplication.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 sound/soc/codecs/wcd-common.h  | 11 +++++++++++
 sound/soc/codecs/wcd937x-sdw.c |  4 ++--
 sound/soc/codecs/wcd937x.h     | 16 ++--------------
 sound/soc/codecs/wcd938x-sdw.c |  4 ++--
 sound/soc/codecs/wcd938x.c     |  2 +-
 sound/soc/codecs/wcd938x.h     | 13 +------------
 sound/soc/codecs/wcd939x-sdw.c |  4 ++--
 sound/soc/codecs/wcd939x.c     |  2 +-
 sound/soc/codecs/wcd939x.h     | 13 +------------
 9 files changed, 23 insertions(+), 46 deletions(-)

diff --git a/sound/soc/codecs/wcd-common.h b/sound/soc/codecs/wcd-common.h
index 08c8e7ce9814..ee101f8547d5 100644
--- a/sound/soc/codecs/wcd-common.h
+++ b/sound/soc/codecs/wcd-common.h
@@ -11,6 +11,17 @@
 #define WCD_MAX_MICBIAS_MV	2850
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
index 8bcd8396f375..40c6896eb781 100644
--- a/sound/soc/codecs/wcd938x-sdw.c
+++ b/sound/soc/codecs/wcd938x-sdw.c
@@ -21,7 +21,7 @@
 
 #define SWRS_SCP_HOST_CLK_DIV2_CTL_BANK(m) (0xE0 + 0x10 * (m))
 
-static const struct wcd938x_sdw_ch_info wcd938x_sdw_rx_ch_info[] = {
+static const struct wcd_sdw_ch_info wcd938x_sdw_rx_ch_info[] = {
 	WCD_SDW_CH(WCD938X_HPH_L, WCD938X_HPH_PORT, BIT(0)),
 	WCD_SDW_CH(WCD938X_HPH_R, WCD938X_HPH_PORT, BIT(1)),
 	WCD_SDW_CH(WCD938X_CLSH, WCD938X_CLSH_PORT, BIT(0)),
@@ -32,7 +32,7 @@ static const struct wcd938x_sdw_ch_info wcd938x_sdw_rx_ch_info[] = {
 	WCD_SDW_CH(WCD938X_DSD_R, WCD938X_DSD_PORT, BIT(1)),
 };
 
-static const struct wcd938x_sdw_ch_info wcd938x_sdw_tx_ch_info[] = {
+static const struct wcd_sdw_ch_info wcd938x_sdw_tx_ch_info[] = {
 	WCD_SDW_CH(WCD938X_ADC1, WCD938X_ADC_1_2_PORT, BIT(0)),
 	WCD_SDW_CH(WCD938X_ADC2, WCD938X_ADC_1_2_PORT, BIT(1)),
 	WCD_SDW_CH(WCD938X_ADC3, WCD938X_ADC_3_4_PORT, BIT(0)),
diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
index 6d77cbcafa70..678e4052a255 100644
--- a/sound/soc/codecs/wcd938x.c
+++ b/sound/soc/codecs/wcd938x.c
@@ -393,7 +393,7 @@ static int wcd938x_io_init(struct wcd938x_priv *wcd938x)
 
 }
 
-static int wcd938x_sdw_connect_port(const struct wcd938x_sdw_ch_info *ch_info,
+static int wcd938x_sdw_connect_port(const struct wcd_sdw_ch_info *ch_info,
 				    struct sdw_port_config *port_config,
 				    u8 enable)
 {
diff --git a/sound/soc/codecs/wcd938x.h b/sound/soc/codecs/wcd938x.h
index a6fda63d7f98..a37962c4cef1 100644
--- a/sound/soc/codecs/wcd938x.h
+++ b/sound/soc/codecs/wcd938x.h
@@ -588,17 +588,6 @@
 
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
@@ -650,7 +639,7 @@ struct wcd938x_sdw_priv {
 	struct sdw_stream_config sconfig;
 	struct sdw_stream_runtime *sruntime;
 	struct sdw_port_config port_config[WCD938X_MAX_SWR_PORTS];
-	const struct wcd938x_sdw_ch_info *ch_info;
+	const struct wcd_sdw_ch_info *ch_info;
 	bool port_enable[WCD938X_MAX_SWR_CH_IDS];
 	int active_ports;
 	bool is_tx;
diff --git a/sound/soc/codecs/wcd939x-sdw.c b/sound/soc/codecs/wcd939x-sdw.c
index 477d6cf27d32..b5a35c3b22e1 100644
--- a/sound/soc/codecs/wcd939x-sdw.c
+++ b/sound/soc/codecs/wcd939x-sdw.c
@@ -23,7 +23,7 @@
 
 #define SWRS_SCP_HOST_CLK_DIV2_CTL_BANK(m) (0xE0 + 0x10 * (m))
 
-static const struct wcd939x_sdw_ch_info wcd939x_sdw_rx_ch_info[] = {
+static const struct wcd_sdw_ch_info wcd939x_sdw_rx_ch_info[] = {
 	WCD_SDW_CH(WCD939X_HPH_L, WCD939X_HPH_PORT, BIT(0)),
 	WCD_SDW_CH(WCD939X_HPH_R, WCD939X_HPH_PORT, BIT(1)),
 	WCD_SDW_CH(WCD939X_CLSH, WCD939X_CLSH_PORT, BIT(0)),
@@ -36,7 +36,7 @@ static const struct wcd939x_sdw_ch_info wcd939x_sdw_rx_ch_info[] = {
 	WCD_SDW_CH(WCD939X_HIFI_PCM_R, WCD939X_HIFI_PCM_PORT, BIT(1)),
 };
 
-static const struct wcd939x_sdw_ch_info wcd939x_sdw_tx_ch_info[] = {
+static const struct wcd_sdw_ch_info wcd939x_sdw_tx_ch_info[] = {
 	WCD_SDW_CH(WCD939X_ADC1, WCD939X_ADC_1_4_PORT, BIT(0)),
 	WCD_SDW_CH(WCD939X_ADC2, WCD939X_ADC_1_4_PORT, BIT(1)),
 	WCD_SDW_CH(WCD939X_ADC3, WCD939X_ADC_1_4_PORT, BIT(2)),
diff --git a/sound/soc/codecs/wcd939x.c b/sound/soc/codecs/wcd939x.c
index ef8def695219..6bbdfa426365 100644
--- a/sound/soc/codecs/wcd939x.c
+++ b/sound/soc/codecs/wcd939x.c
@@ -412,7 +412,7 @@ static int wcd939x_io_init(struct snd_soc_component *component)
 	return 0;
 }
 
-static int wcd939x_sdw_connect_port(const struct wcd939x_sdw_ch_info *ch_info,
+static int wcd939x_sdw_connect_port(const struct wcd_sdw_ch_info *ch_info,
 				    struct sdw_port_config *port_config,
 				    u8 enable)
 {
diff --git a/sound/soc/codecs/wcd939x.h b/sound/soc/codecs/wcd939x.h
index f587cf22f86f..0ee0fbb49ff9 100644
--- a/sound/soc/codecs/wcd939x.h
+++ b/sound/soc/codecs/wcd939x.h
@@ -845,17 +845,6 @@
 
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
@@ -910,7 +899,7 @@ struct wcd939x_sdw_priv {
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


