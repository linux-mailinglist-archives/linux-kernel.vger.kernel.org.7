Return-Path: <linux-kernel+bounces-865127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 103E6BFC4AA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3B821508E20
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96EB348473;
	Wed, 22 Oct 2025 13:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="K91zwic3"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EED313E00
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 13:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761140473; cv=none; b=aTN0r0dRIIlBcW1pGaxyfTrz+TkHb1nBh1UGNFq52qSyJZypv7ZFlUS31ZoT8AYxYmVcYSLBH3EjsQ+PKmhDePBigWEgd9D9OyS288TNTdplmwfuDUAk/in5TuT8vmC6ICjbk1l8M83IAbvIRSu1sFTxbw6nAexJGTPute24baI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761140473; c=relaxed/simple;
	bh=jdg2u1Ver3o8siH3fN2HjRKx1OGl/Aipe8XfPPyX9zw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jOjDwl/3ZJYXmry74EDXJWcGpSksivlgCE8XD/NvtkiIu/697kE93nTznwEzPTOQ4gqj7jHPh+4lD4wd3z/4zJH5d/T+NMzXoXaJRzYeLxSR3Reul8gSeFh+7evhLnKiNcs432JQd3okJwTNJA3r27iLXYbKGHS+3G1ekwZO0fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=K91zwic3; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3ed20bdfdffso6296552f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 06:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761140470; x=1761745270; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HpdOXA6k+KSMhD7IhYkyYK8ydXANTtf/zoVkqChJZNQ=;
        b=K91zwic3h5kHeGEmEX6tpUWzGcwkuu5EJ70DynX6mLjvt+BnBoTmic7SwWyhY1nYjL
         qMpWezPQy7aAoxvQ9Ai2ERQM/8u9BQ6Mee3Wd3aBkSUN5MLl/qifmNTiM2V12/NOOGHk
         utttE+Fs569HQQTevC6GSr+huf6Qf3PDTLHT5+QcsBw3JGhqFxejh+/v/ui9Rr00NWkG
         HLWb4JA5Ab2ghbNOesXpJSRwljxFVeKD60ukyivhTqAqDziO+onmCBT9FTvIeAes3TWX
         ykQCvX/21u3WBc7yei32q5oalwQCaFXs1+TWQochDeBfYtCJC7wY4v5dLUmrSj/nKA7F
         6bQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761140470; x=1761745270;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HpdOXA6k+KSMhD7IhYkyYK8ydXANTtf/zoVkqChJZNQ=;
        b=lmIF4x35T8M9BsZGwUFcXSNKlEn86+EI1+JGeFkLZaQ/AGRy4yaXbmNKEGuLrqA4En
         iakqtsoPsPuxszMwgNdrk8perm0CNugAfN7dC+yWpvjegYRDbPXZqbfcDJ+ixccXKjmE
         LjpzggP0heuK9YUUmbF+MRAYy7WerK/LNyS0LCahMoMss579GMajxBX4Tnom1j2/PQPT
         ZFxw6CJ1G6ZdhWOJ/CWq2MNRrRpYaoDIX3hrVSmpVwMa7F0jl4UbA3PWIGGWjlodBX4v
         95p499JqwdQS6uy8SoxrT/TAIWIR7nrv0Iz7Q/bkNG54PFbixAzWivoyOYpPyq0Y3E8K
         XVsA==
X-Forwarded-Encrypted: i=1; AJvYcCVF3oSFgK1S4bygWMD0p2ptoaJqG91Dao41vVgk5D/YPRu6DE+2Gw+WfvPwm37ywlh0KFUdGrQefDmO2c8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzK0T1VF3xMoSGoWqTV12WlNAnayn8Jt23IZCzFMAMEcJKOe6GT
	pp5JXQZsC2u8LS02zEvHpYgYxvDIccDp3NxeCzINCrGOdCAmY7KLiC3uteL4RzEruHc=
