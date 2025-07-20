Return-Path: <linux-kernel+bounces-738141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2A3B0B4F7
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 12:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 180673B5C2B
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 10:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A31517A31C;
	Sun, 20 Jul 2025 10:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K6Ew+LW5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6BC1DE3BE
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 10:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753008423; cv=none; b=HP4VVmRLYuSyvLDypUgZe4jHrP3PRQ+O2JRx4hjCGBoSZ+JUg1pw76KlQ5ejeAuUd9XSHLSj/rM17cz4n6v/5zPAPQL36UIlLyU9NR836AXnFCoRN/mY3Gey24H85FcK4FLZf6AzN3h5CJ5ONSEWifG9MdOsZmduJwr7I/H4SE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753008423; c=relaxed/simple;
	bh=8mOe/TlbLx5++XUj6fIjftNUzTmsgfKYbff4HS8ZHi4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=R05OcvarFtnYUBFz9yc3+Rxm11Rxx98dOi3yzSVxFNJA/i0WU6dl8ySratKVG2of2G9hdOJyaz48Yj1RzBxP+oa+BD9WBYpcopho55PQXQmewWPSSwdQP7Xda+zvN0P8RxcLz0sFRuxtdU3xz7hglJonBhatwpDJFFOMYn4Ra9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=K6Ew+LW5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CDEBC4CEEB;
	Sun, 20 Jul 2025 10:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753008423;
	bh=8mOe/TlbLx5++XUj6fIjftNUzTmsgfKYbff4HS8ZHi4=;
	h=Date:From:To:Cc:Subject:From;
	b=K6Ew+LW5mox0MHciCW7LQswJXARt0szS6ct/kocMRWUIZdwARqppLfjesYl128bRC
	 PoRpDMnKchBHnP8q0Ap5jtaXkKpMVtQFxl58nPCYnHt3+WK8/N97x2DgPayC4hqErc
	 YLhtzIurM5g+IKZyuOZwt4x8BjeNPor4C+P3t/sk=
