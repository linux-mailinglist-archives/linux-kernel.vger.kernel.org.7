Return-Path: <linux-kernel+bounces-779462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C209B2F46E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 11:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A44E960398C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 09:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148662EFD9E;
	Thu, 21 Aug 2025 09:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UTZQF6JW"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3F92F3C26
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 09:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755769498; cv=none; b=Y5N1uNhgbTxrgZF/vDH4DUnqJrnNrHrhDQZs6CVu/OpkjXM4PzsMiHxGZjhhfNPIyviDrQVVu8pGPEJe6ki9Ema5RXA8O3Gj2rtBIanFauFPppmTStDgn8t+D6CWFsne3BkP5sM2t9klW6lCRw8sK6NKUEg3Fd0L5kye/vIuneQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755769498; c=relaxed/simple;
	bh=ekdA9CVOTz1DmJofPhYI0+HcBHPnLV+Txm+2ENdkrHs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HVxM73XrJLHtd092td0Fm9QxCGhNaTK7fIQgKbluMfZFgZgDDk4Qj4kdZuikk+hY+ra0nIwBKhxgpDYmDbMJPKdVqh7qO1QpbGqPaoBIJNh2RUrxhkX+Cs8wGmDLuU8cbdziOt/U1ai7PqVew28LkA5ZcOvo4HLuDIkGeQzxF8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UTZQF6JW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57L9b824012907
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 09:44:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	x/mJfVjavIoqW9T/ceCVgzgHEhxIAMs4Ha+bWe4V2mM=; b=UTZQF6JWyKAbbNAO
	CEckhQ8WUH5jUPHMkOrnvg0Kb7HHZni+BbQNcdgkrXctZMn3aN9iou480xEw9wVc
	frbMySBIRbYIZK+aiMs9RTQn/l16HSwXoyB2dVFIFmxTymj/SDWzlb8HbZYktwMG
	sloO9nJnQIT5ju+mJGEWWY2AuEz81LXyeC14CPF6WWeJIZ8uyPV5E4MG7KYlF/1s
	RI8GfoD9LS2CD+HfsSEaudSs1pCqkfMURPD5/jUVfcjXPRxZ4c3oiyQmR2zfzjdS
	FRt1NMrLPp4ZqxWMMpQrZ5HT6bt45f+p4Av4gSbRBHBM+zVWFLu1vqQxSe1V1XT5
	+WLHtg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52dmvsk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 09:44:55 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-323267915ebso1907982a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 02:44:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755769494; x=1756374294;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x/mJfVjavIoqW9T/ceCVgzgHEhxIAMs4Ha+bWe4V2mM=;
        b=EPVC+LTcT0mIhe+Qu4L+vMl75jW4yxFFxs1JvLHoxwitv1S+6JEai8EfLerq2qCp9W
         BEMpYA8qU5f0m3vryQPF/WCp3aVmk6ly/+4Jt1mMmegDtbXJh+wkH/5lCVPxlRk4obyo
         diWiucjoRsr/c8YYvEfgytuvDoN+mt1Nwhyq5cIdj/eoOUNZvqGoctnEVHsop6XJB4Ui
         woFfEP/RvqCdDwvyHNaSbIvsa3ZvK9i+Z5eoAjJIXLTsNMf0/QL4spwmm54RibTHyHHD
         izkdGJRkJRDcOiX10HryYnmjjxNvQvIppe/Oa+uLyA21dUXJVX0PWkLSMdbp/eYkniEY
         gH4g==
X-Forwarded-Encrypted: i=1; AJvYcCVKo2eJO43XnKuWFRbR+M+oxlemNHIeH3CS0TfET2OZ+A+UM6lCon08GkUGldfzZ2fD4I0lV387DrDVeA0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4RkXD1Bo4PsnxBzeoecmzHWRuXPRuuF6h2uDr4v1xY45CkKFV
	L/uXW5AueqK+Oa49d24gSl6hP+E3qaf0qJcR/noV9lowaRveLiWxCRskgy/4PfteCUMb/gVAXdZ
	I8dkztxVNWg+Za2FlpJXlcriC9fMURIa2MFui/KPZ1+QqwKo64PSiVh3KixidkroTbLU=
