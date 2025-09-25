Return-Path: <linux-kernel+bounces-831473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C399B9CC40
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 02:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F12C169C91
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 00:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC6A1D5CE0;
	Thu, 25 Sep 2025 00:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ppQ4cE9g"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402032B2D7
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758758489; cv=none; b=nwOZuqDw7BPXwGjpRQsugQPcrcO1euHUtSp6ctxhnhLCrGAawj6P82kOGCPDD7I4+NANKg2tIKI2QMTHNQZlF/kGxN7TKmqf/8fJcPWf4KSpxF0/+iiMLjpVBk8hhzOWacDNdvfTDQRvZRXZrg/01O+OH1SignJAV7p2bg8yZ84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758758489; c=relaxed/simple;
	bh=GbeypoZ7pSzJRq5aiGkJ+ZMsazvCsBwgW3rGQicZDB0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=otifVUokliJP73pR/6g7D8zpWbLhKQncZnQnw47SHcQBlhJpkSQCf/6dH9BAh5cVBfFb0QRD4Aa1sngb30tzcFHBMmpGomndqhLppMabL99wmtCib9YUgf5OVi6dhedwFgnQRok0nj3DdgHKV3IMVdwwiHHRg31uClmRAH+ehik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ppQ4cE9g; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OCDYD4002665
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:01:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BIA0lAPXctuODepcsDAYeLT0cdZurEoM+f0ATXpF7LA=; b=ppQ4cE9gMMpYrh/M
	43u/UYMb8Ez85of68kckCv5nxSmUJiBWyqUmfKuM9+yMfTjr8MfsWMRy4ohTU9nF
	9qPIFDw0TuhaeYjWyhwQyTON+InmHi1dKrYiJLrzwjo1GLCOHfbto0ZKI3fohmMf
	TmlFlcmzCRhNxaMpLrlSb8L3+jYHPhGd3WCPi64fqhQBqAfqYRjEZw7Urx79Uk12
	P+jqBy7IdQTZ4cRRnPPJ6sEhQJ//R8IHBYy1WP0+36NB5Wr5FCOqqV85hTPOlnYU
	PZUikICZu2Yf9uoMaDRDL1+zh66pFswiScxHNLC7LUwn5bKgP9m4I9/KkmTs5jvu
	eX56ig==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bajf0nku-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:01:27 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-77f68c697d3so299435b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 17:01:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758758486; x=1759363286;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BIA0lAPXctuODepcsDAYeLT0cdZurEoM+f0ATXpF7LA=;
        b=H4V7Jh9zprIyZ3pVvqZl3GyRTkdrrdtosFfDV649GkX1TazZfhJMhIw7zaMDTejaL1
         TD4dpUj3RX99WoCHTYNpT1lrMl4V4jSz8MmSc9UB034Inpo6txk//k779VSG8tDo0xRp
         Y/+wYpgddMCCVUZRoG+L1cGXc5GX7EOihKzO7a3f9NXaxDyGCuKunOrJzaeXAKAtKEBu
         AudqHIVWuou3t4MOJnxVu1EfVAk6rYgCO/gvYKLkGEWLcwB6v6Dal3wlQAlRkfefTt4o
         ZssmAt9OHH/RtK6R7X9w9grF2Kx3AjuBIP372KmeLkD2RZOAwXuC40wHvsONDliEukCR
         xzLg==
X-Forwarded-Encrypted: i=1; AJvYcCU6N+tDj+ftPFKKwJWuPqDaA25/CHcR7KMpFNHkSVkPnhvvpTpl/BVRMGRDs5DS7oXqaEcPD++CEHCzO7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEP3JXuFaNR15HUKT/qwJilX8a5yiTaBD+u9DNfcoaduf9Cy2U
	+AP/6PIwWyCz7CE6ZvTDHDs91UCv6hfVh1uEOSXtyqEk5OuQZZeQ+yNBJWvXjqc6klCcCriBfg3
	UOmA27WrsDxs7wF/LgDewD2+aim6kz0HR5n0M6FgKRrPnqMsqHsZtJvfWGsYUyDFDmis=
