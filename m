Return-Path: <linux-kernel+bounces-771269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3D2B284E9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 19:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFEF61CE4FDE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 17:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C66321436;
	Fri, 15 Aug 2025 17:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CiRh+IMn"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91CB1F1518
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 17:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755278672; cv=none; b=u9yp623wu9oTCk7A8+oenHPR07SjcaHf+s73fI4Qe6cE8VL84u38fcxV7AVLSjP79VbJNUSlXHQOFaRGFmgZZs01bOlWykz1ispB0HiOPfiqwOxv6/4W/UbZrm6ZlXmTgfiFSBJIvMwPCgbd6mbbMpZjSRfEUoJMd7Z0II5DNF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755278672; c=relaxed/simple;
	bh=NM5eUwufs9EQvxyH72fi6ouw9HbAH6xIggTFFBsajLc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FZC5nAsBxyPcf4R7J6i0ph26mHroSuemwFF9kCPy4zEHljYG2ZdjHQPlc1/vKIr50qTobXnJ2CMgXihjRwGInpCvldY7lWtghs1Tuqw8TJd88uROyWo69XkCWpPrVFgFmxKNVLMiR0omUfxgXWEl4vy7wIemgB5OGNL7p9rVx6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CiRh+IMn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57FEKMpG021968
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 17:24:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=AcwNi5jqAVS
	vH8zvGbAgdOcfk3Kkt+F28Tzsi0VVD74=; b=CiRh+IMnWiLbwdbYxp6fDX+bvAS
	48aiEpc3DNLT3lDYdZZHu03MJ/YeJgvg88TrZN/3403h6molaE4cWsKKayo7PrWZ
	lfDzAdtisSrQS8KtvccEIYKb4NxhI8ejGQNVthgk9FMWhQ/HKab9USHg86GKkJBt
	uWrriM7sGAJj53oLZ89xe07a4sd7y00PhpOhNPy6Sn3fBndPaQS00yBY//LfWaVj
	0mfGuAE848KDNIhXf4AVupkePS5zb7EDuL17TD/BqTBQv0pMDycQpHyYpk5gw8/k
	0eISBGguOkXyTXJXNAL8Qwl+VoZao9jYwebwhH3owTSRwzeiG2Rsyy7pjgQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48fem4qks0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 17:24:29 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-244581ce13aso39943115ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 10:24:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755278668; x=1755883468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AcwNi5jqAVSvH8zvGbAgdOcfk3Kkt+F28Tzsi0VVD74=;
        b=vzUGoifhVnogMV/SOh41ROjksmKeobC6FndP3c8NzFCagCnNkz7T8+54bCexqOJAki
         gc/xXNKbOtsCsorGfGnMgCRIGsi/RBCnjptz893qFiBnU6rlkQLJJ7xhUaW8eOiam7l9
         RJdn1ScQGhjEqd3lmrrucIpjiwQRaV1wlRN9DSdD3iYTzpZX+5pkRxYBezYgFXi74olx
         d/ruQ4Dsmg4LOaaN/XQ8/Bz6+9KbdenK/8d756Gcq4h3DXP65H6zxiyw7UdMvbsQNXcc
         jPQ+NNeA0n33SmMdzb5z0LXwfo9FkDan/5hDyfSFXAUDs92qA2dvkR7OdiQcXv4SWqp7
         LFrg==
X-Forwarded-Encrypted: i=1; AJvYcCWe0MphnFZUs0XgDJJ1ZhakTRq2lSveFGVZEV2TSpOzckFk/MViAbPJqSwNaTcB7O8Z3uKfsiF0z3+Y3AI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWlL+CiasYzkG7pkWhG3M9dS66y8cYNLsZ4u4tZ8djiKA0rFSs
	z2fydQS0J1WjWfQ5/lSDxYjrMT8UV7aMHdzB3MZuUFIr80v8Pfh82+c8wWSbW3qc4eQIsCw3R8w
	pF4dppoKO/eZlwSro+vJra2iD82IExnOfEZ4m3JFOLM35AQCgBSe6f66pu2W6CX5HUYM=
