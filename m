Return-Path: <linux-kernel+bounces-795114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E95F9B3ECFC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 19:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5F8816CF8C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 17:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F43320A08;
	Mon,  1 Sep 2025 17:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DC+limGa"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF96D32F74A;
	Mon,  1 Sep 2025 17:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756746465; cv=none; b=QOK9sYXYgwkM3lQRaMzaeQFLY7d5AFlOJZZRVrduJuVQv8Vi6zfmHq1+rSP1iA1mSLcgNvp4irxs33vkCZYP+eIQatDiCVRgnBH0gxUXBftDGa3PqdJFnAw3g2PP2MzCP5kLGrYpZ6VBNM9ULPRSV8tDD0+2keCQNHAEVTRmSKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756746465; c=relaxed/simple;
	bh=me8EWh422YPo3cERqnPRxnV9qzRXPkVz2TeOOkHXTbc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=V2NU+TCHg3boQmoZ/daFFZ1AZwXH/ldDycPYT6WlSFqyah0o9O7KQ+Oh1wYjE/17Zj4/Fjughu0ujWaLTvdjzTco3zWhy0FYpHRQpq7GWvJHOovzdBhwnRK37G8XlbkY5+W2DQe4JNZUXoj8kess2FigjOvGCBkF/XmOGdiGubg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DC+limGa; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-55f7ab2a84eso1291753e87.1;
        Mon, 01 Sep 2025 10:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756746462; x=1757351262; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3kL1xnjqe2uzC0tVKSkm6SdseVayTEiArpVj+WQ0yDk=;
        b=DC+limGagVIzn//NkTYABji4pGRRusPbtf3Yz3HRU4wGIAPMfLWwtnWrxLamzH8JcG
         r+usFJAJxoh2BCjTuGtlIMVn0fvrf1KVhFm6h2+T7wKdFErUdXcaQRBaEOawSxSwnWIe
         s4LQXl419bbUNPm0qDS86wScffl7rWTq4kLZ3xGc5VZBunpMuJ8NT0cS5IYYUxXZxtd2
         kmOK4lwjyWtEj2MUxAgc4vZPku4il/o1Vjh76tig9jdqsDf6/nqH7CR9iAjSKIqrnugu
         NCxJMKtDfPdScnAuI6iWbZZh3WTOGa4hIo8OSwG0RVIQUj3GWwkkD064XXXq1VJXej28
         9Lyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756746462; x=1757351262;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3kL1xnjqe2uzC0tVKSkm6SdseVayTEiArpVj+WQ0yDk=;
        b=ZcmQT1MXwl84CAqTZ7/c1plIadkkhg0vl0V/Wv9DmKAi30agrQMQTqA3n85YB1s+Kj
         wD9FD/9j0qrFbmMISr6QzT4zpM5M6XIKEyXXjrljsi1kbjTC3w9/R1x4P3VCN0AMZ4mQ
         5a0npqLvD1kQHbcqSanga2WyAavItrrguta24Rhe8XBGjV90lg/1fFiQz3z8fbgpkIen
         ML7GcTD12lxc6APWgi/P0eIeW5GIH2UkVTqfHHWnsnIPK7YC6Px8mA+mjSgAie6+IITB
         dGHfCTz9fEzMfbPoiuIvHIWMBvfhfPzOlGX3K0F3iTMcnZtuF+F96WeEF75gW29tK6bu
         PuEg==
X-Forwarded-Encrypted: i=1; AJvYcCU+aA3mWKf4DekmXHB01tDo7NBjNxuXUE9JkmFBRNRmumwrWbYrrQ0mXA/rR+z6m6r15+EGoqQxjTTQ@vger.kernel.org, AJvYcCVMDr/05wUJsHABJ16eITL9nzmapGfJu1PXPnsqDTAKIGSwzu7ilFURzF+GlEOf9rqKi9mx3umqLbjW@vger.kernel.org, AJvYcCVf43a1yZqh2BQx3EJqpgIHyIU2nx1asN81/mNiHuoX49hvIXkLdeS41Ehnif1htGzz9IVfmIRiQWwU5x/Q@vger.kernel.org
X-Gm-Message-State: AOJu0YwzxbN9iG4BnRAvX/tzFzrkiVqv3mAemIyg8r56LnuKuNGGqRph
	CAJAefGLUI4RTGvHQajhSASgh/EHb5Qm7Lz0RNQksW8LC+PWXmXUQwdo7UuySw==
