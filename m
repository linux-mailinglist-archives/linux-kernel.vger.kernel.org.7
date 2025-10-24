Return-Path: <linux-kernel+bounces-869428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 46415C07DD1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 21:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E32244E3B9E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 19:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C946B36B961;
	Fri, 24 Oct 2025 19:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="FA0uE7G4"
Received: from mail-il1-f194.google.com (mail-il1-f194.google.com [209.85.166.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEFC36A5F8
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 19:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761333358; cv=none; b=h0fUkF2BBiBBP0GiR797QiTP6X+kDEreH1YPbjW6WPvmqPz1NtqlFVRQGS8cSlFbTexLIihS2Pbs8epMOydVLF7n5yMrXvKVG7xZ+n8/Gmqbe7Fpex7yaZ4VxdSu3VDVHva3zSQY+Wwow66dx8Q/cPlXV/0giYKAcQo+s04toIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761333358; c=relaxed/simple;
	bh=pYEC/hTDDpoyfVbfoYHFpH0exPsJY0khjjaveQnHtzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=diL/gRKcf4/j0+YWi1JF6UOMYzx9Lz45C4U8/PJmyPNIUlqYrd5GFMYzIHQecwByo4GHKYA/nDCMFjpuajowN4Ji3OG97HmJUe/KAl/P2fvcNMVN7Z7ZTSvTodjn4u/ZPrmrb6H5vmPFNMyW1T/ztruflM0FxcokAxjckoK4BcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=FA0uE7G4; arc=none smtp.client-ip=209.85.166.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-il1-f194.google.com with SMTP id e9e14a558f8ab-430d0d37fd7so12030285ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 12:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1761333355; x=1761938155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5hqIIxYoJfbzcFUkevnIvDyYXIbJhiiIxZ4aEshcKOg=;
        b=FA0uE7G4uBaE1x4q+5S28JrSi2UrKzWJ609Ni40Wb+NwKgNm9oBPQdQpXle5FngFUn
         PVBWqZePgLN5OWAHkHnLYAKFy6DPYy+uURjW2QpyV8V7UgGwUGiq3oDoEuDGHqvGmXPa
         A27bh5f0xXnpEqIzFuqazSYmu/eM4tiGZb1GS2gHv1Muz1RtLmVMqzNd5Cttt84+1o2c
         Ms8uur4vm94K3ZzQVEOUXPHfix7cRpm8ilE6O4EKYiJ8c0/0qT2dwLk2C3I5kohDNP9d
         MEpg2cpwU5YURBbyOCbToQWpppGcR06jst1b9cE3k7bpmG2IIzmzill1vvw8ksToyEZS
         y4Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761333355; x=1761938155;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5hqIIxYoJfbzcFUkevnIvDyYXIbJhiiIxZ4aEshcKOg=;
        b=uDAqOIh70YthOrYQk6MA99Ct/hZzzztS2DR+sxZsiyl/Tul4X424obRASRjnfldyHC
         2Dy1RTRGjW1W6Lk+8xTpfyeM+RRAa1fYvCmHhrzsHkUL3TR+gor5fNfVugpLD1gj6unq
         BgtnQ35yOjwYN8OAoqQRByjAtd3KWAzSOX6Bg1t5ugr4bpYdPFWXRchhFEA/cVdUDgSw
         HcncjhjapwmG3QwOcDtudgIrzxCevMRZbe+anQsceXAexyY9d2BeigJf/upaz9F8Wzpj
         JGw6C7ZLtICT4v76HjklQu0/WsMGilwouVoRU8Z00Ces6mCQ+0idX4FVMTHE8FGkDRfj
         V8Nw==
X-Forwarded-Encrypted: i=1; AJvYcCWrQhyU9/wMvFSnXVCoZ7D0YIGWvywFwGb5As1GwhP7dm6ADLG/NyX+n/rGOGkqjRa+BCo1NvjtD3pHwtU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH+0jmvd6ccCaGd+nVWdQsvubwHkzer5yaSxmObKuHQ+6fOqRB
	uEcpsOdJuYwua/utqiXdsr7OPKmKHmkgkw4uVG3AkEJhCev2U+RhEkGs+B22LloE6Zw=
X-Gm-Gg: ASbGnctpNT90XFlztcXvnQ1YBxS0NjYZVy94PkxUD8XCYds6Telvj6RvfFtcDJ/ArrI
	tphCh2LgGo1LxXTISitHpqSgl93nakfVbTUA3o61NxC5QTnxQei4CstV3fcvt+v1pww3lxAT+NN
	Xgj8cCgd1m5Rh/eg1RtCxDwGmBMZ78iOZiv1TtfLTVjLBcZ40qXH0lCpcTZVUMH7jpKxXwaD1A+
	URDZUN3QIE5/ARHo35DVITd1DxjdMkivnbkZT1Q40qNxoyhI6lHwr2a7BDOmom9O9QsKFRfkj0a
	3snVYGrlNU9EKzjypy5/XFOcE8GTGCb6IhK/Es65fZxRlpLVuDO6uvcHP6bX65lQRXiM51pjKfN
	4vPaKtAuR2wL5prLwrKpWQt77btZ/fop0jt9dj3eCEH7JI9kEfGjIcWD6CzEpKe2fcFizuhXTE1
	t7JvfhsiRApeCvRmCqK+vQKc1nSw9w2huMKoTQAru6Jllawy6/TLeJew==
X-Google-Smtp-Source: AGHT+IFf6y19COM4VMTPijjo8N/XwohbmjTEdQxUdhW3R9LdR2ndKIPLgXKS2XAlzSenv51Gg++n7g==
X-Received: by 2002:a05:6e02:2502:b0:431:d678:fcb with SMTP id e9e14a558f8ab-431eb668375mr53003245ab.9.1761333354916;
        Fri, 24 Oct 2025 12:15:54 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5abb7fdb7c7sm2427824173.44.2025.10.24.12.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 12:15:54 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	han.xu@nxp.com,
	broonie@kernel.org,
	dlan@gentoo.org,
	pjw@kernel.org
Cc: Frank.li@nxp.com,
	p.zabel@pengutronix.de,
	guodong@riscstar.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	apatel@ventanamicro.com,
	joel@jms.id.au,
	geert+renesas@glider.be,
	cyy@cyyself.name,
	heylenay@4d2.org,
	conor.dooley@microchip.com,
	fustini@kernel.org,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/9] spi: enable the SpacemiT K1 SoC QSPI
Date: Fri, 24 Oct 2025 14:15:40 -0500
Message-ID: <20251024191550.194946-1-elder@riscstar.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds support for the SpacemiT K1 SoC QSPI.  This IP is
generally compatible with the Freescale QSPI driver, requiring three
minor changes to enable it to be supported.  The changes are:
  - Adding support for optional resets
  - Having the clock *not* be disabled when changing its rate
  - Allowing the size of storage blocks written to flash chips
    to be set to something different from the AHB buffer size

This version of the series addresses comments received in review of
version 2.

					-Alex

This series is available here:
  https://github.com/riscstar/linux/tree/outgoing/qspi-v3
  
Version 3 addresses comments recieved during review of v2:
  - This version fully tested and confirmed to work on BPI-F3
  - Added Acked-by from Conor on patches 1 and 2
  - Added Reviewed-by from Frank on patches 1 and 6
  - Moved the reset property conditional under allOf in the binding
  - In patch 5, needs_clk_disable() is no longer inline
  - Tweaked the description in patch 5
  - Renamed a local variable to be "sfa_size" in patch 6
  - Changed the subject line in patch 6
  - The sfa_size field was not being assigned in spacemit_k1_data;
    now it is set to SZ_1K

Here is version 2:
  https://lore.kernel.org/lkml/20251023175922.528868-1-elder@riscstar.com/

Version 2 addresses comments recieved during review of v1:
  - The "reset" property now only applies to spacemit,k1-qspi compatible.
  - Patch 1 (previously patch 2) now points out that this is the first
    non-Freescale device using the binding.
  - Added Frank Li's Reviewed-by on patch 3.
  - A quirk flag has been renamed to be QUADSPI_QUIRK_SKIP_CLK_DISABLE.
  - The predicate for that quirk now returns bool type.
  - All other similar predicates now return bool type; this is done in a
    new patch (patch 4).
  - If non-zero, new field fsl_qspi_devtype_data->sfa_size defines the
    size of the serial flash regions, rather than ahb_buf_size.
  - A continued line in the Kconfig is now aligned.
  - Patch descriptions are wrapped at 75 columns.

Here is version 1:
  https://lore.kernel.org/lkml/20251020165152.666221-1-elder@riscstar.com/


Alex Elder (9):
  dt-bindings: spi: fsl-qspi: support SpacemiT K1
  dt-bindings: spi: fsl-qspi: add optional resets
  spi: fsl-qspi: add optional reset support
  spi: fsl-qspi: switch predicates to bool
  spi: fsl-qspi: add a clock disable quirk
  spi: fsl-qspi: introduce sfa_size devtype data
  spi: fsl-qspi: support the SpacemiT K1 SoC
  riscv: dts: spacemit: enable K1 SoC QSPI on BPI-F3
  riscv: defconfig: enable SPI_FSL_QUADSPI as a module

 .../bindings/spi/fsl,spi-fsl-qspi.yaml        | 15 ++++
 .../boot/dts/spacemit/k1-bananapi-f3.dts      |  6 ++
 arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi  | 21 +++++
 arch/riscv/boot/dts/spacemit/k1.dtsi          | 16 ++++
 arch/riscv/configs/defconfig                  |  1 +
 drivers/spi/Kconfig                           |  3 +-
 drivers/spi/spi-fsl-qspi.c                    | 88 +++++++++++++------
 7 files changed, 124 insertions(+), 26 deletions(-)


base-commit: 72fb0170ef1f45addf726319c52a0562b6913707
-- 
2.48.1


