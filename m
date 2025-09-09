Return-Path: <linux-kernel+bounces-808283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6951DB4FD88
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 15:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8366C167333
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 13:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05965342C98;
	Tue,  9 Sep 2025 13:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bpV1lJvt"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EB4215198
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 13:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757424999; cv=none; b=aL4gwR7lc4H+SYa9nNBB0hVxKcXBClDu90KxfDuqBs7el21cS9PsarSJ1rWLvhaS6FWvX7/T7vEDg/YtocqGTdMV3fvQTb4CgDfnT4IYJMY2CzXOXmOL1W/LkL25n6rFr1dT7QtRpl+ZAiX80ZcgoYJNBCxzMaT+uyip9ieEfdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757424999; c=relaxed/simple;
	bh=GeUdJBt+v1KLgbpRUvyZgBAL3FGBKi3BqI0ivCr3XSw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=iBh7JfW26uWANzQUHu5bIm+m7hM6d71vc+qWR7sNhZWk855ZX+1DUTQmBoTuASbb2BFHwgcP473I9CRDdE/BFM1aR9VojRetRQ0X4w6/KwprQqPsAbqoOjUQ1sc2HALq8feDmSRgZ3PJMTi5CZQ9urfbLjAiNP9c7c3TDpOQkjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bpV1lJvt; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3e26b5e3f41so2380773f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 06:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757424995; x=1758029795; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kXmltCaa+AaoNYSNTm6MtPTiMQ0YZbzrD/4xtNxBMMM=;
        b=bpV1lJvta3dfswwRvwsoePBn68HkR/UorsZUHHbGQBD51gGfCCABPexhuKNzxcvv3j
         9RNdd/LMC0rWtLZ4JfFkphOYCpqTFRm13Mg9Lgxwy+CRlbR26vTTmm1xHI56YqgfxbWC
         JwrK1k/lGSBq5zKSFcaicVQOgbw+EASgtdSEdG6rnQaWVqHfM7nwGTKjiMvQVMJ5c5Mp
         aMhR62eLtOUCYryF4b/taF01Uw2skUOPQJykXgVakLd3X05DfEz+GI2wE5V+SocjPIDM
         bD5lL4V7V5tDFnF1IEkB4mq7g4tvBPTST9ONm6o4Qjo7tJI3uDRcJ1XlDQWIrjEZmkom
         lIZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757424995; x=1758029795;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kXmltCaa+AaoNYSNTm6MtPTiMQ0YZbzrD/4xtNxBMMM=;
        b=LRJ9ClNcxznZFul+PjDxVeDObDrjclGPykSXOa3SJOvaINB2htjtdab2TDtbJG7ccg
         4SEW5OjIjci3Mt7ZYYcj8LNguthG1H3qa0T/J7X/SVmpPdqHqB1lWzp/iDuqHAddvb8a
         5UvX8W/+PaTwvaZdWg/ik4eopRJObswQyJBr9fXKn9/2pPpyb0jef/eVaDhwO/ZFI2Kk
         YVLNIbaWDhRAkR+bdQPnA2P29y6RYvWX7dsz4XX6SapzVY8hcXbnS0fcAJiHCT8rD6Ta
         0CyEDDXVRScvylKlv8sSThzmm+tCD8lfMglDrzXZ888cblOt8D6jrCTsl6GujGJA7ENw
         eqEQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9CdeqREyguiMxeUH7aCCEotFCqqwFrLSycUx9oG+90qtcaMsVGv6H5fxCDAQXyPYN0bmMpM7F3ZDvfng=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMb/oSS9nyx776LL6ZsyBhDE1WbQdSdYj4EferXvn9tsoHjwKz
	Ab5C5fNe7u/PE5oO8g33N7lE+HSFwR4HSq43D1bMPvJL4+0gxJI3rYhtD6iSzNo/D0yADc0AnO7
	+VK8fXUpTD/EJbNsTQg==
