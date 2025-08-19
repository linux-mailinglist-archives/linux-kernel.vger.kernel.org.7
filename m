Return-Path: <linux-kernel+bounces-775341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BCF2B2BE2B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E29F2687CF7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 09:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC46A3218A3;
	Tue, 19 Aug 2025 09:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="n1gd3tfW"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF2631E0F0
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 09:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755597172; cv=none; b=sqZNoAl7Q2yt3ztxA/pHcbIxqQXfQ2HoRKpmJ5KbP6itH07KzVROkmB8d2eKBGAA9Bfqt1MF+Ppnv14moqnoqIMzK589p6LMIq3kWw06QvV/7uYpJ2dD4ETkHWhj9uhAi3xDRP5QJAloJw/NXvIbS8XarGMiCMLhETKReU3JXWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755597172; c=relaxed/simple;
	bh=ekdA9CVOTz1DmJofPhYI0+HcBHPnLV+Txm+2ENdkrHs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JT4pZplI6owEGPiXIlRcdHUagD7grYxjn9x5GlYltPweshVjtkJpReVUOpyLhZXrtJW8fAdkuXWq4hTDT9GPEX7zPGVAkDtRV7NOEuYGtXWqgv62PbXVvHqpiR8xb2ivzD0b2k33FmpqZ/nMNK5DW+c8lnBZofY0ZwlPctnLu2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n1gd3tfW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57J90Zw3027019
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 09:52:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	x/mJfVjavIoqW9T/ceCVgzgHEhxIAMs4Ha+bWe4V2mM=; b=n1gd3tfWgh4Lple2
	RUP0TcqfCejGVxtXIvYyxDgViyFw0n5gKq1/3QvburWZ0byEhkv0siASr08gQUJL
	8y+juCf9hO4kCtDML0dDO7bIc/ZXYY8W3URSt1G8SWGLWjR9wkwn8EwX/PQpKsbQ
	tVSy9QpSUovsa4Cr8Whfl2Vd4LPXmeLIIcwnbUJM7q//+9itjZOuEU1Qhn0rJTOa
	2FZbqFQoD+obABmuddnvgHf0qRyRfPPFmK93mx5oLv3kpfnCW9BxuA1GJhVmOjXn
	nhpbxfhdClpqYmWjPh3oDVtk4UkMv6Z4fDfStqeEyVJCwnspE1Yktmu7RjoZCqLu
	OXxGww==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jhjyg2d1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 09:52:49 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-76e2e5fde8fso4843342b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 02:52:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755597168; x=1756201968;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x/mJfVjavIoqW9T/ceCVgzgHEhxIAMs4Ha+bWe4V2mM=;
        b=u4C0NqjQs03AdK7GRccC6w8h4aczP/MbVKAuX+CveNZ1G3J9auCVyH8mlnYCT+q/WV
         PFiY2vvVGsGxUzRl8bN4JM/vBZv6W2JFiAAS0jXEH6wk5gtuqUzBG5rtorvZgbAaImBy
         TgJR1ctIvjeq8VwRYAwJUsZqBJcKtCZxL2QkuUsUCIPKbg45hgjjwFayAX1EYM9F2vkR
         4p6GXmUL3LBBsKi/ilnGt7Wsc1cyZGAdUR6L/nyN0C4aE9lUjmGL2vMjlIWEFqmbSyYw
         7bUw+eZ/YhagJLp148lY7LNaHMLgiFdut1RXY26e7hJgk6zkeI3+idIlykKpWQuVc/s7
         5udw==
X-Forwarded-Encrypted: i=1; AJvYcCWO/rkHQtGvZPY5P3//6/jp3Q2HQFvBfWR+g4yWjj0Ug28PiOHmVe+X1ez7m3WldN/4rZ/wmnZbiWjdrUM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhwI/becFTYYw7Rz7D+3chSRun16qC7s+Y3u4J65PgXkVtR3l1
	eZ/i74OkavUfR/cieXfwjGVmSMndru5TRmq9xlm9SVLJNMHGRGlgTbjjWwugZH294MIhijjioHV
	aPeSxMkye5vEp8FLRHlvgi4jsAByD4OrmoA/Qrcb6NSQ2XJOjOaZJlLr1juf+PpYyabA=
X-Gm-Gg: ASbGnctKVExLQamHHCmfS80RJN0KghwvbYwCq363QKn0VxR4Df5wD/39niulKR7dvyL
	1QABecWwfTHyHBErGs8Jvdz3oOHGFEfljq0V+sKuGzTDakQsr03va0evh+9dbtyUvKmF4Mb0KF4
	tRyuI+QUf5mzXv8Ku6gCqjW6Ysaz+elLVA+Sp48UzwYIO2Lx09h5EG2pubJ2914IHjXha6unLe7
	oRaQJOX7PckY10Z87EToEhBuJuIjlWUU/4vAo/zoUYnIx2/qjRrlnUeiFNklv2jforeCh2rrkGf
	SUuK7IKHmo0km7m3pxzcFQxxf1AD/McIUnow6WnYABFVhXFgn9lpD75rKn3y+olEeC5P1gC6u1Z
	63dsec/XgG+48y7o=
