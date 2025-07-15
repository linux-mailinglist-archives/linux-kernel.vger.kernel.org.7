Return-Path: <linux-kernel+bounces-732512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65EE3B067EF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 22:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A0B07B2883
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 20:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3704D27AC2A;
	Tue, 15 Jul 2025 20:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CUCdeHRG"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AE026C396
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 20:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752612481; cv=none; b=hYothrzGrof1K7QYtnBdHWVD2wOnMdZF9N5b8SCg4xKgkE6+yNvp9FhFUR+1BL4NTIezjt7AjY2mjsL+nN3fSggHFq9wdTNLgjQz/GAu8+lCVTaDxYdJaZnEl5a3vMhyD9eVPiPrwFmmsOJHXKguCJDPCkhs+ZZALRXQKOdm9Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752612481; c=relaxed/simple;
	bh=N1HL9C7L/kLT8v4qKMHS4LHGfzF1ugW1J7xuqtAvISs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oKu+IDk4+vo7U9nn9yNeIdUaXLNrB2+G0ycUgHuqQ9b2UqZYcPw/OlP8dKBzbHGbYIe0ekVUSBBt4yVOagySNKd6iPJZDwDOwJJJgRCFeLgH9fSY0Ms7FVnHiwR5wM7tBbfBZgf+07wwlVIqZSbMyuO1Q4brdtsHC71IuSB9LR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CUCdeHRG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56FGDK1k017590
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 20:47:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=hFSqKIxyvXb4XbyJ06T+BQ1Hea3SVTQ/nk9
	2PvzuiNE=; b=CUCdeHRGICnmsDNUWJnIPuUWmcELh663dNkjZJcWZ0S7SCHdM+V
	Ptbfe6PIt/oUpB+vvNjibvUbUmkj32W10cpWh1d0DDYAfB59PJXY/qY9adT4pujn
	TCEZtTOfOKjbmazXd7YVfE9W9a2GtD7aIcf/dRkapz2/J7SS/cv1cNkmf3/8BVbF
	Tnkto4Kgl9jCYYneKC9sfSD3QH4V68z8rcfz8lisFTR1fOrkrbsh85WpktmKV+HL
	IcaDlqdDulGej5wDFPbjOYXL1oNA2W/SVAStLr51mhBwZeUsvmXZ6OhXHSg7NRu0
	vlkuhRR8MJ7i1+rLIyFICqDe5kY7c40zXaA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ufu89g31-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 20:47:56 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7e32b9398e4so283904185a.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 13:47:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752612476; x=1753217276;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hFSqKIxyvXb4XbyJ06T+BQ1Hea3SVTQ/nk92PvzuiNE=;
        b=Df/8IdMb9uvnBOoFfoY/UiNnJoZ0XamAaJW/D95fYGP86vv8md5M9sT2yvYjbvh+of
         VIrmyo2n1fMh7fQRmuSWd+BP1O/XpJ6Qc/u6ldFtEjuoVlRYWrfuWIl88iawWCMw53Fy
         4Yg0z04xYKmS0j0Ym+kgaMHt9tjOomOe0dvAdEM8n/HhH2Q/iJMHtvlsRbKRWLpsPwLD
         VIuPMPfg+ZGGyOrQrTXNcqwNDqXKd5apEqGIvM6Oo/BNGMjaWRl5q+xgQZNP2bAOFCFT
         VY3GNbuAvbiRRyvx7r87yrAE1iUIFlvmE/ypOoMxhraa4z1r8WMRlGyam95v/FdQaFr9
         VwKw==
X-Forwarded-Encrypted: i=1; AJvYcCXUR1oSrKUGaua9y8GWhbKiWYoxIfmVH8X1wBQcV1WnsW9sysa+C8wNcxp6ChJfVX/NzX9A/X1DiYudwKw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRbqkWjZ1YdrM+x7f+IGkLDDwngwhxLwkfpKFYYwe71SkaYknO
	7hONly1LnZ97vWIDMCYrPmxr36KyN8CJca4HgeppiJpQIm56JbqZj/rMXwMKb0yzPgpYXz00zcI
	49MRBO4wvJifpSfV4pEasQ/LgN+uAid0G/nn/LAHWGRhTpvpt4vXCw76IOO6wlHNCDMQ=
