Return-Path: <linux-kernel+bounces-873685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A38A3C14705
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 12:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CF684068F7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 11:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94779307ACA;
	Tue, 28 Oct 2025 11:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="n+E/bn4Q"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22BC30BB88
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 11:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761651991; cv=none; b=NSRMIknoyX5SxTtfrKTywMei270Rs3SFmwtHBetFk8OgRpbsnkj0wbyci2kR9PFvORtHmpVZoCBkDPdYO21Y6XNY51gL9FL7oqZ6UXOqu/iBxG/ZQluQgbKg4yDUhOBeyxjJsvDGQHnoRxjUYkdSDE7JNZ+rxR/NoyIkMigmlUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761651991; c=relaxed/simple;
	bh=A8OgXaRk7o8r9AE5c1vDrBirJ1cPiVZjVmv7xDqq9yU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CBiMQp79UxmtuazzWLyS2F5qsj9TA7sVpfAKlC1tMm1EAk5d0jBLTtLo8Tt802b8cbTs3P5JSwnZAP5ozoNdRUgqU+gGxKfKvaWsD8a0dO/jwilYiTPm5/GMxN//RucpBMX8Nxzq5Ggzug/MgeZJayUsPAjAwBhTVc7d4aohu9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n+E/bn4Q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59S7Vn1F3812996
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 11:46:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=UK+NGGq/OaUN8VshP9+3DY
	uEqhGz7cUBDFCS0noDKmo=; b=n+E/bn4QzvzHwSyz8b3M//sGvnUa064vdat8IN
	+4yLg+ggZMFcz7W8I1gPmwtIY6hYHZnUofE1I6h0VKu20Ke0tFGPTP1hmTRBnJjz
	RfjQfONtF33wf3q0/JPvXeLUuf/NFgZWOoSqnd2PoTtYQAxs3Y/59f0jAXIFj2dl
	9koxfcjLhGkuONFtrD//0CqK5jhoM+8S8QDd8WsFo9kIMAbCsroQTZHxgvwe1+xW
	gRdJK6CRqvrIiWjOjkNRBFTRxusDlu5Jb0a+LV1IXt8+ExBwbVOyvdxE6TK+97oI
	P2HVMGEUGiPGTaiFyIvEs0zOzZmtEzaByWgBEhdiPSk6hN4Q==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a2g2ft8um-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 11:46:29 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4e8a387d01bso268041321cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 04:46:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761651988; x=1762256788;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UK+NGGq/OaUN8VshP9+3DYuEqhGz7cUBDFCS0noDKmo=;
        b=DMoN9YAPEUbyQkrUP5ePvIkJLjqnI2SlJnNVs9CG8TSdNnLUrhBvyFMhsZNHE3YxCn
         no5/DgauTZpx/EIO+9oh3Gj/bxRVhsGDqfMmJxsu1tfjNUEykrF5VJrvhNh5E464AXYK
         sKjRoJTVUgaQbOXtDLBkEcd2jj2afyioCj0Vut+3pPx0zT6ux+6iaPQOEIGlkn5mvs98
         7HG9kVfVl65Dg2As4LEJum4jLGUNpJCAo9PtZtC76CeTUTWooqBuNMHK9vVJlrUVW/tV
         f7N5WEHp4a5k7To4CLssK8picetWv31ymZknN92AAjoNb9AjZ/OM2niM05/1F3iLS9j7
         ogcg==
X-Forwarded-Encrypted: i=1; AJvYcCV3ECDMPAHwZ5cClc9ycgFdZ4E13+6X9lI8qQ4wEadbbHohq0II1BQdcRFfpqPIwRz4e4bWmrrgkm3bfCE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw94CjCj4pkyPwqlRX47mPyGbDH9aHOl36cRRQrFSjmNQjdtqbZ
	3rKiO3zAbraTLaMrPB11qt2+odl3dTFV36dS/yYxHTqiGnxNOQ+kdRNj5d+SJhVTfwH3bIMPLJW
	/EahyOTZbnF6w0e45QmdTzfgvWFn84xIEi2SZ3mKmLZGSqC01t7xfz5eNTRAi+fzhbLr/uJ2k61
	Y=
