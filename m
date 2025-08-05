Return-Path: <linux-kernel+bounces-756743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E530EB1B8B5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 18:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A00393B02FA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 16:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4106826E70B;
	Tue,  5 Aug 2025 16:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SRIvf3C3"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1194C1BCA07
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 16:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754412279; cv=none; b=RRlgOVXykpBgex6maCu7G38DJIXhhifJlrm1edNBaN13xpr48uG+QF/yS3IIzrM0nhp4hLV5iEUF57VR0+zDh4GUe3GRMGjarJlVtD2/b7BZ+B1SCQy1WCaeEldMoFWxH+KJcYHlZaJ4oHUWX7ftq7B/N97uOBiTykHIgX8/aGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754412279; c=relaxed/simple;
	bh=UZnh+dF199ZuP9pVw6ybGbzBNt4HIW922tlSPmWTD/M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eVD0AX057YdQVp1ZmzzR5KRpvy2G6lYcjB8reyUAUdwuFSs5gMdQof9viqL3rFq6kcfjbERacywcOGiGzFyxe2rGzs7lkGiU8Z2vksv81QFotx5SKazYvTSCpm0ga46sW3EBUKy1IK6BqDqa4wmSx/ZHcovCwsv4TdqJr9TuwdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SRIvf3C3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 575Fq1Ut028458
	for <linux-kernel@vger.kernel.org>; Tue, 5 Aug 2025 16:44:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=xFZ6cFO6wa52HtJqwYOKHtqGz7UHtTevLTj
	q7d3NNvg=; b=SRIvf3C3XrZjewO4zKbPO7X3F9IOLoIBzYRNbchpfa32QM2YoPm
	QDimi+wg7WVw8qrS879CcnYVAcm8jHG6N6dWEdwt99xiHvzAVB+iORPxpDVOfFFo
	kD09DUHvoJliAYG9UpyP2DO88sE8JyiEz+Y9IfrwFmp1ZBfFeP05ouGz2E3wjVl+
	AftroD2NAc1/SFIw1tMTYLVqQxWVkzO+EBjXRW49LtsY2CYwZeuKHerhJ4dTojZr
	tprPQiWbeWQ2mjabwiq/RIb0h2V8LSuokn/zaY9ogqq8WrNW/KqdQMbx20Bg8waT
	7cxFz2i7j3hJUfHIiLwcsE73JGBfMRUgUaQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bd9w9ntv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 16:44:36 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b0e0c573531so4421678a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 09:44:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754412275; x=1755017075;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xFZ6cFO6wa52HtJqwYOKHtqGz7UHtTevLTjq7d3NNvg=;
        b=lBvJUZl2QCSXyRfk4jtE2hSVMJLEy7K6DLeyEV3zSSf9P33kCADpSMD/HdauAqeq3K
         wceImHb2C5VS7Xu8vMaoI1l+gsye1OZZAUUIFroZCkuyJfRFPgmZAfuAjUQGnkUN18XW
         L1rElOXrEpOLsnl/V4/Bfi00ncvyKXtjclgD9Zn5eGOChTvlGlumfJNdKip5tlq+wjCz
         w7WskSb/Xo5+Mry9tqj70LBGMH+9FTPSV87VG8gHvHHTeFbyDvGhqRQ4l/YC9PJuGx9Q
         81KHWsgkk4QO+0Hjekl2IY5lf0j1lOBYlmSFhUFgrhDFFKDB7kwKYVzOu+tcYmd2KX9Y
         p6tA==
X-Forwarded-Encrypted: i=1; AJvYcCX8LHRuP20ESY3AnsfLpnNjRsZqtvG2d5mFxP+TDd3m6XpxCQ/moVwfwODm5nER5pmtA8nl2KpmR/krvTY=@vger.kernel.org
X-Gm-Message-State: AOJu0YznSkJknDqQysDk/Vcxkgvge2G57JRnU8IKMKuHDfIfc9XB3Kri
	IMv5ZKVJjLMGnlbulHUwktck1JrWA7Xe0bfnyJ8cokXvOX9B+m8yc9zYra9+EjuGsKu2AG903Or
	qwqF4xMnjuGbui5fcR6UKwOCgRLmWBhrNFgLV2y6XqquQkDKYGKLtTtoG35IbspcQBkQ=
