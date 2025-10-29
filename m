Return-Path: <linux-kernel+bounces-876669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 391BFC1BF63
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 39B2134BC14
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7502EA17E;
	Wed, 29 Oct 2025 16:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LhUmpwAd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B727EAF9;
	Wed, 29 Oct 2025 16:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761754295; cv=none; b=Cb0WDqI9ZODdkTVTjEkJ4bKrI38jscjj7AChovyfidq3Y1YFmcEsJutd67WWb0lDq0QlznMXiio0tgqTiK30jPFDcvmgZKAjgg70qmQV6DTcddxAfXEaOoFNTHo98nmzWnXDWNJIWwPCqKRGbPwH4+HCsT1RFH+atldDc87YUes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761754295; c=relaxed/simple;
	bh=ZHoYFhjdnzGDFed/NoYuMn50qAQjcf3x65RDhAXAqO8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BUf2+CgGJHhGThypKi/y3s7KR6WUyX23J4PaPZN+A1dgFUTcU9BklAYwwIPfDZo46f1cnTuhn+m2IprfodUJ7Wbe+K88T1M1Y5I0zISUpn92Gc6TFqx6CfDikWqCHCnz9xyMAnCg1GH6Yf4tz1RWlG2Xrupc1J/yHGd4Y6GnrrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LhUmpwAd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B3ADC4CEF7;
	Wed, 29 Oct 2025 16:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761754294;
	bh=ZHoYFhjdnzGDFed/NoYuMn50qAQjcf3x65RDhAXAqO8=;
	h=From:To:Cc:Subject:Date:From;
	b=LhUmpwAd7Z9ccct7wO8x5Sch+wXZ8LM6RsiBZPsYX/E3xLaYm96OVekFU7qoJiil+
	 uYnZ0LpXf7Ib7lfEYkuZOl5dlyLS4S4aTqupXTPDZRQ2rWCPBkj19b8lI5nAO8I432
	 FakMqVk2You9r5Q5a4TkzwwkJ4TGC/M7Ckl0g7V1NqYUB/c16PrgkFAV7+4alrCsAj
	 PwdzI6XZEtQHPkzP9CERmK7obs7hqZBLKaKWJMuKGKWVENPMiVfIxo9APaNlThW8sA
	 jReEQpa6i+Z9rOJtPNTbjOJ5bAC1kiqijZzxvhmTaUjVuQU+mxLQocli4JlHTg8047
	 EZ9WeZNgRdd/w==
From: Conor Dooley <conor@kernel.org>
To: claudiu.beznea@tuxon.dev
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	pierre-henry.moussay@microchip.com,
	valentina.fernandezalanis@microchip.com,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-riscv@lists.infradead.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/7] Redo PolarFire SoC's mailbox/clock devicestrees and related code
Date: Wed, 29 Oct 2025 16:11:16 +0000
Message-ID: <20251029-chewing-absolve-c4e6acfe0fa4@spud>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6087; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=PM+I1awA9VRT67tF+JHyycrqYb2aNW3lbRaKFXiJEn0=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDJlMNut+zDyjI2E89eA7DjYWa79JrvzXb1tPT/iRNzF3n vd0tjqdjlIWBjEuBlkxRZbE230tUuv/uOxw7nkLM4eVCWQIAxenAEwkR4Phv/MZ8QU/2TeZiPaJ vGibefo/+5kpt57L9RbkpT0xXy0plM7IsKzh5a5ZjFr/Dx9VyGXjaTPumpAVbadm0vvM/16341Y VHgA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

In v5 the only real change is that I removed the attempt at a common
implementation of regmap-based divider/gate clocks. The series hasn't
managed to receive feedback on my approach in 2025, despite sending
several revisions and bumps, and it is blocking support for both new
drivers (gpio interrupt support, pinctrl and hwmon off the top of my
head) and a new platform so I have decided to strip out the attempt at
making something common in exchange for something that can be merged
through the clk-microchip tree without relying on feedback from the
clock maintainers.

Currently the driver uses the common gate and divider clocks, but the
driver used to use its own custom clock types. Reprising this version of
the code allows me to use regmap accessors in the driver without any
wider impact, or attempting to create something that works for any other
user. It has the advantage that it has already been tested in that prior
for, and all that is done to the clock implementations is replacing
readl()s and writel()s with their regmap equivalents.

Hopefully this change has made it possible to merge the series,
Conor.

v6:
- make reset depend on MFD_SYSCON
- return regmap_update_bits() result directly instead of an additional
  return 0 in reset
- use regmap_update_bits() instead of regmap_read() -> regmap_write()
  RMW sequences in clock
