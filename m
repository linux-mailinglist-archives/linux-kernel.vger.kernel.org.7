Return-Path: <linux-kernel+bounces-692188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A700ADEDFE
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jun 2025 15:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3CA41BC08FB
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jun 2025 13:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8032E9748;
	Wed, 18 Jun 2025 13:39:01 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2A82165E9
	for <linux-kernel@vger.kernel.org>; Wed, 18 Jun 2025 13:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750253940; cv=none; b=e8ZeEBcrTgRujF8KGWXEfYd/YcRgCzfJrrCKwhbfs4qq+XodFapHsTx79G7bPB5RMidcmtu0bbnp5tFmwcvCkilGW9eF03dR9y6CJPNIOASgJ3tG24uBAX5u9hrAWw62/7iqgxA4BfMqplk7Ec4FB/fQFR2lmtJ42g9NoIjUaS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750253940; c=relaxed/simple;
	bh=Je0tGAOTAzvEt2AtG6g843V3mh+EJS9RuHYgCeIxE/s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QFa1m8UJ8iGTlU0bnfV3aOu773nr07rIr0DW8/WvM9OFLpEMUBIrE7mWI0ht6tleejvNlVUtWwYAuUkq8sEug4qLqvQyqksrkuMeMPi90KWfqVPHS94VXubZTf9PJjeGi6i/wrmZKpo0Y3rBFXYsQ2mwz+5Z19ClROJs80Z+hKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <jlu@pengutronix.de>)
	id 1uRt08-0003BG-M3; Wed, 18 Jun 2025 15:38:52 +0200
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jlu@pengutronix.de>)
	id 1uRt08-00499l-0f;
	Wed, 18 Jun 2025 15:38:52 +0200
Received: from localhost ([127.0.0.1] helo=[IPv6:::1])
	by ptz.office.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <jlu@pengutronix.de>)
	id 1uRt08-002lkJ-03;
	Wed, 18 Jun 2025 15:38:52 +0200
Message-ID: <8570dedab1a7478c39b31125ad279038fe31ac13.camel@pengutronix.de>
Subject: Re: [PATCH RFC/RFT 00/15] gpio: sysfs: add a per-chip
 export/unexport attribute pair
From: Jan =?ISO-8859-1?Q?L=FCbbe?= <jlu@pengutronix.de>
To: Bartosz Golaszewski <brgl@bgdev.pl>, Ahmad Fatoum
 <a.fatoum@pengutronix.de>,  Kent Gibson <warthog618@gmail.com>, Marek Vasut
 <marex@denx.de>, Geert Uytterhoeven <geert+renesas@glider.be>, Linus
 Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz
	Golaszewski <bartosz.golaszewski@linaro.org>
Date: Wed, 18 Jun 2025 15:38:51 +0200
In-Reply-To: <20250610-gpio-sysfs-chip-export-v1-0-a8c7aa4478b1@linaro.org>
References: <20250610-gpio-sysfs-chip-export-v1-0-a8c7aa4478b1@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: jlu@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hi Bartosz,

On Tue, 2025-06-10 at 16:38 +0200, Bartosz Golaszewski wrote:
> Following our discussion[1], here's a proposal for extending the sysfs
> interface with attributes not referring to GPIO lines by their global
> numbers in a backward compatible way.
>=20
> Long story short: there is now a new class device for each GPIO chip.
> It's called chipX where X is the ID of the device as per the driver
> model and it lives next to the old gpiochipABC where ABC is the GPIO
> base. Each new chip class device has a pair of export/unexport
> attributes which work similarly to the global ones under /sys/class/gpio
> but take hardware offsets within the chip as input, instead of the
> global numbers. Finally, each exported line appears at the same time as
> the global /sys/class/gpio/gpioABC as well as per-chip
> /sys/class/gpio/chipX/gpioY sysfs group.
>=20
> First, there are some documentation updates, followed by a set of
> updates to the sysfs code that's useful even without the new
> functionality. Then the actual implementation of a parallel GPIO chip
> entry not containing the base GPIO number in the name and the
> corresponding sysfs attribute group for each exported line that lives
> under the new chip class device. Finally: also allow to compile out the
> legacy parts leaving only the new elements of the sysfs ABI.
>=20
> This series passes the compatibility tests I wrote while working on the
> user-space compatibility layer for sysfs[2].
>=20
> [1] https://lore.kernel.org/all/CAMRc=3DMcUCeZcU6co1aN54rTudo+JfPjjForu4i=
KQ5npwXk6GXA@mail.gmail.com/
> [2] https://github.com/brgl/gpio-sysfs-compat-tests
>=20
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

thanks for implementing this! I tried it on one of our boards and noticed a=
 few
things.

After unexporting a GPIO from the chipX dir, the subdirectory is not remove=
d:
 root@lxatac-00006:/sys/class/gpio/chip9# echo 1 > export=20
 root@lxatac-00006:/sys/class/gpio/chip9# echo 1 > unexport=20
 root@lxatac-00006:/sys/class/gpio/chip9# ls -l gpio1/
 total 0
 -rw-r--r-- 1 root root 4096 Jun 18 12:52 active_low
 -rw-r--r-- 1 root root 4096 Jun 18 12:52 direction
 -rw-r--r-- 1 root root 4096 Jun 18 12:52 edge
 -rw-r--r-- 1 root root 4096 Jun 18 12:52 value
Subsequent attempts to export it again fail.

The contents of /sys/kernel/debug/gpio don't really fit any more:
 gpiochip10: GPIOs 660-663, parent: i2c/0-0024, pca9570, can sleep:
  gpio-660 (DUT_PWR_EN          |tacd                ) out hi=20
  gpio-661 (DUT_PWR_DISCH       |tacd                ) out lo=20
  gpio-662 (DUT_PWR_ADCRST      |reset               ) out lo=20
The header is inconsistent: it uses the 'gpiochip' prefix, but not the base=
 as
the old class devices in /sys/class/gpio/. Perhaps something like this?
 chip10: GPIOs 0-2 (global IDs 660-663), parent: i2c/0-0024, pca9570, can s=
leep:
  gpio-0 (660) (DUT_PWR_EN          |tacd                ) out hi=20
  gpio-1 (661) (DUT_PWR_DISCH       |tacd                ) out lo=20
  gpio-2 (662) (DUT_PWR_ADCRST      |reset               ) out lo  =20
If GPIO_SYSFS_LEGACY is disabled, the global IDs could be hidden.

Unix permissions/ownership just works.


As far as I can see, this is basically everything I need to replace the old
global ID based GPIO access in labgrid. Thanks again! :)


Regards,
Jan
--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

