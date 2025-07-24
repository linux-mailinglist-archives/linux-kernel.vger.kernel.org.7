Return-Path: <linux-kernel+bounces-743775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E5D6B10331
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 10:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DA34188AA77
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 08:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675072749E3;
	Thu, 24 Jul 2025 08:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Wr7Ewlk8"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785CA2749C6
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 08:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753344962; cv=none; b=j/EAuioYM8ErcuJnpiFsgy4i4T1BMq5/1d1GoNvH1THkgIn3FvvKAB/RYurtIPLVae8Bn1/TpbJNDGdpGMWf35CDcGJO1+9y5A+kYo8Z7lBGincZu0tKRs/pP9Pzm7d8ZH6zrMx61lLGkOAIqqYrXk/qdr2BpWgfUYvVBAYU6rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753344962; c=relaxed/simple;
	bh=pPE0dthHBTBntcNT9hyg2AS4PevetqvtiTysAuX6epw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=n8nh4tsDr4RMD4MNUTmPu0zB344AP1l2eDplvbsFuzkTIVovsmXs26N8hZ0VgdQIR1KXF3Z6iDwOYYzTjZYNdhJiVbt6xDsqr9ISAq4JegbcergDbU2yEQYPjXi3rmwPD/IzmZ6fcRfkGtgw969yG5Lw7eEy+ZW2XpuMuk5jV+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Wr7Ewlk8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56NMYXfC020266
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 08:15:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=NiT/91ijwaCIS7LiIPcST4
	HlLUuH+EIp+iWbJrHOT5g=; b=Wr7Ewlk8DirsbcU5bfLlfD5ZdxYdkhcG28X5cd
	o19sP+Jo6nnqo8tWB8JcAMIsJ9tuF5McTN0CcGjWIRrTD3LHYU6C6RFfDRX+ZRI0
	R/74bAeGO+BqV1WJvsWsysFkTztHNtjZGy7DP0tbKNwsHWgu55/69AIYszeUp7Jm
	yraWS5vo0tVizFofqRVt64KhWJaCmVIuLN5JmnC6HNM2MeHiyu7E0D936RLeDPEM
	saqQs8RZue4EBIje8S1NfjhS4nepI6QUyANcGKw6evAXA5LVz3FnUz/guXiuif01
	eB7Jb1r93MRHjmCdYpJdWYx2C6yzeFgExcn8sMsEy5icKAtw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 481qh6t3x8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 08:15:58 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-235196dfc50so8895685ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 01:15:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753344957; x=1753949757;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NiT/91ijwaCIS7LiIPcST4HlLUuH+EIp+iWbJrHOT5g=;
        b=XXuGWDUV6lJKttTPSv3p5RbzugT4nZQQXi2fQEPJcNlRqTK4xAL4uCzT2qcbBCdC+g
         FHwcTcp7jbAfOp4e5Vof14ReZg2W8QbYAFGb71NP/fBrR8vd6W3x+d6ilaP8GJ4U6nC8
         EUCPpy2BAJO18NTyXU+kJjwgOKRboszRARtQHNdfleb4BHVkkuTRx5KtGcYWx+X9Sxny
         9ZNM4FsihxjaSjAInHWX2X3mcqzYDTmWDbHAhViPxfUkiJmV/0jRqK/bShRi2Itha+QH
         fZXCeo6t+uAgYVW2ySvjxGdYLm/KJrL99spur4FYnXRyVIBo2c/TeTVgoAf+7ut6ZV8O
         YvUg==
X-Forwarded-Encrypted: i=1; AJvYcCW83as/yho1m5+7V/wvv+EF3G4w5LUp6usCg8aZn229xJJ0mkSCEUJHvefiT10dAD3CtAEq+IsbA/qm5D0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLH2/HuWkx+D+ceMoB5YufD6/t2/qxDusvGCdFO/R2E+wMj4TZ
	cb805q1tLPvx4yH3E037AQTtXpU9fI7X/aIo5UAQetFHME+B3E8t3kxRvEVJTBOva9OtcxRMsK+
	LA0zF2+KUGQcND4mRmfUfL5i1NMgI6N/tywMd/lsTfOGelOeH8SY8FznjgVcOHbs7CfQ=
