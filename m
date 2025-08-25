Return-Path: <linux-kernel+bounces-784934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C4ECB343BD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 16:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C86095E7617
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 14:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D213090F9;
	Mon, 25 Aug 2025 14:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OmyMyYsx"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5FA2FB990
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756131594; cv=none; b=CNWbZvMide0FFzWHiF7NFe1PY8wWBuABHOD1P/dR+WNewvopw2n7o1+dtflzW53fT7wCT7idimSkDgbLWIE0JgfjIIl6QW9dIbAYcvy26G8WXbxAgnu/aJy6yP0u7BtDXKjJUgUPHHutwmbVArckEeB622SwccRSLxarl+4LBMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756131594; c=relaxed/simple;
	bh=EPPzpsOe3GMV6W9LzMO4nrdD0eyL/NlLhoDKFXKKq2Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oP8Kimwt26rkpKGh/GqvhsDx/0IMhpUNdsfZq6p1BvyF564DFdcqdkTOgJStWWW1CxEv9sir6ZFPLsa9llGnjTsg3PkigMu41G/jYSdfQKyJ9qpzUSXscaT2JH7tDIgUUIjBTK6y6dORYhl5GKkwkPe8/RLvZDBvrZLSvFSeznE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OmyMyYsx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57P8IKWU010324
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:19:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ir1+DJRNcXJ/AcbzwsCokOtnTywkuEGXedxgqKP739U=; b=OmyMyYsxaNVhE307
	VKRUCTs+csDQ0SSOZ7TiMeH2g0q1DNmMWjWWeB3sflyPqHQMnkiWlCnryiouQAeZ
	HETpXNyIiIiHXCWumHNX3jPBZSfKk/9QNzz2xV9SloZBaZSXRtBsNZ/fl+rHtgJt
	UYe4Hx//SNXvC0T6ViYrLbsmlI2wwWzF01QeOSyWNBJ7+7glXjcyh6e9D+o0XjAE
	aG+956jmL1lBGp/XwH/O4VzSpNdJm0MiCBH+baLumtlKVO7KAQe9pLWX2MF6nrYO
	rSxPxxIIPQ+wnnTaR0AryxvUkLs8CQzBID06KSV30tbZ1cmHY/DBX9DugQ9re/iB
	E/f7tA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5w2nfqf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:19:48 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-771e7d00fd4so1151352b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 07:19:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756131588; x=1756736388;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ir1+DJRNcXJ/AcbzwsCokOtnTywkuEGXedxgqKP739U=;
        b=SaUVUlN48rLC+J92Fq+k2zSpWQCpLeMHune9ZAJ1k9z23LDezP56wX3381xb2VqkF/
         MPEMSNmWS+bIm617LU/QG6/zRWjxtG6JowG7zPxaWBKQOn3yhqYZPbpIc9xs7k449k6g
         451botpJraePTeevklEZdn7GCe8Pw6tdOnQlLpay8aBJT93Zkc5WtHLgFwtChuE33l65
         BHzb3WG5JCFPY+AkJEZwAKkXQPPLzAhlu0Vc30Ipx3EQamjdZ9nwDSlOT3sowEM1DXBS
         OcDH7SAl64bkuMpiS65P2ob4vvTGLJj8+bdkVP3zLHZnktjduYyA/aGO3P5YEpVAAvwp
         dlGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUm4UNReHI4HRTqSKyk1MCAzOfGvM510ZtcFMv0BuxxpBsotCr4L2VeSzrus3Ixlan3uAEy6bZPQe/3gNM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw71MzNH3auwkJuv7EkSRozn+yZDMyQiynGHSD6HvSULv4cU64q
	EhgHyzhpNmkOXVWxJbfwYMIrLkdsO2urED30nBmYzymLYV8K5V+qLfBrk+tM1extB/XKng0X/O2
	/EZZhg/mc8NS/lDlNfL7DWn9pOeAchzVUHeqV7vX82mR7xriQ8b54OogjwcEOCzy+yBc=
X-Gm-Gg: ASbGncvNY83W7XYL2gs00qyoG/jEFQmP7pnyrxUadeGeJFNn8X6OproNfjNNjj/bg11
	Zcmc/lPXlz/T4B+e6EZiVjf3Kx4bjV2x+I4IN6qusfCJ16yUr+5o9JV9YsohVei2bhRV2izTl76
	2br901YMc7PoElGL7SBTDXA7b7CeQSRWGjXxfE3QmuWl+PWbjSwkJpCdhULn68xCNUsytB9coEA
	SuzWQ86zbPZOLTIk6H/u5+nlwQ07RFxl+24d/GOjbnur8T5/c+as04jFXyZZmoDqgfoo7ZU5V8w
	i+yxN95+M+K63O9sPmnwuD6GAvbMx5TYvdFj8OUBCz/wu5njJAevmxtYNz3SXav3FIPHRso=
