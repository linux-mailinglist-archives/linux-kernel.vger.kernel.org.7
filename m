Return-Path: <linux-kernel+bounces-751629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B623B16BA0
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 07:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC7DF1AA396D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 05:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6186224679E;
	Thu, 31 Jul 2025 05:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bd4Wi0nL"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC66245008
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 05:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753940213; cv=none; b=ZaQ0eLdKsHz/pDY/kowZderKyikyI8oR6HG1jCkIlFAuDHpYa6j4H5kLzQqmcCSH59c/e5MiEK/ZPZolXOT0i72Gp6/qwcchll4eGijio7vccoc3pg8M+sVKPRCCM6R0NSd025UtUu2l4cNglPv4N0YL/BCwOqLxcyvu1hM/gI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753940213; c=relaxed/simple;
	bh=Ao4pyMiEC9kkzAazsUh+aMjntp6mPoSWds/tlQrBDTs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Tk2RNF1u0ZLUoW82byd7x9k429txmA/3yYpCljLHsbboJsfUiQIMEKiT29Qh8PirLq5CiGS+veBdTB7gIGpkt1tZFeGGFRgMe+pwnhn6vxXCz8Ym3qG+6z1gjTFFUmT19R6hVLBLjYLDwr1vNkF7rhZ4eKgUJ2C5bvKDKVT0HV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bd4Wi0nL; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3b78bca0890so344942f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 22:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753940210; x=1754545010; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c1dd0Ga2iTCujV4ta9gqgLx9Y4mluBxA0AcKr2gNUmQ=;
        b=Bd4Wi0nLqxA4HMvMzvioi9Yq1AymrFIoEt+sv8/2OumnL0HRS7ULUH8abDU150faNk
         Q1bXSfGvxzsLzDvpX3RjMGlzGAVyUpNu/CZSCugSfs1pV1d0H6bjcbsaFmivUMEfapcx
         D6jguBp5hTxsKKByrJv3eC2qwAvwCin6pWvRqrC5JDVbWSQnAdGgltkD8hrCePqa6gGO
         yc1VEx9Ja8Fxp+VrMIqOpzd8ly+TNPE7jKzhbnnuiRTirJ1npLuSQd8XtZm2ToZPjKqv
         bm4bj1/Vc1Nqr1BfWtr0IfvsXvETmYtEsXKMNq6ER22ihO72PwgNV1rdcCscKy37P8TG
         D1YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753940210; x=1754545010;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c1dd0Ga2iTCujV4ta9gqgLx9Y4mluBxA0AcKr2gNUmQ=;
        b=qO+XyAI0pc11l8zFPKXfdUfRt6yhVRd1eqSnNH8dl2Vu8iy5INDgp8mACPJitFI5CP
         cgQEAqmacG09NNA4QjndDxDyY1V7j6moDaRHnA+cx8ZLsZVG4yzXdnM6DLGYAu1klbvd
         yrIPpygymkvGABRfKjOHp0KCzuLvmG3d/1Kk1O1JaEbYi/fJ9ZgR97fwNwWOLTUsZmkr
         zQIIrKNrnCRQShOX/O550qsnVkvVO45BPfXteWWcaWrrsdyZWwL92FD5o5VX+0F4jaO5
         UMUWckQh+FjkYFNsJt3fcAvlxPsUsaC6K3jApOzkkgBBrPlpT0lP+vuS+EtGbh1nkSCR
         OZdw==
X-Forwarded-Encrypted: i=1; AJvYcCXJiBI1KbzBqf5JGQuh+kpAYjVDPXWgk7KmNl+GjLOyhph+rPyVluvjmpfvlVCl6DwYkPcGPSzBK57kprQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX8Nw1v+8e+oO5j0116iyzaSbb5EOQ3KGqC+UUTqCqxKSpbgiY
	42p/FPAEa0MhVt5EVhL9uTxVT9FwHaLLO5nyN/vjL+VV66nM/bqsYXLu
X-Gm-Gg: ASbGnctGLtQJm6b1sQtprfrR8OTyT3wUACrGnDYIHjUuQtsX+F9+NjCWd3vFgYOebns
	5SHUlFN8CkDmFHiR0uJW7Plb/2y1oCsZJDlMBFVNgVoKddKR5V/kkvjjiLNAC26OdNZyAwJ/86+
	LarC03YY7tDqLyOA84X/QDQpsnqEHgQ8ahMuLibvTBsvwliADOMVZ1xZaJBCqCfL1fMbtTk6+8o
	0NvHNbJgNLnoPOekNqJbCm1C2iMRYooKurm2Bk4KaUtFkN1NJ46N1SIm5iRRlfpFIHgNtFIGlMT
	Dh4VO9/fN/LNpXjJJFwXhiQBdiNGbEFACuHrxMM0rx1WbmtpNyOFNqycKaROKSAkERRjh/6yI7V
	H+uIVmXU4ldAa6OKCXE7fnOux+/fF0USVaWYep7L5grStcvo1kYaLcUBgexuc
