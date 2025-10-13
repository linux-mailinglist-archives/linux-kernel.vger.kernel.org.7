Return-Path: <linux-kernel+bounces-849882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0CBBD12BC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 04:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AF6AE4E8F88
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 02:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424EE27FD7C;
	Mon, 13 Oct 2025 02:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lW2n8z+P"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7803D23C8C5
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 02:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760321346; cv=none; b=V//ij52MSTAdrkM1lLlo0BSlSCKrBPIsJOnLifTuaG2AfDiPQ9LmMF89tFA0DjbFwRs/RppdTDXZWZe5T/7Sa5Q9Hv0HnNTirEOvJ5pfGdVzfV7UPvt1bxp5CX0053ezi26CAGO+WuFyS6clMrXucT63ZENvYUYmlBpVsdwuZ9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760321346; c=relaxed/simple;
	bh=AgfRFPNIsH1WIr3xx/ogQOdd+Y9OCJ1gSXza5s5JWdc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HZst6eQjVnCGW685xyj+f8LUkjb3XT9aar8q4KzVMtln5oI6psp5J9aoi8aFIrJuP5RAdEZ2u8DXUMpOxa5rfFWSHI7jQSkxkkd8R6piWbsMprGAM+01WtTA1b9MGuTqekiSGpZxHbtjeRr/U+jNFo6aoHohsiS93JTnA6Xt3sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lW2n8z+P; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59D0erMt017009
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 02:09:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=rVNME/kw5zI+jueIa3reIW
	uhrTrDZRF75uY8XRp2EKg=; b=lW2n8z+P4eLkQzdyjjdc1WLiFS1iuNt/XlZNSz
	Vrx/H8k+xFl7nCwrKGRV+EAbxPIu6NBqOSvj6/oQVldOdo0mGnXOlCbJ2qnvuH8D
	YqZwskqFUM875fkuRxVyZNwqQcgbh3x22c3say2RQGTFcb2CHyZWXAOTGUkB5qKp
	IdZzlkkyLzcA39WbP+IziiTiCRFbNTlcxcvJOPjmX1p8UicbVItBsrVrZuVGLtlo
	SMNZO3Y0kJWDhNOuD5YOC15dhTF5KwJ4FAy91ESfcbyAHxyFYqwmVpQ44J5nqZ6W
	pMx0NOWrprgpl5pLrMgY9HSNRAwge3/AHmlNIEYOyadmd52w==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfd8ty6g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 02:09:02 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8635d475527so2736833185a.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 19:09:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760321341; x=1760926141;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rVNME/kw5zI+jueIa3reIWuhrTrDZRF75uY8XRp2EKg=;
        b=V4Qy7q6ha7pog/ge5ke01Xm2HaFbkZq+SASxUjoXPN9sE+MfsfO1UESXkB1oF7KIBG
         xcZwFOT/Pq96sPR5/wLXax/HmpmGzmccgMMJfz/rU/Y2Kb4ZdWVndOFzgD+eYGE0VDG3
         tW1PrfiF1mKbyOq3e/ali7LIJomlTGduanCBUpJgzZAPpxLozebrQEg0tUUS83SMUWE2
         z7MkCRhfAP5wROnlHuFP2cztHib5PA+s/U4GmvqyW9kAYHPWvaWEu56oSGmxvDW2U8Ov
         bTxAjqWGC6G8Gq+2UMzrxCnNzqsNj8puCdQZeb1onlsy/VdZUAfnth5WZ6EZRtBWeNsh
         DF0w==
X-Forwarded-Encrypted: i=1; AJvYcCX0ZQeeptY7KJ8SdSbbaNtRvGUcNm5DQwpfyHmuB50UFeJV3gYWm6lKK2m6LN7VRfoFkoglseskGznxfWM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTbjDHeu/l8aNuztESRNnyn/cYGuOIAsqIQS3G5TKQJaOdMtme
	kTL0OEh9yzhs+tMhEkRKg+kGx1qwNEsTJCCkmBOJtC7RokeoA6xnXCPD9SqIsj2z2Ai4ylkPmuh
	GatYqRjZ4IoJnrVuqJWfggEiyaczAL9GwbAOIaJRv8IM26MChf0O33PrSaEWOVq2Jxq8=
X-Gm-Gg: ASbGncvO5Vn9+FSuldr73a18L9ZrM9ctm8nfW/HRr+f0VfUr0eR5HqtMeFCimdaGyx8
	QC0H/UF6K9F4mbJPlUq6BdEdKYWLen9XJLveFqp4FpdNaRS3TSxciQW29MLWpi+Ird8wPkRJWt9
	wEM/hC97DflSpttZMabGPTOs7ELAxmByPk5E7b8RjfMKUINeVfrnQsLetlxP8IkDpT+Xb/WZttM
	pE/w4NjCzirC6oF0MPWY9xmq0on0wcinDMJXEj57LB5NLJoMgwFtIv1UhtZvDUd9CGmsjN7qq1O
	BB/gYXXzAR3hkl+xp38ibRjVl2noAJUviv2Ry7SBoPojcVzA82PpCII27IEpozh4qd2LIAhfGtw
	G7tWaS2R1cLrL2+eFOd0l23xf4kWvK5mOMQ4a7rDc+g+jMQYOc/LU