X-Gm-Gg: ASbGnctHKVIlvBzyKAZqXqpkXFpPNS1hZBEuHCs2JmvZiGec+OPybueaYYuWJAM6UAb
	rQ5QrZajF5qjhPg7NY8gqspQ6z2do4g6N/VA78maqklMUUPgfVvgdklsbZnIs6wjMIqVFIuylnQ
	W+bYX8MYrTYUQRsZLiHv4p6xhJB3C6UuQQpInqiamjviKDhxgWYVPg+vUZPBnRKiZPQdBTSLAiI
	EYQphaAdDqQ5IoIdQsvD0J6E8w52nF3jdtc/H3OjmboGByNCUcx50j/9OXL5jTn1TMsup2hXR8R
	WhjCkQ8NjdJlJPPjb8ezfRCX4FFRDECxQWf9nyCWKXtcqm8GTbM=
X-Received: by 2002:a05:6a20:914b:b0:240:21e1:cbbd with SMTP id adf61e73a8af0-24021e1cda9mr4886601637.26.1754412275134;
        Tue, 05 Aug 2025 09:44:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGm/6uN6G/KVi2o9cN+/U0oUl1Y1E1Sdo+Y+NbmDyrpK8rXomnmGpne1qkC2tg1XzKix+vaGQ==
X-Received: by 2002:a05:6a20:914b:b0:240:21e1:cbbd with SMTP id adf61e73a8af0-24021e1cda9mr4886558637.26.1754412274703;
        Tue, 05 Aug 2025 09:44:34 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:5b3e:de60:4fda:e7b1])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422b7841besm11489904a12.3.2025.08.05.09.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 09:44:34 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Danilo Krummrich <dakr@kernel.org>,
        Connor Abbott <cwabbott0@gmail.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] drm/msm: Handle in-place remaps
Date: Tue,  5 Aug 2025 09:44:31 -0700
Message-ID: <20250805164431.24350-1-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=NN7V+16g c=1 sm=1 tr=0 ts=689234f4 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10
 a=EUspDBNiAAAA:8 a=54pnWYnEFG7XCx_V-2kA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: 8b14yCklaPpSHCJXrP8nndejwTlV8z2b
X-Proofpoint-ORIG-GUID: 8b14yCklaPpSHCJXrP8nndejwTlV8z2b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDExNiBTYWx0ZWRfX4W/Fr6KqS+nY
 h+UkVA2utqMsOhcfLowFNF2nD/8nc2ZjINj+YMej3/WYqqA/FTrE4uXT3W8eStLIrFa/IByHygu
 +GzzXKjL+t2VVm0YnAXqiEZYaKRBLccXmgageqpE45OIKXBo1OGxYw40sGiv6HQECBKjzzDnALb
 48d3t4LRzfB+M/V+WKFRfe4s372UnAm/LCLVudSuIWlHGdeUAysAfUu8FXFlGtDW5vx4AVdArO8
 yROQNxjyonb5VCAdsfb4XP4mj1Jg6r8lzOdGXQZ21jdfNNsBtKjIgl1YuJXdAcJf96IJ+w9InN9
 lumLzaaVgbp3wD7K1NTH4W5ONl9jisG891pgspEPyC8boc5u3x9h47KmH+61CMpFfFY92LUIWMJ
 w8GRiJAcZPRH3wBZAT5jbV1iZDMmHK0h+JIcR69pSiF/UUer3xSd+J4EA11v/zXw+6dwY8I8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_04,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015 spamscore=0
 phishscore=0 priorityscore=1501 mlxscore=0 suspectscore=0 mlxlogscore=999
 bulkscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508050116

