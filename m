Return-Path: <linux-kernel+bounces-761068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF86EB1F3EE
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 12:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D72521895086
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 10:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC82260590;
	Sat,  9 Aug 2025 09:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="puKuQImG"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27ED825C706
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 09:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754733590; cv=none; b=OCT2CcfoRClPuB7ANmU+qavq8+s8omNe5vSirlLFpZ+4SUELaTfMMDC/v25wnXfokjhgCzZRGjs3CI56L+0R9BxvwR8UOHENbuP5CGqVQjk8WzrgUrjfmFsXTGRty/B8qnpoYOgKdbM6amWvmVAcHpj2UL8X0yJ3w6pS5mn262E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754733590; c=relaxed/simple;
	bh=R4uNQJTJ6TZ6UIRq4jvXRMv3opNeQTLyTEdp1tmrcFg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bqA0Xb8/Mi0h9wa9fhx6YsJiK+lKI9Bs94x9aRqwStLU53Ng8an0/52YRfXH6iBc1+adnvFexk7cTjPebwc73wlw6emNOZAeIZs+cSSy+R/9/2D0N3x38/J9QIOCRX6AQLJpjY1bSqkcYm8ZdLeG6DZWC3LLoc3aAbf+2nXa6wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=puKuQImG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5793Lnow012616
	for <linux-kernel@vger.kernel.org>; Sat, 9 Aug 2025 09:59:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iBQ0e2SAV0/ngnuxIOs6ha4YTv6YdCMqfkqSUm1Uz4E=; b=puKuQImGkrw2xjYE
	KdY49eiqRNdnHwyRNr1zflmaFztoalO3ECQJMLsUzqks5MfKDWKlP6rYoX4TyS31
	rQ4Qh//C7FJ40AUzZty7lFrsw2Hgk4Am4WEe2jH3Bob/SO1huYT3D7i+GI2uc1oI
	q0HJqWhG9KEbaMyJvPpZ9dygy0aPx4SgTFPmhPVCnmWaEp6nWDSHei1PaFdTktev
	K609WAo1EHyj44tednHlNw3fJqFYkEPRvdeyCKyiGt6OdELbk7romPqTBeVZMVJ6
	LxbtO3AQQwjNp4chKo+en1ZeXmW6DVWnFn3vwFYSPcDvodM01f3aP8cUUaS9SNCS
	hJBVvg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dv1fgn8k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 09 Aug 2025 09:59:48 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-24004ac2ecdso47381865ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 09 Aug 2025 02:59:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754733587; x=1755338387;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iBQ0e2SAV0/ngnuxIOs6ha4YTv6YdCMqfkqSUm1Uz4E=;
        b=P42z89fw7+6rULmVUssnclHXhl+je0p+bIuLJt+2F3ybyIegQWQp1SepFpRaGYoKcK
         GsuN5pkzCbCBhBcLuGrR9WnvuXwHYPaEmLKc7OreunBrqN7ov12QnffcC+XeOCkm70e0
         BSoZIOOBg1w0GUdhcXIqsZy8wjx1GdKpXNt5tVFMzFZpf6uPLSFF5f5OdvJjiZZpS4k+
         Ix/AkdYuvVohp4kuiFFdoK/jOl/5NfZrlFvFMqaxrrm0fNT3PK5QnLBD1ciUNNevEt6o
         7fJh3d2KlF22IJRqvx2BZt0ascwFLs1GwObI5r0QH9jELFYC3t1r/D0gtqvJ/PfG3F9J
         ALZg==
X-Forwarded-Encrypted: i=1; AJvYcCUFCoFeDRMvcBSDZDs8VjlqVwyIrVQIBHG8i/R60GJNp35HuwYCYO1AByPBgH/PS+UsUKfnmGQsIL2p27Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBSRc757aiCIrLFsCaMa8iJWIAfdZ0VYA9f+k1bPsBeonnglfS
	cUoD5X/8I0RjlQJWiXBNPjWnD+BZfNH0t/4Gp7IUPcB3H/PP1eHdSxWU1HkPz+Ka35fhckrcguU
	CKatPPYFb0JZYDwT4Z593YOZ/ndW6Ms1hJ8yvyfSWN8+9+xl+9RiDKjzx+YFPwsGAnKk=
X-Gm-Gg: ASbGncvjmUg4PR/V8Bk4wZ3uQBRuWAaF2M4jZYyDXLn4VL1RD+l+hg93B5S2LhpzpFY
	SK38MAEjoeuj6s4vXRiaozgjtPEineCRN167YeHLWvh5IwEKumOkWWozxXln70VcISzhTIjo4cu
	pYA3P+QHNzRjTF23lJKJNhkBHHyEUZNhglTxVhj98EJ4njTdtYh4q7Bgqm/Dx0ef7VVaDVVxUDD
	8fPV1bGNM5ozzvek2K9OJgEmEJBaWO5LrBRyRHNkuYyKBWEIXh1oI4UHKQ5emlFWOAsaUkVt4sP
	uFS6dg1G5BgVmqdRc0G5wlhQha+NwV0ZaKJdVdAc86xYNTaRm+FovzcGs+R04dXLj8meWj6CNMg
	=
