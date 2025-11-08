Return-Path: <linux-kernel+bounces-891690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B47C43422
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 20:50:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D84D188D3D8
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 19:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378BD26C3A2;
	Sat,  8 Nov 2025 19:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CWnZmW9z"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7843A1BFE00
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 19:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762631395; cv=none; b=pBUa47/mj4WdRsKKvUhp3akrqqszIyEa79fAqn4nql4Qtv0uNx+cybhMS38CPi4yMP4y9kb7Kie7lxzjrr6JT84EBJHa27uudeDJKVBODonvPUhpXUKrUO3f723TEN9Y2j7dxux8DaMwDcudIWSB7Yniq+HFuOiQEktnN+oETts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762631395; c=relaxed/simple;
	bh=xfKI7A/m+gQr8SiYeanW3SLgqgQt8ElCuNUJPLjrJnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U3VZPfLrPBD4wbTT5sqLeEK+7okOC60RKARlJmTqyycUES27QFQMrRFv29Bs8CZKUG5rCWFd6xRXCp3tWg9drG/Zt2GE2R6htSOQThVcc+mEJrGrSzSWe4wdB5/HsvMINNef+QNj8wm5FCw6ORhKJHo6KQL5iFZnsXQ30EMayr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CWnZmW9z; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4710022571cso18087415e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 11:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762631390; x=1763236190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b0uy50dOrdzc9k+anVLIDVkwfvmPwxiEPkSelHBhPk8=;
        b=CWnZmW9zxXahZSRLu44/dCI+kTtZLy8vt5VrfIEj4DWKk5c7upUaG8nI//0jaMQzFt
         JMs58r+G1qsjbZibdjI6AKwtr5W+INRdEK+Yd/Icsx0etCYrHMiaYECe6b3hYiUp82LB
         qONj1IJaSfqRmqq3HUJ0+JFLQZ4HREkLP6LG1l53rCDJrY+5lwtlR+WWo2URyp5mEKr2
         G73TaEg8hLM266lGFrZ/8ZzTpJwXbyYCGiS7b9PvfZEUNvEhx97VWwjOvwFmPnld3Qkc
         4UyqZk+xnUI/lx3Odn2BnRZApyK613pV9/uzPaDXwm29pvfpoJraPzSWAQzI3+b5MGy9
         eTgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762631390; x=1763236190;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b0uy50dOrdzc9k+anVLIDVkwfvmPwxiEPkSelHBhPk8=;
        b=iw23oqAwlU+9s/MAIanUj29Erg4kibFSc1hfDkeGru+zyPspaXqQCgb7r2H88xnxPC
         rW4V3loZOMAiwPICKD96tzgyGsX2F0N7/72/KSWsU41KH3z4QDkDQ+8NNBWVB84++rV4
         CzJrrVyV44OzP5ePcf8gB87UF44AAEMdnUx+Lp660x2SQ7j03iPxqcko+U7ONXK/kCSq
         JvII9e/xtxET1bF4Xm5FbkjZFi2wxZv30u3/T/Qhk18tjJb9yK7Ys72eyE/RoHgfRYoI
         VWkCn/fFVM/HJLJAb/fsZtu7f6aZbuAofm/GcgOo9D5usAtTk/i09lCm46269oHAcvYI
         Me1g==
X-Gm-Message-State: AOJu0YxXLyDi1E3978ehkBwlPXKFvgm7GHhHZG/yEDo0DQwIgo0bGHX2
	YzQEkDGpeAEnBppM5Nb2vGX+Ov/gx+Q+MRB7BNbgM8xLVJvLkLpHUdqhrRXPUQ==
X-Gm-Gg: ASbGncuA6Dy2sP4cCXzEXkhBYfhek4ybHy/2Xclxf/tW5lQt7+aSfPEolp2xxb6y3DX
	9Zt6c9FtCP5e7KInnpQ836sfX3VFmoPtLunymgR+ZPsFM6+zRg7Sk/0ceb9eoYGmqKi2vj2Xgk7
	+2CLligO1pCm9G1e5WvvQiHBvrPaUPyUufoTdUMcdiQG+/g9kPSPNkBEiDUcDOyYUKhcUh245TK
	2SkT68IDZrZkvdwulUBHcWjUlA3TFm1sGCdapXwGDtgDxfkbzjq41cDeZNnbcQubHQkYtyqjiNn
	scrHimBiamVcXpC3EVW/wa4fmtUlkqgFI4ZJWcrlJmRK6lp4BN5p6xWdel5R1DQUFYbfKkfUIl2
	Z4AHrgVAqWdQeZqmw02jrd/dCaDcEnJPQoTbObCj+I8M10LT0eLt+mMViUmVlXpvR8IDgAXy+eR
	n6mGghxWiD8IK3HtrS1TvP
X-Google-Smtp-Source: AGHT+IEI7PfgcH4CwLjfZxsDK95X3Phk9kmaJW2SV5zjU3Vr74pa1DgjlYR9lHlBmHuBOuZhK0oYOQ==
X-Received: by 2002:a05:600c:45d3:b0:46e:4783:1a7a with SMTP id 5b1f17b1804b1-47773228b39mr24583095e9.3.1762631390046;
        Sat, 08 Nov 2025 11:49:50 -0800 (PST)
Received: from fedora ([156.208.73.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775cdc33bdsm233461435e9.1.2025.11.08.11.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 11:49:49 -0800 (PST)
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
Subject: [PATCH v5 0/5] drm/nouveau: Enable variable page sizes and compression
Date: Sat,  8 Nov 2025 21:49:14 +0200
Message-ID: <20251108194919.68754-1-mohamedahmedegypt2001@gmail.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The new VM_BIND interface only supported 4K pages. This was problematic as
it left performance on the table because GPUs don't have sophisticated TLB
and page walker hardware. 

Additionally, the HW can only do compression on large (64K) and huge (2M)
pages, which is a major performance booster (>50% in some cases).

This patchset sets out to add support for larger page sizes and also
enable compression and set the compression tags when userspace binds with
the corresponding PTE kinds and alignment. It also increments the nouveau
version number which allows userspace to use compression only when the
kernel actually supports both features and avoid breaking the system if a
newer mesa version is paired with an older kernel version.

For the associated userspace MR, please see !36450:
https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/36450

- v5: Add reviewed-by tags, use dev_warn_once() instead of WARN_ON().
- v4: Fix missing parenthesis in second patch in the series.
- v3: Add reviewed-by tags, revert page selection logic to v1 behavior.
- v2: Implement review comments, change page selection logic.
- v1: Initial implementation.

Ben Skeggs (2):
  drm/nouveau/mmu/gp100: Remove unused/broken support for compression
  drm/nouveau/mmu/tu102: Add support for compressed kinds

Mary Guillemard (2):
  drm/nouveau/uvmm: Prepare for larger pages
  drm/nouveau/uvmm: Allow larger pages

Mohamed Ahmed (1):
  drm/nouveau/drm: Bump the driver version to 1.4.1 to report new
    features

 drivers/gpu/drm/nouveau/nouveau_drv.h         |   4 +-
 drivers/gpu/drm/nouveau/nouveau_uvmm.c        | 102 +++++++++++++++---
 drivers/gpu/drm/nouveau/nouveau_uvmm.h        |   1 +
 .../drm/nouveau/nvkm/subdev/mmu/vmmgp100.c    |  69 +++++++-----
 .../drm/nouveau/nvkm/subdev/mmu/vmmgp10b.c    |   4 +-
 5 files changed, 131 insertions(+), 49 deletions(-)

-- 
2.51.1


