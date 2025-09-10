Return-Path: <linux-kernel+bounces-809968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D026B5141E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 12:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFFBD189BE29
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 10:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F9F2638BC;
	Wed, 10 Sep 2025 10:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FyOECxT3"
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92158A930
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 10:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757500499; cv=none; b=mlLFpW17UjfGdsP4CaL8CbmnLVxPUfeJ164PWe+6+hx1yay4P4Tgvk7pyU/+xFnThPkSyP4ytvY8lQQV4aUPOlS5568JUjYnfqJfmxDz/P10hAhPYm6HNHrMslE34uN0uF46YvV+w26eac8NYpVd/53XoLsEAnReaYZex1UFtRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757500499; c=relaxed/simple;
	bh=zQjg8LCyE/RfH2yHJ1+N6bVu/W0mBBgSV8h8b2sqlDs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=RXHrNOLTAY6/ZOm4JrUKvjgjRjnC2S2bBM6u9e8uhJlSkIPCzfg0vinWSeb/L0O95wh7MhzBmOLHo7PcoPNUEC7fnop9WaONCURGfl4Ch+H8/TwzemfErhWfK/UYqnCaQlxeoyRduJpuiVvf+TMyBjMP5q1BY1UUnxn7tUKWY38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--czapiga.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FyOECxT3; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--czapiga.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-628f17953c7so4197574a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 03:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757500496; x=1758105296; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KKm0jkbqzCHbQbrD/ZyxopJILHKzxrG8LuPV9nqZYkw=;
        b=FyOECxT38jee8HCP9fsxq4ZNS5tE7xEK3sWtejGMsZIJ1tZWZGVDN7UyQt2T5/LXLT
         4Folx62p9qVy8tFNq4kN1FAIz0T8qMZ/ZAji5KdJ0wUOIMCIjIgwyTXeKgJ4qTaKn63z
         hVD27S4mbRnnWDdV8HHjYG9drnYxFlMUdpMGkgkZxbtosXvHKCuEPX6Ne9Ibeg4FqBQu
         C8BObM+B+WMJSRV/MRSnfbpIqBoxTBk5d6QMWUucQk7MZOzLP/SuQbGpUacP3bgszgUJ
         PooiNUgvbRyHQYCgFhy7kCg5FtnLGaeixu1/0pqonwnCvI5bzRdb6Dv7zd+qVcDK6ty6
         1jGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757500496; x=1758105296;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KKm0jkbqzCHbQbrD/ZyxopJILHKzxrG8LuPV9nqZYkw=;
        b=DwqwpR9FyjdYzsmNQs26oahP3BacqB5tNqwU3A57NIZPQD5Tg7dcuZWNUXOxFTLgR1
         AK5AQIubt4USQuYCWbIn6uwsQTLMFLXAli0FEWzwUuNtmgWimXliiG6y7xlWCqJbHb7u
         9tlOdletzpklcAdUcKttsQj+cVlmXqMhVF0qIcbBfFovpnIUx9v5bM90Yj+aAaWQFlHM
         2zlXgmujUd+X3KiE0TsAyj8XUoI06xXseWRp9CdkjIN4tAB4YkSSHYn86Ln6FRMQfViW
         2Fz4wEAVa8P3nt8ARrmu+RPlygW4ToilcKrinQk1ofQMvzerfpjglh6Zl0CRfV32/F9m
         i2/w==
X-Forwarded-Encrypted: i=1; AJvYcCV+mpXdVYbTX/qT+MvkigIvSfak3lyZcSufNT1Ef3W5ABjbj4WU8OK6qujlVyCQrYixI0rmilDvcm8xa0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9i/UbjbXIRdWuIlwGF8Pwp/MxrUdHRB2zKLOemyQ8Swyq/sF1
	EiXWw1pjMn8Y6Q3fGD78R7Rg030r+dbTz+ncAi+Mf/jlLF0hR47qGELS16HsZLDPKx5v9f7PvIP
	f3b9vRq4jVA==
X-Google-Smtp-Source: AGHT+IGQ3fHbE7naj85CdBuLACoB3D4RZfuFn7hndTTGiUVAlDir42uDdrqa3sGbCVuaMELpPzDXQbYL11XZ
X-Received: from edp3.prod.google.com ([2002:a05:6402:4383:b0:61d:1dd1:5e1b])
 (user=czapiga job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:270d:b0:62c:3878:747
 with SMTP id 4fb4d7f45d1cf-62c38784cc4mr4446625a12.33.1757500495905; Wed, 10
 Sep 2025 03:34:55 -0700 (PDT)
Date: Wed, 10 Sep 2025 10:33:55 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250910103355.629421-1-czapiga@google.com>
Subject: [PATCH] mtd: spi-nor: core: Check read CR support
From: Jakub Czapiga <czapiga@google.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, 
	Vignesh Raghavendra <vigneshr@ti.com>, linux-mtd@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Konrad Adamczyk <konrada@google.com>, 
	Adeel Arshad <adeel.arshad@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Jakub Czapiga <czapiga@google.com>
Content-Type: text/plain; charset="UTF-8"

Some SPI controllers like Intel's one on the PCI bus do not support
opcode 35h. This opcode is used to read the Configuration Register on
SPI-NOR chips that have 16-bit Status Register configured regardless
of the controller support for it. Adding a check call in the setup step
allows disabling use of the 35h opcode and falling back to the manual
Status Registers management.

Before:
openat(AT_FDCWD, "/dev/mtd0", O_RDWR)   = 4
ioctl(4, MIXER_WRITE(6) or MEMUNLOCK, {start=0, length=0x2000000}) = -1
EOPNOTSUPP

After:
openat(AT_FDCWD, "/dev/mtd0", O_RDWR)   = 4
ioctl(4, MIXER_WRITE(6) or MEMUNLOCK, {start=0, length=0x2000000}) = 0
ioctl(4, MIXER_WRITE(5) or MEMLOCK, {start=0x1800000, length=0x800000}) = 0

Suggested-by: Adeel Arshad <adeel.arshad@intel.com>
Signed-off-by: Jakub Czapiga <czapiga@google.com>
---
 drivers/mtd/spi-nor/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index ac4b960101cc..79deee3a50d3 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2608,6 +2608,10 @@ static int spi_nor_setup(struct spi_nor *nor,
 		}
 	}
 
+	/* Some SPI controllers might not support CR read opcode. */
+	if (spi_nor_read_cr(nor, nor->bouncebuf) == -EOPNOTSUPP)
+		nor->flags |= SNOR_F_NO_READ_CR;
+
 	/* Select the (Fast) Read command. */
 	err = spi_nor_select_read(nor, shared_mask);
 	if (err) {
-- 
2.51.0.384.g4c02a37b29-goog


