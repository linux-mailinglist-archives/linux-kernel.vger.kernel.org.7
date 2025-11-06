Return-Path: <linux-kernel+bounces-887733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F67BC38F85
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 04:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C46D33B4513
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 03:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C552BD582;
	Thu,  6 Nov 2025 03:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B6XH9q2h";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QS0Tf+HZ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69ED51F17E8
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 03:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762399845; cv=none; b=ux355uW3i4A6ZxLn48fnsTbH3b68Qmjpe209pKjb0R4A1IegyvxLDRiMmXXHqcwPIXi+SHaZa7DtxjKAtK5SRJUdzNN4EUfZQLTkbgCsvH8Tg3FBZKpsrFQRcTCRQU0Xmy9k+N4bPSOodQgmCI/DKK4JzyLXT6IVfEi9UB/z1IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762399845; c=relaxed/simple;
	bh=yg4JTol+ei2C5q3v18EFkcCKjoi9LeBHWpW+VRZXQ2g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BnoRLtsdX3HeM0GWoWZ370SSXJma2xTvsH/6nNhUyNBg+lgasD9mPQ3ECcrTqHCYd4wse6obnIrbWfFSP/D37zMLxA9m1CH3G5/6rfbJOxbEmp8UxvNuBJH5Ih8Mfdg0QsrJaMuSW/wdRvk0QPhexZL4TElsfjeu5caAM+t4Fd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B6XH9q2h; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QS0Tf+HZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A5KF1ts1784693
	for <linux-kernel@vger.kernel.org>; Thu, 6 Nov 2025 03:30:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=yilIcvIjUSTUkIEdX5uDX7
	ggq/iHRDnahERicaREIRc=; b=B6XH9q2hVV2h7e5unCYlO6mbLhBjlcEKAO0dbk
	2iZ8w4OteRNdQzKtjk/GUF82IHUh8YBvCf17BT2BjqR9wkhodnnnCFcIpbXMqZeq
	z+zlXsTrkZ20Z/rtbMI4IehYUucW16LEPJYHng4732741e+uSEsKznTeOQSatUp1
	EQeNwnTkjmIUEslj6t+Vu6wh0sZWtKEE8ntJ3S6ijvNSpAuEaosO4+51DREUjROj
	rKZ2TOtJQyw6WicxBHlC1YHCyT4n2LavgnFp7pQyHmq4Rteabkgi8MLYyxLj6ho9
	oAKXJGN/Ui0IMBfFyhts2+yclvC0jLGU99OqXyzrCPKk4MiA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a8amx9m3q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 03:30:42 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2698b5fbe5bso8802485ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 19:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762399841; x=1763004641; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yilIcvIjUSTUkIEdX5uDX7ggq/iHRDnahERicaREIRc=;
        b=QS0Tf+HZkote0PDyH9si4pvWlHLJy8LFc45FD5ba/Pbeiw+ZzL+ZghpBMoMsw/91jq
         mmS3k+gBMDIhn5JF+GLmOlugNhlFCRT6kAlzLkpcFCGxx5IUEJn4eJbuLew1/k1yT9zT
         mhVPtEM2BZsJhCsf5pjpPGsNh2mJQT+Cq4ZhRhjOFI9ukIU8J7/KuIsee/BwqyJSm8I0
         O0z/ZwlelyrvNltG6O2tqNOoST55y0U5q2OxwSIuCh4XtjbKMiOzo/bCaWo9WjrgokdU
         uT8jjKZJil6RxpcbGz1OsJSOVLCMduI+Zy78vU1+lG9mXcYvP4U3en3X0Cgxk6Ur+70j
         wrAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762399841; x=1763004641;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yilIcvIjUSTUkIEdX5uDX7ggq/iHRDnahERicaREIRc=;
        b=N0+EIDCDXpBAm2zCPwT9kPCrL1ZgQyodw/HtGlQ+jqVaM/j9lW6TJQPQ/WTI/GUuiz
         zLh3wL9Rf1ruEndaDxGIa+6Rm05BxSbOwlCMZd3SIgKh8ST6Pkme+0zxz9zVoea8YMPi
         YcrtHD/Z/FUuBFf/A+mouEA+/ITJAHSBfzf9WjAvzNeR5JTKy23e1T2gxkk2Q6H1MfYh
         73dSHObRvINzENVMkjj+49kuTaQ9x89IXDqhxBVYxJ+ziZWfq6W9ES3QHonDOHI0Egm2
         xelJXgeMO1cW9troexE9TFaklYn7Ue4FFy/x+3p62LX4UtNBmibnvX9Tv4uJBB0Zv1m1
         FMUA==
X-Forwarded-Encrypted: i=1; AJvYcCVQ621Zw6I7xgL5/sziedLmJC4e9H7Mtabw7nJ80qiow81uIE+IuNcsRhkzQygnRSEtj3dpmbtV21CgOVE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9TF9RDOAyi6REJjeiBeml9eZjmX0ghfOQwnp3vToKy90pOsch
	n9qAPF36nDfGHoYvSQLH4llmmG3ihwDo21njfNKEEoY5jqhBkq/O0cyX4ICceMLJdkdo9nEhPvh
	yxg4ruHfuMoitbFZzD8tLPGsvRIJhC0E4SaQ2lNoehM0jS58b+UlQ8pspxzqXfqfknCfW85iaiS
	dMdw==
