Return-Path: <linux-kernel+bounces-806264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8002CB4945C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 17:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 448784E1CF6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 15:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D73130DEB6;
	Mon,  8 Sep 2025 15:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3kvSXYC"
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031FE2D5929;
	Mon,  8 Sep 2025 15:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757346912; cv=none; b=C8T67xtxt+o1dLnyMzjJR5vU0v0sQp3LbyuyZPmQdJ0Z/Ur648z3dMzGQFBuHEmNaPcgjAFfGUOV7A0x2qGdnvhaZuoQJk0baGQmcBHJg6uQyTNHVTm5y07QDXjnukQQ24LhwixY8KDfLeGF0AfAMvTKz0o5euoVwyrO0RrwJr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757346912; c=relaxed/simple;
	bh=DPok5ZJbW/CmanImBGvSLTbfYtANs1XLx0OzKK/GxOQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Za2StrJFeogPTWSmN6BF1M8FITCC87Yrnb50bOt/A+OVlg65V6Fzo2Qo3jhjsCKf8ZHaWczm7DUII47RxzIvBTg9KjFbQZaofo9fnescW7wh74nlxecjYv1CzCqLFCQl4OZt8ahg++VDN80eBfrmcIugntC9hpsBEtUKfO94xcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h3kvSXYC; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-52eb6872bd2so2059591137.3;
        Mon, 08 Sep 2025 08:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757346910; x=1757951710; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ODso1BtjNB08Q2FB6CB8RlQDDaVaGLpJk9SD+YPMh54=;
        b=h3kvSXYCCMSkiia2WgDwKTLg/iQAQWAwQADouXbOafdnvG1fp5zScKxX0zSNSSftjk
         Ox7D7W292WsfG8YF7DbuqkllqimGi/Ya9tLcVJlT/xdFENUd3wdRRt12HxVFzIv0GLmk
         oaa0JxcVdHgU/io6aXSle8QQCJKPVxfyIMBGiPSPgg7+EjzIhLj1srkS8IZUMzQt2Knn
         PGlqwrYwkTRTSvSYlz647fVv1cCK+Fw1kmLs3zZrCIkJt6XBd+4ZhrSmW08f9xSNSk/2
         YrTGghCajyCHOrbqhEXKnrxqXeZooL92947Na3KF2Sgc+ed9Trg5x1jmF8q8RVlm9/uN
         HIeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757346910; x=1757951710;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ODso1BtjNB08Q2FB6CB8RlQDDaVaGLpJk9SD+YPMh54=;
        b=ZOzP3ZZplt8+SHneA3IaqqbapB0L62RSCbb85fnlNKcBktbqdnejXob0SLvHjODcCb
         dX0IjnBOtWT2waLG0J2gq6wnwqOzAGcbfH/cMnhkpg7SaSgTJTLOSA5Gpqdt7pLYHs8B
         7qqGkvuMfSBJG2TFit6rl6QhCDMq2rWCMdyJny5ff/GdGXs/pRdsWb37+JlLzepTqPNM
         m8wBC16VvkbBLDtnTmLDFTR1d80WslGHVoshjn0iH1D6nGHmN7B0hZJ81/Ydi1GvQKhe
         FZp2SKhoTa60NhVV4Wqs1seBLfI126unERHOdbGoAUSMDFnQhXAInlcugk39s/4ZwKA1
         vXng==
X-Forwarded-Encrypted: i=1; AJvYcCVgHCnGLcjrwp38PWcbMW9jSDTFtPTJByUfCPSRlULIw32BdG8Otf9G7qkBGBEzCsjJeHK2LGr6lVQKn45I@vger.kernel.org, AJvYcCW27qbrZ9gHl53xee72yi57/lTvcbhzWxzJCu382mxfzINkaAWA/9zh8jAAhqu3tnzPuuE1YWdpGPTE@vger.kernel.org, AJvYcCX5ALAVXt/lStKtI/DbOyOTSi3A9b6ylWhPJX+zU6964ooGZnJnL4NYOl7XqV3QVUOd3uIH0H7hBOWc@vger.kernel.org
X-Gm-Message-State: AOJu0Yydo9cSh38AzFrEm7PLMDWpMxNL8QRoS7YnTVbY/rP5xHaaiWhA
	D6/VOTdLG7PiUfWocZZ9o821ZdDSiJ5z8bhdQelWMmnQeQ+AIMBoBNtW+pLgVw==
