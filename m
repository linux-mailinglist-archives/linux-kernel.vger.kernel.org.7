Return-Path: <linux-kernel+bounces-819910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA6CB7D753
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB96D7A46AB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 02:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77CBA2F3C22;
	Wed, 17 Sep 2025 02:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mbcUz7uW"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A7D239594
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 02:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758077978; cv=none; b=DAhiUyRmZSnCyQKmam55Dc9BehSmcMuG23BpCQAP9aPdquTaoVlsBTKeRt/tItayKzsUZ9eDJd1enGrPo2tj7Ez+Zc5/3rnRLDB+VyZUGXUdj+qWyu6v+tunsnv8mZqCaeEJbsoT4u6uIDcpPJV5edznDDmhr6X63HY2C48RBSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758077978; c=relaxed/simple;
	bh=+i/WKXbI9KwCiHQScEVwyQJ1DVd0fz9csN9m9EFulrU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SBG/clb7B5iLaIQrVfqiWBPNcD7KAzX2QjEgNUCgYr7mjjNkcd0HTxktSmJ9uVtdsTHIYWBYAEwbeY7PXetFqW6is4+rSn9NAJTZtNjTwDDCxDH0ysMhraCf9dlDWDNbrUuJWikkoV7tMOsiuViryKLCOqfVVls4bfCdPyGFDDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mbcUz7uW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GLaLR6008470
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 02:59:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=GedWUbQS3AE7EocyR7eIba
	LKKyrmQNwStp7EFrXiFiA=; b=mbcUz7uWyFBISn9D5bSomR/I6fsTGf5c6LWtnV
	Uu8dK7T4BCmyhg4vvte9rpFqB8+E8Idkd/oCUWk7+Nk5WssupaxlMRAm+rsSGPRy
	090MomuhWaVSPOdHO9JhfqqW0RyrnJcm39nLnJp2SxiZ9leycPVkcFJmXc4V23VC
	rsNZn/Y6soJ+SJMEW/vN7BFyufyyrhlhEcn0U+vS5Ck+KbviuUpErmoi+rnzuMtq
	uYWc5BOAJoz9Ao7ND9zorTzIIXtjpOX2L6vzWeKNS2Sp+2/UZz+d+VpWVjr04Wnz
	HyrNKWwdX0AkK65aMjZurWWBd96tPOk0JLYzmQ7KTi74PKDQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fxxrnqg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 02:59:35 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b54d0ffd172so419321a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 19:59:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758077975; x=1758682775;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GedWUbQS3AE7EocyR7eIbaLKKyrmQNwStp7EFrXiFiA=;
        b=D3G9kjgXWyZVhl1Kv/e7KdlXCQhEBdcLYTS+gjZC8/nW1y5NQ0wsbzocrjTuBnQ7ue
         My2dNg1c26m9qkzCySd9KsNd2saeBp7a7zIY65fjanD4TSoMbUP6LEkvEpA1Vs3T+mQP
         J0Q1awejvadhzCmaqxJkOx/xqTN7IEc0x6lHoD2htAYlyRxSUHkvgYq2+b0M8W5lCCQb
         vRoCuji2bjLPH53w7CtiEAsBRb8UR2OAfXfB290Q7FuS+kYcoBeFMsz2h/5W3v23D1qY
         WudBlDAYhcBVc+JyxM5sDzdmuGa0D3Lr5oRYwqEXkGHstKXPtdibdODP2OieNEx21E04
         s7ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCAL6yBkeAlWd/HEB5CrOH5yTzGZAHLrR5T6g9HkH6NJlxygPB0PhXW26/9w5M37hcZGDZZksWWYj59fE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB+rgqCeWTXKFkXwnYWVTkYJVzYWzRPTfumKQHwmdJU8gpVk9a
	Zqf67f2WRIuTFT0jGLiYVv5E6TKHY21H+LSBxmT/fEfLYlVlsbVewEzGgUUBYkRBLA4kBwy5h9N
	/d01DorM5JGtYMDzgrui6wp5e7rKrvm25F3pB2Zu+rLWrQGp7+6O0JApkIellUmuj+oVKkFH3sz
	1ylg==
