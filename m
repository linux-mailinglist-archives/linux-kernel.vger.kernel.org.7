Return-Path: <linux-kernel+bounces-743180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C99B0FB82
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 22:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1B021889E44
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 20:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E5A226D1B;
	Wed, 23 Jul 2025 20:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ejswudIF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A786C153BE9;
	Wed, 23 Jul 2025 20:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753302781; cv=none; b=FswuJWFL6M0mR+M6aA+4ZEOH7arbxkDT5tUzirE4Eyjwsq+uADWbwRGO6EkHu+HTBwRcTJlUyCEwRaIX1gEEx1zoaH2Jko21rywitroiPLr4uNJXFisgez85MoP5kHuSrMg8WU/XTcTz/Qe7OeIX5YB2swb3z+EjDwkqKzjDvgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753302781; c=relaxed/simple;
	bh=tzUHKd2DCo514hw2NUxvEWvAf2ZgLiRSU8TKD9p51Hc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hbx+NNQMGi2DwezI8R/knU293l+ZkmD+VDDYBCZ+KHlwsiYtpF+z/WwgZ7mFmWz0SAjoOtIwyZ3Wt+ZNWWE7Nwov+duVIl5IoKICDsX9PARmggym7GL8MTfeq2+u+dzquXlDCiFUT6yHaxrwQgA29kFXoF3znbBvROwOi4fa3/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ejswudIF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 064ECC4CEE7;
	Wed, 23 Jul 2025 20:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753302781;
	bh=tzUHKd2DCo514hw2NUxvEWvAf2ZgLiRSU8TKD9p51Hc=;
	h=From:To:Cc:Subject:Date:From;
	b=ejswudIFYgFBlZGyyi7JVCJqUHCuH6cdvcpsU2CgoDs+NYML+q38NaMOQ1kSNVX6B
	 Iv7Z92vSNULyRhNDLp/zScfTGlje6o9Ho/Q7lYE8E3bVwsbLkaBuLvZrMjafFe9Iuu
	 +KSAG9NX15OXMQcp48BJBgjspsgHnWfb3CRZHe6M4pxfpXWUx5cLxabtYpcR+KXoaU
	 wf+4sJNxhGUg5nefPbmzKOijqibBF3OjXt14qH6KTe4vAhKF8XVIGkC9lT+Q6TEsrs
	 feBDArMg+c/LX96DhESE36bC1IX66jznITYkPb7kyVrxaVqaMQP84X9WNSIa4fdVw9
	 1H7Ce9Efh2dnw==
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 0/2] Documentation: Fix typos
Date: Wed, 23 Jul 2025 15:32:40 -0500
Message-ID: <20250723203250.2909894-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

Fix typos.  Based on v6.16-rc1, split into ABI and other.

