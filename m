Return-Path: <linux-kernel+bounces-879618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B206C23969
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 08:43:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5DDE84F1D76
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 07:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD22329E47;
	Fri, 31 Oct 2025 07:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="A6ShDk+0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bGyR6KDw"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF8832AAB6
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 07:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761896526; cv=none; b=ud5rot0DGmuplIyp+QIfpQ5ddY4pM3NuXiwqWFzCAPERATMjyVozp0DT2+BIeVuxF5iOnsBiHNbkwxxXMTM23OZXreyqzdv4kzptxyJPO+ay/oj/AQHB5QBwngH4KNARiOPTlZ08cGi1zlcC3wC8zr5+cJX+I2KpxOH3OnZR/f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761896526; c=relaxed/simple;
	bh=hyAgBs5i+/xaHJSSHUlbtDcsBlLHZyIavHx3uB+5ohg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SOR6NfTLYfpZW6zqzYcfyDjw8yvF/hgcl5qpQGnyXm6Z+40R73OB+REQRiRasXKH9EZV9j1QLPFlUeorYMoKaPi42kaoh2IZ0M4ridaIGEGTx8d9wUdTgUMdU28sEamwSKO5sFCtNJnNph9eW4ERi0vVtOOpkrqJggDTa+Lh53A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=A6ShDk+0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bGyR6KDw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59V6SSRe3117076
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 07:42:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	k3MuWcoclZXbFGKG7snEdvIBSt3O3tlaIvOtpAIsaag=; b=A6ShDk+01ijGE/sU
	ZQSWA6CN9qW/4HnNjHkmCrTUtnPEHvleJE31WBilHxnTJ9yL+9YXpArJKw6WyC0c
	BiqTkVohotL1YrRgrjImX13W+/47QtivjB6dc8sDDCuhimAAyCh1nKxicUk426kF
	Toa7Bz0ITpxyJaBszDfDQfiAdShcpdjtCJQMlT9AlNyvBOzmBKFUk084bZaxRmuc
	3qzrHhtOsZw0UPVM8rJ+twRM+Y8JzxtDnIaTc0yeLHS36PXQPaZan8kkTwSi+SsH
	ETqawmxX0+CC+W7NKHkRDW8yuCmADaObGGb2KOTp2hjzxiIZANmbWaHe3Y311kGT
	tFhm3g==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a45frk9vg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 07:42:02 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-294fb13f80cso12651925ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 00:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761896521; x=1762501321; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k3MuWcoclZXbFGKG7snEdvIBSt3O3tlaIvOtpAIsaag=;
        b=bGyR6KDwPZp9tZmLSKMPemfAZWNqEQTsA4bk58oSRk0vdFmPuOLaGeuUp9+3A/F16N
         nFzv8/CyXgd2Vi6NIBYj0ycx8N9EM4Pqom4YP8VBFvJDuMr5sVCFuHwdSChJHXQ7AQc+
         ELKg+adVOAIHNlBacSa+fWbEKw1iz7oQgKqpoJwcXYVeNwuyLXn5xrDBivhnwjGNTmok
         rc76O36S3+PTnZMhrFs9lunpY270s39J6DD9pL7Gu1LkLE0XJdIjykNmyC5cNKECFR1R
         WfXPOfozq1GCUsx+8a/Js01VD7Nr1qmluEIFl5QrM7u1xEJhde5x8hwU7r+ZX9bXvXyI
         Ckyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761896521; x=1762501321;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k3MuWcoclZXbFGKG7snEdvIBSt3O3tlaIvOtpAIsaag=;
        b=AqPjRjEtqH2vgMjLbZwWoywZni9AE/6l3otBX/7d5NvpQNkiB5KHIFqrHMXwq4T6xZ
         xtmR9g2SmsS/SwB80cCTjU8eb4Hg1B8fgesbLoFRXOH1TTmMlGuDSvRX+0pcg3j2KNC9
         G+WuXFZ9rjOqSm+IiDfFuFB65GgHm3A9D9doqgAmfecol/WESZ2P+8dbzt2eqReB6vcM
         33i7zu1Hc7ymBr5PDW9aLpUYBYVba/ukyDDv0iYtbI283LvHeASQ3Hr03ch6IVsjU6XN
         S8Z0259AlSWEBgJrgVjH6AVrVfoUiIMoWzxZHN379ZzULzGDJz7s7lancseTrV/lWoKH
         pWQg==
X-Forwarded-Encrypted: i=1; AJvYcCUVsvf4/qvDyIZd2dNyFWN26AU+27GBNwOl13EpiT3fy54MmpPzeTrRXZkf+UCXMQPAX8JZBDfVnJoLmZE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr7uTD+VYNpwYkOOVLkyn2uZUT27rE4QLBFPZHHhslRGWw9yiB
	GJwr0S1zkNlI1j90VB7D1oyQtxUgLcIzDlCx3/K8yX9k2IXhATKjcmqHxGo4ztOT4sQXS942f4D
	PWnLdTU1AnlBxG1SaftYmRfSS6ZXc+aFWhi0IqhxEHeMhrYajdS+rvXwMLz7zfGickUo=
