Return-Path: <linux-kernel+bounces-847571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14134BCB373
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 01:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 797B64274C1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 23:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C3F1A01C6;
	Thu,  9 Oct 2025 23:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CTYTovnU"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0063B289E0B
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 23:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760053192; cv=none; b=ipUo5PlS2XD2QZrH5sbnsRXVPTOmuzbiUiOBSutSZYm20WxdME9tYtiP6wtmCl3KHg30AhGpSiiUm+PBuiwjlElrU03ef0JXBqfgowuM+q3Fi59ust+kFbANJcI6k0EGeY/9p5byAgGSuhCVx8qLi0M4ajWrcyO5RK2Sh8oF+VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760053192; c=relaxed/simple;
	bh=36pVCnZWN4SZ80UBOIQS1tVOes82LSVnGiM35BqW6ZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PLOV4Lc+2UZShPXvl3PcUE9b9yyo+627yVezQkdOKkx9iRDontrR1fE4mKdxAzo1WsgOoKWqRp5SWaUtd/3YXtI4paMeFw70yo14E4rpEAVGm66d9RaiIGJ4DWtl0ZEpuPbPtpttmx+gPPfb1bOgjyO6ASyzaBmscGrYxqL+xRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CTYTovnU; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-46e6c8bc46eso8792095e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 16:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760053189; x=1760657989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OpLyNX9fRh+6ZSUeqgLPaV8NCrY8WnY93VlPM/N7oK8=;
        b=CTYTovnU3OEOx+++fGVBRFUtRG4wlzd4Pc1Xu9RrCaN9S9XJHantMglflyQWP4DESH
         dFAyZDHto7jx1Yu8i1YCUbSHkDPw1ULR2lLnhVOHPjghtGGZ+3C8dinAxDv2CqFwJG+s
         boX0de9f6QHcf0d7NWwz02Z3qKMIuYO92JFtq8s8Wr8pEegIGc93ueTnH4qTXNtAKaOJ
         2bRSjr4DdfNCrvbtw9Tm4IviKnN38zHnq4l02KUmxvjdAOCFltOU5kd+bnHjkMzMP8o0
         YrlQIvsq7jt4qpwYKfLHq+L6PpvOZBhzt+HQXVk8T/9uvsABXASycyL4q9iaL+GaPJ/j
         24Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760053189; x=1760657989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OpLyNX9fRh+6ZSUeqgLPaV8NCrY8WnY93VlPM/N7oK8=;
        b=BkPArVbN52jdT3dn0MQ+wIub8LPUPWevLogDyN7Tn5qhfTaBNdIbNxN3G0A9oSRBea
         /vHwjCzRXyafCoupuw4aj9XFxI8AxlwgQQ7De03RuzYYxInpQ0CZaeh34904R9PyifzF
         bWuq7gicpRyK4iiS7Yib8PPKv4r+sa+Ex9SnWoUS28A07pTVyH0RNcfxo0AxuP4WNhlb
         s0PHLiYokLjeTTXVqVkrjCpNslESsnYkG+JLhQIUa1zUCSB4rDOt3P8hj0remGnKB9zY
         NPMJJ5Xn2zJYqZ2sdkw3H+COvCnsJS34PUITsYQzZk2ONXNd+YFgleJ3U/Kaop5L6XLB
         VX1Q==
X-Gm-Message-State: AOJu0YzB9bPuQA1wEJ6e0zazXRlM38BheXQW6wKKX5LcG0CyhpwUghGZ
	GEfI/z9qbqz6QChRwR4+ztHcFUs8T8M2ugJCrfGOTGMlWf41/cM+9ib+V8OtMw==
X-Gm-Gg: ASbGncs2iI65+nVsm/gxkIHaTP1viIe2/Qznv6vK4FF/Oe7QD+BhonZaJFnskwPhSt7
	meuYC6UTxl7LXCpF9QIVgq9vRD4bTQxmYqm4JmtRdryd3ZWiePt8ij7rV9bzOs8keE9LfYlBPhL
	21SnxpVNn83ns7ckww1qIq832zog62mtWr/EuEeSl8/nB9Tg1EejvUebYzIwxsGLA+PTnOxcfjg
	YFmE6zVC5y7FrSqc/ZE6+9qDCn5EK7YBkbaKtevHTRbSrj7BdCLj3SnRGA2pIH8ySMNtSp8D1S9
	13UHvRD4eVD92+CfaqKuN73mGVfPoTceZcIrkzTMTZnxDGu8W4PJMgdX1QWAyuvrERMw3W1cpOP
	FfCAEFlRLQssJGgAhVFiKoiSLeli0kZqAbCxQ3TwwiqyYJk4BM0g/
X-Google-Smtp-Source: AGHT+IGJYw11rDLltJwLvCnQW4izSML6BKxvrZuXRvJXZRf+jWWFVqJr/ShHNVK1a4VjhZ4lvPbVMg==
X-Received: by 2002:a05:600c:1395:b0:46e:27fb:17f0 with SMTP id 5b1f17b1804b1-46fa9aa204cmr65438775e9.9.1760053188697;
        Thu, 09 Oct 2025 16:39:48 -0700 (PDT)
Received: from fedora ([41.45.27.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fab3e3206sm46066075e9.4.2025.10.09.16.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 16:39:48 -0700 (PDT)
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
Subject: [PATCH 5/5] drm/nouveau/drm: Bump the driver version to 1.4.1 to report new features
Date: Fri, 10 Oct 2025 02:38:37 +0300
Message-ID: <20251009233837.10283-6-mohamedahmedegypt2001@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009233837.10283-1-mohamedahmedegypt2001@gmail.com>
References: <20251009233837.10283-1-mohamedahmedegypt2001@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The HW can only do compression on large and huge pages, and enabling it on
4K pages leads to a MMU fault. Compression also needs kernel support for
handling the compressed kinds and managing the compression tags.

This increments the nouveau version number which allows NVK to enable it
only when the kernel actually supports both features and avoid breaking
the system if a newer mesa version is paired with an older kernel version.

For the associated userspace MR, please see !36450:
https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/36450

Signed-off-by: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
---
 drivers/gpu/drm/nouveau/nouveau_drv.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_drv.h b/drivers/gpu/drm/nouveau/nouveau_drv.h
index 55abc510067b..e5de4367e2cc 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drv.h
+++ b/drivers/gpu/drm/nouveau/nouveau_drv.h
@@ -10,7 +10,7 @@
 
 #define DRIVER_MAJOR		1
 #define DRIVER_MINOR		4
-#define DRIVER_PATCHLEVEL	0
+#define DRIVER_PATCHLEVEL	1
 
 /*
  * 1.1.1:
@@ -35,6 +35,8 @@
  *        programs that get directly linked with NVKM.
  * 1.3.1:
  *      - implemented limited ABI16/NVIF interop
+ * 1.4.1:
+ *      - add variable page sizes and compression for Turing+
  */
 
 #include <linux/notifier.h>
-- 
2.51.0


