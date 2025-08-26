Return-Path: <linux-kernel+bounces-785983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D740CB35324
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 07:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D804240C4A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 05:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF1A11CA9;
	Tue, 26 Aug 2025 05:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AH2uWj3A"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A7E2101AE
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 05:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756185515; cv=none; b=QCWLJs0EWmnPaf54/OJ/f67A2hdBA0xpQHXRqyM1woIVgD7tlVu2OdfHO0aey6z2KRx28xeCsxCeifGuZ4yRp9EXnsd4NiJnxtMrft+SibxQXaPoLzIFw4Q6PRLJ1I17db/nssi5IlHq5SbcQd3oQ927Ju9WQyfo+95eO0oMC1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756185515; c=relaxed/simple;
	bh=vlIwpMdPLzbszsLDUE4+FJfpWc1+VEt9tIvX90Lc+30=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=sn0y9H0IVS/OjqB1Uz2nuaFk+OlZTlY/mZ7+7hKKv4SQHQp684Ajcsi8aZ2890TWBTSDou19G0mPxchM6vwK/zRJ+HAPbCA02iCx06yAMr185qOOvm0Uo5fOPxqwNaK0pnvNhC7KnqIZKtd6lg3pYhX0ODqZLzDlnwdjycm3b3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AH2uWj3A; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57Q3BHqK006924
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 05:18:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=2vsPhyKBqG+IBewEtmHLJo
	hfftWb+4Dg3ZClfwqwBQM=; b=AH2uWj3AsUXqsfQ9CHE3rUMsJRLP6TjvIt5RW5
	7gJxkvCYE8uNT5h6V4K+VAen4WClM4AcRMf4qlHI4DV9FEfBji66EpcuTyNPQtKn
	yMrrKbWItE5QSrrkZm1y7GwnQz3oBDjN+0D6mh3XYTnvVE9pxPoMA/wqugwrf3IV
	vbJTNp5c3Da2VQzyXaxA9Fb8/sOwmmBCoqqd/u3ikMBfV9CMOurqWSoJN6v0VQqw
	jjnyed6mhXC2ZimLNKcTkQj4BHdgBn+P5I9oS6ERPYEUXM9V/n2/koFs6q7YGg1Y
	o3wRNklyQAxWoS3lH7Zh0U5kwn3QroqCpYJUEX9Yez66KixQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5unqd8r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 05:18:32 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2461c537540so53488345ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 22:18:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756185511; x=1756790311;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2vsPhyKBqG+IBewEtmHLJohfftWb+4Dg3ZClfwqwBQM=;
        b=Pb2NWHpxuXPLoCJFDqnPQ9v2jLZFWq3UZroQCuif7S8hY+BxDy2+VnYbJFfCohTFq/
         VvnYvkmban0lJgrzm43ItwROGPWi7DasbEsB7ypW7GhP7bIimLxqlr33Ny2LslgAZBZC
         XDh2qXvB07NahvMPJVFAfxyvRyf6Drc5vlVLD81mP4CpfifT0GgZXU27ULPyxeE0//nZ
         f0OtV2qiVXnhtb5Eaomb8qh+TPXkBM/PJw8fpxfwJLnUq9NWDsfK5RAvXX+Wke3iqHfB
         LCiL3Qb3q2jNjx2W4sXzU/zNr0c7ajks7V8k0OTd2jP2Xje5ovCfppDTQdnpNxzsHALa
         Hqng==
X-Forwarded-Encrypted: i=1; AJvYcCWZjDKv2ThzyPEfaXt0uiKlwGuHPNAqsGFCWiQDqwIqp7qHKPuEKSm2eo4mihCtlKTegehGpmyKKGszOak=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZphzoDthwdxQgfoQczaduYxckMJYkndD3160OixLPBjvetm7S
	SajU7YjNGTTl+ZiKnVSPRe93E6S6BOOXTQ9GkREF0HGlc6xPVbpJygWEimsycBBnk4+B+6OTwre
	eNNLPTu9MMRJzOGNjEBMfuAxqXvG8zkTCtcQKhUQmgs39QEWLOuJ74vTFzjVGCdQwXnM=
