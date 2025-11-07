Return-Path: <linux-kernel+bounces-890588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3EFC406A7
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 15:46:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CFF724E7551
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 14:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72AE627F4E7;
	Fri,  7 Nov 2025 14:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="F8NnA5wS"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149D91465B4
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 14:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762526805; cv=none; b=Y6nbPe2Ju8yvItlfNdYjyrIYc4pK8KjS2uX4w64UuFAtB4PDUsvb3h5xgXwXLsHjPUNIo4k9ZRlw3g/6PlZidJ/av0rf5rYKXhIJaxy2EiViWSvYCh8f4/NVahYTtBRIrPvxez5qwlgFj/GPJHj0oDlogRiDPOhg8wqobJT3VXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762526805; c=relaxed/simple;
	bh=REZTBV6HDipaZAEhcm5+UPb8i+vYRtFvVs1VV5ZcND4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CPZJyeAqP1lLOP/9fyuiqaTGhWRmtNeqffzQW7yZ5Jpbtp0DLVq0V84Dk82Xf2selaIxX4ja6kgTjONmGCKIcvhNFyHq7crjZGIR5QBgsClPVyxI5Qr50qf/1ZSknsFMc+hlPpto2OzYw9FJZyP9wwweyhvKipLrHOPaxxhbnYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=F8NnA5wS; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-477563bcaacso6126905e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 06:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1762526801; x=1763131601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JmuiRcsMYChRNe9C0OOPQPZILJvZGyW98QjMfmQ7M94=;
        b=F8NnA5wS7/CCmUq+Lsxjg43PyTiXfRfONdq6BiUT4p1KjjKm7NigYoYxXdir7JmLBe
         onMtDVWTfJOaNl2dCK4DdJbhkfwcpqG18w3Vwu7ZGK0XgmqQhOGqu8b0oiWZnsw7sdGb
         rqBctdS4a+iOZKhffrIZMF0zzk3iACprIubUgIMMiUNk25nW2ommrGwEWed15YmL9LWC
         TwkNl1Ru/Kat5dBDu49WLnyyREmfA8evdA613YpaCUI5nbJJOd2hlFYsvD6VNMfQs9xY
         2M72rUOtT53TZBJwJrDV8OsFiws2vy1Ua8qQZ4dhNP9/8mPSJd5ghsXjxmr12yOlpFNf
         oQTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762526801; x=1763131601;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JmuiRcsMYChRNe9C0OOPQPZILJvZGyW98QjMfmQ7M94=;
        b=eB2pHrcr9vqA/7SEwROqscKxyJIy4juhPhuNXpn1Trymv3v8hgBvNwL3rxgGiRRrGZ
         ciL5uM5KFDP5xd3Ga5Lvcl6hxQnvaM6b4AC5JmBFxdiICJBmPxXS/W6bJ8QC7TcrMp3w
         zCTjoAiW23BtnA8ZGm+TH0e17pvP70LYnAVrRWAHi+f2ZLGsfcpslCbUJkP9HKeaPE/T
         /+GtJQPMUxGTzTztx1Hi+FhkQofg82p4dhfiJC4Xd/Ce17yz69lR8OAPe0bSMPdFES3L
         Sd1ezNaGe3/Xesv/RABTF80Cl4lKUwUEdnqzUVdwMncNNcyWB9+D2r3nnGDN2kaqysUx
         7Jsg==
X-Forwarded-Encrypted: i=1; AJvYcCWCCgTDMbC9MKx5rOVyiWBacqg48yKLZL9QPjJ0lgo/Q46vD/kg/SVj0zbp8jLpJpRX8pjMJxfLnWgmDTY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhlNi0hMf9A0KJtZGuy3u5MjCEvQeLb9NprmHTMo7BXQzQWmVt
	gcj+wYmgKraJvs3aok29kvgxXhcOa7yr5entbLmT35++a/sZbkW1vKlfMVM6XR/Ppkg=
