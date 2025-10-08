Return-Path: <linux-kernel+bounces-845266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EBDFBC4352
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 11:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4452919E0D90
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 09:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35BAD2ECE84;
	Wed,  8 Oct 2025 09:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lN4O+3jH"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967342F3612
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 09:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759917166; cv=none; b=uxFPp2VZ8t/opxIgocedweF8nTL41qL5XiaOyvZY+Y2Y0k8mfVOoMrY8XKucR12LxDBxVNG60uztvEnZLZlmaCmA52dIj96D7cguMOpeQfp7/DG7SXjWhmyGJ0iAPIcu8kh86eMMm0iTrI3RXJHIygxeJr041cHw6Wv+WW5Rhrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759917166; c=relaxed/simple;
	bh=dVxH7am5NpfR2SKXOMgeyYYUDDszpYOsvQGpJZvlHu0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZQVCS7wnBrNWFhXpCGSyXTfQnZ439T1yXyoVgxjJyV+/H8QKcYFcT8XlEutJkApuhgz/ukiR6B0oKluc2AUNI/19blwHxm2tOytOoiTu0lyHqgHSGpTxrMlzh5bRCFIv1glwssxVm4Fdy3w1lLkxZzfYRybvsS+jeBxOOBU8t0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lN4O+3jH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59890OsA009332
	for <linux-kernel@vger.kernel.org>; Wed, 8 Oct 2025 09:52:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=q3OaqN90CD+hRsZWsAs1tR
	oSX142LTSoO103+LCQM0k=; b=lN4O+3jHGZaOMSvzRNAtSRTPZLkKHw4ijArMpU
	EKRZEAw64Uhz1Icl49LlJOtmcPfCudytB22cyfEVbC1uIqQ+6PTQrZVp74JoPE0z
	NY4aPYleRgfyU0s/sufbgalIC9aVJg/hIoMg26dvxzMUzj9YaVW2KmublTNVwK9A
	EqHFQ+zDTmpfi+Huo9bP4PitOD8c4p8pu9XzxzLY/0K1by2DY5S3f0vwUqDhhLlS
	Pa6clFv+h6PxvqM/Xrn7NaeeyzOaAT2vbdbEvgfFilT0FsHixVCWZET9mc6QdcFj
	6z5QuuX8UH7zyI/T2gp0uLnV9myF20AISYWdHZRye48mSTnA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49junua180-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 09:52:43 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-33428befd39so14284339a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 02:52:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759917162; x=1760521962;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q3OaqN90CD+hRsZWsAs1tRoSX142LTSoO103+LCQM0k=;
        b=J3qtzCtQgAUuUY8xgMt8AIbMjJjYi4wfQV6BRAmGvAcPOLpNcZDWTR/IxjpFoRZ7YT
         Mprai7gNGK8bRWcSWvWOQnWgfM/qi4Jr7P3rX8T6bDjWOM33Fldr5x7E0UtdWLp/WyvF
         jCWwNGMd09Ayflm32bC12zAqONfEXWyIbqWiaVocgwP4ki4XNWDAIN+PY9IyCJ6sZFIj
         X6cOKMXYLGRXgP0xPT1apH3+ajtJWI3PK4jiuoFqKtGq4vw7YIoaExeKeewxykrvnA0B
         d1a7hLmLLxdn0PriMZ4XsurqF07wV5BIqPoBvtXhB6oJtbIBMoOBxN6MDwJrqPBhGv5t
         4GuA==
X-Forwarded-Encrypted: i=1; AJvYcCUrzs12qor4Bq7Ewe4S6CBx1qAB8vr9Es/T8KApP9mxAPI760Hph0VsFbbpFzbXJG39z/nugCwtHtVtOjM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI3fmE6b7FuGP01LvQpQd8D0SpGUkmLgX79spoS2hUfS+XXNwC
	fZlHgy8gYkQDOwHpYaZYUZJUm3YBg3bqAvXOkbArQmNUeMdmLBehHUESYUEy10XCITtUxw9l0M+
	YzFd4A+gdtFRWA5nSn7DMph97ei2CSC9mVLUnstCjrGDnmHq1tPGokLUYoXDX01Vvt4A=
