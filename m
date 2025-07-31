Return-Path: <linux-kernel+bounces-752605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E14B177D0
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 23:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCEB91C26EE5
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 21:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD10D264628;
	Thu, 31 Jul 2025 21:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kn4a3b5A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121112571AC
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 21:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753996067; cv=none; b=bmiOsEQcoyinWxMMgCGe7Pq/oLGtStaYtrez3BhvNkM2RyUXesM9QK8y5Tg2LIDhZAzV2/2ho+pXq5Z4jUXjM5ER9JMCs2FG3iLXw4F7V5UielYvN3FVuFsKJ2jZFrO903+0FaijYXo5CKtrby4s6329hbGQCzIqBFZqvWAAv94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753996067; c=relaxed/simple;
	bh=F1a0VIlhGvv+Ki8yLEmfYVsajK/r+fpIlN+gjl/tfuk=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=DBR2b4ELYAqhAaFCe+FzLAFHqxuCybrE0bE7fnsK32XiQupSVR1Dp1AgvdOHiZv7U62SmRYxnAQRBqVjUgqBJGWLlnzg2VIbY1jC1i2KV19OYmkROIjntBdLyFYPUnbb0gJeoOt4lKxcCIqqEsJFMw98m7fnyaMpYESUjlgFa0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kn4a3b5A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A29CC4CEEF;
	Thu, 31 Jul 2025 21:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753996066;
	bh=F1a0VIlhGvv+Ki8yLEmfYVsajK/r+fpIlN+gjl/tfuk=;
	h=Date:From:To:cc:Subject:From;
	b=kn4a3b5A/RPLhIpTk8quvNWP6JHoQxzxhdCoZhBfjx8Xq0AI1yC4VDFY7NfuZvULP
	 ELQfucQ8FJ826fERdDoQreLxjSsR0nFhaCeukwfRBDnoaVk1iOLhk9SiLye7kVUvuI
	 FGbD5zhJqSil//n/w+q/XcZOKRiDjwwQDQgEdNlaoT66mZ07qLIACf+x8Oq5fg6k1R
	 Fi9pUGU52fMtUStlT+kqrfyeSl7WyO0pC/WoNh9yWXi/pNJ8iaMk390cILoEBjDTmB
	 W0IdSjb2ieHil2A9bfT/7kgZIKPpDLjC19llgNuIlPqGbHnjZM9+ue7VORvBFKlQYR
	 zb/KpDRAsIq+g==
Date: Thu, 31 Jul 2025 23:07:43 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: linux-kernel@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
Subject: [GIT PULL] HID for 6.17 merge window
Message-ID: <84155420-3nos-n64p-o8s2-1o6orssponp6@xreary.bet>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE

Linus,

once you have time in between birthday party drinks, please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/hid-for-li=
nus-2025073101

to receive HID subsystem queue for 6.17 merge window, namely:

=3D=3D=3D=3D=3D
- hardening of HID core parser against conversion to 0 bits in=20
  s32ton() by buggy/malicious devices (Alan Stern)

- fix for potential NULL pointer dereference in hid-apple that could=20
  be caused by malicious device with APPLE_MAGIC_BACKLIGHT quirk present=20
  triggering overflow in data field (Qasim Ijaz)

- support for Wake-on-touch in intel-thc (Even Xu)

- support for "Input max input size control" and "Input interrupt delay"
  I2C features in order to improve compatibility of THC devices with
  legacy HIDI2C touch devices (Even Xu)

- support for Touch Bars on x86 MacBook Pros (Kerem Karabay)

- support for XP-PEN Artist 22R Pro (Joshua Goins)

- third party trackpart support for MacBookPro15,1 (Aditya Garg)
   =20
