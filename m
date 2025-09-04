Return-Path: <linux-kernel+bounces-800000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF3BB4324A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 08:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 812C77C53D3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 06:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE8926C3A8;
	Thu,  4 Sep 2025 06:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JtvT/uA8"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3B2264A92
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 06:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756966999; cv=none; b=DU6Y2/D3RtIdIMjZ++vuZzFBaT+MWahtfmp4ufXCKw2s0tOnoov//Twi+hBm3kgRqRCdStYNTNaSwW5PL6anzjTNbfvearcywlKun/mEesEFXRxi/Tvgqk8MuAjzUi1jA953d+AIA2pmABvEVFbYo276GwtMXlU5eAR614FJHIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756966999; c=relaxed/simple;
	bh=BUBeTRGlxh5yBy8bsZ3XJSCTZrfRT717lc+uZnjTECA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f3xTwFGDIeI6VQPZRTgo+mhKEkYCQLt+0tH25xSFDJu1NA+GNilhqsPjD+WP1yltvg+FR2S0T5ChSSw9QAyZnxUhaz37uohbIlGwak9wLLqEZjGr4JeCEaHsNg9YBOw77wh/Qzn1zj7nCqFpujojp8sFJtc0/iLH1aoE6FvyVsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JtvT/uA8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58417QMC018987
	for <linux-kernel@vger.kernel.org>; Thu, 4 Sep 2025 06:23:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AO6iEgJ9nzZiIvfqCr2K7LOo1og6DI9YbUhKFKaY78w=; b=JtvT/uA8DoEYSotf
	/pVsvx1qD3LRNVjl4DN4EtvdqBki9s6xbDdkW83BOIQ6pfSDdC9AvXkpmv6Xo6VK
	KLTkKs0xCG83feZBroDpGE9Hqvw7edP5LCUqumriR5S8lDaqa/3v8ScAKKZodfRT
	Y6ps2TvqOUOBLU5Z5um6boue9DuvKCm+pSUciZQ8lz7txq6qSv9n8Nq6elzlSY16
	SUXPJb0VgmzlxwU5YsBdrA29ymDeQKfGne37i0IAaa8ZgmAFUhSB2Cv9tTamws4k
	YhlctVx1JHzPvYJd3y/klITQXqTZiMzDKrzs5yjYuq4jLUTn22YsUVs5gLaPzs77
	3xb3Zw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48utk968j7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 06:23:17 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7724877cd7cso792334b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 23:23:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756966996; x=1757571796;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AO6iEgJ9nzZiIvfqCr2K7LOo1og6DI9YbUhKFKaY78w=;
        b=W2LsuTZod92soD68kTLj+qbOwRkzPxb7vp81kOFixFp48H0G0Zj8QgKHN0XsQ7al4M
         vc3YhNNVyuEsKX0plTRpcLoRMq4jxIoqmkqf3AsZJMDJpcX3+pe8iF/Hg/pceEONuWsr
         VfBhyKbT1anT6FpOGvvohHrCSh7AzwFFuBajc3Keb3wWIc6ZgGHMn+AOaaA1+qU5hQ4q
         n4E+TH7luB4nDTacvncg4rcd1teLdDLQmMU8Vfqi2zDPBRIrlLLAeCUw0SflVpn/0NFo
         nkcffC9nzVevibRHTNp8KmGaepgAlzKZ8G87CKwMhGdpjhwAOkaW0eZH/0YsGoz+HwOi
         62fQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFhYy5dtcvcXdXrG+x5lp/7BilXSYSkKGojP2z/FbvTWV/Od2sjzfqsf+HqL+LWuceo767yCGjA/QSSYo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzuzw16ypZbKkAZkdyMe7X2/w3tibntArZmc2n7EcWDRYM3L2m0
	q7HHMnlxRXJ+GSxdeW3rvv5DdC3/H+unblXOhbOn4i6oRb+NMu8vWqaG+BppBV38wqGeas/piSL
	JwSk60cSkXSMzMPUPWlx/+UYpZaRxW71Jj+m5LeTYJ5x2nDoK5sOEppQWzVEOAkOk+9Y=
X-Gm-Gg: ASbGncsHsN/2UVC4p3J/w60g1KrstpCOFgzy9Xg6GGzuEPLxQQqR0zM3OHHF+f1MCyJ
	nrTBN9oPqNVQ7I+WgYDJWvfFwWO88/ILEE+5LFm4KVtsdznJz+TaCt0kbBOjKxJ+yu0BkVxRCrg
	qiAb8uTIX+g98w0EHOba6GEF4Hgux1lutObQRg/ElFve9pKMknUJQr8ufJv1YgRHaojwTW/Cejk
	SQKUhWKN2osC3zIGF1X3d9TLj0G8uU6/fN/0+LcFwS/CaYs+zsUBTFO/2t5yt43BrbS9DhRRakV
	8U8oCTUeYjSvXEthxr7N27xkepKwidDAJVgXm5UJiY860s2vYcHXEL+lFSQPTIz0FLORl7+ZZiZ
	yQ/2vzkQHbXylsBE=