Bjorn Helgaas (2):
  Documentation: Fix typos
  Documentation/ABI: Fix typos

 .../ABI/obsolete/sysfs-driver-hid-roccat-isku |  2 +-
 .../obsolete/sysfs-driver-hid-roccat-koneplus |  4 +--
 .../ABI/obsolete/sysfs-driver-hid-roccat-savu |  2 +-
 Documentation/ABI/testing/debugfs-driver-dcc  |  2 +-
 Documentation/ABI/testing/debugfs-hyperv      |  4 +--
 Documentation/ABI/testing/rtc-cdev            |  2 +-
 Documentation/ABI/testing/sysfs-ata           |  4 +--
 .../sysfs-bus-event_source-devices-hisi_ptt   |  4 +--
 Documentation/ABI/testing/sysfs-bus-iio       |  2 +-
 .../ABI/testing/sysfs-bus-iio-dma-buffer      |  8 ++---
 Documentation/ABI/testing/sysfs-bus-rapidio   |  2 +-
 Documentation/ABI/testing/sysfs-class-fc      |  2 +-
 .../ABI/testing/sysfs-class-power-rt9467      |  2 +-
 .../ABI/testing/sysfs-driver-input-exc3000    |  4 +--
 Documentation/ABI/testing/sysfs-driver-ufs    |  2 +-
 Documentation/ABI/testing/sysfs-firmware-acpi |  6 ++--
 .../ABI/testing/sysfs-memory-page-offline     | 13 ++++---
 .../PCI/endpoint/pci-endpoint-cfs.rst         |  4 +--
 Documentation/PCI/endpoint/pci-endpoint.rst   |  6 ++--
 Documentation/RCU/lockdep.rst                 |  2 +-
 Documentation/RCU/stallwarn.rst               |  2 +-
 Documentation/accel/qaic/aic100.rst           |  4 +--
 Documentation/accounting/taskstats.rst        |  2 +-
 Documentation/admin-guide/LSM/SafeSetID.rst   |  2 +-
 Documentation/admin-guide/RAS/main.rst        |  2 +-
 Documentation/admin-guide/blockdev/paride.rst |  2 +-
 .../admin-guide/device-mapper/vdo-design.rst  |  2 +-
 Documentation/admin-guide/hw-vuln/mds.rst     |  2 +-
 Documentation/admin-guide/kdump/kdump.rst     |  2 +-
 .../admin-guide/kernel-parameters.txt         | 10 +++---
 Documentation/admin-guide/laptops/sonypi.rst  |  2 +-
 Documentation/admin-guide/media/imx.rst       |  2 +-
 Documentation/admin-guide/media/si4713.rst    |  6 ++--
 Documentation/admin-guide/mm/damon/usage.rst  |  2 +-
 Documentation/admin-guide/perf/hisi-pmu.rst   |  4 +--
 .../quickly-build-trimmed-linux.rst           |  4 +--
 .../admin-guide/reporting-issues.rst          |  4 +--
 .../verify-bugs-and-bisect-regressions.rst    |  2 +-
 Documentation/arch/arm/keystone/knav-qmss.rst |  2 +-
 Documentation/arch/x86/cpuinfo.rst            |  2 +-
 Documentation/core-api/irq/irq-affinity.rst   |  6 ++--
 Documentation/core-api/irq/irq-domain.rst     | 36 +++++++++----------
 .../bindings/sound/davinci-evm-audio.txt      |  2 +-
 Documentation/devicetree/usage-model.rst      |  2 +-
 Documentation/driver-api/vfio.rst             |  2 +-
 Documentation/filesystems/erofs.rst           |  2 +-
 Documentation/filesystems/gfs2-glocks.rst     |  2 +-
 Documentation/filesystems/hpfs.rst            |  2 +-
 Documentation/filesystems/resctrl.rst         |  2 +-
 .../xfs/xfs-online-fsck-design.rst            |  4 +--
 .../firmware-guide/acpi/gpio-properties.rst   |  4 +--
 Documentation/hwmon/f71805f.rst               |  2 +-
 Documentation/misc-devices/apds990x.rst       |  2 +-
 Documentation/mm/hwpoison.rst                 |  2 +-
 Documentation/networking/can.rst              |  2 +-
 .../ethernet/ti/am65_nuss_cpsw_switchdev.rst  |  2 +-
 .../ethernet/ti/cpsw_switchdev.rst            |  2 +-
 Documentation/networking/rds.rst              |  2 +-
 Documentation/power/pci.rst                   |  4 +--
 .../power/suspend-and-cpuhotplug.rst          |  2 +-
 Documentation/sound/cards/emu-mixer.rst       |  2 +-
 Documentation/trace/fprobe.rst                |  2 +-
 Documentation/trace/ftrace-uses.rst           |  2 +-
 Documentation/trace/ftrace.rst                | 14 ++++----
 Documentation/trace/histogram.rst             |  2 +-
 .../translations/zh_TW/process/5.Posting.rst  |  2 +-
 .../userspace-api/media/rc/rc-protos.rst      | 20 +++++------
 67 files changed, 132 insertions(+), 133 deletions(-)

-- 
2.43.0


