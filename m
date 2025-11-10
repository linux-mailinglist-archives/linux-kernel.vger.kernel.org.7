Return-Path: <linux-kernel+bounces-893843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA6EC487C2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 19:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4A5C3A6B87
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 18:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0C8316194;
	Mon, 10 Nov 2025 18:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="NGiRFIvW"
Received: from relay11.grserver.gr (relay11.grserver.gr [78.46.171.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3453128A0;
	Mon, 10 Nov 2025 18:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.171.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762798140; cv=none; b=Hd5CXJNtk5s5zgRivjLh8OsfMtY/LYrLMvzT2kzGwV2nNyo/C46yGfcWhkUGdQHrMsGZBgYT91xSlA0Cc15KdxYkDveFj6jRCoy3iqoz0DK9SWfehRyWfaXc5BAPlQtuPOTVjzqn7QmUBEmLWUBYHCGrakF+ujion++EoUJAia4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762798140; c=relaxed/simple;
	bh=kBmezTJCGwCF0Xm3+En0GTLVE5KOt1l8t8uXDrmXSVc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hNwm5/8zN7kPuRQN5zwiUc22jZvh+TczW00wpkJtcAtjx1WFYmFYKxOe/1oTmK7ka42EviO0PTtIkygyoLnjfuTzIPJMIzedY4MOTuby67l4KmKzJpJTBW+wT8FWtJ/QZLPYtVKQYlZN9NVbzRTZBoVGcXXspIS2xboKszN74Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=NGiRFIvW; arc=none smtp.client-ip=78.46.171.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay11 (localhost.localdomain [127.0.0.1])
	by relay11.grserver.gr (Proxmox) with ESMTP id 4EBF8C300A;
	Mon, 10 Nov 2025 20:08:51 +0200 (EET)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay11.grserver.gr (Proxmox) with ESMTPS id 769D9C2CBB;
	Mon, 10 Nov 2025 20:08:50 +0200 (EET)
Received: from antheas-z13 (unknown [IPv6:2a05:f6c2:511b:0:8d8a:5967:d692:ea4e])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id A01BC1FCFC4;
	Mon, 10 Nov 2025 20:08:49 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1762798130;
	bh=jVewx3ek5Gw0vAkopuKVo74gY283IJ/K3La3r/dmK7U=; h=From:To:Subject;
	b=NGiRFIvWLvxf0zgnQOlsBu6akulrj+EXzMtwk0XsBFOMuW1GG7qzFrS+1UR4DtUO9
	 MPdG76rqGkSxdxDz4giWT36yhzkMEAJCBEjc/NTaest4FGhfQirzKZeA3KOGPNcfi5
	 zaszQG+DxopqapvS4ExP2AZjV4KJ6W6STL6cheCkG8JgN/Ask/xnqDRwGRa29NaWrW
	 oG7gp1uUEXuP7wjTjEXL340LFgZErEW7Cn8CcN8Fb28bl1aCVyBB5+tNfPCnc7WIc2
	 img8lh4K4h4anKTXl998TZw8yWjZ+YtD5nS0K/3cIc94CeFABzsLo7dzNifaW+GZYM
	 slBMaU11Sd+3w==
Authentication-Results: linux3247.grserver.gr;
	spf=pass (sender IP is 2a05:f6c2:511b:0:8d8a:5967:d692:ea4e) smtp.mailfrom=lkml@antheas.dev smtp.helo=antheas-z13
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
Subject: [PATCH v4 0/6] platform/x86: ayaneo-ec: Add Ayaneo Embedded
 Controller platform driver
Date: Mon, 10 Nov 2025 19:08:40 +0100
Message-ID: <20251110180846.1490726-1-lkml@antheas.dev>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <176279813014.3664465.16699886879339568418@linux3247.grserver.gr>
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
V3: https://lore.kernel.org/all/20251031163651.1465981-1-lkml@antheas.dev/
V2: https://lore.kernel.org/all/20251015084414.1391595-1-lkml@antheas.dev/
V1: https://lore.kernel.org/all/20250820160628.99678-1-lkml@antheas.dev/

Changes since V3:
  - Move ABI date to November
  - Add mutex to suspend hook and cleanup
  - Fix data access from within hwmon in suspend hook

Changes since V2:
  - Fix various non-functional nits
  - On hibernation restore, use restore instead of thaw, switch to bools,
    and restore fan pwm mode, but only after the first pwm write after
    hibernation. Also, release pwm when entering hibernation.

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

 .../ABI/testing/sysfs-platform-ayaneo-ec      |  19 +
 MAINTAINERS                                   |   7 +
 drivers/platform/x86/Kconfig                  |  16 +-
 drivers/platform/x86/Makefile                 |   3 +
 drivers/platform/x86/ayaneo-ec.c              | 591 ++++++++++++++++++
 drivers/platform/x86/oxpec.c                  | 115 +---
 6 files changed, 634 insertions(+), 117 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-ayaneo-ec
 create mode 100644 drivers/platform/x86/ayaneo-ec.c


base-commit: e9a6fb0bcdd7609be6969112f3fbfcce3b1d4a7c
-- 
2.51.2



