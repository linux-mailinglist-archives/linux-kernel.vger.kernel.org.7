Return-Path: <linux-kernel+bounces-858151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F39BE925D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 63287503A59
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 14:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03FB312830;
	Fri, 17 Oct 2025 14:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LAwG8AXR"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C37D2C3244
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 14:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760710631; cv=none; b=NNK3GCIuKTVxZ7GYharrBqsqyT0dM2JeZT9IRafsA8rW72U+ElBcSnjy5OlLHaolUGxq1SAVJy+0Xz4Dn/bEgewMrzBrlFrfVAgoEZmvAyqyZ7kZpDBYpqhIYsvwq7gq4a2WVwNQ74vzl6zMcbwGf3DSMGJDDahZjn2zNS7N+JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760710631; c=relaxed/simple;
	bh=YoFlB/UzPZDir7p40zu8voPPpoGu13rF8TROhfv5SgM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gLN68SofIMqqBF/U4kZaZ4n6PJ9jPT62mbD44S/9yaH6tICtn/uzQZTmRojaN5Suo8BCZRSnS3ZE/CvgjTDsiXZDLUyEpWY+ZYqXhSgV+bbNQuMuDKBSvIaW+1UIEfF4bQMTAHMxLzyLovHfZRvh9mz3f9it+O8h/HJHKzWFsa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LAwG8AXR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59H8mIOa008877
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 14:17:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=XTB5VMB20gUFcaN4WVAni7
	V2xX4pBmtQJ7J3MnmOFgA=; b=LAwG8AXR8xug1r/G0h19KAouHfF6kJ7VtPq1I7
	s8ItK4vZXwAAZnqLwyzu2SoDz/0k87ZE3VsjS23X8NBdLUJjTtgQ7HEyexEYSNKM
	jZE3OHwj88dKmcF9JwC0rDBb+nIflKKFAfsjodoh7rqAF0mTtc3kMWScOqbgYFnz
	nK1XHoUZXFsMXx0GoHQRv9eHKObkCYHOgxhqvZKueKSlzaJOLQan/uZcxqRxDFVW
	K+P+J7fALiwr+Qf2GH0keKFi0pZuELmn3BMc5mIuEnYnU2SEv0po3DFWXHLbWnpT
	HNVJRHyAzxfgsRbSP28zEWoFxHjJ3Gux7NdysBWapGoh9s7g==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49rw1arpdh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 14:17:08 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-781269a9049so3160403b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 07:17:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760710628; x=1761315428;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XTB5VMB20gUFcaN4WVAni7V2xX4pBmtQJ7J3MnmOFgA=;
        b=SAwiUCantrWFXR/nMinsRa9LCsqlYtiLRpDx2Q86y9XcJQKHpcjBPhK176cfrbmrhE
         YL//RgsvAFWgQ4pCbuf49yW69FRL8s837k5Rdjl6qbgDgPyjRMHLTGcQkIQZpLIKTUS6
         b95xOGBFFQyUHKhScL4B5ntGHlmhXkmCv7ALpUX2G+xadUZ2zGLbJBKrYsoEsUAThyIt
         RXnfRFdVW0S+oueVHSbtabxwOCTIj2SGvPB7kLtAOurIR4k7uONvO+wXYgrV5XITJxIq
         1yJgrBFljkXr+Q4aorfbxvaVf06RxZdmGfiPYfgf5gtdcwMx2wFdFBPOMoozD7a4XYLz
         sdOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfIpCiTrBHxRLNh05LdA1vTRw84mIeriNySGwBo4asmPX9C+OvuGDRR3E6HVreOMHeBe8FwnkAgKPhOYk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza3vvq5RcW9XL2zZIaWdqvIPWI7BSpDh78d++Ap0JifP25OBa3
	KDGd7HkXoHFsJa6G7c2wuLalJ2i0cn7O5oTMWgelQv3ocibMbnB9cs9OvusOBCckouHhmVHxHXu
	p8PjEU/xUgtaWZcpusPpQDlKwAdGiKmBz0SCCyR4API6eotXHej3wmx33i44ZK06rRhA=
