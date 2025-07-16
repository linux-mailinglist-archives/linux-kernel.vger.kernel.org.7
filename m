Return-Path: <linux-kernel+bounces-733818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 013B9B0795A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 17:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52EA0567513
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 15:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A7C291C05;
	Wed, 16 Jul 2025 15:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QUHsk7sR"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AC62EF9BA
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 15:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752678948; cv=none; b=q/WpII1vFYnrxBe+8qYQXCgAGINfd4Uf81sAj3Uv6OWuwhwwTQRLiOguvBQIjMfHmLkj7PgEj8kkeEoRddrKn5lz3xxjEaqZWLYhcsGcXEwQ9se7K0YKkvh10NGeR+P8NxOYMVlWfmDc6WvkaCbtUzn7tAxep0/XEY3JU2rPlpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752678948; c=relaxed/simple;
	bh=3fiJEtG0OZw7lMsiKQs4Z8Qo7rCMvsROE29oSVR+jLw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=X6Zc6l0ILuksr1hE9t5Dr6qsysJ+jY0/86L601t2sU/jy9lkBgCYnd30bqoMkoFRUqzogCpSiO0ABSTZ4z9W5cMNnNQBEzXgCCzOfV6nC5G0N0ouGFqkLhV8wj/O3vxXy55Tza5EoO/y46thKoxZ993x93UDyIYdBCvQjfnEWrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QUHsk7sR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56GE3s2x003436
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 15:15:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=VtVpGvVZrct32JIcBjOhQXZk+GPq1hNjUqV
	+7EdjMl0=; b=QUHsk7sR5rim9L/y3GkRbdMOhD+zJW9W9mtfQqyptdjIaHI4RMM
	M4QqcAo3xIPUJ804M7FIc41mYCNILyutNmy93flIWCurMt29wHDVnZTzD5pQKndv
	SGVWVA2uji7qR8XhdLJ+kE7HqH2ATwzVx6XQwpRfVkqM4a+CYa/M6yfA3HahbwIS
	9jvOt93xV2SH15v3PL1nPZi08yFnMHLzmAoFgNkHdlMe9jalQ9EuB3gUy9JoNL+R
	RkDdWj7EHjT1YBa7axlWL0KUohZMRTkimwbENBYWyMF3fmsjaFKpRfil92X4+VZv
	QXjIEBD4ncA5OjdlVaEAgEjyYX5uVPU7nRQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w5drqdqa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 15:15:45 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-235196dfc50so54335ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 08:15:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752678945; x=1753283745;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VtVpGvVZrct32JIcBjOhQXZk+GPq1hNjUqV+7EdjMl0=;
        b=iO3ASWvFcGHOv1hnCDzOyuzDw2jMf8pbvmv4FuQgH/yD2QG1wG2kHwPY1XhFWO1iDM
         XtbCILAlDygjnFLNM5rLblSBUfOhkHeY5heEwJXcXvbHKRfw+BeBPuMP2EOnjfj8LoVC
         GYiqMCU797kxN29urqMpGkHJHojsDE9y53INryW7WUzAn2qJTngiHkc9i8d6h1owWun8
         ua/mfp9YWFdBcJbeGubZ720oq+sSE5cCnEv/9IwSR4a2KHsCILletvxn6Ev4nEBVAKVK
         7I8yAKJQg5ADNAdaricLjCuvDfCkoo9RVdgIOvvWU9BhjsGJJyWZSr4KOViTEqdbU7Fg
         KRlw==
X-Forwarded-Encrypted: i=1; AJvYcCVPo+yoQrvlveADDTJQvSfVzqapIX2dep9C8lAbYvjKKxbost8HF08rPW5CnfX1hrMKHBOCgtOHPV0s7To=@vger.kernel.org
X-Gm-Message-State: AOJu0Yybf1+elgTABjsxujcIVTmaEu99DkgA49B27YLELsf8zauBO+eF
	k0sMK5fkheD8/Mctua3d7S1G/Hu7fsrDSlTQMy3CLwCqtkEs4hAllu4YwLp8U5T9B/19iNPCbay
	6N3AJmIRk4smyPC+TumRUDD6OruI89ox5lp3TXedtEW/QlRihr5riD7HpvDFUe3WqHG4=
