Return-Path: <linux-kernel+bounces-842075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C27CBB8E6A
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 16:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAB24189D1D9
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 14:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D6B186E40;
	Sat,  4 Oct 2025 14:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nUFaDinH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C68CA4E;
	Sat,  4 Oct 2025 14:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759586587; cv=none; b=MF7urH+2+aLrHe7E+CG2zy0JbE+1UMe5I3qzbc8+1nF2Sjo6qCx6rvUZGPH4RBbHLFSK21A8VNUX1y4XMqHwPXsmt1HnWdCkdYdm7vFnnO3f59UaogYjsmEr0C0f8of/9V+jssAz3J7tSraf8Dt0M4i3MkP1rZy9pyj3G3fRY6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759586587; c=relaxed/simple;
	bh=4PdN6Il6q31BswdMRvP9FRXfXbi+B8+zzy4YC8z7xEE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QRcl4GQ/NJ/1WYT8cnN88BrpLnoJGHr9Vo+tnffdzOkcsb6u026lTQ2A9l2PoyK+xVTrSflNfAw7bwKfwQzr3cbHMlf+VCa3iAVTWedCzHdHvj+3pgu9hm8F6xJMOVdN/5e7bF0gkvwicvZJwYkHAm3e/S18VlO0rIqWP7P8q9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nUFaDinH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D03EC4CEF1;
	Sat,  4 Oct 2025 14:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759586586;
	bh=4PdN6Il6q31BswdMRvP9FRXfXbi+B8+zzy4YC8z7xEE=;
	h=Date:From:To:Cc:Subject:From;
	b=nUFaDinHbbuLiizb0CSWr78XK4DR37b/JJqksAi5J2gAJXOMMGg4EFkTRxgPWkAOC
	 Zbsz8hE9ifwu5Njbn5gLge6/Q2TRgrtdlVN5s6g4p73KkXf6JgEM6YLHrZwmtUyosx
	 +Uacqqmocp2jlPgn91XJ48yFjMls8NyPotmuAITw=
