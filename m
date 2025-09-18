Return-Path: <linux-kernel+bounces-807123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D717B4A061
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 05:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF3071B25CCF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 03:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68598281375;
	Tue,  9 Sep 2025 03:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TPRfEUct"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2167255F27
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 03:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757390228; cv=none; b=VQmtyrrQPF3jI7EMmL0bFpdJZfRcFOqxNu+q1fdTr/qKoreEBTxCuMIva20vNAgmhOG5gNK52605KKbUDikGQDGj2CdXpHARMIThM3dOmR8TthFQKc9a40PLZq/oKhgL0jwur9Zzt4b3u6eruNgXeLccAXltPcu8nJ0PI6FErG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757390228; c=relaxed/simple;
	bh=3B7OyQMyFcGSUg+8fX5pWMGYwHwcRwNUW/9zg/vlngI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KscxcIvt4rmYSbENJ8vKY2+RKn1cuFLULW+Hz1x16ra68/eU6mdqo33ObNa98MgOFIp+qfL22MbF9ZeOXeUnALSMMCDv4QjhXpg0t1dM/KC1KJjm5GFhW2RAV9lwsiZATm5DcchqOkfFYAm/JC95D4RlOnAwmwDRKyigmhJ8720=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TPRfEUct; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5892ET2E020952
	for <linux-kernel@vger.kernel.org>; Tue, 9 Sep 2025 03:57:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=z7g8zYXPN7poenXL+B2mWI
	SjkZSA038v1qp33euxthk=; b=TPRfEUctxybsjjdIU3DjY0Ohmtq/OCmJaDtNgz
	WLAs8v61PcvSfdoqxKbvGZe9+HIwm69je361yEURNPzXpQ1LkX+0cGaiu5BLRZUt
	+u8qTg/qLAvi0OI9J9bP2P8Q/R91ds9yz5dmojFZdTdB65uLzH7RBCmLbxrNUzzK
	dC+YV8cJt4FReurlfKwRcL63YjDh+1VP1AgYjzWArf1vJnz5JZKQ0yVqsEXAmyr2
	203o1adRXLiOdgcCOdaZfX3EDjVhOL1ALunehvQzDq49Q2LOIWHkfvFkvZ4dBYvN
	D+7TZ4ucn5q5ne2InEJsVOuGxln8T6L8ctp3gPJHDZjl/8Pg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490bws6w3h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 03:57:06 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-24cc4458e89so118771815ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 20:57:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757390225; x=1757995025;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z7g8zYXPN7poenXL+B2mWISjkZSA038v1qp33euxthk=;
        b=Z1uJWObqawAkEZjLbT+p5LI889ugo7SnvLFi0oN5tWFq4/PGw+cyYhs9JuwodCgkRC
         VQP3+CQPQxdA0TTyrgXPXGt5SI4yoci8eDq3pIcx7gQcNVpiFqTWyk8c8EyG0iTHzt8p
         IiBlv2UA7PUATK2fQpqji46AmwUN+9PxR7YAOFdufhKM5TyiHSEKIMUIsxgt/jIGCko2
         7L3bv43u7yM1XrJYGIw87yDJUetdiEhDbGDyD9AfYjojXIWZQowP6c+Hrk2/9b/8wZVE
         oejt4LsR+FBIRMx8z+DWstS6y+lsL766RV0LWNNGm+wQPiKlQcq+4FwT26A5hnpQjEcM
         gKww==
X-Forwarded-Encrypted: i=1; AJvYcCUC1DpkBflmaq6SdTUvcaEK1VUlx8YdRaF8ZE4MrVvyoY1+LcccVN3Fwh/K1FPFEAoq5N/rA9knB8GNNwM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSrzcZyCYLOmT9yfqRP0k3lmzNI9O/q9h7nnPAiWtZx+3lV7AV
	doxjtirD5c9KdxsC/yOqnKqZa7aw7EeufftokeDcYZMrp1Aj1ZhGHiWRE7mQpTlXWSLBsMPHJPk
	g0aICMNMJlu28JJE2AUkUbZL90im7ANKmpQHNLcI7OauetN9mlOkguQsP/TWCDojCCUU=
X-Gm-Gg: ASbGncusGGOBXtK99OkAtopHxIHV8EnmxakbcgJsZ5Yj6Od8+q3hByRbkHR3TXM8l/H
	kDrXc0GAXV/3QTfA30NweAdNZFR3XiV6gT2Xtcdncp7GCm9qK67PGAYUt3i/8FE+K9uEmoLoeCF
	+O/Q7hZAaqqK9MKKulTIDl4ZHeDEx6YBZ2l0f4R7jVuZ1VcKmcdjngcOAypJaw0FkU98ReBh6OZ
	dpO/mHovecJi9alesU8jfx2+tUsvS6kE+wIIhsistEM1XnekeKKJx/YGzPMqt6w0J31rG5DODyS
	pUOS2RdghUnOhE6q+0sKJec+tO1UPXeW+rHzqRKS4aHa0leBXOv1bld8Ei2rPnxeND/DIwC9UR6
	vCravo3i+r/50T6rgU3ASXU9rBOgtiS5KQg==
