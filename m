Return-Path: <linux-kernel+bounces-858915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF92BEC3B6
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 03:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 392EA425DFB
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 01:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8CDC1DEFE0;
	Sat, 18 Oct 2025 01:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jsMNkZE1"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C761F03F3
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 01:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760751230; cv=none; b=EEgY8IqxQuOBxaelDQaxC3jPvGOgn+B8+dDQQyJ9D7PeHRmTd8HC3NHbJcqIWbuItIWi9K7nohjo7V8CCwaHF1ATslZLW2o0jIySzdhLmCoHdXNPg5r+hWNVei98zQb/zMIOUQ0PBqjlbMmWa3MjlWJWxODHwMySM1ZRIahHrqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760751230; c=relaxed/simple;
	bh=JjTidZQB/64meRBY72wsiS5dDWqoy5vboHdQPrUMssk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m3ejF+FKn7JAU/pTl/YQvk4PRuN3ZckQgv3+CSnKavzHOlZS9RBrKV6jWMU1kz0J1ZMlvXLmlxj3+/Cnl2fZ1HAZEGpE4Adbb8SjMXjmjb/AyRHeqllMyBGoQC1MAuShqh/H5SoTwyVaQwWS5awJulFxpsm0a5FudBW3htBVRy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jsMNkZE1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59HJH4EO017615
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 01:33:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yL7Iw1H1yxY1RKY9O3NOo5NRWkBTocM3EwLCw3QQ0Xg=; b=jsMNkZE1AyDKc34D
	7f9nENu6iufATV1LGrWEQhTnNa9FIDfrd9wDwnGUJsG6qP2DSVv3gz9kGpm9udkn
	tzNTO1UaW2P9JjTJTkvsbZsVUkZyo+YiCcoXjenXcCqdgYhsFonSQImAsKqhN596
	NQlJrMqTplXEFbjM5ga+Z9K2wYeyQw1N1LJ/sW2B6CFiaPcIuVGAeRj3SqSt0t4u
	rsMzxDWlH0YPh+BM1DCi91T0QirrlqAULlEHNIWKmiP7kZEjym1+2YQmBNAZ8yOd
	+1T+JlwHxu7kqViaFTrfihKfUqzyG2aveaY1ri7kdlzpCTwVRw74fKtdPi8Le/M2
	WI37Vw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49uqun9kak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 01:33:48 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-29085106b99so25774525ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 18:33:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760751227; x=1761356027;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yL7Iw1H1yxY1RKY9O3NOo5NRWkBTocM3EwLCw3QQ0Xg=;
        b=v/VqLJukhLb+b2+ALcc7xou/z9w2BuRRqywqGCRAifedTvVkQvCNG4P6+bwNU7/fVI
         MFQW2BJj3aE72CNy14tdwlaMh9YpFZ6etbHfnTVxpf2UJLa+ZHALIjNmSZ8FFD4YzLaS
         ovMjvIyEJl4XC+26ygPxJOgyKJ1xeOkgG4JfXDP3YznsN8QU3GmmNLP4mPZ4FVx0ra3n
         deZBMjbQqpukQHYv0Rlz1uz+PVSzwidgikvJ/bfD8g5UaggxXZhGAZ5RmjPyewHYbktD
         sWHZrqcNUKcnKEXK35j9lLx5XiJOl6FpXySxDOz+I+UGThMX1jxWJah6phDrj06XrSEJ
         trOw==
X-Forwarded-Encrypted: i=1; AJvYcCXLGFceF+3m9VEx1BQq3PW1vqRN0+bcw7WK5acMFdu3Yx0KDIx8eRWpq0J6bmJLRtNURBariS4IDZFFZbg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoM4i0heWkBrU2G9jn/iFASxMblQc3QIXBFw5EtyMPFYToHa0q
	Yomm//2OSbBhnsKH690ACqeKDWNZM5lJ6PgfgiONLoACKUNWxm4HbumVN02fz0KNTauabj062Qf
	qVPz+xVxUMM4nQmLd5outCqtYj8fHFkfeRSuKJ9k1heHd0O+iwyxUynRIxm1MsYJDPlM=
X-Gm-Gg: ASbGnct1tRqRbnT+8HtqPsXP6f3UHZkg9/2ToVF+zwcep2i0fwF6o1mWDSz0McUtSm+
	3z8pm0cItJW5yPqWhdJGb7lFxKR3mpfhgpxe88sq5TE7GWLuHq4MibCbI5wbiBtK3EDtcFDNRcp
	y+3uy+3hEXhjSbClUG7meRXhLpHnjo/l6ilRiOh03QEZfL2LbQ4zwTaUh2OzGDtKv83fHopJz6D
	ouxT6/e3zrqoywPGgvSB1UMI4+1isOpmH8bFk4xZPjvP9GI6bLpPyQUJFAUE0gPlV6HkfQzfh3F
	dbjwhvke2XwftzrNX9KCSr/A/L529HWLex6R80wbk+B/vQWVIhIrYTzeD3SDYcOv7Q9RHD9lhfg
	pxMnXK4uF19Rmw4eSY5k7rJSJ3AqUMYEqz6XBCig3G5vcNw==
