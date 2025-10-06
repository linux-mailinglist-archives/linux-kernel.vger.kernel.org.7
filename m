Return-Path: <linux-kernel+bounces-843289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84EE7BBED94
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 19:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 585CB189B079
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 17:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9A8285C8D;
	Mon,  6 Oct 2025 17:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mlq58Lnz"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8AD1C84C0
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 17:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759772953; cv=none; b=ULKrlp0G692GiGp0yDo5lrYNQMwfiWUJXqlO4mXelUNR3+39omzHs9h8urGIQ0gw+xs9VK2F3OdizQNG/XvryF36QSj6GyUSgBGGGbBmr+TV3KaDVsJIiLqNSu23rne4BCClQByNwDAn2R3PqrBTvNjk9rJRtrHlfaTCcLuvU7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759772953; c=relaxed/simple;
	bh=nQoaKh0+iG4YyKUnAkYuu5p0DJ2aHhG3jPXqYWGllGQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QllojM0H5HYOlx8K9ul5sF7KedvUI/RenDj5FZTOjkGZ4Q0ElQlcP5aI5s2zNY+XrYCRgXU/mdXd3YWsgJXy+KbNpdi0gaFGTjOei/uOWwAg2BerT45r9D9lhJrYqEXA6zeh1eX714PKWAMETozPtcD2ixDEYvlLVfQdumcaAko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mlq58Lnz; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-46e61ebddd6so50062825e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 10:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759772949; x=1760377749; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OwPjYDue993F4kdSpEJug+JsTugVch4hbG5zN8v6Sko=;
        b=mlq58Lnzm/E7pKrHZPOQUUN8nAZQB35MP6xwoUkCHIvS9aJsTmtqFMoIdjBAELS7CE
         Ca7AeN2AYYjtGNODwZV+0LTQpSGyUqxf9F4Nzf8SkdDlxKGPiZj/6btWJlrkERlCunGe
         HgTu3++wDGGgw1uZ1qBizoRbfD7a1Lu4L5f0+zOzZzcM4UT7zp2V4+wlE7pasQwKqIIq
         R6joTr1TMUVOCWXVRcizjI+jrrZvU2Nsiaypt0ORHVZKeb/CTnqGJJvtsBUt0RMqGycF
         Nu8f1NJvclQ0TGxEajvdFp0KkrZCAPMV+URUdc/j9k9Zr5PL3R4u82XVdaEHdemUq4NG
         n3eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759772949; x=1760377749;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OwPjYDue993F4kdSpEJug+JsTugVch4hbG5zN8v6Sko=;
        b=hg45FfMFbw6Kj2A7vjjEXRm02Oj/bFbsGalzn64OqwJ+LqmOH5QP4YTClqSoLTcJ6t
         GZ5mIRa78o8KDk0AoeSPJGJjp75IiU0zX+rg4YryNI/XFchD/6NDhTBHbZ2cxG0xBSBy
         4O1Jwxt9GfLxn4SkGmNg02g26iISvARqhJzX2Rve6C87ZzPYEveizbFNzlhek5lnBq/I
         FFm3HfPqxyYyNYVMO8C4X8OLWafaHoURKg5/I+41MhOtP+cIJ2SaXCiGL6ts86ZVxOE3
         6R3OuijYzMnFZ4agu+0jqbjf+MPTjc4gnd0y3n8QpVefISDrEsX9pd8g5QtNpFu1Snfc
         2w5A==
X-Gm-Message-State: AOJu0YwldkvWpqmAmwZGFp3OKXQtkgVhzmeTTen7Y9WJ+UMmAZUrNS4Z
	N0/1NipH1JQZ78TZ7c8+Y5nCpwxmBL0Nwq5i2xnoMT2/q6PcZsS4Avnz
X-Gm-Gg: ASbGncv3P2/ZQLU/74DsWg7D21nT98bBkJaGi2+i1T4AM7UaLIufyKsMsf9Re49EDFx
	2qFUJ2Tiqf9IJqkPIj3zjclwxbYsVIdo4EbQMxB1Dmt4QZSDTMyZJQQK02wmtrSPDDmJmbs58ts
	HIdQGONttPVF2n7+10IFesUUwXBBRfbFOYnzuKqZGAlteNpH6+9+6rkWx/v6AmIMk+L3kB20kRW
	glURBI3P42pJOw4sGtX80T84dP24TA7BPQfGe1pVKTo5eBvCpxOwfvilkyMG2n8r+fJTEjLG5l2
	MYGMx0tFByQPetuRq4OkGhSSLg9jBHsbcrjgwwm7ypacwIZsyyHoTzo+DYpcrizdlg1NH8yhng7
	9DxkafVRDEcU3NK4MjJl5ByoWV3OAgarE5KUlEZhR1jWP2dtR5jO906tQw0xSxH521qK9VRHYC9
	187zF4yQQyx5a+H3AigEOP6rlDJq6yT9YOnA==
