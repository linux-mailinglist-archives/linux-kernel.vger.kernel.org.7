Return-Path: <linux-kernel+bounces-838733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7888BB0091
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 12:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 388B2189134B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 10:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E60D2BF3DF;
	Wed,  1 Oct 2025 10:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zhyHhjKK"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B944F1E9B35
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 10:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759315311; cv=none; b=gASHSsS2ahm63USy/LGGL5WWn7dJnlZKT1Yb1PyYBd/UHENsmNtE1FzeG4xH8VgvOdw8CIOgolbpm18kIyYYambQ0oWIS4StTDEiA5AyMzDzwQa14GrVg2YbSTKOLwpLqT0X4T3F6r3lh5El4V5iJL52LTnrDPCpS9nlnpPtIqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759315311; c=relaxed/simple;
	bh=CYKvLAiGqs++D4GTcDP3BiBOeQPlODqXyzh5jaw8M0o=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=XnKcId2MlYtJKyve1iG56+GJqvMwm+9uD5pnDWPyURMMaUUSzppkKCZsc1jx85LzbNRb4HxW/avJC0tki6e3d0lEeyrEZwSdRx3EVvRpaD8RxkEzT4wbkkRowm5ZOiOOdr42svZNTk62WwpKgZZiKvioP0Bk7t3TNsgrRlsmMhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zhyHhjKK; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-46e303235e8so51874485e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 03:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759315308; x=1759920108; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=q4AkcJXKNZTBwi85jKp+KXwdlDEEaE6EAE6141OGSoI=;
        b=zhyHhjKKHDbzGc6eUN9uKktehzgz7cBP0LSh0ilZwVEOS4sM0LKphQfUSbICTBLHM1
         oW203otNkVj4zB7hW9v4pfEEkvTtIB2+XyBRKXwu6f1G45f719JmexBsUSbJyUJzb3nB
         QRNKi5SGJo2FWM7WT74rTKDKXwEm3g6u62BkFKE7iTfPvZbwPTPpldBTSDCPLA03Iv+D
         hDbRUjMRlvXExREujpjmwjUEcVlQbPgrFYf6w0joMTxYI5JjLQN22xrz+owxGnNSCGtc
         T0IFS0mP7tDFxXUWTnGQ1e29F7FJCr1F1JgfznaPcY+vN16KtlMHZ0Ume1zBq88y6b1T
         9FMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759315308; x=1759920108;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q4AkcJXKNZTBwi85jKp+KXwdlDEEaE6EAE6141OGSoI=;
        b=adhjOuzGxmVRKmvWCWXIxM2vhyCopvamOnQxhcV6BdQFUD4Joruf8TxiLwjwlY7ghX
         tMrhBc4m4ln67dlrFOJ1MVk8bw3Wmc8OONn2xozqY3ZwecgZzPunNbdMhd46iqBki9tJ
         qm3s2e2opCLynNte1tChxcb4ikpuDHWJ6Vsp6kD9vnDXN3iGuAD8GHfaEboZ1T5JnHll
         R3oGUTXxPbfQJto2Gs/1vqw/ild00XGzfBudfQ0jbawwighldiiWgOFH2sTbphyZqwJ3
         52ovyH0APOw32lbJkZteA4AYozm98ugkqeNIRCYId3NUBhzJKB6IiT+2tFYQNe36wpmv
         7myw==
X-Forwarded-Encrypted: i=1; AJvYcCVaGBlGdJhz59hn7YdcA7+/RL5EhOdap0UAuJtxVixnAEEUgmMrUTfdf68EaaC1XYi149CIyJ9Ru2TwR8E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR6fB76JN6OnQfyBsH8n9ZojespUcvBFZq0+0PpoLSaOwjskZB
	SOfcUT89WXAV1ZkfyYqlVJRJbOY+mmG33+sxC8Duv/VfKmrvXXnmtaZ3nyRShfgNEHLjtI3bqTN
	8PjOPfxdv/i0s3Mdoqg==
X-Google-Smtp-Source: AGHT+IGcmZb44kUZq9xm+3p/jxi0dJbJMOnTYuGcLSzG5k94a12SYjK9rXC/hs1AahMddzAyDeqHtr6Uml54uVQ=
X-Received: from wmhn17.prod.google.com ([2002:a05:600c:3051:b0:46e:4c7c:5162])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:5009:b0:46e:436c:2191 with SMTP id 5b1f17b1804b1-46e612dad75mr26829995e9.25.1759315308065;
 Wed, 01 Oct 2025 03:41:48 -0700 (PDT)
Date: Wed, 01 Oct 2025 10:41:35 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAF8F3WgC/23MSw6DIBSF4a2YOy4ND6nQUffRdIByUZIqBhrSx
 rj3oqOadHhO8v0LJIweE1yrBSJmn3yYyhCnCrrBTD0Sb8sGTrmkmkqSxzYQiw4jEc44Ta3izEk
 oYI7o/HuP3R9lDz69Qvzs7cy2928mM0JJY5AZoXh7aepbH0L/xHMXRtg6mf9afbC8WK2EtI2oN VX6YNd1/QKo59qP4QAAAA==