X-Received: by 2002:a17:902:f78b:b0:290:ab61:6a4f with SMTP id d9443c01a7336-290c9cb367fmr58341725ad.15.1760751227367;
        Fri, 17 Oct 2025 18:33:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9hDmHjEaPzyblYMvIXbWGcSrq2rVVNWtCtuBRPfBhjjoQkGpW+JgacHko1My72hwjOFIDGg==
X-Received: by 2002:a17:902:f78b:b0:290:ab61:6a4f with SMTP id d9443c01a7336-290c9cb367fmr58341445ad.15.1760751226941;
        Fri, 17 Oct 2025 18:33:46 -0700 (PDT)
Received: from hu-qianyu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33d5ddf16bcsm791695a91.4.2025.10.17.18.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 18:33:46 -0700 (PDT)
From: Qiang Yu <qiang.yu@oss.qualcomm.com>
Date: Fri, 17 Oct 2025 18:33:40 -0700
Subject: [PATCH v5 3/6] dt-bindings: PCI: qcom: Document the Glymur PCIe
 Controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-glymur_pcie-v5-3-82d0c4bd402b@oss.qualcomm.com>
References: <20251017-glymur_pcie-v5-0-82d0c4bd402b@oss.qualcomm.com>
In-Reply-To: <20251017-glymur_pcie-v5-0-82d0c4bd402b@oss.qualcomm.com>
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
        linux-pci@vger.kernel.org, Qiang Yu <qiang.yu@oss.qualcomm.com>,
        Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>,
        Wenbin Yao <wenbin.yao@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760751221; l=1272;
 i=qiang.yu@oss.qualcomm.com; s=20250513; h=from:subject:message-id;
 bh=HOWusfNTWzHipvZF7Qt0wgwXwhNMDSpIrgzW11n9LBY=;
 b=8pimNyDGXNzEl9GUpN7Z7wb3o2a3g+9Fung2WFtYQIGnL7Kk5LNNsPZGGf4IeLUil+4UCHuX9
 65P3erQLPnkAJHXTPIo3PfSQ08IYzKF9rHQm7V7C/JPhAyowoiw8Kki
X-Developer-Key: i=qiang.yu@oss.qualcomm.com; a=ed25519;
 pk=Rr94t+fykoieF1ngg/bXxEfr5KoQxeXPtYxM8fBQTAI=
X-Authority-Analysis: v=2.4 cv=aM/9aL9m c=1 sm=1 tr=0 ts=68f2ee7c cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=eBPcRD9z0Nary0_f1DAA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE3MDEwOSBTYWx0ZWRfX31cb7wqCZs0N
 i9F/5fE/iE6reoulLAAjgn9+wiSU+H33m60Lqudfg4NoLv0uIsIPopzk3y/fAqh4OjJRR5964kO
 sAT3kSE1+6VCIY67orxvXDkFDTHxL+BJlHsd73W1+GLWvDv3a9jqotm+jVENmbfTOYRTYSOaceW
 h5JXiIe1C9ddF45dFi1IBlbPboAkVJPDJTq69mTf8zsXm0tV/SE+puEIZeGA9IWAqpyKc7yf5N0
 r5jaxsYzOJAmySFAN5BVGEjvmpxx3JlUdlw4GEcrujtZs/5dV0K7Me1UQy8VD4NkKd2FaxmXgqR
 Kn9QhC9yiIM2Ym5twGUa8BcO8QnA2VBRDh/bbH15pFMtxyu/i3sU221cNPAuVL4NcbipRsLRTdP
 wvLWTvoF69c+1lmUYruf4HO95ybC0Q==
X-Proofpoint-ORIG-GUID: JZ0Zb3NwgAYwqRuPADH-JiHBp3T89Fa9
X-Proofpoint-GUID: JZ0Zb3NwgAYwqRuPADH-JiHBp3T89Fa9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-18_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1015 malwarescore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510170109

From: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>

On the Qualcomm Glymur platform the PCIe host is compatible with the DWC
controller present on the X1E80100 platform. So document the PCIe
controllers found on Glymur and use the X1E80100 compatible string as a
fallback in the schema.

Signed-off-by: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
Signed-off-by: Wenbin Yao <wenbin.yao@oss.qualcomm.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml
index 61581ffbfb2481959344490e54daea001aaa4ca3..59be6c66b39b5e78418194ea4d8686956303c8f1 100644
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