- drop clock driver specific lock, since regmap has internal locking,
  from !msspll clocks
- implement determine_rate instead of round_rate
- drop patch 1 & 2 (soc bits) since I applied them as a pre-req for
  pinctrl work

v5:
- drop mfd patch applied by Lee
- remove attempt at common regmap divider/gate clocks, and replace it
  with a return to how the code used to look, before it started using
  the non-regmap versions of the common divider/gate, with the
  readl()/writel()s replaced by their regmap equivalents.

v4:
- unify both regmap clk implementations under one option
- change map_offset to a u32, after Gabriel pointed out that u8 was
  too restrictive.
- remove locking from regmap portion of reset driver, relying on
  inherent regmap lock

v3 changes:
- drop simple-mfd (for now) from syscon node

v2 cover letter:

Here's something that I've been mulling over for a while, since I
started to understand how devicetree stuff was "meant" to be done.
There'd been little reason to actually press forward with it, because it
is fairly disruptive. I've finally opted to do it, because a user has
come along with a hwmon driver that needs to access the same register
region as the mailbox and the author is not keen on using the aux bus,
and because I do not want the new pic64gx SoC that's based on PolarFire
SoC to use bindings etc that I know to be incorrect.

Given backwards compatibility needs to be maintained, this patch series
isn't the prettiest thing I have ever written. The reset driver needs to
retain support for the auxiliary bus, which looks a bit mess, but not
much can be done there. The mailbox and clock drivers both have to have
an "old probe" function to handle the old layout. Thankfully in the
clock driver, regmap support can be used to identically
handle both old and new devicetree formats - but using a regmap in the
mailbox driver was only really possible for the new format, so the code
there is unfortunately a bit of an if/else mess that I'm both not proud
of, nor really sure is worth "improving".

The series should be pretty splitable per subsystem, only the dts change
has some sort of dependency, but I'll not be applying that till
everything else is in Linus' tree, so that's not a big deal.

I don't really want this stuff in stable, hence a lack of cc: stable
anywhere here, since what's currently in the tree works fine for the
currently supported hardware.

AFAIK, the only other project affected here is U-Boot, which I have
already modified to support the new format.

I previously submitted this as an RFC, only to Lee and the dt list, in
order to get some feedback on the syscon/mfd bindings:
https://lore.kernel.org/all/20240815-shindig-bunny-fd42792d638a@spud/
I'm not really going to bother with a proper changelog, since that was
submitted with lots of WIP code to get answers to some questions. The
main change was "removing" some of the child nodes of the syscons.

And as a "real" series where discussion lead to me dropping use of the
amlogic clk-regmap support:
https://lore.kernel.org/linux-clk/20241002-private-unequal-33cfa6101338@spud/
As a result of that, I've implemented what I think Stephen was asking
for - but I'm not at all sure that it is..

CC: Conor Dooley <conor.dooley@microchip.com>
CC: Daire McNamara <daire.mcnamara@microchip.com>
CC: pierre-henry.moussay@microchip.com
CC: valentina.fernandezalanis@microchip.com
CC: Michael Turquette <mturquette@baylibre.com>
CC: Stephen Boyd <sboyd@kernel.org>
CC: Rob Herring <robh@kernel.org>
CC: Krzysztof Kozlowski <krzk+dt@kernel.org>
CC: Philipp Zabel <p.zabel@pengutronix.de>
CC: linux-riscv@lists.infradead.org
CC: linux-clk@vger.kernel.org
CC: devicetree@vger.kernel.org
CC: linux-kernel@vger.kernel.org

Conor Dooley (7):
  reset: mpfs: add non-auxiliary bus probing
  dt-bindings: clk: microchip: mpfs: remove first reg region
  clk: microchip: mpfs: use regmap for clocks
  riscv: dts: microchip: fix mailbox description
  riscv: dts: microchip: convert clock and reset to use syscon
  MAINTAINERS: add new soc drivers to Microchip RISC-V entry
  MAINTAINERS: rename Microchip RISC-V entry

 .../bindings/clock/microchip,mpfs-clkcfg.yaml |  36 +--
 MAINTAINERS                                   |   4 +-
 arch/riscv/boot/dts/microchip/mpfs.dtsi       |  34 ++-
 drivers/clk/microchip/Kconfig                 |   2 +
 drivers/clk/microchip/clk-mpfs.c              | 227 ++++++++++++++----
 drivers/reset/Kconfig                         |   1 +
 drivers/reset/reset-mpfs.c                    |  79 ++++--
 7 files changed, 298 insertions(+), 85 deletions(-)

-- 
2.51.0


