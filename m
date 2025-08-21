Return-Path: <linux-kernel+bounces-779286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A48B2F179
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 10:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A7187AB616
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 08:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412CA2EA73C;
	Thu, 21 Aug 2025 08:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ckT4hLda"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9519613A265
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 08:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755764475; cv=none; b=nLQd3ICPcAM9aG22mUWHzA3oCHynpKfwHTTNqHumH8cD5PifYDkQwW5rzNx6y7zo0AUiUMzve3QuQNeWH1+2rJM5XrZgFbSv038Ndb2f0bNlJ1Xk7KGhRPP+ipX7RDYPBZn1Gt559jAqz9qDEhzlKmdOoOvWbxZ2iY0koGfDOVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755764475; c=relaxed/simple;
	bh=bffLUjyFA0KsCSlfiJfeRXqEv6UpZgYAPGsZNkLwUHc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WHqsH4GI9j9bQcWZXm7fhPsCBmdYA/9nUfZjt8PYqJ1/+IG3PiaYWhMO7qIPRVzab4whEW+7ed8Fc/Ic3OaT25StikVkKKSWqsHizCkj9j4Kq8iVhLNurq5TYQXs8vCSt7Istu4hA4NLzKskS9YoXJZ33EQnLM6L+egKx38w32o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ckT4hLda; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57L81oMk026051
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 08:21:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=hm4EmfIOLpSgudxjqr0Lpe
	Dd9d91gclP5Gd5SIEo/RA=; b=ckT4hLdaFnsacJJGPqfo+3vZjERDaK6wYaB9Xn
	/iIdR/rIiztdJZyEqgD5pOmBMTbQcwdpOC/lJZ2UgbewEUqTeMSxFBT6Ita0uD6Z
	Tv/Gwo++cVzjdfvtQ0qFhR4LPXFNlblzowmVkkyNb4pr+oHA79mSDt3h2PA+u9iu
	8NetrIYguO3k+vNK1N+8kIYoP4yJJH3mH4Iao+Zh4EwLx9hJvoZJtg//HK8oEDxu
	Tf2F/nMsW5CyQNgvdzPT/oJsrfvdd/YgnxAVfjdoexb3H+EBXpYYDEosrdOSYDeA
	x+3cg8zRqob9fx7lZJKCv2X73SjlJgcnXYWf+c/a8k77agsw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n5294q74-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 08:21:11 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b47156acca5so702512a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 01:21:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755764471; x=1756369271;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hm4EmfIOLpSgudxjqr0LpeDd9d91gclP5Gd5SIEo/RA=;
        b=PT5vewt2N3TQf9rFVBCyQyI/X+8DyTxXciaSb/ZMCgmOzfsmfsm0x8sw9Oh/Y7r0OY
         /5WR/ILn3zt9LY6WFa3kYTqXOKaIZ8wrBhKuBzGuHpfyZGcXQA+OEmuO4F5KZvohN9zL
         2+MTupxlmj6Rt6oVhlbYKglOybmAcuCmF95kqPRn4pkaBbNUYGzM+E7oAENaYFdWdzfr
         p+Hu02lljD0UE8D7udOK+ZO4Nml77s2EXIanDeFZcxdhyUqOnkZsPzezFdTlhfmEfToZ
         dZF2XF2pllrwCCiviIAO5m4C//l30y2aeX2gDm9uwmmUrbi9+pKgAHBdvSVAmCmgJV0y
         Sc7g==
X-Forwarded-Encrypted: i=1; AJvYcCXSWMZuIfxvvKbKBLgD2T8//0WM4aNGDWC7I5hYi5HzrZzGgFWl5d4VVXNqH/3Cmpv/m7Tpt19QOBsSACQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUyvK9y4c+Rp+qt822Hu69OftTY5cAeJUVEi55C2Gn8WAJU0Wq
	VCvlLk4L63wZITR4RJnfZTESoF/YaOPIJrobPsC1rCLnn+2Bb871i0Fs557vyXm7GeTAVrLITDP
	85GUmAHzb/7aThCG2YQBRUEmexY0vN0wIHOd/61dY6n6s633XktJV9bKkJ/hsT0NG6F8=
X-Gm-Gg: ASbGnctaroGsuDy6rxFgh0bF8NDO+8u5ztRpRpU9LGfRimySrZ+/gFJyA3d6o+COJ2c
	og1ykEhXRNOG4cQ5QdM9X3zumeIi0zfl0Xur3rmkTQLwd6BoePhqCcTTe88IZ25K1xs2vf4nIfb
	SHgp1lSaScTPl90saEOSkdOOkVvpd1AVYAWHrVoWN1T9XXy0n6iAY66srEVZ25d7stHh+sLCpc6
	7lKIeQUNKLI6LexdOdBZKXjhVe6ISRO3X1tsBzjR3i6dkAt3qWYLjFgXrLYXMegzMgc75clIoR+
	xvlEwJye1JfjhW6lTBXQvFwaCkAoZj5/jw9JbImTaCYv6WLVOXnnegsoxLcIgS8B0yRI26bHWeH
	t8pdYuJ2zmquyQJH+Pedp1Mt6DeVQylP8Iw==
X-Received: by 2002:a05:6a20:4325:b0:222:ca3f:199 with SMTP id adf61e73a8af0-24330752ad9mr2252653637.18.1755764470715;
        Thu, 21 Aug 2025 01:21:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEy1faeyC0PQ6/alg6TgYaQWVwghLGtV3hmOWzX6mElQpOQZTWm6K2WekHeVttre8FlBOnyEQ==
