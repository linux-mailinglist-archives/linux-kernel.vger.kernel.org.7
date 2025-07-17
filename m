Return-Path: <linux-kernel+bounces-735336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D42B08DEB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 15:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 672F51A631CA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 13:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570202E0924;
	Thu, 17 Jul 2025 13:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="ND/BH4EL"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DD02E0915
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 13:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752758038; cv=none; b=Q0Zr+CNGcy9mBCy1uu8ccBRLPIY5JGoHd2aSAwmtebBws+VLLAyRmOfJRKETTqGvabk4ga/Uc9nuvwqTIHZ071sy9xM56Ns8+gD0sC8A/1qMUMZbb4vYii5mb8s3iO+e+rrQMdB2RtPxkmiMv+yMsAqCOxYZtmmfsYv9OIfGMuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752758038; c=relaxed/simple;
	bh=a8abfs7W+odJAvc05UtZxThb7KM7VZKwhQlopTwPBxM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ojqr7dzDGUnblMPwKGDcdb9uYNdQ5KETVD1X2/bTGwalgL393FWJY07agKDNip9g8PV2J3UnH3xpWyO5ouVuIYOvilnW3b8oZHGK8HfnNzCC6pDo7PAsScRMSassvJ5BscvQ7UdAnkuT6fiKmpYEa8hyCLNHRYr7e6JhljMXWwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=ND/BH4EL; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3b611665b96so531168f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 06:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1752758035; x=1753362835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8BlSOIjzqGPblnVa/16/fM22TF8N0olF4TmJ+G8fMEQ=;
        b=ND/BH4ELTp6I2JGqRX7M2LoMP2UzpqdsgEovKZlP+ySJnnVO7csIur2rhNG+8sWifL
         q/ES3vCOKcd9QCE+drNsJGzwT1FUS4a6gH4zM/wmnKzVqrZMKtGnogE5Fl3kXJUUnBc+
         Lcwy5hel7MR5BPlyvudzk3QZANSy77Iyj5dbwGOteNsSSnRJuvSHs66f3moLAzoTrX2C
         RE56px00A/PW80S5WDldUvOa3X0jXrDJn6pVRR8la/o4mPtL0bjPLi9BWuMFtXrw3twI
         PMyjrJDo0mFYepy/b57B0Z25VZzwKETqk2ocL9txdEmRftKQZQkKEv7kKY/X62wND8Y5
         6qvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752758035; x=1753362835;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8BlSOIjzqGPblnVa/16/fM22TF8N0olF4TmJ+G8fMEQ=;
        b=Ca0GjyCfUgnxUuaSMmBFnldRpygyyif1JRascd4N3UUNpcrUUS5tJRK1TISeMKBxQJ
         SZOOpTtA2ljE9hu0UyZi9nrVXvvEOPHkph+aEA3Ps+ExkeTqmr681KbdD0vcgylptzyr
         npUdIDzpz9K2T6oSepWMnE4Ny6VicC0+FqnWHWpf02s69/Jl6L+dHr6rj50Lca1LnZPZ
         EtW/4OoydF9HRv+q8VGqwUDMYnJs9Rlu0VH2Rp/XiZy16y0jnOVnUTm+gO13XGbiWFrI
         8vUYQRXtwZxY4X8zZAYESxcYtNPpFE5t5qOP7Bw/oyUA/4q6VusMtPKueHvhOxhKw6QJ
         RUCw==
X-Forwarded-Encrypted: i=1; AJvYcCUaDFDHp9BkjRmpQ7ZDk5QlIm7FebxqmYkWAVrgAeJTSyr9ANA0VOMw6tPWO4iVY08HmyKQIn3zH+IkDOI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp8W/Zk0VOCOaYKfMvsd3kAACImXDD0PBavW6YOyD+7PzYlbcg
	pLsYkDScM9QDc0rFLpyek3hw6+5ssKAyru2wz3WI4JteE5jTO6e+PpAsNpt76qTBME8=
X-Gm-Gg: ASbGncsmpJtMB4FJmavE5Gi64D7P9ddA+OBJ/p6taUM1geFTIflcK8kcz803HX+GJDe
	+pwK7yke7w8/9RtVhzHeMcYyaArH8a9CvYy938+8jNItR1fF384A898AQfbMZtZzRItuUCJRbRV
	JW3wAMoUAuZZCJMVH1c1PACtSkpxWMEhhre9pBDC4tV2s/bZzi3zRbdVj2DrnTnQ0v2MLsYaAPG
	yXSk+vUdiKFtkuMDlp924WzLUxVlfuj8bKjeqi2Y5y/xUbWiHFMckZSkSfy+wzusU4J/CfRWRSq
	MVyUoHud5FfaRmqI/Pa31QQLe2rfQa4b5iAAAldS8XbUukEB/ttd/d8LXsUlAnx9U866qkELaS7
	BNHMoN1ZsEdVwLC9M2V2TgA==
X-Google-Smtp-Source: AGHT+IGgB/fpEAWYu2VM4+/5m13YBJZhxv9mX05x7EQ3+MNtNHwvKU+xVuc8dbVnVJALD9SGIg6aHQ==
X-Received: by 2002:a05:6000:43c6:10b0:3a8:2f65:3745 with SMTP id ffacd0b85a97d-3b60e523b07mr4058374f8f.51.1752758034621;
        Thu, 17 Jul 2025 06:13:54 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:9e61:4694:c621:5693])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc201asm20565852f8f.22.2025.07.17.06.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 06:13:54 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Andrea della Porta <andrea.porta@suse.com>,
	Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [RESEND PATCH] pinctrl: rp1: use new GPIO line value setter callbacks
Date: Thu, 17 Jul 2025 15:13:49 +0200
Message-ID: <20250717131349.54074-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

struct gpio_chip now has callbacks for setting line values that return
an integer, allowing to indicate failures. Convert the driver to using
them.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
Resending with linux-gpio correctly in Cc.

Another driver we missed, that should be the last one under
drivers/pinctrl/.

 drivers/pinctrl/pinctrl-rp1.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-rp1.c b/drivers/pinctrl/pinctrl-rp1.c
index d300f28c52cd..6080b57a5d87 100644
--- a/drivers/pinctrl/pinctrl-rp1.c
+++ b/drivers/pinctrl/pinctrl-rp1.c
@@ -779,12 +779,14 @@ static int rp1_gpio_get(struct gpio_chip *chip, unsigned int offset)
 	return ret;
 }
 
-static void rp1_gpio_set(struct gpio_chip *chip, unsigned int offset, int value)
+static int rp1_gpio_set(struct gpio_chip *chip, unsigned int offset, int value)
 {
 	struct rp1_pin_info *pin = rp1_get_pin(chip, offset);
 
 	if (pin)
 		rp1_set_value(pin, value);
+
+	return 0;
 }
 
 static int rp1_gpio_get_direction(struct gpio_chip *chip, unsigned int offset)
@@ -849,7 +851,7 @@ static const struct gpio_chip rp1_gpio_chip = {
 	.direction_output = rp1_gpio_direction_output,
 	.get_direction = rp1_gpio_get_direction,
 	.get = rp1_gpio_get,
-	.set = rp1_gpio_set,
+	.set_rv = rp1_gpio_set,
 	.base = -1,
 	.set_config = rp1_gpio_set_config,
 	.ngpio = RP1_NUM_GPIOS,
-- 
2.48.1


