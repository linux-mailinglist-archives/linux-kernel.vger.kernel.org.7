Return-Path: <linux-kernel+bounces-885010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A841BC31ADD
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 16:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2C79A34A868
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 15:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2A7331A42;
	Tue,  4 Nov 2025 14:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NH3KqUC4"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDC53346A6
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 14:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762268309; cv=none; b=CaSB1R1gRua3wfWF9Iu7advYi1SxeRcZ9pYPZESCNCYNBJj7ynQ2VotHsj54OmMGEIQ6GzVblC/IhPtmKOf69XIq9gmoQx0QFg0DoOi/0NkHhcf+pquP+A5vwrwTE8XuzNaS21d+f4913fK7lrKMOuc8SJWYIQrngDBxjRdwBDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762268309; c=relaxed/simple;
	bh=jofWWnwmoG4Nrm+u2R6rEX8xNv7yEnOjBBXdOGfBxTY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=W6RCuUw2kyRaZx3c8tBRPs4ZFJQv1dHQWOPlbU0KvZpRLYKSxNNz2pRTWFCx3Jc4arCBuNJ4MhSX9m/mV0iG5vC9e4CCFKxCU5WhWYnje/wg3bHkKru0QxwwK7oQXoJcT7pqv3Thd34uC0NNNHFyYJenhyQqS2irDQCtdye6UL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NH3KqUC4; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-640bd9039fbso3871516a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 06:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762268305; x=1762873105; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4pEYynqLlf97tqquz7gBzDn5fbpmeV4yt44zAz5u1qM=;
        b=NH3KqUC4M5jMP9sD0dDu3QZfAqYyRwTUrw2F0b7M8T3N1likkpBoRiPByQfMTbX+fx
         iQZ5bNrzTeqk9+DbNb4m/7efA6EcrkW9MiSSWHdQ73FEsJzspwFNsEnY7JsawFnoYibK
         4ISwSW+wSJW78DOYpG6V2avuFGY+mcNM5qJ0RzsqfzmQgprDBNBWPfnziBYKfdMhlU5t
         c8x3jn6nI3EqpF+qhe/KULm+L2IOQ8ragVRy9Xp+gZqKa3jHVkm4E61Y4N0l9TImSbrF
         qpzaFYWS/XgpUAjICj1fAJNkBSAxLxpivbyLrSNsw2GNjCdKPS1UGhz3OpCsflW2kxMi
         etOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762268305; x=1762873105;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4pEYynqLlf97tqquz7gBzDn5fbpmeV4yt44zAz5u1qM=;
        b=BlVPxI5Fy0XABQBvO7n8iU9jltwobnsWRe1bs2yzL6BMLxfgjBjkW1c89WcAjIxyt7
         A+/oZw0Oh7tu0i+KqQyKJ6ZuAd09kWWUGWqzLPaLl0TApFs4jy2hlelPZ005aTj9g3ZZ
         kEv6Dt+8ZgErum0Bf5DQPkX8TJhyz/0p98MEFxnkowdfUTrwtvU+aReM60YOYyFbIjko
         du5UxhMjChYF6358bPomekye8u1NeGeiYmS5/FZxTHy2shewI4fNreuKI12aEfa41SOS
         DJM0E03rJBGLAmByE9WGFxfaNcg1LDbkjBeeQDKminJYJ5J/qJCDFnFc5SCL0KAjAUcm
         zt8w==
X-Forwarded-Encrypted: i=1; AJvYcCU62DTO+ED0/6uYcsralHiJu4rvifN16X9cyWHQfLRs3w89RGqtTsuFrY3sQFvpPXvccW6lvVtVnfGnHdc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+HA27NBAHJ7nllzMKaQEsWVoIrrdr5IkEqqw74aNi8OQ2s3V+
	bH6s6JLczJyZhroQ3VpCCwfbfOHHvI9C6xZSHpgpg3QyE9x0Q1Doc0/w
X-Gm-Gg: ASbGncvtKcbMrn1aiIJoiArKMN3j3bsT7k5voLdEFq5eub6TDSxPrDQ8xMtBxnMoa/o
	9lsLXdyCH8P5Ds2OBFp+SHaMBourIB3wRMyZhw9vThoJFYQzEjdmxjp5W+leIh3eyZGVnbHWpwx
	Un4Hyr99UXsbZ+x4AFQG89ULBSEa2xwc2+sQNlMNbNUPwgUJKDlClxn9v/nPCSdA13XFHyNfer6
	z1ebb/NLjttmNZd2i+kcFBE3RyWCfYAqPPKVBe06XpKVVVJkXi6QbT/4oiu7XxpMoWWpFv0/zIb
	WjyHQNARu8WmQgeG4gjQ4pUouzwVF2dZC3WfWAm3Wix0QupRiMbEXJi2oqFNLIP5oB1i+jlrLgl
	9JwVCNamau8zumxhbHuAZQ+qZlixPZUflz0KvL9SpwsReTIn32HVTNmD1kjbpg5fTGrazSeh0lR
	X9Xu3uvGx5HsmUajpyS5I/Eqt/aZBztQxjvBKKY+1kxMW5Has=
X-Google-Smtp-Source: AGHT+IFCrq3nCnD3LeMjo88kUj+iYOsaxz83hK9DRyJQvnnXwEepxp0u4Czy8i8uiy1jj1mUE1acXQ==
X-Received: by 2002:a05:6402:5114:b0:640:f041:c7c6 with SMTP id 4fb4d7f45d1cf-640f041ca48mr1477907a12.21.1762268304776;
        Tue, 04 Nov 2025 06:58:24 -0800 (PST)
