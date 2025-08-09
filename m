Return-Path: <linux-kernel+bounces-761067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EDA0B1F3E9
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 11:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0473E7A8F7E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 09:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE1D256C9F;
	Sat,  9 Aug 2025 09:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Lu7jw/XP"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89122253939
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 09:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754733586; cv=none; b=g0l3pp/5NvuoabJiCyarRTk6s6b1rzlQzlRs5HjHF8eje5wOvmx2AK73ckSYu3s6e9sTH4cIGkRHZ9xVzjwopsX244R+gBB/ymiL+dQQRX8peifFfhNodjAaUlfP97Ov5KUnZ+4oqnZ1cNf/rUaZvb/0sSc2Hl6wuryAPddUmaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754733586; c=relaxed/simple;
	bh=JIqajmtdSDWh+9JO6OyfRjiQd6jzxj/V/KzTUJ+HkCk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uJfwUfMrxfbbAC/1lkwhNFNw8NR9ywmeGTTVhelTOq5I7bpPw891kQ81vSxXZa+Kzd7DmzFtmaQTiNl0BgZjQjCb0pMXnSEuig5IuKVpFl0Qohs3t+Ar9frYGWXKqCfv8r2bIVMiBeAvkNnkPFtwPgupQuOPtPSMzJXbfo/pinw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Lu7jw/XP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5798mo0u017224
	for <linux-kernel@vger.kernel.org>; Sat, 9 Aug 2025 09:59:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=B7gs4hTFxwH3YxsLcB4ZaC
	WQf1OGFUcKEqvS+jFTsFE=; b=Lu7jw/XPWg7RLTTozBNo0HtL/TVmb4SwI0piM8
	gSRonfPmhQoR7sPrDXPZbjqwfHjtY4En7YoMZhIBiysmCH/XIpm2KIbl6RKlvNxi
	Xv65f/iCzUbeqNudrso8TvwUSC7cehM3qy4B8Dn1NJohz2pelR5lbakgJBcsL80r
	hWBcJFx5WeevTIIZIuY76oSQLDZUyy55C2QoLi+Q92JO00T63vTfQgf5b9LD8zRt
	0zHlDBqeg7f/fXqIWqVYPX50AzaWMGeG2W4QstFaeCtz5d0tU5f5LELPu0t6lRM+
	WDfV5NaAmYrEtul1czWLVsJQRhSeBBboDQoUPse9uuLKtn8A==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dxdurek2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 09 Aug 2025 09:59:43 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b42a54b7812so1239526a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 09 Aug 2025 02:59:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754733582; x=1755338382;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B7gs4hTFxwH3YxsLcB4ZaCWQf1OGFUcKEqvS+jFTsFE=;
        b=MbafnH2munkYvZjWBOVgw8yYTQGOYqMY2NGYc18T3IrUvOQg5pSqh7eW8bxZj+68hA
         0Yp2hL26YTRUSFSul1OeyMAtN62pwxJtLJpQNvNygMEftLAwdymCfe/Mh6S8ttqLBEmM
         JXXXvoHnjjKTUMz9aj8R5aw6rgoavQwNV1hZrQczfHWF01YVOpH+CuscEMhpDqiKn7dV
         yDZWca4UjV50AMn+rCTzjQYonE48vSajfkNPFZ6U9Znl43aaAxo2bCoxds/QkrHk1IoS
         PNMoHThaze9heHduLlmM0/+AsbvCpFz7DMogXoC6Xa7KAAd5Z8a/5gxXc2w2ZWOA6J9J
         kImA==
X-Forwarded-Encrypted: i=1; AJvYcCX9toyyVAeqZmYTOxCUI5kmyaeZuNoxxn5IQBSRIa17KCsBit9Jw8Y1BtgHTQcsfhIjhZrSeuSBJn2ZOws=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3TLtaTwd2kRCl1UETbWnUa5t9bWKfyus1sM4oEjqasS6zDWkA
	poErbzMRcL+0MlZ+d68c6gC93t/Yafgyh5H7wDivrXllDDsuAGyR5reP+FqdVHDLOkyd+pjFix1
	oaiZaQhDpaw24/Lcz2/o7p/ci8Wfy423YO/2aIgcEX809WvjxlGrqqxqfp9K8mfegZlOAZ+X7mq
	I=