X-Received: by 2002:a05:6a00:13a6:b0:771:e4c6:10cc with SMTP id d2e1a72fcca58-771e4c6143bmr4641828b3a.6.1756131587890;
        Mon, 25 Aug 2025 07:19:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYxL9Zri7v/saIwgivMP5c3D/nLe00nBqbIJBm10dVOoGEqQhvu2/5xZ+AWaA4jkPkIzp30w==
X-Received: by 2002:a05:6a00:13a6:b0:771:e4c6:10cc with SMTP id d2e1a72fcca58-771e4c6143bmr4641792b3a.6.1756131587467;
        Mon, 25 Aug 2025 07:19:47 -0700 (PDT)
Received: from cse-cd01-lnx.ap.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770401eb20dsm7672339b3a.79.2025.08.25.07.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 07:19:47 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Mon, 25 Aug 2025 22:16:24 +0800
Subject: [PATCH v3 38/38] drm/msm/dp: Add MST stream support for SA8775P DP
 controller 0 and 1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250825-msm-dp-mst-v3-38-01faacfcdedd@oss.qualcomm.com>
References: <20250825-msm-dp-mst-v3-0-01faacfcdedd@oss.qualcomm.com>
In-Reply-To: <20250825-msm-dp-mst-v3-0-01faacfcdedd@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Yongxing Mou <yongxing.mou@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756131425; l=1377;
 i=yongxing.mou@oss.qualcomm.com; s=20241121; h=from:subject:message-id;
 bh=EPPzpsOe3GMV6W9LzMO4nrdD0eyL/NlLhoDKFXKKq2Y=;
 b=2glrjFiAbHnVAab9xXUirWQWDuGwWCuaCdROVriPR5omW4VgCxP0xsBuM18ARg6ihHRK37Aek
 lpHHx5bpe0MDUSf1vG4PwfFZhJlTArs1xWVTxpTCadMkOIgUKiwlJDv
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=zeCnFRUqtOQMeFvdwex2M5o0Yf67UHYfwCyBRQ3kFbU=
X-Authority-Analysis: v=2.4 cv=Z/vsHGRA c=1 sm=1 tr=0 ts=68ac7104 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=cZ6T0uJ2ZX2uJOstinUA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfXxRnfvrhD6Iw2
 f6GeNP8h5yqJTX/1NN9kLPeIycnl+nNtURTEbx9JQvDR3UCN1I4KsiM+moTS88EgjoxI3lqpgi/
 aiQj19nWnzpQBGvEyQdHY03y5GuB7Kq4iEY8wcqUfC3S35AzoU0FJVuzkIqz3a+nYIP5GVArQMC
 n4gp0+FZ3ch4QHdZgdIN+EE+iUwXOm5uucpFy62cI6wOk6xEtQDZXOjxKrX64o8HvBoudykharc
 xmJcpmUQbBbqila40DgzWn7rFyMHStyUnhEV7NeEjW5VXOfJ71vjoHHJ5WwYhSl7TNmQZVY4+lS
 BZSw7ZGCTykTNvEgXaF9fJ4idQyDiSSvolxsQwNe00wguXfruaTdsZDjAwgBVWrSrFrywS5pJZA
 +p+EqbYv
X-Proofpoint-GUID: Y1-gSLshJ_XM-popQn7ogxEKfdCbfrEO
X-Proofpoint-ORIG-GUID: Y1-gSLshJ_XM-popQn7ogxEKfdCbfrEO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_07,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 phishscore=0 clxscore=1015
 suspectscore=0 impostorscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230033

This change enables SA8775P support for Multi-Stream Transport (MST),
allowing each controller to handle up to two or four DisplayPort streams.
As all necessary code for MST support was already implemented in the
previous series of patches.

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 897ef653b3cea08904bb3595e8ac10fd7fcf811f..4a94f37513c21f9a273080b572a1e50a186a45ce 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -108,8 +108,10 @@ struct msm_dp_desc {
 };
 
 static const struct msm_dp_desc msm_dp_desc_sa8775p[] = {
-	{ .io_start = 0x0af54000, .id = MSM_DP_CONTROLLER_0, .wide_bus_supported = true },
-	{ .io_start = 0x0af5c000, .id = MSM_DP_CONTROLLER_1, .wide_bus_supported = true },
+	{ .io_start = 0x0af54000, .id = MSM_DP_CONTROLLER_0, .wide_bus_supported = true,
+	  .mst_streams = 4},
+	{ .io_start = 0x0af5c000, .id = MSM_DP_CONTROLLER_1, .wide_bus_supported = true,
+	  .mst_streams = 2},
 	{ .io_start = 0x22154000, .id = MSM_DP_CONTROLLER_2, .wide_bus_supported = true },
 	{ .io_start = 0x2215c000, .id = MSM_DP_CONTROLLER_3, .wide_bus_supported = true },
 	{}

-- 
2.34.1


