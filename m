Return-Path: <linux-kernel+bounces-781276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D647B31052
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 759271CE46A1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 07:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7672E8E0B;
	Fri, 22 Aug 2025 07:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Bx1PjLna"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EFA2E7BD5
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 07:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755847625; cv=none; b=LpBcGchdYvk8GseyZwnDy97uc9WrKXQPwbmPsfhMTCTqjpGhswdyzZxRdm4GflRGeItTXNpGxkgey/A41l9C8+59gZ58jM8w/vGAmEGzKVLyNo8gw0rvzz2fWfH6RAfu1bjrzUinSzrH09GyTnq4CpULZPVUALDpewhidbHKYRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755847625; c=relaxed/simple;
	bh=mtFSOmlzUjGRTaOYdonrJbl14kE+CiRkvjabIqtX+tw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FjCRtxsyTT2vcenGn0/1RDVBzkmmAnIBCQtcixYZSLvYKbprRYC+KLjeow3nG8XHp5u8MBr5sKzR/MTLCd9yOL7Mba77DtBSc+djT74cH8b89kwnLwrfSnXEDwrgpbacAcRGJktALtDTg+74BILKmQozawD9vKoIbk3s5kG3HcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Bx1PjLna; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57M6uQPO021359
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 07:27:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=jtJpJ+M9oLoAw7iHlj1pHr8YEqUBvJYMWFP
	56DMmt+c=; b=Bx1PjLnaOI1r9mgbjEwzBA79y/tkLkc44A7Fe1xwIenE7hWpdui
	1pY13+7p8Y7pe/91ALWbxW5YHBT0wlExmm20nxBCxlmJgAM5CFpZU4VzgLFm1V2I
	Ut3neXsd245k3qZWcF+iDegxmNbw5akwNkEunrceC5c5whLhMpSVs4YEjVK7MsWv
	LcA9PV8+9Zyi+Q46Eqzo6AHVmhHVIDWvUCsEFV+gerddIWKUhNFEfKrCdJeoF7GZ
	ImBjEkugOo24CBrq294AglQfO5p2lPifwzYwnZVGj2utTCAw0Rhws9G0C5yruwfK
	DTENQ21Xb1KIy8d5Kqa9tMKQivM2CRyZbpw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52a89nx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 07:27:03 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-32515a033b6so820902a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 00:27:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755847622; x=1756452422;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jtJpJ+M9oLoAw7iHlj1pHr8YEqUBvJYMWFP56DMmt+c=;
        b=nun9JI9ZtQ4htYe7Wdju+4r7hk67eQB3B9LmQ+J8UtyXyQOQXaxqlcr7sIwBfweqnh
         emOz2xDtSRFV5A4ewCWm+jf+wq/xbznkE8eb8n3ZDpBBJv3wAkHUPjRiIgJmVlJDZtxQ
         f8ie+CX5+nWiykA1X6q2DMYgY3dyjD1ysIRfGuJGdNwMC5SIA5qPDJilhtC70N2YCPBr
         a5YtcJ/46jmSZ6ZhjGkhtKt5Pe9X8GLKsnP5yhlYB5ArQ1p6b6oH4h9ZQh920V074iFy
         o6J3zvuU5DIJBn1FnyNlRHkXIJgKdm55LZW2JBILb0Tmt/yr7y6RYP/CsicFtPknp6FH
         OlSg==
X-Forwarded-Encrypted: i=1; AJvYcCUkkP+l8oZllK8zN94dSaJbIAt0b4uyJO2pCwXEIY4g80FaZfNEXkV80smZVp8X5xB/fjmMfeEuRnjyIFo=@vger.kernel.org
X-Gm-Message-State: AOJu0YypoATCAYnFHypj7kocnPlxLIBESkXTnx+Srvi3atQDEz4uLj9x
	WCol8bCg9lU2npfoamyXHyvq24TCpFNmlYX2OT26YUPBrnTkLIoOya1EKfyKvUBQCHDkkWXCYoC
	QK1bacSkOtbtqEs7CcDIqKiOMM7yz9RnxsN4yO6o55lPFaGQB6SKvXAXhXAgGzMT+BXM=
X-Gm-Gg: ASbGncvE7FHv2BuNm23d+bnsppLSm8SNR+VC0SyKg2Xt6PMU4METGZh6Sykdtk07Ujt
	bIUCqUVZHeUD4dUKKavxjfafp1Ue0pXu3d7loBxEA9XV0GloQaK0dfy+LM7lhJg2OMpcNjKx4z4
	G9WcgMc7wdNTxzoetTI4JMgyFYGfIk5+Z1YT10Q/FNg0VXmocS4JDh9hmVUQYaaC9iU9fRg2mIL
	xzhPh8qx8sY2sChcZU57QU0WQRrZQAjcRT3ibpDTSLF0OwEXPjdzO1ErBwnQnY3+ucuipre5n+0
	U7ZumzN0KPVCW+ymxxEMeQe9Ypg+2iOPZb1Qql5m/Y+cc8YYZaFr8TW+XyL0ERdXSeGIM4lR4yM
	c
