Return-Path: <linux-kernel+bounces-771210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3E0B28431
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 18:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77518B072B4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 16:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C471430E0F0;
	Fri, 15 Aug 2025 16:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="oKCu43NV"
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F192E30E0E3
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 16:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755276266; cv=none; b=MS2I3qXEIIqTmpFG96bnDU1NbL8djXgSiDW5Z413Jcer4Se7/yPKqGlD/tES4hxiZxBX15LTlEZu7eSgSKUIvrzlwivAF/MDS4T0cr/lFNIv6n5+Iq1djr44vYSyksBISp+ku8ulddmRyFGVyfrb1mAuuwIcA5kNZCXXO6a2yOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755276266; c=relaxed/simple;
	bh=4mSg7/FJF+dNCJc9keQwuNfI4XYRtRidKb+j1+8mh8g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ohUeLNdyi80ULMRgHDZwsi5sVT9IvU5791QzAEUUW9lbdrv3iLsged+MfO+bzNCkQnmkxVUQhjaqfHlJ4aGPzfOZUHiEIQ/VpeXBMY7V2NQ9++sodt/4GEE/OW+3u7lHPUq2NzItIO+21n9iDq+td/yl3UXr/L72R6t/OM3m3A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=oKCu43NV; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-435de7ab175so224705b6e.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 09:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755276263; x=1755881063; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jeTCzOhB8KlIbjBAM+JfgXZgHbqV4L9r/ttlxrn63B4=;
        b=oKCu43NVt953zlSg1P5W1H3Kvf/mnpyXZhDyqd+sJiKSf27o5q9CNPI7DVeQbPLsaJ
         xfJxSXaySzuDmLVOM3lXjhhi7d3PS/LhIYOHNorx4GMfOAqbflOXTBv0GanK7ZRWkfb2
         +OuEKcem1aY2YZHcJ9wu7muphRpaBOwvFrbRrQf/8/VB4KKrnQFC9kIUt87H+3kV5+QT
         SoVJxAHrHwhIsXWzFD6vYyGQ4n+kVkYyyJvVpSfo6LCOYfYkk9g0jrr5GH2D8nXl0i1J
         GCm9gqNsv0oV8rDi30P2jjV2WbbcRhcJgkfWj3rxpH/yLhZUcW7Vm1N6mWRqLGbXiGMU
         OMOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755276263; x=1755881063;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jeTCzOhB8KlIbjBAM+JfgXZgHbqV4L9r/ttlxrn63B4=;
        b=uqT4UBZ68bz2Esff0VNYXGQf4HMgzgO0DfJfQ0z41s54EnZ+SutdyZbWgDb9eperKq
         ChxSE3R7yMIni78EjEYHER1yo6FbBCknD6tjZTA5vCVTT475yR2EEjIjERky2/22Ebv3
         Eanueg0itTuGxwIzsPOL9dMYD9Y2Od113zPLyE6eEW3dMBLfRqUP3ysCgRPIIh6+6M4X
         PeWIEym1l0hBl3Dti257Jed/AuKwVG8N8nwATiXLffurXs5y13HQRiBr7SzqEETpvvwL
         BqhoAn5FNgayExC0U5ZxzBpZp9IfxnMfYVJN8/zEMlZR92fdDj3A+3koje0v/rFftyUe
         TBXg==
X-Gm-Message-State: AOJu0YwYvcb6utM2u1/bU2xMkwCSbePkiFp5UBMS+2tuhTjLGaJLykFn
	Ji0XQ8QbvRIUQ6cOBdEO+0aIRAecz6sDxg8vZy7Ff+e78bB+z480YKv55fBGY0wb4NZrp+UpIt5
	Hsov5
