Return-Path: <linux-kernel+bounces-753724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A813B18700
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 20:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA42A6280EB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 18:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CEB828C860;
	Fri,  1 Aug 2025 18:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EW2Ja2EY"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8121DC99C
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 18:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754071218; cv=none; b=fOl7QQ4Z+KgWEBlvhDTNdfaGRYP9NJBHzM2XBihHT2k52lOjZcZJsFLklB/dNpOwhRzaf/fsWcseqe6D3r3Ovmr/DvGk6+T6uk62DH/E6aJ68xl1xukH4HEihWOi/UsHWhz4DVF1E6UnRlEjfb4r0qyDchzxEDWqAbWJbLX4+fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754071218; c=relaxed/simple;
	bh=EvQ+6IfQMsPUowcbChu8GLraQRRsmBVri80l+sOVixU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RAh1LNk3N06K9qv943vEt9NZ3Ts2YaxIc/vrHC0mW38qkUsJ92R78VKJqppcz05zwepz9HnOTQvzYiKGQXHsn5PZV0CViBOyGVDFLJkJLF/YoGan2CbpePOQLNaA37q5jrpQ6jD1a3n+09qaZeUXjAleEEp2mv6W6n7EHTCWNkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EW2Ja2EY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 571HfZmG022642
	for <linux-kernel@vger.kernel.org>; Fri, 1 Aug 2025 18:00:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=iHQTKYkj0qpzUWY7+WEgpg8wdP0WoJQ6dPs
	zuReeFiA=; b=EW2Ja2EYQ2iz82iQwENTK1cE6hsXSob9TuTFT78v5DR4od4kq0l
	bNpMMTYnpLdAR8uTpw3w8ELN2i9GnUHFAkdCmdUYlMiNKUon42n8B4senmalZrpP
	cvNJHyOOE5+O0xqN3mcb5rlLMmraYuS6GmXye3YySW9UG0XCnv8jhi0wtpSDO0ZW
	+D2XPZJLwn/Jf4CjLj3ZXcz2ymo1I4sYq1P6ioognzMkn4eWcPoVcyE2aARzQdlA
	3kmkZnYfdlwejawSvbqrVR1QN4CHuEFAEDu6obhRcCPrKWEavBBiJ+QH8NQZx0yx
	UPxkFdW1u8LQCAA3k4RyQq6dW3KgG2Q1/pw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 488u651fak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 18:00:15 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2400499ab2fso19954665ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 11:00:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754071214; x=1754676014;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iHQTKYkj0qpzUWY7+WEgpg8wdP0WoJQ6dPszuReeFiA=;
        b=I0Dm5R9gacSpWnhZaHkmJUnULuWcRP9jTbvDTVZDQkwdmnL48U6ss/3NCEHm+BrnnW
         f1mv7+jWjZBUS8Z7L/8hirDNd29Vx+YmErImRGEzr2YC9spruguRFgaxhSinbgJyGrX9
         c7+MFa+9CR+5j2gWKgy26ul+j5gSeLFKVLQ9OySfJk7F/XwRe8SxcJfwGiTY8lL5dIFn
         hhD3Chw4hbB2IU5BmaYCWxMrYtu1bhkT/Adm6K8u6DXqqGuu7VUXu6pao0lLwnuYqH7Y
         nJrrL1oxS5n72TAqpkyRbMPr96OEd6B+1/UL7VxkijZ3cDfkNNy1avBJc8lDkBA83fKT
         IxVw==
X-Forwarded-Encrypted: i=1; AJvYcCUIq75m+Yiff70wm7QvUYBVRURVlz6NWjvSU9RXYs5bd8W3uaajUbZOckBr1mCF9aGNb6wE+QI+AuOoJNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzceLLmTdQ4/Jiz2Od8egWdbgs4dPUnpYB27UZBaYsBq4soVkR3
	dxwGP989ojghohLY7yo+0dBLD2/MVldeW77qzHN/SpWrG0lsuTC1JqrKVklvBRYpLdO6OAq603h
	54urH/mPwJo4z0sgmPCs3aV6CGGRhTW6EEQYtAv44rmcd88xwPWYhfLV0O31Am0elD2g=
