Return-Path: <linux-kernel+bounces-776656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B30B2CFF5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 01:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D1E4520615
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 23:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4971D2737FF;
	Tue, 19 Aug 2025 23:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Jirj354E"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED7B261581
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 23:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755646156; cv=none; b=A8rVM8AR2Pl3Ebrkb3RMX1qxlbug3Wm0pcgdGiQOpwCbpbDSqKGzOggYv/UTdeBAR+OmRan7SP1lSPqX3GJuEGVatpx3eMEg0HhMdcTLTY43wxsX9HJAeVk3KIL0KftAd69rwdKOup5gqklv/fyxnbhULceiWPPmeYM0ZbZ/A78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755646156; c=relaxed/simple;
	bh=LjENvcqs3jA0omFU5up+rd8ZRQO9PVI4Y2VMj5m+6FI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K+5+nAu49MczlkmmoeH/6NU17lVoiBFH6En5MKVX/tdQQRW/m86FDvoptf/qfOpvOkA4gEDQb/pjcRL3XExicvKNwSqOj5zdQIa73hKE8tfXKkwPz5Yrb0YfPXYt0G/4hGI7j5opiuYVSegN/dcmYP75mwYjDO6edZGtvz7f/Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Jirj354E; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57JL10kR026212
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 23:29:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=a+ZaKXx/xL/
	u7Q7T4LDwvQWGaQFWySGiqB6JfEfEJwE=; b=Jirj354E7t9/WYXwpWkvWD4WCn5
	dpa/J7/+4TNVg8H2Lm/r0XJ393CQ8TPYNODaVYKMUxDVyAZjq5CGqRiYjtxBpQnd
	McbHaNFmVX3RVySxqIuihWfl94LBgw41JLqxpGan/r72dTZ4DsB65XSkROp/sEoP
	EKZATlStJRu+O5zmofpSgNBUmmeqVmOXLGkNTy92dtPcIgtay5EuV/FX04GQUZ69
	VdTlijBW+IbtWggczmzhhHJ0d6++C7FsjG6jJDfJXN8I7S4uuDS2qUbN+xowy/gJ
	4ttwVJohJRbttq6r6NTSILxPFJJdON+3uAHauTBZb5R8a0RHZQfDqcAnnzw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n0tf88sk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 23:29:13 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-76e7ef21d52so3193605b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 16:29:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755646153; x=1756250953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a+ZaKXx/xL/u7Q7T4LDwvQWGaQFWySGiqB6JfEfEJwE=;
        b=FTvMK9m2nmPJdkvL+2iR6W7xNZrdhChuD+UHogmI6RzYDePlgCaVV44wUOgOYVM1rc
         GfLB3/65dGVJbRXJiEEk3wXZeON1ntc4Xj5xZDIXyIbpKVBH6I+6gAUBCs5KE7MedPh6
         SKEuYtAdPCz/xrVkOPggDa2pRPvYms9yu6S4V0+6F7hm9Jmkkcu72OiAFSQ1NiI2zD4T
         fKxltx3pnYnC18sC1iA/nubU6GRoEOjU2U+wi3pHk1eLxXRdWvVCZMp/yqi4N/ylRXjT
         UFraW73n9sTDbHEStYYHVj0vdEPdvaMheb+KDk9xBcirmlh/7ABBF8vtQotoVbx1iPR6
         knxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcbZXY/YaUBbe3SULyF1sHTkj6MQgte2J7X+5BxKqKrqBTd9g4xqfZ6rGVlC5fhVHZ1GL2MMq9X3j8JWc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpFFLkUZPG+c7LEYxrdJ6CtcmNP1Tavy6nUayweZ1GUBCPv9qx
	UMkHQZllR1uTAFMbE3wjj4ApfX4c9PW6/lnIKaJC6/P/wtdssn6GmYb3W5hTOPPMHfoS/dOzVAC
	pbomVmKx7NT1PvE6+w859x/Pl39+t2cYeoYfwK3hlO+C2P5z+wwcBbTtCe0QSmq4wisg=
