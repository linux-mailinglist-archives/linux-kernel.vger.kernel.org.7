Return-Path: <linux-kernel+bounces-831477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86050B9CC5E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 02:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 926271BC2829
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 00:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C56757EA;
	Thu, 25 Sep 2025 00:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZqrVXsPf"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD4F1397
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758758495; cv=none; b=Ne0CCsjU8WF7M2PNnKyYxg5f63cU9Kd+WfBF/cBOoYmNrEYpnOoTxT+LE/dbywi+nxSCmtUwOeQynRDEZYdiY1jjf/pjIMalxesiYGv1vteD5suyRkB/4/LjwTTrQ2HDvAdUiEfPBlqoTlIMLWOp+o3i3zBXudiVor8cOGfj6hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758758495; c=relaxed/simple;
	bh=V4rfHcCU/wAXV0FGv9ipICr0cbduOyswJBX8O8lOqu8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GjueWzCUU1DmXYe1LaGEwxl+3M2Q+NHjPfAzIEsIB1oiT5mQvyG+SDahHc5131mPkb2lTk1Ys98U/jNc5sTEDM6zAlwPaz/5zSMZkkiyjqh6R6UqwkLIUS/p4z+jJTdhBFcQpYhNfMFk3IdxdG8B6Cx9DTSVgqoPvVhoNyC7WpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZqrVXsPf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OCYCih017470
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:01:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iPSCfQa0r4/1zMxhDx3atNDe951NN06HkbNHSAELqSg=; b=ZqrVXsPfaaZMwNkZ
	UnQkZwFTLDWLdK2/4fzKa24Q6A5CPlqfRL2eYlR3S/CQBRNvx2V3fKewEt3Sq9KR
	rbgoOrf1lYgJ/uooFWzbhqLewnAIbnAg4v+H3O7oZXslhXRUmCqqb8G2KMQcy+TO
	rSuSvLM4TvcGxC4KsuZInbIvtznLmq/lHDEwbQy4LcLREeoEThIWbN5d7lO186DP
	4zZdu/wDOLykNu95rVc4LEKazWlHlL0lvPr89o0qd1E7117n+uT+cASJyigdntiO
	mbyi5gGQ2JHX7n6hWKtFNu9cSft6ffeqdTlfToL3FFX3JGmaQW3U1bZkh6h4FTlZ
	RhRN8A==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bhvjyekj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:01:32 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b55118e2d01so233093a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 17:01:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758758492; x=1759363292;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iPSCfQa0r4/1zMxhDx3atNDe951NN06HkbNHSAELqSg=;
        b=FbfoWMie1mgZC0MOi/fRggL+dSxJd9Vq+YwGT3eiX/r2A50iYudSASPbUIAEqyoAsd
         1ylyR46KuuK42VV4Mvn2tf4ITbyYoiXbvujP/eDxQlr7lpYdx/7dOG//Ynjhf0ybpuoY
         cyLTMGbxLZ1SSVNNO46e68LnRYung7UQ6ODz2VoAiZjstEqdbUQeHZabCXjCKaNYf7jW
         gfTAu2kRg28F3mslwEWlbUPqF0+te4CcBt7lW9Fvv8Euun6sSCLu7sGWlyJmKzaiJTLG
         1NrPaE3XmAYkdq5ZG/PN0O2tSKo6gUvG07MWBkZ07QJeRyCcaccCk7fL3wKNsrRzg/Il
         HKew==
X-Forwarded-Encrypted: i=1; AJvYcCVF3NYxBoWvYmKMm77V/jam2+vt0rLNwLOaz4e1DorOm3+6pJdj0l3/aKbaQEf3VxIx8VFgpH+B5OcaO4A=@vger.kernel.org
X-Gm-Message-State: AOJu0YybVMtr+2GXIRCdQMYWGPcLFXjvNctk3RnFW4B4hy6ZOcUrPtgm
	xNtWE1P+qav+n5gVleUgcSCwIAmBsYHfhKQvjnDpquSLUFRPTkJJpa4rdJoAzPQP8xlAZ5fZdDa
	pVykJzM/nQEjI+76tu5Hc9uNU24wZiRjgBxTJ50A2KJmj4+Ll9VkE03+HrBVgwv444w1/z7meJB
	5H2Q==
X-Gm-Gg: ASbGncvrGIbcXL4ZesGJDE1t1Mv3aMs6c0y5Agk/Bx8eVTQed269HOu6Teae0yTY/w0
	otr8WmZqRFIs1izJu5Jk94ABqx9QJ5HRZMG705m9NX/G/xxgFgsyVE25SsS6Ub2kDWyirTXtxiD
	L1HxSz2ki8MbAylUjj8s4fWmUTbS5pavpwH7rPdCDU3hzGnJ6BR0QIQedMah6U8wEekkYy172/Z
	msoJ7QKn6pRj4gBTca/5cKzc726eXf9H9VvHJWjiTsAYf0sggC64PRwtgFCSH/njVJpDYrQ9cmq
	adlKf8UhkhHDOIUChURHpTNIOCjbexv6b2zlCAiMltuV53iRmkkI69IhYKF78/bswC9X0gqdMKa
	yZCzllQuehXaIrUQ=
X-Received: by 2002:a05:6a20:938e:b0:2b5:b1cc:9d57 with SMTP id adf61e73a8af0-2e7d0ad1ef7mr1735958637.44.1758758491877;
        Wed, 24 Sep 2025 17:01:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcBuhUX+zwV9XHhEnGYkxGcKW8PJ35g+7aoF8dcZvIwzlBSGtU1PclkPMxKApcmlPUiavjNw==
