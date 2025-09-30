Return-Path: <linux-kernel+bounces-837869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD752BADEB2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 17:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 570313B31BE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 15:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E17A248F4D;
	Tue, 30 Sep 2025 15:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rxg8MhaW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B91B232395
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 15:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759246456; cv=none; b=I4iSsTJZjIZzQXGm9WFHVZifM3roFUR9Q+VZG/EogmZPrHcozvbTZJMdrreq0gpE4xoFKLeraUvesvrq4Hn368zbfIRLOR49RKJnkCJHtYnyStviVzzMjTOh8v8UMMphcVvn/LVLu7SQAEdpM0e6D8gv0Vj+9es/3fnSZudekIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759246456; c=relaxed/simple;
	bh=umIFmn2UelsmL37RXGn4vEG672DxR7sEUbTuGaU3W5g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ddvR641zulihuC4sXqB4dLCs+8wafeBYxtrRfhzmtxuqCuy2xMGYwZjfLaHw8Wx/GSWcu+zD2KpFGjt2d8ui0JQjbp8/W5E03YInuQoSXdJgcdBTVcpoxaIoDQeRxxpB+qGmWpfz2Zj2kxufrPdTAqaIiWFj7W3+6QaYKuYS+y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rxg8MhaW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75977C4CEF0;
	Tue, 30 Sep 2025 15:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759246456;
	bh=umIFmn2UelsmL37RXGn4vEG672DxR7sEUbTuGaU3W5g=;
	h=Date:From:To:Cc:Subject:From;
	b=rxg8MhaWmC0icav0hmMSOOKKr5PEH24hlWqC1Gb55BR79ofk0uzXwBdqQxRA6F9MO
	 az0yQfwVcX+IA1GTy3PFtAp8lFDoLGUvYmuWp81iLmIqQ0FiR9YEBsvNctuazKXYD+
	 7LfumnvYjMCu/1Mo22RY/kkxvrXWhzV7XY73azR+ggN7ihZwbmdKtQGYwW4BtYD/Aq
	 ZNIJg0WgUQbPl1orWXeRyL+or+o/1FLAizOqfmkahxUfn2fMZYkMtA2WDYj+CFMtLq
	 Q5wSrLcm2mTpLIkMuYWLHRxPpwvY1w1kQigSqKvnpkuhS35LweLuivQWn2TF5IAc9A
	 H1SnKm8CFaJbw==
Date: Tue, 30 Sep 2025 17:34:12 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Kosina <jikos@kernel.org>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] HID for 6.18 merge window
Message-ID: <6avar2v2wzvery2ptlynwdlf43octlt57ue32kykwjqn23kemp@j7vmslpbqwxt>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Linus,

please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/hid-for-linus-2025093001

to receive HID subsystem queue for 6.17 merge window, namely:

=====
- implementation of haptic touchpad support (Angela Czubak and Jonathan
  Denose)

- add support for audio jack handling on DualSense Playstation
  controllers (Cristian Ciocaltea)

- allow HID-BPF to rebind a driver to hid-multitouch (Benjamin
  Tissoires)

- rework hidraw ioctls to make them safer (and tested) (Benjamin
  Tissoires)

- various PIDFF and universal-PIDFF fixes/improvements (Tomasz Pakuła)

- better configuration of Intel QuickI2C through ACPI (Xinpeng Sun)

- other assorted cleanups and fixes
=====

Thanks.

----------------------------------------------------------------
Amit Chaudhari (1):
      HID: asus: add support for missing PX series fn keys

Angela Czubak (11):
      HID: add haptics page defines
      Input: add FF_HAPTIC effect type
      Input: add INPUT_PROP_HAPTIC_TOUCHPAD
      HID: haptic: introduce hid_haptic_device
      HID: input: allow mapping of haptic output
      HID: haptic: initialize haptic device
      HID: input: calculate resolution for pressure
      HID: haptic: add functions handling events
      Input: MT - add INPUT_MT_TOTAL_FORCE flags
      HID: haptic: add hid_haptic_switch_mode
      HID: multitouch: add haptic multitouch support

