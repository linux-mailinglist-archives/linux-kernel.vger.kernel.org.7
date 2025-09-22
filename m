Return-Path: <linux-kernel+bounces-826569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9FFB8ED44
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 04:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07BE13BB33E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 02:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F70B2EC0B1;
	Mon, 22 Sep 2025 02:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N6A7nGYO"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515CC1548C
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 02:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758509863; cv=none; b=LX068wGRlcaeBAS2Cwu9HijF74q8Y4/vpMf4sS4P+ohUYv5anpEL5bMP5lDt9h24MsPyyY0xxoQvco8exd8OtXeXUe4fqSTt2Y/tEIYcYIqsiLXQ1/a07YRseHg6m/gdvyEQwbZlLSmw7Xhg8K8yV/rrP6cOH5HRmdz9fdsJPV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758509863; c=relaxed/simple;
	bh=4a8JeN2uyVnaN5neLm35KD+FvaZjZ1l+wsL+PM10Ld0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=lrtaggocfQOa/jmisDCBZU0rfK4ckcCnVuJVxKt9svmBg7Nw5hwkCzYSV1Tz/+N6uKMXMBaOjjTvYBIuwQZDQPKlmuSshI+nSvWNPI5c8BnuNgG5LR3bG1+2/pBpA8cHcx4rFGtq+9ploozbf34xVUm7n2w+rFJ7/gXTxBzUxwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N6A7nGYO; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-77f429ea4d5so132351b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 19:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758509862; x=1759114662; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6Hn5nOt3o6tJ4bZAjN+4kfHo/FZFsXJw50TfEglXGXQ=;
        b=N6A7nGYOdXwG0FZcJkEtl1uNgQhajT6JgE61mZWm3Ykv8sDn4+7O6TPMkIU7wT9zED
         i9Ch5GPUgI24AW8rrHKF4h4n99bj70a9sHPYVYu9e4Ct7ytMCYK/bD76iGuIh4JMSxcZ
         4v1qqxNIXGtdOJwy25VTPNmGpowjRK/Pa8/CkEDPIoXmTB+N0mu5egZFYPTSjF1Sq+0O
         RS3rXeNWwXgFybxb0O+Yc2+UpfL1YLKOGoLJT4F71MngVDtwkmo0c4lYFe4VvciXFLNZ
         0gCMJnsVmax/TRkfU6mEq0iCC0CXFyz71xNWVcswXwD9LUrpwwYHczQpULTcoKCNjCiJ
         fAYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758509862; x=1759114662;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Hn5nOt3o6tJ4bZAjN+4kfHo/FZFsXJw50TfEglXGXQ=;
        b=TKuFU5bWgR+hhOx0JyTQyS4AEin1d6zDBwYDuIm+v7sJsGf258AeQocAkhvMQrpzA4
         G8W5rGg4NLR9Yu3s2CbMnJ28/xa3CwIt+uMqyMGceQv/E7FUVc6sWO55b3AO5Rz97H9H
         94UsRA9qw+aBndYKWmlcXzczFM7DjK39fQDGQvXW/E2gXAcgnUIw2EeQpotXjuNBF/JR
         8sZD8Wrdn5FZCvxa3f9Yt3oaJfjToJHGwRpWGgjV6cl3GbWSyS5n1Rtq14A+Ae4PmzZZ
         XoX5UKVOovjkBG3H7LgIAr+Z0j7BzxpMTiVsdGL+ApbRMDfmrOl+qwMYUrO6WIf45OIS
         ANGg==
X-Forwarded-Encrypted: i=1; AJvYcCX3aGlZkbFtw2canDox8z9vNj+HMcyUUarQ2SveO25MUtbQ5pl+uaiZQocRt2mTYWBGO5dg+8ABySciEIo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyoHMY8slCotLfAGh4bj0fUXr6Zaapnx363ebpITU37wSm/TuG
	B6kJHRhvbCnA/n6VppHfsB3ghSqTJ0t5v793WqmUfWGBU0i7JCrL0M2b
X-Gm-Gg: ASbGncv2YesCwqpOXGiwYqtJAx9LeuenOmuX5WmlKbmlkcd1H7yFeQC6aASmNyQ2+kO
	dD1GBQY+tBQ4/OQ5/uSy91OtMbAKVmMDme7kJL76lzNHit7rP4diFKravoNJwcDe2G+egAf/ERS
	7aBvO2E9WK/+cCrAX49ZIxj4DseEzttyIu7o3Aw5mXDrzhcReYS3+hUaucaK6Zuur2+aUAukV20
	79i0JavHS7xbsQ21MLhoWwps3XCYniSVIRd0gPSOSPGdjXAnIUmnWf+G+aomZdsnfXWWIxVtRAb
	b9R2v/HG0qud3a2CNpNDVYDHcvS9wQdl5etB60OQbWAKUxPIQn9M8eYFqpH+MJzzJL26VuKS8NY
	wlnMiI0mwNjMpyHPbHtk0vaHh44Xv4ffflXXdx9w+41pVias5gTTGF9uWaXO+Pw==
