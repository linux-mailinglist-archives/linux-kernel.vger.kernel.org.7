Return-Path: <linux-kernel+bounces-849596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34197BD0747
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 18:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50FA21896AEF
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 16:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722D32F1FC9;
	Sun, 12 Oct 2025 16:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ApkhdwWS"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC73F2EC54C
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 16:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760286230; cv=none; b=fxo2EdOWrwka0vyujdcxR00hmqPx8hucWR7w7H9t/2IHYQdYlgEr+cP9NXgCCSnxlIjD+xUkeWM/7XWPd1aDv36B0H7b1ap1bBw91KpsyEvP8MKEwIdNf84XpS/8+5G111ylbDnoTTJoT+ZkmzO7Wbn4/N2g4KbUZhkLBlcgyXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760286230; c=relaxed/simple;
	bh=XpWK1FNv28pKv2sRV/xV0L4dhWJPtREoMlbipFZg6k4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fEmuw/CIsWzLe7WD2fzGTT+OXWXBCSrQESHz/nZ1KT4wzYF0YBL91AylKn3cVzj9RQi7T286PO2KputJcmqgcV4Ciqduy8pLmPK1viXiBY65RJ2sBuRpe6S8fgkx2JEWe5mx9N1ak0HR3p5br1NTmvjnfnJqjHqqBG5aNoMRv0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ApkhdwWS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59CBtanp016334
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 16:23:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=5ErWmbb8I3LejFy9xRe59k
	oDt1xJvASxNazFf4knC7U=; b=ApkhdwWSqJebeIDo303koEF/gyt616tPY8yUFK
	UZxy5ml9w9XV3JYpIP9C42U5MSwQN7ihXyxGHn5oVQo+Ym29G+ChF33Ala6c3+Jg
	LP40QBW54vGH3hvCL7gMNWSxfIbII9hQxQZpOX/ZcPEZ0/jcW17gLI1+EsW6yuL2
	If6nmqyT04Uz3xBblNjYve04YgJKzQUlMFaIB6ch2nVs7Qin7TyQa96dAuuREVy6
	ZDXoMwIEpxWEsDKgXCqp2GSvDwJVcBa5MkHRYUMySue8/X9oz/TOdA221tZiakLi
	tVN5NA28pPUqYvfLHEH4lsPxPfQzUVxXMWN/TKxi0yeZQADg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfert96s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 16:23:36 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-86835654255so3710987785a.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 09:23:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760286215; x=1760891015;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5ErWmbb8I3LejFy9xRe59koDt1xJvASxNazFf4knC7U=;
        b=Zro9mYHJ9KOeK6FLIjtZkbcsM4oA1t/n3lRvHklTV1d7PwO4e3aO0kx7cjgUmmfdlJ
         j61zWMkvXYhtN1QhOurY52+VtCVI1H+rgIMOO96O7UXirMjMFGd59+5vFpLc6YCSJz4C
         aK30Dtm5d9et+a36Eb6yasZui0BhIJhfUY0REI+9cQ3JqxkhV9WSZ/qfxIGF3ma5MHKX
         wXybNs5Vo77oHDnjAQh1PKlzRKIgWzhKchmnuyC9vAuTLHQobOtQ4hAugMRmP1+ltBg0
         ktNkv7bGANhAqhw/WlFzHIeb/Tb79O6tl+XvpQCHUNkETU/1wsuRk87Y7IQoZIa43GmX
         qBcA==
X-Forwarded-Encrypted: i=1; AJvYcCVTTefoO27x4qRrDXMpvoDBXK2BpZbLsLCzG041noe/d+p8BK+MTCLsUN+HUNI1xABGcl0ybJTwAgw4zs4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg34En/Vn6XMLqGeZExUpl1/rS6P19F0/4f1iHsAWRJlXXVbu/
	YRq41y2t25AdXBlZh+/JjNPoZMYhRUqi3mtkJY2mtuJJ0d697qd1pU6thswVA/pMnsY74904dDG
	Y4KMJ1MXI2/GttMzvx/tgZm35orJ0tBay4ZMXDXN6+CCOmr72XhIYohtc8UkjjtrfmUI=
X-Gm-Gg: ASbGncvny0uNMzFlNHSGy8sa9LBZC01xszvrk9BIzg2njHA1qTcQQh+VjCeTJgPnOGA
	TPwW90wHHZavmmJk364786+pQ5zKwLnyvGTDU3ZLezLcz1oqDz6uC3p9Y4LfdWfYkjozDUbgFCG
	iFdNwFn/c8MVfdqrUQryEMUeTteqeTolzdgKCjNd6Qgc9UywP4ENIV4oYLlQw+D+AsyxUwtEt7H
	hONFx4cWLYra5ClSD18pduh3Wbr42xE1P0rO9tbAfceNDqUG0hDyPPiYO7JBSFGbL544MeQBgT9
	yT3lDUXaWCD+z05N6aDbkv/IjnqShT1prx8pUPEU0qJf5Zz0hLVidpS4mQxDburF2MxgVkVSjWe
	XZjDPOaLxRxf9J2lmsFM2b+cLNtCxrCsOO4D/1D33AyePrtiYCCaj
