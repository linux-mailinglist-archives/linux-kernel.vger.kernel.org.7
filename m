Return-Path: <linux-kernel+bounces-854769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B381BDF561
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 17:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8674188E4A5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 15:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FFF92FD1BA;
	Wed, 15 Oct 2025 15:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a+JZSOvC"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391772FCBF0
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 15:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760541973; cv=none; b=LUtkdBivTPlqDAkj+7KRTae6CzFE+P4b6U1ZuDl68vr1teKtfWE+7Cvtznq8ZE5h/nXj8oykKZuWUIU0BmIqGvLGECL9wQdAbL8rE3U16WOUXj/8kMggNrYFMTGlyGuHAW66+FcGvELNFSiUlXra7I4KoCll8e9hRA/qZku/5yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760541973; c=relaxed/simple;
	bh=c+xJXWz8nJ7TMLjQLredolSTZfMUIhKuR0ZiBPNE4zo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ujjVLKSFiACYGNk18KWVjavYreIy597rPdX4dzR/9OUNl2Fb+FBChJUXofc/JSv48wkK+QKEOGkD7+lJl9g5Ev7K07kfJXNTiScqX02g2/mQDkpaASafrqmdUuG9bTDXmFbo4Rz/5GgKf6VBBgXU31ceJvoin/sUglO6ZDiWNAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a+JZSOvC; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2907948c1d2so30199495ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 08:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760541971; x=1761146771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7O0CpM0/C7Le3z3rkyQRvc1X6MxZb/suwRe01ONJGns=;
        b=a+JZSOvCvUhqur86lnCX/r8JqHh74bbQ/kOuxspcqlRuDAgiv28p8BiATZH444tFn9
         sU71kvQ1mS2eQw1u/cfN8jD5yCfNKKT6ndzOMj6vut7NixFwDcDgpoG4FkYIDOFLqTv7
         qAjNXP1j8yzPaYLMTwk1gPAhy8Jr443yXHTs9sL+m8ZQUxOXHqtPcl+AV8CC5gA1pM1I
         diZxB0c5P7CORBFFrmEYB4K68ogLpJQzLJNdc9RDD4ImXT8ScWFEK0gfcKzE24nUpz7s
         bT3iSxNveccDbpBCKIc4d7JHha2eVPXtViI8sxLEUkSSvaHDeJP/6URemmO7kPWOEkV8
         G0zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760541971; x=1761146771;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7O0CpM0/C7Le3z3rkyQRvc1X6MxZb/suwRe01ONJGns=;
        b=ckjvCoDgJeMhZYwiOSQmDnY133bUi38MW7+WtsLQ1Zq6r+zUpKapcTD+JcfbrBjPpN
         8f7EoYWGRDUjvp2d0Bb2mNbLnWAkr2ep6YbDqEjp98/w9OCl+BzRzecmF0rXZ1Lz/Kj/
         svbyUV/9zS7xt0u60U8K5UTT7tzcY/YQEzXsJhMtO3blw7rkQJifVT5Va6HYDJlbcBT7
         rGU1sFpSUbRZII6TIrzc2sOUffb0V6JFR9OFsKH4oJFh0fZJ7b57d9spHNpRHcP1aLBg
         nz7ysl2aUaNuReEoWNP/Rw3N129Ihrj1ALzMgs//FTYpUA82XT5kcip7h/JTsibgNgAz
         0JdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVY3DRh5MCrxSs0A3/jHf8rCSCKR5nthte4vueDQFYp+9bJ5gpAwmmvVjeyFb+PPWzYggkU9CSY8Eg0yCE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyAhTRnLiSVJ1AFX/D7GoO4A9LP7admqBVjHP0mefkEYGfCf3G
	rlATDSYFyHn737uhVlYtBL4RaWOjd+RVYX5GSW3TnkgDP+aCoaczWEtI
X-Gm-Gg: ASbGncvPV1cvjF9up4btfP6dGJBWTIaC/i/0Z6ZWbptMJ5dZUeQjLHfjRDBgg9rJtP2
	w4R7MCvk2aUzPySFqk13lKBEtFvF6LQdPhHwr+2zMOiAy/Ua1YPE0uX+pJO4ldsTuaPB8rl1wUx
	Wn8eSie8iSZ+HpXO43XbB6U8tosZF96syqiwe52o5KEf6fQqG1T1uAhhfPZdNmSJzEP938X84Zs
	baBcUsq4BV4ye237GeoMzMO9yBXY6v1Scjyn5Ndts4N53AySXUJ8dgXyl8NI/q/XcncrwmgDFGo
	W1V5N2ZysFJ9tpA/bOe2PhEeguGWvlfUBmp41roJVtPoNF/DWFLjfea3KkM4AHmiY4ROeflGRnV
	f2vHxU6wV5kO+mB9csjiGlTkCb5KVmBKDOEvzsYOtzCUE+WA=
X-Google-Smtp-Source: AGHT+IHPNdtXsGrKiyWshln4Wfw606m9LZSh9VEYZ8OFWOsKMEwpo9QsS2xbGC5lMHJGNcWMCYwM8g==
X-Received: by 2002:a17:902:cf11:b0:269:7c21:f3f8 with SMTP id d9443c01a7336-290272b498fmr337396675ad.39.1760541970803;
        Wed, 15 Oct 2025 08:26:10 -0700 (PDT)
Received: from tixy.nay.do ([2405:201:8000:a149:4670:c55c:fe13:754d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f05c2dsm200607325ad.73.2025.10.15.08.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 08:26:10 -0700 (PDT)
From: Ankan Biswas <spyjetfayed@gmail.com>
To: bbrezillon@kernel.org,
	himal.prasad.ghimiray@intel.com,
	dakr@kernel.org,
	matt.coster@imgtec.com,
	robin.clark@oss.qualcomm.com,
	matthew.brost@intel.com,
	aliceryhl@google.com,
	thomas.hellstrom@linux.intel.com
Cc: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	simona@ffwll.ch,
	skhan@linuxfoundation.org,
	khalid@kernel.org,
	david.hunter.linux@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	Ankan Biswas <spyjetfayed@gmail.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH v3] drm/gpuvm: Fix kernel-doc warning for drm_gpuvm_map_req.map
Date: Wed, 15 Oct 2025 20:50:57 +0530
Message-ID: <20251015152543.24368-1-spyjetfayed@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel-doc for struct drm_gpuvm_map_req.map was added as '@op_map'
instead of '@map', leading to this warning during htmldocs build:

WARNING: include/drm/drm_gpuvm.h:1083 struct member 'map' not described in 'drm_gpuvm_map_req'

Fixes: 000a45dce7ad ("drm/gpuvm: Pass map arguments through a struct")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/all/20250821133539.03aa298e@canb.auug.org.au/
Signed-off-by: Ankan Biswas <spyjetfayed@gmail.com>
---
Changes in v3:
-  Addled Closes tag in log

Changes in v2:
- typos fixed 'map_ops' -> '@op_map', 'map' -> '@map'

 include/drm/drm_gpuvm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/drm/drm_gpuvm.h b/include/drm/drm_gpuvm.h
index 8890ded1d907..476990e761f8 100644
--- a/include/drm/drm_gpuvm.h
+++ b/include/drm/drm_gpuvm.h
@@ -1078,7 +1078,7 @@ struct drm_gpuva_ops {
  */
 struct drm_gpuvm_map_req {
 	/**
-	 * @op_map: struct drm_gpuva_op_map
+	 * @map: struct drm_gpuva_op_map
 	 */
 	struct drm_gpuva_op_map map;
 };
-- 
2.51.0