X-Google-Smtp-Source: AGHT+IFjMgNZjpmTloPgv57R4zc0ax4KAplY7viQDnpXjQ6wfKrJH/nZWUk7ml/DBLF/33o3g5U24w==
X-Received: by 2002:a05:6a21:3384:b0:24e:95c2:907f with SMTP id adf61e73a8af0-2925ca294famr16240784637.2.1758509861552;
        Sun, 21 Sep 2025 19:57:41 -0700 (PDT)
Received: from [127.0.1.1] (211-23-39-77.hinet-ip.hinet.net. [211.23.39.77])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b55156734a4sm8343111a12.4.2025.09.21.19.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 19:57:41 -0700 (PDT)
From: LiangCheng Wang <zaq14760@gmail.com>
Date: Mon, 22 Sep 2025 10:57:34 +0800
Subject: [PATCH] drm/tiny: pixpaper: Fix missing dependency on
 DRM_GEM_SHMEM_HELPER
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250922-bar-v1-1-b2a1f54ace82@gmail.com>
X-B4-Tracking: v=1; b=H4sIAB270GgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDSyMj3aTEIt3kFMM041QLY5NUcwsloMqCotS0zAqwKdGxtbUADCz+SVU
 AAAA=
X-Change-ID: 20250922-bar-cd1f3e834e78
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 kernel test robot <lkp@intel.com>, LiangCheng Wang <zaq14760@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758509859; l=1838;
 i=zaq14760@gmail.com; h=from:subject:message-id;
 bh=4a8JeN2uyVnaN5neLm35KD+FvaZjZ1l+wsL+PM10Ld0=;
 b=b2Lz634TMQd2uje5PtB9StbLsC7xXco/bfRnNf9wPOoWFtgWCIadUantM2fog7BKUmxtP9X+v
 U2tYq/DQszsAWnhkk8gWhWyDL9INPMlXvg/Mup2H6pGP+qeJ0FcxX3Y
X-Developer-Key: i=zaq14760@gmail.com; a=ed25519;
 pk=5IaLhzvMqasgGPT47dsa8HEpfb0/Dv2BZC0TzSLj6E0=

The driver uses drm_gem_shmem_prime_import_no_map() and
drm_gem_shmem_dumb_create(), but the Kconfig currently selects
DRM_GEM_DMA_HELPER instead of DRM_GEM_SHMEM_HELPER. This causes
link failures when DRM_GEM_SHMEM_HELPER is not enabled.

Select DRM_GEM_SHMEM_HELPER to fix the build.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202509220320.gfFZjmyg-lkp@intel.com/
Fixes: c9e70639f591 ("drm: tiny: Add support for Mayqueen Pixpaper e-ink panel")

Signed-off-by: LiangCheng Wang <zaq14760@gmail.com>
---
This patch fixes a build failure in the Pixpaper DRM tiny driver caused by
a missing dependency on DRM_GEM_SHMEM_HELPER. The driver calls
drm_gem_shmem_prime_import_no_map() and drm_gem_shmem_dumb_create(), which
require CONFIG_DRM_GEM_SHMEM_HELPER to be enabled.

The issue was reported by the 0-day kernel test robot. This patch updates
the Kconfig to select DRM_GEM_SHMEM_HELPER instead of DRM_GEM_DMA_HELPER.
---
 drivers/gpu/drm/tiny/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tiny/Kconfig b/drivers/gpu/drm/tiny/Kconfig
index 94a5bf61a115929640022128e20c723ab7c0e735..7d9e85e932d7fd7bdb6ad7a4c6ba0f835841f623 100644
--- a/drivers/gpu/drm/tiny/Kconfig
+++ b/drivers/gpu/drm/tiny/Kconfig
@@ -86,7 +86,7 @@ config DRM_PIXPAPER
         tristate "DRM support for PIXPAPER display panels"
         depends on DRM && SPI
         select DRM_CLIENT_SELECTION
-        select DRM_GEM_DMA_HELPER
+        select DRM_GEM_SHMEM_HELPER
         select DRM_KMS_HELPER
         help
 	  DRM driver for the Mayqueen Pixpaper e-ink display panel.

---
base-commit: 846bd2225ec3cfa8be046655e02b9457ed41973e
change-id: 20250922-bar-cd1f3e834e78

Best regards,
-- 
LiangCheng Wang <zaq14760@gmail.com>


