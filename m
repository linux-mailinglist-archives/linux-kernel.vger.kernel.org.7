Return-Path: <linux-kernel+bounces-730137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B17C3B040A0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F7C218868D6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 13:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D5C253B52;
	Mon, 14 Jul 2025 13:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QBVdIXCj"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FD41EEE0;
	Mon, 14 Jul 2025 13:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752501285; cv=none; b=rCzv9stkxyHb7NU2k9SKJj7GCTL0ap1MdfmBQdvOIjv4nY7YiBTCXJ1vRkW7jWulBETedpbXZaRBggDX5VxHGLSV8EVj/UbpM5A1N0YYTx1WSOrufYUKaSZZvc0pgQWoW6cE0YGOm+Dvfrqg7F2mEFf3VUFreeKNhUlFiYyFgOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752501285; c=relaxed/simple;
	bh=H/Oh3chBUpLzn0eNy+IaizkwixT6SipYXq6A3XVjTHQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TYiz06soWViu7teFU6cfW36gVajdT7ckNg6tNReDF7CjsB4gw+d48rc3oI+rnw9R1LcZzu3raAfZchYkjIwpRgNYVFs8bOWpXRazhr2XL1TdsthepRQaI24TZWNBWSrTpI27hskCMlxalBiIgQdbpjOMs8Vh+5Y5vjOL756WWWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QBVdIXCj; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a54700a463so2412414f8f.1;
        Mon, 14 Jul 2025 06:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752501282; x=1753106082; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sbexDFjpftzRKLUMFsoZCD327x/JPVEAr4KstWx05Qc=;
        b=QBVdIXCjxP6vlrlkmRQh0HH/SixyQ7cCLkAI5M8iZQ2Ak/iZM1f/tdMc5zzdg02EqI
         M9w5+09L3gxKqNd361jmJC1z5o7CQuxer4L8zY2FWB1x81ts0PHrjfWWc88EWg+OEhOP
         ULfCPT1pdq0CdzfDLGkUHnpt3LNUeViQuoj0RioPj1tnTXg3YP2ja2uU7q9+bA54ilL9
         MxmzCfi8eAkPfTrh18RSV1xWseeSeEBd91qH510TmXvr+iWFduLKjrzWeMZ9763VFaoN
         d/W2YEYI67vSbKNp9sZzrJBiJ7DqMFF7bXuZ/esLRBX21z1PqFLINuOiToY2ys4akX5w
         bfBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752501282; x=1753106082;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sbexDFjpftzRKLUMFsoZCD327x/JPVEAr4KstWx05Qc=;
        b=FfRoZ37FXTINeAYPx7CbxnYRrNi5k1kMUZDX1TKBCsor9u1tczg6TQ1aijf7jgwj/3
         i26Shgbhe1q0X0LPzKJsT7RFaSUw6KN5R6kx2VdKnT967MbOkXep49mppFqZ3QWsW9S1
         Rtc4EswhhWeVClATnNAz06+Rs5MP7hKo5wMBszCG8hnR20RxR9egpJQlf3d+1J+DHfTg
         0MeFlUcToso9tlW1vkow/K2wGjzojlbxVgHxjjHG2R3dmr/8FHeyg4H4L68mS00vLLFu
         7YJuA3k439U9xxXdgBteLMsB1ArCtApuLrEyd0PCG45lX87QtreIKA9k/DibO9aTrnor
         RDUA==
X-Forwarded-Encrypted: i=1; AJvYcCWBD808LrWiy/9dLGUZUudqWe+0Z2SVStcCtabXQq7nUeS/jDp2y9hN5hTIASPf9Tz1MXrWutYi/SMGzI4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOm4UCdNFSOPKxtIW20qDKWsyU77w6mXmqu85y/7BIxotfyEUE
	prwb5kXmNf0aMf9RaEyHg7AyBxYIqvn13weMvm+FDjzTtVGMd7vqefA8
X-Gm-Gg: ASbGncsHBqJ6jm0b2NfIMTnjcOzTAICZjepw4Ml7WvrTuPrYPqDS6m1R0n7Hf7KWcwR
	gLqPxJ/FFcaRowqGKVSllAblUuZeOOXEeiz51IcKY6dd4/ZzmqV2pO3Rxye/uuF9oi0YYB+5qMK
	qXoz95VGZH4HDVnRay+MQITdXSx0PspcwGV7v0ntXKk+qnQOTxysWr1ycfKyjmFVZyJ+75319N/
	TVSPKlsGgqgSfQcX+3kZi2J3JPrdF5wu+/JOj2z9oVGHQo6P+iXTy05RyJfFKfY4XalC2S4cGwB
	csVWJiKGGEG4K5/fPfA72SKQzSkXaOLF0/2HSdWJNqtXdyzC7ERZK1yIVMssCiTIggnZeaDRhyy
	fqiwRUn1oPb0Zsh1WUPg439c=
X-Google-Smtp-Source: AGHT+IF74DQCzwwIomyBqEdXXOD1jj69Vn57eaymRaq7JEtoCmwGDdu6w5HfwaY0Mnrz+k2RuQo+dA==
X-Received: by 2002:a05:6000:4907:b0:3b3:9c56:b825 with SMTP id ffacd0b85a97d-3b5e7f34e3cmr15791519f8f.22.1752501281828;
        Mon, 14 Jul 2025 06:54:41 -0700 (PDT)
