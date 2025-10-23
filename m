Return-Path: <linux-kernel+bounces-867517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A8DCBC02D31
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 20:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D535D4E74F8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 18:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD0234CFA1;
	Thu, 23 Oct 2025 17:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="VeF21GZH"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788A334C155
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 17:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761242375; cv=none; b=b+hCAIu0Jitj9C7JHlQCUJKZVmaXKC6v0UpzWCwlrfz8/mqjJ3NUq8X312JqQMSHokliwlNZA7Kf8hQPPw8NZukWS53J/PP+ZlTr0p/pK1pEm+BeGgaVwF9WPyboAtZl4LjzQvXBZBWC7Vh3Rk7A13lfjISDizHj1lzm+TvVuO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761242375; c=relaxed/simple;
	bh=dnCGB01wbbXE+/x5ZL+8+es/jtlarQfWqAKWcy4NrUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M/r8V6sx444lnKBVbO8LjuSfqoeigQ+E1Uzsiv01nbs74X7W6k8LSHRj7HeXpwO9GNuIHWudxFRaeKh0ee0m7lpgzWimjCGDfhqI9XBHJdFf7P1L6r+DsLsrgqtW2dejqzjdraLjZmOMZnIi2+BQ0ApQufPtKu44B9HAxZj1Enc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=VeF21GZH; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-33d28dbced5so1514875a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1761242372; x=1761847172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0LXU+r3p2H3OLM8MjqTR3TSPttnWfeamJ354G5+nCPs=;
        b=VeF21GZHrvGrqn7Ab+JECtK4KWMMiOyR05c5bP9ZAc0pe+QwmOdIMJ2ykjuL9qaYSV
         XFD1z7e0qQDy+a7ss1RwIzf9CkmffG8QtbXxzsYyus/yn/rOnZrNNCKCQ1IsHsSzOyLU
         k5RILfoqD82aU1w0pVA2Ys5HXm1Dy5Nw9oEHVqZzFajf3n96dDj0EKm+vkZnjC+rk9vM
         ToLExNrE8o4uFQIgDysKqFI60NtqOx7q7Y6ebMzLxHssDmh0nbLyIBNWuKTf7DQYzdxK
         xkC/VIbL0JvMZc2i6UQI+193gFEqjQWZ39R/mkB4T5aSNj5fNctCBdEPCVxcsSXlV4TU
         g0sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761242372; x=1761847172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0LXU+r3p2H3OLM8MjqTR3TSPttnWfeamJ354G5+nCPs=;
        b=vaJ37x/GvkMr8RbRB8SiXuxfnHmkzMrloRij9BG5rAtLp3wJRQ6HwjIIWWHVAYvOSK
         lDti27Gw3a/+Y0gvdT8VVzy6w0yp48kz/UgZeQBcDY7Xf3wDVaQ7ryyaOlALwdJT7L2E
         l34RySaipvpEFXmoOmV2Ospu52gkhv+qWeTJwoW10v0e0nldM5/fBBe8qyObnzK03K39
         V1D1S/y6GNjnfBhg6daf2uvhBy5/kO8OAQXHH22n41bO2RVo8WSJjEg1I+I0uMfvX2u1
         Ngyw3vzhRbNvcQby//EgcdO1cBV/z5mk5i7gBAkPeUpw4X7Jue+DFb0KkQywD0XRbL2l
         BdRw==
X-Forwarded-Encrypted: i=1; AJvYcCUBFmKG7h4JaVcfnuNc/X63bSQtnM5J5T9UItsZxAiV7UiJRJFMbOPmpo3+V5zBBhcjMiZBTlqInBZ46rw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDz7vBZi2ThHRRWKrzLsbDpWaOouD5nChXVKjUCgdDHZF25jvJ
	+d/z+32UbpESYIJ4uqAo2jrOB7y44caXjFPaZjvjCqYdhNuMrFeSBDx708hAiVOuBI4=
X-Gm-Gg: ASbGncufolnTQ+XKvwbuKPsEX3X6XkqLn6zoslNQ9JROWQW0X9p3l3Lw5FGByLYrmiy
	u+z7XZsVl/djZ91F8jOXFPES4Oc10498GiPnjJhxhOJ9AAIEUkGU8+uTNFVV/Ce0oZ2XBIaz7V0
	5/JpIN+svQMu8fhjt49nCUiTsbuLjpb48IFq/cxqVDL+jXjnUU/20LQlynVifU0Z+hbWUcWnoX6
	4pS7UW5GFZJp+I85pNX/Hh2QjN5jiv007Yr7ik5mrl8KpQtVBrNK9kiSUPmamI0Om54aO+2YNVh
	WHg+CTrUp5enxVEn6Li79+sGyeQG/psAZo0vJf480Qdb+aEJYFPS447qXyAmlCSUsY4oiroAnxa
	1HsU0WepLGznIP2KEZf5Ark0AYIHGiJ87lnNErqttRcUdWevKaM1la/uHTrJwYVeoxbCXrki4Cn
	auDB5Dgbh3FlbYv1zIq7GaBl6zFyZ8Ny+SnQ==
