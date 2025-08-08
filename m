Return-Path: <linux-kernel+bounces-760128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F803B1E6DA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 12:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 390D4566088
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 10:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAFF5256C73;
	Fri,  8 Aug 2025 10:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="jaTsuWve"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FD525178C
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 10:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754650490; cv=none; b=djetN7suqB9nMGY8Avp/5uWXjA+ltdIfJCHoPW+9FIoiDOom1FApBXR0oEM+xfK6kxtkxwdtNAORYj46FfnVlUigA8ESxNvZeQhifMxT2lB02jhcTduYvMIvpg8nLDa8gsE/3va5Yz2vcAbv6e7mKKWsPAkqrzVAgJkmo4h3tSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754650490; c=relaxed/simple;
	bh=EV3g5k5zyxsKK5CBzB9Qk0ayiK4C5buxD+vlITadXMk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=InX3g9BQoPr5+8KLkLjAZ62RN0a22lJppqfLONqzb5lYiT4dUtsIpN93mvnyeA035pxS8TomfYmtdSVnCZ2BrwAsYdAaYiGk052z+zDYeQNGg2IEBxv8zrtXVX5OvzorXsYtDml4/qeTpcYvNibH32rnJXJuA8PRIFblj6jmAAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=jaTsuWve; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3b8db5e9b35so1036768f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 03:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1754650485; x=1755255285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZFbJ7DGUr43TNrU2K/61XZxe2nHYhi0+LrpKBxoo42E=;
        b=jaTsuWveH320USeZYnSZ5X+ilo2Sc/mIrVfrmhz///iMmwrTLJ44T/vV5CvdD995Y0
         hS3vWRZIhOkfGNmmQjm9GHSRIaGTL/hb1vaHM9am2lWpVo+ZPyQn6WUdTmYdxcZ6Tews
         CaYXuP7rvYg3Q2ChtF2eQnUAOoy3QJr3nYbTco67m86ZRl+rG9qZ9eRQFijfT/Ma5Dma
         xNNSzv+Lkriea+fvUiJbx8WJ9TMgBhXVgnBVcJUWFOvdM/NiDL/6plg6sNeKM1rO5Gdr
         8ZMgNpHyjpjYXyd+4enC2gWpwPlOY0kurZQyctMa4UxXxnIku4Ztz0jJtunRDDaJgfmk
         PmiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754650485; x=1755255285;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZFbJ7DGUr43TNrU2K/61XZxe2nHYhi0+LrpKBxoo42E=;
        b=uGB7hj6Ka4mZDW28Ye0/UHvhhvYx5f9TdZB8pQLvCPFJNsmr0DbIg75EJJ6F/h5xBd
         dOkwoabhZ+sSIEA5x3PqyQS4nKn1qWSm9tdqq6CwcmFvi8e+xjCnooQI2fD9gK0jdb1x
         ukGp52jYlSnTAaZUvotRDd4UCBSLaPIMW0Meq4o1/De3n7LFvfYQrnr80W42nsrV2eJS
         DdgqbLOMwzuAd9jpQtsNnBSvIpxMQ8fZzGBiI59Dc/ewITFJMIb/3LfuwEDhuDalFKoF
         CIX0HjlXFDLPPYHmPEsjrgxZj9l/Ew5TVVpLqOApnLumfUinobtQdtJgtkZFgG5gEN/M
         Xg3w==
X-Forwarded-Encrypted: i=1; AJvYcCX0ZWCkvYle2UGyvYHMbcnVk1vGadWH5zUUlkmr4yNAK09NKzMhk3izTmZ2XCmUfLbAzWJ6ZcIar8wwj88=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj04Ndx9mUN4nUShGjIrp+v7HMI+TIflCg7r10VatnmLx6Bzn4
	XjyFsa+CIVBF4zHWY8zJkmzVRFFdCmsXIYDNsF8TR54KAW9F50exRPqM2dZVvGtsuAc=