X-Gm-Gg: ASbGncsz10BlMlARlb/io9CcUaiI0xX75Qba/ZXAaukaMrYULhPX3Z0dPTAxUPCAPMB
	dVM+P16sqgVMeXX6JuC4kqGXAuSfQCdmDwB2Ba3izv+FKWlxXlgEwM5QpnILqeq9EC7g0Gx98M5
	CUx0EnXiDBlHDjmSZQ442FYQzy3hl502Jh6m/pUNMjqYQ1lB3aWw2p7190RuDVKeCS+MjSBAGMF
	rVsd5X8EIv0c7gIb9/FA1LP+DTK5I9NBKdf9iu4VRzVSpzOC+KzY4oUJl3DQJGmDq7kZP9mHXSX
	iVxbMF63ZgPZvULR/C5isa3hoIx4wxAD3hgE556IilWp2DBbT3IQMGrcAeb/faO57/T5bOsrGC0
	=
X-Received: by 2002:a17:903:1b26:b0:240:41a3:8e0d with SMTP id d9443c01a7336-242c221775bmr95568625ad.36.1754733581856;
        Sat, 09 Aug 2025 02:59:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGFCSZuzVmsIIkf+AYK0rGcOQzWTHIlpDNibLokhgE5KNUVYtisa4qZXZAAwYsaBSlgc6/cw==
X-Received: by 2002:a17:903:1b26:b0:240:41a3:8e0d with SMTP id d9443c01a7336-242c221775bmr95568245ad.36.1754733581394;
        Sat, 09 Aug 2025 02:59:41 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e899b783sm225962845ad.133.2025.08.09.02.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Aug 2025 02:59:40 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH 0/4] arm64: dts: qcom: Add PCIe Support for sm8750
Date: Sat, 09 Aug 2025 15:29:15 +0530
Message-Id: <20250809-pakala-v1-0-abf1c416dbaa@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPMbl2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDCwNL3YLE7MScRF0j00TzZMOUlKREC1MloOKCotS0zAqwQdGxtbUA8H1
 EqVgAAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754733575; l=1194;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=JIqajmtdSDWh+9JO6OyfRjiQd6jzxj/V/KzTUJ+HkCk=;
 b=kDfkSZaxVXL0BFqDK8S9gzh227+Pn8id/z2GPwjJZrxbfe93CFqWxDBD7D9RZDsM1iUFNsP04
 7q+h23qTyusD9aQK8FP3LRAoKYb7XIl5TY0tqmuRqWdN8x5wcw9+aHD
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=IuYecK/g c=1 sm=1 tr=0 ts=68971c0f cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=KRKipztoQesxEaMeAmMA:9
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: YtXUPUV3Bz8YtFPBNchiPmz0a3ge7Yqi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAyNSBTYWx0ZWRfXyxSyS37/ItnG
 Cvk3Iofc0HpsnlGTbHWJna3HPBI0cKnXqQJYY9AFi9iUlxXaERknrUzcnIX8WdOY8xV3abao7dL
 7yipLJTBXIKsZji41cj4SnFhlKdFZNDsPSCRPMKci3XaCpp5jTfkDUVpeS+mZhTwwEijaf4v6gq
 kI61itkkyTTGGmtc1Wgt2/en8NA18jWbUMU4YR8VIvDY37/Bzu/cYLkcdZ1iiN7TeEUAaX+EIpi
 F94YMsqrUDp3pzH8SEGaogEtJULJZ4cNuyaeBMv33iyAkYDF+3xfPPTNLnxDCMz91DL53QJXqs1
 aCfvkZ8u2eluHrhZHunx70Q+HH/dfTcy9V4zV7qGJ8wA+tHuzYACkmtezj1Tbi6Cck3h7IyHysp
 m0zJ9cvy
X-Proofpoint-GUID: YtXUPUV3Bz8YtFPBNchiPmz0a3ge7Yqi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-09_03,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 phishscore=0 suspectscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090025

Describe PCIe controller and PHY. Also add required system resources like
regulators, clocks, interrupts and registers configuration for PCIe.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
Krishna Chaitanya Chundru (4):
      dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Document the SM8750 QMP PCIe PHY Gen3 x2
      phy: qcom-qmp-pcie: add dual lane PHY support for SM8750
      dt-bindings: PCI: qcom,pcie-sm8550: Add SM8750 compatible
      arm64: dts: qcom: sm8750: Add PCIe PHY and controller node

 .../devicetree/bindings/pci/qcom,pcie-sm8550.yaml  |   1 +
 .../bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml   |   2 +
 arch/arm64/boot/dts/qcom/sm8750.dtsi               | 174 ++++++++++++++++++++-
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c           | 149 ++++++++++++++++++
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v7.h         |   2 +
 .../phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v7.h    |   4 +-
 6 files changed, 330 insertions(+), 2 deletions(-)
---
base-commit: 37816488247ddddbc3de113c78c83572274b1e2e
change-id: 20250809-pakala-25a7c1ddba85

Best regards,
-- 
Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>


