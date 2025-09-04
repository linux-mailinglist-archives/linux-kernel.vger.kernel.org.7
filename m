Return-Path: <linux-kernel+bounces-799999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C713DB43242
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 08:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 784617C537B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 06:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F352673AF;
	Thu,  4 Sep 2025 06:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="P5j2/8Ub"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AAC2641C6
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 06:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756966998; cv=none; b=I7Oc0prPtwfkPCzPD/6t4CdgUvYCop4YIJ7Mn1tPNVCbChGZDDjc8SaK6/ESAGNzOzVePhFURLDxtNCNt/E5iuj/nxB3SOHnq5W3h9RHvM0j7vXh4XLWp3oM5P5qpXhPpWT/Ot/PK6L0Kq5b5HOQSQ18Wu4EIHGlpZSTi0INbbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756966998; c=relaxed/simple;
	bh=A64x7+BNXYv782ni3wGjbjBf2GE5tylgSfS7zkngzrU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JSzckyNf7cKlzMrpLsKQ4NSF7hfmUDDZ/T3AdZSZwIpe9oHXlfimXTxh9whM2112EvR4A4ngA+79u8MbazvfiKolQyeZBtAbDXqdE84dEgHYCmTxMvM9ILeGGSZL0FPWomFyba+pEFEApWF4pY32Qil2W057gisbEeZhMxdabmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=P5j2/8Ub; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5841ALtO032593
	for <linux-kernel@vger.kernel.org>; Thu, 4 Sep 2025 06:23:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=8mnxwcogrBs5wXZPmzs5x+
	48L88qADEjdwSP1+OP2Ic=; b=P5j2/8UbZ+fDsvGa+8Wzu+18b5PWMRIDoJ1SRO
	RHVKUbPSgwv7QjvmvBqhOt73odjVyT5A04tWn5GAwVMpJTaBWFlNnvMLF7a7W77P
	hz5m/alBTx9+LmA3iaJ55UXovkROxqxYqRtKrj6N1jHCBTLIhqZP9eGKj70Aao6s
	i1DX20eH+Ykl80xQzZ6xguRts89otj39/raJOLGGEZxsuHhlMOuUnVHDmwRkXzDC
	poCkCqd0VQTvX2+PHcB4W4cCZ7WG/rMHjFzvg11vvveOVorofhnTJ8EzPe9hTRbM
	qokYsXdZ5iDLvZ15iHyMZshaYrkqmQWPJ0cMhcdIQkUPoOSQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ush36ahy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 06:23:16 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-772642f9fa3so1690866b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 23:23:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756966995; x=1757571795;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8mnxwcogrBs5wXZPmzs5x+48L88qADEjdwSP1+OP2Ic=;
        b=kLWLtu5dyFqEg9aY2byxBhlIJ5lRaGB4rHtEQH8QFPduCPQd1xjXnKMdd/qm0fE2um
         +50K4/wdXeDpqmG7PA0uPhz8ELz+3nknn1ZPd2tIu5Gb+BqE8dcF5xQ3L6akemW5Ar6F
         tQhTEc0Xa+YtW3McxveF3/5nsbqTNaWMLlWJV2nt6aEbrORE6rLnjHzq4pok2yQmSBCc
         GdTxMGJact6RKRWIWGXwUQvawEYQwWwR/e5wQ+2GWlPc4fRL0DD+VC0Hzkz9YFOzxY4u
         PmiJJWhUoX17c+OFZadsbyaDR8M53Vg26a2SYGke0NehkgGEZplSIYc5fIk7hndP+BGC
         HOIg==
X-Forwarded-Encrypted: i=1; AJvYcCWNgXSaX/6gh3KhfscdxRLNoIdy4yFUz6hJ3NRfn2cTLyTGvQu9CZeOaI7gZjAYIa9U4VpdbDQNSbqbspU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvDhuI2TLLueQYooAiNYMvX4l6s35WMvnF4h4UapzRPCeLi1IE
	IpcGWCTzkT57iloOziEBf2uLdQqbdngFrmaSmTOdxhSU4McCiIJ+ZbnUoLklH/9DGqmMFMN6Bx+
	6rNTQYe5Sl0u4sok+urwfyYYjOA4qncPP9n4EaWwbrgD91akL0GWEdWjhylPhaajqvd4=
X-Gm-Gg: ASbGncsqP1nJvAHRygGafZlB2CK1MJ/OJOCPNEldKXqJZADCYzGWk/pLl96ZwD7hfUI
	1hLQ8ksMTqe+buJqtrJZ4RcEGFjwxC15VSofwyUS2IYZWDBTrSRsRhzgAbzkrlz+3z4J69K7qog
	fS1eSLp1LhkpUWSy6y6GK8h/Cd2eiRVoPrxE6OuokQy8D/1zaYgEi9np3bbLTnMgdgAoO9oN2NI
	uqbUIKk+5URPKcTNee5kLNyMhDJ8STkdlBi6eErDZ0quIh6/K/+hYdaNECICkznbbloYPiqPDf+
	XW++a20mgmESgiT23iK9KNHesFYCil/LOJm5LgAVyvEgGQbrdYaj8pJhzsC5VkXUGx+ozeE2TEw
	xUIH2gh4OFiNnBT0=
