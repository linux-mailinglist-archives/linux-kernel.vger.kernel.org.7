Return-Path: <linux-kernel+bounces-855780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 717A4BE24BD
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 11:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 240EF406959
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 09:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A22F31158E;
	Thu, 16 Oct 2025 09:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="r++X6JFY"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FD53112A9
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 09:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760605778; cv=none; b=SuTEOczCed4qYmlNpn53xkPQ3qgFNhmjbrfsgl2vGzInlGRfj8j3dlOyF8C5mpabRTwNLu5NkMqffBGzqMV2dDK8BKFrNKlJkETpGXEJckK72KwRT0dtihmAKbA7hQJdcFWPbCazC2ZNA94WXZYhwlvdwe0IVgf6dliBuTMQjE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760605778; c=relaxed/simple;
	bh=/A0ZCcFCCbHISULOnXDBh9EbzVTgeCK0Cn6Fan3eR6s=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mOcDLchjF7BMY1k7qv04ne7pXfMRDdVeZxTLEweK3J2rIiRivPHIwE5FRQcCQ5B6DVBX5lFXxBBcexCdQYJZESw9Fi9NcFqTr/FuFHhkA77QWkJLQz5xH9JR4HDyfhqgnp6CAIg83ghS/F2rKolkv0axUThKgzdVzAis3PomWVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=r++X6JFY; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-42568669606so368806f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 02:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1760605773; x=1761210573; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3XfGtDpvixDdEbcRz5vwuGcb2ROuArxfXHlo3yElQWM=;
        b=r++X6JFYEMiElthQ28hMk1Wg2h/5n8TILpEutfWQS8RaCDIyT8wDSIQM7P3rajSWa0
         utcJC4quT4Gg0KkVrANxoIBULlxHbb2nrPU0BZWrXYBYZeij8ZRDDO0cBlGO2mvLWMz1
         FrEQ1fyTZKy0hPgrr43AysKgE3ykgPDEfSRusOcZi2aZ4QOoonDGquQnWHPoPowRw3q2
         0MvnYbMG/VLavH/HstQaeV/RXZ4/nunRuhA9xrddQ/WTAgws2FjUv6yZMp/8StKT0EX3
         tPFMcNxPcQ58/VzL0+k/HI/MuvP9SICdM4sQNP0BSJIGaMi0bSzCB1dE01XrgqYLHQ5i
         TQ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760605773; x=1761210573;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3XfGtDpvixDdEbcRz5vwuGcb2ROuArxfXHlo3yElQWM=;
        b=K1KYRRgzdNEyBR7ljPu0javt6xO0M0fugSrdZ8FNRMy8pTuBTmPKthktRA2agbRNYe
         BJVg4r3PdHYiE1Wd7sc8GUcNQHtrePbBTZT2gW4xkuTgU/uPIlcBf9/lKKUsP1OVsIeD
         WVZlIjOPoeJrDFA9JSuWf4k5b2D02tAzcwh3D3nN69eJTAiFmVVrIwi2aIL5xQEDe47N
         NvUTGPdywc+mthlh+X3scZglKTVH2mrdpw84Vydc+HUjbph8wyiCU+OZ11ey778kVRIz
         Bm84yTpPhM7jnFJqHd5TBwnCt8UXygHgkXVPFUcfMbBXa/erQnn9eRIco11s07xRCSVb
         YiNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcxu1OJXyIp+tWE6Gjsw1G9rtj8mcr3Siay8AnWZRquZC0SQWvdgTst49sq2fVydTH4AgAkdkzzFhCpXo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm2N12z1/dStiZnSMXxsiiiv2wapSBKwWugBbeOlVFimSuvTyB
	qionZVYOY8dGFgetqeS0hmUIPsGUy06F9F3nO11U+JC/TQ4FcBvfxzkUKaVnJz4+6Is=
X-Gm-Gg: ASbGnctGL3VzYa1UodVD8OwId6DH5ihGIKpKO8maJcRQMugPmb48mXTZXVrlEqmFJdM
	k5tAC51v0+fggpVT7l21Mnbu2AU38TrH7Axdxjh6S1MTJsnqW+o4v/FvT/zwCWFHnxmVoCX8zNB
	XCkdK5XTLQgRGLLS5ah+AigXc/2nRqV2RC6qFVAK2BDDOknSjEU+4EWz/cLe9YVF4XhoQBnlfaw
	9eeSnK8ZDW6aH5XsmyAznt5v8fhTGf5tnKZT8ull7p6/nJ+PdWPE3NpCIfPFusEGiu3lWYLZmaV
	NniTuhC7V0gifOFZrFVmSYdAM04JdPYwAZVgYXDyRmoSs2UsVE1qTyYTbkhymON0kReg0nXTjST
	v0dgJo27UEOU5ouJ56i2IUc7ZS5WWEfLa48p4F8bSxTg8/D8Tu/4tlQ8HemNs2lp1qtPxaag=