X-Gm-Gg: ASbGncsDTbPC6NWjQ6GS/dKI0zKWhfhQo6O1g5hfNs//YHPOE5A8eTPeTV28uDFe4rW
	ZzgXkab4tf4fLK6jsEZMUv7SBGpun1PFSkh+Ayf78geqFoLl2DFVSmm5mfz6Lbo6wpkzwRJnA6K
	Kj6/dYLudd1Q4uKvv0uxHMRKGhb0+PbiLeDF1RNA6yX6XdQEzvPz/5/EA03lfH2FI8N9UiIUO3v
	kBsOtUIPxkcfe6LFEhB63zgUPoCdNwTpE2nlP2B4lz5HW90+5Erw/Vf3kErcPxA0mESVXy2uUNw
	0f8asWxohIbQGIDUjc0ToZ07YQQfYtqESw2ISuBqnbNRFW3sG6VxWx4OXWNBD1G5ee8x+sFwMPc
	6jGesccBTRi4DumBaD3E70RBUVrtejjXXix5/5fqFT6EA/+ae4MnSSA8pMt/OziUNS9QPzqP08Y
	5gfMK+k1xWu5X8
X-Received: by 2002:a05:622a:5c95:b0:4ec:f0b5:50d0 with SMTP id d75a77b69052e-4ed074fc7f3mr42901451cf.28.1761651987667;
        Tue, 28 Oct 2025 04:46:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzd4/OcSU+o7P1EFTYwN8xWFSkG8e2ElP3RMUOQ3Yc0HAC61oxQgGVV5dgRybgyY2tc35gAw==
X-Received: by 2002:a05:622a:5c95:b0:4ec:f0b5:50d0 with SMTP id d75a77b69052e-4ed074fc7f3mr42901051cf.28.1761651987064;
        Tue, 28 Oct 2025 04:46:27 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59301f41ce8sm3096564e87.6.2025.10.28.04.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 04:46:26 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v6 0/6] media: iris: port support for Qualcomm SC7280
Date: Tue, 28 Oct 2025 13:46:19 +0200
Message-Id: <20251028-iris-sc7280-v6-0-48b1ea9169f6@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAutAGkC/3XMy2rDMBCF4VcJWkdhdBnJ6arvUbrQZdQIkriVW
 tMS/O6RAwEL6s2Bf2C+G6tUMlX2sruxQlOueby2MPsdCyd3/SCeY2smQaIAMDyXXHkNVg7AU/T
 2aJNUQxxY+/gslPLvQ3t7b33K9Xssfw98Esv16QydMwkOPFICBO+QRHodaz18/bhzGC+XQxu2c
 JNcEUL2hFwIVE44DWiC2iDUmlA9oRqRlA/krXUSYYPQa+LYE7oRRCaGNmS12CBwRUjbE9gIJHI
 ejQXS/h9inuc7IMI2pLkBAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4799;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=A8OgXaRk7o8r9AE5c1vDrBirJ1cPiVZjVmv7xDqq9yU=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpAK0QL3iVQ8pojaauQ86rtK31e5zweo3zJdCci
 NwWenOWHWqJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaQCtEAAKCRCLPIo+Aiko
 1eY9CACY4ID/MSoEmSvqDG5pwYLa4P2Um8fNf0UpGNhDMJty3h43D+Cm4+OI2+VytYa3csv7R6s
 Eqpzw3NcghkKwF3k4th/fWEclHPVuWWQx2nOsClXJErRliCnTEBFJdmfkEUMIOGShi7S1XAR/Mk
 dUJU6rVH3RMVgfS5Lyx/j9nKhYrCZVesBvVVo26vCFPWeVGaV9usDRUGiLe53l1h5QGAjz0uGg1
 SFoO2W5mfnLU3F/qAG+e/VGpadXQHBD1oMICeDg4plLDwNp9CR/BlRxf9ISGTsQdKsNlQ2WrXyW
 qk7QqGEw4GYojpeK9oRYBeKsg69NtjG8u2wmzblirVEBz361
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDA5OSBTYWx0ZWRfX3C50c/QXLOks
 GBD6xT4gQeuD1xFyC2vlFPwinskxv8u3gkvgjHEQp8lZzonB4MV1bdiOGM35wd2Ao9XoHXW9yXt
 eFHSOCqKKK5YPecOGvq728sqa1E7WiLz40TR6SCBJUhPurPqLIo6k5TXxqBZXAmDWKzTFNFxkeG
 i85CQCvC9tfT3RvhHpDj5mhccm9g9MKBC+rcpUxEeD5UaBMocZsUKvzHi3UOXOst+NdHZnwAzxM
 9PQ+1FEgx1tUDl0zZtNNF3i/jUQFfYHnnktN3iAhaVqUtgvkkb8rvYBE7ppsVr7UvuDewSqnSK6
 dBT6NNz0OlhuphsguflsIpjBpdg7Atx6xHz0eel2GTH4MYmVwryEwQs8OF1aqPNaPmvm5UK3Wp1
 gE8CxzTQDmoUes/IqcA1wtpEQyDDzw==