X-Gm-Gg: ASbGncv3ih8ZwxJuenbuTsrYEdzKG6gbuj7/TRfGWKz+6qziMQkMpUx060JhRAovpvj
	DOfMOCTP+oQWhe8FK/GZd93q4niHITH9Qi5AaWRCdidQSU8T65YgxrKm5uetvYQQbyjwg0PgTP/
	YXlXVLhG126ZJ2XMui5ceL8tA7JiCk3al3qUy3rLBJWuT139yfAGdzwktUzyfQaCHYZGhc+OrkL
	QqSXtSLrbfvSqWrv5ddg6ysBY1hGhYBQsP3RKBj8dg3EjzGtWxW+o5PsHIbWBCMGyG4Kpe6x19M
	iNh/od1CwjfNB5VrjhWwH+erWEOjPYBu5GhXtqJSpHrtrdIxBYqo6nI9KFWYV7NgkU9yzYOxpJt
	qEkUQOBzk2zXHsPP90HPWOrU9TxmfPf8JnzOTp/6/wCOVIg==
X-Google-Smtp-Source: AGHT+IHWg9rkJXFeOAyLPfI6Jq9upYbCl3QgUTbnRIZyklmbPgPwlM7YtvDYF70o6nvmJLdC8tIBxA==
X-Received: by 2002:a05:6512:230b:b0:55f:5172:474f with SMTP id 2adb3069b0e04-55f708b50c1mr2491179e87.17.1756746461551;
        Mon, 01 Sep 2025 10:07:41 -0700 (PDT)