X-Received: by 2002:a05:620a:7087:b0:85e:8106:f7bc with SMTP id af79cd13be357-883544f549emr2740838185a.52.1760321341231;
        Sun, 12 Oct 2025 19:09:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlows1iclj8Y9TcAMERw/mrJ+xQbQKgM6LEH+BjuoTzLW15YGd+8v2B60LQtYzKOhiwXLNJQ==
X-Received: by 2002:a05:620a:7087:b0:85e:8106:f7bc with SMTP id af79cd13be357-883544f549emr2740836085a.52.1760321340677;
        Sun, 12 Oct 2025 19:09:00 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-590881e4f99sm3563419e87.7.2025.10.12.19.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 19:08:58 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v3 0/8] media: iris: port support for Qualcomm SC7280
Date: Mon, 13 Oct 2025 05:08:54 +0300
Message-Id: <20251013-iris-sc7280-v3-0-f3bceb77a250@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADZf7GgC/23MywrCMBCF4VcpWZuSi2mjK99DXKS52AFrNKNBK
 X1304Jgwc3AP3C+kaBP4JHsq5EknwEhXkvITUVsb65nT8GVJoIJxRlrKCRAirYVmtHgunbXBiG
 106QsbskHeC3a8VS6B3zE9F7wzOfv19ErJ3PKqPOBKdYZ5Xk4RMT6/jQXG4ehLofMXBY/BBdrQ
 syEkoabLVONlX+IaZo+I1FfgPAAAAA=
X-Change-ID: 20251006-iris-sc7280-fdb797f238d8
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4126;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=AgfRFPNIsH1WIr3xx/ogQOdd+Y9OCJ1gSXza5s5JWdc=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBo7F84dnLTsRxim+bubpnpqjubTYehO6QPH+VTS
 7TOTSOJxD+JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaOxfOAAKCRCLPIo+Aiko
 1Xz6B/442vaTiqIBvJ9Y29gxrG0skCJKEuiolYq1R/l+jMVbbNmCZQlzFOciC7+OWU/Nv5BDhyd
 7vPAs6x9nSx/e/ouZc/b17j2Ga7xVYRGY387pgWoLEJu4UibPOakDziJGRJlNG4JyxJlSNB6dqO
 GNB4tBE+K6I0cmC9dkSG34Eb3rjkr233JSYBG2dKKx5cZ8exbV8E2Cro7H+eeuOMMeSwgILgJDd
 6bSpzXm2uzrxA+awSg55b84SAJYixij+xkV3dkulfRunhabVHJDwK7Kh5YCRvwlcsI7keaDaO9M
 0i7UAlTZ4rZKuFxKfROLhCyRCDeApU/rbRagyOXfyV+qr1Fh
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: CKRr2sEpM49K2rORnFjazIJJDjJRnJLJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX7Fh3gpw7Qkdr
 ghifNgSj5yYW20b/i4Vgq1NVTHfV8Gd4Ew7AB7mqRNusKenW8P87h/r33dh4GGhouuINnhAXduT
 JNYF1eUT1B/ooLpoDkWTA/WS84EFiV7B2vqc3adoNE5pDfcDsCrUtxvTRKunFWJ/nT7VO1177sH
 qn501mdIbXFDqvrG2WYFps5uvaij8p0iPfrIsuEKcVRXcLue8Zt8ezHyY3rIGoe1sHkxmE0r8Mx
 YnSVVg0xifNBiFB4roCnBx8VCW90m2cN/zrsM4Q77UJ8PGHa52CJ2Q5/y97fV9CT9ClTWZpK2Ou
 YDPrDL1+fxAqlwf0JHxCkgoiwTxNj/6ewN2WCRmgYeIpyfN1i2wwujpgjW1MWerANPgqS6+uxrt
 Ghb40HJYCtMGDFtTRb1yF2hiBsbW/Q==
X-Proofpoint-GUID: CKRr2sEpM49K2rORnFjazIJJDjJRnJLJ
X-Authority-Analysis: v=2.4 cv=PdTyRyhd c=1 sm=1 tr=0 ts=68ec5f3e cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=gkQpJwJ0h16Q5Df4fnkA:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_01,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018