X-Gm-Gg: ASbGnctDDYWxYcCZEzp995HnNcghXAgsxD7mFiGbu9ZHwYfPJIt5simsjdG54GXIwAg
	ZhbsQjz+YNen27F/xVLaVtYlaqn7CGReZLSq0Sf824zPOHyA5AwykR1LBO0JtcB72KaF1I++R+o
	P6en6ZfgmOjzaAis370B1pWVuR+S6wE21YWVHUkTfQU5YeWuODPayT5ZxGlnNa2DZ37OfEVFUUd
	GXcIfdtOs5prwacglniz2ikUvAi+X/HFSIjnsNgE6pbgwWz5XG76NioCH1RZpR8eRFzYcblHa2q
	VLoVklYNcF7uLcKXr1cWZzK/6YMi9xyjlPI/Y7+tNMZvvQwzvnRYtcVt4szrt5E6NcPIPQsWkLf
	FGIAmD+7B0FbYCR6/l9+XfhhAmB3IvhDMEOP1V6mlNT80JrS0B+tJ5BIzmxBRzPFO0eC/pl82Sq
	HYFMA8tQ==
X-Google-Smtp-Source: AGHT+IFYLIYvRG6TOb9ebkUIWsPlNRcJ0+FBt6ib6BgLN9HQVyDMXksEkV7eo0NqEX3wuKcit4SPJw==
X-Received: by 2002:a05:6000:258a:b0:428:4082:c8e9 with SMTP id ffacd0b85a97d-4284082cadamr10290015f8f.62.1761140469975;
        Wed, 22 Oct 2025 06:41:09 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:69df:73af:f16a:eada])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f00b97f8sm24863066f8f.36.2025.10.22.06.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 06:41:09 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v2 0/9] reset: rework reset-gpios handling
Date: Wed, 22 Oct 2025 15:40:59 +0200
Message-Id: <20251022-reset-gpios-swnodes-v2-0-69088530291b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOve+GgC/22NQQ6CMBBFr0Jm7ZhSLAZX3MOwADvAJKYlMwQ1p
 He3snb5XvLf30FJmBRuxQ5CGyvHkMGeCnjMfZgI2WcGa6wzjXUopLTitHBU1FeInhT94FxF9dU
 0boC8XIRGfh/Ve5d5Zl2jfI6TrfzZo1caU//tbSUarH1VWTc0/Xix7ZNDL/EcZYIupfQFacs+e
 LcAAAA=
X-Change-ID: 20250925-reset-gpios-swnodes-db553e67095b
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Daniel Scally <djrscally@gmail.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-acpi@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3638;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=jdg2u1Ver3o8siH3fN2HjRKx1OGl/Aipe8XfPPyX9zw=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBo+N7uv3BITyR4TRWCtFMn+CU9Mx242xZACrVjD
 5bmBHnxwCOJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaPje7gAKCRARpy6gFHHX
 chaqEACN2PrAG5OD+UTiZyzSlNbXiJ3LdNo8SlQnH/wSilDJSz+x0dXbYyr+ARY+T4/Fh44VnOe
 JPIMzMuPqYyhQePdC/T4oVlPBCY/42jajf9QfXoP+8ET17taKwtNvx8wBaCp54ZkXEiGPA5kMaA
 HBvwkpWmdTbjrbkCxmagByVoeAHIU6eTIapYtE5Jh3PGCKD8TXkgkBVW98s/SN14739R3FOTOUM
 O3IUFnSlA06MsAqGWFpYxmmHJR0OyvkLHKDyGZ3rl97tsUag+Op1pLAnxaG4p7JRiaD2dYztq1/
 QIjCvA8uTC80hKThNx8E1s4qOzl+Fcxq5BoLqMaoohUSro4RgBp7W3JcPrNTMrqiNVD7jlV4vGX
 4nJOjoF6v+Yeg212861GzRvH2mXufbFIWLjXpCOKNH+pgnfSoyY4G57L3SSePlq1slQcQn5qvWK
 gCb/d6m6WIXkD16IGM7bA3ixueuH2J2OsXLIkUHXT+dBN2dXuwOGGfc9XAYwzaRsF+HR9d8TCrp
 5dMlwAQ+CGejXoEaHGwIDhFu520eLFSMG3IvLF/4fI90KdhkTkOoZMxyTgHlR2kVtMZkbLVrnuc
 /bnBB7hM8PRYjPmLZiyVgB9K5aTIIDoPeUEr6RcmYRJsvVwXUwHqakhzPSt4WsSCiWoAmXXshmr
 XXQjjlTVSYXCkrQ==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

