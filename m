Return-Path: <linux-kernel+bounces-772828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A525BB29810
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 06:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 379235E18A0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 04:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A562F26E709;
	Mon, 18 Aug 2025 04:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="judyfJZX"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEC3267F59
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 04:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755490397; cv=none; b=mARXmzZ27VN8sXS6H35+O8gVTusrNR75v7cJynbJzog1NlTJLySdl/pRgbrVITwDGwO6TAc3HYESW0GNodRV+dQMtQM7mXDtpwiLRe5WLX+Gg1SMUMxXU1og5MVdnMubRXGo8uc57nJrL9WyNPc3DNHPb9MpzBqPxwgVfb3wzYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755490397; c=relaxed/simple;
	bh=65T8ACHblxo2D9Y5oErp1bIX7U/Lm0LLwEyN5VeFGBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CWpEoCwH4CAaWapuzLLQlEKGsNf3VGLH63fDxfrw/dnva63a0FpNci+8NrosHseO6XVb+KE6KIzWqUjZ+wpZPXfeTwiUwCIewBzB40fVxDsJ4NOj1skFAxrwj+wP9ikUwUeMCWiGyltP7GpkD0yZx4MryU/v73vfhrgv8n+OavA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=judyfJZX; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b4717554c29so2393077a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 21:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755490395; x=1756095195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tJN6/jwOx6PvAx5UtYwiYDtqnVqwfwWox4DCK7OERJ8=;
        b=judyfJZXRbZ1MtDjdYFuXlBo+IoN5mmIax/pQyCcF4bbj7KsoUwoZoh1pkeDIusy/n
         B6Va2ItrQ5Clxnxy1D7NzWn+eioroWtbpUdcntaXi1E6xzaQ9ol3sxOr/42l5gDLNXYh
         HN7ciGhDBdlCxSVmm4A5QUtZe1hwfKyo7JgLTbLvix8dhJXLTULVKm5sWleIh+7Kk4+O
         mIdn/5k8STw7+u0APgJYzHpHPqJyn8YPJ/XFdLjFCAe/cShBHnItQJ3NUxt4WL3nTNrY
         K8jUNuUVG5Swi3+inXpAAsVwEj9OI4nAnm2rHiqitxhQfI03PW11MXjoVUrxH9K7u2Hf
         cUDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755490395; x=1756095195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tJN6/jwOx6PvAx5UtYwiYDtqnVqwfwWox4DCK7OERJ8=;
        b=vnc+SlGzoQn7o4I2nU+6yH3znkNM06Qn+7Eyeqgkk0HNIZK3gz0dwU7FjKTujhDQHy
         QB8lpFqPT5bjBmxOZOghmThSiVKE/JNaGRytZ/1gaMSIF0BlvbfpMufRnhSgae72r9+j
         DABXFzcO4BolQvCdFjjm89zMxEvsxkw/NZSR8D2S2KSaOgLnFUsW++927kzAd2sVUCfu
         rOJ9u2m+pYlMOap5NNAAdwmed2xsSxgtUvcNbjl071Silr1hxCkS9Xk3bFPpDiYe+as4
         jozmuxs7axQjCtLEE+BBbq49IVhkiuVpcBTEBZpBNVfXFniPeLHtJo9nLBwzMh17eivN
         RoEg==
X-Forwarded-Encrypted: i=1; AJvYcCXxf2QrIWf/nDrDtb8vxgouyvN4X3+YuYnizKSaLBpzU4zn3I5pEQlV80Q0GE6W5oQaSPtGdEljx/+RvDs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7RhlmZRwEvKuutfFjSk53jLznbmkjNdMTqf02ChTqD+6GQbvc
	TtpmvgHCBmJ28iWtY0r69BQN15ug+sVDvqimOFAncsVot57kSWfYbixnUQNbxmmzhmw=
X-Gm-Gg: ASbGncvT8PWf56FhD5AcyWN8HVe+9hVshzRUortMheivnHvzIUIyscp7ulbiGT/Vmau
	pu94532pRPOMHvuIKmRYR3BjpMxY4bbVDiHtrIYVOPPQ+ZoRwkTEdQN9WFjGMWtJl61MmnMJ3RP
	V7g6UlfGlLXDFO49eps0NHCLRvLb3ZCCUNy0WzLdAJG7UgM5oUrtQPTLqSv//GYusq+8l4PRwPC
	FSjubYgoZzUUOPx3DD0ym9DIxCD46mwgQxGit4iw5ehCqkSe5AKSXOvZoMp4n6orPzaxT78KYtR
	UzOi9yljxBOXRGtkklkh9B/WYDLefCJOFqBTDHRqR/a83GAixylTPQNxvlzwchTUxWMUPemni9n
	NOICrUPLWYpzCwJqCVy4eimlfYszraA5tCrqgVwUe58yImYmXOrcSaCQ9hxXaW6J/
X-Google-Smtp-Source: AGHT+IGHAghuq2SQgJxlaChRoet/Tx7S9hCYmLUP2wntlwdg9I81uVIMsAQNgL7M5sl0qBnBN4yH/A==
X-Received: by 2002:a17:902:e948:b0:242:3855:c77a with SMTP id d9443c01a7336-2446d8c6388mr161787285ad.34.1755490394370;
        Sun, 17 Aug 2025 21:13:14 -0700 (PDT)
Received: from localhost.localdomain ([122.171.17.53])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32343c70356sm6560972a91.25.2025.08.17.21.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 21:13:13 -0700 (PDT)
From: Anup Patel <apatel@ventanamicro.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Len Brown <lenb@kernel.org>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Rahul Pathak <rpathak@ventanamicro.com>,
	Leyfoon Tan <leyfoon.tan@starfivetech.com>,
	Atish Patra <atish.patra@linux.dev>,
	Andrew Jones <ajones@ventanamicro.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <anup@brainfault.org>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v10 23/24] RISC-V: Enable GPIO keyboard and event device in RV64 defconfig
Date: Mon, 18 Aug 2025 09:39:19 +0530
Message-ID: <20250818040920.272664-24-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250818040920.272664-1-apatel@ventanamicro.com>
References: <20250818040920.272664-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The GPIO keyboard and event device can be used to receive graceful
shutdown or reboot input keys so let us enable it by default for
RV64 (just like ARM64).

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 7b5eed17611a..021baecb253a 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -139,6 +139,8 @@ CONFIG_MICREL_PHY=y
 CONFIG_MICROSEMI_PHY=y
 CONFIG_MOTORCOMM_PHY=y
 CONFIG_INPUT_MOUSEDEV=y
+CONFIG_INPUT_EVDEV=y
+CONFIG_KEYBOARD_GPIO=y
 CONFIG_KEYBOARD_SUN4I_LRADC=m
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
-- 
2.43.0


