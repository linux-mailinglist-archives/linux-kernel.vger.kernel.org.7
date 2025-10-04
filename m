Return-Path: <linux-kernel+bounces-842077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5F8BB8E73
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 16:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5E3404E299E
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 14:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0171CA4E;
	Sat,  4 Oct 2025 14:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AwHczAbD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155BF15E5BB;
	Sat,  4 Oct 2025 14:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759586626; cv=none; b=ff70vqyQPp3trauX73VL3O1IEfabZpnJZcuTEwImLkk9oBv4GqB6aIgoSdfq0OgsJPNUKi/1FwGyP6k9/Jy77BgczN/Q9GJZIwrL511r11vUsgXmUM1Ol5lLalQGmk5rZVu1NaRefF8cJB9xmu2HSeGEcnaamY64P5KpZOi6LgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759586626; c=relaxed/simple;
	bh=3kBk0kJ5x/4TZQqZhETvagnPX7mifvyfG210Q+2n4iQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=k/newXZnAE6uppW6js3dJNx2a8giooSAw4qLF7H3HsBZ7HeilqKDsZ/bM9YNGH5AhhVBlgs6IvhlVQw8Df68YqXHjamQXK6tsw+NXzb6uTUIIu3ouDSt1daAh/mGxh7fJeyrAKbz8Zpa19H+sSbGXbIvJuIR25Svuak2NIgdNXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AwHczAbD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 805B0C4CEF1;
	Sat,  4 Oct 2025 14:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759586625;
	bh=3kBk0kJ5x/4TZQqZhETvagnPX7mifvyfG210Q+2n4iQ=;
	h=Date:From:To:Cc:Subject:From;
	b=AwHczAbD8h69CQZIk26isWHMixrbeBn7RpyZYmPkeo05ORmGKHmtTLRSMBTlRwoIL
	 +CTlGTjRY5Z1MRN8XmYjemJpb0wlLxrKQuPwX3i+qG8WWdB4164diFWOE0Ek8BAB/y
	 /raM5ZjLZMP8VBuS5sPnknt3z7jibFz/mFI1Xtcc=
Date: Sat, 4 Oct 2025 16:03:43 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [GIT PULL] Staging driver updates for 6.18-rc1
Message-ID: <aOEpP3nLOrQAKh6C@kroah.com>
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

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-6.18-rc1

for you to fetch changes up to b76029bdd71054b17f62740fe9617d6b2ea601c3:

  staging: rtl8723bs: xmit: rephrase comment and drop extra space (2025-09-17 12:15:33 +0200)

----------------------------------------------------------------
Staging driver changes for 6.18-rc1

Here is the "big" set of staging driver changes for 6.18-rc1.  Nothing
really exciting in here they pretty much consist of:
  - minor coding style changes and cleanups
  - some api layer removals where not needed

Overall a quiet development cycle.

All have been in linux-next for a while with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Ahmet Sezgin Duran (1):
      staging: sm750fb: rename camel case variable

Akiyoshi Kurita (4):
      staging: rtl8723bs: rtw_efuse.h: simplify copyright banner
      staging: rtl8723bs: fix typo in comment
      staging: rtl8723bs: hal: put return type and function name on one line
      staging: rtl8723bs: xmit: rephrase comment and drop extra space

Ali Nasrolahi (1):
      staging: rtl8723bs: fix comment formatting in basic_types.h

Bruce Qin (1):
      staging: rtl8723bs: fix if-statement alignment and line continuation in rtw_ap.c

Jannik Rehkemper (1):
      staging: rtl8723bs: fix checkpatch spaces preferred around that

Len Bao (1):
      staging: octeon: Use 'u64' instead of 'uint64_t' in union cvmx_pip_wqe_word2

Liao Yuanhong (1):
      staging: gpib: tnt4882: Remove redundant header files

Luke Yang (1):
      staging: gpib: tidy-up comments

