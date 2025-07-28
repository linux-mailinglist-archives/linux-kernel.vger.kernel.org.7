Return-Path: <linux-kernel+bounces-748589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B986B14363
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 22:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42B58169708
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 20:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9778E27E04C;
	Mon, 28 Jul 2025 20:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gxT81nkX"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50ED127CCF2
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 20:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753734869; cv=none; b=WWzg6/D53bqbJ7s3+ilx9CMbkmt5ukyhtFCbVXx/FYvDjLXmgm0kJbZdfBZU6FidjdPoTkSfe2Je/gvadFSSj584+cNZAuANdKon+ZQjEfEOTgVRh0ykCkmQu69ImEuBUYx/u2vlAABP0WSNQS3e/yj2oRVlp18wUX80Y9AU4r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753734869; c=relaxed/simple;
	bh=DkcFgrXlcxwrYVvJKTGLyt7PuaR841KGpI8Wprw//10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H1nLc5J3QstHhiaTMHTna1kPdwyaDHaRQgGlC6XzxlMDm6DzgrdfueJyYMT07kLuLEkQtO3j15ij+kwJ9In6IQPHDtTs7lq1lOXGuyu+A7xB60UjmOxfH0Lb/9/oj5mNQxqUPQzf53aIcXXxbUV+O5QEOeD4ExetRw4BDLRzR4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gxT81nkX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56SAlMAG018859
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 20:34:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=9HL2ElAARF0
	/fbev6G08+6TVwHe8Nc/ReEeD7pJWGHU=; b=gxT81nkXjsjgayio9XdonbnMeD7
	L2+voPgFoghEPofYHzvzSJ3hLfkheUpUwp6AJecqOkRU/RpXsAyZVmft8OLRHRnp
	OSDvwcAEzcHv/ElcJ3SY/f1Qbxxtxxa+xYZ4qM17D4MU5kHoyDqkRFBXqyE92xrg
	DENhi4NVNJJ8NBdEu/wuWBSRQKoO9FfrcFszkovsvso92EplmAaXrABkXkSeOgXn
	fWB0pahpyQocRVNF4ucOqG89ghmh/G9mxs8epGopELP7oQ97O6fGXcHyR6TM2+G8
	0SEehKRpk9xWcynZbgpAh4d1yU/CcuhsMleGjbACtCb06aQ1m8BJo5lihjA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484q85wu31-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 20:34:27 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-31f2dd30823so225723a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 13:34:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753734866; x=1754339666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9HL2ElAARF0/fbev6G08+6TVwHe8Nc/ReEeD7pJWGHU=;
        b=JePXXzAVcUp5HBWrAjM0CoUQNUtdBHpKt8Mn1Ic/BZvwyU1Iw782h9JZeeijsEI/kB
         d4MwcR9+PUkYfmXwQteZrV1aTFHVkgEQaUKxSKPqRe+CjQh+eAZUh2Zxz0Os3Kn/iqU+
         rTtxvR2it9GBq7wJzjXU1WqNV/4QeX/Nl4fg/YFiEzdpO0jyM8H9rsAy7ChgVHUxZg0B
         DedpW8spoIoao06DqgGh9La5hYcygfxG1exbBUBrR2ZEw8B3ujD1HgPqOmyTFv1HGWfe
         yUEsvdlUITRI/MoflmglHJZ6ZLTie+0l2zUzxgheZHaH2CNHhJJUnTcRyfOH9yIXaq1F
         XtOw==
X-Forwarded-Encrypted: i=1; AJvYcCUiuH8sP2/2NQPNUudfNO7xoWNYUnxF9tYT7PKrQC5OFoxhrmlSN4Vrt7MeU9i6A6C/i9rXtjkyZH8GVmc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfrbZGWg72iV1MseUT+LN//dQ0I6QGfqTboE7gQSJwk7HynXza
	DkYWlUqawBHT5i07Cw7Bb6DsJKWlVoISLeaafmSfnCLGXzKwrKHP5UtpbmKAd2Ayj6sPx9qp0UC
	fHfzKhbJWPxsz0xGqPpZAZpO1sWi0IjDgQMSmDddqUK6dz41Cmhbt9n/XRK1Exe8fFkI=
