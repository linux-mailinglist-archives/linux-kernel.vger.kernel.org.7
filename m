Return-Path: <linux-kernel+bounces-703252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48221AE8DC8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 21:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E09D21C21843
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 19:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C933F2F2730;
	Wed, 25 Jun 2025 18:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BRVPUDP0"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FC82F1998
	for <linux-kernel@vger.kernel.org>; Wed, 25 Jun 2025 18:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750877940; cv=none; b=M1Kwk9gLCBLJDrw/LVkoYJS4z5wEDcaS+mGXsS9LigV58DViSkjHqa9unOa1HC072A5pTeKLS5oreCH+8k9x3VmO17B2CWeM8CVmcQKwU3P/x1Vygw/zvC5flL0dMac17Ura8TvfrrgEAnRpCa5eiN34dJuxcTRza1K5v1nHdBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750877940; c=relaxed/simple;
	bh=LREB/xY7C5jNcdjT/n4AlwVuZ2kqMqXCgxBuqCdzI2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TAWKD0DcaAC4eEbZHEBrBa1EOapJiEf/yICYc5CVdDEDGziGlwOvpEtgufb6tkxkqZXInqeW4fJBqKiX33sXBCREWzfs33HOaq8Ibn2c8WcHBg5ue8pG2UeVViA0GQrn8lKDvPRWpsyYyNFB8iB7PAEl8Lq344uik7po+9hMVTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BRVPUDP0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55PA33au032470
	for <linux-kernel@vger.kernel.org>; Wed, 25 Jun 2025 18:58:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Hh5tX4Ew+Aw
	YGkhPc+5ZLD0+EzWfomf8YCd88hJnzq0=; b=BRVPUDP0CPl6GQY+52eTwDR27yQ
	mnFlEAXs2Ei5WbyUVsmU6xWAOq/QWtgbpU3tRD2MXZjmu6sPO2vpGNMrW6S6fICd
	azh0D92DsikdwCOxpUP/REa8JAxeZEWB3D/FWRYnO0qFSDgECWwc8o1ZyJF08EIG
	SlwKxHOQhxpS14YKNasi4vgBJpaju7KZNv3JQrzOak9SCtpEo05rlV0DDR5i5w5x
	ZmHfVp2nmut7KxuLmDNKUgAbHWQLuWUyBS+SLb4XCEPr5NGTb3LbONzcT96iwiD0
	lK4UNpRHwR9206J3+Jp/7UeoLMv4dGsKCb+0djkrZP7vv6dd/Xhppvqf3Jw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47fbm1yh0a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 25 Jun 2025 18:58:57 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-31218e2d5b0so261402a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jun 2025 11:58:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750877936; x=1751482736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hh5tX4Ew+AwYGkhPc+5ZLD0+EzWfomf8YCd88hJnzq0=;
        b=c/922B7corDMEmykqx9JKSVCwMfuukQuCaeTMjaT+92c9acVCwDL1ZWTlq5N0Ky4ZH
         ov4fvHxhTpgGrhwL1MEssrjNCipxBdZeR8WAsh88T773dpKEF5dyvRRTvaOoJgCI4Fiu
         SGZpjX1WjxttfZAIKRRcjWkxCJerdYa6Mc1zpVo97gDtgFa21jHhdRuaLHv++eUqoUzw
         a4vOXXBC95aDhnHMd1jXumncE+LS/mMgq3hBZbDLrbPcWRi+QY2/jUlmWN3vMFB8j8oW
         kHRxjV0LWgISbLdUQOnfc30hExCPWQFR3toecaS7B1u5Ma6o94JIh9jkCPuj/oICP65b
         U+HQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjm9hveneuJ7oNreLcIxN+QxSfLDGLbuy5VfcsY0s6EcYyqYcx7Na+Zy40um2wHuDklcw4zYwOCZqVCZw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2HFHCtkjh4urh+9h5hoLB/XmiUrrtYjPxvq98YM7IOceFpsQY
	oqkxu+sOHbS6XfCZgMSRb/lIdZU3stOI4pdD0wr7iVJGh0PcGmUIDCw4MPpkr9qUo3jz7cqjfZ4
	AeMYlHTAzw1amd6ZhicPaJ9L1relZxPsi4QgYR6JOCqpM36zkNADunW5OFySKhN8+a5I=
X-Gm-Gg: ASbGncteYQPTPgmPTGOdXrc7IQq4MLWgVnP5T6ooK1+CDspSLqKBWidBMJgUePtZWIv
	0O7DEcl0djgsFzxBsd+h8OlVzc5K2OhCq0GkEB13UdPL1TrhTBE0vsncxs747b6dsxZf+Hz6vE1
	05kcZS9wIboA7qq51PeXmDjdmYYqPqxPnl9Ue9VgU5UNrxBFPxLwNg4RT4pD4xOZEuM9+PrMBo2
	Avo9z5UojvBkUJ+zNuZaYI35/AH1ZAXl4aI/y32U1ZW7GeqOsbZBBWxyYY7D8dfxgLjWlviRosa
	K/lU1T0hZsFFqiNEpNitvjFictIyCI3W