X-Gm-Gg: ASbGncuIuiTzX3JHJFRrew1YLT9JrlUnoKQ1xjTkxyE5a5ilGubkKtHwDS4tTBRgtiq
	4pbutQ/G1MlFycYcBTGEFwVY0cZzfsg109aomdJJwnS38vh9Ts9WzjAiKDGRUI1uHyLVjZLHyG7
	c+Sq0UMLCqN3XDDfXSrjPXpjBFiERn6S9m9TDxSnKj+BbTCTbNFGrQn5QP3oAm+E2UbF2QK+2wU
	wqVMlCyc1OFaHGMS8jS3lIAQ9Ynw2wDZunV4E8B0+V/YJTGWArWgujtGnnDtISxI4GI3aIfW6Na
	H9Rs2KbP2kfTuVF1ttyfULFfKCSVmbvRpW6Gi8RdnIleb/NsgdMCnmAWSNpy0iQARHIXRaXljxP
	mbSyQ4WJ3xsDsl2kDbjHKNJgXBiq73s3Bk5bAg/c6UI9qlzdwqYIxQ1iQMW5Kmc6WksK4qOBAA7
	d791pxDLSuqQ2FxhY=
X-Google-Smtp-Source: AGHT+IEB9FlukRQfn9DZ898TQpnF0Z6Iiu4Mpv6B4yxwwI68pnVP1RmaouOAHRVgc3cxu0aVnr5yOg==
X-Received: by 2002:a05:600c:c4a3:b0:46f:b42e:ed87 with SMTP id 5b1f17b1804b1-4776bccd440mr32327345e9.40.1762526801247;
        Fri, 07 Nov 2025 06:46:41 -0800 (PST)
Received: from brgl-uxlite ([2a01:cb1d:dc:7e00:fb6d:2ee:af61:f551])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac679d544sm6156457f8f.46.2025.11.07.06.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 06:46:40 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [GIT PULL] gpio fixes for v6.18-rc5
Date: Fri,  7 Nov 2025 15:46:37 +0100
Message-ID: <20251107144637.40951-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Linus,

Please pull the following set of GPIO fixes for the next RC.

Thanks,
Bartosz

The following changes since commit 6146a0f1dfae5d37442a9ddcba012add260bceb0:

  Linux 6.18-rc4 (2025-11-02 11:28:02 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.18-rc5

for you to fetch changes up to 4436f484cb437ba28dc58b7f787a6f80a65aa5c3:

  gpio: tb10x: Drop unused tb10x_set_bits() function (2025-11-06 18:19:44 +0100)

----------------------------------------------------------------
gpio fixes for v6.18-rc5

- use the firmware node of the GPIO chip, not its label for software
  node lookup
- fix invalid pointer access in GPIO debugfs
- drop unused functions from gpio-tb10x
- fix a regression in gpio-aggregator: restore the set_config() callback
  in the driver
- correct schema $id path in ti,twl4030 DT bindings

----------------------------------------------------------------
Bartosz Golaszewski (2):
      gpio: swnode: don't use the swnode's name as the key for GPIO lookup
      gpiolib: fix invalid pointer access in debugfs

Jihed Chaibi (1):
      dt-bindings: gpio: ti,twl4030: Correct the schema $id path

Krzysztof Kozlowski (1):
      gpio: tb10x: Drop unused tb10x_set_bits() function

Thomas Richard (1):
      gpio: aggregator: restore the set_config operation

 .../devicetree/bindings/gpio/ti,twl4030-gpio.yaml     |  2 +-
 drivers/gpio/gpio-aggregator.c                        |  1 +
 drivers/gpio/gpio-tb10x.c                             | 19 -------------------
 drivers/gpio/gpiolib-swnode.c                         |  2 +-
 drivers/gpio/gpiolib.c                                |  8 +++++++-
 5 files changed, 10 insertions(+), 22 deletions(-)