X-Received: by 2002:a05:6a20:938e:b0:2b5:b1cc:9d57 with SMTP id adf61e73a8af0-2e7d0ad1ef7mr1735906637.44.1758758491381;
        Wed, 24 Sep 2025 17:01:31 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b57c55a1bafsm423152a12.43.2025.09.24.17.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 17:01:31 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Wed, 24 Sep 2025 17:01:19 -0700
Subject: [PATCH 5/5] ASoC: dt-bindings: qcom: Add Kaanapali LPASS macro
 codecs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-knp-audio-v1-5-5afa926b567c@oss.qualcomm.com>
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
        Prasad Kumpatla <prasad.kumpatla@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758758482; l=3129;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=dj3g6v9BUpW7nvIbf4y6iP6vvL+STyAnXhGU9WKLRGk=;
 b=t4zFhLZc7eIjaZjRxnzqaDgTly+djP/IQcGhd6ju6V0SD4I1v8SDX0LnxRwb4kUfba9UWCss+
 YphOVCPo9yIARoKYugGp3X5iIzX8Af0/V/nXRyQEPNBrjrj6shFNedh
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Proofpoint-ORIG-GUID: sELL6RUubTdbo2teuMU-ATdNuY9Ze2Lh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDAxMSBTYWx0ZWRfX260f8qKr89SU
 gUL94zRK1L26RsO4/MuUB1yux9eFx0mnsfP9Txj5oAFksh1MHy9y363rHEE4TGmyl9/gCWHXus5
 N4h2iRWruCG8s0fFCosUx5WyfqKCrgVxi9yAw1uLDg192RgAyWzRWUqj7CQP+f4FM+Y0C0GhF2y
 Cl0y/tRyGI77Qc8Tdxd9HOPUKdf7hZVV2fX/pmH8T6RZSuukymnvYzrDzhwkY1MjDEHlFsRKJYB
 j/xRJRwH4Us7zv+TzK6rEWNUwaw40i8YYMJJ9w94//Y0pixUTLUwZKMMNudTNvlIN44ivfFDmag
 555T2qI5d46e762q9Ps4KjZ70ZzU2hiJ6W/Fd4lmIXcTFPfmLlBlL08wvGFjdfKXOhJn7owZghr
 NTWKU/HR
X-Proofpoint-GUID: sELL6RUubTdbo2teuMU-ATdNuY9Ze2Lh
X-Authority-Analysis: v=2.4 cv=Csq/cm4D c=1 sm=1 tr=0 ts=68d4865d cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=ehmOrWUO2zTDMYMZoEsA:9
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 adultscore=0 impostorscore=0 phishscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509230011

From: Prasad Kumpatla <prasad.kumpatla@oss.qualcomm.com>

Add bindings for Qualcomm Kaanapali (LPASS) RX, TX, VA and WSA
macro codecs, which is likely compatible with earlier SM8550.

Signed-off-by: Prasad Kumpatla <prasad.kumpatla@oss.qualcomm.com>
Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/sound/qcom,lpass-rx-macro.yaml  | 1 +
 Documentation/devicetree/bindings/sound/qcom,lpass-tx-macro.yaml  | 1 +
 Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml  | 1 +
 Documentation/devicetree/bindings/sound/qcom,lpass-wsa-macro.yaml | 1 +
 4 files changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-rx-macro.yaml b/Documentation/devicetree/bindings/sound/qcom,lpass-rx-macro.yaml
index 92f95eb74b19..b869469a5848 100644
--- a/Documentation/devicetree/bindings/sound/qcom,lpass-rx-macro.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,lpass-rx-macro.yaml
@@ -20,6 +20,7 @@ properties:
           - qcom,sc8280xp-lpass-rx-macro
       - items:
           - enum:
+              - qcom,kaanapali-lpass-rx-macro
               - qcom,sm8650-lpass-rx-macro
               - qcom,sm8750-lpass-rx-macro
               - qcom,x1e80100-lpass-rx-macro
diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-tx-macro.yaml b/Documentation/devicetree/bindings/sound/qcom,lpass-tx-macro.yaml
index 914798a89878..e5e65e226a02 100644
--- a/Documentation/devicetree/bindings/sound/qcom,lpass-tx-macro.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,lpass-tx-macro.yaml
@@ -21,6 +21,7 @@ properties:
           - qcom,sc8280xp-lpass-tx-macro
       - items:
           - enum:
+              - qcom,kaanapali-lpass-tx-macro
               - qcom,sm8650-lpass-tx-macro
               - qcom,sm8750-lpass-tx-macro
               - qcom,x1e80100-lpass-tx-macro
diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml b/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml
index 1c0d78af3c05..5b450f227b70 100644
--- a/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml
@@ -21,6 +21,7 @@ properties:
       - items:
           - enum:
               - qcom,glymur-lpass-va-macro
+              - qcom,kaanapali-lpass-va-macro
               - qcom,sm8650-lpass-va-macro
               - qcom,sm8750-lpass-va-macro
               - qcom,x1e80100-lpass-va-macro
diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-wsa-macro.yaml b/Documentation/devicetree/bindings/sound/qcom,lpass-wsa-macro.yaml
index b6f5ba5d1320..d5f22b5cf021 100644
--- a/Documentation/devicetree/bindings/sound/qcom,lpass-wsa-macro.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,lpass-wsa-macro.yaml
@@ -21,6 +21,7 @@ properties:
       - items:
           - enum:
               - qcom,glymur-lpass-wsa-macro
+              - qcom,kaanapali-lpass-wsa-macro
               - qcom,sm8650-lpass-wsa-macro
               - qcom,sm8750-lpass-wsa-macro
               - qcom,x1e80100-lpass-wsa-macro

-- 
2.25.1