X-Gm-Gg: ASbGnctLEXjg89qjhhD9ttA4aauUDDEdF9xPT2feSAxtRSF6LwBRV/iDmikBU4F1Bm0
	efwx/RQKjtQ01brLFNp7z24ikkkLkbX6fqcIMoy8pM2ufJL3dRTYsor48pOqvMpWf1ILN4WeKPz
	f6m06D3BnhbYCzZERQ49fjx6ejfdEd0rqusrPJU6G94pm33pApiAgwUVjnAR4m9OXbCmdoDqQDC
	ZAnFlJ8PjlGr5ubxf0FrWiXTdl3x5/atrV5gxxWiOetmeUb58nGx3O/wR3gy2Qfw5nE7p9lEux6
	8Qlv7El+s+7XXa5VpHNwvlWWixpU5irbFpLiSfjB4HgAQqn1rSIPGomQHtAZkkOKZoyN9CqoU+c
	+pp89K1eZO2KzYm4=
X-Received: by 2002:a17:90b:3d08:b0:321:c2fb:bcca with SMTP id 98e67ed59e1d1-324ed0681cbmr2515843a91.3.1755769493912;
        Thu, 21 Aug 2025 02:44:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGN4QGoSOSkyHCDquqO4K7cRbMNAnFqN11llAdnPwRvafPdrmBPndjXdBnrgoZqS9H+rmNwvg==
X-Received: by 2002:a17:90b:3d08:b0:321:c2fb:bcca with SMTP id 98e67ed59e1d1-324ed0681cbmr2515809a91.3.1755769493384;
        Thu, 21 Aug 2025 02:44:53 -0700 (PDT)
Received: from hu-wenbyao-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-324f23d853esm1426078a91.6.2025.08.21.02.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 02:44:52 -0700 (PDT)
From: Wenbin Yao <wenbin.yao@oss.qualcomm.com>
Date: Thu, 21 Aug 2025 02:44:29 -0700
Subject: [PATCH v2 2/4] dt-bindings: PCI: qcom: Document the Glymur PCIe
 Controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-glymur_pcie5-v2-2-cd516784ef20@oss.qualcomm.com>
References: <20250821-glymur_pcie5-v2-0-cd516784ef20@oss.qualcomm.com>
In-Reply-To: <20250821-glymur_pcie5-v2-0-cd516784ef20@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755769489; l=1172;
 i=wenbin.yao@oss.qualcomm.com; s=20250806; h=from:subject:message-id;
 bh=jt6UG6eiIFzDb1oeF0pFhVGf3jfLG0hsOnnZ5HuEIJI=;
 b=iVAV8bG9k+1C7FYvQNu0ndV0BZQ3x7EFjTeiL0LohmKaBaK6d5AHjlrw1HUjekakwVBfWMLUH
 8CIuZ2ivKYeDQCdzm1zrXjBWXEQgZcZrjChM6VspFo0bMv8qJlyFeMk
X-Developer-Key: i=wenbin.yao@oss.qualcomm.com; a=ed25519;
 pk=nBPq+51QejLSupTaJoOMvgFbXSyRVCJexMZ+bUTG5KU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX1mE3lCzm5Tao
 ycOzxDc+I1uDuBSEyYlL70cdZgndgaci9/JoyggdMJWzKAagYfty1LmuPK1RrnJxwOg7BxfJSEL
 /fABv89cuNt1EyOa6Oit+pXuQttg2OlU5nkiWiKOONmBxXbEegcbLgMq/KT9Hvq27dUbbNV2rBq
 NIbxkDfX9zDV9GfgJS52C7FBlwC0m8Ymk+hIiNeiAMFU5Ug1oqE3cLR5J4DjGhqLnlmSBYFc8GG
 zhcoYurIKmqmK04ooDKRF4+4yNF7ghyss45t1GRZSEStzL4tWvGVmJtOik+TntQpDkGv/LQJfnX
 V41l1U1RfKazd3IUFILHV4po3YDBuMMNg1VH+ApZblJ+gq9fiGhuF7Z6zr0A5DvmOFT3b73+PSB
 bgogQytxt+NNj3Vq1qU0C3lV20gJCg==
X-Proofpoint-ORIG-GUID: 7h5UDaY5GU5kkW-SpRf-r714-IVuBQJL
X-Proofpoint-GUID: 7h5UDaY5GU5kkW-SpRf-r714-IVuBQJL
X-Authority-Analysis: v=2.4 cv=SoXJKPO0 c=1 sm=1 tr=0 ts=68a6ea97 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=WgZgizuZlwTqGGW0kXsA:9 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_02,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

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