Michael Straube (42):
      staging: rtl8723bs: remove wrapper rtw_os_indicate_scan_done
      staging: rtl8723bs: move init_mlme_ext_timer to core/rtw_mlme_ext.c
      staging: rtl8723bs: move rtw_init_mlme_timer to core/rtw_mlme.c
      staging: rtl8723bs: remove wrapper init_addba_retry_timer
      staging: rtl8723bs: merge rtw_os_indicate_connect into rtw_indicate_connect
      staging: rtl8723bs: merge rtw_os_indicate_disconnect into rtw_indicate_disconnect
      staging: rtl8723bs: move rtw_report_sec_ie to core/rtw_mlme.c
      staging: rtl8723bs: move rtw_reset_securitypriv to core/rtw_mlme.c
      staging: rtl8723bs: use crypto_xor_cpy
      staging: rtl8723bs: remove unnecessary forward declarations
      staging: rtl8723bs: remove bPseudoTest from EFUSE_ShadowMapUpdate
      staging: rtl8723bs: make Efuse_ReadAllMap static
      staging: rtl8723bs: remove bPseudoTest from Efuse_ReadAllMap
      staging: rtl8723bs: remove wrapper efuse_ReadEFuse
      staging: rtl8723bs: remove bPseudoTest from Hal_ReadEFuse
      staging: rtl8723bs: remove bPseudoTest from hal_ReadEFuse_WiFi
      staging: rtl8723bs: remove bPseudoTest from hal_ReadEFuse_BT
      staging: rtl8723bs: remove wrapper EFUSE_GetEfuseDefinition
      staging: rtl8723bs: remove bPseudoTest from Hal_GetEfuseDefinition
      staging: rtl8723bs: remove Hal_EfuseGetCurrentSize
      staging: rtl8723bs: remove bPseudoTest from hal_EfuseSwitchToBank
      staging: rtl8723bs: clean up variable initializations
      staging: rtl8723bs: remove bPseudoTest from efuse_OneByteRead
      staging: rtl8723bs: remove efuse_OneByteWrite
      staging: rtl8723bs: remove wrapper rtw_init_recv_timer
      staging: rtl8723bs: move rtw_recv_indicatepkt to rtw_recv.c
      staging: rtl8723bs: move rtw_handle_tkip_mic_err to rtw_recv.c
      staging: rtl8723bs: merge rtw_os_free_recvframe into rtw_recv.c
      staging: rtl8723bs: merge rtw_os_recv_resource_alloc into rtw_recv.c
      staging: rtl8723bs: merge rtw_os_recv_resource_free into rtw_recv.c
      staging: rtl8723bs: merge rtw_os_recvbuf_resource_free into rtl8723bs_recv.c
      staging: rtl8723bs: move rtw_os_alloc_msdu_pkt to rtw_recv.c
      staging: rtl8723bs: rename rtw_os_alloc_msdu_pkt
      staging: rtl8723bs: move rtw_os_recv_indicate_pkt to rtw_recv.c
      staging: rtl8723bs: rename rtw_os_recv_indicate_pkt
      staging: rtl8723bs: remove os_dep/recv_linux.c
      staging: rtl8723bs: remove include/recv_osdep.h
      staging: rtl8723bs: remove wrapper Efuse_PowerSwitch
      staging: rtl8723bs: remove bWrite from Hal_EfusePowerSwitch
      staging: rtl8723bs: remove REG_EFUSE_ACCESS_8723 and EFUSE_ACCESS_ON_8723
      staging: rtl8723bs: Hal_EfuseParseAntennaDiversity_8723B is empty
      staging: rtl8723bs: remove unused tables

Mohammed GUERMOUD (1):
      staging: octeon: Clean up dead code in ethernet-tx.c

Nino Zhang (1):
      staging: rtl8723bs: fix coding style issues in core/rtw_mlme.c

Ovidiu Panait (2):
      staging: axis-fifo: remove unnecessary dev_set_drvdata() calls
      staging: axis-fifo: use unique identifiers in device names

Qianfeng Rong (1):
      staging: gpib: use int type to store negative error codes

Yiming Qian (2):
      staging: sm750fb: remove unnecessary volatile qualifiers
      staging: sm750fb: rename snake case variables

Yuri Martins (1):
      staging: vc04_services/vchiq-mmal: fix typos in comments

Zhuoheng Li (1):
      staging: rtl8723bs: fix space-before-tab warnings

