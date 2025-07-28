Return-Path: <linux-kernel+bounces-748583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30894B1435B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 22:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 084FE3AC648
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 20:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0BE2264BC;
	Mon, 28 Jul 2025 20:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SOV+dHYK"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4522E219A89
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 20:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753734861; cv=none; b=WHu6N/FeRJMttGhjkSi2H1mBssrP6z8kCq1w4IEc8MrhRvAGAUx3o46dry+S+LDXQxyOt82oQnQbkfDeBrhlAxpWbH59eMQJpYNKLPFfLt0TC+qLXL0enzvJ8CvSROyhG6CoqMkYxmnx0eCNOW9HHl6KNp5O2OyU+5LZ9fa65l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753734861; c=relaxed/simple;
	bh=cKdFC1SVSPgpyZumkMcdQr9+XbDPl6Xq75PSfnUrhdo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QL2BnCTDYC/A1skQyMagDGvr9O3VRfki3IMZ18EBzmcxXt1DjgMkJAfmaNbKhig/yU84LX+tP1F9c4LxofoW269UpJbjILPS14IX+NbMswreXNrpmPRVVxdKDzNAMgUI2fenH/cVeu2VXw6u1WYbHQJhINNpJSALQQGOY3SrLc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SOV+dHYK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56SAlWNk005322
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 20:34:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=Vx9YOMF9/vaXXfGAitKrXqT/YmN37duAwQA
	vLpyxaqo=; b=SOV+dHYK+WJTfpTVBLvWtAMYbSlZzjo1WkmIzRaTjaOOviYOA0A
	JvCLdsPn/jE/Nncto1gn36Pyynu6vdxV4ForI/qlFJmJEBquwn3RKP3qSU5JwLBK
	arKBt2Hcp1qmIKlrBjlnIzYmqQEM7S71EdGONwPlvqFTy2vIHJzS2iExCf6Cwsuy
	YAuqT4JtQic/ytbL2etrz2qokMFPAhR8HBtaTg950tIshxXTwuCEF5Z1cZx+vbFM
	6RYC0rQNVKPUbOKSDw1vteVC+4IF01RcxlWMcNPyXNWiTHcDx+AmWA4AG9hvvWn+
	KGCxEfVezrIa55qdmphmQUCPa6BTNXRMDFg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484nytx06j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 20:34:19 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7492da755a1so4328253b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 13:34:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753734858; x=1754339658;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vx9YOMF9/vaXXfGAitKrXqT/YmN37duAwQAvLpyxaqo=;
        b=G4aJVFlYADWb8YT2Rzy7xZlQQt5pyZQbAkpbbIhW9mcOZvB3BNsGgV+19BYInOkVjq
         fhqksXStfNtzybpjNn5t+Mxyb/2obCxx+JhDUcg81MKa3wsLtxjLJ0E3znWatrpNaCpJ
         4uvCHqv4/5Qp/WuSpcOYoYyAg6hhUx+RCdkFCs/b5qetuXVnkN0erWkeaBD2r1/5bDyf
         hBkNF5mq282Ose+UXqGA2iteXYgD5mFU9kez124Vl1sTJP958mvzrxuMQUD7Q8h7fJRs
         IdnJo7kXJ20fQzwLLdqP4kju3Shk1DCSVdcsZ8fF4SVWrQNQPR7R8J8JAjiA6CpJXwqp
         cJbw==
X-Forwarded-Encrypted: i=1; AJvYcCVeUBoQphr/YoygZJMywQsnVP3lKQH+ee/hjShpsV6pDvGl4V+TGyt8dJbbgq/ysmrg61F9cZ17Y0k9IYE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7u0sisWi4jTNcNcokLfwPxkyZpP4lmttGfAZ8G0aTzBD7y5/y
	vYlDbIr7dNKtiOGoe8tKcETh1NK5qLTLE3580ct3fSMssIlS2f+ZkuCfGkT/b/M0sfiUXn1EXrP
	siLKdIfo/0YTfl257bb2X38D83JaKqqOxbn/+Zgl/dmIfZbvZyM7m7DCh+jGHRBx9wHE=
