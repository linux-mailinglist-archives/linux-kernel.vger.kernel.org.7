Return-Path: <linux-kernel+bounces-767433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E5EB2542D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 22:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F1C57AF3F1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 20:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8CE2C0F6E;
	Wed, 13 Aug 2025 20:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uMJJFcAb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E39F2F99A1;
	Wed, 13 Aug 2025 20:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755115537; cv=none; b=VqvkWt7y0ekrfsgkucsuANghSx5vf8S3QPRzvQsqt5lljn8Y/lx5azpDR0JiCMlYLoZPmF0TD36g9GtPruxR26VyMl17HjZjMEUYoN21TlHmMXUxI+9+EoTRz5WL7I0mrx9iZLrbe4uWkexlHM5oz5UDAHuJSSqPE6fWkKAsLVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755115537; c=relaxed/simple;
	bh=ZUwZbMTC6lo6ReIpf7yjreRb8WhP90AUcs5gPWZW7kE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jsWZihOadBgGsFf/O4pm8P6MZU6jyR2yGuHS3I14WbxZ9csNx5tkmME4hTeyAbnzfnQen5IXkaCHxmk1auYZ3lMh2b/D1mlmscbX+Fi6h1dg278vEvwVSVBnsf3M/1s1ggZ+mUbZcIIpBNRyrukmw3xHAn9i8dUolfD5AJk5LHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uMJJFcAb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2EFDC4CEEB;
	Wed, 13 Aug 2025 20:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755115536;
	bh=ZUwZbMTC6lo6ReIpf7yjreRb8WhP90AUcs5gPWZW7kE=;
	h=From:To:Cc:Subject:Date:From;
	b=uMJJFcAbdTYirOSMj6ktozgIfnQEZBSDoBxKxhHqGSU+CqtMJsOcQesNdkjxVme9Q
	 wASi7Z3WCz4My/U0JUrK9xyTmvNZNYrYHEXf82U/nBN36hq1JULnQN5e5rPyHPEXn6
	 zY4agoo6A4Udaed5HD/l/+QSoBz7f+hSeybpmvg3n/goPWtIcrilB9E12O6QN8hYED
	 Pj6QfKCMzyTo0DyEIbrWsqAt9L6yfMHc2tynGOW7x0+ut+IC+Pql0Qx8ObNjurixFE
	 w/5S3BaNfuKFHOclQzfHZWrAu4ocgrZFWzSTBUvGcjQVqCV5LV4OxUYYIRH2Xn4XQf
	 PRlQxj74OC+nA==
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Randy Dunlap <rdunlap@infradead.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 0/9] Documentation: Fix typos
Date: Wed, 13 Aug 2025 15:04:56 -0500
Message-ID: <20250813200526.290420-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

Fix typos in Documentation/.  Based on v6.17-rc1.

"git log -p --word-diff" or similar might make this easier to review.

Feel free drop any conflicts; nothing here touches code or messages.

Bjorn Helgaas (9):
  Documentation: Fix PCI typos
  Documentation: Fix RCU typos
  Documentation: Fix admin-guide typos
  Documentation: Fix core-api typos
  Documentation: Fix filesystems typos
  Documentation: Fix networking typos
  Documentation: Fix power typos
  Documentation: Fix trace typos
  Documentation: Fix misc typos

 .../PCI/endpoint/pci-endpoint-cfs.rst         |  4 +-
 Documentation/PCI/endpoint/pci-endpoint.rst   |  6 +--
 Documentation/RCU/lockdep.rst                 |  2 +-
 Documentation/RCU/stallwarn.rst               |  2 +-
 Documentation/accel/qaic/aic100.rst           |  4 +-
 Documentation/accounting/taskstats.rst        |  2 +-
 Documentation/admin-guide/LSM/SafeSetID.rst   |  2 +-
 Documentation/admin-guide/RAS/main.rst        |  2 +-
 Documentation/admin-guide/blockdev/paride.rst |  2 +-
 .../admin-guide/device-mapper/vdo-design.rst  |  2 +-
 Documentation/admin-guide/hw-vuln/mds.rst     |  2 +-
 Documentation/admin-guide/kdump/kdump.rst     |  2 +-
 .../admin-guide/kernel-parameters.txt         | 12 +++---
 Documentation/admin-guide/laptops/sonypi.rst  |  2 +-
 Documentation/admin-guide/media/imx.rst       |  2 +-
 Documentation/admin-guide/media/si4713.rst    |  6 +--
 Documentation/admin-guide/mm/damon/usage.rst  |  2 +-
 Documentation/admin-guide/perf/hisi-pmu.rst   |  4 +-
 .../quickly-build-trimmed-linux.rst           |  4 +-
 .../admin-guide/reporting-issues.rst          |  4 +-
 .../verify-bugs-and-bisect-regressions.rst    |  2 +-
 Documentation/arch/arm/keystone/knav-qmss.rst |  2 +-
 Documentation/arch/x86/cpuinfo.rst            |  2 +-
 Documentation/core-api/irq/irq-affinity.rst   |  6 +--
 Documentation/core-api/irq/irq-domain.rst     | 38 +++++++++----------
 Documentation/devicetree/usage-model.rst      |  2 +-
 Documentation/driver-api/vfio.rst             |  2 +-
 Documentation/filesystems/erofs.rst           |  2 +-
 Documentation/filesystems/gfs2-glocks.rst     |  2 +-
 Documentation/filesystems/hpfs.rst            |  2 +-
 Documentation/filesystems/resctrl.rst         |  2 +-
 .../xfs/xfs-online-fsck-design.rst            |  4 +-
 Documentation/hwmon/f71805f.rst               |  2 +-
 Documentation/misc-devices/apds990x.rst       |  2 +-
 Documentation/mm/hwpoison.rst                 |  2 +-
 Documentation/networking/can.rst              |  2 +-
 .../ethernet/ti/am65_nuss_cpsw_switchdev.rst  |  2 +-
 .../ethernet/ti/cpsw_switchdev.rst            |  2 +-
 Documentation/networking/rds.rst              |  2 +-
 Documentation/power/pci.rst                   |  4 +-
 .../power/suspend-and-cpuhotplug.rst          |  2 +-
 Documentation/sound/cards/emu-mixer.rst       |  2 +-
 Documentation/trace/fprobe.rst                |  2 +-
 Documentation/trace/ftrace-uses.rst           |  2 +-
 Documentation/trace/ftrace.rst                | 14 +++----
 Documentation/trace/histogram.rst             |  2 +-
 .../translations/zh_TW/process/5.Posting.rst  |  2 +-
 .../userspace-api/media/rc/rc-protos.rst      | 20 +++++-----
 48 files changed, 99 insertions(+), 99 deletions(-)

-- 
2.43.0


