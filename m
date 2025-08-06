Return-Path: <linux-kernel+bounces-758161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0832B1CBD1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 20:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DB0B18C493B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 18:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B154120458A;
	Wed,  6 Aug 2025 18:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kdcftEr8"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC28029C33E
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 18:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754504339; cv=none; b=o322REmpOGbS3Mf/t0kbCy+oZEUUAguiR23MzRdmkgNvjl2fkvbvuic+Y6DdsPMOBHkJeundJku4ThCw/9g6kvYP81HukpUZkOdmQfjw6K98yw5p1FWeHgOes2wbKvYMMZoN1tmX4u7hHtsZ3t90rP/RljSOAtla6v4IOHfLd44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754504339; c=relaxed/simple;
	bh=NM5eUwufs9EQvxyH72fi6ouw9HbAH6xIggTFFBsajLc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BmSmU64Y+kbCzq3PzhX2TmfSHYwecjf7zZ6zQJ4cakmAnYRsszCPuFAkifFmjTSPbMXq9fDWDerJFnindOsCA/1aJNvHVcVpoYMci4dly6bd7MPP75MjtxJAePIRvNO04FWUao7CaAz9amDZVP3KwTbvvqpUYYw80vC0kNlGf7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kdcftEr8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 576DkbnX004807
	for <linux-kernel@vger.kernel.org>; Wed, 6 Aug 2025 18:18:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=AcwNi5jqAVS
	vH8zvGbAgdOcfk3Kkt+F28Tzsi0VVD74=; b=kdcftEr8krSd+IzqJ9tRWKlU3AS
	gRU8EIpWJU+T5GyInolsyLz9vx9jtKBHu0U2tEXQbsz7TipjNY2fO+V0YTj8tevr
	J0nx20qfMCxVgHrV8zjvLFyV2l/5200ir+qfygh/s6Jqkbb3dFA835jMQVKHSF0u
	zZFe47+zJRxOEBoTNniJLgI7NDE3MY2r+aXQHzyf2RfOKIPDcz1XYcsA9ooMAv/E
	aGrnNMAYQcQAAwyORO6VjZKURSeL2TrXcVcbtzHYFKpKMZSvKoeIiiQOTj7IO9A4
	9NMsakDaknLq6BHy3iuJj0Rfpd4KqZ9vpnuoZfITnL+5xMEDviBZoTYuLGQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpyabnp4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 18:18:56 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b38ec062983so58756a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 11:18:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754504336; x=1755109136;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AcwNi5jqAVSvH8zvGbAgdOcfk3Kkt+F28Tzsi0VVD74=;
        b=tY3AJJ9K5BintluHbOWe3M1nEZsmdQh+7SUoFg1KwNawEeu9wChDJ9KY9bi04nu4wG
         +5mqkONfUgWznQOzmOSauoAlw/tQlkJlwj4RMnJbHlnr3cCG7SByrwyCy8T1drsHNHW0
         4pOiwTzeJZtil6cou/eqe4Q/iO/g1BcvA5r9ScRbipIAj8UdypJFKxOtfa8aWUW7LrLF
         l1bHkKbGAWQEM1HfAjccFp85rYTnZ6D2IGVCgQVvqTW/V66sxHz0wdQIofluCQUr0NSJ
         2CfeUhb+EG/FlUVAe4GLXam/RzAaVM/qsl1oZqJX0jTA9P7rpvd5lVojEbVJhbA4yjoF
         nEbw==
X-Forwarded-Encrypted: i=1; AJvYcCU6S9rAi2ExlksrmPMMqRZ4hudzv4TU1NYKsIoj+xOr0jfH7X2o6AHiKYlZRh5VnWXz37u6aTd/D2cJZy0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKf1CwLy+SevnEw5aQZ1DY4SGx/hEjitJswuVIXdDmjM8mvXkM
	KU3QiwaM8ITjtWVsKq1S22ZAcF1Df4BlA4XvaOUi5xOJg/zYJGbSP6Xq615ywKA0eGf7kboo4tX
	IaxJrzQai/trJQ4c9DB4sYYZTb6jOkHTRNUgsKpXK86/6n7tatnmjKrmpGW0X0/K0E04=
X-Gm-Gg: ASbGncu5TplglM1SmJzonRRRPru34qDHT62Dv1Q/FuMMx34PIOvyf1i3k/T93cB8CNP
	UHT96pXDIlwrYRqXsHRMbdGopcZEnzd6TcqbZZJQ1KUjj7A5kjMM7y6Un599V9M0Gyp89TWSF2d
	MUw7UFMx1f7Ox1PbCEvzpBYhkGK6rpmTMQI8xMz6OD/K58BHOu+ZYO51fMyyvfow0LteLfwZ2y6
	WlO70meKo6s7n9c3FTgSN/og5Cgr6jkkNT2vhTRkWC27b1evExZ2R1OY8Ak7dAqTBUmo51x8+YB
	s5dshCd7TlRw/SFQoRv4FbWpcL3Ac8V2wl0Z23WWrrQkRkSgRefg2J8DSbArZSzM0i/rSQ/MSLJ
	p
