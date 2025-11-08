Return-Path: <linux-kernel+bounces-891691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC43C43431
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 20:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B2CD3B1FE5
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 19:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFBF2275B15;
	Sat,  8 Nov 2025 19:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NFOgJ4lo"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1883B1BFE00
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 19:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762631402; cv=none; b=Ns3VlZ1LK0BzoYOTmiSMGxb+xrIj4UqH7RLBId89iQ2lujdRm77b+BcCjHkidYGMCkuj+8q9tRXzbIlZ3MM85IXw+XScL/VyNd2+rl3C5YWosxOy4hVzVAIstMO4NzS6tvC5VFOgT9SYbr3rF2rg9h68Xw2f1rN++dVHNjWBnCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762631402; c=relaxed/simple;
	bh=rVWdWmYwATTCWH+YV3TN6fgUASD5QTFhdEauTYh4pY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j/bbmqt8uoAPofSPWAAzzsUNKSxxJuC8lUB3ilLQGwzf5A4cl1DwKKOwng/DHsq8F8wRECbzEHV4FAihdO5mlAFKiKnztui1h0qfT9K2VsvBE5hL11n7+jJYxoQl3zGA9qN4SKmtpeyU3gsr7JYnb/BwlMdR8DCL81qres3Lnpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NFOgJ4lo; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47755de027eso12758015e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 11:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762631398; x=1763236198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tC6CcFDtB9h0jZt5MH9nV4+dpNMBEY/OO1REMIcE6dc=;
        b=NFOgJ4lognr/1WSHH6B9UXOTFkHboXhMSjbesQrL6X9MrNgWXxEs1+KltpPdTC1Mh7
         O1Frj34saWjVCFagpdOHzS4sdacVlh0QlkP7tPRufO8ZpXTCDL2p/DYO6Ywk+ThGvHsG
         VhiGFUjiE3tTu6eMl3/LCiiy5pQpK/PQQ4RKqDtEKzsxgm/pLe2ukyT0hQhgQG4cRygj
         FLPo/E07v0eOL0M+6Ba7VN+sKjlxhYur0UujJAO1s7Ju4wveM+uP1PxV3k37rDwXRvSR
         carZtpS/1y7wT9pTlO7XaQUEwjDvi9xd4j+E0YvXIbKEUoPLH1EKXvPNGBRP5lq/9y6t
         EUCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762631398; x=1763236198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tC6CcFDtB9h0jZt5MH9nV4+dpNMBEY/OO1REMIcE6dc=;
        b=Mkq39/SQzTa7cvtyNd0rYocIwGnKWXGyuYVcwj1uC633OzUNwneDMU7/tcrBkdO2mr
         Src0FZp1MSTXsTgQOG2ZvxUSGyQ/Gn9DvtwyqF/Ye6vL/n4UHBH9g3gOfG7xrn3Q03TM
         vzjJRmqmUJ52wrKJQdd2HnL/7xvJjkjt9OiodSH/6MtnP2Q796W/E1SVqn2u2gzIvRN6
         Tk5FYIkl2mW8siVkMk18aDrw0INLl65kd3sM4CMZ0+43QWu0FRYIv4kZL9hjnpRe04+0
         EUsYoBWq4Ne3JXIqg87aDQZiZtRE2IQQTmdt368qKY0obozAm+K/mBMvAjrLDn9Rw25n
         FkxQ==
X-Gm-Message-State: AOJu0Yy+L66xJnZ8SHV114+IjulT7Uu5wug9Ad2JvuChp4D5Y0P4YU5p
	2aTCx4RSnoyJC+hepo0L/IFZQoYZMLV4i2Hv07D0bn4UtPBQN63UeTtAXBDhIg==