Received: from tablet.my.domain (83.21.17.47.ipv4.supernova.orange.pl. [83.21.17.47])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-640e6a7fcd7sm2288874a12.37.2025.11.04.06.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 06:58:24 -0800 (PST)
From: Artur Weber <aweber.kernel@gmail.com>
Subject: [PATCH RESEND v7 0/7] clk: bcm: kona: Add bus clock support, bus
 clocks for BCM21664/BCM281xx
Date: Tue, 04 Nov 2025 15:58:18 +0100
Message-Id: <20251104-kona-bus-clock-v7-0-071002062659@gmail.com>
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
 phone-devel@vger.kernel.org, Artur Weber <aweber.kernel@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Alex Elder <elder@riscstar.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3090;
 i=aweber.kernel@gmail.com; h=from:subject:message-id;
 bh=jofWWnwmoG4Nrm+u2R6rEX8xNv7yEnOjBBXdOGfBxTY=;
 b=owEBbQKS/ZANAwAKAbO7+KEToFFoAcsmYgBpChSNG1jE7pGayE9k2YeIEYEceIZhdRQbjRVvf
 c+4M2DM7p2JAjMEAAEKAB0WIQTmYwAOrB3szWrSiQ2zu/ihE6BRaAUCaQoUjQAKCRCzu/ihE6BR
 aDg2EACPQfLq3G9R87y8E6cISkzuRCn0I42CEz+TaLiFTXrXAIRNojHo/LdGDTz/kRnGRi0WpYn
 0cCm5clirUWqzMJ9c+ifTT6OOs6412rzwPIZfBrDikH/jQDNQml0N2BMkws4yT5Q0D7chgtzgzt
 jpDz6oIHJ6kIv50ZEewPZn+/ufxFnmIn6JCElW8WN6/NBT/01FTbafOUzNqikpZw82IvP3qH0HQ
 7sNz7f79BaBFE88LN03h0eze5i0AQ4FoYyQfLUs2zJtFWinTfzglhfRxgAWO34meuiSt5M0O/lQ
 h+xQhlR4mQ+5QiwOjikfQUuzhUlipswVgraOCfbgq4gchs8wTMr9leseDbZQPGL+pqEhjOtGKEQ
 sfbHEC34K7ycd3gUUm/H5rojBylUXJ9avCQWCDXaFDqqD0RAbxnsiWYoTbgjCNExH6WaLCDwyRb
 X5fkDnPxnWO9RGifbFG3kgCYqqZDQFEDMFxUbdlKAWTzgLAzaIQRH8PvbSf0u9cNw3I8gI+s9lT
 vHWI6tgOesxEfXfHSQrxTmV3QQyieWoCLfsB/B3a5+qxZF0or/1FVG31aJaubgFGTnJCSGCoz4M
 UPKMvKuyAg54i6hS4MK0LiCPzwI83mbS8RyIhBrSZTFSO7OpzVGORzx2zT7ceRHBvdpfrcXODts
 7i3OXHOAZld/E6Q==
X-Developer-Key: i=aweber.kernel@gmail.com; a=openpgp;
 fpr=E663000EAC1DECCD6AD2890DB3BBF8A113A05168

This patchset does the following:

- Introduce support for bus clocks. These are fairly similar to
  peripheral clocks, but only implement policy, gate and hyst.

- Add matching bus clocks for BCM21664 and BCM281xx peripheral clocks
  and update device tree bindings to match.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
Changes in v7:
- Drop DTS patches to make merging into the clock tree easier. They will be re-sent
  in a subsequent patchset.
- Link to v6: https://lore.kernel.org/r/20250813-kona-bus-clock-v6-0-f5a63d4920a4@gmail.com

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
Artur Weber (7):
      clk: bcm: kona: Move CLOCK_COUNT defines into the driver
      dt-bindings: clock: brcm,kona-ccu: Drop CLOCK_COUNT defines from DT headers
      dt-bindings: clock: brcm,kona-ccu: Add BCM21664 and BCM281xx bus clocks
      clk: bcm: kona: Make kona_peri_clk_ops const
      clk: bcm: kona: Add support for bus clocks
      clk: bcm21664: Add corresponding bus clocks for peripheral clocks
      clk: bcm281xx: Add corresponding bus clocks for peripheral clocks

 .../devicetree/bindings/clock/brcm,kona-ccu.yaml   |  49 ++++++-
 drivers/clk/bcm/clk-bcm21664.c                     |  99 ++++++++++++++-
 drivers/clk/bcm/clk-bcm281xx.c                     | 141 ++++++++++++++++++++-
 drivers/clk/bcm/clk-kona-setup.c                   | 116 +++++++++++++++++
 drivers/clk/bcm/clk-kona.c                         |  64 +++++++++-
 drivers/clk/bcm/clk-kona.h                         |  14 +-
 include/dt-bindings/clock/bcm21664.h               |  17 ++-
 include/dt-bindings/clock/bcm281xx.h               |  24 +++-
 8 files changed, 499 insertions(+), 25 deletions(-)
---
base-commit: 038d61fd642278bab63ee8ef722c50d10ab01e8f
change-id: 20250212-kona-bus-clock-4297eefae940

Best regards,
-- 
Artur Weber <aweber.kernel@gmail.com>


