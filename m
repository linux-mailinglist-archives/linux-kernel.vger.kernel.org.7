Return-Path: <linux-kernel+bounces-879246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8006CC22A23
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 00:04:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C811423576
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 23:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B74A33BBBB;
	Thu, 30 Oct 2025 23:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JUU9kbWD"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD0C33BBBA
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 23:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761865470; cv=none; b=NIpf3K8FS4CYNYJhkcJZrAzhxmxSPM6CUDEkgvq8bZuHv/ija/W90ACO6BkygDZSLRSEK34Kdo0Isg+1U+fHL7A5UTGht46H15na+IKiQ9hwFYY3DP68OSOeEa/8XU9rLXeQwlZXMBAksBq2DgJ4/W0PUoqLdiLA0QL8UzxDftY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761865470; c=relaxed/simple;
	bh=bzMv81MW/FPDpuuGp43OP9la5hOXCKPFu7eUNrVEOmY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yhdx7Mh0jGwzGCZ/KhgJs9PIbC6zxFLJnrhvxPyAGKfnOMPQ7NvLAdTJhzRmP9A5Myrovvkyy04Yr5m+XgmyEXvnMgBEvtZN/asVEC4XfeqIRphcHSfwr11lE340cVz2I2RxEfoaytCdLIvZO1GuwxCb+kOa98VszvKnYkT30MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JUU9kbWD; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47117f92e32so13795795e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 16:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761865466; x=1762470266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=46N0aWvp8oKX6Nu5qfDL/f1CreothHImB8SyXqy9PMU=;
        b=JUU9kbWDWjyMyKR5akgukWUAUan7Cy/JO4yUcizJT+b1jRnGxS9NkznVxaxJsiW7Wt
         COXfmxlW9xAK29GQacHNKiVPsXwya5x3jQ1/4jOU89UgIuSUs+H4SXH4dw/yWeUNgr8l
         DzYg5sXH4wQMRErdZ+MbwTu3SAL04W68Nmyl9z7m9GK1oFL8FskRWFOzM8MOONkrTM04
         wLUx/xrnFQORMT4TCFyI8uk7McjVZ3I+lrFIB3Qt03iloJlbwPwE8x8xRVPyIuYQVd+s
         D0oKXFqGKfA+CR7FbXUP7pfZRwHQ9UFgW49+DOHZJxRaZ9YGjaf2iR5TE9K8sZykhrgp
         /RhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761865466; x=1762470266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=46N0aWvp8oKX6Nu5qfDL/f1CreothHImB8SyXqy9PMU=;
        b=tILIFSuLN2YqXVmfpBfY9AGAmMszfC9z+VECtEJzSfeMOV5m1beJcbwrbZS2YCJKA3
         x4q4nXvyOkUe/Hj9HI+KpMn22C40FJ3uN57p5UAh/pO4l3iyeDv4gE5D0TpUfbYJ1d3O
         vwrZ4wOCtHsTzmjhBCo8v1o/WzFIdzXv+KxI4ViqAVjOSpUsv3FP0uSJIgnrtHqxQx1w
         dd9JWEjP9O8OtLsxaie5SHoj39Iry7tnHhnWB/bNOWMGpbsLo4KEXm1bU3gfu3ysb332
         wnr9iiKbR+t9pJAvE2sTSTgrMrNIDLgi02oqBoRADXPYaruefT4VS8ZChO01ltG3iuub
         nf6w==
X-Gm-Message-State: AOJu0Ywmb/qt2Mb4EbcOIcPMUNTFgkvJqPQgsSDpVgLpyQVRhIcAWAh9
	0u/XV+2rQ3i6D3m+Mg6NU3VHlVpR2FKesJuFOIH08RgNmvoyclnfSFCinnoZ4A==
X-Gm-Gg: ASbGncswRnLYGDNaptZCa1Hr2w7senZSslNCXJ2USFrjtyu1M/eBnxI8R4TTwjLmC/3
	tXKI9p1vIePsxz+5jnTglCSXqk9mdiFC4inkjuu5yrR4vaEa3MQuljUSLwsDjHGHvP4gwnEhqSB
	e6VLcLfarX1G2KG2YwAXCCm51cBVBO5qtMVhtZ1+PR5v+QVkmLUlZUUa5rup/xx3UxIwIjhZhsv
	GqHUkeBEueID/JNjx2b9raVhEjiED8oFUVrvESkFHTMK5gXk45sRYK8nXMNjpdf+JpxroUUlWAA
	6NHG8lSoyW093pmwCpUnBJJr9GqOgVejHRFrS4BnUdGNc/oSQv6yKeFCI6VIltcfmpYxtgYKvm+
	gkMa+OvfNYWxWrZPN2V6NpoqPNb443DVv8/sskML/kyxyX/HNwYW4PKOwvHNXSTEliJSfbQR77q
	uBrNFnSXyKBN0=
X-Google-Smtp-Source: AGHT+IF3V0g/eQ/lGtV/ew84nrHC/EHi1TJv4zNBhbsESiTddZuJ6+lmPFHjfgPrS32IKMq22nTyGg==
X-Received: by 2002:a05:600c:83ce:b0:471:989:9d85 with SMTP id 5b1f17b1804b1-47730871fa6mr13632455e9.19.1761865466296;
        Thu, 30 Oct 2025 16:04:26 -0700 (PDT)
