Return-Path: <linux-kernel+bounces-839395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1BEFBB18B9
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 21:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A15D31C4194
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 19:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195212ED168;
	Wed,  1 Oct 2025 19:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="a1k1F9Ff"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400FF2D739D
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 19:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759345221; cv=none; b=J4S5ipjnDaMGJpyo8OeJ0gwTuK4EZRq2CuxFqSxGxvymECmszWgzr/IWJoak61g52MMhd9KO9IMnL0eSO/iCcRTho2y9FDVWBQ+T8sKUzOOIrdcY9NFdknUK/NZWpKZvtV+bi4GZNqLHtm3PJCNjkAgV7x1wwG4JPC3gjvz6U/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759345221; c=relaxed/simple;
	bh=RS5ed8qjm2lKOVKgGnRCWgq0cYeLrBMSinDcp3nmLco=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bnFK7rzk5MmtgSMECFN/1tJQGTvCIdjA3Q16zzxrR5S3Ji4MO4fSfhTLXNyXAQiMOfgHZgYkSegijMQLYhikgThSEWy3DeLS0qzsslvZXAEibfvBjbBuytWfcG8aVcIK6HTKqPX2Q+0x3eoq4mauqm33FNRZMHaJ8slcHRFG1aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a1k1F9Ff; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 591IbtRD023326
	for <linux-kernel@vger.kernel.org>; Wed, 1 Oct 2025 19:00:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=m9fiJTsLGyiW5lPi0xsymQ
	BVVOwmrLFVbUuOdy6oKLk=; b=a1k1F9FfwtzToTXoIXztq90PlNBFdPX6uW9PPp
	hLgGERMP8Vp39D5jMQ006XIBqJqnHGVSSmUYgI3R+DWHD7hkaK3nnD90s9CF/Xoe
	3NUR9b9QN36E9HIA9P+nVs4lFp6pWu0egcrVy2Fj7Ex9DsXAFfajDviq5fGxCZ8B
	sBRX1UYHppkQuYZuBBigvuj8dvTBAV0UZgWcN/MOTOcaDP5DxOdorNxjZbymIx1r
	DOmuq/Wyz4caNyLlY7Byz5ASr6tKb2mpbcy6vEosklkgcQnhWmg/ZTGLra9m8n2i
	40NRoZzfDhOpagxNE+NiCo6jlgx5XqxQdXbpPa6TOM17vgHg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e8a65n4h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 19:00:17 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-335279648e3so45452a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 12:00:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759345211; x=1759950011;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m9fiJTsLGyiW5lPi0xsymQBVVOwmrLFVbUuOdy6oKLk=;
        b=mbCsCsjnNTiawm6wCa4uEuoWEuI1PhKzYxSiKI8tVxCZdBxyQkoicFDO0VEC7ieq1R
         gNA8HnvDlrSZ1rhpmAf59V84/L92I1W6U2/37omKpQtgqgPruaOQq9HROMswXqRNb6EZ
         QmdF5iQVyBRxJn+8HnDL2MNFo+dNLF6l+IPkMD7RpmaoRl13g+w26Uy4Wy+9JWTI/uV5
         0C4NZIouoPOk7BvX2xvKt0RV4SIkocg1iGTRO5/XUW4qfrUeahYwHgYMxRXZCH0hUaQC
         CnoH7B9EvNJ+8c2hpQ30xc2pMPAAqHKlK8jsE1iunj3FDy2gJOY0VxeEDJEVz5LixNpq
         pEpA==
X-Forwarded-Encrypted: i=1; AJvYcCXEcnFU5ZZyejJoBnHU8/a1okAfnYu3Qmb8Epxe5V/1wSjiN3GeNb/C3HiGZM4pTRrgsmNfpUmblznyfYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYgR1I0jZ3lQdvM8kRmMdS139hq4Y0o6oBwnPUCcTwnzRAqJ5U
	aeSCjQ2tkc0PvsTOSGZCj9lZI1zWTQh3WVUFq5VdPRSfvOo8mAkTdoiHMsWJ8l6bLsgl+RLyCPR
	D9V3clRSsnok1ohrmkmWbNrupqj2FNhHNQBWn/VU1YHdFNXA0e3FWIn58JWHmxGuYqnA=
