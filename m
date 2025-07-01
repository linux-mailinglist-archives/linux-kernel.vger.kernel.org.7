Return-Path: <linux-kernel+bounces-711183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1189AEF74F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jul 2025 13:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 793BC1896B87
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jul 2025 11:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5CD274671;
	Tue,  1 Jul 2025 11:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="hUh1T2q+"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C7D2737F0
	for <linux-kernel@vger.kernel.org>; Tue,  1 Jul 2025 11:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751370590; cv=none; b=XAFDWQ28aapYu1Be6T4X8fahTVuLOm1EPCKdD6UHWx0oab/TlB1K2yAFSRl6/40Tr3k+tl/WtuQnHthY8GGbPKNpjNU2wIA5weqlCG/ZvHJKuHXuoSQfZ4v2xYsUBeSQflnNgot0P3f/c8FEV9BsibhWQUVQESZpokI8Pp69Yzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751370590; c=relaxed/simple;
	bh=UJc3hmakmCFDejzXGWV/PRSC/VBVjDRZZhjzXcD8pcE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jyIPaR0zGKCTw7WlS8A7dHmJiY0MMwpGuvvG/C611LbJDMETox+xglJxn8qhXaZr+IWVBIlg8crqmfbk10F7eNpDKr7PuYBY7Jr9zrGmTbCIsLksVB9RA0wS7Ma2/8exYBYOWROx7fe9uWdheppstpSJXhticDWOsPvSqfCNZ2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=hUh1T2q+; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a5257748e1so2068281f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jul 2025 04:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1751370586; x=1751975386; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7rBnsamyDV27J2WwKLyAccKonvibQaYagfLaZ+VNSiU=;
        b=hUh1T2q+r/WlpHPiwhrJBOHct+Z3FErYkPrEnWjGTQJnRgaan3O0qhwwxaPFqlR9yy
         ZjYrs/fuFlmSBjCsoE18grPW0ONRO0Z8m9nZy037c0haC9++AhxZhvywUKnbgmw8auYj
         fYhYquo58HexJI9enhQknjoWEKJ4NwEw0AaMtk2D8oy7f4KrD3DDpR+tAem2N89JJOFq
         sw9FjP0FcyW+hbN6k5026bQCeQ52m2mQL+6hMHlb/2i7wTd1EloA+piEBZD6byCjs9Ow
         hVQ+Pjblo1v7Y1huqxPN9Rc8oRISpJ39+DZjUWPqiyz+reacB35Jn+3T7nDheTVitl6d
         cvfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751370586; x=1751975386;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7rBnsamyDV27J2WwKLyAccKonvibQaYagfLaZ+VNSiU=;
        b=LgH1aYFzR/d889wWuu42UU8Zu7AqWvzpVqIoo/xJOJ7Q4M63fqZcDA0siOYSHpmDDY
         IY+Or3GD5uJjmmMMbHUIt5NLgqxRcOXyqQgfCMFtbGOHq3qTd3nIV8L2yQTqdBT2jLUp
         dNNfiOzWl5VJgv0bcPvdpaHwIX0QKK3jaWomNgNdREu1zCTV7xq6Y9MhLM0+vDJOLNqo
         YKsPzZ7Vejm4gRIf1BQw/sSP2MNNwYE8UKeAweaOv5Qxim/mD8ATy2S0nMvdVksSvfWW
         iH6HTW3oYgfUvtyBLem+gYCzSQw+PmqxclHx8sFoNaEVjtuUjCppzg+dwr3pfMI/c4To
         kigQ==
X-Forwarded-Encrypted: i=1; AJvYcCUj5C3PTjG0bHTzZ+fa+41yS35M5v/RzJ/77O6GasVOQyLxaH2kg7HwKcehlbU71T1ECLrLsyr8VtOmhJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1OBZ3ixyj6KsBNV8ennovLCszjMfK+tz9zelk1Cm6DlzhUgmK
	dj0iZ3DGzlR1PHCCrt/Ad6ZD7VzpO84AMVKtNDluQKDVNjnzo/X5Xud4Mlow8wPN2To=
X-Gm-Gg: ASbGncvLglvyJSwoPMBDXxAA3k1GRHVkGyhf7WLruaqm2wqxqvxZdh2Gh2AEkZyjGyX
	y9nd/yfuD979ZVKg5yoH1QrM04Ux42LgvxTngxsWn0E5QZ6eHdoFLoLIE/VHckuskfmr217T0GD
	3DdzADvSK1HMgFyh3U+NV4FXhs41Tlf9aJz6SYLHIQU/59PIliZofMMS8dQmu2CgEaGEbpk0OJu
	Hn2KUPo+CsQTupm5j4dJtqFhGYbTFXQlG/hEriLYAFJ4BXkcs0wFiiyjy+efaCiCn5zK180+oeh
	y3QnyjI2O4J/q/c3O3ZvNPAHZZZDOhIUJrjBvfDJT/c7s7sl4z3Xtw==
X-Google-Smtp-Source: AGHT+IGLudSO4qSGgaoI0lE0gwhgJMiF1fIaIOReku4KKO0+ggLf63z8+JCs9hpvb79VzA7DdKYPnw==
X-Received: by 2002:a05:6000:270e:b0:3a4:e609:dc63 with SMTP id ffacd0b85a97d-3a8fdb2a345mr10940398f8f.20.1751370585709;
        Tue, 01 Jul 2025 04:49:45 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:a387:7a32:8457:f9b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538233c05csm193988925e9.5.2025.07.01.04.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 04:49:45 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH RFT v2 0/6] gpio: mmio: remove struct bgpio_pdata
