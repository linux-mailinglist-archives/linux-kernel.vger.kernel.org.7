Return-Path: <linux-kernel+bounces-802815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E7A8B4575D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCEA93A68FF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 12:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9C934AB07;
	Fri,  5 Sep 2025 12:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TazNyOEp"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899C072615
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 12:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757074299; cv=none; b=mKXnr2dj1713rlQcjiGBccF7MQJzdUiEO9XuRbP6c9xp1J1TyaVmOrkjDpk+cAwJ6LlLhGJIJ1PKI1xoWclee2DbDP3uPZ6lPiGWX7YICFW1dv2NBv+Ks05Zrw76Z/zIrFgIrFj79110excXrLDlTgYJYa6j1SCGI0UTdWB15gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757074299; c=relaxed/simple;
	bh=av2PCZN3iHw31m2KXa/hGZSNvzXXs4uH3KJeadBo61w=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=CkmLCQbjoYrEMpbByrXLAtSiJRD2JsFkMR2JeDzPXY9X/pGgntbtfnLPlMnaYNeQ0vwKo+4L5aB9O3v1MnCCqZ34q3EOO9c/QYhuaSSIGtjWwGmnPOd8ZdyLOyXc0qNFERd1ODL8c92PkJKwISHaqaHDv2vjrxCywcQ9RM1MpNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TazNyOEp; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-45dd9a66cfbso4389415e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 05:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757074296; x=1757679096; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZOPSONkb/oHrdvEnVNIWH6qwbQDR8wyTn/LimFEqbTE=;
        b=TazNyOEp+4Quk6P3MHvTTJvhA5eaEd1F3kcyE/i5djzReyEOGCpywgvxVV+der/+5c
         XgXT9+O7J8fl2naSM4CAA6qiOGnXKyIvMOSQ/ueEAh73yoFDFASTmsOnMPUzjrhMaV48
         NOF/gPCn606tbDcxtN8pf2qjxDTxHdNfxQOi09D5X8I2k/0wG7IfgDF0L8wLR+tUhgfC
         ZSFeDXvuAjNKsB4J76dPItkKHlLzgSusDGRWf6Wv97WAbCBCxV6MtaoBBb1nZsUrShzd
         OyL1snaWUcoYfz+DGkdCmP1kEadB2EPFWMS22z9hCymNkAWoYsvZUb8lAeJPk9NDpWQH
         YOOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757074296; x=1757679096;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZOPSONkb/oHrdvEnVNIWH6qwbQDR8wyTn/LimFEqbTE=;
        b=jZIIw7u59IC5Jt/aMGO0nSeKzDOMF3KshOKJdySJdF1ChP/0Tay8BnO/z8kT7MsCD7
         Dcsm4hWAvBcxb8d3m3XHYyx6RXOa5JPkq8hdafm0wlXORrIj/OUNmEcH0aztoTBHMGwg
         iBXtfkIAI58wZJY3Iw6axYEsDmeneNfHge4Wid4VivREiKoCXCWfiPhMxHhFUsKCceq7
         AFh9N4AidEh1H61KEfnVOQIgsCvTLgP1KqGaMGKHcEb++XvSJe18PfgD++3PR7WxuFTV
         SHA86Pc+qKlj1ynA3VYTMjt8/aLWpMceIPqb3w/yRdVfRN+vTEk+sC4n2YNHMJPngOuy
         64RQ==
X-Forwarded-Encrypted: i=1; AJvYcCWB+PwFSvWK7mAE+qIUhvIiTcYsZ36jxR7CY1f0+HOiD/1NMowbfl0yFRuZO+zV80muJGjUPsLzSkwc4Jo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKDETmoMrY32+eSRTy2/A43MaIgMeOADH0DA8DkFso/ed8wx4i
	umLv9iyWrMIIcfx/xAza+4+XScgixeHeCqwx7O3jGk/QPvGUh9tffXAET7rK/a+mRaxrOfzh6lT
	oRYxsR5xIpt1/EkN3Hg==
