Return-Path: <linux-kernel+bounces-754242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA457B190C8
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 01:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F8D018990B0
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 23:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C1B2749D3;
	Sat,  2 Aug 2025 23:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lnRTrcz4"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB8415853B
	for <linux-kernel@vger.kernel.org>; Sat,  2 Aug 2025 23:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754177225; cv=none; b=Yqub6GP7KTWp+9/aD99+YeXsE85Fo7jr45s8J/d3JD82i3MYZrrOQMl7Cst8njwIsMadjLvs1r1FaQsv9o62Bn80BKFRnOs6oC+e/ig6x+9b9NIgD0vdqWWH4EUEG4h9i7T6t3zgWWcjKkV91/QUri+ugeCl8+03HPGFQWXABP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754177225; c=relaxed/simple;
	bh=4kyNTVslHOqedJUEZVpHi+XVmT3+/VWMNpTIA9DnM+c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mX6wTR6mCLJJ0FWVS98pUsxQ6D6o/pEFU0CVmlhPFsaVVEVPHXVG76e3scsIrtXqGaaOBfpfYnbdz8g6JaKJ+RSniyC0p5L21A3qQxo2U2lAqOfefW1HXCnm1SZs/2Ft23660ahYDzSiwqhTIyZKoqaK+bKLOoQj73R8yjHWnJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lnRTrcz4; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C08331F68D;
	Sat,  2 Aug 2025 23:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1754177215;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=jYVXXKBsIzJHgP3r/GynpoEXRvPIuovCsUvYjh/Xw3s=;
	b=lnRTrcz4xln+EzV6jw7K5cKuy3O4Zx6daw+QWRCkDRzXNKJ/ZYixWcMLRqWlhFvRx8nxoS
	X5xgkbGEgStW/OL3GoxsYiyNY7+v90GCCh6xii3jJubBbATGKcDPZ89uBVcVGo4Umq/IYd
	kw2Apub4gWXdon0w5EKenT91CoVJLTK94iaNA1srNM1vqfiF4rn3H8DYcvDSY3g8EQThYW
	S02om6WlBEjeveC6LXBI2wIRXI2/8Y63tLr5DOcEjGFZdSCKVbm00y3RfdBqaumAqlXW9A
	znuoPUbK0zqUzvhQA8eyc8DsFbbb4X+Lf+h60kklOLbZ1aRiBB3pBjfip90RHw==
Date: Sun, 3 Aug 2025 01:26:54 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] I3C changes for 6.17
Message-ID: <20250802232654918f2886@mail.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdejkeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfggtggusehttdertddttddvnecuhfhrohhmpeetlhgvgigrnhgurhgvuceuvghllhhonhhiuceorghlvgigrghnughrvgdrsggvlhhlohhnihessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhephfegfefhtdehgffgkedtfeelkedugefgtdeugeegffdvkeefjefhkefhffetvdeknecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpsghoohhtlhhinhdrtghomhenucfkphepvdgrtddumegvtdgrmedvugemieefjedtmeejkegvtdemtgdtvgekmedvkedtieemkegrtgeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedvugemieefjedtmeejkegvtdemtgdtvgekmedvkedtieemkegrtgeipdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpegrlhgvgigrnhgurhgvrdgsvghllhhonhhisegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeefpdhrtghpthhtohepthhorhhvrghlughssehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehlihhnuhigqdhifegtsehlihhsthhsrdhinhhfr
 hgruggvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: alexandre.belloni@bootlin.com

Hello Linus,

Here is the i3c subsystem pull request for 6.17. Most of the changes are
preparation for the driver for a new controller and the driver itself.

The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494:

  Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git tags/i3c/for-6.17

for you to fetch changes up to 3b661ca549b9e5bb11d0bc97ada6110aac3282d2:

  i3c: add missing include to internal header (2025-07-31 02:25:17 +0200)

----------------------------------------------------------------
I3C for 6.17

New driver:
 - Renesas I3C controller

Subsystem:
 - use adapter timeout value for I2C transfers
 - don't fail if GETHDRCAP is unsupported
 - replace ENOTSUPP with SUSV4-compliant EOPNOTSUPP

Drivers:
 - svc: Fix npcm845 FIFO_EMPTY quirk

----------------------------------------------------------------
Arnd Bergmann (1):
      i3c: fix module_i3c_i2c_driver() with I3C=n

Bagas Sanjaya (1):
      i3c: Fix i3c_device_do_priv_xfers() kernel-doc indentation

Jorge Marques (4):
      i3c: master: Initialize ret in i3c_i2c_notifier_call()
      i3c: master: Add inline i3c_readl_fifo() and i3c_writel_fifo()
      i3c: master: cdns: Use i3c_writel_fifo() and i3c_readl_fifo()
      i3c: master: dw: Use i3c_writel_fifo() and i3c_readl_fifo()

Krzysztof Kozlowski (1):
      i3c: master: cdns: Simplify handling clocks in probe()

Sakari Ailus (2):
      i3c: master: svc: Remove redundant pm_runtime_mark_last_busy() calls
      i3c: dw: Remove redundant pm_runtime_mark_last_busy() calls

Stanley Chu (1):
      i3c: master: svc: Fix npcm845 FIFO_EMPTY quirk

Tommaso Merciai (1):
      dt-bindings: i3c: Add Renesas I3C controller

Wolfram Sang (14):
      i3c: dw: use adapter timeout value for I2C transfers
      i3c: master: cdns: use adapter timeout value for I2C transfers
      i3c: mipi-i3c-hci: use adapter timeout value for I2C transfers
      i3c: master: svc: use adapter timeout value for I2C transfers
      i3c: add patchwork entry to MAINTAINERS
      i3c: don't fail if GETHDRCAP is unsupported
      i3c: master: replace ENOTSUPP with SUSV4-compliant EOPNOTSUPP
      i3c: dw: replace ENOTSUPP with SUSV4-compliant EOPNOTSUPP
      i3c: master: cdns: replace ENOTSUPP with SUSV4-compliant EOPNOTSUPP
      i3c: prefix hexadecimal entries in sysfs
      i3c: Standardize defines for specification parameters
      i3c: Add more parameters for controllers to the header
      i3c: master: Add basic driver for the Renesas I3C controller
      i3c: add missing include to internal header

 .../devicetree/bindings/i3c/renesas,i3c.yaml       |  179 +++
 MAINTAINERS                                        |    8 +
 drivers/i3c/device.c                               |   11 +-
 drivers/i3c/internals.h                            |   38 +
 drivers/i3c/master.c                               |   38 +-
 drivers/i3c/master/Kconfig                         |   10 +
 drivers/i3c/master/Makefile                        |    1 +
 drivers/i3c/master/dw-i3c-master.c                 |   47 +-
 drivers/i3c/master/i3c-master-cdns.c               |   90 +-
 drivers/i3c/master/mipi-i3c-hci/core.c             |    2 +-
 drivers/i3c/master/renesas-i3c.c                   | 1404 ++++++++++++++++++++
 drivers/i3c/master/svc-i3c-master.c                |   30 +-
 include/linux/i3c/device.h                         |    4 +-
 include/linux/i3c/master.h                         |   13 +-
 14 files changed, 1727 insertions(+), 148 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i3c/renesas,i3c.yaml
 create mode 100644 drivers/i3c/master/renesas-i3c.c

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

