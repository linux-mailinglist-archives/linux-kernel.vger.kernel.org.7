Return-Path: <linux-kernel+bounces-821996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C01B82CDD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 05:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05927485A99
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 03:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62124242D63;
	Thu, 18 Sep 2025 03:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="X3y7Y/dJ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99E923B615
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 03:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758167478; cv=none; b=GiuKJEbzE0LY09Q5nJgsbTMs0tgqRCKXsTMtoGIzElKhoqFlnUAMBScwPIoSdC1A4/m4bBDGVCImsHd0HnX7LYXfyWsh25YZQ4drEZ+FV6tamkasdWkQnFuLvr4z4YlFXLKnqODZpN/7KmEKC8NTkAQKcKxZh1Bm2c2uEI0HKRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758167478; c=relaxed/simple;
	bh=N12mAH4AEAt7MmcqShE1P3CEHF675u7xLlRmXgGx5Xo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nuMkdJ6UE3vdtbQLbnnBrh2lrglkJCb2eraKtkXqnzDsmEoO8XAWdjz6mH4ElHa9d9NpLKa1r+ebRCFmzp7INlbMKgNtVJEzRGvaOEpSQz0W7uRNRIg91cxqUbYmXu3jqbRaqOQ3H5EfN9DoL1dGPSecfaALOVQB9dTFYUrbP/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=X3y7Y/dJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58I3j5BF032414
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 03:51:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=le3hcgVXjn8geHN7AQBsWT
	xvYkhBX1Lcw++MHyY4VEk=; b=X3y7Y/dJmEZaNlp4uMoE94qP3P2nxCu4BepXJf
	jfFi5ZXwIn+PxTpvLMGPRR8ChVjwwRK89iHg7gk/nbqo2V7DyZnzzfxDIaMIwrR8
	Fi75ZKd/Wr3c6y18aHk68+dlqxa1dG8Ms/Jzw/sSHpmIFDC8Smeu+RCsZMAp+Edi
	9zsbGXrXjpqkU/33HRcuQh0CUpGVihxATJXdYuWGdTMQN8KQK3S3yt38VPXExaSL
	+GCg3M4QeBnT6/I+a19Yq/6AY8ajkWoKk4EScTshkYivX2pn2u8Dr9LOxQlR+Ug1
	aOFmf6/cFd9hW802oVa+Rol2o3x9L+1p7U6eTVCUhkpmH9Vg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fxymtg7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 03:51:15 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b7ad72bc9dso13921581cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 20:51:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758167474; x=1758772274;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=le3hcgVXjn8geHN7AQBsWTxvYkhBX1Lcw++MHyY4VEk=;
        b=Ro17W2tPF5UREsHvQEUMrU6TT/ndRHrFzwgLH48MPo/YmGxHw1QNGYyf4jZAA7QfF8
         jSUQru/KkIErZJSbx2xHlER8a/VW8kVtbtOZY1uR4QEkQ2fITyK01fRATjzX+y2ZxlTn
         iKXf+oUaQeoidIS2cyCvp+1lAo3gE7Jr6r3yGe0rQ10O1P+kquBmQ4bl33L2NxRslG/f
         jZFlNbQx7zKz9VTLX4vZSeztfXzuTgq9wcG+uN0CIeWSbBLLeBp5Xa+mp9QDxQzdLwCU
         LYTr9NGQuZ0W/gc7/vlsrqFTyhiVT3+CQSoBsgG+0PL4CO7kDU+xVGSQL131ROTvLi2x
         W8mg==
X-Forwarded-Encrypted: i=1; AJvYcCXGLmzBWDt4Krd3GphIqiURzKvVW2wmd9imAOF8pM9w7qVQeTb+iWC59Ir0L6CXur0wZ3kcMgeNYgxAG3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWbA/i/wweGlTW/v12gDCbZ3jBamuZBtluKGW0CKPjvksVsbub
	iK4tQJKJ+Fy/EkbLfK+4o6Ch+tIXqWI/gf2ocF0haQhCDvUzzYzWtJw3NuT1aGIby6TkHVjE/89
	jdLlPPeet+2y111ZNTru8YlJokJVNtI9vCgmlfDRP2gl7gJJNsbLvXluiBj3lv79svjc=