X-Gm-Gg: ASbGncsbJEwzp9gBxDMy0gAUP3n3AUpvs5myWmHw9XBodZnCh6tX6tKV0ELmn7qLCrV
	litU4BHDTtiVB0pzLOey4A+LCx3ZibpIEVrRFVbq4+ceb5V/C1RUWUTvIoGt/E+yV2NiPqwFhNk
	QaEh6ozz0bOxcFCdCbuOhRNjoblYgFEM3pNmtVCrV2zO7M+TIXRSxs2X8x5c139pdYfYkBNBpAF
	U3Dpc37llHEp/NWr3Hey+JnOGaBy4Wv3pQScHuVUJROJJNzueg75uORyJVfVnqXDavQObZiRoIE
	t6N04RNipZ93+BWyK9qFDF2uFwiWsh9JX3O9rGnscQVX9gdGs3iUX6xlZ5TiuE3/YVZmmGWPOSB
	8Jbdnaq8+u1Qfue22vQAiF6EONaIg7vi1jA==
X-Received: by 2002:a05:6a21:e083:b0:240:1e4a:64cc with SMTP id adf61e73a8af0-266e19e33bcmr7000207637.12.1758077974534;
        Tue, 16 Sep 2025 19:59:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUudJhKkA0gFbZk0mVrNdSkC0s6f/Q+szAjOQRSl5ljao4ZoDHehv8AWxcj3LAidWquKXLPQ==
X-Received: by 2002:a05:6a21:e083:b0:240:1e4a:64cc with SMTP id adf61e73a8af0-266e19e33bcmr7000183637.12.1758077974024;
        Tue, 16 Sep 2025 19:59:34 -0700 (PDT)
Received: from yijiyang-gv.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54a35b45d1sm15481872a12.5.2025.09.16.19.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 19:59:33 -0700 (PDT)
From: Yijie Yang <yijie.yang@oss.qualcomm.com>
Subject: [PATCH v12 0/3] Initial support for Qualcomm Hamoa IOT EVK board
Date: Wed, 17 Sep 2025 10:58:57 +0800
Message-Id: <20250917-hamoa_initial-v12-0-4ed39d17dfc5@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPUjymgC/32T22rjMBCGXyX4ehVmdFYoS9+jlEXHRpDYW8sNW
 UrefWWnUGPHvTHInv/Tp9H4symxz7E0h91n08dLLrlr6wLpr13jj7Z9iySH+qKhQAVI4ORoz53
 9k9s8ZHsi4IMCJoOiCpua+dvHlK8T8OW1rp0tkbjetv44UqbwV10f3z/qfsO9+F7pu/M5D4ddG
 68DmbY0SMf6cyzFTjKH3dPXByRXrG/6XEgYyAUJEsm8TZBCrfDPp9zavtt3/dvvZnQ55jJ0/b/
 prBecNp1ICnBxqsoCYpkKTkjHBXfPXSn79w97GgX39TE63cMoH4WTTCJAMhYlW4dHmwudGyz7e
 qEVwjSVnAegNtgfDOjDsEEH4LWmAXHDgM0MUCwhrEJUokZbQT2V5icD8yisQUYwVGkT/IYB/zb
 Q6x7wCkETg3NUS6XcBkTMILiCiNEElTVeRh242oDIGYSu5kGOvaCRR0Ar6sVuQNQcopYQNc6Fc
 RqDkLyeaQOi5xC9hOgK8SagYrXtVmw11nxDzLqxpkKCYhRZskrwLROEOWV1xwgVEz0CCJWSD5u
 Y2b9mamiJwWnUY6jDBijSoxu63W7/AWE0rLmrBAAA
X-Change-ID: 20250604-hamoa_initial-0cd7036d7271
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yijie Yang <yijie.yang@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-56183
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758077969; l=6665;
 i=yijie.yang@oss.qualcomm.com; s=20240408; h=from:subject:message-id;
 bh=+i/WKXbI9KwCiHQScEVwyQJ1DVd0fz9csN9m9EFulrU=;
 b=hUKJTlvi6B6IU2V66iR+blRDZa7WesXrU65UnT55t9+BZ3KftOxqY4VGCY847KEEWVsH+H7bA
 GM1e/fzfteKABuj8ISrqkcXM8MjqtFVowkM511v1O0J54xFOMJoW8Lz