X-Gm-Gg: ASbGncuaDHLF0/zCFDHK10Q+a3A6Kuwd8owvwi5M9VgM+zhSib8g+/N/h19B3APj6to
	IW1luYphed2686tu07oV0kW3uW67hSpghVV7uSD+Rwzkw6YQoxTVxxqujjC1a2chLyElwxCiZsT
	jtTBlByu7adWBf+0iVP+Xcb/0F+3cEcmKQZNL1xAQ0KiOP02W+zQqS2CZJjTogDyXS0VJPiptTV
	SwKQ2qG0JjCUOASfA7q9UR8a0VEkKbB1+kUINBVNpaP8DVEiWfwf4Q6NOL3YBJUJhpbAZKtbfgN
	63Y3AWYI60zL/25GpM7oXwJXrUrWdK8iQjT7uz8aVoGjWs3d+ijR1qDyQd1AL5u0whWoR3Dffap
	pTeWDUshzHtsIuxVdLI0x6i9DOWejZA==
X-Received: by 2002:a17:90b:1646:b0:330:b952:1069 with SMTP id 98e67ed59e1d1-339a6f722b6mr2759545a91.6.1759345210971;
        Wed, 01 Oct 2025 12:00:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCqkL9KDfpJQSh9IS4wHjts8w1ogz5k0Hc+iJzM0POFonOPpMeJ4D9eITP2/4iu6juWinqKw==
X-Received: by 2002:a17:90b:1646:b0:330:b952:1069 with SMTP id 98e67ed59e1d1-339a6f722b6mr2759514a91.6.1759345210133;
        Wed, 01 Oct 2025 12:00:10 -0700 (PDT)
Received: from gu-dmadival-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339a701cbffsm2950074a91.21.2025.10.01.12.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 12:00:09 -0700 (PDT)
From: Deepa Guthyappa Madivalara <deepa.madivalara@oss.qualcomm.com>
Subject: [PATCH 0/5] Enable support for AV1 stateful decoder
Date: Wed, 01 Oct 2025 12:00:03 -0700
Message-Id: <20251001-av1_irisdecoder-v1-0-9fb08f3b96a0@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADN63WgC/x3MQQqAIBBA0avErBOcyoquEhGiY81GY4QIpLsnL
 d/i/wKZhCnD0hQQujlzihXYNuBOGw9S7Kuh051BrVHZG3cWzp5c8iRqHkbXY5i0NQi1uoQCP/9
 x3d73A8jQ2cthAAAA
X-Change-ID: 20251001-av1_irisdecoder-846c31f70a51
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Deepa Guthyappa Madivalara <deepa.madivalara@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759345209; l=7741;
 i=deepa.madivalara@oss.qualcomm.com; s=20250814; h=from:subject:message-id;
 bh=RS5ed8qjm2lKOVKgGnRCWgq0cYeLrBMSinDcp3nmLco=;
 b=nuFP/4zTN/YXkzXGniIva6R0KNyIvLTAVfD8F/wxEzayfh5HxbweplpUY7s65soJOkx5ekeks
 +B9D/RFaHfIA2armtyeNJm6jV+4zap3QUyYvuuko1Jeayo5T4+02n2v
X-Developer-Key: i=deepa.madivalara@oss.qualcomm.com; a=ed25519;
 pk=MOEXgyokievn+bgpHdS6Ixh/KQYyS90z2mqIbQ822FQ=
X-Authority-Analysis: v=2.4 cv=RZKdyltv c=1 sm=1 tr=0 ts=68dd7a41 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=e5mUnYsNAAAA:8 a=hQsw8RxEzvAONxDPLg4A:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-GUID: 9g1a6rWo4-ZJnPbGah4qdnTDN9fwkUeP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAzMyBTYWx0ZWRfXykG+a4Qh8TWE
 7xrwHdlSnFXaKPYQ2LmS7M3cdG4HOF/QyraI4E9ipV9vusEycp33QOntsOp4dK2m3O2XROG5Q/e
 vM5ZrIf9dgBFv//3Vo++DnNMQi25fTk5HCxvXFffSKp//Xx+HFgsQ4ah02lSj5/vDohhWl0GchR
 6PNqwBhpTdTZlTSWLW18SObYfvaQJcuAIx2TAkGHwdKsOEmtaijH0R7hHK3OWAcIAUbEY+u73zC
 NEBJkkUkrH8X5wO/hsIVML9Ho+HXdmRg/Cvld6tCkWA04DE0Y5XcV2IfA8/1+nXA1RjVN4lnxbP
 Ind/aqgkDaDQ5odT5VR8e//kmGk6xsw5oUevFTZVPfJaOBHM6RYVkZ3HGnHUz8+XBfY5a+1X9UU
 01eEKJFggSwp1b+RqElN29AQWQlBAg==
X-Proofpoint-ORIG-GUID: 9g1a6rWo4-ZJnPbGah4qdnTDN9fwkUeP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_05,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270033

Hi all,

This patch series adds initial support for the AV1 stateful decoder
codecs in iris decoder. Also it adds support for AV1 stateful decoder
in V4l2. The objective of this work is to extend the Iris decoder's
capabilities to handle AV1 format codec streams, including necessary
format handling and buffer management.

