Return-Path: <linux-kernel+bounces-784929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A24B3439A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 16:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 282A71882321
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 14:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17122307AD1;
	Mon, 25 Aug 2025 14:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KcXKcIx8"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F26F303CAF
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756131572; cv=none; b=VFQw1okLBh444rz4fRx8MALR6Wzv4XKjWAoVQzL8G9LlqJXR7rSdK4eSMphvKzTd/dmx2OB8+XpeRn8yJO5Qyp+MhSPYvEgEtNpa0TaY6QVEXE9cPy1BnOVy6kkfcz31489aMsFLElCjOOtusRUp3hCpgOPuWkSMrKAi3Du3lAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756131572; c=relaxed/simple;
	bh=CQew//jCuiFG64AEQ7qv6Ec8/khFlO/FKeMU5oCidU8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PONWnKQ3ldM8DXLxI2XvJFvluBlJw1NUKZ7srRJMg1s1khR3PFd27ievtGuKVc9dmKrr2S6YyjFfhG+8P8Rh3r5iJT1HIsPQHWRileS2PgK3MD5irJYTSPlFzTfpdP0FLCLIvtjZl+b0XX3XSHIRpbGdGGYQNbwaKro/dCmHhJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KcXKcIx8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57P8wq10023627
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:19:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	P1yd10YofnLH+CQC4gSLJjeDZmLAxXPdlUuNT6txE1Y=; b=KcXKcIx89ECYWM+p
	Qumlgpfvh7fNUJ/+asqPchqOSihvhFSpD0mg5oAWug7OoGEeE0qSbq57S85peLe6
	4OCCeIk3/BDph9cZ/1uPltJcOHuQ5tSLv4w6I3T0yEYf/dNyo8lpDyBwspduW3DF
	RLfE1HBg2RfhA+Xg/VuyFo+A+woEI9ec0phF57ruxPvG9UOfR92QlOOuDX7SzBmg
	K/NAM1WV7JOJVdnOM0jeTUsh5pzQ98929T7Bw5eRvLy1epvFWa7u5H2zujIXTaor
	F6n378ZEd4YEovLjC48UloZb9rWIiiapG6q3t41Rg34eaMlndjgG8AF2ONMCViTB
	y9kfIA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5um5en8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:19:28 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-771e331f0fcso849318b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 07:19:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756131568; x=1756736368;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P1yd10YofnLH+CQC4gSLJjeDZmLAxXPdlUuNT6txE1Y=;
        b=qHxTpvLmqdQf/r6VkwJFaluzIM3oVxLNaNkqr+2I9waM3nmKI3cTx41Fad6Uh7+0EY
         S5NvrfxG9noug/vKkQ9rhHj6jX/KYSp2P4R+wNBjOWSyCQbAJFLdl1kDqyaTFfrAx+Ha
         T9BbaOsL05GQmsQAPsIdDDVOnXmoC9jN/U4b6Jj1eOZPrqbLr2kGIZAaLLBrJLy0Cfdk
         nqKJYg5wbWuwQaSQW9BjoMcnoaSiZwZCA0e/Kx+KDH09zlC7NNW7A3RI0fAShm0qx+Dy
         zXt9uag18DwIonbftaiPJoy/DfC78jwN3Xeq7OuHNT7FfWbYtXCT7ozpRlAXlHHmzy9x
         ABGA==
X-Forwarded-Encrypted: i=1; AJvYcCWUY7aXCR5N5rxQxs78ekhOtNHG4PptVG0C2bMxskrt3MO8p3J2cLKeV5oKxkRF/8T+eXMd99HHE5MxUwo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfdSjrWwjbxAIodcTRA8Dk+hV4sYcJdE7C0TYEWhHPdxo1hszO
	j5SpkDWYELFaOcYFjy7Mttq3KpDB3OUIG2mdqUc21ZXDciDefevZ4MDW7MpRWqI2vOyXYT8UCC4
	yK3ZcrIbJULjLwROSUQACyeNUXaasePhbmCtZP90oULReGiKvjxWXeEQDlPfDjviAw3o=
X-Gm-Gg: ASbGnct+LXgfzhOIMato6cXGIA2lUZHphjFZXPtyLZPdJk4zPiOi4TQ8ZlnQfGpwCO5
	pQl6m0DERVMNrqrVbP5J9OO8lLCVJLW+MgsjOvAO2GvCDY0Zr2piQFBV9JNa1RcN3Dbv+mWKWbq
	aPDNZmk2nGYnmrIjUPv8uFT9bNNnlPC3XHEfAvPimFuIbpB1Vnx1bs1t+yb4tydJRWwqL8fKyff
	aqrfA8Nkw1HGNiiAErC6nzr9ibVlCID+/augxPBllGPXodhoS5g+3Ka+MGv1JKaLAOinwt7ErRs
	i1Ku9A4ckHoGDNRDpjMvLuburx2Fb9iPRIdAB/gJQSjJ5k7yeCjbrVUTTJdWlQ0bj13P0+0=
X-Received: by 2002:a05:6a00:b44:b0:771:ef50:346 with SMTP id d2e1a72fcca58-771ef50091cmr1422423b3a.15.1756131567563;
        Mon, 25 Aug 2025 07:19:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGFvu3XuT9VU/LnqIitNUMdiD78ZWBqA+dkmxK74qwT0hQeTdkMlAaWKNmSD7AF3jPQpDnfQ==