X-Received: by 2002:a05:6a21:6d8a:b0:243:d1bd:fbac with SMTP id adf61e73a8af0-243d6dfb77dmr24913299637.7.1756966995211;
        Wed, 03 Sep 2025 23:23:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlqYG4j4tCAUQjllJWSXIoBHjaLsyGVsWcC+ZkPeWO4oTZkGeYNcQReC2fOyY0NlmWHVGzCg==
X-Received: by 2002:a05:6a21:6d8a:b0:243:d1bd:fbac with SMTP id adf61e73a8af0-243d6dfb77dmr24913253637.7.1756966994711;
        Wed, 03 Sep 2025 23:23:14 -0700 (PDT)
Received: from hu-wenbyao-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7723427c127sm17120911b3a.62.2025.09.03.23.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 23:23:14 -0700 (PDT)
From: Wenbin Yao <wenbin.yao@oss.qualcomm.com>
Subject: [PATCH v4 0/4] PCI: qcom: Add support for Glymur PCIe Gen5x4
Date: Wed, 03 Sep 2025 23:22:01 -0700
Message-Id: <20250903-glymur_pcie5-v4-0-c187c2d9d3bd@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAkwuWgC/33MwQ6DIAyA4VcxnIcBBhp32nssyyJYlUTFwSQzh
 ndf9bzt0uRv028jAbyFQC7ZRjxEG6ybMOQpI6avpw6obbCJYEKxignaDeu4+MdsLCiqwRSl0qV
 udE3wZfbQ2vfB3e7YvQ0v59dDj3zf/oAip4wyBYWQleJVy64uhPy51INx45jjILsX5T9DoqEMH
 vhZC2HKL0ZK6QOfhwR68wAAAA==
X-Change-ID: 20250902-glymur_pcie5-bec675b7bdba
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
        Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756966993; l=2136;
 i=wenbin.yao@oss.qualcomm.com; s=20250806; h=from:subject:message-id;
 bh=A64x7+BNXYv782ni3wGjbjBf2GE5tylgSfS7zkngzrU=;
 b=h0WX++anw1r4++tGfxwRySxcmOfq17vKXcxaWu4NTzGiCweIF+C3zdU52Ej9BLOfwpmisYL8k
 zxXXbwVobu6DTD4B5D6Fss26SLI9vduVky2/yeeCTyk3Xl7ip6DosNb
X-Developer-Key: i=wenbin.yao@oss.qualcomm.com; a=ed25519;
 pk=nBPq+51QejLSupTaJoOMvgFbXSyRVCJexMZ+bUTG5KU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfXx9rteBIETvOc
 l8njRce+gnZDN684E9VECAmrMkO+0n+aUDdzkuvadLR+93X6NDjy8innoJMrKCXUOPP3DT/5BjD
 3yRi9sqS5tJ2jJJeS0ZIfxL0Yw+NU3DdoTpG/c3bhUIwmV5B24WHWb/JlRU5px5aa/fHskVr+Nt
 Y7TIEvhJkmWRtTsJX15fjJeUgHvszrgQcjl/YcPPt6+WaqxlmIPMSEc/iAtuLQOz98fgokKkVuC
 ECV4z/YA9nzNP0v7sG3L2bkrMaJ/JAt7zJ60EEwYj+VmJMZscLDDrHWHhENWA9ceTSUS4EeIfLq
 O5VSvKLf9gtTQsIkLgjAX9wDE5OLf8KQ+ePoYOb5Bc+x1xdD6oGfefq39Heq732mS95hNl6Mljo
 mI3Irj3u
X-Proofpoint-ORIG-GUID: 4q8uvZ6iIpgDQbCbGXV0H1DGfrPV1XtM
X-Proofpoint-GUID: 4q8uvZ6iIpgDQbCbGXV0H1DGfrPV1XtM
X-Authority-Analysis: v=2.4 cv=M9NNKzws c=1 sm=1 tr=0 ts=68b93054 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=TkXPrYfmiUOmToh-xYcA:9 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 suspectscore=0 phishscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300032

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
Changes in v4:
- Rebase Patch[1/4] onto next branch of linux-phy.
- Rebase Patch[4/4] onto next branch of linux-phy.
- Link to v3: https://lore.kernel.org/r/20250825-glymur_pcie5-v3-0-5c1d1730c16f@oss.qualcomm.com

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
base-commit: 356590cd61cf89e2420d5628e35b6e73c6b6a770
change-id: 20250902-glymur_pcie5-bec675b7bdba

Best regards,
-- 
Wenbin Yao <wenbin.yao@oss.qualcomm.com>