X-Gm-Gg: ASbGncsFsznUdvt/JoeDANvzD1mge2yDPMRyGcvLTNNG+SzLi81gF3vzWHoLDeEEhMd
	lHTQ2M5FaHYNSL4Pd41WHOYHHPySDH6o2JO1EmGCo3ovUgHW8/TZc/iZUjcSuyUDKutIQI97wd7
	JO6Sf0maPdcU3ijMmE6XojuljJuSdWeSUx40LyT41jvnTXBPkqZgLhL9jEn6MFsq7TbZ01yBD7V
	nK4TMi1ecfzngyzhQ0u0aTV7kkNAjEMzVmTuxQLPoLzwkbUXW/qFKr1gu0PlxNKRtY6vpx1YdtS
	52LsGSRj45SrO6zwE/G6r7p0h5jQZPF1qE3r8oGlBbV2K94KAe/aAA750Sg2Nbjx6TaA5ojYOZR
	s/2ylxf9rpwxE8WuS1zt7Rk60LRqzwq033g==
X-Received: by 2002:a17:902:e948:b0:215:6c5f:d142 with SMTP id d9443c01a7336-23fa5d5ec54mr18729685ad.20.1753344956831;
        Thu, 24 Jul 2025 01:15:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0rYQPN7kY4fiz//JYFRHF/cZGa/em+fXLWQb5iFkEEBlK4P/Xyw0TACKiX4Fa1q3XMhJUDw==
X-Received: by 2002:a17:902:e948:b0:215:6c5f:d142 with SMTP id d9443c01a7336-23fa5d5ec54mr18729415ad.20.1753344956389;
        Thu, 24 Jul 2025 01:15:56 -0700 (PDT)
Received: from yijiyang-gv.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa476eb07sm9770595ad.65.2025.07.24.01.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 01:15:55 -0700 (PDT)
From: Yijie Yang <yijie.yang@oss.qualcomm.com>
Subject: [PATCH v2 0/4] Initial support for Qualcomm Hamoa IOT EVK board
Date: Thu, 24 Jul 2025 16:15:22 +0800
Message-Id: <20250724-hamoa_initial-v2-0-91b00c882d11@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAJvrgWgC/3WQwWrDMBBEf8XoXAVpZUlxTv2PEsLakmtBLCeSI
 1KC/72y3UJw08vCsDNvh32QaIOzkRyKBwk2uegGnwW8FaTp0H9a6kzWBBhIplhJO+wHPDnvRod
 nyhqjmVBGg+YkZy7Btu6+8D6OWdcYLa0D+qabKUv4xxfs9ZbPjat5dTZD37vxUHh7H+lyUnNFZ
 lDn4jiEr6Vn4kti3TO+qZQ4ZRSFNrVUdSnL+n2IcXe94Xmm7/KYC/zCX4Vb1UrD2gq5En/Dc5s
 Ezw22T0mQIWIPqiwNAzT4D0Q8QbjcQkSG6BaqPUpoQFUvINM0fQP86KEhwQEAAA==
X-Change-ID: 20250604-hamoa_initial-0cd7036d7271
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: Yijie Yang <yijie.yang@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753344952; l=3734;
 i=yijie.yang@oss.qualcomm.com; s=20240408; h=from:subject:message-id;
 bh=pPE0dthHBTBntcNT9hyg2AS4PevetqvtiTysAuX6epw=;
 b=q/GXc8dKKUJZGF0TNSuLJcXFRs94bn0hTkYdnTPYRmw40hrwclfkkrzKd67yBxivc+Bv8zBgb
 WZWFuoR9fEuARYdtIifbw6D4Ff6Hh9Wb2rMdlST0BOskpxlwi/a0kLa
X-Developer-Key: i=yijie.yang@oss.qualcomm.com; a=ed25519;
 pk=XvMv0rxjrXLYFdBXoFjTdOdAwDT5SPbQ5uAKGESDihk=
