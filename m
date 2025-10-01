Return-Path: <linux-kernel+bounces-839002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7FABB09AF
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 16:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8DD63B8491
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 14:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BFC03019A2;
	Wed,  1 Oct 2025 14:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T2kHtH9Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072FA26B0AE
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 14:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759327354; cv=none; b=kUM7Lx7A0nuB6/A1E+hdL1hgCE0+CebkgAn0vrx3EikOZboivPvV47vwakUlqP9Evl8xhCvEkX1J7qnZJ/tlwQkjbiGIpstHiw078JGSQTbFN2OfcmqGVGyF8gpyzmNf/+hiY3HtinWJiZYcd8caClRXIq1NW00HkrGkI+/JQzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759327354; c=relaxed/simple;
	bh=ObfQTrmwJsWM25B0qjYqGIRt6H7tWY/LpK+slRyuyDc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DkgsPpSIzrMlCgn5Q+0W5NDJAfiSVF611bSWQCQ7OUBZoLGWLB4CjMNW4BDPwqFMdvqIjjuwRZdGuxmdrrX59LohwcQGWZKu3rP5IVsvBmKF4obYvkpONLrsynrpNKRoOTQRhiIiZu44oi8DyopMRxF0HN8cWCoGaJ+AAdnqTfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T2kHtH9Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF28DC4CEF1;
	Wed,  1 Oct 2025 14:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759327353;
	bh=ObfQTrmwJsWM25B0qjYqGIRt6H7tWY/LpK+slRyuyDc=;
	h=Date:From:To:Cc:Subject:From;
	b=T2kHtH9YsS6PfWUFi8VCwYCM14/UNuY1rPIKPK+e8AiXRt4mGNiuz1DuPKfIYNaZT
	 Dt/J7Wptle6tZBDZ7k7cT7V083Yh0ROABMvIIhsrQFWoAnjcGddsED70IUT+zVtaeB
	 6d/BuwBHxlnxM3zl1OKCZy+SNkC+BQdSMqJQjG/bd5QfAic72hVhnW6Xk4zduaJlPi
	 H3gu7hi8B8KtJhObnzv/akrw1vD9wL32fCsWMfR1v4pZ4aDRNAVwkQGRCcm45e3HIC
	 jLhVpxagjXKZVGCpnqVfLv+GzZjvRlkHxH9piKmuDFJQLr9GYMISUfByeJ9vJWYTfF
	 UP6mHakcc2rsQ==
Date: Wed, 1 Oct 2025 15:02:30 +0100
From: Lee Jones <lee@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Daniel Thompson <danielt@kernel.org>
Subject: [GIT PULL] Backlight for v6.18
Message-ID: <20251001140230.GW8757@google.com>
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

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git backlight-next-6.18

for you to fetch changes up to ba3b29a639fe5173033914db6ee58d8d9bb86aba:

  backlight: rt4831: Include <linux/mod_devicetable.h> (2025-09-16 17:05:19 +0100)

----------------------------------------------------------------
Backlight for v6.18

This set is comprised of a couple of small but important fixes and a number of clean-up and
refactoring patches.  The fixes correct an EPROM address for the LP8556 and improve memory
allocation safety in the LED backlight driver.

The remainder of the set is made up of refactoring work to the mp3309c driver and a series of
patches to make a number of drivers more self-contained by including their own dependencies.

Improvements & Fixes
- Correct the EPROM start address for the LP8556 to align with the device's datasheet.
- Use devm_kcalloc() in the LED backlight driver for safer array allocation with overflow
  protection.

Cleanups & Refactoring
- Drop an unnecessary call to pwm_apply_args() in the mp3309c driver.
- Modernize struct initialization in the mp3309c driver by using a compound literal instead of
  memset.
- Make numerous drivers self-contained by including necessary headers directly rather than
  relying on transitive includes from the core backlight header.

----------------------------------------------------------------
Qianfeng Rong (1):
      backlight: led_bl: Use devm_kcalloc() for array space allocation

Svyatoslav Ryhel (1):
      video: backlight: lp855x_bl: Set correct EPROM start for LP8556

Thomas Zimmermann (9):
      backlight: Include <linux/of.h>
      backlight: apple_dwi_bl: Include <linux/mod_devicetable.h>
      backlight: as3711_bl: Include <linux/of.h>
      backlight: da9052_bl: Include <linux/mod_devicetable.h>
      backlight: jornada720: Include <linux/io.h>
      backlight: ktd2801: Include <linux/mod_devicetable.h>
      backlight: led_bl: Include <linux/of.h>
      backlight: rave-sp: Include <linux/of.h> and <linux/mod_devicetable.h>
      backlight: rt4831: Include <linux/mod_devicetable.h>

Uwe Kleine-König (2):
      backlight: mp3309c: Drop pwm_apply_args()
      backlight: mp3309c: Initialize backlight properties without memset

 drivers/video/backlight/apple_dwi_bl.c      |  1 +
 drivers/video/backlight/as3711_bl.c         |  1 +
 drivers/video/backlight/backlight.c         |  1 +
 drivers/video/backlight/da9052_bl.c         |  1 +
 drivers/video/backlight/jornada720_bl.c     |  1 +
 drivers/video/backlight/ktd2801-backlight.c |  1 +
 drivers/video/backlight/led_bl.c            |  5 +++--
 drivers/video/backlight/lp855x_bl.c         |  2 +-
 drivers/video/backlight/mp3309c.c           | 14 +++++++-------
 drivers/video/backlight/rave-sp-backlight.c |  2 ++
 drivers/video/backlight/rt4831-backlight.c  |  1 +
 11 files changed, 20 insertions(+), 10 deletions(-)

-- 
Lee Jones [李琼斯]