X-Received: by 2002:a05:6a00:b44:b0:771:ef50:346 with SMTP id d2e1a72fcca58-771ef50091cmr1422378b3a.15.1756131567093;
        Mon, 25 Aug 2025 07:19:27 -0700 (PDT)
Received: from cse-cd01-lnx.ap.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770401eb20dsm7672339b3a.79.2025.08.25.07.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 07:19:26 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Mon, 25 Aug 2025 22:16:19 +0800
Subject: [PATCH v3 33/38] drm/msm: add support for MST non-blocking commits
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250825-msm-dp-mst-v3-33-01faacfcdedd@oss.qualcomm.com>
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
        Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756131424; l=2126;
 i=yongxing.mou@oss.qualcomm.com; s=20241121; h=from:subject:message-id;
 bh=bbMgrjogFWOe53cU7bupWnZmtxrreVf6AXy9Q1VXF+M=;
 b=gpg3jVD6oQp8tI8kWMMSeHm2DZx31ldvlH7b/o8hYiGVXXFJvVsSukXwu+8X2LIpMWKJk16+T
 Az8Qnk5jGIADEg6fsCyTUrl4ahidQSBEY8LldaFTeQqX6Yi482rJj8G
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=zeCnFRUqtOQMeFvdwex2M5o0Yf67UHYfwCyBRQ3kFbU=
X-Authority-Analysis: v=2.4 cv=VtIjA/2n c=1 sm=1 tr=0 ts=68ac70f0 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=pGLkceISAAAA:8 a=-c5J4RddxQ5453FdQNsA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMiBTYWx0ZWRfX7YcyqX2edEbB
 4SW3PI4YR4iwAa0YmVsE8E1wZ5n/uvI2QVI8f81ekTrAZJuvZjYEj05vyF0peeEcZJfbX0GjVeg
 HXCQlI38BTo0M0i7xcHzeJ54vXX/2Idum6nXddnhToDCXg4sarNevh7BnxHNh8VhP+raCF7z0AF
 nDTQsTwcJVi/MPNLl3mcmQ1ANlfWPNsxlh5YdiwE43wCiaF04lmVYFNfhCSjtIRmUScXAOFudcb
 FpkpxNQNtMXRCExKTaaZiypDvBrTJYeNaYXyOMBmYXdyNbcIronQLEWapvDCELiKG5njSc1nSbe
 9bQRjUuFDTHJ0r8QGl/hbODQBrZroz20Sj65tjYRydYg4kAsh2FxZnLgK8Z4f2SHNc2xWYT5hs4
 qJPp7PXS
X-Proofpoint-GUID: uS5DsjesFeTPejPMbNwZBTo0HjQl-fUO
X-Proofpoint-ORIG-GUID: uS5DsjesFeTPejPMbNwZBTo0HjQl-fUO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_07,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508230032

From: Abhinav Kumar <quic_abhinavk@quicinc.com>

Integrate MST framework APIs with atomic_commit_setup() and
atomic_commit_tail() to support non-blocking atomic commits
for DisplayPort MST.

This patch only applies to MST. For SST, non-blocking commits are
already handled via commit_tail(), which internally calls
drm_atomic_helper_wait_for_dependencies() in the DRM core.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_atomic.c | 3 +++
 drivers/gpu/drm/msm/msm_kms.c    | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/msm/msm_atomic.c b/drivers/gpu/drm/msm/msm_atomic.c
index 3aa0020dec3a90b693ad3d4171cfcffc091aad4c..b1656fb456d54af11ba8a30d4971fface114c7a1 100644
--- a/drivers/gpu/drm/msm/msm_atomic.c
+++ b/drivers/gpu/drm/msm/msm_atomic.c
@@ -4,6 +4,7 @@
  * Author: Rob Clark <robdclark@gmail.com>
  */
 
+#include <drm/display/drm_dp_mst_helper.h>
 #include <drm/drm_atomic_uapi.h>
 #include <drm/drm_vblank.h>
 #include <drm/display/drm_dp_mst_helper.h>
@@ -226,6 +227,8 @@ void msm_atomic_commit_tail(struct drm_atomic_state *state)
 
 	trace_msm_atomic_commit_tail_start(async, crtc_mask);
 
+	drm_dp_mst_atomic_wait_for_dependencies(state);
+
 	kms->funcs->enable_commit(kms);
 
 	/*
diff --git a/drivers/gpu/drm/msm/msm_kms.c b/drivers/gpu/drm/msm/msm_kms.c
index 6889f1c1e72121dcc735fa460ea04cdab11c6705..09776be1d3d854f4c77d7df3afa8d56f53639411 100644
--- a/drivers/gpu/drm/msm/msm_kms.c
+++ b/drivers/gpu/drm/msm/msm_kms.c
@@ -10,6 +10,7 @@
 #include <linux/sched/mm.h>
 #include <uapi/linux/sched/types.h>
 
+#include <drm/display/drm_dp_mst_helper.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_mode_config.h>
 #include <drm/drm_vblank.h>
@@ -29,6 +30,7 @@ static const struct drm_mode_config_funcs mode_config_funcs = {
 
 static const struct drm_mode_config_helper_funcs mode_config_helper_funcs = {
 	.atomic_commit_tail = msm_atomic_commit_tail,
+	.atomic_commit_setup = drm_dp_mst_atomic_setup_commit,
 };
 
 static irqreturn_t msm_irq(int irq, void *arg)

-- 
2.34.1


