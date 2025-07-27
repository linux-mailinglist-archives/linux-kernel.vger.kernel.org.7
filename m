Return-Path: <linux-kernel+bounces-747013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 123F8B12EA1
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 10:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1661F166859
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 08:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7031F866A;
	Sun, 27 Jul 2025 08:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="I13M0/0y"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27731F0E55
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 08:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753605119; cv=none; b=MSFJxStdu75UVpdXrTvLHoDFwBEUQ2OZwfPrsDBnsgWbPwPkIoTQfBPOCvWJDZRxfaw+zyh2DgIY9o6yq7hbZzvmch+V6ZVfp079b9LVUy29iwGIDtwlGyTuhBGRevCUPGSu3zcYk51KMmYEYcK2OJSyuyUQhZ1ew7yB5W0Vl7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753605119; c=relaxed/simple;
	bh=NM5eUwufs9EQvxyH72fi6ouw9HbAH6xIggTFFBsajLc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qPrgJwbFr6na+ObX90P8wBZWQ+GVwmZgGMZSAUsKVw3loRCGobtkzIglS4UtxEi/h28eQibRKDPTeiBUhlW1r+8LtzHEsmgCDif8lUGF0aWuAkhFeKdh1bYR6AuTf0rXTFVyABP2OMeGfLX4xStgDJOigE5ANgdbcDooY+O8cjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=I13M0/0y; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56R5t03l004030
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 08:31:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=AcwNi5jqAVS
	vH8zvGbAgdOcfk3Kkt+F28Tzsi0VVD74=; b=I13M0/0yu7CcEcdijMsbuKAb+Io
	liLBfBX8mE9pIsxnm7cA0XPlRLmEtJKgEud1LHxD6v62CMdmIsjel1VMYlC+raJ/
	HhhM016Kns3opK9CfDrb+QcmdV9R/IdwmzAYiZ8rAE/dUEEwawZ9EZ+FpJK5bwLl
	Xkl1kFuG0sw6Bx0BZV94EmRRaDPdCbcvm2w1kU1NqcKIYUs7vkGyra0MdfouG4lL
	U5eXLuCM0LMZ3oX1x2isFDRP0yPvDF8x3325aCC0XBpUL3tg31ABHORIsid4nXtF
	C8imaHfccmHNLePZLJBvFLWLimbARJQMF6fngCwlzHQXh+/QGYrfnQkPxsg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484q3xhubb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 08:31:51 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-234f1acc707so31444435ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 01:31:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753605110; x=1754209910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AcwNi5jqAVSvH8zvGbAgdOcfk3Kkt+F28Tzsi0VVD74=;
        b=HSvoSdEtoi8pjTBeVahTZvMU/gzsvV5feUQMWNih4nH4sc1xHpttGox2ktbOPSaiPy
         Ybem+/9Y5tT0LncOnfMfTwvybX6lBiqrYS91bjSRdTJCvp+h52soj8k4zlvQUvcebIkn
         Kfosp+ULEZHoIgiQ5g24eg3b0L40zlA3n3er3d7snaDRhYaeED5m8vd49VQZOhRnVb7J
         VMhCn3vJ09qrYCnIab4zhcjMTGhfk9cTVfAqJuu9ywglz4snmk76JG5QlGWr2otr4WW+
         uQ6wqkA24aFZwomLP5Zar5pCfj/y9TsgwNVGRMrIWGur26+RfhEvDj7Ur1EORfxOWrEV
         c2Qw==
X-Forwarded-Encrypted: i=1; AJvYcCUnmylo06WewFufAQwlVR2vxmyhZZ5nWyGEeOzIUeSxsUs85+4/LQnlTAw5Jg5x2kLZNEZJDuMJkVhf2i0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQtxgYDSukm/Oy85z6lycIreNbBOsTnFgEx1d02SnYvIm+bx56
	hmtFbm+DG7mJC0SL4ZgS3iXq7Nylkxvydvmv9svwXNwGunZGYx4SfAwj+3SB3DP31HNzcGPPW+A
	3GBrUAqW7BdHmcPo55BobqCt3c27ejWp3C2VqGe8hvgi5uAZ/JeEzSWPfvF3Ky4w6Pvs=