Port Support for the Qualcomm SC7280 aka QCM6490 aka QCS6490 platform
from the existing venus driver to the newer Iris driver. The firmware on
this platform uses the older, gen1 HFI, which puts it close to SM8250
from both the hardware and interface point of view.

Test results:

$ ./fluster.py r -d GStreamer-H.264-V4L2-Gst1.0 -ts JVT-AVC_V1
...
Ran 77/135 tests successfully               in 17.010 secs

$ ./fluster.py r -d GStreamer-H.265-V4L2-Gst1.0 -ts JCT-VC-HEVC_V1 -j 1

Only WPP_E_ericsson_MAIN_2 succeeds, this needs to be investigated later

After removing several test vectors and running single-threaded:
$ ./fluster.py r -d GStreamer-VP9-V4L2-Gst1.0 -ts VP9-TEST-VECTORS -j 1
Ran 219/292 tests successfully               in 134.749 secs

Disabled tests:

            "name": "vp90-2-18-resize.ivf",
            "name": "vp90-2-21-resize_inter_1920x1080_5_1-2.webm",
            "name": "vp90-2-21-resize_inter_1920x1080_5_3-4.webm",
            "name": "vp90-2-21-resize_inter_1920x1080_7_1-2.webm",
            "name": "vp90-2-21-resize_inter_1920x1080_7_3-4.webm",
            "name": "vp90-2-21-resize_inter_320x180_5_1-2.webm",
            "name": "vp90-2-21-resize_inter_320x180_5_3-4.webm",
            "name": "vp90-2-21-resize_inter_320x180_7_1-2.webm",
            "name": "vp90-2-21-resize_inter_320x180_7_3-4.webm",
            "name": "vp90-2-21-resize_inter_640x360_5_1-2.webm",
            "name": "vp90-2-21-resize_inter_640x360_5_3-4.webm",
            "name": "vp90-2-21-resize_inter_640x360_7_1-2.webm",
            "name": "vp90-2-21-resize_inter_640x360_7_3-4.webm",

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Changes in v3:
- Included the header file for the SC7280 platform (LKP)
- Link to v2: https://lore.kernel.org/r/20251012-iris-sc7280-v2-0-d53a1a4056c3@oss.qualcomm.com

Changes in v2:
- Expanded commit messages to explain some of the changes (Konrad).
- Moved platform_inst_cap_qcs8300 back to the header (Dikshita) and
  added guarding ifdefs to the haders.
- Merged SC7280-specific ops into the common implementations (Konrad).
- Split SC7280-specific config bits to a separate header (following the
  Gen2 split).
- Link to v1: https://lore.kernel.org/r/20251008-iris-sc7280-v1-0-def050ba5e1f@oss.qualcomm.com

---
Dmitry Baryshkov (8):
      media: iris: turn platform caps into constants
      media: iris: turn platform data into constants
      media: iris: stop copying r/o data
      media: iris: stop encoding PIPE value into fw_caps
      media: iris: remove duplicateion between generic gen2 data and qcs8300
      media: iris: rename sm8250 platform file to gen1
      media: iris: move common register definitions to the header
      media: iris: enable support for SC7280 platform

 drivers/media/platform/qcom/iris/Makefile          |   2 +-
 drivers/media/platform/qcom/iris/iris_core.h       |   4 +-
 drivers/media/platform/qcom/iris/iris_ctrls.c      | 246 +++++-----
 drivers/media/platform/qcom/iris/iris_instance.h   |   3 +-
 .../platform/qcom/iris/iris_platform_common.h      |  26 +-
 ...iris_platform_sm8250.c => iris_platform_gen1.c} |  62 ++-
 .../media/platform/qcom/iris/iris_platform_gen2.c  |  25 +-
 .../platform/qcom/iris/iris_platform_qcs8300.h     | 534 +--------------------
 .../platform/qcom/iris/iris_platform_sc7280.h      |  27 ++
 drivers/media/platform/qcom/iris/iris_probe.c      |   4 +
 drivers/media/platform/qcom/iris/iris_resources.c  |   2 +-
 drivers/media/platform/qcom/iris/iris_vdec.c       |   5 +-
 drivers/media/platform/qcom/iris/iris_venc.c       |   5 +-
 drivers/media/platform/qcom/iris/iris_vpu2.c       |   6 +
 drivers/media/platform/qcom/iris/iris_vpu3x.c      |  35 --
 drivers/media/platform/qcom/iris/iris_vpu_common.c |  77 +--
 .../platform/qcom/iris/iris_vpu_register_defines.h |  56 +++
 17 files changed, 345 insertions(+), 774 deletions(-)
---
base-commit: 0b2f041c47acb45db82b4e847af6e17eb66cd32d
change-id: 20251006-iris-sc7280-fdb797f238d8

Best regards,
-- 
With best wishes
Dmitry