X-Gm-Gg: ASbGncuQW21XQrf01tpvhSQC1MzfGXztVsy/rix7dBow2ws7CvbQ4WfSTLSPvTv4s7O
	K/Q+LcZWRP9Qg8L1gGGbmn3wlQRZ+ICtJkTC+daao2f5u2Hvl8zdOldO2vv5kCvADSs8KNFd3Wq
	hyfloR9pYSm/MAuSYf5YWcUJLIm4XaP+9CHkABw4D3Fz5gTya2jht5z/pm647MRj9XHs55f1DTz
	JQJMgTLkISMINdv6sWBjYPUPmzINzQVLkQVc4a6MnRWFzncJoU4C0qmsyRoldmPEvIWbg45fwhY
	+/Nj9ug6vpa9pHwvaQeBqAYgpzxxIWkjpJaxo3dq0kyKMy9YyJoXJV8htP2ajyBHTbewZMq2wgU
	=
X-Received: by 2002:a17:902:db0c:b0:242:a0b0:3c1f with SMTP id d9443c01a7336-2462ee0b27dmr189012765ad.7.1756185511511;
        Mon, 25 Aug 2025 22:18:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGh6SmRROLIr6PMOz1PXF4cr/CmjrIyVmNC6hvrLBZh8ZNDcT48YrclMSup6MtV2RwVhMvgVw==
X-Received: by 2002:a17:902:db0c:b0:242:a0b0:3c1f with SMTP id d9443c01a7336-2462ee0b27dmr189012375ad.7.1756185511073;
        Mon, 25 Aug 2025 22:18:31 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2466889f188sm84348085ad.146.2025.08.25.22.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 22:18:30 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH v2 0/3] arm64: dts: qcom: Add PCIe Support for sm8750
Date: Tue, 26 Aug 2025 10:48:16 +0530
Message-Id: <20250826-pakala-v2-0-74f1f60676c6@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJhDrWgC/2XMQQ7CIBCF4as0s5YGiGh15T1MF1OgdmJbKqNE0
 3B3sVs3k/yTl28F9pE8w7laIfpETGEuoXcV2AHnmxfkSoOW2shGnsSCdxxRaINHq5zrsDFQxkv
 0Pb036NqWHoifIX42N6nf949ISkiBXa/sXh0KhJfAXD9eONowTXU50Oacv54v/WGjAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756185504; l=1290;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=vlIwpMdPLzbszsLDUE4+FJfpWc1+VEt9tIvX90Lc+30=;
 b=0KL+6x8TGQEUpYJvqY3iP7+9EiYO5OHNdo3h8C2d3xI/A7u5IucNW+PqyxEKSkGSKdoxYvNTS
 VfQB9wQxqcECRS59Ps24xjDDVMDDAnOl+9daRomBfOlTaY1dUeBmR0y
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: zfBR9lgjtwyQaY83Zd6DGw8kmobkYdZg
X-Proofpoint-ORIG-GUID: zfBR9lgjtwyQaY83Zd6DGw8kmobkYdZg
X-Authority-Analysis: v=2.4 cv=JJo7s9Kb c=1 sm=1 tr=0 ts=68ad43a8 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=qIbWdXD6M1inJYch3NYA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMSBTYWx0ZWRfXy6r/4DwAIOlD
 NruZ4jE/mqPKdQAHrp14NNPnXYcCc5hHG5+TJH66AI5vP0ZOyq1ZAGHFNymlACLbHeS51vANJlP
 nM6hEW/TRpRuWxVaQAdfk/k5XMV4vSSxI2oYTC6oVFmxZAn1Bi+7YQek4xUeoTcbxX+AVbMEqcV
 0PHrZ/XGOmWt1/xZmZyx9PLksDzI6p9okGRQ6pWlE1lK1eVqJSvt5y2aTWFSkLRxBsxMnFLqnOV
 w8tAYSDoX+DZT9qsnAkK4QbHCuiga/MRxBwpqMOmK0G+ND4iOdilNRL2UBvCgTMnhsFb0uiBuFI
 en9gQ4nClHDMDVaYocQ/x8P7N1Cb/gPkTXVs7U6MxUrm/l235+crqwJJYBk89AlkqRaP/CFOu25
 8Lw8aKiJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_01,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 bulkscore=0 spamscore=0 impostorscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230031

Describe PCIe controller and PHY. Also add required system resources like
regulators, clocks, interrupts and registers configuration for PCIe.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
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


