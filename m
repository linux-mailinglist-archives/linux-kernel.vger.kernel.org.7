Return-Path: <linux-kernel+bounces-743250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C01B0FC8D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 00:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 822EF7AE641
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 22:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49318272815;
	Wed, 23 Jul 2025 22:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AWICn2Ap"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B66126E17F
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 22:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753308762; cv=none; b=nNzCMPwzBak+ipojW89Mghp6tFTXev+gJEizyQ5xgCabr6z4qc34xk1YPujc1p+3iBgXW7ilpdjTGlSK+1yrcE4sAqke8pMFJnx/RkeZVx3hr8glGzGU+xnf81NLS1R7tVBqG5wqmCWAQ4DTSqBgReMj5UbiFWHblFAqLp9GSlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753308762; c=relaxed/simple;
	bh=MHO/qp+UAkFUDV1KW+FRY1st72hVPxPQhofJO3khj6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eKg3H7OVcnsFNYi6V6rIQM/H0FbAnjIMpcQa5ZXKQgj9P6rAQAokuyXYJN1W1lNizHEvFaRONj0UBwchIQexNdOSs8cn8IDiKMQhzbj2/uY1aCLjEtlKoaOx3dqWwEF1BXR+vi/htXVQ4x7O3/5hcbQ+qNyRUk9mC1wuDNkqYMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AWICn2Ap; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56NH7qQS025911
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 22:12:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=nwBcV4Oemt5
	w740AAje6mIColtrmwRWXKq31FSAZZI4=; b=AWICn2ApB2hptKoeZROC9GpzaY5
	SFOn2Ft8ShfZYY1eOrWzBCbUCM9IEdHDe24FI+bSASpuOLAtwDefPQXyw+GumzTq
	XbtgmrE4Q0LY4qQbsKoVG2r0VEQNCqYxMFeaXT8ELJbN9GMGuRZ16Vhe9RDXna8n
	8hB2ymR0ZL/m7y+4ew/0C5oPpUx5658CNlQpY9vHYy2onO/NEtrtjqGHZVKVF1uf
	GiePYIFU9rF+LBJ6QgPeS1RS56CYyEn2fg8A76CaTbB6hh/1HzwC3EwFXb37uU+G
	2NCM46UhzpjmsQC7BLbu7sUCnC9+k5Yy17RjQxfFoe1O25R70YGAt6lLJ5A==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 482b1ud84f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 22:12:40 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-23827190886so3132715ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 15:12:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753308745; x=1753913545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nwBcV4Oemt5w740AAje6mIColtrmwRWXKq31FSAZZI4=;
        b=HmlMCI1m+kau66CsPbar/ZS8GF/WydQNQEI0vPYoQcmZzfXwi379MJTOCt6NQ2K6KH
         Zvbf8qtVLGqV/+Ad8LUgXOWetj3v499K3X4OqBYKb/ZvdPQdFT6g3nc5pkxT0OXpei0A
         zN70wZDvhXDqgJX13okXmaeiNN4wIIhwY2nKQqUhdFg79xwEIKyZz9SdvSmPBUGuZ+y2
         zDxFowVzCxd494EGZP6jHtSd/xSXEmxVAz3gPGhg7J/Fj5XdMw5Rhpgg2xu+nNozi8zi
         8ouwrtmJpv+1RCrEVu/pUW5pgFMdhVckBhvH2krte+nR1/jn7aUc0x6+RHmj1xQ+vRbb
         evaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHQer6QuKsF9SmmHSbQc6CV+RlWWdiXepyzA2vQQfxfcMVjXljy1D4w3K3DM1QhORgwrDauhCBcmYUhVo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzHU0HK/T/VrLzpDR2M4bFRwvk18z3ygbWAND27NrlUcg78u1G
	HiBNF0M1Otafk9Ys3TBZyITMjd2B6KCMbQSIX0Ry0FX36e89qOJP2fjF4JYhXC2BPgsCzTSHL+u
	XhRzPHCyQArJdPGvbd51jMD/t/HrZYDi4n7XgdfmaltM55LlIE1LBkaSmlwevR2HTN5M=
X-Gm-Gg: ASbGncsP6b/2hNdbmvalsqo71xa1ujDSxi9HKX7qDX6t4HgAt7iIB8tXcsaqpSqEnf+
	tCW8kAmDdTnA4b2CQHEiZelP6TcAp3M3EHx39H5JOu2/jeNv4VCB1qTEvIM/mEJXM6U0Pib2h1A
	tW2HOhy6YonsoFEfGkkfbmboCTucJJxKvEK6u3+/34SFjKwwPw6jPza0lTbhRDSe/jMuVOwL3Jl
	hMFlylPqTVdB/X7eIH/chhbAeJLTVA3imWZiMifnXzvY8r26h6xBrDhu5s8torZm34oqJ4smTUK
	nOOpZk0UAbyJzE2LkMxfiBa3NY2mcQGXwNOSzbZIlrZPAvIl7Ys=