X-Received: by 2002:a05:6a00:238c:b0:76b:f0ac:e798 with SMTP id d2e1a72fcca58-76e80ec16cbmr2675703b3a.7.1755597168018;
        Tue, 19 Aug 2025 02:52:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENz0VJ98WADN+joIk0/P7w0o0p+4hmpEs1o6oCjBWcA7BvrTOLvz8FOh4tQnOd04eMjoXMVQ==
X-Received: by 2002:a05:6a00:238c:b0:76b:f0ac:e798 with SMTP id d2e1a72fcca58-76e80ec16cbmr2675678b3a.7.1755597167592;
        Tue, 19 Aug 2025 02:52:47 -0700 (PDT)
Received: from hu-wenbyao-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d4f7cf7sm1998291b3a.69.2025.08.19.02.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 02:52:47 -0700 (PDT)
From: Wenbin Yao <wenbin.yao@oss.qualcomm.com>
Date: Tue, 19 Aug 2025 02:52:06 -0700
Subject: [PATCH 2/4] dt-bindings: PCI: qcom: Document the Glymur PCIe
 Controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-glymur_pcie5-v1-2-2ea09f83cbb0@oss.qualcomm.com>
References: <20250819-glymur_pcie5-v1-0-2ea09f83cbb0@oss.qualcomm.com>
In-Reply-To: <20250819-glymur_pcie5-v1-0-2ea09f83cbb0@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Wenbin Yao <wenbin.yao@oss.qualcomm.com>,
        konrad.dybcio@oss.qualcomm.com, qiang.yu@oss.qualcomm.com,
        Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755597163; l=1172;
 i=wenbin.yao@oss.qualcomm.com; s=20250806; h=from:subject:message-id;
 bh=jt6UG6eiIFzDb1oeF0pFhVGf3jfLG0hsOnnZ5HuEIJI=;
 b=aLluycJkcVAxmTz5cJvmmczoB2nQCBmt5en2PL/z+GQMXGS1yuhRxxt+knyE5tfFmYvmM1uZ3
 3TxgHk0HhLTAUMfkAk+qLqJLStjDeG3lHUrH6iLe1j1Pj7Ojlp56vIp
X-Developer-Key: i=wenbin.yao@oss.qualcomm.com; a=ed25519;
 pk=nBPq+51QejLSupTaJoOMvgFbXSyRVCJexMZ+bUTG5KU=
X-Proofpoint-ORIG-GUID: Nw2Zghi19i6iPZGoiOLE0UteT2KqlloU
X-Authority-Analysis: v=2.4 cv=ZJHXmW7b c=1 sm=1 tr=0 ts=68a44971 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=WgZgizuZlwTqGGW0kXsA:9 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: Nw2Zghi19i6iPZGoiOLE0UteT2KqlloU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAyOCBTYWx0ZWRfX7jlkTz+XmZrL
 OwRF551bpGrhlh3PFi0wIPOym4SC4XS/PD92y+Fb7sXHh5ubOO9KcOjrS9ysGI3JYfM/7H+5FPL
 QlGThd6QFZ9dhsGIuPYGGlCPeFNuN3pFZBOyToNFir2jEPjVSAWnPApeuD1r2gdhaNK+0TdZWgV
 v0GZ1ohRXPTnOss1b/gTqFM28Wc5A+fYWGxyLhZMDG5anqByVUdmCUDglfUq1uYDRRKPoC6O3ON
 XSIQ36WVWR8d5g/+t89zHhhdLB1dA/8jkXfH3zAFMGYndIK0aUp6J6aDkkDhiR4C2l7UghxJ1n/
 mbWMSyWR0Dvpz2onhO46/j3HJszTkLDn75uZfhSNfdcL5s/6xlreRnl1DDxhFoCraZq18oQleBA
 jVsT+/XA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0 clxscore=1015
 bulkscore=0 spamscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160028

From: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>

On the Qualcomm Glymur platform the PCIe host is compatible with the DWC
controller present on the X1E80100 platform. So document the PCIe
controllers found on Glymur and use the X1E80100 compatible string as a
fallback in the schema.

Signed-off-by: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
Signed-off-by: Wenbin Yao <wenbin.yao@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml
index 257068a1826492a7071600d03ca0c99babb75bd9..8600f2c74cb81bcb924fa2035d992c3bd147db31 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml
@@ -16,7 +16,12 @@ description:
 
 properties:
   compatible:
-    const: qcom,pcie-x1e80100
+    oneOf:
+      - const: qcom,pcie-x1e80100
+      - items:
+          - enum:
+              - qcom,glymur-pcie
+          - const: qcom,pcie-x1e80100
 
   reg:
     minItems: 6

-- 
2.34.1


