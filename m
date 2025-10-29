Return-Path: <linux-kernel+bounces-876642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0DCC1C048
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAFE496193F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4813559D7;
	Wed, 29 Oct 2025 16:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Fp4KlcOi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YHwQMDMk"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F0134FF4E
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 16:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761753690; cv=none; b=ojM/v1EtddfnvgvShmy0Fxp4UuXx5zYu/vE4EPiztDHC7Y1ANyNSBKyv11XA8jr2Up3p9s0323mQqa0665CXt3Qc68T42MP5ThLL/RU20MikpHHjUI4U+DDRjeiQHMu8de5VHVnevNjXxAtilOgV2HriSMgqyHlZqK7abkvSxqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761753690; c=relaxed/simple;
	bh=EKU/HsGn5C1um2y0d1RTOlDdIIAAM6JbAG4htV2yCb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uveiy/yAPCueMzYvbVFNzBLtU1PkjvX2sLI1TVUbfbrH1+8TENgo9UM6W1DbZoe3ty+5dS+5+A4imwjZytIbra7EU9QWAdFInbtIuyz1Qpn/1AT3RoNDx1ND+httBexAC6lVq2KJCdgzJeAfbjY49PI7ylCRayWAMRFyTDsdZVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Fp4KlcOi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YHwQMDMk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59TBeYF0435432
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 16:01:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=IEq2aSb00s4
	qKXheRiZL2KxJNF7/Ul190P2t2smNwvw=; b=Fp4KlcOisn08BOseA3d2L7cvsCh
	+XpBrZOspxy9+Xgbu+dU0wa2K2vKPOtqFvNgvjGeX50hQCwyczD6UPIKVci6Z8yR
	LtWEj2lBNTTCQRvodytoceCXnPiiFH/SnZn8F5nGAujRGdkByChv05TrW9Doe+uG
	u1RqPO4OtY1SDq/73NvjxToORamprtc6h+sFnF7b+lUqjofQglI6yPagrpVYesRb
	il4Mzuc5mdakde9uvcnyJ/P+oUBOxW+vXKy+EUWoedtlO4XOqHfOiUNRnlTUy6zT
	0tK2zzEnTfwMGT4Z4qogmS6FeLSUBlyhqs1eewbCdlNn1vGC32DV5uT42qg==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a3j8jrt5b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 16:01:27 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-557b7fb8755so16255374e0c.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761753687; x=1762358487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IEq2aSb00s4qKXheRiZL2KxJNF7/Ul190P2t2smNwvw=;
        b=YHwQMDMk7FT6G1oz2wu1+zFIaFhwT/dPia02csxOw78QrnVBMPcYqzXJkqJmmRpqn5
         4XLdiCY4SeCYs/Y/5ruZessqFpPtY7F/BTumT6KHLt7ErPQdew3Rk7JECmcHwiMz80ho
         5wfEjrb8a/rZhOrX6nQXIJRZlcewutzb4a83ZJuTxEMX42PBG7ZH+DiSZlLYJ7w4TErD
         QvtZ1Pft7LbCeP5v+AA0ZKQMQnc2MzgeiclSAN66LusjXFLP/UvbfHyEjkRfQJH2l9P1
         yPgo48Xl9tqEv+0KANbrZJFCwWdGGNy6AG8npC3cC6NLXM+GAFUrJIMZbDtDfQ1VMlab
         gZaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761753687; x=1762358487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IEq2aSb00s4qKXheRiZL2KxJNF7/Ul190P2t2smNwvw=;
        b=YftlqPvafV38sdGSh/Uj253yFLZi7SQ8BldMvfM1SZjT2bcDYhgpKH9F2GVHsHjNdo
         t3Ua8OYZdrDBPIZMBt5VHGoTDFdq28ovC3O0fArNCo8Fn7f+irc5BcTJ7LgH1yJEL6/H
         ylHW3SK7DG54wzUBj57t6CB2e/Pwuy/keF4McloDOXKpcLrULdNeqazl+KR27OWyRl+H
         sDP1VfMucVSzddW4P09xNwwV31ZEkmacUhhJUEr0WBD15qxbBmJqw3MV7Ge/1ECBYJUC
         q8Kj9HtXeP798reR7tJp0Yb2u9LCFd5Rr7s5TKH73jwhcwN3cT8XSDOk+x2ihGbGoTq4
         ppIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmjdwquIB7IjgrN0zVloCL9bu8IArou9PX51/haDkZ5kDSOUTrea077EZhaOExKVBVh9AbRsTl17tgLAE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRTqKhgUzY3fs417x8Yo1dQJcH/hdo/frvHtDwPLY2wM4gEYsc
	oSNMgIsAO2a53k4tnkImtQNL56taSzqPqfvASvfhtkuANbChkk0XAXNrlxLmXkdhI7uj2Xxe2xW
	XYTHhcZILmAO3lIfsSvrWu8BgoXMTCgzYcngjWu/wG3sVeCIurqsaxP+Q8u86epSlfHA=
