Return-Path: <linux-kernel+bounces-846306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A90BC786A
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 08:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 39A084F1F0E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 06:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789A429ACC0;
	Thu,  9 Oct 2025 06:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ga/+tSM9"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E63299943
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 06:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759990760; cv=none; b=iCS47KxXhKn3Wx3bHh2UrwW0l8EKE2yqhk3zICf3yihH4rBCF4RiA3cv6Cwq3tMAr7roDv2+bDlFT6tkBX0tf165IlvBG/Jt6dYyTnaxd3X+5Ha6+S2MTYvGjNTlRXZtLluwLKy3QqjgUku+eQz791Kk3WARD7pMYcTuGzw7qqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759990760; c=relaxed/simple;
	bh=mhm3iyRHbrd6C1T0gzq8dZ3Be4D6uDhl+Lr3IO84qiM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qOuC/9aBPp6AoWfyq16v4C3TNbAF6dtTSsx+XqgptojQyhOjGCo925acaTomJ9H5GU+gYs7OaXgUgaYNYSJ/6ez3/f1/aj9PHZHNxrv6oLtcH38CiUnNRXhOiIkbOd7Bjf8bc6dH7R37ENHvik+qdtLsk2OQLYrJR0kPIbMLhoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ga/+tSM9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5996EO9R029749
	for <linux-kernel@vger.kernel.org>; Thu, 9 Oct 2025 06:19:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ATUO9sxjCo5PUTMu4Z+g3kwu8CIesdgQ1LufySgyaP0=; b=Ga/+tSM9v0/LYuuH
	USW0Yiye6GxscVBv/DS8sLMt5yjAdBTAwmsordoas+3voS77lpWVXnEmUGDcyV9e
	ckJUuZj4j+T9TdFiPFW6kIibNrV3SvE6nb2fFA1B4tlTWxPNMQO9jmUEvagiWY1E
	L8f9gX5yhpOHw8j1JO66PE9T072HtyK0yMtkSDjxDvmhcSCIIgntkxCCoB8O8TmN
	M75RpwzO5K46RNhqI0KVBz0AT9ciw9SDThKdvo04uw4XZEZJE41S4FjSJ7vaqRf8
	PMM+HQC/onikNKcGUD94RZTgCvu4JN3GYZ45iDqTI8IcLKNFcXavzEuLyubah/zS
	lyIIZQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4n9pbp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 06:19:18 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-32ec69d22b2so1467998a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 23:19:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759990758; x=1760595558;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ATUO9sxjCo5PUTMu4Z+g3kwu8CIesdgQ1LufySgyaP0=;
        b=DzWAc1j21X4fXnHr7odglaBbU3N1zsAPuC8My+CNVeJ4f1Gp/XxCxDmHaOR+YapyrD
         /1L0LJ1Gyt4iEg9y3u9BKGJP0PLtk2PHUoqnZMeCq1Vd4IXY/7jaP6gXBFPXmJEFFELc
         evi5lh20xjj6jATXeRMuQ+NzofhZgRxd9rlWPqx9Skau+eNx2m8rG9SRL0eobJBtkxXt
         1CwcKe+T6S1YRly89YrdPo1a08j+aCIg6uLczhqLMINOvWzJGQRkhdlTiSKBoHynU8HO
         DHhpbj9bJleVwI9ZcNoyqmlFzUEOrYLSM25A8jHA0BKiqEjkLKCpNHQZ0sg+gYn1US3K
         PvKw==
X-Forwarded-Encrypted: i=1; AJvYcCXMZ2DX6BCYALpPOW9STbOaoMsUbes2TjSk5nWG0ibNXNBR1+JUNoyjfhmx9qW/a3jHfU2JjzeWyC0BZVs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwkVP/+pvjC9yqYBg/D9KKv4L9s6YVQ71z73nYgjuwCV81f3pi
	PrREG0snpqfPeGfwk/F8ZJnX7e9zj3OfdWZrZ2PRcSvBDtEbguxtqov2YDI4wqEcaU0XuzDAQCR
	exYxTXqk0T12F/lySFkuOoEZuslrxWTnA37+e78uC73Uj8+6/VvjiyOfhLlySxWO/dh8=
