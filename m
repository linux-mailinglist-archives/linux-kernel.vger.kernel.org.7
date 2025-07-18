Return-Path: <linux-kernel+bounces-736725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C90D6B0A0F6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 12:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E82BA5A75A3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 10:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E413172605;
	Fri, 18 Jul 2025 10:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fIangq+h"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB6E2BDC25
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 10:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752835618; cv=none; b=D51RAhG847KmztrumyHlYuarWmQOKqd/gokTdwJzwcACP9B17vnfaEGKAI75SEEgsn1or+V2ERhs0jIGizV97LKDhkg2iRM2D5WS+DvD2kl0jppOaF5Zez1C1aVnUVW4wiiYqW+qM7PoCWhezyXFtqpoQziUw+FuIJ5X0aqi59s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752835618; c=relaxed/simple;
	bh=5wy5crBqCcBbvGTsXxUbWrxKJE9+Mz5wRtahEqlnRzs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=klI4tqTNtHpJl+PwS700p3ewuorrrd1xcM47BiJscwoRceJOii8bJ88k3VkP7b2u6L/o3lf0yeyny00UeIgY4p77ay+9LTVw1b6IWkaT0FNHryGv6UfWscyEjV4qXoIXZ0gNhjcj5Jdbg5ozkTHclUfPnQBtNvw3ZsmqVnHZsp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fIangq+h; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56I5Qrrg020649
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 10:46:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=gif+LMxG0jg
	Jt8xMw6rl3aERVL6vO3MZf5qPtUSTZH0=; b=fIangq+hI+zckgCjxrXQN7L0H9K
	08dhqExUB5MuSucXCkH8Lf7LUSKvrPw0N+CDS+Ofll2kWuvGebjO6qnySXcPPYlU
	xV4NL4fBaaMvsa0ZXbSeVyCHgN0QIwkKuGuy7lIl2p/cPx5F/IvLUjd/rCEVPW/1
	Vu/dse7ab/pdXhn1taBDZrotpUqJv9GJiwkJ2+zOb4rhRLvLwacuEIv1iCEyc9wi
	2u3kRtjYtsjRzKhzW5m8VPrWO/4+koRROa8R9QjO6ptGxStlZgWYk3fOZzj7CWlb
	LoFTyZT6iWHMzqBGR4RCUuOQ2jcrNLAfFYlrfFYNjbFCDEHTBRqODupVrWQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w5dpp92t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 10:46:55 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-75494e5417bso1944574b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 03:46:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752835615; x=1753440415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gif+LMxG0jgJt8xMw6rl3aERVL6vO3MZf5qPtUSTZH0=;
        b=QNb6hqtpb/6g1Eku8i3gYuY4RL0RCTnU8ojaOgm02aCssxom36cN4X8zRDhLv5Dw48
         BGEf7mH0aGjVXxRiI3t+P6VVx/CvLqvRAoShhprfVOTPdB5Hxpc4o4pHdszcFYVMOJz3
         a8cf2474CFhAER8Ti2xmz5yHMrrxuPnWMVNMNgkNd2y32u1YAkdUvzfOL1XPrE3sjpVM
         XEYE2ocV/xB1T93rjpha3Eb/trE72krI1JtHqfWog+Z1x9hbkVX1PwAHQL8NlV4c3Az4
         WXlCp7gEP3qRh0zltpRNcSHtxrEZM0prsoJPQip/Qyw4CfIztxe7iT90F1OjXW0JyXrn
         px7w==
X-Forwarded-Encrypted: i=1; AJvYcCXnBGi9GV2IEUfnFieBpyRipY7bJGcCOW3VLr6XV4JauLB225EzJxj39m5YapvxoZT5w9myNwiZyfZ3a3E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY/ChQQWtYlgai+9s3lDGYhWymQkRh3XvgE88vVYgSwbcWJCmn
	awmPh7RvmuyvqZ41xPl16C54VWNwnFYOAKgLV4njfgxHwRL+kXDI++K2Xk8IvEbhrHgNt8Vreks
	qPjd/uiZSWuCIZIQWDJwjWH/CnuU2PlZMS0sKnFJyjEF2EbAFvC5rkvfanePLifQ/Dus=