X-Received: by 2002:a17:90b:52c6:b0:311:f99e:7f4b with SMTP id 98e67ed59e1d1-315f268d1dfmr6120307a91.28.1750877936361;
        Wed, 25 Jun 2025 11:58:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELg7y0BBSEXdb+RpJNqLCAHvVquCtejZGqhozSz9F3YB5bONEdwukKoEgzoLXImTOBbjcArw==
X-Received: by 2002:a17:90b:52c6:b0:311:f99e:7f4b with SMTP id 98e67ed59e1d1-315f268d1dfmr6120266a91.28.1750877935809;
        Wed, 25 Jun 2025 11:58:55 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:5b3e:de60:4fda:e7b1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-315f51dc446sm2518313a91.0.2025.06.25.11.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 11:58:55 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Connor Abbott <cwabbott0@gmail.com>,
        Antonino Maniscalco <antomani103@gmail.com>,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v7 22/42] drm/msm: Add opt-in for VM_BIND
Date: Wed, 25 Jun 2025 11:47:15 -0700
Message-ID: <20250625184918.124608-23-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250625184918.124608-1-robin.clark@oss.qualcomm.com>
References: <20250625184918.124608-1-robin.clark@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=YYu95xRf c=1 sm=1 tr=0 ts=685c46f1 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10
 a=cm27Pg_UAAAA:8 a=EUspDBNiAAAA:8 a=iDRtRSvoPPFvr6RSarUA:9
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: jU_fzouSSZWjt5CqUHHktlMg0Lr9iaAn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDE0MiBTYWx0ZWRfX/O+jVXZjYxGl
 NodP0V5VWxUUkusj51ruNdOZxyv59RW5b5nL962YsAXAN9Q5lugnsH/YH1NJ/1BaYCkKqAYJ8C2
 8pAmRvgKI7nIm3s/WncrZPLP9avRHTVtyUwVWviLe38aoH5OZHQTTvbWkkNxwze9FspZd3q5PA3
 5LNZdnZqhcYY4JTro0MWl5R9MrO72iT7kFzAPC0yEo/bV6/GICwcgr+I9+HJ9gmlV7dp5j6YuHm
 1sXKw312qE7lluby2FCsjLH/hwfiLzTEipI7VI4EtXRK3nopvfroff8Q/rVNOgHf+uo6dx1+EZP
 +G1JasgwbSoqGIICTN7b7uZTF8qh6MKgOvqfmyTMnXrsCxEUCnr0s8fkq652TBOim2+XBPTNxkh
 OcJoxhO7GkGPkBzliUQIDCFGh2c4K+c4s3gnY4zI+aUHgwFsc7MvIU2nCP0W9PgM29dhPEFB
X-Proofpoint-ORIG-GUID: jU_fzouSSZWjt5CqUHHktlMg0Lr9iaAn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_06,2025-06-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 mlxlogscore=999
 clxscore=1015 mlxscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506250142

From: Rob Clark <robdclark@chromium.org>

Add a SET_PARAM for userspace to request to manage to the VM itself,
instead of getting a kernel managed VM.

In order to transition to a userspace managed VM, this param must be set
before any mappings are created.

Signed-off-by: Rob Clark <robdclark@chromium.org>
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c   |  4 ++--
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 15 +++++++++++++
 drivers/gpu/drm/msm/msm_drv.c           | 22 +++++++++++++++++--
 drivers/gpu/drm/msm/msm_gem.c           |  8 +++++++
 drivers/gpu/drm/msm/msm_gpu.c           |  5 +++--
 drivers/gpu/drm/msm/msm_gpu.h           | 29 +++++++++++++++++++++++--
 include/uapi/drm/msm_drm.h              | 24 ++++++++++++++++++++
 7 files changed, 99 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 0d7c2a2eeb8f..f0e37733c65d 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -2263,7 +2263,7 @@ a6xx_create_vm(struct msm_gpu *gpu, struct platform_device *pdev)
 }
 
 static struct drm_gpuvm *
