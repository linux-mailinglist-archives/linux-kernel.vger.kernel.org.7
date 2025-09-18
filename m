Return-Path: <linux-kernel+bounces-809787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B80B5120B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 11:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D8143B780D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 09:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797F8312807;
	Wed, 10 Sep 2025 09:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OUnUZoo7"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD72130C351
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 09:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757494984; cv=none; b=NTispJoUpBIkSNKo1So9sMQUwVovOKWw8YuaGszfmkTgXVbrPnruPkJgM39Fgl7P1ekMIOxLnp94rabJ5Vvhtv3iSYIxfjwufnErgeVuRMeH4ajQOAwJctqlApSNpFbJAKWy98LCt+Bb6ce55Soil6T+utOjuHV8C4rDrzO9dWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757494984; c=relaxed/simple;
	bh=iygfp2FLmyHMlYNE06s1pLsxgC91NyUBh21VJODUkds=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=to1jW90xt/hhkNOjjvwCRYKDhutcOqZZfTFnW84HGbkW53iQ12DUdatJzh78rq543sOpy22qe80edIpmlJMxzKsOJmHKJE1UPXDcgQUExSLyoDPm+8GcAtTkXKN3DxtwUfwJ/QfrqMvaLAuVBei50B87m2LH+7B1zhIxKFSgmUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OUnUZoo7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58A7ccgK018232
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 09:03:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=9JcM8tm2w70x93VPdHPPUv
	gkj0Etp6YMvrIgsZqB0VI=; b=OUnUZoo7Rh32YZOM7HH8sGsJflp3ddoWwN32e9
	6ipEyELx6o9Ih6ezpvA62eKPhUw88M9vhflCSQH9GPVBO18Mk/pC5GbQkqHIHPQX
	qyV7pCo779jwgiLKzrW63vGJCR2uD3LVYNr7DtsyNct1FeEAG7y+mnZHv1Mm/OAD
	kceyKD1RTdjb7w/Gu4+nmFsk7dwcopE0/p1SR1U8ND5rFeJ6LdUwY/8/UD21iHEi
	YrshIMwuNh2872AyxPBacFH9OmtJkUGXBkEXnnwI1ajZ4+Im11wPIyeyWJp6BSCV
	BswMjgfKgaY0vi0TaNB7A6ZAQuxu38gnIFxkZU3J61XkdfOg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490aapkj5u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 09:03:01 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-244581ce13aso134836245ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 02:03:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757494980; x=1758099780;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9JcM8tm2w70x93VPdHPPUvgkj0Etp6YMvrIgsZqB0VI=;
        b=jfUoD0+db8arFsfZM2atTbAOSV1H1WaDNPrUfVKVKbUwRyFvJXussNuNSfYqW7GTHc
         SkZnjUGei8hTWalUih0awe8Bnv9FFeLOAQZkHK0a7zWIWlREdAEzkEVkXroLO77EUXnc
         iytx9cXnEw88260pnvdiqNZgPQ76el0F8BerY4Y2HNU7F7MZxQwW/GQLQ3W9QzakbHbJ
         vDqKdDPlv//AtJTw/7aP3YnJAggQQcZLsPVs8MaT6Th+Lyj+Q2QJ83pYrBuTgnGvR1ZD
         H5lU0mc9SeLj8OTFo0MszYKMPXWwd5Uu0W+fKIbzU0BOf+SuXws9N8sq0IG4HfP7W6GF
         Sh1A==
X-Forwarded-Encrypted: i=1; AJvYcCUFD1em59c69S8KDLv+gopQFl3hsoAhxnyBAtuO3nCrFqQK/9BVGf5e7qOQ+yakBBT7lb6xl2EyCS9T+bo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZRQsEETZQsUuJRbQpt7JstTAut0dGwaoRbcVMi2j4NW0xZi6m
	VVP2CzOvXb17W02geLuNMIYNpuXch4JqX42/2piLUvc6HkyCOaa6QNGbIn/2vweQ6gh1bimY9nY
	9sWqvFizz3ktoUruT+m/QLHvEb+qMLyN6hP30x9txuArZy4v9had+r4xHUEzwaXr8HTI=
X-Gm-Gg: ASbGncs7ULu1E5ScYNBOjc1EITE2BQPrFuAURlqothispP1a4EPhdZ7iqrhKj2DVu0z
	AUcwwAT1DSd3CBXJDOOArWs16Wwyfq/bjn0jYUJ4W1oPc6+AML1bhPlLRMEQnTeCTtNSCfAY7GY
	KXoP0F2EEDChxNS1mEO2/bbSFOu5VMEIfA3e76Ysqd/aiFFgJyc17NPgBghiaQtwhcX05pJMD3U
	3VHG86XHnhRZSihGELQ6YjfqPiZ9JFr2JDcRAX3Hx8FYRUSRXaWhIxWP0A1oq6LK5tVbjupzYQ7
	SqdY53/RMQgKC1IEMQcbb4O3t601Nr1sC00RYnW3NsSCgKPTGCFWCdBeMhf9oDjAK4xO82XfwSY
	Orx1C3jS0Cb2nKaoOxVyn+5hs68hzeyebDQ==
