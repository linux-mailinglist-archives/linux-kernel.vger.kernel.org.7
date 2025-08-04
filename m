Return-Path: <linux-kernel+bounces-755153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E908AB1A214
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 14:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 966C03A806F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 12:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D49E26A0F8;
	Mon,  4 Aug 2025 12:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OiLMrUdb"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834472620F5;
	Mon,  4 Aug 2025 12:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754311717; cv=none; b=IRyBqLzdboeBH9IBaC0hxBgNxJgjI3vLgc+5eZvnUbLywQB8R7WDjPYG3oGu6tdMrgMYGNz04fXLzyCsbI2t+0zjQ0zMxIzaPYMQyyxdr8Rn1eaNNNOwqYosZ/FASkW3RVjCnEefvtcbT4W8UFgjr11Aw6B7wyb+Z8GyYP6B7qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754311717; c=relaxed/simple;
	bh=+rWNS6EpC+ok6OGEmxvyNLCgYYM2WkjSK3CbsK5Csv4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B0ZhXcxgSkpvZHGAC/VDyUQl1CLUz5c0/q2E8FFjPEPU+bWWPY9nQMb3P7W4n3JWNDaS+BWjsf0NNYMTBrSARc5VyV3YLZPu/SIWMvG/rfJQrVB4NMepH5GHd2O3gGAjB0cTeKSMtWbe6Cvd5MG4jYEutM4UCXH3xSGWdvPoHUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OiLMrUdb; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-76b6422756fso4938705b3a.2;
        Mon, 04 Aug 2025 05:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754311716; x=1754916516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gzjx2DVpYPGgsfQ6eov+FVw7jZ0lNmf8LVqNGKlL7nk=;
        b=OiLMrUdb5w+hfj8u3L+3flAnFxF9F66B6vEi7ZuJ+rTGw5NFBkqQRJfGFnTGqQKk/n
         H7GdP2V3Jxy7TJXcmDn0M6borH9sX1Gw1HoOGZh/zmBNkdpKJJzOt4r4e+xk9HwlfDpe
         P14thvJLRJ4zjeDrr9OtlghWaKhy9Es+sR6mbBmFeY1G9SUnisqoOIguiTdVTA/LkzuZ
         +w/KGc7GDcoaxNjohMR6C9rpGzsOEM6Z8WssnBr1G4uxEmUJYWb/b/VXUHY3AISIE0WF
         uBAvfR6GGHkkv3/6RkiLVFblw94PmFaPzCN3EiFFW1UpizAA6GGUZ2EMOVcjbfxN+bTH
         ljoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754311716; x=1754916516;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gzjx2DVpYPGgsfQ6eov+FVw7jZ0lNmf8LVqNGKlL7nk=;
        b=PTF+wO3CxM1nvGcX/9ZiTwAdDoo+yUh3bL9uBfgnqwOiiwXdRyDyvHtQgsADTepS9k
         d/T3IUz4k4uV6aL4Nzjv2S46tmYWxGs9GUJ/RZ6ryff+/ED4tRfX/CcXJV9bCzud9lbL
         R426tS7yC83AS8JS/pEX/K/sBgVTW7TclJX0NUpzaAqEl7BeGnXhlCmQ+OJxS3yo4Nyg
         64Hd4Nr1i7ZYHoAMuKlSe9ek2bnH+iVBxZ6YpL+U94Ki7cQMV2bX6aOsG/YxrnrMQnHG
         ZUwbScjMWBdWZBrbadrHrm/TcrDLQHsmwhQ5vKLlzxbXV5bObDAg5bMITh+SoMkwa1aL
         AQIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDhOSmNFPLKW/QDUehGJils7L+pGH/DSs7ED86p6PqHesDRrXUYuZn9WBE6Q6l8UT3KxUQt5V+/U1Z@vger.kernel.org, AJvYcCX6sSt8kF+zizWFZ0xSnvLL1RaJ2DhlOMgyKmWDf55j+ZO8jKLekjtab5kxNVOKtqE1uXpr1JpyJOAjqlmT@vger.kernel.org, AJvYcCXI8QQQO/9YGvVxOtyjkCS0ncRr/buI1aGETf7o2wB/dpw66GOrYKfpMqD+Jl95C5HmOhlVIxVC4PxH@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr4tQMeqxZlklECkBJKbG78JOGsLqQWPIoBuJV7wuIOgEjtVbO
	jYM6ns1YuRXxNDM4AUqgitesTeRCeXvng4lzD7wb7pepJVdeHPSTZI3vrd9uqQ==