X-Gm-Gg: ASbGncvaMZwpfiSaXg1yFJRwsgTOO5KtW5+yZHXkjY/7I8qM95R2q3m/Jk7sOHib2Io
	F6jf1moHhfJRzOqbGX3tJrl/DqyIuWpGrM3UPCuVav2yO9Wje8Nv27jSfM/IHQ53wmzOzg/wxfz
	OKWLkZKhUAcrNbKGmxvd/uOLE662LTtOR6ioC53CyYcFJwMAdNNzS57DhYVJytfJkEVgqYnXKZq
	D9oBl5B7hSOnsyCJtIFgF84/WWJNMXlXF9dy82OYcC3BYCr4Fnn8W8Y6++JX5t3PGF1VmX7DdRx
	Bh2A5HFn9mwMojzvebTkWZC+Nm1PK8WGJ+cZx0VLKrMT+gZ/83gBrHclFG9oQm89G8/WGFyWKvM
	/kDXWoju9G/fbjwv0cJINz94SBopSxx5Gwg==
X-Received: by 2002:a05:6a21:32a3:b0:2b5:9c2:c596 with SMTP id adf61e73a8af0-334a84854dbmr5573700637.6.1760710627378;
        Fri, 17 Oct 2025 07:17:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxq14j5h0e9btV3c6i7sSVOnPC3iEeMMtP0w7v5b5dmZiJB/BjC4REi9Kb5L0fnw8OgSxpSQ==
X-Received: by 2002:a05:6a21:32a3:b0:2b5:9c2:c596 with SMTP id adf61e73a8af0-334a84854dbmr5573638637.6.1760710626727;
        Fri, 17 Oct 2025 07:17:06 -0700 (PDT)
Received: from hu-vgarodia-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d0966d7sm25895826b3a.40.2025.10.17.07.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 07:17:05 -0700 (PDT)
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Subject: [PATCH v2 0/8] media: iris: add support for video codecs on Qcom
 kaanapali platform
Date: Fri, 17 Oct 2025 19:46:21 +0530
Message-Id: <20251017-knp_video-v2-0-f568ce1a4be3@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALVP8mgC/02MwQrCMBBEf6Xs2ZQ0TSl68j+kSJps7aJtalaDU
 vLvxoLgYQbeMLwVGAMhw6FYIWAkJj9nULsC7GjmCwpymUFJ1ci90uI6L+dIDr0wZtBWyx5b3UL
 +LwEHem2uU5d5JH748N7UsfquP0vzZ4mVkAJrVVvZ51h39Mzl/Wlu1k9TmQu6lNIH2cv5GakAA
 AA=
X-Change-ID: 20250924-knp_video-aaf4c40be747
To: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vishnu Reddy <quic_bvisredd@quicinc.com>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760710621; l=15427;
 i=vikash.garodia@oss.qualcomm.com; s=20241104; h=from:subject:message-id;
 bh=YoFlB/UzPZDir7p40zu8voPPpoGu13rF8TROhfv5SgM=;
 b=m4BCSTe3wWsfRdaPigTkAEsepYvxYerbcgL8vQUxgXx3lkBAiom3xiBSdp87odMNwXSEdqHxx
 d4PBOgMvStxAjB8foDGXnRpS3rv5kqxEbBOOtLi0G+rCop+P8TdVSYx
X-Developer-Key: i=vikash.garodia@oss.qualcomm.com; a=ed25519;
 pk=LY9Eqp4KiHWxzGNKGHbwRFEJOfRCSzG/rxQNmvZvaKE=
X-Authority-Analysis: v=2.4 cv=K88v3iWI c=1 sm=1 tr=0 ts=68f24fe4 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=j8pLvHWEjehsjOGDu-oA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: OQzo2HCwLDFHwUwdcds_ohmwSyGEubwO
X-Proofpoint-ORIG-GUID: OQzo2HCwLDFHwUwdcds_ohmwSyGEubwO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEzMDAzNSBTYWx0ZWRfX06LHsPn2ZpeG
 /oxzDqjtoVSUNUxGU6GgFpzX4YXROAmsi65D/2Mb44s3roKr7OYiFGdg67RMYko8r0ZLV+E8cox
 hiFqKh66a6pTPdZP+/rHBa6DCZl46aB7a6ZDN131mKrIzIh3qDKSEZHkzagDuoXHZFaZf5wBXjS
 SCQPpg8DQo1kIk3HLoc6OTBLc9znmBq6PAgdARNsdJZwLaQiRST4iERy34Afo5QuOXt4crL/IX6
 2db/RRXw2Fi1BlP+O1mdhBn/wOB2+zY/lTz4RkPhsX0EC2X/MzPuKHXxZ9QCq+eFu3D3AFbH4Ne
 cTYdDxhp5pMjtXwZcsn72epRYEHcDsmZm3luqVAgJ5f5lINAkSc6B1rbQJmnPUIzu36U+kAnKPr
 JTeoVj5w3sLE5x0vq1xvOd8C4osWZw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 adultscore=0 clxscore=1015 bulkscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510130035

