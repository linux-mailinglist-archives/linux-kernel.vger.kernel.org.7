Return-Path: <linux-kernel+bounces-708440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5A2AED05F
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jun 2025 22:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5DC91895D0C
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jun 2025 20:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A63F23D2B2;
	Sun, 29 Jun 2025 20:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="n3jSGl9i"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D3C23C4F5
	for <linux-kernel@vger.kernel.org>; Sun, 29 Jun 2025 20:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751228153; cv=none; b=JVFiWbTlTZRoy5HASrzPaDD/L9jkuD3sUxUvTW1gBSGaiRIPsEfsl5lVu4kgvlVNhx+fML3SLNTQtUeS9kTrwvz9Pyo1ugrRxvSXtjdXA8kk2p0SM8z1axgMikKJt4yXViksqAOltBtJEjsGV3ykoTANdV8M+nUi3Ar6+MEkEW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751228153; c=relaxed/simple;
	bh=fUFp5T48iHQMMb+w+CljarmzayVBiB1y2lUv7gNJA+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n5hSRvGeCzqkLWyNXtQH/HlV+x9o1/0BZD81749PE5mfLb1Q3Gb9+xL08NPw83gFNUF7qXHv9oUTjvqqheukX4TsEysgyZ5AAUExZv348dngSBSvsgiqmIi7/3vy5kmsYWBlRzVbVQE/D9nGtno71527GA5JRBaFgLkmpXkf2L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n3jSGl9i; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55TIDZ0s012252
	for <linux-kernel@vger.kernel.org>; Sun, 29 Jun 2025 20:15:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Q9hZi7WyneL
	FKJYzB24G6qPoC5N3fZK4sv14UWJEX/w=; b=n3jSGl9ixpAI11KCtJ6s+UX6bhh
	sIDUhBjUd6k/Az0e9bjYhCAkJJQTtx4jHPXnI3ziCHncNUIwiyX4HocNl1bbnFK4
	tw/PD84d3jq9qeCGQRMeDwP/PEMgCDa9V6yg6t2BNzxt+iIU1juHf/20HSdW7m9b
	VITgbXORRztJyuknVLNtGdzxhSeJOW5+9Uxzmtxkc7rD14mr3xyU2hVwBal69oPu
	Qo4B/uFiuHhb9FMIyShz489duME5GZLWbh8sDT4KKyRUWjfiYtc/FYhLYfSXucd+
	I9qSDBAeXD2P9mTe0U3xA7tmrZW8iYudUxV5mNl2KRsL21QYc3vc9K+AU0A==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47j63k2teb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 29 Jun 2025 20:15:50 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-235c897d378so28676925ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jun 2025 13:15:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751228150; x=1751832950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q9hZi7WyneLFKJYzB24G6qPoC5N3fZK4sv14UWJEX/w=;
        b=TD72JTccFITCsAI73xkhkwjPo2pfR+kwEw3pwKxgF1S2t4zbtlvDMTfQavtSCTHgVX
         ziYiI2SQd6d2gCs/ZXyOYHWK32VPHe3G+TPcosgOnV3N/w9O4jAkD6DMlXuQLQZ5RKUN
         CLc9Jqn6Q+eEN0fTwPMOSSAOTJ0S9YASgsD0LN8TYQLBaevSe7j95ZlQ4rKRMyercI83
         ot33NRDaId6oDIt0Klp1HAdNVvtP8KxfLcaak0J3MgZGnHVDRNKeRwvVRmfa9jOp3BWd
         CX5n6X01mkBR4+7FKg9lty4YuziMmdY7xR8QsZk12Yjkn+gqqUL8UqlJfUlpd39FZLYD
         Unig==
X-Forwarded-Encrypted: i=1; AJvYcCWGB/ihalAHGZu5ml7sr8coO49i2fNb9S76Qccb56gQ4Es8Sqn7RkwVZ9msFK6K66sUhimO02KO/fOGZe0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQYPYdG1OupGJAhIL7Kr2CoQtTnZFqeo7hTpSm370zeMypAlVl
	LGaMs35QxjUF+p0+EqVAcjwZosOYX7O4T9qNO9MtGAkdsRg/DQIlnElR4lDbj51mFd2WmhWqiEd
	muCf0h1EzVqH3gtJ0uEK433xZYHHP1TsVO6wmkbmSfBDGOTfbLnIRTD1w9M1ni+x6JII=
