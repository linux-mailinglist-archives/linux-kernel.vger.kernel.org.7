Return-Path: <linux-kernel+bounces-805855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B878B48E6A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 14:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41261169F09
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 12:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE353305941;
	Mon,  8 Sep 2025 12:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dX1rQ/kI"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7423054FF;
	Mon,  8 Sep 2025 12:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757336386; cv=none; b=bivnB00ZfxoaAJdfFmGEvGw2TFTpjoPc45UPazs0Gzx30s2gBNM25UCmRVE3h9y3LUIiMTHzUUocJR7+39IQmZIPhNVyWrUS5vHYB3Sa+21nW2Oc1hdcq0mFGU+dVpATN4MCZr1dxFdXPnqudia0+y0hmd51ytbK2BnT8w73HL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757336386; c=relaxed/simple;
	bh=8uEM4gdyv3Tgk8Rw6iN0DvfOwdlfYIhoy3AC0avu8TY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=M/QuOT50oKzPJ8lF6ZhOiHw3441PuYHvCyYnk6JpW8If1dig3PVsyOlFaLCnmE62JWi0XVK70xNCzzX+AiRTSxRbIihhKoooUiVwjdasx3HKGF4AkIOodIyCx/fUKzkPI8GZKy8tBuReItfjk7EHy0Q9NsxGsldBno91H/XNVbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dX1rQ/kI; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3dea538b826so3724858f8f.2;
        Mon, 08 Sep 2025 05:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757336383; x=1757941183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P9HAK++51pzatrkTcr67kHbvxEqiZA0dHLEsKJrNIuI=;
        b=dX1rQ/kIQOI38Ndco5GR0Dc7oGdHp9cHi5K5Tpg3nmI0EGchY2zn80KXkkWHEah1ec
         xTh6yYs/1JyDQ49oEMNLkglIeOOHfPHaxdHVkxA8TujUtTX9OvAYsnWQMkRSZGvbpl3a
         7DoY3oN1hVWRMy6WEwM/C0eqwdTwprWGJiWml7gETnfDOZqJAIJ+/LXmKUgOjFgN7/zL
         hWhQBNBTCIh+9+l5hhmpCf/XR/fXLoj802RR940pM1peIHOmHoZgdz2SMMLODPbMSOaC
         oecpu85K+P6UtB0aJNc6nVM5oXdK3/aCOrAsslPTxnOMWQ9PTidxkFilvihWMd7qqa9W
         UBLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757336383; x=1757941183;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P9HAK++51pzatrkTcr67kHbvxEqiZA0dHLEsKJrNIuI=;
        b=hTsWLWZEaVH7tvAWL2GtOCHzA74wudamZqOUG0b3ABNJ/QI5rSO49xXIT3xFi7aUY9
         n7U7Ga2XZjffJVi70Ba1Z6xc0GFsNO3GoKzrMgDS9FyUYuESatshT+vO+yBofSg8yP7o
         DlY5L0Zen7qzjgP8crmMhyz+4K5NCjmjH6OM1HdCZ1mUmLtXS+ZTQQcSsd2XwYXzb9G8
         3M3RYyD7CyKH7xDokauhMb+yP083fZVG7WnWywvXunnmLLzcfwe+31Ts7IZNFhgsf91Y
         AzxCwFxigBjY9Md0tt+GeSCGSXAyatTIAwruYI+aS/82F9vCN2T6rEQKs8Lc4haTiuFa
         94mQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiaveFrhllA3+6TRwy0R4k258VjF/g00oBL0rSjfc5dWnj51e3YoIeNC9fIokwMIMSgEvVTcMb5mrB@vger.kernel.org, AJvYcCXlapYCstFnOGF0YEMvNaX/5/SCBX7uPofib8HC1Jib08sQSyrq4dAxYCzUd77Jtz1narn/MsETJ7rtDmiG@vger.kernel.org