X-Gm-Gg: ASbGnctAf8UGm+HAc4bK29UD26wqXFc6a2gxDvcvb9B0teSVphRg65IjTrBkum2R9Xh
	BPWUO/A2Y2fV9YLOyc4TR0bTL4eJplfKePe0kFXP82QCsnrb+xuloZzsjDGvAMWNPtur4t7jPfM
	t7bGGfvQsHSk6FOEXiODs9CFESO1BZZBHshuIGL4tGJssm4qvLMen/YtYSa7S4Poie9332TwSaQ
	WxlGyHEcv1Tc2cuOGNehGIzcuAqN22yVQ/ydKqgfVvpF2732Wsq/okD3leQiQ7jqIcYyfeO7vwF
	V+aQ582BYPF24dfC8K8YsoE9o6usSuw2n8qiswqGJqI4rPC6XUYYn1MnJNEiZmEhuriJK36I7Yj
	k
X-Received: by 2002:a17:903:1965:b0:243:926:b1f3 with SMTP id d9443c01a7336-2446d7a9610mr49008625ad.24.1755278668484;
        Fri, 15 Aug 2025 10:24:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEihBomGwZVjSUs4+UKA4oxIwLDdUcsOiQ1uMULw5AP5GlJ6JVwHuwDnUGWMxWVfKCJnYCXwQ==
X-Received: by 2002:a17:903:1965:b0:243:926:b1f3 with SMTP id d9443c01a7336-2446d7a9610mr49008275ad.24.1755278668067;
        Fri, 15 Aug 2025 10:24:28 -0700 (PDT)
Received: from hu-mohs-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446cadff5asm18404025ad.42.2025.08.15.10.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 10:24:27 -0700 (PDT)
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
        linux-gpio@vger.kernel.org, kernel@oss.qualcomm.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 1/2] ASoC: dt-bindings: qcom,wsa8830: Add reset-gpios for shared line
Date: Fri, 15 Aug 2025 22:53:52 +0530
Message-Id: <20250815172353.2430981-2-mohammad.rafi.shaik@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250815172353.2430981-1-mohammad.rafi.shaik@oss.qualcomm.com>
References: <20250815172353.2430981-1-mohammad.rafi.shaik@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 47DxWXdQ-GDoxq1qaHxzY0MudH0GQg9z
X-Proofpoint-ORIG-GUID: 47DxWXdQ-GDoxq1qaHxzY0MudH0GQg9z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA2OCBTYWx0ZWRfX/9x6mKqxN2B+
 k42y7d7fU60/hgLtRJO8ii8cAgruYqOsojnJmMTYtJgHXdafg8vGmEPL1xzOk/i/2cAB7uuPn3J
 qUBPdhrRUGbKpsshOUB7X40VI7HMdjVkqgboroh8svRDQFB6rJPUcffP8uSbGIvUKwayYy6esKx
 Hgw+JRCc9hapzo+9zXWsudk75u5ltiY+LoebADIKgXQgtuYjQiE1QYKEbMUufn2WFSRLXa1A6rn
 Wn7nwN9T+fiS4+tpNpsXINmhnNJ0kYY4eE0GuRVcJ6Z5SF2go1mSSV1sMaNjII6ayqg1ZphXgrc
 1Q1REPMrLhcDsDxZFw9zDKYFUUVS0RWcnBNGOKzA10Wh/rz+jsSUHuqmq+cKUtKdofIzwfs3Xri
 uSJy6gE6
X-Authority-Analysis: v=2.4 cv=YMafyQGx c=1 sm=1 tr=0 ts=689f6d4d cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=2OwXVqhp2XgA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=Jjn-4_SfM33dySwp1_gA:9
 a=324X-CrmTo6CU4MGRt3R:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-15_06,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 priorityscore=1501 spamscore=0 suspectscore=0
 adultscore=0 impostorscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508110068

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