-a6xx_create_private_vm(struct msm_gpu *gpu)
+a6xx_create_private_vm(struct msm_gpu *gpu, bool kernel_managed)
 {
 	struct msm_mmu *mmu;
 
@@ -2273,7 +2273,7 @@ a6xx_create_private_vm(struct msm_gpu *gpu)
 		return ERR_CAST(mmu);
 
 	return msm_gem_vm_create(gpu->dev, mmu, "gpu", ADRENO_VM_START,
-				 adreno_private_vm_size(gpu), true);
+				 adreno_private_vm_size(gpu), kernel_managed);
 }
 
 static uint32_t a6xx_get_rptr(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index b70ed4bc0e0d..efe03f3f42ba 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -508,6 +508,21 @@ int adreno_set_param(struct msm_gpu *gpu, struct msm_context *ctx,
 		if (!capable(CAP_SYS_ADMIN))
 			return UERR(EPERM, drm, "invalid permissions");
 		return msm_context_set_sysprof(ctx, gpu, value);
+	case MSM_PARAM_EN_VM_BIND:
+		/* We can only support VM_BIND with per-process pgtables: */
+		if (ctx->vm == gpu->vm)
+			return UERR(EINVAL, drm, "requires per-process pgtables");
+
+		/*
+		 * We can only swtich to VM_BIND mode if the VM has not yet
+		 * been created:
+		 */
+		if (ctx->vm)
+			return UERR(EBUSY, drm, "VM already created");
+
+		ctx->userspace_managed_vm = value;
+
+		return 0;
 	default:
 		return UERR(EINVAL, drm, "%s: invalid param: %u", gpu->name, param);
 	}
diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index ac8a5b072afe..89cb7820064f 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -228,9 +228,21 @@ static void load_gpu(struct drm_device *dev)
  */
 struct drm_gpuvm *msm_context_vm(struct drm_device *dev, struct msm_context *ctx)
 {
+	static DEFINE_MUTEX(init_lock);
 	struct msm_drm_private *priv = dev->dev_private;
-	if (!ctx->vm)
-		ctx->vm = msm_gpu_create_private_vm(priv->gpu, current);
+
+	/* Once ctx->vm is created it is valid for the lifetime of the context: */
+	if (ctx->vm)
+		return ctx->vm;
+
+	mutex_lock(&init_lock);
+	if (!ctx->vm) {
+		ctx->vm = msm_gpu_create_private_vm(
+			priv->gpu, current, !ctx->userspace_managed_vm);
+
+	}
+	mutex_unlock(&init_lock);
+
 	return ctx->vm;
 }
 
@@ -420,6 +432,9 @@ static int msm_ioctl_gem_info_iova(struct drm_device *dev,
 	if (!priv->gpu)
 		return -EINVAL;
 
+	if (msm_context_is_vmbind(ctx))
+		return UERR(EINVAL, dev, "VM_BIND is enabled");
+
 	if (should_fail(&fail_gem_iova, obj->size))
 		return -ENOMEM;
 
@@ -441,6 +456,9 @@ static int msm_ioctl_gem_info_set_iova(struct drm_device *dev,
 	if (!priv->gpu)
 		return -EINVAL;
 
+	if (msm_context_is_vmbind(ctx))
+		return UERR(EINVAL, dev, "VM_BIND is enabled");
+
 	/* Only supported if per-process address space is supported: */
 	if (priv->gpu->vm == vm)
 		return UERR(EOPNOTSUPP, dev, "requires per-process pgtables");
diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index 89fead77c0d8..142845378deb 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -85,6 +85,14 @@ static void msm_gem_close(struct drm_gem_object *obj, struct drm_file *file)
 	if (!ctx->vm)
 		return;
 
+	/*
+	 * VM_BIND does not depend on implicit teardown of VMAs on handle
+	 * close, but instead on implicit teardown of the VM when the device
+	 * is closed (see msm_gem_vm_close())
+	 */
+	if (msm_context_is_vmbind(ctx))
+		return;
+
 	/*
 	 * TODO we might need to kick this to a queue to avoid blocking
 	 * in CLOSE ioctl
diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index 82e33aa1ccd0..0314e15d04c2 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -831,7 +831,8 @@ static int get_clocks(struct platform_device *pdev, struct msm_gpu *gpu)
 
 /* Return a new address space for a msm_drm_private instance */
 struct drm_gpuvm *
-msm_gpu_create_private_vm(struct msm_gpu *gpu, struct task_struct *task)
+msm_gpu_create_private_vm(struct msm_gpu *gpu, struct task_struct *task,
+			  bool kernel_managed)
 {
 	struct drm_gpuvm *vm = NULL;
 
@@ -843,7 +844,7 @@ msm_gpu_create_private_vm(struct msm_gpu *gpu, struct task_struct *task)
 	 * the global one
 	 */
 	if (gpu->funcs->create_private_vm) {
-		vm = gpu->funcs->create_private_vm(gpu);
+		vm = gpu->funcs->create_private_vm(gpu, kernel_managed);
 		if (!IS_ERR(vm))
 			to_msm_vm(vm)->pid = get_pid(task_pid(task));
 	}
diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
index d1530de96315..448ebf721bd8 100644
--- a/drivers/gpu/drm/msm/msm_gpu.h
+++ b/drivers/gpu/drm/msm/msm_gpu.h
@@ -79,7 +79,7 @@ struct msm_gpu_funcs {
 	void (*gpu_set_freq)(struct msm_gpu *gpu, struct dev_pm_opp *opp,
 			     bool suspended);
 	struct drm_gpuvm *(*create_vm)(struct msm_gpu *gpu, struct platform_device *pdev);
-	struct drm_gpuvm *(*create_private_vm)(struct msm_gpu *gpu);
+	struct drm_gpuvm *(*create_private_vm)(struct msm_gpu *gpu, bool kernel_managed);
 	uint32_t (*get_rptr)(struct msm_gpu *gpu, struct msm_ringbuffer *ring);
 
 	/**
@@ -370,6 +370,14 @@ struct msm_context {
 	 */
 	bool closed;
 
+	/**
+	 * @userspace_managed_vm:
+	 *
+	 * Has userspace opted-in to userspace managed VM (ie. VM_BIND) via
+	 * MSM_PARAM_EN_VM_BIND?
+	 */
+	bool userspace_managed_vm;
+
 	/**
 	 * @vm:
 	 *
@@ -462,6 +470,22 @@ struct msm_context {
 
 struct drm_gpuvm *msm_context_vm(struct drm_device *dev, struct msm_context *ctx);
 
+/**
+ * msm_context_is_vm_bind() - has userspace opted in to VM_BIND?
+ *
+ * @ctx: the drm_file context
+ *
+ * See MSM_PARAM_EN_VM_BIND.  If userspace is managing the VM, it can
+ * do sparse binding including having multiple, potentially partial,
+ * mappings in the VM.  Therefore certain legacy uabi (ie. GET_IOVA,
+ * SET_IOVA) are rejected because they don't have a sensible meaning.
+ */
+static inline bool
+msm_context_is_vmbind(struct msm_context *ctx)
+{
+	return ctx->userspace_managed_vm;
+}
+
 /**
  * msm_gpu_convert_priority - Map userspace priority to ring # and sched priority
  *
@@ -689,7 +713,8 @@ int msm_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 		const char *name, struct msm_gpu_config *config);
 
 struct drm_gpuvm *
-msm_gpu_create_private_vm(struct msm_gpu *gpu, struct task_struct *task);
+msm_gpu_create_private_vm(struct msm_gpu *gpu, struct task_struct *task,
+			  bool kernel_managed);
 
 void msm_gpu_cleanup(struct msm_gpu *gpu);
 
diff --git a/include/uapi/drm/msm_drm.h b/include/uapi/drm/msm_drm.h
index 5bc5e4526ccf..b974f5a24dbc 100644
--- a/include/uapi/drm/msm_drm.h
+++ b/include/uapi/drm/msm_drm.h
@@ -93,6 +93,30 @@ struct drm_msm_timespec {
 #define MSM_PARAM_UCHE_TRAP_BASE 0x14 /* RO */
 /* PRR (Partially Resident Region) is required for sparse residency: */
 #define MSM_PARAM_HAS_PRR    0x15  /* RO */
+/* MSM_PARAM_EN_VM_BIND is set to 1 to enable VM_BIND ops.
+ *
+ * With VM_BIND enabled, userspace is required to allocate iova and use the
+ * VM_BIND ops for map/unmap ioctls.  MSM_INFO_SET_IOVA and MSM_INFO_GET_IOVA
+ * will be rejected.  (The latter does not have a sensible meaning when a BO
+ * can have multiple and/or partial mappings.)
+ *
+ * With VM_BIND enabled, userspace does not include a submit_bo table in the
+ * SUBMIT ioctl (this will be rejected), the resident set is determined by
+ * the the VM_BIND ops.
+ *
+ * Enabling VM_BIND will fail on devices which do not have per-process pgtables.
+ * And it is not allowed to disable VM_BIND once it has been enabled.
+ *
+ * Enabling VM_BIND should be done (attempted) prior to allocating any BOs or
+ * submitqueues of type MSM_SUBMITQUEUE_VM_BIND.
+ *
+ * Relatedly, when VM_BIND mode is enabled, the kernel will not try to recover
+ * from GPU faults or failed async VM_BIND ops, in particular because it is
+ * difficult to communicate to userspace which op failed so that userspace
+ * could rewind and try again.  When the VM is marked unusable, the SUBMIT
+ * ioctl will throw -EPIPE.
+ */
+#define MSM_PARAM_EN_VM_BIND 0x16  /* WO, once */
 
 /* For backwards compat.  The original support for preemption was based on
  * a single ring per priority level so # of priority levels equals the #
-- 
2.49.0