X-Proofpoint-ORIG-GUID: CVunpo1HdOHb_gjNWL43HU8_2e5BlMjr
X-Proofpoint-GUID: CVunpo1HdOHb_gjNWL43HU8_2e5BlMjr
X-Authority-Analysis: v=2.4 cv=FIMWBuos c=1 sm=1 tr=0 ts=6900ad15 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=pcU2kZSltczg-j7lHUUA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510280099

Port Support for the Qualcomm SC7280 aka QCM6490 aka QCS6490 platform
from the existing venus driver to the newer Iris driver. The firmware on
this platform uses the older, gen1 HFI, which puts it close to SM8250
from both the hardware and interface point of view.

Test results:

$ ./fluster.py r -d GStreamer-H.264-V4L2-Gst1.0 -ts JVT-AVC_V1
...
Ran 76/135 tests successfully               in 16.903 secs

$ ./fluster.py r -d GStreamer-H.265-V4L2-Gst1.0 -ts JCT-VC-HEVC_V1 -j 1

Only WPP_E_ericsson_MAIN_2 succeeds, this needs to be investigated
later. For other tests I'm getting:

qcom-iris aa00000.video-codec: session error for command: db800000, event id:1009, session id:4bd48000

After removing several test vectors and running single-threaded:
$ ./fluster.py r -d GStreamer-VP9-V4L2-Gst1.0 -ts VP9-TEST-VECTORS -j 1
Ran 217/292 tests successfully               in 136.210 secs

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
Changes in v6:
- Corrected max_core_mbps / max_core_mbpf (Dikshita)
- Fixed the label in the error path (Dikshita)
- Dropped double blank lines from the headers (checkpatch)
- Link to v5: https://lore.kernel.org/r/20251027-iris-sc7280-v5-0-5eeab5670e4b@oss.qualcomm.com

Changes in v5:
- Fix typo in the commit message (Dikshita)
- Dropped .min field for PIPE capability (Dikshita)
- Corrected max_core_mbps for SC7280 (Dikshita)
- Link to v4: https://lore.kernel.org/r/20251019-iris-sc7280-v4-0-ee6dcee6e741@oss.qualcomm.com

Changes in v4:
- Dropped the inst_fw_caps rework, it will be sent later after rework.
- Dropped .min value for PIPE capability, set it in the same code path
  (Vikash)
- Adjusted clock index names, clock names and num_vpp_pipes for SC7280
  (Dikshita)
- Squashed the SC7280-specific codepaths into the iris_vpu2_ops
  (Konrad)
- Dropped the register moving patch, it is now unused.
- Link to v3: https://lore.kernel.org/r/20251013-iris-sc7280-v3-0-f3bceb77a250@oss.qualcomm.com

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
Dmitry Baryshkov (6):
      media: iris: turn platform caps into constants
      media: iris: turn platform data into constants
      media: iris: stop encoding PIPE value into fw_caps
      media: iris: remove duplication between generic gen2 data and qcs8300
      media: iris: rename sm8250 platform file to gen1
      media: iris: enable support for SC7280 platform

 drivers/media/platform/qcom/iris/Makefile          |   2 +-
 drivers/media/platform/qcom/iris/iris_ctrls.c      |  18 +-
 .../platform/qcom/iris/iris_platform_common.h      |  18 +-
 ...iris_platform_sm8250.c => iris_platform_gen1.c} |  63 ++-
 .../media/platform/qcom/iris/iris_platform_gen2.c  |  25 +-
 .../platform/qcom/iris/iris_platform_qcs8300.h     | 535 +--------------------
 .../platform/qcom/iris/iris_platform_sc7280.h      |  26 +
 drivers/media/platform/qcom/iris/iris_probe.c      |   4 +
 drivers/media/platform/qcom/iris/iris_resources.c  |   2 +-
 drivers/media/platform/qcom/iris/iris_vpu2.c       |   6 +
 drivers/media/platform/qcom/iris/iris_vpu_common.c |  34 +-
 11 files changed, 160 insertions(+), 573 deletions(-)
---
base-commit: fe45352cd106ae41b5ad3f0066c2e54dbb2dfd70
change-id: 20251006-iris-sc7280-fdb797f238d8

Best regards,
-- 
With best wishes
Dmitry


