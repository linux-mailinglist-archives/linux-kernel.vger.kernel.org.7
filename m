Return-Path: <linux-kernel+bounces-749546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72EA4B14FD1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 16:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D2D318A3F67
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 14:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440E0292933;
	Tue, 29 Jul 2025 14:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cwE4C6zi"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2241829186F
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 14:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753801070; cv=none; b=ZYTAYridOa+q18p0dd2jQV+Rw297lMRLghGGz2uN9/r1bYpBvNc/mMu25dNqt/MYZEq+heXURhCJcYaGTjEvC2b0vwfG6QyTmjduB/SU4IYx2sjUW59FVLUC9ERl6rbuU+WD/BtJ4ogTCZ0mPMsV5uCm06oIZZASq2SFY2QLSZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753801070; c=relaxed/simple;
	bh=8EH8A9BzE7HOMEuqzDRblValFMLmOx5fGsLpG1xj7mA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JiSrHaxfV5iFUB/aB3cl/Iv7vj7LbbGVOn1+X/ACSnbueM7sugBJdihqiKzGJkqdZ52gG7T7WI686KLx9ieG+aNPgIeM59WHvKvpMiDQHyA5f3T0utk+Thx/VM5aNtTU3f3dMP3qCO71T7jjNMuElk1O3QoMl36Wluz0JQbbkjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cwE4C6zi; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56T9VJvP005849
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 14:57:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=bV9napCh09s
	i1kGi9emra2vbNQVuKZFFrQKfXkn3mks=; b=cwE4C6zi1myTmBMi/zSeVDwYByp
	cSRwkxUl1oaeXRMzSaMvqhpXkRVPK7kz8kHclbNaBDupQMhj61Qp0oUo8A7W21PY
	1v8lIH+9t+BoNHrFJR/vzp1RXA8Km3JIZF0uDZXWnS7jidqhfVTVp9/OCYuV3D7n
	9q3Vjb3ibCyjMjyJbJUDLUFXWBoFkbM7ib1uE/+WBkRVXLPohlGS/EC/Mtz3o8iF
	z2UwZevKN/aF0lmno08TbILqcfBtX+mFS76YbbTK1+jjYjpP0hz7VW1ItKHQWdQF
	CRHhHqA74hzgTv6sA/U+9Vdj+GAOKVLS/UZPWFU+q5MzzJa/9yPAQfi0SMA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484mcr8pdn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 14:57:47 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-748f13ef248so5574945b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 07:57:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753801067; x=1754405867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bV9napCh09si1kGi9emra2vbNQVuKZFFrQKfXkn3mks=;
        b=es6j/4nzcz0Ybd2U7bkG0AMHFeWSZ70ZoVI4467AJFNhHxXKpNljJ4L1hcojcMMbh6
         Btm56H9mkGhdiwn7PUm5JWB1pBiUFquCnShE52CtKt9FrRSZleAD5RqCD0WgIFCp2S9L
         yTZfCc57GFKg5llVio9ohzRY7hbMoRcCxbJSilkS3iXU8ogrHrLsfL0+ao/Wfa3znGqN
         /CMlJA593iIX2BYEHzk/cOzV2qlc/T0/5m+aC7GMOke+MBYpP0nGlVcJBT9CfrVOGaSt
         4nWCgTO/OFZIZOTRgYfTTLdTyobnwvCJW7tfT5C9hbgtfQaeYyarttgj/IoweZdTJw0Q
         Bw/g==
X-Forwarded-Encrypted: i=1; AJvYcCUrBh17LXNilIRppmbAww44LlqiYiIBNGP/EfB5g78TIDISGgvj5y+NWFAm0o1q6Quch/S4KDOWLjLXonU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhFL2N1+9+ajnQ+sHsF6pYDxRQlpTSsxPbQ2ksOTlyjsyCmUni
	p8idAlq4laK1/qizop3Or91/pst7UBWCQWb3DIjsCPTatxt8SyGvnKIT9ySDx/QlepCYhS/RN2w
	Mk1heUq1bEjlKiZiwEMgfj+dVBsJNd5CnTd/oJDYjd9GrvIA0MCXTdj2uFxMMF3r3GA0=
