Return-Path: <linux-kernel+bounces-754354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5803FB1932F
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 11:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CBB13B46F8
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 09:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D3F2877CA;
	Sun,  3 Aug 2025 09:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MmGcTE74"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A945317BA9
	for <linux-kernel@vger.kernel.org>; Sun,  3 Aug 2025 09:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754213203; cv=none; b=tz71MthcHKL3mqRNlX51NJgRdXKWY/b0ui1Po+8kLJFS9oCxfev/UDyqY2eqFPDtQ00GF/SCgv0bjQvRDsj5UORfxECNZOUPZetpxEKKRlQKSPxNY0evjoL8NXuQRrjWZj5skKMFSZVxGcjns8vrSPPWrqKx2PTz9VYDABruws0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754213203; c=relaxed/simple;
	bh=mnJWwDR4de8pGXdj39dEsaYVake3EvI/oEcfz5jnXJk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tUxW0saRfpXhJgmpgPvHDhVSpzslFy9ZRE9yainCtDy7A5Tw+WBMMqUxN0ulCujwGNIkEFPnB0Lio6tKks1HCYtSHcTAQ/+zaPhnYb6zEKsc9bsR2dmQtySwwS9t2HygNiQjwhB3QAEiXrhBtPq1oPIp8LPdezNo3rwy5Y6Bru8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MmGcTE74; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b4209a0d426so3734278a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Aug 2025 02:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754213201; x=1754818001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xf+CB48o0krzq5HXF8wTrlbGY9U2aGX2mTek/fztxU4=;
        b=MmGcTE74TAf4D9R1feL/KhEb6/a/eDDlD87IR03i+UQYVbJGHHfCyUcxlow01uf/zn
         xwTF+E6Ls/+3pWdUi9E+vb78NnThgCNIUeRQJoZ3IF6WuxvSMDfRbxekkGltLK4aW5Ig
         KMvZYeQRwz7vLfaeNpGRWBBRpXKY0WDq92u7hSIJtDYdWq+QJUS6YJy+6NFMNpfjr3K+
         ksuj766rRTEMejKEp6Z4uOedl1iSeS4hHKe6FkDXE4ry+RbfYBLzrmlFnXneVMsDxcKk
         mAj/ExCEvMri7j0ldZXdHZf7tQotM2SxiSb/ogPNs9S3k6x6X7omsW415LxSFdFFVj3Y
         5pDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754213201; x=1754818001;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xf+CB48o0krzq5HXF8wTrlbGY9U2aGX2mTek/fztxU4=;
        b=KffT/Nu27MeZhAktY+Nm5aQYfATKz6Lbomm7N0Xq3pn4iWlnnG4tD0eBXWaY2QeXAq
         GJ0y/QQ/tc8sACISIsft2hdsYLam3oOp6r4pr6giof/1GzFzaQ4OmWCuZLfeSO/YhVw4
         N1aAikTm1KulInhOgpxTs1ZmviPRepE+e+rt1bhJms6iQN51NJuZ5FVx2+wiA5Dvw3RM
         umPgLyC6FpVQRyIsMVZo/yJ903Rb23Z3j9z1pKJWhRfkPu9cIS5OH1Bpwfw9LwxRngkF
         4OJJEPYBO26aIdOns9ASvPJ8Ao6tdX74J2zyIzruXWauNcNCW6/uLSlh9K6YpkZz5uOS
         vpYw==
X-Forwarded-Encrypted: i=1; AJvYcCU/iLKUw+OG34lHCscHybHaJxa/xrxrnviBglLsSOi1xLqQyshMz4jaMmNXjblLlQqSl4tEljCQBZFC0W4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4CUHVUcrvYKyHSo8du20Sc8O7JQICEGzpi1Cs3PU1gR8pMS3+
	agtIe+VxQsByST4n3Acgxw2y3BTYPGs3tWHVrNGOTHV7nMkYZB51fJH8
X-Gm-Gg: ASbGncsliSL0O25jO+ri/SdCyQtFVPBvV4ZEIX7Xo9OA9zlyXhqgEtfKLcrjmMjix2g
	AIoW+vdEY6+U/SAQsw33TIHUiFZBN1DfDqefIFkiZ5P48eyRRmAGGE22AhLuUOPZOCAP61CJqF2
	F5mz4IbwAE/A3K59cXLAO9EVXO4aBqXfjzDEcaUoaBA+H5GR8zRyB5AVZ9/et22N32hTPviNmYd
	bUor1meUScDKRhMfM5q8p6SW1egsgHYTQJ5AaWAVkThHSze7XQ15vHw+r9PN6s5ZfVCKXjXAvg1
	LWW7fg6M+WTLkpuYezMFqS7YmZkAMweC5K0mRLGbSTG5t6Q2JTItTpaew6qdq/1My5uP/q9xIm0
	wUqQgcCBZ6CBWVW84T2IYm3XrMDoSg+mUOQ==
X-Google-Smtp-Source: AGHT+IFfWcED3Joe1pUA/sM9Vt4NU6PNW1ZV+CjXMBQyJNJMXMktKo40ISTWSvawGpK7dyzxPJDdKg==
X-Received: by 2002:a05:6a21:2d8b:b0:23f:f431:9f77 with SMTP id adf61e73a8af0-23ff4319ff1mr5785966637.22.1754213200742;
        Sun, 03 Aug 2025 02:26:40 -0700 (PDT)
Received: from server.. ([103.250.145.182])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfbcee7sm8017807b3a.66.2025.08.03.02.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Aug 2025 02:26:40 -0700 (PDT)
From: Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>
To: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/gpuvm: Fix kernel-doc formatting and typo in drm_gpuvm_sm_map_exec_lock
Date: Sun,  3 Aug 2025 14:56:15 +0530
Message-ID: <20250803092622.27532-1-reddybalavignesh9979@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add `.. code-block:: c` directive to resolve Sphinx parsing issues
like "unexpected indentation" and "definition list ends without a
blank line" during make htmldocs.

Also corrected a typo in the return section from "negative error codec"
to "negative error code".

Signed-off-by: Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>
---
 drivers/gpu/drm/drm_gpuvm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_gpuvm.c b/drivers/gpu/drm/drm_gpuvm.c
index bbc7fecb6f4a..fb46f531fe7d 100644
--- a/drivers/gpu/drm/drm_gpuvm.c
+++ b/drivers/gpu/drm/drm_gpuvm.c
@@ -2432,6 +2432,8 @@ static const struct drm_gpuvm_ops lock_ops = {
  *
  * The expected usage is:
  *
+ * .. code-block:: c
+ *
  *    vm_bind {
  *        struct drm_exec exec;
  *
@@ -2473,7 +2475,7 @@ static const struct drm_gpuvm_ops lock_ops = {
  *    required without the earlier DRIVER_OP_MAP.  This is safe because we've
  *    already locked the GEM object in the earlier DRIVER_OP_MAP step.
  *
- * Returns: 0 on success or a negative error codec
+ * Returns: 0 on success or a negative error code
  */
 int
 drm_gpuvm_sm_map_exec_lock(struct drm_gpuvm *gpuvm,
-- 
2.43.0