X-Received: by 2002:a17:902:c945:b0:24a:af68:72f0 with SMTP id d9443c01a7336-25171cba33cmr132175725ad.34.1757390224979;
        Mon, 08 Sep 2025 20:57:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvgUp90I0lndkCSYgjcSvAih1NiSVHc4pNrx6wMvMWxlcUhPBsCFEia334W805yRi+z1jXBA==
X-Received: by 2002:a17:902:c945:b0:24a:af68:72f0 with SMTP id d9443c01a7336-25171cba33cmr132175435ad.34.1757390224418;
        Mon, 08 Sep 2025 20:57:04 -0700 (PDT)
Received: from yijiyang-gv.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24903724b94sm295614705ad.35.2025.09.08.20.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 20:57:03 -0700 (PDT)
From: Yijie Yang <yijie.yang@oss.qualcomm.com>
Subject: [PATCH v10 0/4] Initial support for Qualcomm Hamoa IOT EVK board
Date: Tue, 09 Sep 2025 11:56:01 +0800
Message-Id: <20250909-hamoa_initial-v10-0-ec10057ffcd2@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAFOlv2gC/32S22rjMBCGXyX4ehU0o3MoS9+jlKKTG0FibyzXp
 JS8+8pOocaOe2OQNP83n8b6qnLsUszVYfdVdXFIObVNWQD9s6v80TbvkaRQNiqkKKiknBztubV
 vqUl9sidCfVCUyaBQQVUy/7pYp+sEfHkta2dzJK6zjT+OlCn8XdfFy0fp19+L75W+PZ9Tf9g18
 dqTqaVGHOvPMWc7yRx2T9OBKi5XKDtdymQAAsQzYCoYZSJnz6fU2K7dt93732oUOabct93ndNE
 Bpo7fGFhcqbAosYXkhHRccPfc5ry/fNjTaLcvn1HoHgb5KFzLWgRaGwuSrcOjzYBzg+VQBywQp
 lFyHijaYH8xwIdhA45SrzUGgA0DNjMAsYSwAlE1Gm0FepTmNwPzKKypjNSg0ib4DQP+Y6DXM+A
 FAiYG51BLpdwGRMwgsIKI0QSUNV5GHbjagMgZBFfvQY6zwMgjBSvKj92AqDlELSFqfBfGaQhC8
 nKnDYieQ/QSogvEmwCKlbFbsTVY8wMx68GaAgmKIbDaKsEfmdxut/891iGPGgQAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757390219; l=5881;
 i=yijie.yang@oss.qualcomm.com; s=20240408; h=from:subject:message-id;
 bh=3B7OyQMyFcGSUg+8fX5pWMGYwHwcRwNUW/9zg/vlngI=;
 b=+zucONejh2FR3zhZtUke2iS3J/Xp0yih3byjCK2Eoljf9HYBUXYABHjjioc6UCs9ATT8ioDpZ
 Wcyphdfs9jnAn/tkkRfSRZYGXZWXOGNsuuTPEj9w2SKe+Dt5LkJBmrC
X-Developer-Key: i=yijie.yang@oss.qualcomm.com; a=ed25519;
 pk=XvMv0rxjrXLYFdBXoFjTdOdAwDT5SPbQ5uAKGESDihk=
X-Proofpoint-ORIG-GUID: zicejjC-dFHzqpF7M5gEGuyQcilorB3r
X-Proofpoint-GUID: zicejjC-dFHzqpF7M5gEGuyQcilorB3r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAxOCBTYWx0ZWRfXymG0fWLRIV6D
 /+5hbX9DiIxN5p9D64TH7kLjYIOYMUubKT8AjCjO+2yyQXm2KWpzSnYQh3oYW3p6PUMrKGPy4ED
 xuKNnMa+q5KDR3j6WwqDknWkDRj66YBY3AIKDynw6BhkiFqPihxmroYMWpS+cC4iXuJsgf85vTt
 B/fvPVsYZfgaeMi/f2vTVa+17IUPh8z5IYNHZbAW7LBR1oVPySu6WmWocPCglT26cJFBKR23rsG
 ZANKdtbtd2boTHIW5i6v0afRxKQYsLt3iPubZKl8MLbyFsOvTWwvtmV/vp3QYC0R9Mq4cUKpijQ
 8fHbLsgdgPTjeXnLPLiZkMhRTROuvWzvszd0e5GtUObC26dpWdOuMnqmQsILR3U21piVLO+3NwU
 98MqILZj
X-Authority-Analysis: v=2.4 cv=G4kcE8k5 c=1 sm=1 tr=0 ts=68bfa592 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=9t_RjFJeVWII2trnqQ4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22 a=cvBusfyB2V15izCimMoJ:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060018

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
 arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts      | 1240 +++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi     |  621 ++++++++++++
 arch/arm64/boot/dts/qcom/x1e80100.dtsi          |   82 ++
 5 files changed, 1950 insertions(+)
---
base-commit: b899981540841e409e496083921f2e5c4c209925
change-id: 20250604-hamoa_initial-0cd7036d7271
prerequisite-message-id: <20250704-x1e-iris-v1-1-c3137d979e43@linaro.org>
prerequisite-patch-id: 037bb113706198fca6a87000e46907bc23f9d7e2

Best regards,
--  
Yijie Yang <yijie.yang@oss.qualcomm.com>