Antheas Kapenekakis (1):
      HID: asus: add Z13 folio to generic group for multitouch to work

Basavaraj Natikar (1):
      HID: amd_sfh: Add sync across amd sfh work functions

Benjamin Tissoires (18):
      HID: core: factor out hid_set_group()
      HID: bpf: rescan the device for the group after a load/unload
      selftests/hid: update vmtest.sh for virtme-ng
      selftests/hid: hidraw: add more coverage for hidraw ioctls
      selftests/hid: hidraw: forge wrong ioctls and tests them
      HID: hidraw: tighten ioctl command parsing
      Merge branch 'for-6.18/core' into for-linus
      Merge branch 'for-6.18/hidraw' into for-linus
      Merge branch 'for-6.18/i2c-hid' into for-linus
      Merge branch 'for-6.18/intel-ish-ipc' into for-linus
      Merge branch 'for-6.18/haptic' into for-linus
      Merge branch 'for-6.18/asus' into for-linus
      Merge branch 'for-6.18/pidff' into for-linus
      Merge branch 'for-6.18/playstation' into for-linus
      Merge branch 'for-6.18/steelseries' into for-linus
      Merge branch 'for-6.18/uclogic' into for-linus
      Merge branch 'for-6.18/selftests' into for-linus
      Merge branch 'for-6.18/intel-thc-hid' into for-linus

Cristian Ciocaltea (14):
      HID: playstation: Make use of bitfield macros
      HID: playstation: Add spaces around arithmetic operators
      HID: playstation: Simplify locking with guard() and scoped_guard()
      HID: playstation: Replace uint{32,16,8}_t with u{32,16,8}
      HID: playstation: Correct spelling in comment sections
      HID: playstation: Fix all alignment and line length issues
      HID: playstation: Document spinlock_t usage
      HID: playstation: Prefer kzalloc(sizeof(*buf)...)
      HID: playstation: Redefine DualSense input report status field
      HID: playstation: Support DualSense audio jack hotplug detection
      HID: playstation: Support DualSense audio jack event reporting
      HID: playstation: Update SP preamp gain comment line
      HID: playstation: Silence sparse warnings for locking context imbalances
      HID: playstation: Switch to scoped_guard() in {dualsense|dualshock4}_output_worker()

Janne Grunau (1):
      HID: lenovo: Use KEY_PERFORMANCE instead of ACPI's platform_profile

Jeongjun Park (1):
      HID: steelseries: refactor probe() and remove()

Jiri Kosina (3):
      HID: steelseries: Fix STEELSERIES_SRWS1 handling in steelseries_remove()
      Merge commit '89c5214639294' into for-6.17/upstream-fixes
      Merge remote-tracking branch 'origin' into for-6.18/intel-thc-hid

Liu Song (2):
      HID: Intel-thc-hid: Intel-thc: Use str_true_false() helper
      HID: uclogic: Use str_true_false() helper

Mario Limonciello (AMD) (1):
      HID: i2c-hid: Resolve touchpad issues on Dell systems during S4

Rahul Rameshbabu (1):
      HID: core: Change hid_driver to use a const char* for name

Sébastien Szymanski (1):
      HID: cp2112: fix setter callbacks return value

Tomasz Pakuła (18):
      HID: pidff: Use direction fix only for conditional effects
      HID: pidff: Remove unhelpful pidff_set_actuators helper
      HID: pidff: Remove unneeded debug
      HID: pidff: Use ARRAY_SIZE macro instead of sizeof
      HID: pidff: Treat PID_REQUIRED_REPORTS as count, not max
      HID: pidff: Better quirk assigment when searching for fields
      HID: pidff: Simplify HID field/usage searching logic
      HID: pidff: Add support for AXES_ENABLE field
      HID: pidff: Update debug messages
      HID: pidff: Rework pidff_upload_effect
      HID: pidff: Separate check for infinite duration
      HID: pidff: PERMISSIVE_CONTROL quirk autodetection
      HID: pidff: Remove Anssi's email address from info msg
      HID: pidff: Define all cardinal directions
      HID: pidff: clang-format pass
      HID: universal-pidff: clang-format pass
      HID: pidff: Reduce PID_EFFECT_OPERATION spam
      HID: pidff: Fix possible null pointer dereference