X-Received: by 2002:a17:903:320a:b0:248:79d4:93a9 with SMTP id d9443c01a7336-2517408dcdcmr177463755ad.55.1757494979836;
        Wed, 10 Sep 2025 02:02:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFZll1G9bSel7LGXLaN2Uf9uCbc9GQUQwlW/FGJKzNiXxxPDMiE6h3wRcl1xoZ2NIiXRkcoQ==
X-Received: by 2002:a17:903:320a:b0:248:79d4:93a9 with SMTP id d9443c01a7336-2517408dcdcmr177463285ad.55.1757494979230;
        Wed, 10 Sep 2025 02:02:59 -0700 (PDT)
Received: from yijiyang-gv.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25a27c029ccsm21089155ad.41.2025.09.10.02.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 02:02:58 -0700 (PDT)
From: Yijie Yang <yijie.yang@oss.qualcomm.com>
Subject: [PATCH v11 0/4] Initial support for Qualcomm Hamoa IOT EVK board
Date: Wed, 10 Sep 2025 17:02:08 +0800
Message-Id: <20250910-hamoa_initial-v11-0-38ed7f2015f7@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAJI+wWgC/32S22rjMBCGXyX4eh00Oo0UytL3KGXRyY0gsbeWa
 7KUvPuOnUJNHPfGIHn+bz6N9FmV1OdUqsPus+rTmEvuWloA/NpV4ejat1TnSBsVZ1wxzWR9dOf
 O/cltHrI71SxEZEJH5AgVZf72qcmXGfjySmvvSqp979pwnChz+KuuT+8f1G+4Fd8qQ3c+5+Gwa
 9NlqOeWltmp/pxKcbPMYfc0/0ByuQDt9LnUI9RQBwECo0WbpHg+5db13b7r335Xk8gxl6Hr/80
 HHWHu+IWBuyMRi9WOSF5pL5X0z10p+/cPd5rs9vSZhG5h0I/CjW5UZI11oMU6PNmMfGlwP9SRE
 0QYrqWMjLvofjDgD8MWPGPBGB4BNgzEwgDUPUQQBBtujVM8cG1/MrCPwobpxCxHY2PYMJDfBmY
 9A0kQsCl6z41G9BsQtYDACqImE0Bng04mStyA6AWEr96DnmbBk0wMnKKL3YDgEoL3EJzehfUGo
 tKSzrQBMUuIuYcYggQbAQWN3amtwdpviF0P1hIkouAgGodKbpkAW1JWdwyMMCkAYwqbJsRHmOv
 1+h9voTugYQQAAA==
X-Change-ID: 20250604-hamoa_initial-0cd7036d7271
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yijie Yang <yijie.yang@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Wangao Wang <quic_wangaow@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-5bbf5
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757494974; l=6160;
 i=yijie.yang@oss.qualcomm.com; s=20240408; h=from:subject:message-id;
 bh=iygfp2FLmyHMlYNE06s1pLsxgC91NyUBh21VJODUkds=;
 b=Cw1j6eU3N+pjv0SGVPS4bvbNyikpM7BMu8wkjXTmchs9OvRpgW+WmYxmjRxMaviH3LtjXOLHQ
 JDcKQmmyot3BW2A6zOrcmOzReaSL82MQ2YTulAWs4Y+1sqc3/f3mYxl
X-Developer-Key: i=yijie.yang@oss.qualcomm.com; a=ed25519;
 pk=XvMv0rxjrXLYFdBXoFjTdOdAwDT5SPbQ5uAKGESDihk=
X-Authority-Analysis: v=2.4 cv=eMETjGp1 c=1 sm=1 tr=0 ts=68c13ec5 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=hsIpd76ykShK3axuoLUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22 a=cvBusfyB2V15izCimMoJ:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: WBIGFkG64LVG1Imuwks6dZ8pa4b5OAEs
X-Proofpoint-ORIG-GUID: WBIGFkG64LVG1Imuwks6dZ8pa4b5OAEs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAwMCBTYWx0ZWRfX0Xu+ENNWz6u1
 K9jhWE7I9V2jnI8ZcXsgKbuWWXi8otKFjklFuzycvoQ6g3JFrZ8YM3xTf9GgG2eI2/bZ/IZUQFE
 nOuXhPioi48OJ/38RdScYiqFQxVEbwvaKqFlisIZBKBL1Wc4WTBWvLsVVDMl1bwBwLmH6eHNVin
 E4UgjIfatJQmOP2mm3U3qfSbRQ1sjGNQpuqDm2RYlf0uyDIy2TkdiVB6L1fLyYLs1D11yv+Dilu
 ZDpkSViQ5d80WdqpjejeX14QDuP8G2YMoOp2+7/PLVhyz41AZCbFlEVRZKzv9WSU2fpitTAgL3m
 VAo/f/hJYOyj7ENNW5W+/UzciGgeGqV/I1igsWzGmxnv+Tgcp+tyzbMQFkCxiNrJ9TTJIkarlMj
 y2AHpWuc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_03,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509060000

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
- Graphic
- Audio
- Video

