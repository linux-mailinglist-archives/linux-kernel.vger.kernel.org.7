Return-Path: <linux-kernel+bounces-884268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A34EC2FC7F
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 09:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F9ED3B4BCE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 08:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E1A3090FB;
	Tue,  4 Nov 2025 08:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y4NetYWH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QBHpdXGt"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974C925F7A9
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 08:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762243924; cv=none; b=O8I/f+Vjl06/qXferQpXZCR5Ed0idHTlrDwroX7/UrdDBNNyJXQJ4qW5BNLju+k2FhjHjJDfidNlmIfHq9ONWMlgs09nMt/t3Eby6zCXSDyFmKebBMo+b4wDfwCBMcSH5rkUun23e7zMMiuOpM3T4rDvNok+LQfcD8kP0rFVQXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762243924; c=relaxed/simple;
	bh=DMNd54NL9igyKhQm2bCvyfpFiguK2RiOcPxcpk9CSK0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PNoGm4zrrFZ0PXonhvbsHtlQK6GAa1syZebxvOyRK6VK7dPg4HzE3eXWHJEwBOzVSpN7D//vqXlLuAIv93yHGCS0pd7CXBPJlwK9jPkXa+2HybrdQewjl/K2EKXhogLu9E0yA1ta5WSdB4XksP0SfeyaV03AxmoE20QoBf1fEHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Y4NetYWH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QBHpdXGt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A43784D3659412
	for <linux-kernel@vger.kernel.org>; Tue, 4 Nov 2025 08:12:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=XrEgKSVOrIRJIvB0Ey+5MX
	aqvtp2K1BacuTldxl2QTU=; b=Y4NetYWH+hekwRZNSQQcZyInZU0GdrlmYyIHWu
	QaZtbS355or/MVILH11vp9xVj9syigjdUYvYrwpmzs2dlnMQIlm34LLP4FgMRQTA
	J9AihQFyS7eo9n/0RjmQpEpX5hsB0MurNf5kIpWpgFQ3cMf7LYzaEswrhFfIq2Jf
	BxTQ34WKYHjeXdIH+pg1SkehFgLoywJ+f58C46pBgQQubO5kNFE+jEDiGNNIUUIy
	evtXAjXsRixbTJio9LFWDO+uDGvkKzd1t6hOnM/BnbRM5F3Ij/99kEsa/f/yUigv
	nS0CZfyfd2ibvVlHNM81ogkW8aMvnwHAS8sj6QYdlc374yjQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a70gea5v4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 08:12:01 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b62da7602a0so4339449a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 00:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762243921; x=1762848721; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XrEgKSVOrIRJIvB0Ey+5MXaqvtp2K1BacuTldxl2QTU=;
        b=QBHpdXGtJm59V1gy03BNtaC7H4pBFPIZfmX+oZObJaQQcOjN4W/kPLuLjF6mtSqNI8
         Bbez/DpjF9v0fjwn0oXLYIzrmi5NmX2JxlRv93fBR8JU9ff0Y8W31/UOXGla1di3prPG
         ULZAU7gW6OVi0/npM589fJFNuhIOzmDmZ2T2TEmz3vlUYtsEoajQPZq1FBH2Jfxjybs4
         tq7as5xlpXswRNzTJRucfR+CS2aP+KZnquidbES6nDQSF3kBZwFo8Xt1c+XQ1uyoyOqJ
         XlzrxnvN/CMNm2+p/PZozpCM6A4gPSog4Y9aEJ37vmEEqhvk0hDekrnl6yM7QK9qgcz/
         cyVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762243921; x=1762848721;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XrEgKSVOrIRJIvB0Ey+5MXaqvtp2K1BacuTldxl2QTU=;
        b=kRpLmm10p46DcDcXGzlxhBELqf2WbxqcxmdK1hBCXqZXblbKF7ymTOV4uyPnzVl3W1
         pZnlVvWyC5xYBqBevyjlYl0jaG9XJC3IlqJbJJLyos0iMfJJ2wLTYNAbmq4WmKXnv37Y
         bX76wE3THk88AXiiRE0YRGVPOeyXZapKrFTRIH/eiY29nuAIJktBoE6ocH4twSxmVbGr
         JTTynsX2dzzlI5QaTxkyI4oyr4cf7jTM/5TxAxmcdGqiqJoWu/IWmu13J2z5vBUAwE9V
         S9uo1lgIZgnGham0cZnMnsPEiA0s5Y+fHYKnFS1xyvw7dqbK7KpH6ev5AYdWko4rickV
         wD9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUZdCGJNR0yCDHjQSVE3bT7erVWLkhohhdTeX2cuvj/j1v33BOiymulMcpBk8KWtoSeu2SdkyNL69qn3BI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuWIlrfY+0WerDqtrlx9pVSfTt3OEuMA8b/ZwYphmcWGZP+Viq
	HCyy0aU6FmSFKht1w8n+gOoH7dKFt8T+LA9NtVlpQ9uZrIN66o8ZDmD13xUjElXQGswFoumpC0O
	Or1w6c+RJdBlzV+4Nu2lTHlgGpGkI22lMzvf4cq/GUdnck54P9JquOQ1zWhl07evzgbE=