X-Received: by 2002:ac8:6909:0:b0:4dc:c31b:3844 with SMTP id d75a77b69052e-4e6eacf6555mr255027831cf.20.1760286215376;
        Sun, 12 Oct 2025 09:23:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLc9PBUMMdN6mWfG0IkIQhrVcTd8vE0cE7839Ov28SoUxKNnRM5vw7k5z9DxAL8nVwxoqAOg==
X-Received: by 2002:ac8:6909:0:b0:4dc:c31b:3844 with SMTP id d75a77b69052e-4e6eacf6555mr255027531cf.20.1760286214881;
        Sun, 12 Oct 2025 09:23:34 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-590881fe5besm3112637e87.50.2025.10.12.09.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 09:23:33 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v2 0/8] media: iris: port support for Qualcomm SC7280
Date: Sun, 12 Oct 2025 19:23:27 +0300
Message-Id: <20251012-iris-sc7280-v2-0-d53a1a4056c3@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP/V62gC/1XMwQ6CMAzG8VchPTvSzSDTk+9hOAzWSRNhuCrRE
 N7dSeLBS5N/k++3gFBiEjgVCySaWTiOOcyugK5345UU+9xg0FQa8aA4sSjpamNRBd/WxzqYvfU
 W8mJKFPi1aZcmd8/yiOm94bP+fn+O/XNmrVB5Clhh6yrS4RxFyvvT3bo4DGU+0Kzr+gEM5Cf0r
 QAAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3891;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=XpWK1FNv28pKv2sRV/xV0L4dhWJPtREoMlbipFZg6k4=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBo69YDvAaoPLmeoTg1n01W9o6acVNMwb4qYhlZp
 8R1+4pEhZaJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaOvWAwAKCRCLPIo+Aiko
 1bAGCACB/igjvEryMbZ26mOngjpnXkYWFLTkyk4d/jYXTjgcK0MhldASwdr9VqjDenDkBimiYEd
 DDtudxE+44Ez9qWR4beq1ZqDGaA7fDVOdKr8pYOFvI3CAYgHtLzhGvt25Slinr+MiG55dk7Rn9N
 yHC7Aj5QKxwhHb29mLwJKE6DTVmbAX+97oKmI/W1ZiuKU4cM5rTJIdXaSrLCXxpdQm50ue1P9B1
 zxTEBsOE9qnCo2AgA28cFf89iJX+rTshjcgRtG+b8eUZWuANdT2J4sGZwnqnDxlf7shdhDeC8Wn
 wM23KDjUIsFUfl9rMDA3gUDSvLA11a8O5mHjCeESOX57+D2L
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=R64O2NRX c=1 sm=1 tr=0 ts=68ebd608 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=-0qgCpxBxD2pDo7pzZoA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: 3MYD_dKwvqvWyaSutVw2SIsy56vz0TW1
X-Proofpoint-ORIG-GUID: 3MYD_dKwvqvWyaSutVw2SIsy56vz0TW1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfXz3j1N6ahFP6y
 54XbYN7RGT0whQqi45gzhRdGE1dRkKAXTAYHdmZsGQxjgU1JZ8g0plgA9el7+ko81hEY10yFosr
 T8SrmF1eZcPvigQ83bRFTjGRBMjYhF5S0BJnmvDV7MLLUjA8tMAZO/34mlucp4cAc89gS9Jf/Ex
 EAc40UxJwotM1yliUQbGnGeeX+4wkfrg8H1xVPszQ5s3aOvd2t/rB4XlXzCh/lL5+GXxJU5DDg/
 QrsTriF8dhipi1QiBpvLvnh+b2hIbQG++xtyo+X5hjqs8SaVkApif5RVWo8pSTkh6yWm7VgvveS
 bSWlklW0u9nUK08GCltHbtyr9krhfoGkvyu2TX5vitN2sEbHnglbnOeLQ2E4TJmyUB6k4K1beR8
 Ts8OtEFQChHjQd6vdSoqZKIH8Wc1Jw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-12_06,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110018

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
 drivers/media/platform/qcom/iris/iris_probe.c      |   4 +
 drivers/media/platform/qcom/iris/iris_resources.c  |   2 +-
 drivers/media/platform/qcom/iris/iris_vdec.c       |   5 +-
 drivers/media/platform/qcom/iris/iris_venc.c       |   5 +-
 drivers/media/platform/qcom/iris/iris_vpu2.c       |   6 +
 drivers/media/platform/qcom/iris/iris_vpu3x.c      |  35 --
 drivers/media/platform/qcom/iris/iris_vpu_common.c |  77 +--
 .../platform/qcom/iris/iris_vpu_register_defines.h |  56 +++
 16 files changed, 318 insertions(+), 774 deletions(-)
---
base-commit: 0b2f041c47acb45db82b4e847af6e17eb66cd32d
change-id: 20251006-iris-sc7280-fdb797f238d8

Best regards,
-- 
With best wishes
Dmitry