X-Google-Smtp-Source: AGHT+IGlIhfe1+ha/9LeqXoxdlGCP3fC0KLx/czzY6T8qRlm4KfCZ4cgQx6QeotUnn1aepuzecDbCQ==
X-Received: by 2002:a05:6000:288a:b0:3b7:9477:f4ad with SMTP id ffacd0b85a97d-3b794fe92c2mr4075356f8f.36.1753940209428;
        Wed, 30 Jul 2025 22:36:49 -0700 (PDT)
Received: from [192.168.1.205] (dynamic-176-005-138-071.176.5.pool.telefonica.de. [176.5.138.71])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3b79c3ac093sm1149137f8f.9.2025.07.30.22.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 22:36:48 -0700 (PDT)
From: Philipp Zabel <philipp.zabel@gmail.com>
Date: Thu, 31 Jul 2025 07:36:37 +0200
Subject: [PATCH RFC 4/6] drm/amdgpu: don't wake up the GPU for some
 AMDGPU_INFO queries
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250731-b4-dont-wake-next-v1-4-e51bdc347fa3@gmail.com>
References: <20250731-b4-dont-wake-next-v1-0-e51bdc347fa3@gmail.com>
In-Reply-To: <20250731-b4-dont-wake-next-v1-0-e51bdc347fa3@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>, 
 Philipp Zabel <philipp.zabel@gmail.com>
X-Mailer: b4 0.15-dev-a9b2a

Don't wake the GPU if the AMDGPU_INFO query doesn't need to power up the
GPU.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2295
Signed-off-by: Philipp Zabel <philipp.zabel@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 59 +++++++++++++++++++++++++++------
 2 files changed, 49 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 732f398922da5..79d31ac6a7b37 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2961,6 +2961,7 @@ static const unsigned int no_wake_ioctl_list[] = {
 	DRM_IOCTL_MODE_LIST_LESSEES,
 	DRM_IOCTL_MODE_GET_LEASE,
 	DRM_IOCTL_MODE_REVOKE_LEASE,
+	DRM_IOCTL_AMDGPU_INFO,
 };
 
 long amdgpu_drm_ioctl(struct file *filp,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 190602bacbcdf..fe1347a4075c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -732,7 +732,17 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 		return copy_to_user(out, &count, min(size, 4u)) ? -EFAULT : 0;
 	}
 	case AMDGPU_INFO_TIMESTAMP:
+		ret = pm_runtime_get_sync(dev->dev);
+		if (ret < 0) {
+			pm_runtime_put_autosuspend(dev->dev);
+			return ret;
+		}
+
 		ui64 = amdgpu_gfx_get_gpu_clock_counter(adev);