Depends on the following change to ensure compliance with the Device Tree schema:
https://lore.kernel.org/linux-arm-msm/20250704-x1e-iris-v1-1-c3137d979e43@linaro.org/

Signed-off-by: Yijie Yang <yijie.yang@oss.qualcomm.com>
---
Changes in v11:
- Update the high-speed PHY repeater for the USB MP to the correct one.
- Update base commit.
- Format the audio-routing property and the i2c5 device node.
- Link to v10: https://lore.kernel.org/r/20250909-hamoa_initial-v10-0-ec10057ffcd2@oss.qualcomm.com

Changes in v10:
- Update the commit description.
- Remove the redundant space in 'stdout-path'.
- Move GPU nodes to the SoM's .dtsi file.
- Integrate the changes that enable video support into this patch series.
- Link to v9: https://lore.kernel.org/r/20250904-hamoa_initial-v9-0-d73213fa7542@oss.qualcomm.com

Changes in v9:
- Sort the nodes within the root node in alphabetical order.
- Add WLAN control pin to the PMU.
- Link to v8: https://lore.kernel.org/r/20250828-hamoa_initial-v8-0-c9d173072a5c@oss.qualcomm.com

Changes in v8:
- Change the style of how collaborators are listed.
- Link to v7: https://lore.kernel.org/r/20250827-hamoa_initial-v7-0-f9b81d564bb2@oss.qualcomm.com

Changes in v7:
- Configure the EDP regulator to boot-on.
- Change back to a year‑less copyright statement.
- Update base commit.
- Link to v6: https://lore.kernel.org/r/20250821-hamoa_initial-v6-0-72e4e01a55d0@oss.qualcomm.com

Changes in v6:
- Restore the full change log for each revision.
- Merge the changes related to Audio and Graphics into the patch series.
- Link to v5: https://lore.kernel.org/r/20250814-hamoa_initial-v5-0-817a9c6e8d47@oss.qualcomm.com

Changes in v5:
- Update base commit.
- Drop an already merged patch:
https://lore.kernel.org/all/20250804-hamoa_initial-v4-2-19edbb28677b@oss.qualcomm.com/
- Link to v4: https://lore.kernel.org/r/20250804-hamoa_initial-v4-0-19edbb28677b@oss.qualcomm.com

Changes in v4:
- Update commit messages.
- Update base commit.
- Update the format of the node mdss_dp3_out.
- Add comments to clarify certain nodes.
- Update the configuration of regulator-wcn-3p3 from regulator-boot-on to regulator-always-on.
- Link to v3: https://lore.kernel.org/r/20250729-hamoa_initial-v3-0-806e092789dc@oss.qualcomm.com

Changes in v3:
- Add compatible string and dt-bindings for SOM.
- Restore PMU-related regulators to comply with dt-binding rules and enable kernel-level power management.
- Adjust commit description accordingly.
- Link to v2: https://lore.kernel.org/r/20250724-hamoa_initial-v2-0-91b00c882d11@oss.qualcomm.com

Changes in v2:
- Merge the compatible rules and remove the compatible string map.
- Align the ADSP and CDSP firmware paths with other x1e80100 platforms.
- Remove the regulators on the M.2 card, as well as those managed by UEFI on this board.
- Merge another patch series that enables USB DisplayPort functionality on this platform: https://lore.kernel.org/all/20250723-x1e-evk-dp-v1-1-be76ce53b9b8@quicinc.com/
- Link to v1: https://lore.kernel.org/r/20250716-hamoa_initial-v1-0-f6f5d0f9a163@oss.qualcomm.com

---
Wangao Wang (1):
      arm64: dts: qcom: x1e80100: add video node

Yijie Yang (3):
      dt-bindings: arm: qcom: Document HAMOA-IOT-EVK board
      arm64: dts: qcom: Add HAMOA-IOT-SOM platform
      arm64: dts: qcom: Add base HAMOA-IOT-EVK board

 Documentation/devicetree/bindings/arm/qcom.yaml |    6 +
 arch/arm64/boot/dts/qcom/Makefile               |    1 +
 arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts      | 1221 +++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi     |  621 ++++++++++++
 arch/arm64/boot/dts/qcom/x1e80100.dtsi          |   82 ++
 5 files changed, 1931 insertions(+)
---
base-commit: c62a516303b963817a9d008c432013b18581997e
change-id: 20250604-hamoa_initial-0cd7036d7271
prerequisite-message-id: <20250704-x1e-iris-v1-1-c3137d979e43@linaro.org>
prerequisite-patch-id: 037bb113706198fca6a87000e46907bc23f9d7e2

Best regards,
--  
Yijie Yang <yijie.yang@oss.qualcomm.com>