X-Gm-Gg: ASbGncsCrMKXDpI0LbDjHE/yJ7OOwlimXMRWHPyq/jsLXFbe+e1zMf0r0rjQ5QtOiR4
	lsJdNI9l2u6BWq7D1N5FmWT/cnsJO2y/nB/rwwm5zmsGOUc2O+Q6tAQ87QImSlAEVIqJ0FBO3ha
	HX5rMMkqkMTHcbVh2xMBv4A8NUcskTVkVdcl2MWsDDMq7YJysuwUPDyVO5EdvcHM5t+K1Gpxas+
	h06KYmuZZzMTd3AtBVIWi38p5Uuxs1UFtogOzcmvHJcU7UIEeQykF6/IOEy9EHM2hJ/Abzv8Bp6
	uOHOAu1S1/KsMHIuk4Re+GdquLxnQfeP+FF64rOhyL5+c6ngtSw=
X-Received: by 2002:a17:90b:564f:b0:313:1e60:584d with SMTP id 98e67ed59e1d1-31e778582ffmr20598902a91.11.1753734866629;
        Mon, 28 Jul 2025 13:34:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEdJ9/dscUM4BqdHSg4PGTK5hxCSdAWWgSIKT1qLZOsCkP8tbWQs3GjcAPYzq2dmolO2Bt7g==
X-Received: by 2002:a17:90b:564f:b0:313:1e60:584d with SMTP id 98e67ed59e1d1-31e778582ffmr20598863a91.11.1753734866210;
        Mon, 28 Jul 2025 13:34:26 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:5b3e:de60:4fda:e7b1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e83545d23sm6505289a91.31.2025.07.28.13.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 13:34:25 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Connor Abbott <cwabbott0@gmail.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 6/7] drm/msm: Fix debugbus snapshot
Date: Mon, 28 Jul 2025 13:34:06 -0700
Message-ID: <20250728203412.22573-7-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250728203412.22573-1-robin.clark@oss.qualcomm.com>
References: <20250728203412.22573-1-robin.clark@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDE0OSBTYWx0ZWRfX4oGML3raIRg6
 HrB8uFEy7rBfECNZhYSkyEeKrajo3633iXGvY8QwU8XqgwoFTtAZg4o34ycihb4VnpShIBx6lk4
 cepcCINoq/Lse6gvFrLl6/S/y0s5xjJR8Y+IpaZUvl39shmwH6aX2ZQ9OekvxgnDORBr5Ob2qMi
 5YulHBu0BQ/9OKttft2g3nD9QNtMNi/ycSSXVVLfzFtsgO0d/jOWStMOkcvRHN8SV6+lp6+4DxP
 +82zEPPPvFna8G0QN38Acg6Wj2huHqkkxcvv6unlKwvCUrSpPADd1zm/89c1HfdEFfg4hOpamBL
 d4Jb2kdU19bhhMTVatNSXjRBlzBxsMDYWca2corvMrC0FAEOARWQA/UJ2EDtAeaLV4hDqv8lUnm
 3OfVv0UPMCaRb8VCfLUwYue2uq1aRCLWZ2GCqYEGLQwbEyyZZmKaPdAJ4fneb4Ac6P3mcC4A
X-Authority-Analysis: v=2.4 cv=TqLmhCXh c=1 sm=1 tr=0 ts=6887ded3 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=Q8ed3UK4sgpFGPsrdooA:9
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: zadFZwKJzpzcBZGeOIqvyBJpWQA4SZNL
X-Proofpoint-GUID: zadFZwKJzpzcBZGeOIqvyBJpWQA4SZNL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 adultscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507280149

We weren't setting the # of captured debugbus blocks.

Reported-by: Connor Abbott <cwabbott0@gmail.com>
Suggested-by: Connor Abbott <cwabbott0@gmail.com>
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
index 33df12898902..4f0d8c0e6ac5 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
@@ -430,8 +430,9 @@ static void a7xx_get_debugbus_blocks(struct msm_gpu *gpu,
 				a6xx_state, &a7xx_debugbus_blocks[gbif_debugbus_blocks[i]],
 				&a6xx_state->debugbus[i + debugbus_blocks_count]);
 		}
-	}
 
+		a6xx_state->nr_debugbus = total_debugbus_blocks;
+	}
 }
 
 static void a6xx_get_debugbus(struct msm_gpu *gpu,
-- 
2.50.1


