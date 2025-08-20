Return-Path: <linux-kernel+bounces-778388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC0CB2E4DB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 20:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C973BA26FFC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 18:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2763279334;
	Wed, 20 Aug 2025 18:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dg62XYw4"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8D13EA8D;
	Wed, 20 Aug 2025 18:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755714208; cv=none; b=qboMk40KhV09jb09X/5J5iezzXJRpI5QMrDpr+/GGLlKZcebW6fRz9A1nlt9aXFpbqftoR/YZj9SoL9XTqW0jdunthH+NKz6iTPb47zV5Rky1ToCpday0+HbB1agTUixS2m1xoUWh9UHlns52a779uon074VaWb+V0m1QSj04vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755714208; c=relaxed/simple;
	bh=smGnO2fyg7RPOwg+W0wmpugItFInhBMUzvPKGjXle+k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lNcfFnSBgHcQg4u7K2IojcwQrrNSqtBKNtF39XoH5vWt0z9ecje+ZZa/zv32D8USSuJ8Mk2R8bk6Xy84vnKmkDhECI0X0BB7gS2xXfbENa7hWkvvQvWhHAXCOnFvJ8SnjyN0Nj/ah9rlO/l1f4mSo8hSYKkGypYfieZEBVOYUWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dg62XYw4; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b477029ea5eso90518a12.3;
        Wed, 20 Aug 2025 11:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755714206; x=1756319006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qJD17dHXBpBddqd9ZQM59zYB7xSPsARGmN3EqdaDYYk=;
        b=dg62XYw4YeAx4PD+HK7152WqwwMhNN01Q75CibvWSvE+euMumm8FID1FyS868uZXxK
         OE7Rqqj6V/6b0veeXlUjZLniMwTD5spL5Y8Yi97uQCZ0MpAK6+ODfEb5vAGj9E+OAT8i
         Cf7Yy9k3Pxo3YTMEv98KXU6CZvn/LkqdK8wHRO6JI1q9TtzV9X9w9WxpjhqT6UE1x+co
         4MoEoOnR/soYjR5YIVIMFWGauo1Wg24U467TcTUKDqEm7mcEMmN9UNmOlD4ytxzYsP4O
         KJngxjrnFDPFKROChQCUJ1BLfD6CVt7bNcuJHuuD3YxQr9t9YRBtnRUSrZWVU8eqevBf
         xUUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755714206; x=1756319006;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qJD17dHXBpBddqd9ZQM59zYB7xSPsARGmN3EqdaDYYk=;
        b=b+uShqN8urcuBOqwiGnDamBoVbNyaFksecG4FXHiALHT4RH1yQDqvl7FXunkLpeJl6
         V8Vm+bpYGWr4dJ4dTKqOW2vwIsDbN2NA4ejy34y5EOzjED+ECke/LiwfGuKV4ZNKLjzQ
         gSPF9/dhDrWNTnlxnwhMcux6xp2IaueaKopSS8qnXNdB7JGkXYKPBu8a6tpRhFbJ/B5o
         9dMOd7mhMo0wQ0HIcwAd105ULVonpn3Rvg7kkObJzBhLs62Vb1EbdiJYvq+Jruj2Qupl
         iQbmy5a7g4ysrBdy42zQqZADOxagSsi4txbcWdqX4H9kUzdszOUtGIu2ZEsYCsx9lb+c
         nHvA==
X-Forwarded-Encrypted: i=1; AJvYcCXt8IUaiiB4vJuSjddoJNHsY4KdRZDGX+KaVTyOlHcV6jfp/F/u0gLdDvEjmKmFvA8S5UAS6yRQFHqsZDw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFEVlDAnkEnxbh+0MCuuVsku71UjQ4qG9Q2pln3DyQcBN/B953
	U42OTTolorB3FJ1TCsku116VAcaiAYZFX/M4UpVBsOXMzO6I57tiBDahNKWsMOYGgMg=
