Return-Path: <linux-kernel+bounces-748288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F3EB13F09
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 17:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B212E16190E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 15:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2885F270EA8;
	Mon, 28 Jul 2025 15:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ReuYKPOJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD3D2222C7;
	Mon, 28 Jul 2025 15:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753717404; cv=none; b=kG5stOaRHiNxGGIqb6MuNdGAdbDz+UaP+wQdlF/CjWrdrV3qJTUCpnpQCmGGkaLHN8a0/E/BxZxab7gbQGDumYLVKHjB9qiAtdn+IwwqfodYZjWfAUXyWiLyarMENp9A1QJsp+RXGCGmMwPyl2XAzhSbnxKNP8klbbFkufLv4BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753717404; c=relaxed/simple;
	bh=TAYDtSEjnjbF7DkGh/rpYDTtXmcQfSBW7E+rvEX79V4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MYySGWKdatedEj8MsxKEQF+h9Yj1Nk0zZkvPnQyfaO9nMbdRVNTUVtkITixY0q6APZHuz6Y1rQnjDWQZvj//cUozADZrX5bLc+7mHrnAIKZnFTkpw8Qw6fUxq3eAcve11pIIElTmwUfGKKllWILBkqxoisT68u5ab4ibHCIjWeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ReuYKPOJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8009CC4CEE7;
	Mon, 28 Jul 2025 15:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753717403;
	bh=TAYDtSEjnjbF7DkGh/rpYDTtXmcQfSBW7E+rvEX79V4=;
	h=Date:From:To:Cc:Subject:From;
	b=ReuYKPOJFPUdWktWdhhzH6kWW+rWMS62P/arTynah+Beww5pgOPDn4ipBX6PgKf5B
	 Bvt75t8wH9zhikLN8Bz2IBv5P1OaqC/SXmQZHrfsawJVKSxCsBvpIcbt+1834kB9vW
	 TAv/jac57SlsyfE0ryjQBSc1g82rwR2ytHdqQDpw=