These patches also address the comments and feedback received from the 
RFC patches previously sent. I have made the necessary improvements 
based on the community's suggestions.

Changes since RFC:
- Addressed CRC issues seen during fluster testing which
  are fixed with firmware fix [1] 
- Added Documentation for AV1 stateful uapi [Nicholas]
- Resolved issues reported by static tool analyzers
- RFC:
  https://lore.kernel.org/linux-media/20250902-rfc_split-v1-0-47307a70c061@oss.qualcomm.com/

[1]:
https://lore.kernel.org/linux-firmware/ff27f712-a96e-4fa6-7572-a0091537d8ac@oss.qualcomm.com/

These patches are tested on SM8550 for AV1 decoder while
ensuring other codecs are not affected.

Gstreamer testing: 
Gstreamer MR for enabling AV1 stateful decoder:
https://gitlab.freedesktop.org/dmadival/gstreamer/-/merge_requests/1

Fluster testing:
Test suite: AV1-TEST-VECTORS 
The result of fluster test on SM8550:
135/242 testcases passed while testing AV1-TEST-VECTORS with
GStreamer-AV1-V4L2-Gst1.0

failing tests:
unsupported content with bitdepth 10 (66 tests)
Iris decoder supports only 8bit NV12
av1-1-b10-00-quantizer-*          

Unsupported resolution (36 tests).
Iris hardware decoder supports min resolution of 96x96
av1-1-b8-01-size-*

Unsupported colorformat (1 test)
av1-1-b8-24-monochrome

Unsupported SVC tests (2tests)
av1-1-b8-22-svc-L2T1                     
av1-1-b8-22-svc-L2T2  

Bitstream corruption issue: (2tests)
av1-1-b8-03-sizeup                       
av1-1-b8-03-sizedown

Testsuite: CHROMIUM-8bit-AV1-TEST-VECTORS
13/13 testcases passed while testing CHROMIUM-8bit-AV1-TEST-VECTORS with
GStreamer-AV1-V4L2-Gst1.0

Following the RFC feedback, focused on only IVF/MKV content
as AV1 parser lacks support for below content
AV1-ARGON-PROFILE0-CORE-ANNEX-B
AV1-ARGON-PROFILE0-NON-ANNEX-B
AV1-ARGON-PROFILE0-NON-ANNEX-B

Unsupported test suites:
Iris Decoder supports only PROFILE0/V4L2_MPEG_VIDEO_AV1_PROFILE_MAIN
and 8 bit, 420 only
AV1-ARGON-PROFILE1-CORE-ANNEX-B
AV1-ARGON-PROFILE1-NON-ANNEX-B
AV1-ARGON-PROFILE1-STRESS-ANNEX-B
AV1-ARGON-PROFILE2-CORE-ANNEX-B
AV1-ARGON-PROFILE2-NON-ANNEX-B
AV1-ARGON-PROFILE2-STRESS-ANNEX-B
CHROMIUM-10bit-AV1-TEST-VECTORS

Compliance test for iris_driver device /dev/video0:

Driver Info:
        Driver name      : iris_driver
        Card type        : Iris Decoder
        Bus info         : platform:aa00000.video-codec
        Driver version   : 6.17.0
        Capabilities     : 0x84204000
                Video Memory-to-Memory Multiplanar
                Streaming
                Extended Pix Format
                Device Capabilities
        Device Caps      : 0x04204000
                Video Memory-to-Memory Multiplanar
                Streaming
                Extended Pix Format
        Detected Stateful Decoder

Required ioctls:
        test VIDIOC_QUERYCAP: OK
        test invalid ioctls: OK

Allow for multiple opens:
        test second /dev/video0 open: OK
        test VIDIOC_QUERYCAP: OK
        test VIDIOC_G/S_PRIORITY: OK
        test for unlimited opens: OK

Debug ioctls:
        test VIDIOC_DBG_G/S_REGISTER: OK (Not Supported)
        test VIDIOC_LOG_STATUS: OK (Not Supported)

Input ioctls:
        test VIDIOC_G/S_TUNER/ENUM_FREQ_BANDS: OK (Not Supported)
        test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
        test VIDIOC_S_HW_FREQ_SEEK: OK (Not Supported)
        test VIDIOC_ENUMAUDIO: OK (Not Supported)
        test VIDIOC_G/S/ENUMINPUT: OK (Not Supported)
        test VIDIOC_G/S_AUDIO: OK (Not Supported)
        Inputs: 0 Audio Inputs: 0 Tuners: 0

