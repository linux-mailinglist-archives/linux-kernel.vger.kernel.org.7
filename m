Return-Path: <linux-kernel+bounces-743284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2EABB0FCE8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 00:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04CE83AAA62
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 22:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FAA7286439;
	Wed, 23 Jul 2025 22:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AOdiCa7j"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CD127F015
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 22:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753309700; cv=none; b=K3VbmxEdPh1nJP/zcKs0EAZMajXLVzYs0RMLiZIRkwQPFVmStwVjSKcov4BOsnN8Q3kef8g8qkVdQUbkOsmHk2k22jesVmEgjqrR7FN/s0TTdAK2VNkvMd5AFFbHmzvaGfZHJ1VnjhlKkrbdTW95E/JYIOum+O4/XufeKWoDRrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753309700; c=relaxed/simple;
	bh=sgooeZjbfM6S1ri+FrVmewlkP2UIgcflyZIdd6FVHsw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IO7JoNplMj3zdLWsi52W08a7yVId3rV1m3EQgjbFse0cTXHNN6o5ndEINfxFMpUblSyxm5w6qDfCHdeZw9KnG/HudFlhRj1ga6fQ40/Bn9OfthwiqWAmLPt4KozFTd/epgaq7V7JgoLaO7lfDpYUPKZg9y9dktPMICC9If1cBaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AOdiCa7j; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56NHDrtv025461
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 22:28:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=16arupX2e1S
	BlChhr2W+V8p/tQWklYBcFD4Hu6qlLGg=; b=AOdiCa7jKX/D/Vwga3ZFEf1m3Yu
	70HDTKS4vX9bXS197MiWBc3hLps02Zy2vNuwOL3m5uS0Sm+iGA3/72KrYX32wZCF
	JI5OMTofh8Mu5J1Bb9BN+NCRTUj9QkwVHcLJR/7DeNHfg2j64bKATCv0OZMDYgqP
	ZEKm8BXxZOW+fAFc4Tn5PbPZoG8Ye/PEo7DgRV7u2fHLrEIwSD60gX5d3yrQmzQX
	ipfu4MZv0Ia9cKuBOQ35Ok3AkdQvG+eJp/BoId7FqC9+eZyU9JwzldrmIxi9MQzU
	M66kQwrJhRrn/8yydyMLOtMbkAzbeaLj0bMV72iu6SF7XdTApiGG9D4IU4A==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 481g3esgx4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 22:28:17 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6fb3bb94b5cso5265516d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 15:28:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753309696; x=1753914496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=16arupX2e1SBlChhr2W+V8p/tQWklYBcFD4Hu6qlLGg=;
        b=agLt7CopKV4W18G0/7xZ8W9s5NZ/ahnhUcmu5E3Wvz+p27hfpyNIN7vvqzNOjtX67m
         7lmGgL5TeLzvQZZOw43JgLVJidNXZd5IRLTrhoiU8kiL0sR+jeIJmFzKhHVNkjU4DOSr
         jrUfmnTl87fYEQ06O2VA5sOIdzaT2jSxV+Jh1ceghHeBl9L+vh8l4M8NrHqo8IS8+K0h
         N2I2fwZq0Yx/nIgv0SUTMRhXMuB/FsRBkTM76/C3J+occh9L6PBxt3mSgDd2NxrQ4c6b
         xim9uy45bPuJkjNAEaHRRCpHim/h5gJW2DQFYyiwHdh8ee8XfQ8vMQpJ8PDb/GU4hkRE
         6R6w==
X-Forwarded-Encrypted: i=1; AJvYcCW5Me1ZHQYwX05On+iPRlMpC0S2V9SF7a0Gmfw6H63bQWkwBbtR+PaDraELCyEvAoTczRrnoR+++GzSzI4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6nBKknfMCilEfgjZG8AFZQ4AfhIl7fPfqMBSQfsALZToHf/Tx
	6mLm1bXYdfHGY3C0q1b+QdHXLQ608bHwkrZaIWL1eVRDruYOwkgawVM4vYrEXhwjLaRGWuCuNlf
	ggeaFuTfuhACkmUjNlx9cStXk5KquqETFthIKZmm1GyMjvpj+AFmZPuM2bQ4eRNV5RO0=
