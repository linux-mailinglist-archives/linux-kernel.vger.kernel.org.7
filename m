Return-Path: <linux-kernel+bounces-748291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE1BB13F17
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 17:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B52021609E8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 15:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9365272819;
	Mon, 28 Jul 2025 15:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1P3s1fhu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1A926D4E4;
	Mon, 28 Jul 2025 15:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753717461; cv=none; b=lStLF4hIXbCnozamyX/h5qC+TBq0FsMXiLbiv0G2XT4ccSPglOQzJxdAF2CLk4NHC5pyg8AkiXBtjK9OecMaSNmbhYTFwCGnjYFMdJOUQ6lWYrzqnfvmwaV3z3DfLUV2A/gaDeIub3D+HwuGbY2vJNQO3OiGmXKIyoPcy6r/giY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753717461; c=relaxed/simple;
	bh=QHYzZrNRpbqv8YnzcImUFT1caQKEPMQJ29G73MsnVO8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gcfsKstQcqH0hhwptEc2+dQs7VbAIOBgZk8Dbk0Nwuf39mf6/H9Jlubl5/LPmkBFMc/WdX1IWhlzOKyO+aokJ4PehkBrAsonVrOVlL1LO2vv5o1DbsLBEgDVWYA6ndGnBIcSCGsyXxu6aXZlBBieMyRlq8iIJ5G6lt2RKe8Urdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1P3s1fhu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8A00C4CEE7;
	Mon, 28 Jul 2025 15:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753717461;
	bh=QHYzZrNRpbqv8YnzcImUFT1caQKEPMQJ29G73MsnVO8=;
	h=Date:From:To:Cc:Subject:From;
	b=1P3s1fhumUQgJP3jGqpTcXHfjCJ+5A5C6zgBK4VlZ+JDCaO+Naq22C7w7wyvdgxan
	 +Anthr7jzGVzX6L2Gwe0apfpGA6g1VP/cEwqC+GLLQb5coC16mgime2OmaPtT37qz9
	 ku+HbmWwkMzidnS719ThSiWfMAhBF3nqGsxe1PZY=