X-Gm-Gg: ASbGncumc53uP6jCbl+rlxQ2gOpfhuXBXiMCfb8jfREcQTMrAOfiobSkyEjqGH8a31s
	YCPx2DQl7kRpcAx8jUy6AXFk03jRM+CxspV2LzB5MXchhm7kt1tbHAbS/fsKPorRVviF+9UAMW6
	vy005anIY5UMT7LYt3qURiwAWzLJkYwVinxPmqeQHqRBDgoFXwuXs1t3HAGTrEZG1CZz1LA6WZg
	d4o6HDoSJLM8hvoT7whl8CH4GGgTqU12gcNRAdj6of46EFGCKXa6y+jOBlA91fFb3CExlxgb/4U
	q+sRpfBj7MSzPG3NrtkaoV/RDjDzUi7TQuhJm1It81ivIHo772Si59CZLoaN1Hagg4oNpJDwoAY
	FfLQ4JvifhSpP
X-Received: by 2002:a05:6122:90a:b0:556:97dc:4a83 with SMTP id 71dfb90a1353d-55814267160mr1315489e0c.14.1761753682116;
        Wed, 29 Oct 2025 09:01:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3Y9WaBzilw+bQFAcYPxp8fJjA+27I+dMEnAhZub51yTwrAHnCEemtfq+h8JeZrRrzVZ13BQ==
X-Received: by 2002:a05:6122:90a:b0:556:97dc:4a83 with SMTP id 71dfb90a1353d-55814267160mr1314998e0c.14.1761753680063;
        Wed, 29 Oct 2025 09:01:20 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4771e27f7b8sm57154535e9.0.2025.10.29.09.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 09:01:19 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: robh@kernel.org, broonie@kernel.org
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
        perex@perex.cz, tiwai@suse.com, srini@kernel.org,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, alexey.klimov@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH 4/4] ASoC: dt-bindings: qcom,lpass-va-macro: Add sm6115 LPASS VA
Date: Wed, 29 Oct 2025 16:01:01 +0000
Message-ID: <20251029160101.423209-5-srinivas.kandagatla@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDEyNSBTYWx0ZWRfX+Rq2FGaB2TD0
 q4HvWIjAMY0QH9v55s1NJ4vKjh/byX6AsCPGHqTL6iE7ST0Tm8acKGVTqIlFSH4s+g+UYxjH8Cd
 vZjBQbnEJgIohp5Yhsumv3heTUJh8M9+gK7FNw0UlOyQe7kasbMLlvjs2CuxSReNbwxbByMfkYR
 zxiL/BnKAB1f2B4he7iW5fao6v/5CJv2v76PKD6rKJKB0sdICDJSr7p7aI/ry5qE2BeP7CqwJO1
 sx63WLv5Lt4ScnNGjJnyv3mHTUI+YWoYxeCgXWJgj/1a6FjGGm0bav1kOZwFO+dKqDmDUFqAtOg
 RZ7d7i3WbdWHMPzMSti5ISGvFH/JKyJUiZWVza+dPP5oo73InKjq3wQT1jBGK+DhuND3He9+yhk
 rTY+N8DnC735Tcm6m1eaUskMsdNW7g==
X-Authority-Analysis: v=2.4 cv=FOoWBuos c=1 sm=1 tr=0 ts=69023a57 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=0AadgyblTOGOoKeRh1oA:9 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-ORIG-GUID: LKVCpzo33mXatGsp-T3VViUfVH0YoHmw
X-Proofpoint-GUID: LKVCpzo33mXatGsp-T3VViUfVH0YoHmw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-29_06,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510290125

Add bindings for Qualcomm SM6115 SoC Low Power Audio SubSystem (LPASS)
VA macro codec, which looks like compatible with SM8450, however one of
the clocks macro is available in this SoC. So updated the bindings to
allow min-clocks to be 3 to be able to use SM8450 compatible for
SM6115.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 .../devicetree/bindings/sound/qcom,lpass-va-macro.yaml | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml b/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml
index 5b450f227b70..1ac3392776ca 100644
--- a/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml
@@ -26,6 +26,10 @@ properties:
               - qcom,sm8750-lpass-va-macro
               - qcom,x1e80100-lpass-va-macro
           - const: qcom,sm8550-lpass-va-macro
+      - items:
+          - enum:
+              - qcom,sm6115-lpass-va-macro
+          - const: qcom,sm8450-lpass-va-macro
 
   reg:
     maxItems: 1
@@ -44,9 +48,9 @@ properties:
     minItems: 1
     items:
       - const: mclk
-      - const: macro
       - const: dcodec
       - const: npl
+      - const: macro
 
   clock-output-names:
     maxItems: 1
@@ -125,10 +129,10 @@ allOf:
     then:
       properties:
         clocks:
-          minItems: 4
+          minItems: 3
           maxItems: 4
         clock-names:
-          minItems: 4
+          minItems: 3
           maxItems: 4
 
   - if:
-- 
2.51.0


