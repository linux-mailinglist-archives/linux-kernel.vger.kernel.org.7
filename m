Return-Path: <linux-kernel+bounces-879782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D157C2404F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:08:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FDD01A641F4
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 09:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37BB432E69F;
	Fri, 31 Oct 2025 09:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/DtGl8x"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC7B32D7D6
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 09:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761901540; cv=none; b=qDRvpNTMEawYpMA7u56EWwacnoM/qCjrBl/JBgaZon6SnDD+jpEsm/Zy1K0ZpOXEWJVmw2L2dlxwhgtwnIWUEkSq9f4L7CIDSHwcB/atPJAE/DVN+VLr6JVdBF47rvK++DAyjN1ptWfc3r+wF6LW6HwjoGtpYx/ebS45Cu0NfHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761901540; c=relaxed/simple;
	bh=w6JnjqkIJH2ZNUgNoek7w1tRYQGAGSDYTVXH/aaP3DA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qyhooRw+bY+e6fjt6jKm6HjrkP0ixpcEGLQr9hLAJcBzKE9522N0KcYek476PBlcHVRJNwhIdZ+QgpxT4SXS4FE4e7mbNCO9uG2CploRFTWrG00AxrDUiwA+reM7L4D1Qth5/j8Fu3eu8jwC4TZQ6qBbu9KC7KC20PYYNjBWqMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V/DtGl8x; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4298b49f103so805599f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 02:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761901537; x=1762506337; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3aqRGwqwN2V4mYhgwOypNmslGulZldQn28Px6r89nRA=;
        b=V/DtGl8xKyAmScKkMJW7ngQ7m9Uq/93KZt81ljckq+SCzmwfIbPgYPbxOwbieeOKgo
         9nghKN0iQHG2rzQgm2MjSCo1oBZpNjp3F7xMWf5cdJSVY60IJKufKeZeBcpUMQdyxnlk
         U9fxCG/dDEh4dJIZETXuK6SNzVQkPJXclENxCv+FnZ12f/giD2e5qUBkoAY4MsZVtxK6
         0Herby8xLD57+BvDqH5+lbXqJG7RBY+lspySRJGJIJNNzRHQdMjreCjXQR6SSAOYiIHs
         2lCIQw3lrivbehDB/BIvhZbP16MDQlq6Po/896W8XfSZTPZRqgJaioio5Nzyta0PhW2N
         GvUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761901537; x=1762506337;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3aqRGwqwN2V4mYhgwOypNmslGulZldQn28Px6r89nRA=;
        b=VgFYvASm2M7sZDam8odHsUfPSYeGCCnr3ffHxIqiC0odDzpqyA3CEwf1+Iev3Fq+qN
         csXfino3wwUAnWSv1DWEg9lndzWNmv5lMvda/i23g/QTShNwtfuQ9mihfkbpnrs42k2u
         JY9rrt0/dV2xUvKfYcERqW42zrOu49+yr+UqH/MQ/DzLcylkeu119CPYkSafJDpUnciH
         yisN4F8xh3+dTs6Rlr0ridmK2pbCkSdnkVn2ZDaXEccgqHIYw5XBdebAIwYV/s07Weah
         OwXIw1DZ0/1Zu6KYb1inytRaSdJpDla/lWdP7ZVxBUSBrZ5gBqf7SPexin3EYg85QfCk
         7syA==
X-Gm-Message-State: AOJu0YwizuEb8a537FPWB4PJoA6T3Qy7ChwVFH2bWfSgfLJYY3l8rjnk
	LiUoWG7/PMqPkgSz7EhzqdMfghHVcqpqi8i7BPqZFGvXgt/McsswbZ4C
