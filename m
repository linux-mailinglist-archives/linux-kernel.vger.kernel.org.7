Return-Path: <linux-kernel+bounces-831435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48377B9CA78
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 01:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 537151BC471B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 23:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8FA2C21E8;
	Wed, 24 Sep 2025 23:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="io47iIWU"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389082BD5B3
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758757116; cv=none; b=ByRrkRwfm/IjZBQd5U17La1w3qf7cIzB1y+25l/hE+s59CLzhbPi/kE93196E0G4A65HRax42UDNicb7gZYm642PRobmsfN+3sdzxitRZTAX+biDenJjGC2OSRTfOmNeSwumepcqEPkJ/wGk+bGzc1qBK3pue0wt7X7aUmpfw98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758757116; c=relaxed/simple;
	bh=R4a+xO6YzjGKd8+xDBkkEFUU0Buw6iW5iNLWRTb2GL4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P05Bab+Duvts4NqmZ3m8c31ZevV/t8ZvJZrPTPod3ppLahOgp/V3VEaUiVsAj6ZZI9pqVt7ym9TzcV9rvlZKadFOTVz+seqKow2PTAv8PWLdelf8S9Giz1DNSCYuENn8rKAvM1ZvcYSu8sfL5ovhoMTAUQxcdW30EeUBJNalR8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=io47iIWU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OCab8D025591
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:38:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	m6EJyLoah95Eov6Jjxf32aSHBqBRimx6jvDy8Jf6Bk8=; b=io47iIWUbookm9jA
	D6JU4qBtEOB2Ko6ua09b2HQNoldSEuHnB6b/PXf7Bs+P5BVKuvpkV6+bSW8Ryz8h
	hqBdm7BU88WdJ5/vJteG+XywxkXym0A8xlvXy+PVrJoOTmePSD6AutIIPiaJr4Re
	qyGfol2pPQ6o9bcEoNS0NBepLdPgfGO3Fdus0vNSGgDFrpoZHO2DRN9sUNaBhLMT
	2atpI6wGF5KvUOWNsxMZS2FUNWJkapIzJQC3Zn1QY3fKlahux2vUZ6pUpuE/fhI4
	5hhF36NYdKdx6qQsvIRcL/bynZjC+cczSuS/gq5K4oN5t2D98s082MXQ6V5oHt7b
	8VzMkw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499hyexcgq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:38:34 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-780fb254938so332775b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 16:38:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758757114; x=1759361914;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m6EJyLoah95Eov6Jjxf32aSHBqBRimx6jvDy8Jf6Bk8=;
        b=q+prFQVJWbiRiP8rCB1iEG5Uba/BNUjCyclJ9IMZoJISRBXhLXfJ0YVliOlBRAxu/W
         E3hqSED1vRzS7Dz9UBuYyRH89Q4TTx/B1aRQvzKVorxxXs5JqcTq/nt50wKbLmoffrzT
         I3ARypZoIteUWp0H8fTDumsKtrx20k3h+ESZu0/9TpfFdwVq4pYpyFh1RiMeMUiUs9ww
         1u9KZ3ATGpDlNu2aXT7/ri+BltIDkzPpVvtLJkEweOF60dmDhS0zDRKyGHvvcGc45yV4
         oII75UnzMsgoip6cRXUE0h+tuHrrZ7W7ThmzR6mcieZHAFWfPkf7VI+MRMOlVg1PcTII
         iHZg==
X-Forwarded-Encrypted: i=1; AJvYcCW/vTUK/p++55PmJAml4rTxcy6BqqtWXY+RHHJiJKCLSYp5ZcTE+szBqwKvmHHVCBNUZIwzSJprd6Syc8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNf+Dfon6g3o6r5r70oz7vltHtbT4loSimwe75pImTMyI4wziW
	gFfhvn3Wyn0WEfDtGX+tjzQX5y1hTKLP4Y53WNAI1Bg0AIvbtJZdU5lIGUW6DBCdhN7XSWXNecQ
	HUv6Q6iXEsQm+6QpXV+4BC5zRD9848sYcywBCdauEGeiDnNHw7iGFSeYF1QWRDqe5tFo=