X-Gm-Gg: ASbGnctjwsfzpknsTBqZEQuoL3+rlLdpuHmcgafvp+bbakPoZkdMpd9Bxh2GX45fVvV
	x+OcZwEci8tCKhinBjobJ2VtRwoNgl9Pk6tasPPg0H+VjpFVwIcBiBokcYB/2ow718ztkNkK8bb
	hT4LznARkVdpWW+I/1v8B+Z/GgzOec7E1FlDV/YsoMWYEOs22qdgKEuHoz1MHFCfJcOUE3c7f9I
	Dkdw2tWIcJ9wnAjJWutnSUoQTFvBdp4QQOKhXldfyTrjcr7bQmWT7rS38MZkFxKVB4+cBtXhN3t
	JJ9p4ftF/dBBQmJrQiXjk48PvVFQl3mgqw==
X-Received: by 2002:a17:902:f709:b0:234:c5c1:9b73 with SMTP id d9443c01a7336-23ac465d9cfmr194782245ad.36.1751228149965;
        Sun, 29 Jun 2025 13:15:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBZp4KZgwrEI6FDcHEYVJoxJkjmXqWfz5vRcyogp+uCc4z+KjzVqLAqMcc42XPdeMvwWa/qA==
X-Received: by 2002:a17:902:f709:b0:234:c5c1:9b73 with SMTP id d9443c01a7336-23ac465d9cfmr194782005ad.36.1751228149529;
        Sun, 29 Jun 2025 13:15:49 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:5b3e:de60:4fda:e7b1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb3bc037sm63349185ad.196.2025.06.29.13.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jun 2025 13:15:49 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Connor Abbott <cwabbott0@gmail.com>,
        Antonino Maniscalco <antomani103@gmail.com>,
        Danilo Krummrich <dakr@redhat.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Danilo Krummrich <dakr@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v9 02/42] drm/gpuvm: Add locking helpers
Date: Sun, 29 Jun 2025 13:12:45 -0700
Message-ID: <20250629201530.25775-3-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250629201530.25775-1-robin.clark@oss.qualcomm.com>
References: <20250629201530.25775-1-robin.clark@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=ZKfXmW7b c=1 sm=1 tr=0 ts=68619ef6 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=gXmLzIc8hE4PcKHQkQgA:9
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI5MDE3MSBTYWx0ZWRfX/mI1P0cDJwwC
 Vv0TdJA+PfA2w8OLxOdHkFKzncOnpIzGGIik/UVott2cYbWu4ItQt3W2NTDAQxW9/VXFpWmd7Hg
 Ap7bLOAICRWYt2TOqDZuhfeFAZxDcMqTz6SyWDFm8vIy4DnrvBj1bfz9mZQljvzw1q3CM5FuEM8
 QeqL0U9o5Pd5vmnhSHJWJos8SxSVOPmxt+2Xii0ocIAqmV7oP2Z6s72tbrlwTLjMASv+4FwhZ1v
 Pe0iIAZBhoODz8Mk0GuIx552UEn2oehx/vKo2j6gJIZ0ekPEGfBa+SfZgG7XtsGa1FfPJIZYnAU
 WXuPukT1xaBVvdeUVF1ERnm6RU1llnuZ6d+weQX6opMMxc0JAaQOyH41spGwag/eQHgDhwOlsbB
 w7hea3ylxvppvNLQ5EDc9JVxf65wX/rb25TR7bq/cvb6zrK2fYM0NYTcrXpKhlvZbzLFHNzu
X-Proofpoint-ORIG-GUID: RSdfjDS9JA36M6xMNlXVoXa9y5pacEEV
X-Proofpoint-GUID: RSdfjDS9JA36M6xMNlXVoXa9y5pacEEV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_05,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506290171

For UNMAP/REMAP steps we could be needing to lock objects that are not
explicitly listed in the VM_BIND ioctl in order to tear-down unmapped
VAs.  These helpers handle locking/preparing the needed objects.

