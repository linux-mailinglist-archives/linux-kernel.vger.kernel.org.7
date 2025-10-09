Return-Path: <linux-kernel+bounces-847568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3C5BCB35E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 01:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 039634278EA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 23:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42640289E0F;
	Thu,  9 Oct 2025 23:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a2E83KHb"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9A4289E17
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 23:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760053177; cv=none; b=YtpN9AhOiGWwGTyEEJrepM3rxu5A/KguKJutDq1U+x7MzPowGeC1tCDpKIA1farHIIxa7zjBQhDb48v4zpBqfbfOLCySLF22eHZauhDFhvL8roAjin6+xisowX/lO/35ynoHCHCQ+h7t7bfvBf7K1BUrnrWjJvzXWHHx58IAHSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760053177; c=relaxed/simple;
	bh=87JDphCaHktiF6piSU460m4DUFo2x5gB2FcUdBbP05k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JjJ7kFs3UGH6HDdO5zBD7WoRVffcfnpsb2HFTT7fIoXOZ1s0D5yd3jaYB6Rf1/H6NQmzLZJrrP4U32zB+iTGXKLqN1l4aAUW86FtJixC61v6y0cAOQ+SnLgvT4XP6E+mbym9xbCK0+hOBW+FbWPrVAhcYP54rUnn4zl0BHaT4W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a2E83KHb; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3ecdf2b1751so1064919f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 16:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760053174; x=1760657974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SNJhbRyXnLpVcJDyTCl+QlImHdH1yijCDQYOlaa6U08=;
        b=a2E83KHba9yA9guMRkHcGN8yRzwSa+GTBsHLJ9wSA/YwBlStO/KCkKcExDDlN9CT/e
         p4pSvdN1fQtUeYe4amZsK5VcN5VbQbbVv1Y3Jq6lRURrhdx3sJwWyaksBcAkvbYDP3D9
         DwgZMTMX0VRcm4nw2M5kNwODkVRCuy3mhnUQnV44nN4jgq+BZEnSYsgiwVZF0hh/JbbR
         1gQgrHiAwzmgBY300p8Qx4ls/LtmFMjIQsDwmuU9Nh4FxTdzkYY1KUHbIHcBXnghM0TK
         R5IIERy8saXloZPIeQoNEhHe9srAOVnOAfHfpEEsx5ticDYSK8YgSHWeVUh6XkMCT9Ik
         dqqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760053174; x=1760657974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SNJhbRyXnLpVcJDyTCl+QlImHdH1yijCDQYOlaa6U08=;
        b=Cpu9dgJy26ccHVzTFJVP/ofIH+Q6koymCTGPgbrpGoAdKxcCuoIiA2jdlb3vpicO17
         NaIiXlTsa+0OS+UBNM/ndO9giTMSNddisB+HTl1qWVpL/aXa+t9uawWcRp4UTYJyQ4Zv
         4JQKh4twILR0cApKUJqaepcvrfMtXgokrrPGJSI3Ag5RHiqUupj4KVXeDpurPyEW5wbi
         lA7ppJFQSEja64uwxjgdyRibXPLUcotG5oa7vOIC88rso7b+JUqkMIsNiMhEsnjmZQtc
         NYzV/JQrAlaVRJoTF4QM3c9+h34Ujaa2xOITcvmPiPuGmS3lC16Xaea0ibC6wgnT5+Bo
         5Lnw==
X-Gm-Message-State: AOJu0YxpIRV89JYeQ1/LlPIXCk/QdgTzxERybnwHyWssQE3RROS2sJim
	s3WfkW5pyvmG3hx2QDdUAk8nomxS9BFjSKpY8J2VHc2J1B6B98FobN/t2vlQHw==
