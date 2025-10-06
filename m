Return-Path: <linux-kernel+bounces-843384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E93ABBF133
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 21:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD95B1899E27
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 19:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1918D253355;
	Mon,  6 Oct 2025 19:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PjOplA0F"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570092DCC17
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 19:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759778052; cv=none; b=WUsDRXXvLCR1dk9WaigA4c0ahWQEXwJwIdw314zbgBTiAN1zYDUzmOVT76tr993p+wAUQa1xIIs/yi4noXvsTleXx6805whkO5SkzIgQ7lgMaffBvBBE4QeIFyKV+OYk703HxIaRROYZAeGqKkcA+Z0FtdLBuefu40UGQs2NPko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759778052; c=relaxed/simple;
	bh=ZIcS8Mmmutrq6wXs8/dJhMwFqbcJEFdNwodKoHbbPXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PZkj3fLbBS6t5jdU6TBgHcxLX3Ic1LIRKYORsCdS/NzpqHTvaSvI/A885nVEv2hhLSNCG/wExHYjpKPJElCPth2jL+ZRszR1EjVPHMiiwFojAwrIGtguCK7edJHec/Or7s8d8cDs4h5N+Yfk3KTN9hPxMRlErfU1FXuaLiYn3rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PjOplA0F; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-46e37d6c21eso39409135e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 12:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759778048; x=1760382848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D1fg5U/GyUHEUoYSW2uLA1ee/vFWzHy3xrE05+0l8NM=;
        b=PjOplA0F5Rk3z/F2wKFRX8vseY20uAVIMlQqC7qjVxhcmVq+tT5tZiVCCaF1n5jSO2
         KYyixnyu6YmRMXQXTUwYwvskKN53I1T5FzkXnQW4y6vfl1tifafjSADkbXlZuq/mz2qY
         Tr9wqhrWUTdAn2P+AgN03GdIP78kPYGuF/UKZPDu/OhGdhmej7PA45ruR4Iq2xwHxdZB
         K1acmmRfF12fesr/b9sFMhc4uzDYJrOLWpNTXoc56P43AfKMkC32nWYlxFve8tNg+8Ok
         l/mrZ0ijtW13JrffhDz8wSDLxVRAZZbrN4MLMzar1K7ZH+fVBjrAjGw/wuTM/KuVS+fg
         kD6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759778048; x=1760382848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D1fg5U/GyUHEUoYSW2uLA1ee/vFWzHy3xrE05+0l8NM=;
        b=D1mDHePQ4T2C26m+7GgZHI9tTrwxmnFEhpmXdNHVr+TwmQIt7DZbiOj10eBN9QQzLI
         3ytiKh+rdSfS0A0v7W8LYct5xbbuhXpD5BnRrbQJhLzwI+PsAzUgbkKvyQb9ubd8835B
         RbsZESjZWM0L/LZptAh9enszc6ZtPkc+q6OxEJY5wo56AJmuAf8vDtBZYzuV3LlPpNeP
         cWomtGovSaRGwi7zPIGaM9TKIq9wvXLK33QqYFNN9SCkPycnLv6d/BrFwj1Tpb7WNDDv
         CszW/MDbxCbqGrLA1evP3g/XR2xxQG/Nhf+nuLY4IcG64GV3y5pD74biqy9p+Qga0RDf
         zj9g==
X-Gm-Message-State: AOJu0YwwC0kPTayLFu3TxMdK8V5PlHuZHYYGtJ6JioBOY3UAohisouTV
	6QG+aiSJZ/keJ66uomghdGyEVinwLERoqQJSfuVsGioYg/IBd8Tbm17LExrLkg==
X-Gm-Gg: ASbGnctSFw5G5KSoPDshvfNuoHyiUILTitxQJ4aEaQwedqgLcidPEShGLkfV8iE3zio
	AgY7jW2cpkzCMCgqySV4Om4/V3m7EVFFAv935sUgFUUaA+Q7U+bLMuXzpEMtt4cImypJuoimgbt
	XC+RWYlQOoVL+es9ojQdwpX7EFOHB7xhBybRTIQbPG7PkQ56DwRDN8Xy6PlxncZ+eaPDZHP3h/A
	PF3SPx4PcZQf3HCwAiq0k6RMrNnBZ7eObd42Pn+bVDQmpDj50JIrys3YsQyJrymki3fgCoXtsZ5
	awaH1VqhAueIZjiYgY3fI75Zz3Fxx6rJPLW9Pt87VlH6/0mjw1zv1feTN8q+9AKNmDpbVyHI4Lf
	pOD4yjCm+tq8nC76EotleEKpj7yR3qJrQMb4yu4/B7ZaLiregb0TOB2kdxW5F6mcvLvnQ
X-Google-Smtp-Source: AGHT+IF6rR0frEg/vaEMe0ANf9gzsCwVmoWQdq/B0a+98WReh9cKA0vT6dOHdfdyl59Refztc7ueSw==
X-Received: by 2002:a05:6000:2410:b0:3ff:d5c5:6b03 with SMTP id ffacd0b85a97d-425671952ecmr8137394f8f.35.1759778047749;
        Mon, 06 Oct 2025 12:14:07 -0700 (PDT)