Note that these functions do not strictly require the VM changes to be
applied before the next drm_gpuvm_sm_map_lock()/_unmap_lock() call.  In
the case that VM changes from an earlier drm_gpuvm_sm_map()/_unmap()
call result in a differing sequence of steps when the VM changes are
actually applied, it will be the same set of GEM objects involved, so
the locking is still correct.

v2: Rename to drm_gpuvm_sm_*_exec_locked() [Danilo]
v3: Expand comments to show expected usage, and explain how the usage
    is safe in the case of overlapping driver VM_BIND ops.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
Tested-by: Antonino Maniscalco <antomani103@gmail.com>
Reviewed-by: Antonino Maniscalco <antomani103@gmail.com>
Acked-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/gpu/drm/drm_gpuvm.c | 126 ++++++++++++++++++++++++++++++++++++
 include/drm/drm_gpuvm.h     |   8 +++
 2 files changed, 134 insertions(+)

diff --git a/drivers/gpu/drm/drm_gpuvm.c b/drivers/gpu/drm/drm_gpuvm.c
index 0ca717130541..a811471b888e 100644
--- a/drivers/gpu/drm/drm_gpuvm.c
+++ b/drivers/gpu/drm/drm_gpuvm.c
@@ -2390,6 +2390,132 @@ drm_gpuvm_sm_unmap(struct drm_gpuvm *gpuvm, void *priv,
 }
 EXPORT_SYMBOL_GPL(drm_gpuvm_sm_unmap);
 
