Return-Path: <linux-kernel+bounces-786499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6399B35A97
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 13:03:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C7AD3BDBB4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 11:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6EFB29BDAC;
	Tue, 26 Aug 2025 11:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YQbJgUWt"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3EF222562
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 11:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756206186; cv=none; b=IpRsGA+AH4XqxO5X0WKkvLK3XzkA4ImR0vG29vA9DgeMfre5zVxj5glK9AeqA4ejhnAscsW5PiHv/5ur8tW20FNUUWls9ghBkJDoxsdc1OzbsNQRNVLNqIzRfyXQBA+zGMfCrsuMc9mITGnsy6eGn7skuGVw9Cyg2TdCThhP3Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756206186; c=relaxed/simple;
	bh=dTps1W7yFBJgnc5AYKWxbmGHLBztW+e3CUQk4PYJS9c=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HQnE9JMfqlnY/rs6h6G1lKpNJ2mqNaZ7Nb7tkWztHegcRLXyjyhNLnHukeqBpG1qFfSXgHjt9JGDYZXtwjLZzwGmVRjH8vfM/7TqFAQrpNfDnQ2Ap5+2Yl1hBCJACiQylZeAjEFcWhmerHWprKGdaW7UMfEpiqda2xI5DXK4re8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YQbJgUWt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57Q8caf5018268
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 11:03:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=x9+0v50NQTkfI3P1V23OCP
	NTgsTLPjdF6d/vJu77srg=; b=YQbJgUWtzh9VARKrz6Y2d8IqYx5EfroBLX25cY
	oVV82xflgoLeCUiI0VlKW0KJbTq8GI3ksgpk4ZPbXWMdua+nz9FysRxE8f4pB5QK
	BoGfpEyXt0nS96doNvPficDHoKBnWzzR/v6X1N+NOb1sauJgV2a4D6nzFoHjRhCE
	dp0XSKXlY/IwIseEbe4OyddYVrpqF/HitUgPYSSOFFp0+cwBU/J0beelHo4YM8Gz
	Ea09s9ZnmKN/1MtZyUKPdisI3uFNt9Gs8xN91AN7UGOrPZeyNCIbGSEvrpCNYAvY
	mqOT+jwpStf+5KNoebVEJO8gTtRfI4jNPLtjQk7dwDVei0oQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5unrdye-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 11:03:02 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b4c1f0cc4fdso1238971a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 04:03:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756206181; x=1756810981;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x9+0v50NQTkfI3P1V23OCPNTgsTLPjdF6d/vJu77srg=;
        b=EvVo9O4kl8wSIhIBUXieu60qFSRbQ7K6+8YxdjDMEGtf5R48DhgspFM+HRZU2fYDlk
         YwdNaHT9aY55Flsk9WW71QtIostzhkOK4l6LNtiUjId5kDsJuQFqRIcqvhkCsQIVawoA
         /j6XG2KU+xqtMtC78BjpWWWdE9uVCzpzVrqCKaokHvjbjOIsWF7gMdwC7B9hPGgBdb0l
         M9G8JBGoIXd2NanJnk0CnACvv/X6AHJgNUYNToaPbab5tw1sNWzzxWjdtXJh8nRv7APs
         AiWAQADuBeg8ojjeCcmkfdb6r90M7g4dpKawlzmS8xuPir4Ka6aMtdD818CD4LPV8uPP
         6dXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqAoU0JYDz50UH0/Ffc88STtf37yeXTQShsqnIkBWIWhkzWe1w/+0VckuTNnmFcbP2KRlUcVkwO5GVbow=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAzFxWorgXA892lhzHekZU+SJE5Or6QZ9lPhPs3wvNhu2noqYh
	aJ8MtzyRrGWYaJVLE9y4Li8UFqaZymhd6eki6F1pSIts8B/4WBRSInpw2+77P3dV470HxpfH8bi
	/tzpaCaPQ5xwR+dIwIlXBNtJiX6UVZExHiba5coFAkKzKYyESVvg40MGWOmrEzKT1Z4g=
X-Gm-Gg: ASbGncv+qdkI0SowDTpkAxhsq1Vo9YrnGsoltGygXi8tQkq3OE5T03MSa/MGfPz8Lpz
	AS0qC7Cq5It3sHjBALprBGH4cCuxsqwrkHYdRwD0ASKLhNEa8Fgi4Bktv30x7uVGaf2YRAeJL/o
	rg1iiCkQaCWbj3m6mTjljfnQrklaAsHhNFcm/wxJlb4fhJfctgc8IWIG57TIUXPqjxwdjglFH2C
	N4Bta5BOWBs01155zJ9pUQUmgC8s658nXJG1CrYRYGw11Wg3iaOKuFC1YA/mapMFPNqGVCc/Hsf
	KW9+ux6evy2nWGF3Hcc3b/kKEUwPmvKYyzGmIAqYmYVp0ltN0J+SW+QO+rdtX7nn/eDRoQVbHmY
	=
X-Received: by 2002:a17:902:e5c7:b0:240:640a:c576 with SMTP id d9443c01a7336-2462ee02b9bmr194581055ad.15.1756206180759;
        Tue, 26 Aug 2025 04:03:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9KK2j15pPMLTu9NzWYSjjBpeWDIhm+qorXqLMJG7JM0/T+BAcp2bQtDU3K0U3p+/axC0CEw==