X-Gm-Gg: ASbGncsVw85vPUgbeH90OWrfbK+x5OeRj2kuwKO5NVxMD7c/AGHmVrbnWksd+JJLFOo
	VWSDdIJLs95Bwc2fVEO1TJEfBHhj0lijfd/bg/UX/xdi8OXPmNscO0JDreOc1avW4KwLXQqr8bl
	oQxMCanjMlN9MxKrfIyCjOUa9hpFjojs/x0hXPotIEg3vEhq0qHnvBF/Zpwzni+NMguYoMfHQh3
	l7s8MZx1Vs6LXv1faC3o6rn93a7FXY3q6U/qb4wOmSkdFHtOtD3q1M7+P+fyu2AaZ4CH1Weill0
	TcTyUGrF5mmykPyS1JqLhX5iwQohVlEiSOSQLTh9AFU2qfbSWaqiz+Q8+1j6WUpZRKImAb2m4VA
	Ye0Fpn24eVqh8NrFroBonHrxTqXe9oCNmZuiO42s2WX4n2QSVAhUU36Jr3kp7LEaDznMRdKjM8B
	RygFmeMNj81vrCx1AiiUQ6nP8jR2EojdpDbz3EgO8D8Q==
X-Google-Smtp-Source: AGHT+IFg1FhvXQeYmxAmP+Nfhgs6XrXefcP9LhQ7WeeLTenWM5h6u0BVP7s24vUtB2NJSszwvaVfhw==
X-Received: by 2002:a05:6000:2f83:b0:427:a27:3a6c with SMTP id ffacd0b85a97d-429bd6d69aamr1761935f8f.63.1761901536640;
        Fri, 31 Oct 2025 02:05:36 -0700 (PDT)
Received: from ipedrosa-thinkpadx1carbongen12.rmtes.csb ([5.225.139.156])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477289adaf8sm93454475e9.7.2025.10.31.02.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 02:05:36 -0700 (PDT)
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Subject: [PATCH v4 0/3] drm/sitronix/st7920: Add support for the ST7920
 controller
Date: Fri, 31 Oct 2025 10:05:16 +0100
Message-Id: <20251031-st7920-v4-0-35291f8076b2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMx7BGkC/2XNTQ6CMBCG4auQrq0Z+gd15T2Miym00ETAtIRoC
 He3sECiy2/S5+1Mog3eRnLJZhLs5KMf+jTEKSNVi31jqa/TJgyYhBIUjWOhGVBboEHODEejSHr
 8DNb51xa63dNufRyH8N66U75e/xJTToEqgUYiF04jXJsO/eNcDR1ZExP7Mg16ZywxAdqJUoMz0
 v0yvrMcDr/xlblS10oqh8CPbFmWD3fCG4MKAQAA
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
Changes in v4:
- Added definitions for the VDD power supply and the XRESET GPIO line,
  which were identified as minimum requirements from the datasheet.
- The error handling strategy has been refactored to propagate an
  error-tracking struct from the caller.
- The atomic enable/disable logic has been correctly moved from
  drm_encoder_helper_funcs to drm_crtc_helper_funcs, as the
  functionality is bound to the CRTC.
- Added drm_dev_enter() and drm_dev_exit() calls to the atomic_enable
  and atomic_disable helpers to correctly manage the device's runtime
  power state.
- Renamed macro definitions to match the correct terminology.
- Link to v3: https://lore.kernel.org/r/20251006-st7920-v3-0-4f89d656fa03@gmail.com

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

 .../bindings/display/sitronix,st7920.yaml          |  58 ++
 MAINTAINERS                                        |   7 +
 drivers/gpu/drm/sitronix/Kconfig                   |  10 +
 drivers/gpu/drm/sitronix/Makefile                  |   1 +
 drivers/gpu/drm/sitronix/st7920.c                  | 905 +++++++++++++++++++++
 5 files changed, 981 insertions(+)
---
base-commit: c571cb70e1ed43ee543c70151e61a001ab2eefa2
change-id: 20250806-st7920-e7aba32b3ab6

Best regards,
-- 
Iker Pedrosa <ikerpedrosam@gmail.com>


