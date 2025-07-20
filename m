Return-Path: <linux-kernel+bounces-737988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 612E7B0B2E4
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 02:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C51717C6CC
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 00:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27A818C322;
	Sun, 20 Jul 2025 00:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dl09NeZp"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF891624EA
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 00:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752969740; cv=none; b=NlRon/b9DXJAYPwTqKjP50ZT43s6DMzsPcFaO2HcmThSaKHTw/ty04P872iGMPl+IxxEgU6vyzo1gWGFKLKOBm5lHmjcM9f8BbCe8HLBAWDcncGX3/CwH6YU7FjFfHtpFwDDC28Ueu10axQYXC9T4BU+j6HA+dvYzDMFpOclTCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752969740; c=relaxed/simple;
	bh=euR2VwgCkRIWXyTzig6yI4wtQ7awSnyxjngi6S8bOig=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r9FXZvrmA9PHEHnEFzpkMSae/9bOYSePYEshmRDmt6SMdBXb387hoMZX9ZEdsnFzAHvA0a5+Ar7bFN56YQ+P7A1Gr/kSJpCunFTaLfEyetFaCDkBfwy7sb2pNmxfGyvpGqjoASMdUjlwexEcqOXKDCpr2enx/3Br3tzpjhIUGho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dl09NeZp; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7494999de5cso2217153b3a.3
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 17:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752969738; x=1753574538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f0g8euYzh4PVKXcq3yGRqIgxnHvB130Kw4K5TtkFvGs=;
        b=dl09NeZpQLugQWg0fK/KZE3Vem4sM84FPRvcZ4egazCX7Mq/4bUMKjLrCDvbJyRXLV
         xjyD8jmNE/PlHU9j4ecTEhPq0LSWLc2k27ouepK07zUiiVmRvDxSCFe3hw0xuDYpVdsB
         LttCImjzqL0mrS70Ew1+98pzHK2IK27/DpWLPojyUxBajU3CwYijt7h7CVbGcohag/GL
         h1cMXl60lNOyOXrlktYkcobLcbPxZ6iP2MjvfD20IVfsK3uWDoTLOv/qshS5n9R7InLu
         gY7ehClje8BQkmeNJUsxnde9UGctPKW5qN2Hws0FwHeD9w13BRRX11g1O7l1imZdP9eu
         7NxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752969738; x=1753574538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f0g8euYzh4PVKXcq3yGRqIgxnHvB130Kw4K5TtkFvGs=;
        b=a4IRxm0CqsrT/mVB4WSG/+7jU5OyY8zzNbeya59XI3pVHO7WVdMlg88iz6RQQ1f8El
         WX1dKKw51Xpha/yXPG5j2Wjn8Fjj08C7bL9F/lF8/ocMpQOrnvUQ72u0HM2EYbJmlnR+
         kuavcVgu6T6P+Jt3zxFwC0deGdDoj9641IQzVKYv1Qtz2kjTdPPuFbKGbdkkgsMdDwM/
         3xX5n6VE9uz+lc/OHqCKsHYreu+XGbrxQ55Wk8HBW7krFEeMwvhjHZ3fR84coYYaVdrq
         AKuimqUzLOZEdjJ7M0w/F6bhsWEomrRY9u7v96SiVMaGwNc8zTkyJ746QOXltF6P3dI7
         a8Wg==
X-Forwarded-Encrypted: i=1; AJvYcCUXKpys52W/asa0SMySzNnNywOsmpuoO6RHegmJSH5vDrdfW07JWELT93SagDXPbsnqtTYZeT7K1AlLzmo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoHOBCg2A9QQLoPP1ot7yDiJdGMY4MOhxokAatWBXtzm8Kn8aj
	K6m2WP2q6qkcsiBi5hWcDYH1idW5ZSG5PyEXPMSsdt8pbkxSfK7UtDGU
X-Gm-Gg: ASbGnctIIx46wXdG0BvEY4LWkR/6IJnJeQiSgkzWF4z1F2vhcGbw8yX/qfZmBAhJ/zA
	EmqdCKrJKeopK+0yk0h5Vc7J/jw3cvvNd11YQWwNnAavpvkZZ2Q3gsudStuGUzQhJ/w5sBcaOmd
	eJriv0KmhHEy7LFtwJZCFcSyAYhqA3ecpR/JtsQsdVNPQyqTxThT5fUh2Bv5dGXX4jAJePFsDtG
	CBZzZbBIj+FkKtyRJVVqiJ9nNvmuCmRKQJDdKKUeIN3jGDdz6JCnd0Srv1cq0W6fAo+MjQKP3tI
	mgrWs7rPQATbUreY2EiJ5RfYaklzqjWH4Z9nxqyh7iHC1uDmyES8ZSf2JLvD9xvdMc2bwfMH5SI
	Cy9Xkl6I1Ro3hxowMRNkZoquEOhwo73Shrxw14RvCflBCzITueCsv
X-Google-Smtp-Source: AGHT+IH0XzEBS9bAnV+/bToDYJIzXvhemGCeVDQs7hDsvK1S65xaiAr4na/7QXrJig0yY3pxRhrAMw==
X-Received: by 2002:a05:6a00:9298:b0:73e:2dc5:a93c with SMTP id d2e1a72fcca58-756ea1ddca4mr24913433b3a.11.1752969738104;
        Sat, 19 Jul 2025 17:02:18 -0700 (PDT)
Received: from localhost (111-252-5-201.dynamic-ip.hinet.net. [111.252.5.201])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-759cb678d9bsm3377982b3a.109.2025.07.19.17.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 17:02:17 -0700 (PDT)
From: Chia-I Wu <olvaffe@gmail.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 8/9] drm/panthor: check bo offset alignment in vm bind
Date: Sat, 19 Jul 2025 17:01:45 -0700
Message-ID: <20250720000146.1405060-9-olvaffe@gmail.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To: <20250720000146.1405060-1-olvaffe@gmail.com>
References: <20250720000146.1405060-1-olvaffe@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fail early from panthor_vm_bind_prepare_op_ctx instead of late from
ops->map_pages.

Signed-off-by: Chia-I Wu <olvaffe@gmail.com>
---
 drivers/gpu/drm/panthor/panthor_mmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index a857a0dd1099..7862c99984b6 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -1206,7 +1206,7 @@ static int panthor_vm_prepare_map_op_ctx(struct panthor_vm_op_ctx *op_ctx,
 	    (flags & DRM_PANTHOR_VM_BIND_OP_TYPE_MASK) != DRM_PANTHOR_VM_BIND_OP_TYPE_MAP)
 		return -EINVAL;
 
-	/* Make sure the VA and size are aligned and in-bounds. */
+	/* Make sure the VA and size are in-bounds. */
 	if (size > bo->base.base.size || offset > bo->base.base.size - size)
 		return -EINVAL;
 
@@ -2423,7 +2423,7 @@ panthor_vm_bind_prepare_op_ctx(struct drm_file *file,
 	int ret;
 
 	/* Aligned on page size. */
-	if (!IS_ALIGNED(op->va | op->size, vm_pgsz))
+	if (!IS_ALIGNED(op->va | op->size | op->bo_offset, vm_pgsz))
 		return -EINVAL;
 
 	switch (op->flags & DRM_PANTHOR_VM_BIND_OP_TYPE_MASK) {
-- 
2.50.0.727.gbf7dc18ff4-goog