X-Received: by 2002:a17:902:e5c7:b0:240:640a:c576 with SMTP id d9443c01a7336-2462ee02b9bmr194580485ad.15.1756206180270;
        Tue, 26 Aug 2025 04:03:00 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246688a5e5esm93207955ad.161.2025.08.26.04.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 04:02:59 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH v3 0/3] arm64: dts: qcom: Add PCIe Support for sm8750
Date: Tue, 26 Aug 2025 16:32:52 +0530
Message-Id: <20250826-pakala-v3-0-721627bd5bb0@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFyUrWgC/22MQQ6CMBBFr0JmbUlboaAr72FcDKWVRqTYaqMh3
 N2BhTHRzSRv8t+bIJrgTIR9NkEwyUXnB4LtJgPd4XA2zLXEILksec13bMQL9shkiZUWbdtgXQK
 Nx2Cse66h44m4c/Huw2vtJrF8fxJJMM6wsUIXQlEIDz7G/PbAXvvrNacDSynJL1uqjy3Jrgorr
 OKqUlr9sed5fgPes0x74QAAAA==
X-Change-ID: 20250809-pakala-25a7c1ddba85
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756206175; l=2165;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=dTps1W7yFBJgnc5AYKWxbmGHLBztW+e3CUQk4PYJS9c=;
 b=ORqzFVgp5adXJHIasbs9RHwU+iRtAM2wzhkSNTggapOaGM92dybSlm70kFk+mRAXNYgbs2HQc
 wFAt8sJbAseCRHkXVO0dDHAgFAkVcsMb39uenW1ggc6JKPRlsrUj2/T
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: wEVOdz-U47LyMo51IeX6kG0w7mN-UhMk
X-Proofpoint-ORIG-GUID: wEVOdz-U47LyMo51IeX6kG0w7mN-UhMk
X-Authority-Analysis: v=2.4 cv=JJo7s9Kb c=1 sm=1 tr=0 ts=68ad9466 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=l8mvWsQ0dvX29tmygDoA:9 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMSBTYWx0ZWRfX5elC7WrPAaNn
 jI713551E+gipGsaA4jfYu97Ws2393s68k+TO9xT4pXnT0i3lXi+Kw4votzCYIMxr1IKWDFefr1
 l84P0gcSJ/mjxFPxP9y9kHzaboTfCNuUiEFh2YRDTCYG3ftamH9f8yYSfzsDHsXoYxEAM1WXcim
 tNnBWRxf4qpebDuSiP4cILXyja7vzCDRET0xPSo4KjYANCfFUhwFHT0nBsfJWAkJ0pH97aG2XUh
 FeBXvL12ibhosG+gOiMjnvuhnwwHE4BAzAG9QfT9Wk+WK/Bc2UWd/XtFixbo0RZFw0oXxVhKJQ4
 sF2SEZN8h2h0hyQfgdU3VfVJcW5Abow1exjCJiVDTr8jtvGJlXjOU2DbQpa8xJu43NxJdj6b1oG
 yInCA/Ey
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 bulkscore=0 spamscore=0 impostorscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230031

Describe PCIe controller and PHY. Also add required system resources like
regulators, clocks, interrupts and registers configuration for PCIe.

The qcom_pcie_parse_ports() function currently iterates over all available
child nodes of the PCIe controller's device tree node. This includes
unrelated nodes such as OPP (Operating Performance Points) nodes, which do
not contain the expected 'reset' and 'phy' properties. As a result, parsing
fails and the driver falls back to the legacy method of parsing the
controller node directly. However, this fallback also fails when properties
are shifted to the root port, leading to probe failure.

Fix this by restricting the parsing logic to only consider child nodes with
device_type = "pci", which is the expected and required property for PCIe
ports as defined in pci-bus-common.yaml.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
Changes in v3:
- Use device_type to find pci node or not instead of node name.
- Link to v2: https://lore.kernel.org/r/20250826-pakala-v2-0-74f1f60676c6@oss.qualcomm.com

Changes in v2:
- Follow the x1e80100.dtsi pcie node description (Konrad).
- define phy & perst, wake in port node as per latest bindings.
- Add check in the driver to parse only pcie child nodes.
- Added acked by tag(Rob).
- Removed dtbinding and phy driver patches as they got applied.
- Link to v1: https://lore.kernel.org/r/20250809-pakala-v1-0-abf1c416dbaa@oss.qualcomm.com

---
Krishna Chaitanya Chundru (3):
      dt-bindings: PCI: qcom,pcie-sm8550: Add SM8750 compatible
      arm64: dts: qcom: sm8750: Add PCIe PHY and controller node
      PCI: qcom: Restrict port parsing only to pci child nodes

 .../devicetree/bindings/pci/qcom,pcie-sm8550.yaml  |   1 +
 arch/arm64/boot/dts/qcom/sm8750.dtsi               | 180 ++++++++++++++++++++-
 drivers/pci/controller/dwc/pcie-qcom.c             |   2 +
 3 files changed, 182 insertions(+), 1 deletion(-)
---
base-commit: b6add54ba61890450fa54fd9327d10fdfd653439
change-id: 20250809-pakala-25a7c1ddba85

Best regards,
-- 
Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>