X-Gm-Gg: ASbGncvfYrOVBr8ueRjxazYmkoJC033W9mx6n/w14DXlGVlQRkNWFrBjRR8UraDa6fq
	cBIPSlLMiY62cQv1hteLHBTs8jGgYm7b1iQh/2Phy8PS6ObIn80odqyDPcbI2iRoHPrvegN3SXv
	UZHR/acAvNbkDmbfgk8my8QLBw1GsZ87fGfdw/pM0B+vSzC0PWJ1Cu8w1pjLjf5JfCmmJSnV/is
	ccrqtMHsYnlWhNQHDThtd7XfmRDCDzbLNfu27dwFmC8CkxMqhENBqvf3uxhNkyFi1k7j22WwGrG
	YuDZoiKhvNl9SyA7XDOLvwKuGIPF6wBJga3Hbx/7AHeZJosaAvk=
X-Received: by 2002:a05:6a20:4322:b0:21f:d0f6:13ba with SMTP id adf61e73a8af0-23d6ffe8724mr25354330637.1.1753801066011;
        Tue, 29 Jul 2025 07:57:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkVUdWVY1jgk5W7nGQYN/xwaTvSOwMDc1T4fWKqth8CqZfG64KwyTPkn95VrDifdcVac2c4Q==
X-Received: by 2002:a05:6a20:4322:b0:21f:d0f6:13ba with SMTP id adf61e73a8af0-23d6ffe8724mr25354282637.1.1753801065484;
        Tue, 29 Jul 2025 07:57:45 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:5b3e:de60:4fda:e7b1])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b420db5d93bsm1812782a12.27.2025.07.29.07.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 07:57:45 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Connor Abbott <cwabbott0@gmail.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 6/7] drm/msm: Fix debugbus snapshot
Date: Tue, 29 Jul 2025 07:57:23 -0700
Message-ID: <20250729145729.10905-7-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250729145729.10905-1-robin.clark@oss.qualcomm.com>
References: <20250729145729.10905-1-robin.clark@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI5MDExNCBTYWx0ZWRfX8wEwvSjV3T1q
 iKY4vj5M21oqV4O/cZ4Ac2Bba7qfMdk4UN06TgtZXvW7oGzn55JsOFVJk3oLTSqEhxgc0TtzN50
 sWaqjQaugGLmn4P4XMR3jdF64ALD2tfl31uZtv/wDj9qFsC8gGrlRYcOzYGGGMXdEf8PMUy4VJh
 fVXdjkdiXRD5uMZSNL6shn2veHeESTTMLKg1F29cqrV1OK6nXsp7t8osNkAa5xg9TlXkE8srTK9
 9znkHrBoIz6hphXS0wuSW1guNiz3zZzcqjIlv9/dk+QGiUSnyvdU2tzBnTJaZ+OYPEpYEOK4iNv
 JpzB57LfBW4ozTdlM5SR076jqh2Ow664VF7mZSl6Qb+yI87V+tQeJ3XvnNlwxFAPrwItpyC1eE/
 wpETgxEubetSLsIPvrv6tXHlT1UvjqkOpqmRfj1JLQEWJK6NGIWmlLRsjaWaN/VFmbNZyQps
X-Authority-Analysis: v=2.4 cv=Hth2G1TS c=1 sm=1 tr=0 ts=6888e16b cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=Q8ed3UK4sgpFGPsrdooA:9
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: NUl7ZnPYKHZgaKRMxSxaiB7X_idcD_qv
X-Proofpoint-ORIG-GUID: NUl7ZnPYKHZgaKRMxSxaiB7X_idcD_qv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 mlxscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 mlxlogscore=999 clxscore=1015
 spamscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507290114

We weren't setting the # of captured debugbus blocks.

Reported-by: Connor Abbott <cwabbott0@gmail.com>
Suggested-by: Connor Abbott <cwabbott0@gmail.com>
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
index 8317e1107389..ab9b35e44778 100644
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


