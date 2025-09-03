Return-Path: <linux-kernel+bounces-798318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A49B41C45
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 12:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2B801A8730A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 10:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A282F3C32;
	Wed,  3 Sep 2025 10:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TTApY0W9"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03002F39C9
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 10:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756896719; cv=none; b=L4sJ9KM+5YfvKO3KBXxIdzGID8U1/DZrDRvQStFnJ93X1RBOXoYhsWvcbm4VFYWVk08mzWp2FGkvT/8lx+N0EYImCEb5U4evvNdUlzCM6C6O4bCZVhq24rhfBBLzDbOlmSIc8vqQUSc94nZYTJhP7AEVacTwRBK4JDkG9vC2Jlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756896719; c=relaxed/simple;
	bh=DOxzGa5ln47R7OKiLfYSQ6PXX1PmidXuqgERtNEvWGQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QSya5MzgLKXiMR0vF2cQ0zDCu9NMTjx9p/bkDUXSLTz1qa1qrx7J05jP8L62B/YEHEBkWdaHcfGyeRlgtyPoa0UTlrgOmEA22EEU+IwjqKYhW+GpmvyunEvzVTuvcfq81qxc0CzHhCmeQscluEGshh5ZmG9uS5XJiSY8DRvKnJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TTApY0W9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583AKkhp021298
	for <linux-kernel@vger.kernel.org>; Wed, 3 Sep 2025 10:51:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LOqF21CE1uDjWwhsOc9+y9QDvjUZ79AdnXqgs80Rfxg=; b=TTApY0W982Io0a/7
	5WaFtnPrDL2iRHZskZUwbk3zX5R0GRvG/p9mg2JlJ9BGRXZuqmTm/BdsZs81vc7a
	Io/UD4DHRejY11M1LEYH4bnAJKb6/BM9PJXhSBGKzasnCKcq1/8/G4WnnAeUu0iP
	H7vvLfN0ihBYhFFRk3fc+Ac4h/J7xS7sUyn+RdZnubhvAqMMClm1cExtULUemQpS
	vubmHmFLT3LXFgKvFGq1rro70fGnwntv3iMRfJEjuQSasPXFdbotNbWZCb6K8zPQ
	hIU80hCaRWyESWQs7xls7AQJCZFvb4w9QXhONW/Wq/3J5RN33tH9N/DjTiUtHQ8Q
	fRASCQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ur8s3dx8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 10:51:56 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-70dfd87a763so72174696d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 03:51:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756896715; x=1757501515;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LOqF21CE1uDjWwhsOc9+y9QDvjUZ79AdnXqgs80Rfxg=;
        b=IQOwegiyYd3n5MuQYfF3t5cKxSTgL5Ow46yKP/uOF7j1HWRdC932+YfFRzDbFBkRd+
         Sqaz+NN9nX3xtmSoz5pE7H4silpX7jWpr50w3kQ9+7c6I+x6AuotDe8ojBQpuI/Pg7RH
         i3o0q3XWwDBOliqNMTa5JupT0o1kwTa0z+I/5NCXaqfpKcrrdClKcqzk9/t+/dIKN2m3
         t0TgNIVVrZtoQZH8+AWBB/7mfawpxOP/r9BoYR6incEYmqo4xePH49VLZ/LNnkgVyHSG
         TznMFpDB65TWQTfO1+7tnmp8SFIbQZMnGP+/eT8h+3AQrmzgtQPSETYhb88Cv/jYW4ms
         4JVg==
X-Forwarded-Encrypted: i=1; AJvYcCUdA1LQ4jRkazEx3zbDARB9vIJtS9O5DAOJXUOY5dd70bR8XSZ8ObY0Ln2cnXnmdNjPXY8eXit0Qntylhk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhfYb3S4kv2VoYFQmTsihPWkdf/SJNC5Thj85hUmTry1mxRvmy
	YrmRFxlH4e+zBgyQ3sCfQtmp6ct0WWsv09TVPXrDSU6yFdvr8f4i/lIDkVwl4D7s+bx+yPNhosu
	HTxNWDWqIwYRwBlTNPRt4O8oUhiZmRJ5X7d04+M2CgRWJyBf4YyllooVM/Zf5i8VbXRU=
X-Gm-Gg: ASbGncvNf74s/fbH632nbVwOyEMHASphFS2AwT+KxDGyTQf77vYhPjTuaFMmHdVqZeI
	SObjt7P0fKzYf5JDoKqzfJDUb3juWOrj2BFzlgds3HwB78P75KJ0Ft/EkS6vnDsLqU5TyWMcQlG
	JpXt6jtQMQ+P+mGlpU+zuSo4Rj2jIAWOYZ1EW+L9EOA5zA2O2PsagZPY5+S5L/qSnYeh64MZSQC
	iylcw+Q/Kh55gHpmAxgkYF4QKG7btWgsNoLIwPveWccuk1tiMpX3EPlv2uP+SOMca99XwUYzyb5
	pufSt0N9yETCH5nGN0nbgVSt2bxpXl48DefzZw61jdkqMUA72A0qF+8MsTOK9b8GhhZW/F2dDCs
	Dfzy7Mvce4yObGW4edY7NZM6lP1iiq0Q9qbMT7iu8ubWSzacFqP4T