Date: Tue, 01 Jul 2025 13:49:34 +0200
Message-Id: <20250701-gpio-mmio-pdata-v2-0-ebf34d273497@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE7LY2gC/2WNwQrCMBBEf6Xs2UiTmho9efIDxJv0sG3WdME2J
 SlBKf13Q/HmZWBmmDcLRApMEc7FAoESR/ZjNmpXQNfj6EiwzR5UqXRZq0q4ib0YhiyTxRkFmkq
 2p5qMtQryagr05PdGfMDteocmhz3H2YfP9pLkVv2Ahz9gkqIUqE13VNRqXePlxSMGv/fBQbOu6
 xd5U/AztAAAAA==
X-Change-ID: 20250623-gpio-mmio-pdata-a831b96e8dd2
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Lee Jones <lee@kernel.org>, 
 Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Janusz Krzysztofik <jmkrzyszt@gmail.com>, Tony Lindgren <tony@atomide.com>, 
 Russell King <linux@armlinux.org.uk>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, 
 patches@opensource.cirrus.com, linux-samsung-soc@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Charles Keepax <ckeepax@opensource.cirrus.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2027;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=UJc3hmakmCFDejzXGWV/PRSC/VBVjDRZZhjzXcD8pcE=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBoY8tRdPoTibMAomzGNkjn3M4LGNffQVy9TxdSJ
 ySv+9g/ljaJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaGPLUQAKCRARpy6gFHHX
 cjvAD/9XrZRdWLFc4ZGo9ECLkOKGsrV6090zJOH8UE+pCw8zhlOKsArJbrLVXjR21hvLXP7TVun
 cKVNZSf5kTHZwsQMU5c1J3lhTTMYP4qforoqO6USlfVDjlh2U4ZdABevibR2rj0VtTdaVW9uRP8
 o6vioxw4z+bvCvZsl9pSl+HKDY+w0oBYbup1I5OXPkam4/xBOTGQL0cuFmSZre5AX19bw6bY+Hs
 vC9KByrkT1ccFoPrun8h1YsRzpu5h29H/8TBU8OUw6FjBSYTrob5Qbi35KIwoHshEhWk0RVokuy
 pt0JYFcpUCeOusVhltlDF/7si+ISXJCt4/ajpPFHyIDH4tXok/EdAy7GFVROdc5JXxm5y/KDmAR
 1vNIvPhd8661BpKbeHI6diXu4tAASI7b3BvHvef4w2UL3i3AvCZtj2tItLHHHWlWesoxaju9vFu
 HuDy3zng3nIR00ofBuiTnKR4XXT7DJSUtnr/RKS8WhH28RRMypZfOgQGDBj2c8+DuP/2WDx41Cv
 DMcq4UYnjtg9etRNoFWtWPzKKMDE3/sFQMEHqMoy8ZNAlpf6ElOErYJq4Jdb9DG/FUVg571mIic
 U6K/xeM9Y143/Mj5B8hh9qrUA0R13X+nv6sZ4AEaDmO8F0VRgUzrdtdp4CuhQT+hjo6WGXyEx/H
 GV6aS0WOYDNdtYQ==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

I'm working on removing the fields relevant only to gpio-mmio from
struct gpio_chip. One of the bits that need addressing before we can do
this is the removal of struct bgpio_pdata from the kernel. Fortunately
there are only 3 users left treewide.

This series adds support for parsing of generic device properties to
gpio-mmio, converts all users to setting up software nodes containing
relevant values in their property sets and removes struct bgpio_pdata.

As for merging: it would be best for MFD/OMAP/s3c maintainers to ack the
changes and let me route them through the GPIO tree. I can provide an
immutable tag if needed.

Obviously I was only able to build-test the changes so any actual
verification is appreciated.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
Changes in v2:
- add a comment about the gpio-mmio-specific property not being suitable
  for device-tree
- pick up tags
- Link to v1: https://lore.kernel.org/r/20250624-gpio-mmio-pdata-v1-0-a58c72eb556a@linaro.org

---
Bartosz Golaszewski (6):
      gpio: mmio: drop the big-endian platform device variant
      gpio: mmio: get chip label and GPIO base from device properties
      mfd: vexpress-sysreg: set-up software nodes for gpio-mmio
      ARM: omap1: ams-delta: use generic device properties for gpio-mmio
      ARM: s3c: crag6410: use generic device properties for gpio-mmio
      gpio: mmio: remove struct bgpio_pdata

 arch/arm/mach-omap1/board-ams-delta.c | 42 ++++++++++++------------
 arch/arm/mach-s3c/mach-crag6410.c     | 17 ++++++----
 drivers/gpio/gpio-mmio.c              | 61 +++++++++++------------------------
 drivers/mfd/vexpress-sysreg.c         | 46 +++++++++++++++-----------
 include/linux/gpio/driver.h           |  6 ----
 5 files changed, 77 insertions(+), 95 deletions(-)
---
base-commit: 3f804361f3b9af33e00b90ec9cb5afcc96831e60
change-id: 20250623-gpio-mmio-pdata-a831b96e8dd2

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