X-Gm-Gg: ASbGncuTkYFQV/5jdTbpPZgozmzDfADaFebjro7YnYwqW+Rl48obU3iuCmbiiORCZXu
	FW9LBO2VhRNyC4JLGzxPiYISGfb/ouyl44LasZbX02uDrBHDys8VymLQ8Zo/QA+Z88bOaxcDBE7
	ru8tG/C4YIayVkguijxLhaTo++jPlPvVIvHuy5k22JblFQjLO2TBzHTgH4+Tbk+Blp4ywL1sdJ5
	EAQvo9slRgPErRtWiiV8ISKYp5e3L43caQPQJe8r/6juuB0TJeV0xgeMdhHBDdQeeCpY3T2Xljz
	tNx5RxqyyfzGCrzQT0t3L7zFL/C1L6kHDnyRi6OlZ/z2lcDtQEKmDRrvA4CC2TbJ1V6p5lv6lq4
	lBs1Gyai9e5/8dw9onouKNj8MQUE=
X-Google-Smtp-Source: AGHT+IGxVHwxWzd0VLZskRkya2/ny1iDGS9Hg+m0NaghOzwqRevtboYxJh4mBs1hCDsOMv5cLgK6Fg==
X-Received: by 2002:a17:903:13cf:b0:240:150e:57ba with SMTP id d9443c01a7336-245ef0d5a4dmr50329185ad.3.1755714205396;
        Wed, 20 Aug 2025 11:23:25 -0700 (PDT)
Received: from lkmp.. ([49.37.163.128])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-324e2643bafsm2956636a91.23.2025.08.20.11.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 11:23:25 -0700 (PDT)
From: Rakuram Eswaran <rakuram.e96@gmail.com>
To: linux-doc@vger.kernel.org,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	corbet@lwn.net
Cc: tzimmermann@suse.de,
	mripard@kernel.org,
	maarten.lankhorst@linux.intel.com,
	simona@ffwll.ch,
	siqueira@igalia.com,
	harry.wentland@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	skhan@linuxfoundation.org,
	rakuram.e96@gmail.com
Subject: [PATCH] docs: gpu: Fix spelling mistakes
Date: Wed, 20 Aug 2025 23:52:58 +0530
Message-ID: <20250820182259.11227-1-rakuram.e96@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixed following typos reported by Codespell

1. filp ==> flip
In Documentation/gpu/drm-mm.rst

2. complection ==> completion
   implementions ==> implementations
In Documentation/gpu/todo.rst

3. unpriviledged ==> unprivileged
In Documentation/gpu/drm-uapi.rst

4. propogated ==> propagated
   aperatures ==> apertures
In Documentation/gpu/amdgpu/debugfs.rst

5. parition ==> partition
In Documentation/gpu/amdgpu/process-isolation.rst

6. conections ==> connections
In Documentation/gpu/amdgpu/display/programming-model-dcn.rst

Signed-off-by: Rakuram Eswaran <rakuram.e96@gmail.com>
---
 Documentation/gpu/amdgpu/debugfs.rst                       | 4 ++--
 Documentation/gpu/amdgpu/display/programming-model-dcn.rst | 2 +-
 Documentation/gpu/amdgpu/process-isolation.rst             | 2 +-
 Documentation/gpu/drm-mm.rst                               | 2 +-
 Documentation/gpu/drm-uapi.rst                             | 2 +-
 Documentation/gpu/todo.rst                                 | 4 ++--
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/gpu/amdgpu/debugfs.rst b/Documentation/gpu/amdgpu/debugfs.rst
index 5150d0a95658..151d8bfc79e2 100644
--- a/Documentation/gpu/amdgpu/debugfs.rst
+++ b/Documentation/gpu/amdgpu/debugfs.rst
@@ -94,7 +94,7 @@ amdgpu_error_<name>
 -------------------
 
 Provides an interface to set an error code on the dma fences associated with
-ring <name>.  The error code specified is propogated to all fences associated
+ring <name>.  The error code specified is propagated to all fences associated
 with the ring.  Use this to inject a fence error into a ring.
 
 amdgpu_pm_info
@@ -165,7 +165,7 @@ GTT memory.
 amdgpu_regs_*
 -------------
 
-Provides direct access to various register aperatures on the GPU.  Used
+Provides direct access to various register apertures on the GPU.  Used
 by tools like UMR to access GPU registers.
 
 amdgpu_regs2