X-Gm-Gg: ASbGnctv7h+zuiTu5+gYZoJw6xr5YsYQtAlD41ucqbkiAk3xus9AbmpGCBbOqYHFmu2
	sFaV0U7wJ39/yO1S+m/pTH4w0+78sZJt/4DcpF3bhMdZ/pULXbuLYzmeOo7OujvQyicZ6yDr218
	xleR7Tu6VY1RlhNoxg2FimLpPH4kZKZiJfe/ylQ+yBraJhj8PNvX5zu7I8y1LVSWuE07DLlJjXi
	TpP0f5yyuvSQ7+UMOa0ANoMPYy0Y7UJs5QsBcMojYS4LP40/oqP7bL1RJIy9PLShRNaP6k7nNXt
	ODVGR691QOKfV+6FLHqkHHX/ZpWxmxCVF4yzGGXy363/6qY6JypCH2FHebHfF53Jq9KpP10g1j3
	NrvX8zTqBb+WDb7XiJq513kCfaZoqsx02HD7zZhDnMDacMm2oQPGNe90QG7j8HERL0GF2ecFiQP
	rxkWbbu6I=
X-Google-Smtp-Source: AGHT+IELLgfCkFQJQ5IDbpK6I+JXBZTSYNzNEe7rgTPBPnl8nosGlREgdQgF972TIfm4uUY0QalItQ==
X-Received: by 2002:a05:6a00:4644:b0:748:e1e4:71d9 with SMTP id d2e1a72fcca58-76bec4f6a57mr10718674b3a.22.1754311715527;
        Mon, 04 Aug 2025 05:48:35 -0700 (PDT)
Received: from CNTWS00427A.itotolink.net (111-242-101-165.dynamic-ip.hinet.net. [111.242.101.165])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfbd656sm10566612b3a.72.2025.08.04.05.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 05:48:35 -0700 (PDT)
From: ChiShih Tsai <tomtsai764@gmail.com>
To: linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: jdelvare@suse.com,
	linux@roeck-us.net,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	corbet@lwn.net,
	t630619@gmail.com,
	ChiShih Tsai <tomtsai764@gmail.com>
Subject: [PATCH 0/2] Add sq24905c support
Date: Mon,  4 Aug 2025 20:48:03 +0800
Message-ID: <20250804124806.540-1-tomtsai764@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SQ24905C is also a Hot-swap controller similar to the ADM1278, with the
following differences:
        * The MFR_ID register data is different.
        * The MFR_MODEL register data is different.

It also introduces two parameters "silergy,power-sample-average" and
"silergy,volt-curr-sample-average" for Digital Power Monitor. Device tree
bindings are updated accordingly.

The currently available ADM1275 driver supports the ADM1278 and this patch
adds support for the SQ24905C. The datasheet see link for reference.
https://www.silergy.com/download/downloadFile?id=5669&type=product&ftype=note

ChiShih Tsai (2):
  dt-bindings: hwmon: adm1275: add sq24905c support
  hwmon: (pmbus/adm1275) add sq24905c support

 .../bindings/hwmon/adi,adm1275.yaml           | 20 ++++++++++++++
 Documentation/hwmon/adm1275.rst               | 24 +++++++++++------
 drivers/hwmon/pmbus/Kconfig                   |  5 ++--
 drivers/hwmon/pmbus/adm1275.c                 | 27 +++++++++++++------
 4 files changed, 58 insertions(+), 18 deletions(-)

-- 
2.43.0