X-Gm-Gg: ASbGncviVxtW1C43qJFV/9y3l9WpNYy5LhBP4icAxZZi8ArENwvJwTuBclhUe6ForZu
	mwlmBV7SfBhS7OcrnKut4cSkqEcxTJc2+Da3wP2Fif+7moUNwj7mJndS4Bois5Rdyc5a+5Az+rl
	S6GNu3ICHexHf5zVLUiZrS7jYmFN6h5QUIMhj72Af/uOFTwXQ+LfRgbHKBcFzolJGy6BFXj8ZVl
	Ya/j5g4i3PQOZ/g4h5XxnVuf1iWXG258G8aEm99vKd9WKMYGXlP937a4e1j8ZKVPZXDImrpktK0
	Q+cqk4CHpRntgNrW/RkM3GVo2w+eN8JqKKG2nisNAZKL58+fpeIR5z5b+8ZG3xW9AAUZJztv0GQ
	Ec8L3baiiZiO3EAULjSqaCynB
X-Google-Smtp-Source: AGHT+IF6gbzg1CUm0lHxzPJCEpT8rKKw2V3ILLMKu96jRKW9r0k3fC3W8zcnvnNoI1NH7YhkB7odzw==
X-Received: by 2002:a05:6102:c51:b0:524:bd1e:bcf2 with SMTP id ada2fe7eead31-53d16b6639emr2188489137.35.1757346909432;
        Mon, 08 Sep 2025 08:55:09 -0700 (PDT)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:875c:6c76:e06b:3095])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-89601b67070sm8689299241.20.2025.09.08.08.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 08:55:09 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
Subject: [PATCH v4 0/4] hwmon: (sht21) Add devicetree support
Date: Mon, 08 Sep 2025 10:54:48 -0500
Message-Id: <20250908-sht2x-v4-0-bc15f68af7de@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEj8vmgC/22MywqDMBQFf6Vk3ZQ81XTV/yhd5KmBqiWRYBH/v
 VdXRVzO4cwsKPsUfUb3y4KSLzHHcQAQ1wuynR5aj6MDRowwSRSpce4mNmNlVEWZ1MQGieD7ST7
 Eee88X8BdzNOYvnu20G09FgrFBAcnq0ZwQ43gj7bX8X2zY4+2QmGnFgOL2tpZRbQJjT9a/NTiY
 MFbVMZRyYX5t9Z1/QHpvmv+BgEAAA==
X-Change-ID: 20250907-sht2x-9b96125a0cf5
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Kurt Borja <kuurtb@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1464; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=DPok5ZJbW/CmanImBGvSLTbfYtANs1XLx0OzKK/GxOQ=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDBn7/gQ+27pw7tfDum+v6Esn88RUPPOR+LdUa/ODee/k1
 M9uOHpMpKOUhUGMi0FWTJGlPWHRt0dReW/9DoTeh5nDygQyhIGLUwAmsmoSI8ObPvk3jgtury1S
 Fhbb5mbsrRSZJtJ+3uDXN9uVbzb0qFsz/A+4adc1YdHu09qPxR6l7Pu85NGqqGes3w+l3oy3nRU
 mVswPAA==
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

Hi all,

The sht21 driver actually supports all i2c sht2x chips so add support
for those names and additionally add DT support.

Tested for sht20 and verified against the datasheet for sht25.

Thanks!

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
Changes in v4:
- Reorder dt-bindings patch
- Drop stable tags
- Link to v3: https://lore.kernel.org/r/20250907-sht2x-v3-0-bf846bd1534b@gmail.com

Changes in v3:
- Add MODULE_DEVICE_TABLE() (I forgot, sorry for the noise!)
- Link to v2: https://lore.kernel.org/r/20250907-sht2x-v2-0-1c7dc90abf8e@gmail.com

Changes in v2:
- Add a documentation cleanup patch
- Add entry for each chip instead of sht2x placeholder
- Update Kconfig too
- Link to v1: https://lore.kernel.org/r/20250907-sht2x-v1-0-fd56843b1b43@gmail.com

---
Kurt Borja (4):
      hwmon: (sht21) Documentation cleanup
      hwmon: (sht21) Add support for SHT20, SHT25 chips
      dt-bindings: trivial-devices: Add sht2x sensors
      hwmon: (sht21) Add devicetree support

 .../devicetree/bindings/trivial-devices.yaml       |  3 +++
 Documentation/hwmon/sht21.rst                      | 26 +++++++++++++---------
 drivers/hwmon/Kconfig                              |  4 ++--
 drivers/hwmon/sht21.c                              | 15 ++++++++++++-
 4 files changed, 34 insertions(+), 14 deletions(-)
---
base-commit: 76eeb9b8de9880ca38696b2fb56ac45ac0a25c6c
change-id: 20250907-sht2x-9b96125a0cf5
-- 
 ~ Kurt


