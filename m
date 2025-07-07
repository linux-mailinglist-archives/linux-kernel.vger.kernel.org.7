Return-Path: <linux-kernel+bounces-720381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF78AFBAD2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 20:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 074CA1AA8221
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 18:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB36274FDC;
	Mon,  7 Jul 2025 18:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="X1a4akaD"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3B32652AF
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 18:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751913249; cv=none; b=ZbvzwH3WWIFzDm33W8fOdv8rniNYOUharTeB4vROOev0VvZNKYcPVeHy9ItRw2M8WKRZvq8tnelU9zJzYD9FHBmG9zQpCSgoeY7RyMBw6y3+d2lXidtoUYoW21s41bBCLWHu0hcbkWtwhMOm5I4fCE+OkHocQoAlM2Y+gXykVvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751913249; c=relaxed/simple;
	bh=8K+GjBl/FE9E58iFy0BSlb50AFIZ1lCSp8aNhG9rQUA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KY/KQ/oHRsUp5zmQZS9+tu+DJBxyECB33BQodBclRJoiHyNniCSUr2qU5tkbGBWfppfxR782aKO/VhpFMHuX8tKYkKxwI0u0y3vyMjJauwALRxXQZSy/UUXcyNBv0COGVv2aDHW02Y3TFu5Cu7ujihuY0z4nxVc88Urs839Wjck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=X1a4akaD; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-54b10594812so4285928e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 11:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1751913242; x=1752518042; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GI3mp7khiC3aiN54V1s1kSnePibHGblj0uNsT4N64ys=;
        b=X1a4akaDudcpWGG6x3wdASzM2j0EkRw1PXvxGw8Y1XeoVH0rXperSPOG8bHV5J5uQh
         cuoWkX7ZU1mPjcjP2HJCCWUMpKaqzdr0CSYO+fS3CvVBS7ECxz51e5s2y3DIzUILS4Y7
         iIZa1W43MYuzEI2J0qEiPCD8lPYFh+/38HYEo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751913242; x=1752518042;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GI3mp7khiC3aiN54V1s1kSnePibHGblj0uNsT4N64ys=;
        b=p0YX7NoCL/+PX97BMvfJ2thhErcBBEQT7nyElWMK9tcowNWGJXyscf2jQRUfp6/R1S
         tr/2bbErA6QVZskEEZ0qnhp2zQeuQ+PpfYZ18zORxnEO2QW9vUA0IhTO9yvrqjWZc9mI
         pzFHCNU+h1nvXNl/u8LDk7luuhWkr2RH33pCE4eh59rQsGI4+fjb/7W5aaiM9PScXVzR
         ++zU48JzM3AJ5no+yyqttzDd3eaVKpuGNJ5cRSidE3Wdk73DGJTKX6YQsh0jDcxQKk2+
         FFyZqXxX/ZczlMI+cB02NhHzUBZHAlrlDcUWPyDAWe0eIuYdAoEr61OGVWGjA/Ky34B+
         USZg==
X-Forwarded-Encrypted: i=1; AJvYcCV9cTJ0sFdpXUsz5DbN+9PpDpG78bI7xIqkObLpmE3fI7S/5H6pEWNgMT4kzsgm/ZRKGbuZqSwFX1Dk9kE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbgDmg2jlQJWan87D0gLjN29fnP9cvjszK3QOH3VnIQwoQRpUR
	IURPVtW/oxL6fuAh7G8BssZpA+U0qfb4dKFlOqpsJn8ekH4A8RtTCe4Jw5EQuTUHbQ==
X-Gm-Gg: ASbGnctW/0inxDnIk27/LmyQXXyVlBOTlNRp2JebMwDXcU7wwB0W69tIySDlo9nznYh
	2IW07G9WOiTAdOpderbjtBZ0FAw0yWfrEcAK+vg4Boohh1UnsYwiRBpvX1VQJC5AO1Z/5fXW8OH
	aR1dyzKD7WI4gYpDrUvJW+qfMQEglQ51NTOY21ahFFk8NDsRMDBqjxSuJAmIUVH1VwIc7Rad1W5
	gF9sGSB/OhkzhryAa5DB7qxLvDLloeV94yWxlkuxLd8fHzOveHrOVrWFOAQ4oRpjVEZxTgN/d+m
	2MbM4nhUGFyx9Hy9Qwtu8VsTzwCxq0m1701wl/0GIZGp1dP29wg/99QCkQQ8p0o3vad5kznh6JK
	fV/+Dt/rJIbzBYxEjIN95+EHJZwjP9IwWfbakvuuyvm07C2Ttkk4R
X-Google-Smtp-Source: AGHT+IEZCncGnL0Aldaey4MgBeMqfZh2uyJKivyRIHEvg5ihpDRPGtDR+uZRcmp1UvTuk7T00/T0hA==
X-Received: by 2002:a05:6512:2c8f:b0:549:5866:6489 with SMTP id 2adb3069b0e04-557aad3a2ecmr3691237e87.47.1751913242430;
        Mon, 07 Jul 2025 11:34:02 -0700 (PDT)