X-Gm-Gg: ASbGncuK1/sZcK2lbjgRWynbc0V1MNYD9iLbvlS0dljwbcH8AZSZl1lyRju8I6ozxLn
	3c5Wetv1h4d3n6Vgci/JwttFqyBDM2mwFlXgAobWf0njbxb5+Ic08l9FtkxRgaM6cA9igg8OBXQ
	kEluahiGwAlOHcOeaKilcfu+8MiaUCQkmpISNMCk9CJVFYVBOnxpEXvlcp9PQKJng+gDwdB/7bl
	y/oQSjeqMS56E64Yy72f5+iJzRNzds0irYM5lJACQKhW9nkyXToe+3f5IrlAKYfHl1893orTH29
	o8CdWXZWTvaAmOEyz25G+S9+6AET62Ke5K+EPmaiHh5iB3/Uh0e18DCAsvcq902w4PhlBPXf/3L
	t63mR6p2u8woQSp5kFw==
X-Received: by 2002:a05:620a:4008:b0:7e3:4248:ab8f with SMTP id af79cd13be357-7e343350cb0mr47245485a.7.1752612475901;
        Tue, 15 Jul 2025 13:47:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGQlxLOByFsA1tMtdQYZniTPs7Ycj2UVQgk0JgmbT3ZcLd0ulJ5EVp4YeaQ8YnrfVs0mj/Og==
X-Received: by 2002:a05:620a:4008:b0:7e3:4248:ab8f with SMTP id af79cd13be357-7e343350cb0mr47240685a.7.1752612475395;
        Tue, 15 Jul 2025 13:47:55 -0700 (PDT)
Received: from trex.. (153.red-79-144-197.dynamicip.rima-tde.net. [79.144.197.153])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc2464sm16331877f8f.38.2025.07.15.13.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 13:47:54 -0700 (PDT)
From: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
To: jorge.ramirez@oss.qualcomm.com, quic_vgarodia@quicinc.com,
        quic_dikshita@quicinc.com, bryan.odonoghue@linaro.org,
        krzk+dt@kernel.org, konradybcio@kernel.org, mchehab@kernel.org,
        andersson@kernel.org, conor+dt@kernel.org,
        amit.kucheria@oss.qualcomm.com
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 0/7] media: venus: Add QCM2290 support with AR50_LITE core
Date: Tue, 15 Jul 2025 22:47:42 +0200
Message-Id: <20250715204749.2189875-1-jorge.ramirez@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDE5MSBTYWx0ZWRfX1QKs9b27wYwd
 KfEXWSzTWNROtihoWgem6/7KAZNLRqHb6vWBRzofmifF3wTwJ1FMME1iWA5DZpPuh/QdAlaw8Dn
 jpPBJbKA12yuDLulG157NC/hf6JKKUvmTBr6m3wwku3KyORv5P6WsOJnYGFdzPTKv5RTVLpHSoZ
 yOeXpINghGRQ0AEEgkjudIxVwcz65sc3URHeGPjXF2bch+VyK95fWK+qDUgSPO7XIi/vdABqFZm
 28ZrPO1Y8QC2VG7GeOIhntpwAqoSaetcR+TGrZ1+zqDzfERSTzcUySfTyX/S//FxrfV44aPTkAJ
 RSlnwOLORzhwuNbUHXUlb1ie2kVx0ycRBqGREm9gfud9PpQarFwlRSIIjz+UlLd0wWbVNQU9djp
 uXXk5UeDQSBj6HzdJv2rLfuWxhpClkC2bRI5zT8AVg8QtqF2W+ulUI57YTAVpcWUW4JtcpBO
X-Proofpoint-ORIG-GUID: Z8unC9XLHh4En1AOWm0mlNXuRKLGu8r1
X-Proofpoint-GUID: Z8unC9XLHh4En1AOWm0mlNXuRKLGu8r1
X-Authority-Analysis: v=2.4 cv=f59IBPyM c=1 sm=1 tr=0 ts=6876be7c cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=Ki5fnJvzvo7yLsyA0quaxQ==:17
 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=vaIsIKZIAAAA:8
 a=aGt0-UCxYSDcx6FY-O8A:9 a=bTQJ7kPSJx9SKPbeHEYW:22 a=rh-XPM1-DYv4t-UOgbwD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-15_05,2025-07-15_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 spamscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 mlxlogscore=999 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507150191

