Return-Path: <linux-kernel+bounces-882724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD93C2B3F2
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 12:08:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22F4418866E3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 11:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016E730148C;
	Mon,  3 Nov 2025 11:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="acI4HVvX"
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E800D2FE58F
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 11:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762168020; cv=none; b=FRui4RSd9W6HCsgVXouU+Ni4mice3HP9XHls4gXWkYvMuH1h3Pf8XuZ0Qqj81p2INePwHT+wkKZ3OgjErisVfaZdJ30Krcf9IhtCabOOzrvL4WOBDRg27FPvvM+9w9Kq8AyctTJGGjaet2ouuQ4ju5Gua+ssiJFC4BOnrToTz74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762168020; c=relaxed/simple;
	bh=4K8ff7naWva5QP5+rWneFBDK+QFz923xCqhRcHl62d0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mg6DAiHBAxJmPKoI9zOACbEp7sVk3JnSCMNVFrvMU9o3IfGOCDKijc3bcRaMJGSGukMKym3T3aIonF3A/GhtRg0bWNuUk781PIuFmCWxaAWPy1ZWXw1Cv4cgcYNevMDlkBWOuKtzrMHIo9+KexJNEbQiHs8sRkNWTR7tF9ULSiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=acI4HVvX; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2951a817541so42420945ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 03:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762168018; x=1762772818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=msKPrbmLk4Pe+fn3QzDxAI35yUJEjQv+lopXWiS4lts=;
        b=acI4HVvXpDlipCGu3tF4pNA8mEaYI1wS8/ybxO6sMKNln0/f7Gj3M5kUfhyGVu8102
         ABa0zey2hWthYSAA3OcCg7wcrTtW29eQqb/9dZae2Dp5KPdsn3G27R4MTbud2uCbhzgR
         L0OqhTVA9v2QyG7/eVIekBPQDPMzgvApbmjEJGMW/MI2VGxZzSJBaAwpZq90S5eCjxLH
         vJymWCOpwDc2FP8R7KKRDQ9fV5oYimwMkNNDJTgNvswhTJNz2lDrozvvzDlnEVn2K6Dg
         JE1bN1jgtdF/mMnj5Omq440UNL4tT+1BFzmxb155G1QgizwJ7V3BuecGAE84hKKTrCrd
         8ahQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762168018; x=1762772818;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=msKPrbmLk4Pe+fn3QzDxAI35yUJEjQv+lopXWiS4lts=;
        b=qEsw0Euwyr3HoKwm6vXxtA/XHAaeBYDF/Q5X1RkHZ/dFUBtAAYdaWBa5k2On9SFXAW
         IOTZ95RG1VhxMS40C6hPQt/hDVMIT0xLCoPd2CS37s9KUp5w+B+/xeVdUv+vnIkBNHyp
         6ZH02tJbsFw1PF2+HHz3zwDgWpL82WBb6TKAEQNAzJEU5gp7Ir/Xi5JIFz4OhfKU4usX
         iJD0wvrIv2jrp1DJbm0JGutQS5JFPq5yyDSabvz4DVRy7e+tEauS0uiQSclaHe6FA0pd
         /SYM1JHoydkbHT0nxO88/KAk8n5M7xRV/yy6HYlT+RwK5MKRxDiuGHebhlqY4yV4wRcS
         PzPA==
X-Forwarded-Encrypted: i=1; AJvYcCVFmyLaCitW5I9wQlOiEQOW4kt5W21A6FX5YoRiw0QJBSzG592BgSIvQG9XytV5VtMllU5adrS30CKHMVM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEJdyOjgrkLIZcEd3RAr7rpSXjilI5Z/UzuBIvXyX51TdLYYSW
	fq5kupHznJ/iyOttJPSqkrzQFXMhceuzfHldwFw/RBaEN8m3aL6SeekR
