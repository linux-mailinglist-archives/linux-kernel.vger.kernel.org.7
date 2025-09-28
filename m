Return-Path: <linux-kernel+bounces-835252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D25BA6963
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 08:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96D5E3AD38E
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 06:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6C529B778;
	Sun, 28 Sep 2025 06:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fazxwdIe"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D215C29AB1D
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 06:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759041696; cv=none; b=slE+y1Bim+zgekLxc72H82ercwgXULiERVNId1E1vesCE+TJBTxzoXmUzxQuNh6X/0bhg7EUFSsZCOlFWSGqBMRF6nA3zoiR/H1EFntXUpA5yQPEQVlIURfRurJaZFyVVKVXWfpQZorXYq8erisIWrLfghrVTgQazdlkw6ldeGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759041696; c=relaxed/simple;
	bh=lTRg2QLZ/kUbp0pVRHtFL2EIqAXAC0du+XeXnKk6JLs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=noVu5yGJbwDuGc6nkOafs7S1wubTgduse8jE0EH9GKAiiXMFLl4l43OoWx87AdslwJx/a3AFiMnW8r05bziwlM65LEEZhHYMrIl/tCFS/LuZKzF9civV6Wp8t38i/Wrm/kO+Iaw7FaLkaSQLYZAWK5QIMB/e+8vciowrDAvpJ24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fazxwdIe; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5821dec0408so1727904e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 23:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759041693; x=1759646493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6+l4n0MONZz4a0slWD0pvYSfJJ9WeP67vg+P79m1fQ4=;
        b=fazxwdIeIAff4lCOy76BX1Ltk9FCZx9o1s9dPsbUs9EqV4vEwKadXtKj2qn5fvjV1x
         C+Xy61VMdiG6NxX8vsyFKtEYEN89Yc+A92WPDcCeD0Ows2AVPPmLCcwfE7unLBbfq2Nj
         RBE8KgSaP3JTc9+aAg0PsJDW5Z+UK3NwZZV5VAUno10ZXUHib9qxq+Au0V7elsjzlq33
         UnZaRSOEYDjnnaMGQd64xmUi0wRBkfaYhALP1viEhMIgztV1d5RgIrfWkAaNrVo4c0zg
         ggEwvKX0Q4Vx1oEK1OAg8VVKdEXxQ37aTUaIl+YjFP2FW0WKCRrxHmx1uYVMlRHO7IE8
         171w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759041693; x=1759646493;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6+l4n0MONZz4a0slWD0pvYSfJJ9WeP67vg+P79m1fQ4=;
        b=mrr+8GNUPtvIAxUfDBEDhqT85QEzKWc1IiytCMvBP8GS7DudS3ZxXD8ephvFfqmhul
         XVSQbQf0pPEbnJD5BXMJ2rpsdQcTPo/s9veOEudLIaMW8mtJntGmfuT5pFpCZ2b45yZr
         5LhQZe1jJ8IJnyESS4+xTi3HtvJAX6NPPKPNVd0AlK6kJX7S122ea8G94U6BYoMBOqV9
         1NYI8RLVYtEYYYF23rhVDuxiZlyC/L6rUYXLol/D+dEOauvsAGltTq0Dy0zEar1v2Lb3
         NCksRcSN+OAryRTWUKKC0mj7+N1HJ9sxadoWBmGOro0ndrqNGpLMAKRu2Rn5f+VtN81P
         cmeg==
X-Forwarded-Encrypted: i=1; AJvYcCUSv6lwNNhFv6jlzrOj7NPuYPIqKAh2RpTXU8s+dPGI2ecsVo2qHPrxbfQeGmcabZQxgV1wN8M/kMd4jfc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywnn6L+HmbtBcwZt4321ysXka4AhV1MTgBOBE+oCLmZlTA8fezO
	x4jykGNDwpa96Xtkb+VYF3d1tlnlQjFJcJhd/EHBDsHEbwr7r/lbF2G/
X-Gm-Gg: ASbGncuN8q/nq8nPz8p+qBOjbnXCLRyLAwZOPzHAo+aHKPQY6g4uhTwsikjx11ha1nu
	OaWC1h8oh/xIphK99uNw9fms51vKs2o9Jdn+v0n+0pwPXx6GkGwyHj8g1t1HpbhsDYC2t6UYrWA
	ThIcV5A4FPkm/Zsc/1uaNG3GFNp+oA2l1d3XAw9cayrrxLRQ7vWus4SJLXjFrpst5Kg0tETfBMU
	Ik/kn+QkvQpo/mJJc/7bKho/FKPEOLvhCSldWFz4XZT+b5QrI5w46v6lYh+x2lMx+0OGcpmqNsx
	YOfEdQ1rVq3dgWWFTTD+piFlrv7T73cIL+DPnl2plkQKafHX05P25rRDTt1nKTwk/iwmYQNLm1L
	QWvgnwjkAnMLXKcOiHFMVfrCd
X-Google-Smtp-Source: AGHT+IEcgaLatwY7/VhpRV9y6ZVjBLs8icf5KFY4Z30Ha7VQ5Kg2Dymj6dhwUPoRS5QtGAxYVuOHYQ==
X-Received: by 2002:a05:6512:3d0d:b0:55f:6cec:2890 with SMTP id 2adb3069b0e04-582d3300904mr3995446e87.38.1759041692491;
        Sat, 27 Sep 2025 23:41:32 -0700 (PDT)
Received: from xeon.. ([188.163.112.70])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58600043386sm973735e87.86.2025.09.27.23.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Sep 2025 23:41:32 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] DRM: panel: add support for Sharp LQ079L1SX01 panel
Date: Sun, 28 Sep 2025 09:41:04 +0300
Message-ID: <20250928064106.46756-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sharp LQ079L1SX01 panel is a LCD panel working in dual video mode found in
Xiaomi Mi Pad (A0101).

---
Changes in v2:
- adjusted schema with ">" and dsi0 > dsi
- fixed copyright from Nvidia to Xiaomi since sconfiguration equence is
  based on the downstream Xiaomi code.
- adjusted commit name of second commit

Changes in v3:
- tested with drm-misc-next
- switched to mipi_dsi_dual* macros

Changes in v4:
- removed unused struct drm_display_mode pointer from driver struct
- adjusted resolution in Kconfig description
- rebased onto drm-misc-next
---

Svyatoslav Ryhel (2):
  dt-bindings: display: panel: document Sharp LQ079L1SX01 panel
  gpu/drm: panel: Add Sharp LQ079L1SX01 panel support

 .../display/panel/sharp,lq079l1sx01.yaml      |  99 ++++++++
 drivers/gpu/drm/panel/Kconfig                 |  15 ++
 drivers/gpu/drm/panel/Makefile                |   1 +
 .../gpu/drm/panel/panel-sharp-lq079l1sx01.c   | 223 ++++++++++++++++++
 4 files changed, 338 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/sharp,lq079l1sx01.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-sharp-lq079l1sx01.c

-- 
2.48.1