X-Gm-Gg: ASbGnct211K8KwetnAuxlWSY0Yt2rQUmppFm+B5zaJsC8EFiSWT8P7f4jnkIormo+b4
	9tFK3ZNl4oysKItODSMUjzxwITYyAKdVpyXlp8INpe/Qb2qOpj8BrU9q0b5cS3Fb9jTQh7DZZmj
	GK9sbMc5PAQlJU9fZEkUnZsboxlmZG/BNCajRV7zR9nKV4L37mFM/9ly37j9HZTOk9oYpnm+bUa
	pR3ZDkCmotG2ICN2pxw49q7r8fN0WymhnWk30OZ5h64xKvtAxHq7eWA3SkAl+MdqrZsRYCh8CyE
	a1oNCFlycDgTRWdvSH40Yvo5jnJv0e5UFsVapEl6jrsxqXDbwTY=
X-Received: by 2002:a05:6a20:3d82:b0:238:3f54:78ef with SMTP id adf61e73a8af0-23d7020a87cmr21229908637.45.1753734858339;
        Mon, 28 Jul 2025 13:34:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2NfubVkX7OmnivNJmSnmau6UKEHaNttBxrPWDyk7ZRlG/54KN/lEb53AfFRyD8rGryWhf+Q==
X-Received: by 2002:a05:6a20:3d82:b0:238:3f54:78ef with SMTP id adf61e73a8af0-23d7020a87cmr21229878637.45.1753734857904;
        Mon, 28 Jul 2025 13:34:17 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:5b3e:de60:4fda:e7b1])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f7f6ae43bsm5545654a12.49.2025.07.28.13.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 13:34:17 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        David Airlie <airlied@gmail.com>, Dmitry Baryshkov <lumag@kernel.org>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        linux-kernel@vger.kernel.org (open list),
        Marijn Suijten <marijn.suijten@somainline.org>,
        Sean Paul <sean@poorly.run>, Simona Vetter <simona@ffwll.ch>
Subject: [PATCH 0/7] drm/msm: Various snapshot fixes
Date: Mon, 28 Jul 2025 13:34:00 -0700
Message-ID: <20250728203412.22573-1-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: bljP4hMRnPtJQswIYZDlPfiu7P_u1XEC
X-Proofpoint-ORIG-GUID: bljP4hMRnPtJQswIYZDlPfiu7P_u1XEC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDE1MSBTYWx0ZWRfX4qhDxULZ7egX
 AZdlhaWe7JXtw0M7+xbC00CndyBxSalILr837ahTxfzqV3+UGRIi1uLlWnrbWlGUCXbMua0cQCa
 t+9CFsOfxcM1RDkhTJ7qJBTrvnh+S2exBc+zFBGe8VCz5VHBIF+2Iua4Xy5xsXSaVlsTsB2sqHc
 cxTswU9/FMJDnwR5mZ3rz7biELx7abzif8iONPmpekgJkC8tbh0y5JlGrUPoiFm5Jjq2Jzs3ZXd
 kJhiuKL24a86+e2OltAL4bg1cU8DXmM/6FgYZCkIpK5s+WwImpUPxEHEbnELdDyZ4lVsv6r5tKl
 ZpOh8zwxzBGQJoMEfax5g6H8gvtDN88chXrDHXkM4G/rdKTQjnWHtNaPZ8hInPqQgR2Y7C+UWlJ
 L0JZ6F5B3sZ84KaYnymc0sK1QrXEJwdZKWSaTOc5ELFVtr2L34fpw15+ZXDzlzSHImVTd6VH
X-Authority-Analysis: v=2.4 cv=CLoqXQrD c=1 sm=1 tr=0 ts=6887decb cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10
 a=w1cFhwVCMIBtwBHhTYMA:9 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507280151

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
 5 files changed, 73 insertions(+), 54 deletions(-)

-- 
2.50.1


