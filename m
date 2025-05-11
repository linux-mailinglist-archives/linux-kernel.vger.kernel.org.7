Return-Path: <linux-kernel+bounces-643342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CDEAAB2B3C
	for <lists+linux-kernel@lfdr.de>; Sun, 11 May 2025 22:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66D0818992A9
	for <lists+linux-kernel@lfdr.de>; Sun, 11 May 2025 20:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6DC262D0B;
	Sun, 11 May 2025 20:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="kI9MxO1m"
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3325B25E830;
	Sun, 11 May 2025 20:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746996807; cv=none; b=KtaYu/ObYVOGk5QSYX+dI57yl9liqJXa3s2X924jonYiuHHh0Oip+cRvm10qfPVFot+40rRYX6WySiiYHxBaxvA+pPLWba57dYUZOVQfkbkFDZXkunjFc9ypp70hgrSvzqxsDVvH6RvuOGQJ0LYSw+hBv27t3YpAIUpiavsMMvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746996807; c=relaxed/simple;
	bh=csg+A7Bhp01hECOFFManlrmGorkh6UdbFJH4llgO7MM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YRs1GC0Sp/tiAl1cwek2E7Dw04OMd8Katk0XDAL8XdvIrXM8DYz0x4XIpPu9Bhi7jGbL0lYh6SiDqgGmr2gpexL8xlibbaZjoTCX6LbQl83U0ecKN1EXiEJ33QROwim2pXUprkYj0g2/6yNcbKuHaGSlK9T9xeP7m5gj2mvMV/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=kI9MxO1m; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from localhost.localdomain (x5996a826.customers.hiper-net.dk [89.150.168.38])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 8CDEA2E0A418;
	Sun, 11 May 2025 23:44:35 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1746996277;
	bh=Rp8WBypSDO+ZIBKX6G/H59IRWLeWcZlkVKkdbkhSt18=; h=From:To:Subject;
	b=kI9MxO1maPq9CIL/1NXeDogXNMRY0P8eIGOcfUL/yip3h9QKGg11JgMj56hqSbplD
	 V8DnWxgjV3wMdFAiBjy001fIBHVmUQUKSa/LErMYAUcaKUbOfjV+rTTNCMNbVi9ca1
	 SnTBIjuO9oPWUW/dW23u4b1lEuiQVnawBy/RfC7M=
Authentication-Results: linux1587.grserver.gr;
	spf=pass (sender IP is 89.150.168.38) smtp.mailfrom=lkml@antheas.dev smtp.helo=localhost.localdomain
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
From: Antheas Kapenekakis <lkml@antheas.dev>
To: platform-driver-x86@vger.kernel.org
Cc: Armin Wolf <W_Armin@gmx.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Kurt Borja <kuurtb@gmail.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	Antheas Kapenekakis <lkml@antheas.dev>
Subject: [PATCH v1 00/10] platform/x86: msi-wmi-platform: Add fan
 curves/platform profile/tdp/battery limiting
Date: Sun, 11 May 2025 22:44:17 +0200
Message-ID: <20250511204427.327558-1-lkml@antheas.dev>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <174699627737.27496.1574115942377532855@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

This draft patch series brings into parity the msi-wmi-platform driver with
the MSI Center M Windows application for the MSI Claw (all models).
Unfortunately, MSI Center M and this interface do not have a discovery API,
necessitating the introduction of a quirk system.

While this patch series is fully functional and tested, there are still
some issues that need to be addressed:
  - Armin notes we need to disable fan curve support by default and quirk
    it as well, as it is not supported on all models. However, the way
    PWM enable ops work, this makes it a bit difficult, so I would like
    some suggestions on how to rework this.
  - It turns out that to fully disable the fan curve, we have to restore
    the default fan values. This is also what is done on the OEM software.
    For this, the last patch in the series is used, which is a bit dirty.

Sleep was tested with all values being preserved during S0iX (platform
profile, fan curve, PL1/PL2), so we do not need suspend/resume hooks, at
least for the Claw devices.

For PL1/PL2, we use firmware-attributes. So for that I +cc Kurt since if
his new high level interface is merged beforehand, we can use that instead.

Antheas Kapenekakis (8):
  platform/x86: msi-wmi-platform: Add unlocked msi_wmi_platform_query
  platform/x86: msi-wmi-platform: Add quirk system
  platform/x86: msi-wmi-platform: Add platform profile through shift
    mode
  platform/x86: msi-wmi-platform: Add PL1/PL2 support via firmware
    attributes
  platform/x86: msi-wmi-platform: Add charge_threshold support
  platform/x86: msi-wmi-platform: Drop excess fans in dual fan devices
  platform/x86: msi-wmi-platform: Update header text
  platform/x86: msi-wmi-platform: Restore fan curves on PWM disable and
    unload

Armin Wolf (2):
  platform/x86: msi-wmi-platform: Use input buffer for returning result
  platform/x86: msi-wmi-platform: Add support for fan control

 .../wmi/devices/msi-wmi-platform.rst          |   26 +
 drivers/platform/x86/Kconfig                  |    3 +
 drivers/platform/x86/msi-wmi-platform.c       | 1181 ++++++++++++++++-
 3 files changed, 1156 insertions(+), 54 deletions(-)


base-commit: 62b1dcf2e7af3dc2879d1a39bf6823c99486a8c2
-- 
2.49.0