Date: Mon, 28 Jul 2025 17:44:18 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [GIT PULL] USB/Thunderbolt driver updates for 6.17-rc1
Message-ID: <aIea0h6hkgqgeFUf@kroah.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The following changes since commit 89be9a83ccf1f88522317ce02f854f30d6115c41:

  Linux 6.16-rc7 (2025-07-20 15:18:33 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.17-rc1

for you to fetch changes up to 51d4b0a44c82e5eff056ef76acd2c3c605a8eb74:

  usb: musb: omap2430: clean up probe error handling (2025-07-25 10:50:44 +0200)

----------------------------------------------------------------
USB / Thunderbolt changes for 6.17-rc1

Here is the big set of USB and Thunderbolt driver changes for 6.17-rc1.

Lots of little things in here, mostly all small cleanups and updates, no
major new features this development cycle.  Stuff included in here is:
  - xhci minor tweaks for error handling
  - typec minor updates and a driver update
  - gadget driver api cleanups
  - unused function removals
  - unbind memory leak fixes
  - a few new device ids added
  - a few new devices supported for some drivers
  - other minor cleanups and changes

All of these have been in linux-next with no reported issues, with the
leak fixes being in the shortest amount of time, but they are "obviously
correct" :)

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Akash Kumar (1):
      usb: gadget: uvc: Initialize frame-based format color matching descriptor

Alok Tiwari (1):
      thunderbolt: Fix typos in documentation comments

André Draszik (3):
      usb: typec: tcpm/tcpci_maxim: fix irq wake usage
      usb: typec: tcpm/tcpci_maxim: drop CONFIG_OF
      usb: typec: tcpm/tcpci_maxim: enable PROBE_PREFER_ASYNCHRONOUS

Arnd Bergmann (1):
      usb: typec: ucsi: yoga-c630: add DRM dependency

Bagas Sanjaya (1):
      Documentation: usb: gadget: Wrap remaining usage snippets in literal code block

Bartosz Golaszewski (2):
      USB: serial: ftdi_sio: use new GPIO line value setter callbacks
      USB: serial: cp210x: use new GPIO line value setter callbacks

Benson Leung (1):
      usb: typec: ucsi: psy: Set current max to 100mA for BC 1.2 and Default

Charalampos Mitrodimas (1):
      usb: misc: apple-mfi-fastcharge: Make power supply names unique

Chen Ni (9):
      usb: gadget: m66592-udc: Use USB API functions rather than constants
      usb: gadget: f_fs: Use USB API functions rather than constants
      usb: gadget: udc-xilinx: Use USB API functions rather than constants
      usb: gadget: pch_udc: Use USB API functions rather than constants
      usb: gadget: net2280: Use USB API functions rather than constants
      usb: gadget: composite: Use USB API functions rather than constants
      usb: gadget: dummy_hcd: Use USB API functions rather than constants
      usb: ohci-spear: Remove unnecessary NULL check before clk_disable_unprepare()
      usb: fsl-mph-dr-of: Remove unnecessary NULL check before clk_disable_unprepare()

Dan Carpenter (3):
      usb: gadget: u_serial: remove some dead code
      arm64: dts: s32g: Add USB device tree information for s32g2/s32g3
      usb: chipidea: imx: Add a missing blank line

Darshan Rathod (1):
      usb: usblp: clean up assignment inside if conditions

Dmitry Baryshkov (10):
      usb: typec: ucsi: yoga-c630: fix error and remove paths
      usb: typec: ucsi: add recipient arg to update_altmodes() callback
      usb: typec: ucsi: yoga-c630: remove duplicate AltModes
      usb: typec: ucsi: yoga-c630: remove extra AltModes for port 1
      usb: typec: ucsi: yoga-c630: fake AltModes for port 0
      usb: typec: ucsi: yoga-c630: correct response for GET_CURRENT_CAM
      usb: typec: ucsi: yoga-c630: handle USB / HPD messages to set port orientation
      usb: typec: ucsi: yoga-c630: register DRM HPD bridge
      dt-bindings: usb: genesys,gl850g: use usb-hub.yaml
      dt-bindings: usb: genesys,gl850g: add downstream facing ports

Dr. David Alan Gilbert (5):
      usb: phy: tegra: Remove unused functions
      usb: gadget: config: Remove unused usb_gadget_config_buf
      usb: gadget: Remove unused usb_remove_config
      usb: core: Remove unused usb_unlink_anchored_urbs
      usb: typec: Remove unused ucsi_cci_str

Eric Biggers (1):
      thunderbolt: Fix copy+paste error in match_service_id()

Frank Li (1):
      dt-bindings: usb: convert lpc32xx-udc.txt to yaml format

Geert Uytterhoeven (2):
      usb: renesas_usbhs: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
      usb: gadget: udc: renesas_usb3: Convert to DEFINE_SIMPLE_DEV_PM_OPS()

Ghennadi Procopciuc (3):
      dt-bindings: usb: Add compatible strings for s32g2/s32g3
      usb: chipidea: s32g: Add usb support for s32g2
      usb: chipidea: s32g: Add usb support for s32g3

Greg Kroah-Hartman (5):
      Merge merge point of tag 'usb-6.16-rc5' into usb-next
      Merge tag 'thunderbolt-for-v6.17-rc1' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt into usb-next
      Merge tag 'v6.16-rc7' into usb-next
      Merge tag 'usb-serial-6.17-rc1' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-next
      Merge tag 'usb-serial-6.17-rc1-2' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-next

Hanne-Lotta Mäenpää (1):
      usb: core: Use sysfs_emit_at() when showing dynamic IDs

Hendrik Hamerlinck (1):
      usb: ehci: replace scnprintf() with sysfs_emit()

Ingo Rohloff (1):
      usb: gadget: f_fs: Remove unnecessary spinlocks.

Inochi Amaoto (2):
      dt-bindings: usb: dwc2: rename sophgo usb compatible string
      usb: dwc2: follow compatible string change for Sophgo CV18XX/SG200X series SoC

Jameson Thies (1):
      usb: typec: ucsi: Add poll_cci operation to cros_ec_ucsi

Jay Chen (1):
      usb: xhci: Set avg_trb_len = 8 for EP0 during Address Device Command

Jens Glathe (1):
      usb: misc: onboard_usb_dev: Add Bison Electronics Inc. Integrated Camera

Jiayi Li (1):
      usb: core: Add 0x prefix to quirks debug output

Jisheng Zhang (1):
      usb: dwc2: disable platform lowlevel hw resources during shutdown

Johan Hovold (7):
      usb: gadget: udc: renesas_usb3: drop unused module alias
      usb: musb: omap2430: enable compile testing
      usb: dwc3: imx8mp: fix device leak at unbind
      usb: dwc3: meson-g12a: fix device leaks at unbind
      usb: gadget: udc: renesas_usb3: fix device leak at unbind
      usb: musb: omap2430: fix device leak at unbind
      usb: musb: omap2430: clean up probe error handling

Johannes Schneider (1):
      usb: dwc3: gadget: Simplify TRB reclaim logic by removing redundant 'chain' argument

Lad Prabhakar (1):
      dt-bindings: usb: renesas,usbhs: Add RZ/V2N SoC support

Lucas De Marchi (1):
      usb: early: xhci-dbc: Fix early_ioremap leak

Mario Limonciello (2):
      usb: xhci: Avoid showing errors during surprise removal
      usb: xhci: Avoid showing warnings for dying controller

Mihai Sain (1):
      usb: ohci-at91: Use dynamic device name for OHCI HCD creation

Myrrh Periwinkle (1):
      usb: typec: ucsi: Update power_supply on power role change

Nathan Chancellor (1):
      usb: atm: cxacru: Merge cxacru_upload_firmware() into cxacru_heavy_init()

Oliver Neukum (2):
      usb: core: usb_submit_urb: downgrade type check
      cdc-acm: fix race between initial clearing halt and open

Prashanth K (1):
      usb: dwc3: gadget: Remove duplicate check while setting xfer resource

RD Babiera (1):
      usb: typec: altmodes/displayport: add irq_hpd to sysfs

Radhey Shyam Pandey (2):
      usb: dwc3: xilinx: add shutdown callback
      usb: dwc3: xilinx: set coherency mode for AMD versal adaptive platform

RubenKelevra (1):
      include: fsl_devices.h: drop unused, misspelled FLS_USB2_WORKAROUND_ENGCM09152

Sebastian Reichel (1):
      usb: typec: fusb302: cache PD RX state

Seungjin Bae (1):
      usb: host: xhci-plat: fix incorrect type for of_match variable in xhci_plat_probe()

Slark Xiao (1):
      USB: serial: option: add Foxconn T99W709

Su Hui (1):
      usb: xhci: print xhci->xhc_state when queue_command failed

Sumanth Gavini (2):
      usb: gadget: f_uac2: replace scnprintf() with sysfs_emit()
      usb: gadget: f_uac1: replace scnprintf() with sysfs_emit()

Tao Xue (1):
      usb: gadget : fix use-after-free in composite_dev_cleanup()

Tomasz Michalec (1):
      usb: typec: intel_pmc_mux: Defer probe if SCU IPC isn't present

Uwe Kleine-König (1):
      docs: usb: gadget: Reindent numbered list

Wolfram Sang (1):
      usb: renesas_usbhs: use proper DMAENGINE API for termination

Xinyu Liu (1):
      usb: core: config: Prevent OOB read in SS endpoint companion parsing

Xu Rao (1):
      usb: core: modify comments xhci_hc_driver has HCD_MEMORY just like ehci ohci

Xu Yang (7):
      usb: chipidea: udc: add CI_HDRC_CONTROLLER_PULLUP_EVENT event
      usb: chipidea: imx: add imx_usbmisc_pullup() hook
      usb: chipidea: imx: implement workaround for ERR051725
      usb: core: add dma-noncoherent buffer alloc and free API
      media: uvcvideo: use usb_alloc_noncoherent/usb_free_noncoherent()
      media: stk1160: use usb_alloc_noncoherent/usb_free_noncoherent()
      usb: core: add urb->sgt parameter description

Yongbo Zhang (1):
      usb: typec: fusb302: fix scheduling while atomic when using virtio-gpio

Yuesong Li (1):
      usb: storage: reltek_cr: convert to use secs_to_jiffies

Yuhao Jiang (1):
      USB: gadget: f_hid: Fix memory leak in hidg_bind error path

 .../ABI/testing/sysfs-driver-typec-displayport     |  10 ++
 .../devicetree/bindings/usb/ci-hdrc-usb2.yaml      |   5 +
 Documentation/devicetree/bindings/usb/dwc2.yaml    |   2 +-
 .../devicetree/bindings/usb/fsl,usbmisc.yaml       |   2 +
 .../devicetree/bindings/usb/genesys,gl850g.yaml    |  28 ++--
 .../devicetree/bindings/usb/lpc32xx-udc.txt        |  28 ----
 .../devicetree/bindings/usb/nxp,lpc3220-udc.yaml   |  50 ++++++
 .../devicetree/bindings/usb/renesas,usbhs.yaml     |   1 +
 Documentation/driver-api/usb/anchors.rst           |  11 --
 Documentation/usb/gadget_configfs.rst              |  45 +++---
 arch/arm64/boot/dts/freescale/s32g2.dtsi           |  23 +++
 arch/arm64/boot/dts/freescale/s32g3.dtsi           |  23 +++
 drivers/media/usb/stk1160/stk1160-v4l.c            |   4 -
 drivers/media/usb/stk1160/stk1160-video.c          |  43 ++---
 drivers/media/usb/stk1160/stk1160.h                |   7 -
 drivers/media/usb/uvc/uvc_video.c                  |  61 ++-----
 drivers/thunderbolt/domain.c                       |   2 +-
 drivers/thunderbolt/nvm.c                          |   2 +-
 drivers/thunderbolt/switch.c                       |   2 +-
 drivers/usb/atm/cxacru.c                           | 172 ++++++++++----------
 drivers/usb/chipidea/ci_hdrc_imx.c                 |  11 ++
 drivers/usb/chipidea/ci_hdrc_imx.h                 |   1 +
 drivers/usb/chipidea/udc.c                         |   5 +
 drivers/usb/chipidea/usbmisc_imx.c                 | 128 +++++++++++++++
 drivers/usb/class/cdc-acm.c                        |  11 +-
 drivers/usb/class/usblp.c                          |  33 ++--
 drivers/usb/core/config.c                          |  10 +-
 drivers/usb/core/driver.c                          |   4 +-
 drivers/usb/core/hcd-pci.c                         |   2 +-
 drivers/usb/core/hcd.c                             |  29 +++-
 drivers/usb/core/quirks.c                          |   2 +-
 drivers/usb/core/urb.c                             |  31 +---
 drivers/usb/core/usb.c                             |  80 ++++++++++
 drivers/usb/dwc2/params.c                          |   2 +-
 drivers/usb/dwc2/platform.c                        |   3 +
 drivers/usb/dwc3/dwc3-imx8mp.c                     |   7 +-
 drivers/usb/dwc3/dwc3-meson-g12a.c                 |   3 +
 drivers/usb/dwc3/dwc3-xilinx.c                     |  35 ++--
 drivers/usb/dwc3/gadget.c                          |  16 +-
 drivers/usb/early/xhci-dbc.c                       |   4 +
 drivers/usb/gadget/composite.c                     |  31 +---
 drivers/usb/gadget/config.c                        |  53 -------
 drivers/usb/gadget/function/f_fs.c                 |  12 +-
 drivers/usb/gadget/function/f_hid.c                |   7 +-
 drivers/usb/gadget/function/f_uac1.c               |   2 +-
 drivers/usb/gadget/function/f_uac2.c               |   2 +-
 drivers/usb/gadget/function/u_serial.c             |   6 -
 drivers/usb/gadget/function/uvc_configfs.c         |  10 ++
 drivers/usb/gadget/udc/dummy_hcd.c                 |   2 +-
 drivers/usb/gadget/udc/m66592-udc.c                |   6 +-
 drivers/usb/gadget/udc/net2280.c                   |   8 +-
 drivers/usb/gadget/udc/pch_udc.c                   |   2 +-
 drivers/usb/gadget/udc/renesas_usb3.c              |  10 +-
 drivers/usb/gadget/udc/udc-xilinx.c                |   4 +-
 drivers/usb/host/ehci-sysfs.c                      |  18 +--
 drivers/usb/host/fsl-mph-dr-of.c                   |   3 +-
 drivers/usb/host/ohci-at91.c                       |   2 +-
 drivers/usb/host/ohci-spear.c                      |   3 +-
 drivers/usb/host/xhci-mem.c                        |   2 +
 drivers/usb/host/xhci-plat.c                       |   2 +-
 drivers/usb/host/xhci-ring.c                       |  10 +-
 drivers/usb/host/xhci.c                            |   6 +-
 drivers/usb/misc/apple-mfi-fastcharge.c            |  24 ++-
 drivers/usb/misc/onboard_usb_dev.c                 |   2 +
 drivers/usb/misc/onboard_usb_dev.h                 |   8 +
 drivers/usb/musb/Kconfig                           |   3 +-
 drivers/usb/musb/omap2430.c                        |  37 ++---
 drivers/usb/phy/phy-tegra-usb.c                    |  89 -----------
 drivers/usb/renesas_usbhs/common.c                 |   8 +-
 drivers/usb/renesas_usbhs/fifo.c                   |   2 +-
 drivers/usb/serial/cp210x.c                        |  10 +-
 drivers/usb/serial/ftdi_sio.c                      |  18 ++-
 drivers/usb/serial/option.c                        |   2 +
 drivers/usb/storage/realtek_cr.c                   |   2 +-
 drivers/usb/typec/altmodes/displayport.c           |  28 ++++
 drivers/usb/typec/mux/intel_pmc_mux.c              |   2 +-
 drivers/usb/typec/tcpm/fusb302.c                   |  20 ++-
 drivers/usb/typec/tcpm/tcpci_maxim_core.c          |  51 +++---
 drivers/usb/typec/ucsi/Kconfig                     |   2 +
 drivers/usb/typec/ucsi/cros_ec_ucsi.c              |   1 +
 drivers/usb/typec/ucsi/psy.c                       |   2 +-
 drivers/usb/typec/ucsi/trace.c                     |  17 --
 drivers/usb/typec/ucsi/trace.h                     |   1 -
 drivers/usb/typec/ucsi/ucsi.c                      |   6 +-
 drivers/usb/typec/ucsi/ucsi.h                      |  11 +-
 drivers/usb/typec/ucsi/ucsi_ccg.c                  |   4 +
 drivers/usb/typec/ucsi/ucsi_yoga_c630.c            | 176 ++++++++++++++++++++-
 include/linux/fsl_devices.h                        |   1 -
 include/linux/usb.h                                |  16 +-
 include/linux/usb/chipidea.h                       |   1 +
 include/linux/usb/composite.h                      |   3 -
 include/linux/usb/gadget.h                         |   4 -
 include/linux/usb/tegra_usb_phy.h                  |   9 --
 93 files changed, 1016 insertions(+), 683 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/usb/lpc32xx-udc.txt
 create mode 100644 Documentation/devicetree/bindings/usb/nxp,lpc3220-udc.yaml

