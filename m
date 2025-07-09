Return-Path: <linux-kernel+bounces-723304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2E4AFE596
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 12:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A8FA175D21
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 10:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE23288CAA;
	Wed,  9 Jul 2025 10:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iYa7rJiz"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DD42868B0
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 10:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752056515; cv=none; b=l24w0+yZwKmFLaHB2QjZvAPW434sWFrgvMM7gFZhKv1b9ie5mFkPLv0WGrSQjjV+xlgT+3BoZPdmJR2/xF/V2C2fvLap9AnUdKwTu9i7Qiqlk1H3f0Tg2BxC8DwL14uASWJjaaVjYcXneRkX9WwfKjkXroX/m3FEpMZggPTRxA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752056515; c=relaxed/simple;
	bh=wIqPLRw2HOvarV36h3OAvicgvKrGbpwiOzAHWe3Pt3Y=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=JUlnhs7dCeFNQ7rW6/3HdhWUHzwiUE8nI0R1Apj9AXzlz9SECamJdY/cg6qtJLNbGpcqu40y/gnxvm4+fGCeAkmWSZPfUpHUFuLq8Rp2fZBPxJOgzAlld0lVUAMdDcQS6WoYukyx35WKdTkokZphzUR7y4UV4Z60cGoienxs4Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iYa7rJiz; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-32ca160b4bcso59990881fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 03:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752056512; x=1752661312; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DnYi4NSxelKtKJI4OL4GTqIMsRDkT7cGv2pD1bYfX0g=;
        b=iYa7rJizl75g9yi+gDIFL4i+AI0P56Bb9DDi2A3XqHj7m6u+vDowoYbawO90Om0K0n
         EYPE1y+R2L5nQQ8swfAhx0NzFF/kq6rHHUpwbfo8eT39BTnv5v3fVXJS4d2wnw5xVwiB
         BxP2OM/C61Dh7VqLdugoa4L1CQM6fRu0j3tenJXjiB0wbBAs7zDQEs8KQ9/ZvRcK2AVF
         +xsLrNl10uKmkh2kKq5U06KykNIs7lK2BOobt3uR1TjC2jCgFuN2WMl+cL/zY+RA8UcK
         aAp+w2DoB+1F/pbXNByW9/G9gJWWp6bnDHUrx5JgrghjkxsBEXhfw82vUKp7ZxuyYmTI
         l40Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752056512; x=1752661312;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DnYi4NSxelKtKJI4OL4GTqIMsRDkT7cGv2pD1bYfX0g=;
        b=kw/K82beTirLSTuc6sQ2825Sm/kqCnDrxlayjxhu/QveETzJk2LMf+HEjqeDW1nJIp
         /59SI28d6argFYJP+z9VGLmSLw2sVhRD8RsnXU8GiWg7akztuqiongIPkPAhn4thpJhZ
         vzFH5TML9g8bz0YxozyKSV3yoHp3HGEE5eDgnkUeyJKxAo99aAtP3S2kQogGWNDzQiNw
         hum0SeIliVqoNFhiqnMUe4IbiGXz2JxHUAve4xi7ffK23F6PTWIQ+rnhOUYkCzJcKEHb
         Az4+rXhka1OPamJTC0wKutMBXzbl0sqKgX006iogoh4lYM8+WMsZ6xNB4iMlYTkcdtXn
         zkVg==
X-Gm-Message-State: AOJu0YybhgE7a2vr/tNvHH+z7x3ku5fAsZmEeXASprVQSJAlHKEgpsKj
	igUNN4rJQrY+SzJe7g1EZnA0uZVfaXxjs5iEUFOL05OqzHCvMU+9P5lxg08bMZ+jDqBhqjga80r
	9MnvgyqkL0XyjgpvKzi5DXRSIRX6ikzSDZ7068gR7WA==
X-Gm-Gg: ASbGncvIe/4iquxa0O7WLhQAngEMex2XB9lojjplcsF/yKAT1l/AO1A0keqlhHI2FCF
	tNSraUvUuL8NpOswSi+NwlA5O/g3Dh/3zQu3LpRhzyQS7K1gwWkwqXA8UA9bSgkp1KilpcWtHVS
	gQoty/Lke0rSp4/Ba/HahwIzsVECnBAS5MSyPTsgM+QrA=
X-Google-Smtp-Source: AGHT+IHSPJfxh6GXrGcKI1DP68kz97ujql/EuTBRM/jvIvYqGbvtieEObAlF+0aiWntKSzdWqidNEKxOo0NgV4jV7SA=
X-Received: by 2002:a2e:a370:0:b0:32b:78ce:be8e with SMTP id
 38308e7fff4ca-32f48585e59mr3497221fa.32.1752056511343; Wed, 09 Jul 2025
 03:21:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 9 Jul 2025 12:21:40 +0200
X-Gm-Features: Ac12FXyoZXoQflju9o9tYtb_0UNR6yMkEYYNVK3VI5ezRpYr41t18RFM2aqmrUY
Message-ID: <CACRpkdZB=mYnmZU14Gn9buB7jE2b-7Fu+dgf3pcAcVj0FgvHiQ@mail.gmail.com>
Subject: [GIT PULL] pin control fixes for v6.16
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, 
	"open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

here are some pin control fixes for the v6.16 series.

Nothing special, just driver fixes, the AMD one is especially
nice to have and will probably spill over to stable as well.

Please pull it in, details in the signed tag!

Yours,
Linus Walleij


The following changes since commit e04c78d86a9699d136910cfc0bdcf01087e3267e:

  Linux 6.16-rc2 (2025-06-15 13:49:41 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
tags/pinctrl-v6.16-3

for you to fetch changes up to 5285b5ed04ab6ad40f7b654eefbccd6ae8cbf415:

  pinctrl: aw9523: fix can_sleep flag for GPIO chip (2025-07-04 10:31:50 +0200)

----------------------------------------------------------------
Pin control fixes for the v6.16 series:

- Mark som pins as invalid for IRQ use in the Qualcomm
  driver.

- Fix up the use of device properties on the MA35DX
  Nuvoton, apparently something went sidewise.

- Clear the GPIO debounce settings when going down
  for suspend in the AMD driver. Very good for some
  AMD laptops that now wake up from suspend again!

- Add the compulsory .can_sleep bool flag in the
  AW9523 driver, should have been there from the
  beginning, now there are users finding the bug.

- Drop some bouncing email address from MAINTAINERS.

----------------------------------------------------------------
Bartosz Golaszewski (2):
      pinctrl: qcom: msm: mark certain pins as invalid for interrupts
      MAINTAINERS: drop bouncing Lakshmi Sowjanya D

Mario Limonciello (1):
      pinctrl: amd: Clear GPIO debounce for suspend

Milan Krstic (1):
      pinctrl: aw9523: fix can_sleep flag for GPIO chip

Miquel Raynal (1):
      pinctrl: nuvoton: Fix boot on ma35dx platforms

 MAINTAINERS                            |  3 +--
 drivers/pinctrl/nuvoton/pinctrl-ma35.c | 10 ++++++++--
 drivers/pinctrl/pinctrl-amd.c          | 11 +++++++++++
 drivers/pinctrl/pinctrl-aw9523.c       |  2 +-
 drivers/pinctrl/qcom/pinctrl-msm.c     | 20 ++++++++++++++++++++
 5 files changed, 41 insertions(+), 5 deletions(-)