X-Gm-Gg: ASbGncuB2PZwUzsOm0LJe5W/EVEFnvxzO7WUosEhn5FT4cTsYAY4x8IjJ2Zu9gC5pZs
	GBASTm4uOqc5KuxCTTPrHN4Xoy+A3YMV//L2P6a/5ubFP7Vz2V7yfOyiAZN2vCobFnAk+d/NRNG
	6mQZDc+qpm4rTn9/lEb+pzusuvIqwt8G9TzgTT4EAoSmNjIzjfDQbaK8HVlZPW10jbeNmkdVLEZ
	aOTM//UwkrY5x27XGwrxmQwOO7iAGHuDAfxd5ouugrQ+e/umurIMb2KJvJyU7b1+HMbByAkTDqU
	Jw5/7OybwxmBn0uJJYs5ZcqrIDtg4ufNDPtMAVOCrS2Ieh3vivcdbmfgnvA5bebk9LUjAOK115k
	TwDTEMLcp42CEdjBlrnFlF89TOUOYm3F1mr3nJl1B/ivHwCnHtf3XRtdaOBK6
X-Received: by 2002:a17:903:950:b0:234:5ea1:6041 with SMTP id d9443c01a7336-23e1a43e5b2mr121925105ad.10.1752678944892;
        Wed, 16 Jul 2025 08:15:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEx4lYicAxy/akPMh6VffbDUsZkyKqrnhemzyMQuz11i7usIVNVimaeetdH9/tTmv63a9jbew==
X-Received: by 2002:a17:903:950:b0:234:5ea1:6041 with SMTP id d9443c01a7336-23e1a43e5b2mr121924305ad.10.1752678944243;
        Wed, 16 Jul 2025 08:15:44 -0700 (PDT)
Received: from hu-pankpati-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42ad9efsm132769455ad.58.2025.07.16.08.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 08:15:43 -0700 (PDT)
From: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
To: djakov@kernel.org, lumag@kernel.org, a39.skl@gmail.com, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, quic_rjendra@quicinc.com,
        raviteja.laggyshetty@oss.qualcomm.com
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Add interconnect support for Glymur SoC
Date: Wed, 16 Jul 2025 20:45:33 +0530
Message-Id: <20250716151535.4054172-1-pankaj.patil@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: BEqF4PhCzDMsm1hJ86CumIje-U2pdRTR
X-Authority-Analysis: v=2.4 cv=D4xHKuRj c=1 sm=1 tr=0 ts=6877c221 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Wb1JkmetP80A:10 a=kNru7P6y79U7mb-8zXEA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: BEqF4PhCzDMsm1hJ86CumIje-U2pdRTR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDEzOCBTYWx0ZWRfX/d87eo3BUjtV
 bhkKTQKOJerLepjUxwQ0JzaNZtXgygPWAveOSTn+PdlpIuUryEpnvWwk4zevSQJbS/PzpZjxaSx
 atfnR0Fvbqq1ccH4Mwg//ZhsVsbuYyD6hKaJ6Hbiz0LMtUXusbsLTiiy3Ts900J7Wcu985bpLjq
 Sm120db8ClgF9SA850PxR9OMqJ/hFAYlmerN5NdkZz9+6zDY/irdNOi20v8K6nvGVxewDRUKPnE
 1gyNJr0BNYexsSRSlvxE44+YsN7eESV/jKZPwmnkEGXdOJ4bNgq2LSvXdHqByc2Ub69wsCSf0Yu
 S0rVpQAjEN0orKqN+Oz4HuKgXtlvwMBzlvfMoU8H8U23ww94bvFXMGC28AAyQ9cdsZdtZ/ZxYjJ
 0kmVTCBcwGiHuZUoAhfgZ8bTmOxz5JdZJ5FspLq3ShaapW274AGlAEecAEgjRxSg0SUCQQAS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_02,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxlogscore=916 impostorscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 malwarescore=0 suspectscore=0 bulkscore=0 mlxscore=0
 priorityscore=1501 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507160138

Add interconnect dt-bindings and driver support for Qualcomm Glymur SoC.

Raviteja Laggyshetty (2):
  dt-bindings: interconnect: document the RPMh Network-On-Chip
    interconnect in Glymur SoC
  interconnect: qcom: add glymur interconnect provider driver

 .../interconnect/qcom,glymur-rpmh.yaml        |   84 +
 drivers/interconnect/qcom/Kconfig             |    9 +
 drivers/interconnect/qcom/Makefile            |    2 +
 drivers/interconnect/qcom/glymur.c            | 2259 +++++++++++++++++
 drivers/interconnect/qcom/glymur.h            |  185 ++
 .../interconnect/qcom,glymur-rpmh.h           |  205 ++
 6 files changed, 2744 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,glymur-rpmh.yaml
 create mode 100644 drivers/interconnect/qcom/glymur.c
 create mode 100644 drivers/interconnect/qcom/glymur.h
 create mode 100644 include/dt-bindings/interconnect/qcom,glymur-rpmh.h

-- 
2.34.1


