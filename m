Return-Path: <linux-kernel+bounces-880120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9F0C24EBC
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 13:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 15CD34F3A13
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80BBB347FF3;
	Fri, 31 Oct 2025 12:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="K2u8DiSD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IFTGatTS"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C595347FE6
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 12:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761912459; cv=none; b=HMLGXrryMHPOYZqYw2y68+AL5b9tfzobRzS9fnArUDHfX/Fuxvg9gFCrI9r+3Yf+1oI0l+dJKSAIM9AXs6jgFAB0VfZeqHKbZck/lsZBogYIhinWwY7yTF6lpL7wX9GgsNWCCbOyEADpShmnFGUy7fVgqx5l9DluSYPkbNcZxgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761912459; c=relaxed/simple;
	bh=sOQOsePjYlM2SdUmv8lUrLY2KaB8teOMMCQg12ut7nA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mfpd+ZP7O9mTHxQgBgGKj2Uzc9mYMVEBWkBEJza52mH77q6Aey+Yo9ZMcczOi79+JvBS3fsafp+269/n/WHoG54V9T66hnLU3cgEVxkZLuHxxosUvTSgwuM7bs4eIAnOZbxDdSkh0FkljPHxuVEq3GiNH9sbh5tG9gVvsdSR0Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K2u8DiSD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IFTGatTS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59V9nA8r1416943
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 12:07:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=j1FjvgdJcCM
	iQjsMtzDEBVWbE1HV5FnpJ02ra3ujabY=; b=K2u8DiSDcs76r14JBy2xvX4pgaf
	eePHSlAzFrlVIBlKK7g83FIcFVgmzsMCaaPpX6GNLFOLmdGuepu+fVK6dWu4PLqi
	ZvNXycHhrmYZ0SwAtJU0WVLAp/4ewC8qlYdvYJnCzMfE295fy+Xa+fVphOhmszNF
	+4Rj8G7SHptRCnWCUCPE3Ovw/OyfSbvKsb2QYZ9IcxolusZ8kMQNVQvzO1zF9u96
	ufy1x/xtW6mYeU4OGSD991PEScc9V5DMRUSda0fM0TsfwJ0gg4t3fcVWgDFLdZuc
	sXEeh87W4u7i+MxZwraKBsRhQyWyK/OS7sKMs19awDPMiyedgQR1sjAmbPQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a4k69hnae-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 12:07:37 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ecf5d3b758so39345781cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 05:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761912456; x=1762517256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j1FjvgdJcCMiQjsMtzDEBVWbE1HV5FnpJ02ra3ujabY=;
        b=IFTGatTSZb5io4Edoq9MiBsXftmN0SDQhyf1Fk99zKjCP9VQbE1tg5zahOLvrX0jsD
         gom79HhYlMQxJAbInLOZJ2tybGA3KDrFwsLHMWI4esjHE8lBUfaVvk0o+qhIXmCkxAPz
         W3allLBxqETTYV5hbfYMHzYjJfT71tjkt+PnV1cjWAEWootmvxy0fS1fnoh1dUZI1FPU
         OPuebDur+2yEPUEYDtz2YjmEdeyDX4QO866ZVpFy4fuG3XS+qnrEnZlRguX/dlxuHv3x
         FZVJzy53gq1pI31a6P516RghafDLOcqA06Kh7S7pZ1xwSyoxnL24qNLUbcgloxLIDoKw
         v70A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761912456; x=1762517256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j1FjvgdJcCMiQjsMtzDEBVWbE1HV5FnpJ02ra3ujabY=;
        b=tWzr7+Jk1k3CqWdP/CXYQh9cagT5Z9PPQj0PBZ3xKErBlli8Kk44HChiIizxZ5Gcur
         BWqdpsnw63Pp+1IcaquzGWM5GVJLzz59GGLaB9WbbaxFZJqt+Ihe25GakaQ+SHJ1p7VS
         Z+5koPMqvNECKhNnawgG4tdTUt785UysH1/A3fyMiC0WgS4c5BtNFuNgTCPH60fDc28d
         luIfH38BEs1isW3FER72oE1rS9qt6B1gcQXdJk92Lgi319Dv6w0ipMUF0yPmtfSCt0/a
         +90mwhf/GMfqpwfrgue7sDR2JbxFfO6UVfdTYyg+QdpEAq6hk3WT9JV2hBFsTINYyiGg
         zurg==
X-Forwarded-Encrypted: i=1; AJvYcCXgyq/xRnAhPW1/FMPlJqPUZHKNhggBFboUwEkPge8xvzvjKkqJ0kwN/37yAzC72+oJDXykmnssXoIc8g0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaR8F/BYNFH+F/N5kD+Yif76tAOIoTWrjds86QumMm56oUmO2E
	blg/SXADvJ0vMBrknLYzvlcfx4V6hRWuPuJ/DvJVIc1h3Zvna1mRLbwGEHavNvMU9UvOYussbKe
	bcKzEXp3ZE/+ZCZh/UfdH+A/Xc8we8Gc/ONBZstWzPUEjI7z1IuHhvF36xqRPie4s0KM=
