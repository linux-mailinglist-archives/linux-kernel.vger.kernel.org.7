Return-Path: <linux-kernel+bounces-842602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6BFBBD22D
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 08:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DF3484E57D0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 06:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8919324A076;
	Mon,  6 Oct 2025 06:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NTp9J3PJ"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1AB21B9D2
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 06:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759732274; cv=none; b=tTxyNaUH72eZCEI/lko+1WH53WgMa3qypKX358rtqzx5eWO8IF39A8H6KYbz6Y5ISikPF+8a+qy5Q9/rEXRcfwy+dA1fTuiu1CjASguaFlMuk7glFkrVq3iLYkyoBrzdO/8UMRRY3IynYKKzQ0BcrX8jhlcRgqRVpQdoOzWkdUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759732274; c=relaxed/simple;
	bh=H3X73yEWW5xnMRSc/VOILo4P2AJ07gDRT0jl3xbbPJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nqMz30XOOVKGafPSQC7cQjNm5M7NVoHxjfg4RUgnI4aO2CvDptNPVXnb50zeHckUtC9vref1xHO/dRh5+tW7md8t2fLp9JoBAd9TTy5rXOIHG0jdGrS0caFONVuf/6tRzSPGgDlXKDkwLZrF1G5MfNmqNSnHAjgRVp31IIBCvNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NTp9J3PJ; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-27d3540a43fso46373795ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 23:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759732273; x=1760337073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kAl5ud0fiOLEIeLKR9WAaQrnRBmvWYDt4oevdTsfy9Y=;
        b=NTp9J3PJX4R5/e9GEJZPd/WZdXgnME11ExEEwiGH/NqB353SnZvHlLXrwoQw6oO2vw
         yylCHLzPd+PyTVqUoykpbfXi90Ht+QeHPF/Tp0AEff4subWBuvi8EAZXVwRGXFec37XB
         gMXOPBZApayFUfDM4sp0Z4RiPm2nSQrTdAHpDqcdj0oTUOTJxCYjNUy2uMtunKl21ruL
         YeL9Cn4U/IcSS4z6P3TC3Tv8MEgGwI+wfCZKuJW/2o7fUK32j4pfDIPZAEWw/ES2CEDY
         2zHGLyYfpPPc5GZj2o3D/8mej42pgNq01239g5PmMW93xOx0F3cc6lUqVpoZyM5DnsyH
         9DOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759732273; x=1760337073;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kAl5ud0fiOLEIeLKR9WAaQrnRBmvWYDt4oevdTsfy9Y=;
        b=WNAACnm1Rqd2veM0hlrq7dsghCDrmLdy0/R18gwEh1bjFG4Qu37rVTEISL10gYPXci
         cS+3FOKyvHP2t+p6YyvMUr6nFnQ1GXKyGowBcVw2qge7t8u4szXh6Ti7xIzaQiwxGpOz
         fInb/moCkIu1deSJd//i++/DXOb3bHPgyinA/TF1KQ7YQAelyYgLn9RbohOoHHxbskZc
         gTgY8umuH6Y+nfCGAiYQ9szG6Bw/bAxBLbR10+x5KqJH+2/p6FFYdc+QUcR4jSYd2fOv
         f327mkhd0k//5s9eu/SrI6QIgtI+mG5hK4lfRbY2FZ/9dbJWx6FC/nu6fnekU+1M68Bn
         gHAA==
X-Forwarded-Encrypted: i=1; AJvYcCXmf+QXcih4yZ+skT2c9fY+jGsvVoDDYqeSHXWo2qBm+oq+MOUSUbx+yylhph6v0nIbUur0q0kLQMgZC3E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDHlgIJb4zr9ZW8TCvMEFOiVSnIYFOPvU1iAlJk56RYUQzSs1j
	HCvvPh57nHyOQ3pNa9zcIOxRmhzHAaRr5MncUdkgnOrKTYh/x2h+8RCh
