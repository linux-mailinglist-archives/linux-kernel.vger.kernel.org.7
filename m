Return-Path: <linux-kernel+bounces-838998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB892BB0997
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 16:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8BB07B0146
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 14:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79EE303A2C;
	Wed,  1 Oct 2025 14:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WcgDdHrT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447D93019C4
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 14:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759327273; cv=none; b=DZC9k+1Sok9kRDahIiQYWtOtOMswng1rT6D2SmHbBqiOqJr5BqZFbWH3DFkxIGaDpPtMeQvKZdT3iXDtNA3s8cZEkazNg6Vvy2LgjdOEiAr1TUF6rdCD3Et3oeGUIct1i9GZ/ZTi8TV7rXbeNpYZVQdwW4EZ+GtGtgvgwSIhHHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759327273; c=relaxed/simple;
	bh=A6silx/M+hDUZF7P4Y/0L2EjlImyCNKNWzelNbuMSkc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=h1UHCC++02zE2K4f+8uwBYVhonA5Tbay3/xYl2m28OF5LkNBRkHC/+fHq2lyYiYD/8dd1aA7hEngT0oOVG1CBIIEzcG9zlkRQ2R+NxREzmgZekiUTtoHYWTDMVuAPOyz/I4Gn18KXjmv00t1EZM8L5HG/q/gSRpm6iKhS6iNANk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WcgDdHrT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0461FC4CEF1;
	Wed,  1 Oct 2025 14:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759327272;
	bh=A6silx/M+hDUZF7P4Y/0L2EjlImyCNKNWzelNbuMSkc=;
	h=Date:From:To:Cc:Subject:From;
	b=WcgDdHrTBJv3u0ycEpj8zGPY6Wy5/st7j6k66mTyXqgbw095+FXYlokivyRVheaO3
	 bc7vos7l1ultQ7ya5E77mgG32U+ki/p5YEJrLTnnH5alqAYBSFUPMCNUl47sjweU+j
	 S9KEvSwKbz0ah+1NAr97L1zFRCayg3/6DQBjh3FjECzLHGlvJ6yFwv4S0uTgRTUkOL
	 brlUv/VUhd8HDLvdY+mQP4FhEslPtntLL6a3zobV8xR3Yjt8ZPsl1XihZkklAKmvv+
	 xT3O0ZhTk2k6UDRMXGx3eOqv8TzHKc/sskH2Gw10e2iExRNRcqhIxqmOWKliULGDEe
	 Uj6UdunKQ3nbg==
Date: Wed, 1 Oct 2025 15:01:09 +0100
From: Lee Jones <lee@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Pavel Machek <pavel@ucw.cz>
Subject: [GIT PULL] LEDs for v6.18
Message-ID: <20251001140109.GV8757@google.com>
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

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/leds.git leds-next-6.18

for you to fetch changes up to 64826db1e2e177b58dcbc7cf1e1379527be2185a:

  dt-bindings: leds: as3645: Convert to DT schema (2025-09-25 13:01:32 +0100)

----------------------------------------------------------------
LEDs for v6.18

This submission is a mix of new features, a number of fixes, some clean-up/refactoring and a
few Device Tree binding updates.  The most significant changes include new device support for
the IS31FL3236A and QNAP's status LEDs, a number of fixes for the Qualcomm flash, LP55xx,
MAX77705 and QNAP MCU drivers, along with some generic LED consumer binding documentation and
unification.

New Support & Features
- Add support for the IS31FL3236A LED driver, including an optional 22kHz PWM frequency setting.
- Add support for the red and green status LEDs on QNAP MCU devices.

Improvements & Fixes
- Fix an issue in the MAX77705 driver where an error value was assigned but not returned.
- Correctly update the torch current clamp setting in the Qualcomm flash LED driver to prevent
  unexpected clamping.
- Add a separate register map for the PMI8998 to the Qualcomm flash LED driver to handle its
  unique register layout.
- Fix the state numbering for the USB LED in the QNAP MCU driver to avoid command conflicts.
- Correct the memory programming address calculation for non-paged devices like the LP5562 in
  the LP55xx driver.
- Add Device Tree support to the generic led_get() function, allowing LEDs to be looked up by
  name.

Cleanups & Refactoring
- Fix a spelling mistake in the Kconfig help text for the BD2606MVV driver.
- Use devm_mutex_init() in the IS31FL319x driver to simplify code.

Device Tree Bindings Updates
- Drop the redundant '-db' suffix from the IS31FL319x binding.
- Introduce generic LED consumer bindings for referencing LEDs via phandles.
- Unify the 'leds' property across several bindings to use the new generic consumer binding.
- Convert the AMS AS3645A LED controller binding to the DT schema format.

----------------------------------------------------------------
Aleksandrs Vinarskis (2):
      dt-bindings: leds: Add generic LED consumer documentation
      dt-bindings: leds: Unify 'leds' property

Andrei Lalaev (1):
      leds: leds-lp55xx: Use correct address for memory programming

Christophe JAILLET (1):
      leds: is31fl319x: Use devm_mutex_init()

Colin Ian King (1):
      leds: Kconfig: Fix spelling mistake "limitiation" -> "limitation"

Fenglin Wu (2):
      leds: flash: leds-qcom-flash: Update torch current clamp setting
      leds: flash: leds-qcom-flash: Add a separate register map for PMI8998

Hans de Goede (1):
      leds: led-class: Add Device Tree support to led_get()

Harrison Carter (1):
      dt-bindings: leds: as3645: Convert to DT schema

Heiko Stuebner (2):
      leds: qnap-mcu: Fix state numbering for USB LED
      leds: qnap-mcu: Add support for the red and green status LEDs

Krzysztof Kozlowski (1):
      dt-bindings: leds: issi,is31fl319x: Drop 'db' suffix duplicating dtschema

Len Bao (1):
      leds: max77705: Function return instead of variable assignment

Pawel Zalewski (1):
      leds: leds-is31fl32xx: Add support for is31fl3236a

 .../devicetree/bindings/leds/ams,as3645a.txt       |  85 ----------
 .../devicetree/bindings/leds/ams,as3645a.yaml      | 130 +++++++++++++++
 .../bindings/leds/backlight/led-backlight.yaml     |   6 +-
 .../devicetree/bindings/leds/issi,is31fl319x.yaml  |   1 -
 .../devicetree/bindings/leds/leds-consumer.yaml    |  67 ++++++++
 .../bindings/leds/leds-group-multicolor.yaml       |   5 +-
 .../bindings/media/video-interface-devices.yaml    |   8 +
 drivers/leds/Kconfig                               |   2 +-
 drivers/leds/flash/leds-qcom-flash.c               |  87 ++++++----
 drivers/leds/led-class.c                           |  17 +-
 drivers/leds/leds-is31fl319x.c                     |   8 +-
 drivers/leds/leds-is31fl32xx.c                     |  47 +++++-
 drivers/leds/leds-lp55xx-common.c                  |   2 +-
 drivers/leds/leds-max77705.c                       |   2 +-
 drivers/leds/leds-qnap-mcu.c                       | 175 ++++++++++++++++++++-
 15 files changed, 497 insertions(+), 145 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/leds/ams,as3645a.txt
 create mode 100644 Documentation/devicetree/bindings/leds/ams,as3645a.yaml
 create mode 100644 Documentation/devicetree/bindings/leds/leds-consumer.yaml

-- 
Lee Jones [李琼斯]