+
+		pm_runtime_mark_last_busy(dev->dev);
+		pm_runtime_put_autosuspend(dev->dev);
+
 		return copy_to_user(out, &ui64, min(size, 8u)) ? -EFAULT : 0;
 	case AMDGPU_INFO_FW_VERSION: {
 		struct drm_amdgpu_info_firmware fw_info;
@@ -873,6 +883,12 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 
 		alloc_size = info->read_mmr_reg.count * sizeof(*regs);
 
+		ret = pm_runtime_get_sync(dev->dev);
+		if (ret < 0) {
+			pm_runtime_put_autosuspend(dev->dev);
+			goto out;
+		}
+
 		amdgpu_gfx_off_ctrl(adev, false);
 		for (i = 0; i < info->read_mmr_reg.count; i++) {
 			if (amdgpu_asic_read_register(adev, se_num, sh_num,
@@ -882,11 +898,16 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 					      info->read_mmr_reg.dword_offset + i);
 				kfree(regs);
 				amdgpu_gfx_off_ctrl(adev, true);
+				pm_runtime_mark_last_busy(dev->dev);
+				pm_runtime_put_autosuspend(dev->dev);
 				ret = -EFAULT;
 				goto out;
 			}
 		}
 		amdgpu_gfx_off_ctrl(adev, true);
+		pm_runtime_mark_last_busy(dev->dev);
+		pm_runtime_put_autosuspend(dev->dev);
+
 		n = copy_to_user(out, regs, min(size, alloc_size));
 		kfree(regs);
 		ret = (n ? -EFAULT : 0);
@@ -912,7 +933,8 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 		dev_info->num_shader_arrays_per_engine = adev->gfx.config.max_sh_per_se;
 		/* return all clocks in KHz */
 		dev_info->gpu_counter_freq = adev->clock.xclk * 10;
-		if (adev->pm.dpm_enabled) {
+		ret = pm_runtime_get_if_active(dev->dev);
+		if (ret == 1 && adev->pm.dpm_enabled) {
 			dev_info->max_engine_clock = amdgpu_dpm_get_sclk(adev, false) * 10;
 			dev_info->max_memory_clock = amdgpu_dpm_get_mclk(adev, false) * 10;
 			dev_info->min_engine_clock = amdgpu_dpm_get_sclk(adev, true) * 10;
@@ -925,6 +947,10 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 				dev_info->min_memory_clock =
 					adev->clock.default_mclk * 10;
 		}
+		if (ret == 1) {
+			pm_runtime_mark_last_busy(dev->dev);
+			pm_runtime_put_autosuspend(dev->dev);
+		}
 		dev_info->enabled_rb_pipes_mask = adev->gfx.config.backend_enable_mask;
 		dev_info->num_rb_pipes = adev->gfx.config.max_backends_per_se *
 			adev->gfx.config.max_shader_engines;
@@ -1125,13 +1151,19 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 		if (!adev->pm.dpm_enabled)
 			return -ENOENT;
 
+		ret = pm_runtime_get_sync(dev->dev);
+		if (ret < 0) {
+			pm_runtime_put_autosuspend(dev->dev);
+			return ret;
+		}
+
 		switch (info->sensor_info.type) {
 		case AMDGPU_INFO_SENSOR_GFX_SCLK:
 			/* get sclk in Mhz */
 			if (amdgpu_dpm_read_sensor(adev,
 						   AMDGPU_PP_SENSOR_GFX_SCLK,
 						   (void *)&ui32, &ui32_size)) {
-				return -EINVAL;
+				ret = -EINVAL;
 			}
 			ui32 /= 100;
 			break;
@@ -1140,7 +1172,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 			if (amdgpu_dpm_read_sensor(adev,
 						   AMDGPU_PP_SENSOR_GFX_MCLK,
 						   (void *)&ui32, &ui32_size)) {
-				return -EINVAL;
+				ret = -EINVAL;
 			}
 			ui32 /= 100;
 			break;
@@ -1149,7 +1181,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 			if (amdgpu_dpm_read_sensor(adev,
 						   AMDGPU_PP_SENSOR_GPU_TEMP,
 						   (void *)&ui32, &ui32_size)) {
-				return -EINVAL;
+				ret = -EINVAL;
 			}
 			break;
 		case AMDGPU_INFO_SENSOR_GPU_LOAD:
@@ -1157,7 +1189,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 			if (amdgpu_dpm_read_sensor(adev,
 						   AMDGPU_PP_SENSOR_GPU_LOAD,
 						   (void *)&ui32, &ui32_size)) {
-				return -EINVAL;
+				ret = -EINVAL;
 			}
 			break;
 		case AMDGPU_INFO_SENSOR_GPU_AVG_POWER:
@@ -1169,7 +1201,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 				if (amdgpu_dpm_read_sensor(adev,
 							   AMDGPU_PP_SENSOR_GPU_INPUT_POWER,
 							   (void *)&ui32, &ui32_size)) {
-					return -EINVAL;
+					ret = -EINVAL;
 				}
 			}
 			ui32 >>= 8;
@@ -1188,7 +1220,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 			if (amdgpu_dpm_read_sensor(adev,
 						   AMDGPU_PP_SENSOR_VDDNB,
 						   (void *)&ui32, &ui32_size)) {
-				return -EINVAL;
+				ret = -EINVAL;
 			}
 			break;
 		case AMDGPU_INFO_SENSOR_VDDGFX:
@@ -1196,7 +1228,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 			if (amdgpu_dpm_read_sensor(adev,
 						   AMDGPU_PP_SENSOR_VDDGFX,
 						   (void *)&ui32, &ui32_size)) {
-				return -EINVAL;
+				ret = -EINVAL;
 			}
 			break;
 		case AMDGPU_INFO_SENSOR_STABLE_PSTATE_GFX_SCLK:
@@ -1204,7 +1236,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 			if (amdgpu_dpm_read_sensor(adev,
 						   AMDGPU_PP_SENSOR_STABLE_PSTATE_SCLK,
 						   (void *)&ui32, &ui32_size)) {
-				return -EINVAL;
+				ret = -EINVAL;
 			}
 			ui32 /= 100;
 			break;
@@ -1213,7 +1245,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 			if (amdgpu_dpm_read_sensor(adev,
 						   AMDGPU_PP_SENSOR_STABLE_PSTATE_MCLK,
 						   (void *)&ui32, &ui32_size)) {
-				return -EINVAL;
+				ret = -EINVAL;
 			}
 			ui32 /= 100;
 			break;
@@ -1238,8 +1270,13 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 		default:
 			DRM_DEBUG_KMS("Invalid request %d\n",
 				      info->sensor_info.type);
-			return -EINVAL;
+			ret = -EINVAL;
+			break;
 		}
+		pm_runtime_mark_last_busy(dev->dev);
+		pm_runtime_put_autosuspend(dev->dev);
+		if (ret < 0)
+			return ret;
 		return copy_to_user(out, &ui32, min(size, 4u)) ? -EFAULT : 0;
 	}
 	case AMDGPU_INFO_VRAM_LOST_COUNTER:

-- 
2.50.1


