Return-Path: <linux-kernel+bounces-794502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFEC4B3E2B3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 14:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BE603A56B7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 12:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470A52EF67A;
	Mon,  1 Sep 2025 12:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ET6ikEEK"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976A017A2E6
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 12:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756729556; cv=none; b=IMblmJ1fSNXMJmm6NZQSZ//WdgbAe80pBhWAETP2lrmNdYqjFn/aWfWc4/zpnRKoHyumdnQ3zOHN4pkEDOOPVYYCR7y+d6dK/WJDt/bmGX6rxIksxKMBr2bisyTKdlM+5MAzlNk8UT70Yg4dxkrRCHWhSRtB1fjNy7kflBAUpHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756729556; c=relaxed/simple;
	bh=YRLpPcktydkiMFe1WpSS/gj4C0i9I/Dc1Map8lBk/Tg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fqOf2UZS1FikTeTn0fvYHWU19XdwsviYfYgXEitl7CwTfTH4y4dgJIGRjlghANKRrEwPPfHbxiQpI+LAncgGepJbuVftPf4y93sbR0Vcvv07c3f9Puin3WR3bCM68APlj3AsoOjnK0I+NC1T8Hh4Vf7G1T82V3eSEV3oyMwSFIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ET6ikEEK; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45b873a2092so15117965e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 05:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756729553; x=1757334353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qbycQLF9MWkGkzA+fGZj0+ulP2LwfvU4kMytcoetwe8=;
        b=ET6ikEEK1mOxIg+9CtZkw+2VmUwBnFCTIvAPwCKV/gn0gQTTI6bPcWmx6ndjsgYR7T
         czyx2KkswtqJci9bJ5U4eAPZIai3qpbpaevUuw7/qhHuxK09WlutD+KOy0fwZyvaucX3
         w2kdfC42z2xnsMlvH8/AYwD63cnewzA/7/qeM0Swttn2u8HgDWMkgQB9xhlQZSZxvgCD
         DLwMvwsX5H7FmE5tYnZciHmAzCzONOnOn0F+KuB3Oxcbgvjpik6TPa+38n7ptZg2knHq
         HsPfMXgIQj36aizQsa7QCbuMFP+ilsqDVNztFErSkx5keAK+nVmN6Li5Gf63df4BhPV9
         epYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756729553; x=1757334353;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qbycQLF9MWkGkzA+fGZj0+ulP2LwfvU4kMytcoetwe8=;
        b=MXdBmQ+VHwvISZKBbxdO8kJdUFK4jhhVmWUSc2vZFNYoucj8dBL3WPxKo9T51HH0AN
         LKN72IoSMiNwEd/b3I3antfK9pdZ74eRPlZxQ/8sroj0pOqrTxs+OhWbBITorkwit/k/
         qVXsRHHNjzfAUHUkFBJ5CIRZ569odxbaHphKbeio+NWxqXkPfD96AcRoOXK9wxYyk5VF
         xCgw2vM9fxgG7b2ElfpnYGClc7xlzbxIAJHlboGGrZMc09dm4qwoGCak3ZRkkf6bspzd
         JX6DWS1LG0YJL0Fy+sxDJazyRXH0zcLSFrZSJTeQcqfiJnX7Z5ZPHShORXGFUCeIQ3Y7
         RAcA==
X-Forwarded-Encrypted: i=1; AJvYcCVWjaxDJmhKIDxlRvURc4zX2sLxvNDctAUsMcuObilbuT2pxmUzi1e2gXpU99kV6PuFVCKhT1nEm1yhYAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLrOPDiYypFt0meyTI/sAohO2/8QgmsW3ODZRQnGzayaLRrmno
	ij2yIJ0yPw0iaDKyG9oG3rJvUrUjnQxOcTUggJbfPjIXRASMxaTTso+f
X-Gm-Gg: ASbGncug9egwIcJm8obmYCMqYdSi26AkFXrtgF3Kc+po90n3t/5KJRd5/GDFPtKSKP+
	wzVIUPDvT0t3IzDdlSPNku4Ylx2pZXr/5Rwc36hwlYZCwrgPI7Wa5q+/nmRyrvHgNo2BRVqkqs0
	zuGtqW12Wt5i9y2dC5YOdR1xJzSi+wWgsWg2SK/FFLedWQTni/xhPLGtAoy9AiSGzzuM64HyZes
	LP+gHDXOHOyduyZ8/fw9udx1WOERuwHRtVXo8UhztWSjWebZpQ89BgLZi62xkvdr08RnQQFG96h
	rYh17ElIRC/wqiGzWDoZ/ap6g6TuC/DVYLqmorI3papPrLCzSA/miivpNUOjLpDvWCSJaLCKcKk
	xOEOowkCTXgiM1nJSzeBXS9QzUxIa
X-Google-Smtp-Source: AGHT+IHRynpVpTWD6ySXHOkdCNUyg4PSynT/rcEtXw/LLZpnm9LeRHn2wE/hMLoxu9UKMd4J2YF/7A==
X-Received: by 2002:a05:600c:a44:b0:45b:7f72:340 with SMTP id 5b1f17b1804b1-45b8557c68cmr69560785e9.25.1756729552446;
        Mon, 01 Sep 2025 05:25:52 -0700 (PDT)