X-Gm-Gg: ASbGnctoZgy705A/yyf9XSS5l+Tc9/0RBTpcr4IMMu0rv00MDwOMDN9Th8KKyMzwajN
	PUjyfV6lQzhYH/3DYMP6DDqvcyvE6YItOe6ZubB2a6puN9DT+Ll9l1sYqHtIxvaLXizNDbXSz0f
	a4EWLcJ+RYh4LPi+3hOcKr040rFGY7V1N2Olq4Oia1/3AeFaejWl1c583wu8j2f3G6Z6X2a9P6I
	tYhoHzcU46xwo0ZciCKyHTUrgwxCET1FyfyaJbRg3LhCKvU+tPTbG+st3juAug+avNq2x+PJNG4
	tFRNfeSOvtjaIEuv71yfBXMD/HX5r1dYb7Hg4RjAuhVbPQxr4XjGYMBthssa23I0CpLb7rH8c31
	LRv3yRUOu99AKIG/o//FRiay04xL2A7/zKOrE4YL/9DD6fSHSM3D8wWl8r6+AdUcgXcIbaVYa/Q
	==
X-Received: by 2002:a05:6a20:4322:b0:33e:5d06:92d2 with SMTP id adf61e73a8af0-348c9f67250mr21731428637.5.1762243921137;
        Tue, 04 Nov 2025 00:12:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFM8NFfG/MFiCteOZs8UFVDIyx0OgBqgTID3lkEvK8v+2tmm6PMhe3lMsbWlxrdXHKLHI/hAQ==
X-Received: by 2002:a05:6a20:4322:b0:33e:5d06:92d2 with SMTP id adf61e73a8af0-348c9f67250mr21731383637.5.1762243920563;
        Tue, 04 Nov 2025 00:12:00 -0800 (PST)
Received: from WANGAOW-LAB01.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3415a1c2f12sm3601755a91.5.2025.11.04.00.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 00:11:59 -0800 (PST)
From: Wangao Wang <wangao.wang@oss.qualcomm.com>
Subject: [PATCH v3 0/5] media: qcom: iris: encoder feature enhancements
Date: Tue, 04 Nov 2025 16:11:44 +0800
Message-Id: <20251104-iris_encoder_enhancements-v3-0-63b0c431b4d0@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAEC1CWkC/32OzQrCMBCEX6XkbEJ+jDGefA8RaZOtDdhEkxqV0
 nc3LQgexMsOs+x8syNKEB0ktKtGFCG75IIvRqwqZLranwE7WzzilEtGmcIuunQCb4KFWLTcGOj
 BDwm33DK9UQ3XrUYlf43QuufCPhyL71waQnwtVZnN2w9VUs0V3RKhqMAMP0pvHcgs+5ASud3ri
 wl9T8pAMynzr7Rgf37KHFMsmDZWSdM0a/kDOE3TG/3heW0HAQAA
X-Change-ID: 20251017-iris_encoder_enhancements-f2d1967b29f9
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Wangao Wang <wangao.wang@oss.qualcomm.com>,
        Neil Armstrong <neil.armstrong@linaro.org>, quic_qiweil@quicinc.com,
        quic_renjiang@quicinc.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762243916; l=8879;
 i=wangao.wang@oss.qualcomm.com; s=20251021; h=from:subject:message-id;
 bh=DMNd54NL9igyKhQm2bCvyfpFiguK2RiOcPxcpk9CSK0=;
 b=lNzH0pFUBrgGft980oM9oN51RdIbfJLQ+rsfdYPfXrjGBBbYAY1Ys1OtbyEYp9vL6STJ7+OnG
 koY7+04WAaDBvPnYcU1dJD9jfFZ8LA5CwcMyWl4Z00ppXHARJFetNc6