X-Gm-Gg: ASbGnctiN9GJlJelDiHqMsXvUY+7S/Zj/md4t+T+Q7Rm1ZkSebbUigfnpHlNLSFMlCe
	Eum2p3udLW7ISfzre9v2vUcLAV0OSNK28FvQn1W4zh2tTdSuesjdrY0RoJiLr82rZIElNT6U0TR
	Y4rNq2UXQDtN2boi6kj2qnT4NTkktFyocJQylicURkpeAoHgECRAkbZxnittcPtcDnuh1QWc5t/
	US7A9kXmUzRRMFmLEmVncaej79KEQBhbRSw+sU70u80J3g24YdeAywFCVO/ivWuE0xlPanTmeQO
	XMYvATwwqi8AmSQLDPr2AEwHI9O6ubvKPEcbwuRlI5ZvDRilv7E=
X-Received: by 2002:a17:902:d415:b0:240:417d:8115 with SMTP id d9443c01a7336-24246f595eamr4151415ad.16.1754071213691;
        Fri, 01 Aug 2025 11:00:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIiS1uNtFlKO/TgDqfd33YVLs9CK624JVjnlxU52duE5nqqItwb0e7s0qZCDfogQasU+SoRg==
X-Received: by 2002:a17:902:d415:b0:240:417d:8115 with SMTP id d9443c01a7336-24246f595eamr4151005ad.16.1754071213205;
        Fri, 01 Aug 2025 11:00:13 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:5b3e:de60:4fda:e7b1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef7562sm48517715ad.24.2025.08.01.11.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 11:00:12 -0700 (PDT)
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
Subject: [PATCH v3 0/7] drm/msm: Various snapshot fixes
Date: Fri,  1 Aug 2025 10:59:57 -0700
Message-ID: <20250801180009.345662-1-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: K8JmTYvjAeQQl-qlJpDPXyTbUQwN4mcn
X-Proofpoint-GUID: K8JmTYvjAeQQl-qlJpDPXyTbUQwN4mcn
X-Authority-Analysis: v=2.4 cv=f+RIBPyM c=1 sm=1 tr=0 ts=688d00af cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10
 a=w1cFhwVCMIBtwBHhTYMA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDEzOCBTYWx0ZWRfXwXcom4MMUo/8
 vSDtWMpxMwHhUfJZy0Zn/6IIbF6JgG0rKKDs/uBD/xM0fJBko5Vd6sMO3FbNQACfGtMeI0KQmGv
 PL/v66p0d7Nf51dztLgULYasOY6FELxAviaikh6FmRNlTxHj5X/eDwp4bz6DNFqI/dq6dw64fAf
 LUaebQyoDqIT0HEframmQS/1YPv2yZ/whYzSZ+D7tjmzfYaGPSWtneVOUfQylApV0XdCN6n8oZ+
 HYD7IGHeoyVulXhe2Rf/10KwEbhHdpsClzbXAKP7FJWNFRxm0iZL74jA5Xmq5P5ZYHPMpOmST/9
 pU6DjM8HzcqYsgkGhk9gKNZ9QwDLvn/58Lr7CdXu1rUQ9QU/ffFTYgwB9yP3ufv2zbDSvLImAys
 UxulKGtK90BHyID1hJDziR+jF3lDR7uepMG/mgBOywbqFHDq+a4Jm4Fp2nrIFZdJYKWkMLXq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_06,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508010138

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

 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c   | 47 +++++++++++++------
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h   | 38 +++++++--------
 .../drm/msm/adreno/adreno_gen7_0_0_snapshot.h | 19 +++++---
 .../drm/msm/adreno/adreno_gen7_2_0_snapshot.h | 10 ++--
 .../drm/msm/adreno/adreno_gen7_9_0_snapshot.h | 34 +++++++-------
 drivers/gpu/drm/msm/registers/adreno/a6xx.xml | 14 +++++-
 6 files changed, 101 insertions(+), 61 deletions(-)

-- 
2.50.1