X-Google-Smtp-Source: AGHT+IGoQmqa08yh2oAWYFi0h/YVWQM5hhY6UDRLPAIKA3rUms7L/IUnK3x7/0LeBb8VrVVo34J77Q==
X-Received: by 2002:a05:600c:46d1:b0:46e:4c02:c2f9 with SMTP id 5b1f17b1804b1-46e71157990mr93102665e9.36.1759772949081;
        Mon, 06 Oct 2025 10:49:09 -0700 (PDT)
Received: from ipedrosa-thinkpadx1carbongen12.rmtes.csb ([5.225.139.156])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e723431f5sm165583805e9.2.2025.10.06.10.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 10:49:08 -0700 (PDT)
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Subject: [PATCH v3 0/3] drm/sitronix/st7920: Add support for the ST7920
 controller
Date: Mon, 06 Oct 2025 19:48:52 +0200
Message-Id: <20251006-st7920-v3-0-4f89d656fa03@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAQB5GgC/2WMyw7CIBBFf6VhLWYK9IEr/8O4GCq0k9hioCGap
 v8u7UJNXJ6be87Cog1kIzsVCws2USQ/ZZCHgnUDTr3ldMvMBIgKWqh5nBstgNsGDUphJJqa5fM
 jWEfPPXS5Zh4ozj689m4qt/UvkUoOvFZoKpTKaYRzPyLdj50f2ZZI4qtp0B9NZE2BdqrV4Ezlf
 rV1Xd/Krf2s0wAAAA==
X-Change-ID: 20250806-st7920-e7aba32b3ab6
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 Iker Pedrosa <ikerpedrosam@gmail.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org
X-Mailer: b4 0.14.2

This patch-series adds support for the Sitronix ST7920 controller, which
is a monochrome dot-matrix graphical LCD controller that has SPI and
parallel interfaces.

The st7920 driver only has support for SPI so displays using other
transport protocols are currently not supported.

* Patch #1 adds the driver.
* Patch #2 adds the DT binding schema.
* Patch #3 adds the MAINTAINERS information.

---
Changes in v3:
- Reorganize the patch documenting compatible (DT bindings) before their
  use.
- Drop reduntant information from DT bindings.
- Use a goto label to ensure drm_dev_exit() is called in the error path
  of drm_gem_fb_begin_cpu_access().
- Link to v2: https://lore.kernel.org/r/20250909-st7920-v2-0-409f4890fb5f@gmail.com

Changes in v2:
- Refactor SPI communication:
  * Internalize error handling and delays within the st7920_spi_write()
    helper.
  * Split the main SPI write function into smaller, command-specific
    helpers for clarity.
- Improve DRM/KMS logic:
  * Relocate CPU access calls (drm_gem_fb...) to the atomic_update hook.
  * Use standard DRM helpers (drm_crtc_helper_mode_valid_fixed and
    drm_connector_helper_get_modes_fixed) for mode validation and
    creation.
- General code cleanup:
  * Remove dead code related to ST7920_FAMILY.
  * Replace WARN_ON() with drm_WARN_ON_ONCE().
  * Ensure single variable assignments per line.
- Fix probe initialization order:
  * Move spi_set_drvdata() and st7920_init() to occur before device
    registration.
- Devicetree:
  * Update bindings to address feedback from review (e.g., reference
    common SPI properties).
- MAINTAINERS:
  * Add a proper commit message to the patch.
- Link to v1: https://lore.kernel.org/r/20250806-st7920-v1-0-64ab5a34f9a0@gmail.com
---

Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>

---
Iker Pedrosa (3):
      dt-bindings: display: sitronix,st7920: Add DT schema
      drm: Add driver for Sitronix ST7920 LCD displays
      MAINTAINERS: Add entry for Sitronix ST7920 driver

 .../bindings/display/sitronix,st7920.yaml          |  50 ++
 MAINTAINERS                                        |   7 +
 drivers/gpu/drm/sitronix/Kconfig                   |  10 +
 drivers/gpu/drm/sitronix/Makefile                  |   1 +
 drivers/gpu/drm/sitronix/st7920.c                  | 892 +++++++++++++++++++++
 5 files changed, 960 insertions(+)
---
base-commit: c571cb70e1ed43ee543c70151e61a001ab2eefa2
change-id: 20250806-st7920-e7aba32b3ab6

Best regards,
-- 
Iker Pedrosa <ikerpedrosam@gmail.com>