Qualcomm kaanapali platform have a newer generation of video IP, iris4 
or vpu4. The hardware have evolved mostly w.r.t higher number of power 
domains as well as multiple clock sources. It has support for new 
codec(apv), when compared to prior generation.

The series describes the binding interfaces of the hardware, buffer 
calculation and power sequence for vpu4, and add the platform data at 
the end.

Please review and share your comments.

Following are the compliance and functional validation reports

v4l2-compliance report, for decoder followed by encoder, including 
streaming tests:

v4l2-compliance 1.31.0-5396, 64 bits, 64-bit time_t
v4l2-compliance SHA: 3f22c6fcee75 2025-09-18 09:49:23

Compliance test for iris_driver device /dev/video0:

Driver Info:
        Driver name      : iris_driver
        Card type        : Iris Decoder
        Bus info         : platform:2000000.video-codec
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
        Standard Controls: 10 Private Controls: 0

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
[  328.905995] qcom-iris 2000000.video-codec: invalid plane
[  332.917543] qcom-iris 2000000.video-codec: invalid plane
        test blocking wait: OK

Test input 0:

Streaming ioctls:
        test read/write: OK (Not Supported)
        Video Capture Multiplanar: Captured 21481 buffers
[  350.438406] qcom-iris 2000000.video-codec: invalid plane
[  350.447079] qcom-iris 2000000.video-codec: invalid plane
[  350.458821] qcom-iris 2000000.video-codec: invalid plane
[  350.465860] qcom-iris 2000000.video-codec: invalid plane
        test MMAP (select, REQBUFS): OK
        Video Capture Multiplanar: Captured 21481 buffers
[  363.878157] qcom-iris 2000000.video-codec: invalid plane
[  363.886546] qcom-iris 2000000.video-codec: invalid plane
[  363.898475] qcom-iris 2000000.video-codec: invalid plane
[  363.905527] qcom-iris 2000000.video-codec: invalid plane
        test MMAP (epoll, REQBUFS): OK
        Video Capture Multiplanar: Captured 21481 buffers
[  377.209312] qcom-iris 2000000.video-codec: invalid plane
[  377.218027] qcom-iris 2000000.video-codec: invalid plane
[  377.233635] qcom-iris 2000000.video-codec: invalid plane
[  377.241360] qcom-iris 2000000.video-codec: invalid plane
        test MMAP (select, CREATE_BUFS): OK
        Video Capture Multiplanar: Captured 21481 buffers
[  390.624700] qcom-iris 2000000.video-codec: invalid plane
[  390.633590] qcom-iris 2000000.video-codec: invalid plane
[  390.645629] qcom-iris 2000000.video-codec: invalid plane
[  390.652618] qcom-iris 2000000.video-codec: invalid plane
        test MMAP (epoll, CREATE_BUFS): OK
        test USERPTR (select): OK (Not Supported)
        test DMABUF: Cannot test, specify --expbuf-device

Total for iris_driver device /dev/video0: 54, Succeeded: 54, Failed: 0, 
Warnings: 0

Compliance test for iris_driver device /dev/video1:

Driver Info:
        Driver name      : iris_driver
        Card type        : Iris Encoder
        Bus info         : platform:2000000.video-codec
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
        Detected Stateful Encoder

Required ioctls:
        test VIDIOC_QUERYCAP: OK
        test invalid ioctls: OK

Allow for multiple opens:
        test second /dev/video1 open: OK
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
        Standard Controls: 38 Private Controls: 0