X-Gm-Gg: ASbGncuojT5VWRIQYBhGeAgIcKOJqI5wYtUy93A83rd/o3ooFiwDVztA3okHdgELDez
	mStXJRCpB7RXFiJGUXzrkj1e2XMNIALxsIh6DJKN5LQ1GtGcFCysFSUxsxGz28ygxU+ZBL61HVV
	QHIuYscfMfqVaEokiBJlyYi3VGkd4RTyc/hXi7ewjPi470RONJQoL277gL8Ql4mjPElvptcfsHN
	P1k+92NWDTjLg/rEvdcthiXiV2EB9o40SFN/LvIa0+NLsTnbVapCpI05IytE/4HstQN1oAg/D8u
	ZAq7YQ44lxVyoqth6pRPj5TaV3KX0v0RXXbKJaIL808S+B0T0ireYnJ90DJSKHoG0V798Lg+5NO
	GReVoFu9LP4dfvUjhwMc2XOPvJRJTnPe1CTmINQTWMooq7DKxlObYMdncqzmmTLpfQLPg7t4fkt
	4rcyrH2RRo+w==
X-Google-Smtp-Source: AGHT+IF/+3+SUkojh3Q/ztfASRycevQZ9mrL6CnFlh8YCnITjDaQVoH9rXfdZTj0M9ykzZfqI+PgLg==
X-Received: by 2002:a05:600c:22ce:b0:477:76bf:e1fb with SMTP id 5b1f17b1804b1-47776bfe447mr9951605e9.16.1762631397945;
        Sat, 08 Nov 2025 11:49:57 -0800 (PST)
Received: from fedora ([156.208.73.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775cdc33bdsm233461435e9.1.2025.11.08.11.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 11:49:57 -0800 (PST)
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
	Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>,
	James Jones <jajones@nvidia.com>
Subject: [PATCH v5 1/5] drm/nouveau/uvmm: Prepare for larger pages
Date: Sat,  8 Nov 2025 21:49:15 +0200
Message-ID: <20251108194919.68754-2-mohamedahmedegypt2001@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251108194919.68754-1-mohamedahmedegypt2001@gmail.com>
References: <20251108194919.68754-1-mohamedahmedegypt2001@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mary Guillemard <mary@mary.zone>

Currently memory allocated by VM_BIND uAPI can only have a  granuality
matching PAGE_SIZE (4KiB in common case)

To have a better memory management and to allow big (64KiB) and huge
(2MiB) pages later in the series, we are now passing the page shift all
around the internals of UVMM.

Signed-off-by: Mary Guillemard <mary@mary.zone>
Co-developed-by: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
Signed-off-by: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
Reviewed-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: James Jones <jajones@nvidia.com>
---
 drivers/gpu/drm/nouveau/nouveau_uvmm.c | 46 ++++++++++++++++----------
 drivers/gpu/drm/nouveau/nouveau_uvmm.h |  1 +
 2 files changed, 30 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_uvmm.c b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
index 79eefdfd08a2..2cd0835b05e8 100644
--- a/drivers/gpu/drm/nouveau/nouveau_uvmm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
@@ -107,34 +107,34 @@ nouveau_uvmm_vmm_sparse_unref(struct nouveau_uvmm *uvmm,
 
 static int
 nouveau_uvmm_vmm_get(struct nouveau_uvmm *uvmm,
-		     u64 addr, u64 range)
+		     u64 addr, u64 range, u8 page_shift)
 {
 	struct nvif_vmm *vmm = &uvmm->vmm.vmm;
 
-	return nvif_vmm_raw_get(vmm, addr, range, PAGE_SHIFT);
+	return nvif_vmm_raw_get(vmm, addr, range, page_shift);
 }
 
 static int
 nouveau_uvmm_vmm_put(struct nouveau_uvmm *uvmm,
-		     u64 addr, u64 range)
+		     u64 addr, u64 range, u8 page_shift)
 {
 	struct nvif_vmm *vmm = &uvmm->vmm.vmm;
 
-	return nvif_vmm_raw_put(vmm, addr, range, PAGE_SHIFT);
+	return nvif_vmm_raw_put(vmm, addr, range, page_shift);
 }
 
 static int
 nouveau_uvmm_vmm_unmap(struct nouveau_uvmm *uvmm,
-		       u64 addr, u64 range, bool sparse)
+		       u64 addr, u64 range, u8 page_shift, bool sparse)
 {
 	struct nvif_vmm *vmm = &uvmm->vmm.vmm;
 
-	return nvif_vmm_raw_unmap(vmm, addr, range, PAGE_SHIFT, sparse);
+	return nvif_vmm_raw_unmap(vmm, addr, range, page_shift, sparse);
 }
 
 static int
 nouveau_uvmm_vmm_map(struct nouveau_uvmm *uvmm,
-		     u64 addr, u64 range,
+		     u64 addr, u64 range, u8 page_shift,
 		     u64 bo_offset, u8 kind,
 		     struct nouveau_mem *mem)
 {
@@ -163,7 +163,7 @@ nouveau_uvmm_vmm_map(struct nouveau_uvmm *uvmm,
 		return -ENOSYS;
 	}
 
-	return nvif_vmm_raw_map(vmm, addr, range, PAGE_SHIFT,
+	return nvif_vmm_raw_map(vmm, addr, range, page_shift,
 				&args, argc,
 				&mem->mem, bo_offset);
 }
@@ -182,8 +182,9 @@ nouveau_uvma_vmm_put(struct nouveau_uvma *uvma)
 {
 	u64 addr = uvma->va.va.addr;
 	u64 range = uvma->va.va.range;
+	u8 page_shift = uvma->page_shift;
 
-	return nouveau_uvmm_vmm_put(to_uvmm(uvma), addr, range);
+	return nouveau_uvmm_vmm_put(to_uvmm(uvma), addr, range, page_shift);
 }
 
 static int
@@ -193,9 +194,11 @@ nouveau_uvma_map(struct nouveau_uvma *uvma,
 	u64 addr = uvma->va.va.addr;
 	u64 offset = uvma->va.gem.offset;
 	u64 range = uvma->va.va.range;
+	u8 page_shift = uvma->page_shift;
 
 	return nouveau_uvmm_vmm_map(to_uvmm(uvma), addr, range,
-				    offset, uvma->kind, mem);
+				    page_shift, offset, uvma->kind,
+				    mem);
 }
 
 static int
