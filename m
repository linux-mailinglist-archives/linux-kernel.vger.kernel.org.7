Return-Path: <linux-kernel+bounces-718278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8692EAF9F8E
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jul 2025 12:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2C6916E782
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jul 2025 10:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8322627510F;
	Sat,  5 Jul 2025 10:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="U0sAAeby"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515DB2E3704
	for <linux-kernel@vger.kernel.org>; Sat,  5 Jul 2025 10:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751709755; cv=none; b=R7eqOCWy20/tKVi51QqIMNLxSTQ8cAO/2WpNzSF4/j5aMZ1BltPB+Yc/aC5S614Ywa2FhyUDCz4f/dqjrQeiaLnMbH5wThKdVm6snG3JIXwsrqiWkX5Xfi7SeY7ZAyIzzirWpoJe4EYA8+XN+bTrxTFZ4CvgQSoRbQZF465fM9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751709755; c=relaxed/simple;
	bh=J4C/0+LOprx+Bc2up6uIFnQA0ASg0Yvpvgf2DAZQvtk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GSgkFMhQH5LMQe/UnQXzJ0/UnIy+XY7FydWdMWYtbD+tA8FrGlL5yGhx/2pNX5ntVZ7inFXy34ChxWmQGb5NZct+wFV+fFkHjkdmDHMFFaPcMaTglrlSrxx6WWrA2pu2AnF5i8Has75PxBGr4lGRixeh7VWXn0gb6BqP233hBIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U0sAAeby; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5653QZ8f009346
	for <linux-kernel@vger.kernel.org>; Sat, 5 Jul 2025 10:02:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=8yTWfLiR3ivzVCC1BMznD4
	n6vr2lZu7kT5+xvaCCSNU=; b=U0sAAebyPKrogsLkSvZgChKohivpc8JlrbhxK+
	7aJuiPz1wHi4H/fT5BclW8RvHPdHtW47qiZ3ah72u6+n3oTNk3yaPQHxXgrGAaCG
	qMm7TjULai6QQRq1p7L+97MoRWm6sqIysiz/pG3yWNU9ijhOLkZXDXQ9oTsHXcQG
	9sSz5z57M4WyvbRSJeHklm5QvUb77yXa9MYChPFWxZTZv/DnIW3uPkTYDNC2asbq
	wP1PKYnYjSompwlF662nDaZ1SMArYaH0TJu+IputNiyii5Vxi7LGljsc5clHiOhR
	B9JOJMY+WKRweabLPMjYqXKYDcrA7NIQMoqH/uKwps00mvnA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47pv4x8jyu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 05 Jul 2025 10:02:32 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c790dc38b4so266616285a.0
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jul 2025 03:02:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751709752; x=1752314552;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8yTWfLiR3ivzVCC1BMznD4n6vr2lZu7kT5+xvaCCSNU=;
        b=eIMkYgpqSgRhyNkHjeFwCJeWGo87VmmcBhyYaWoCAfPL9BXn5hxa0ewO7Ay1O78GA3
         Co1AVw/S2DdjtXnVTNxftrd3ts1ne1uQMDZ/6MB6+UEgDhSRzT/hPhjEOJnBPQ8WB7zd
         kTZuPMW3SWKLMtPAa2yXfjc2ARlElmBdUrxeh82kEIRRarFDmBi24BOhPGVlePbA/Omy
         U0sxgJ/DG1dmEw5UoYejHlmRA+gxiU94J9RVsUaQNK4u/iPjszI7JiyGY+iPTHUqEfqM
         Zi6QGOkfROJRsZkJ/xAI6kpYczuShpegFmqu5uu94dxBPzUwnqw6M15i7yLeO9AR0m1p
         71kw==