X-Received: by 2002:a05:6a00:4fd2:b0:772:641:cfb8 with SMTP id d2e1a72fcca58-7723e0d366emr17986389b3a.0.1756966996556;
        Wed, 03 Sep 2025 23:23:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvXohAA/unSga9vVXl1kTHuDcfUmEtv9aPvZ2haTs0//u+0U/pKB3T8NlkE0osq1/WTnYyFg==
X-Received: by 2002:a05:6a00:4fd2:b0:772:641:cfb8 with SMTP id d2e1a72fcca58-7723e0d366emr17986362b3a.0.1756966996051;
        Wed, 03 Sep 2025 23:23:16 -0700 (PDT)
Received: from hu-wenbyao-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7723427c127sm17120911b3a.62.2025.09.03.23.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 23:23:15 -0700 (PDT)
From: Wenbin Yao <wenbin.yao@oss.qualcomm.com>
Date: Wed, 03 Sep 2025 23:22:02 -0700
Subject: [PATCH v4 1/4] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy:
 Document the Glymur QMP PCIe PHY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-glymur_pcie5-v4-1-c187c2d9d3bd@oss.qualcomm.com>
References: <20250903-glymur_pcie5-v4-0-c187c2d9d3bd@oss.qualcomm.com>
In-Reply-To: <20250903-glymur_pcie5-v4-0-c187c2d9d3bd@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Wenbin Yao <wenbin.yao@oss.qualcomm.com>,
        konrad.dybcio@oss.qualcomm.com, qiang.yu@oss.qualcomm.com,
        Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756966993; l=1645;
 i=wenbin.yao@oss.qualcomm.com; s=20250806; h=from:subject:message-id;
 bh=DwIAlVG79vEnNxiE7JeLaRZgKTUUwjCwHpMa5vhARMs=;
 b=TxaO/eppeOEGOzYPQ07gElbix33P8l5Tcwej82955emjawk8w3ibEnTEgBuN1Yl74dqCxNpw8
 zb9tA/evQYFD29dcc+y1prxYzZzr83HFgxZ+8QPjidrS/k+bZNi83tW
X-Developer-Key: i=wenbin.yao@oss.qualcomm.com; a=ed25519;
 pk=nBPq+51QejLSupTaJoOMvgFbXSyRVCJexMZ+bUTG5KU=
X-Proofpoint-GUID: ch3p0Nx5Cf5S1xedXpros1nbicavbKcZ
X-Proofpoint-ORIG-GUID: ch3p0Nx5Cf5S1xedXpros1nbicavbKcZ
X-Authority-Analysis: v=2.4 cv=ccnSrmDM c=1 sm=1 tr=0 ts=68b93055 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=prgL3jgsdPShhDvlN2UA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDA0MiBTYWx0ZWRfX76hzhZnsFSg8
 fLCv9OAJz8r8cLuFrYMbq3fRDAUNqqmMaPkLHNEKgR/Bj00b+yFnSxxQMGgusHyeGVfRaw3WQbe
 x+t6UStietcXkXKzdaF39KwprJcts8Yz+dgFXoAwygLCePnsP4SwLpMRPlkRCyfsxgvwrKqaHMR
 OrvD+4yvyJy/o1BOzF6sxa2LvlxTWGUFcpPfG7bwY4peSfHQaT3zgFuH7ljRuJXPaJN8L78Wm0b
 /gfmLDLBNC5Fg+TJcWNs6qlM9ykm7j9bk7WHdtJ0XLITA3BAr/erOXaI5sqpRA15cd1f0aZdFos
 9QGo3jHjVbS/WKSmDu8YW95DciWiAwe1Uuini1Yil9EgEMN8evKanoh742ZUnRYJgY6DiyB61GQ
 McCop8sV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 spamscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300042

From: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>

The fifth PCIe instance on Glymur has a Gen5 4-lane PHY. Document it as a
separate compatible.

Signed-off-by: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
Signed-off-by: Wenbin Yao <wenbin.yao@oss.qualcomm.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
index cb706cf8219d015cc21c1c7ea1cae49b4bf0319f..1527616902ebeab975c9c79d75cb1eada64ae55a 100644
--- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
@@ -16,6 +16,7 @@ description:
 properties:
   compatible:
     enum:
+      - qcom,glymur-qmp-gen5x4-pcie-phy
       - qcom,qcs615-qmp-gen3x1-pcie-phy
       - qcom,qcs8300-qmp-gen4x2-pcie-phy
       - qcom,sa8775p-qmp-gen4x2-pcie-phy
@@ -178,6 +179,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,glymur-qmp-gen5x4-pcie-phy
               - qcom,sc8280xp-qmp-gen3x1-pcie-phy
               - qcom,sc8280xp-qmp-gen3x2-pcie-phy
               - qcom,sc8280xp-qmp-gen3x4-pcie-phy
@@ -213,6 +215,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,glymur-qmp-gen5x4-pcie-phy
               - qcom,sm8550-qmp-gen4x2-pcie-phy
               - qcom,sm8650-qmp-gen4x2-pcie-phy
               - qcom,x1e80100-qmp-gen4x2-pcie-phy

-- 
2.34.1