Received: from fedora ([154.182.161.198])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47732ff8235sm2227025e9.14.2025.10.30.16.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 16:04:25 -0700 (PDT)
From: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
	Mary Guillemard <mary@mary.zone>,
	Faith Ekstrand <faith.ekstrand@collabora.com>,
	Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	nouveau@lists.freedesktop.org,
	Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
Subject: [PATCH v3 2/5] drm/nouveau/uvmm: Allow larger pages
Date: Fri, 31 Oct 2025 01:03:54 +0200
Message-ID: <20251030230357.45070-3-mohamedahmedegypt2001@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251030230357.45070-1-mohamedahmedegypt2001@gmail.com>
References: <20251030230357.45070-1-mohamedahmedegypt2001@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mary Guillemard <mary@mary.zone>

Now that everything in UVMM knows about the variable page shift, we can
select larger values.

The proposed approach relies on nouveau_bo::page unless if it would cause
alignment issues (in which case we fall back to searching for an
appropriate shift)

Signed-off-by: Mary Guillemard <mary@mary.zone>
Co-developed-by: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
Signed-off-by: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
---
 drivers/gpu/drm/nouveau/nouveau_uvmm.c | 60 +++++++++++++++++++++++++-
 1 file changed, 58 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_uvmm.c b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
index 2cd0835b05e8..f2d032f665e8 100644
--- a/drivers/gpu/drm/nouveau/nouveau_uvmm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
@@ -454,6 +454,62 @@ op_unmap_prepare_unwind(struct drm_gpuva *va)
 	drm_gpuva_insert(va->vm, va);
 }
 
+static bool
+op_map_aligned_to_page_shift(const struct drm_gpuva_op_map *op, u8 page_shift)
+{
+	u64 non_page_bits = (1ULL << page_shift) - 1;
+
+	return op->va.addr & non_page_bits == 0 &&
+	       op->va.range & non_page_bits == 0 &&
+	       op->gem.offset & non_page_bits == 0;
+}
+
+static u8
+select_page_shift(struct nouveau_uvmm *uvmm, struct drm_gpuva_op_map *op)
+{
+	struct nouveau_bo *nvbo = nouveau_gem_object(op->gem.obj);
+
+	/* nouveau_bo_fixup_align() guarantees that the page size will be aligned
+	 * for most cases, but it can't handle cases where userspace allocates with
+	 * a size and then binds with a smaller granularity. So in order to avoid
+	 * breaking old userspace, we need to ensure that the VA is actually
+	 * aligned before using it, and if it isn't, then we downgrade to the first
+	 * granularity that will fit, which is optimal from a correctness and
+	 * performance perspective.
+	 */
+	if (op_map_aligned_to_page_shift(op, nvbo->page))
+		return nvbo->page;
+
+	struct nouveau_mem *mem = nouveau_mem(nvbo->bo.resource);
+	struct nvif_vmm *vmm = &uvmm->vmm.vmm;
+	int i;
+
+	/* If the given granularity doesn't fit, let's find one that will fit. */
+	for (i = 0; i < vmm->page_nr; i++) {
+		/* Ignore anything that is bigger or identical to the BO preference. */
+		if (vmm->page[i].shift >= nvbo->page)
+			continue;
+
+		/* Skip incompatible domains. */
+		if ((mem->mem.type & NVIF_MEM_VRAM) && !vmm->page[i].vram)
+			continue;
+		if ((mem->mem.type & NVIF_MEM_HOST) &&
+		    (!vmm->page[i].host || vmm->page[i].shift > PAGE_SHIFT))
+			continue;
+
+		/* If it fits, return the proposed shift. */
+		if (op_map_aligned_to_page_shift(op, vmm->page[i].shift))
+			return vmm->page[i].shift;
+	}
+
+	/* If we get here then nothing can reconcile the requirements. This should never
+	 * happen.
+	 */
+	WARN_ON(1);
+
+	return PAGE_SHIFT;
+}
+
 static void
 nouveau_uvmm_sm_prepare_unwind(struct nouveau_uvmm *uvmm,
 			       struct nouveau_uvma_prealloc *new,
@@ -506,7 +562,7 @@ nouveau_uvmm_sm_prepare_unwind(struct nouveau_uvmm *uvmm,
 			if (vmm_get_range)
 				nouveau_uvmm_vmm_put(uvmm, vmm_get_start,
 						     vmm_get_range,
-						     PAGE_SHIFT);
+						     select_page_shift(uvmm, &op->map));
 			break;
 		}
 		case DRM_GPUVA_OP_REMAP: {
@@ -599,7 +655,7 @@ op_map_prepare(struct nouveau_uvmm *uvmm,
 
 	uvma->region = args->region;
 	uvma->kind = args->kind;
-	uvma->page_shift = PAGE_SHIFT;
+	uvma->page_shift = select_page_shift(uvmm, op);
 
 	drm_gpuva_map(&uvmm->base, &uvma->va, op);
 
-- 
2.51.1


