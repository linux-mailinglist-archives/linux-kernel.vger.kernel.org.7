Return-Path: <linux-kernel+bounces-872957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A81C12B36
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 03:55:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E85BD4EFBE8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 02:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62EEA277819;
	Tue, 28 Oct 2025 02:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="igOvB5ml"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485901EDA0F
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 02:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761620143; cv=none; b=mNoTM9siOruDWNcnGroDCoDSIfT9r1a+sG/YPsPtgXQJIwyxdCbaO4YwsxUe9aDXXgbyQW3LYWAmaY6/wjeO/djUM+QetomOLT+kBi37D11mGq292G90FJ1e14udfVjlyltjqMKQQG+PbFs71OCB8apk9MRcsUYPsvjQaEqwllY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761620143; c=relaxed/simple;
	bh=bZOhK5HCh3vlm4RKXz4yQ3BpYGs2VtaetnFAD3Q+3ts=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=dDTCvNzg2U578ZzAvM9ozNd8OobDOKgTFEIXB1uZ/EjHUv0QO86RLykJOOLZmzsTW17OU5kDdhgnnJn8SnN1kX1FXV9EVU4R2trFo0p5oywmbCSZ7eh9K/J07YxL+o/GNjuHJRz6dY3//UiBQgQEgRb0sTxj5vSDCYTJHrJIgEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=igOvB5ml; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-793021f348fso4721211b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 19:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761620141; x=1762224941; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uuA4KWO6Edrrb6J6eT/hSkUwiiht8zwyxLZmkW65ivo=;
        b=igOvB5mlhWOGjP2LOtnVAhax1JP7geuJZlD79IzrEI3iDqUu+Q0mX5AS3442heEJst
         ENvjoZPA+TLx+twdnBPZeu5Ldh4B1tAhZLXTbUE9LWgvwwkijiERFiRYj5n/gKyC6JZi
         t6OgypjMQpsAsREMcYo6U9SR5+LpEsYBqogEZsw05WEh8tV6LDpJJFyNrpo+MUE+OVO1
         tIVGc8OMRT/8yDwOJ2GELPmEPZ5CyWG2hut9X+fe8pHpzb1yzCGukOkjyQf3RxPqngna
         pKae+fNqcpkjKXdN0Vjp0XKDV+spaTYA9fvKb1gPvtgiuAOEFrXX0ijU6471dpZQ9+ZA
         aVpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761620141; x=1762224941;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uuA4KWO6Edrrb6J6eT/hSkUwiiht8zwyxLZmkW65ivo=;
        b=mhtpafDMg8W4MxQesNtwDMHno9WT6mnzVCQavzHNivJZpzr/I3nGz8vPyIABmtnJSt
         sAcyo5BLvd8JVB27chtZxm0jtZMDSveavcjZgjdXLxzhr+GVtZD7uLajBwNgaIhDB6wv
         UrqS0EfaV+8P9WozQhm2ryjImMDuU35sydvmQDn2ekY6vu7QLzWKokeWq9h+SynKFfex
         kf//l8rHRyf28hZfZUcmmCUi1WT4Xgm+dYYDbGcFrUEnpvdkTNINJqU3PGMsqGkVrsxl
         ndGthbv3dKDquebN9oyTf4pGP3FDfns2oflEre7jlCuXOFU759xsymzUvuuBAIbosl3P
         28Tw==
X-Forwarded-Encrypted: i=1; AJvYcCU9wRkcxRxBcn4VZxTaitHmRYftpMo/7TUl1guaaMFYvoWXWnyRa3mQIM9pUzVoFQWoe3J3yzgcFws2Z5s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz65hshatoQ5r/mMmr3UxFeYceiOkOEDSPJwt//aMswr7SzzSbR
	KsnBMhDQEslIuWA060WBBfFwNmwWJ3ociDv9e7RhtLKsu9TVp5oFMilO
X-Gm-Gg: ASbGncvdIdx5eH2lLeczhVgC8pKurjEvzY9BXO/ajS6Zf1panI+r8d06oo2Y/KoE746
	sQK/T/Xkls0JLiFehi1JPwbrDHLB40Kp0roJHz2AS7S1Lq0sxWiy6WOCrZVeo+9jPGSGgUzt1oo
	i3dUGgKfB9wOvzA3XjpE2P/TBrjtbnAoV9oE9nlWhP8aFfUF+RYHgD6Uz8b4bQEFKXx09gLY4dP
	oA5WIvoc7iu5bpa+S0NvimoaUYxVi8BZ0mGUzUPqjDf5DfrcRq9XR2W/3dIk2RVX43UavOh1ijZ
	E8tpI6pRGEt8WMSq7daiQfX5aQDZtZGgBHI+SvutNRVqtJh8MO8KAtlZTExYxuMHFOlBwDy3bkX
	FLDhiGoBNDEhmstW69YIxUHOy0dS85R2pIP/9YBzIICHVCkp+gkP5lQM4FNjrL++ZTrBAmTciri
	IFT+u+F0jbPdwMhGs3KlzSq7zmYfY72eVFKe7nUKY=
