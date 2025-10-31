Return-Path: <linux-kernel+bounces-880618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5F9C26255
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 17:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7A7FA4E2BAE
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 16:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7F828A1CC;
	Fri, 31 Oct 2025 16:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="JJhwJ1c8"
Received: from relay10.grserver.gr (relay10.grserver.gr [37.27.248.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0DB1E520A;
	Fri, 31 Oct 2025 16:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.27.248.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761928622; cv=none; b=a8jtjgmljIbccBHCbOe1NuxdG9Jzh2rB4P+A1jyL4qPygUEiFOLdJM+vSP7ky8A/adYMNl2A0Op7nbuu3sC0XfwEJCvM2FV0MiYwoVte0d+suNVObdIkvpYSGm6my3pAVyCH5q8uKBbxeaxrlBHNxJ9U7jf4Ho6BVAfUc+vW4E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761928622; c=relaxed/simple;
	bh=09bq7dvmZAj2kv5tbJYna197iLNeKWqUeV9DD6XmB/I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bz42Xhehwf7bfY3nI2ZBOOAy0WpKtvpCK+NjR1TeSkNTk0m4inWsXug69MzDed6JyJLF2hJZHxDn1fJhxxNst3eurZNuTBRpe0YIfCZygqalGL/9x0uqn4J3ARR6AeHUq5aJuomm9tFnsqjL8LJh72dgJYqaPAw4/wFTBSLunIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=JJhwJ1c8; arc=none smtp.client-ip=37.27.248.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay10 (localhost.localdomain [127.0.0.1])
	by relay10.grserver.gr (Proxmox) with ESMTP id 7D31E46404;
	Fri, 31 Oct 2025 18:36:55 +0200 (EET)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay10.grserver.gr (Proxmox) with ESMTPS id 55FF74648B;
	Fri, 31 Oct 2025 18:36:54 +0200 (EET)
Received: from antheas-z13 (unknown [IPv6:2a05:f6c2:511b:0:8d8a:5967:d692:ea4e])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 46B9B200C0C;
	Fri, 31 Oct 2025 18:36:53 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1761928613;
	bh=S0o0HiGbs6mTzLuf97OCE5con7cXdx7LusBICJLrVkk=; h=From:To:Subject;
	b=JJhwJ1c8ca0u3OxoFQ+DGY3gfGnSRnMaFm/kVYvddr4QRSImlIhb396rBNM7W9Dg7
	 DW/bVCrgvIqNiYGKpX9hiOLJ+ZNonhWl8eINTuDuGwFSLObMMTSMurMZw3Ot26Z8AE
	 Tiehv6obAadvsCJlJal/ZfznBw/CBr5UeokPM+KUU6TIiK2jlipa8NN86P1bs/kHW7
	 qupJQtTyn7/zh/bUqFniSgbQKG5LVloMmRvj36sMYW/dxgMR4A3e4O4duMrn4LYaOO
	 fq7orgGSVUdEvByo40NBUeOdeQXsy7aEBx5xbrm1qu1r5xxnm0RyCXIWesKJr+xNn8
	 IP6Ghg+hFIdYw==
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
Subject: [PATCH v3 0/6] platform/x86: ayaneo-ec: Add Ayaneo Embedded
 Controller platform driver
Date: Fri, 31 Oct 2025 17:36:45 +0100
Message-ID: <20251031163651.1465981-1-lkml@antheas.dev>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <176192861378.3949006.2547249137033292293@linux3247.grserver.gr>
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

V3: https://lore.kernel.org/all/20251015084414.1391595-1-lkml@antheas.dev/
V2: https://lore.kernel.org/all/20251015084414.1391595-1-lkml@antheas.dev/
V1: https://lore.kernel.org/all/20250820160628.99678-1-lkml@antheas.dev/

Changes since V3:
  - Fix various non-functional nits
  - On hibernation restore, use restore instead of thaw, switch to bools,
    and restore fan pwm mode, but only after the first pwm write after
    hibernation. Also, release pwm when entering hibernation.

Changes since V2:
  - Remove i counter from suspend hook by hardcoding the index
    (we already allocate the maximum size for the cache anyway)
  - Rename quirks to end in quirks
  - Add missing includes to controller sysfs patch, use switch statement

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
 drivers/platform/x86/ayaneo-ec.c              | 582 ++++++++++++++++++
 drivers/platform/x86/oxpec.c                  | 115 +---
 6 files changed, 625 insertions(+), 117 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-ayaneo-ec
 create mode 100644 drivers/platform/x86/ayaneo-ec.c


base-commit: 211ddde0823f1442e4ad052a2f30f050145ccada
-- 
2.51.1



