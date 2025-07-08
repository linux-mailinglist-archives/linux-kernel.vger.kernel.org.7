Return-Path: <linux-kernel+bounces-722156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4CEBAFD5FE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 20:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 229E058547A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 18:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D1C2E7196;
	Tue,  8 Jul 2025 18:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KbgnFaBA"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F002DECA7
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 18:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751997942; cv=none; b=M/9lIl4MyZKMTlZ/wN6ZKRDBDvp+vyovr6AVtRLoyn7QQG/WhuFXfkiOaQv2vKSurFA1nKngMHJ0Rpu/Edqgqq8ElxeGriApm4wTjfjl7HZIUFdi3pKxVujHmM5/fLhdSjUaushcya8wIKXH3JDyUtPVX0Yx98ZEmhZCf9FGHpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751997942; c=relaxed/simple;
	bh=tds5LsaaDSUggrltydUqjYMaABMi28P7Zl+3fRiNdwA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ardXosicrNqfaYp25iHMEM1l90Cm02igsBh7Dhhsr9PO0QcUSUIM7a3sJeqxpPd59OgVFKGQ1HU+UUpMz8KsE0foQfHoGoQySCqRAWOPjiYndxl1HlANLkZX+F/IxCtMxycUXo6LIZrbOq03eIf5fy9h0rHYH+ut9MKnzAYfS5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KbgnFaBA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568AAZ3R032608
	for <linux-kernel@vger.kernel.org>; Tue, 8 Jul 2025 18:05:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=0kFlWz/lvuupJR82Xv6tSNIvp06Wu+CwMux
	CYhz5pmQ=; b=KbgnFaBAn3B0DcdcQjNLf1ZZZOwQn6xVQ1Myga3+1kuzwrGCzY4
	+lw/fSsXVSM2U8OJSPqWZBWiFja87PQrVwFLa0bPOnhi4KSLPrVeFOFGH+Ojyube
	yPQg0HZehNP+DU/RGsWJuLk7i55DWdju3M1ZHfLFiU5WglrGLN837gSL2kh4VL60
	aQvjTkg+w9H1621XbAfMSPe+OaRQpT/9iw0YyHqLU+XOTyWWkSm9lzEfP3mpy2Ps
	vpaE/hqPJBD//SskUzDSwT26+YVX1wSmHB0UCTZvDer9nxsZ1g/T2q8GmLlmvJni
	snl2h7MbbEcDYQ9mdIK2z2SxVmgBDf6Xj1g==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47rfq338t4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 18:05:38 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4a9764b4dc9so104983801cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 11:05:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751997937; x=1752602737;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0kFlWz/lvuupJR82Xv6tSNIvp06Wu+CwMuxCYhz5pmQ=;
        b=Mon2+CkUHxioPAfCueeDBeB7egFSTzBBj+M2eEjYllKOJykemtk0In910ZgW7WVeKe
         Ny3GqoCgfHLdJQG0AbBFJLIm8XYQW5X5+dtjzkm4O09CHlyfM8UAq6KfIhiA25pM8CQZ
         tNoXx6lduaMKBghNrQ5vgFogcRvOKqvpF7NBbBF3AaKdJdCjLkvHMqphWIVpSShcXZVv
         URCTBxlhTKWwcyxBV8ur4ibt68HjWX0Lm7QCpCuiOJ6Gf33hCRpo65dnVexblJkO7iH/
         yFh+syRNa44pPWo6KxhYVsnuspFk7WG3K8XARR1o2QK29P64Jfl+/e9FWtJtguJuUdoK
         racw==
X-Forwarded-Encrypted: i=1; AJvYcCW5ij/kY7rvqBCzAjs9GuRx153l4gg7PGozjy6xYcuB0+IkzQExV7kAcGFNkOOZz/5Di/6HFShApcacAis=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm2YrO/F8oP4h154Ca55wfmX4ZvqP0GV7t4xE4aju8dUeUJ8Md
	+PvylMZAw45EV+h2d417ybWsGk2TE+aXzt5LQ/29/0csGKtLy58A7AWQStbF6Dg11zfwC+y+hFC
	C660AG/K0evff9ukaAbwvdZWwtzeLLFpomcpkMbo07exF8txmXxtREAVE6FobmKlY/HA=
X-Gm-Gg: ASbGncvJ0sjSSX6Q1ye4mWU8R1lO5F6RX6L9Hw8Vg9JZDlaJLHVlbWyA2Y9fFMO79JV
	ENm5/2r5YKNohOgHw4sjvDW/IDZ/w3zfZfUulwbaVUqJUEWc4edAYHBNAUFBt0Q5W6/llpNZj7Q
	0UhYcltO4sD8z+uxA8ZRx++d5A0Y2RpaTAL5Gxt3cXbfacQbAdN59RrClfMeucZE1xUu9AeZBhO
	KrwumTgPRUyvU6tQr0OQwDeeAIsTFsWMSMJRxWAQ92Rir/SYd3c0rGnMdKz8Ot1r8UaaI66lLxy
	uMihQ1BHVtmR1kEYQEVG8ugpGdDPqGfzDD/di0tr/LJgaAZEbZStZOG24JkiAlJUW/f4IIJifg=
	=