+static int
+drm_gpuva_sm_step_lock(struct drm_gpuva_op *op, void *priv)
+{
+	struct drm_exec *exec = priv;
+
+	switch (op->op) {
+	case DRM_GPUVA_OP_REMAP:
+		if (op->remap.unmap->va->gem.obj)
+			return drm_exec_lock_obj(exec, op->remap.unmap->va->gem.obj);
+		return 0;
+	case DRM_GPUVA_OP_UNMAP:
+		if (op->unmap.va->gem.obj)
+			return drm_exec_lock_obj(exec, op->unmap.va->gem.obj);
+		return 0;
+	default:
+		return 0;
+	}
+}
+
+static const struct drm_gpuvm_ops lock_ops = {
+	.sm_step_map = drm_gpuva_sm_step_lock,
+	.sm_step_remap = drm_gpuva_sm_step_lock,
+	.sm_step_unmap = drm_gpuva_sm_step_lock,
+};
+
+/**
+ * drm_gpuvm_sm_map_exec_lock() - locks the objects touched by a drm_gpuvm_sm_map()
+ * @gpuvm: the &drm_gpuvm representing the GPU VA space
+ * @exec: the &drm_exec locking context
+ * @num_fences: for newly mapped objects, the # of fences to reserve
+ * @req_addr: the start address of the range to unmap
+ * @req_range: the range of the mappings to unmap
+ * @req_obj: the &drm_gem_object to map
+ * @req_offset: the offset within the &drm_gem_object
+ *
+ * This function locks (drm_exec_lock_obj()) objects that will be unmapped/
+ * remapped, and locks+prepares (drm_exec_prepare_object()) objects that
+ * will be newly mapped.
+ *
+ * The expected usage is:
+ *
+ *    vm_bind {
+ *        struct drm_exec exec;
+ *
+ *        // IGNORE_DUPLICATES is required, INTERRUPTIBLE_WAIT is recommended:
+ *        drm_exec_init(&exec, IGNORE_DUPLICATES | INTERRUPTIBLE_WAIT, 0);
+ *
+ *        drm_exec_until_all_locked (&exec) {
+ *            for_each_vm_bind_operation {
+ *                switch (op->op) {
+ *                case DRIVER_OP_UNMAP:
+ *                    ret = drm_gpuvm_sm_unmap_exec_lock(gpuvm, &exec, op->addr, op->range);
+ *                    break;
+ *                case DRIVER_OP_MAP:
+ *                    ret = drm_gpuvm_sm_map_exec_lock(gpuvm, &exec, num_fences,
+ *                                                     op->addr, op->range,
+ *                                                     obj, op->obj_offset);
+ *                    break;
+ *                }
+ *
+ *                drm_exec_retry_on_contention(&exec);
+ *                if (ret)
+ *                    return ret;
+ *            }
+ *        }
+ *    }
+ *
+ * This enables all locking to be performed before the driver begins modifying
+ * the VM.  This is safe to do in the case of overlapping DRIVER_VM_BIND_OPs,
+ * where an earlier op can alter the sequence of steps generated for a later
+ * op, because the later altered step will involve the same GEM object(s)
+ * already seen in the earlier locking step.  For example:
+ *
+ * 1) An earlier driver DRIVER_OP_UNMAP op removes the need for a
+ *    DRM_GPUVA_OP_REMAP/UNMAP step.  This is safe because we've already
+ *    locked the GEM object in the earlier DRIVER_OP_UNMAP op.
+ *
+ * 2) An earlier DRIVER_OP_MAP op overlaps with a later DRIVER_OP_MAP/UNMAP
+ *    op, introducing a DRM_GPUVA_OP_REMAP/UNMAP that wouldn't have been
+ *    required without the earlier DRIVER_OP_MAP.  This is safe because we've
+ *    already locked the GEM object in the earlier DRIVER_OP_MAP step.
+ *
+ * Returns: 0 on success or a negative error codec
+ */
+int
+drm_gpuvm_sm_map_exec_lock(struct drm_gpuvm *gpuvm,
+			   struct drm_exec *exec, unsigned int num_fences,
+			   u64 req_addr, u64 req_range,
+			   struct drm_gem_object *req_obj, u64 req_offset)
+{
+	if (req_obj) {
+		int ret = drm_exec_prepare_obj(exec, req_obj, num_fences);
+		if (ret)
+			return ret;
+	}
+
+	return __drm_gpuvm_sm_map(gpuvm, &lock_ops, exec,
+				  req_addr, req_range,
+				  req_obj, req_offset);
+
+}
+EXPORT_SYMBOL_GPL(drm_gpuvm_sm_map_exec_lock);
+
+/**
+ * drm_gpuvm_sm_unmap_exec_lock() - locks the objects touched by drm_gpuvm_sm_unmap()
+ * @gpuvm: the &drm_gpuvm representing the GPU VA space
+ * @exec: the &drm_exec locking context
+ * @req_addr: the start address of the range to unmap
+ * @req_range: the range of the mappings to unmap
+ *
+ * This function locks (drm_exec_lock_obj()) objects that will be unmapped/
+ * remapped by drm_gpuvm_sm_unmap().
+ *
+ * See drm_gpuvm_sm_map_exec_lock() for expected usage.
+ *
+ * Returns: 0 on success or a negative error code
+ */
+int
+drm_gpuvm_sm_unmap_exec_lock(struct drm_gpuvm *gpuvm, struct drm_exec *exec,
+			     u64 req_addr, u64 req_range)
+{
+	return __drm_gpuvm_sm_unmap(gpuvm, &lock_ops, exec,
+				    req_addr, req_range);
+}
+EXPORT_SYMBOL_GPL(drm_gpuvm_sm_unmap_exec_lock);
+
 static struct drm_gpuva_op *
 gpuva_op_alloc(struct drm_gpuvm *gpuvm)
 {
diff --git a/include/drm/drm_gpuvm.h b/include/drm/drm_gpuvm.h
index 2a9629377633..274532facfd6 100644
--- a/include/drm/drm_gpuvm.h
+++ b/include/drm/drm_gpuvm.h
@@ -1211,6 +1211,14 @@ int drm_gpuvm_sm_map(struct drm_gpuvm *gpuvm, void *priv,
 int drm_gpuvm_sm_unmap(struct drm_gpuvm *gpuvm, void *priv,
 		       u64 addr, u64 range);
 
+int drm_gpuvm_sm_map_exec_lock(struct drm_gpuvm *gpuvm,
+			  struct drm_exec *exec, unsigned int num_fences,
+			  u64 req_addr, u64 req_range,
+			  struct drm_gem_object *obj, u64 offset);
+
+int drm_gpuvm_sm_unmap_exec_lock(struct drm_gpuvm *gpuvm, struct drm_exec *exec,
+				 u64 req_addr, u64 req_range);
+
 void drm_gpuva_map(struct drm_gpuvm *gpuvm,
 		   struct drm_gpuva *va,
 		   struct drm_gpuva_op_map *op);
-- 
2.50.0


