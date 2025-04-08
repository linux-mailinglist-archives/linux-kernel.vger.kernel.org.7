Return-Path: <linux-kernel+bounces-593144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63AE3A7F5CF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Apr 2025 09:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39E973AF141
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Apr 2025 07:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C87826157D;
	Tue,  8 Apr 2025 07:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="thM1J1Ny"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB4421ABAC
	for <linux-kernel@vger.kernel.org>; Tue,  8 Apr 2025 07:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744096671; cv=none; b=VJR0/EEJabbC0kLzigSQzT9CBWEs3su2D8mpUIcQzPf7KsHzuNBKGHs/EGV2VLKI7m9edG5cAh8V88na+OzWHY0kHWWS02icCtwxTuTx7r9ehHEYwkS+PoEfhyAt/rpdm6/5Srl10AGtnujC603mxXOHvnT9q05YIypZQZCMGgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744096671; c=relaxed/simple;
	bh=URqhQAHIhJ98p7iATPuB6NMM3MUefZcysEx+qAGhUqs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=X6smfQF7bfU6+L0hv8kbvFoqTY7/NYH0DNJXMj9k/7wBWYer1g5T2Xn73PeARkQzvkiNhqXPIl1zElJF/b3Y00XKsPmaqxe3Qe5Jz3tmRc/IBPCf+hgsUX68GA4OY9h9ilYXXzBV0KpFKmRM3hM1+hMZ+LlvG0Lm1+/BKXqU3Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=thM1J1Ny; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43cf05f0c3eso33113945e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Apr 2025 00:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1744096668; x=1744701468; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yx1TIqghntnSkzos2ma1rb18OugfZ01/6UPIvIRogGo=;
        b=thM1J1NytIHO2cLBvpxQqvX8wGgVuJ9IjMPwo9IgujQAsy7VLy0ZjVVcT9BzbXPF5e
         1rY6FiB/taonIfXLO6MXUatIsFdmNmTSprki4swLcJfjMA+Rikg2norOIZkt9NguC6kO
         /LQchKEGRkmKSscJDHRSVNqiAn/cjxncgHOxSxWxzhtEgi8JWeAchXGzXMSOXX9aA0Gm
         1kWqoUokbgfeGkH+2hX5LVa8iN2yT5d1agSJ4r+5BmT4vkZ+eXifDQ6Awb1CCGtMSXdl
         bHtWCajDePN2rVl50M+Vo2fiN9UIb2z/4vBYps+v9r0eyvkRVpBfU2GIjTBu9zSLByLT
         Fm/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744096668; x=1744701468;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yx1TIqghntnSkzos2ma1rb18OugfZ01/6UPIvIRogGo=;
        b=D1WMBZl5sX8Wdh7cFyhpB4m601nPkOiYYKwaTNFFQto52hl5gKxXW2z48pAeMxtpgB
         pYJvuany77tqyMWcezRYdeuFrXbgTUYjQwTvMAWoYj2kvdto4QIgxcng3iVcVKZhOG0b
         /NP1E6OTGtto2rRQW7APui9GPtgv/a0aW32HXXObl3b2UaBYGhstXahB98JW2el2TS8N
         tRIHUVAjP/3H7QjL5UUL3NOjG2kYkwTU38smJhxEzE339njGRvG0hOp+NGgSS3QlWNN8
         R1vDnc8BzVcgZv+uCydIUb1AudWtwjnwogjKs0CB5EUVT0t8s24sxZrGuYouEtTrcXLg
         4gZg==
X-Forwarded-Encrypted: i=1; AJvYcCVFmN34cjTqEI7XXAtkxHd8fS+v4DjOdo6XOFPvMP49QsAlrzbQMXCu1tHQmZ8kKZ1vwblBX9KRr7eFbrE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAhKueyHlz6zrVMocgZSPJ/dEEN8Txks/zTNcB2awgM8OkoIGe
	H428Lw++1PFsG6t0se23p+D6IXl9mNHPVXiRkIdRYkG40pZYAL36Ja+y9EYaPrmxNceqnQR9u1Y
	v9Fg=
X-Gm-Gg: ASbGncskk7DKM2ERKnAFH04+tzCDkSsRVZ47cwRxysE1w93s6H0Ut0DU+pCglq9vJ2x
	SUMVgKwL9Bb3Bw5PR2MtWTVBQCbSlWv+6lCtHP/XhSzt4ca9+7JxeZduyUJODZwjz7BoTErV4zx
	y+CU3RGY2fNpVCiuDZY/QPCiMiY2/JMOsqJAOkIuhBiIYDPX/6U4kW4FH/0yU/q/zltS06uh8hZ
	GS3gkvzRSjjlIgtCwEEmW1PcnHYyrhpdFkzeva0j7CXmE68+8Qv5OyUjBI0h1SWqTXw/I2v1pIv
	zeMq6QJDB7LUdjQ79ZFSufP9KjbqYiVZsN9OOQ==
