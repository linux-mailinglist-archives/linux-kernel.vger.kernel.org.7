Return-Path: <linux-kernel+bounces-839553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0AEBB1DEA
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 23:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31248192468B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 21:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365E531194C;
	Wed,  1 Oct 2025 21:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="F5KevJI2"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08F2175A5
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 21:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759354799; cv=none; b=AY68s4qFoVux4W4Pj96fEHF1THX35DqXFmwcGw2a0zfLoClo7jPWmi0tVNWu8y6mJ5nvp1CkulmWWAjjCUhCh0Dbe6S5t/V97qkWyftO4aOpVn2IGZPkS1a25F/TQzZK7zwNlavRUtjOzrw52amEf6+235Mxpy/d3BEebPAUfRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759354799; c=relaxed/simple;
	bh=kj2CZ72WDmc/ZNw0I/6sNhH1wvt7ixQFQT+wm9fP290=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=AwQgkcmZiPJSJdkozcxi4u8EcwKZiorCywvxV2c0jolSAXXZaVw3EZKeQe9HwyY5OoGswKakarMCLCP6UFJHQw9GMXf/X5wSF7+n3DT5sGWC2DSjyh/8pUxOEkRTp95F6BQUs+5AsakPSVdSEYd4Nf1dZQo5RxQbovo/BwDRMrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=F5KevJI2; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 3BDFE1A0FFA;
	Wed,  1 Oct 2025 21:39:53 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0A2C0606BF;
	Wed,  1 Oct 2025 21:39:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 76BD4102F1A54;
	Wed,  1 Oct 2025 23:39:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1759354792; h=from:subject:date:message-id:to:cc:mime-version:content-type;
	bh=lHs+a0zQYhMAuhiPsL2CDQSj6H2mO9Qd4Q2C0SoNsNI=;
	b=F5KevJI2w/SNO1BFa7n1/Auh1UDMXyo/T7Iz5z93/FZv0pRMQ+Z/tlks9NObnirfbo72nZ
	9ZtKYPSyvFOS66uZRUMwRSdT2Gaw0VH5UJ1ktuimYs2Tj/lgYuyWUdXsHsuZrBkE+w9BMk
	AjQQMufjuOHiM2WFNBy/cAUH2swB55s9N6f1GfNoEoV8YIKzM3dWVUmQYqhfM9xEGdz9FD
	dsp6feXx5Q1eRFbwjZpfLzWnDOeje3CkVF1eAKFmLJQEQp7x42UOvzBji4KuJTk4nQ/SZZ
	HWGROzAXzzYEuyavF5EKu/NoZMmcXFYGkuNk4SqCpSA8mdYbXUJYxIYpG1YEcg==
Date: Wed, 1 Oct 2025 23:39:49 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] I3C changes for 6.18
Message-ID: <2025100121394906389990@mail.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3

Hello Linus,

Here is the i3c subsystem pull request for 6.18. Another controller
driver has been added this cycle. We also have many improvements for the
mipi-i3c-hci driver.

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git tags/i3c/for-6.18

for you to fetch changes up to d6ddd9beb1a5c32acb9b80f5c2cd8b17f41371d1:

  i3c: fix big-endian FIFO transfers (2025-09-29 00:17:22 +0200)

----------------------------------------------------------------
I3C for 6.18

New driver:
 - Analog Devices I3C Controller

Subsystem:
 - fix big-endian FIFO transfers
 - fix default I2C adapter timeout value

Drivers:
 - dw: shutdown support
 - mipi-i3c-hci: Intel Wildcat Lake-U support, IOMMU support
 - renesas: RZ/V2H(P) and RZ/V2N support

----------------------------------------------------------------
Alexandre Belloni (2):
      i3c: master: adi: fix header location
      i3c: master: adi: fix number of bytes written to fifo

Arnd Bergmann (1):
      i3c: fix big-endian FIFO transfers

Jarkko Nikula (11):
      i3c: mipi-i3c-hci-pci: Add support for Intel Wildcat Lake-U I3C
      i3c: master: Add helpers for DMA mapping and bounce buffer handling
      i3c: mipi-i3c-hci: Use core helpers for DMA mapping and bounce buffering
      i3c: mipi-i3c-hci: Use physical device pointer with DMA API
      i3c: mipi-i3c-hci: Use own DMA bounce buffer management for I2C transfers
      i3c: mipi-i3c-hci: Change interrupt status prints to dev_dbg()
      i3c: mipi-i3c-hci: Remove nonexistent ring interrupt
      i3c: mipi-i3c-hci: Uniform ring number printouts
      i3c: mipi-i3c-hci: Remove function enter DBG() printouts
      i3c: mipi-i3c-hci: Convert remaining DBG() prints to dev_dbg()
      i3c: Fix default I2C adapter timeout value

Jorge Marques (2):
      dt-bindings: i3c: Add adi-i3c-master
      i3c: master: Add driver for Analog Devices I3C Controller IP

Lad Prabhakar (1):
      dt-bindings: i3c: renesas,i3c: Add RZ/V2H(P) and RZ/V2N support

Manikanta Guntupalli (1):
      i3c: dw: Add shutdown support to dw_i3c_master driver

Stanley Chu (2):
      i3c: master: svc: Use manual response for IBI events
      i3c: master: svc: Recycle unused IBI slot

Wolfram Sang (2):
      i3c: renesas: Simplify return statement in 'renesas_i3c_daa'
      i3c: Remove superfluous FIXME

 .../devicetree/bindings/i3c/adi,i3c-master.yaml    |   72 ++
 .../devicetree/bindings/i3c/renesas,i3c.yaml       |   16 +-
 MAINTAINERS                                        |    6 +
 drivers/i3c/internals.h                            |   12 +-
 drivers/i3c/master.c                               |   78 +-
 drivers/i3c/master/Kconfig                         |   11 +
 drivers/i3c/master/Makefile                        |    1 +
 drivers/i3c/master/adi-i3c-master.c                | 1019 ++++++++++++++++++++
 drivers/i3c/master/dw-i3c-master.c                 |   23 +
 drivers/i3c/master/mipi-i3c-hci/cmd_v1.c           |    9 +-
 drivers/i3c/master/mipi-i3c-hci/cmd_v2.c           |    7 +-
 drivers/i3c/master/mipi-i3c-hci/core.c             |   74 +-
 drivers/i3c/master/mipi-i3c-hci/dma.c              |   96 +-
 drivers/i3c/master/mipi-i3c-hci/ext_caps.c         |   11 +-
 drivers/i3c/master/mipi-i3c-hci/hci.h              |    6 +-
 drivers/i3c/master/mipi-i3c-hci/mipi-i3c-hci-pci.c |    3 +
 drivers/i3c/master/mipi-i3c-hci/pio.c              |   75 +-
 drivers/i3c/master/renesas-i3c.c                   |    2 +-
 drivers/i3c/master/svc-i3c-master.c                |   31 +-
 include/linux/i3c/master.h                         |   26 +
 20 files changed, 1410 insertions(+), 168 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i3c/adi,i3c-master.yaml
 create mode 100644 drivers/i3c/master/adi-i3c-master.c

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