Detect and handle the special case of a MAP op simply updating the vma
flags of an existing vma, and skip the pgtable updates.  This allows
turnip to set the MSM_VMA_DUMP flag on an existing mapping without
requiring additional synchronization against commands running on the
GPU.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_gem_vma.c | 41 ++++++++++++++++++++++++++++---
 1 file changed, 37 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/msm_gem_vma.c
index d1f5bb2e0a16..00d0f3b7ba32 100644
--- a/drivers/gpu/drm/msm/msm_gem_vma.c
+++ b/drivers/gpu/drm/msm/msm_gem_vma.c
@@ -451,6 +451,8 @@ msm_gem_vm_bo_validate(struct drm_gpuvm_bo *vm_bo, struct drm_exec *exec)
 struct op_arg {
 	unsigned flags;
 	struct msm_vm_bind_job *job;
+	const struct msm_vm_bind_op *op;
+	bool kept;
 };
 
 static void
@@ -472,14 +474,18 @@ vma_from_op(struct op_arg *arg, struct drm_gpuva_op_map *op)
 }
 
 static int
-msm_gem_vm_sm_step_map(struct drm_gpuva_op *op, void *arg)
+msm_gem_vm_sm_step_map(struct drm_gpuva_op *op, void *_arg)
 {
-	struct msm_vm_bind_job *job = ((struct op_arg *)arg)->job;
+	struct op_arg *arg = _arg;
+	struct msm_vm_bind_job *job = arg->job;
 	struct drm_gem_object *obj = op->map.gem.obj;
 	struct drm_gpuva *vma;
 	struct sg_table *sgt;
 	unsigned prot;
 
+	if (arg->kept)
+		return 0;
+
 	vma = vma_from_op(arg, &op->map);
 	if (WARN_ON(IS_ERR(vma)))
 		return PTR_ERR(vma);
@@ -599,15 +605,41 @@ msm_gem_vm_sm_step_remap(struct drm_gpuva_op *op, void *arg)
 }
 
 static int
-msm_gem_vm_sm_step_unmap(struct drm_gpuva_op *op, void *arg)
+msm_gem_vm_sm_step_unmap(struct drm_gpuva_op *op, void *_arg)
 {
-	struct msm_vm_bind_job *job = ((struct op_arg *)arg)->job;
+	struct op_arg *arg = _arg;
+	struct msm_vm_bind_job *job = arg->job;
 	struct drm_gpuva *vma = op->unmap.va;
 	struct msm_gem_vma *msm_vma = to_msm_vma(vma);
 
 	vm_dbg("%p:%p:%p: %016llx %016llx", vma->vm, vma, vma->gem.obj,
 	       vma->va.addr, vma->va.range);
 
+	/*
+	 * Detect in-place remap.  Turnip does this to change the vma flags,
+	 * in particular MSM_VMA_DUMP.  In this case we want to avoid actually
+	 * touching the page tables, as that would require synchronization
+	 * against SUBMIT jobs running on the GPU.
+	 */
+	if (op->unmap.keep &&
+	    (arg->op->op == MSM_VM_BIND_OP_MAP) &&
+	    (vma->gem.obj == arg->op->obj) &&
+	    (vma->gem.offset == arg->op->obj_offset) &&
+	    (vma->va.addr == arg->op->iova) &&
+	    (vma->va.range == arg->op->range)) {
+		/* We are only expecting a single in-place unmap+map cb pair: */
+		WARN_ON(arg->kept);
+
+		/* Leave the existing VMA in place, but signal that to the map cb: */
+		arg->kept = true;
+
+		/* Only flags are changing, so update that in-place: */
+		unsigned orig_flags = vma->flags & (DRM_GPUVA_USERBITS - 1);
+		vma->flags = orig_flags | arg->flags;
+
+		return 0;
+	}
+
 	if (!msm_vma->mapped)
 		goto out_close;
 
@@ -1268,6 +1300,7 @@ vm_bind_job_prepare(struct msm_vm_bind_job *job)
 		const struct msm_vm_bind_op *op = &job->ops[i];
 		struct op_arg arg = {
 			.job = job,
+			.op = op,
 		};
 
 		switch (op->op) {
-- 
2.50.1