X-Gm-Gg: ASbGncupzj0awNCBwD8i89Z5x7RaWv6GHwzG88PxEaYQpv+KVaIM1M/PBxAO4Mdnocy
	XaHeO4m42f6K5Uw/kqFjGhYmqt4Jy9zIW2ZfAtHI3cmcj6yWO1dYyzYjJojHBK7Q7rnr/rEa7fi
	6FrQQ06gQSvcWyfvZjtJLeMsFT6bWJULMjzDeJHCOcUDkmjuVr4Xin6QzxNXkddb12SqRzZ+PYf
	1T9a1Zui5U4oOM8MGwxxhQdu7jO6LlrGBZzjfniQaoHju+5LmN9PgRZflKQ/Ih/NEWP9I69yDQK
	GvKi+TFOw5I4a9AP3uJTgrsHPWDLTZTaYmJYtN1r8J6hGYXpOtlBBdqz465rDGzAOVov8mUbwH8
	Jo/XzdHIyNBeBt/U=
X-Received: by 2002:a05:6a00:2d90:b0:77e:87ea:ecac with SMTP id d2e1a72fcca58-780fceb708bmr1759006b3a.24.1758757113677;
        Wed, 24 Sep 2025 16:38:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlduWD5j5O1dhgkaATz2ppoqEJZiU0V8pGBVFWj+WZPierk/jNzCpKicZ9eurz32EFTkgekw==
X-Received: by 2002:a05:6a00:2d90:b0:77e:87ea:ecac with SMTP id d2e1a72fcca58-780fceb708bmr1758971b3a.24.1758757113226;
        Wed, 24 Sep 2025 16:38:33 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78102c0709csm177056b3a.81.2025.09.24.16.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 16:38:32 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Wed, 24 Sep 2025 16:38:27 -0700
Subject: [PATCH 1/3] dt-bindings: crypto: qcom,prng: Document kaanapali RNG
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-knp-crypto-v1-1-49af17a231b7@oss.qualcomm.com>
References: <20250924-knp-crypto-v1-0-49af17a231b7@oss.qualcomm.com>
In-Reply-To: <20250924-knp-crypto-v1-0-49af17a231b7@oss.qualcomm.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com,
        Gaurav Kashyap <gaurav.kashyap@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758757110; l=893;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=8JJMRPXwStM8oNf/K3bPstEsS8Hn9PWNKSZdyFsUQrY=;
 b=7ZtmwklUf3aLvtvgw3SS4Tvxs6sh6uvHucPTsyLs+6ggmonxS6D6kEI7Nn3EH/f5SXIdBiKVN
 mZelxeIg8oUD5vp1p6POExUGZyk+a+OI8fDDkp1D9powFEpnM02RF+i
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Proofpoint-GUID: a2nYoLWGDEs2MYr6ux5Z0FteOgZZcymP
X-Authority-Analysis: v=2.4 cv=YMOfyQGx c=1 sm=1 tr=0 ts=68d480fa cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=ou92kEv10uOBaGRFQZkA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAwNCBTYWx0ZWRfX+XAWlmol1ebt
 AmU31vcHhJg3i4jDvxFZpqJ0boTZymiX0fp9ToQPw5Asyy7nFHNm5T1DLNoJ8v4XD7qQmVm2OBV
 QJku3F4Q42tHeoihkShRx7/7jNpVDxpjmRDu/KslAUhnln5T1q0qgQHdoA40nB7cfJA2IgflPJO
 Xf8theAOAxYNHFxmsE0k29/b8vHNW6E54T0pHNfIfMAHvC4v/AcElEtOMqE/B94U/v/2IMAG9ga
 L25ujV7EbV/uMOAMjV8PhrrtvLZYCzYG58gN/pPQaHL9PsvYSk/4GI0uqc+CiV9MujV/7FXvmJz
 vfOGJfKzyZunR1ivh8nWSWsxhlQQMZj3Yd/zkr0Tcgs2KnAlQNIiLn8sGoLc8zCSBwxNLxqYZZ0
 PGHl966y
X-Proofpoint-ORIG-GUID: a2nYoLWGDEs2MYr6ux5Z0FteOgZZcymP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200004

From: Gaurav Kashyap <gaurav.kashyap@oss.qualcomm.com>

Document kaanapali compatible for the True Random Number Generator.

Signed-off-by: Gaurav Kashyap <gaurav.kashyap@oss.qualcomm.com>
Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/crypto/qcom,prng.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/crypto/qcom,prng.yaml b/Documentation/devicetree/bindings/crypto/qcom,prng.yaml
index ed7e16bd11d3..597441d94cf1 100644
--- a/Documentation/devicetree/bindings/crypto/qcom,prng.yaml
+++ b/Documentation/devicetree/bindings/crypto/qcom,prng.yaml
@@ -20,6 +20,7 @@ properties:
               - qcom,ipq5332-trng
               - qcom,ipq5424-trng
               - qcom,ipq9574-trng
+              - qcom,kaanapali-trng
               - qcom,qcs615-trng
               - qcom,qcs8300-trng
               - qcom,sa8255p-trng

-- 
2.25.1