X-Received: by 2002:a17:902:e943:b0:235:ec11:f0ee with SMTP id d9443c01a7336-23f9814207bmr57803125ad.14.1753308744788;
        Wed, 23 Jul 2025 15:12:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkj+Iw99H9WbS4Td45rekkyuGG7wRyakRiLqXabI0Xe5dEzjqYnRgG1GK9hr915l7+gNcwMA==
X-Received: by 2002:a17:902:e943:b0:235:ec11:f0ee with SMTP id d9443c01a7336-23f9814207bmr57802895ad.14.1753308744415;
        Wed, 23 Jul 2025 15:12:24 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:5b3e:de60:4fda:e7b1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa48fa0f7sm449255ad.169.2025.07.23.15.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 15:12:23 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Danilo Krummrich <dakr@redhat.com>,
        Connor Abbott <cwabbott0@gmail.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] drm/msm: Handle in-place remaps
Date: Wed, 23 Jul 2025 15:12:12 -0700
Message-ID: <20250723221213.36325-3-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250723221213.36325-1-robin.clark@oss.qualcomm.com>
References: <20250723221213.36325-1-robin.clark@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=LdY86ifi c=1 sm=1 tr=0 ts=68815e58 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10
 a=EUspDBNiAAAA:8 a=kCfvZJGldO2mi53t-5YA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDE5MSBTYWx0ZWRfX1OaBC3u+E7eg
 NHW5k8I+XEhj+sRP5wvmZDKvhubsROFneifxzoQYex84Pc5B7kCSxPbVeP8UA65+n4LgseSro7y
 1jTK3oa6Vve3uFvxee9ZO41ty3voQ3S0FnOYjsKuA83iqO0GT0919j+HnuH7WL766prsweObAqX
 NtOb0C6662v4sBJ3W9pUV6+Pt/byXbSo2/tWeLseGLUPaRDvXsyLgSNxUIA9qOEAJOuL1CuBV5x
 AbGwKOJgvlYwdXZ7XUqpX9xOpH6xFEWwGE9J1nntJd4SGzthCN6nMEGUQA9eKlOGuM94TjEQA4E
 mE0Gcy9sjscf/M0t3+kv6J6NC6AK7Slwx2kGghx2MPbrXT0hVgOBw9g6nMH767lLZPSn9vEWnWM
 6wwQRZqtjeQc4noqG3UrmlEz6J6iHNOiksFIVakv5rnrrAmAJSQW0LwUm3sBlH9Li0o5KEsH
X-Proofpoint-ORIG-GUID: SGyLu7q8p63eOqJje3PCYorTsuqS76FM
X-Proofpoint-GUID: SGyLu7q8p63eOqJje3PCYorTsuqS76FM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_03,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxscore=0 priorityscore=1501 adultscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 suspectscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507230191

Handle the special case of a MAP op simply updating the va flags by
detecting the special case, and skip pgtable updates.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_gem_vma.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/msm_gem_vma.c
index dc54c693b28d..d4b1cfb3aa03 100644
--- a/drivers/gpu/drm/msm/msm_gem_vma.c
+++ b/drivers/gpu/drm/msm/msm_gem_vma.c
@@ -519,9 +519,10 @@ msm_gem_vm_sm_step_map(struct drm_gpuva_op *op, void *arg)
 }
 
 static int
-msm_gem_vm_sm_step_remap(struct drm_gpuva_op *op, void *arg)
+msm_gem_vm_sm_step_remap(struct drm_gpuva_op *op, void *_arg)
 {
-	struct msm_vm_bind_job *job = ((struct op_arg *)arg)->job;
+	struct op_arg *arg = _arg;
+	struct msm_vm_bind_job *job = arg->job;
 	struct drm_gpuvm *vm = job->vm;
 	struct drm_gpuva *orig_vma = op->remap.unmap->va;
 	struct drm_gpuva *prev_vma = NULL, *next_vma = NULL;
@@ -529,6 +530,18 @@ msm_gem_vm_sm_step_remap(struct drm_gpuva_op *op, void *arg)
 	bool mapped = to_msm_vma(orig_vma)->mapped;
 	unsigned flags;
 
+	/* Special case for in-place updates: */
+	if (op->remap.unmap->keep && arg->flags &&
+	    op->remap.next && !op->remap.prev &&
+	    (orig_vma->gem.obj == op->remap.next->gem.obj) &&
+	    (orig_vma->gem.offset == op->remap.next->gem.offset) &&
+	    (orig_vma->va.addr == op->remap.next->va.addr) &&
+	    (orig_vma->va.range == op->remap.next->va.range)) {
+		/* Only flags are changing, so update that in-place: */
+		unsigned orig_flags = orig_vma->flags & (DRM_GPUVA_USERBITS - 1);
+		orig_vma->flags |= orig_flags | arg->flags;
+	}
+
 	vm_dbg("orig_vma: %p:%p:%p: %016llx %016llx", vm, orig_vma,
 	       orig_vma->gem.obj, orig_vma->va.addr, orig_vma->va.range);
 
-- 
2.50.1