Received: from fedora ([94.73.32.0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b74950639sm207297055e9.17.2025.09.01.05.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 05:25:51 -0700 (PDT)
From: =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To: louis.chauvet@bootlin.com
Cc: hamohammed.sa@gmail.com,
	simona@ffwll.ch,
	melissa.srw@gmail.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	sebastian.wick@redhat.com,
	xaver.hugl@kde.org,
	victoria@system76.com,
	a.hindborg@kernel.org,
	leitao@debian.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH v6 00/16] drm/vkms: Add configfs support
Date: Mon,  1 Sep 2025 14:25:25 +0200
Message-ID: <20250901122541.9983-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi everyone,

This series allow to configure one or more VKMS instances without having
to reload the driver using configfs.

The process of configuring a VKMS device is documented in "vkms.rst".

In addition, I created a CLI tool to easily control VKMS instances from the
command line: vkmsctl [1].

The series is structured in 3 blocks:

  - Patches 1..11: Basic device configuration. For simplicity, I kept the
    available options as minimal as possible.

  - Patches 12 and 13: New option to skip the default device creation and to-do
    cleanup.

  - Patches 14, 15 and 16: Allow to hot-plug and unplug connectors. This is not
    part of the minimal set of options, but I included in this series so it can
    be used as a template/example of how new configurations can be added.

Finally, the code is thoroughly tested by a collection of IGT tests [2]. The IGT
series is almost fully reviewed (1 patch is missing) and it is waiting on this
series to be merged.

I don't know what is preventing this series to be ACK by a DRM maintainer, but
please, if there is something missing or that needs to be fixed let me know.

I CCed the configfs maintainers in case they can give feedback about the design
of the configfs API or the configfs related code, just in case that is one of
the complicated points to review by DRM maintainers.

Best wishes,
José Expósito

[1] https://github.com/JoseExposito/vkmsctl
[2] https://lore.kernel.org/igt-dev/20250807074550.6543-1-jose.exposito89@gmail.com/

Changes in v6:

  - No code changes, rebased on top of drm-misc-next
  - Added Tested-by: Mark Yacoub, who merged the series into the Android tree (thanks!)
    https://lore.kernel.org/dri-devel/CAC0gqY6ZH8h5aoNh31ck3dP6c3YYtfTRjJ47Obu6xSXSVXm5mA@mail.gmail.com/
  - Added a link in the cover letter the CLI to configure VKMS: vkmsctl
  - CCed more people to try to get the series merged
  - Link to v5: https://lore.kernel.org/dri-devel/20250507135431.53907-1-jose.exposito89@gmail.com/

Changes in v5:

  - No code changes, rebased on top of drm-misc-next
  - Added Reviewed-by tags, thanks Louis!
  - Link to v4: https://lore.kernel.org/dri-devel/20250407081425.6420-1-jose.exposito89@gmail.com/

Changes in v4:

  - No code changes, rebased on top of drm-misc-next
  - Since Louis and I worked on this together, set him as the author of some of
    the patches and me as co-developed-by to reflect this joint effort.
  - Link to v3: https://lore.kernel.org/all/20250307163353.5896-1-jose.exposito89@gmail.com/

Changes in v3:

  - Applied review comments by Louis Chauvet: (thanks!!)
    - Use scoped_guard() instead of guard(mutex)(...)
    - Fix a use-after-free error in the connector hot-plug code
  - Rebased on top of drm-misc-next
  - Link to v2: https://lore.kernel.org/all/20250225175936.7223-1-jose.exposito89@gmail.com/

Changes in v2:

  - Applied review comments by Louis Chauvet:
    - Use guard(mutex)(...) instead of lock/unlock
    - Return -EBUSY when trying to modify a enabled device
    - Move the connector hot-plug related patches to the end
  - Rebased on top of drm-misc-next
  - Link to v1: https://lore.kernel.org/dri-devel/20250218170808.9507-1-jose.exposito89@gmail.com/T/

José Expósito (6):
  drm/vkms: Expose device creation and destruction
  drm/vkms: Allow to configure the default device creation
  drm/vkms: Remove completed task from the TODO list
  drm/vkms: Allow to configure connector status
  drm/vkms: Allow to update the connector status
  drm/vkms: Allow to configure connector status via configfs

Louis Chauvet (10):
  drm/vkms: Add and remove VKMS instances via configfs
  drm/vkms: Allow to configure multiple planes via configfs
  drm/vkms: Allow to configure the plane type via configfs
  drm/vkms: Allow to configure multiple CRTCs via configfs
  drm/vkms: Allow to configure CRTC writeback support via configfs
  drm/vkms: Allow to attach planes and CRTCs via configfs
  drm/vkms: Allow to configure multiple encoders via configfs
  drm/vkms: Allow to attach encoders and CRTCs via configfs
  drm/vkms: Allow to configure multiple connectors via configfs
  drm/vkms: Allow to attach connectors and encoders via configfs

 Documentation/gpu/vkms.rst                    | 100 ++-
 drivers/gpu/drm/vkms/Kconfig                  |   1 +
 drivers/gpu/drm/vkms/Makefile                 |   3 +-
 drivers/gpu/drm/vkms/tests/vkms_config_test.c |  24 +
 drivers/gpu/drm/vkms/vkms_config.c            |   8 +-
 drivers/gpu/drm/vkms/vkms_config.h            |  26 +
 drivers/gpu/drm/vkms/vkms_configfs.c          | 833 ++++++++++++++++++
 drivers/gpu/drm/vkms/vkms_configfs.h          |   8 +
 drivers/gpu/drm/vkms/vkms_connector.c         |  35 +
 drivers/gpu/drm/vkms/vkms_connector.h         |   9 +
 drivers/gpu/drm/vkms/vkms_drv.c               |  18 +-
 drivers/gpu/drm/vkms/vkms_drv.h               |  20 +
 12 files changed, 1072 insertions(+), 13 deletions(-)
 create mode 100644 drivers/gpu/drm/vkms/vkms_configfs.c
 create mode 100644 drivers/gpu/drm/vkms/vkms_configfs.h


base-commit: 6b53cf48d9339c75fa51927b0a67d8a6751066bd
-- 
2.51.0


