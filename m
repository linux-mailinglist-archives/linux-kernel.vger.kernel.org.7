Return-Path: <linux-kernel+bounces-759135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 377C8B1D907
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 15:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 253881AA40E6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 13:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF52B25B663;
	Thu,  7 Aug 2025 13:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="lv4s07jF"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE9D233713
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 13:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754573295; cv=none; b=Y5huT+06MhEBWeQwGr4cLbdliyDPoP7N7LH4cCLlCHtOKX4tcrwXpXYPPl7vm45HOPLNXA5gIf7K6jdvnMv6LpSNqx/HRrCf4EAJyCSOpf656sxhSYOONXsxrCrBe/xRZX+7vfdqDBBY9181K4WkEmRYG+mBda5jJ6td/alx7KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754573295; c=relaxed/simple;
	bh=9KwuCCE2n8n+3IcCq8a/1kcQGcdMhrefbW16UIaKUUg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XREXbRoMR8cLtAIafv9PxiRwXNwDcDRisjPrZOORpjDZ0rS7vNyF63mkGJp3WDnbymVP6T/CNSN8nLlc1mp22hS+Aw2+WypknG/LiLO3cBSNQFzWXzXKeS7Psd7n6dwLkZDR6cjig4Uburhj9QzQLrQJ9JjQ++01RqBid/4rWyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=lv4s07jF; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-459e72abdd2so5791095e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 06:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1754573291; x=1755178091; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S9NhIkmh6pa4LMtXboVJCwnuCZbZ5X3r44AzxS4gd7g=;
        b=lv4s07jFPB7JxkELnoMDyjosH7oPVikCwC9vFkQlNou3gdmAu1fkZ7uF+9yz5AGP4f
         UnZW//PvtlVq7zoAe5r1VJacn3CTAdHWysMos12IxkkJbHj5APCGqZCtf3Hho77B2ah+
         wDrJ6aNheP8eF1i5IdjCkrYaQYLAcncn5L9LJLYn9SP5PaPLuSvxkfnfAuMntg+nReMB
         w5fl7FcSqK7SgeGvbXwBvyrRdlL3zZ+MZpyiKV5LYcymVzO4TmFsD4Ax9kHfitIG0wld
         gLKuahUYb/o/uieo6QUzr9HBTfeTdt2/ekEC1sgjsB8UXeA/DYGdpIlXKaWftixxn7Tq
         clWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754573291; x=1755178091;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S9NhIkmh6pa4LMtXboVJCwnuCZbZ5X3r44AzxS4gd7g=;
        b=BaxkwA05CDLFg2MgZL1vEGhcWLWYaA2UTraz6xpcbKOOXY0BqrCnPmGXs7FqKuVMiK
         3E528u8zUA++dF97ERVHm/UBl7iPzP3hNymavD1GvjM7NPb1ZDb9mYe0pRIUv1c2YvdJ
         2/+rmnCFylrov+CXJheSs6dsTMntXSi4TVRgXsqFtsN6sAyHiwsDYM2scuVRYEH0gWEu
         2jdt/XPrb6bhwgs+2mHCrxNfwBaPY8cBZRFP9XdKcb7PfZayqYBwCS3gG9xPYpfTbnsr
         cp323oJUPwhNmVsuBKL4kZj8IEBfvlKmez/hi4ierhYVpGgq5v9OYUMA+AG7CA47d78w
         7Gyg==
X-Forwarded-Encrypted: i=1; AJvYcCWCgcey2RLjTyKeBs8j4ikxCpswJO5oK9hLP8Y3pQuAPeo42UxXl0NSq2tWfDKz54rN0GY/yZj0SofnWco=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd6SGd7R9qkS+bxySZ2YjV9p4P+ge8Djl9Osiy2m3MsZQIM3ra
	pV+/mLgF8Hb/WQHJsDM/5P6t12xtHY/98Wpu8vZNhfLCMsC8G7SUzDoteL1IGj1C4ZI=
X-Gm-Gg: ASbGncvtsPo70QXmS/7qi+Dkg6kBO6sVCKXaGe6ud94CW+mGECkJBncAFl9bfvclDSi
	b/E1z07YR4X9xYjYi6hqqSH/zD/9wTghGVuGYpo9LjuHAYqVJGVcCb0r8+hlwlWo31XxwKsqF2j
	sLxCe8wp0KYJfy2oRNsHQRs1V8tyeXWkya4wiF3Vsx+Xn97AeEmOCs3ZA6HdPhy6ZE78T+B11k2
	QTIQghyDLZfgqYEwNCpLGOGa1PRpyuEObsVt0wTHnxxdGzAafjp7dyWzDDiEs9OZgyKUsYtuvyr
	DJmpFEqlJBWSVjDcI1MzUb7i474WvhLda+mIddxSc1DUo+mBIpk1lwUX6EZnCa+7wZ/Q6NmOpxl
	E1NMCn6ReLfdn5A==
X-Google-Smtp-Source: AGHT+IFP5gGyK67ezPZUVxGJG8n6WwFpHK9eRMOuh7S6Y+Uq3tIIh1ArW3G3UuUlE5XlffAyaWQvhg==
X-Received: by 2002:a05:600c:3109:b0:458:bd31:2c35 with SMTP id 5b1f17b1804b1-459ee8721c3mr25230775e9.25.1754573291068;
        Thu, 07 Aug 2025 06:28:11 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:1098:3142:e::8])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-459e6dcdbbbsm38337875e9.7.2025.08.07.06.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 06:28:10 -0700 (PDT)
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Subject: [PATCH v2 0/2] drm: vc4: Add support for additional 10/12/16bit
 YUV plane formats
Date: Thu, 07 Aug 2025 14:28:00 +0100
Message-Id: <20250807-drm-vc4-extra-formats-v2-0-fadc93844551@raspberrypi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAOCplGgC/4WNSw6DMAxEr4K8riuS8ild9R4VizQ4xQtI5KAIh
 Lh7Uy7Q1eiNNG92iCRMER7FDkKJI/s5g74UYEczfwh5yAy61HXZ6goHmTDZCmldxKDzMpklonL
 1jZqqU9YqyNsg5Hg9va8+88hx8bKdN0n92n/GpFBh0zpzL+sux/AUE8ObRLbAV+sn6I/j+AJBh
 gajwAAAAA==
To: Maxime Ripard <mripard@kernel.org>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Robert Mader <robert.mader@collabora.com>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>
X-Mailer: b4 0.14.1

We'd been asked if the S01x YUV formats could be supported on Pi5 as some
software codecs produce them.
The answer was yes, so this patch adds them and the P01x formats.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
---
Changes in v2:
- Swapped from adding an extra bool hvs6_only to having a min_gen for
  each format (suggested by Maíra)
- Link to v1: https://lore.kernel.org/r/20250724-drm-vc4-extra-formats-v1-1-67fa80597fad@raspberrypi.com

---
Dave Stevenson (2):
      drm/vc4: plane: Flag formats as having a minimum generation
      drm/vc4: plane: Add support for P01[026] and S01[026] formats

 drivers/gpu/drm/vc4/vc4_plane.c | 56 +++++++++++++++++++++++++++++++++++------
 drivers/gpu/drm/vc4/vc4_regs.h  |  9 +++++++
 2 files changed, 58 insertions(+), 7 deletions(-)
---
base-commit: d2b48f2b30f25997a1ae1ad0cefac68c25f8c330
change-id: 20250724-drm-vc4-extra-formats-1f53e6491cc1

Best regards,
-- 
Dave Stevenson <dave.stevenson@raspberrypi.com>


