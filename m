Return-Path: <linux-kernel+bounces-848684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC69BCE561
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 21:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 151504EF156
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 19:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E890F301006;
	Fri, 10 Oct 2025 19:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FV+7V9eB"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068CC21FF4A
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 19:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760123467; cv=none; b=jQPLMUbYEjeVMXFf/hQkUVKokqDOn/4fQzV2Kpk3zzPbT3PTe+hVvBZGGYCUYsxSaMp6ApJPUewr1rIIbYNccmQfrTfMmAtNC7XwWH66UbqRR5zfDsvQWBXiadqbKvRgwiPbSdZaP373jeZQ6ebgiWwICZMWPS7GUJtvydjm+uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760123467; c=relaxed/simple;
	bh=D46Tb12nmUmndhtqFCfahDJvapdpQA7Xdz9pjuL8Y7o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AW5P/Weo+LHM61cA0yB9zQYSpuwf4QyAvjuFhLJ0vk0psnnvukCCDqRNs7JJvnbRL/xe1VQvsXKNpjt3BGFvukwiEuS54RMPY1p4T4ygct9AR2GlAaJmuVCQCpbTycIm0JZe2tfet2tpUXungbQdjV4kh2G7yy6k2FrYNpO/biM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FV+7V9eB; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-781db5068b8so2076459b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 12:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760123463; x=1760728263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+U0Y94PCfWWUoXrVPKAH49E0+Bg479gJuRHep4at91M=;
        b=FV+7V9eBqH0IGz/F9Py+kc2hZ3mtdjgY9dhYxUu7k73zCxYz3X3Wyj6LHD8qewNCzx
         qFP5kwQbbBzGrcJ2lliBt71ifTbYMEL2odmjD6TekICJUMUymrP23tDbv3FhkVGU+W0Q
         UvhrKcGyJjuZlf3ATKkVgWXbYm3y2tHplUog8DenDA7fPFnwjlFbgznBCTAvxFcBH6p3
         gTocgWAXkLQhPuxQJLrrnAL3A7c1Jg+vMFBD+Om+kAx1TLLngzoYYIC3jZE1jN/kWZ9K
         JPFm/8hT/0mzIOla1/dJBzELBQcfJuFTi2JHm7KdRPoMZ6ootlgKOpL6qmz75ENBBFm6
         V36A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760123463; x=1760728263;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+U0Y94PCfWWUoXrVPKAH49E0+Bg479gJuRHep4at91M=;
        b=gJjq8BJoubRl1NYOWZagXdfWralamXrCDvgJIcsySVvGH91OvcLjD3BbbUGl8AmJKY
         01f7Kg1pgG4rhbVbmHJSzekjdVyg62BOBFzxiSHx2zxq8LFdBa672EEZGxM4nNjq+XXQ
         c7txdMcI9qovAxeClv3wB9rs+0Tb0C0P0OgIUScFfueg40mWcojcwb30D1tCRQuJW821
         1Fz3TaxOjTkg2ugGYtbM0Uxn/OW2O02O1566xgljO8IzI2rXibeOnRKg+HOTI3Q7brm5
         WZn5/QGeZQ394bEhMP8omuItBeZxmwUi0XoXa5X1afP85hLLMvA7FRpToS7bTwmlIkZU
         yQ7w==
X-Forwarded-Encrypted: i=1; AJvYcCWttSLhY9PcQZCrW1JdmCyuWLtxGmpAwELEPXUfLAq0cfggx6+PXZ28+WJe/3Raj2WRolvwa6hE90vXVmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2oMy5XZ9NG3JZvkBaPPEke/LNS8/1iMSKVCs64uHTx6yIGxBZ
	J8CTqujwDOoyhbvzR0NBj079TG9ahr06cxgPCpo5slYJx6i8z9uzct9u
X-Gm-Gg: ASbGncsHFKsNY7Wjmv+WMw4WaWNH1UmzAer0RyFzeAgoQJEDglmetgP+CCFSBHxsOam
	Roj6DzbfDXATyI5Pg41ymCrN4H4i2YaQ1vSEYvoaynkpuzhdBIjX7ono5XT/AEyRB/X4ZQ/9sxU
	iX/lgNaaUdj6fIuK2Vim3cJFB2WwjNN/i0uw6/x1RwDTEhBHF9aEMvN8a5vNbil2qKdgVQ9Dx2i
	iQxuX/2gmm9SSdTXkjiwG09GWX+6U9vkPsteEo8WEACqlwU1iEzVz721HvhJtESihFCogHqGoJ3
	zIYhqHhcQWXQDAStDBm3bh/QyZnwQ2HjylDcZoZfj71YiAA4VRg6WBc42TQc1rKKnXG2m7esEJH
	ec9zG4EDP8tvhpXutHPqchWi4ruc8sdYBPKbgEov7xgP0swTi9aVfZGjobsxSqwI3
X-Google-Smtp-Source: AGHT+IFN5WjIYZZRb/4TngbfzeAJu9kbhU7Ke04fdJ3b0HKiaP9SE5AjXmpdtHtn0LFsJ06yZYxEiQ==
X-Received: by 2002:a05:6a00:1146:b0:77f:472b:bc73 with SMTP id d2e1a72fcca58-793859f31cemr16464830b3a.6.1760123462963;
        Fri, 10 Oct 2025 12:11:02 -0700 (PDT)
Received: from localhost.localdomain ([2804:14d:4c64:860f:5abf:20b2:7217:3f90])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d5b8672sm3717462b3a.69.2025.10.10.12.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 12:11:02 -0700 (PDT)
From: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
To: lanzano.alex@gmail.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: ~lkcamp/patches@lists.sr.ht,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: imu: bmi270: fix dev_err_probe error msg
Date: Fri, 10 Oct 2025 16:06:46 -0300
Message-ID: <20251010191055.28708-1-rodrigo.gobbi.7@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bmi270 can be connected to I2C or a SPI interface. If it is a SPI,
during probe, if devm_regmap_init() fails, it should print the "spi"
term rather "i2c".

Signed-off-by: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
---
Just fixing this little "typo", definitely it was copied from the bmi270_i2c.c [1],
which has the same dev_err_probe logic.
Tks and regards.

[1] https://github.com/torvalds/linux/blob/master/drivers/iio/imu/bmi270/bmi270_i2c.c#L30
---
 drivers/iio/imu/bmi270/bmi270_spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/imu/bmi270/bmi270_spi.c b/drivers/iio/imu/bmi270/bmi270_spi.c
index 19dd7734f9d0..5e625586681d 100644
--- a/drivers/iio/imu/bmi270/bmi270_spi.c
+++ b/drivers/iio/imu/bmi270/bmi270_spi.c
@@ -60,7 +60,7 @@ static int bmi270_spi_probe(struct spi_device *spi)
 				  &bmi270_spi_regmap_config);
 	if (IS_ERR(regmap))
 		return dev_err_probe(dev, PTR_ERR(regmap),
-				     "Failed to init i2c regmap");
+				     "Failed to init spi regmap");
 
 	return bmi270_core_probe(dev, regmap, chip_info);
 }
-- 
2.48.1


