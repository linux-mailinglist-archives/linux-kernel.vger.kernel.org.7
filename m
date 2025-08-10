Return-Path: <linux-kernel+bounces-761418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F67B1F9D6
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 14:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24D443B9858
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 12:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA0E24DD13;
	Sun, 10 Aug 2025 12:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="G0YrLyEj"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA6F22B5A3
	for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 12:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754828502; cv=none; b=nH3UNx/2PfggkczMzgW0k2vyzww9naw0yvcLd6LserSvwcqz3i+j2UxXOjlx0bHDyaO/6VTECxgnlPduUrS33bIwVrIkfyWnJ+ztL1Gp2MtmHrloTUgs36HVvtUff3aYaFR4ulNh1aRWMucnU/KDOUP41BYnp3lMGM7ZA7k+08Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754828502; c=relaxed/simple;
	bh=FKF32B1DbsrgOSP6yeaxp0UqlkMMCckPHJ/HTZ2PyYI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gx+DAF7FPOfSWGP49mNoOnUmBEQe6yQxjkgGYmI+ipnRl7Q7mOKXL0E6lKg7+Kb7NNtdzsswo2n06sTwuBIEmPEgZi+zrVYYC7EU2lm5k8wWWcZf+Xws01E47j6w+yZJ0aKtl9UxmMXeF3CwJw2y6ZWPOn3/nxcHu/llSqQZozU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=G0YrLyEj; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-61564c06e0dso5694296a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 05:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1754828499; x=1755433299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L4RjcnrIZ+W5L3kUceF7GfLbbqAQQYw2hpKEnRdHMMA=;
        b=G0YrLyEj6gNSqmGrDBeb375MqwH6QVilybgJC4h10UPSD9VBoMT4eJ7trvKrff4dEH
         JjbgUc+vRmJNDDQ3dr0m3nr7uM2/PQJIzEHbSZRhmP+jjU/pvzDZB9Qi8Wml69O9cRYX
         3NlZgzTWOoaTnBY6bXvGmN70SEiwJcld3hK3xIJvksmClUQCZ9GxAJPZjdNDg113EDXS
         2xijzAGPFkVWsUh/AZppZ9CnLqEkFicZhNX/hac8cHH0rqxSclwq6FwcK21bsefRY1VH
         GW0UMBVRFPW08Haf8sX2U99h65YWxhIob6cFjKZsz3m1VCbb2w8SuVA4FBI5c2Gks3TQ
         i6BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754828499; x=1755433299;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L4RjcnrIZ+W5L3kUceF7GfLbbqAQQYw2hpKEnRdHMMA=;
        b=hu7zvgQgz+Sb8QeFkJ/dA5e2Dbac+5AiU1h3ktd+XkoNI/F+w2OuPkwz8y3Rp4xzbT
         btgeFEEDV1tMskc5MDYJObl9XckI4+MKYMVDRDg2ezhZjV+gb0NH/0vwDddQ/YMJXP3X
         1I5sifBTW/4iy9IPTJBJkk7u82k9CigI8/K7rRzMLqxXGnZBLndMp3jj5pauRdQc82nw
         vbemYSpIUudpiZCDrOqtRZg/h/VcIzvXCC9gqEGp+MYk6BnZ7oWZF39uw9a3uFlnM/l/
         hWOf2ELoACK/naiouXiy/YfuGuDyNGTPqTmwvU6rQtH+48HUHhAFjPEweGj3KpdpWSr+
         /7Xg==
X-Forwarded-Encrypted: i=1; AJvYcCVzkdzYRiOQzVDSb6AyDXNM0/2JhX2n+a5Q+s9QjURlQ8UhOgm3aQOV6eGE3TewcuKswhqjbyDveosEjG4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhnvMNfpeBDip2PifOQrDA/QxXEyw80IX4pcvkRZ/R97V2Jd1F
	5ibMxoXgyD1ZHxwYyfsoNdsUu2YN2bQljLQYa9nOXsg0CGJHHEkKd6czkafSrG77jYI=
