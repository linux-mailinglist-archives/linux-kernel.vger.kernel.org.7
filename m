Return-Path: <linux-kernel+bounces-831428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 887C2B9CA27
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 01:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F997327CD9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 23:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA2925A34F;
	Wed, 24 Sep 2025 23:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y85xpRhX"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21F42BDC04
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758757054; cv=none; b=GDpOnq/33tmA6A7mb7kjuUxES2XcovxAVROZJ3DPRH3lZtbdw9RijESa2Zvg9JjnbvFfmOLSPac+6QLeTSftU2qvytbRcg/lGQ9rBFotZ9byYk3x1gqXHMfzVHFI6GSH5Ygxi6tDH+Q+vYYAw9eGthy48tLQj8xeFGlQz5PsE5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758757054; c=relaxed/simple;
	bh=MbxEjMIaUENf1P9WEPkEfk2L22A1VFwABKvQjLg/Xoo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RBEBMhuY2RnGwLrdSxGbBi/Hki+e0FBvDm5tVE09mot4IcoEzEeN5aBXv+gjUfg/XonmU2IiWsIFiNNk5zGm3wgo/ftRzMuZoBs33Wx96hYeuGiOCabtPxSKknDapZEa5WzV7xyuJHjv3/TOdETVv2qhb8AMp+yk1pEIH6j6E0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Y85xpRhX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OCoZHK016452
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:37:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	feXVGRefITNODxeUJQMMl0Hw7fIAFVpnWml1r8rDvSc=; b=Y85xpRhXsG36zo6E
	0DiELzQtJBPqZexV9b+Eh6lTPaEtwMVostvBM38kfU6jTjjT3AZHkaPgcR1nN3Ij
	+uk0hyR0RVJPRxMOR48Rl2iO1U75/nqRQk4WdE8gQaqV3jL/j9wUo11TQBBhgud0
	mEoY9fIqgJ7DBQsKqU8rDktanUB8wjgquC6smOV7NVnBZZ3QHq+Ri3HEdVK+Sw3J
	GkIuKneaDBBSamMZDBno6dVB6ar7kfWCYUh2Oy/ufvJbJl2fhiAud71On0LmypQ7
	gpEE9d8KWMhBOYLrOLCvJFqo8l1XgyHqj2+GnyQyUzNCT6dbNTDHa+YauhSQNbat
	/1Rmfg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49b3nyhvbc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:37:32 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-32eaa47c7c8so347750a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 16:37:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758757051; x=1759361851;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=feXVGRefITNODxeUJQMMl0Hw7fIAFVpnWml1r8rDvSc=;
        b=Fhum/XGqMT28XHtgadwONDYmXgkzxRCWPL1McwwugNRnifBThb7A0mddaluxhLvaMu
         NeD31F5YAEh14ud5KwENtYLY3g1QbodbuPrZipQ+auDLDErXPLhVZFX7ewk3fiiR1T9k
         zYL9puPk5aqlZTn7xHpaBCAA37j8DZ8o+vnnrIcNI6uQlVSswGP8tAI+luRJOFZELVHT
         TDr5izpKpg+OmDxEqdetBKQwdZqQzCUkxkQSTiYMuulzn4EWlI4BDwVBBy5UbJrhnA8a
         6htgh5BalVtskFY7LmnTw03FI0Z/gB2BhW1H7vqI/9EPBiQljGc04saI23N8CtP44vTM
         y4mg==
X-Forwarded-Encrypted: i=1; AJvYcCVkW/syZTp86fOjG4kTRBu/00Mm+qeE5+GOX/Bx0+Ff8vm+N0RnwU0Ye90CiH/DByZfwW5uQvIuI1fzTkI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywcvu2Vc+OrsgQdQX2MbyV9lKVVvWHIx5CIhPi9AkptWkvdbupv
	EQDfQ3DOkJx3SA9doNuNjoy4w3HE3P+v85cRy9N5N2EFmVNxt8xuhLf4JfM5pJPO7A3ywzp4OUn
	KyaXGZB7Urp+KWwQSFCQi6g6aaRB7SawcbQi0P7aFeOXQgHu54zfIMSa0g7uXe29KGW8=
X-Gm-Gg: ASbGncu8F1etb0wdcTTzPu/ptRjEtEFAdWjZ3DakfF8X+tBdx0s/zSOUDHXIfzZXXxz
	2u+QXJm8+LYFfF56A5wk/UvRCbqry3wzPdvlQzJiuwTuMHfZiQUNdZtcn8pbcJjQCQgSJwnXDXl
	pC3qlVgy8/D3+hLEE7pbvGhvnxLevdM/B7ipqhZ0WeZDDjXAPtYFWyS4wFV73USrhsCSeDU4rHA
	pkVphSi754WksFHmTJQYsDHfErPs0skhqHkOALdqqOoj9xAe5/sVeUuQmlFPnHB0g9s894vGHAR
	7Nsa6v5HZAqx7piqVIbG//Vmh5k3Lhc7nFpNEtAr8tkJQkSFeHtyQP0YexIucQJFvA9mnWyiTYZ
	0SsYzMZ3uGbXEjjg=
