Return-Path: <linux-kernel+bounces-876640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 420B6C1BEA4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:05:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 84F5C34B393
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7964835470D;
	Wed, 29 Oct 2025 16:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cOTLRBIW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eBQ1l0eU"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36222354AF3
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 16:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761753680; cv=none; b=tTMHflX2Yi77q17cUH6UbZvZkcqmRjY02InldxL1zEXBl4E/obAeejMALEVVI0XVgb6ZS6oQy5E8KWLP/uMm4aKmBzwoCxbAlf8hQXoJS+59wJy7ozZnZ6/JgEpoCNz51jVL1Zwtg63tyBinnT5dAhHO4Mfr7LO2a8MnySuIiyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761753680; c=relaxed/simple;
	bh=emhALl942H3lDPK8rcbv0sOb2ovgQxu1VqmRMFsRjcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tp7sD9CQ2PUWvs5qeDlGqhoPWLYtTd10/ZRtATONrNs7yw0y3w7MxYzF+e9tiNuE/Dhg3O9XbQqeavyQs5iZJEpZAMyjiYld44nMgR/TFLvKOT0H+aqeFYQoY4Q6LYBgctCovSXdTWg5XI0fJeaJaSlYkR6Db2qu3HO7a9z60cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cOTLRBIW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eBQ1l0eU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59TBeGDj435098
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 16:01:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=MiehR/zHYH3
	DNrg1Zd+xw78LsI7244OS19/slPbVvZI=; b=cOTLRBIW7bnHGKxAjI9tFkwG0Uy
	DP5728IY+c8nUiJRB4U5rBSxLhwG9v7gsjbvZ+BJVSqN1O7/qYUpfKilUUh3m9Sw
	kAAROdE4Wr/KKAhQEbbfGeu/DGS0/RiQwbPckxNFYMdt4uhkb1iKCmiGUMOZnT8s
	RPVBuLhL8zgMqpp7aW3sM3UCk//6XD3Es2twVGs+kot/kQ0KUv5xFTxkLnnu6UE6
	ods7gzO7gEjBGMiKxyV9yFNVtrioSPrx3tJgZoTSHKRH3J4ygzJ1gjkEwSIptqdu
	QksEUJ7jpqPTRPipdkp6nVX7BtQd34zrsaJvu628GbNmSox5ePgeV5d6QmA==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a3j8jrt46-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 16:01:17 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-54aa7b50e26so9008e0c.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761753677; x=1762358477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MiehR/zHYH3DNrg1Zd+xw78LsI7244OS19/slPbVvZI=;
        b=eBQ1l0eUMlfodgAmG9SvIFjFkb/vA5BtwMmFYZl1eUUGsP6yOEYjRhndKGagNdSqm4
         v7ASTZHnceNB7wnfQirTz+Bhx46B2Hknr0zpvtz9XpvBU+hxcYnTMUFWxr7/LCTbFrIR
         Tw884OLgonf5vhk96DpE7/cc6v1eQ03c5/slPqhXviLahQ+iMb1mXdwRRVtjfB4PK5kD
         AbUqPLgg+WcGGPwmwkty9laAveEecsmuEzP85cBo8YVSmAQqnBzOmRpxJKu9/rkBWnDe
         IAXwH9rs7U+hHUUF837P8aS9m/TsA3/mA8crLqGUn+Ph12LXZ1Dgq2tN1SBRf460oUMC
         F87w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761753677; x=1762358477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MiehR/zHYH3DNrg1Zd+xw78LsI7244OS19/slPbVvZI=;
        b=L+fvd6o+kzT+RgkPMeQeoq4xiTU9Gzy24sK8s0dxCHoQ8ep1zB5z1FD6iCqdHaB5fr
         u1jrjVW9MZc/OzWFBjfZkgFZTilSEG8LOIAgFAbD8ffQCto9co5HkHLQT/Cr6aYkL1e+
         LjhL8nJAWyyQAnliM1k4cS4kpCJkQJBrngUL1hVN0M6gnW5g1UjTzmMgfszeU9se9Wnl
         P0Wb2F8knhTaNmYMVyYDaKXF+1Ey6Kqz0xeNkXbmCHfVRjmubJhZAM6xTGwntt7UNADr
         7SWH2H6duSFaDVfUFnGDBPqF5VuY8YUnypwQO0YQuvXqlh6Go1N6UmmfPW17ADz/1jA1
         SElg==
X-Forwarded-Encrypted: i=1; AJvYcCXuQpYYhCuv0b8I4K/j7ngTTAL/2mAtxfXWUazhfPFB1rcHwoC/pU4KfiZ7W2VR9cE6WKcOGDyf26myLxw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiJtRrBr4z3ChHNDwUlnkbPdppHFHAWclJy4IUt85jVL0MEd45
	am4rOJNAYX1wOymARdrg4cEXqaPodCIgsmdqSXuF+TCyuj9cHen8Lcx+b5qGTTs3x4Z81QoFVze
	tZx2K7iS22MQeut2CX1cj9fd5/tHY3zSO2bzSbj7AhkszsjJXU4rUu7sXHcjAntmxu/c=