X-Gm-Gg: ASbGncsP2uHcoj5Zu1NclWiNJVKGk1LztwRjMZEa/PEZ+oz0k6Hma+l7H5nsIKvzrG/
	C0s6Hq6CCZYeBKTN1D4jytIN1Dj361HD9pSUOVSwq/MfBjw7lDwCJgozZQ1n0GuVzz5b81VyaCh
	Bx0ShkayEdahfXzDusl7EaWWcOhyZH5FaK3WFXhPdBB7T8pLcWxS2PlVGN3rfCpPnVDe8nKmC78
	NdWRdAWpBo/ksScojN741uAe29xCDcNNeFMaYu1qsBqmjvh4s+umery8hxtR029YUBtT+M1LcRH
	+KoiBrP+cGvDVDgNjnKqoqUZg0Y2kJOIZC/nZKijM4sUaipHLFAwQhUm08749An33eUCOKLJPTG
	olZ/1bak=
X-Received: by 2002:a17:90b:1b42:b0:330:a228:d32 with SMTP id 98e67ed59e1d1-33b5111891emr3514628a91.10.1759917162096;
        Wed, 08 Oct 2025 02:52:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKrHvQ5C6DuHSYon1yuEagBSjWu5msDds51jUihiW7AOho0r2ExmRh8FDxUoD9d0odO+4Yxg==
X-Received: by 2002:a17:90b:1b42:b0:330:a228:d32 with SMTP id 98e67ed59e1d1-33b5111891emr3514601a91.10.1759917161653;
        Wed, 08 Oct 2025 02:52:41 -0700 (PDT)
Received: from hu-dikshita-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b510e91d4sm2763833a91.1.2025.10.08.02.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 02:52:41 -0700 (PDT)
From: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
Subject: [PATCH v2 0/3] Add support for QC08C format in iris driver
Date: Wed, 08 Oct 2025 15:22:24 +0530
Message-Id: <20251008-video-iris-ubwc-enable-v2-0-478ba2d96427@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFg05mgC/3WNwQ6CMBBEf4Xs2SVtgwqe/A/DobRb2QSotlI1h
 H+3knj0MsmbZN4sECkwRTgVCwRKHNlPGdSuANPr6UrINjMoofaikTUmtuSRA0ecu6dBmnQ3ENZ
 H0ubgKul0BXl8C+T4tYkvbeae48OH9/aT5Lf9KZt/yiRRoBDCSklWO1uffYzlfdaD8eNY5oB2X
 dcP8AFrNcMAAAA=
X-Change-ID: 20250918-video-iris-ubwc-enable-87eac6f41fa4
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759917158; l=2450;
 i=dikshita.agarwal@oss.qualcomm.com; s=20240917; h=from:subject:message-id;
 bh=dVxH7am5NpfR2SKXOMgeyYYUDDszpYOsvQGpJZvlHu0=;
 b=sISEYgomFBoqTELd5kLJQEAq4BxSDAxh+bkBabfEKbdPiB9PH/wv7h+DwBhmtWEgA3NvuFBYa
 qGtszB/Mcb7BQw5nW4/MpYiXGYpjhfbk4qbj7eAslloHyelxETUzAjF
X-Developer-Key: i=dikshita.agarwal@oss.qualcomm.com; a=ed25519;
 pk=EEvKY6Ar1OI5SWf44FJ1Ebo1KuQEVbbf5UNPO+UHVhM=
