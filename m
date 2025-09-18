Return-Path: <linux-kernel+bounces-822408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A935DB83CA2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 11:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDD7A3B3BF8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 09:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4C02FF648;
	Thu, 18 Sep 2025 09:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aonR3qr7"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C5B302746
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 09:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758187694; cv=none; b=Xo0UgtAlYty53enFo6mSFyIFmkm8avITEPx5KfUmgAqHRcrk/do84n1CV3pIvpf0o01kpTEtDAJniRTvrgyYC1Adg5YIcks2YxTCoNMnjNYpx45NBos5DMZXaJrSUnklF/GEaToI0VSrSnwoe9SF7ZDezCUpQ8tetSdmNshTxHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758187694; c=relaxed/simple;
	bh=Q2k1OGZi1tJ10Qxj2dLCmgjuSxg9MrRTOJnHncy862U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KiGFjUYChtx9KA1CLhU6FxX3P37dVVC4XCy6G5UhPyLnr5SQZkMTYhO1+Gsxq/CW9swdmEtovof2uX25MyOm1mP1QzZM29HtvA2TQTPKo6/gtVsNbqGZs5ZqOz01Pt0ME5zgkKvCJhY8xNNivj11glBtrKwdr5si0nYEgC6OX/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aonR3qr7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58I65pY8027124
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 09:28:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1vmZRbmtKnmDzwshtwRuWl1jymhjwTHzJdcYwocu9vQ=; b=aonR3qr7SLRQP5uu
	wW2xW+GodCH1vU+i9Qz8x1VdOjyNPLASRv6GCcHlIAbFMaDYk7R4YRpCCqowlmC+
	oavLQpaWbGtrbf81qvbkJQdKniFJjIX78g/dt/H1iMMPQSzkcZYzWU64l1vBpsR8
	m7pSWNm/JekbI2eN6jRs3c4UqX8yDknDayh/7AdjIX+oE6SOgNexnC5To8Z3mlQi
	5SRfNX2AL0TJZ34702A3up/oDfy0jbled9W1DGCjSou0XrvDUkXFgn5XpE3CM9rV
	zagD7O+Any7ClPPDVLpg89PEtMxrbda/mR3bFcG/UJvES/pkmVxV+HDYq7xtARVC
	b5CGmg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497v1jbpnn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 09:28:11 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7725a76dcb4so1284679b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 02:28:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758187690; x=1758792490;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1vmZRbmtKnmDzwshtwRuWl1jymhjwTHzJdcYwocu9vQ=;
        b=gW0jcZ+KxUHUvdA0jQv24So1q4or2BbKYiw0hO6J6G2ERRvOtsKny3da0/ObQJSEgo
         fX5Fi8OArBda2ttrmSroq0JUhRlriJ7S8tdWFw7mKomOdxkUbGso5cxp4iIU4gzOrf2r
         yZIAOhylMyMYcrjiKnytY2bXAL7peHlDe0ui40s+pMWchyFly0Ct1mIWydq6iVtfNeuM
         ns7LT95arKtBN71ksQiRQ54ltbMOwQvOBORyNLfC4EZDSVxLVpNOWW3Oo4cmVDRuIkKb
         y5Ayy/VhO/1gC/rARV4VXfTYB8KwtGdWKrLx+neYDujeXl1lNP51zdw27zfIXOgLBdgN
         Z5KQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBuhkaDuQvd0V9C2ywrbq1LZEiwTsFeqYLQ5a5KYgvV9fSnXYe8pd6yJk1daUNd2PhnFxN08sXsjT5OL8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy45pacbvO5a9IWD5R7rWBa9PxuHatObwNsq5ilvDJ1zfDencRc
	eR+Lp9n7vpPObsZqaGUF7t80I9fyN/s3vXQoZbvyFldsuNa3Nx9yAuhUVzQyh0rV5/tgq5Zo3/4
	9rXRMSvzHvzc5bqlkOMynlo5QfgDtou7h5SMqfFktVIRkWJalUHuBR/JRMxqjahQPLjI=
X-Gm-Gg: ASbGncu15PJebjVQkBFsAfO/GhX4mBrS4V/z2A6+Is7LgSD/Qcbc/23IOUUsZv+UUQf
	2N1nL7nuu/PFBz4aaDYywWGx+JnHDwkdNI/F6Z2XOhWi221Os92YvQBpnoN7slm07HDb9r48Hr5
	HHx1Kgj1uAwFJBD58Mv+XDVO3L5CEXg9KJp65c59LX1J8wKQUpCRRwPtTbzIPPNYXI/Jz6bKJAe
	uLbza80aYQ6TH1mWLJDYe+86FJZQJJTP3SOP6YOo6rCgWTHfs8JA2ZKcWe0ReEOpb+BJNXgiXRY
	mIh+jeJgdNfkWJaxqYo8Xw9nqQo5DDrIwYnsEiPy4WqmUtf9kZ7LkzovmCl6ifU0/fmzcaEiltY
	cwr7l4nZW6/QefJVcGaQ6+g6tSw==
X-Received: by 2002:a05:6a00:189f:b0:772:397b:b270 with SMTP id d2e1a72fcca58-77ce17975efmr3278428b3a.10.1758187689861;
        Thu, 18 Sep 2025 02:28:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGM9Ng6LRdJFvsS7waDhp1Q6bkzfw4TSKnJkjVy1/ntjaST5iTEkBNT7bhGD8Yf3/oF4B8ICg==