- Apple Magic Keyboard A311[89] USB-C support (Aditya Garg, Grigorii =20
  Sokoli

- support for operating modes in amd-sfh (Basavaraj Natikar)

- avoid setting up battery timer for Apple and Magicmouse devices=20
  without battery (Aditya Garg)

- fix for behavior of the hid-mcp2221 driver for !CONFIG_IIO cases
  (Heiko Schocher)

- other assorted fixups and device ID additions
=3D=3D=3D=3D=3D

Thanks.

----------------------------------------------------------------
Aditya Garg (11):
      HID: apple: move backlight report structs to other backlight structs
      HID: apple: use switch case to set fn translation table
      HID: apple: remove unused APPLE_IGNORE_MOUSE quirk
      HID: apple: Add Apple Magic Keyboard A3119 USB-C support
      HID: apple: add fnmode=3D4 to disable translation of fkeys and make i=
t default on Macs with Touch Bar
      HID: quirks: remove T2 devices from hid_mouse_ignore_list
      HID: apple: Add necessary IDs and support for replacement trackpad on=
 MacBookPro15,1
      HID: apple: avoid setting up battery timer for devices without batter=
y
      HID: magicmouse: avoid setting up battery timer when not needed
      HID: apple: use secs_to_jiffies() for battery timeout
      HID: magicmouse: use secs_to_jiffies() for battery timeout

Alan Stern (2):
      HID: core: Improve the kerneldoc for hid_report_len()
      HID: core: Harden s32ton() against conversion to 0 bits

Bagas Sanjaya (1):
      HID: intel-thc-hid: Separate max input size control conditional list

Basavaraj Natikar (1):
      HID: amd_sfh: Enable operating mode

Benjamin Tissoires (3):
      selftests/hid: run ruff format on the python part
      selftests/hid: sync the python tests to hid-tools 0.8
      selftests/hid: sync python tests to hid-tools 0.10

Chelsy Ratnawat (1):
      HID: replace scnprintf() with sysfs_emit()

Colin Ian King (1):
      HID: uclogic: make read-only array reconnect_event static const

Even Xu (10):
      HID: Intel-thc-hid: Intel-thc: Add thc_dma_content into kernel doc
      HID: Intel-thc-hid: Intel-thc: Refine code comments
      HID: Intel-thc-hid: Intel-thc: Introduce max input size control
      HID: Intel-thc-hid: Intel-thc: Introduce interrupt delay control
      HID: Intel-thc-hid: Intel-quicki2c: Refine code comments
      HID: Intel-thc-hid: Intel-quicki2c: Add driver data support
      HID: Intel-thc-hid: Intel-quicki2c: Add two new features to PTL
      HID: Intel-thc-hid: Intel-thc: Add Wake-on-Touch support
      HID: Intel-thc-hid: Intel-quickspi: Enable Wake-on-Touch feature
      HID: Intel-thc-hid: Intel-quicki2c: Enable Wake-on-Touch feature

Grigorii Sokolik (1):
      HID: apple: Add Apple Magic Keyboard A3118 USB-C support

Heiko Schocher (1):
      HID: mcp2221: set gpio pin mode

Jiri Kosina (1):
      HID: intel-thc: make ptl_ddata static

Joshua Goins (1):
      HID: uclogic: Add support for XP-PEN Artist 22R Pro

Kerem Karabay (5):
      HID: multitouch: Get the contact ID from HID_DG_TRANSDUCER_INDEX fiel=
ds in case of Apple Touch Bar
      HID: multitouch: support getting the tip state from HID_DG_TOUCH fiel=
ds in Apple Touch Bar
      HID: multitouch: take cls->maxcontacts into account for Apple Touch B=
ar even without a HID_DG_CONTACTMAX field
      HID: multitouch: specify that Apple Touch Bar is direct
      HID: multitouch: add device ID for Apple Touch Bar

Li Chen (1):
      HID: rate-limit hid_warn to prevent log flooding

Qasim Ijaz (1):
      HID: apple: validate feature-report field count to prevent NULL point=
er dereference

Tomasz Paku=B3a (11):
      HID: universal-pidff: Fix missing blank lines
      HID: hid-ids.h: Fix LITE_STAR_GT987 device id define
      HID: hid-pidff.h: Fix comment styling
      HID: pidff: Fix missing blank lines after declarations
      HID: pidff: Remove unneeded debug from pidff_clamp()
      HID: pidff: Rework pidff_set_time() to fix warnings
      HID: pidff: Use __func__ in debugs
      HID: pidff: Remove unneeded else in pidff_find_special_field()
      HID: pidff: Move trailing statements in pidff_rescale_signed()
      HID: pidff: Add missing spaces
      HID: pidff: Move else if statements to follow closing braces

Yu Jiaoliang (1):
      HID: mcp-2221: Replace manual comparison with min() macro

Zihuan Zhang (1):
      HID: debug: Use the __set_current_state()

 Documentation/hid/intel-thc-hid.rst                |  28 ++
 drivers/hid/Kconfig                                |   1 +
 drivers/hid/amd-sfh-hid/amd_sfh_client.c           |  23 ++
 drivers/hid/amd-sfh-hid/amd_sfh_hid.h              |   2 +-
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c             |   4 +
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.h             |   1 +
 drivers/hid/hid-apple.c                            | 244 ++++++-----
 drivers/hid/hid-core.c                             |  12 +-
 drivers/hid/hid-debug.c                            |   2 +-
 drivers/hid/hid-ids.h                              |  30 +-
 drivers/hid/hid-lg4ff.c                            |   6 +-
 drivers/hid/hid-magicmouse.c                       |  66 +--
 drivers/hid/hid-mcp2221.c                          | 108 ++++-
 drivers/hid/hid-multitouch.c                       |  62 ++-
 drivers/hid/hid-quirks.c                           |   9 +-
 drivers/hid/hid-uclogic-core.c                     |  66 ++-
 drivers/hid/hid-uclogic-params.c                   | 134 ++++++-
 drivers/hid/hid-uclogic-params.h                   |   5 +
 drivers/hid/hid-uclogic-rdesc.c                    |  44 ++
 drivers/hid/hid-uclogic-rdesc.h                    |   4 +
 drivers/hid/hid-universal-pidff.c                  |   5 +-
 drivers/hid/intel-thc-hid/Makefile                 |   1 +
 .../intel-thc-hid/intel-quicki2c/pci-quicki2c.c    | 218 ++++++----
 .../intel-thc-hid/intel-quicki2c/quicki2c-dev.h    |  55 ++-
 .../intel-thc-hid/intel-quickspi/pci-quickspi.c    |  15 +
 .../hid/intel-thc-hid/intel-thc/intel-thc-dev.c    | 140 +++++++
 .../hid/intel-thc-hid/intel-thc/intel-thc-dev.h    |  33 +-
 .../hid/intel-thc-hid/intel-thc/intel-thc-dma.c    |  40 ++
 .../hid/intel-thc-hid/intel-thc/intel-thc-dma.h    |  38 +-
 drivers/hid/intel-thc-hid/intel-thc/intel-thc-hw.h |   5 +
 .../hid/intel-thc-hid/intel-thc/intel-thc-wot.c    |  94 +++++
 .../hid/intel-thc-hid/intel-thc/intel-thc-wot.h    |  26 ++
 drivers/hid/usbhid/hid-pidff.c                     |  46 +--
 drivers/hid/usbhid/hid-pidff.h                     |   3 +-
 include/linux/hid.h                                |   8 +-
 tools/testing/selftests/hid/tests/base.py          |  46 ++-
 tools/testing/selftests/hid/tests/base_device.py   |  49 ++-
 .../selftests/hid/tests/test_apple_keyboard.py     |   3 +-
 tools/testing/selftests/hid/tests/test_gamepad.py  |   3 +-
 .../selftests/hid/tests/test_ite_keyboard.py       |   3 +-
 .../testing/selftests/hid/tests/test_multitouch.py |   2 +-
 tools/testing/selftests/hid/tests/test_sony.py     |   7 +-
 tools/testing/selftests/hid/tests/test_tablet.py   |  11 +-
 .../selftests/hid/tests/test_wacom_generic.py      | 445 +++++++++++++++--=
----
 44 files changed, 1669 insertions(+), 478 deletions(-)
 create mode 100644 drivers/hid/intel-thc-hid/intel-thc/intel-thc-wot.c
 create mode 100644 drivers/hid/intel-thc-hid/intel-thc/intel-thc-wot.h

--=20
Jiri Kosina
SUSE Labs


