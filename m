Return-Path: <linux-kernel+bounces-869098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0561DC06F0C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 17:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 22487346E8C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 15:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98D332A3EB;
	Fri, 24 Oct 2025 15:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="XDDcaUw0"
Received: from relay10.grserver.gr (relay10.grserver.gr [37.27.248.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C11325490;
	Fri, 24 Oct 2025 15:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.27.248.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761319330; cv=none; b=u+4ItG8PCQvhR6iWm4UfFhN3Op+Rkf2WICIE9TNoHSMOYb/ICGVRz2fBeqITUqXZPIHItgeNjPpuVkddQKq1+v2IJFkNwWXr246MayFy0SwKZfG9JDy/VqLl2oW+bmM0IqoWb8isCN4Vkl+moaGwGkRh/TZuq1b4/LoRx8GfFZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761319330; c=relaxed/simple;
	bh=2TdACTndFvL6+kmkl3YLG90I0fJ7jKitHIvdS6iaiXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D0nhfo0gBVNftNNkun5LZxMj7XOFkIFqiCfuAG6qZwkKy6YGy94FVVmNMFchQHuKbmM3UTjOCWrdgX/jkM3NatZtrRTD4s6uimw6mKGqPF2x2ocY6yLHOH3kMdnX8SA79nqIKMOz2fssS/KipUmdsfaTyDUYezIbM0p7CvwpHTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=XDDcaUw0; arc=none smtp.client-ip=37.27.248.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay10 (localhost.localdomain [127.0.0.1])
	by relay10.grserver.gr (Proxmox) with ESMTP id D0AF046309;
	Fri, 24 Oct 2025 18:21:58 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay10.grserver.gr (Proxmox) with ESMTPS id 0B2BF4630C;
	Fri, 24 Oct 2025 18:21:58 +0300 (EEST)
Received: from antheas-z13 (unknown [IPv6:2a05:f6c2:511b:0:8d8a:5967:d692:ea4e])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 1C73F1FF3B7;
	Fri, 24 Oct 2025 18:21:57 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1761319317;
	bh=spsglYgimcjKwr6ZwOdpCum8Zdo4KCEeTND/G6yrqnM=; h=From:To:Subject;
	b=XDDcaUw0K6REBNmirYfF4dAK3CUohzCLdCrJBgWBS/udhsmWE8Xnj3RzNdksgZyVm
	 wSgXcCYm2fjBlkW92DTl50ML5iAR9c+BPbQYF20OZaLxYU2FyK3b3Zx3fG6M086Eok
	 JzrykDp/yg+6gUeTvHfkDQCW1OzTce0fJdECRTpCoXc709/XEp1t9/nwIqjSkMquhZ
	 O6gE2D0WWCNdYbGyqkBadjdNb0aO9G0KJe3A0UZWvczuBKV9cA4cZ/gXONoWt0kP3A
	 xPFVL0MsTInBSfwoaBL/1v+zkhvY9GHsKN/yXPh80LZF0lnTzDFnveeO5r3tpaUafv
	 bSTa/gRivq1Qw==
Authentication-Results: linux3247.grserver.gr;
	spf=pass (sender IP is 2a05:f6c2:511b:0:8d8a:5967:d692:ea4e) smtp.mailfrom=lkml@antheas.dev smtp.helo=antheas-z13
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
From: Antheas Kapenekakis <lkml@antheas.dev>
To: Alex Deucher <alexander.deucher@amd.com>,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	Antheas Kapenekakis <lkml@antheas.dev>
Subject: [PATCH v1 3/3] drm/amdgpu: only send the SMU RLC notification on S3
Date: Fri, 24 Oct 2025 17:21:52 +0200
Message-ID: <20251024152152.3981721-4-lkml@antheas.dev>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024152152.3981721-1-lkml@antheas.dev>
References: <20251024152152.3981721-1-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <176131931758.2356119.11738767784012382444@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

From: Alex Deucher <alexander.deucher@amd.com>

For S0ix, the RLC is not powered down. Rework the Van Gogh logic to
skip powering it down and skip part of post-init.

Fixes: 8c4e9105b2a8 ("drm/amdgpu: optimize RLC powerdown notification on Vangogh")
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4659
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Tested-by: Antheas Kapenekakis <lkml@antheas.dev>
Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c       | 8 +++++---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c        | 6 ++++++
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c | 3 +++
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 3d032c4e2dce..220b12d59795 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5243,9 +5243,11 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
 	if (amdgpu_sriov_vf(adev))
 		amdgpu_virt_release_full_gpu(adev, false);
 
-	r = amdgpu_dpm_notify_rlc_state(adev, false);
-	if (r)
-		return r;
+	if (!adev->in_s0ix) {
+		r = amdgpu_dpm_notify_rlc_state(adev, false);
+		if (r)
+			return r;
+	}
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index fb8086859857..244b8c364d45 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2040,6 +2040,12 @@ static int smu_disable_dpms(struct smu_context *smu)
 	    smu->is_apu && (amdgpu_in_reset(adev) || adev->in_s0ix))
 		return 0;
 
+	/* vangogh s0ix */
+	if ((amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(11, 5, 0) ||
+	     amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(11, 5, 2)) &&
+	    adev->in_s0ix)
+		return 0;
+
 	/*
 	 * For gpu reset, runpm and hibernation through BACO,
 	 * BACO feature has to be kept enabled.
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 2c9869feba61..0708d0f0938b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -2217,6 +2217,9 @@ static int vangogh_post_smu_init(struct smu_context *smu)
 	uint32_t total_cu = adev->gfx.config.max_cu_per_sh *
 		adev->gfx.config.max_sh_per_se * adev->gfx.config.max_shader_engines;
 
+	if (adev->in_s0ix)
+		return 0;
+
 	/* allow message will be sent after enable message on Vangogh*/
 	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_GFXCLK_BIT) &&
 			(adev->pg_flags & AMD_PG_SUPPORT_GFX_PG)) {
-- 
2.51.0



