Return-Path: <linux-kernel+bounces-786025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3966AB353B5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 08:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 648A27AC4E2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 06:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471522749DA;
	Tue, 26 Aug 2025 06:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VKpsrFNt"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01CD247283
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 06:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756188189; cv=none; b=AE4yLKpK2D0e6oLYdxtmgzNRz7CuZls1xLsHeCvECBwaF7PBYdf9Jum0ARzI1vkvh8BBmLSncxw+IB3qY0LAUMNmuJ3NlLwvdxCDJ4xBpXS5YKOC7LlWJQ5jzzzVdytnwwEWOxkjHFQrtbdY4Df0brciLRgT/Zk7Rbs10hl8l0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756188189; c=relaxed/simple;
	bh=NMvu6tjTeXh3gl/g/huT9wGas8Pnxc/WPB+nobZ03RQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=G8waaVZTvro/+OFtR+6WRfHC44PAnv4pT+vyN7oVmwLyGTAV0fnLcCbe7r0/KM6ksYQrrTsr1PlcsLMpl9xJOmAe12Ngk7ofxh7nD06VroATR6LqaV6UOxSXoAx2EQUyiiRw8bnYgJdRdkuMbM8vhMfABPUNfzkQHQZGQTYdckc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VKpsrFNt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57Q0WmQ1029005
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 06:03:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=lEftv+FACOPDXFccinKHuv
	dGuhyZZ2/i2kFzrCdq/HU=; b=VKpsrFNtY4a27z1SxEYC76HosUbyWYVw2qp/cd
	U7pIbhtxdNjJbrimgLDz7kTUf9uM/x+EzFeOSS/BC0Akeu94rT+4CO5lt/ZkuuBG
	Kf+i5Gg9kDIfJOgooTgFJQvJYBSVLbW6NO+2YVY90+VlbeyrlqC1Ff+XNeiXgMNF
	a/+v9GUsYhLwoihVMdbRNjCSqBLeGddGMU+sp5NHNjKwJu58+qcrZWAD3gaoBkpE
	975CyLwRLqRUOCIOVLe+AcPCFaZZ0M9cuu4Pk/IC3LgyHXunmSnCNB7xixV7abJI
	qzSpVSRPA1wwSVSzeSh9XGASrolnGqkJ/vViIE7hqVdmGUAw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48s2eugre4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 06:03:07 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-246364842e7so90123165ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 23:03:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756188186; x=1756792986;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lEftv+FACOPDXFccinKHuvdGuhyZZ2/i2kFzrCdq/HU=;
        b=HhGdJbpBM8+JwCKG9tgxEjZ2jjpXoeHj1zrkst3MOfnUQ5mPkuu2AAqA7BYburV4O3
         1u/ohkfGdMffnsHEZfkUAqMC6PuiB2F8P5Vou4ZB0br1kOQZ9f86suSJ4lIksgPYy1pA
         Ecv3kgffVSALTzwE3eF8j+fgzyq1dt6YeT3MwL8vMwv9MnMyCjqmOekgBP9woBS6NYip
         5/QjQ3rQoZ5vJRAJN+j6FIixYEiXImVoc2/+S4tJV9OG4WXbHVPV4N2+/cGjFFCeJMja
         7pSGGjkHxX7aU68weco69v0iHbLMX2v15mSS2MDJgXVEGeOm6dvL+/ax+CiKSdNRW4XX
         QCTg==
X-Forwarded-Encrypted: i=1; AJvYcCUvtb6oCVCWhyuiYT6Z/nGNSsJE9S6WDRKG/RF27/+Y4abfwrC1Xt2mdNFkG7ycY0R0211ENA96CpnrHPo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyuxkhq0foTwiGPK+uYFFY63OumE3+FLQxLH9dyrxwxUSa89SlI
	yp/4anWEz4qFFXCcMFT/k2umpVPQtI6Jt3jgiOR4uR84jqC8XrPY9j3p29gkTbQvKlA4mW/Aafl
	K0bxdjSyPzszcEZ+u7DNhWhNWS0rq6mFFa2rBUrOAApzZ5deu6QXkas7JFal71agfRHc=
X-Gm-Gg: ASbGnctXKAlvQefVmJs394bQKSi3zWdI7+KwIvunY9Ks5QYtTx0zjr7XYMAz29vYNBE
	wir7j1zPcEbR/p+k659tPEsrt/ukhnms29yiwyI1WKeyregL5JkZUaU8bt1c6RBtUsuaoihUFee
	wO4dEhAEmhV0jXJ+ArS1vYZTeMjKMtXeJxsJ95MxyrhCSslkbahLACg5AqatKQGAlmcnh2qVMPK
	/qNwhX1NHezcuJ3sqaXNzgk+176PZqqjpgxm7eGQz12nZsLGxtEu3k3AILZSHvAQH3258AMLI5B
	+1VfruLNdpeQL2riE1qllfMHHXtUcAHo4JGBY8TR7G8ECAplUcFGDqb4knomcq9Zx/ROhUVttYR
	8W5dR9Srl3QguFXs=
X-Received: by 2002:a17:903:2347:b0:246:d743:b0fc with SMTP id d9443c01a7336-246d743bde9mr69826985ad.44.1756188186302;
        Mon, 25 Aug 2025 23:03:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYhe4dXjLNGhJZGzARNQrnPNogJdMJqZaTMcpoZSngAMDqHiAexd97bFcuHHEUnL/JnUfghw==
X-Received: by 2002:a17:903:2347:b0:246:d743:b0fc with SMTP id d9443c01a7336-246d743bde9mr69826445ad.44.1756188185606;
        Mon, 25 Aug 2025 23:03:05 -0700 (PDT)
