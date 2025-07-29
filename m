Return-Path: <linux-kernel+bounces-749540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CD3B14FC2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 16:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D6447A6791
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 14:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99719285CBD;
	Tue, 29 Jul 2025 14:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iwrQamTT"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539A352F66
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 14:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753801063; cv=none; b=o3t7X1y6tIEkLcDYg/NEPUnxTH8GjLePpPIbIqYkeLAp3F5q7w5gOxl97TYBmNSMAK4VwTnQA9JP6d4h8XaQcOlgChaDQp63R2tMNbW8UiUMFAFHHjMd7raz6MRL/gE04ht7C/MluYOdPkvLYr2rYt68keJBOWaDOUtos1WHzko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753801063; c=relaxed/simple;
	bh=vbFmQ/+esHqUIOpLQSHDhOMZseDsbrI+zmf98HJ10M8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tDdJIZIXErmWbmzlh4aHrW0ZbZ2hQ8qESCinThjHswcC8Ktt2SykpkxygxZLVWHuJdoEB3cKOft1c6vw5QfLcKOSus1TAlX5JMYiZaqhyLx+JLhlZPjPo28LlrhGz/iEhlKw+Lr0Mbr2Po2LWiPA61Ibx4J/6NEfnWxRHJydls4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iwrQamTT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56T9mmTw017661
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 14:57:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=r5UPSy+ehArJ0kieZ3fL0Y0tSoDuquiGCGJ
	+T2zz/U4=; b=iwrQamTTYmbGr5OuuQJyvBsvyoBJHBz7WmIenzJNu2bJlTmmqUt
	14wBqLSUfgr3VZj6ZS7/vDOFRcQln0hnbbhSMXXMYlJePJLhCvjqeAqCyaRcHT18
	vF0eqM7eyZJEkgMZzDot1ZGpOqGhT0sEe/Vt9zqQqDfVCQuY9wvN/f5UA2fZeFg7
	wR3VV2bc8cP2zA0Auyal7KvfwJsdnTHh1Jbp3BYDyRQG6+Fr1ES6FMMmv17vWw80
	Mem4gyOpU7iLgGoUntkNLusn5OtOUMd5vMdhAi13udf7EAnCsMS9EitRv7PrfOBv
	Ax4VJQ5klh29ZlNctBDciBlm9va/9P34R1Q==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484pm2gejb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 14:57:39 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2400b28296fso34889265ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 07:57:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753801059; x=1754405859;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r5UPSy+ehArJ0kieZ3fL0Y0tSoDuquiGCGJ+T2zz/U4=;
        b=DFLsCYSVCCVqJw5lBS6mswo5vCx2cz8mdO6N/qG0c9oRIItrcfL1FQkUF3NKQKDE2c
         KcTQFYFhhDeiBWsIuD2+ne0Vav7H3yYuVB4buSy7zDGSuCJJgWb3qRa9SEN+Y5ye9f8R
         wjw3qiTbUGUhlztTv18j7NjS9Si7/He3upSCkMQosmjlY7doj/TrT2cOz5CgpuQukq1I
         EMvd1V0n0AhvSBGPq9/iwhz5DHWxYujFddF0ZuTP2UtVyXmtm87qfmyoMuFWxVgAcXmy
         wLJNmfOp/D7N+4y+vmht+R3hAHJABtviTIArvNSvjRbPHQOysQhKbWSfUCa+L1UQMcmL
         5Vrw==
X-Forwarded-Encrypted: i=1; AJvYcCXN5huU8wTmUELNwjhIoNpyCRsBV/GguBJ6qGkHsrkHnKffysBiUqho/sgSFnF/GUq5d2dz0k5iJszxcLs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPIs5JoZIZJN7Xy3Yplv21XzhRhJ72SyoIrJkUErfzYw0Z5M43
	BQvutDn0svdHko1cJZ2iq+Dvsr58q3/nBrMe4IKP/YHqNvFakUFaF1UW/nywwqf9chvgKQmhdMH
	fEduBFXhvTpewGsctE5ZJR9MVjFXVXh6kDQnS9+p2EKN9LxRQzZopTX8W3CXsSp9Dnps=
