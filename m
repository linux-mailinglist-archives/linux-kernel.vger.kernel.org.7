Return-Path: <linux-kernel+bounces-748588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BDA9B1435F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 22:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57E56165D55
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 20:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66BFE27F18F;
	Mon, 28 Jul 2025 20:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Zn/Jihe6"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1F027B500
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 20:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753734868; cv=none; b=DsPwJv/+ac91/6ziyiT/icGRE9pK9j7axypw6k/Fhsf40ydh3erZf7tCnu9lIOYbXG74rjJXZTe3Ivz3oT29vzsUtnO3nJ60cXYvuhkCmeEH+cSPKAEJs3cD7OD2RlUJXuMoS1tWnetqMh7uocfkSPn/Kv0pvx0yH5XSe9cQj0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753734868; c=relaxed/simple;
	bh=8V6l3AP57/Q2ToIGiQ4XYsiXilViuzjLKRtk6DrANT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oQNkbxJO+EOozgfKtGGc/IR9oshA1Tolm4n9rcfOc1VeMjr/8yEMqdw5iYLLMqcgKw7Y+eyrgALOzBmzoGdDv2XteeCl+8F2KzliqTC14Rj3Jj4gl2tba5PCw6sXeM6E91cTAvmUgeAhi0wK3v/y5GUtuFZHA5HsOQmR628/TYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Zn/Jihe6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56SAlLCT027710
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 20:34:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=I8t+2xKA9TH
	HZTmJzGvWTh6YVgWzaeQG0zONpcACs58=; b=Zn/Jihe6d+bzp6z/IcaME1UWJC5
	GillVYY1LDFxQ1lU6yCMRy6zJ9eDOUpeeLk2BDSfXrjIDPQdU1oqHMxhDHUsX0nI
	fZCvXDNCn/8+y3k9RddhKe94kfDoKawqT6p4oGEaMFFBNWFsM6EimnAHT4AsWrMB
	dXERVW8mi4U+Fe3AXQ6Vtouqcps7GtB68ykAow32KhqSJkp//9DAi0pnIbWeMyXV
	LuVpFO5gOaYg2vAnHqZpHBPj5eh1ubi0qfopGR/VIPND7xH/AgUkfWI/FyW7tP5j
	g3LLkwIe9X4zDktg0zi+FtTf7taMjldos6ut6xJp+zya5amVH5tQ33zOzkw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4860enu0h8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 20:34:26 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3141f9ce4e2so7616217a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 13:34:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753734865; x=1754339665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I8t+2xKA9THHZTmJzGvWTh6YVgWzaeQG0zONpcACs58=;
        b=P1nueIoORRnUPtfxcGWiJ7tjI657yJZ3knz3WnJYaIuB08SYF5CtwfNQSZJC+ITVbT
         rv20iaeitbc7XDq/4Pk3CTpH0W/P6CfS0hi2Gf4EUxCqhL/LrUatyN6emPihGb478H4r
         vZCx6kbELOqqRfwO4gOXcHzsxzE5fvWJWD85GWZxzG9OjTGLMVWOJtzNai3wF9qQO17e
         hcb8SDnB57cNFSNi8HkuMi0rSM1lvBdjDrDctRuowN4g2l0ecsIIpWFxyZ6SxlVt9AV+
         dOj28zsBSYl4zkbmITrUJI+2312x0OZHWeBNWrj/+8qWlkAvXi1r2AMmVix7YGwYVp6X
         ti1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUEENBLxhFcTNGirZzdjYkKbJI0AQfUe1JG26vmav3gdZptC+GTU0DA8olBY9ehSjw9sFkTqau2uomsXJU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEcSZYTPEbvvjSvSJlAz35ugoz/ZgnA68YDZnRTWKhKbJOMp5k
	9I7k0CJXt/xBdfzUS9NQcu4+R5AFoQk7snQRllNK67XaEo2yHS48J2j8qcmOvWKskog7lhPoD8S
	htB6d1TKGLcqzjpWjOmRfVBrHfxO6TQv6cNTGjxkf311TrTivrpE9S6ZOJoNWQUm7VHjWjzZ071
	E=