X-Authority-Analysis: v=2.4 cv=CZ4I5Krl c=1 sm=1 tr=0 ts=6881ebbe cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=gWuG99rYYzh1ZzfbfFIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: d3NQi7Q6iG6rGa4uuIlyanfBOzezIogS
X-Proofpoint-GUID: d3NQi7Q6iG6rGa4uuIlyanfBOzezIogS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDA1OCBTYWx0ZWRfX0xub1YFz8IIa
 gwyIXeoj8dbpp3VnJhUymy20dG5502vTeO9A0d3efSxDNqFKKSdn+ezrF6bcA53MP4v4Xa/Svsa
 Eh0ltZ/Xae2KTakiyrepkZ6paomr/znawFPs+0AhxbjNOseqNZfp0wRLcvowDdxSGfIyFqKyRYA
 /l3mqyA4cYTcamTGHPq7ogqPXkU6tTkNeYPjGirVIw+wXbj5BqUdCjHBxvbX7UNjBelhP0MdQ4I
 Cr/OdZn563UX8tqzafkHyzmjrw8YuJkFAxExq2mu7eshHbo4FN3KfCJmhU0Y9GfaeG8SCxlHxWy
 L9qm02SW2CCnNQu295vqxr+NsbOoWd6utKah+S7bS9/v9C14K1QZlESq6+5/WHOgWAti6k8j03o
 XHdUIj0b6ILrngNWX117Nz4vTkVwlkFzwp6te0UN/rYAh5raeWpWvD8MHLXUxK0zQFr8QY8Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_01,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 mlxlogscore=999 impostorscore=0
 clxscore=1015 mlxscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 bulkscore=0 spamscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507240058

Introduce the device tree, DT bindings, and driver modifications required
to bring up the HAMOA-IOT-EVK evaluation board—based on the X1E80100 SoC—to
a UART shell.
This patch set focuses on two key hardware components: the HAMOA-IOT-SOM
and the HAMOA-IOT-EVK carrier board.
The HAMOA-IOT-SOM is a compact System on Module that integrates the SoC,
GPIOs, and PMICs. It is designed to be modular and can be paired with
various carrier boards to support different use cases.
The HAMOA-IOT-EVK is one such carrier board, designed for IoT scenarios.
It provides essential peripherals such as UART, on-board PMICs, and
USB-related components.
Together, these components form a flexible and scalable platform, and this
patch set enables their initial bring-up through proper device tree
configuration and driver support.

Qualcomm SoCs often have multiple product variants, each identified by a
different SoC ID. For instance, the x1e80100 SoC has closely related
variants such as x1e78100 and x1e001de. This diversity in SoC identifiers
can lead to confusion and unnecessary maintenance complexity in the device
tree and related subsystems.
To address this, code names offer a more consistent and project-agnostic
way to represent SoC families. They tend to remain stable across
development efforts.
This patch series introduces "hamoa" as the codename for the x1e80100 SoC.
Going forward, all x1e80100-related variants—including x1e81000 and others
in the same family—will be represented under the "hamoa" designation in the
device tree.
This improves readability, streamlines future maintenance, and aligns with
common naming practices across Qualcomm-based platforms. 

Features added and enabled:
- UART
- On-board regulators
- Regulators on the SOM
- PMIC GLINK
- USB0 through USB6 and their PHYs
- Embedded USB (eUSB) repeaters
- USB Type-C mux
- PCIe6a and its PHY
- PCIe4 and its PHY
- Reserved memory regions
- Pinctrl
- NVMe
- ADSP, CDSP
- WLAN, Bluetooth (M.2 interface)
- USB DisplayPort

Signed-off-by: Yijie Yang <yijie.yang@oss.qualcomm.com>
---
To: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
Changes in v2:
- Merge the compatible rules and remove the compatible string map.
- Align the ADSP and CDSP firmware paths with other x1e80100 platforms.
- Remove the regulators on the M.2 card, as well as those managed by UEFI on this board.
- Merge another patch series that enables USB DisplayPort functionality on this platform: https://lore.kernel.org/all/20250723-x1e-evk-dp-v1-1-be76ce53b9b8@quicinc.com/
- Link to v1: https://lore.kernel.org/r/20250716-hamoa_initial-v1-0-f6f5d0f9a163@oss.qualcomm.com

---
Yijie Yang (4):
      dt-bindings: arm: qcom: Document HAMOA-IOT-EVK board
      firmware: qcom: scm: Allow QSEECOM on HAMOA-IOT-EVK
      arm64: dts: qcom: Add HAMOA-IOT-SOM platform
      arm64: dts: qcom: Add base HAMOA-IOT-EVK board

 Documentation/devicetree/bindings/arm/qcom.yaml |   1 +
 arch/arm64/boot/dts/qcom/Makefile               |   1 +
 arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts      | 915 ++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi     | 607 ++++++++++++++++
 drivers/firmware/qcom/qcom_scm.c                |   1 +
 5 files changed, 1525 insertions(+)
---
base-commit: 4d088c49d1e49e0149aa66908c3e8722af68ed07
change-id: 20250604-hamoa_initial-0cd7036d7271

Best regards,
-- 
Yijie Yang <yijie.yang@oss.qualcomm.com>


