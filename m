Return-Path: <linux-kernel+bounces-865949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DFB4BFE65C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 00:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 304F41A03EF8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 22:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27AC305051;
	Wed, 22 Oct 2025 22:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XEkMV+VT"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE3E26F443
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 22:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761171647; cv=none; b=SUNJ+qfFb9HkSPUd7XjPkhpQoJYfTiLAtlE9O1ZxdwfvDaO4Q3BMWM+bdIt0LY8k0TOVujqspCT3IvsUV+zmBbrBQH70MkxIVc6sTSfwOA+cROMxxMyfD3ZA4ljGlyh7JgC2QcnpHrs+1KKLVsayFnb8RXnmKv+3k2oOTjPK3qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761171647; c=relaxed/simple;
	bh=s1tNuMqAcm2bXMiMD6V6FQCydvFf5uZlJ3OrFtH/Ovo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nVohVK7oz28b0aMA8UWQzLdYPK5khdI4BnFxmRV2k1vne95H21xRtROC0lJY6OJRHFu1enRhSOfKJYUEAUxye9Oq24JbTb9y05jJ9ACnQxWDTi753D+uq6o9wthtDiOdBcuhGrrI5sdRf5U+CpHSL1G+NnwsRUlkOIgksl4QYdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XEkMV+VT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59MIex8Q031877
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 22:20:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=ojPDymiYZTBLdr/wyRVgSgbdNLO5BGbhwnh
	T/pYk/5k=; b=XEkMV+VT0Vncnb4O8C33110XM73b8qxAXFOmWykCvCJVcT1/Qg9
	XAHAez+tRla3HOj7g7zHbK6LyZV1P76src9J0CqU3pa5hUg9yf/uQzARdqNi2qjU
	sgnPKIucpFNLncrNNnR0Un2Wyj794wd52GTHb15SI9T0DdFj3eMtrAhCp5vEq94l
	UQAbQBuY6td+QZscz4cRMufFjBuDIVPAIC65vErFx0EVnLAmsxyAjka9ro/1Gunb
	LVdiEVcIQkWSjP3p164VQA7n0srzvHy6FhOwFe2bqv2emGj26oqZ9Y7M2mwHGHfq
	/Ze6q8qtTYrHuYhE27eg/7g7OBIjoPsPKLA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v2ge66sp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 22:20:43 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-78117fbda6eso95802b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 15:20:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761171643; x=1761776443;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ojPDymiYZTBLdr/wyRVgSgbdNLO5BGbhwnhT/pYk/5k=;
        b=n96qVl+o6ndBj2k9H5eAXnrkX0Mqcf6UmPjj660kr3iuEuPU+xhbAwR7duC2QXKs1V
         rf+WoETWBrLmtxgrCVRO2mxHRGIN6x2d0si+ESkyFkOlNrAN0/fvSLqeiOO2G5hXjgOl
         WCJu6mEkHiWmPDvbTURCw0BZZ7Os5aqsQGN39OEtBYDd0kP4ZzNVqSAfXo5yAlzDW212
         FjysDY6jsZUTRUNgqSBCfSzE1uEPOEiaVOce9RgT9tWHMn0H2R1n5KpylHp2e9iHIzjc
         nQ2rR/nfcBlP1Q62JwNwzHXiU7vyJedKjac9NwVe/zqWT0ix6kYSLLiTPeGHZTGtWeZH
         6/CA==
X-Forwarded-Encrypted: i=1; AJvYcCU6xuRVod6yLpty2rSdl82FwEFC+/hUy95+vYd+phxg6AMSJ62STiITP3QaRrzAH5NoeCErfK1zTSZ9sfk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm0F5Kl3Q7tsXMaf0C0p9+Y2DRa00eCEp4o4WxoAQMaiPONW5s
	ViAgKlnz6rXrSBKQGHuFVFpfK1IpsFG0IVyTHwC+eKhPjwOQyCRMXgnT+Rp7njkSSEEktc7h0NN
	zDRBEr9iVzyib1FX/9FuI+pzVf0vOVuElVa5N8z4WIB/t1WdO9wVeWBjG2cxhPZyB5jE=