X-Gm-Gg: ASbGncv5bQrZvgh5ssNA+XcNS1k9HsTa1r4CHhbGNpP3Gl0zQU6RYC95qVD6qELX4FR
	bO3IHCfkGADlsvomECW6MTKpBcnY8fmVfUwu/XnLEJ7eImM33vL4F6dZdoYPm7ETLeJ0EdqEn/n
	jm2n9NisDNssGN4hTwHuQ5SAonLHiopvO81MQe7haoIJCd09BBCoFjs0Z0rMwVVkxtZsG5FLssb
	3c5GW4vMNaG7SwrE2WG0bff1vefXoifHwr+q5Cn/Utzc0tsfyUYvIs3aQ3MSYiCpNf3ZlepVoUw
	SCZXNujRg2pnoA4fsTDN7POjRI9j3eEQurX+QMsu6Bc0+cErcaE=
X-Received: by 2002:a17:90b:2409:b0:31e:d2a5:c08d with SMTP id 98e67ed59e1d1-31ed2a5c5a1mr6681373a91.33.1753734865324;
        Mon, 28 Jul 2025 13:34:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdlbZQJgZiV/klf4QMEE5MCR2s1YEQimkMRUs0qJyT+RaCeltmukYVdgn4Uepp3jzkO6MZlA==
X-Received: by 2002:a17:90b:2409:b0:31e:d2a5:c08d with SMTP id 98e67ed59e1d1-31ed2a5c5a1mr6681351a91.33.1753734864911;
        Mon, 28 Jul 2025 13:34:24 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:5b3e:de60:4fda:e7b1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f00e778f4sm2480959a91.23.2025.07.28.13.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 13:34:24 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 5/7] drm/msm: Fix a7xx debugbus read
Date: Mon, 28 Jul 2025 13:34:05 -0700
Message-ID: <20250728203412.22573-6-robin.clark@oss.qualcomm.com>
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
X-Proofpoint-GUID: BadAC2VHWj3_cveHYJ0v_Av-h0WyN1yX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDE0OSBTYWx0ZWRfX5xXn7lvvIySq
 pDpWaDk4CihSyt8c8GglcE3dBEXeEjob9TiL4UittMztYrv8mELYsYcRUY9MVa+bMw2Mm4RREJ0
 SN71wCFV8+Ni/FQLK4Wg0af7z2hSDUCE8AJb7WA2hakPFnmLrwLH1vm/YP26NxOo8vEqnzPwVHM
 AxlTvpVic3nUf0BHBo8jRrgnLlO5PJpwd6I6aOqMozcy+9FRUOCANnlo39OHsoRAMP1blDFf3Ox
 7ltlE03qnP8bA002cn3HA9BE37ZleSaF07rpWRZXCkrWqYNJhb0ekmRiZ6JT4ZHGk1J7NLZw3I8
 n+vbfm/726UOydKYClhzl5VmSdzPBJTeHNmTS/WvnHL7FbC0rSyEQQjkA/hN3iab84byYRDxhpc
 t7CvJBC3cOKDAENqXEnf36NHk30g0vEEC7DdsdapL8Rosujf9n3WfdZQEOM2JzfBuClxXFkT
X-Authority-Analysis: v=2.4 cv=DIWP4zNb c=1 sm=1 tr=0 ts=6887ded2 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10
 a=EUspDBNiAAAA:8 a=E4Rgrv4FocJ6r0LxV30A:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: BadAC2VHWj3_cveHYJ0v_Av-h0WyN1yX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 impostorscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507280149

The bitfield positions changed in a7xx.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
index 7ba7113f33cd..33df12898902 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
@@ -174,8 +174,15 @@ static int a6xx_crashdumper_run(struct msm_gpu *gpu,
 static int debugbus_read(struct msm_gpu *gpu, u32 block, u32 offset,
 		u32 *data)
 {
-	u32 reg = A6XX_DBGC_CFG_DBGBUS_SEL_D_PING_INDEX(offset) |
-		A6XX_DBGC_CFG_DBGBUS_SEL_D_PING_BLK_SEL(block);
+	u32 reg;
+
+	if (to_adreno_gpu(gpu)->info->family >= ADRENO_7XX_GEN1) {
+		reg = FIELD_PREP(GENMASK(7, 0), offset) |
+			FIELD_PREP(GENMASK(24, 16), block);
+	} else {
+		reg = A6XX_DBGC_CFG_DBGBUS_SEL_D_PING_INDEX(offset) |
+			A6XX_DBGC_CFG_DBGBUS_SEL_D_PING_BLK_SEL(block);
+	}
 
 	gpu_write(gpu, REG_A6XX_DBGC_CFG_DBGBUS_SEL_A, reg);
 	gpu_write(gpu, REG_A6XX_DBGC_CFG_DBGBUS_SEL_B, reg);
-- 
2.50.1