yingche (1):
      staging: rtl8723bs: fix fortify warnings by using struct_group

 drivers/staging/axis-fifo/axis-fifo.c              |  37 ++-
 .../staging/gpib/agilent_82357a/agilent_82357a.c   |  18 +-
 .../staging/gpib/agilent_82357a/agilent_82357a.h   |  10 +-
 drivers/staging/gpib/cb7210/cb7210.h               |   4 +-
 drivers/staging/gpib/cec/cec_gpib.c                |   2 +-
 drivers/staging/gpib/common/gpib_os.c              |   2 +-
 drivers/staging/gpib/common/iblib.c                |   2 +-
 drivers/staging/gpib/eastwood/fluke_gpib.c         |   2 +-
 drivers/staging/gpib/fmh_gpib/fmh_gpib.c           |   2 +-
 drivers/staging/gpib/gpio/gpib_bitbang.c           |  16 +-
 drivers/staging/gpib/hp_82341/hp_82341.c           |  12 +-
 drivers/staging/gpib/hp_82341/hp_82341.h           |  40 +--
 drivers/staging/gpib/include/amccs5933.h           |   4 +-
 drivers/staging/gpib/include/gpib_types.h          |   3 +-
 drivers/staging/gpib/include/nec7210.h             |  26 +-
 drivers/staging/gpib/include/nec7210_registers.h   |   4 +-
 drivers/staging/gpib/include/plx9050.h             |   8 +-
 drivers/staging/gpib/include/tms9914.h             |  90 ++---
 drivers/staging/gpib/include/tnt4882_registers.h   |  22 +-
 drivers/staging/gpib/ines/ines.h                   |  12 +-
 drivers/staging/gpib/ines/ines_gpib.c              |   4 +-
 drivers/staging/gpib/nec7210/nec7210.c             |   6 +-
 drivers/staging/gpib/ni_usb/ni_usb_gpib.c          |  10 +-
 drivers/staging/gpib/ni_usb/ni_usb_gpib.h          |  10 +-
 drivers/staging/gpib/pc2/pc2_gpib.c                |   4 +-
 drivers/staging/gpib/tms9914/tms9914.c             |  10 +-
 drivers/staging/gpib/tnt4882/mite.h                |  10 +-
 drivers/staging/gpib/tnt4882/tnt4882_gpib.c        |   5 +-
 drivers/staging/octeon/ethernet-tx.c               |  40 ---
 drivers/staging/octeon/octeon-stubs.h              | 136 ++++----
 drivers/staging/rtl8723bs/Makefile                 |   2 -
 drivers/staging/rtl8723bs/core/rtw_ap.c            |   8 +-
 drivers/staging/rtl8723bs/core/rtw_efuse.c         | 169 +---------
 drivers/staging/rtl8723bs/core/rtw_mlme.c          | 231 +++++++++----
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c      | 130 ++++----
 drivers/staging/rtl8723bs/core/rtw_pwrctrl.c       |  10 +-
 drivers/staging/rtl8723bs/core/rtw_recv.c          | 194 ++++++++++-
 drivers/staging/rtl8723bs/core/rtw_security.c      |  78 +----
 drivers/staging/rtl8723bs/core/rtw_sta_mgt.c       |   6 +-
 drivers/staging/rtl8723bs/core/rtw_wlan_util.c     |  60 ++--
 drivers/staging/rtl8723bs/core/rtw_xmit.c          |   2 +-
 drivers/staging/rtl8723bs/hal/hal_com_phycfg.c     |   5 +-
 drivers/staging/rtl8723bs/hal/hal_pwr_seq.c        |   2 +-
 drivers/staging/rtl8723bs/hal/odm.c                | 152 ---------
 drivers/staging/rtl8723bs/hal/odm.h                |   6 -
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c  | 368 +++------------------
 drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c     |   6 +-
 drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c     |   2 +-
 drivers/staging/rtl8723bs/hal/sdio_halinit.c       |   1 -
 drivers/staging/rtl8723bs/include/basic_types.h    |  41 +--
 drivers/staging/rtl8723bs/include/drv_types.h      |   2 -
 drivers/staging/rtl8723bs/include/hal_intf.h       |   7 +-
 drivers/staging/rtl8723bs/include/mlme_osdep.h     |  19 --
 drivers/staging/rtl8723bs/include/recv_osdep.h     |  40 ---
 drivers/staging/rtl8723bs/include/rtl8723b_hal.h   |   2 -
 drivers/staging/rtl8723bs/include/rtw_efuse.h      |  15 +-
 drivers/staging/rtl8723bs/include/rtw_mlme.h       |   1 +
 drivers/staging/rtl8723bs/include/rtw_mlme_ext.h   |   2 -
 drivers/staging/rtl8723bs/include/rtw_recv.h       |   4 +
 drivers/staging/rtl8723bs/os_dep/mlme_linux.c      | 179 ----------
 drivers/staging/rtl8723bs/os_dep/recv_linux.c      | 225 -------------
 drivers/staging/sm750fb/sm750.h                    |   6 +-
 drivers/staging/sm750fb/sm750_accel.c              |   8 +-
 drivers/staging/sm750fb/sm750_hw.c                 |   4 +-
 .../staging/vc04_services/vchiq-mmal/mmal-msg.h    |   2 +-
 .../staging/vc04_services/vchiq-mmal/mmal-vchiq.c  |   2 +-
 .../staging/vc04_services/vchiq-mmal/mmal-vchiq.h  |   2 +-
 67 files changed, 858 insertions(+), 1686 deletions(-)
 delete mode 100644 drivers/staging/rtl8723bs/include/mlme_osdep.h
 delete mode 100644 drivers/staging/rtl8723bs/include/recv_osdep.h
 delete mode 100644 drivers/staging/rtl8723bs/os_dep/mlme_linux.c
 delete mode 100644 drivers/staging/rtl8723bs/os_dep/recv_linux.c

