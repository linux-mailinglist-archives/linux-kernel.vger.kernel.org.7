Return-Path: <linux-kernel+bounces-893501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8855DC47986
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 16:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E000B3A42F6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468A9258EE1;
	Mon, 10 Nov 2025 15:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mary.zone header.i=@mary.zone header.b="eFEvk5Q5"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AA61DDC37
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 15:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762788786; cv=none; b=D9aa2Djk60SlWPPpbVvr7DwUuAwaTSBZOHPChgAHV325jZzBbuAVbNGU9Dje3Hqn5OqnpXxzyjUA1UnaeO5+ngJZ1oQWXOap/h12NEV/+o3Bb6Jtew1IKR5hA0tWfyd4DlvzzhDIqMnZWXSIMVSaJzFA6R3cDufYhG5nrNnRGdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762788786; c=relaxed/simple;
	bh=x7A3QBs1NXnlL087SlrPT4pGThphOzTOBIfIymk33fo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gjU0tleygV9FPl6IRjKAaw/FFNeaSwgpebdYobyIzbieKu83GelqsYo8GQw0mXsV5xR96J2BDI6szml+Nxsw1GFLw2nZPQltEadEN0/kSdBB/h9IfVO5RaC6Mfe9ZmAP1rby7sruhxaNcXY6KnqeXoXuzGqrIhkZHZ05fQ8Qgts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mary.zone; spf=none smtp.mailfrom=mary.zone; dkim=pass (2048-bit key) header.d=mary.zone header.i=@mary.zone header.b=eFEvk5Q5; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mary.zone
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mary.zone
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b7260435287so470117266b.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 07:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mary.zone; s=google; t=1762788782; x=1763393582; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QZt1eoNmJghXxK3OzFUBWP+UZk12kwPAzm9DvMX3M0s=;
        b=eFEvk5Q5flyTAMg6Hr6tFYa19nj/rxvxcGMOIZDyluIHRySNjPD+s48JLmSs9EbQXt
         m+gCXZ/CRoabPxzJv4P+BIcND0ftD4dj4cs1w3/G1MBtLYEqYPgAX0+GvaciC1ZwSbPE
         K5/PEVfsAjJpgYV/P/9RtxR4Cwti9TJTUBVcGwDSi0d1jFpW+Kru/ptmN7kOVeDF+w7r
         rLVKgPiI9Tb6Wub+XSqI5pH1RDr+UVMSuTwzE3kMDpKmDfmbSwlMpUGo0dZhyxdEtwKp
         P9kTCrN+w/7z1qUn3urdOutTtsB8sWdlhTpNB4lDPGkkiqmvC8aQMISHhUpBhxH3gPst
         7Rhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762788782; x=1763393582;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QZt1eoNmJghXxK3OzFUBWP+UZk12kwPAzm9DvMX3M0s=;
        b=t0HQX4yfvnr2bSflDJknVby/IyKUfsOdrYKir+7E+IE9klnjYgszxiyizoVEFTGVAH
         ZEpuqqbpp+CHfaLwrnB2d+AeNG7/16gC+n6cRrDOQKQrT74v6yy8uSKJM3mRlBaT5Uh4
         Pq2FGIiY7PHvyDnygYgfx7eVBW48xJt5d6Zfj+OlyNyBKVkPaeYTK7Mnt6Oeh0ouVix+
         iQzpbSm4m/c9jOKmxRoiyybURMtUayRWAUt+Qa960B/Ys5TAgODORCa/5bKmG0mO2f1o
         FP2XXan+1EHdzGSvPQdp8wFNBfkdYgDueWaaozPr6w/+04KpQOvPlFza9O18oYSZ5wyz
         F5fQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdEw9ABY1dHaNGUS6qtRi5oBXvqgAmmTevFp6ayUW95xaerc3IJaAV3V+hGQHovXDmFSUQxYh3thTaeUg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yycnpn9DXKoFTF+UnE8LzrwWPzIhJWtPoQ8Pu7D+Zg85Xqsjude
	5EmnOAuATGwX+RjuPF0VOgvM3u4cU2KQo7bT3B2tzhy8T00tv+A3D+uGwqDeklQenXg=