X-Google-Smtp-Source: AGHT+IEkbTOHKioAtONGgwkvAsGOsKfAqzUbUYimlR3mk/qE5gxQcFOeHUOtlCWwIcIjPL5dhBZ8bQ==
X-Received: by 2002:a05:600c:5394:b0:43e:bdf7:7975 with SMTP id 5b1f17b1804b1-43ed0db4aa5mr109160625e9.32.1744096668295;
        Tue, 08 Apr 2025 00:17:48 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:2adf:eaae:f6ea:1a73])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c3020d5d1sm14257694f8f.77.2025.04.08.00.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 00:17:47 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 00/10] pinctrl: convert GPIO chips to using new value
 setters
Date: Tue, 08 Apr 2025 09:17:37 +0200
Message-Id: <20250408-gpiochip-set-rv-pinctrl-part1-v1-0-c9d521d7c8c7@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJHN9GcC/x3MwQqDMAwA0F+RnA003RS3X5EdJMs0IDWkRQbiv
 1s8vss7IIurZHg3B7jsmnVLFdQ2wMuUZkH9VkMMsQuP2ONsuvGihlkK+o6miYuvaJMXQg5CQsO
 LOD6hHuby0//9j5/zvAB86B6ZbwAAAA==
To: Ludovic Desroches <ludovic.desroches@microchip.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1922;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=URqhQAHIhJ98p7iATPuB6NMM3MUefZcysEx+qAGhUqs=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBn9M2VxiGLfOGc8w7N9uwqlmDQaQy+QYBveZRbX
 IiqtfRBBzyJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZ/TNlQAKCRARpy6gFHHX
 cnsRD/9ICdXa8mwRQHn7n5c64t6ndqQWY8pEkRiqIbPQmkznn9iJP58U1NzQQ8sefnwUleqgAEE
 R5FhdR//yzS06E0Ysx0XCDSeqHGzP5jCtZhVqs6swdonrx3uWzWjg5KKLb+rERYLO/PQ2DHua5q
 Q/j8m8DsnDyNbSyxT5fdV4QgwF0n4f63Lfex3iZbzKr/xapVvgZuEIsOKLHwPE7/mzUO6y/e5Yj
 HcHloTKFv/uQHvWbsZcAgFM/QtH2SGQip3cdTnDr/KcSIH29DnzdoXka4ZxVHL4iAapQhhZVUJ5
 m7y3e+r4jHZEsTI7agyFD1QUfvzFDT/Xdrz0WmEZU9ChuHEEMedVnuDjPxJwtZd5aHXI7IOWT2Z
 329DjZ/YDcVXMG4I9X6e0nbLFIEjyJdoAXOwVUmab3gVTzLQKqLbMq1+17hDJ4U0zDX3HZ35Vko
 yHsqspCRKZSsmnXFjMhDXr0EBqhWfJ+GO9eH2J8FuZMxf/lSHqmWWc7p9WeV6a2xZXKxeHU3X9C
 XJIJZAMqh+rv5lFnE/iaTBzT180rr4tNSDyO1YSx/Zb8NL+FVg3ODUkOSYCZwfWXX/0z6OEGnoH
 p3cEU9ef8U6YcFbt+uPm+pdhD4QY/KaM947VDfxr8SK9xopbXadzRaI/lAAa4kqwUd5OFwtIexS
 oJ5sbidkFTFEqUA==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

struct gpio_chip now has callbacks for setting line values that return
an integer, allowing to indicate failures. We're in the process of
converting all GPIO drivers to using the new API. This series converts
the first part of pinctrl GPIO controllers.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
Bartosz Golaszewski (10):
      pinctrl: at91-pio4: use new GPIO line value setter callbacks
      pinctrl: rk805: use new GPIO line value setter callbacks
      pinctrl: abx500: enable building modules with COMPILE_TEST=y
      pinctrl: abx500: use new GPIO line value setter callbacks
      pinctrl: meson: use new GPIO line value setter callbacks
      pinctrl: amlogic-a4: use new GPIO line value setter callbacks
      pinctrl: sx150x: enable building modules with COMPILE_TEST=y
      pinctrl: sx150x: use new GPIO line value setter callbacks
      pinctrl: ocelot: use new GPIO line value setter callbacks
      pinctrl: cy8c95x0: use new GPIO line value setter callbacks

 drivers/pinctrl/Kconfig                    |  2 +-
 drivers/pinctrl/meson/pinctrl-amlogic-a4.c |  8 ++++----
 drivers/pinctrl/meson/pinctrl-meson.c      |  6 +++---
 drivers/pinctrl/nomadik/Kconfig            |  8 ++++----
 drivers/pinctrl/nomadik/pinctrl-abx500.c   | 12 ++++--------
 drivers/pinctrl/pinctrl-at91-pio4.c        | 14 +++++++++-----
 drivers/pinctrl/pinctrl-cy8c95x0.c         | 17 +++++++++--------
 drivers/pinctrl/pinctrl-ocelot.c           | 17 +++++++++--------
 drivers/pinctrl/pinctrl-rk805.c            | 26 +++++++++++++-------------
 drivers/pinctrl/pinctrl-sx150x.c           | 23 ++++++++++++-----------
 10 files changed, 68 insertions(+), 65 deletions(-)
---
base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
change-id: 20250326-gpiochip-set-rv-pinctrl-part1-c0e1e1891c24

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


