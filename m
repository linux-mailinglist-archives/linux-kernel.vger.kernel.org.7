Return-Path: <linux-kernel+bounces-778167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1F9B2E21D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 18:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91A1E188EB38
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 16:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BFA4322C9F;
	Wed, 20 Aug 2025 16:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="aCaOBlup"
Received: from relay10.grserver.gr (relay10.grserver.gr [37.27.248.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BF72E2EFD;
	Wed, 20 Aug 2025 16:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.27.248.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755706463; cv=none; b=eJhxp/s8msnTXSTxZ62ey6rzE7jOOFjl5sGN0LYQpvcXnSjimJiCe3DYQ1QSnuTpnuqJa24bp8+IO6COSrMmjUcFSfE/LpgSkwZUXCbzvrIb7d12a8tYV4MOH8gOKQNCC1jeDiRemRrUYRzZmcrJidkmrFY2e8t/Ygfbq6bKsc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755706463; c=relaxed/simple;
	bh=BzaaEsxp8WY9Eto7aPGpxWexAvFXXQBnxEq6xmtCF1E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EyGdWY5J2KQW+aAq2eUQMxV+Gy/3fez2WEgTXepZo1e20xtDEgXdlcnev+QVlv1DgTyyTKrsfMMVlblF+1A23RPAHz+cfdOZEzNUdyjYFSWybk1k4LX8tvRt3tX8u7+wkvYz/Bzod38YBNqFXwtDCIA6K33RgOlJPc538VXfaws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=aCaOBlup; arc=none smtp.client-ip=37.27.248.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay10 (localhost.localdomain [127.0.0.1])
	by relay10.grserver.gr (Proxmox) with ESMTP id 60AB7467CE;
	Wed, 20 Aug 2025 19:06:32 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay10.grserver.gr (Proxmox) with ESMTPS id 3BCD24236A;
	Wed, 20 Aug 2025 19:06:31 +0300 (EEST)
Received: from antheas-z13 (unknown [IPv6:2a05:f6c2:511b:0:7200:c86a:8976:4786])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 36E611FD027;
	Wed, 20 Aug 2025 19:06:30 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1755705990;
	bh=V/Od0YgsrpVzXJiNhkgyby7t3VUAyw5+QgSPq01ipMU=; h=From:To:Subject;
	b=aCaOBlup3IBED20rI+YnZ0r69nJn/OBS/babfY2fZK6qkS3I0ojTnqaSG5H1MzySG
	 YeTMyKFpu/fgilyvrpBs0QM1n+hPv1VFClbUNBAP1eIfWUhExik9Rx0kjSSjQzj1vo
	 M+yI+7l2gnM3xloQuF5h4eA99AGOBgZfgZXG7xaO+ohqZEckBRDARo5pDwPPscYOmQ
	 OCXSkRBVA7PaD8LOwkm64JrZ0OisHSpaOHfFk+oTn7nh0lPmi/z4whRrZF1Idv6FYS
	 oqE4Od6LFMgfw2wEM/z53Xnvnz9ngheZjJDcywymGhheF1RCht/BrrgBh/+GRlfvoS
	 7vTlTc03+1dnQ==
Authentication-Results: linux3247.grserver.gr;
	spf=pass (sender IP is 2a05:f6c2:511b:0:7200:c86a:8976:4786) smtp.mailfrom=lkml@antheas.dev smtp.helo=antheas-z13
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
From: Antheas Kapenekakis <lkml@antheas.dev>
To: platform-driver-x86@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Derek John Clark <derekjohn.clark@gmail.com>,
	=?UTF-8?q?Joaqu=C3=ADn=20Ignacio=20Aramend=C3=ADa?= <samsagax@gmail.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Antheas Kapenekakis <lkml@antheas.dev>
Subject: [PATCH v1 0/5] platform/x86: ayaneo-ec: Add Ayaneo Embedded
 Controller platform driver
Date: Wed, 20 Aug 2025 18:06:23 +0200
Message-ID: <20250820160628.99678-1-lkml@antheas.dev>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <175570599073.2162602.3378467634628196693@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

This series introduces a platform driver for Ayaneo devices, ayaneo-ec.
This driver provides hwmon support, power management, and module management
(for the new Ayaneo 3 device). Module management is done through the new
firmware attributes sysfs interface.

Luckily, all Ayaneo devices with an ACPI mapped EC use the same registers.
Older devices also use a memory mapped region for RGB[1], but that is
replaced by HID in the new Ayaneo 3. Therefore, this allows for a simple
driver design that provides robust future support. The memory mapped region
can be upstreamed as a different RGB driver in the future or remain
out-of-tree[1].

This change also allows cleaning up the oxpec driver, by removing Ayaneo
devices from it. In parallel, charge limiting is added for these devices.

[1] https://github.com/ShadowBlip/ayaneo-platform

Antheas Kapenekakis (5):
  platform/x86: ayaneo-ec: Add Ayaneo Embedded Controller platform
    driver
  platform/x86: ayaneo-ec: Add hwmon support
  platform/x86: ayaneo-ec: Add charge control support
  platform/x86: ayaneo-ec: Add controller power and modules attributes
  platform/x86: ayaneo-ec: Move Ayaneo devices from oxpec to ayaneo-ec

 MAINTAINERS                      |   6 +
 drivers/platform/x86/Kconfig     |  17 +-
 drivers/platform/x86/Makefile    |   3 +
 drivers/platform/x86/ayaneo-ec.c | 631 +++++++++++++++++++++++++++++++
 drivers/platform/x86/oxpec.c     | 115 +-----
 5 files changed, 655 insertions(+), 117 deletions(-)
 create mode 100644 drivers/platform/x86/ayaneo-ec.c


base-commit: c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9
-- 
2.50.1