Changes since v6:
  v6: https://lore.kernel.org/all/20250708180530.1384330-1-jorge.ramirez@oss.qualcomm.com/
- patch 1/7: Add qcm2290 dt schema
  - no change
- patch 2/7: Conditionally register video nodes
  - fixed potential NULL dereference on handling firmware errors when the encoder is not present.
- patch 3/7: Add Support for AR50 LITE video core
  - applied Dikshita Agarwal review comments: do not handle no-tz case, fix WD mask
  - replaced EOS buffers for a work around (firmware should not access the eos buffers)
     renamed venus_helper_alloc_eos_buf to venus_helper_prepare_eos_data
- patch 4/7: HFI platform V4 capabilities
  - removed 10 bit encoder support as per Dikshita Agarwal review
- patch 5/7: Add DT compatible and capabilities
  - removed frequency table as per Konrad Dybcio review (driver now uses opp)
  - fixed bw_tables for the supported loads (remove 10 bit support)
- patch 6/7: Add Venus video node for 2290
  - no change
- patch 7/7: Enable Venus on 2210 RB1 board
  - no change

Changes since v5:
  Two additional new patches added to the set to support video encoding.

- patch 1/7: Add qcm2290 dt schema
  - added reviewed by: Bryan O'Donoghue
  - added reviewed by: Krzysztof Kozlowski
- patch 2/7: Conditionally register video nodes
  - new functionality required to support AR50_LITE
- patch 3/7: Add Support for AR50 LITE video core
  - completely rewritten - lite platforms are extensions of previous HFI_XXX
- patch 4/7: HFI platform V4 capabilities
  - use HFI 4XX instead of HFI 6XX as per review
- patch 5/7: Add DT compatible and capabilities
  - added reviewed by: Bryan O'Donoghue
  - enabled new option min_fw_version
- patch 6/7: Add Venus video node for 2290
  - added reviewed by: Konrad Dybcio
  - removed status property
- patch 7/7: Enable Venus on 2210 RB1 board
  - new

Changes since v4:
- patch 1/5:
  - added reviewed by: Krzysztof Kozlowski
  - updated example section
- patch 2/5:
  - added reviewed by: Bryan O'Donoghue
  - Fixed Co-developed-by order
- patch 3/5:
- patch 4/5:
 - removed encode-node (userspace exposure)
 - fixed Co-developed-by order
- patch 5/5:
 - fixed venus register region
 - power-domain-names: one per line
 - clock-names: one per line
 - fixed interconnect tags
 - empty line before subnode
 - enable the venus node

Changes since v3:
- Fixed schema commit subject.

Changes since v2:
- Removed IS_HFI/IS_VPU macros
- checkpatch.pl --strict fixes:
  - convert macro to static inline to avoid argument reuse side effect

Changes since v1:
- Added IS_HFI macro usage
- Moved schema patch to top
- Fixed commit messages

This patch series adds support for the Venus video decoder/encoder block
present on the Qualcomm QCM2290.

This series functionally depends on the following patch:

  clk: qcom: gcc-qcm2290: Set HW_CTRL_TRIGGER for video GDSC
  https://lore.kernel.org/all/20250613102245.782511-1-loic.poulain@oss.qualcomm.com/

Please ensure the above patch is applied before this series.

The QCM2290 integrates an AR50_LITE core, a low-power implementation of
Venus supporting H.264, HEVC (H.265), and VP9 decoding as well as H.264
and H.265 encoding.

The series includes:
  - DT binding schema for qcom,qcm2290-venus
  - SoC integration via qcm2290.dtsi
  - Resource table definitions and frequency scaling
  - Platform capability registration for the AR50_LITE core decoding block.

Limitations:
  - The hardware does not support concurrent operation at FullHD.
  - Encoding is not supported in firmware version before 6.0.54

Firmware:
  - This code has been tested with 6.0.52, 6.0.53, 6.0.54-PRERELEASE

Some basic Tests:

Decoding and Encoding were verified on the QCOM RB1 platform using
GStreamer with V4L2-based decode plugins.

The following pipelines were used for playback 1280x720 and 1920x1080
H.264, HEVC and VP9 videos from https://www.elecard.com/videos.