X-Forwarded-Encrypted: i=1; AJvYcCUGywl2wksMKJVS8kR8nyl607DbzxNaaTLgw3a5AAlA5UF9q6jEc4oa1cqqmEPZkozAh0yaZPJwob6c8Dw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtH5Q5yXkFXSuOYyp7JV64KMA9wBkdMJg330JLbABjGAzQuKyE
	aXa4Rbp17OfCbAVQxkkkLw9bvG0lVm7aAkN3U3oEuRjly6syQ1bUvA9PvwXk73IO2I+yhNmFMAO
	atM5cXsFWu1h4VOpZjfeYaLPQctO8ddxeuUPy1vnPn0J1TcWV0vCEJ9ykNRuQ2r/ahX0=
X-Gm-Gg: ASbGncuFXqHk+L2s472cKAdD3qPlSANPMVx3BT/9upqDiXnpBFl/VNmjkzRgpAPq8rO
	saEBKrBf2t3AP8Nx+0msrDt+q4se8yA4Qzem5RQObhTd22SYCholrlDdOM88AtKgUFqlTyLfLsR
	JR8BTA8Jl+KD1CG47v4jpyOYsm9YsfIOKFdM5oLfXuDezNEgg1aN3CBOfw9qPQG3AHJPJyY8ZOM
	TDUv5DxgkWmQixwhO/mcVBRG2JbU+oyVxSBfScgOULt8GdEPu5YDlGl5ODHwgZ0NWHWwOXmLTeh
	lXrBkq/L6xoR0I0umBQu8e5mWJRJXD2yRXldL2oZho9ue7cbtXexKorE9AoXRIVBoSgOFELnb9+
	ZGT1nMzoXV8fgO6KwZv5/DmeIBo1p0/cX8nY=
X-Received: by 2002:a05:620a:1a9d:b0:7d4:4b12:a39c with SMTP id af79cd13be357-7d5dc6b8a4amr855386485a.16.1751709751664;
        Sat, 05 Jul 2025 03:02:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXvGmikYRm3WVOK8bhN4jyz/OZR+VPtPDg3PsMkeviJGVWLPAoeV6KBDIzLQsF2YVG8aan3w==
X-Received: by 2002:a05:620a:1a9d:b0:7d4:4b12:a39c with SMTP id af79cd13be357-7d5dc6b8a4amr855382885a.16.1751709751119;
        Sat, 05 Jul 2025 03:02:31 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-556384c0558sm526274e87.209.2025.07.05.03.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jul 2025 03:02:28 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v4 00/10] drm/msm: rework the ties between KMS and GPU
 parts of the driver
Date: Sat, 05 Jul 2025 13:02:25 +0300
Message-Id: <20250705-msm-gpu-split-v4-0-fb470c481131@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADH4aGgC/3XMTQ6CMBCG4auYri2ZmRYRV97DuKgwxSZikQLRG
 O5uITEafzaTvJN8z10Ebh0HsVncRcuDC86fY+jlQhRHc65YujK2IKAUNKKsQy2rppehOblOUgb
 IOmcNFkTcNC1bd5293T720YXOt7eZH3D6PiX1IQ0oQSIqsvqwwlWRbX0IyaU3p8LXdRKPmMCBX
 kgKXwhNCOVUHAzY1JR/EPWG4PoTUREBzpHXnGVA6gcyjuMDkFvzuzsBAAA=
