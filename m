Return-Path: <linux-kernel+bounces-754174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E939B18F57
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 18:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E9583B9CC7
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 16:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D7C248897;
	Sat,  2 Aug 2025 16:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L9a4XyPv"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE06172612
	for <linux-kernel@vger.kernel.org>; Sat,  2 Aug 2025 16:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754151228; cv=none; b=VJ4UDpGshPSuJdjT0iG3l6iKj3dSMV4OI5mkilo/1tpSM0CJj7FfuPNOv3R3oTf0+dAfRTEUyL4BXXs6COoZQo4WD5elhawm22Oa57Q7K4ttJjXlBfdGH5T8y1pUZabfowUPUsnnvfbs4xr+euk46VflzeIY99vyy2agL31xuLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754151228; c=relaxed/simple;
	bh=626h5VedKAEDV7eF+j4gRWQ/EVh8EL1yFG4kycMiduA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dGdFfdrTpRJ/tLtPDtzlsWIGdtlCG3FVgw2RmLMR9zFhq9QF6umhiLabEV+ESitfy9qxnShuDZAq1oodGrIyU2NqkbE/S3F1vQsYMN80XYzRGmAUSOPggV4/FSANcq+k/v2zlV3y8KFrJChsO9XjvazUaHGztILRSzwCgBe3pXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L9a4XyPv; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ae0bde4d5c9so631214266b.3
        for <linux-kernel@vger.kernel.org>; Sat, 02 Aug 2025 09:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754151225; x=1754756025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WrDtMtgXDAh4aQCn1amCHGAxD2IuoC9BaP8lJI8ilpU=;
        b=L9a4XyPvXjkjZTZ5YfMPG2HeBGsuSkxiDv7fknba1ui8V2GrUT+dEBwR3sx0rtV8oT
         zTy6cqBO9BVa2pi8mY60F6nCeC007A5ZIPTLfgfzljyfjmoJuTlq60wsvjqQftzBIN62
         q3siGxKMbep9sXFR12ySQWwU9l/BZeeHG8fZ8SK0czp6hns2aYm1qAXoFipuTFaGO5RO
         MiUD49RkLQO7SFvJTFKRwTwW6Vm7KkUHVKzwAGdN1cMkTF0xcfBi2rXJ7DVagKlLOkDG
         4y+KTUxa9NOvVehCCIpGe0cu6UIcsV0XvD4LaaStlCmQVZg5C4SojXAPI2Ig99EDEfAo
         dofg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754151225; x=1754756025;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WrDtMtgXDAh4aQCn1amCHGAxD2IuoC9BaP8lJI8ilpU=;
        b=FUww2UD482LAFoE+vmdbn+H3iIUx7oxNDFtcFg8m3+3b0bBkVjmgaBVTS8xjgGtuJ1
         M8VkkjNxH06tnkKdoLNeusqe/CpUZmkoHjzOCRaF5ihoOQt9xctmSMeUTbfU8hIluL7+
         fK2e9Yw95WDVhZ/WmtlfUqPrJiT9yQhA3xsJ3aeBvOA2yVZwsdnjSqqvA/JJHOEclLmP
         wxdBM4gTAkxriWjeo3RLLoVxVoS2YfJeAD5kFuMOLsIt1OqMUJxo9pDmHjVjl1EtwLEF
         MHPyfM8BW/OQdScVy+g4tOBU+Wuj1d4WRxANK2Ie26fjukauaLUNB2/gBH6kXUgEqYJh
         k9CA==
X-Forwarded-Encrypted: i=1; AJvYcCVP7u9Nk63UNuVbZmYFuHHi4pbzrnbxD8zMn+QPwfxvmTlPiGy9CO+SyTfBiZxGp4u7Jhp7oQgBd33JVok=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBSjbQn0Eby/8s2dnl1C2fG2DPxUrKosektOch2klrakuY+PBM
	zmg4pvXsDKW4XTtpLmU3AMGI8ierCq0uTaul7qN8i0+/Hrh/55Pbcgvx
X-Gm-Gg: ASbGncsL+7O597oz9PA/t/ClLRjODtCsLObne+B1U/aq3TNNeYjb4wIcUoghXM1f/iZ
	hMBZqZSqJNkKT71YKGGJ5tyvAgxsuqXty/VP8RYOJ+QYHrIjqOTEK3j6uicW29lGHS7etkHoWJs
	xcujEsNvFJ5uVIH7x9Z0Odhi1pWR3kCPEIX0Yo89N2TmsGUUjYINu/1xhk7bHKCrcPj+UoKjOpH
	y+UiJ9PFBuSL1GlLQft5yS4kN+1H1CIWv6/vMAEtkm0Yz4CkCghXx3/qYEYks0nC2K03ZbVWEQN
	QnqIyhABmGvECNEX+P7SHbDC/RN98h87Ji56jJwU10rlAkV0s7OJedxgrGtftfROP0iTpgWynE+
	PqhjNGgp3w9r5kvdAALGqUbjhQ0seJi6R4XdTAq1moojffW3gVwM5N2iXo6TFCOTZ+bHjvx64Sz
	rp1xql4Ce7jh+Ipqvk7gSBNI5Ll+eEst2wHuKM8tK2jA==
X-Google-Smtp-Source: AGHT+IGJC2NvD6UQnMiSqb/7JcSyp9498E96SzuBdZPwGcfTuVGVWWGQmPas/UULbsiTpyd/ly6LoA==
X-Received: by 2002:a17:907:6d0a:b0:ae3:e378:159e with SMTP id a640c23a62f3a-af940062f58mr365236066b.26.1754151224871;
        Sat, 02 Aug 2025 09:13:44 -0700 (PDT)
Received: from hsukr3.localdomain (dynamic-2a02-3100-3a10-5000-2839-9355-6f35-74dc.310.pool.telefonica.de. [2a02:3100:3a10:5000:2839:9355:6f35:74dc])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a24370asm455456766b.128.2025.08.02.09.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Aug 2025 09:13:44 -0700 (PDT)
From: Sukrut Heroorkar <hsukrut3@gmail.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Cc: skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	Sukrut Heroorkar <hsukrut3@gmail.com>
Subject: [PATCH] drm/drm_bridge: Document 'connector' parameter in drm_bridge_detect()
Date: Sat,  2 Aug 2025 18:13:05 +0200
Message-ID: <20250802161309.1198855-1-hsukrut3@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

drm: drm_bridge: fix missing parameter documentation

The function documentation was missing description for the
parameter 'connector'.

Add missing function parameter documentation for drm_bridge_detect()
to fix kernel-doc warnings.

Warning: drivers/gpu/drm/drm_bridge.c:1241 function parameter 'connector' not described in 'drm_bridge_detect'

Signed-off-by: Sukrut Heroorkar <hsukrut3@gmail.com>
---
 drivers/gpu/drm/drm_bridge.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index dd45d9b504d8..387a3b6cda54 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -1227,6 +1227,7 @@ EXPORT_SYMBOL(drm_atomic_bridge_chain_check);
 /**
  * drm_bridge_detect - check if anything is attached to the bridge output
  * @bridge: bridge control structure
+ * @connector: connector associated with the bridge
  *
  * If the bridge supports output detection, as reported by the
  * DRM_BRIDGE_OP_DETECT bridge ops flag, call &drm_bridge_funcs.detect for the
-- 
2.43.0