X-Gm-Gg: ASbGncvwiVwhkl53ekGQO7TpIz+vYFvFxqJGo9aOOxkUnjy5NsLVDbAdhohGKNiYdKx
	KiJlDhNuAk7h4OZC6oUdG0uA7D/JhZIhoStlf7kRFUqanjmAMwCVk6Cmk3ZDPHO3avfkGJxeY4u
	tHswis7zYmgCJkwPueY2wHRHXjxiMtEv3bT9P36CQX0VGNIyV4znvuS/OO7O80BsFEGMhB+P9/k
	YmUsvUFDq+e8o/iVxlloQh4Xn19J1B528FioSLwo8MPYKt5W4mBJhrlnMkofwhamwlHsVTEYXYL
	uD4to6scJkapFhvIyNl5DvbA5oA7tH99+u4sAPvhCi3XiLn289Ax/NXRiwJVFPyHNE1YYKnPjG6
	B8A8lI1cY4X5Wn6A=
X-Received: by 2002:a05:6a20:1582:b0:2a2:850:5605 with SMTP id adf61e73a8af0-2e7ca028446mr1739917637.23.1758758486240;
        Wed, 24 Sep 2025 17:01:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7X7TPCsIc57wMYrcNMGRRsXn1Ow5fYgIvLU6YgaAL4nJnulh3iSn/UmFmwgQLfia0CqSxtA==
X-Received: by 2002:a05:6a20:1582:b0:2a2:850:5605 with SMTP id adf61e73a8af0-2e7ca028446mr1739838637.23.1758758485495;
        Wed, 24 Sep 2025 17:01:25 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b57c55a1bafsm423152a12.43.2025.09.24.17.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 17:01:24 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Wed, 24 Sep 2025 17:01:15 -0700
Subject: [PATCH 1/5] ASoC: codecs: va-macro: Rework version checking
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-knp-audio-v1-1-5afa926b567c@oss.qualcomm.com>
References: <20250924-knp-audio-v1-0-5afa926b567c@oss.qualcomm.com>
In-Reply-To: <20250924-knp-audio-v1-0-5afa926b567c@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rao Mandadapu <quic_srivasam@quicinc.com>
Cc: aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com,
        linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Prasad Kumpatla <prasad.kumpatla@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758758482; l=5418;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=Q1SMif4AwHacwHa6WXMONmfzDjI6PXISmkZKkL2767Q=;
 b=nMLp6bNDKm/EnM6Afg+st3NM2flB6w0tlviUxamensAfUQFRM/NjPrTBwBfUWOWQtJDT/N3ON
 Iwo+lezfJOaCrj7JyUxA9RVwtHmklI7tFhBhEL8q5/ttXaIsRrohncX
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Proofpoint-GUID: SGGC9fZrm6Mj0ifg-CLmAFo-MQdWAnlY
X-Authority-Analysis: v=2.4 cv=fY2ty1QF c=1 sm=1 tr=0 ts=68d48657 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=u-qv99s1o6jZDIvgRHYA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDE2OCBTYWx0ZWRfX07bngK55BA+5
 jXlwfEi7xl0k+DdXRvLqmanQXNfGBINxEUXyBkL1fnkepjuM/VQ/ci2PcNRnWx4DW4xVcibA3Jd
 ZkfTvNqL3JhVD4xwiO7BH9iuCYTAJ5F/xQGh+dNfe25pbRysEM7hQY9NvBfm1VctrGUf4nrRrhp
 +n6pWsl36NZDAPnTl/vJ6sRCNWXYh45wwQ2BPcl/ce8ae9KuROTg3Q+GaJ6wSu4S9bqp3jrmR3v
 ZFDNKpoRW3kYhp+MP2K1Rcm/q75NCK6fTuR6zD3hWtA417w4fef2KsUXiFuz2S0thqyKolr+cA0
 MIOuTc5cqEm5d8lB0Vmtp5BN7OQbXu4UqHvoW866Fxwuz2Iexjc2N+2N6HTO6zKwgZ2e1wVd/87
 bU4OQATp
