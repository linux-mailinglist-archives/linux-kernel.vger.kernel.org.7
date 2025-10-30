Return-Path: <linux-kernel+bounces-879245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D272C22A03
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 00:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4E52E4EAC30
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 23:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5387338F52;
	Thu, 30 Oct 2025 23:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KPsqzox5"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F782E4257
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 23:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761865465; cv=none; b=RIJDuFzwK5CAegec789W8BkTYn47K1bmHmMCg+0gbG1ISLmQFor5av9EmLJBp9rv3ZIsMzY/svxvJINluJc0QP7VX8E4BC1DZSgcUd5KnF/RScXZzue18X5rtPHlNMSr4U8Dk1C0HpreMlyK6Ghysjwl5zFgFUaPe4YmRUv/F8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761865465; c=relaxed/simple;
	bh=RyudmJXPWxWDQI94X+73YWpu+3qoRpwAgYxRsvc+kyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AuhsmEJVODoEMFljULi8g+PWVHkk9bVf6dGVyDeShP6yIdZPdZEv9gab2waX98fCir62r7QZBtns+hjmlYKFk3dUH19bbtxbXnFL5YVOrEqdK6SoVWszk9B1w8yh7Uu70I/w/m5TwaXjlVym4sU74KddG+3/rxwT85nBUXcewWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KPsqzox5; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4711b95226dso20561615e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 16:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761865461; x=1762470261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AKZ8AsjriREu28KWguGoIt9B8lVGieRdwO7NRV/7JlQ=;
        b=KPsqzox5RQMvZOGblVkNfGNo/8KXIf/9/633/0iqec/5KeFCjnnSu3PbbTP31BFFs0
         wZWNTPV2XQyVecc0jmzjgJWY7aOBJpLkHxjlMz1w/0+8tKchEUdcDd1mH71INZsnjVeu
         QLi7DBs18NCbTGtLKQhj72l9ULVqKhl196A6wWdkZ8yRuE9XZr01B9rBJE9CXyo/Rx6N
         3tIyvyxN7ZjLIcwEd4iF5yx87rl7tRjDSnhJZaDZEi/YL/wQxJvPjeOJE6ETUo+L0k64
         Ho8DftlMMAWy9xG6RXSv+6uKQgYwYWI7BtbulAhXPioFZAgCliqV5FBGXtreOuMqAXX4
         99Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761865461; x=1762470261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AKZ8AsjriREu28KWguGoIt9B8lVGieRdwO7NRV/7JlQ=;
        b=fqhQo60yadkTzpmXzP0LENFdqxruXyUPFahnyb+4dyq+5I3WnkRznlVNNawG0aovmJ
         5o+sIrmdpKEra6KUotg1AJR7ScMSGECIgcRekU0ngZpLJ7CvLlZxE6rEgTKp5jYX/0qk
         hAPvD+QscexrE+iRG7NCF1y6NPIs1krqZVQM5u9MyuC718MdoD/9F1vGch5nn1ZyC9uu
         4TAzLUe4yBZUvLwFAXv8SJWnpqOODhwuEGNSALuAj0+NP9l/RXvUcq4B3oj33txeOT5e
         svmWuqCkJtHSC2WkrScphmdZ4GCsgV9QN5JbR4AztjRGbIpbJ7ezTnkgUKB64z7d+1oT
         eecw==
X-Gm-Message-State: AOJu0YztGwt5JoDwv5DGUXFZyQIYRFwEVSdv1Y41oF70fiOUTbWL8aE6
	q8z1+o+zZZVpfzwEFVBpIcdnuayCFIr4fuQvgkMNXGBKgxBoRUoTYafPOCEYpAFz
X-Gm-Gg: ASbGnctZWtfles6KoYkXp42DfUfLj9ifj3TnpFaDU8TmzcZx9NjCw0Owqp1oQKw0Ex7
	eGMWXWYk552w8SH64ocsGPEWVpbL3aJqwA/OMNRDw9ogUK4d9vA5EG0HvTluDwenZKlPzvl4Q9O
	QotvlkunYSy/qQ4qYOKse8eicmlO5kPjEuAm1ih8AL6EssgKzHxNlW+IO9HRl9uDbcNguDXmCT5
	ePMw2kggx6k6dnW+72jjAHDzBeO2TAmdtDNoSFWZCVgiNEN1X9kQ5ZU1iJDclYAdD0J1c+7puB8
	YAJoGUoEcEjDI7xx9LePauzXsashwod5c2tUB8xCurtrigzARll3TVVsjLQxXfpPepatCHhkYJa
	8MyMilm/vI5gYp8LK1bayeHAQINUIhf67AFnE4B51VhZ1MaKnnH8wffvpZgb2VeGpfmOP/NMFOz
	aOgVvS9NhM5W4=
X-Google-Smtp-Source: AGHT+IGvqeYE+ZtasL202hzyMcJJ4edAKilBbNz44Q/Nk6YXiZiyYpDoMiNbTD4qbZkcLZ1eELhQyg==
X-Received: by 2002:a05:6000:2c0b:b0:429:b8f9:a887 with SMTP id ffacd0b85a97d-429bd672390mr953743f8f.6.1761865460869;
        Thu, 30 Oct 2025 16:04:20 -0700 (PDT)
Received: from fedora ([154.182.161.198])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47732ff8235sm2227025e9.14.2025.10.30.16.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 16:04:19 -0700 (PDT)
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
Subject: [PATCH v3 1/5] drm/nouveau/uvmm: Prepare for larger pages
Date: Fri, 31 Oct 2025 01:03:53 +0200
Message-ID: <20251030230357.45070-2-mohamedahmedegypt2001@gmail.com>
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

Currently memory allocated by VM_BIND uAPI can only have a  granuality
matching PAGE_SIZE (4KiB in common case)

To have a better memory management and to allow big (64KiB) and huge
(2MiB) pages later in the series, we are now passing the page shift all
around the internals of UVMM.

Signed-off-by: Mary Guillemard <mary@mary.zone>
Co-developed-by: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
Signed-off-by: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
Reviewed-by: Lyude Paul <lyude@redhat.com>
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