Machine GPIO lookup is a nice, if a bit clunky, mechanism when we have
absolutely no idea what the GPIO provider is or when it will be created.
However in the case of reset-gpios, we not only know if the chip is
there - we also already hold a reference to its firmware node.

In this case using fwnode lookup makes more sense. However, since the
reset provider is created dynamically, it doesn't have a corresponding
firmware node (in this case: an OF-node). That leaves us with software
nodes which currently cannot reference other implementations of the
fwnode API, only other struct software_node objects. This is a needless
limitation as it's imaginable that a dynamic auxiliary device (with a
software node attached) would want to reference a real device with an OF
node.

This series does three things: extends the software node implementation,
allowing its properties to reference not only static software nodes but
also existing firmware nodes, updates the GPIO property interface to use
the reworked swnode macros and finally makes the reset-gpio code the
first user by converting the GPIO lookup from machine to swnode.

Another user of the software node changes in the future could become the
shared GPIO modules that's in the works in parallel[1].

Merging strategy: the series is logically split into three parts: driver
core, GPIO and reset respectively. However there are build-time
dependencies between all three parts so I suggest the reset tree as the
right one to take it upstream with an immutable branch provided to
driver core and GPIO.

[1] https://lore.kernel.org/all/20250924-gpio-shared-v1-0-775e7efeb1a3@linaro.org/

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
Changes in v2:
- Don't use a union for different pointer types in the software node
  reference struct
- Use fwnode_property_read_u32() instead of
  fwnode_property_read_u32_array() as we're only reading a single
  integer
- Rename reset_aux_device_release() to reset_gpio_aux_device_release()
- Initialize the device properties instead of memsetting them
- Fix typo in commit message
- As discussed on the list: I didn't change patch 7/9 because most of
  it goes away anyway in patch 9/9 and the cleanup issues will be fixed
  in the upcoming fwnode conversion
- Link to v1: https://lore.kernel.org/r/20251006-reset-gpios-swnodes-v1-0-6d3325b9af42@linaro.org

---
Bartosz Golaszewski (9):
      software node: read the reference args via the fwnode API
      software node: increase the reference of the swnode by its fwnode
      software node: allow referencing firmware nodes
      gpio: swnode: don't use the swnode's name as the key for GPIO lookup
      gpio: swnode: update the property definitions
      reset: order includes alphabetically in reset/core.c
      reset: make the provider of reset-gpios the parent of the reset device
      reset: gpio: convert the driver to using the auxiliary bus
      reset: gpio: use software nodes to setup the GPIO lookup

 drivers/base/swnode.c         |  21 +++---
 drivers/gpio/gpiolib-swnode.c |  16 ++---
 drivers/reset/Kconfig         |   1 +
 drivers/reset/core.c          | 150 ++++++++++++++++++++++++------------------
 drivers/reset/reset-gpio.c    |  19 +++---
 include/linux/gpio/property.h |   5 +-
 include/linux/property.h      |  40 +++++++++--
 7 files changed, 155 insertions(+), 97 deletions(-)
---
base-commit: 5d1aa1920fd17a271dc0f136e14901d8a7e01c26
change-id: 20250925-reset-gpios-swnodes-db553e67095b

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