Format ioctls:
        test VIDIOC_ENUM_FMT/FRAMESIZES/FRAMEINTERVALS: OK
        test VIDIOC_G/S_PARM: OK
        test VIDIOC_G_FBUF: OK (Not Supported)
        test VIDIOC_G_FMT: OK
        test VIDIOC_TRY_FMT: OK
        test VIDIOC_S_FMT: OK
        test VIDIOC_G_SLICED_VBI_CAP: OK (Not Supported)
        test Cropping: OK
        test Composing: OK (Not Supported)
        test Scaling: OK (Not Supported)

Codec ioctls:
        test VIDIOC_(TRY_)ENCODER_CMD: OK
        test VIDIOC_G_ENC_INDEX: OK (Not Supported)
        test VIDIOC_(TRY_)DECODER_CMD: OK (Not Supported)

Buffer ioctls:
        test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK
        test CREATE_BUFS maximum buffers: OK
        test VIDIOC_REMOVE_BUFS: OK
        test VIDIOC_EXPBUF: OK
        test Requests: OK (Not Supported)
        test blocking wait: OK

Test input 0:

Streaming ioctls:
        test read/write: OK (Not Supported)
        Video Capture Multiplanar: Captured 61 buffers
        test MMAP (select, REQBUFS): OK
        Video Capture Multiplanar: Captured 61 buffers
        test MMAP (epoll, REQBUFS): OK
        Video Capture Multiplanar: Captured 61 buffers
        test MMAP (select, CREATE_BUFS): OK
        Video Capture Multiplanar: Captured 61 buffers
        test MMAP (epoll, CREATE_BUFS): OK
        test USERPTR (select): OK (Not Supported)
        test DMABUF: Cannot test, specify --expbuf-device

Total for iris_driver device /dev/video1: 54, Succeeded: 54, Failed: 0, 
Warnings: 0

gstreamer test:
Decoders validated with below commands, codec specific:
gst-launch-1.0 multifilesrc location=<input_file.h264> stop-index=0 ! 
parsebin ! v4l2h264dec ! video/x-raw ! videoconvert dither=none ! 
video/x-raw,format=I420 ! filesink location=<output_file.yuv>

gst-launch-1.0 multifilesrc location=<input_file.hevc> stop-index=0 ! 
parsebin ! v4l2h265dec ! video/x-raw ! videoconvert dither=none ! 
video/x-raw,format=I420 ! filesink location=<output_file.yuv>

gst-launch-1.0 filesrc location=<input_file.webm> stop-index=0 ! 
parsebin ! vp9dec ! video/x-raw ! videoconvert dither=none ! 
video/x-raw,format=I420 ! filesink location=<output_file.yuv>

Encoders validated with below commands:
gst-launch-1.0 -v filesrc location=<input_file.yuv> ! rawvideoparse 
format=nv12 width=<width> height=<height> framerate=30/1 ! v4l2h264enc 
capture-io-mode=4 output-io-mode=4 ! filesink sync=true 
location=<output_file.h264>

gst-launch-1.0 -v filesrc location=<input_file.yuv> ! rawvideoparse 
format=nv12 width=<width> height=<height> framerate=30/1 ! v4l2h265enc 
capture-io-mode=4 output-io-mode=4 ! filesink sync=true 
location=<output_file.hevc>

ffmpeg test:
Decoders validated with below commands:
ffmpeg -vcodec h264_v4l2m2m -i <input_file.h264> -pix_fmt nv12 -vsync 0 
output_file.yuv -y
ffmpeg -vcodec hevc_v4l2m2m -i <input_file.hevc> -pix_fmt nv12 -vsync 0 
output_file.yuv -y
ffmpeg -vcodec vp9_v4l2m2m -i <input_file.webm> -pix_fmt nv12 -vsync 0 
output_file.yuv -y

v4l2-ctl test
Decoders validated with below commands:
v4l2-ctl --verbose --set-fmt-video-out=pixelformat=H264 
--set-fmt-video=pixelformat=NV12 --stream-mmap --stream-out-mmap 
--stream-from=<input_file.h264> --stream-to=<output_file.yuv>

v4l2-ctl --verbose --set-fmt-video-out=pixelformat=HEVC 
--set-fmt-video=pixelformat=NV12 --stream-mmap --stream-out-mmap 
--stream-from=input_file.bit --stream-to=<output_file.yuv>

v4l2-ctl --verbose --set-fmt-video-out=pixelformat=VP90 
--set-fmt-video=pixelformat=NV12 --stream-mmap --stream-out-mmap 
--stream-from-hdr=input_file.hdr  --stream-mmap 
--stream-to=<output_file.yuv>