X-Gm-Gg: ASbGncvXV7+hhSNrgiiDE4nQVbZUqWclDKFlGgCJtEx6ou0FzhRljC1vYO8r6SfuCKA
	uwwqeOJGv17yPtyRXHIIbpW6sAY4YLdVG6nb5ci00eK9vCzgDIDELBnNpKaNWhUcrHQjt+09mhc
	uJNei1PDgHPuwDeSNmqzlatqI6l2MJzmtvVixfI+Wrl6iN+FdMIWfOXZv6HwbWw4ZztAFYOzABa
	4uRNN6ALgCWxKPjNeohAPvqSiVNhPfKCjxQr6x/KePVmNSvK281JnqQXD42rUFoF7rXNNhPbnLH
	hWxUCnM6b4kkaIKgtcUTq+t3OFd+wH36p+/vtcgZCkkHTSXOpJLJt5obi//11KPtMMbji35+gDU
	TDdWGfRM8+epp8CjKfafNmmo9h4S5X0pYZjqo7hRgMLTb19HSeS/8
X-Received: by 2002:a05:622a:410a:b0:4b7:aa31:3c54 with SMTP id d75a77b69052e-4ba6d819d77mr56422841cf.55.1758167474441;
        Wed, 17 Sep 2025 20:51:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHk+JT0nmGXpYlGzcsiZnvebGGF+RyXL6mJsOObPCr7jEILfS/0AWa9sVdxR5sxI5O0qDmEZQ==
X-Received: by 2002:a05:622a:410a:b0:4b7:aa31:3c54 with SMTP id d75a77b69052e-4ba6d819d77mr56422661cf.55.1758167474005;
        Wed, 17 Sep 2025 20:51:14 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-361aa38c4f7sm2799911fa.62.2025.09.17.20.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 20:51:11 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v5 0/5] drm/msm: rework the ties between KMS and GPU parts
 of the driver
Date: Thu, 18 Sep 2025 06:50:21 +0300
Message-Id: <20250918-msm-gpu-split-v5-0-44486f44d27d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH2By2gC/3XPwQrCMAyA4VeRnq0kaWs3T76HeNhqqgXn5jqHI
 nt3O0GUqZfAH8gHuYvIbeAoVrO7aLkPMdSnFGY+E+5QnPYswy61ICADGlFWsZL75iJjcwydJAv
 IOmcNHkS6aVr24fr0NtvUhxC7ur09+R7H7UtSE6lHCRJRkdflEpfOrusYF+dLcXR1VS3SECPY0
 xsx8IXQiFBOrizAm2L3B1EfCGZTRCUEOEfO2Fog9QfRb8SCmSI6Ib7UFpzO0lv4AxmG4QEbzZH
 1gAEAAA==
X-Change-ID: 20250411-msm-gpu-split-2701e49e40f0
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3268;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=N12mAH4AEAt7MmcqShE1P3CEHF675u7xLlRmXgGx5Xo=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBoy4GtJ5eB/xL4gUiMVxXXYJu5iL4TDfPX2/WvQ
 AE2GvhevTqJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaMuBrQAKCRCLPIo+Aiko
 1bGaCACrcfl54E/NPTAiqJJvaiIh87+3wEmrZe5uAs+zCxfSkb/1/O3vl7fIMGOxtOchxgYTAqi
 cNlwfhGmodkeo+b5qM/8DyUuYNje1wRgr4VF1LosjPB1sV4b4V6Hju7/mTqEWi6sImMBFvw9BlD
 ce7JM8BemdWIzrE5XQj/DSR4vFIyxU3nCTq54eOx5bz/uUgnm2jA9TxaSS8hBYyevK1Afifm3tO
 MdYoYTOUQ+HZdQ5hNk0qGui7mAGxKRDkdvddYmBm8AgYLvWSwDL/0nUg2iJWiXAM6SRI8NCZQV0
 J2WFGYHxG6s4TooNwqEc5jy2TQwwR2x4k/mFvVXYy/TEtp+h
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=e50GSbp/ c=1 sm=1 tr=0 ts=68cb81b3 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=3aS5ecUQXdRO32CnfYUA:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: VTtNG7Cnxtzf-4a47j9qC-qsH3FH--M5
X-Proofpoint-ORIG-GUID: VTtNG7Cnxtzf-4a47j9qC-qsH3FH--M5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX230q9VrJwmjh
 SdhNYjrDOANrcI2tOmm/r1Nrhx7oHtA8OKdBwe6EZEZuS8GorkpKV/2R3oh/tj6IrBQ5PQjp0m2
 n/W9rIZH/yp58WL97Md10ng3YyksswZ7gEjCY9GTlRu4fxmjK0Cv+CEVer5juxkocyP1fbGSO54
 by2cbTPAlhv8iqm5kMDGn0KYG5ZwoNzkHww42AKkr4+JRZkUcs5H5G2eIe5m2Crmq/JMBa919PG
 dXTrRFkwkUJoOXr15N0QRAwX0Q3xMY4HClst54Yp2FWitbz4F0KeXCMt9b20SBFV1OS8t4fpQvg
 FFAhBG4SaRuxoRo/5Djc7EuFsj11AdQR21OdZEm/58wJLkLJ1H0g5KnbKYi3XhIR1vPo+5ruUYu
 ht7vz68C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160202

