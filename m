Return-Path: <linux-kernel+bounces-844841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F60BC2E4E
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 00:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B13314E896C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 22:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2081FDE39;
	Tue,  7 Oct 2025 22:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FKy6Z7TO"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618171311AC
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 22:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759877167; cv=none; b=tSL7UDbijgkQbISgo+OVa/viD9ioFqrpQHNjTi1jvJ7AQu1yPHfW9LAXvmmkb1zt5g9FoRGJjfM1u436GvDONvOVYT8Hi3Wa3Lad79vjUqTX+3yG0IHxb2zYdWnzIb5mxxKf+D/TSV5ekjKMf5DKPMW+V/2/CVzglS4cA7qfjbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759877167; c=relaxed/simple;
	bh=BP5BC7EzLXQugEIJHSYipCCvb0wE77dIbogOUrPcw1U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M5Owc1DmX8sktU0xdpDd2G4OiHKVhTErY8HLjOrpIK/lStqDNDXANXgVFauJIwJhWvUpVpQY9ATvof9mcHCHkO3ZnmoqZkVHvZgGD6sBEnXp1gQiJidd+l3QCtOVBerp30GU+1tvkVRIN7+DKARXEeMFcUFpGE/O1GKGj/m16A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FKy6Z7TO; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3ee15b5435bso4096051f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 15:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759877161; x=1760481961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3pQQY2keBFswywTklmwxwyGGVpvzk59ZMACKy3TjyoA=;
        b=FKy6Z7TO/5Xye41HB41J+76kGZatkg5PaopBCvc3OSHOGGMqcy7yDcu1HH0KLV2DVh
         S1sAo8bIZUKkDml1f+aIynRXOVJO2JRU51XohY6rhCZJsl4KwreypG6W/XATn8qmmgPV
         8uUR3Ipo30F4ZNcdA17Yy68O+ZSrlYNodyBSPZhvucVB1Yspa4k1Zx8kcRc2+4xrr7T6
         j8xkfPXjVVbnIglPvMRmf3tCiH6/xkREGEoMwrsBPIVWXpeVNex8uoedH01Au4PSbOC8
         JFkAUeIkW+rd2CqpBUSHIbDn/nf+nAG6h0rBQMcTfxMfUK4ciBvqzPTPvBK6yk25YcYe
         dzog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759877161; x=1760481961;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3pQQY2keBFswywTklmwxwyGGVpvzk59ZMACKy3TjyoA=;
        b=mjKBTDFH5sQPeqMNTB2z8yEvKPngplke4KdeucsKWWAt9SxJrTSEKsdjXgrKtjb+YK
         AyqjrFNsbIPqXvxSAwwUwPSSfAJuthICJa8S4l/giydyrZ2OxfpGYpWKHFjNggYwswlo
         Byv1XUiduFS59cIvvwj9Lt+1al/shQoDjtC5i6OZIKHi2INK3QdHmMMI9XjAgw4yrKYs
         B9ge9dq4JlzeJXrduKJ5IZ/7h/Ys/IoGf/JsZQiUvbBgikDitfdAwz+VDIL7gMAbScMJ
         WO4+WRglx2AHqXsRlM5Vid7n+FlCnbuw6eqHXUK0xLw43QTmVLAp+c6iG0XoKg0g1i3c
         ohhQ==
X-Forwarded-Encrypted: i=1; AJvYcCURuDdFOEdgOIOcqo5nMjitKgXnMz/mJ3qWSreMSb2ALzYZtjD688AoYWPZ4W7IDauNWbZkGMLKBTmIbfw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc9ekJrzAZMgtyTY6jjMwpQkajRI/X37k+Dj8s+hZWdA3EQVn+
	arhQlU10sjj6rve1xpT8+l/TJ2x2D+JFWjqvoivwonW8ZSva0QKut++d
X-Gm-Gg: ASbGncu2wTGmzRy5we5g8h+VpOE2yhssMNFMd3L2vGpcL8n5Z/iqPznIT5C6SIHuxYV
	cbEhGrBOXYuuuUqN/0q0SGH1k2eiVU3qC+9AYQSltz/rv2XKaKLuQK+r9FX3eh/rtvH1ontSrYA
	OlGPFacE5PTsVOYhzdD6oOip39mwvHBr0cvUTviad56n3Sh6FWKLNJbeQSTDaPDkA2eRqe5bHb/
	1gT5kjbcmgJyouW0kYM/VycGk0fniRyKGpEpkL02Ec5qlO703WC0ikMBulp9LM90IelhGNIC3/j
	ISQOW6sK5UAN4HpGNh1T1yiGxLh7wZ5MyrlmzKzZyHoUFT926dr3eagY7WcOOt7py6mlS9kv/PC
	pkRwhleIX2LExO1qbT4SF9IeaznAlLsiDl4nNcrJpcG39CYwx/AmUjJa0eqiNohY=
X-Google-Smtp-Source: AGHT+IGpUoeWYYfKgtD3wk2UP4YLDCFnN42FiNw3j98CkNvoabTKCMcEKd8fM1WEcK58BkjWgmbiLQ==
X-Received: by 2002:a05:6000:1a8e:b0:3ff:17ac:a34c with SMTP id ffacd0b85a97d-4266e8e46b1mr536653f8f.59.1759877161371;
        Tue, 07 Oct 2025 15:46:01 -0700 (PDT)
Received: from ekhafagy-ROG-Strix.. ([41.37.1.171])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8f01a0sm26925335f8f.48.2025.10.07.15.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 15:46:01 -0700 (PDT)
From: Eslam Khafagy <eslam.medhat1993@gmail.com>
To: Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <siqueira@igalia.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Wayne Lin <Wayne.Lin@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Tom Chung <chiahsuan.chung@amd.com>,
	Dominik Kaszewski <dominik.kaszewski@amd.com>,
	Yilin Chen <Yilin.Chen@amd.com>,
	amd-gfx@lists.freedesktop.org (open list:AMD DISPLAY CORE),
	dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Cc: eslam.medhat1993@gmail.com
Subject: [PATCH RESEND] drm/amd/display: Initialize return value in dm_cache_state()
Date: Wed,  8 Oct 2025 01:45:44 +0300
Message-ID: <20251007224549.87548-1-eslam.medhat1993@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Initialize the return variable "r" to 0 in dm_cache_state() to fix
a potential use of uninitialized variable warning.

The return value for this function might not be a PTR_ERR, in casse if
condition fails. In that case we ensure predictable reutrn.

Signed-off-by: Eslam Khafagy <eslam.medhat1993@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 8e1622bf7a42..6b4f3eb9ce48 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3115,7 +3115,7 @@ static void hpd_rx_irq_work_suspend(struct amdgpu_display_manager *dm)
 
 static int dm_cache_state(struct amdgpu_device *adev)
 {
-	int r;
+	int r = 0;
 
 	adev->dm.cached_state = drm_atomic_helper_suspend(adev_to_drm(adev));
 	if (IS_ERR(adev->dm.cached_state)) {
-- 
2.43.0