Encoders validated with below commands:
v4l2-ctl --verbose 
--set-fmt-video-out=width=<width>,height=<height>,pixelformat=NV12 
--set-selection-output 
target=crop,top=0,left=0,width=<width>,height=<height> 
--set-fmt-video=pixelformat=H264 --stream-mmap --stream-out-mmap 
--stream-from=<input_file.yuv> --stream-to=<output_file.h264> -d 
/dev/video1
v4l2-ctl --verbose 
--set-fmt-video-out=width=<width>,height=<height>,pixelformat=NV12 
--set-selection-output 
target=crop,top=0,left=0,width=<width>,height=<height> 
--set-fmt-video=pixelformat=HEVC --stream-mmap --stream-out-mmap 
--stream-from=<input_file.yuv> --stream-to=<output_file.hevc> -d 
/dev/video1

Note: there is a crash observed while performing below sequence
rmmod qcom-iris
modprobe qcom-iris
The crash is not seen if ".skip_retention_level = true" is added to 
mmcx and mmcx_ao power domains in rpmhpd.c. This is under debug with 
rpmh module owner to conclude if it to be fixed differently.

Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
---
Changes in v2:
- Dropped dependencies from binding (Dmitry).
- Dropped optional items from binding (Dmitry, Krzysztof, Konrad).
- Updated binding in sorted order and proper alignment (Krzysztof).
- Fixed order of newly introduced kaanapali struct (Dmitry, Bryan)
- Improved readability of buffer size calculation (Bryan)
- Optimized fuse register read (Konrad).
- Fixed order of vpu register defines (Dmitry).
- Addressed few other log and commit related comments (Bryan)
- Link to v1: https://lore.kernel.org/r/20250925-knp_video-v1-0-e323c0b3c0cd@oss.qualcomm.com

---
Vikash Garodia (8):
      media: dt-bindings: qcom-kaanapali-iris: Add kaanapali video codec binding
      media: iris: Add support for multiple clock sources
      media: iris: Add support for multiple TZ content protection(CP) configs
      media: iris: Introduce buffer size calculations for vpu4
      media: iris: Move vpu register defines to common header file
      media: iris: Move vpu35 specific api to common to use for vpu4
      media: iris: Introduce vpu ops for vpu4 with necessary hooks
      media: iris: Add platform data for kaanapali

 .../bindings/media/qcom,kaanapali-iris.yaml        | 231 +++++++++++++
 drivers/media/platform/qcom/iris/Makefile          |   1 +
 drivers/media/platform/qcom/iris/iris_firmware.c   |  23 +-
 .../platform/qcom/iris/iris_platform_common.h      |  12 +-
 .../media/platform/qcom/iris/iris_platform_gen2.c  | 119 ++++++-
 .../platform/qcom/iris/iris_platform_kaanapali.h   |  63 ++++
 .../platform/qcom/iris/iris_platform_sm8250.c      |  21 +-
 drivers/media/platform/qcom/iris/iris_power.c      |   2 +-
 drivers/media/platform/qcom/iris/iris_probe.c      |  24 +-
 drivers/media/platform/qcom/iris/iris_resources.c  |  16 +-
 drivers/media/platform/qcom/iris/iris_resources.h  |   1 +
 drivers/media/platform/qcom/iris/iris_vpu3x.c      | 195 +----------
 drivers/media/platform/qcom/iris/iris_vpu4x.c      | 358 +++++++++++++++++++++
 drivers/media/platform/qcom/iris/iris_vpu_buffer.c | 345 ++++++++++++++++++++
 drivers/media/platform/qcom/iris/iris_vpu_buffer.h |  15 +
 drivers/media/platform/qcom/iris/iris_vpu_common.c | 168 ++++++++--
 drivers/media/platform/qcom/iris/iris_vpu_common.h |   5 +
 .../platform/qcom/iris/iris_vpu_register_defines.h |  32 ++
 18 files changed, 1377 insertions(+), 254 deletions(-)
---
base-commit: f215d17ddbe8502804ae65d8f855100daf347061
change-id: 20250924-knp_video-aaf4c40be747

Best regards,
-- 
Vikash Garodia <vikash.garodia@oss.qualcomm.com>