X-Received: by 2002:a05:6a20:4325:b0:222:ca3f:199 with SMTP id adf61e73a8af0-24330752ad9mr2252611637.18.1755764470182;
        Thu, 21 Aug 2025 01:21:10 -0700 (PDT)
Received: from yijiyang-gv.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d52c7f2sm7468238b3a.87.2025.08.21.01.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 01:21:09 -0700 (PDT)
From: Yijie Yang <yijie.yang@oss.qualcomm.com>
Subject: [PATCH v6 0/3] Initial support for Qualcomm Hamoa IOT EVK board
Date: Thu, 21 Aug 2025 16:20:21 +0800
Message-Id: <20250821-hamoa_initial-v6-0-72e4e01a55d0@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAM/WpmgC/32QW2rDMBBFt2L8XQVp9A6ldB+lFL3cCGI7sRyTE
 rL3ynahIXbyIxg098yZuZQpdDGkcltcyi4MMcW2yYV4KUq3M813QNHnugQMHAvM0M7UrfmKTey
 j2SPsvMRUeAmSlDlz6EIVzxPv4zPX1qSAbGcatxspU/ivrwvHUx7Xz81zp2vrOvbbognnHk0jF
 WFjfx1SMpPMtnidPiQwVLdDQMEfUGj8oY1Nn9BAEEXCGS60IqCoem9T2hxPZj+yN/l5K0exXUx
 92/1Mew9kMpixmNytmIkYGSq95cIyzuyCOArOYSLWwpWouMeVNkTQZXi0GeDW4P7IA2QIVSAY8
 xiMN08MYDWsicXYKQWekAcG9MaA8HsIzRBZgVaGgwOhnxnotbDCImANUmnvHhiwfwO1vAHLEKK
 DtxaUkNI+gPAbCFlA+GhCpNFOBOWZXIFcr9dfUlv2XxUDAAA=
X-Change-ID: 20250604-hamoa_initial-0cd7036d7271
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yijie Yang <yijie.yang@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Yingying Tang <quic_yintang@quicinc.com>,
        Quill Qi <le.qi@oss.qualcomm.com>, Jie Zhang <quic_jiezh@quicinc.com>,
        Shuai Zhang <quic_shuaz@quicinc.com>,
        Yongxing Mou <quic_yongmou@quicinc.com>
X-Mailer: b4 0.15-dev-5bbf5
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755764464; l=4906;
 i=yijie.yang@oss.qualcomm.com; s=20240408; h=from:subject:message-id;
 bh=bffLUjyFA0KsCSlfiJfeRXqEv6UpZgYAPGsZNkLwUHc=;
 b=P1KPxFMOpCgwFNBgQG7wAuDUDUjNiDrxTfb+WVW5E0n9HpOV/vrgTN3yh9Y6RqOxv+mZgkDh0
 XBK/hGlCPPYD4Y4tPPLtlf0c9zuXG76X/aiU7OP299r2e00Dt5I9uLO
X-Developer-Key: i=yijie.yang@oss.qualcomm.com; a=ed25519;
 pk=XvMv0rxjrXLYFdBXoFjTdOdAwDT5SPbQ5uAKGESDihk=
X-Authority-Analysis: v=2.4 cv=ZJKOWX7b c=1 sm=1 tr=0 ts=68a6d6f7 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=SVuyu6wvmbTLjiTTrX8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: QDmwmpRyBDYuKC-S42ruHB9-BbCSL0al
X-Proofpoint-GUID: QDmwmpRyBDYuKC-S42ruHB9-BbCSL0al
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX3py02hsMIILk
 erU72m8KgyISEujfGmtjbi27ZDg3MWtXlIDDjLYRU1RynRoyFUYpnLCY74YKDxQNSuIFUQ68sII
 pJwjwQKt471tFmaeVxDec2cEaWxs9cRaWInzW4dI9SDRz035zqd3o1GHBgcZ/NUqaKCXH7aSNZu
 4iRQn9a3Ige/kjtw8KdYXa+96lT7GjKMuZezGxJZpOo/g2ZT9PGWFc7dTd9zzl6RIs+36fSNZNt
 oU5A7HHuAZwH28Oq6l8V72wEExxvhSdkrZ33APP3NEAWCQO9EYW0G4d3EjYOCWHSS37F4DYYw1c
 HRf2PI49/f24DYXP5kbFyDxqWKapZCzRH6icNhpEvcj8WDNlyxc/MNrKywJKU2qAD9QXrwYqWCE
 TX18TBtUDZcSusG7XdIEz08IeXom3w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_01,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

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

Signed-off-by: Yijie Yang <yijie.yang@oss.qualcomm.com>
---
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
 arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts      | 1247 +++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi     |  609 +++++++++++
 4 files changed, 1863 insertions(+)
---
base-commit: 2016d952577e807ee89e0cef02af1f95aabbbcb2
change-id: 20250604-hamoa_initial-0cd7036d7271
prerequisite-message-id: <20250724-move-edp-endpoints-v1-3-6ca569812838@oss.qualcomm.com>
prerequisite-patch-id: c536bf9ec7fd22af9b05b695272997615dfd675f
prerequisite-patch-id: d513e5a08d3be585b9b6a737ef3a1ad275d7caad
prerequisite-patch-id: 605ef6f89dd84f810df11be9d11ee6803a6bf289
prerequisite-patch-id: 2ab2430624acbdd9011f6c0c2a77469fd19fc75a
prerequisite-patch-id: bfbb562513763ce75f2bb5da7f12e7b54ff3919d

Best regards,
--  
Yijie Yang <yijie.yang@oss.qualcomm.com>