X-Gm-Gg: ASbGnctLsTPyfc1kBSTRsU1DaMsUICtg4sYUF+gtPiOI3CDDF67UjnoHWbrcWlIlG8Y
	l9VhYrfso0xJjfsDpHB0Z8ZWyymkcJkMZ3K+c95Yh5mNcrUtF4JYJeqJXpOTkIwjHgqub8ebWyb
	JWlPCNHEmkmnMUu5ezK512icbYboPWf8oQXxRoebYsZznbWCIWiEynPWxZHHxKjIZZeP1ly+orO
	CEwRRJNR9zcvRj1fsA2z1N/Dp2XSX/QuTAJVnFVYO3bEcRSuFvvx3Doa8Oax6S1+VBGCfok1XrK
	rukwtDxdFr6p9lEl0cSnjOnX/skRzFQsjAs7ynD0WvH5nNnFLa+7VQ2gxmmdtuBTq/dOI6Z2N8t
	+aVs2N1kibJvYK2qu4SLYPPHoJ40kjUIoo4xqef3bb7Waw22HbthAk/1kgxB91sTuy4dz83wpqX
	0UMhEvc9bl5+/eIdvT3Q==
X-Google-Smtp-Source: AGHT+IG3q2ScRjcYVlSQKEOGzfSShOd+VCm6j/zTtP/syrwGIinOh8u7Pw68B0XoVDTjaFHiUhDd5Q==
X-Received: by 2002:a17:902:e74b:b0:269:b30c:c9b8 with SMTP id d9443c01a7336-2951a55923fmr150821025ad.56.1762168018110;
        Mon, 03 Nov 2025 03:06:58 -0800 (PST)
Received: from VM-0-14-ubuntu.. ([43.134.26.72])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2955615d720sm84025575ad.65.2025.11.03.03.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 03:06:57 -0800 (PST)
From: Junjie Cao <caojunjie650@gmail.com>
To: Lee Jones <lee@kernel.org>,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Helge Deller <deller@gmx.de>
Cc: dri-devel@lists.freedesktop.org,
	linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	Pengyu Luo <mitltlatltl@gmail.com>,
	Junjie Cao <caojunjie650@gmail.com>
Subject: [PATCH v2 0/2] backlight: aw99706: Add support for Awinic AW99706 backlight
Date: Mon,  3 Nov 2025 19:06:46 +0800
Message-ID: <20251103110648.878325-1-caojunjie650@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pengyu Luo <mitltlatltl@gmail.com>

Add support for Awinic AW99706 backlight, which can be found in
tablet and notebook backlight, one case is the Lenovo Legion Y700
Gen4. This driver refers to the official datasheets and android
driver, they can be found in [1].

[1] https://www.awinic.com/en/productDetail/AW99706QNR

Signed-off-by: Junjie Cao <caojunjie650@gmail.com>
---
base-commit: 72fb0170ef1f45addf726319c52a0562b6913707
---
Changes in v2:
- add handler for max-brightness and default-brightness
- add properties(max-brightness, default-brightness) (Krzysztof)
- use proper units for properties (Krzysztof)
- drop non-fixed properties (Krzysztof)
- include default values in the aw99706_dt_props table (Daniel)
- warn when a property value from DT is invalid (Daniel)
- drop warning when optional properties are missing (Daniel)
- add a function pointer into the aw99706_dt_props table to handle lookup (Daniel)
- use a lookup function instead of hardcoding the formula for the iLED max (Daniel)
- move BL enalbe handler into aw99706_update_brightness (Daniel)
- Link to v1: https://lore.kernel.org/linux-leds/20251026123923.1531727-3-caojunjie650@gmail.com

Junjie Cao (2):
  dt-bindings: leds: backlight: Add Awinic AW99706 backlight
  backlight: aw99706: Add support for Awinic AW99706 backlight

 .../leds/backlight/awinic,aw99706.yaml        | 100 ++++
 MAINTAINERS                                   |   6 +
 drivers/video/backlight/Kconfig               |   8 +
 drivers/video/backlight/Makefile              |   1 +
 drivers/video/backlight/aw99706.c             | 492 ++++++++++++++++++
 5 files changed, 607 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/awinic,aw99706.yaml
 create mode 100644 drivers/video/backlight/aw99706.c

-- 
2.51.1.dirty


