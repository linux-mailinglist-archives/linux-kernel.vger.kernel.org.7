Return-Path: <linux-kernel+bounces-847029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A549BC9B1B
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 17:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B63614F686D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 15:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4F02EC094;
	Thu,  9 Oct 2025 15:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sn+u+AhP"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD692EBB86
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 15:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760022393; cv=none; b=X21g85tYh10hqtKDHDX9Yf1VP4otjMJoRpXMqHFrCLIVr8PfUZSSygP7/OFPid4+vTuDvkqNcwqmMKi78GFyX++PK4JZ07KhogAcerMFHFRb6yRpCQbKo5KtGkcCcaRGa6Go/fgUNbyTJaiXXjUYSN+XmreE7jmTMS+yWWLIAy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760022393; c=relaxed/simple;
	bh=Xmgpv3pLg3//5f5fa4beqGsC1NAKFUNclLsWdxNb0Fo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=bumhEUCRJzjtmGaHePxM9nCbwXIp51uecMHXb1kPm+Swsn2kAYbtYp6sj2gTDf51WDlqPWpo687L5+KKqKcaQwnTWUTE/sPHFJGpkWoxQbHaIRLgZwxwr15LXJpj3nrMa9tSu38zZw3LKedUYmY+YYaUQ9XXt8ZPSQZW/CuGhhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sn+u+AhP; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3ef9218daf5so1049201f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 08:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760022388; x=1760627188; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9kNNIboTBu/rgfEeqjlIf4OLiFoNCoyw80MDr+LA5Y0=;
        b=sn+u+AhPFZKd4pb0mEtW5Y/fTc7kvWv9KNBUEPJ6mCVUyOhAIdHjWa/LUJFu3xLSYZ
         doWgh73q8JLDhKtfUlFRDP6IGq8bxlsO/982dwmiU5ObkSCUF/gMV21wnRmz4otJCd39
         nKvTzxHqI4VIw4NYUIuXnAnzpGJyN4CbFPrTjn002q5uqkWIc9XY2NitTo0XeXIuukBV
         Z37EsZ6WGgkbI/tCcVsmx//25ouG/Bw2fBSBF9FgTOuWY2yefz9I/8Wc5Ri7p0FaPUsZ
         3Z/diOLVV6mrUdpgiifupdf/oZ2b/90Vi0LBuJDdB4CGqtCSkGs5OOpj36H4GnSRqC09
         thJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760022388; x=1760627188;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9kNNIboTBu/rgfEeqjlIf4OLiFoNCoyw80MDr+LA5Y0=;
        b=hDTyTWHJb3rxuq+fLzn5N97fPbB2K+BPp//2pFShjYM1lzvYTny40Wu4FW24TvFWJB
         jI7u2OdJ7KdLzWhl50VK6YO3WK/DA4mHj9vfvsB7vxVcfA8H3EqGNkEIycfWH5qvz8mw
         2qE2T4S9lcX8dwqVHjj4frDlnp+jvTVJT8TtUI0O7J52c+Mcxsi3flBJ7xeGO544LPrm
         OhJptKjkv28EUtVJRqelahGtu/+7Rl1rBlm3+V+cghOpzrVxm/rygT8l10gT8lrC2GOt
         D4GiABBDmBnB3uKXDo+su+5Wjorr/rJxy5GquShBKSk9K14qqgc99PA+W3S4nAtf3+17
         zr3Q==
X-Gm-Message-State: AOJu0Yzt6fdCeTV+xoEKi5li03FW+rexvTnJV/Lefx7F9R1rXItTRaqx
	6JoHVcR9PXhqC1a+mD/QdytwYEa/XXNAjUE8VNI10ymUQ7JBORPJ8LHlNucctaibsvTDs3t1ag0
	dU83zDfaIOSiuU8qaJUE5zV8MpitzyNT54v28QZri430u65gVVO375HekUXQrEvAC/xHlFOSvU8
	BVGkWr8wCr7awrobCusHN8b2dhg5fxnXXmqg==
