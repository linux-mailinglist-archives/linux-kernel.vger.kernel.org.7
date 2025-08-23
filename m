Return-Path: <linux-kernel+bounces-783102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64450B32962
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 16:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FED51885FDD
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 14:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F75229B77C;
	Sat, 23 Aug 2025 14:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GZ0U1lwO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79A429CB56;
	Sat, 23 Aug 2025 14:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755960289; cv=none; b=EgvLz52ft1syfxsQ5shKaOyShAZ2HsBMEtJ5kB+SXSUxR117KhufVXTAJfEzCrHMfbfNRCWH9m3T5x3hz1urLGAjsJFMlRt2+LiBtjA9RiINA2wp0qDfmlkWtKxSfXzP4HLtZSDUDmQ02BTe31dq6lEt777h2UvYDPeXm8dNz5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755960289; c=relaxed/simple;
	bh=XLNrun7kIQT0mqwRRQMKsvdopi3C5S5qwDroaXv6eG0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PV1ZN6KMpXTIIiOtLYCFe6D5g9KArZdsWKh29Uj5LU1jZf6Gi4+DazNysRIgnptWbHqxATHDYZARCSvQdg6SPbR1tzGqv7DWOMWK6cvYfAqcKA0cuxz6RyHG/JuflnND3/aZKquAwdHxSwbqVpdDKmM7QF1YDpY92/pEPNVqglY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GZ0U1lwO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E44D5C4CEE7;
	Sat, 23 Aug 2025 14:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755960289;
	bh=XLNrun7kIQT0mqwRRQMKsvdopi3C5S5qwDroaXv6eG0=;
	h=Date:From:To:Cc:Subject:From;
	b=GZ0U1lwOKx2sLU1WmkoD6So2eMp9mWJ16iqwQxRUgZNwJMlUAgG3d5BseorFi9YPe
	 sS8QZsjaWHnhjR6BLzrTBsleSjqZVkANwyAinIn7PQFm3y0u7ZgYrBuDkE/xF2ngXV
	 1yOuoSe+zTavB/ewPWaeYGfxEZp4dIVkY7Zvty90=
Date: Sat, 23 Aug 2025 16:44:46 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [GIT PULL] USB driver fixes for 6.17-rc3
Message-ID: <aKnT3gmJbnYFoALE@kroah.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.17-rc3

for you to fetch changes up to ff9a09b3e09c7b794b56f2f5858f5ce42ba46cb3:

  usb: xhci: fix host not responding after suspend and resume (2025-08-19 16:12:13 +0200)

----------------------------------------------------------------
USB fixes for 6.17-rc3

Here are some small USB driver fixes for 6.17-rc3 to resolve a bunch of
reported issues.  Included in here are:
  - typec driver fixes
  - dwc3 new device id
  - dwc3 driver fixes
  - new usb-storage driver quirks
  - xhci driver fixes
  - other tiny USB driver fixes to resolve bugs

All of these have been in linux-next this week with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alan Stern (1):
      USB: core: Update kerneldoc for usb_hcd_giveback_urb()

Amit Sunil Dhamne (2):
      usb: typec: maxim_contaminant: disable low power mode when reading comparator values
      usb: typec: maxim_contaminant: re-enable cc toggle if cc is open and port is clean

Heikki Krogerus (1):
      usb: dwc3: pci: add support for the Intel Wildcat Lake

Kuen-Han Tsai (1):
      usb: dwc3: Ignore late xferNotReady event to prevent halt timeout

Mael GUERIN (1):
      USB: storage: Add unusual-devs entry for Novatek NTK96550-based camera

Marek Vasut (1):
      usb: renesas-xhci: Fix External ROM access timeouts

Miao Li (1):
      usb: quirks: Add DELAY_INIT quick for another SanDisk 3.2Gen1 Flash Drive

Niklas Neronin (1):
      usb: xhci: fix host not responding after suspend and resume

Russell King (Oracle) (1):
      usb: gadget: tegra-xudc: fix PM use count underflow

Sebastian Andrzej Siewior (1):
      kcov, usb: Don't disable interrupts in kcov_remote_start_usb_softirq()

Sebastian Reichel (1):
      usb: typec: fusb302: Revert incorrect threaded irq fix

Selvarasu Ganesan (1):
      usb: dwc3: Remove WARN_ON for device endpoint command timeouts

Thorsten Blum (1):
      usb: storage: realtek_cr: Use correct byte order for bcs->Residue

Weitao Wang (1):
      usb: xhci: Fix slot_id resource race conflict

Xu Yang (2):
      usb: core: hcd: fix accessing unmapped memory in SINGLE_STEP_SET_FEATURE test
      usb: chipidea: imx: improve usbmisc_imx7d_pullup()

Zenm Chen (1):
      USB: storage: Ignore driver CD mode for Realtek multi-mode Wi-Fi dongles

 drivers/usb/chipidea/ci_hdrc_imx.c         |  3 +-
 drivers/usb/chipidea/usbmisc_imx.c         | 23 ++++++++----
 drivers/usb/core/hcd.c                     | 28 ++++++++-------
 drivers/usb/core/quirks.c                  |  1 +
 drivers/usb/dwc3/dwc3-pci.c                |  2 ++
 drivers/usb/dwc3/ep0.c                     | 20 ++++++++---
 drivers/usb/dwc3/gadget.c                  | 19 ++++++++--
 drivers/usb/gadget/udc/tegra-xudc.c        |  9 +++--
 drivers/usb/host/xhci-hub.c                |  3 +-
 drivers/usb/host/xhci-mem.c                | 22 ++++++------
 drivers/usb/host/xhci-pci-renesas.c        |  7 ++--
 drivers/usb/host/xhci-ring.c               |  9 +++--
 drivers/usb/host/xhci.c                    | 23 ++++++++----
 drivers/usb/host/xhci.h                    |  3 +-
 drivers/usb/storage/realtek_cr.c           |  2 +-
 drivers/usb/storage/unusual_devs.h         | 29 +++++++++++++++
 drivers/usb/typec/tcpm/fusb302.c           | 12 ++++---
 drivers/usb/typec/tcpm/maxim_contaminant.c | 58 ++++++++++++++++++++++++++++++
 drivers/usb/typec/tcpm/tcpci_maxim.h       |  1 +
 include/linux/kcov.h                       | 47 +++++-------------------
 20 files changed, 224 insertions(+), 97 deletions(-)