X-Google-Smtp-Source: AGHT+IHsrGQX8qcCZ9HxIK99VE+RHo02K97912TeGraChWZB2JeehQ4Mi9OmJ8LtBxrYUIHXz75LaPtSikynI1Q=
X-Received: from wmbds21.prod.google.com ([2002:a05:600c:6295:b0:45b:88d8:5042])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:470b:b0:45b:90fc:1ede with SMTP id 5b1f17b1804b1-45c8e725fbdmr99877055e9.6.1757074295980;
 Fri, 05 Sep 2025 05:11:35 -0700 (PDT)
Date: Fri, 05 Sep 2025 12:11:27 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAG/TumgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDSwNT3bLcpHzdlNS01CJd47TENEuDFAsjwzRTJaCGgqLUtMwKsGHRsbW 1AJu26iRcAAAA
X-Change-Id: 20250905-vmbo-defer-3faf90d821f5
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=2215; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=av2PCZN3iHw31m2KXa/hGZSNvzXXs4uH3KJeadBo61w=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBoutNyxOpFZ42DS+TtcDs65lWJgcI/hgupquxoE
 NNEcJ4qa8SJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaLrTcgAKCRAEWL7uWMY5
 RpvTD/48s9S0nMHsl6JehxEXr8PtHD7thHl/lFxQWMfgSrMadcAmIJHO+zwYADWnzmomYuJky2n
 gNQvGc++T3PO/n2sAU9PhqruPaukq5/lCRv/maHDgqhIE3xfN9OYftlTwVAdPf4yN9uGrKPSxkJ
 bAeP+WcoY3QwXAV7805QTP+9gv5hK2sc4AymngGBMfiuwVQqsn35huTRpv8lhD/qRlx5SnVH2G2
 yzO4mFdQVlBRfqIz9dSM0R2EoPpt8fRCLQ3RoRRYs2af6pGpL5+JKAu+GwSHUQXkQcNop+wdycF
 7gLhpE6RVpXEWumcinMC0UVYea+0CVXIYk4kuYPou8wEYDuWlas+PV1aEpkdYnAiBQoIHBoMFm+
 pwmLLHTVHFXsjjCise4kQ2UyRNpZoctvkgGskOfWpgvgcVNt+IH7l3Ukimv+0Rf7LupUrdZ3kOq
 fDjDWwXfu9BCSgCH8zvwZCuTHqdLRqdwFXCIB+Zjqd8L8eDdsUkwoehj/xQfZ2s9Ro35RjDGw64
 kfw3LMXZRXlOLuFOVUbZWLECPYklrRcHXkeA8XTOPdVl3GAfJd7G+xcomZ05f/z+2HAoEwX53Xg
 hu576GcCaXnIrA3e9tiGLrSSOFJkOShBBfziv4M3rt5d5zAinz9AtybVyuloRybGPJFp1GepKRz ECEpmW5DmEnP3/A==
X-Mailer: b4 0.14.2
Message-ID: <20250905-vmbo-defer-v1-0-7ae1a382b674@google.com>
Subject: [PATCH 0/2] Defer vm_bo cleanup in GPUVM with DRM_GPUVM_IMMEDIATE_MODE
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
Alice Ryhl (2):
      drm/gpuvm: add deferred vm_bo cleanup
      panthor: use drm_gpuva_unlink_defer()

 drivers/gpu/drm/drm_gpuvm.c           | 167 ++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/panthor/panthor_mmu.c | 112 ++++-------------------
 include/drm/drm_gpuvm.h               |  26 ++++++
 3 files changed, 211 insertions(+), 94 deletions(-)
---
base-commit: 4c67b73907214994f87cad795195c46fe63c1e1c
change-id: 20250905-vmbo-defer-3faf90d821f5

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