Xinpeng Sun (3):
      HID: intel-thc-hid: intel-quicki2c: Add WCL Device IDs
      HID: intel-thc-hid: intel-quickspi: Add WCL Device IDs
      HID: intel-thc-hid: intel-quicki2c: support ACPI config for advanced features

Zhang Lixu (1):
      HID: intel-ish-ipc: Remove redundant ready check after timeout function

 Documentation/input/event-codes.rst                     |   14 +
 drivers/hid/Kconfig                                     |   13 +-
 drivers/hid/Makefile                                    |    1 +
 drivers/hid/amd-sfh-hid/amd_sfh_client.c                |   12 +-
 drivers/hid/amd-sfh-hid/amd_sfh_common.h                |    3 +
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c                  |    4 +
 drivers/hid/hid-asus.c                                  |    9 +-
 drivers/hid/hid-core.c                                  |   44 ++-
 drivers/hid/hid-cp2112.c                                |   10 +-
 drivers/hid/hid-haptic.c                                |  580 +++++++++++++++++++++++++++++++++
 drivers/hid/hid-haptic.h                                |  127 ++++++++
 drivers/hid/hid-ids.h                                   |    4 +-
 drivers/hid/hid-input.c                                 |   18 +-
 drivers/hid/hid-lenovo.c                                |    4 +-
 drivers/hid/hid-multitouch.c                            |   47 +++
 drivers/hid/hid-playstation.c                           | 1073 ++++++++++++++++++++++++++++++++++---------------------------
 drivers/hid/hid-quirks.c                                |    2 +
 drivers/hid/hid-steelseries.c                           |  108 +++----
 drivers/hid/hid-uclogic-params.c                        |   10 +-
 drivers/hid/hid-universal-pidff.c                       |   57 ++--
 drivers/hid/hidraw.c                                    |  224 +++++++------
 drivers/hid/i2c-hid/i2c-hid-acpi.c                      |    8 +
 drivers/hid/i2c-hid/i2c-hid-core.c                      |   28 +-
 drivers/hid/i2c-hid/i2c-hid.h                           |    2 +
 drivers/hid/intel-ish-hid/ipc/ipc.c                     |   17 +-
 drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c |   41 ++-
 drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-dev.h |   26 +-
 drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c |    2 +
 drivers/hid/intel-thc-hid/intel-quickspi/quickspi-dev.h |    2 +
 drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.c     |    3 +-
 drivers/hid/usbhid/hid-pidff.c                          |  716 ++++++++++++++++++++++++-----------------
 drivers/hid/usbhid/hid-pidff.h                          |    2 +-
 drivers/input/input-mt.c                                |   14 +-
 include/linux/hid.h                                     |   31 +-
 include/linux/input/mt.h                                |    1 +
 include/uapi/linux/hidraw.h                             |    2 +
 include/uapi/linux/input-event-codes.h                  |    1 +
 include/uapi/linux/input.h                              |   22 +-
 tools/testing/selftests/hid/hid_common.h                |    6 +
 tools/testing/selftests/hid/hidraw.c                    |  473 +++++++++++++++++++++++++++
 tools/testing/selftests/hid/vmtest.sh                   |  668 ++++++++++++++++++++++++--------------
 41 files changed, 3150 insertions(+), 1279 deletions(-)
 create mode 100644 drivers/hid/hid-haptic.c
 create mode 100644 drivers/hid/hid-haptic.h

--

Cheers,
Benjamin