X-Received: by 2002:a05:6a00:189f:b0:772:397b:b270 with SMTP id d2e1a72fcca58-77ce17975efmr3278394b3a.10.1758187689401;
        Thu, 18 Sep 2025 02:28:09 -0700 (PDT)
Received: from hu-kamalw-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cfbb79b81sm1819205b3a.10.2025.09.18.02.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 02:28:08 -0700 (PDT)
From: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
Date: Thu, 18 Sep 2025 14:57:02 +0530
Subject: [PATCH v3 2/4] dt-bindings: rpmh-regulator: Update pmic-id DT prop
 info for new CMD-DB
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-glymur-rpmh-regulator-driver-v3-2-184c09678be3@oss.qualcomm.com>
References: <20250918-glymur-rpmh-regulator-driver-v3-0-184c09678be3@oss.qualcomm.com>
In-Reply-To: <20250918-glymur-rpmh-regulator-driver-v3-0-184c09678be3@oss.qualcomm.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758187677; l=2308;
 i=kamal.wadhwa@oss.qualcomm.com; s=20241018; h=from:subject:message-id;
 bh=Q2k1OGZi1tJ10Qxj2dLCmgjuSxg9MrRTOJnHncy862U=;
 b=52X7WcYtkPgVaETGF44fZkY4QHN3oYL+sncyuSRp6tGU+gmkRNABc3+goKEwj4MmxeHDFNaSP
 3AL8iQJ3/zOCrlOM19167QxgWkREpUsOHiFnMgYU+lP74ABEvrd3joY
X-Developer-Key: i=kamal.wadhwa@oss.qualcomm.com; a=ed25519;
 pk=XbPE6DM5/mJi2tsiYwMCJCZ4O5XPMqColJRlGVcM7Hs=
X-Proofpoint-ORIG-GUID: x8sVj2hX6FDoP3YjmjFOSKFaZ0F-tBm3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE3MDExMCBTYWx0ZWRfX2uQupQkPvnzU
 mLfkNlq3weP8oddXaISRw/HvywuiQvUUf9cIow+9HZ1PaqMAJ4INsaKqaKruPwjUJVoPuyIJmeP
 GP3GFW5twQRvSAydGeIAsvoplq9Fmzc72F+YPyAJyEbvklXRxYztKixtw55vU+VDcrWtLJWR2vI
 2xJ/o1Tf+tuWtveJbZawk4IQZ9F+ZNE//kwXBqTtMUmlH5DdITHtIMp1R+ThVl1iwbBjSj5O+ji
 tY+0qDGbV6lSPMu7XCVWqJjFjpS57QkKNaExyZJrfhqN5i5DFREMYDxWxmE3vYjol/mmKiVE02F
 zrWHpLUsDTV1duZdNvLlSW0rSWW+QGOwZnBoaDV6NSk5sM6vP3eycMLYRZRHg84d3u8jY9qScEe
 AfNeV6sB
X-Authority-Analysis: v=2.4 cv=AeqxH2XG c=1 sm=1 tr=0 ts=68cbd0ab cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=QlHTb26AAUdUyTm3vN4A:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: x8sVj2hX6FDoP3YjmjFOSKFaZ0F-tBm3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-18_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0 adultscore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509170110

Currently, CMD-DB names for RPMH regulators follow this format:
`^(smps|ldo|bob|vs)[a-n][1-9][0-9]?$`

Here, the `[a-n]` value is read from the `pmic-id` DT property,
which is unique to each PMIC present on the board.

Note that in this older CMD-DB name format the SPMI bus on which
a particular PMIC regulator exists was not apparent from its
CMD-DB name.

New targets like Glymur, where we have multiple SPMI buses,
overcome this limitation by following a new CMD-DB name format:
`^(L|S|B)[1-9][0-9]?[A-N]_E[0-3]$`

Here `[A-N]_E[0-3]` part will now be read from the `pmic-id` DT
prop and it includes the SPMI bus id `[0-3]` as well.

However, the PMIC ID part `[A-N]` of the CMD-DB name is now
unique only to the SPMI bus that the PMIC regulator is present
on.  which means `L1B_E0` and `L1B_E1` are both possible CMD-DB
names for two different regulator LDOs present on two different
SPMI buses (bus id 0 and 1) on the same board.

Note that since the new `pmic-id` DT property is a combo of
PMIC ID and SPMI bus ID, so its still unique to each PMIC
present on the board.

Update the `pmic-id` property pattern information to reflect this
change in the driver handling to support this new CMD-DB naming
format while maintaining backward compatiblilty with old CMD-DB
naming format which is still supported for older/existing
targets.

Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
index 40e57b10ebbebeff130871b6d978df64111b6f29..40ddc64577e78b5c0dbb7b4e8893a08e8b37c92e 100644
--- a/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
@@ -108,7 +108,7 @@ properties:
         RPMh resource name suffix used for the regulators found
         on this PMIC.
     $ref: /schemas/types.yaml#/definitions/string
-    enum: [a, b, c, d, e, f, g, h, i, j, k, l, m, n]
+    pattern: "^[a-n]|[A-N]_E[0-3]+$"
 
   qcom,always-wait-for-ack:
     description: |

-- 
2.25.1


