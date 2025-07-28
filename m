Return-Path: <linux-kernel+bounces-747786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7102FB13835
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 11:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E356189DF21
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 09:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E7C25CC62;
	Mon, 28 Jul 2025 09:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="AHNGymxw"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE5625CC70
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 09:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753695884; cv=none; b=lJ6GNa7WXjeanoFL95ptkhFZPd6pgU2pmFyek+r34sUkrrI1M+ZxuB8OQaVc42QSlklVLWhUSvX3kp3nxADYYpdS8aSCF/qEIYkyuvZzD/Q4q+lKAl43X0wpkOXVPY2GUXXyMYHmzOEqEXSO5BONxqBrUTcAs6a7P2Qbe8kF59A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753695884; c=relaxed/simple;
	bh=do4xgD3FIKiBFCXHybdwqmJMFTQfLzd5+SYEVnCmQ8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oiPviJv7khvP9SdRrcd4ohc2G8egsbfvp1rKo/phpD8PMAYPL0QIOiNlD3ud90rJ5i5MLHNxKIbk7T9td4RUF4e5M27uG1ao4utquNzOXIoUMJI+SW/I86KvswP4SeTx7071HrUIbmYHNpYpA4ddGah8BiHGKL3oRqnLD3d0/bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=AHNGymxw; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b34a6d0c9a3so5232705a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 02:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1753695883; x=1754300683; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nCKZPLGMv6q3Gia2CuwihlvGGifXlgSwREijf4CMFzo=;
        b=AHNGymxwc6ze+foPPqiwLOrwz34x1+X+Coj9wPsCcjscm4N4E7tDbikib8qNvdez1x
         Xdi82sLba/BE8fLngO32PgSDiy/DfaN6Td13oGmal2mj9I6UU8L2czw8mFhEBdkFD7L5
         X7fM2DREQTJuPyR+oGkTsTHbh3ZlmhbRGj/3J290RZ49XEYei7zgcK8oYP61r+QrLV54
         44AD1VsoME9L9k0rgTtjh87OD+tK0EdhfcAYG7LcDBqOcjThmtTiAUbIhX1R65umAmYF
         ZzEnpjcSysfApVgU4KxB4W1ZXE33Kt5uDS/xKj6nQKHzRzp7tqopr5OcWmh2TGf7vPYR
         yOyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753695883; x=1754300683;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nCKZPLGMv6q3Gia2CuwihlvGGifXlgSwREijf4CMFzo=;
        b=KW2yLJiH21BLi5o3HBglC2N5sY4ZM/9eGzbrQg0fwnnNmb63izQdRvn2OLcrjSzClz
         8mrDgXQUGpU8tgT/ELapKoaHcfxz1tVUhPrxZMTHhPl/c3sijArhyvM0R9na0+JB/+Dg
         boPV3wk6SVfdIDGau7cbpQ5scjUe5p2lGoi13JhfyYk5r86uxgFHcoXYv9bvNCw0quPT
         sN79n+10F3IDcydftHKhzcRZe2+Y+vy8bb/fs6eKbjk5agBW+WPVX1mB0Bsg79pCdt8y
         mF3zneT1xjUbXaKJoHLgf0KR0U3stmzbMmRTxhmaxJ7YBmq7nd+FOmZ48oIqQFoYK4/y
         x1xQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdtlX4P97l/v33cw0wB8JvjmGSGKlaD3x7P1AF9cJXfH7jpAl/Qar124ycAxFGjmj5oj4aI6pCbljO3wM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCUZ82xswD5OgpG4RMcujcoeXhi6aAtmWIIc8lCMjs3WKEm2Jx
	FBjaLmSgc5bZrl/vg+Vjf0BwJuhp+jusz/wBopRe1Mv7aDNHX2/Wmj60vdFqcriNX2I=
X-Gm-Gg: ASbGncuwKyZPnqRYy71FJvUSyo7Aoih0k2iInqJTvQscX+/dyjDWce2CN9U9veVlEv/
	/a80ZqeZTrygOumhZucpc3foKCrreZTXjrJQUvRcl8cFNC3dyiaz9nxVbr2Q7IYTwMdEVVFOlVl
	+Sj+XWY6Vb9+6FZSXibOvSuZBZ9L+/bA3BWj9IszNIVMR1kzzoG/qSojjSmwY43yHcCslxC1ZLn
	CfldvX6+vS0ri7exj0pspg2/V7vEByidQEZt20u2A/f4OAwJGfjAafZaBj2DsQ9aXxRjaEBanKM
	NV9OJEWmIZ+8mud3JlH8LLMf7r7Fo7EJEvV1bRRQDe3MKWV5sVJjxrFgD2BVc73K8cSLDxHu71H
	/6OopcqF2T4x6RPng3Qthl+dlBjspJv48+RFc2GIJOs7QhfypHT2iFMbBGIYW
X-Google-Smtp-Source: AGHT+IELZc1JoVLYVZkMGvFurZiEqv7IzPn8isjkF2mrjY4D12shOeNQi1Y8F1Z2Ck3l3/NTN/nxsQ==
X-Received: by 2002:a17:90b:264e:b0:311:c970:c9c0 with SMTP id 98e67ed59e1d1-31e77a00816mr14125480a91.22.1753695882475;
        Mon, 28 Jul 2025 02:44:42 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([122.171.19.28])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e832fbf99sm5396230a91.1.2025.07.28.02.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 02:44:42 -0700 (PDT)
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
Subject: [PATCH v9 23/24] RISC-V: Enable GPIO keyboard and event device in RV64 defconfig
Date: Mon, 28 Jul 2025 15:10:31 +0530
Message-ID: <20250728094032.63545-24-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250728094032.63545-1-apatel@ventanamicro.com>
References: <20250728094032.63545-1-apatel@ventanamicro.com>
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
index fe8bd8afb418..bd5f97e1d1a0 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -138,6 +138,8 @@ CONFIG_MICREL_PHY=y
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