X-Google-Smtp-Source: AGHT+IEF41yHnh/Q9tj7kOyP7EkFl0s2frDdTCHx9ucShzUXPPZ2GVIgbE/DpmewAxUbKZPk9NMitQ==
X-Received: by 2002:a17:90b:1dcb:b0:33b:b033:d7e5 with SMTP id 98e67ed59e1d1-33bcf9186f0mr36102913a91.35.1761242371953;
        Thu, 23 Oct 2025 10:59:31 -0700 (PDT)
Received: from zoltan.localdomain ([208.115.86.150])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e223d1265sm6447431a91.3.2025.10.23.10.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 10:59:31 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: han.xu@nxp.com,
	broonie@kernel.org
Cc: dlan@gentoo.org,
	Frank.li@nxp.com,
	guodong@riscstar.com,
	linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/9] spi: fsl-qspi: allot 1KB per chip
Date: Thu, 23 Oct 2025 12:59:18 -0500
Message-ID: <20251023175922.528868-7-elder@riscstar.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251023175922.528868-1-elder@riscstar.com>
References: <20251023175922.528868-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In fsl_qspi_default_setup(), four registers define the size of blocks of
data to written to each of four chips that comprise SPI NOR flash storage.
They are currently defined to be the same as the AHB buffer size (which is
always 1KB).

The SpacemiT QSPI has an AHB buffer size of 512 bytes, but requires these
four sizes to be multiples of 1024 bytes.

Define a new field sfa_size in the fsl_qspi_devtype_data structure that, if
non-zero, will be used instead of the AHB buffer size to define the size of
these chip regions.

Signed-off-by: Alex Elder <elder@riscstar.com>
---
v2: - New field fsl_qspi_devtype_data->sfa_size now defines the size of
       the serial flash regions if it's non-zero

 drivers/spi/spi-fsl-qspi.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c
index c21e3804cb032..a474d1b341b6a 100644
--- a/drivers/spi/spi-fsl-qspi.c
+++ b/drivers/spi/spi-fsl-qspi.c
@@ -207,6 +207,7 @@ struct fsl_qspi_devtype_data {
 	unsigned int txfifo;
 	int invalid_mstrid;
 	unsigned int ahb_buf_size;
+	unsigned int sfa_size;
 	unsigned int quirks;
 	bool little_endian;
 };
@@ -737,6 +738,7 @@ static int fsl_qspi_default_setup(struct fsl_qspi *q)
 {
 	void __iomem *base = q->iobase;
 	u32 reg, addr_offset = 0;
+	u32 size;
 	int ret;
 
 	/* disable and unprepare clock to avoid glitch pass to controller */
@@ -795,17 +797,17 @@ static int fsl_qspi_default_setup(struct fsl_qspi *q)
 	 * In HW there can be a maximum of four chips on two buses with
 	 * two chip selects on each bus. We use four chip selects in SW
 	 * to differentiate between the four chips.
-	 * We use ahb_buf_size for each chip and set SFA1AD, SFA2AD, SFB1AD,
-	 * SFB2AD accordingly.
+	 *
+	 * By default we write the AHB buffer size to each chip, but
+	 * a different size can be specified with devtype_data->sfa_size.
+	 * The SFA1AD, SFA2AD, SFB1AD, and SFB2AD registers define the
+	 * top (end) of these four regions.
 	 */
-	qspi_writel(q, q->devtype_data->ahb_buf_size + addr_offset,
-		    base + QUADSPI_SFA1AD);
-	qspi_writel(q, q->devtype_data->ahb_buf_size * 2 + addr_offset,
-		    base + QUADSPI_SFA2AD);
-	qspi_writel(q, q->devtype_data->ahb_buf_size * 3 + addr_offset,
-		    base + QUADSPI_SFB1AD);
-	qspi_writel(q, q->devtype_data->ahb_buf_size * 4 + addr_offset,
-		    base + QUADSPI_SFB2AD);
+	size = q->devtype_data->sfa_size ? : q->devtype_data->ahb_buf_size;
+	qspi_writel(q, addr_offset + 1 * size, base + QUADSPI_SFA1AD);
+	qspi_writel(q, addr_offset + 2 * size, base + QUADSPI_SFA2AD);
+	qspi_writel(q, addr_offset + 3 * size, base + QUADSPI_SFB1AD);
+	qspi_writel(q, addr_offset + 4 * size, base + QUADSPI_SFB2AD);
 
 	q->selected = -1;
 
-- 
2.43.0


