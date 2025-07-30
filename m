Return-Path: <linux-kernel+bounces-750962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1375AB16362
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 17:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70754188D3DD
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 15:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF4E2DC35B;
	Wed, 30 Jul 2025 15:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cxYSvFdh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C9D2D94BF
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 15:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753888217; cv=none; b=d3av3orUA/bhPqXoPDCvy+Ft9XoylylSRaZYaNvv86kvWyQ6/rXJoC8pKw/SFAjd/zQTN4CJLIQyAVpgNHMmw9gwf4e4m2E2nZzXc1URqIvHpxhdawGeQPJCYaMX4Kfsfkx5hrt5GzFjuUL3D/zPXTlDwQcm2SQKcSu7h9MMfm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753888217; c=relaxed/simple;
	bh=QF36PakihxzhRNIxAuTdVoaBCzXwC4MNRTTisJzK4RM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BfRzaEOsSngJfwMupY+QeDG0FlURXS/N6Up7nobxvOXkzzQWlG9FQjBI0ohj2YRLu9uCT+KeE9bjI6dROa4nRlhxDNokrGqbJHGiZO4sJj9BZ+Vc3Hx/j9b6vBjYtKxJ49SH7bqbLb3UthIhHlGY3PzvY2I6YbwOWQe34OU36bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cxYSvFdh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A65CC4CEE3;
	Wed, 30 Jul 2025 15:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753888217;
	bh=QF36PakihxzhRNIxAuTdVoaBCzXwC4MNRTTisJzK4RM=;
	h=Date:From:To:Cc:Subject:From;
	b=cxYSvFdhMo7mwYb3Wxd+JgwcILbj90cU4XrQPDdBdib5RdfbW+vXxatS8LtmhXev/
	 5b22PJ7Th9hu/blLqN7J+mreDxtvHHmCz0UTDSQ6zIGwEY5Quhv9L73qs+9x1ENngU
	 GH/u5ZYUI2GaUtCCb5XAefn6F/eUIKlKRhf3ZY61RXSa6rk22cxtQKdajcobNPwKjZ
	 Nzlnpziq/MfVrHNku22JqWGs5fmkOqYRWvC7rKyEisamB61VlKIPla2Op6TmBXueUy
	 3YXjjfFBk1TCPsSiL6CcKk18SnfXBbDU8wUNw1Bv03DTTBaveNUm6Ia1IIf8usXoTh
	 OlVuWspQFx4pQ==
Date: Wed, 30 Jul 2025 16:10:13 +0100
From: Lee Jones <lee@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Pavel Machek <pavel@ucw.cz>
Subject: [GIT PULL] LEDs for v6.17
Message-ID: <20250730151013.GC6782@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Good afternoon Linus,

The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494:

  Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/leds.git tags/leds-next-6.17

for you to fetch changes up to 4903924ac7ef31fbbe48b3261b1bc86ce6cd7e97:

  dt-bindings: leds: ncp5623: Add 0x39 as a valid I2C address (2025-07-23 10:32:36 +0100)

----------------------------------------------------------------
LEDs for for v6.17

- Improvements & Fixes
  * A fix has been implemented in QCOM Flash to prevent incorrect register
    access when the driver is re-bound. This is solved by duplicating a static
    register array during the probe function, which prevents register addresses
    from being miscalculated after multiple binds.
  * The LP50xx driver now correctly handles the 'reg' property in device tree
    child nodes to ensure the multi_index is set correctly. This prevents
    issues where LEDs could be controlled incorrectly if the device tree nodes
    were processed in a different order. An error is returned if the reg
    property is missing or out of range.
  * A Kconfig dependency on between TPS6131x and V4L2_FLASH_LED_CLASS has been
    added to prevent a build failure when the driver is built-in and the V4L2
    flash infrastructure is a loadable module.
  * A potential buffer overflow warning in PCA955x was reported by older GCC
    versions has been fixed by using a more precise format specifier when
    creating the default LED label.

- Cleanups & Refactoring
  * The MAINTAINERS file entry for the TPS6131X flash LED driver has been
    corrected to point to the correct device tree binding file name.
  * A comment in the Flash Class for the flash_timeout setter has been
    corrected to "flash timeout" from "flash duration" for accuracy.
  * The of_led_get() function is no longer exported as it has no users
    outside of its own module.

- Removals
  * The commit to configure LED blink intervals for hardware offload in the
    Netdev Trigger has been reverted. This change was found to break existing
    PHY drivers by putting their LEDs into a permanent, unconditional blinking
    state.

- Device Tree Bindings Updates
  * The binding for LP50xx has been updated to document that the child reg
    property is the index within the LED bank. The example was also updated to
    use correct values.
  * The JNCP5623 binding has been updated to add 0x39 as a valid I2C address,
    as it is used by the NCP5623C variant.

----------------------------------------------------------------
Andy Shevchenko (2):
      leds: Unexport of_led_get()
      leds: pca955x: Avoid potential overflow when filling default_label (take 2)

Arnd Bergmann (1):
      leds: tps6131x: Add V4L2_FLASH_LED_CLASS dependency

Daniel Golle (1):
      Revert "leds: trigger: netdev: Configure LED blink interval for HW offload"

Fabio Estevam (1):
      dt-bindings: leds: ncp5623: Add 0x39 as a valid I2C address

Johan Adolfsson (2):
      leds: leds-lp50xx: Handle reg to get correct multi_index
      dt-bindings: leds: lp50xx: Document child reg, fix example

Krzysztof Kozlowski (1):
      leds: flash: leds-qcom-flash: Fix registry access after re-bind

Lukas Bulwahn (1):
      MAINTAINERS: Adjust file entry in TPS6131X FLASH LED DRIVER

Richard Leitner (1):
      leds: led-class-flash:: Fix flash_timeout comment

 .../devicetree/bindings/leds/leds-lp50xx.yaml         | 19 ++++++++++++-------
 .../devicetree/bindings/leds/onnn,ncp5623.yaml        |  4 +++-
 MAINTAINERS                                           |  2 +-
 drivers/leds/flash/Kconfig                            |  1 +
 drivers/leds/flash/leds-qcom-flash.c                  | 15 +++++++++++----
 drivers/leds/led-class.c                              |  3 +--
 drivers/leds/leds-lp50xx.c                            | 11 ++++++++++-
 drivers/leds/leds-pca955x.c                           |  4 ++--
 drivers/leds/trigger/ledtrig-netdev.c                 | 16 +++-------------
 include/linux/led-class-flash.h                       |  2 +-
 include/linux/leds.h                                  |  1 -
 11 files changed, 45 insertions(+), 33 deletions(-)

-- 
Lee Jones [李琼斯]