X-Received: by 2002:a17:903:13c8:b0:236:6fbb:a5f3 with SMTP id d9443c01a7336-2429f54c7eamr61943575ad.40.1754504335581;
        Wed, 06 Aug 2025 11:18:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtnljZKXOMWdBRC4f+HxW11Qf1guDBZHmC+q3fOK4zEG7lfva4EPwAY+d9RnC5k2MlPPZAyg==
X-Received: by 2002:a17:903:13c8:b0:236:6fbb:a5f3 with SMTP id d9443c01a7336-2429f54c7eamr61943105ad.40.1754504335141;
        Wed, 06 Aug 2025 11:18:55 -0700 (PDT)
Received: from hu-mohs-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f63f36311sm20235186a91.34.2025.08.06.11.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 11:18:54 -0700 (PDT)
From: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, quic_pkumpatl@quicinc.com,
        kernel@oss.qualcomm.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 1/2] ASoC: dt-bindings: qcom,wsa8830: Add reset-gpios for shared line
Date: Wed,  6 Aug 2025 23:48:17 +0530
Message-Id: <20250806181818.2817356-2-mohammad.rafi.shaik@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250806181818.2817356-1-mohammad.rafi.shaik@oss.qualcomm.com>
References: <20250806181818.2817356-1-mohammad.rafi.shaik@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: rw7IvX5d-wKAK8zSh0cbnSP8BkYJ0-yr
X-Authority-Analysis: v=2.4 cv=MrlS63ae c=1 sm=1 tr=0 ts=68939c90 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=2OwXVqhp2XgA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=Jjn-4_SfM33dySwp1_gA:9
 a=3WC7DwWrALyhR5TkjVHa:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAwOSBTYWx0ZWRfXy37Apg29E2+W
 YKMnULqwJCNYWOrwT5JVOX3qwXwPNsZOzHkcPaSBeH9fNNB187VnJb9jSVExqFhfpmRCBEYwt2u
 F6D0L+bbCB1brA54hqOESN1hdnGeKSKgcIqAaOFrLcHiPbLq8G1rTQbVKZCiZfYSNUrhLO2telw
 crAeE+DF5AKV025dtfyLub0plvdAvLyUvAFxa53ix9Ez6XCwN6fFX5QPPeapUw+QmMPU4ykC7vc
 vXGBkjy07W7Tf9M3mABbFnVI1eOR1/LeV8eXIzTuNbpXlZnAPCBxx3klI+6+1rjnHYxRadyclzp
 5J9cNZNB0rkhO1fCMxXYA335XI+hdsNjHYcKlPbBNjhL08tcxCrahWWxq1KHnDN3baJHinwXkIO
 QX940vti
X-Proofpoint-GUID: rw7IvX5d-wKAK8zSh0cbnSP8BkYJ0-yr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_04,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 adultscore=0 priorityscore=1501 phishscore=0
 spamscore=0 bulkscore=0 clxscore=1015 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508060009

On Qualcomm platforms such as QCS6490-RB3Gen2, the WSA883x speaker
amplifiers share the SD_N GPIO line between two speakers, thus
requires coordinated control when asserting the GPIO. Linux supports
shared GPIO handling via the "reset-gpios" property, which can be
used to specify either the powerdown or reset GPIOs.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
---
 .../devicetree/bindings/sound/qcom,wsa883x.yaml       | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/qcom,wsa883x.yaml b/Documentation/devicetree/bindings/sound/qcom,wsa883x.yaml
index 14d312f9c345..098f1df62c8c 100644
--- a/Documentation/devicetree/bindings/sound/qcom,wsa883x.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,wsa883x.yaml
@@ -29,6 +29,10 @@ properties:
     description: GPIO spec for Powerdown/Shutdown line to use (pin SD_N)
     maxItems: 1
 
+  reset-gpios:
+    description: Powerdown/Shutdown line to use (pin SD_N)
+    maxItems: 1
+
   vdd-supply:
     description: VDD Supply for the Codec
 
@@ -50,10 +54,15 @@ required:
   - compatible
   - reg
   - vdd-supply
-  - powerdown-gpios
   - "#thermal-sensor-cells"
   - "#sound-dai-cells"
 
+oneOf:
+  - required:
+      - powerdown-gpios
+  - required:
+      - reset-gpios
+
 unevaluatedProperties: false
 
 examples:
-- 
2.34.1