X-Google-Smtp-Source: AGHT+IF28pI3nDsq06k40pR3d1KWdnq7Bmqmwn+5p1/UbYexmHQrk0yWcmBoTkVBvwdXntL/+LqRUcL0
X-Received: from wmhf15.prod.google.com ([2002:a7b:cc0f:0:b0:46f:b153:bfb7])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:41c6:b0:426:cd4b:4b36
 with SMTP id ffacd0b85a97d-426cd4b4b50mr143095f8f.58.1760022387953; Thu, 09
 Oct 2025 08:06:27 -0700 (PDT)
Date: Thu,  9 Oct 2025 17:06:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2191; i=ardb@kernel.org;
 h=from:subject; bh=BfB8Vi7bZ1cD+rxey05bluTEmM0Q6lYE5jThs99t4Pg=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIeP5+TxG4RyBuTtFVdNaFojs743b5qHJd6D1WPaRB32LZ
 r1fLOPRUcrCIMbFICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACay8jUjw61dyq5Z+TtXinnZ
 7X1o/vriK/GTMUvCpv3Si3roP2+Rujkjw9YKwd/iohuiu2Y1beXKSlprMTmh7G2Qv6+mq8GfWMs z3AA=
X-Mailer: git-send-email 2.51.0.710.ga91ca5db03-goog
Message-ID: <20251009150621.3886079-2-ardb+git@google.com>
Subject: [PATCH] drm/amd: Permit DC_FP_START/END only in non-FP compilation units
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Ard Biesheuvel <ardb@kernel.org>, 
	Austin Zheng <austin.zheng@amd.com>, Jun Lei <jun.lei@amd.com>, 
	Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
	Rodrigo Siqueira <siqueira@igalia.com>, Alex Deucher <alexander.deucher@amd.com>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: Ard Biesheuvel <ardb@kernel.org>

Test the existing CPP macro _LINUX_FPU_COMPILATION_UNIT, which is set
when building source files that are permitted to use floating point,
in the implementation of DC_FP_START/END so that those are only usable
in non-FP code. This is a requirement of the generic kernel mode FPU
API, as some architectures (i.e., arm64) cannot safely enable FP codegen
in arbitrary code.

Cc: Austin Zheng <austin.zheng@amd.com>
Cc: Jun Lei <jun.lei@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Rodrigo Siqueira <siqueira@igalia.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.h | 8 ++++++++
 drivers/gpu/drm/amd/display/dc/os_types.h      | 2 --
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.h b/drivers/gpu/d=
rm/amd/display/amdgpu_dm/dc_fpu.h
index b8275b397920..4e921632bc4e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.h
@@ -31,4 +31,12 @@ void dc_assert_fp_enabled(void);
 void dc_fpu_begin(const char *function_name, const int line);
 void dc_fpu_end(const char *function_name, const int line);
=20
+#ifndef _LINUX_FPU_COMPILATION_UNIT
+#define DC_FP_START()	dc_fpu_begin(__func__, __LINE__)
+#define DC_FP_END()	dc_fpu_end(__func__, __LINE__)
+#else
+#define DC_FP_START()	BUILD_BUG()
+#define DC_FP_END()	BUILD_BUG()
+#endif
+
 #endif /* __DC_FPU_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/os_types.h b/drivers/gpu/drm/am=
d/display/dc/os_types.h
index 782316348941..6af831710489 100644
--- a/drivers/gpu/drm/amd/display/dc/os_types.h
+++ b/drivers/gpu/drm/amd/display/dc/os_types.h
@@ -55,8 +55,6 @@
=20
 #if defined(CONFIG_DRM_AMD_DC_FP)
 #include "amdgpu_dm/dc_fpu.h"
-#define DC_FP_START() dc_fpu_begin(__func__, __LINE__)
-#define DC_FP_END() dc_fpu_end(__func__, __LINE__)
 #endif /* CONFIG_DRM_AMD_DC_FP */
=20
 /*
--=20
2.51.0.710.ga91ca5db03-goog