X-Gm-Gg: ASbGncvG/nfpeq4HgZ0DIx1ubDl6t3zZeeH4W2ZT1vC6l2YcgUegYGNCfOzCbDQkRbs
	TbiCiKcG/HQ22ahihHFqHC9eC06+pXNH9yOE9ARjLU3Mb0G82j7c5uu4wCtV8JdCfKpXNTww1Za
	3zlsHmCaWi9oDCjXj5wVDPIW1ZEf8AFLbfkGlB8HRrQMjp09prHc6ZCuRRQoBTXZycgvCXRHSED
	IobqQIZ0sFyb/RR3GVizrSZUNsAdYF+zh/mXjdQyVeou1MqXedcuzQN11BswhabQTFTcYto4Bis
	ISQn1Q8I/DwWAfWC0baASRrKPLcOBAYB6GuwW9B1KWqpClrb4NA=
X-Received: by 2002:a05:6a00:2e92:b0:76b:f0ac:e7b2 with SMTP id d2e1a72fcca58-76e8dbac1a1mr1258732b3a.13.1755646152730;
        Tue, 19 Aug 2025 16:29:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXuuxWQ9CNWJW9SCXTPxi43/HrmCwC3mMsHGIjwm8ubVSa4o5saby5u8uLerY0CGPltJ3xIw==
X-Received: by 2002:a05:6a00:2e92:b0:76b:f0ac:e7b2 with SMTP id d2e1a72fcca58-76e8dbac1a1mr1258702b3a.13.1755646152306;
        Tue, 19 Aug 2025 16:29:12 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:5b3e:de60:4fda:e7b1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7f0b4f60sm3423813b3a.86.2025.08.19.16.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 16:29:11 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Connor Abbott <cwabbott0@gmail.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/3] drm/msm: Fix missing VM_BIND offset/range validation
Date: Tue, 19 Aug 2025 16:29:02 -0700
Message-ID: <20250819232905.207547-3-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250819232905.207547-1-robin.clark@oss.qualcomm.com>
References: <20250819232905.207547-1-robin.clark@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 0b573KcLfpxXc-d5uDA9zC-iwYyeYxnv
X-Proofpoint-GUID: 0b573KcLfpxXc-d5uDA9zC-iwYyeYxnv
X-Authority-Analysis: v=2.4 cv=H5mCA+Yi c=1 sm=1 tr=0 ts=68a508c9 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=xd9qGtD1qYZMgD9OdIwA:9
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDE5NiBTYWx0ZWRfX7pmqsWHpcA/Q
 pVCoMLXVLrFMqJ4JwVPE2JC1fwTnb+PxZDyR4R2CFNecUMNaFmNrrqAEXgEFz1587gNtvw7VIMQ
 zVRLtVxfnPsICHci4Q4UDpM4CC7nJ9XmcfhDMrYSUtonqBpWcuE43met9WhdXT3OlAGihtoMFv3
 fafOeUhAVLUTpUChYH587Xc1g02FlD0zsZX0tmwt9+DExiLI52vb3JuNT7LFUrGiE2ls/Rn7S2I
 LM/SMkyAeI1L4OtmMWzVRqbkM9rv0HknXtv6t+GEU3erHzU195ktN3N2V55/bG3aaVeM0pgIn4k
 IZoVNzjEm3Ky9Tx48bhG4XleSEczZq0N8aUUQLlIFFvSmg7SAycX2rIiZ2rLTIrHEWlCcs3UwIF
 p/KTWdJuxCRX8YoxE6eIVg4ZxV1BaQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_04,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 bulkscore=0 priorityscore=1501 adultscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2508110000
 definitions=main-2508190196

We need to reject the MAP op if offset+range is larger than the BO size.

Reported-by: Connor Abbott <cwabbott0@gmail.com>
Fixes: 2e6a8a1fe2b2 ("drm/msm: Add VM_BIND ioctl")
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_gem_vma.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/msm_gem_vma.c
index 209154be5efc..381a0853c05b 100644
--- a/drivers/gpu/drm/msm/msm_gem_vma.c
+++ b/drivers/gpu/drm/msm/msm_gem_vma.c
@@ -1080,6 +1080,12 @@ vm_bind_job_lookup_ops(struct msm_vm_bind_job *job, struct drm_msm_vm_bind *args
 
 		op->obj = obj;
 		cnt++;
+
+		if ((op->range + op->obj_offset) > obj->size) {
+			ret = UERR(EINVAL, dev, "invalid range: %016llx + %016llx > %016zx\n",
+				   op->range, op->obj_offset, obj->size);
+			goto out_unlock;
+		}
 	}
 
 	*nr_bos = cnt;
-- 
2.50.1