Date: Sun, 20 Jul 2025 12:46:59 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc/IIO driver changes for 6.16-rc7
Message-ID: <aHzJIwjrpLJmol5d@kroah.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The following changes since commit 86731a2a651e58953fc949573895f2fa6d456841:

  Linux 6.16-rc3 (2025-06-22 13:30:08 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.16-rc7

for you to fetch changes up to 2d7521aa26ec2dc8b877bb2d1f2611a2df49a3cf:

  nvmem: layouts: u-boot-env: remove crc32 endianness conversion (2025-07-16 16:51:04 +0200)

----------------------------------------------------------------
Char/Misc/IIO fixes for 6.16-rc7

Here are some char/misc/iio and other driver fixes for 6.16-rc7.
Included in here are:
  - IIO driver fixes for reported problems
  - Interconnect driver fixes for reported problems
  - nvmem driver fixes
  - bunch of comedi driver fixes for long-term bugs
  - Kconfig dependancy fixes for mux drivers
  - other small driver fixes for reported problems.

All of these have been in linux-next for a while with no reported
problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Akshay Gupta (3):
      misc: amd-sbi: Address potential integer overflow issue reported in smatch
      misc: amd-sbi: Address copy_to/from_user() warning reported in smatch
      misc: amd-sbi: Explicitly clear in/out arg "mb_in_out"

Angelo Dureghello (1):
      dt-bindings: iio: adc: adi,ad7606: fix dt_schema validation warning

Chen Ni (1):
      iio: adc: stm32-adc: Fix race in installing chained IRQ handler

Chen-Yu Tsai (1):
      iio: adc: axp20x_adc: Add missing sentinel to AXP717 ADC channel maps

David Lechner (3):
      iio: adc: adi-axi-adc: fix ad7606_bus_reg_read()
      iio: adc: ad7949: use spi_is_bpw_supported()
      iio: adc: ad7380: fix adi,gain-milli property parsing

Fabio Estevam (2):
      iio: adc: max1363: Fix MAX1363_4X_CHANS/MAX1363_8X_CHANS[]
      iio: adc: max1363: Reorder mode_list[] entries

Gabor Juhos (3):
      interconnect: increase ICC_DYN_ID_START
      interconnect: icc-clk: destroy nodes in case of memory allocation failures
      interconnect: avoid memory allocation when 'icc_bw_lock' is held

Greg Kroah-Hartman (2):
      Merge tag 'iio-fixes-for-6.16a' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-linus
      Merge tag 'icc-6.16-rc5' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/djakov/icc into char-misc-linus

Ian Abbott (9):
      comedi: Fail COMEDI_INSNLIST ioctl if n_insns is too large
      comedi: Fix some signed shift left operations
      comedi: das16m1: Fix bit shift out of bounds
      comedi: pcl812: Fix bit shift out of bounds
      comedi: aio_iiro_16: Fix bit shift out of bounds
      comedi: das6402: Fix bit shift out of bounds
      comedi: Fix use of uninitialized data in insn_rw_emulate_bits()
      comedi: Fix initialization of data for instructions that write to subdevice
      comedi: comedi_test: Fix possible deletion of uninitialized timers

Johan Hovold (1):
      interconnect: exynos: handle node name allocation failure

Kim Seer Paller (1):
      iio: dac: ad3530r: Fix incorrect masking for channels 4-7 in powerdown mode

Krzysztof Kozlowski (1):
      mux: mmio: Fix missing CONFIG_REGMAP_MMIO

Markus Burri (2):
      iio: backend: fix out-of-bound write
      iio: fix potential out-of-bound write

Maud Spierings (1):
      iio: common: st_sensors: Fix use of uninitialize device structs

Michael C. Pratt (1):
      nvmem: layouts: u-boot-env: remove crc32 endianness conversion

Rodrigo Gobbi (1):
      dt-bindings: iio: gyro: invensense,mpu3050: change irq maxItems

Sean Nyekjaer (1):
      iio: accel: fxls8962af: Fix use after free in fxls8962af_fifo_flush

Steffen Bätz (1):
      nvmem: imx-ocotp: fix MAC address byte length

Tamir Duberstein (1):
      MAINTAINERS: add miscdevice Rust abstractions

Xilin Wu (1):
      interconnect: qcom: sc7280: Add missing num_links to xm_pcie3_1 node

 .../devicetree/bindings/iio/adc/adi,ad7606.yaml    |  6 ---
 .../bindings/iio/gyroscope/invensense,mpu3050.yaml |  2 +-
 MAINTAINERS                                        |  1 +
 drivers/comedi/comedi_fops.c                       | 30 ++++++++++++++-
 drivers/comedi/drivers.c                           | 17 +++++----
 drivers/comedi/drivers/aio_iiro_16.c               |  3 +-
 drivers/comedi/drivers/comedi_test.c               |  2 +-
 drivers/comedi/drivers/das16m1.c                   |  3 +-
 drivers/comedi/drivers/das6402.c                   |  3 +-
 drivers/comedi/drivers/pcl812.c                    |  3 +-
 drivers/iio/accel/fxls8962af-core.c                |  2 +
 drivers/iio/accel/st_accel_core.c                  | 10 ++---
 drivers/iio/adc/ad7380.c                           |  5 ++-
 drivers/iio/adc/ad7949.c                           |  7 ++--
 drivers/iio/adc/adi-axi-adc.c                      |  6 ++-
 drivers/iio/adc/axp20x_adc.c                       |  1 +
 drivers/iio/adc/max1363.c                          | 43 +++++++++++-----------
 drivers/iio/adc/stm32-adc-core.c                   |  7 ++--
 drivers/iio/common/st_sensors/st_sensors_core.c    | 36 +++++++++---------
 drivers/iio/common/st_sensors/st_sensors_trigger.c | 20 +++++-----
 drivers/iio/dac/ad3530r.c                          |  4 +-
 drivers/iio/industrialio-backend.c                 |  5 ++-
 drivers/iio/industrialio-core.c                    |  5 ++-
 drivers/interconnect/core.c                        | 34 ++++++++++++++---
 drivers/interconnect/icc-clk.c                     |  2 +
 drivers/interconnect/qcom/icc-rpmh.c               |  7 +++-
 drivers/interconnect/qcom/osm-l3.c                 |  7 +++-
 drivers/interconnect/qcom/sc7280.c                 |  1 +
 drivers/interconnect/samsung/exynos.c              |  5 +++
 drivers/misc/amd-sbi/rmi-core.c                    | 24 ++++++++----
 drivers/mux/Kconfig                                |  1 +
 drivers/nvmem/imx-ocotp-ele.c                      |  5 ++-
 drivers/nvmem/imx-ocotp.c                          |  5 ++-
 drivers/nvmem/layouts/u-boot-env.c                 |  6 +--
 include/linux/interconnect-provider.h              |  7 ++++
 35 files changed, 213 insertions(+), 112 deletions(-)