X-Gm-Gg: ASbGncsDciwRNhoqUruEf3H2c5UchCO2IhZ62nLv7+tgCRD6+YVR70bblwDdUy+TYxX
	BJxf5bmAXit9xKci2/GV+qS2uqfy5NNcTcnnmFmMw09Akztj5I1IijCBcsqVJviE7a3uSNtzx1B
	vsSgloeCxXigxulIGNsn/gMEHauJyypwEb7E6H7H6C361Qd8Aabc3B2Fs8VJSAYHQbuIHqLXSQP
	k6GqpEIh8dVmtnwvGraSq2g5/PnyXYbLe4NccTDjvhKGGJcY84KSMSNZIqUDGcxdjH5KESRrDBD
	b23laMinKN7WTowrjlVAHj7el3CL9P/S2QH6nNRZ52pyO2giFQ2nhxNxm08Dp4IV2uo7zN8laju
	GMTOIQ8H9brplbw6U7PsLjeZPT8A=
X-Google-Smtp-Source: AGHT+IEo11i/uc/Hufr9lPF4hwWNBHjn9+ucSXTQlaalqfaTXDcHGp7UsewwnkPTdi+uu/hMcbjDYg==
X-Received: by 2002:a05:6808:10d6:b0:434:d39:63bf with SMTP id 5614622812f47-435ec48ee26mr1198739b6e.14.1755276262853;
        Fri, 15 Aug 2025 09:44:22 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:677:c1a1:65b9:2b0c])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-435ed1b186bsm305263b6e.21.2025.08.15.09.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 09:44:22 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH 0/2] spi: offload-trigger: followup
Date: Fri, 15 Aug 2025 11:43:59 -0500
Message-Id: <20250815-spi-offload-trigger-followup-v1-0-8ec5413a8383@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM9jn2gC/x3MzQqDMAwA4FeRnBewrYruVcYOsiZdoJiS7g/Ed
 7fs+F2+HSqZUIVrt4PRR6ro1uAuHTye65YIJTaD7/3Yz27EWgSVOesa8WWSEhmy5qzfd8EYAvs
 puGmJA7SiGLH8/v3tfhwnv5GMMm4AAAA=
X-Change-ID: 20250815-spi-offload-trigger-followup-d33f263169d4
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=797; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=4mSg7/FJF+dNCJc9keQwuNfI4XYRtRidKb+j1+8mh8g=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBon2PRmJwQLsyKooC72AoFETjaYLn/XzO2yFqLJ
 Hs5xJ1Xfi6JATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaJ9j0QAKCRDCzCAB/wGP
 wG8eCACd/wPlJUMamVDnAuTfSpA3J7dv4WgxloBtOsquEjQrCO3X0cBW/ug7R6HkXzAow5IzJqE
 0Ww0VVJlRZnkiROVGOo5XA4cuCfD4J26plTtoCuK87UQU5MAYdT1USCqP0BF5HudhGybKNo5Vrn
 hSgygwu0YSWDzyGWwrhPddJSr9ZlE7l3CTefIq4BN6z1E9D5h+RDtdtAEFAzZ6BosU1T8Mhmrk4
 cldwTn5U1oY3QPL4+irBqLP3l3Y80fHMcKdmxQfROgoQviSUH6aOQuUr+zmgf9vQ91ZdFSni1/E
 +DpUqPfrXX4IwNknygJazce9M7w17W5KbUMs3OyYbwDf8e9j
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

This cleans up a few loose ends from the series that added the ADI Util
Sigma-Delta SPI driver [1].

[1]: https://lore.kernel.org/linux-spi/20250701-iio-adc-ad7173-add-spi-offload-support-v3-0-42abb83e3dac@baylibre.com/

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
David Lechner (2):
      MAINTAINERS: merge TRIGGER SOURCE sections
      spi: offload trigger: adi-util-sigma-delta: clean up imports

 MAINTAINERS                                            | 8 +-------
 drivers/spi/spi-offload-trigger-adi-util-sigma-delta.c | 5 ++++-
 2 files changed, 5 insertions(+), 8 deletions(-)
---
base-commit: bbe4656eae2729b8ca87116defa19c568898d08f
change-id: 20250815-spi-offload-trigger-followup-d33f263169d4

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