Received: from localhost ([2001:861:3385:e20:2acd:89a8:83d9:4be5])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-454dd241210sm134773145e9.0.2025.07.14.06.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 06:54:41 -0700 (PDT)
From: Raphael Gallais-Pou <rgallaispou@gmail.com>
Subject: [PATCH v2 0/3] STi device-tree cleanup
Date: Mon, 14 Jul 2025 15:49:13 +0200
Message-Id: <20250714-sti-rework-v2-0-f4274920858b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANkKdWgC/1XMQQ6CMBCF4auQrq2ZKbQIK+9hXBQoMFGoaUnVE
 O5uITHi8r3k/2bmjSPjWZnMzJlAnuwYhzgkrO712BlOTdxMgJCQAXI/EXfmad2NVwCFlKhTJWo
 Wg4czLb027HKNuyc/Wffe7CDW98uoPRMEB95gpbCtIC8yde4GTfdjbQe2MgF/aY7pX4oxVTkqD
 YWR6anZp8uyfAAsKuob3wAAAA==
X-Change-ID: 20250401-sti-rework-b009551a362c
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Alain Volmat <avolmat@me.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1634; i=rgallaispou@gmail.com;
 h=from:subject:message-id; bh=H/Oh3chBUpLzn0eNy+IaizkwixT6SipYXq6A3XVjTHQ=;
 b=owEBbQKS/ZANAwAKAechimjUEsK1AcsmYgBodQwRRIPuR301IFBulcUz6dbFJvnew4dfSC9PU
 wW5Rs/nstqJAjMEAAEKAB0WIQQgmXv2E+fvbV/9ui/nIYpo1BLCtQUCaHUMEQAKCRDnIYpo1BLC
 tVoeD/96W9cfUoDitYxPMWeu9TTXWFUqavcyUyrp94uDntgeorRswvVTA7Ngg7WUM+OxuQJI5mw
 n9nAtcJPvweseKDZEMha0vMQj82TdsrTKjueo3EFs9D1KIC5mLXlRZP49llMM+AFv+zyEtAOAz6
 2KrimlM4k99/goaLhuMbkvyytEtzIb4OyAjX1UIzp7wkUHD4gCjBfXnIuL5uPHajWXJkniKQw+K
 YX42XDn6Z0Fgk7MKpDEfDYbSZW9453swASYm+DwWWRpJioyS6xKY1qum7JDPaqnMjfIHX5+k35g
 onaE96Aep7OoGwO9HIlELNwYJ+r4L92Xihm00HDUveVw/0QJDYpHhzlnSrSetzI7BhGzNwkFkX8
 6wIxS0icQZU8S01Ed+mkDbxPXwH58bFTNDnVvlLQeQxSL1F8uBhPOuxv7i1V3PsAQoAxJyvTBcx
 DSP8QrngMgqw4J003Om7SHXsP7AH0+NQCebF9iIujBfT3vqYzGlgUph1L2Lkf3IK4JRebCIygAe
 SN/qcDCfkN+NAnhdBdjM0xxWL70A8zRGn4BWHmptZkz4FUOgKXzjZcOmwWIKMzySEdKcXkOTIuK
 PL7XDiC88zGj5zJAIr4MPY4IlMTVIrzB2j+mIt9eAgkxd6WCUXNH3bQ8l6ws1hcDtbWwJ3WgU4B
 QKuezY3W11wgpAw==
X-Developer-Key: i=rgallaispou@gmail.com; a=openpgp;
 fpr=20997BF613E7EF6D5FFDBA2FE7218A68D412C2B5

This serie aims to cleanup and rework the STi device-tree.

STiH415/STIh416 SoCs are not supported anymore and B2120 boards are
internal boards.  Update the documentation and drop the related DT
files.

Patch [2/3] has already been sent by Alain several months ago, but got
no response [1].

[1] https://lore.kernel.org/all/20230416185939.18497-1-avolmat@me.com

Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
---
Changes in v2:
- Fix typo in cover letter s/[4/6]/[2/3]
- Reorder patchset to be bisectable as Krzysztof mentioned
- Add Krzysztof's Acked-by where relevant
- Link to v1: https://lore.kernel.org/r/20250713-sti-rework-v1-0-6716a09e538d@gmail.com

---
Alain Volmat (1):
      ARM: sti: removal of stih415/stih416 related entries

Raphael Gallais-Pou (2):
      ARM: sti: drop B2120 board support
      dt-bindings: arm: sti: drop B2120 board support

 Documentation/devicetree/bindings/arm/sti.yaml |   4 -
 arch/arm/boot/dts/st/Makefile                  |   2 -
 arch/arm/boot/dts/st/stih407-b2120.dts         |  27 ----
 arch/arm/boot/dts/st/stih407.dtsi              | 145 -----------------
 arch/arm/boot/dts/st/stih410-b2120.dts         |  66 --------
 arch/arm/boot/dts/st/stihxxx-b2120.dtsi        | 206 -------------------------
 arch/arm/mach-sti/Kconfig                      |  20 +--
 arch/arm/mach-sti/board-dt.c                   |   2 -
 8 files changed, 1 insertion(+), 471 deletions(-)
---
base-commit: a6cfa4c8833944f8912c1fa7f95795753f6376ea
change-id: 20250401-sti-rework-b009551a362c

Best regards,
-- 
Raphael Gallais-Pou <rgallaispou@gmail.com>