X-Gm-Gg: ASbGncsxU71HXgvca0uXo/B5U6V2cfxmiUUUC0uJS9+RT1xxthqyDDjPqbwvYP7y6eq
	ZS///ly0CmOaV9jRzyVIKTqkjD9pNST6ryLvzIc46bZdzV7ybtWGPVuwe69pBbtDdSp0dR7ifRD
	9iF2vc18qakHByxJxru74uhTFFZIgvZGoUwJ6zMGmwfzbdL4Dg7yBCMzjDuzrMAYi0I42mxFnMm
	c9uCE/qZew0I+CP+cBlHVDzQTfx6I4ajVGZCB/ALOhx1UhDOKnR8nim2IDpaFvbyIXt3HxoKHWD
	us7GOEvuCOQhcNVIImAjMQo1kzwKINP0CohraNZoZarvce5eZWWI4g==
X-Received: by 2002:a05:6214:3015:b0:704:7df7:c1a0 with SMTP id 6a1803df08f44-707004b362amr67677766d6.7.1753309695726;
        Wed, 23 Jul 2025 15:28:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENnDd7E8dvz4OBj48g90QpOOMdiTVyaWS/Zz6TAtRGOSxYgAkQu5KM2rpchgfGqo30V4noHw==
X-Received: by 2002:a05:6214:3015:b0:704:7df7:c1a0 with SMTP id 6a1803df08f44-707004b362amr67677536d6.7.1753309695310;
        Wed, 23 Jul 2025 15:28:15 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b76fcad23bsm248520f8f.44.2025.07.23.15.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 15:28:14 -0700 (PDT)
From: srinivas.kandagatla@oss.qualcomm.com
To: andersson@kernel.org, konradybcio@kernel.org
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH 23/23] arm64: dts: qcom: sm8650: add sound prefix for wsa2
Date: Wed, 23 Jul 2025 23:27:37 +0100
Message-ID: <20250723222737.35561-24-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250723222737.35561-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20250723222737.35561-1-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: B5J8v7Bx7Jh3t-JUs-BpRWdZqAs6GWj5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDE5MyBTYWx0ZWRfXyTLI94BVaKMO
 iuoOBGPqxKEs+V+MH4r56M71C8BZKqVjX7CNeXjYCvNP9M8xiUJry5pTDf5qc2taeokNP5+lOpY
 WZ6ztwDssU2Xc8lK+MYquAcn9wEfU8+P7PTwfGNmK0uqn3sMJ7H1hyEk7MCSGziBBzNE7z+ZC6w
 LqHkS+vVRxB2aDXLK6V50EXj7B5i1dTptd1Wzbb/h87kZ4bSK/qe5W5CfPOcq2wDAglTyZV9WHT
 8PPYcOrWXcNTy/OA7Y/ieYia5cJsTxIMjM7AgP9w/02mA6p5CWCJQ2UqoIXXoMy4mgS0Ce0ORJ2
 htnhtbDRjtbmM42NTLzjkQ6NJZi2QgCfpMX3MledowC/z1Dt8gGqyGfxDPM2ekvAG2QWM0NQrsN
 YBQGtokslI4k0OGLxw9yOAXQrWRYskEdQv/g58LTLajMkx1jTANNQdaJcflYuUkOLA3hqMcm
X-Authority-Analysis: v=2.4 cv=Q+fS452a c=1 sm=1 tr=0 ts=68816201 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=Nfxnn_ge1f9Pje3RmyYA:9 a=zZCYzV9kfG8A:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-GUID: B5J8v7Bx7Jh3t-JUs-BpRWdZqAs6GWj5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_03,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=797 suspectscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507230193

From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>

WSA and WSA2 are two instances of WSA codec macro, this can lead
dupicate dapm widgets and mixers resulting in failing to probe
soundcard if both of these instances are part of the dai-link.

Correct way to address this is to add sound-name-prefix to WSA2
instances to avoid such confilcting mixers and dapm widgets.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8650.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
index 5212000bf34c..8b43ded297c8 100644
--- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
@@ -4526,6 +4526,7 @@ lpass_wsa2macro: codec@6aa0000 {
 			#clock-cells = <0>;
 			clock-output-names = "wsa2-mclk";
 			#sound-dai-cells = <1>;
+			sound-name-prefix = "WSA2";
 		};
 
 		swr3: soundwire@6ab0000 {
-- 
2.50.0