Output ioctls:
        test VIDIOC_G/S_MODULATOR: OK (Not Supported)
        test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
        test VIDIOC_ENUMAUDOUT: OK (Not Supported)
        test VIDIOC_G/S/ENUMOUTPUT: OK (Not Supported)
        test VIDIOC_G/S_AUDOUT: OK (Not Supported)
        Outputs: 0 Audio Outputs: 0 Modulators: 0

Input/Output configuration ioctls:
        test VIDIOC_ENUM/G/S/QUERY_STD: OK (Not Supported)
        test VIDIOC_ENUM/G/S/QUERY_DV_TIMINGS: OK (Not Supported)
        test VIDIOC_DV_TIMINGS_CAP: OK (Not Supported)
        test VIDIOC_G/S_EDID: OK (Not Supported)

Control ioctls:
        test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: OK
        test VIDIOC_QUERYCTRL: OK
        test VIDIOC_G/S_CTRL: OK
        test VIDIOC_G/S/TRY_EXT_CTRLS: OK
        test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEVENT: OK
        test VIDIOC_G/S_JPEGCOMP: OK (Not Supported)
        Standard Controls: 12 Private Controls: 0

Format ioctls:
        test VIDIOC_ENUM_FMT/FRAMESIZES/FRAMEINTERVALS: OK
        test VIDIOC_G/S_PARM: OK (Not Supported)
        test VIDIOC_G_FBUF: OK (Not Supported)
        test VIDIOC_G_FMT: OK
        test VIDIOC_TRY_FMT: OK
        test VIDIOC_S_FMT: OK
        test VIDIOC_G_SLICED_VBI_CAP: OK (Not Supported)
        test Cropping: OK
        test Composing: OK
        test Scaling: OK (Not Supported)

Codec ioctls:
        test VIDIOC_(TRY_)ENCODER_CMD: OK (Not Supported)
        test VIDIOC_G_ENC_INDEX: OK (Not Supported)
        test VIDIOC_(TRY_)DECODER_CMD: OK

Buffer ioctls:
        test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK
        test CREATE_BUFS maximum buffers: OK
        test VIDIOC_REMOVE_BUFS: OK
        test VIDIOC_EXPBUF: OK
        test Requests: OK (Not Supported)
        test blocking wait: OK

Total for iris_driver device /dev/video0: 48, Succeeded: 48, Failed: 0,
Warnings: 0

Thanks,
Deepa

Signed-off-by: Deepa Guthyappa Madivalara <deepa.madivalara@oss.qualcomm.com>
---
Deepa Guthyappa Madivalara (5):
      media: uapi: videodev2: Add support for AV1 stateful decoder
      media: v4l2: Add description for V4L2_PIX_FMT_AV1 in v4l_fill_fmtdesc()
      media: iris: Add support for AV1 format in iris decoder
      media: iris: Define AV1-specific platform capabilities and properties
      media: iris: Add internal buffer calculation for AV1 decoder

 .../userspace-api/media/v4l/pixfmt-compressed.rst  |   8 +
 drivers/media/platform/qcom/iris/iris_buffer.h     |   2 +
 drivers/media/platform/qcom/iris/iris_ctrls.c      |   8 +
 drivers/media/platform/qcom/iris/iris_hfi_common.h |   3 +
 .../platform/qcom/iris/iris_hfi_gen2_command.c     | 110 ++++++++-
 .../platform/qcom/iris/iris_hfi_gen2_defines.h     |  10 +
 .../platform/qcom/iris/iris_hfi_gen2_response.c    |  22 ++
 drivers/media/platform/qcom/iris/iris_instance.h   |   1 +
 .../platform/qcom/iris/iris_platform_common.h      |  15 ++
 .../media/platform/qcom/iris/iris_platform_gen2.c  | 156 ++++++++++++-
 .../platform/qcom/iris/iris_platform_sm8250.c      |  17 ++
 drivers/media/platform/qcom/iris/iris_vdec.c       |  25 +-
 drivers/media/platform/qcom/iris/iris_vidc.c       |   1 +
 drivers/media/platform/qcom/iris/iris_vpu_buffer.c | 255 ++++++++++++++++++++-
 drivers/media/platform/qcom/iris/iris_vpu_buffer.h | 105 +++++++++
 drivers/media/v4l2-core/v4l2-ioctl.c               |   1 +
 include/uapi/linux/videodev2.h                     |   1 +
 17 files changed, 711 insertions(+), 29 deletions(-)
---
base-commit: afb100a5ea7a13d7e6937dcd3b36b19dc6cc9328
change-id: 20251001-av1_irisdecoder-846c31f70a51

Best regards,
-- 
Deepa Guthyappa Madivalara <deepa.madivalara@oss.qualcomm.com>