Received: from tablet.my.domain ([2a00:f44:892:8a37:6b0:21e7:549b:225b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f7abf7abesm1137666e87.55.2025.09.01.10.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 10:07:41 -0700 (PDT)
From: Artur Weber <aweber.kernel@gmail.com>
Subject: [PATCH RESEND v6 0/9] clk: bcm: kona: Add bus clock support, bus
 clocks for BCM21664/BCM281xx
Date: Mon, 01 Sep 2025 19:07:06 +0200
Message-Id: <20250901-kona-bus-clock-v6-0-c3ac8215bd4d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Alex Elder <elder@kernel.org>, 
 Stanislav Jakubek <stano.jakubek@gmail.com>, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 ~postmarketos/upstreaming@lists.sr.ht, linux-arm-kernel@lists.infradead.org, 
 Artur Weber <aweber.kernel@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Alex Elder <elder@riscstar.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3153;
 i=aweber.kernel@gmail.com; h=from:subject:message-id;
 bh=me8EWh422YPo3cERqnPRxnV9qzRXPkVz2TeOOkHXTbc=;
 b=owEBbQKS/ZANAwAKAbO7+KEToFFoAcsmYgBotdLIi6PhSFeqmMBEQRv1HVm0Y6me6yRuQg9zb
 h0pGkVQqemJAjMEAAEKAB0WIQTmYwAOrB3szWrSiQ2zu/ihE6BRaAUCaLXSyAAKCRCzu/ihE6BR
 aMimD/0cI/DWnNL3uvNnof3spp9UvWC6z4WyZGJpVBYGjAlnati6sOENPcj/H2kMAsGSktW2oka
 D2mm5n0Vcfr1wfJv1l762pW9G4GHJQH2f7RG2Bs3L4tgOHhBhoC7uVgczKSNK46t2zWEGRd8UMb
 ZwRHgpDoIdAaiq2EW2112cWmBeO/Zg0eJLpBlQ2AGruC087SH+ww2o7850ev2HcWG0Lxc1lweC9
 eQ9/HjQ1gN3nJw85OJUVGLqaZLgcnAEwc5GzE2khBG1bUDGP69L9kFWOjrSfNpZlEgaviDNVCZ5
 a6WzZSQjD+Zim+vmGhWkoofoIfLyZvYcl7SgW73kRzVEWnpamHJhp+UUL10er39DevgozHFga3Z
 qpHaQXhEgn/LUYo9ca64MBT3XZqXFGJBO3UwalRzjFZpSSAa8j0jEymJmjOJw6TgxSrZwhsSDB8
 55fOA0pr+4Tsw+2zxq9MUqHe872NBfJa8Y6IHSjGXJisZmBRqwmdH6lYrg6h1rkRoo1PVCuALdr
 gA4pj+VxDOYdGBHSGW1l8lYnlCpITCA755atn6ion3NyEc8xpiImvSfUoyEuRkS8n0J2iW8vGLx
 xb6bZdLKNzNf7YAn1EBHjaQAS1AYllXZZuSDAv7qYARlTW7iXT9esNRbTFb4xnVrtya6U4daI7B
 DgOG6vCyeG85p0g==
X-Developer-Key: i=aweber.kernel@gmail.com; a=openpgp;
 fpr=E663000EAC1DECCD6AD2890DB3BBF8A113A05168

This patchset does the following:

- Introduce support for bus clocks. These are fairly similar to
  peripheral clocks, but only implement policy, gate and hyst.

- Add matching bus clocks for BCM21664 and BCM281xx peripheral clocks
  and update device tree bindings to match.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
Changes in v6:
- Rebase on v6.16
- Make kona_bus_clk_ops const, add a new commit to make kona_peri_clk_ops const as well
- Link to v5: https://lore.kernel.org/r/20250430-kona-bus-clock-v5-0-46766b28b93a@gmail.com/

Changes in v5:
- Pick up Reviewed-by trailer from Krzysztof on patch 3
- Rebase on v6.14
- No code changes since v4
- Link to v4: https://lore.kernel.org/r/20250318-kona-bus-clock-v4-0-f54416e8328f@gmail.com

Changes in v4:
- Rename moved CLOCK_COUNT defines to CLK_COUNT to avoid redefinition
- Squash BCM21664/BCM281xx bus clock DT bindings commits together
- Link to v3: https://lore.kernel.org/r/20250308-kona-bus-clock-v3-0-d6fb5bfc3b67@gmail.com

Changes in v3:
- Fix DT schema example in BCM281xx bus clock bindings
- Move CLOCK_COUNT defines from dt-bindings header to the driver
- Fix BCM21664 UARTBx_APB IDs being out of order compared to clock
  driver
- Link to v2: https://lore.kernel.org/r/20250303-kona-bus-clock-v2-0-a363c6a6b798@gmail.com

Changes in v2:
- Drop prerequisite clock patch
- Move clock/bcm21664.h dt-bindings header change to dt-bindings patch
- Add BCM281xx bus clocks
- Link to v1: https://lore.kernel.org/r/20250216-kona-bus-clock-v1-0-e8779d77a6f2@gmail.com

---
Artur Weber (9):
      clk: bcm: kona: Move CLOCK_COUNT defines into the driver
      dt-bindings: clock: brcm,kona-ccu: Drop CLOCK_COUNT defines from DT headers
      dt-bindings: clock: brcm,kona-ccu: Add BCM21664 and BCM281xx bus clocks
      clk: bcm: kona: Make kona_peri_clk_ops const
      clk: bcm: kona: Add support for bus clocks
      clk: bcm21664: Add corresponding bus clocks for peripheral clocks
      clk: bcm281xx: Add corresponding bus clocks for peripheral clocks
      ARM: dts: bcm2166x-common: Add matching bus clocks for peripheral clocks
      ARM: dts: bcm11351: Add corresponding bus clocks for peripheral clocks

 .../devicetree/bindings/clock/brcm,kona-ccu.yaml   |  49 ++++++-
 arch/arm/boot/dts/broadcom/bcm11351.dtsi           |  33 +++--
 arch/arm/boot/dts/broadcom/bcm2166x-common.dtsi    |  28 ++--
 drivers/clk/bcm/clk-bcm21664.c                     |  99 ++++++++++++++-
 drivers/clk/bcm/clk-bcm281xx.c                     | 141 ++++++++++++++++++++-
 drivers/clk/bcm/clk-kona-setup.c                   | 116 +++++++++++++++++
 drivers/clk/bcm/clk-kona.c                         |  64 +++++++++-
 drivers/clk/bcm/clk-kona.h                         |  14 +-
 include/dt-bindings/clock/bcm21664.h               |  17 ++-
 include/dt-bindings/clock/bcm281xx.h               |  24 +++-
 10 files changed, 540 insertions(+), 45 deletions(-)
---
base-commit: 038d61fd642278bab63ee8ef722c50d10ab01e8f
change-id: 20250212-kona-bus-clock-4297eefae940

Best regards,
-- 
Artur Weber <aweber.kernel@gmail.com>