X-Gm-Gg: ASbGncvLhYfZ19RsF9q3ClOWiPGiI7llnPML7l461HVOUwqjpI+sy7jCLeA63BAULjN
	QahaEqKM7yMmnS8xFIssWJM+yt65l158F3EK7Wpap19fWBKJ8+XnYAjbWc7r8ACbRkoD5AOnBp5
	ujJV+aYEkNYmPh5FH0duPXPuvlPVjDl5waGw4J6Zhlk3KL1pT3CirkPIa/xfp+ySFJI1l7SRU7w
	/c9D4fQ/xCXFvMbMWuPM9HYBE8xh+w2iygVYSW1vBe/CHr4RmPP8GykElmEhPZJ7x9fue34lbuj
	rCUKXjj4n4pYudvltT5qKqegugKlfcrOLsDiLa3yd+CCERpBmuUelmP38EMyHUFaqsfb0ceVubV
	ljfO2+HUbF4+ed4FAO6CK7rMp9M9hJDzJBZXENWFie4D/ckPITFJKkdVxEGtGXezBY0MhgYcsqw
	==
X-Received: by 2002:a17:902:ec89:b0:295:7806:1d7b with SMTP id d9443c01a7336-2962ae37b77mr83849785ad.45.1762399841183;
        Wed, 05 Nov 2025 19:30:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGtClnm97yZABJrTaUVjth8CUgqdfKhvQ+se0j4VBVQQ459QBBvE3o6ktOn5znTX2IhovNm5g==
X-Received: by 2002:a17:902:ec89:b0:295:7806:1d7b with SMTP id d9443c01a7336-2962ae37b77mr83849385ad.45.1762399840615;
        Wed, 05 Nov 2025 19:30:40 -0800 (PST)
Received: from WANGAOW-LAB01.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651cd0060sm10361925ad.108.2025.11.05.19.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 19:30:40 -0800 (PST)
From: Wangao Wang <wangao.wang@oss.qualcomm.com>
Subject: [PATCH v4 0/6] media: qcom: iris: encoder feature enhancements
Date: Thu, 06 Nov 2025 11:30:32 +0800
Message-Id: <20251106-iris_encoder_enhancements-v4-0-5d6cff963f1b@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAFgWDGkC/32OwW7CMBBEfwX5jKNd28GYU/+jqqrY3oAlErc2T
 Vuh/Hs3SBUcgMuOZrXzZs+iUklUxW51FoWmVFMe2Zj1SoRDN+5JpsheKFAtAlqZSqrvNIYcqbD
 yTaCBxlOVvYroNtYr1zvB+Y9Cffq5sF/f2B9SPeXye6macNn+U1twysK20Ra0RPnNvV1uFnnJt
 TafX90x5GFoeIiFNKmbtMYnP01KgtToQrRt8N60D4D6CkQwz4CagRvtIRiN3kS4A5zn+Q8rEJj
 RWAEAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762399836; l=9209;
 i=wangao.wang@oss.qualcomm.com; s=20251021; h=from:subject:message-id;
 bh=yg4JTol+ei2C5q3v18EFkcCKjoi9LeBHWpW+VRZXQ2g=;
 b=JBPNAn4aYcFE/oNmjmpTEq44mjGt7/cv118KIIPRUoJjJ6DgiC/gqstaMmswhkUdHwrVyfh23
 Tkr4GU8cCSnC0IuL3u229CmxefTAKXo+LHDF9jYdl1waDjyn1KFnu3C
X-Developer-Key: i=wangao.wang@oss.qualcomm.com; a=ed25519;
 pk=bUPgYblBUAsoPyGfssbNR7ZXUSGF8v1VF4FJzSO6/aA=
X-Proofpoint-GUID: vm_50AnKL2qnQCjQrd28aqdH4A-cdI5o
X-Authority-Analysis: v=2.4 cv=P443RyAu c=1 sm=1 tr=0 ts=690c1662 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=CziIr5uqzkuEUY6LxPcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDAyNiBTYWx0ZWRfX5PpBo2nT9Y5M
 gpI4FEAS+lYcxCZjl+kZWhGnVFTmXePW0LPYA5zsMC2u38g4kCw2p//ClZxd03kpyAu4kvJ0E7M
 bB7ZqiYRdPOsMLbRS7y5B+5WsOJpEqFeVtNTJRt1NZ/3uYAAwiWV7841klYShFXo+zrnMuMh0xh
 Bxox5heaYRJ2X3Qrj1thHvnsFewYOUmDQS65nKlJBKYm2okmViEvap1OZgOmIca7d5oumf063Wy
 odbXiTiwZwjTFOLXa8ftPFhwRCT61BZAV3yb5s16JfZSaJYH8uaq5tzWlxJsW9ee+SOV4RM8ED2
 xWv/jgOsU4++CFkCA4xZG0DQpjPwMBSXe//hOcKzbLIf0mqtfs5ZJTr7+Us6ILxfZaqpqWZ/+m1
 ZT1WAZoYt+kyi6r2pLlApyckvaT0sQ==
X-Proofpoint-ORIG-GUID: vm_50AnKL2qnQCjQrd28aqdH4A-cdI5o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_09,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 phishscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511060026

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
Changes in v4:
- Split ‘improve alignment’ and 'crop offset' into two patches.(bod)
- Modify the comments for the enc_raw_* variables.(Vikash)
- Link to v3: https://lore.kernel.org/r/20251104-iris_encoder_enhancements-v3-0-63b0c431b4d0@oss.qualcomm.com

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
Wangao Wang (6):
      media: qcom: iris: Improve format alignment for encoder
      media: qcom: iris: Improve crop_offset handling for encoder
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