X-Developer-Key: i=wangao.wang@oss.qualcomm.com; a=ed25519;
 pk=bUPgYblBUAsoPyGfssbNR7ZXUSGF8v1VF4FJzSO6/aA=
X-Proofpoint-ORIG-GUID: THyd1GKQsUQX2ckdmE8ckU-hD8K2y_jX
X-Authority-Analysis: v=2.4 cv=bqBBxUai c=1 sm=1 tr=0 ts=6909b552 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=dRbC0bwBXVP-Wn5h6LwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDA2NiBTYWx0ZWRfXxqtemcr4iG2W
 6/aIsVDfsjGsDQwl0vSjavb3tpYixqPnq/XEjIXv3O3E3PYR7uVxu/iXPV+yg+pdNrR+nQInPfw
 Sv7fV8mHrnAzuQhXINwWSHXaaGuAjbgYs/yglcIDg6AjIYoIoLcwoMyhlnMOrcjndMkePH8Y/wB
 D7DFk01CnF/WZhg4cdbE/0x5kk20rFR9ptebnEtcjtYuDfmWLU5akXvZtcfV10SyaWcI4Pp88Rc
 2aDIxvd+X1I7ayXm+sWGyHQc9H3oTP1N2r2aE7oEsnLBGkXTx7fPXptCP6c+9xKJMgNq8PKZsVU
 QRTYT++rHdI3eq6BwPKyNCahsN3O38BJilnaJOocCwtzGuQ3MPmVtes5C9J0lHtDuWsfq711n92
 vwSD/NXNoigzZTDMvPqXLdbrmaL9AA==
X-Proofpoint-GUID: THyd1GKQsUQX2ckdmE8ckU-hD8K2y_jX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_06,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 adultscore=0 bulkscore=0 malwarescore=0
 impostorscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511040066

Hi All,

This patch series introduces several enhancements to the Qualcomm Iris
encoder driver, improving support for V4L2 controls and enabling more
 video encoding features.

All patches have been tested with v4l2-compliance, v4l2-ctl and 
on QCS8300 for encoder.

Commands used for V4l2-ctl validation:

Scale:
v4l2-ctl --verbose -d /dev/video1 \
--set-fmt-video-out=width=1920,height=1080,pixelformat=NV12 \
--set-selection-output target=crop,width=1920,height=1080 \
--set-fmt-video=width=1280,height=720,pixelformat=H264 \
--stream-mmap --stream-out-mmap \
--stream-from=input_nv12_1080p.yuv \
--stream-to=output/scale_720p_output.h264

Flip:
v4l2-ctl --verbose -d /dev/video1 \
--set-fmt-video-out=width=1920,height=1080,pixelformat=NV12 \
--set-selection-output target=crop,width=1920,height=1080 \
--set-fmt-video=pixelformat=H264 --stream-mmap --stream-out-mmap \
--stream-from=input_nv12_1080p.yuv \
--stream-to=output/vertical_flip.h264 \
--set-ctrl vertical_flip=1

v4l2-ctl --verbose -d /dev/video1 \
--set-fmt-video-out=width=1920,height=1080,pixelformat=NV12 \
--set-selection-output target=crop,width=1920,height=1080 \
--set-fmt-video=pixelformat=H264 --stream-mmap --stream-out-mmap \
--stream-from=input_nv12_1080p.yuv \
--stream-to=output/horizontal_flip.h264 \
--set-ctrl horizontal_flip=1

Rotate: 
v4l2-ctl --verbose -d /dev/video1 \
--set-fmt-video-out=width=1920,height=1080,pixelformat=NV12 \
--set-selection-output target=crop,width=1920,height=1080 \
--set-fmt-video=pixelformat=H264 --stream-mmap --stream-out-mmap \
--stream-from=input_nv12_1080p.yuv \
--stream-to=output/rotate90.h264 \
--set-ctrl rotate=90