Decoding:
[H.264]
gst-launch-1.0 filesrc location=videos/xxxxx.mp4 \
  ! qtdemux name=demux demux.video_0 ! queue ! h264parse ! v4l2h264dec \
  ! videoconvert ! autovideosink

[H.265]
gst-launch-1.0 filesrc location=videos/xxxxx.mp4 \
  ! qtdemux name=demux demux.video_0 ! queue ! h265parse ! v4l2h265dec \
  ! videoconvert ! autovideosink

[VP9]
gst-launch-1.0 filesrc location=videos/xxxxx.webm \
  ! matroskademux ! queue ! v4l2vp9dec \
  ! videoconvert ! autovideosink

Encoding:
[H.264]
gst-launch-1.0 videotestsrc num-buffers=30 \
  ! video/x-raw,width=1280,height=720,framerate=30/1 \
  ! v4l2h264enc ! h264parse ! mp4mux ! filesink location=/tmp/output.mp4

[H.265]
gst-launch-1.0 videotestsrc num-buffers=30 \
  ! video/x-raw,width=1920,height=1080,framerate=30/1 \
  ! v4l2h265enc ! h265parse ! mp4mux ! filesink location=/tmp/output.mp4

Concurrency:
gst-launch-1.0 -v videotestsrc num-buffers=1000 \
  ! video/x-raw,format=NV12,width=1280,height=720,framerate=30/1 \
  ! v4l2h264enc capture-io-mode=4 output-io-mode=2 ! h264parse \
  ! v4l2h264dec capture-io-mode=4 output-io-mode=2 ! videoconvert \
  ! autovideosink

[Fluster]
The H.264 decoder was also tested using the Fluster test suite
(version: v0.4.0-12-g33566abd0964).
 Target: GStreamer-H.264-V4L2-Gst1.0, Test Suite: JVT-AVC_V1
 Result: 126/135 tests passed
 Failures:
 FM1_BT_B, FM1_FT_E, FM2_SVA_C, BA3_SVA_C, SP1_BT_A,
 SP2_BT_B, MR6_BT_B, MR7_BT_B, MR8_BT_B

---

Jorge Ramirez-Ortiz (7):
  media: dt-bindings: venus: Add qcm2290 dt schema
  media: venus: Conditionally register codec nodes based on firmware
    version
  media: venus: Add support for AR50_LITE video core
  media: venus: hfi_plat_v4: Add capabilities for the 4XX lite core
  media: venus: core: Add qcm2290 DT compatible and resource data
  arm64: dts: qcom: qcm2290: Add Venus video node
  arm64: dts: qcom: qrb2210-rb1: Enable Venus

 .../bindings/media/qcom,qcm2290-venus.yaml    | 127 +++++++++++++
 arch/arm64/boot/dts/qcom/qcm2290.dtsi         |  55 ++++++
 arch/arm64/boot/dts/qcom/qrb2210-rb1.dts      |   4 +
 drivers/media/platform/qcom/venus/core.c      | 142 +++++++++++---
 drivers/media/platform/qcom/venus/core.h      |  13 ++
 drivers/media/platform/qcom/venus/firmware.c  |  10 +
 drivers/media/platform/qcom/venus/firmware.h  |   1 +
 drivers/media/platform/qcom/venus/helpers.c   |  30 ++-
 drivers/media/platform/qcom/venus/helpers.h   |   2 +
 .../media/platform/qcom/venus/hfi_parser.c    |   5 +-
 .../media/platform/qcom/venus/hfi_platform.c  |  20 +-
 .../media/platform/qcom/venus/hfi_platform.h  |  25 +--
 .../platform/qcom/venus/hfi_platform_v4.c     | 173 ++++++++++++++++--
 .../platform/qcom/venus/hfi_platform_v6.c     |  32 +++-
 drivers/media/platform/qcom/venus/hfi_venus.c |  25 ++-
 .../media/platform/qcom/venus/hfi_venus_io.h  |   4 +
 .../media/platform/qcom/venus/pm_helpers.c    |   2 +-
 drivers/media/platform/qcom/venus/vdec.c      |   7 +-
 18 files changed, 580 insertions(+), 97 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/media/qcom,qcm2290-venus.yaml

-- 
2.34.1


