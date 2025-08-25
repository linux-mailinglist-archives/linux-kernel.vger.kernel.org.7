Return-Path: <linux-kernel+bounces-784714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EA975B34035
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 14:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A00C34E2F8C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 12:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03931E6DC5;
	Mon, 25 Aug 2025 12:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nfRP95SR"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63488393DCA
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 12:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756126719; cv=none; b=NCh1TMJdCPPovNTdA+IBD4H2nAWP+nzD7rxg/k1Eb2rqM+NwoiKEEK9qADqS+hPlqTCKUyZ9jwUpXjmmtG61xgZK9m1WcQoul3ZCJhYdfaGdBe6lZr45X4Dcc+g+O5U4KgFu2RdzKj3DazVywDadMnrJi6Vw1kjjB05wEvM2COI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756126719; c=relaxed/simple;
	bh=IM9iJO7UIYdkAwSAqbmV9tDKxFnqhLDvSUZ9NJuIE90=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=kpEWBwfrdgcvX1DUvUrtOJRZOggl9fMs3GenmrSdQg516Pi2rtipYxbGEmEmYrlun2eGbmtI9GJzdQRVBqQiImS3SfibiF/eFaNqitjt6r84VFepFpJxt6LXsPKKzPNM3Y9XZ7VZdurs8UzCxK5YgEsvYJzQbsNW9QWMuZEPFhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nfRP95SR; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-333f901b229so36232481fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 05:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756126716; x=1756731516; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=h2y2NsC9oaR3662j4IuBMxoGBjdUhWRZWEFVHsbKjJU=;
        b=nfRP95SRLvhAd5TPDrjslwETAD9ZKQQqLmBdd6UpXO8ooLOv5Q1u+JI2CgzQrTw8eq
         UDgu0PTmIeGdU56Tzaj8MCDJSSu4D/7FHSAZae5vAb66A+HIPMlfffoLxn8Y9jFoTep+
         sE95cTCS4LoUQVTbswymS8APynZ5hhz65kCqMSbnmaPXOKZjdO17v/ehS2KJSBWZfSdY
         VQmOWOHKr5GQ71dnUCxf3+qMg2LKGPqs37ToHX7hk+zMA0yhwOcsH6iBYbakEclvrcS5
         MAn/zI/K2mR62bv8l8z/Mr5ThawFe09JC2icLZPYKyw6nc4cIx/1/2Sfm6/kHEfAunYZ
         ZO4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756126716; x=1756731516;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h2y2NsC9oaR3662j4IuBMxoGBjdUhWRZWEFVHsbKjJU=;
        b=QAsTQgxhIjoIBmW7tt1pXHQiP3HoIFJ6pQhp6tNCJFUUeas96M5kY4eHXeMVinRqVG
         o1O0J5nCHEpt3AtTKmfSAeI/1BdYaNIJzDHyCTO/Pu+JvfEw2MKf4mw47hIGV3zWK+QZ
         WCKQU4FBUvnXjAX+Ewzr8CaT8JxGiVGJstmMk6yV6vXTplJ4JgdeJYDkA8T+Y+INNAWc
         CDUUEevuUT1JZc6C1lT+3E04xnOWQ9Wy6euCtTOImuMF/tV55IKbOY67R+pjAPsI++LF
         06g7mzFJgpVzPpRa1tCsUkDRg36pkQmldfOaYS2YQuzCS2Hv+0lMlLKJHBOraPqaLth/
         uhqg==
X-Gm-Message-State: AOJu0Yzi3ow7kk/9vCMmQKfDuZwqhEHlhVz4DFrbhH/nwgK0nZvz/TuG
	oTpR34w25R6YN7LxKRlYDUV1Ii8SEOgACYBX308/fQxjuoiOzBnMXbSyj7f/p1V1yYeyTOajuva
	5L5POISu0pwbnaJYGSNM6XupRnPfSPfRWe/j82KreKQ==
X-Gm-Gg: ASbGncuELt+IbO3alEVVbAZ2NrX8+3+XLMxxk4RO/b7RypFnoCb9/GeXDVY/20ePr4o
	Oi4C2ZR2SVWFJXUEzTOOgp2NvnEa6Hu9Jsh8Qt6C60ZXO8lYMP+iGFqafrBSmWEcsHOleAnjzEn
	7hFYIngKmzcZLzOm1aSUKSSlIkfyBZpNxM67h04ZiDYXbav5tYOSmeZ4SlRXfuoBB8GFdOoio8O
	LlGDS0=
X-Google-Smtp-Source: AGHT+IEM8Ta/aMlYhdX2kyS2KdDJN8sJsB7fP7RconVSabr+2MrjSO9P2xauUdSFKN0AK/LYT3T5QmMf3jjBlZqu/Rs=
X-Received: by 2002:a05:651c:31c5:b0:334:390:d92e with SMTP id
 38308e7fff4ca-33650e3ae24mr35592811fa.7.1756126715536; Mon, 25 Aug 2025
 05:58:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 25 Aug 2025 14:58:24 +0200
X-Gm-Features: Ac12FXwpYrX8dlNs7pqV067CILDapuc-jiI-uPN-PFTU4ngTPdYVQHt2d9IqhBE
Message-ID: <CACRpkdbMXvpwgniKeyJ47-t0X+ekkJ1r8RpDFJRsd+g9id+ruQ@mail.gmail.com>
Subject: [GIT PULL] pin control fixes for v6.17
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, 
	"open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

here are some quick pin control fixes.

Nothing special, just driver fixes.

Please pull them in!

Yours,
Linus Walleij

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
tags/pinctrl-v6.17-2

for you to fetch changes up to 563fcd6475931c5c8c652a4dd548256314cc87ed:

  pinctrl: airoha: Fix return value in pinconf callbacks (2025-08-22
15:08:58 +0200)

----------------------------------------------------------------
Pin control fixes for the v6.17 series:

- Module macro parameter fix for the meson driver so that
  it actually modprobes.

- ACPI quirk for the ASUS ProArt PX13

- Build dependency for the STMFX driver.

- Proper return value for the pinconf callbacks in the
  Airhoa driver.

----------------------------------------------------------------
Alexey Gladkov (1):
      pinctrl: meson: Fix typo in device table macro

Lorenzo Bianconi (1):
      pinctrl: airoha: Fix return value in pinconf callbacks

Mario Limonciello (AMD) (1):
      gpiolib: acpi: Add quirk for ASUS ProArt PX13

Randy Dunlap (1):
      pinctrl: STMFX: add missing HAS_IOMEM dependency

 drivers/gpio/gpiolib-acpi-quirks.c         | 14 ++++++++++++++
 drivers/pinctrl/Kconfig                    |  1 +
 drivers/pinctrl/mediatek/pinctrl-airoha.c  |  8 ++++----
 drivers/pinctrl/meson/pinctrl-amlogic-a4.c |  2 +-
 4 files changed, 20 insertions(+), 5 deletions(-)

