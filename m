Return-Path: <linux-kernel+bounces-843385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 414B2BBF13E
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 21:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D71FD4ED3E2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 19:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D772D5436;
	Mon,  6 Oct 2025 19:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jmoyugqr"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F6C2DEA83
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 19:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759778058; cv=none; b=TlFL2Gdrrv2agmnuboad65DbzBwsTSYKrPMFRb4ylZNG8CsZf/St8KSYDTuZGEuSyJaV/2zDVCiCpzWYCgJii2oSapTTxGFksStZWWALmJFgO2Wwbu00Pq7cia2irVrqrIeTQRdUsFVyBqXHKiLLedg4gZ+gImwM83HCirD9N08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759778058; c=relaxed/simple;
	bh=5ItGTF9EYZUxAeNOySOjfAhlMFY2cqvYZmvtzq8PvfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cAo4+fIZiEp4UlAkRmwZK3dAWJIr6Un9a7Uh4W3TrnnOMGgA9AtFyx7Qi7Pms0b6/ti4HAc/DpVUp5zwD5E87cRKEMH+W6tQkMDP8KzCGpDF4gOhQsGg7dZA58ZOV1DITTjFIfdk4KZELLQSNsDJIwUKfiQlDrNTQdjrdEwULsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jmoyugqr; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-421b93ee372so2516269f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 12:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759778054; x=1760382854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1j0V90HxcPRVTKrhHkvxSsBjf2AtjVnHy6SmuJWd4uc=;
        b=jmoyugqrmbCxfcM+AKWwoIflSiAkmp9VEi6EsPDRx6e4kRB+GDIBakI1K5NV1IpLp9
         qU9nfH3sOQ5ulzRBi5I0jHbF9mnjiDtKYDXx+fC8EvdlzkTWDtvEuRmITueYII3Y0S0U
         t0+H5KwoIf++pGbqFwqqEVD4R1xKWgykjVoqLO+xO/QMMgoO9rcpDWqYKqwVY+h9yOEu
         EqnHpjS3byU0Mc9h5n9NmEjxyQ8I/WrV11OQaGSDVp72CNWtmfS8ECwGIN81mbEwP5ua
         l9UiOA5YPfEkSskmW1bZchSge/L/+E7kCfppgRRVLftCaB1QtMW2YvK05OckoxOnZuWx
         Xyxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759778054; x=1760382854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1j0V90HxcPRVTKrhHkvxSsBjf2AtjVnHy6SmuJWd4uc=;
        b=JaQE0kXrgF4kvulazE9hk3WCyNHRh/aXvnVEC7sX0QvJfVnZ8S9WXd9+xgsTj0kLtJ
         NRvLSEYjkchVykLw5xkoUL6amOxUSAIxP9Uze2c6qO5Dn4JsgmYv7QEoM9ac7a4TTXkL
         h1PdGKyUou+IISOjzMaC96f+77Q7cyomIfT88ZQ/PCfIL4y6WF1zCkyQs4m0UOApZT8L
         dJ9Gi33VSsV8s4UKLA2K8PARkWy2UMOmCBx8rKaYz/rV/k3YRN/9MGn5LpnBPuojvqCK
         +1nWw9RXp0/krKb6qv7P4eb2nXJiBnhB1K18Hp7WL6aZBEKNkcH1Z9rv+3D1Xm29DY5H
         0vAg==
X-Gm-Message-State: AOJu0YzI3A5eEHrsbgmY7amWQUdry4QQ42GMT47wmH2c2iCGkMdrTslD
	aO5KsWlRGyS8s6/SoLmdSD4ZwRJKVN7ZBYB4oOFA0C6uXquH2IcgZSkfK+vMgg==
X-Gm-Gg: ASbGncuAtS8YD9ULCqzwmHvOT2FPzk0bAWugoHb4TFKq4t7G1+BUUwphxiXCbWsQynt
	oBa66wOliJG3iO8+TdZBk7/jWI/a9oDc/EdxuSlUbTdhS75+mVm0dSKH+YB6UUCuiuUZJfwx5Lw
	K6aotNVcd5GQlITOqBHhRnXrPgxHuUKORTS+koHxSQFtX700xDs575QdqTTnaWj8Sz6AQfUPnFy
	OoT1YUarENh2m+dxKAN2qoKUBg7zZJ+FvCJGVe3RJHApByhR4sMObXchxRQvdlEV7FD/K2WZvE7
	65uZLH75oT0rvjU8N5Fsm78crP1qDJKBEVx+7PwsLZU9dRCpy3LpthjiiImjzqHxcZE1lOXWejG
	tdiD780qk1oqDoT/RK5TvdY102OhCngkJROaAxzVZpRJViyKvInAtK9IWj1hhul6+PGgw6ME8i3
	88JGE=
