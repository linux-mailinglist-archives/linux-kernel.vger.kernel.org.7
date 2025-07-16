Return-Path: <linux-kernel+bounces-733891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E70E3B07A49
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 17:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE521189335B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 15:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60DA62EA14E;
	Wed, 16 Jul 2025 15:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KFBA4PxH"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13C32EF646;
	Wed, 16 Jul 2025 15:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752680896; cv=none; b=vAsoSQQ8+oh2m3ABBnSAVPyO7BJDh7FMMkXfnZIKwRBLMPE6hhIRUakJzYx5K7/8S+l8SGiez/LVvda8K082CNWNkqXo8+gkKOMaGmS4T7iHDG7tVG4zgn2/lJtBBHr00cuUyve0pklmY6lJhgEfJJKjNUoBJ1OVO5M/LsplNWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752680896; c=relaxed/simple;
	bh=GOkZ+kxSzALlySorLSCA6cXsPChjBJFPrqHDc+rhD6A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A/VavQlXxqUa2E6GoaRQtUWNJePqXSJi19L2Cjd+s0gXwMH4IRYuuZsQbk/F7+799astQqB0hSOgStT8FSqGXwN4uCDnYI7GZesZwoLNTYtTWdF+KJJGa5xDp2A9ge44KztoDsPkb3XUGmPxQnWeyMX5WgVGiS44qY9hoBUgSvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KFBA4PxH; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-60c5b7cae8bso10936349a12.1;
        Wed, 16 Jul 2025 08:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752680893; x=1753285693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lKjVbstUaXUkfpWGZfi4yqhbObtoazSimLO3Mc4PdaA=;
        b=KFBA4PxHxSHdlTsfkV/U33yuR/IbUe30pCqbnw/BznE18+oRZ5gJQSHVb9ZOJV3I9X
         9KEZo7YU7uJebjCQjQYwUT6b9jackx6Ld7oDhry0DxOa6+nNrdA4M7TUL5oEMPiOPrzI
         jrAPYjdZx8dVUrRI6YRr9fYOv9/TCSRlKe8qwCBX95wqgjMFahlZondjQcYLbfkuTTpT
         caX8Efg9G1RaUIbWaKqUROhR5bMrhs2pLvpuF46iF18o29fI+a5qik6vubgyrlPvpYWK
         i3MQU4Y4nQbjNylK59p9ypj58CGswj2/2VzZDbNVC8edG+tr2ESEPlmAzwpr2Zk9I0Mk
         tlhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752680893; x=1753285693;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lKjVbstUaXUkfpWGZfi4yqhbObtoazSimLO3Mc4PdaA=;
        b=PEE4jPKVw/antCrL76KAlRauxVQAb9O9gBWdKNeaV508siRr9vRe2JJ3nP9pqqiOYa
         4BflxR0ixHV7M37oTVBV2MZX2fljZM+1gv76Xp1UXmLQbxes9ELh8UlvmGNZjIGWw4B9
         tkA/2ISPO4o0hNTGz655vDcHpwdssWmdhjzrMPakfDiXMLQyQobwW0xTSoXgSAmKdyg4
         zeCW6kGOeUa4f3y6O0/f76R+cadkHtKaGChYfhHMnRSj/MNOocZ2tzh5k0AGGy3qG04Y
         BNJSzzBApJffD6EuwOFd2a95WCeedOLoyl1a0KptPflP8xDXKpt2RsptMFUdpL2+9ARh
         GmlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJe9vv04CiGEPsrEaXuXx4weYLL46VG66mUGR3XAzNWQvSz1BOe1PYDTGZ9IcM5xzTPrKLe7y3YP9zZcol@vger.kernel.org, AJvYcCXrtYnRZZWWxmj948aQZfc0MvPsoI/6ZSAhGaVrp2BO0ZUXnSbkRAp+1dnattMSoXpl1hGf5Saw+Wdy@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp1Dc55PWpMZTwNuyg3P5uDQ7r4HrAUEMiqmUBiSBApdBdLZre
	+P5vJHSK2nPuXAPqxAGJe5Z5Kv/DvAdCiMZaIE2vRNqztRgnedUhiR2e
X-Gm-Gg: ASbGnctmVWvUSwG66nGvoR2T5AodRTfB4HGz0g39HZ0uyoKGPuq8EsDOE50LSvORcHq
	iCXasukUHLQh70ywE/Fh91vsHPI3Iz5qWTpZiwQxPLSJ3kZidZhBfj0PHucTjgJZGLxm2ReEPnw
	pKqic54k9TMRgTBR5DEFTJGJORqDee1Hhhikvr8Jrbnr2qoeGs8V6q9AABBHpP413kPfRbTEkhJ
	XhWraRjdSzubxTbEC1BfUgTEhenk+6RVWBihqav0yfgtYVXrJ80SJuD5kqOzI6O2CCFy8BEXY/4
	oZ/0mGWa5hPEKiyoqLuPmydX5UDSyyP9a/K00iXRYX/SqR5MKU1u2SbWa8e24+bbNoTJBnWawLn
	gIrXMawRsVTuLFgmsbxNCOGMYHA==