Received: from fedora ([154.182.208.105])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4256866060fsm16646435f8f.14.2025.10.06.12.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 12:14:06 -0700 (PDT)
From: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
	Mary Guillemard <mary@mary.zone>,
	Faith Ekstrand <faith.ekstrand@collabora.com>,
	Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>,
	Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	nouveau@lists.freedesktop.org
Subject: [PATCH 1/5] drm/nouveau/uvmm: Prepare for larger pages
Date: Mon,  6 Oct 2025 22:13:24 +0300
Message-ID: <20251006191329.277485-2-mohamedahmedegypt2001@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251006191329.277485-1-mohamedahmedegypt2001@gmail.com>
References: <20251006191329.277485-1-mohamedahmedegypt2001@gmail.com>
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
(2MiB) pages later in the serie, we are now passing the page shift all
around the internals of UVMM.

Co-developed-by: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
Signed-off-by: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
Signed-off-by: Mary Guillemard <mary@mary.zone>
---
 drivers/gpu/drm/nouveau/nouveau_uvmm.c | 55 ++++++++++++++++----------
 drivers/gpu/drm/nouveau/nouveau_uvmm.h |  1 +
 2 files changed, 35 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_uvmm.c b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
index 79eefdfd08a2..a92c729600d6 100644
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
@@ -581,7 +588,8 @@ static int
 op_map_prepare(struct nouveau_uvmm *uvmm,
 	       struct nouveau_uvma **puvma,
 	       struct drm_gpuva_op_map *op,
-	       struct uvmm_map_args *args)
+	       struct uvmm_map_args *args,
+	       u8 page_shift)
 {
 	struct nouveau_uvma *uvma;
 	int ret;
@@ -592,6 +600,7 @@ op_map_prepare(struct nouveau_uvmm *uvmm,
 
 	uvma->region = args->region;
 	uvma->kind = args->kind;
+	uvma->page_shift = page_shift;
 
 	drm_gpuva_map(&uvmm->base, &uvma->va, op);
 
@@ -627,13 +636,14 @@ nouveau_uvmm_sm_prepare(struct nouveau_uvmm *uvmm,
 		case DRM_GPUVA_OP_MAP: {
 			u64 vmm_get_range = vmm_get_end - vmm_get_start;
 
-			ret = op_map_prepare(uvmm, &new->map, &op->map, args);
+			ret = op_map_prepare(uvmm, &new->map, &op->map, args, PAGE_SHIFT);
 			if (ret)
 				goto unwind;
 
 			if (vmm_get_range) {
 				ret = nouveau_uvmm_vmm_get(uvmm, vmm_get_start,
-							   vmm_get_range);
+							   vmm_get_range,
+							   new->map->page_shift);
 				if (ret) {
 					op_map_prepare_unwind(new->map);
 					goto unwind;
@@ -657,7 +667,7 @@ nouveau_uvmm_sm_prepare(struct nouveau_uvmm *uvmm,
 
 			if (r->prev) {
 				ret = op_map_prepare(uvmm, &new->prev, r->prev,
-						     &remap_args);
+						     &remap_args, uvma_from_va(va)->page_shift);
 				if (ret)
 					goto unwind;
 
@@ -667,7 +677,7 @@ nouveau_uvmm_sm_prepare(struct nouveau_uvmm *uvmm,
 
 			if (r->next) {
 				ret = op_map_prepare(uvmm, &new->next, r->next,
-						     &remap_args);
+						     &remap_args, uvma_from_va(va)->page_shift);
 				if (ret) {
 					if (r->prev)
 						op_map_prepare_unwind(new->prev);
@@ -689,6 +699,7 @@ nouveau_uvmm_sm_prepare(struct nouveau_uvmm *uvmm,
 			u64 ustart = va->va.addr;
 			u64 urange = va->va.range;
 			u64 uend = ustart + urange;
+			u8 page_shift = uvma_from_va(va)->page_shift;
 
 			op_unmap_prepare(u);
 
@@ -704,7 +715,7 @@ nouveau_uvmm_sm_prepare(struct nouveau_uvmm *uvmm,
 				u64 vmm_get_range = ustart - vmm_get_start;
 
 				ret = nouveau_uvmm_vmm_get(uvmm, vmm_get_start,
-							   vmm_get_range);
+							   vmm_get_range, page_shift);
 				if (ret) {
 					op_unmap_prepare_unwind(va);
 					goto unwind;
@@ -799,10 +810,11 @@ op_unmap_range(struct drm_gpuva_op_unmap *u,
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
@@ -882,6 +894,7 @@ nouveau_uvmm_sm_cleanup(struct nouveau_uvmm *uvmm,
 			struct drm_gpuva_op_map *n = r->next;
 			struct drm_gpuva *va = r->unmap->va;
 			struct nouveau_uvma *uvma = uvma_from_va(va);
+			u8 page_shift = uvma->page_shift;
 
 			if (unmap) {
 				u64 addr = va->va.addr;
@@ -893,7 +906,7 @@ nouveau_uvmm_sm_cleanup(struct nouveau_uvmm *uvmm,
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
2.51.0


