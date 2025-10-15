Return-Path: <linux-kernel+bounces-854404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B6167BDE498
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 13:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5240335741C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 11:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E04032145A;
	Wed, 15 Oct 2025 11:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZby2yUG"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFEE32145D
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 11:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760528242; cv=none; b=puPaopc/29hJPEblpsB2TNoNQFajlPySOOSlaABf5s8yX7lJwx5nesRs0Yf3QniHau/uA65WNSImZa8NiMViShNd/6NHrf9KLdNml8u7Ro1aCgkx33rdUQdkkWlFfOsqm1V9ft1S6tIi28sYbZuJPECgc2eLBP6/YwdxAyDhAec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760528242; c=relaxed/simple;
	bh=c4aYKS54E8jqERLS+NN4OOzQlB4QxsJ61mU3bGEwygc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dyfo7L4ExSmV5/M9AKFZTWbvXt55XdXEZi/NkYxa1jXUDXPKCKrFq0L/TQglA2g3DdSy4OwYUyCXvIIef2cS1NPLLUGf88yUBV3oPMGPUzrVPKMatj1kHgyqKuEcrn/DRblpWqMHnxdigh4Zn7XTP/HOFxWDpUx0oegoid+3vBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bZby2yUG; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-77f5d497692so7809640b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 04:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760528240; x=1761133040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x9r7lDMOBshgk2OBbZUZFD3lZ/ikkhF8KUnZZ8JlQI0=;
        b=bZby2yUGZFBNTX+JNU581DM2IYjqqiMJdD+65uG6APsJYyrYyykoO2FwV9UpO9cBKD
         J0qIXunmMDbhmkGHKV3G8eRXNSulrhki8pxarKt3B1FSmfu8W3pvDqL/IiF12YI0jUQt
         GQ+wQrQBrXwOaRVE0c0yZa4wy25ArXEQA72+DjfOXCI0NkbCqqdSbRTTy+r7duQG8zUq
         mDBCxNpjj3IUMPbG7kOt5/EFGUwmoc6RwBWc6fPfGp1k/0XoOHBs7kmhiJoDCr8DPQ8i
         pcfg0WC8TZgTy1VfJIcAxHEwykTEC/7LMYC+hAYZ/9WxQiQR4SuKKBQWWbpJ/0NjMzge
         99oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760528240; x=1761133040;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x9r7lDMOBshgk2OBbZUZFD3lZ/ikkhF8KUnZZ8JlQI0=;
        b=KKK7uWQqzz1DcEcAwdFBgEFuAhgg5EB1GODpIA9OmEN4e6w3n3jvhfW7j1etxovURo
         m0BWH5Gh5fsmwtwBix5PY5tbaGUQbDCopj3vF6v5eG10j/tCu5DgBpEMeShcKe80+ztJ
         MF2HaSBRWSMz1OqvGx8W0F1TOX9Rgeuy5vCEuEqKqC/j/MGHDGX9l+711NrxRsTPhFh5
         l0A0LC2VHiD1/LDDvo8qz7tFSEr7T+vpXCoZFpzxhJdlpJPAenbLLQ4fHZoIMFC3c73p
         DcDOE0s9ND32tEYU0nP7vhDM/ZbAxnIdwOIzzCAwHcJ9qtfiEgoRMn2ygoOr87fWJNyq
         xrEg==
X-Forwarded-Encrypted: i=1; AJvYcCVmheeo7xSOo+rtN9Vq/vHx8+vUmF7YMwA9/Fw3tc5+ERsxnuh90v0CtdBAx3tAhVUfQQtD9qw9fiXInUk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvGtgdWYQbmFjiBE8lXvLMGFDIyYPJ6vTcjuuoXDZM/yI9nQWa
	i4WOoS/K6jnLjGSkfHiEsHrNxCUP0whFI9kbw+Ond8rUfyo8pXczA48eWgI3R8jfZj0=
X-Gm-Gg: ASbGncuSpjtma48rsxrHDhqh6Bc4N07phyz4vYDOcz76UjCTwxQ4fU0as2VkCbcqCEG
	k5QrF7NApWunNxAiUctiBX4k7HFghui62vbCDkcMboEeIXor4ExC8g03fy98ZCOH+ZFPzSpXRsu
	P4VQU9oN60An/wFYxtF4HwX6v4W2VsMFN1/iYcoFbiacwEC+iH4Mn50oer798oTapPt0gSzx2Sz
	oQstDVmR/bkVkxLn+zHwwb5N467x0DsjPdhI1Rfkvq+pw6jthGUgLNGJcRvkH4zAHo6kHqa/TKq
	AwZWwtqB5BHl1Uoq9q1xJgvX4/mD4trcfVxdEJEGlLS3+3S/MFukFVJP3SlweE1jJpIjdX7rXLA
	X95204FfLh14lbvIXx0fGCV25pRtdLZGxK4KV6yDBiCueJZMgkFWPA6KNQQ==
X-Google-Smtp-Source: AGHT+IF/kMdSW2mdiOvPmOOpT6ZAXFjqWzHKAwJiaUVYsXOzqJQMewVct8CF0Jj3G4kE299bLT4akg==
X-Received: by 2002:a05:6a00:a0a:b0:781:1920:d12d with SMTP id d2e1a72fcca58-793858fb6dfmr34996835b3a.12.1760528240330;
        Wed, 15 Oct 2025 04:37:20 -0700 (PDT)
Received: from tixy.nay.do ([2405:201:8000:a149:4670:c55c:fe13:754d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d0e3f89sm18115540b3a.66.2025.10.15.04.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 04:37:20 -0700 (PDT)
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
Subject: [PATCH v2] drm/gpuvm: Fix kernel-doc warning for drm_gpuvm_map_req.map
Date: Wed, 15 Oct 2025 17:01:23 +0530
Message-ID: <20251015113656.21447-1-spyjetfayed@gmail.com>
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
Signed-off-by: Ankan Biswas <spyjetfayed@gmail.com>
---
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