X-Gm-Gg: ASbGncukjeCs+lyAMfQnDuK51CO4mbgmp4OZdrRsT7beIk1mGz4tOD3lozqJIJUVUns
	ei/aTA9rS3OS0n+XC0w9jj3OXqGX9QcCQc59EmvNCECKQCEm2xKqlS8L9BL6TQoTGOnFOBxnr4Q
	4TIeFYZCYt6VwQXdFWt7qcMo84R4ts576h0fN/UTKESYaDClC8l0Q6xXnavx9CgBSQkfcZXDSqP
	33UWGBTyZ6j7iKhhChq3QJwe1BThqtz5Ie+cDt9PCh66JDC0GrRqZv4LQ9cXR+CfBFAK1SG1ovh
	ensxUsdqMUhKb+vVamcJHt035Np2RYylVk3BgQ86+d3XsW+A6rJn8bx6HAf4N6AZDLg7pRRTRY9
	wVkXCWEQSH/37+nar1SIXf+H6WMVVCU74ZqXWM0hOkeHFOg496aiUtUPsb42hPLFcDWTLNXdGmD
	6+hl+r7JAIzc5gFw2ChJoeLNh0KrekKuOtV2cFxnmkvNfib1bv3miOtpfhrbCL
X-Google-Smtp-Source: AGHT+IGL96zs748BVkStlBplObt6x+GOYGDHlU+lHOEWktwEy6wmWPMpV0MLGfLrCfASxr+Q4IKQYQ==
X-Received: by 2002:a17:907:3e9e:b0:b53:e871:f0ea with SMTP id a640c23a62f3a-b72e058a6d9mr938783966b.56.1762788781394;
        Mon, 10 Nov 2025 07:33:01 -0800 (PST)
Received: from [192.168.1.42] (2a01cb0405e83a000cb38cfe29807c1e.ipv6.abo.wanadoo.fr. [2a01:cb04:5e8:3a00:cb3:8cfe:2980:7c1e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf7231dcsm1115978466b.31.2025.11.10.07.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 07:33:00 -0800 (PST)
From: Mary Guillemard <mary@mary.zone>
Subject: [PATCH v6 0/5] drm/nouveau: Enable variable page sizes and
 compression
Date: Mon, 10 Nov 2025 16:32:55 +0100
Message-Id: <20251110-nouveau-compv6-v6-0-83b05475f57c@mary.zone>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyzHQUlJIzE
 vPSU3UzU4B8JSMDI1NDQ0MD3bz80rLUxFLd5PzcgjIz3WRzI+NES+OkZGPjJCWgpoKi1LTMCrC
 B0bG1tQB1XZ50YAAAAA==
X-Change-ID: 20251110-nouveau-compv6-c723a93bc33b
To: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>, 
 James Jones <jajones@nvidia.com>, Lyude Paul <lyude@redhat.com>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Mary Guillemard <mary@mary.zone>, 
 Ben Skeggs <bskeggs@nvidia.com>
X-Mailer: b4 0.14.3

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

- v6: Use drm_WARN_ONCE instead of dev_warn_once.
- v5: Add reviewed-by tags, use dev_warn_once() instead of WARN_ON().
- v4: Fix missing parenthesis in second patch in the series.
- v3: Add reviewed-by tags, revert page selection logic to v1 behavior.
- v2: Implement review comments, change page selection logic.
- v1: Initial implementation.

Signed-off-by: Mary Guillemard <mary@mary.zone>
---
Ben Skeggs (2):
      drm/nouveau/mmu/gp100: Remove unused/broken support for compression
      drm/nouveau/mmu/tu102: Add support for compressed kinds

Mary Guillemard (2):
      drm/nouveau/uvmm: Prepare for larger pages
      drm/nouveau/uvmm: Allow larger pages

Mohamed Ahmed (1):
      drm/nouveau/drm: Bump the driver version to 1.4.1 to report new features

 drivers/gpu/drm/nouveau/nouveau_drv.h              |   4 +-
 drivers/gpu/drm/nouveau/nouveau_uvmm.c             | 102 +++++++++++++++++----
 drivers/gpu/drm/nouveau/nouveau_uvmm.h             |   1 +
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmgp100.c |  69 ++++++++------
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmgp10b.c |   4 +-
 5 files changed, 131 insertions(+), 49 deletions(-)
---
base-commit: a2b0c33e9423cd06133304e2f81c713849059b10
change-id: 20251110-nouveau-compv6-c723a93bc33b

Best regards,
-- 
Mary Guillemard <mary@mary.zone>