X-Gm-Gg: ASbGnct0X6f++/7ktQnm6otE21wj4tqwLD9yKQT2KGwDsVpmg0CzStGgtJQXL6PLiOq
	Y8Hx2Y4bo1BUZ2yfGsr5dzAT0qxww5PYibudcc8lK7SDUgTkM/I94uptQXyZy8FbiS2/mH9MdE9
	8E8xgq6bUFOrpFCesgKjlinUcJ/vIGVPamgvA6wS5wI8HZHsCUvqzNlj17YalbYMxXyCjpZ5rkG
	WPtR3awMMfZecCqUqu9HfHFAKuD7E/QKuCqCIK/u+ew4v+iT1I4kzYu6wZroYVieuklqkE+tsyx
	28moZ45V1h9hIMi2MW5yPFVHCSrYcZFFkERCq9twz7WuV5u/PYyPRSEICnqrFlKX4E80rfRwFeI
	SJBKCy+w=
X-Received: by 2002:a17:90b:33c9:b0:32e:e18a:3691 with SMTP id 98e67ed59e1d1-33b513ebbc0mr8788424a91.35.1759990757583;
        Wed, 08 Oct 2025 23:19:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFAqILhWyE/XzKX2WhRN71ULW8L8fSTk+2psqr5ZcNytsqF57WijfbGOqYcU3wUDR0qZ960g==
X-Received: by 2002:a17:90b:33c9:b0:32e:e18a:3691 with SMTP id 98e67ed59e1d1-33b513ebbc0mr8788392a91.35.1759990757080;
        Wed, 08 Oct 2025 23:19:17 -0700 (PDT)
Received: from hu-arakshit-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6099adbcbesm19239671a12.4.2025.10.08.23.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 23:19:16 -0700 (PDT)
From: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
Date: Thu, 09 Oct 2025 11:48:51 +0530
Subject: [PATCH 1/5] dt-bindings: mmc: add qcom,ice phandle to mmc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251009-add-separate-ice-ufs-and-emmc-device-nodes-for-qcs615-platform-v1-1-2a34d8d03c72@oss.qualcomm.com>
References: <20251009-add-separate-ice-ufs-and-emmc-device-nodes-for-qcs615-platform-v1-0-2a34d8d03c72@oss.qualcomm.com>
In-Reply-To: <20251009-add-separate-ice-ufs-and-emmc-device-nodes-for-qcs615-platform-v1-0-2a34d8d03c72@oss.qualcomm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc: linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org,
        Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=ZJzaWH7b c=1 sm=1 tr=0 ts=68e753e6 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=bQkk_NDItiJHBMw_kacA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: Wkr8f1A0IkpyFiQFppjCkvL3NXMq5BiO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX9faFQBKS8U4a
 roEpJI7Te3+CaZvMDeHQ5nkRPn909DRZXleMJjATVogo9atLvWPELWHTmpU/rl4WGZ1VUfFKqlF
 UVissfmQ58wynJwZikbP1F7jA3Upt/C19r+LSB1WV4sU82u85lhYmfF4KmB40/t2XjqnBz3PHjE
 cgG+AdoqZsxTqOuR9N+ZV5QG6c1iGBIYqe6o6sCySAoNwLOp8d94HykmA7bacgJoac3VptUoD/L
 iT/NQ8JcSVQpo5IW/eyTAwvd/yAeKC6gv12Qjz18WFIznCit2zZDclboM5PWHHbFwcHwHebTHbj
 xTsPwL+oukruIxMoe/J+lfyflkEbXNApmPhjtXWHqBqkzdhYUC/7kIFIf0xcNqtd7xbv0X5p9AZ
 8TPOA3b+FUKGFaA7FegtIMpg/isjmQ==
X-Proofpoint-GUID: Wkr8f1A0IkpyFiQFppjCkvL3NXMq5BiO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_01,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

Add the 'qcom,ice' phandle to the MMC device tree binding to support
reference to an Inline Crypto Engine (ICE) device node.

ICE hardware is now represented as a separate device node, and its
clock and frequency configuration are managed independently by
the ICE driver.

Signed-off-by: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
index 594bd174ff211e1bb262ad8d8c7fe1c77f1e7170..9d6be27b43cdfb349a1dc96a6687b5863af844d7 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
@@ -138,6 +138,10 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint32
     description: platform specific settings for DLL_CONFIG reg.
 
+  qcom,ice:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: phandle to the Inline Crypto Engine node
+
   iommus:
     minItems: 1
     maxItems: 8

-- 
2.34.1


