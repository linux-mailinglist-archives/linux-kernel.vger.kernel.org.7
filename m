Return-Path: <linux-kernel+bounces-751628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7585BB16B9F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 07:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D32605824FD
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 05:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236761DF267;
	Thu, 31 Jul 2025 05:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h47x8iUP"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E9524336B
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 05:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753940211; cv=none; b=ItrVt6qEEw+drTq4hcVMDryHflgdi6GgXfyz6jqDaKZQqefioWp8nfNEafvWJVVfQhIAmlvYkSAw+BhB4nHSjvKy7sFAgkf0XZsTv0VzGwQJYO9a6TgI6dC/QwO1LTxVywKzfij7iAOuxoaVVfwP7m2kBlEcbtQXPeIILGk7vhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753940211; c=relaxed/simple;
	bh=Qf72vCrFpWA/LHVYHcKO+jvYrXE1Ym1za1XLlSRgDbw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WveKf4e8J6CnT8cHtRPmLHZZfdtxedmftdR2WOEky2hjS1tkZFlo8vAz3SqbSGJSxMNUsKTKjfxhprYmb4AECXDtg9xoVAnsJQUhrqzyHrSXOyWg7KkykDsD6+C6cB23OO6Clt8xCEJ6AdbJDfVDfvR1cPzIBDkLD4PE8FaG9nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h47x8iUP; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4563cfac2d2so4654715e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 22:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753940208; x=1754545008; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cYq6/WMdCGI3NVumhbssuyW0E52SNpXkJoe+qhP+t+w=;
        b=h47x8iUPlklMcMEpAoPRqvZs80qG2nUm4oJwAZ+5tAzMPfAyEkVZTcHLUDLeLRyc68
         +FuSFf9677Jldd8Gif0pK7i4EDnXpmxzGPUm0BcLfkyv4NNnwFENE82XFNcFrL1dhcds
         KTWCgzFqaLXC15vyjKZWtyBuEjie3ALdthtKsDZMTizEy07/EuNorcWHQt6A2+pkfK2F
         yLuoD2IaQ+Y6m7EYdQuy8zjFZdt4QOkaB1gjh7Z1ylMeOcNptNvlzemMWMkimgMxzWzX
         uWK0Ela+6HINpoqwHnWJTdrPi5Tz7jMQNP1KZMFE2u/aJKCwPomjEuo52HBOgE2PWexF
         yGCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753940208; x=1754545008;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cYq6/WMdCGI3NVumhbssuyW0E52SNpXkJoe+qhP+t+w=;
        b=sv6wK5eokPed6chXLNed737k66UM+CjuLRquDs9Gi/Ntzdlt+0GXH7ORG2byFMV0fJ
         V3P2yih+gv7xoblaB7bYDCrmYIK3lPT/ofXyHBrrGN3Rwv8Fpng/p4CsJYqq7a34OoIy
         zmA8W8r1Eb06FU1ju6Xg41/CbAtpxEj+TC8XCbp1xylS6BvJIW1vHWoOy4R0+KOBhX1S
         ek7imTOkclxNJI6BIaWEgkFXalQBBSI0T9ltDFSdFJSXBs9ZLlNbMa/6BpUlm2uXWOZW
         4CbyYdsLVkps9tKZkmhtkMN1jlasklndaMsha4RFp3Mj/xi6SClhL5py9Tvtgzkq3E5U
         urVw==
X-Forwarded-Encrypted: i=1; AJvYcCV2ei9rr9npJr1P1Phy8fGi4Z1fjrSgVggR9jRMIFGrv5Vr+3kwquPUtdYg8jCrOicqqwqyMeINo1kl1+g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2+q5Lz5nqBYYhOTcUKGVf3u1IVEAmLwWgiXkVyWgrBohFOJUt
	MCJkg3nBmiIIIvtPUAGS3uNRlmKp/KJCSPWQLdyekoqkQR2Tw9c6Rzjv