X-Gm-Gg: ASbGncttzfW6Mm6JGfk378vDEJulJp1ZIy4UUhwJReid3AR02teb+xnYDBkJaUQBwFq
	ibg+IPY9NS9IzYcSlL0yf+bKRa4xzE6v+HkQ0mShmF3GWOBKxaP9bx04OcHV4BwBXVWNsWenAfG
	nPaByNsydjDVAi+EV7Cij+m3Y6a9indmIiMWyuDggby7zuQ428vW7xmonLV4tQ9XyrP7sCN/yXk
	w/MgzVCh0Q2IUx3pVJagiIwwwcvjUxXEb+1BSPkEzwd2W1n2sLTlWMrCu1QrFnv2VnfhZ6p4PM9
	UccgH+EitH3UPwmERW5bCmGMGrn+7JaKVhBFxcoFRZ25ijW7F5GbGlTwbkFblWuCp5sHOi+UQ6O
	C
X-Received: by 2002:a05:6a00:23c6:b0:746:195b:bf1c with SMTP id d2e1a72fcca58-7596a1877a0mr4234449b3a.10.1752835614973;
        Fri, 18 Jul 2025 03:46:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmit4JF/V6hPtbEMuCGG/dXgfpFvmuDdWI16KeBuC6kTA9Y2B7VQ7qoTDe0q039H8l4VRUOw==
X-Received: by 2002:a05:6a00:23c6:b0:746:195b:bf1c with SMTP id d2e1a72fcca58-7596a1877a0mr4234419b3a.10.1752835614441;
        Fri, 18 Jul 2025 03:46:54 -0700 (PDT)
Received: from hu-mohs-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cb678cdbsm1028989b3a.108.2025.07.18.03.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 03:46:54 -0700 (PDT)
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
        kernel@oss.qualcomm.com
Subject: [PATCH v2 1/2] ASoC: dt-bindings: qcom,wsa8830: Add reset-gpios for shared line
Date: Fri, 18 Jul 2025 16:16:27 +0530
Message-Id: <20250718104628.3732645-2-mohammad.rafi.shaik@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250718104628.3732645-1-mohammad.rafi.shaik@oss.qualcomm.com>
References: <20250718104628.3732645-1-mohammad.rafi.shaik@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDA4NCBTYWx0ZWRfX5QxxEHNQLGBw
 gsEwqxFcJ6aO0Hj1KmQZDkkT2SvX5l+0gGM4bHD2wuDXx4auKcDC1ibn5yChH1zv9fa8NjeEZwW
 CUWW+o9ASNOT7WOotKZ9e4h6K+3EphDIK7MvfA9XqZ0lPh0qBhex/dlm7FzRLbvEsjd6hDYfiJL
 10m+yam6wz5uLRnF4mPoXNrZNdnVId7Qs54s8hrV8HDdPbc3kYlq2wRvpR+EfiX95wi/qEBfasf
 UZvtRopCd+b/FzK4Cge5dfEI3iRLdya2d71B44I5+kBMF6oajjXh3keLplqG+iEiGHvq3gcEqQT
 ph+km2cdbrTECZd2dvQq4GrGxeV2xiao651jBmVjhS5GefnFCjF+t5HVHFUQ51fsXRh+Cwn0PkB
 Hmy5TEJJp/BdeLBUW0hipu5f10K6BqK3Gj/rZsWSY4hhHXLNunwsLSVpFNZd/1zTsaq/jS7T
X-Proofpoint-GUID: ms200-KvCptvVZJ_NlCD97-J7FioXC-H
X-Proofpoint-ORIG-GUID: ms200-KvCptvVZJ_NlCD97-J7FioXC-H
X-Authority-Analysis: v=2.4 cv=Y+r4sgeN c=1 sm=1 tr=0 ts=687a261f cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=Jjn-4_SfM33dySwp1_gA:9
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_02,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=999 phishscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 impostorscore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507180084

On Qualcomm platforms such as QCS6490-RB3Gen2, the WSA883x speaker
amplifiers share the SD_N GPIO line between two speakers, thus
requires coordinated control when asserting the GPIO. Linux supports
shared GPIO handling via the "reset-gpios" property, which can be
used to specify either the powerdown or reset GPIOs.

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