X-Change-Id: 20250905-vmbo-defer-3faf90d821f5
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=2783; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=CYKvLAiGqs++D4GTcDP3BiBOeQPlODqXyzh5jaw8M0o=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBo3QVlY/GHVqJ/AVp07a8vNu/sGadftMNeocEXI
 xHxNOEhvQqJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaN0FZQAKCRAEWL7uWMY5
 RkUvD/wL0NxeTLlUXgmCpoqQuEkfJtg+jiefX3y8GEOK55Q/rzQGJRI5dgeoJN1jwzO6eKi2oul
 iO1zo72lQo3sKnlksRBEd9nXquUYdm1EtInbRdCqpCCzgiwl0cqjvZnGfTIPfer53XkjVxFgmtG
 QIMaGcXhtCckI3WcwKhkNVlWSUTRq08dERIBWGE3a6yEa/F6aJZW8hphUgAvbPN/n623fdvystt
 OpXo17yocNkUWBxz+iU2qV5gbnZaB6up8ONo935QGBxWQOzK2BRsEpkNe74+Nrl/J247MJfuB+I
 sAj9wCK9+uxfbp3LthFHU0SffeZQvnpnR0cDepUI0lSGry6S1lCcyscINuDqU+wbs23epZr+kGY
 yzMrMG3Mdipor6G8UcZKq3Bc/oFfudwjObAEEB4a9CAMfnrrFWBB+6hTU8ZcllpUlVB7eKHio9g
 4rYdaFC4cytGEGlVsNDzAQ+Y1GDnuDdlF3whVi1e9becd7+gHiH2VH7ZU+dpx2amyrVdfqIUMJp
 4EGtRez8xTrvMv3zseWpyhEPaHYGthWCLVm0EKNT9BabO2BDC/JiuL82tRZHssS2kPI43dNi000
 hgda664j1McYDESA3yVlmnck8iE+RR/edmhLjG2gsfIg5n4IFaCoECz61eYAaNysbSonemAbXMO f4L+/q/FXFoKoDw==
X-Mailer: b4 0.14.2
Message-ID: <20251001-vmbo-defer-v3-0-a3fe6b6ae185@google.com>
Subject: [PATCH v3 0/2] Defer vm_bo cleanup in GPUVM with DRM_GPUVM_IMMEDIATE_MODE
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
	"=?utf-8?q?Thomas_Hellstr=C3=B6m?=" <thomas.hellstrom@linux.intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Boris Brezillon <boris.brezillon@collabora.com>, Steven Price <steven.price@arm.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Liviu Dudau <liviu.dudau@arm.com>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

There are two main ways that GPUVM might be used:

* staged mode, where VM_BIND ioctls update the GPUVM immediately so that
  the GPUVM reflects the state of the VM *including* staged changes that
  are not yet applied to the GPU's virtual address space.
* immediate mode, where the GPUVM state is updated during run_job(),
  i.e., in the DMA fence signalling critical path, to ensure that the
  GPUVM and the GPU's virtual address space has the same state at all
  times.

Currently, only Panthor uses GPUVM in immediate mode, but the Rust
drivers Tyr and Nova will also use GPUVM in immediate mode, so it is
worth to support both staged and immediate mode well in GPUVM. To use
immediate mode, we must manage the vm_bos and vas during the fence
signalling critical path.

The first part of that work was the introduction of a fence signalling
safe mutex for the GEMs GPUVA list in commit e7fa80e2932c ("drm_gem: add
mutex to drm_gem_object.gpuva").

This is series the second part of that work: Dropping a vm_bo object in
the fence signalling critical path is problematic for two reasons:

* When using DRM_GPUVM_RESV_PROTECTED, you cannot remove the vm_bo from
  the extobj/evicted lists during the fence signalling path.
* Dropping a vm_bo could lead to the GEM object getting destroyed.
  The requirement that GEM object cleanup is fence signalling safe is
  dubious and likely to be violated in practice.

Panthor already has its own custom implementation of postponing vm_bo
cleanup. Take inspiration from that by moving the logic into GPUVM, and
adjust Panthor to use the new GPUVM logic.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Changes in v3:
- Unpin in panthor on drm_gpuvm_bo_create() failure.
- Use llist for bo_defer list.
- Rename drm_gpuvm_bo_is_dead() to drm_gpuvm_bo_is_zombie().
- Rename drm_gpuvm_bo_defer() to drm_gpuvm_bo_defer_free().
- Link to v2: https://lore.kernel.org/r/20250909-vmbo-defer-v2-0-9835d7349089@google.com

Changes in v2:
- Fix missing kfree in Panthor.
- Rework mutex_lock() calls to be less confusing.
- Add note about resv lock in drm_gpuvm_bo_is_dead() docs.
- Link to v1: https://lore.kernel.org/r/20250905-vmbo-defer-v1-0-7ae1a382b674@google.com

---
Alice Ryhl (2):
      drm/gpuvm: add deferred vm_bo cleanup
      panthor: use drm_gpuva_unlink_defer()

 drivers/gpu/drm/drm_gpuvm.c           | 184 ++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/panthor/panthor_mmu.c | 110 ++++----------------
 include/drm/drm_gpuvm.h               |  16 +++
 3 files changed, 219 insertions(+), 91 deletions(-)
---
base-commit: b2ec5ca9d5c2c019e2316f7ba447596d1dcd8fde
change-id: 20250905-vmbo-defer-3faf90d821f5

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