X-Gm-Message-State: AOJu0YzxltURrNxngI0RubTwn6bXW7xa8Cy6TmPu+64Mtuce1BNG+Jtc
	XeuqM+cR+xrQBUplsxZcZ4GGH00oo/j57EPbPDuWV/qQPv+uCVAVy5Wd
X-Gm-Gg: ASbGncuC8t/24zTruNxsCUDV07rHHBiSbLxZOToF3UaqNyZbanF2fLWypM2HmPN5d52
	BV8aYbDrgUT6SQRm01IZj/DTLZBdrTA8bN1uVWkYC2HzHetZRfNp4AbQ6GacxPwUSyjX4kIYm+I
	1nlzaCJ+H6wEOt9n5aOpcnUv6Sc4/NWwsm0Zjemf9n8RVqQdCzNTxOxFlKbc7n6xMw4YQSHAYpB
	sc7zSPaSLxhdtRWezyqo4wjdq1A1utr44LaHn4cEmEtvz0B6VSVfqfu3aMBaxsiFXRNDOSqAHKM
	0zCtiu+lWw0LPhAG6+AJSKWVaUOzlauYHNmGEKxq6XUIKmWfBncyxvofPowhSqoAtJH65gRI2DW
	S4EgTy8vCZoEB0r6eDwwGI7wAwvZ4gtIvRw==
X-Google-Smtp-Source: AGHT+IH0t7fMV6CgMwj3Du7kf1S1PE57qtTFVRLfVYSND+U3dwSNX0b9nM0ZLF92ANClKZ2SLD0pQQ==
X-Received: by 2002:a05:6000:2087:b0:3de:c5b3:dda3 with SMTP id ffacd0b85a97d-3e645c9d0fbmr6697379f8f.44.1757336382785;
        Mon, 08 Sep 2025 05:59:42 -0700 (PDT)
Received: from taln60.nuvoton.co.il ([212.199.177.18])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf276d5816sm41260581f8f.25.2025.09.08.05.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 05:59:42 -0700 (PDT)
From: Tomer Maimon <tmaimon77@gmail.com>
To: robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	avifishman70@gmail.com,
	tali.perry1@gmail.com,
	joel@jms.id.au,
	venture@google.com,
	yuenn@google.com,
	benjaminfair@google.com
Cc: openbmc@lists.ozlabs.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v2 0/2] arm64: dts: nuvoton: Add NPCM845 SoC and EVB support
Date: Mon,  8 Sep 2025 15:59:36 +0300
Message-Id: <20250908125938.3584927-1-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds device tree support for peripherals on the Nuvoton NPCM845 
SoC and its Evaluation Board (EVB).
The first patch introduces peripheral nodes for Ethernet, MMC, SPI, USB,
RNG, ADC, PWM-FAN, I2C, and OP-TEE firmware in the NPCM845 SoC device tree.
The second patch enables these peripherals for the NPCM845-EVB, adding
MDIO nodes, reserved memory, aliases, and board-specific configurations
like PHY modes and SPI flash partitions.

The NPCM8XX device tree tested on NPCM845 evaluation board.

Addressed comments from:
	- Krzysztof Kozlowski: https://lkml.indiana.edu/2507.3/05464.html
						   https://lkml.indiana.edu/2507.3/05465.html
Changes since version 1:
	- Fix commit message
	- Fix dtbs_check warnings.

Tomer Maimon (2):
  arm64: dts: nuvoton: npcm845: Add peripheral nodes
  arm64: dts: nuvoton: npcm845-evb: Add peripheral nodes

 .../dts/nuvoton/nuvoton-common-npcm8xx.dtsi   | 702 +++++++++++++++++-
 .../boot/dts/nuvoton/nuvoton-npcm845-evb.dts  | 439 +++++++++++
 .../boot/dts/nuvoton/nuvoton-npcm845.dtsi     |   7 +
 3 files changed, 1147 insertions(+), 1 deletion(-)

-- 
2.34.1