X-Developer-Key: i=yijie.yang@oss.qualcomm.com; a=ed25519;
 pk=XvMv0rxjrXLYFdBXoFjTdOdAwDT5SPbQ5uAKGESDihk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfXybg06yLT3ie0
 aVyJE2tTndLD6fAbo0grZlgLabGZX9NLHULnRHjUECa11BXDcbrM7qKvEX4H8AEU7ikxkh0WzPt
 z7kwHFUSJ+PlymwU0ltj0cFSR9Ws3yOTjdvR/QzSXqJlZL2FqPnKGv8cFGGG2bIrWdcYZWfGROQ
 ITPdjsa533259vGvZmuIadXYqptwJo7Dhp8ZBCwGLbPzrs06M2p8ouVZjBmsOQDOqW/vvHDfYxN
 Ymh5AmRONivcQteVnq4urnp3GgWg4YEE6n0Nb7t0p7/faFuQx0icd0MqKSFHkUz2A0OEOzQ/3B5
 bmRwv4qU7r3wRt3I1cAgi7BrQhQ+nrjeQDoFJXkCE4V6iSB1wi8BI2ixRTl4njNUS98SVrN/KYc
 oVXvCngb
X-Proofpoint-ORIG-GUID: wp9WB1EWfVJ1wAc2xQwOgEcYVC-CIh4Z
X-Authority-Analysis: v=2.4 cv=KJZaDEFo c=1 sm=1 tr=0 ts=68ca2417 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=hsIpd76ykShK3axuoLUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22 a=cvBusfyB2V15izCimMoJ:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: wp9WB1EWfVJ1wAc2xQwOgEcYVC-CIh4Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-16_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 adultscore=0 impostorscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160202

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

Depends on the following change to enable video:
https://lore.kernel.org/linux-arm-msm/20250911-x1e-iris-dt-v1-1-63caf0fd202c@linaro.org/

Signed-off-by: Yijie Yang <yijie.yang@oss.qualcomm.com>
---
Changes in v12:
- Remove the data-lanes property from the nodes: mdss_dp0_out, mdss_dp1_out, and mdss_dp2_out.
- Dropped the video commit as it duplicates Stephan's work and marked it as a dependency here.
- Add 'regulator-boot-on' property to vreg_wcn_3p3.
- Fix incorrect comments: change 'CRD' to 'EVK'.
- Remove dt-bindings dependency for x1e80100 Iris.
- Link to v11: https://lore.kernel.org/r/20250910-hamoa_initial-v11-0-38ed7f2015f7@oss.qualcomm.com

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
Yijie Yang (3):
      dt-bindings: arm: qcom: Document HAMOA-IOT-EVK board
      arm64: dts: qcom: Add HAMOA-IOT-SOM platform
      arm64: dts: qcom: Add base HAMOA-IOT-EVK board

 Documentation/devicetree/bindings/arm/qcom.yaml |    6 +
 arch/arm64/boot/dts/qcom/Makefile               |    1 +
 arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts      | 1222 +++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi     |  619 ++++++++++++
 4 files changed, 1848 insertions(+)
---
base-commit: 51095600e8c19d53729a7fbd273abc4435a25e9b
change-id: 20250604-hamoa_initial-0cd7036d7271
prerequisite-message-id: <20250911-x1e-iris-dt-v1-1-63caf0fd202c@linaro.org>
prerequisite-patch-id: 00f818253d1f1613b0263ee46cbbcd8ff9a01642
prerequisite-patch-id: 733387b3347d71183bf5859b70b787a95b0d1c4d
prerequisite-patch-id: a39bcc0bb375eada0214efe3e40d5c2f3405c5dc
prerequisite-patch-id: 2c2ec1f8e5de8cb33e63fddcdada4e9c0dacc6c1

Best regards,
--  
Yijie Yang <yijie.yang@oss.qualcomm.com>