X-Received: by 2002:a17:902:d2c9:b0:240:1953:f9a with SMTP id d9443c01a7336-242c20703d5mr104333285ad.2.1754733587516;
        Sat, 09 Aug 2025 02:59:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4c/wiGzwRmWvFnGhbo7cmBsz+6nWkl5TgRx8Q2bsS4E4Vq6y5oGW9hWnJRcnT/BPcwMFLTw==
X-Received: by 2002:a17:902:d2c9:b0:240:1953:f9a with SMTP id d9443c01a7336-242c20703d5mr104333145ad.2.1754733587106;
        Sat, 09 Aug 2025 02:59:47 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e899b783sm225962845ad.133.2025.08.09.02.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Aug 2025 02:59:46 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Sat, 09 Aug 2025 15:29:16 +0530
Subject: [PATCH 1/4] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Document
 the SM8750 QMP PCIe PHY Gen3 x2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250809-pakala-v1-1-abf1c416dbaa@oss.qualcomm.com>
References: <20250809-pakala-v1-0-abf1c416dbaa@oss.qualcomm.com>
In-Reply-To: <20250809-pakala-v1-0-abf1c416dbaa@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, quic_vbadigan@quicinc.com,
        quic_mrana@quicinc.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754733575; l=1281;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=R4uNQJTJ6TZ6UIRq4jvXRMv3opNeQTLyTEdp1tmrcFg=;
 b=Pn44e4XwnwfvY73BZod/cOU+TNd9XbdK5DnaUkh10yJmXKf+BBVokgllhEO5swZK6AJvGflcQ
 3E3Jgc+ZT5JBvWhJhQOkMM5Ib7UJOT30HMRDM4dxwY/tg3q7YF12YGJ
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: D7DbS9z8RDtLBAyL8U-tD2d2AloY3_uz
X-Authority-Analysis: v=2.4 cv=cLTgskeN c=1 sm=1 tr=0 ts=68971c14 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=AUvBg9Asf6StguVY0UIA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAwMyBTYWx0ZWRfX+U3BUgCkTgBm
 HUVEf9MT8OfPF5JZAQGnLptFHwldKulc4+qxufCX0LhtNant2Unkn3xUR/1Tb0bw9mRzUqFzLei
 bIkV1vpDv2cBr/M1cX7UxjsNNnjWtEkWZETO2PuprrsVkipvAg0zN/MokgpxmFTzmJhzB9yjDKe
 FEyPfFNLj1XEvOi5JoBxQ97ESc2CEs2wS2ijF90EWoB+d92MtlC0kqy4+zHcQeShBtK3PYvWaTf
 HP4btB032K1uvePUg5ujbnqcnNkvQKN85PeYB7T2C97LpDobwZxlbceKApTaIbi154JMcyl+zBM
 9n8RrgmgeZ0tSPQ/NKudY+17yjdxa0QV5bEvnzqQIxJEMtPywPZBDTm/6w1wNattT64vqz6Tb+G
 6YliCB/V
X-Proofpoint-ORIG-GUID: D7DbS9z8RDtLBAyL8U-tD2d2AloY3_uz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-09_03,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090003

Document the QMP PCIe PHY on the SM8750 platform.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
index a1ae8c7988c891a11f6872e58d25e9d04abb41ce..cb706cf8219d015cc21c1c7ea1cae49b4bf0319f 100644
--- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
@@ -42,6 +42,7 @@ properties:
       - qcom,sm8550-qmp-gen4x2-pcie-phy
       - qcom,sm8650-qmp-gen3x2-pcie-phy
       - qcom,sm8650-qmp-gen4x2-pcie-phy
+      - qcom,sm8750-qmp-gen3x2-pcie-phy
       - qcom,x1e80100-qmp-gen3x2-pcie-phy
       - qcom,x1e80100-qmp-gen4x2-pcie-phy
       - qcom,x1e80100-qmp-gen4x4-pcie-phy
@@ -164,6 +165,7 @@ allOf:
               - qcom,sm8550-qmp-gen4x2-pcie-phy
               - qcom,sm8650-qmp-gen3x2-pcie-phy
               - qcom,sm8650-qmp-gen4x2-pcie-phy
+              - qcom,sm8750-qmp-gen3x2-pcie-phy
     then:
       properties:
         clocks:

-- 
2.34.1