X-Google-Smtp-Source: AGHT+IFiOKx69C8wJ8fec7v6/uMOAzhY+T9bwF3wNtNS/WP44BQb7b5nEI8GbxT+f57A+QJG5AIjKg==
X-Received: by 2002:a05:6a20:5493:b0:324:b245:bb8e with SMTP id adf61e73a8af0-344d2973e71mr2314026637.26.1761620141451;
        Mon, 27 Oct 2025 19:55:41 -0700 (PDT)
Received: from [127.0.1.1] (211-23-39-77.hinet-ip.hinet.net. [211.23.39.77])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414032c71sm9927580b3a.25.2025.10.27.19.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 19:55:40 -0700 (PDT)
From: LiangCheng Wang <zaq14760@gmail.com>
Date: Tue, 28 Oct 2025 10:55:38 +0800
Subject: [PATCH] drm/tiny: pixpaper: add explicit dependency on MMU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-bar-v1-1-edfbd13fafff@gmail.com>
X-B4-Tracking: v=1; b=H4sIAKkwAGkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDAyML3aTEIt3EVIMUC9MkQ7M0Q2MloMqCotS0zAqwKdGxtbUAq5RPf1U
 AAAA=
X-Change-ID: 20251028-bar-ae0d85b16f13
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 LiangCheng Wang <zaq14760@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 kernel test robot <lkp@intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761620139; l=2722;
 i=zaq14760@gmail.com; h=from:subject:message-id;
 bh=bZOhK5HCh3vlm4RKXz4yQ3BpYGs2VtaetnFAD3Q+3ts=;
 b=CcuQCNl2THLCANzvmTYJ5l+sPZCXMOHNgam9/fft79MOXtY7+R2haFDcJ6BdJCPTeKWVhwEU6
 eFEnBYalrizD1uIo0829Kc2ES4WL6rKT5VZXnpUemvOpjCh/bO2KC//
X-Developer-Key: i=zaq14760@gmail.com; a=ed25519;
 pk=5IaLhzvMqasgGPT47dsa8HEpfb0/Dv2BZC0TzSLj6E0=

The DRM_GEM_SHMEM_HELPER helper requires MMU enabled because it uses
vmf_insert_pfn() in its mmap implementation. On NOMMU configurations
(e.g. some RISC-V randconfig builds), this symbol is unavailable and
selecting DRM_GEM_SHMEM_HELPER causes a modpost undefined reference:

    ERROR: modpost: "vmf_insert_pfn" [drivers/gpu/drm/drm_shmem_helper.ko] undefined!

Normally, Kconfig prevents this helper from being selected when
CONFIG_MMU=n. However, in some randconfig builds (such as those used by
0day CI), select statements can override unmet dependencies, triggering
the issue.

Add an explicit dependency on MMU to DRM_PIXPAPER to prevent this.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202510280213.0rlYA4T3-lkp@intel.com/
Fixes: 0c4932f6ddf8 ("drm/tiny: pixpaper: Fix missing dependency on DRM_GEM_SHMEM_HELPER")
Signed-off-by: LiangCheng Wang <zaq14760@gmail.com>
---
This patch fixes a build issue reported by the kernel test robot when
building with CONFIG_MMU=n on RISC-V randconfig.

In such configurations, the DRM_GEM_SHMEM_HELPER helper uses
vmf_insert_pfn(), which is unavailable without MMU support. Although
normal Kconfig rules prevent DRM_GEM_SHMEM_HELPER from being selected
in this case, randconfig builds may forcibly enable it via select,
leading to the following modpost error:

    ERROR: modpost: "vmf_insert_pfn" [drivers/gpu/drm/drm_shmem_helper.ko] undefined!

The fix is to add an explicit `depends on MMU` to the DRM_PIXPAPER
driver, ensuring it cannot be built for NOMMU systems.

This issue cannot always be reproduced locally because typical builds
do not violate Kconfig dependencies, but it was confirmed that the fix
prevents the reported 0day failure.
---
LiangCheng Wang (1):
  drm/tiny: pixpaper: add explicit dependency on MMU

 drivers/gpu/drm/tiny/Kconfig

Signed-off-by: LiangCheng Wang <zaq14760@gmail.com>
---
 drivers/gpu/drm/tiny/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/tiny/Kconfig b/drivers/gpu/drm/tiny/Kconfig
index 7d9e85e932d7fd7bdb6ad7a4c6ba0f835841f623..f0e72d4b6a4709564e63c758e857bdb4a320dbe7 100644
--- a/drivers/gpu/drm/tiny/Kconfig
+++ b/drivers/gpu/drm/tiny/Kconfig
@@ -85,6 +85,7 @@ config DRM_PANEL_MIPI_DBI
 config DRM_PIXPAPER
         tristate "DRM support for PIXPAPER display panels"
         depends on DRM && SPI
+        depends on MMU
         select DRM_CLIENT_SELECTION
         select DRM_GEM_SHMEM_HELPER
         select DRM_KMS_HELPER

---
base-commit: fd57572253bc356330dbe5b233c2e1d8426c66fd
change-id: 20251028-bar-ae0d85b16f13

Best regards,
-- 
LiangCheng Wang <zaq14760@gmail.com>