X-Google-Smtp-Source: AGHT+IFUbfCqi9C93YR2bP5dtsE3l+2iS9CguomaGDGXJEXk2nSHZJBr5r0pl0Mosg68LCW/bIjt9A==
X-Received: by 2002:a05:6000:1842:b0:3c8:7fbf:2d6d with SMTP id ffacd0b85a97d-425671b28ecmr7651955f8f.50.1759778054388;
        Mon, 06 Oct 2025 12:14:14 -0700 (PDT)
Received: from fedora ([154.182.208.105])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4256866060fsm16646435f8f.14.2025.10.06.12.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 12:14:13 -0700 (PDT)
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
Subject: [PATCH 2/5] drm/nouveau/uvmm: Allow larger pages
Date: Mon,  6 Oct 2025 22:13:25 +0300
Message-ID: <20251006191329.277485-3-mohamedahmedegypt2001@gmail.com>
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

Now that everything in UVMM knows about the variable page shift, we can
select larger values.

The proposed approach rely on nouveau_bo::page unless it would cause
alignment issues (in which case we fall back to searching an appropriate
shift)

Co-developed-by: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
Signed-off-by: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
Signed-off-by: Mary Guillemard <mary@mary.zone>
---
 drivers/gpu/drm/nouveau/nouveau_uvmm.c | 55 +++++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_uvmm.c b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
index a92c729600d6..c336a121e320 100644
--- a/drivers/gpu/drm/nouveau/nouveau_uvmm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
@@ -454,6 +454,56 @@ op_unmap_prepare_unwind(struct drm_gpuva *va)
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
+	if (nvbo) {
+		/* If the BO preferred page shift already fits, use it. */
+		if (op_map_aligned_to_page_shift(op, nvbo->page))
+			return nvbo->page;
+
+		struct nouveau_mem *mem = nouveau_mem(nvbo->bo.resource);
+		struct nvif_vmm *vmm = &uvmm->vmm.vmm;
+		int i;
+
+		/* Otherwise let's find a granuality that will fit. */
+		for (i = 0; i < vmm->page_nr; i++) {
+			/* Ignore anything that is bigger or identical to the BO preference. */
+			if (vmm->page[i].shift >= nvbo->page)
+				continue;
+
+			/* Skip incompatible domains. */
+			if ((mem->mem.type & NVIF_MEM_VRAM) && !vmm->page[i].vram)
+				continue;
+			if ((mem->mem.type & NVIF_MEM_HOST) &&
+			    (!vmm->page[i].host || vmm->page[i].shift > PAGE_SHIFT))
+				continue;
+
+			/* If it fits, return the proposed shift. */
+			if (op_map_aligned_to_page_shift(op, vmm->page[i].shift))
+				return vmm->page[i].shift;
+		}
+
+		/* If we get here then nothing can reconcile the requirements. This should never
+		 * happen.
+		 */
+		WARN_ON(1);
+	}
+
+	return PAGE_SHIFT;
+}
+
 static void
 nouveau_uvmm_sm_prepare_unwind(struct nouveau_uvmm *uvmm,
 			       struct nouveau_uvma_prealloc *new,
@@ -506,7 +556,7 @@ nouveau_uvmm_sm_prepare_unwind(struct nouveau_uvmm *uvmm,
 			if (vmm_get_range)
 				nouveau_uvmm_vmm_put(uvmm, vmm_get_start,
 						     vmm_get_range,
-						     PAGE_SHIFT);
+						     select_page_shift(uvmm, &op->map));
 			break;
 		}
 		case DRM_GPUVA_OP_REMAP: {
@@ -636,7 +686,8 @@ nouveau_uvmm_sm_prepare(struct nouveau_uvmm *uvmm,
 		case DRM_GPUVA_OP_MAP: {
 			u64 vmm_get_range = vmm_get_end - vmm_get_start;
 
-			ret = op_map_prepare(uvmm, &new->map, &op->map, args, PAGE_SHIFT);
+			ret = op_map_prepare(uvmm, &new->map, &op->map, args,
+					     select_page_shift(uvmm, &op->map));
 			if (ret)
 				goto unwind;
 
-- 
2.51.0