X-Gm-Gg: ASbGncvZX6BFGP6rpDOwzTuYXLaZOkJqmew/ProAlfQPp+awyV0Cx3C9XVmCPTFewf7
	2SI20AGHHlT+Ycxr+oDddIwlPdNDD0ostEVMuJqkEqBfSbCb2yI9OHraq+0bv7xlt8X0D+EvQdb
	BDoybvq+6LZ6FuN6CuTDfW7GugtSVFnKSOZE35grlEFXVQ9GaS7hYvFmCn4QKXuHazAeqe7eHDp
	VuSXbZfcAZIhacUcFQcQvp0LVRfEpnM3cYJ9yQoHoEGj6Ni00e4OUjUwe+CweKZH/KaWh5xQwKD
	AeEBoJalqZiJceM/4PIFo1QAfnXg51EJNbpUTqqlSd9EX+tyeRayBJLudpoR/c9P9yhI/FMWKDr
	5YoRhA/6i4MunX7GTpndtmDPH/6WvjTltVOvM0wTKvaNlk7O97g==
X-Received: by 2002:a17:903:2348:b0:267:a5df:9b07 with SMTP id d9443c01a7336-2951a36bff4mr34667655ad.12.1761896521402;
        Fri, 31 Oct 2025 00:42:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBgmjyvuQbEx4Q9ICC0LuNnHIpOw9uoqbn+Ks7CXvMLqb7c2GuNZPwjAkuYwHFmBBxdvCtfQ==
X-Received: by 2002:a17:903:2348:b0:267:a5df:9b07 with SMTP id d9443c01a7336-2951a36bff4mr34667485ad.12.1761896520886;
        Fri, 31 Oct 2025 00:42:00 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2952696f0c8sm13276735ad.71.2025.10.31.00.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 00:42:00 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Fri, 31 Oct 2025 00:41:44 -0700
Subject: [PATCH v3 1/3] dt-bindings: mailbox: qcom: Add IPCC support for
 Kaanapali and Glymur Platforms
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-knp-ipcc-v3-1-62ffb4168dff@oss.qualcomm.com>
References: <20251031-knp-ipcc-v3-0-62ffb4168dff@oss.qualcomm.com>
In-Reply-To: <20251031-knp-ipcc-v3-0-62ffb4168dff@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Sibi Sankar <sibi.sankar@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761896518; l=1025;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=hyAgBs5i+/xaHJSSHUlbtDcsBlLHZyIavHx3uB+5ohg=;
 b=WBmu+bx+9S7CuuLrrRq/TiVzMmZne+hsZuPkfXSrnUFhXUsJs/YZIG/LuTnH1T7dzZ6SQrpJo
 k53f7rM014yBcSViFW9x8CSKZGJNlJzS0DcBgO9hRbcW9cbq9WsaNk+
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Authority-Analysis: v=2.4 cv=KupAGGWN c=1 sm=1 tr=0 ts=6904684a cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=5oGIy7HwbUt9dYcD9-4A:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: EXUQ5QubIM79Xa9iqu4DvE5vOVUoWzNa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDA2OSBTYWx0ZWRfX3fOuhwiI/G0+
 BPbH777L6DamAkk+EsGONVioRfbUZapB+0t7iFctAyFV+SUfgywJdk5Bd8oJs0Hafj+spdXSHNQ
 PqLIKDzGWQDP7plpjlmyqJT/p0KFjkgyzYBZi1d2PqR3xpODYnz8zXuMCrKb3HWIq1dU6u3Se6J
 8aGNtrcTgFjuBgL50eSbZFWegUGpgec2oT+1XzSSKSstrweroHI5IiIRv1FyOeerjF0WVnlsrfH
 rsb0mZYz8JnemtZRr4tT8jC/XaKdpnjchzCz93Rdc5xECVLjHU/0MKU0jJEWA41rQPSngU5bkTg
 H8Tv5olBX/4eYXiB/OXQvE78i+fZ6DMVYFl6PZl5EHxJJblc8ssH/SR/0azRx5AoA0o/hh4sWjm
 pNSeDTx+WogRRqADC+QgcRw5VGPo4A==
X-Proofpoint-GUID: EXUQ5QubIM79Xa9iqu4DvE5vOVUoWzNa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_01,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 spamscore=0 impostorscore=0 adultscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2510310069

Document the Inter-Processor Communication Controller on the Qualcomm
Kaanapali and Glymur Platforms, which will be used to route interrupts
across various subsystems found on the SoC.

Co-developed-by: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
Signed-off-by: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml b/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml
index e5c423130db6..7c4d6170491d 100644
--- a/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml
+++ b/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml
@@ -24,6 +24,8 @@ properties:
   compatible:
     items:
       - enum:
+          - qcom,glymur-ipcc
+          - qcom,kaanapali-ipcc
           - qcom,milos-ipcc
           - qcom,qcs8300-ipcc
           - qcom,qdu1000-ipcc

-- 
2.25.1