Received: from ribalda.c.googlers.com (166.141.88.34.bc.googleusercontent.com. [34.88.141.166])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-556383d31a6sm1417630e87.61.2025.07.07.11.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 11:34:02 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v8 0/5] media: uvcvideo: Introduce
 V4L2_META_FMT_UVC_MSXU_1_5 + other meta fixes
Date: Mon, 07 Jul 2025 18:34:00 +0000
Message-Id: <20250707-uvc-meta-v8-0-ed17f8b1218b@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABgTbGgC/23MQQ6CMBCF4auYrq0pQ9sBV97DuGjKAF0ApoVGQ
 7i7hY1oWL7JfP/MAnlHgV1PM/MUXXBDn0ZxPjHbmr4h7qq0GQhQQoqcT9HyjkbDSSmNmFcZGGL
 p/empdq8tdX+k3bowDv69laNcrweRKLngBaIxWqIqUd1s64fOTd1l8A1bO1HtrdxZlWyNZYmyt
 lCBOLD6a/WP1cliJrNKFjYHsAcWdzbDncVkS5uukBNAof/ssiwfeRSDvFcBAAA=
X-Change-ID: 20250403-uvc-meta-e556773d12ae
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Hans de Goede <hansg@kernel.org>, Hans de Goede <hansg@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-usb@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2

This series introduces a new metadata format for UVC cameras and adds a
couple of improvements to the UVC metadata handling.

The new metadata format can be enabled in runtime with quirks.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Changes in v8:
- Dynamically fill dev->meta_formats instead of be const.
- Link to v7: https://lore.kernel.org/r/20250617-uvc-meta-v7-0-9c50623e2286@chromium.org

Changes in v7:
- Add patch: Introduce dev->meta_formats
- Link to v6: https://lore.kernel.org/r/20250604-uvc-meta-v6-0-7141d48c322c@chromium.org

Changes in v6 (Thanks Laurent):
- Fix typo in metafmt-uvc.rst
- Improve metafmt-uvc-msxu-1-5.rst
- uvc_meta_v4l2_try_format() block MSXU format unless the quirk is
  active
- Refactor uvc_enable_msxu
- Document uvc_meta_detect_msxu
- Rebase series
- Add R-b
- Link to v5: https://lore.kernel.org/r/20250404-uvc-meta-v5-0-f79974fc2d20@chromium.org

Changes in v5:
- Fix codestyle and kerneldoc warnings reported by media-ci
- Link to v4: https://lore.kernel.org/r/20250403-uvc-meta-v4-0-877aa6475975@chromium.org

Changes in v4:
- Rename format to V4L2_META_FMT_UVC_MSXU_1_5 (Thanks Mauro)
- Flag the new format with a quirk.
- Autodetect MSXU devices.
- Link to v3: https://lore.kernel.org/linux-media/20250313-uvc-metadata-v3-0-c467af869c60@chromium.org/

Changes in v3:
- Fix doc syntax errors.
- Link to v2: https://lore.kernel.org/r/20250306-uvc-metadata-v2-0-7e939857cad5@chromium.org

Changes in v2:
- Add metadata invalid fix
- Move doc note to a separate patch
- Introduce V4L2_META_FMT_UVC_CUSTOM (thanks HdG!).
- Link to v1: https://lore.kernel.org/r/20250226-uvc-metadata-v1-1-6cd6fe5ec2cb@chromium.org

---
Ricardo Ribalda (5):
      media: uvcvideo: Do not mark valid metadata as invalid
      media: Documentation: Add note about UVCH length field
      media: uvcvideo: Introduce dev->meta_formats
      media: uvcvideo: Introduce V4L2_META_FMT_UVC_MSXU_1_5
      media: uvcvideo: Auto-set UVC_QUIRK_MSXU_META

 .../userspace-api/media/v4l/meta-formats.rst       |   1 +
 .../media/v4l/metafmt-uvc-msxu-1-5.rst             |  23 +++++
 .../userspace-api/media/v4l/metafmt-uvc.rst        |   4 +-
 MAINTAINERS                                        |   1 +
 drivers/media/usb/uvc/uvc_driver.c                 |   7 ++
 drivers/media/usb/uvc/uvc_metadata.c               | 115 +++++++++++++++++++--
 drivers/media/usb/uvc/uvc_video.c                  |  12 +--
 drivers/media/usb/uvc/uvcvideo.h                   |   7 ++
 drivers/media/v4l2-core/v4l2-ioctl.c               |   1 +
 include/linux/usb/uvc.h                            |   3 +
 include/uapi/linux/videodev2.h                     |   1 +
 11 files changed, 161 insertions(+), 14 deletions(-)
---
base-commit: a8598c7de1bcd94461ca54c972efa9b4ea501fb9
change-id: 20250403-uvc-meta-e556773d12ae

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


