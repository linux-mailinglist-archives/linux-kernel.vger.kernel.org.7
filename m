Return-Path: <linux-kernel+bounces-783103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4C7B32965
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 16:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E306E1893914
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 14:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF0D21B8F5;
	Sat, 23 Aug 2025 14:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="truQuPMy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821222135D1
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 14:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755960313; cv=none; b=SdSfz6dedWv+nd6aai+J/JZjKZ4JbOndiSep4Yyr+dhGFEKko6Abx56XBKwLqb3wbtN2p5TpECZDp3sHlUWJqmcpTWC83u9jOwV0qtYKIL2jSpILjcGer8cu523CnbsxYUF5GWFK0zGaxArMPUAeNlDkVAmekCqu91qCLJVTZNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755960313; c=relaxed/simple;
	bh=i/F8Fwe6uYBrP8vNdDFheItSGQyFXOJkkIi52nL/IPE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=k4/3du26sBzULqNStb0O7VDwDIJh2uTS9bi0Gw2BXZ84GyI3dWUMJt8N3i7psP/bLhNuSKA04pH0/1+wf8VNuEWQbVPq1h7InrwYDqaHAfNQ7VaNrT+47WKExAhU9pyEZ3UbRzEV7Sx2RbZdKV0S54x60FHTtx0+Qcn5U3x4fJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=truQuPMy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2DC9C4CEF4;
	Sat, 23 Aug 2025 14:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755960313;
	bh=i/F8Fwe6uYBrP8vNdDFheItSGQyFXOJkkIi52nL/IPE=;
	h=Date:From:To:Cc:Subject:From;
	b=truQuPMyBls82wZK36J5GbpvsC86kmXzTO4+hIVprdGz0EOSoXlrmyHumLQaViShO
	 /YHiaKoUZS8Qs41UGyEM7T02AZFJZ+SUW8QKA7Auhnh9wv6SJs4h0WiDXw98PSiSFM
	 wOBtw0G0L6TY6NRJdipNgUvZppDHnGP4Sc4+M56Q=
Date: Sat, 23 Aug 2025 16:45:10 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc/IIO driver fixes for 6.17-rc3
Message-ID: <aKnT9goiCOPLVeZe@kroah.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9:

  Linux 6.17-rc2 (2025-08-17 15:22:10 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.17-rc3

for you to fetch changes up to fe85261d7d554f54693f205898260ef1d44cbd8b:

  Merge tag 'iio-fixes-for-6.17a' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-linus (2025-08-20 11:05:00 +0200)

----------------------------------------------------------------
Char/Misc/IIO fixes for 6.17-rc3

Here are a small number of char/misc/iio and other driver fixes for
6.17-rc3.  Included in here are:
  - IIO driver bugfixes for reported issues
  - bunch of comedi driver fixes
  - most core bugfix
  - fpga driver bugfix
  - cdx driver bugfix

All of these have been in linux-next this week with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Claudiu Beznea (2):
      iio: adc: rzg2l: Cleanup suspend/resume path
      iio: adc: rzg2l_adc: Set driver data before enabling runtime PM

David Lechner (6):
      iio: accel: sca3300: fix uninitialized iio scan data
      iio: proximity: isl29501: fix buffered read on big-endian systems
      iio: adc: ad7173: prevent scan if too many setups requested
      iio: temperature: maxim_thermocouple: use DMA-safe buffer for spi_read()
      iio: adc: ad7124: fix channel lookup in syscalib functions
      iio: adc: ad7380: fix missing max_conversion_rate_hz on adaq4381-4

Edward Adam Davis (1):
      comedi: pcl726: Prevent invalid irq number

Greg Kroah-Hartman (1):
      Merge tag 'iio-fixes-for-6.17a' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-linus

Ian Abbott (2):
      comedi: Fix use of uninitialized memory in do_insn_ioctl() and do_insnlist_ioctl()
      comedi: Make insn_rw_emulate_bits() do insn->n samples

Jean-Baptiste Maneyrol (1):
      iio: imu: inv_icm42600: change invalid data error to -EBUSY

Jonathan Cameron (1):
      iio: light: as73211: Ensure buffer holes are zeroed

Matti Vaittinen (1):
      iio: adc: bd79124: Add GPIOLIB dependency

Miaoqian Lin (1):
      most: core: Drop device reference after usage in get_channel()

Salah Triki (1):
      iio: pressure: bmp280: Use IS_ERR() in bmp280_common_probe()

Thorsten Blum (1):
      cdx: Fix off-by-one error in cdx_rpmsg_probe()

Xu Yilun (1):
      fpga: zynq_fpga: Fix the wrong usage of dma_map_sgtable()

 drivers/cdx/controller/cdx_rpmsg.c               |  3 +-
 drivers/comedi/comedi_fops.c                     |  5 ++
 drivers/comedi/drivers.c                         | 27 ++++----
 drivers/comedi/drivers/pcl726.c                  |  3 +-
 drivers/fpga/zynq-fpga.c                         |  8 +--
 drivers/iio/accel/sca3300.c                      |  2 +-
 drivers/iio/adc/Kconfig                          |  2 +-
 drivers/iio/adc/ad7124.c                         | 14 ++--
 drivers/iio/adc/ad7173.c                         | 87 ++++++++++++++++++++----
 drivers/iio/adc/ad7380.c                         |  1 +
 drivers/iio/adc/rzg2l_adc.c                      | 33 +++------
 drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c |  6 +-
 drivers/iio/light/as73211.c                      |  2 +-
 drivers/iio/pressure/bmp280-core.c               |  9 +--
 drivers/iio/proximity/isl29501.c                 | 14 ++--
 drivers/iio/temperature/maxim_thermocouple.c     | 26 ++++---
 drivers/most/core.c                              |  2 +-
 17 files changed, 159 insertions(+), 85 deletions(-)