X-Gm-Gg: ASbGnct/RJ60SpkI9VXHdSsYvD7gnK764rZp7DhiARwBOx4Q7/wSu3ihrCy6838d9ih
	/hwz6Unk/VgZo3/q5Dm8FgYKMzPijZl8Gw8+dRtoDURrOl8FWS4+Yv4mN0tgdJ0YoA/ZsdwWXwm
	4jRBvJTkZgtqU4yD25//ryhPc69OhpibfqdEBz55YTOJI4IbARfK188ssD7qYtHv6P1s6TmTlHi
	k+KctvZpi+Wi1VdiV7ra43dJGxVCR217cVF6AlWpBJuK0xphS6AzlS1lg8WzkjfNU+PTekqavMg
	CKPngUZBmBR5SZsLhPLNYPpcI5ujSNKOtoFOGrpgebT9uhTeW9aIKQ4L4SbL9JqrOPiVGiOFJyv
	jp+yIt30RiFvI7JwyCDKNsBh+z7hp5/9DaK67s0qG6fQKZCK37Tg2UsNmK+GRbVxGiC2Cwzkfun
	sFDEjDDn+kGX8qpoO7
X-Google-Smtp-Source: AGHT+IHKS+oeeNKj/EFlrmrofpMOFfPx1KyywWr1hRI8tAdaxlhC/+6F4BOCfjFok9c0Kftk9FX8Jw==
X-Received: by 2002:a05:6000:2011:b0:3a5:1cc5:aa6f with SMTP id ffacd0b85a97d-3b900b4dbdemr1960149f8f.34.1754650485269;
        Fri, 08 Aug 2025 03:54:45 -0700 (PDT)
Received: from brgl-pocket.. (2a02-8440-f50a-1439-dbd6-857c-37ea-be16.rev.sfr.net. [2a02:8440:f50a:1439:dbd6:857c:37ea:be16])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4532c4sm29723646f8f.36.2025.08.08.03.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 03:54:44 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [GIT PULL] gpio updates for v6.17-rc1 - part 2
Date: Fri,  8 Aug 2025 12:54:36 +0200
Message-ID: <20250808105436.6021-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Linus,

With all dependencies now in mainline, here's the second GPIO pull request
for v6.17-rc1. As discussed: there's a small commit that removes the
legacy GPIO line value setter callbacks as they're no longer used and
a big, treewide commit that renames the new ones to the old names across
all GPIO drivers at once.

There's a small conflict with the SoC fixes tree in a seldom used board
file. You can just prioritise my tree as with it, the other change is no
longer needed.

While at it: there are also two fixes that I picked up over the course of
the merge window. Details are in the signed tag.

Please pull,
Bartosz Golaszewski