X-Google-Smtp-Source: AGHT+IFex17gwksYmEfwRekLYMBaX4AofLHIu+ZY9di4Kvn6YVkKnhCVyoBbL95UX6lWR4Ue7UJ9Pg==
X-Received: by 2002:a17:907:d24:b0:ae2:9291:9226 with SMTP id a640c23a62f3a-ae9ce1e71b1mr337656766b.59.1752680892887;
        Wed, 16 Jul 2025 08:48:12 -0700 (PDT)
Received: from wslxew242.. ([188.193.103.108])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e8293fe7sm1196705266b.123.2025.07.16.08.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 08:48:12 -0700 (PDT)
From: =?UTF-8?q?Goran=20Ra=C4=91enovi=C4=87?= <goran.radni@gmail.com>
To: Frank.li@nxp.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	boerge.struempfel@gmail.com,
	s.hauer@pengutronix.de,
	festevam@gmail.com
Cc: =?UTF-8?q?Goran=20Ra=C4=91enovi=C4=87?= <goran.radni@gmail.com>,
	kernel@pengutronix.de,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 0/3] arm64: dts: Add support for Ultratronik i.MX8MP Ultra-MACH SBC
Date: Wed, 16 Jul 2025 17:48:03 +0200
Message-ID: <20250716154808.335138-1-goran.radni@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch series adds support for the Ultratronik i.MX8MP-based Ultra-MACH SBC.

The Ultra-MACH SBC is an industrial-grade single-board computer based on the NXP i.MX8M Plus SoC. This initial support includes:

- Updating the MAINTAINERS file to include the new board in the Ultratronik support section.
- Adding a compatible string entry for the board to `fsl.yaml` in device tree bindings.
- Introducing a new device tree source file `imx8mp-ultra-mach-sbc.dts` with basic hardware support.

This series is modeled after the support added for the STM32MP157C-based Ultra-FLY SBC and aims to follow the conventions used for other i.MX8MP boards in mainline..

Changes in v2:
  - Use `enum` with `const:` values in fsl.yaml to correctly represent multiple compatibles.
  - Updated SPI child node name to use the generic `nfc-transceiver` per DT naming conventions.
  - Renamed several peripheral nodes (`crypto@35`, `pmic@25`, etc.) to standard names.
  - Minor formatting cleanup and compliance fixes per review feedback.

Changes in v3:
- Added "ultratronik,imx8mp-ultra-mach-sbc" to the shared i.MX8MP enum block in `fsl.yaml` [1].
- Ensured the compatible entry is validated by the existing binding structure.
- Updated `imx8mp-ultra-mach-sbc.dts` to address review feedback from v2 [2], including:
  - Proper formatting and indentation fixes.
  - Cleaned up node ordering and property alignment.

Changes in v4:
  - Moved `status = "okay";` to the last property in the TPM node.
  - Fixed indentation of `cs-gpios` multi-line property in the ecspi2 node.
  - Removed an outdated comment.

Changes in v5:

  - Reordered and grouped pinctrl-names and pinctrl-0 at the top of nodes for consistency.
  - Removed redundant status = "okay"; from TPM and NFC nodes, as their parent nodes already enable them.
  - Inserted required newlines between properties and child nodes (e.g., in ports {} block).
  - Cleaned up minor formatting and property order issues in regulator and gpio-leds nodes.

No functional changes otherwise. Patch series is based on feedback from Frank Li, Krzysztof Kozlowski and Shawn Guo.

Thanks for the reviews!

Link to v2 DT binding discussion:
[1] https://lore.kernel.org/all/578ea477-c68c-4427-8013-550bf4f9c05b@kernel.org/#t

Link to v2 DTS review:
[2] https://lore.kernel.org/all/aEmh7VL7BHkXp5Fu@lizhi-Precision-Tower-5810/

The board is based on NXP's i.MX8MP SoC and includes eMMC, LPDDR4, USB-C, Ethernet, and HDMI.

Tested with:
- `make ARCH=arm64 dtbs_check` (passes)
- Boot tested on hardware

Best regards,  
Goran Rađenović


Goran Rađenović (3):
  MAINTAINERS: Add i.MX8MP Ultra-MACH SBC to ULTRATRONIK BOARD SUPPORT
  dt-bindings: arm: imx8mp: Add Ultratronik Ultra-MACH SBC
  arm64: dts: imx8mp: Add initial support for Ultratronik
    imx8mp-ultra-mach-sbc board

 .../devicetree/bindings/arm/fsl.yaml          |   1 +
 MAINTAINERS                                   |   1 +
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../dts/freescale/imx8mp-ultra-mach-sbc.dts   | 907 ++++++++++++++++++
 4 files changed, 910 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-ultra-mach-sbc.dts


base-commit: 155a3c003e555a7300d156a5252c004c392ec6b0
-- 
2.43.0


