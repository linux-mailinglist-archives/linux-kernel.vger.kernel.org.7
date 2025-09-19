Return-Path: <linux-kernel+bounces-825075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33930B8AE25
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 20:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C99B170256
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 18:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64B925393C;
	Fri, 19 Sep 2025 18:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YWINuwhM"
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F624A3E
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 18:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758305797; cv=none; b=VeHtXo3huw0P+Zgi8BmG87Zd1tQ274FGKeZ5fkGI+gKO+XDpfejsmL5EkX/aRzBiHze2MLvooecX3cpxLOxVLLxfZKkdcKtzZ61D/r90Gi8QFheS5ibTABWO7Q2jkf276TBQjjZ+VAQh9qJFF19/CjO+p4GOcMQTMOeSuffcptc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758305797; c=relaxed/simple;
	bh=svB4c4RUB6k6TMO/taqKy8jJHs6qQsb6dPdPQdI21nk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=f2skxN56nCVIRQAb6osiyASrq27LwDxSicK/L9Jsg/mUYwZTL1DTgpOtB/QzXcCnbGOhJ01A2t6SitUSEJIU0EnF6/DpwkTlarD6+jMoPmw4lRM8Jm6gvbyaYYvXjslYNtGNpsXSIbxxvP4xC4IX5DC65uxGCzANoDtmz20sOhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--czapiga.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YWINuwhM; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--czapiga.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-62efab531d8so3393851a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 11:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758305794; x=1758910594; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5mgMxXZc6JsWSisIXu5YKjlUPOflnR0WNH38+RWcea4=;
        b=YWINuwhMarzGUvPo57orz93mG954ydMfwx8z+QtZyGmIHnQ3pnjut6lUj/zxPBOuAA
         QHUQPqnZCiPYEutD9rOksIT5iPsjAYK1kdKOg09DDILVG3tjeAYzq5vqCNpxzleDRObV
         k93wcGuAKvVvlLVbKhguaeKCnoel2Ef9o/573SmC6vEB+Gtgpf0IOTADt/b7vlSgZzvj
         PX6EQ3o8OCMrvnPud8QGGXSmOfa/KGOPGoIuudBWhwR7tGZilJHpBwej7xkQQR1sgJHQ
         veBle8b9A81Qwn+gFR72//4HqBIL0iTHz29oou8gDQpW/FFc/x+67ScMahZQ6LYxwtfg
         SPKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758305794; x=1758910594;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5mgMxXZc6JsWSisIXu5YKjlUPOflnR0WNH38+RWcea4=;
        b=Bz5naI8UwiQIgLrIkW1AHTIJYWv3HE2D2xyYzgBQru2evRYAkGZp/tYILITJoNTo9s
         fH4LqNWPyV1leWMm4aLf5lCNV/ANzYFsl6pZWyHxKDJz4oLwtO9watFpV0zRsTRGhEw5
         e+JPlskK+aThOF2gf+/K7siq+w09hhQYkPofskqflY/+OWMf/cSjaSFrEx8Rl86xxadV
         Qx1PY2v2s84dULTklBM5aAUp6Ni0U0s318GZ4qgh1+bAc88ixWvUC5lOag/cuFfWnGy9
         bEqX9BZpROliqh5riGU8Hb4rNtXjDlq2OZX5EtZ8AfJpfQ4CAH1sJFlDlOkotwCaoveq
         9bDg==
X-Forwarded-Encrypted: i=1; AJvYcCWk94tQ8HDiEo5CDtKvkzKjHiDFMGEEQuaxW60aQf6dm15p1lpDhABMnd1i7za+ZL1hgVJJAQaga0GP7Lw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFhnxm9kZYTKYO1tMIb53OKNOr5WLtMi24rlwIatKIo1b4ndXg
	UVcI8Jl9KKK5yE2jlo6RACK8E7vsL4f+2+8Dht34Ac3re5K8YrhYmp5cKPdllTEJFLCVwyFIm2D
	HeeiXhUwxhQ==
X-Google-Smtp-Source: AGHT+IFBF9Kq0n5zsV/eYossWIuj1G3yQkDPq2/13B/MTXPtyGtmb7OfIX4VaMq0zKbRqqvGUOTUkbhU52En
X-Received: from edbfi21.prod.google.com ([2002:a05:6402:5515:b0:62f:8b99:d116])
 (user=czapiga job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:4586:b0:626:1fce:d2f2
 with SMTP id 4fb4d7f45d1cf-62fc0917f14mr3475109a12.16.1758305793785; Fri, 19
 Sep 2025 11:16:33 -0700 (PDT)
Date: Fri, 19 Sep 2025 18:15:47 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250919181547.2172319-1-czapiga@google.com>
Subject: [PATCH v2] mtd: spi-nor: core: Check read CR support
From: Jakub Czapiga <czapiga@google.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, 
	Vignesh Raghavendra <vigneshr@ti.com>, linux-mtd@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Konrad Adamczyk <konrada@google.com>, 
	Adeel Arshad <adeel.arshad@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Kornel Duleba <korneld@google.com>, Jakub Czapiga <czapiga@google.com>
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
Changes since v1:
- Use spi_nor_spimem_setup_op instead of spi_nor_read_cr to test opcode
- Check only for spi-mem devices
- Move check from spi_nor_setup to spi_nor_spimem_adjust_hwcaps

 drivers/mtd/spi-nor/core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index ac4b960101cc..0c43fcca3d0a 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2318,6 +2318,16 @@ spi_nor_spimem_adjust_hwcaps(struct spi_nor *nor, u32 *hwcaps)
 					    &params->page_programs[ppidx]))
 			*hwcaps &= ~BIT(cap);
 	}
+
+	/* Some SPI controllers might not support CR read opcode. */
+	if (!(nor->flags & SNOR_F_NO_READ_CR)) {
+		struct spi_mem_op op = SPI_NOR_RDCR_OP(nor->bouncebuf);
+
+		spi_nor_spimem_setup_op(nor, &op, nor->reg_proto);
+
+		if (spi_nor_spimem_check_op(nor, &op))
+			nor->flags |= SNOR_F_NO_READ_CR;
+	}
 }
 
 /**
-- 
2.51.0.534.gc79095c0ca-goog


