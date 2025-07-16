Return-Path: <linux-kernel+bounces-733183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6358EB07141
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 11:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F18461AA0EC8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 09:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C652F1FFE;
	Wed, 16 Jul 2025 09:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lR7qYW7/"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383402F002C
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 09:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752656963; cv=none; b=hqdI7gFr9fg5PlMl02vuIDWvkM+VQyxlJpMj0t59w+qOrVyOabC4hHI0vQRo2MTM8AiPqmAyYbdzPdthyBuKlQgmiXSsG7B7Aely/6zhHexzozfrn7bgLGIDyDdbuuPXsjZfYrw7N+jlm1pLgaNE4Iz8Jr1SoFYpOVAI33wEqIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752656963; c=relaxed/simple;
	bh=E2yE+9Nv7BLKm6qUe/2mO7codsrDcFi+y6F6O46xBrc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Y83N9Ni8gC18LQY+5OXYMJYctQGjJ0VPOZag0k4l4Wz1g0+IrKqwbxjEDRqpYlNyO0ODvgn1l8+oWiNTc2JnkFtmC6JyW9ZPXrXWqF88wCowy7RqEQV+FQmbvW3X4H1Wqv5tBo4J7cINZkhR49gz8DHbhmKYPoytOth4QG+gQ7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lR7qYW7/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56G5gub4017640
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 09:09:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Inqvtfl9OShg17aGwZeZQy
	+EahwDz4RdL7DIjDaQJoM=; b=lR7qYW7/oKk8/HGDLhr95L1nSN4DL5lfWRu4B4
	LseeCb7dSaS7ZTOFeCT4JGylHsovAQVKVvb198YKK8dcSjp9To7UZ4JLphx2KPaH
	NMY/nb/sb3sSsV9Sq8rYDV423Ax8QO70qury+fReDNNh4taPAnHO7k6oKKrR7C11
	DgygRP8z/+DYs2SV6Gu0rtcBRAD3DwPIDFa7eGn1SSe7Q1uF9nRfA2IqcANDs7tG
	XaMjqc6x6qYYTZNgoJC3gQnSEjvEfNPWnL4e6k/qS6pEDKjRP7OZwXEZT9rOi0P2
	0j362cSI1p7/hi7MQyzH4LJliciPYVGpu0vryvsE96xjbCSg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ufu8b67x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 09:09:19 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-748fd21468cso5467945b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 02:09:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752656959; x=1753261759;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Inqvtfl9OShg17aGwZeZQy+EahwDz4RdL7DIjDaQJoM=;
        b=h+Kloe9O826eSu73XHRLZfPRfvjC09EfoClpdNXooiuo+FjvHPMCi1cN5RGIW2Zndc
         GPYP4Yxzj6/0Yxos8ck+GjMSp8gIarPIoZjkEsh/OpF7IZtSW+H16OuSCX18VXaoY2R5
         8vUSWkGQ2Hwo5ifHzwmrBY4OYtg36UIOhuuVBfm6v0S5udVufj9fFHJ1Ga+FP20aAyCm
         ZKktEmNG2Tyni6Jku3VdIvywl+FenOmzNLtZ01eE6FsMNxPhhiktvtOC8WMOpvdsDmII
         Qqj0mtYBcD16m76bO//+XFnsuUEEl+tE2E9bcrtGYyLauP6/jzAPuwD3fP2ZgogyYK3d
         1kLg==
X-Forwarded-Encrypted: i=1; AJvYcCVxLQ3YTdnaZWmDPg3Uh5MjmlTq/xpCEyf/JT7PAF02Jjh9KfTFZt72EmeXG9mEmvQDy9ls+SgfHLDbXLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8vJguNpkJYdkCAtpRpx9VPyXr7KUixw71yG9JrJTXgbW6YFe+
	pztL9XsrUQ/xd01Qmwz4bbaMw7Syk1BG7gCKE+SMz1OeqKoLpuQpr5NrUrNoJPce39tfaBv3CiW
	JmzXdxdVSQC/BGIp44KzDD5okeSlcpJZBeLikOj/GCPO9/mwhNNiTMy6VO/88agUq7Qs=
X-Gm-Gg: ASbGncsTuw+pWSQyqbR2rTfTTJy3nmFBkxYrGsnCQXiOUQo69yZ4z/G5nfBf1uX184D
	foF/R09/U+38TmPy9xVWrCaqYC4pe9DPJbOj+ArVqVNRSJo6dnYBIrPrJSnzFovkUGweXbFctgK
	zzch0R67OdsZZg6zHUbDt3sDGON4i0C4pAxpR9aZtiZ2GgkaDS7ktzgPBfq60SA9yT/JwrT+jbL
	lXi195hsEaoAG6DrGpCevwsto+/YsiRLSNGm2ApaSV24CyFm20ByMYPOliKciHd4JqOJ1iRfW9U
	tvAa547OIs723uhRb9+TMAkuJr1Qo9x+q19cUC4DG4Go/cTVjnTD46AlysdNrJ/VnEdwzSMut0V
	8S3TLhyCqdvC/cKyTXjSWS09yqUa+Cl8sBA==