X-Received: by 2002:a05:6214:765:b0:709:e251:c29e with SMTP id 6a1803df08f44-70fac6f8965mr187559146d6.10.1756896715392;
        Wed, 03 Sep 2025 03:51:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpI7x7MnFeM18AkGfzBg+64o8SGEKu+2rsvamRjKqa+LRpXTTcPOES7lO8eSmbXmRIaaIuKQ==
X-Received: by 2002:a05:6214:765:b0:709:e251:c29e with SMTP id 6a1803df08f44-70fac6f8965mr187558846d6.10.1756896714885;
        Wed, 03 Sep 2025 03:51:54 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-337f5032df6sm9373431fa.39.2025.09.03.03.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 03:51:52 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 03 Sep 2025 13:51:49 +0300
Subject: [PATCH v2 1/4] drm/msm/mdp4: stop supporting no-IOMMU
 configuration
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-msm-no-iommu-v2-1-993016250104@oss.qualcomm.com>
References: <20250903-msm-no-iommu-v2-0-993016250104@oss.qualcomm.com>
In-Reply-To: <20250903-msm-no-iommu-v2-0-993016250104@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Antonino Maniscalco <antomani103@gmail.com>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1164;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=DOxzGa5ln47R7OKiLfYSQ6PXX1PmidXuqgERtNEvWGQ=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBouB3GCYkst6B7Vxs59unZZ9OWKVDoBqiuhqLC0
 Ad4ZcOrmJSJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaLgdxgAKCRCLPIo+Aiko
 1ZcgB/wIRfe3wD4L2wCQMTy+OxGPZlV6SmutRvWdRPLCSQp30ykvoaG1Ed+6wQruZao1GvSijCJ
 orcOb6USxUZZxw63Mfp1G+ybUU9Tj3tfzkG6fKuQSGwc6GyAwW8583XlCql0de54kaT3+Z+oYN0
 okuAymJbOPK6yEBncCgmM5y6SOrv9LsQyd2VcJYYZLAXt9cv3ojsX8+Y1SZ8BKMp6Vcaauelz7M
 EW1dHqy73TPNShxN5UdgVrL2iH6FND7OHToV5llWfafKG+xzR/L8NsgiyfSK+lL7JIQ/YlQM5xr
 ys3pID7GzsNL4GX6q0nLPx9t5Unu9DrwctpnWmwyAzpLutPL
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAxOSBTYWx0ZWRfX06x71+79Q3TJ
 qoHyjSunX4PxIP+xtjd1vSXXdCZemmm1CN7GTlv3MfTF+VSRoHFiSr0Wde2OkZZnFC0ruicXyRj
 +Vbs13VeJm4VXWQOyUliKbFD5ZXytUpklsLarS52wVelBNFuwJG1vt9Hc4Jlodd1KMVlFYExF6p
 77k2iyNvZx1naEn06m+8YxtyAwa83jkkqDVgQ9u85WvPVsSfQ+oME9/VB6fKMpRy2ge5zkIJOGQ
 rSCTOP/XiUFQc57iamNSbUNiwDupVW7IzWCSCKKE5xRIozr9wyGJdfA6H/sz1PrKgGWYueVHXmc
 D8uKcYF7S7VQZlyPkKrK7ULQgBF1dX3YOIbN2xpCzqmyiD/5B51lJDsB/vcn2S0+X+NZnEqq2cp
 0jHNKe88
X-Proofpoint-GUID: 3BYqIZgK8esmSnQs61dkgVsvBIZbjVbe
X-Proofpoint-ORIG-GUID: 3BYqIZgK8esmSnQs61dkgVsvBIZbjVbe
X-Authority-Analysis: v=2.4 cv=PNkP+eqC c=1 sm=1 tr=0 ts=68b81dcc cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=5Zp61nms7guAxvsrN5oA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300019

With the switch to GPUVM the msm driver no longer supports the no-IOMMU
configurations (even without the actual GPU). Return an error in case we
face the lack of the IOMMU for an MDP4 device.

Fixes: 111fdd2198e6 ("drm/msm: drm_gpuvm conversion")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c b/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
index 0952c7f18abdca4a7e24e5af8a7132456bfec129..4d1ea9b2619170335ab4d2a2ee46f31e785b2c02 100644
--- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
+++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
@@ -463,9 +463,9 @@ static int mdp4_kms_init(struct drm_device *dev)
 		ret = PTR_ERR(mmu);
 		goto fail;
 	} else if (!mmu) {
-		DRM_DEV_INFO(dev->dev, "no iommu, fallback to phys "
-				"contig buffers for scanout\n");
-		vm = NULL;
+		DRM_DEV_INFO(dev->dev, "no IOMMU, bailing out\n");
+		ret = -ENODEV;
+		goto fail;
 	} else {
 		vm  = msm_gem_vm_create(dev, mmu, "mdp4",
 					0x1000, 0x100000000 - 0x1000,

-- 
2.47.2