X-Received: by 2002:a17:90b:1b4d:b0:32b:aee1:18d5 with SMTP id 98e67ed59e1d1-3342a2cb650mr1454583a91.29.1758757051230;
        Wed, 24 Sep 2025 16:37:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFb0KpgTvAPWQG9YQkzgc8DpK2qH8dPaSgf4xK0XteXzopA5zzTkpzU7C5BCgrqm001OepIAQ==
X-Received: by 2002:a17:90b:1b4d:b0:32b:aee1:18d5 with SMTP id 98e67ed59e1d1-3342a2cb650mr1454556a91.29.1758757050772;
        Wed, 24 Sep 2025 16:37:30 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33471d73550sm227187a91.3.2025.09.24.16.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 16:37:30 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Wed, 24 Sep 2025 16:37:23 -0700
Subject: [PATCH 2/6] dt-bindings: remoteproc: qcom,sm8550-pas: Add
 Kaanapali CDSP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-knp-remoteproc-v1-2-611bf7be8329@oss.qualcomm.com>
References: <20250924-knp-remoteproc-v1-0-611bf7be8329@oss.qualcomm.com>
In-Reply-To: <20250924-knp-remoteproc-v1-0-611bf7be8329@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758757046; l=1455;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=MbxEjMIaUENf1P9WEPkEfk2L22A1VFwABKvQjLg/Xoo=;
 b=42zVztKkOXeN1S7cXzjNRiEnLF4tGM0ToLX1k5yT5lVTdwOtBlNJ6D7wBlNwRkLIlOLGE6QLE
 d2VDs9mZdZnDEaV0TGMefSB5I/ua/j6CUQLjo0QfiLdd65ktRjM+9xH
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Authority-Analysis: v=2.4 cv=EuPSrTcA c=1 sm=1 tr=0 ts=68d480bc cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=fQzFCQHg6D5FrR4bPmwA:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: ISqbyr5vbHF9U7N2L3M4wRChiRclSXPx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDA5MCBTYWx0ZWRfX5J/bwf/C6Y2z
 FPasdlTDDmE7Y/fxSp64ZcuVBC7UBS1e6WdnDiWBMPl+l+N8WeNEVC0sQm66qIHn1KIh34P6s8W
 BnNGudZewWNDHIXfnBbX0VDy+zmOcwosi2ItovzkltD/W6vtdxxduBinIHfzRUH0zxYlfkXWn2V
 Jo4lyXD7vOd8VjnhhfM/10l1kT/4njEEBbxRe6tGehHOEDPFYjW4DVBy26zyLBIfcIfHhFjK2s+
 ywlwxdhOIHokt/7Pg1MkqU2VoYacBuaC/DKzE43vFElWv3JaJyzK/ZfWQpUuAn2rVQubTo6stf2
 Xk59PlFbsNs4MWKnZmzuSKGtaX8EKkgtd8JYSLtbaXkSgURk+vXPcVEr2vs/8dkfoFoY+J+zrCN
 85Tv1NZr
X-Proofpoint-ORIG-GUID: ISqbyr5vbHF9U7N2L3M4wRChiRclSXPx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509220090

Add remote processor PAS loader for Kaanapali CDSP processor, compatible
with earlier SM8550 with minor difference: one more sixth "shutdown-ack"
interrupt.

Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
 .../bindings/remoteproc/qcom,sm8550-pas.yaml          | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml
index be9e2a0bc060..031fdf36a66c 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml
@@ -35,6 +35,9 @@ properties:
       - items:
           - const: qcom,sm8750-cdsp-pas
           - const: qcom,sm8650-cdsp-pas
+      - items:
+          - const: qcom,kaanapali-cdsp-pas
+          - const: qcom,sm8550-cdsp-pas
 
   reg:
     maxItems: 1
@@ -107,6 +110,22 @@ allOf:
           maxItems: 6
         memory-region:
           maxItems: 2
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,kaanapali-cdsp-pas
+    then:
+      properties:
+        interrupts:
+          maxItems: 6
+        interrupt-names:
+          maxItems: 6
+        memory-region:
+          minItems: 2
+          maxItems: 2
+
   - if:
       properties:
         compatible:

-- 
2.25.1