The following changes since commit 6e64f4580381e32c06ee146ca807c555b8f73e24:

  Merge tag 'input-for-v6.17-rc0' of git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input (2025-08-07 07:40:01 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-updates-for-v6.17-rc1-part2

for you to fetch changes up to d9d87d90cc0b10cd56ae353f50b11417e7d21712:

  treewide: rename GPIO set callbacks back to their original names (2025-08-07 10:07:06 +0200)

----------------------------------------------------------------
gpio updates for v6.17-rc1

- remove unused, legacy GPIO line value setters from struct gpio_chip
- rename the new set callbacks back to the original names treewide
- fix interrupt handling in gpio-mlxbf2
- revert a buggy immutable irqchip conversion

----------------------------------------------------------------
Bartosz Golaszewski (4):
      Revert "gpio: pxa: Make irq_chip immutable"
      Merge commit '6e64f4580381e32c06ee146ca807c555b8f73e24' of git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux into gpio/for-next
      gpio: remove legacy GPIO line value setter callbacks
      treewide: rename GPIO set callbacks back to their original names

David Thompson (1):
      gpio: mlxbf2: use platform_get_irq_optional()

 arch/arm/common/sa1111.c                           |  4 +--
 arch/arm/common/scoop.c                            |  2 +-
 arch/arm/mach-s3c/gpio-samsung.c                   |  2 +-
 arch/arm/mach-sa1100/assabet.c                     |  2 +-
 arch/arm/mach-sa1100/neponset.c                    |  2 +-
 arch/arm/plat-orion/gpio.c                         |  2 +-
 arch/m68k/coldfire/gpio.c                          |  2 +-
 arch/mips/alchemy/common/gpiolib.c                 |  6 ++---
 arch/mips/bcm63xx/gpio.c                           |  2 +-
 arch/mips/kernel/gpio_txx9.c                       |  2 +-
 arch/mips/rb532/gpio.c                             |  2 +-
 arch/mips/txx9/generic/setup.c                     |  2 +-
 arch/powerpc/platforms/44x/gpio.c                  |  2 +-
 arch/powerpc/platforms/52xx/mpc52xx_gpt.c          |  2 +-
 arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c     |  2 +-
 arch/powerpc/platforms/8xx/cpm1.c                  |  4 +--
 arch/powerpc/sysdev/cpm_common.c                   |  2 +-
 drivers/bcma/driver_gpio.c                         |  2 +-
 drivers/gpio/gpio-74x164.c                         |  4 +--
 drivers/gpio/gpio-adnp.c                           |  2 +-
 drivers/gpio/gpio-adp5520.c                        |  2 +-
 drivers/gpio/gpio-adp5585.c                        |  2 +-
 drivers/gpio/gpio-aggregator.c                     |  4 +--
 drivers/gpio/gpio-altera-a10sr.c                   |  2 +-
 drivers/gpio/gpio-altera.c                         |  2 +-
 drivers/gpio/gpio-amd-fch.c                        |  2 +-
 drivers/gpio/gpio-amd8111.c                        |  2 +-
 drivers/gpio/gpio-arizona.c                        |  2 +-
 drivers/gpio/gpio-aspeed-sgpio.c                   |  2 +-
 drivers/gpio/gpio-aspeed.c                         |  2 +-
 drivers/gpio/gpio-bcm-kona.c                       |  2 +-
 drivers/gpio/gpio-bd71815.c                        |  2 +-
 drivers/gpio/gpio-bd71828.c                        |  2 +-
 drivers/gpio/gpio-bd9571mwv.c                      |  2 +-
 drivers/gpio/gpio-bt8xx.c                          |  2 +-
 drivers/gpio/gpio-cgbc.c                           |  2 +-
 drivers/gpio/gpio-creg-snps.c                      |  2 +-
 drivers/gpio/gpio-cros-ec.c                        |  2 +-
 drivers/gpio/gpio-crystalcove.c                    |  2 +-
 drivers/gpio/gpio-cs5535.c                         |  2 +-
 drivers/gpio/gpio-da9052.c                         |  2 +-
 drivers/gpio/gpio-da9055.c                         |  2 +-
 drivers/gpio/gpio-davinci.c                        |  2 +-
 drivers/gpio/gpio-dln2.c                           |  2 +-
 drivers/gpio/gpio-eic-sprd.c                       |  2 +-
 drivers/gpio/gpio-em.c                             |  2 +-
 drivers/gpio/gpio-exar.c                           |  2 +-
 drivers/gpio/gpio-f7188x.c                         |  2 +-
 drivers/gpio/gpio-graniterapids.c                  |  2 +-
 drivers/gpio/gpio-gw-pld.c                         |  2 +-
 drivers/gpio/gpio-htc-egpio.c                      |  2 +-
 drivers/gpio/gpio-ich.c                            |  2 +-
 drivers/gpio/gpio-imx-scu.c                        |  2 +-
 drivers/gpio/gpio-it87.c                           |  2 +-
 drivers/gpio/gpio-janz-ttl.c                       |  2 +-
 drivers/gpio/gpio-kempld.c                         |  2 +-
 drivers/gpio/gpio-latch.c                          |  4 +--
 drivers/gpio/gpio-ljca.c                           |  2 +-
 drivers/gpio/gpio-logicvc.c                        |  2 +-
 drivers/gpio/gpio-loongson-64bit.c                 |  2 +-
 drivers/gpio/gpio-loongson.c                       |  2 +-
 drivers/gpio/gpio-lp3943.c                         |  2 +-
 drivers/gpio/gpio-lp873x.c                         |  2 +-
 drivers/gpio/gpio-lp87565.c                        |  2 +-
 drivers/gpio/gpio-lpc18xx.c                        |  2 +-
 drivers/gpio/gpio-lpc32xx.c                        | 10 +++----
 drivers/gpio/gpio-macsmc.c                         |  2 +-
 drivers/gpio/gpio-madera.c                         |  2 +-
 drivers/gpio/gpio-max730x.c                        |  2 +-
 drivers/gpio/gpio-max732x.c                        |  4 +--
 drivers/gpio/gpio-max77620.c                       |  2 +-
 drivers/gpio/gpio-max77650.c                       |  2 +-
 drivers/gpio/gpio-max77759.c                       |  2 +-
 drivers/gpio/gpio-mb86s7x.c                        |  2 +-
 drivers/gpio/gpio-mc33880.c                        |  2 +-
 drivers/gpio/gpio-ml-ioh.c                         |  2 +-
 drivers/gpio/gpio-mlxbf2.c                         |  2 +-
 drivers/gpio/gpio-mm-lantiq.c                      |  2 +-
 drivers/gpio/gpio-mmio.c                           | 24 ++++++++---------
 drivers/gpio/gpio-mockup.c                         |  4 +--
 drivers/gpio/gpio-moxtet.c                         |  2 +-
 drivers/gpio/gpio-mpc5200.c                        |  4 +--
 drivers/gpio/gpio-mpfs.c                           |  2 +-
 drivers/gpio/gpio-mpsse.c                          |  4 +--
 drivers/gpio/gpio-msc313.c                         |  2 +-
 drivers/gpio/gpio-mvebu.c                          |  2 +-
 drivers/gpio/gpio-nomadik.c                        |  2 +-
 drivers/gpio/gpio-npcm-sgpio.c                     |  4 +--
 drivers/gpio/gpio-octeon.c                         |  2 +-
 drivers/gpio/gpio-omap.c                           |  4 +--
 drivers/gpio/gpio-palmas.c                         |  2 +-
 drivers/gpio/gpio-pca953x.c                        |  4 +--
 drivers/gpio/gpio-pca9570.c                        |  2 +-
 drivers/gpio/gpio-pcf857x.c                        |  4 +--
 drivers/gpio/gpio-pch.c                            |  2 +-
 drivers/gpio/gpio-pl061.c                          |  2 +-
 drivers/gpio/gpio-pxa.c                            | 10 ++-----
 drivers/gpio/gpio-raspberrypi-exp.c                |  2 +-
 drivers/gpio/gpio-rc5t583.c                        |  2 +-
 drivers/gpio/gpio-rcar.c                           |  4 +--
 drivers/gpio/gpio-rdc321x.c                        |  2 +-
 drivers/gpio/gpio-reg.c                            |  6 ++---
 drivers/gpio/gpio-regmap.c                         |  4 +--
 drivers/gpio/gpio-rockchip.c                       |  2 +-
 drivers/gpio/gpio-rtd.c                            |  2 +-
 drivers/gpio/gpio-sa1100.c                         |  2 +-
 drivers/gpio/gpio-sama5d2-piobu.c                  |  2 +-
 drivers/gpio/gpio-sch.c                            |  2 +-
 drivers/gpio/gpio-sch311x.c                        |  2 +-
 drivers/gpio/gpio-sim.c                            |  4 +--
 drivers/gpio/gpio-siox.c                           |  2 +-
 drivers/gpio/gpio-spear-spics.c                    |  2 +-
 drivers/gpio/gpio-sprd.c                           |  2 +-
 drivers/gpio/gpio-stmpe.c                          |  2 +-
 drivers/gpio/gpio-stp-xway.c                       |  2 +-
 drivers/gpio/gpio-syscon.c                         |  4 +--
 drivers/gpio/gpio-tangier.c                        |  2 +-
 drivers/gpio/gpio-tc3589x.c                        |  2 +-
 drivers/gpio/gpio-tegra.c                          |  2 +-
 drivers/gpio/gpio-tegra186.c                       |  2 +-
 drivers/gpio/gpio-thunderx.c                       |  4 +--
 drivers/gpio/gpio-timberdale.c                     |  2 +-
 drivers/gpio/gpio-tpic2810.c                       |  4 +--
 drivers/gpio/gpio-tps65086.c                       |  2 +-
 drivers/gpio/gpio-tps65218.c                       |  2 +-
 drivers/gpio/gpio-tps65219.c                       |  4 +--
 drivers/gpio/gpio-tps6586x.c                       |  2 +-
 drivers/gpio/gpio-tps65910.c                       |  2 +-
 drivers/gpio/gpio-tps65912.c                       |  2 +-
 drivers/gpio/gpio-tps68470.c                       |  2 +-
 drivers/gpio/gpio-tqmx86.c                         |  2 +-
 drivers/gpio/gpio-ts4900.c                         |  2 +-
 drivers/gpio/gpio-ts5500.c                         |  2 +-
 drivers/gpio/gpio-twl4030.c                        |  2 +-
 drivers/gpio/gpio-twl6040.c                        |  2 +-
 drivers/gpio/gpio-uniphier.c                       |  4 +--
 drivers/gpio/gpio-viperboard.c                     |  4 +--
 drivers/gpio/gpio-virtio.c                         |  2 +-
 drivers/gpio/gpio-vx855.c                          |  2 +-
 drivers/gpio/gpio-wcd934x.c                        |  2 +-
 drivers/gpio/gpio-wcove.c                          |  2 +-
 drivers/gpio/gpio-winbond.c                        |  2 +-
 drivers/gpio/gpio-wm831x.c                         |  2 +-
 drivers/gpio/gpio-wm8350.c                         |  2 +-
 drivers/gpio/gpio-wm8994.c                         |  2 +-
 drivers/gpio/gpio-xgene.c                          |  2 +-
 drivers/gpio/gpio-xilinx.c                         |  4 +--
 drivers/gpio/gpio-xlp.c                            |  2 +-
 drivers/gpio/gpio-xra1403.c                        |  2 +-
 drivers/gpio/gpio-xtensa.c                         |  2 +-
 drivers/gpio/gpio-zevio.c                          |  2 +-
 drivers/gpio/gpio-zynq.c                           |  2 +-
 drivers/gpio/gpio-zynqmp-modepin.c                 |  2 +-
 drivers/gpio/gpiolib.c                             | 31 ++++++----------------
 drivers/gpu/drm/bridge/ti-sn65dsi86.c              |  2 +-
 drivers/hid/hid-cp2112.c                           |  2 +-
 drivers/hid/hid-mcp2200.c                          |  4 +--
 drivers/hid/hid-mcp2221.c                          |  2 +-
 drivers/hwmon/ltc2992.c                            |  4 +--
 drivers/hwmon/pmbus/ucd9000.c                      |  2 +-
 drivers/i2c/muxes/i2c-mux-ltc4306.c                |  2 +-
 drivers/iio/adc/ad4130.c                           |  2 +-
 drivers/iio/adc/ad4170-4.c                         |  2 +-
 drivers/iio/adc/ad7768-1.c                         |  2 +-
 drivers/iio/adc/rohm-bd79124.c                     |  4 +--
 drivers/iio/adc/ti-ads7950.c                       |  2 +-
 drivers/iio/addac/ad74115.c                        |  2 +-
 drivers/iio/addac/ad74413r.c                       |  4 +--
 drivers/iio/dac/ad5592r-base.c                     |  2 +-
 drivers/input/keyboard/adp5588-keys.c              |  2 +-
 drivers/input/touchscreen/ad7879.c                 |  2 +-
 drivers/leds/blink/leds-lgm-sso.c                  |  2 +-
 drivers/leds/leds-pca9532.c                        |  2 +-
 drivers/leds/leds-pca955x.c                        |  2 +-
 drivers/leds/leds-tca6507.c                        |  2 +-
 drivers/media/dvb-frontends/cxd2820r_core.c        |  2 +-
 drivers/media/i2c/ds90ub913.c                      |  2 +-
 drivers/media/i2c/ds90ub953.c                      |  2 +-
 drivers/media/i2c/max9286.c                        |  2 +-
 drivers/media/i2c/max96717.c                       |  2 +-
 drivers/media/pci/solo6x10/solo6x10-gpio.c         |  2 +-
 drivers/mfd/sm501.c                                |  2 +-
 drivers/mfd/tps65010.c                             |  2 +-
 drivers/mfd/ucb1x00-core.c                         |  2 +-
 drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c    |  2 +-
 drivers/misc/ti_fpc202.c                           |  2 +-
 drivers/net/can/spi/mcp251x.c                      |  4 +--
 drivers/net/dsa/mt7530.c                           |  2 +-
 drivers/net/dsa/vitesse-vsc73xx-core.c             |  2 +-
 drivers/net/phy/qcom/qca807x.c                     |  2 +-
 drivers/pinctrl/actions/pinctrl-owl.c              |  2 +-
 drivers/pinctrl/bcm/pinctrl-bcm2835.c              |  4 +--
 drivers/pinctrl/bcm/pinctrl-iproc-gpio.c           |  2 +-
 drivers/pinctrl/bcm/pinctrl-nsp-gpio.c             |  2 +-
 drivers/pinctrl/cirrus/pinctrl-cs42l43.c           |  2 +-
 drivers/pinctrl/cirrus/pinctrl-lochnagar.c         |  2 +-
 drivers/pinctrl/intel/pinctrl-baytrail.c           |  2 +-
 drivers/pinctrl/intel/pinctrl-cherryview.c         |  2 +-
 drivers/pinctrl/intel/pinctrl-intel.c              |  2 +-
 drivers/pinctrl/intel/pinctrl-lynxpoint.c          |  2 +-
 drivers/pinctrl/mediatek/pinctrl-airoha.c          |  2 +-
 drivers/pinctrl/mediatek/pinctrl-moore.c           |  2 +-
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c      |  2 +-
 drivers/pinctrl/mediatek/pinctrl-paris.c           |  2 +-
 drivers/pinctrl/meson/pinctrl-amlogic-a4.c         |  2 +-
 drivers/pinctrl/meson/pinctrl-meson.c              |  2 +-
 drivers/pinctrl/mvebu/pinctrl-armada-37xx.c        |  2 +-
 drivers/pinctrl/nomadik/pinctrl-abx500.c           |  2 +-
 drivers/pinctrl/nuvoton/pinctrl-ma35.c             |  2 +-
 drivers/pinctrl/pinctrl-amd.c                      |  2 +-
 drivers/pinctrl/pinctrl-amdisp.c                   |  2 +-
 drivers/pinctrl/pinctrl-apple-gpio.c               |  2 +-
 drivers/pinctrl/pinctrl-as3722.c                   |  2 +-
 drivers/pinctrl/pinctrl-at91-pio4.c                |  4 +--
 drivers/pinctrl/pinctrl-at91.c                     |  4 +--
 drivers/pinctrl/pinctrl-aw9523.c                   |  4 +--
 drivers/pinctrl/pinctrl-axp209.c                   |  4 +--
 drivers/pinctrl/pinctrl-cy8c95x0.c                 |  4 +--
 drivers/pinctrl/pinctrl-da9062.c                   |  2 +-
 drivers/pinctrl/pinctrl-digicolor.c                |  2 +-
 drivers/pinctrl/pinctrl-ingenic.c                  |  2 +-
 drivers/pinctrl/pinctrl-keembay.c                  |  2 +-
 drivers/pinctrl/pinctrl-mcp23s08.c                 |  4 +--
 drivers/pinctrl/pinctrl-microchip-sgpio.c          |  2 +-
 drivers/pinctrl/pinctrl-ocelot.c                   |  2 +-
 drivers/pinctrl/pinctrl-pic32.c                    |  2 +-
 drivers/pinctrl/pinctrl-pistachio.c                |  2 +-
 drivers/pinctrl/pinctrl-rk805.c                    |  2 +-
 drivers/pinctrl/pinctrl-rp1.c                      |  2 +-
 drivers/pinctrl/pinctrl-st.c                       |  2 +-
 drivers/pinctrl/pinctrl-stmfx.c                    |  2 +-
 drivers/pinctrl/pinctrl-sx150x.c                   |  4 +--
 drivers/pinctrl/pinctrl-xway.c                     |  2 +-
 drivers/pinctrl/qcom/pinctrl-lpass-lpi.c           |  2 +-
 drivers/pinctrl/qcom/pinctrl-msm.c                 |  2 +-
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c           |  2 +-
 drivers/pinctrl/qcom/pinctrl-spmi-mpp.c            |  2 +-
 drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c           |  2 +-
 drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c            |  2 +-
 drivers/pinctrl/renesas/gpio.c                     |  2 +-
 drivers/pinctrl/renesas/pinctrl-rza1.c             |  2 +-
 drivers/pinctrl/renesas/pinctrl-rza2.c             |  2 +-
 drivers/pinctrl/renesas/pinctrl-rzg2l.c            |  2 +-
 drivers/pinctrl/renesas/pinctrl-rzv2m.c            |  2 +-
 drivers/pinctrl/samsung/pinctrl-samsung.c          |  2 +-
 drivers/pinctrl/spear/pinctrl-plgpio.c             |  2 +-
 drivers/pinctrl/starfive/pinctrl-starfive-jh7100.c |  2 +-
 drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c |  2 +-
 drivers/pinctrl/stm32/pinctrl-stm32.c              |  2 +-
 drivers/pinctrl/sunplus/sppctl.c                   |  2 +-
 drivers/pinctrl/sunxi/pinctrl-sunxi.c              |  2 +-
 drivers/pinctrl/vt8500/pinctrl-wmt.c               |  2 +-
 drivers/platform/cznic/turris-omnia-mcu-gpio.c     |  4 +--
 drivers/platform/x86/barco-p50-gpio.c              |  2 +-
 drivers/platform/x86/intel/int0002_vgpio.c         |  2 +-
 drivers/platform/x86/portwell-ec.c                 |  4 +--
 drivers/platform/x86/silicom-platform.c            |  2 +-
 drivers/pwm/pwm-pca9685.c                          |  2 +-
 drivers/regulator/rpi-panel-attiny-regulator.c     |  2 +-
 drivers/soc/fsl/qe/gpio.c                          |  4 +--
 drivers/soc/renesas/pwc-rzv2m.c                    |  2 +-
 drivers/spi/spi-xcomm.c                            |  2 +-
 drivers/ssb/driver_gpio.c                          |  4 +--
 drivers/staging/greybus/gpio.c                     |  2 +-
 drivers/tty/serial/max310x.c                       |  2 +-
 drivers/tty/serial/sc16is7xx.c                     |  2 +-
 drivers/usb/serial/cp210x.c                        |  2 +-
 drivers/usb/serial/ftdi_sio.c                      |  4 +--
 drivers/video/fbdev/via/via-gpio.c                 |  2 +-
 include/linux/gpio/driver.h                        | 22 +++++----------
 include/linux/gpio/generic.h                       |  4 +--
 sound/hda/codecs/side-codecs/cirrus_scodec_test.c  |  2 +-
 sound/soc/codecs/idt821034.c                       |  2 +-
 sound/soc/codecs/peb2466.c                         |  2 +-
 sound/soc/codecs/rt5677.c                          |  2 +-
 sound/soc/codecs/tlv320adc3xxx.c                   |  2 +-
 sound/soc/codecs/wm5100.c                          |  2 +-
 sound/soc/codecs/wm8903.c                          |  2 +-
 sound/soc/codecs/wm8962.c                          |  2 +-
 sound/soc/codecs/wm8996.c                          |  2 +-
 sound/soc/codecs/zl38060.c                         |  2 +-
 sound/soc/soc-ac97.c                               |  2 +-
 sound/soc/ti/davinci-mcasp.c                       |  2 +-
 283 files changed, 358 insertions(+), 387 deletions(-)