Date: Mon, 28 Jul 2025 17:43:21 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [GIT PULL] Staging driver updates for 6.17-rc1
Message-ID: <aIeamUo74ht2d9Ls@kroah.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit d0b3b7b22dfa1f4b515fd3a295b3fd958f9e81af:

  Linux 6.16-rc4 (2025-06-29 13:09:04 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-6.17-rc1

for you to fetch changes up to 63533ba19d0f325f8e36cc5aae73281a93758618:

  staging: rtl8723bs: remove redundant semicolon in basic_types.h (2025-07-24 11:31:34 +0200)

----------------------------------------------------------------
Staging changes for 6.17-rc1

Here is the "big" set of staging driver changes for 6.17-rc1.  That's in
quotes as it really isn't all that big of a set of changes this
development cycle at all.

Major things that stand out are:
  - gpib cleanups and tweaks with the majority of the big issues now
    taken care of.  Odds are it will move out of staging/ in the next
    merge window if all goes well.
  - more constant cleanups and layer removals from the rtl8723bs driver.
    It's amazing how many layers deep they really are, all cleanups here
    are great to see
  - axis-fifo sysfs api removed and debugfs api added.  The sysfs api
    didn't work at all so obviously no one was using it.  Add the same
    information into debugfs as that's the proper place for it, and make
    it actually work.
  - Remaining changes is lots of small checkpatch cleanups, most of
    which seem to have come from a Debconf session where people were
    encouraged to submit their first kernel patch, a nice thing to see
    happen again.

All of these have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Abdun Nihaal (3):
      staging: fbtft: fix potential memory leak in fbtft_framebuffer_alloc()
      staging: fbtft: fix potential memory leak in fbtft_framebuffer_alloc()
      staging: fbtft: cleanup error handling in fbtft_framebuffer_alloc()

Abhinav Krishna C K (1):
      staging: greybus: Documentation: firmware: Move logical AND to previous line

Akhil Varkey (1):
      staging: greybus: power_supply fix alignment

Akhilesh Patil (1):
      staging: vme_user: fix spelling errors

Alexandre Viard (1):
      staging: rtl8723bs: os_dep: remove whitespace after cast.

Ali Nasrolahi (1):
      staging: rtl8723bs: remove redundant semicolon in basic_types.h

Alok Tiwari (1):
      staging: nvec: Fix incorrect null termination of battery manufacturer

Ana Oliveira (1):
      staging: rtl8723bs: os_dep: remove blank line before close brace '}'

Ananthu C V (1):
      staging: rtl8723bs: remove unncessary multiple blank lines

Andrei Zeucianu (1):
      staging: rtl8723bs: hal: remove blank line before close brace

Bartosz Golaszewski (1):
      staging: greybus: remove unnecessary GPIO line direction check

Bryant Boatright (1):
      staging: rtl8723bs: place constant to right of logical test

Christophe JAILLET (1):
      staging: gpib: Fix error handling paths in cb_gpib_probe()

Colin Ian King (1):
      staging: gpib: fix unset padding field copy back to userspace

Dave Penkler (6):
      staging: gpib: Update TODO
      staging: gpib: Remove unneeded enums and functions
      staging: gpib: Add local include file for commands
      staging: gpib: Use standard size basic uapi types
      staging: gpib: Add bit and byte padding to ioctl structs
      staging: gpib: Add init response codes for new ni-usb-hs+

Gaston Gonzalez (1):
      staging: gpib: fix typo

Greg Kroah-Hartman (3):
      staging: vme: vme_user: fix up const issue in vme_bus_match()
      Merge 6.16-rc4 into staging-next
      staging: greybus: gbphy: fix up const issue with the match callback

Harshit Mogalapalli (3):
      staging: gpib: Fix error code in board_type_ioctl()
      staging: gpib: cec: Fix inconsistent indentation in cec_pci_attach()
      staging: gpib: lpvo_usb_gpib: Remove unreachable return statement

Ignacio Pena (6):
      staging: sm750fb: fix function parameter alignment
      staging: rtl8723bs: remove unnecessary comment separator lines
      staging: rtl8723bs: add missing blank line after declaration
      staging: rtl8723bs: remove unnecessary commented code
      staging: rtl8723bs: remove unnecessary braces in rtl8723b_cmd
      staging: sm750fb: fix CamelCase variable naming

Jonathan Dupart (1):
      staging: rtl8723bs: hal: add spaces around ternary operator

Kisub Choe (2):
      staging: sm750fb: rename 'hwCursor'
      staging: sm750fb: remove function pointer proc_setBLANK

Michael Straube (25):
      staging: rtl8723bs: remove return from void function
      staging: rtl8723bs: remove some 5 GHz code
      staging: rtl8723bs: remove empty functions
      staging: rtl8723bs: remove unused function parameter
      staging: rtl8723bs: remove unnesessary function parameter
      staging: rtl8723bs: remove redundant static function
      staging: rtl8723bs: Efuse_WordEnableDataWrite() is not used
      staging: rtl8723bs: remove function pointer SetHalODMVarHandler
      staging: rtl8723bs: remove wrapper rtl8723b_SetHalODMVar
      staging: rtl8723bs: remove function pointer hal_notch_filter
      staging: rtl8723bs: remove function pointer c2h_handler
      staging: rtl8723bs: remove macro FillH2CCmd
      staging: rtl8723bs: remove function pointer fill_h2c_cmd
      staging: rtl8723bs: remove macro hal_xmit_handler
      staging: rtl8723bs: remove function pointer xmit_thread_handler
      staging: rtl8723bs: remove function pointer hal_reset_security_engine
      staging: rtl8723bs: remove function pointer c2h_id_filter
      staging: rtl8723bs: remove struct hal_ops
      staging: rtl8723bs: CheckFwRsvdPageContent is empty
      staging: rtl8723bs: rtl8723b_set_FwAoacRsvdPage_cmd is empty
      staging: rtl8723bs: rtw_get_encrypt_decrypt_from_registrypriv is empty
      staging: rtl8723bs: _InitOtherVariable is empty
      staging: rtl8723bs: hw_var_port_switch is empty
      staging: rtl8723bs: dm_CheckStatistics is empty
      staging: rtl8723bs: DoIQK_8723B is empty

Milos Puric (1):
      staging: rtl8723bs: Align next line to open parentheses in core/rtw_xmit.c

Nadzeya Hutsko (1):
      staging: vme_user: fixed alignment should match open parenthesis

Ovidiu Panait (2):
      staging: axis-fifo: remove sysfs interface
      staging: axis-fifo: add debugfs interface for dumping fifo registers

Ravi Kant Sharma (1):
      staging: rtl8723bs: remove blank line before close brace.

Simon Chopin (1):
      staging: greybus: Documentation: firmware.c: fix whitespace alignments

Vincent Caron (1):
      staging: rtl8723bs: remove spurious if-block braces

Vivek BalachandharTN (1):
      staging: rtl8723bs: clean up redundant & parentheses

Yuesong Li (1):
      staging: gpib: hp_82341: Replace manual comparison with min/max macro

 drivers/staging/axis-fifo/axis-fifo.c              | 215 ++++-----------------
 drivers/staging/fbtft/fbtft-core.c                 |  38 ++--
 drivers/staging/gpib/TODO                          |   5 +-
 drivers/staging/gpib/cb7210/cb7210.c               |  15 +-
 drivers/staging/gpib/cec/cec_gpib.c                |   2 +-
 drivers/staging/gpib/common/gpib_os.c              |   4 +-
 drivers/staging/gpib/gpio/gpib_bitbang.c           |   2 +-
 drivers/staging/gpib/hp_82341/hp_82341.c           |  10 +-
 drivers/staging/gpib/include/gpibP.h               |   1 +
 drivers/staging/gpib/include/gpib_cmd.h            | 112 +++++++++++
 drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c |   1 -
 drivers/staging/gpib/ni_usb/ni_usb_gpib.c          |  14 +-
 drivers/staging/gpib/uapi/gpib.h                   | 198 -------------------
 drivers/staging/gpib/uapi/gpib_ioctl.h             | 112 +++++------
 .../greybus/Documentation/firmware/firmware.c      |  28 +--
 drivers/staging/greybus/gbphy.c                    |   6 +-
 drivers/staging/greybus/gpio.c                     |   6 -
 drivers/staging/greybus/power_supply.c             |  14 +-
 drivers/staging/nvec/nvec_power.c                  |   2 +-
 drivers/staging/rtl8723bs/core/rtw_ap.c            |   9 +-
 drivers/staging/rtl8723bs/core/rtw_cmd.c           |   3 -
 drivers/staging/rtl8723bs/core/rtw_efuse.c         |  25 +--
 drivers/staging/rtl8723bs/core/rtw_mlme.c          | 152 +++++++--------
 drivers/staging/rtl8723bs/core/rtw_wlan_util.c     |   9 +-
 drivers/staging/rtl8723bs/core/rtw_xmit.c          |   2 +-
 drivers/staging/rtl8723bs/hal/HalPhyRf.h           |   2 -
 drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c     |  10 -
 drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.h     |   7 -
 drivers/staging/rtl8723bs/hal/hal_com.c            |   7 -
 drivers/staging/rtl8723bs/hal/hal_intf.c           |  37 +---
 drivers/staging/rtl8723bs/hal/odm.c                |  10 -
 drivers/staging/rtl8723bs/hal/odm_DIG.c            |   1 -
 drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c       |  27 +--
 drivers/staging/rtl8723bs/hal/rtl8723b_dm.c        |   7 -
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c  |  98 +---------
 drivers/staging/rtl8723bs/hal/sdio_halinit.c       |  13 --
 drivers/staging/rtl8723bs/include/basic_types.h    |   2 +-
 drivers/staging/rtl8723bs/include/drv_types.h      |   1 -
 drivers/staging/rtl8723bs/include/hal_com.h        |   2 -
 drivers/staging/rtl8723bs/include/hal_intf.h       |  17 +-
 drivers/staging/rtl8723bs/include/ioctl_cfg80211.h |   1 +
 drivers/staging/rtl8723bs/include/rtl8723b_cmd.h   |   3 -
 drivers/staging/rtl8723bs/include/rtl8723b_hal.h   |   1 -
 drivers/staging/rtl8723bs/include/rtl8723b_xmit.h  |   1 -
 drivers/staging/rtl8723bs/include/rtw_efuse.h      |   1 -
 drivers/staging/rtl8723bs/include/rtw_mlme.h       |   2 -
 drivers/staging/rtl8723bs/include/sdio_hal.h       |   2 -
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c  |  24 +--
 drivers/staging/rtl8723bs/os_dep/os_intfs.c        |  19 +-
 drivers/staging/rtl8723bs/os_dep/sdio_intf.c       |   4 +-
 drivers/staging/rtl8723bs/os_dep/sdio_ops_linux.c  |   1 -
 drivers/staging/rtl8723bs/os_dep/wifi_regd.c       |  16 +-
 drivers/staging/sm750fb/sm750.c                    |  36 ++--
 drivers/staging/sm750fb/sm750.h                    |   4 +-
 drivers/staging/vme_user/vme.c                     |   6 +-
 drivers/staging/vme_user/vme_fake.c                |   2 +-
 drivers/staging/vme_user/vme_tsi148.h              |   2 +-
 57 files changed, 426 insertions(+), 925 deletions(-)
 create mode 100644 drivers/staging/gpib/include/gpib_cmd.h