@@ -203,12 +206,13 @@ nouveau_uvma_unmap(struct nouveau_uvma *uvma)
 {
 	u64 addr = uvma->va.va.addr;
 	u64 range = uvma->va.va.range;
+	u8 page_shift = uvma->page_shift;
 	bool sparse = !!uvma->region;
 
 	if (drm_gpuva_invalidated(&uvma->va))
 		return 0;
 
-	return nouveau_uvmm_vmm_unmap(to_uvmm(uvma), addr, range, sparse);
+	return nouveau_uvmm_vmm_unmap(to_uvmm(uvma), addr, range, page_shift, sparse);
 }
 
 static int
@@ -501,7 +505,8 @@ nouveau_uvmm_sm_prepare_unwind(struct nouveau_uvmm *uvmm,
 
 			if (vmm_get_range)
 				nouveau_uvmm_vmm_put(uvmm, vmm_get_start,
-						     vmm_get_range);
+						     vmm_get_range,
+						     PAGE_SHIFT);
 			break;
 		}
 		case DRM_GPUVA_OP_REMAP: {
@@ -528,6 +533,7 @@ nouveau_uvmm_sm_prepare_unwind(struct nouveau_uvmm *uvmm,
 			u64 ustart = va->va.addr;
 			u64 urange = va->va.range;
 			u64 uend = ustart + urange;
+			u8 page_shift = uvma_from_va(va)->page_shift;
 
 			/* Nothing to do for mappings we merge with. */
 			if (uend == vmm_get_start ||
@@ -538,7 +544,8 @@ nouveau_uvmm_sm_prepare_unwind(struct nouveau_uvmm *uvmm,
 				u64 vmm_get_range = ustart - vmm_get_start;
 
 				nouveau_uvmm_vmm_put(uvmm, vmm_get_start,
-						     vmm_get_range);
+						     vmm_get_range,
+						     page_shift);
 			}
 			vmm_get_start = uend;
 			break;
@@ -592,6 +599,7 @@ op_map_prepare(struct nouveau_uvmm *uvmm,
 
 	uvma->region = args->region;
 	uvma->kind = args->kind;
+	uvma->page_shift = PAGE_SHIFT;
 
 	drm_gpuva_map(&uvmm->base, &uvma->va, op);
 
@@ -633,7 +641,8 @@ nouveau_uvmm_sm_prepare(struct nouveau_uvmm *uvmm,
 
 			if (vmm_get_range) {
 				ret = nouveau_uvmm_vmm_get(uvmm, vmm_get_start,
-							   vmm_get_range);
+							   vmm_get_range,
+							   new->map->page_shift);
 				if (ret) {
 					op_map_prepare_unwind(new->map);
 					goto unwind;
@@ -689,6 +698,7 @@ nouveau_uvmm_sm_prepare(struct nouveau_uvmm *uvmm,
 			u64 ustart = va->va.addr;
 			u64 urange = va->va.range;
 			u64 uend = ustart + urange;
+			u8 page_shift = uvma_from_va(va)->page_shift;
 
 			op_unmap_prepare(u);
 
@@ -704,7 +714,7 @@ nouveau_uvmm_sm_prepare(struct nouveau_uvmm *uvmm,
 				u64 vmm_get_range = ustart - vmm_get_start;
 
 				ret = nouveau_uvmm_vmm_get(uvmm, vmm_get_start,
-							   vmm_get_range);
+							   vmm_get_range, page_shift);
 				if (ret) {
 					op_unmap_prepare_unwind(va);
 					goto unwind;
@@ -799,10 +809,11 @@ op_unmap_range(struct drm_gpuva_op_unmap *u,
 	       u64 addr, u64 range)
 {
 	struct nouveau_uvma *uvma = uvma_from_va(u->va);
+	u8 page_shift = uvma->page_shift;
 	bool sparse = !!uvma->region;
 
 	if (!drm_gpuva_invalidated(u->va))
-		nouveau_uvmm_vmm_unmap(to_uvmm(uvma), addr, range, sparse);
+		nouveau_uvmm_vmm_unmap(to_uvmm(uvma), addr, range, page_shift, sparse);
 }
 
 static void
@@ -882,6 +893,7 @@ nouveau_uvmm_sm_cleanup(struct nouveau_uvmm *uvmm,
 			struct drm_gpuva_op_map *n = r->next;
 			struct drm_gpuva *va = r->unmap->va;
 			struct nouveau_uvma *uvma = uvma_from_va(va);
+			u8 page_shift = uvma->page_shift;
 
 			if (unmap) {
 				u64 addr = va->va.addr;
@@ -893,7 +905,7 @@ nouveau_uvmm_sm_cleanup(struct nouveau_uvmm *uvmm,
 				if (n)
 					end = n->va.addr;
 
-				nouveau_uvmm_vmm_put(uvmm, addr, end - addr);
+				nouveau_uvmm_vmm_put(uvmm, addr, end - addr, page_shift);
 			}
 
 			nouveau_uvma_gem_put(uvma);
diff --git a/drivers/gpu/drm/nouveau/nouveau_uvmm.h b/drivers/gpu/drm/nouveau/nouveau_uvmm.h
index 9d3c348581eb..51925711ae90 100644
--- a/drivers/gpu/drm/nouveau/nouveau_uvmm.h
+++ b/drivers/gpu/drm/nouveau/nouveau_uvmm.h
@@ -33,6 +33,7 @@ struct nouveau_uvma {
 
 	struct nouveau_uvma_region *region;
 	u8 kind;
+	u8 page_shift;
 };
 
 #define uvmm_from_gpuvm(x) container_of((x), struct nouveau_uvmm, base)
-- 
2.51.1


