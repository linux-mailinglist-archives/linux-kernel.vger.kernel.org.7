Return-Path: <linux-kernel+bounces-875487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 80714C19383
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:54:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C8278585CE6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E010432BF25;
	Wed, 29 Oct 2025 08:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lPKoLdqb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Qo5CILlv"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A981328621
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761726344; cv=none; b=ZbUY4dAug0uOnUbHwVXJDN+himaFjdSvwcKxeIK0D96h4c+dFq8HEvvYrIpChM20nNDtMqXm5j07w9JcI/9YV0jj6nvfgdqAKtNcwVXHc3ne93w+Orl8/ZKwdVp774g7DxHIC1uATNf6sNnR8QMDZdInYEJDKfrK3zlX3XlFkWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761726344; c=relaxed/simple;
	bh=W4lOSMg903GYA1zxTDxFQF9gnP+6sHQAZV34jmuGdKQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hebiVz9byYb2ALOxOhXTTR0VrKlvep+yUCteMqO9qXUQ5Q6zl42LKPKKsAzCz2NIoEYodpGF+dlYXDimo9vgMNAdbZ0fE/pHzUwhr+66EwDcHABNAmgkyyE4go9dJ7z+owuVy34zboUTQnQmkV9PlVkKrAQ+YDTy7DafBA55NNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lPKoLdqb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Qo5CILlv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59T4uuMm3642920
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:25:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JK7SZJX+MikCqFjK/k66SySTPy7ACr2CTGcmwo3Ayjc=; b=lPKoLdqbDV+aWPRQ
	SgIfMylcGd99Cm+LcN6qZzqnGPiogq3AJ0UX+WebPKXB+jVr3bPbILf1lMDGn3Qs
	BafXexIsoFsLKd98SnrfAN23o+YKcXt2ug10jginxZHkiLaR+bymdt3wlzHGxC7k
	DPOF9ht7Qq7I9o5CcBEq/Ateuzg+s7G3Z2KsAWIaPdAAkqobstOdFxj4p4+Ff8mW
	g5sb9veM/xeKlei3iS0i29ydkLguAmuRPuJaoIaCQyF64+vxVA35hXoYnEoCvGhg
	gxj2Z+6rtrjOcBRdw74augF2ph9FJjiyqdtAeUeUI5bi+Txne4m2jRAkaPSgKmzh
	L83y6g==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a34a1hswb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:25:40 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7a264d65dbeso4671102b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 01:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761726339; x=1762331139; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JK7SZJX+MikCqFjK/k66SySTPy7ACr2CTGcmwo3Ayjc=;
        b=Qo5CILlvRlXMGzZKcKbCaigZbMwGepdAw0MWkcuNOUapjkzg+iR4hbApR5AP2fpID/
         vuxhqjjJGSOrOCHxHP2exU3VUcZz6aSEShj9gTDMSx5iz3S7rOyit33Klir5gi9Xw41v
         4oG+dveGasQoWvT9PtlmjTsYp+pnl53Fm0LZc6UzQk0Ia28k+NXtP+OG+DaGTIgJTQs0
         qFhvKKvNrMFPFV5utPJTyv/uk0iuZFlSQdqAFWMCj3RHesrMY+AkByv93mxjHdWCj2Xi
         fQBlqe6ra6ZBBX9JSMesK3TqyUX8Zs7w7aKx5MItIO7KHQUd9w9w6TMKijHU2YU8VBZ4
         oy9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761726339; x=1762331139;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JK7SZJX+MikCqFjK/k66SySTPy7ACr2CTGcmwo3Ayjc=;
        b=p75ggoBcPDqpMVlGIQqwbe0GGMBJs+QeTeCCdzhk+Eakpj4F/Eh/p0RxNG+M1BkD7Q
         mZO6A4OLo8einL9Xgl5Y5Pj/EoGnT8Jpo2zlb1pOtb9y8m/loWo8vTpdGuLQO5+lzQWT
         9ijkbvFGrmSkPyU9AZXdTsHuO4Q6ShBLTgZ8UXCjeXywbVaJr4KzTz3FqTA29ciaiZBF
         H8si6gnozv8KwK45s5ovMcRX9KAX6AMeT6T0qA8rYj67Ix5NFM9DqUvqgzgLA/4T5E5m
         rnZl6rbMZ50fyvKz/TjCY/601mvfkhl1quL0K/i6AL0MWVJTBXlmLa86YDJAJ2cYynU0
         LFpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHZxdp7XKSEm479jk7ldoCFOuI/GJwpY01NGvfGfynXP5dulJv+diXYk8IWlYtOTllu9kvwv/Z8AD5Oz8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmdQtsh3O9ERqViCIsrLNQEWPVNW60cOkdXFYYeZFmYP0BZfjR
	6m0cnsdW1XsED+mxKGmliFLhmPY/EtKihGbL6mKyyyCLiTIx1gnvRFO+t7zMEkJCdc/qicNrAg6
	DUDleMbuxxxV4huy6DRv5YDmTrFVzOYpM6pQlrWDYfWmZAYma4qakv4jqbAzmFsjlVJ8=