X-Gm-Gg: ASbGnctha0wcgp12pzuLfbCwXHlC2uwDH3yNzgPUfcxMOvvQsxVM04vqHpodLnEcRTI
	DfKzH6+dQUt44qfOfQjEG9ASNqnkZhG8PeWOXaKzr7HWRax4oF9edid3Nx/OPfhVxc8VTGlgGLT
	01nu53vpUmG0+T0KmATamyiSuy+ic5rhHMPZL0+RzxfEyFyQ7pxaAZqOoFnXk4m4nrgZlS3EChh
	+CIZWTLMFVnVWJHXahGRYsIuFSwuYGjfz+u7ZxW4/3EWkYbNxBz30I35/tqvI4MdeBHnTQrGQ0H
	FT/70DXy1DZAE/s8ClebMZtkMbaQYoqCziXxRMaOVJJoxzqoCsHO0RNbgWejpagKZyqe7+oXVsJ
	NoYS6krphpjYvEQ68XQmdIcOsrWiCYb010kk7E1U80xxacziQ3dVu
X-Google-Smtp-Source: AGHT+IEHbriviJcKghNvsIijh1pBMhiKzJ4SyCmZlLqgkmtnMByimnxocABQh66B8voRln+z3wk6JA==
X-Received: by 2002:a05:6000:2485:b0:425:8133:ec6c with SMTP id ffacd0b85a97d-42666ac634cmr5253436f8f.9.1760053173778;
        Thu, 09 Oct 2025 16:39:33 -0700 (PDT)
Received: from fedora ([41.45.27.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fab3e3206sm46066075e9.4.2025.10.09.16.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 16:39:32 -0700 (PDT)
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
Subject: [PATCH 2/5] drm/nouveau/uvmm: Allow larger pages
Date: Fri, 10 Oct 2025 02:38:34 +0300
Message-ID: <20251009233837.10283-3-mohamedahmedegypt2001@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009233837.10283-1-mohamedahmedegypt2001@gmail.com>
References: <20251009233837.10283-1-mohamedahmedegypt2001@gmail.com>
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
 drivers/gpu/drm/nouveau/nouveau_uvmm.c | 29 ++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_uvmm.c b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
index 2cd0835b05e8..26edc60a530b 100644
--- a/drivers/gpu/drm/nouveau/nouveau_uvmm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
@@ -454,6 +454,31 @@ op_unmap_prepare_unwind(struct drm_gpuva *va)
 	drm_gpuva_insert(va->vm, va);
 }
 
+static bool
+op_map_aligned_to_page_shift(const struct drm_gpuva_op_map *op, u8 page_shift)
+{
+	u64 page_size = 1ULL << page_shift;
+
+	return op->va.addr % page_size == 0 && op->va.range % page_size == 0 &&
+		   op->gem.offset % page_size == 0;
+}
+
+static u8
+select_page_shift(struct nouveau_uvmm *uvmm, struct drm_gpuva_op_map *op)
+{
+	struct nouveau_bo *nvbo = nouveau_gem_object(op->gem.obj);
+
+	/* nouveau_bo_fixup_align() guarantees for us that the page size will be aligned
+	 * but just in case, make sure that it is aligned.
+	 */
+	if (op_map_aligned_to_page_shift(op, nvbo->page))
+		return nvbo->page;
+
+	/* This should never happen, but raise a warning and return 4K if we get here. */
+	WARN_ON(1);
+	return PAGE_SHIFT;
+}
+
 static void
 nouveau_uvmm_sm_prepare_unwind(struct nouveau_uvmm *uvmm,
 			       struct nouveau_uvma_prealloc *new,
@@ -506,7 +531,7 @@ nouveau_uvmm_sm_prepare_unwind(struct nouveau_uvmm *uvmm,
 			if (vmm_get_range)
 				nouveau_uvmm_vmm_put(uvmm, vmm_get_start,
 						     vmm_get_range,
-						     PAGE_SHIFT);
+						     select_page_shift(uvmm, &op->map));
 			break;
 		}
 		case DRM_GPUVA_OP_REMAP: {
@@ -599,7 +624,7 @@ op_map_prepare(struct nouveau_uvmm *uvmm,
 
 	uvma->region = args->region;
 	uvma->kind = args->kind;
-	uvma->page_shift = PAGE_SHIFT;
+	uvma->page_shift = select_page_shift(uvmm, op);
 
 	drm_gpuva_map(&uvmm->base, &uvma->va, op);
 
-- 
2.51.0