X-Received: by 2002:ac8:5854:0:b0:4a9:d991:39d3 with SMTP id d75a77b69052e-4a9d99141a5mr27367861cf.40.1751997937047;
        Tue, 08 Jul 2025 11:05:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHM1X6sIWiVXjQn57KJe/n697INGTH/46HXfaEWPxjZZaslLe/zCK35JXyssJkLnNO8DT7ppw==
X-Received: by 2002:ac8:5854:0:b0:4a9:d991:39d3 with SMTP id d75a77b69052e-4a9d99141a5mr27367011cf.40.1751997936338;
        Tue, 08 Jul 2025 11:05:36 -0700 (PDT)
Received: from trex.. (97.red-79-144-186.dynamicip.rima-tde.net. [79.144.186.97])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b4708d0a5csm13394906f8f.29.2025.07.08.11.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 11:05:35 -0700 (PDT)
From: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
To: jorge.ramirez@oss.qualcomm.com, bryan.odonoghue@linaro.org,
        quic_vgarodia@quicinc.com, quic_dikshita@quicinc.com,
        krzk+dt@kernel.org, konradybcio@kernel.org, mchehab@kernel.org,
        robh@kernel.org, conor+dt@kernel.org, andersson@kernel.org,
        amit.kucheria@oss.qualcomm.com
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/7] media: venus: Add QCM2290 support with AR50_LITE core
Date: Tue,  8 Jul 2025 20:05:23 +0200
Message-Id: <20250708180530.1384330-1-jorge.ramirez@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDE1MSBTYWx0ZWRfXwCNMngcAom8x
 Gf3EZq66Xv5GPH8q/g9Y+kUfHXW3qs6HfyqawIVUWd1r+NNG8GNc/HfsKx1rBv8ABFwAEM75t4l
 5a4n34omSpdLrSIklL4hPD9RESMMGKCRXIojz+yDEQMPPmECDYJUXRTImDdSIwG+F8pi2yP8ASt
 Ecu+ISHrBNk/W7/iFXEGqsKm9rmNUh24UMW5ciIgnlREQtW/Ol3CHiXpbxXGpP/XlXstChI5Jty
 7CJH+aouuL67lZARxIes4YHYVTzxMN6sz0aQn9B4IJCjTaSnYx0MjSqiKfaKpKulQXqEKajjOpJ
 BunJTgVaIxlpJTzG4NVQ4E50HGJhYegtM+/NRDpmSib0OHitDJ0MrsJlTInku3Hsgjoo1Pof973
 TD4aoDS+0PTwVWOORHqL9yfY4omId8J8O6jF/0NR+QIX0x8odjLgzpXi5ugy+cM8X1O0rGT8
X-Proofpoint-ORIG-GUID: sBSOOdX9ioFoBxAVEsfcA5DblxhJ3LYs
X-Proofpoint-GUID: sBSOOdX9ioFoBxAVEsfcA5DblxhJ3LYs
X-Authority-Analysis: v=2.4 cv=SOBCVPvH c=1 sm=1 tr=0 ts=686d5df2 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=oX6B8lV6/A+qF9mARCc04Q==:17
 a=Wb1JkmetP80A:10 a=vaIsIKZIAAAA:8 a=7ZroTbgFCKi4LJLxcLoA:9
 a=a_PwQJl-kcHnX1M80qC6:22 a=rh-XPM1-DYv4t-UOgbwD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_05,2025-07-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 malwarescore=0 bulkscore=0 priorityscore=1501
 adultscore=0 mlxlogscore=999 spamscore=0 impostorscore=0 phishscore=0
 mlxscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507080151

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
  -  Encoding is not supported in firmware version before 6.0.54

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
 drivers/media/platform/qcom/venus/core.c      | 135 +++++++++++---
 drivers/media/platform/qcom/venus/core.h      |  15 ++
 drivers/media/platform/qcom/venus/firmware.c  |   6 +-
 drivers/media/platform/qcom/venus/helpers.c   |  87 ++++++++-
 drivers/media/platform/qcom/venus/helpers.h   |   2 +
 .../media/platform/qcom/venus/hfi_parser.c    |   5 +-
 .../media/platform/qcom/venus/hfi_platform.c  |  20 +-
 .../media/platform/qcom/venus/hfi_platform.h  |  25 +--
 .../platform/qcom/venus/hfi_platform_v4.c     | 174 ++++++++++++++++--
 .../platform/qcom/venus/hfi_platform_v6.c     |  32 +++-
 drivers/media/platform/qcom/venus/hfi_venus.c |  16 +-
 .../media/platform/qcom/venus/pm_helpers.c    |   2 +-
 drivers/media/platform/qcom/venus/vdec.c      |  16 +-
 16 files changed, 621 insertions(+), 100 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/media/qcom,qcm2290-venus.yaml

-- 
2.34.1