Currently the KMS and GPU parts of the msm driver are pretty much
intertwined. It is impossible to register a KMS-only device and
registering a GPU-only DRM device requires modifying the DT.  Not to
mention that binding the GPU-only device creates an interim platform
devices, which complicates IOMMU setup.

Rework the driver:
- Make it possible to disable KMS parts (if MDP4, MDP5 and DPU drivers
  are disabled).
- Register GPU-only devices without an interim platform device.
- Add module param that makes msm driver register GPU and KMS devices
  separately.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Changes in v5:
- Rebased on msm-next, dropped applied patches, re-picked up no-GPU
  patch
- Rewored debugfs, GEM VM_BIND and ioctls code to reduce number of
  #ifdef's
- Link to v4: https://lore.kernel.org/r/20250705-msm-gpu-split-v4-0-fb470c481131@oss.qualcomm.com

Changes in v4:
- Rebased on msm-next(-robclark)
- Temporarily dropped the "no-GPU" patch, it will be reposted later
  (Rob)
- Link to v3: https://lore.kernel.org/r/20250518-msm-gpu-split-v3-0-0e91e8e77023@oss.qualcomm.com

Changes in v3:
- Disabled SYNCOBJ / SYNCOBJ_TIMELINE for KMS-only driver (Rob Clark)
- Further refine Kconfig dependencies
- Link to v2: https://lore.kernel.org/r/20250503-msm-gpu-split-v2-0-1292cba0f5ad@oss.qualcomm.com

Changes in v2:
- Got rid of mdp4_crtc.id and msm_drm_private.num_crtcs
- Moved msm_drm_private.wq and msm_drm_private.event_thread to struct
  msm_kms (Rob Clark)
- Moved HDMI / DSI / DP pointers to msm_kms (Abhinav)
- Link to v1: https://lore.kernel.org/r/20250413-msm-gpu-split-v1-0-1132f4b616c7@oss.qualcomm.com

---
Dmitry Baryshkov (5):
      drm/msm: correct separate_gpu_kms description
      drm/msm: split VM_BIND from the rest of GEM VMA code
      drm/msm: split away IOCTLs implementation
      drm/msm: split debugfs implementation
      drm/msm: make it possible to disable GPU support

 drivers/gpu/drm/msm/Kconfig           |   27 +-
 drivers/gpu/drm/msm/Makefile          |   21 +-
 drivers/gpu/drm/msm/msm_debugfs.c     |  420 ------------
 drivers/gpu/drm/msm/msm_debugfs.h     |   14 -
 drivers/gpu/drm/msm/msm_drv.c         |  645 +++---------------
 drivers/gpu/drm/msm/msm_drv.h         |   16 -
 drivers/gpu/drm/msm/msm_gem.h         |   10 +
 drivers/gpu/drm/msm/msm_gem_debugfs.c |   96 +++
 drivers/gpu/drm/msm/msm_gem_vm_bind.c | 1116 +++++++++++++++++++++++++++++++
 drivers/gpu/drm/msm/msm_gem_vma.c     | 1177 +--------------------------------
 drivers/gpu/drm/msm/msm_gem_vma.h     |  119 ++++
 drivers/gpu/drm/msm/msm_gpu.c         |   45 ++
 drivers/gpu/drm/msm/msm_gpu.h         |  111 +++-
 drivers/gpu/drm/msm/msm_gpu_debugfs.c |  213 ++++++
 drivers/gpu/drm/msm/msm_ioctl.c       |  484 ++++++++++++++
 drivers/gpu/drm/msm/msm_ioctl.h       |   37 ++
 drivers/gpu/drm/msm/msm_kms.h         |    8 +
 drivers/gpu/drm/msm/msm_kms_debugfs.c |  129 ++++
 drivers/gpu/drm/msm/msm_submitqueue.c |   12 +-
 19 files changed, 2463 insertions(+), 2237 deletions(-)
---
base-commit: 05af764719214d6568adb55c8749dec295228da8
change-id: 20250411-msm-gpu-split-2701e49e40f0

Best regards,
-- 
With best wishes
Dmitry