X-Gm-Gg: ASbGncsJcRe3Oo/D22Hla2phhW7ytjpB9NyqS+iXAi9OGXOBc1YsZukcYJYo67+CX8J
	miAA4T/CzbQpirih+QixyqSRf+xhSLfcrg8C2O1V/NbwNpmCj+PXmb4IPxWL+0EdP2zepC+gxSF
	FvPlDSYWZx/o28UY+Q/Kb/zRzIXIHx/tm0EyYPR49Y5Jg2x1d3Dt0MSFQdtAY0r2Y+Z1gf7tzf0
	bVFIi0UrKds79QfK3aI3Q2Q4YlMnAPPNyxqTrUhIpZt2zWs95avK0tqcBI0seHjz5n53zxmZPsI
	R1dVqXBUKpudYwAssz456aDJAZNY/31Xk+5ATSjZ8p/GRew7nayLBBsCLm33vwddUR8YL42c/hr
	bPGM8uwD/nQ==
X-Received: by 2002:a05:6a00:94ce:b0:771:fa65:ae6e with SMTP id d2e1a72fcca58-7a220a99177mr31804771b3a.17.1761171642674;
        Wed, 22 Oct 2025 15:20:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHP3Xt+fiS6/lvXldmXrI/Xmz9rKgUz8Br5D+seLdPQbhnS8ioRXSjubRta++0jtoklDejZTA==
X-Received: by 2002:a05:6a00:94ce:b0:771:fa65:ae6e with SMTP id d2e1a72fcca58-7a220a99177mr31804731b3a.17.1761171642157;
        Wed, 22 Oct 2025 15:20:42 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:5b3e:de60:4fda:e7b1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a274bb0c93sm284889b3a.59.2025.10.22.15.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 15:20:41 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/msm: Ensure vm is created in VM_BIND ioctl
Date: Wed, 22 Oct 2025 15:20:38 -0700
Message-ID: <20251022222039.9937-1-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMCBTYWx0ZWRfX5zAeqB7zIsde
 JAglOrvdEH4thRhqrvfbNb04rI//tI97q9GigJ1cUhMPZ5mOMoaRhZ3HAxEHyNTZxzFFtgTK2XL
 YcFKfkhawyjkP55rIV3fqjlw2KeYkH9i/Kt/ad8CzIui0I7ydFbJxDPTEOfo38RmqhF7gKkOIjc
 tXHNfRcvwnNNIjSlpEBe0aBDQbpuY7ytsOrWF3M0cc20XEQGLoZ6a9F0sLqu60hJlggUn95qQec
 Uz6x3bGKIPKdyqFwh3KZnWy3WQjxfEYoiDuEhQe2n3uzbmYOEJDWqrsTmHFmweHi8yy5BTM5MsW
 /OamCIozj+l8eWsDzYP5c9pE3PLb8x0I3Km9WmemCFTmqVEel0OBdqrOk6lKWQiK8nPF6vUtvit
 8Tl3DOnuTeMezLtrZjPf3DspbVzq2g==
X-Authority-Analysis: v=2.4 cv=KqFAGGWN c=1 sm=1 tr=0 ts=68f958bc cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=3QSsbYrYwaFkjnnp2pkA:9
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: kshlRVbaTLmSgDI3Xon1kZ4YAF8toTd_
X-Proofpoint-ORIG-GUID: kshlRVbaTLmSgDI3Xon1kZ4YAF8toTd_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 phishscore=0 malwarescore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180020

Since the vm is lazily created, to allow userspace to opt-in to a
VM_BIND context, we can't assume it is already created.

Fixes: 2e6a8a1fe2b2 ("drm/msm: Add VM_BIND ioctl")
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_gem_vma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/msm_gem_vma.c
index 00d0f3b7ba32..90712586faac 100644
--- a/drivers/gpu/drm/msm/msm_gem_vma.c
+++ b/drivers/gpu/drm/msm/msm_gem_vma.c
@@ -1382,7 +1382,7 @@ msm_ioctl_vm_bind(struct drm_device *dev, void *data, struct drm_file *file)
 	 * Maybe we could allow just UNMAP ops?  OTOH userspace should just
 	 * immediately close the device file and all will be torn down.
 	 */
-	if (to_msm_vm(ctx->vm)->unusable)
+	if (to_msm_vm(msm_context_vm(dev, ctx))->unusable)
 		return UERR(EPIPE, dev, "context is unusable");
 
 	/*
-- 
2.51.0