X-Received: by 2002:a17:90b:5443:b0:311:f99e:7f57 with SMTP id 98e67ed59e1d1-3251774b90fmr3079066a91.23.1755847621846;
        Fri, 22 Aug 2025 00:27:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmLmqFldpv+m0ckTlde4cTh29EiQMTSlLO6BYZehey/5qXgoATAf9+VVUdZui4BbBPF+ggGw==
X-Received: by 2002:a17:90b:5443:b0:311:f99e:7f57 with SMTP id 98e67ed59e1d1-3251774b90fmr3079029a91.23.1755847621298;
        Fri, 22 Aug 2025 00:27:01 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4763fe3047sm6416367a12.17.2025.08.22.00.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 00:27:00 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
To: andi.shyti@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, gregkh@linuxfoundation.org, jirislaby@kernel.org,
        andersson@kernel.org, konradybcio@kernel.org, broonie@kernel.org,
        johan+linaro@kernel.org, dianders@chromium.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org
Cc: mukesh.savaliya@oss.qualcomm.com,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Subject: [PATCH v6 0/6] Add support to load QUP SE firmware from
Date: Fri, 22 Aug 2025 12:56:45 +0530
Message-Id: <20250822072651.510027-1-viken.dadhaniya@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=feD0C0QF c=1 sm=1 tr=0 ts=68a81bc7 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=HXvFq9hwUs1lQpdr-HAA:9 a=rl5im9kqc5Lf4LNbBjHf:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: WStZOv0SMQINerDzRLb5S2qHb_qvk2FM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfXxPR6gXZoJaAG
 sBr4xt62zu/BkXLyhFqaZNHIezxnr8vSkBcuQUyUUANdCqTJ0gEvlyBxJPLju3OfHTBm7wTfth9
 nY2cJWGVlDRtUPM6N7AVKrNaetLsMX72j5DbZ8KAkm65GRQVegLjBbxN+GCpS4IQhOUXesDn7Yi
 qPGsrve3vAXCGc/yFTjIXHUslf0et8vHskIwoZKVI/ofyvtzeMKPTj+VCmgqaTYGmOkO0QE4Nmj
 yC9Ow+GJzEwZlxayX8ocRdmi0Iz9YzPq8jljrnppUiLltYGDbv8lmTubeAj8qSshLdZDvotpu5Y
 PzeCpjH+dytXgDwUpdDPLjJ/stymEeR1eTrZeI7w6MdlrcLdW0i8TzwXSIJW4jL7N13w0kYo5Qh
 4BDJMFCyeFsJzckew6Q//bN+aE+2CQ==
X-Proofpoint-GUID: WStZOv0SMQINerDzRLb5S2qHb_qvk2FM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_02,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

In Qualcomm SoCs, firmware loading for Serial Engines (SE) in the QUP
hardware has traditionally been managed by TrustZone (TZ). This setup
handled Serial Engines(SE) assignments and access control permissions,
ensuring a high level of security but limiting flexibility and
accessibility.
 
This limitation poses a significant challenge for developers who need more
flexibility to enable any protocol on any of the SEs within the QUP
hardware.
 
To address this, we are introducing a change that opens the firmware
loading mechanism to the Linux environment. This enhancement increases
flexibility and allows for more streamlined and efficient management. We
can now handle SE assignments and access control permissions directly
within Linux, eliminating the dependency on TZ.
 
We propose an alternative method for firmware loading and SE
ownership/transfer mode configuration based on device tree configuration.
This method does not rely on other execution environments, making it
accessible to all developers.
 
For SEs used prior to the kernel, their firmware will be loaded by the
respective image drivers (e.g., Debug UART, Secure or trusted SE).
Additionally, the GSI firmware, which is common to all SEs per QUPV3 core,
will not be loaded by Linux driver but TZ only. At the kernel level, only
the SE protocol driver should load the respective protocol firmware.
---
v5 -> v6:

- Added extra patch for cleanup in qcom-geni-se.c file.
- Moved contents of qup-fw-load.h into qcom-geni-se.c.
- Specified endianness for all members of the se_fw_hdr structure.
- Changed the return type and arguments of the geni_read_elf function.
- Renamed geni_read_elf to geni_find_protocol_fw for clarity.
- Added error logging for corrupt firmware.
- Passed SE mode and protocol type explicitly to all relevant functions.
- Replaced writel_relaxed with writel for stricter memory ordering.
- Renamed variable reg_val to reg for consistency.
- Moved firmware length validation logic into geni_find_protocol_fw.
- Updated function documentation for clarity and accuracy.
- Removed redundant firmware length check.
- Inlined the qup_fw_load function and removed its definition.
- Removed the MAX_PROTOCOL macro.
- Dropped mode and protocol fields from the geni_se structure.
- Moved unrelated firmware loading code into a separate patch.
- Added Acked-by tag.

