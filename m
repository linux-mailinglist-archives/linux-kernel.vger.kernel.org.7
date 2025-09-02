Return-Path: <linux-kernel+bounces-796706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B096B40624
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 16:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 529594E7B9F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D518330C365;
	Tue,  2 Sep 2025 14:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jFDzbKot"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AEF2DFF12
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 14:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756821676; cv=none; b=eTuM/5MiBrsfGIZZ+F5Mki4LYWKt1scDQVU0bJyKZ5iGjvEisyUSxLrrHHpxVLbjmUFtCkfre4oryjXqca5M6MH+AIIkLNCWQTDtNPeEbzxVsUUi5OI+YanTWUqI+XJ4ZuAseQhqSpLhp4pbEir9ILuO6+Z0vjBJNQzG0xHuD4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756821676; c=relaxed/simple;
	bh=wc/7JbfhxWZb0IvcqrXcslNekS6+I2olIuv0yDvhRhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NG+Zsg+lLlswXT+76Adgm/cmJqh0vunX+ztdZQyhRKke49oafEa+dYMZqhmDj/k9VSWcsZ7AT19WJrXtzm1BTy8SLaIi67tnk+3YSTxGN1g6zG0ZZztJVd9wSFtfMEdiHUFchxNaCCvOODofmGW4rGZnbuA8MvfxImhx1DpYXVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jFDzbKot; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 582B3B5n025567
	for <linux-kernel@vger.kernel.org>; Tue, 2 Sep 2025 14:01:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=ofBMOU8ZIZT
	vpxtjJjzxzmb9uOD74fydkc+Mw7BveZ4=; b=jFDzbKotkqypIshh5GCVuxtWybR
	GSkI3mvgBp18pQfU04reVVaQGEoK2AqUDG2uQwH+qAlL3+XErhVrluCEZfqpNu+h
	1AeBixrSKHKV5ZXwT8l5GzhXQ5IRmg9kWjgKSNQHC+JmHh42cOlYczm4fzTXJCuj
	ZnV/uLf1XKLoOhIbRaVeptLTmqE53YIfMZ0ly3rzAEah2JFUEMIQN0YbD74p5htn
	vYhtt06I0lSvMjuDFarm+OZqGdhsUqwIqmgg8SAdj8/UoXgIJwJiMcR2edyEIHTE
	vOdK1n0oDk+xFWhuI0lwh5zjgXlnWjItd2hsZe3YYF+D9RM1tf1BvrnhoGw==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48uscv02hr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 14:01:13 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-5228ed1eff1so894920137.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 07:01:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756821673; x=1757426473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ofBMOU8ZIZTvpxtjJjzxzmb9uOD74fydkc+Mw7BveZ4=;
        b=MahW7/bz5jTBbY1AqZC/bblVNPOvgpNxsRgGoukd+LebILj2Nxac1/aroGxVPrmIpx
         DREQBb/QpTWj0OpUGsaxTpNwltfyxuQnVCiVhRFjUPInV0cKyJZ3trnp7mOCkualsTCr
         R27K/xs3mGUL7LaX1JfnYNahZV1EVUbDAVxFesQEDAM3H+gw+fVJHMNFNXWZsXrpR/1X
         lbVjnukRjQDPH0HMI2+powAJT1C2zVYYgAdlqSorNY1/+S9YL92D1PpsGPzd/rywU9Dd
         9OHT+8yXkaNPcyPuKHRRuMwx93Dbr+C33VB5TgeFSUSUi2iqYInmlvFqNOC2fvuyvDgf
         2YxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqG4NZsrNYMYc1+xE1FOeIBy7HxODH2Z8UF4sK7jHIX5//kiUVn2zC5Y3z9TfhbukcwqzBm63wp6pDwyA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZX1WEA8Bg/aLTAWiTTZKt7ynxoUZ07o7+W57zYX7V4zvQtvqx
	oC1ijZ7FHWmzgCkBHq+uMGfnyfU+Wtwgg0hVTsP2etbtcRTlTbaX/CWoEKj+EMr1XKerj1FDWiL
	sMHepyED+VVeexRnmQd2bt+v4bojbA0q347owDeYeVvYIUeZHr18Dntw6OZMg1P9zGgE=