X-Gm-Gg: ASbGncth8L1briAebQapModBDBSdeZHjEhXGT6vuPci6OjM663+mwdprUmPn/0hEfB2
	aujRcGHiTrNwtytIih+BIqFNJg8/ktM0QqHdFTUFXutUUholhtJlv/9/shnBN6JOVGWhk3Ln4yq
	q6SQRFGM1jxfXUlde4ZGBvZCn2Ugdu3QYb8/zzDhPpphmbJAglWb+LhZ3T06wk5fDVKO0Hdesjz
	Fe7AiJhfDb/e3OnEsIsp6qNVAS/t7+p7ScsgUX4ZTAjXdVccd0WTCv+Nqi6WpSg0l9YsU7ujtrd
	xoCpwcfSwLy9nuO3+BseNqa9NAjqBkPZkAUBnt4fdi2cR6v16G1r7BpD3EhbLvgBpIrCuG42ktN
	vytfHPRVbvCmO8IMP7ShiIezo3olaEFenOlCvdvuBNhjD9lsaP+8yP1XHEuSf
X-Google-Smtp-Source: AGHT+IEp5VCzLJr0X68P0qy3TU0LoV0niMRhq9/WEWNUYlkHD0hdkBSjsI1HL68vgVh52+E/1wlU1A==
X-Received: by 2002:a05:600c:518f:b0:456:1d06:f38b with SMTP id 5b1f17b1804b1-45892b9da13mr49754965e9.8.1753940207960;
        Wed, 30 Jul 2025 22:36:47 -0700 (PDT)
Received: from [192.168.1.205] (dynamic-176-005-138-071.176.5.pool.telefonica.de. [176.5.138.71])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3b79c3ac093sm1149137f8f.9.2025.07.30.22.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 22:36:47 -0700 (PDT)
From: Philipp Zabel <philipp.zabel@gmail.com>
Date: Thu, 31 Jul 2025 07:36:36 +0200
Subject: [PATCH RFC 3/6] drm/amdgpu: don't query xclk in
 AMDGPU_INFO_DEV_INFO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250731-b4-dont-wake-next-v1-3-e51bdc347fa3@gmail.com>
References: <20250731-b4-dont-wake-next-v1-0-e51bdc347fa3@gmail.com>
In-Reply-To: <20250731-b4-dont-wake-next-v1-0-e51bdc347fa3@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>, 
 Philipp Zabel <philipp.zabel@gmail.com>
X-Mailer: b4 0.15-dev-a9b2a

Cache the xclk rate during amdgpu_device_init() and return the cached
value in the AMDGPU_INFO_DEV_INFO query.
This will allow to avoid waking up the GPU for this query later.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2295
Signed-off-by: Philipp Zabel <philipp.zabel@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    | 2 +-
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index e33c90c44697e..35827a0cca780 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -431,6 +431,7 @@ struct amdgpu_clock {
 	struct amdgpu_pll spll;
 	struct amdgpu_pll mpll;
 	/* 10 Khz units */
+	u32 xclk;
 	uint32_t default_mclk;
 	uint32_t default_sclk;
 	uint32_t default_dispclk;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 79d0ff0bda290..44a8fad60512e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4818,6 +4818,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	if (r)
 		goto failed;
 
+	adev->clock.xclk = amdgpu_asic_get_xclk(adev);
+
 	return 0;
 
 release_ras_con:
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 60f36e03def2a..190602bacbcdf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -911,7 +911,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 		dev_info->num_shader_engines = adev->gfx.config.max_shader_engines;
 		dev_info->num_shader_arrays_per_engine = adev->gfx.config.max_sh_per_se;
 		/* return all clocks in KHz */
-		dev_info->gpu_counter_freq = amdgpu_asic_get_xclk(adev) * 10;
+		dev_info->gpu_counter_freq = adev->clock.xclk * 10;
 		if (adev->pm.dpm_enabled) {
 			dev_info->max_engine_clock = amdgpu_dpm_get_sclk(adev, false) * 10;
 			dev_info->max_memory_clock = amdgpu_dpm_get_mclk(adev, false) * 10;

-- 
2.50.1