X-Gm-Gg: ASbGnctVUE4SoLYKlEW0bZRHudwZIlaOqWYOXopgA+02jNnFFcuzHzVeqiIX0harxv0
	sDQ60ginekkyqO+3XLDcWZ2nV09v2mFCMmgDYq1c4NwzUiFcutwxZZkgzckws+pz1XlcW6KVchI
	TVvpodcvWZy9Zv/KsKFM5Qq3JdtU66BKrdsEXVW/nYgAVSE97r9PdMWwV+0eIE2kyxXqd9oaf15
	nn9KYgGASCUKoAhAMdj1JcZ8SN3B3DKJO9Jyf+6Pv1sw8gNLdz91Du58aeQId7W687Lu8Cxy1XM
	aqzEkgwBTROQo7J6W7K7uaIKbwjohLC1O09k0eJSWFTxzvEpgLmbmCOCVEuMFVX49HKWb9EBz48
	dyZj+y6PDHgDtMP6bHlGmgmB8m4ttvBErRMqFZEurgInCqp6HKQ7RaNn97aZv31DQlw==
X-Google-Smtp-Source: AGHT+IGMU7hrj7U1FkXheOsivtz2T+wK280erwvJlu/0py0PentU5hAcc1tVeLRVpzJrKs2Jah4LwA==
X-Received: by 2002:a17:902:c94a:b0:267:776b:a315 with SMTP id d9443c01a7336-28e9a61a914mr137570535ad.32.1759732272761;
        Sun, 05 Oct 2025 23:31:12 -0700 (PDT)
Received: from LilGuy ([2409:40c2:504c:58f0:9c58:4a8b:65a6:88b4])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-28e8d1ba184sm121008085ad.89.2025.10.05.23.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Oct 2025 23:31:12 -0700 (PDT)
From: Swaraj Gaikwad <swarajgaikwad1925@gmail.com>
To: David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Jonathan Corbet <corbet@lwn.net>,
	dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-kernel@vger.kernel.org (open list)
Cc: skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	Swaraj Gaikwad <swarajgaikwad1925@gmail.com>
Subject: [PATCH] Documentation/gpu: Remove duplicate kernel-doc exports in drm-uapi.rst
Date: Mon,  6 Oct 2025 12:00:09 +0000
Message-ID: <20251006120010.17976-1-swarajgaikwad1925@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Eliminate redundant `:export:` kernel-doc directive in
Documentation/gpu/drm-uapi.rst to fix duplicate C declaration warnings
during Sphinx builds.

warning before this patch:

  WARNING: Duplicate C declaration, also defined at gpu/drm-kms:35
  Declaration is '.. c:function:: const struct drm_format_info *
  drm_format_info (u32 format)'. [duplicate_declaration.c]

The removed export was already documented elsewhere, so this patch
does not remove any meaningful documentation. Post-change, both
`make htmldocs` and targeted builds with `make htmldocs
SPHINXDIRS=Documentation/gpu`

complete cleanly without warnings.

Based on commit 47a8d4b89844

Signed-off-by: Swaraj Gaikwad <swarajgaikwad1925@gmail.com>
---
 Documentation/gpu/drm-uapi.rst | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/Documentation/gpu/drm-uapi.rst b/Documentation/gpu/drm-uapi.rst
index d98428a592f1..80cfd9b7c908 100644
--- a/Documentation/gpu/drm-uapi.rst
+++ b/Documentation/gpu/drm-uapi.rst
@@ -604,9 +604,6 @@ DRM specific patterns. Note that ENOTTY has the slightly unintuitive meaning of
 .. kernel-doc:: include/drm/drm_ioctl.h
    :internal:
 
-.. kernel-doc:: drivers/gpu/drm/drm_ioctl.c
-   :export:
-
 .. kernel-doc:: drivers/gpu/drm/drm_ioc32.c
    :export:
 
@@ -761,4 +758,4 @@ Stable uAPI events
 From ``drivers/gpu/drm/scheduler/gpu_scheduler_trace.h``
 
 .. kernel-doc::  drivers/gpu/drm/scheduler/gpu_scheduler_trace.h
-   :doc: uAPI trace events
\ No newline at end of file
+   :doc: uAPI trace events
-- 
2.51.0


