Return-Path: <linux-kernel+bounces-778711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6964BB2E937
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 02:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26EB71C22590
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 00:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73CE8194124;
	Thu, 21 Aug 2025 00:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dnNH4hbQ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B5D76C61
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 00:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755734681; cv=none; b=XY/efdN2/IbG6RiDTZ0fuhZ/ohIhQHIW0yceS3kckaUlCUvKjVlhO32aq1YBt6g1XHTTyFDkEj9QH1XBdHJeuSME1LZ9jyQpfzfPFD5IBpQ6Rn1pIQ+xA0k275yz+84A2enZoIX2dwBWU6lINiOctNmzvkOs1DWSETpj6FS2GIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755734681; c=relaxed/simple;
	bh=Q+iv3Gx4AwJ4uL7gAQ5BVjYAf5nK2oKipZP3EVLxtRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bGWHY03KKmVxgnTOYFx43O+WyRuRJfnXcNRD4qYc5/myE2t53QD2mPeT0mjQQHYmP2zc6/aagsrhzCfjgXXIjf5rvYPho3vhOAyhZ0EdMX8fvhGBU/qs0SZcxaBx02IrG7Zh4NBz2BTjbToVKzQWZRIpb5x4NnWRHy3PwPyC78o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dnNH4hbQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57KJhxJA014392
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 00:04:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Qp/A80ntMQW
	zKIpfCuvJC05mBAON98quijLhbVW9wZM=; b=dnNH4hbQwF1dp70I1AK4GDd7LPD
	QA6H48WypGfAO9OmxYlws9xAzKsvDrZsDs8jJkSat/QdWkh/nLRYnarZ8SgaJohJ
	eIrOwL5ntNZphB8gylta/McpcLVfYzkF/gvlgEnbB3R2r6pjLkWRAN+WmvmyTP5F
	0yUGEqhSxD6QuzpVmDwJEn7hAqRYnYmURnKKVDpibhlJ2kqwjvvpPy1Pj0WWJ2+E
	UPWMXKfyE090ZF09g9H3VAvUOUjN7TrpFAVQYvh03l6H2x+bUpwHoQiApghNZtxJ
	A+oXiSWFzPJ8NoJau9GorVIqtxtgN+9KFqBzUA6g/LeBN4GHrFgMcbRkbBA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ngt897rn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 00:04:38 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-24458121274so4234205ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 17:04:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755734678; x=1756339478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qp/A80ntMQWzKIpfCuvJC05mBAON98quijLhbVW9wZM=;
        b=n+pI0Z2htIpWRnL5aS7X4jI1OnDIQaJDJ6tcrWTxtG3UPukCuselt8nK0bl4R5PCfv
         5hOpORmZCPWd2KosJNBumuaq1Wta+JncukDccHvUZEezC+M+DioKjtJcMijKumG8Dwlq
         PvopHjqw9Kh/hFWwW1cvwES7ipb6mXlFJ7bbiEcaxk2RTLdwu6eGXh2pkxycqlBLXKB2
         Q0sSrucdzxrPvIW/qxkU5vgnWH7SYfpoDq+XlrnoEI4gBoo/SP4d+WMLx1DJaGfHTNUN
         ffCM51UUlawH4WRddsS1t4uth1eCZI5RJ9hcnVBf/lJ16eZ0LvVZXWF1pxkDrtDIMqo1
         YBMw==
X-Forwarded-Encrypted: i=1; AJvYcCXq3gT8Up8h228pgriu8nHzIzE09fbOW/VGqg9NiExXGEbQSGTAbxVcNLiDlkM268/nvcn3QNAlgdyW9Ew=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv5LNejPYv6nOUsYV68fMnUVpJ/TXgy6S8fp8q8f5V68mZRQ6j
	7OjuT5rclv599hEjS5wS4ZthWQAjCDixTP1EmruhxcOIJoLRzuwDqYHN4muGZMRz8+vBb/c/QNc
	TWWrBYVJufqIuaDD9VISTuYg9Dx8Cyvs0SP3kVIp/2QhRNHtWonjwHHGNHulMuYflJgQ=
X-Gm-Gg: ASbGncumCQw4NmrU4wK8RswdNo47WdwApfNnzkvdcadSLXPyIJMou9xGzO6fmBYVQ0b
	ZAazDlaR5fY+NjS5b5slH1pQRM5YD2do2nYT89gvExpN7RZZA8eg7CA9kLQ80Z668pskh2fQMPv
	vJgdSUSugfJ80ky0wBpDlfFxum1C1W10U39ilSYxeY8/75EyPePguNoeiFfldCv9WGa36bBQt88
	SvfTYQbCpWXoI5dCrRldSLcJ5C8DMeK3Dt+ilhOGFU5nK1uZpBNIxqB2xhz4QwcpDabuFeVHfhp
	8heiIvKCggsmejw6LgtFUqSK+koQ7pdezB3G4iAF8KzpFpdiXsE=