X-Gm-Gg: ASbGncsP12pE/7YGC6tjjujhv72AloEvQUlOsLhpug0U8uj9BoBcIzx5nLiwmuQjtHY
	L5WyNuIS00t6ToQfAjJCFVZo0zjcQ6Zx+4vCc9D/4LKcilEG4nJChCInjomhBntYjDJo9TOsKjN
	qO8HK5F2tiXi7fd2y/F0AyQ2QgrviEPHf5O2Gar1AbN/vmSd79ivpaSjwWE1I75wRuodSIPvfDP
	qb1kLAl/5l4kN0N3mZJ5rQl4AzYC/SL9Gwh/FtLhQxQVf0wLKV2xXV90ptZCID1N27/B0KqNwPv
	2aZHCJ82wQRiYgpU6AMC8cQ2l2IBZHuCI8//fsqTJ/fUlhY1H30PWw==
X-Received: by 2002:a05:6102:54a4:b0:525:42d2:790d with SMTP id ada2fe7eead31-52b1b902c6fmr3471050137.25.1756821671587;
        Tue, 02 Sep 2025 07:01:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE257wS09hktiVeXoKS7mdBQNq0fy2/WSA+DkddsrfqENMevrNa5o8DRsYPDgcJnlFqhk99Sw==
X-Received: by 2002:a05:6102:54a4:b0:525:42d2:790d with SMTP id ada2fe7eead31-52b1b902c6fmr3470791137.25.1756821670137;
        Tue, 02 Sep 2025 07:01:10 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d2250115fdsm14381196f8f.40.2025.09.02.07.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 07:01:09 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: srini@kernel.org, broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org
Cc: conor+dt@kernel.org, perex@perex.cz, tiwai@suse.com,
        linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH 6/6] ASoC: codecs: lpass-wsa-macro: add Codev version 2.9
Date: Tue,  2 Sep 2025 15:00:44 +0100
Message-ID: <20250902140044.54508-7-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250902140044.54508-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20250902140044.54508-1-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMSBTYWx0ZWRfX8qLIVkL31zi5
 2CiDG02rlB8Q67s0o7yMnpe6lQM8tRt+dtrKa+qkqFa3vQSRFmjJi05clZr/YjCRjPuxYTg+FCK
 2nfj2L/0HUDtue25b0Gss2iQri1PzufupfxYoLcKydk9WXioXOKuxFj/UeGiND7jmxYIobTm7uq
 suHNBrP5pwXTXzwqGhs5nN1LcPNKKqFOZ+WdFhHbQKuwGZMeho6LWJQRE+V1eiBrKPqdgEHzexq
 1FMx3TeiBsHRR7k+aIh+mrvHUMVf+yKpS/ExMSUDXcApKlX4Vzw/wOkHfjNZHx5kDyJ6rofYOBU
 Kdch4bJUrNz0S0+YN697oNIwtKLI8BRBH2J7qkSVsV7E5q8y36cWGJQfLbTdzurPuT5ho3zhemk
 oU067ojb
X-Authority-Analysis: v=2.4 cv=A8xsP7WG c=1 sm=1 tr=0 ts=68b6f8a9 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=aFUyGFNo807uSY4iGNgA:9
 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-ORIG-GUID: PALSwxyUYiISnhfTvpp1nb4rH4DDn1vn
X-Proofpoint-GUID: PALSwxyUYiISnhfTvpp1nb4rH4DDn1vn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300031

Add support for lpass wsa codec macro version 2.9, which is available in
Qualcomm Glymur SoCs.

Its compatible with 2.8 w.r.t register layouts

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 sound/soc/codecs/lpass-wsa-macro.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/lpass-wsa-macro.c b/sound/soc/codecs/lpass-wsa-macro.c
index da6adb3de21d..187805b39264 100644
--- a/sound/soc/codecs/lpass-wsa-macro.c
+++ b/sound/soc/codecs/lpass-wsa-macro.c
@@ -2690,6 +2690,7 @@ static int wsa_macro_component_probe(struct snd_soc_component *comp)
 	case LPASS_CODEC_VERSION_2_6:
 	case LPASS_CODEC_VERSION_2_7:
 	case LPASS_CODEC_VERSION_2_8:
+	case LPASS_CODEC_VERSION_2_9:
 		widgets = wsa_macro_dapm_widgets_v2_5;
 		num_widgets = ARRAY_SIZE(wsa_macro_dapm_widgets_v2_5);
 		break;
@@ -2838,6 +2839,7 @@ static int wsa_macro_probe(struct platform_device *pdev)
 	case LPASS_CODEC_VERSION_2_6:
 	case LPASS_CODEC_VERSION_2_7:
 	case LPASS_CODEC_VERSION_2_8:
+	case LPASS_CODEC_VERSION_2_9:
 		wsa->reg_layout = &wsa_codec_v2_5;
 		def_count = ARRAY_SIZE(wsa_defaults) + ARRAY_SIZE(wsa_defaults_v2_5);
 		reg_defaults = kmalloc_array(def_count, sizeof(*reg_defaults),
-- 
2.50.0