X-Change-ID: 20250411-msm-gpu-split-2701e49e40f0
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3533;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=J4C/0+LOprx+Bc2up6uIFnQA0ASg0Yvpvgf2DAZQvtk=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBoaPgyKITxu/e3W/8n+dQIe/ccYjZEQmlMEG0p2
 9TOSBgiCGiJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaGj4MgAKCRCLPIo+Aiko
 1ernB/0ar0V4CLSSyk+omG2AydPR+Q1hjEoBOIzJAacJCAljf5IwJ/uVfsMJKaO1IF+OdOhnsXp
 927gmANpCD3eKrV4LTfzelZbw8paA64pO6svOHkYNZxMGYyhKSsVEtxNrIyiftlu2/Oqbv793zJ
 PcEuVhktvTYLqbAo6YmIDtdBJdOanL6dQ+59qxv/ZWNnNRhRNluJm2+7JZveFZIBHI1wXKrS43C
 KlPcjtzHqrd/MEPhaVAmj9uMVkboy6oVeyXbaQvqAgSVNwaVLhdcU4AnJgtBoqy+DL3VW4PENjl
 Zhhm8gVbc47UC5g2gTs+vFenbBH2V5pa4qUa87xm0f6inPAB
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA1MDA2NCBTYWx0ZWRfX2ec4ab2IvhOH
 G2PNAcWI99J+LFooIDAhWQ1uuXxqswZfgCHW5IWgvtYJD1Mj2LchTwwdvvn/hkgOioAy1Yw7Cge
 TX1Jjhmrn8nvlhyCovOfFifdd/q5R2ke4dCBo6jchtN3eekL18TAaIlBkZmkDmqzgWUuFUQ9RWa
 x7/7tXsUk5i0JTovclWcHRR4wGrJ4UtyiEu4fFYKn1IjpH9LW/6uLb4IwJki/SOv+Vz8BFTHHQ7
 7g62d1GEqGx3WasRlevc2yb+ZkvSN3/48r0fY7X81SjTdwgbQ2vFDrbACe7ILiD00UEXcbFC6Gv
 nxEgHqpXxaq1bZQKJ4Wt6aRcLSTCRJgMPxTDcJfJFjVyy38MMGd5OoKY6GpxuuDOhIU/UiJEt0D
 FPCogRT+/6HcBGxEMQ4tlAdV+SPcH++scsJWfGySM5LQV8x2w71jpsTqIY4GLx03JjuKA8vj
X-Proofpoint-ORIG-GUID: ZKCQLFUgDvE0CyoZiG8U9vu4uHlyXyUT
X-Authority-Analysis: v=2.4 cv=DNCP4zNb c=1 sm=1 tr=0 ts=6868f838 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=3aS5ecUQXdRO32CnfYUA:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: ZKCQLFUgDvE0CyoZiG8U9vu4uHlyXyUT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_07,2025-07-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 spamscore=0 clxscore=1015 phishscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507050064

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
Dmitry Baryshkov (10):
      drm/msm: move wq handling to KMS code
      drm/msm: move helper calls to msm_kms.c
      drm/msm/mdp4: get rid of mdp4_crtc.id
      drm/msm: get rid of msm_drm_private::num_crtcs
      drm/msm: move KMS driver data to msm_kms
      drm/msm: make it possible to disable KMS-related code.
      drm/msm: bail out late_init_minor() if it is not a GPU device
      drm/msm: rearrange symbol selection
      drm/msm: rework binding of Imageon GPUs
      drm/msm: enable separate binding of GPU and display devices

 drivers/gpu/drm/msm/Kconfig                       |  34 +++--
 drivers/gpu/drm/msm/Makefile                      |  19 +--
 drivers/gpu/drm/msm/adreno/adreno_device.c        |  39 ++---
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c          |   4 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c       |  13 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c           |  35 +++--
 drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c         |   9 +-
 drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c          |  13 +-
 drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.h          |   2 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c         |   2 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c          |  17 ++-
 drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c |  12 +-
 drivers/gpu/drm/msm/dp/dp_debug.c                 |   4 +
 drivers/gpu/drm/msm/dp/dp_display.c               |   6 +-
 drivers/gpu/drm/msm/dsi/dsi.c                     |   4 +-
 drivers/gpu/drm/msm/hdmi/hdmi.c                   |   9 +-
 drivers/gpu/drm/msm/msm_debugfs.c                 |  97 ++++++++-----
 drivers/gpu/drm/msm/msm_drv.c                     | 166 ++++++++++++++--------
 drivers/gpu/drm/msm/msm_drv.h                     |  31 ++--
 drivers/gpu/drm/msm/msm_kms.c                     |  41 +++++-
 drivers/gpu/drm/msm/msm_kms.h                     |  46 ++++++
 21 files changed, 360 insertions(+), 243 deletions(-)
---
base-commit: 7df7b18268eb5c75e3978da5d183d8cc24d4e201
change-id: 20250411-msm-gpu-split-2701e49e40f0

Best regards,
-- 
With best wishes
Dmitry