X-Gm-Gg: ASbGnctYgGqX/JBEQjz3XF0c/m2eLkdTBGcUvGAKYTSAy2lTm12EavPekXfIQce6Ft8
	LMCQHWAyvfZSrOO9HaoNSLzKxKOQwtrBuYM4ZrCTxLLR6lqHf8voMNHvf74IRGYBtYhqDj96BPN
	gBDxOUabw1B40Jgr1uCiX6p7YtjoSNq+lPx7HYyR6bc4V8fo6M0yJIlI4LR20dIuh30d0mNdRzP
	Cpe2Jg1Zz9mTRGQvMTJpx+Ck+50wV6P2a13S2kLJYMoUhENcg4m75P3i46KeTsKlDARe7R22F2D
	+1CvmtPlJ+dO6SaP5IZCVMyf2wtvWr9T5a3DFpayIODJ7t9TmlwyICxTlUVX2Lpe9gh5EEDEKaC
	u3huTT8/8MROCdIMLdzCIIDIxhiRUqAWolnXTVf2WK/bFkPlljHZT
X-Google-Smtp-Source: AGHT+IFSeAF9Fk04n1puF8WCTjGoIhixSoOG8oLkqqtM+6CY0pS9xTvj6pKvC1KxF2I94fi8T7M8qw==
X-Received: by 2002:a05:6402:2106:b0:615:5353:5e2c with SMTP id 4fb4d7f45d1cf-617e2e5311dmr8217507a12.19.1754828498757;
        Sun, 10 Aug 2025 05:21:38 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.188])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a86758fcsm16611897a12.0.2025.08.10.05.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 05:21:37 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	p.zabel@pengutronix.de
Cc: claudiu.beznea@tuxon.dev,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	niklas.soderlund@ragnatech.se,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v4 0/4] thermal: renesas: Add support for RZ/G3S
Date: Sun, 10 Aug 2025 15:21:21 +0300
Message-ID: <20250810122125.792966-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

This series adds thermal support for the Renesas RZ/G3S SoC.

Series is organized as follows:
- patches 1-2/4:	add thermal support for RZ/G3S
- patches 3-4/5:	add device tree support

Merge strategy, if any:
- patches 1-2/4 can go through the thermal tree
- patches 3-4/4 can go through the Renesas tree

Thank you,
Claudiu Beznea

Changes in v4:
- dropped devres group
- fixed compilation error on arm32
- use div_s64()
- dropped pm_runtime_mark_last_busy()

Changes in v3:
- drop runtime resume/suspend from the temperature reading function;
  this is not needed as the temperature is read with ADC; this is
  confirmed by the HW team
- use dedicated function to open the devres group in probe; in this
  way the thermal probe code is simpler

Changes in v2:
- dropped the already applied patches
- dropped patch 2/6 from v1 as the devres_open_group()/devres_release_group()
  approach was implemented in this version (similar to what was proposed in
  [1])
- collected tags
- added a passive trip point not bound to any cooling device, as proposed
  in the review process
- decreased the trip points temperature
- convert the temperature to mili degree Celsius before applying the
  computation formula to avoid losing precision
- use int variables (instead of unsigned) for temperature computation

[1] https://lore.kernel.org/all/20250215130849.227812-1-claudiu.beznea.uj@bp.renesas.com/

Claudiu Beznea (4):
  dt-bindings: thermal: r9a08g045-tsu: Document the TSU unit
  thermal: renesas: rzg3s: Add thermal driver for the Renesas RZ/G3S SoC
  arm64: dts: renesas: r9a08g045: Add TSU node
  arm64: defconfig: Enable RZ/G3S thermal

 .../thermal/renesas,r9a08g045-tsu.yaml        |  93 ++++++
 MAINTAINERS                                   |   7 +
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi    |  49 +++-
 .../boot/dts/renesas/rzg3s-smarc-som.dtsi     |   4 -
 arch/arm64/configs/defconfig                  |   1 +
 drivers/thermal/renesas/Kconfig               |   8 +
 drivers/thermal/renesas/Makefile              |   1 +
 drivers/thermal/renesas/rzg3s_thermal.c       | 272 ++++++++++++++++++
 8 files changed, 430 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/thermal/renesas,r9a08g045-tsu.yaml
 create mode 100644 drivers/thermal/renesas/rzg3s_thermal.c

-- 
2.43.0