Date: Sat, 4 Oct 2025 16:03:03 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [GIT PULL] USB/Thunderbolt changes for 6.18-rc1
Message-ID: <aOEpFzhV1YiZ3qjw@kroah.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The following changes since commit f83ec76bf285bea5727f478a68b894f5543ca76e:

  Linux 6.17-rc6 (2025-09-14 14:21:14 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.18-rc1

for you to fetch changes up to e40b984b6c4ce3f80814f39f86f87b2a48f2e662:

  usb: vhci-hcd: Prevent suspending virtually attached devices (2025-09-25 18:52:32 +0200)

----------------------------------------------------------------
USB/Thunderbolt changes for 6.18-rc1

Here is the big set of USB and thunderbolt drivers for 6.18-rc1.  It was
another normal development cycle, with lots of the usual drivers getting
updates:
  - Thunderbolt driver cleanups and additions
  - dwc3 driver updates
  - dwc2 driver updates
  - typec driver updates
  - xhci driver updates and additions
  - offload USB engine updates for better power management
  - unused tracepoint removals
  - usb gadget fixes and updates as more users start to rely on these
    drivers instead of the "old" function gadget drivers
  - new USB device ids
  - other minor driver USB driver updates
  - new USB I/O driver framework and driver additions

The last item, the usb i/o driver, has an i2c and gpio driver added
through this tree.  Those drivers were acked by the respective subsystem
maintainers, but you will get a merge conflict with the i2c tree where
new drivers were added in the same places in a Kconfig and Makefile.
The merge conflict is simple, just take both sides.

All of these have been in linux-next for a while, with the only issue
being the i2c tree merge conflicts.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alan Borzeszkowski (26):
      thunderbolt: Update acpi.c function documentation
      thunderbolt: Update cap.c function documentation
      thunderbolt: Update clx.c function documentation
      thunderbolt: Update ctl.c function documentation
      thunderbolt: Add missing documentation in ctl.h tb_cfg_request struct
      thunderbolt: Update dma_port.c function documentation
      thunderbolt: Update domain.c function documentation
      thunderbolt: Update eeprom.c function documentation
      thunderbolt: Update lc.c function documentation
      thunderbolt: Update nhi.c function documentation
      thunderbolt: Add missing documentation in nhi_regs.h ring_desc structure
      thunderbolt: Update nvm.c function documentation
      thunderbolt: Update path.c function documentation
      thunderbolt: Update property.c function documentation
      thunderbolt: Update retimer.c function documentation
      thunderbolt: Update switch.c function documentation
      thunderbolt: Update tb.c function documentation
      thunderbolt: Update tb.h function documentation
      thunderbolt: Add missing documentation in tb.h
      thunderbolt: Update tmu.c function documentation
      thunderbolt: Update tunnel.c function documentation
      thunderbolt: Update tunnel.h function documentation
      thunderbolt: Update usb4.c function documentation
      thunderbolt: Update usb4_port.c function documentation
      thunderbolt: Update xdomain.c function documentation
      thunderbolt: Update thunderbolt.h header file

Biju Das (4):
      dt-bindings: usb: Document Renesas RZ/G3E USB3HOST
      usb: host: xhci-rcar: Move R-Car reg definitions
      usb: host: xhci-plat: Add .post_resume_quirk for struct xhci_plat_priv
      usb: host: xhci-rcar: Add Renesas RZ/G3E USB3 Host driver support

Chelsy Ratnawat (1):
      thunderbolt: Use string choices helpers

Chen Yufeng (1):
      usb: cdns3: gadget: Use-after-free during failed initialization and exit of cdnsp gadget

Colin Ian King (1):
      USB: serial: oti6858: remove extranenous ; after comment

Cristian Ciocaltea (1):
      usb: vhci-hcd: Prevent suspending virtually attached devices

Dan Carpenter (1):
      usb: host: max3421-hcd: Fix error pointer dereference in probe cleanup

Dominique Martinet (1):
      USB: lower "Device is not authorized for usage" message to info

Duoming Zhou (1):
      thunderbolt: Fix use-after-free in tb_dp_dprx_work

Eric Biggers (2):
      thunderbolt: Compare HMAC values in constant time
      thunderbolt: Use HMAC-SHA256 library instead of crypto_shash

Eric Gonçalves (1):
      tools/usb/usbip: fix spelling mistakes in usbipd.c

Forest Crossman (1):
      usb: mon: Increase BUFF_MAX to 64 MiB to support multi-MB URBs

Greg Kroah-Hartman (8):
      Merge 6.17-rc3 into usb-next
      Merge patch series "eUSB2 Double Isochronous IN Bandwidth support"
      Merge patch series "Support system sleep with offloaded usb transfers" into usb-next
      Merge 6.17-rc6 into usb-next
      Merge patch series "Add SpacemiT K1 USB3.0 host controller support"
      Merge patch series "usb: gadget: Refactor function drivers to use __free() cleanup"
      Merge tag 'thunderbolt-for-v6.18-rc1' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt into usb-next
      Merge tag 'usb-serial-6.18-rc1' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-next

Guan-Yu Lin (4):
      usb: xhci-plat: separate dev_pm_ops for each pm_event
      usb: offload: add apis for offload usage tracking
      xhci: sideband: add api to trace sideband usage
      usb: host: enable USB offload during system sleep

Haotien Hsu (1):
      usb: xhci: tegra: Support USB wakeup function for Tegra234

Hector Martin (4):
      usb: typec: tipd: Update partner identity when power status was updated
      usb: typec: tipd: Use read_power_status function in probe
      usb: typec: tipd: Read data status in probe and cache its value
      usb: typec: tipd: Handle mode transitions for CD321x

Herve Codina (1):
      usb: dwc2: Add support for 'maximum-speed' property

Israel Cepeda (3):
      usb: misc: Add Intel USBIO bridge driver
      gpio: Add Intel USBIO GPIO driver
      i2c: Add Intel USBIO I2C driver

Jihed Chaibi (2):
      usb: dt-bindings: ti,twl4030-usb: convert to DT schema
      usb: dt-bindings: ti,twl6030-usb: convert to DT schema

Jisheng Zhang (3):
      dt-bindings: usb: usb251xb: support usage case without I2C control
      usb: usb251xb: use modern PM macros
      usb: usb251xb: support usage case without I2C control

Komal Bajaj (1):
      usb: misc: qcom_eud: Access EUD_MODE_MANAGER2 through secure calls

Krishna Kurapati (4):
      usb: dwc3: qcom: Remove extcon functionality from glue layer
      usb: dwc3: core: Introduce glue callbacks for flattened implementations
      usb: dwc3: qcom: Implement glue callbacks to facilitate runtime suspend
      usb: xhci: plat: Facilitate using autosuspend for xhci plat devices

Krzysztof Kozlowski (2):
      usb: ohci: s3c2410: Drop support for S3C2410 systems
      dt-bindings: usb: s3c2410-usb: Drop entirely S3C2410

Kuen-Han Tsai (9):
      usb: dwc3: Add trace event for dwc3_set_prtcap
      usb: dwc3: Refactor dwc3_mode_show
      usb: udc: Add trace event for usb_gadget_set_state
      usb: gadget: Store endpoint pointer in usb_request
      usb: gadget: Introduce free_usb_request helper
      usb: gadget: f_ncm: Refactor bind path to use __free()
      usb: gadget: f_acm: Refactor bind path to use __free()
      usb: gadget: f_ecm: Refactor bind path to use __free()
      usb: gadget: f_rndis: Refactor bind path to use __free()

Lad Prabhakar (2):
      dt-bindings: usb: renesas,usbhs: Add RZ/T2H and RZ/N2H support
      usb: renesas_usbhs: Add support for RZ/T2H SoC

Liao Yuanhong (2):
      usb: host: xhci-tegra: Remove redundant ternary operators
      usb: gadget: tegra-xudc: Remove redundant ternary operators

Linus Walleij (1):
      dt-bindings: usb: IXP4xx UDC bindings

Lukas Wunner (1):
      thunderbolt: Use is_pciehp instead of is_hotplug_bridge

Matthias Schiffer (1):
      usb: musb: dsps: use platform_get_irq_byname_optional() for vbus IRQ

Miaoqian Lin (1):
      usb: cdns3: cdnsp-pci: remove redundant pci_disable_device() call

Michal Pecio (2):
      Revert "usb: xhci: Avoid Stop Endpoint retry loop if the endpoint seems Running"
      usb: xhci: Update a comment about Stop Endpoint retries

Mika Westerberg (2):
      thunderbolt: Use Linux Foundation IDs for XDomain discovery
      MAINTAINERS: Update Michael Jamet's maintainer entries

Niklas Neronin (4):
      usb: xhci-pci: add support for hosts with zero USB3 ports
      usb: xhci: improve TR Dequeue Pointer mask
      usb: xhci: correct indentation for PORTSC tracing function
      usb: xhci: align PORTSC trace with one-based port numbering

Owen Gu (1):
      usb: gadget: f_fs: Fix epfile null pointer access after ep enable.

Petr Vorel (1):
      usb: misc: Update link to EHSET pdf doc

Prashanth K (1):
      usb: dwc3: qcom: Add shutdown handler

Qianfeng Rong (1):
      usb: typec: qcom-pmic-typec: use kcalloc() instead of kzalloc()

Rai, Amardeep (3):
      usb: core: Add a function to get USB version independent periodic payload
      usb: xhci: Add host support for eUSB2 double isochronous bandwidth devices
      usb: core: support eUSB2 double bandwidth large isoc URB frames

Rob Herring (Arm) (1):
      dt-bindings: usb: Drop duplicate nvidia,tegra20-ehci.txt

Sakari Ailus (6):
      USB: Check no positive return values from pm_runtime_resume_and_get()
      usb: core: Use le16_to_cpu() to read __le16 value in usb_parse_endpoint()
      usb: core: Parse eUSB2 companion descriptors for high speed devices only
      usb: core: eUSB2 companion descriptor is for isoc IN endpoints only
      usb: xhci: Use usb_endpoint_max_periodic_payload()
      usb: core: Introduce usb_endpoint_is_hs_isoc_double()

Stephen Boyd (1):
      usb: typec: Stub out typec_switch APIs when CONFIG_TYPEC=n

Steven Rostedt (3):
      cdns2: Remove unused tracepoints
      cdns3: Remove unused tracepoints
      cdnsp: Remove unused tracepoints

Sven Peter (7):
      usb: typec: tipd: Clear interrupts first
      usb: typec: tipd: Move initial irq mask to tipd_data
      usb: typec: tipd: Move switch_power_state to tipd_data
      usb: typec: tipd: Trace data status for CD321x correctly
      usb: typec: tipd: Add cd321x struct with separate size
      usb: typec: tipd: Read USB4, Thunderbolt and DisplayPort status for cd321x
      usb: typec: tipd: Register DisplayPort and Thunderbolt altmodes for cd321x

Tao Q Tao (1):
      media: uvcvideo: eUSB2 double isochronous bandwidth support

Thorsten Blum (3):
      usb: ucsi: stm32: Use min() to improve ucsi_stm32g0_fw_cb()
      usb: usblp: Use min_t() to improve usblp_read()
      usb: storage: realtek_cr: Simplify residue calculation in rts51x_bulk_transport()

Venkat Jayaraman (2):
      usb: typec: ucsi: Add support for READ_POWER_LEVEL command
      usb: typec: ucsi: Add check for UCSI version

Waqar Hameed (1):
      usb: misc: eud: Remove error print for devm_add_action_or_reset()

William Wu (2):
      usb: gadget: configfs: Correctly set use_os_string at bind
      usb: gadget: f_hid: Fix zero length packet transfer

Xiaowei Li (1):
      USB: serial: option: add SIMCom 8230C compositions

Xichao Zhao (2):
      usb: typec: mux: Remove the use of dev_err_probe()
      usb: phy: twl6030: Fix incorrect type for ret

Xu Yang (1):
      usb: typec: tcpci: add wakeup support

Ze Huang (2):
      dt-bindings: usb: dwc3: add support for SpacemiT K1
      usb: dwc3: add generic driver to support flattened

raub camaioni (1):
      usb: gadget: f_ncm: Fix MAC assignment NCM ethernet

 CREDITS                                            |   5 +
 .../devicetree/bindings/usb/intel,ixp4xx-udc.yaml  |  39 ++
 .../bindings/usb/nvidia,tegra20-ehci.txt           |  23 -
 .../bindings/usb/renesas,rzg3e-xhci.yaml           |  87 +++
 .../devicetree/bindings/usb/renesas,usbhs.yaml     |  28 +-
 .../devicetree/bindings/usb/s3c2410-usb.txt        |  22 -
 .../devicetree/bindings/usb/spacemit,k1-dwc3.yaml  | 121 ++++
 .../devicetree/bindings/usb/ti,twl4030-usb.yaml    |  74 ++
 .../devicetree/bindings/usb/ti,twl6030-usb.yaml    |  48 ++
 .../devicetree/bindings/usb/twlxxxx-usb.txt        |  43 --
 .../devicetree/bindings/usb/usb251xb.yaml          |   9 +-
 MAINTAINERS                                        |  12 +-
 drivers/gpio/Kconfig                               |  11 +
 drivers/gpio/Makefile                              |   1 +
 drivers/gpio/gpio-usbio.c                          | 247 +++++++
 drivers/i2c/busses/Kconfig                         |  11 +
 drivers/i2c/busses/Makefile                        |   1 +
 drivers/i2c/busses/i2c-usbio.c                     | 320 +++++++++
 drivers/media/usb/uvc/uvc_driver.c                 |   4 +-
 drivers/media/usb/uvc/uvc_video.c                  |  24 +-
 drivers/media/usb/uvc/uvcvideo.h                   |   4 +-
 drivers/pci/quirks.c                               |   2 +-
 drivers/thunderbolt/Kconfig                        |   4 +-
 drivers/thunderbolt/acpi.c                         |  28 +-
 drivers/thunderbolt/cap.c                          |  49 +-
 drivers/thunderbolt/clx.c                          |  12 +-
 drivers/thunderbolt/ctl.c                          |  33 +-
 drivers/thunderbolt/ctl.h                          |   1 +
 drivers/thunderbolt/debugfs.c                      |   3 +-
 drivers/thunderbolt/dma_port.c                     |  21 +-
 drivers/thunderbolt/domain.c                       |  73 +-
 drivers/thunderbolt/eeprom.c                       |   4 +-
 drivers/thunderbolt/lc.c                           |  58 +-
 drivers/thunderbolt/nhi.c                          |  20 +-
 drivers/thunderbolt/nhi_regs.h                     |   6 +
 drivers/thunderbolt/nvm.c                          |  42 +-
 drivers/thunderbolt/path.c                         |  14 +-
 drivers/thunderbolt/property.c                     |  38 +-
 drivers/thunderbolt/retimer.c                      |   7 +-
 drivers/thunderbolt/switch.c                       | 140 ++--
 drivers/thunderbolt/tb.c                           |  32 +-
 drivers/thunderbolt/tb.h                           |  45 +-
 drivers/thunderbolt/tmu.c                          |  16 +-
 drivers/thunderbolt/tunnel.c                       |  90 ++-
 drivers/thunderbolt/tunnel.h                       |   9 +-
 drivers/thunderbolt/usb4.c                         | 346 +++++++---
 drivers/thunderbolt/usb4_port.c                    |   7 +-
 drivers/thunderbolt/xdomain.c                      |  53 +-
 drivers/usb/cdns3/cdns3-trace.h                    |  61 --
 drivers/usb/cdns3/cdnsp-gadget.c                   |   8 +-
 drivers/usb/cdns3/cdnsp-pci.c                      |   5 +-
 drivers/usb/cdns3/cdnsp-trace.h                    |  25 -
 drivers/usb/class/usblp.c                          |   3 +-
 drivers/usb/core/Makefile                          |   1 +
 drivers/usb/core/config.c                          |   4 +-
 drivers/usb/core/driver.c                          |  58 +-
 drivers/usb/core/generic.c                         |   2 +-
 drivers/usb/core/offload.c                         | 136 ++++
 drivers/usb/core/urb.c                             |  14 +-
 drivers/usb/core/usb.c                             |  51 ++
 drivers/usb/dwc2/params.c                          |  26 +
 drivers/usb/dwc3/Kconfig                           |  11 +
 drivers/usb/dwc3/Makefile                          |   1 +
 drivers/usb/dwc3/core.c                            |   2 +
 drivers/usb/dwc3/core.h                            |  26 +
 drivers/usb/dwc3/debug.h                           |  18 +
 drivers/usb/dwc3/debugfs.c                         |  12 +-
 drivers/usb/dwc3/drd.c                             |   1 +
 drivers/usb/dwc3/dwc3-generic-plat.c               | 166 +++++
 drivers/usb/dwc3/dwc3-qcom.c                       | 174 ++---
 drivers/usb/dwc3/gadget.c                          |   1 +
 drivers/usb/dwc3/trace.h                           |  17 +
 drivers/usb/gadget/configfs.c                      |   2 +
 drivers/usb/gadget/function/f_acm.c                |  42 +-
 drivers/usb/gadget/function/f_ecm.c                |  48 +-
 drivers/usb/gadget/function/f_fs.c                 |   8 +-
 drivers/usb/gadget/function/f_hid.c                |   4 +-
 drivers/usb/gadget/function/f_ncm.c                |  81 +--
 drivers/usb/gadget/function/f_rndis.c              |  85 +--
 drivers/usb/gadget/udc/cdns2/cdns2-trace.h         |  69 --
 drivers/usb/gadget/udc/core.c                      |   4 +
 drivers/usb/gadget/udc/tegra-xudc.c                |   3 +-
 drivers/usb/gadget/udc/trace.h                     |   5 +
 drivers/usb/host/Kconfig                           |   2 +-
 drivers/usb/host/max3421-hcd.c                     |   2 +-
 drivers/usb/host/ohci-s3c2410.c                    |   8 -
 drivers/usb/host/xhci-caps.h                       |   2 +
 drivers/usb/host/xhci-mem.c                        |  85 ++-
 drivers/usb/host/xhci-pci.c                        |  44 +-
 drivers/usb/host/xhci-plat.c                       |  57 +-
 drivers/usb/host/xhci-plat.h                       |   2 +
 drivers/usb/host/xhci-rcar-regs.h                  |  49 ++
 drivers/usb/host/xhci-rcar.c                       | 100 +--
 drivers/usb/host/xhci-ring.c                       |  30 +-
 drivers/usb/host/xhci-rzg3e-regs.h                 |  12 +
 drivers/usb/host/xhci-sideband.c                   |  36 +
 drivers/usb/host/xhci-tegra.c                      |  84 ++-
 drivers/usb/host/xhci-trace.h                      |  34 +-
 drivers/usb/host/xhci.c                            |  16 +-
 drivers/usb/host/xhci.h                            |   5 +-
 drivers/usb/misc/Kconfig                           |  19 +-
 drivers/usb/misc/Makefile                          |   1 +
 drivers/usb/misc/qcom_eud.c                        |  36 +-
 drivers/usb/misc/usb251xb.c                        | 108 ++-
 drivers/usb/misc/usbio.c                           | 749 +++++++++++++++++++++
 drivers/usb/mon/mon_bin.c                          |  14 +-
 drivers/usb/musb/musb_dsps.c                       |   2 +-
 drivers/usb/phy/phy-twl6030-usb.c                  |   3 +-
 drivers/usb/renesas_usbhs/common.c                 |   4 +
 drivers/usb/serial/option.c                        |   6 +
 drivers/usb/serial/oti6858.c                       |   2 +-
 drivers/usb/storage/realtek_cr.c                   |   4 +-
 drivers/usb/typec/mux/tusb1046.c                   |   2 +-
 .../usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c    |   2 +-
 drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_port.c |   2 +-
 drivers/usb/typec/tcpm/tcpci.c                     |  33 +
 drivers/usb/typec/tipd/core.c                      | 559 +++++++++++++--
 drivers/usb/typec/tipd/tps6598x.h                  |   5 +
 drivers/usb/typec/tipd/trace.h                     |  39 ++
 drivers/usb/typec/ucsi/debugfs.c                   |  31 +
 drivers/usb/typec/ucsi/ucsi.c                      |  17 +
 drivers/usb/typec/ucsi/ucsi.h                      |  13 +
 drivers/usb/typec/ucsi/ucsi_stm32g0.c              |   7 +-
 drivers/usb/usbip/vhci_hcd.c                       |  22 +
 include/linux/thunderbolt.h                        |  25 +-
 include/linux/usb.h                                |  24 +
 include/linux/usb/gadget.h                         |  25 +
 include/linux/usb/typec_mux.h                      |  46 +-
 include/linux/usb/usbio.h                          | 177 +++++
 include/linux/usb/xhci-sideband.h                  |   9 +
 tools/usb/usbip/src/usbipd.c                       |   4 +-
 131 files changed, 4793 insertions(+), 1226 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/intel,ixp4xx-udc.yaml
 delete mode 100644 Documentation/devicetree/bindings/usb/nvidia,tegra20-ehci.txt
 create mode 100644 Documentation/devicetree/bindings/usb/renesas,rzg3e-xhci.yaml
 delete mode 100644 Documentation/devicetree/bindings/usb/s3c2410-usb.txt
 create mode 100644 Documentation/devicetree/bindings/usb/spacemit,k1-dwc3.yaml
 create mode 100644 Documentation/devicetree/bindings/usb/ti,twl4030-usb.yaml
 create mode 100644 Documentation/devicetree/bindings/usb/ti,twl6030-usb.yaml
 delete mode 100644 Documentation/devicetree/bindings/usb/twlxxxx-usb.txt
 create mode 100644 drivers/gpio/gpio-usbio.c
 create mode 100644 drivers/i2c/busses/i2c-usbio.c
 create mode 100644 drivers/usb/core/offload.c
 create mode 100644 drivers/usb/dwc3/dwc3-generic-plat.c
 create mode 100644 drivers/usb/host/xhci-rcar-regs.h
 create mode 100644 drivers/usb/host/xhci-rzg3e-regs.h
 create mode 100644 drivers/usb/misc/usbio.c
 create mode 100644 include/linux/usb/usbio.h