v4l2-ctl --verbose -d /dev/video1 \
--set-fmt-video-out=width=1920,height=1080,pixelformat=NV12 \
--set-selection-output target=crop,width=1920,height=1080 \
--set-fmt-video=pixelformat=H264 --stream-mmap --stream-out-mmap \
--stream-from=input_nv12_1080p.yuv \
--stream-to=output/rotate180.h264 \
--set-ctrl rotate=180

v4l2-ctl --verbose -d /dev/video1 \
--set-fmt-video-out=width=1920,height=1080,pixelformat=NV12 \
--set-selection-output target=crop,width=1920,height=1080 \
--set-fmt-video=pixelformat=H264 --stream-mmap --stream-out-mmap \
--stream-from=input_nv12_1080p.yuv \
--stream-to=output/rotate270.h264 \
--set-ctrl rotate=270

Intra Refresh:
Testing of this feature requires the use of this application.
https://github.com/quic/v4l-video-test-app

The result of v4l2-compliance on QCS8300:
v4l2-compliance 1.31.0-5378, 64 bits, 64-bit time_t
v4l2-compliance SHA: 2ed8da243dd1 2025-06-30 08:18:40

Compliance test for iris_driver device /dev/video1:

Driver Info:
        Driver name      : iris_driver
        Card type        : Iris Encoder
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
        Standard Controls: 43 Private Controls: 0

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

Total for iris_driver device /dev/video1: 54, Succeeded: 54, Failed: 0, Warnings: 0

Signed-off-by: Wangao Wang <wangao.wang@oss.qualcomm.com>
---
Changes in v3:
- Restore crop offset support for the input port.(Dikshita)
- Set the output port's left and top offset directly to 0.(Dikshita)
- fix the issue in iris_vpu_enc_line_size.(Neil Armstrong)
- Link to v2: https://lore.kernel.org/r/20251031-iris_encoder_enhancements-v2-0-319cd75cbb45@oss.qualcomm.com

Changes in v2:
- Split ‘improve alignment’ and ‘enable scale’ into two patches.(bod)
- HFI_PROP_RAW_RESOLUTION uses the actual YUV
  resolution.(Vikash,Dikshita)
- Rename enc_bitstream_* to enc_scale_*.(Dikshita)
- Add comment for scale case.(Dikshita)
- Make the resolution assignment into an inline function.(bod)
- Shorten the long chain that checks whether scaling is enabled.(bod)
- Correct the handling of rotation in crop offsets.(Dikshita)
- Move VPSS buffer things into scale patch.(Dikshita)
- Link to v1: https://lore.kernel.org/r/20251015092708.3703-1-wangao.wang@oss.qualcomm.com

---
Wangao Wang (5):
      media: qcom: iris: Improve format alignment for encoder
      media: qcom: iris: Add scale support for encoder
      media: qcom: iris: Add rotation support for encoder
      media: qcom: iris: Add flip support for encoder
      media: qcom: iris: Add intra refresh support for encoder

 drivers/media/platform/qcom/iris/iris_ctrls.c      | 94 ++++++++++++++++++++++
 drivers/media/platform/qcom/iris/iris_ctrls.h      |  3 +
 .../platform/qcom/iris/iris_hfi_gen2_command.c     | 56 ++++++++++---
 .../platform/qcom/iris/iris_hfi_gen2_defines.h     | 19 +++++
 .../platform/qcom/iris/iris_hfi_gen2_response.c    |  2 +
 drivers/media/platform/qcom/iris/iris_instance.h   |  8 ++
 .../platform/qcom/iris/iris_platform_common.h      |  5 ++
 .../media/platform/qcom/iris/iris_platform_gen2.c  | 63 +++++++++++++++
 drivers/media/platform/qcom/iris/iris_utils.c      |  6 ++
 drivers/media/platform/qcom/iris/iris_utils.h      |  1 +
 drivers/media/platform/qcom/iris/iris_venc.c       | 33 +++++++-
 drivers/media/platform/qcom/iris/iris_vpu_buffer.c | 60 ++++++++------
 12 files changed, 310 insertions(+), 40 deletions(-)
---
base-commit: 13863a59e410cab46d26751941980dc8f088b9b3
change-id: 20251017-iris_encoder_enhancements-f2d1967b29f9

Best regards,
-- 
Wangao Wang <wangao.wang@oss.qualcomm.com>


