Return-Path: <linux-kernel+bounces-748584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 265F2B1435E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 22:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC7403B9B86
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 20:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9A02750F8;
	Mon, 28 Jul 2025 20:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eVH+Tlln"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466CD2222C0
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 20:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753734862; cv=none; b=dXK0Mm3Ntxo81uqEZ9hVmgOpIwSuX2iMhXnSZSzGui+zAO4JE8UCwsYVZKRk7/R8xm54PH7Cod2Kr1OILxrbzA8tRUT5Lp6LxyqyZKEOR/Xn8U+d8y0Cd1QHwaW9FaQPg9WKxRi6pasglkThXd/+iMLmdmTBYWkYxPBQvbOjt4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753734862; c=relaxed/simple;
	bh=U+ZmNomacuLxHtKNQVm5cEtjh2nkXR65mIV/H+xO5dU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f21C/FW9QVCamAJxigoGUcgwKczXdT5d2Ex5zNVzsngxI1B5hPhDnuy6bXSmGIHo/AWc5qwdPHUZJhOyrmlKEWufaM6enEdy829hmEmvjxEFJWBtUFlTP+Dp20yy7fmIDnCdiDteuTgsK5I+6bQfVe/CQQmHNkBJWjKhssCkibg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eVH+Tlln; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56SAlNfi023471
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 20:34:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=A0+lIarkug5
	bI2XIrG4czP8gMx8w85UfEvs/RUlisrI=; b=eVH+TllnKQmh+pn8Li5q7mtiA5r
	teO23vGhVz372m5F06S0sneA01PZmQMLBtOr8PfuCtm91UC36diTq/BDvYfp+XLA
	5N1ZEnGSAQXZM+4m9q/aDRNCo3RmdCv1oPm8T3FBVEMgYMjgecjbMpMg5co0uatf
	EPTF2cqwM1bX6qYjJWKl3gpxV0mgc0ojGUp367vC+bLp3eNrozTEBMXhw7N6ETN8
	JHCWo+poPGUf5ci6hKgPHHefemzZGxSAGn3tG4rsN0tJyj3JCziNmAnoOoGcAmnx
	PaXB5VyvIAGDQa3U9HEjMke9RWeAOTn6pbU2oVELhvtI1yBy5yFL5sbOpxw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484r6qnqxd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 20:34:20 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-74b185fba41so4595300b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 13:34:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753734860; x=1754339660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A0+lIarkug5bI2XIrG4czP8gMx8w85UfEvs/RUlisrI=;
        b=qTVegyE9sO9qJHnEwSIkoCVFF//w9XCkpc+6IarCDGWrzgw7TxZKTPLNJzP6PWwIoR
         ffRCSvQA7rqEob/hydYKb6jFdu2Qt5s/66/e2v18GdROFKb1XADhD8KT7v51M2HMSYFU
         suXrStSY6qUxFniKvMjszBjD25ITN97BBDfd3TTZV4KhOrpsV5aOX/TtPPo1ZoK4b74L
         IAu4WMe62o7pyGAQ0OzZPdyCEJH/XA1b6kjZhJDbRUJRqb3DXt/8nT+luUon30bPiVsL
         fuAUlBKpXhZrk5NO1MByOcjss9iUo7zoAWtY1b5Od1onabTw3YfgX+thI8Expwc+8g+v
         Lf6w==
X-Forwarded-Encrypted: i=1; AJvYcCXOh+NYdWncM4kTFbYx5eq0B4UhfQXWt0/VAMEolC4KxzF17U5VUaLERv/71vTznl+rCcON2e5wY9RI+o4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOa+dtgAkv85tTNfsk5kakhLgcwMxrTnYNnnFINgoaAx8SzTrw
	VrX9Hi/YhP/n/muBGirwp3WA0moCTfyty5fTeifHhA0IqSZ4K2BigCQNWRClfOWpnFSU6RXNTj5
	ra5CdLEbJ59KG4u/YjsBwy0exOLGXNznOGihDIIAB691wWBQ9171S/nUYFSUDUnWdrqw=
