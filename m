Return-Path: <linux-kernel+bounces-797946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC67B4178D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 10:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D0C6188853A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 08:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC662DC344;
	Wed,  3 Sep 2025 08:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="rLpziD0o"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184592DFA2B
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 08:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756886423; cv=none; b=mg9m+9r86Mc26WhEcfhzOGx4y9PYKpGUrc0jEQOyci1QWxkQASZGQhnsnL0UEeCFt7SMWBMAYvv+Z13iKURHxNBwtzr4nKqdpA4jx8SjZ5SS80yJ5AFkzkoKDyYKpz19SSXr/EkldmBwsT22Ma4aiF7RxfonF+RF0kD+8sWlSmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756886423; c=relaxed/simple;
	bh=gKWwUvnAEvt2ScQRr56TGrFFGK11fkBKFuB/ae7rjDs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=odxgnE92VLRGWtkRTXxN6ioVsRB2gb/ah9gUj9r8bbnWZ+6hUYR674mccu+jAXtGDV0DTmeXOWwc4ZxOU+6ZiFNF9o/bcM/kjsvV1fRE78ZY+UW94tt4MRLpcDMS1nVxBugg3rE0RuWUfqZjdRkjKl6VgpL3xw9ZnyeVvNf3I4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=rLpziD0o; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45b7c56a987so21090545e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 01:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1756886420; x=1757491220; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DpPPqJ6vfvGH4vuO+e6EX5ng+865t3uw6R5fP2qsALM=;
        b=rLpziD0o/ZGofM9iyt8raiYE/NDnwKoKOgxjILmZGwE6jjTK6+u31BfqfiRMhSV7hQ
         TijKvIs6HpG4QyzHFu4edKWFJdgX0tJSDWIq7hQi4QPb+qQf1nxuzehMt7Xjx25MB61R
         8uNgWxJ3mSsfZ2CwRWRDHDq31LGfTO7yz1RkPx2U7r6i+IcAvxFA2E1mKtOajw7COx5N
         YhaynUl15b2lBTwvMV+r/jTiXJ9BSIHvtn6wktnIGdwSkYfOdqyAi9MgsK+kvgjnCCGO
         xNdH9fpaewrlcr+gww1p0jDaYWf8VN2ttKUPmVj4TPyUnUl7Ad7khl3Lh/Gjbd7Y7Nfw
         QjkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756886420; x=1757491220;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DpPPqJ6vfvGH4vuO+e6EX5ng+865t3uw6R5fP2qsALM=;
        b=MeqUvBsFLLm4bcx98WN5VatYT9cw8cN6EPWzWPecQ+Sk0BendytIRLNCl2f/7kdROY
         2lq+pmRBEiIcWuXfbyHBsC1tDhzpPRUV/FAYZbzG8byPSJFsRqRHHkFAc8qLHoW1OqiU
         dh3kAQ204lfqnx9XnAKM5RIJ8Q36PbHZiwmgZsLtLlYlsnA+1150qo0BPYFRsXEd9tM4
         RwUCZ9rJICjdpMCnrohxlHpkE/YOFsORIO/ln4ItIAAkGmq3Du6tDQG1VO7VO2I5dcgu
         5fdv5UMwRvTXs4tEJdiUlxpbZ7Dzzl379UQfmKl2WHVqIoiVmZyPdGmQeDe6nfszJkZA
         SOWw==
X-Forwarded-Encrypted: i=1; AJvYcCXowK4LJkP88QpUdCbIHgT11o/5s9DTFVXSQlCYwWgwEb4Oqic68MEh/1mPVmLn8+ibhiyaKBzlqF/vBJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzvczive9FqIkXYi90EfpjaYRW7PfdMqCXAPAHSpiJlsMrrfUc+
	1Cb1qTz3zoL0SbbEU7Ls/JPAf7lPbyDwNwMVSTnbMy9X6AnNAIwxgzogD8K9z4DASBU=
X-Gm-Gg: ASbGncs3FvH+J/mMXF3QntWd0j2gbS95qMBSU4G0GxlSKTMeBLYDzUT5m2wEBO0Zy5c
	R4DQjdh8+8a0/y/WgK5wIiurwj+P5IUdYFnstBkrdYWyl8S+nfTxaGuur4Ri3SHZZfkJe1rcV2w
	bebRcksYas9TN6CTxFwddLcyiJ0/jcMT8G8xxmNI3Wk6GmwgUp7yxS1pakxlZJx/MmnwtedS6E6
	VaLpPbihE5CWSJy0aswZverM+gXWc0Q3UZ/cF6afKI09NWr5o6VW7FykJMC8rlPVMweTeSuzqJs
	UEGMa1CKLgqFRJp8T3HPZFSu8j1JC1ytpJklnAlNyOes3W8dz8L9qkZJTjbwZJE5I/IZvS8kQxf
	CCW+T8RNRzPRotOTt