X-Proofpoint-ORIG-GUID: PKXEoc8E5-3EZeStWRvkB4Z_1jvuNN1j
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAyMyBTYWx0ZWRfX8UpVT3DGXiFN
 bKmsIx9PYhZvk18tzracmiPsZeCEq2ad9wEWzhZ1MWHS9NgNe6J7h0Yp3ljSruQyojWSe8p9epR
 oayY1AyjwKy06NmmYtYa1mcQGVqID3JmNSKEcDjieY5avZ3vvgPD9K9A0fbQFwNw9VwHlcNM3mS
 yawR48C7Us4A7CZsTBCsGcpnD5bi3PqcvgVDYMb07RWtFqx6aVFi1rZRz0uPmwoF1LdoViUDcMw
 MwTLLNT/92POOGJtnPGVbsmf+vJ31t+kd+7DHFrioVfyeubXXNMZmsXKD3tUQk6Bop1G2YhTAlt
 72VLIqoJlKscKCvZ76VKGYOmRf5tdrGLwa4m8ZErYDONPv8TsT09cCnfRcbIAR5kBMQXXcD03mq
 L+/ZZLuQFVWE5AzzK5JlYw88OOFVtQ==
X-Authority-Analysis: v=2.4 cv=CbIFJbrl c=1 sm=1 tr=0 ts=68e6346b cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=tWxWURTORvhNpiqNSXYA:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: PKXEoc8E5-3EZeStWRvkB4Z_1jvuNN1j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 phishscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040023

Add support for the QC08C color format in both the encoder and decoder 
paths of the iris driver. The changes include:

- Adding QC08C format handling in the driver for both encoding and 
decoding.
- Updating format enumeration to properly return supported formats.
- Ensuring the correct HFI format is set for firmware communication.
-Making all related changes required for seamless integration of QC08C 
support.

The changes have been validated using v4l2-ctl, compliance, and GStreamer (GST) tests.
Both GST and v4l2-ctl tests were performed using the NV12 format, as 
these clients do not support the QCOM-specific QC08C format, and all 
tests passed successfully.

During v4l2-ctl testing, a regression was observed when using the NV12 
color format after adding QC08C support. A fix for this regression has 
also been posted [1].

[1]: https://lore.kernel.org/linux-media/20250918103235.4066441-1-dikshita.agarwal@oss.qualcomm.com/T/#u 

Changes in v2:
- Added separate patch to add support for HFI_PROP_OPB_ENABLE (Bryan)
- Updated commit text to indicate QC08C is NV12 with UBWC compression (Bryan, Dmitry)
- Renamed IRIS_FMT_UBWC to IRIS_FMT_QC08C (Dmitry)
- Link to v1: https://lore.kernel.org/r/20250919-video-iris-ubwc-enable-v1-0-000d11edafd8@oss.qualcomm.com

Signed-off-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
---
Dikshita Agarwal (3):
      media: iris: Add support for HFI_PROP_OPB_ENABLE to control split mode
      media: iris: Add support for QC08C format for decoder
      media: iris: Add support for QC08C format for encoder

 drivers/media/platform/qcom/iris/iris_buffer.c     | 17 ++++--
 .../platform/qcom/iris/iris_hfi_gen1_command.c     | 15 ++++--
 .../platform/qcom/iris/iris_hfi_gen2_command.c     | 21 +++++++-
 .../platform/qcom/iris/iris_hfi_gen2_defines.h     |  1 +
 drivers/media/platform/qcom/iris/iris_instance.h   |  7 ++-
 .../media/platform/qcom/iris/iris_platform_gen2.c  |  1 +
 drivers/media/platform/qcom/iris/iris_utils.c      |  3 +-
 drivers/media/platform/qcom/iris/iris_vdec.c       | 61 ++++++++++++++++++----
 drivers/media/platform/qcom/iris/iris_venc.c       | 59 +++++++++++++++++----
 9 files changed, 152 insertions(+), 33 deletions(-)
---
base-commit: 40b7a19f321e65789612ebaca966472055dab48c
change-id: 20250918-video-iris-ubwc-enable-87eac6f41fa4

Best regards,
-- 
Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>