diff --git a/Documentation/gpu/amdgpu/display/programming-model-dcn.rst b/Documentation/gpu/amdgpu/display/programming-model-dcn.rst
index c1b48d49fb0b..bc7de97a746f 100644
--- a/Documentation/gpu/amdgpu/display/programming-model-dcn.rst
+++ b/Documentation/gpu/amdgpu/display/programming-model-dcn.rst
@@ -100,7 +100,7 @@ represents the connected display.
    For historical reasons, we used the name `dc_link`, which gives the
    wrong impression that this abstraction only deals with physical connections
    that the developer can easily manipulate. However, this also covers
-   conections like eDP or cases where the output is connected to other devices.
+   connections like eDP or cases where the output is connected to other devices.
 
 There are two structs that are not represented in the diagram since they were
 elaborated in the DCN overview page  (check the DCN block diagram :ref:`Display
diff --git a/Documentation/gpu/amdgpu/process-isolation.rst b/Documentation/gpu/amdgpu/process-isolation.rst
index 6b6d70e357a7..c1297a9e4d09 100644
--- a/Documentation/gpu/amdgpu/process-isolation.rst
+++ b/Documentation/gpu/amdgpu/process-isolation.rst
@@ -26,7 +26,7 @@ Example of enabling enforce isolation on a GPU with multiple partitions:
     $ cat /sys/class/drm/card0/device/enforce_isolation
     1 0 1 0
 
-The output indicates that enforce isolation is enabled on zeroth and second parition and disabled on first and fourth parition.
+The output indicates that enforce isolation is enabled on zeroth and second partition and disabled on first and fourth partition.
 
 For devices with a single partition or those that do not support partitions, there will be only one element:
 
diff --git a/Documentation/gpu/drm-mm.rst b/Documentation/gpu/drm-mm.rst
index d55751cad67c..3496ef28b15c 100644
--- a/Documentation/gpu/drm-mm.rst
+++ b/Documentation/gpu/drm-mm.rst
@@ -153,7 +153,7 @@ size in bytes.
 GEM uses shmem to allocate anonymous pageable memory.
 drm_gem_object_init() will create an shmfs file of the
 requested size and store it into the struct :c:type:`struct
-drm_gem_object <drm_gem_object>` filp field. The memory is
+drm_gem_object <drm_gem_object>` flip field. The memory is
 used as either main storage for the object when the graphics hardware
 uses system memory directly or as a backing store otherwise.
 
diff --git a/Documentation/gpu/drm-uapi.rst b/Documentation/gpu/drm-uapi.rst
index 843facf01b2d..7435664a1ffe 100644
--- a/Documentation/gpu/drm-uapi.rst
+++ b/Documentation/gpu/drm-uapi.rst
@@ -535,7 +535,7 @@ ENOSPC:
 EPERM/EACCES:
         Returned for an operation that is valid, but needs more privileges.
         E.g. root-only or much more common, DRM master-only operations return
-        this when called by unpriviledged clients. There's no clear
+        this when called by unprivileged clients. There's no clear
         difference between EACCES and EPERM.
 
 ENODEV:
diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
index be8637da3fe9..1d064e617699 100644
--- a/Documentation/gpu/todo.rst
+++ b/Documentation/gpu/todo.rst
@@ -319,7 +319,7 @@ everything after it has done the write-protect/mkwrite trickery:
 
       vma->vm_page_prot = pgprot_wrprotect(vma->vm_page_prot);
 
-- Set the mkwrite and fsync callbacks with similar implementions to the core
+- Set the mkwrite and fsync callbacks with similar implementations to the core
   fbdev defio stuff. These should all work on plain ptes, they don't actually
   require a struct page.  uff. These should all work on plain ptes, they don't
   actually require a struct page.
@@ -854,7 +854,7 @@ Querying errors from drm_syncobj
 ================================
 
 The drm_syncobj container can be used by driver independent code to signal
-complection of submission.
+completion of submission.
 
 One minor feature still missing is a generic DRM IOCTL to query the error
 status of binary and timeline drm_syncobj.
-- 
2.43.0