X-Proofpoint-ORIG-GUID: SGGC9fZrm6Mj0ifg-CLmAFo-MQdWAnlY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 impostorscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509220168

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Open-code some of the registers to make the checks anywhere near human-
readable. Error out if the version is unsupported or if the VA macro
isn't supposed to be present within this LPASS instance (since we can
check for that now).

Note that previously v2.0 and v2.1 assignments were swapped, but v2.1
does not even seem to exist (as opposed to v2.0.1) and there is no
difference in SW handling anyway.

Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
[Prasad Kumpatla: fixed a spelling error and resolved a checkpatch
warning related to return value handling]
Signed-off-by: Prasad Kumpatla <prasad.kumpatla@oss.qualcomm.com>
Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
 sound/soc/codecs/lpass-va-macro.c | 89 +++++++++++++++++++++++++++------------
 1 file changed, 62 insertions(+), 27 deletions(-)

diff --git a/sound/soc/codecs/lpass-va-macro.c b/sound/soc/codecs/lpass-va-macro.c
index 2e1b77973a3e..1454c533db8b 100644
--- a/sound/soc/codecs/lpass-va-macro.c
+++ b/sound/soc/codecs/lpass-va-macro.c
@@ -64,8 +64,15 @@
 #define CDC_VA_TOP_CSR_I2S_CLK			(0x00A8)
 #define CDC_VA_TOP_CSR_I2S_RESET		(0x00AC)
 #define CDC_VA_TOP_CSR_CORE_ID_0		(0x00C0)
+ #define CORE_ID_0_REV_MAJ			GENMASK(7, 0)
 #define CDC_VA_TOP_CSR_CORE_ID_1		(0x00C4)
+#define CORE_ID_1_HAS_WSAMACRO			BIT(3)
+#define CORE_ID_1_HAS_RXMACRO			BIT(2)
+#define CORE_ID_1_HAS_TXMACRO			BIT(1)
+#define CORE_ID_1_HAS_VAMACRO			BIT(0)
 #define CDC_VA_TOP_CSR_CORE_ID_2		(0x00C8)
+ #define CORE_ID_2_REV_MIN			GENMASK(7, 4)
+ #define CORE_ID_2_REV_STEP			GENMASK(3, 0)
 #define CDC_VA_TOP_CSR_CORE_ID_3		(0x00CC)
 #define CDC_VA_TOP_CSR_SWR_MIC_CTL0		(0x00D0)
 #define CDC_VA_TOP_CSR_SWR_MIC_CTL1		(0x00D4)
@@ -1462,39 +1469,63 @@ static int va_macro_validate_dmic_sample_rate(u32 dmic_sample_rate,
 	return dmic_sample_rate;
 }
 