X-Google-Smtp-Source: AGHT+IGpd7wVDU7QaP3WDSMkWRZay0a703HdaORpePC2ExBYXtfISIk0y/IycXtdZ8Fxh2p+uKHUoHh4HXK5Hec=
X-Received: from wrp30.prod.google.com ([2002:a05:6000:41fe:b0:3e7:5322:fa12])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:adf:a2de:0:b0:3e6:e931:b3e7 with SMTP id ffacd0b85a97d-3e6e931f910mr6330514f8f.61.1757424995549;
 Tue, 09 Sep 2025 06:36:35 -0700 (PDT)
Date: Tue, 09 Sep 2025 13:36:21 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAFUtwGgC/23MQQ6CMBCF4auQWTumLVbAlfcwLApMyyRCSWsaD
 endraxd/i953w6RAlOEW7VDoMSR/VpCnSoYZ7M6Qp5KgxJKi05oTMvgcSJLAWtrbCemVkmroRy 2QJbfB/boS88cXz58DjvJ3/qXSRIFNoakqVs1XJvL3XnvnnQe/QJ9zvkLO1FwoaUAAAA=
X-Change-Id: 20250905-vmbo-defer-3faf90d821f5
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=2470; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=GeUdJBt+v1KLgbpRUvyZgBAL3FGBKi3BqI0ivCr3XSw=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBowC1dGqdohxONBkmeGDCsxY+w9d40QZKFJNsMn
 blUuB2WgMKJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaMAtXQAKCRAEWL7uWMY5
 Rjl0D/9V49VT0Tbg6rT/l8FP+PvPvgDkL+20mqG6MQUaTYe15pW4fvIT38lA36TeEmLzYOOblJ/
 iNZu+LQs1SUSMY0XT3Lpd47Gd6suiwvO8aCo2+xsyMBmiA22jM4Wl7Ug+o/pWTMgOTv7kPqWsYI
 9x4izNqiAEeQW15SlpoGt2eVDbkqvz/JyZ3v9Y9Rmcv0TGs74YALbMW1Sozp/0EOgR2lAgklLyj
 uND73E1B+Kw+ObTcou+8WkikX7Kbg513yQdvJaAxWADEV8E2hALAYpGItOduFdNaM/HFtjvfLjE
 AGKeTZH0ZXRvlWPqCisAwJDw+gxUJvjvTkvuM79FioAaULVwmuPgjg65Xb8gMDT+UbyNexjQx5L
 QixxOGM6gEm/QVF4zWdmTfRnLpvuEn9G4VNNP5hALbxXKcN5iRBUCHbvCsmKntReOi4opHZmgDv
 71XTIAdFgQAHThObOuzMfbtU+V8qpbn9pVPxCkA+lbphh/HowtYrMVhR7v7DzJoQfvGIPQAqjkv
 nURbgyocHZ0MTNQeBhzmPrSoBCM6ZkXE6V7gvNnLPzmhZAhXY2HwB2UfwDl1BerLCFZ4mYlTSa4
 jnOsP21rmP/tkucFd1XQgh72IZGyLGk2zz8jvTFEOfJqz6tf/UgnPqEEtxTN69KhW7y/rw7vAGw D8A+EpkPjoC26qw==
X-Mailer: b4 0.14.2
Message-ID: <20250909-vmbo-defer-v2-0-9835d7349089@google.com>
Subject: [PATCH v2 0/2] Defer vm_bo cleanup in GPUVM with DRM_GPUVM_IMMEDIATE_MODE
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
Changes in v2:
- Fix missing kfree in Panthor.
- Rework mutex_lock() calls to be less confusing.
- Add note about resv lock in drm_gpuvm_bo_is_dead() docs.
- Link to v1: https://lore.kernel.org/r/20250905-vmbo-defer-v1-0-7ae1a382b674@google.com

---
Alice Ryhl (2):
      drm/gpuvm: add deferred vm_bo cleanup
      panthor: use drm_gpuva_unlink_defer()

 drivers/gpu/drm/drm_gpuvm.c           | 174 ++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/panthor/panthor_mmu.c | 113 ++++------------------
 include/drm/drm_gpuvm.h               |  26 +++++
 3 files changed, 219 insertions(+), 94 deletions(-)
---
base-commit: 7156602d56e5ad689ae11e03680ab6326238b5e3
change-id: 20250905-vmbo-defer-3faf90d821f5

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