X-Google-Smtp-Source: AGHT+IGiB5wh2xi45fqGt9AHQHRjpRW/BPh60+Svmei7EnochMvgfDKfftV2c/QbNugPLrF4Z4/urA==
X-Received: by 2002:a05:6000:288c:b0:425:75d7:c308 with SMTP id ffacd0b85a97d-4266e8dea0dmr19755334f8f.51.1760605773226;
        Thu, 16 Oct 2025 02:09:33 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:ef97:57cb:86cb:f7c4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e1284sm33191287f8f.45.2025.10.16.02.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 02:09:32 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 0/3] gpio: aspeed: remove the "gpiolib.h" include
Date: Thu, 16 Oct 2025 11:09:24 +0200
Message-Id: <20251016-aspeed-gpiolib-include-v1-0-31201c06d124@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAES28GgC/x3MQQqAIBBG4avErBtIy0VdJVpY/tVAmChFIN09a
 fkt3suUEAWJhipTxC1JTl+g6oqW3foNLK6YdKONapRhmwLgeAtyHjKz+OW4HFh3vW2N7rE6QyU
 OEas8/3ic3vcDmqOiCGgAAAA=
X-Change-ID: 20251015-aspeed-gpiolib-include-249a3529efd5
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Kent Gibson <warthog618@gmail.com>
Cc: linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1080;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=/A0ZCcFCCbHISULOnXDBh9EbzVTgeCK0Cn6Fan3eR6s=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBo8LZH3arKi5byEXGVlxJX2oBym0TIUQaJt4vNT
 2Xhn80agZiJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaPC2RwAKCRARpy6gFHHX
 ch71EACPqE9VZd/9ZyXyN0sohSzOOWITHwl9w0/7pdKL5fhienPDAccVYCkftlwlyVuR6IEaINE
 NS8j/mdCrT4WJfa5s+32eqU7LcMma9kwO7ZGhRtYJlKJlRCOqV5RiNU5nWhrL179JY8i8iPNP2j
 8TTKj2+zZGarliK69rjNxfN8eO4CvMbnGQVQpOTz5q3ggMBC5Q+NFLn3ruJxDRYz/o/rbpmm8Ci
 P7emEyEGFOV99QTDHmfj9y6203ZN322qZSET6UBrW7GX3gMslcgtmhvROjfL00YyG4FLvkPomPR
 Qx6fQlJJ2zMgvQkWqwxxLt4Ga/Ms+c6mmL5fdINtDr55jP5jx1gw8i+akbhiimaDcacFIst0ghX
 ShGVHue+2vDlV9QUpLwG9kIX0yjmCFHhbvh0/ZRhE7z/YXSouMX7fPF8jE+ch1Ms++5w3fHU//b
 p4/BmPhBqEYvzFpNof0paEusUG6sAXvrkbNCKlis6m5JGWP59ZP/lsXbMkU0o+g6B6dK2kxrsdC
 DkpfSgbFD78BGPHNXaQMrrMb2E2HSUfcJpCAIAzZkFqK09WtU/NPIb+kj2LBq2LtYasZPMXcEqN
 kIUBHTzWzvWGnU+qpzKkEr9RdRB9L9sKakgDpWqIj5MutGTOA8KWZA+RYmeP+7GUZfmrLpRdxGT
 5W060Q0/Ve/5ewg==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

gpiolib.h is a header internal to the GPIO core. Drivers should not
include them. gpio-aspeed only needs to be able to determine the
hardware offset of the GPIO given the descriptor. Expose the relevant
symbol in the consumer header which allows us to stop pulling in the
private one.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
Bartosz Golaszewski (3):
      gpio: rename gpio_chip_hwgpio() to gpiod_hwgpio()
      gpio: export gpiod_hwgpio()
      gpio: aspeed: remove unneeded include

 drivers/gpio/gpio-aspeed.c    |  7 +++--
 drivers/gpio/gpiolib-cdev.c   | 12 ++++-----
 drivers/gpio/gpiolib-sysfs.c  | 14 +++++-----
 drivers/gpio/gpiolib.c        | 59 ++++++++++++++++++++++++++-----------------
 drivers/gpio/gpiolib.h        |  8 ------
 include/linux/gpio/consumer.h |  2 ++
 6 files changed, 54 insertions(+), 48 deletions(-)
---
base-commit: 13863a59e410cab46d26751941980dc8f088b9b3
change-id: 20251015-aspeed-gpiolib-include-249a3529efd5

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


