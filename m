Return-Path: <linux-kernel+bounces-854077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 262C9BDD7E2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 10:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFCA41891D90
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 08:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C8E3176EE;
	Wed, 15 Oct 2025 08:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="k2hrtOR+"
Received: from relay11.grserver.gr (relay11.grserver.gr [78.46.171.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4DE3164D0;
	Wed, 15 Oct 2025 08:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.171.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760518001; cv=none; b=Gkb+9Ue2PRDXOKHkfcf93uGjChJN2vKd18gp3igJ7JjCuJDReTNRYDE80nSzUfQWivKSJNCnUv9MvgHNcvVsOT/gPiDBBUmurJX9oAt7TyOyLhoSmDZYedZtmyNb+LNMukDKe1nWHdqe0NJ7uBXGPBf0C0oq+GOE6bH8p1jv8Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760518001; c=relaxed/simple;
	bh=+o0GsnWnYYH2rYb7oBqdNplXJeBCnaXsrfz/PIRSmqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=avc3pWubYDpgHl6cQ60Bc5v5DzKrOGO37wxbRhX+qUa1Oy054AxmGUK1b1pCcDqTYGDhrZgzQPoqpC1+WciA0GH7FIn5Mibk6T2LuymuFLQyiY8CLMjuxUqZd8YuCGqO7im6haaJCtQJ5z2WnyMTQnGOYP1ZnoWeAxZoNPlTWuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=k2hrtOR+; arc=none smtp.client-ip=78.46.171.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay11 (localhost.localdomain [127.0.0.1])
	by relay11.grserver.gr (Proxmox) with ESMTP id 1320AC572A;
	Wed, 15 Oct 2025 11:46:30 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay11.grserver.gr (Proxmox) with ESMTPS id 444CAC4F7A;
	Wed, 15 Oct 2025 11:46:29 +0300 (EEST)
Received: from antheas-z13 (x5996a8de.customers.hiper-net.dk [89.150.168.222])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 45F74200A81;
	Wed, 15 Oct 2025 11:46:27 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1760517989;
	bh=jxquyYtL0fSzRfx4rbJSB5tzEASoEkljMua5h0I9tcQ=; h=From:To:Subject;
	b=k2hrtOR+XeiXptuYzn6V0a933K1f0fldmX3nam6a97Qp8mnlZaA6jahaCVYtotF56
	 xYnQIv/4zm7djFvbqCi99ZEaO3VEg2cwOJ4jsTiQWg/EdUSL9wA1q+tAPUX0D0jnuc
	 dEnhqjrIp7kKpglOnrxsB3MnrsrMKXdIypYNjZpcqN29o6lpFK0BEf8SMefQR+vFSU
	 BbIHNXlUiKyTFqyMiaTHAjynjWmsx6RV+wI7E9CP3QuCJidiktSPp0Kmal7pyZWdTU
	 MPJI3L/jnSIcyjyynQXsB2WMltYMvTVoFBr4IGOCyVTeEauch5rAlK+gbjfEGJxW8l
	 LeMJk089GzM+g==
Authentication-Results: linux3247.grserver.gr;
	spf=pass (sender IP is 89.150.168.222) smtp.mailfrom=lkml@antheas.dev smtp.helo=antheas-z13
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
Subject: [PATCH v2 0/6] platform/x86: ayaneo-ec: Add Ayaneo Embedded
 Controller platform driver
Date: Wed, 15 Oct 2025 10:44:08 +0200
Message-ID: <20251015084414.1391595-1-lkml@antheas.dev>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <176051798894.920664.10794098439892525348@linux3247.grserver.gr>
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

---

V1: https://lore.kernel.org/all/20250820160628.99678-1-lkml@antheas.dev/

Changes since V1:
  - Use plain sysfs attrs for magic module attributes
  - Combine quirk for power and modules, so attribute tree is simpler
  - Use switch statement in hwmon
  - Add hibernation hook for charge bypass in last patch
    - Restoring fan speed is a liability so it is omitted, see patch notes
      Note that for EC managed fan curves, it would be acceptable
    - Regmap comment: Using regmap is unprecedented for ACPI mapped ECs
      and overkill for one value (> 100 LOC)
  - fixp_linear_interpolate() comment: it requires importing an extra header,
    is not used for static parameters in other modules, and expands to the
    same equation for parameters used, so it is omitted

Antheas Kapenekakis (6):
  platform/x86: ayaneo-ec: Add Ayaneo Embedded Controller platform
    driver
  platform/x86: ayaneo-ec: Add hwmon support
  platform/x86: ayaneo-ec: Add charge control support
  platform/x86: ayaneo-ec: Add controller power and modules attributes
  platform/x86: ayaneo-ec: Move Ayaneo devices from oxpec to ayaneo-ec
  platform/x86: ayaneo-ec: Add suspend hook

 .../ABI/testing/sysfs-platform-ayaneo         |  19 +
 MAINTAINERS                                   |   7 +
 drivers/platform/x86/Kconfig                  |  17 +-
 drivers/platform/x86/Makefile                 |   3 +
 drivers/platform/x86/ayaneo-ec.c              | 541 ++++++++++++++++++
 drivers/platform/x86/oxpec.c                  | 115 +---
 6 files changed, 585 insertions(+), 117 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-ayaneo
 create mode 100644 drivers/platform/x86/ayaneo-ec.c


base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
-- 
2.51.0