X-Gm-Gg: ASbGncv3ZoK+WE1QoxBKUujCHMIg1yKmR45mgFLdMufuzkwM2uP9kIzeALvZkTWMsva
	SSkYPXJJqXq9/w51PnSAaOP3uutark5km4u69Xlp0wfWY1/6ijXES7xbUUsRmK1IMUxp2xRG48X
	lvmVDHNjBWF0fOdJc0oPjjTE0Ga0Lz3pi+B29uM194gTIWjk7VdZ4cSKzADFAm6ySqVYpvbFgI3
	BQW7/EhwxFpRcDbuYxNe7uo1vM34z6dutE8dEnfBn37S4m/tpPINGxlIsgJQgWKBgQeCEo7osz1
	A8iWbfpPDWGhsQBhcxr0yj5qITZXUCKPpc5Itl5eTihpaAGf9rEI/5nyFHul2woQawWtoG5Ugwb
	5
X-Received: by 2002:a17:902:c9c4:b0:240:9ff:d546 with SMTP id d9443c01a7336-24009ffd7f9mr10052515ad.6.1753605110185;
        Sun, 27 Jul 2025 01:31:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERPCA3gFX6YamqhgdGjO1m2DVjgSysrzz5AvHQkC6e/zWEA9GvZU/sr+aJlTkVRUIhwXmMMg==
X-Received: by 2002:a17:902:c9c4:b0:240:9ff:d546 with SMTP id d9443c01a7336-24009ffd7f9mr10052185ad.6.1753605109738;
        Sun, 27 Jul 2025 01:31:49 -0700 (PDT)
Received: from hu-mohs-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2401866c2c3sm2848645ad.30.2025.07.27.01.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 01:31:49 -0700 (PDT)
From: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, quic_pkumpatl@quicinc.com,
        kernel@oss.qualcomm.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 1/3] ASoC: dt-bindings: qcom,wsa8830: Add reset-gpios for shared line
Date: Sun, 27 Jul 2025 14:01:15 +0530
Message-Id: <20250727083117.2415725-2-mohammad.rafi.shaik@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250727083117.2415725-1-mohammad.rafi.shaik@oss.qualcomm.com>
References: <20250727083117.2415725-1-mohammad.rafi.shaik@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=JovxrN4C c=1 sm=1 tr=0 ts=6885e3f7 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=Wb1JkmetP80A:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=Jjn-4_SfM33dySwp1_gA:9
 a=GvdueXVYPmCkWapjIL-Q:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: MpOF4ILxfXcrzKm34nU_omfuxQdykwMw
X-Proofpoint-GUID: MpOF4ILxfXcrzKm34nU_omfuxQdykwMw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI3MDA3MyBTYWx0ZWRfXwTNxJwxVvntV
 7tjjSLF+wHDfQiCeiX11p3ocIKoFXHk/GNVl5m9OSrZclneC9DQT5Klxn/WPJTizaiLfj2bLnhi
 ObBR653/ya6+h9aA2ovUXsPgA3oOf/rAx1DhL48xeU3VJbrEOjfVPPssoYEqzh0NaUdg+ujMRXN
 EGMnL8g5jesG9Era6zasl7CcTohh/51iS5zmXbCIp59rX8cqcK/xiVZLmW/vO9qaG4Mzc3GryZs
 O/vzh13p6QEobO/Mh8zR9wNWPBjR7PjrrwQmKtiOqiJodqPJB9LQxH3YMnZFdfV0Yh6sdIfzqkG
 Jwx6OKJQMbcbQVz00d8Di3VjzO/9Pe58OHsBsuhR0YQv0LeWM/O5jxwOdAI+EKVN1A8u0OJFxa1
 m2vIQtLJ7jMirDRfLf0m/HAD6BNNMOy9hxTiuth8bW8nPmb5iR0q+xHBRS9nanchembdCcgS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-27_03,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 bulkscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507270073

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