X-Gm-Gg: ASbGnctKcy9I2V3PohLC2q1Iz8fj3Nm7vBcb7kDVPYLiNHcEH6mTR7fmvULBFEx0d9q
	nvJoHJ1ogAJmSIK0R/cARn/+umFx7oaSrs2scZgUNarjclYUljPcVDZ8rhLUOHBqpfg15W/B1RR
	ToXlOWEjn3GSSYQYxTyeyYA8pA/cFqqyaC/GaGy6s86Uk9iJojQ+VxtB5OxVjn74LCaV7Yvs7fS
	vI2GePRbsWTOEpg3Bd5Y8NOpc25NdJm8rxLjjiFPgs7p5n96nUXR/LRRf4Tf4LDLHvkXtDevPII
	5QWF/K2wJaxjPgrYodHfQrYHIOO0fE9+jn2OxOVFEoeKS3X2+t8=
X-Received: by 2002:a17:903:283:b0:240:6740:6b11 with SMTP id d9443c01a7336-24067406f22mr49778075ad.40.1753801058361;
        Tue, 29 Jul 2025 07:57:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFQovZlrhwFov5F/FdQdGq2gSTgHMjBMBeH8Fux2H9TUnRq58+154f4BSUz7QjrZqjwgo7yA==
X-Received: by 2002:a17:903:283:b0:240:6740:6b11 with SMTP id d9443c01a7336-24067406f22mr49777165ad.40.1753801057121;
        Tue, 29 Jul 2025 07:57:37 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:5b3e:de60:4fda:e7b1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2404483f5a0sm38202595ad.191.2025.07.29.07.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 07:57:36 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Connor Abbott <cwabbott0@gmail.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        David Airlie <airlied@gmail.com>, Dmitry Baryshkov <lumag@kernel.org>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        linux-kernel@vger.kernel.org (open list),
        Marijn Suijten <marijn.suijten@somainline.org>,
        Sean Paul <sean@poorly.run>, Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v2 0/7] drm/msm: Various snapshot fixes
Date: Tue, 29 Jul 2025 07:57:17 -0700
Message-ID: <20250729145729.10905-1-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: jOfzR7z4bleaXf6xaEYtHV1d82teGwgE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI5MDExNCBTYWx0ZWRfX2zyy8qfVFCIC
 C3ashEAgJRMytSRyL3UVnMto4gj4HywJ5kkXLAA0JICdI9CAL+dgo3xr+5E1JXedyzyFKEPBfbs
 Zw/hujk5nJxiZzwK2AvHoKw04Dd7KROj/OJ1I9xLLEhVyQwos+vPkfBuOymDMDgwOS8lVXjRo9N
 YEZfeKt3RlszGVroBg1SnS3sTfzjCLNzmXxhus7PYQFSuOa5qGdAaVJO0GnPwDdoT8u/q38oZtn
 /EAU1gHJtnKcOk86Iohycl8OK6crGtRBfhIBd9Bchh0rgdqYwQvu9MIgqHOlbnK/EMT1ot4Qq6z
 cNNfUXumNGBhvUK+Qy1ydSqEMeTiD0GSJugRplTJ6fUHKaYhuOi11KFX06C0QrakqVy5vC+k8Hq
 pIGWry2VFJGJLxHwAEpQ4o7qR980yYcxzCUm5MOd1vbteSfg6YkoC6nDBoEngfx+6yLQSCQW
X-Authority-Analysis: v=2.4 cv=HfYUTjE8 c=1 sm=1 tr=0 ts=6888e163 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10
 a=w1cFhwVCMIBtwBHhTYMA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: jOfzR7z4bleaXf6xaEYtHV1d82teGwgE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=999 phishscore=0
 priorityscore=1501 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507290114

Various fixes I've found so far while ingesting upstream devcore dumps
into internal tools.

Rob Clark (7):
  drm/msm: Add missing "location"s to devcoredump
  drm/msm: Fix section names and sizes
  drm/msm: Fix order of selector programming in cluster snapshot
  drm/msm: Constify snapshot tables
  drm/msm: Fix a7xx debugbus read
  drm/msm: Fix debugbus snapshot
  drm/msm: Fix a7xx TPL1 cluster snapshot

 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c   | 26 +++++++++----
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h   | 38 +++++++++----------
 .../drm/msm/adreno/adreno_gen7_0_0_snapshot.h | 19 +++++++---
 .../drm/msm/adreno/adreno_gen7_2_0_snapshot.h | 10 +++--
 .../drm/msm/adreno/adreno_gen7_9_0_snapshot.h | 34 ++++++++---------
 drivers/gpu/drm/msm/registers/adreno/a6xx.xml |  6 ++-
 6 files changed, 78 insertions(+), 55 deletions(-)

-- 
2.50.1