X-Received: by 2002:a05:6a21:6f06:b0:234:86ce:9de1 with SMTP id adf61e73a8af0-237d5a04ad2mr3750682637.17.1752656958554;
        Wed, 16 Jul 2025 02:09:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEx99Cveh+s5nC7YY3FmH/g8Q2nSuMinm7HmdUGIH9MouHAPNWahDybpUmzqAHA6j/q+j6o0w==
X-Received: by 2002:a05:6a21:6f06:b0:234:86ce:9de1 with SMTP id adf61e73a8af0-237d5a04ad2mr3750643637.17.1752656958129;
        Wed, 16 Jul 2025 02:09:18 -0700 (PDT)
Received: from yijiyang-gv.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9dd6022sm13926375b3a.8.2025.07.16.02.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 02:09:17 -0700 (PDT)
From: Yijie Yang <yijie.yang@oss.qualcomm.com>
Subject: [PATCH 0/4] Initial support for Qualcomm Hamoa IOT EVK board
Date: Wed, 16 Jul 2025 17:08:38 +0800
Message-Id: <20250716-hamoa_initial-v1-0-f6f5d0f9a163@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABlsd2gC/3XP22rDMAwG4FcJvp6LD0nc9mrvMUqRD10Ejd3aq
 ekoefc57gYlbDcGYf2fpAdJLqJLZN88SHQZEwZfCv7WEDOA/3QUbamJYKJjPWvpAGOAI3qcEM6
 UGauY7K0SipOSuUR3wnv1Pg6l1pAc1RG8GRalhn/6orveyrjp2fzsNGEccdo33t0nWkcqxskCD
 ZimEL/qnpnXxO//aqXMKaMgldVdr9uu1e8hpc31BudF35Snglm8Iuu7siiI3Iq+bS0TYOEfRL4
 gvFsjsiDqJHZb6IQR/e4PZJ7nb0mUXM2EAQAA
X-Change-ID: 20250604-hamoa_initial-0cd7036d7271
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: Yijie Yang <yijie.yang@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752656952; l=3210;
 i=yijie.yang@oss.qualcomm.com; s=20240408; h=from:subject:message-id;
 bh=E2yE+9Nv7BLKm6qUe/2mO7codsrDcFi+y6F6O46xBrc=;
 b=U4H7BSyiUGJquC92P5NAO/glGvs2iYuQVX+/UZIw/K7PnleVr9rRVxxD7SKUuvvlrS6R/T+16
 IYArvaWHmBLB6acJ4VhnkkGtjhzl6qkkK1Oq02LfbttbGc+QuaTOjaW
X-Developer-Key: i=yijie.yang@oss.qualcomm.com; a=ed25519;
 pk=XvMv0rxjrXLYFdBXoFjTdOdAwDT5SPbQ5uAKGESDihk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDA4MSBTYWx0ZWRfXznbaWRsFVciY
 5lY8EnuDdozwvYbT8rs+jv9TTJ9UQI8x1is2mefL5PxqUAYSpt9hauFLTI1VjQHpsaOuVKX8OQf
 jzO/E7dslip+2lbmAUrtKNejfu4kGkcOX8UrrPtR5oqPMdkN12Ex4kQLMbb0ar+ZV2Km2ETZVT9
 3ZA6uSusMEXcb9U1ILf1VHYV+COg+GeCZsujCJsjh2vkUP6cMegbptrqNu/LSiRytMQMi+5X4Ar
 7BpGyt+EBUGLDpPfmKK74/QEh/J4STqYuJoUFj4Uy5fNHY9d7157vOeAERCa0VIx7nfytMkpZEr
 rpbCwut6A9DjBDDIAElI/SFTrhPmJZ3MuGtINv0dqBdGJoN00LbxQZfwD3jBfnQScSwZ/3b8dRk
 P7XmFYkp5MjZQNrzqE6te7ZRCtInq+u0jCvdsq37PIPki8YSuFp4HtI7y+gkjkQeB19ZFfhK
X-Proofpoint-ORIG-GUID: AhtwWsIiyR0jp_Ip46H8PVK4PhEhdtzk
X-Proofpoint-GUID: AhtwWsIiyR0jp_Ip46H8PVK4PhEhdtzk
X-Authority-Analysis: v=2.4 cv=f59IBPyM c=1 sm=1 tr=0 ts=68776c3f cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=gWuG99rYYzh1ZzfbfFIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_01,2025-07-15_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 spamscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 mlxlogscore=999 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507160081

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
Yijie Yang (4):
      dt-bindings: arm: qcom: Document HAMOA-IOT-EVK board
      firmware: qcom: scm: Allow QSEECOM on HAMOA-IOT-EVK
      arm64: dts: qcom: Add HAMOA-IOT-SOM platform
      arm64: dts: qcom: Add base HAMOA-IOT-EVK board

 Documentation/devicetree/bindings/arm/qcom.yaml |   9 +-
 arch/arm64/boot/dts/qcom/Makefile               |   1 +
 arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts      | 835 ++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi     | 607 +++++++++++++++++
 drivers/firmware/qcom/qcom_scm.c                |   1 +
 5 files changed, 1451 insertions(+), 2 deletions(-)
---
base-commit: bf66a1ba8e378d23fde984df2034d909215f5150
change-id: 20250604-hamoa_initial-0cd7036d7271

Best regards,
-- 
Yijie Yang <yijie.yang@oss.qualcomm.com>