X-Gm-Gg: ASbGncuY5yYRGtfx/cBgA82VNlO9h7Iz1RtKrDJyjsSPiYLuv5ISTFbL+ExhkCLEb7J
	JMoPdjWtnADXXZ6eyDqC8Gz3NOy8CiGMV7Ij1vFwkPy0obwdlcVAZD/Xpj8uULQqWyOP+2SyILc
	Se2jN56J+34YnYdPJ0sGeP1CuHpYuOiEA5msrSqBzS7tidRwUxaQR9fUx7WVSGW52izjiA6k9al
	5cGx00EWYKBT6v1l0qSjIaD28ES5C3K6B9Gus5WDKgmbsApjGObSnLwww77nQC/CKiXZjB+yLAt
	HqjyOB6rW4MMTC8/vmJ1lYGQHcrd4JMnWLXKAJUhHpNluKdu1GY=
X-Received: by 2002:a05:6a00:1384:b0:748:ef04:99d with SMTP id d2e1a72fcca58-763386bee18mr19109552b3a.14.1753734859646;
        Mon, 28 Jul 2025 13:34:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2U4D3i5dSnzRYsZjd3vL3u5W2DMJmemVWB+nFUZJ81pGCKxZrWX1gOYjxX0lk0X30atUWdg==
X-Received: by 2002:a05:6a00:1384:b0:748:ef04:99d with SMTP id d2e1a72fcca58-763386bee18mr19109519b3a.14.1753734859229;
        Mon, 28 Jul 2025 13:34:19 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:5b3e:de60:4fda:e7b1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76408c02706sm6282388b3a.39.2025.07.28.13.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 13:34:18 -0700 (PDT)
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
Subject: [PATCH 1/7] drm/msm: Add missing "location"s to devcoredump
Date: Mon, 28 Jul 2025 13:34:01 -0700
Message-ID: <20250728203412.22573-2-robin.clark@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDE1MSBTYWx0ZWRfX//8hBMJuroNf
 wsAvj6Raoh1gwqBI1bHq3YCsrapOUyFAqcwHCzAB0Rbn27ZiWfLJTvh8KMXHvl4xZ7KsAPu2yfo
 CYn/puuTszy8lHR1P+tk3gKPoR5CHkxvcjaxmgJ5Y0wp1/wHklGL/uY7eEoJcy1tXhaTnv97Eps
 Ktz5V/Jm8cLfawtSwhIlzqNr2Qt8HQ2IO/acvgT5K5yWDgLXjYt0LtsF5Dct4a0TPBOvP7gZEa2
 bav7ugSdFydhJiJKxRVvYxVF4tDJBrqcuc9KQixvs7FfcqiKJ9mSZwfCY4+PVhSM0WVXGDbmlUM
 pZC1icDOc28Lmg8gm2VJxQuIlNGRzu0p1tdn/Nmn6N0nnDLKiOCuKNiLdTic+xmc3ih1K3MgEkC
 mrF/cXHU5g8QjpTPLTVjIF+HUjIvpRX6fLTh7132MIGD71FOW1Lq6QO8c3m3U40/S/dN5GBW
X-Proofpoint-ORIG-GUID: fxKfUFzlVEMB3gBork6ZqHws3AzUhOgb
X-Authority-Analysis: v=2.4 cv=ea89f6EH c=1 sm=1 tr=0 ts=6887decc cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10
 a=EUspDBNiAAAA:8 a=YFM8xwheDJGXjHaRWHsA:9 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: fxKfUFzlVEMB3gBork6ZqHws3AzUhOgb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 adultscore=0 clxscore=1015
 spamscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507280151

This is needed to properly interpret some of the sections.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
index faca2a0243ab..e586577e90de 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
@@ -1796,6 +1796,7 @@ static void a7xx_show_shader(struct a6xx_gpu_state_obj *obj,
 
 	print_name(p, "  - type: ", a7xx_statetype_names[block->statetype]);
 	print_name(p, "    - pipe: ", a7xx_pipe_names[block->pipeid]);
+	drm_printf(p, "    - location: %d", block->location);
 
 	for (i = 0; i < block->num_sps; i++) {
 		drm_printf(p, "      - sp: %d\n", i);
@@ -1873,6 +1874,7 @@ static void a7xx_show_dbgahb_cluster(struct a6xx_gpu_state_obj *obj,
 		print_name(p, "  - pipe: ", a7xx_pipe_names[dbgahb->pipe_id]);
 		print_name(p, "    - cluster-name: ", a7xx_cluster_names[dbgahb->cluster_id]);
 		drm_printf(p, "      - context: %d\n", dbgahb->context_id);
+		drm_printf(p, "      - location: %d\n", dbgahb->location_id);
 		a7xx_show_registers_indented(dbgahb->regs, obj->data, p, 4);
 	}
 }
-- 
2.50.1


