Return-Path: <linux-kernel+bounces-842910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E27BBDF55
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 14:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADE783B29AD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 12:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C67279DDD;
	Mon,  6 Oct 2025 12:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ml/ryJrk"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F7423B63C
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 12:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759752367; cv=none; b=sM7xWU6jEtiFlKVRgHznw/v4X2au0rGN+MbhgeXyP5hjbhHNtm6vp3XhXHsjfJf0gDEg5m7j4GTOp+xa1iEzwoeX5wTiAi8uCgV+bhgYLubhLFMyCWgkAFKFCikfyrGdzocN6/JzM9OdEH5ONJuYt77Eaa/rAOIRpZgyJ9UpQQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759752367; c=relaxed/simple;
	bh=0nkElAd5E12QHlg7Kb8WPr3y/YHY+cnYvzDlo0JgOKs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Q/IzViqTTS6b119sjhqTKnOnK/SkIJ3K8yNwPZ0+OQXNs7n1h5xabpCkVQj8AB85dJHMVEhKRiX/UZe+SnczTtMfXTcG5hIfe0n7dHtjdbxIE0py8PMxMSsSLlkJLAV4cQUUEmX/d055qS8TG7o5x1DULffN/EKzSSVUVO6lVt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ml/ryJrk; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3ecdc9dbc5fso2638798f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 05:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759752364; x=1760357164; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/OB7xMh5+T9ypw6dAsTTgtORxWZ55dw+sNCcskl6+uI=;
        b=ml/ryJrkwzkOuLDMYLSRLqXAHevA/wQQPaw7cI9W1pKriV94KDGrYwOj9zBa5W05FH
         GmxU6M65PaBBL8SsJkA2llQZn52RnydOkzKeGgySkJQrVqWKec6nVCskhshbrsu3ay8w
         nQ/Cs8ilHbX8fsyHYgxl2rFvpQYAd03N5KDvvyyaE5VLPsh9Q78I7LZOOJqJ8oGY49YC
         u/94KqwP9Atg7KWHmbxooEGlhFOcziNTMZMfAeY+aj3sKqV+ojr1e5TuXOmorEUjZMy2
         Tyc4+SsvwyLP8Oj59hxMPqXO96Xd71koQsUg0YRSzV3PnnHvB3oi4lwz9/N+OrFyFFed
         Gp8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759752364; x=1760357164;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/OB7xMh5+T9ypw6dAsTTgtORxWZ55dw+sNCcskl6+uI=;
        b=jRdJT3/muVdWpKwSlUFP3OYt0HAIR0jb1ZchcGUe1eqCQwfsNOEwuBGhIDyUaf49l3
         SUNrtNJDIOHAxbafBgXoDJ9gJbJmkJ1FBjmVfOsbm97DS8EjMpnqjDxYn5QfZ2nNhw61
         bcEYE4cgEh05U3/91OnIfXmmlvSUhJgGN7aDuYXBoxPco3G5ogt7a7J28DKaVUXiNhjL
         SCjZ9SWkno/qEjUXnO3eZWqbKdDi0PaROlSWCf3UG8JR1tAF5wjOYfwDvciZ+Csh+whI
         eomG/+Bdz+lL9SiQp84ZZSpY4wONEotXaKOQ63pZy4U9pMovJO1BtRlLyuYBrGEVK1jF
         HT8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUNBDpskg+peW+rzd3WEVrXMwoPYOo/7OSpLwiFtwrJs6Zx8qhlIphJY7VtSQLE563DZEExir/9O9J+dFY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3v9GYZd8nyBnYgAajRQRJu208zx16TJZbDQNky9Yh9Amig3Jx
	LULuX0b8YInXUbGWVzs+3S3uqiZcB/hZJtPQBmlrEwwhizm5016zmj37veY8F7BdQyrhU63O0U0
	peZpAUkajD/vkYIPxAw==