X-Gm-Gg: ASbGncuu531Ud1Hk/DA3GAm+RnSmWVJViMES7i8jkTtamvSY2MD4JG63fKH/Zos05sg
	4jzJck1B1Z3nGozMIXGvNZMbJDki8BdaBcBsBdQQ9qExJhjA6WXX1bj0xHJ0KjxfExwAKWBHGbP
	RgdstMby6IpzprKgKBKkEID8K2fuWD4n4b58MqYMwq1sTk1KCg3pJtLA+AiMOb5mOh9/PZz2Ev0
	rehJzUaqGArhhw13W2jeWKrGtrsPlOhqPxin/8tdcNJRH3Apd2Ry+cenxK8iAnd6OR1sY4LZC7B
	CTZQrT+Pcy4VzNBRlnY4Qs8q+bZxQdmUCl3f4vkYTRbEzZqlxoItRGTP2sg9sdwiotMOx/jX3lP
	VqzoG3u+Cd0/o
X-Received: by 2002:a05:6122:201e:b0:54c:da0:f734 with SMTP id 71dfb90a1353d-55813ec34a2mr1158781e0c.0.1761753676883;
        Wed, 29 Oct 2025 09:01:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnL4ne9FLkQ/VZ3estDP2bnXka+Spc42s99A8l5vSxio3Yq7f+MpwzMX3IWzU7vWy3vH7Mig==
X-Received: by 2002:a05:6122:201e:b0:54c:da0:f734 with SMTP id 71dfb90a1353d-55813ec34a2mr1158485e0c.0.1761753674726;
        Wed, 29 Oct 2025 09:01:14 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4771e27f7b8sm57154535e9.0.2025.10.29.09.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 09:01:14 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: robh@kernel.org, broonie@kernel.org
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
        perex@perex.cz, tiwai@suse.com, srini@kernel.org,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, alexey.klimov@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH 2/4] ASoC: dt-bindings: qcom,lpass-tx-macro: Add sm6115 LPASS TX
Date: Wed, 29 Oct 2025 16:00:59 +0000
Message-ID: <20251029160101.423209-3-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029160101.423209-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20251029160101.423209-1-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDEyNSBTYWx0ZWRfX0xXVDa4wmt2a
 JgboF2pUlhP6TNRk5+GKyWcZ11xsH0MMlOesAlyVqGpPg5vBbYWZC8SYXFcwqaT9KbWlJufz1RQ
 ts5C2sVwvcFRFhQTk6zWEkIz5+MkfAteJc7u7eIgR2SNGA1sK6it1D+8Nrpw1Xpq3oIQMK1nyhL
 spZS7TEg3HUh3+ByfYreXL+hw8EK6uYy3wpuZDUbWbYeRbENUgzdGpZtAkebo2p8xqx5Ewxi4XU
 Q8wKGQaZOSOM44fyC5FmwsSD3prKjkUb1HHNUBP9SdpLh6lAgdUoLjTdom32pXoN7zwc0E4fMP7
 xJ9koGKTEB686hDEWnM6pT/o/WprNcPdqnReY5U7mhpLdFy715IV8Dmntay1vGdMlx4fQnORlZ1
 Xnd0c2I4Yb7E40t39vH0bvVxhfAx4g==
X-Authority-Analysis: v=2.4 cv=FOoWBuos c=1 sm=1 tr=0 ts=69023a4d cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=ggwc2drRBbIiG4O-mS8A:9 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-ORIG-GUID: cLXORXf5-7zbogyryRzX-lArG7zusam9
X-Proofpoint-GUID: cLXORXf5-7zbogyryRzX-lArG7zusam9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-29_06,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510290125

Add bindings for Qualcomm SM6115 SoC Low Power Audio SubSystem (LPASS)
TX macro codec, which looks like compatible with SM8450.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 .../devicetree/bindings/sound/qcom,lpass-tx-macro.yaml       | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-tx-macro.yaml b/Documentation/devicetree/bindings/sound/qcom,lpass-tx-macro.yaml
index e5e65e226a02..8dd8005d73d6 100644
--- a/Documentation/devicetree/bindings/sound/qcom,lpass-tx-macro.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,lpass-tx-macro.yaml
@@ -14,7 +14,6 @@ properties:
     oneOf:
       - enum:
           - qcom,sc7280-lpass-tx-macro
-          - qcom,sm6115-lpass-tx-macro
           - qcom,sm8250-lpass-tx-macro
           - qcom,sm8450-lpass-tx-macro
           - qcom,sm8550-lpass-tx-macro
@@ -26,6 +25,10 @@ properties:
               - qcom,sm8750-lpass-tx-macro
               - qcom,x1e80100-lpass-tx-macro
           - const: qcom,sm8550-lpass-tx-macro
+      - items:
+          - enum:
+              - qcom,sm6115-lpass-tx-macro
+          - const: qcom,sm8450-lpass-tx-macro
 
   reg:
     maxItems: 1
-- 
2.51.0