X-Gm-Gg: ASbGnctqz4WzIxp/THw5KX4mP1raFfDYKETF+xTYSuzfSSgEtdk0wZsTddZ31mQ7lDL
	VIB0gSd3BcCkFzvSQ6a0LB9HeVTOIWRDfA8r8ssu9YxNVuy8KjaTOmmjKCRTNKV7Fys5Ke74dkZ
	ENQ8e0SV0xgFKCrSCK/Ap8SgAy+mirgBEyh9Q1CVGSxowfDnndbFmAUxLiTZlvNWGIvCiioukRC
	xO8KM+kpiuPX/d1zwPLg8wPV8IRGxUpk9q+nMCqHZBNzWKuRe05NEdrU/14MmNfPeSV1Jp3s6ql
	RsfdTCuaGk6eRn+RzdABdLSf3bNNkut9C9kHB648n9GwTgofOK6z79wgp/oM4XXOYDK8VeqH9YX
	hIWqrdgObTAWt
X-Received: by 2002:a05:622a:480c:b0:4ec:f634:7966 with SMTP id d75a77b69052e-4ed30dccfc6mr45714811cf.23.1761912456503;
        Fri, 31 Oct 2025 05:07:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBnzrTnYPLE2IH4J5tqf7U+h+V3pAgh1vyeu2UR/XQoXDi5qUOwPWROjLqiCxAElsaJcRN3A==
X-Received: by 2002:a05:622a:480c:b0:4ec:f634:7966 with SMTP id d75a77b69052e-4ed30dccfc6mr45714221cf.23.1761912456103;
        Fri, 31 Oct 2025 05:07:36 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4772fd280fbsm21273995e9.5.2025.10.31.05.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 05:07:35 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: robh@kernel.org, broonie@kernel.org
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
        perex@perex.cz, tiwai@suse.com, srini@kernel.org,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, alexey.klimov@linaro.org,
        konradybcio@kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH v3 2/6] ASoC: dt-bindings: qcom,lpass-rx-macro: Add sm6115 LPASS RX
Date: Fri, 31 Oct 2025 12:06:59 +0000
Message-ID: <20251031120703.590201-3-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251031120703.590201-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20251031120703.590201-1-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDEwOCBTYWx0ZWRfX0wr4Do5IDZA/
 Mq6GZ+SichYaBr/Mm9OhZwXEcQQCLsOt8NEsp4jLisI29Y0WQk+ErrsUxeKTaMTkfwL5baaTbWr
 p1r+0NwQ9109MwuqmxbeQGD3zuAyqNXobmzf/L61IOH/eKARgtPUfkCtLHhQa3z+Q0DYozFj+vS
 WxgQnw+A0VE0hKnHg1DuWNGlvWX8aYZ5RWM4EFne3w3LWgJFppMBBSQdsDh5crxIgtGG17BbG2f
 nSL5+03QQfuB1Z5e//LDKaRe+0ARla1gXXEpUB0CPTNwN8/kPqgY+L2MLXf0fshVwp53A3OJuFT
 bVTOVag6z12Y2OWAvvuLmdGCv+cp8sqbYb8hTeDJed1aDXMqdDPW4DxYvRtKg5nVr9GeDdGbNJE
 PNK2rYAsoq7QEYw3GOL3UGiCRFVMEw==
X-Authority-Analysis: v=2.4 cv=Bv2QAIX5 c=1 sm=1 tr=0 ts=6904a689 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=Vptr8DYYLnhAWPBg-1oA:9 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: I5qKEgcb1WQzw-OS5pMN5cq783cUWlsD
X-Proofpoint-ORIG-GUID: I5qKEgcb1WQzw-OS5pMN5cq783cUWlsD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_03,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510310108

Add bindings for Qualcomm SM6115 SoC Low Power Audio SubSystem (LPASS)
RX macro codec. This SoC does not provide macro clock so reflect that in
the bindings.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 .../bindings/sound/qcom,lpass-rx-macro.yaml    | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-rx-macro.yaml b/Documentation/devicetree/bindings/sound/qcom,lpass-rx-macro.yaml
index b869469a5848..2eed2277511f 100644
--- a/Documentation/devicetree/bindings/sound/qcom,lpass-rx-macro.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,lpass-rx-macro.yaml
@@ -14,6 +14,7 @@ properties:
     oneOf:
       - enum:
           - qcom,sc7280-lpass-rx-macro
+          - qcom,sm6115-lpass-rx-macro
           - qcom,sm8250-lpass-rx-macro
           - qcom,sm8450-lpass-rx-macro
           - qcom,sm8550-lpass-rx-macro
@@ -81,6 +82,23 @@ allOf:
                 - const: npl
                 - const: fsgen
 
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,sm6115-lpass-rx-macro
+    then:
+      properties:
+        clocks:
+          minItems: 4
+          maxItems: 4
+        clock-names:
+          items:
+            - const: mclk
+            - const: npl
+            - const: dcodec
+            - const: fsgen
+
   - if:
       properties:
         compatible:
-- 
2.51.0