v5 Link: https://lore.kernel.org/linux-i2c/20250624095102.1587580-1-viken.dadhaniya@oss.qualcomm.com/

v4 -> v5:

- Added Reviewd-by tag.
- Resolved kernel test robot error by including the missing bitfield header file.
- Updated the SE firmware ELF structure name for consistency.
- Specified _leb4 format for the magic number definition.
- Updated the email domain from 'quic' to 'oss'.

v4 Link: https://lore.kernel.org/all/20250503111029.3583807-1-quic_vdadhani@quicinc.com/ 

v3 -> v4: 

- Drop patch 1 of the v3 series as it has been reviewed and merged.
- Update the qcom,gsi-dma-allowed property name to qcom,enable-gsi-dma.
- Remove the full stop from the title.
- Add a reference to the common schema YAML in the I2C, SPI, and SERIAL
  YAML files in a single patch and drop the individual patches for protocol YAML.
- Update the commit message.
- Resolve kernel test robot warnings.
- Add a multiline comment in the Copyright section.
- Remove valid_seg_size and geni_config_common_control functions and add the code inline.
- Rename read_elf function to geni_read_elf.
- Add a firmware size check.
- Assign *pelfseg after finding a match.
- Break one large condition check into multiple checks to improve code readability.
- Remove return type documentation for void functions.
- Update error messages to be more descriptive.
- Correct indentation.
- Rename geni_flash_fw_revision function to geni_write_fw_revision.
- Remove __func__ from all print statements.
- Move resource_on to the appropriate section after parsing the firmware file.
- Update variable names and function arguments as suggested.
- Use FIELD_GET, FIELD_PREP, and GENMASK.
- Use memcpy_toio() instead of memcpy.
- Remove duplicate registers and bitmask macros.
- Remove rsc struct and add required variables in geni_se struct.
- Add a patch dependency note.

v3 Link: https://lore.kernel.org/linux-arm-msm/20250303124349.3474185-1-quic_vdadhani@quicinc.com/ 

v2 -> v3:

- Add a new YAML file for QUP peripheral-specific properties for I2C, SPI, and SERIAL buses.
- Drop the 'qcom,xfer-mode' property and add the 'qcom,gsi-dma-allowed' property in protocol-specific YAML.
- Add a reference for the QUP peripheral shared YAML to protocol-specific YAML.
- Enhance error handling and remove redundant if conditions in the qcom-geni-se.c driver.
- Remove the ternary operator in the qup_fw_load function.
- Update function descriptions and use imperative mood in qcom-geni-se.c
- Load firmware during probe only if the protocol is invalid.

v2 Link: https://lore.kernel.org/linux-kernel/20250124105309.295769-1-quic_vdadhani@quicinc.com/ 
 
v1 -> v2:

- Drop the qcom,load-firmware property.
- Remove the fixed firmware path.
- Add the 'firmware-name' property in the QUP common driver.
- Add logic to read the firmware path from the device tree.
- Resolve kernel test robot warnings.
- Update the 'qcom,xfer-mode' property description.

v1 Link: https://lore.kernel.org/linux-kernel/20241204150326.1470749-1-quic_vdadhani@quicinc.com/ 
---
Viken Dadhaniya (6):
  dt-bindings: qcom: se-common: Add QUP Peripheral-specific properties
    for I2C, SPI, and SERIAL bus
  soc: qcom: geni-se: Cleanup register defines and update copyright
  soc: qcom: geni-se: Add support to load QUP SE Firmware via Linux
    subsystem
  i2c: qcom-geni: Load i2c qup Firmware from linux side
  spi: geni-qcom: Load spi qup Firmware from linux side
  serial: qcom-geni: Load UART qup Firmware from linux side

 .../bindings/i2c/qcom,i2c-geni-qcom.yaml      |   1 +
 .../serial/qcom,serial-geni-qcom.yaml         |   1 +
 .../soc/qcom/qcom,se-common-props.yaml        |  26 +
 .../bindings/spi/qcom,spi-geni-qcom.yaml      |   1 +
 drivers/i2c/busses/i2c-qcom-geni.c            |   8 +-
 drivers/soc/qcom/qcom-geni-se.c               | 493 +++++++++++++++++-
 drivers/spi/spi-geni-qcom.c                   |   6 +
 drivers/tty/serial/qcom_geni_serial.c         |   8 +-
 include/linux/soc/qcom/geni-se.h              |   4 +
 9 files changed, 527 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,se-common-props.yaml

-- 
2.34.1