X-Google-Smtp-Source: AGHT+IGZiwn/2wr4en+CfzEIAktdUh7Xr9CEeu2eqUOcO9id7QGmI8fMYngV1eXRgRmIk6O9kosqt6M4YuIVHFI=
X-Received: from wrrd12.prod.google.com ([2002:adf:fd8c:0:b0:3ec:df8a:fad0])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:400f:b0:414:a552:86b1 with SMTP id ffacd0b85a97d-425671c2cd5mr8127141f8f.63.1759752363933;
 Mon, 06 Oct 2025 05:06:03 -0700 (PDT)
Date: Mon, 06 Oct 2025 12:05:54 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAKKw42gC/23N0Q6CIBTG8VdxXEc7gCh01Xu0LlAPypbSoLGa8
 91DL1quLr+z/f5nJhGDw0hOxUwCJhedn/IoDwVpBzP1SF2XN+HAJWiQNI2Npx1aDFRYYzV0ijM
 rSQb3gNY9t9jlmvfg4sOH19ZObL3+zSRGgdYGmRGKN1Vdnnvv+xseWz+StZP4t9U7y7PVSsiuF qUGpX+s+FgGwHZWZGuExaqp8ncld3ZZljey9oPqHQEAAA==
X-Change-Id: 20250905-vmbo-defer-3faf90d821f5
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=3010; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=0nkElAd5E12QHlg7Kb8WPr3y/YHY+cnYvzDlo0JgOKs=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBo47ClY4kic2ueCmjFDZtvoHdJ9lRrq9D/h2+aK
 c5IeVhtg/WJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaOOwpQAKCRAEWL7uWMY5
 RrT9EAC0eBYJqZ0YqLg7uTb+b64n+6kwas/1IE95oVSribxOWjqYBvkfZJcY58pw0jTPloLNvMi
 QisNu+vuY96By4D7jTRyd5V46+5jSM30A/Ll0iwefwlZd+Qdl977XgdsgydphsFZlCrcOEb8z6l
 CA7mDys9ZOxDeVxML2FT//LX/Henv3DFOcA/yiqiXn+L5oMQSskfYpltLBsXFlsqYnXi641s8xF
 uwvAbiGKXosPdqqpVHRN2y8CIWgnVsYO8a7ojpaotas3tQyHS6UVA4xAnhZFbaB2sUolAxuKi/d
 JvRb1ZZ0cr/xpkHY4CixAFRimX1R4YNE8D2KJxMFmXZJZievFlPbmgMRYO8hMs6RO4gdnJIHIUv
 s+JM0Al2XuB53wsPU0n323zrzEjnl1Eg1MrewjbygLK2nEW0waSPHcw/9LH5EwHbV44uieQf5Yn
 cnkb2jgAZUj6XYEaeK+tpSa6251n1RUkhaxoO7I+QLmbaBwejm5RGGJsS6RFr/ABC4QsWZaRwiw
 MNVWX5ai9ew9QMZy/c8xIMoLJTqq1COhGMWuUox+je59lZBfr6gfduUsUTmZd9uwkeB9cPxJEqu
 7GqRpp9BGq38ODG9DR1WI8KEDWaw/Gew3f567FubQ2DomJEVWb762jPeSyffVpvEaipypC3PA7m URQQFoOae7CXIlw==
X-Mailer: b4 0.14.2
Message-ID: <20251006-vmbo-defer-v4-0-30cbd2c05adb@google.com>
Subject: [PATCH v4 0/2] Defer vm_bo cleanup in GPUVM with DRM_GPUVM_IMMEDIATE_MODE
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
Changes in v4:
- Go back to using kref_put_mutex().
- Change terminology of deferral methods to 'zombie' and improve their
  docs.
- Link to v3: https://lore.kernel.org/r/20251001-vmbo-defer-v3-0-a3fe6b6ae185@google.com

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

 drivers/gpu/drm/drm_gpuvm.c           | 191 ++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/panthor/panthor_mmu.c | 110 ++++----------------
 include/drm/drm_gpuvm.h               |  16 +++
 3 files changed, 226 insertions(+), 91 deletions(-)
---
base-commit: b2ec5ca9d5c2c019e2316f7ba447596d1dcd8fde
change-id: 20250905-vmbo-defer-3faf90d821f5

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