Received: from hu-wenbyao-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24668864431sm84989705ad.93.2025.08.25.23.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 23:03:05 -0700 (PDT)
From: Wenbin Yao <wenbin.yao@oss.qualcomm.com>
Subject: [PATCH v3 0/4] PCI: qcom: Add support for Glymur PCIe Gen5x4
Date: Mon, 25 Aug 2025 23:01:46 -0700
Message-Id: <20250825-glymur_pcie5-v3-0-5c1d1730c16f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMpNrWgC/5XQzWoDIRDA8VcJnmvQcf3qqe9RSnHcMRGy2VSbp
 SHsu9cNPYQ0OeQijPD/oXNmlUqmyl5XZ1ZoyjWP+zaolxWL27DfEM99mxkI0MJJxze703Asn4e
 YSfMeO0pCAYFSrCWHQin/XLj3jzZvc/0ey+miT3K5fQBNkgtuPVKyCrWJ3dtY6/rrGHZxHIZ1O
 xb+r/V32mRTECAlok3PtrpLZDwRgsBnW6AgfHIqIor/7bKDCa7+DfLGgGbEXktjXVslPDLUtaF
 vDLW8wxlvZOd0CPqOMc/zLyMOxejrAQAA
X-Change-ID: 20250818-glymur_pcie5-db4ef032e233
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
        Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756188184; l=1916;
 i=wenbin.yao@oss.qualcomm.com; s=20250806; h=from:subject:message-id;
 bh=NMvu6tjTeXh3gl/g/huT9wGas8Pnxc/WPB+nobZ03RQ=;
 b=YIkUZc5qn1Aw090tYWuUOaTqjC0ZXyb3a1sjTjdoAmHUO5INUREbVNsHk+Bw3ggIMk6XAxerR
 daW51x1xUzmDcoBRxrxYxgivfp/YY9HAWFm0vfikTRhAeuTn+hKsrHn
X-Developer-Key: i=wenbin.yao@oss.qualcomm.com; a=ed25519;
 pk=nBPq+51QejLSupTaJoOMvgFbXSyRVCJexMZ+bUTG5KU=
X-Proofpoint-ORIG-GUID: FfBFCaQa1xWFRVVN5-gOU5qASiSWhtIP
X-Proofpoint-GUID: FfBFCaQa1xWFRVVN5-gOU5qASiSWhtIP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI2MDAwMSBTYWx0ZWRfX2FknU/fv5a/P
 04M2Qy04SBljGXk6Id2OY5zDG6++dh+YRsE/FCI5hGNxzxsvuaOLYpCibkKJBKmDZswOXH3Qtvk
 BZZ3Mfy+29sywhykSAMuFekwv7eNvA6pSyWaY6JHhq81BpZ02lKlp17TX7GHHG6DmAumSezqPHm
 yO+EueTEf69Qo127ZW3Jy8hs40stbQv+Gr/1cAqO1KG6DqSib51/jasAxldFOUZzfULOvMrJufj
 bc2O++vUJ3PYf6rXVbFdv78/DCl5BbNOlQWeUB0N9eTI0Mr5QbT4JzmGvN298PL0slQ/XqBJk3m
 w/rZNkeXf+d+57TwGMMENVbAAuKf1bLKgog1GoYTM4vCDBQL5tmxKcARoXGgzmtSjOnMI4qXr4u
 rQHJDPVg
X-Authority-Analysis: v=2.4 cv=PJUP+eqC c=1 sm=1 tr=0 ts=68ad4e1b cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=450xJL59MvcON_dSg4wA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_01,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 phishscore=0 priorityscore=1501 spamscore=0
 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508260001

Glymur is the next generation compute SoC of Qualcomm. This patch series
aims to add support for the fifth PCIe instance on it. The fifth PCIe
instance on Glymur has a Gen5 4-lane PHY. Patch [1/4] documents PHY as a
separate compatible and Patch [2/4] documents controller as a separate
compatible. Patch [3/4] describles the new PCS offsets in a dedicated
header file. Patch [4/4] adds configuration and compatible for PHY.

The device tree changes and whatever driver patches that are not part of
this patch series will be posted separately after official announcement of
the SOC.

Signed-off-by: Wenbin Yao <wenbin.yao@oss.qualcomm.com>
---
Changes in v3:
- Keep qmp_pcie_of_match_table array sorted.
- Drop qref supply for PCIe Gen5x4 PHY.
- Link to v2: https://lore.kernel.org/r/20250821-glymur_pcie5-v2-0-cd516784ef20@oss.qualcomm.com

Changes in v2:
- Add offsets of PLL and TXRXZ register blocks for v8.50 PHY in Patch[4/4].
- Link to v1: https://lore.kernel.org/r/20250819-glymur_pcie5-v1-0-2ea09f83cbb0@oss.qualcomm.com

---
Prudhvi Yarlagadda (4):
      dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Document the Glymur QMP PCIe PHY
      dt-bindings: PCI: qcom: Document the Glymur PCIe Controller
      phy: qcom-qmp: pcs: Add v8.50 register offsets
      phy: qcom: qmp-pcie: Add support for Glymur PCIe Gen5x4 PHY

 .../bindings/pci/qcom,pcie-x1e80100.yaml           |  7 ++++-
 .../bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml   |  3 ++
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c           | 32 ++++++++++++++++++++++
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v8_50.h      | 13 +++++++++
 drivers/phy/qualcomm/phy-qcom-qmp.h                |  2 ++
 5 files changed, 56 insertions(+), 1 deletion(-)
---
base-commit: 886e5e7b0432360842303d587bb4a65d10741ae8
change-id: 20250818-glymur_pcie5-db4ef032e233

Best regards,
-- 
Wenbin Yao <wenbin.yao@oss.qualcomm.com>