X-Received: by 2002:a17:902:ce11:b0:240:9f9:46a0 with SMTP id d9443c01a7336-245fedb7bcfmr7679345ad.38.1755734677492;
        Wed, 20 Aug 2025 17:04:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEP5tsfZ6UJAKOwZ9VJcJCpxgsE7IAQWoLU/G9aFnHsuF58zIqAfzhOOeqY/ioG4KuVujNrLA==
X-Received: by 2002:a17:902:ce11:b0:240:9f9:46a0 with SMTP id d9443c01a7336-245fedb7bcfmr7678895ad.38.1755734677061;
        Wed, 20 Aug 2025 17:04:37 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:5b3e:de60:4fda:e7b1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2460273cba9sm2170355ad.63.2025.08.20.17.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 17:04:36 -0700 (PDT)
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
Subject: [PATCH v2 3/3] drm/msm: Fix 32b size truncation
Date: Wed, 20 Aug 2025 17:04:27 -0700
Message-ID: <20250821000429.303628-4-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821000429.303628-1-robin.clark@oss.qualcomm.com>
References: <20250821000429.303628-1-robin.clark@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDEzNCBTYWx0ZWRfX6Z2/JRao8amq
 /rgdlw1F0RAP212y9zI5EMSd9BCD9pJyWC6z1kdcDOd+VcCS/3yzORS97AmPKiN3tMhNCDGbOue
 xW4Bi0wLLMArkPdOPjlCy3p5QgKhUYMMuOW2rqw3mZ/W/qg5mYhjq9f6uVVgqGMM4PmVM6w7qr+
 UBoadIeosbm62Ao3egv93SzWcZbvcftSaY+B3sXeNOUhZxhH/jBV3YTW2Uy47Sn0kopL02c7xBD
 VFlhXe6vsxsgjvEV3/xtvGsM0nWdHj+Lvdx18JhwbwsEiphqnzQsMroYKtzhXZ4/AmbENjxh6Mo
 HP/OrH3hhbNfd1fA24KixDQZhFE+cmej95T4/zU+zJY+6Lw3qBRrPJZXa7oMNXbAbZjAf3U82jT
 7qKKRPG1IaRgCPFFLJHV18ol10qpyQ==
X-Authority-Analysis: v=2.4 cv=c/fygR9l c=1 sm=1 tr=0 ts=68a66296 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=ZgH9EFzBAD-oDO0bpbcA:9
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: IGRd6UdpXmf9-bXvzNoSL945azdc0Goo
X-Proofpoint-ORIG-GUID: IGRd6UdpXmf9-bXvzNoSL945azdc0Goo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_06,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 phishscore=0 spamscore=0 impostorscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200134

Somehow we never noticed this when arm64 became a thing, many years ago.