X-Gm-Gg: ASbGncuevoBbNwMPNIJETa8AUII1d/nl4oBDSGKV5Nbvhv1+pEPwNuPDN7n/AHibogD
	XqikjjjKREUvPobi2tkM7M5xK25m8rA4eko1vaNR1mWCshb1nHcwHODdggJyr7E8qLt700nZHEB
	Dwy2LqT1GPKjFXszywGk4eFBeAu+TRCMVAzWRuasIg2OWAD4C7XgxNaCJSfuOJenxTMpLT+QjQQ
	E4eW0n6yrYE3B+0Qbi6Y64CihyP4f7BR3T8nkENSdtrhM4pSCA0TDd39nAw1ARoenIa6Ydtx8NS
	/KzZlj0RK/Hr4QMOo8HtQzvwBXPqA24c8iBtxVoZll39FXJFJxCM0WMRdX5T1KvQzAT2T2e/qO/
	5J4i8vTmWywFXo/U2JutP83lzCLtwoKuJYFUzWg3EkovvgpDU0g==
X-Received: by 2002:aa7:9064:0:b0:7a2:8111:780a with SMTP id d2e1a72fcca58-7a4e2df8cbbmr2363268b3a.2.1761726339222;
        Wed, 29 Oct 2025 01:25:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECihEvvzOVIGmNK8hPCjT06tnNOOFSohNpSB5zChwhoVvZea0PYfRvBk669noNoCuIzhObKQ==
X-Received: by 2002:aa7:9064:0:b0:7a2:8111:780a with SMTP id d2e1a72fcca58-7a4e2df8cbbmr2363231b3a.2.1761726338692;
        Wed, 29 Oct 2025 01:25:38 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414049a44sm14158850b3a.35.2025.10.29.01.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 01:25:38 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Wed, 29 Oct 2025 01:25:30 -0700
Subject: [PATCH v2 2/3] dt-bindings: crypto: qcom-qce: Document the
 kaanapli crypto engine
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-knp-crypto-v2-2-b109a22da4f7@oss.qualcomm.com>
References: <20251029-knp-crypto-v2-0-b109a22da4f7@oss.qualcomm.com>
In-Reply-To: <20251029-knp-crypto-v2-0-b109a22da4f7@oss.qualcomm.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Gaurav Kashyap <gaurav.kashyap@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761726334; l=869;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=j9YVsWbXcS2a6HwO/+foiEbEjltuK+bIiq6tBsLubm8=;
 b=2HSGd1hA7of3GezzUr/8YAJJWPY3Tf/fyJngsluCXpx7q1JgTexKLVDv6j/j3oOcPS23To/8F
 7ezLZWgDuA3AEj6HljjgqMpGjAmGPojU8GXzoEHOs4v5JgTNmztkqEn
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Authority-Analysis: v=2.4 cv=dbiNHHXe c=1 sm=1 tr=0 ts=6901cf84 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=UTvf6Pk5Os8-KCCN1KUA:9 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: Ya7BEoDJ5HRVJ5ex95MD7d0HMDE2_wgN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDA2MSBTYWx0ZWRfXxmpYRNV2YdYl
 bybof6PnOC6bCaru8smILicAs9LZaPwIRrRvTScwjtUC2iMYUgjGf0OEYtKleJRHyjOaNjnCbo/
 50Sv2F++78vShz/Le4jXhzTIBF7X1UG14y7091qqdzdLEMq9Zj5mXxzxMgN/4fQCWVlwfORzNZn
 pLgNLlId0E2sEoK0geer4P3fiwVE/8s3+IHHFLdovSuuquBATURhVH735NgSG4wvkuJlfZ7Ox5B
 UQBQ9MIgILPseG7pfH5SK/KZYjYY0Ue5hJLPCQ5rFMyCu/IALZTm32w6vvvHpSaFtVzv6S4pmOn
 kx46HdBZWhILLV5wMEndEPP1Xn9OD5T1//HTu1BCvNo40CuBUOrOC28Xqbih56C4ESuMIYYJeKz
 I2cCojXyPiPYKcA0sC3bdYsolT6VZA==
X-Proofpoint-GUID: Ya7BEoDJ5HRVJ5ex95MD7d0HMDE2_wgN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-29_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510290061

From: Gaurav Kashyap <gaurav.kashyap@oss.qualcomm.com>

Document the crypto engine on the kaanapali platform.

Signed-off-by: Gaurav Kashyap <gaurav.kashyap@oss.qualcomm.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/crypto/qcom-qce.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/crypto/qcom-qce.yaml b/Documentation/devicetree/bindings/crypto/qcom-qce.yaml
index e009cb712fb8..79d5be2548bc 100644
--- a/Documentation/devicetree/bindings/crypto/qcom-qce.yaml
+++ b/Documentation/devicetree/bindings/crypto/qcom-qce.yaml
@@ -45,6 +45,7 @@ properties:
 
       - items:
           - enum:
+              - qcom,kaanapali-qce
               - qcom,qcs615-qce
               - qcom,qcs8300-qce
               - qcom,sa8775p-qce

-- 
2.25.1