X-Google-Smtp-Source: AGHT+IFwjP7yYn1uifzActrfXYI79jTCrc8TnAVAgAEQ4T0bxdVQdBTd41jSKK0TuTYpRpjrFDEjGw==
X-Received: by 2002:a05:600c:4e44:b0:459:dde3:1a27 with SMTP id 5b1f17b1804b1-45b855fc86amr107466725e9.26.1756886420178;
        Wed, 03 Sep 2025 01:00:20 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:2f8b:4799:6bd6:35df])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b83e954b7sm113331635e9.1.2025.09.03.01.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 01:00:19 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 00/12] gpio: replace legacy bgpio_init() with its
 modernized alternative - part 3
Date: Wed, 03 Sep 2025 10:00:04 +0200
Message-Id: <20250903-gpio-mmio-gpio-conv-part3-v1-0-ff346509f408@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIT1t2gC/x2MOwqAMBAFryJbuxCjInoVsTBxE7fIh0REEO9uS
 DO8Kd68kCkxZViaFxLdnDn4Il3bgD53bwn5KA5SyFHMokMbOaBzBXXp4G+Me7p6HPtBzcaoiaS
 G8o+JDD+1vW7f9wMBCkNvawAAAA==
X-Change-ID: 20250901-gpio-mmio-gpio-conv-part3-534b9ffb7e2c
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Linus Walleij <linusw@kernel.org>, 
 Imre Kaloz <kaloz@openwrt.org>, James Cowgill <james.cowgill@blaize.com>, 
 Matt Redfearn <matt.redfearn@blaize.com>, 
 Neil Jones <neil.jones@blaize.com>, 
 Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1600;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=gKWwUvnAEvt2ScQRr56TGrFFGK11fkBKFuB/ae7rjDs=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBot/WMzbJ/KeLZaXwwbG7zHqK/b9QJqWbxJVEkF
 NwdikCx+xqJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaLf1jAAKCRARpy6gFHHX
 ciaYEACZUQUFrz8EUOXz/wW+8FpV4nOg7WED+poFNv1ix3BYoSfeycNXw6ASf8bmTHYuRUfMeN1
 RfJfuwFT9hdegcIBuWDhcHRmW/MhmZN/lfl2jipA5Z0T+f9Bcs/jU64irF6NgBMONC36lWxz434
 tSq+qphMiMajKiFrcwoWa8GenarK0R3+JcoTAhDwfAr5F6+GTanDnjNwY6CVcz/ns6Jpkj6Qjm/
 DXZgC2xB1dlOgRk/KBm0uVd5ztLeToZOW93AyDUZdsF8aKnRvKKU85ypaJ/U3hxwQEpw0r5X9c/
 4vwFH4beR1yILC2lFhkhsU/M8fU0lhSmgc6ajG/XeV7EuUlPhz9+ozGz/OxCzeHr5Zuq3SQc3VT
 jPCVSYynJOUfAWmBKaKgKg4YGHufyqswORJ1Gu6S+PokAhRamn2cFOF+zfsJ+n83f02+J5YT4S6
 m38OkRc6GTE636Q9OnZOk0VoH2hhWWQMsn+VPysDq7YQQiJWli9piqELKJ4lT+wKVJSgDcIixNk
 A2UvApfvhhuPYuFH+Wdtp8ivAh2v57RpT1czjXW4nHXz9KtIj7r2G/93f6wED0SMWHaGkSn5Bgg
 aLBCXTs8AyWbCXyQEagHqPvuVrllsdtt8bKra3fhbclCiYgUYtC9e64Dby7AYCdtdAUK5l2bLQp
 htd9ZzHD04avA7g==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

Here's another round of patches converting GPIO drivers to the
modernized generic GPIO chip API.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
Bartosz Golaszewski (12):
      gpio: ixp4xx: allow building the module with COMPILE_TEST enabled
      gpio: ixp4xx: use new generic GPIO chip API
      gpio: idt3243x: use new generic GPIO chip API
      gpio: blzp1600: use new generic GPIO chip API
      gpio: tb10x: order includes alphabetically
      gpio: tb10x: allow building the module with COMPILE_TEST=y
      gpio: tb10x: use new generic GPIO chip API
      gpio: mlxbf: use new generic GPIO chip API
      gpio: ep93xx: allow building the module with COMPILE_TEST enabled
      gpio: ep93xx: order includes alphabetically
      gpio: ep93xx: use new generic GPIO chip API
      gpio: mlxbf3: use new generic GPIO chip API

 drivers/gpio/Kconfig         |   8 ++--
 drivers/gpio/gpio-blzp1600.c |  39 ++++++++++-------
 drivers/gpio/gpio-ep93xx.c   |  33 +++++++++-----
 drivers/gpio/gpio-idt3243x.c |  45 +++++++++----------
 drivers/gpio/gpio-ixp4xx.c   |  70 +++++++++++++++---------------
 drivers/gpio/gpio-mlxbf.c    |  25 ++++++-----
 drivers/gpio/gpio-mlxbf3.c   | 101 ++++++++++++++++++++++---------------------
 drivers/gpio/gpio-tb10x.c    |  74 +++++++++++++++----------------
 8 files changed, 214 insertions(+), 181 deletions(-)
---
base-commit: 5d50cf9f7cf20a17ac469c20a2e07c29c1f6aab7
change-id: 20250901-gpio-mmio-gpio-conv-part3-534b9ffb7e2c

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


