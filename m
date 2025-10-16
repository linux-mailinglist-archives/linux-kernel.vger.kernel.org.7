Return-Path: <linux-kernel+bounces-856731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA401BE4EF6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 19:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 456A9188AB3A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 17:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF89E22129B;
	Thu, 16 Oct 2025 17:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XMZJpuk7"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62EF2334697
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 17:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760637405; cv=none; b=lW2kw9/VF+BGB6zMulQWrqA5GnQuC6yHZuwLBxvkFpvsaSpyIb/aLvTW/VYNh0ME+FBNg2queHaoj6Z3C8LNA7QzCmabPfH9VaD7Ycfgtlv4HpPqacaNNh/qrD0HU6lYmSKoJr4Upsr9WEtzzu/c5B1fcNuujGO6YmuiqGKS/qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760637405; c=relaxed/simple;
	bh=Tfi6Ed2LnGMpygf/tnbikrEQ7wJ6wjv0+wXgMAsITGM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=M4jpEafWkMEy0i6bakZa7fJxNy6N3rYgX66pbEG2JGbtIAp6nXbJypzY+bbRncgg6Roq6LzVlKJbibQbViK5g7HMzdlwyxUbnCaiNjd277mUHRycYu6H1WKssH0GQcK5sybdoz+hj5YYueGTN5HKvB3oFbGjr+GbryyuYF7lb8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XMZJpuk7; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47117e75258so1318195e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 10:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760637402; x=1761242202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8hqkh+fjkB3fz9DwOW6jO474uGX1QhhcgWpwE4pXOXQ=;
        b=XMZJpuk7YDQ+ns37Xjoww7aovRWTh6+YF8NRzUzq00OQWww/HBhS8d6ywJ1tx9NTYY
         8kD9Orq/rFyvQ/mKGXsfzW0I+n1puPYMWT5OX8tVZqZPnQTloTmqS5rZ0qMXjvB6tMsp
         AQyCxA2QJcWVEZtAtBkmRO8QSbtb/j9hWRsuBqEwDAu+5C4jdqj423yJnqZ/AKTrQoDl
         lvhkNRGcDp8Urwsk/OYJB5q8cygaimyHcMeYes9QG55lDqKwlpSksAxrfniFI7XhrfuE
         bWIiBOhTjXV90YV95cW9cTjdRBg3qimssKE0tHAvUycS9hWJ73z/f4GI/OvQCYKuBXDS
         t/qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760637402; x=1761242202;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8hqkh+fjkB3fz9DwOW6jO474uGX1QhhcgWpwE4pXOXQ=;
        b=ljNqHx4T5CBEXgFA6LUwZGP0DtSTPm4tOS4HwJaMKPy1Y8n9ImwPw6JBl8YK45KQAD
         I+b3Nvw+pnvnXO29rgNoagSJjix8kgmPm6E+IahuCdsAXWQ761Cj99kjFfp9CG53SiCx
         lK6XUmqunkyfMcu+YBSi1s2T39cwFauOz7tl+ZDUCSHPoDwxeZEqu4aeAfLQ6H+TWMEI
         oLYZK9+8vG2MMsekaaf7S+Ci4cThtvSX+frf7nKHXKh+v62v5D4Zen+RLXvtsK0z9Wen
         EfXp+fKjlGs+z2/f3EDpY1Ev52JA/nD8qZDs+Q4pu2EeT6LIUDCvPacoPxrURwo2CQMo
         awwA==
X-Forwarded-Encrypted: i=1; AJvYcCUkNBCnnzHAwk06Wyyvw0odMzckQiV8IqWovSUS+avi2Q+LDOwHgRFoUQ8cFp8jo/6aFUeT+4tYzJav+Q8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfkWd1vAbe/uu0+DXT84vQE44zjX1A07LPuwvweRgjw1in9tjf
	OLi7Qa4ehfKObEjxTCck2Y81gI54nOVwHMbFMcdGvvtP/4GBKh0uEECC
X-Gm-Gg: ASbGncsB28YwMitYwYmcq+ynUNyiSANQ7oinCXMIc+36TiUxQ2o0AGfJwpynQQ+Mg5i
	xMntGIyzb0cKm4qDu2jDQ0SBgPvc0JtlEtpIWPGxsDvbGp20DZpy5HuiV0gEaeBjo/UXR6vIzA3
	ietTGFlQ/3H9YuMdpwnP/Ktqyu3myRoe6K4NpDAvEgIISh4Fe1+L89Gndc1+ErNIsskv8RL9Y3p
	jC+Md1T9QTXtpREBALg/O9Bozj7couFapwUnCLxM6JwGG+v4v9NqfY+ZvXuR5Ta/LSknlNU+B4Z
	epyF4+JtKhw5lHN7g331nhMr704p9Kvzkh7RZFM11NAuQ65rsAw688ybSOJfgo/rZjcKvw0+WKJ
	86R3IDqpAPgZcmzl10drZjQO8v4Vd6yncWgybxHu/CSuz/Gs6VUcXLlev0TYFhnB+iYs/+sCbUn
	FN+tA8/7AJtw==
X-Google-Smtp-Source: AGHT+IHlyrWkPJWHU8jWWshnVV3s579IlPpvASGs8mFWda20UTGwQPy5nfJzZhrHmi8bRfFYfdm7/g==
X-Received: by 2002:a05:600c:64cf:b0:46e:3dad:31ea with SMTP id 5b1f17b1804b1-471178af7cemr6048875e9.17.1760637401561;
        Thu, 16 Oct 2025 10:56:41 -0700 (PDT)
Received: from fedora ([94.73.33.104])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5cfe74sm35344023f8f.35.2025.10.16.10.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 10:56:41 -0700 (PDT)
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
Subject: [PATCH v7 00/16] drm/vkms: Add configfs support
Date: Thu, 16 Oct 2025 19:56:02 +0200
Message-ID: <20251016175618.10051-1-jose.exposito89@gmail.com>
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

Finally, the code is thoroughly tested by a collection of IGT tests [2].

Best wishes,
José Expósito

[1] https://github.com/JoseExposito/vkmsctl
[2] https://lore.kernel.org/igt-dev/20250807074550.6543-1-jose.exposito89@gmail.com/

Changes in v7:

  - Rebased on top of drm-misc-next
  - Fixed 2 documentation issues (thanks Harry!)
  - Added reviewed-by Harry and Luca, thanks a lot!
  - Link to v6: https://lore.kernel.org/dri-devel/20250901122541.9983-1-jose.exposito89@gmail.com/

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


base-commit: b291e4f1a4951204ce858cd01801291d34962a33
-- 
2.51.0