v2: also fix npages

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
Tested-by: Connor Abbott <cwabbott0@gmail.com>
---
 drivers/gpu/drm/msm/msm_gem.c       | 21 ++++++++++-----------
 drivers/gpu/drm/msm/msm_gem.h       |  6 +++---
 drivers/gpu/drm/msm/msm_gem_prime.c |  2 +-
 3 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index 958bac4e2768..aefc82184eec 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -189,7 +189,7 @@ static struct page **get_pages(struct drm_gem_object *obj)
 	if (!msm_obj->pages) {
 		struct drm_device *dev = obj->dev;
 		struct page **p;
-		int npages = obj->size >> PAGE_SHIFT;
+		size_t npages = obj->size >> PAGE_SHIFT;
 
 		p = drm_gem_get_pages(obj);
 
@@ -1142,7 +1142,7 @@ static int msm_gem_object_mmap(struct drm_gem_object *obj, struct vm_area_struct
 
 /* convenience method to construct a GEM buffer object, and userspace handle */
 int msm_gem_new_handle(struct drm_device *dev, struct drm_file *file,
-		uint32_t size, uint32_t flags, uint32_t *handle,
+		size_t size, uint32_t flags, uint32_t *handle,
 		char *name)
 {
 	struct drm_gem_object *obj;
@@ -1208,9 +1208,8 @@ static const struct drm_gem_object_funcs msm_gem_object_funcs = {
 	.vm_ops = &vm_ops,
 };
 
-static int msm_gem_new_impl(struct drm_device *dev,
-		uint32_t size, uint32_t flags,
-		struct drm_gem_object **obj)
+static int msm_gem_new_impl(struct drm_device *dev, uint32_t flags,
+			    struct drm_gem_object **obj)
 {
 	struct msm_drm_private *priv = dev->dev_private;
 	struct msm_gem_object *msm_obj;
@@ -1244,7 +1243,7 @@ static int msm_gem_new_impl(struct drm_device *dev,
 	return 0;
 }
 
-struct drm_gem_object *msm_gem_new(struct drm_device *dev, uint32_t size, uint32_t flags)
+struct drm_gem_object *msm_gem_new(struct drm_device *dev, size_t size, uint32_t flags)
 {
 	struct msm_drm_private *priv = dev->dev_private;
 	struct msm_gem_object *msm_obj;
@@ -1259,7 +1258,7 @@ struct drm_gem_object *msm_gem_new(struct drm_device *dev, uint32_t size, uint32
 	if (size == 0)
 		return ERR_PTR(-EINVAL);
 
-	ret = msm_gem_new_impl(dev, size, flags, &obj);
+	ret = msm_gem_new_impl(dev, flags, &obj);
 	if (ret)
 		return ERR_PTR(ret);
 
@@ -1299,12 +1298,12 @@ struct drm_gem_object *msm_gem_import(struct drm_device *dev,
 	struct msm_drm_private *priv = dev->dev_private;
 	struct msm_gem_object *msm_obj;
 	struct drm_gem_object *obj;
-	uint32_t size;
-	int ret, npages;
+	size_t size, npages;
+	int ret;
 
 	size = PAGE_ALIGN(dmabuf->size);
 
-	ret = msm_gem_new_impl(dev, size, MSM_BO_WC, &obj);
+	ret = msm_gem_new_impl(dev, MSM_BO_WC, &obj);
 	if (ret)
 		return ERR_PTR(ret);
 
@@ -1347,7 +1346,7 @@ struct drm_gem_object *msm_gem_import(struct drm_device *dev,
 	return ERR_PTR(ret);
 }
 
-void *msm_gem_kernel_new(struct drm_device *dev, uint32_t size, uint32_t flags,
+void *msm_gem_kernel_new(struct drm_device *dev, size_t size, uint32_t flags,
 			 struct drm_gpuvm *vm, struct drm_gem_object **bo,
 			 uint64_t *iova)
 {
diff --git a/drivers/gpu/drm/msm/msm_gem.h b/drivers/gpu/drm/msm/msm_gem.h
index 751c3b4965bc..a4cf31853c50 100644
--- a/drivers/gpu/drm/msm/msm_gem.h
+++ b/drivers/gpu/drm/msm/msm_gem.h
@@ -297,10 +297,10 @@ bool msm_gem_active(struct drm_gem_object *obj);
 int msm_gem_cpu_prep(struct drm_gem_object *obj, uint32_t op, ktime_t *timeout);
 int msm_gem_cpu_fini(struct drm_gem_object *obj);
 int msm_gem_new_handle(struct drm_device *dev, struct drm_file *file,
-		uint32_t size, uint32_t flags, uint32_t *handle, char *name);
+		size_t size, uint32_t flags, uint32_t *handle, char *name);
 struct drm_gem_object *msm_gem_new(struct drm_device *dev,
-		uint32_t size, uint32_t flags);
-void *msm_gem_kernel_new(struct drm_device *dev, uint32_t size, uint32_t flags,
+		size_t size, uint32_t flags);
+void *msm_gem_kernel_new(struct drm_device *dev, size_t size, uint32_t flags,
 			 struct drm_gpuvm *vm, struct drm_gem_object **bo,
 			 uint64_t *iova);
 void msm_gem_kernel_put(struct drm_gem_object *bo, struct drm_gpuvm *vm);
diff --git a/drivers/gpu/drm/msm/msm_gem_prime.c b/drivers/gpu/drm/msm/msm_gem_prime.c
index c0a33ac839cb..036d34c674d9 100644
--- a/drivers/gpu/drm/msm/msm_gem_prime.c
+++ b/drivers/gpu/drm/msm/msm_gem_prime.c
@@ -15,7 +15,7 @@
 struct sg_table *msm_gem_prime_get_sg_table(struct drm_gem_object *obj)
 {
 	struct msm_gem_object *msm_obj = to_msm_bo(obj);
-	int npages = obj->size >> PAGE_SHIFT;
+	size_t npages = obj->size >> PAGE_SHIFT;
 
 	if (msm_obj->flags & MSM_BO_NO_SHARE)
 		return ERR_PTR(-EINVAL);
-- 
2.50.1