-static void va_macro_set_lpass_codec_version(struct va_macro *va)
+static int va_macro_set_lpass_codec_version(struct va_macro *va)
 {
-	int core_id_0 = 0, core_id_1 = 0, core_id_2 = 0;
 	int version = LPASS_CODEC_VERSION_UNKNOWN;
+	u32 maj, min, step;
+	u32 val;
 
-	regmap_read(va->regmap, CDC_VA_TOP_CSR_CORE_ID_0, &core_id_0);
-	regmap_read(va->regmap, CDC_VA_TOP_CSR_CORE_ID_1, &core_id_1);
-	regmap_read(va->regmap, CDC_VA_TOP_CSR_CORE_ID_2, &core_id_2);
+	regmap_read(va->regmap, CDC_VA_TOP_CSR_CORE_ID_0, &val);
+	maj = FIELD_GET(CORE_ID_0_REV_MAJ, val);
 
-	if ((core_id_0 == 0x01) && (core_id_1 == 0x0F))
-		version = LPASS_CODEC_VERSION_2_0;
-	if ((core_id_0 == 0x02) && (core_id_1 == 0x0F) && core_id_2 == 0x01)
+	regmap_read(va->regmap, CDC_VA_TOP_CSR_CORE_ID_1, &val);
+	if (!FIELD_GET(CORE_ID_1_HAS_VAMACRO, val)) {
+		dev_err(va->dev, "This is not a VA macro instance\n");
+		return -ENODEV;
+	}
+
+	regmap_read(va->regmap, CDC_VA_TOP_CSR_CORE_ID_2, &val);
+	min = FIELD_GET(CORE_ID_2_REV_MIN, val);
+	step = FIELD_GET(CORE_ID_2_REV_STEP, val);
+
+	if (maj == 1) {
 		version = LPASS_CODEC_VERSION_2_0;
-	if ((core_id_0 == 0x02) && (core_id_1 == 0x0E))
-		version = LPASS_CODEC_VERSION_2_1;
-	if ((core_id_0 == 0x02) && (core_id_1 == 0x0F) && (core_id_2 == 0x50 || core_id_2 == 0x51))
-		version = LPASS_CODEC_VERSION_2_5;
-	if ((core_id_0 == 0x02) && (core_id_1 == 0x0F) && (core_id_2 == 0x60 || core_id_2 == 0x61))
-		version = LPASS_CODEC_VERSION_2_6;
-	if ((core_id_0 == 0x02) && (core_id_1 == 0x0F) && (core_id_2 == 0x70 || core_id_2 == 0x71))
-		version = LPASS_CODEC_VERSION_2_7;
-	if ((core_id_0 == 0x02) && (core_id_1 == 0x0F) && (core_id_2 == 0x80 || core_id_2 == 0x81))
-		version = LPASS_CODEC_VERSION_2_8;
-	if ((core_id_0 == 0x02) && (core_id_1 == 0x0F) && (core_id_2 == 0x90 || core_id_2 == 0x91))
-		version = LPASS_CODEC_VERSION_2_9;
-
-	if (version == LPASS_CODEC_VERSION_UNKNOWN)
-		dev_warn(va->dev, "Unknown Codec version, ID: %02x / %02x / %02x\n",
-			 core_id_0, core_id_1, core_id_2);
+	} else if (maj == 2) {
+		switch (min) {
+		case 0:
+			version = LPASS_CODEC_VERSION_2_0;
+			break;
+		case 5:
+			version = LPASS_CODEC_VERSION_2_5;
+			break;
+		case 6:
+			version = LPASS_CODEC_VERSION_2_6;
+			break;
+		case 7:
+			version = LPASS_CODEC_VERSION_2_7;
+			break;
+		case 8:
+			version = LPASS_CODEC_VERSION_2_8;
+			break;
+		case 9:
+			version = LPASS_CODEC_VERSION_2_9;
+			break;
+		default:
+			break;
+		}
+	}
+
+	if (version == LPASS_CODEC_VERSION_UNKNOWN) {
+		dev_err(va->dev, "VA Macro v%u.%u.%u is not supported\n",
+			maj, min, step);
+		return -EOPNOTSUPP;
+	}
 
 	lpass_macro_set_codec_version(version);
 
 	dev_dbg(va->dev, "LPASS Codec Version %s\n", lpass_macro_get_codec_version_string(version));
+
+	return 0;
 }
 
 static int va_macro_probe(struct platform_device *pdev)
@@ -1594,10 +1625,14 @@ static int va_macro_probe(struct platform_device *pdev)
 	 * old version of codecs do not have a reliable way to determine the
 	 * version from registers, get them from soc specific data
 	 */
-	if (data->version)
+	if (data->version) {
 		lpass_macro_set_codec_version(data->version);
-	else /* read version from register */
-		va_macro_set_lpass_codec_version(va);
+	} else {
+		/* read version from register */
+		ret = va_macro_set_lpass_codec_version(va);
+		if (ret)
+			return ret;
+	}
 
 	if (va->has_swr_master) {
 		/* Set default CLK div to 1 */

-- 
2.25.1


