Return-Path: <linux-kernel+bounces-764381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5614AB2224D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 11:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5520E3B7C41
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 09:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7982E7171;
	Tue, 12 Aug 2025 09:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mz3rN8xh"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488012E54A9
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 09:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754989303; cv=none; b=GgU1UYtucc3fGnhXqJcPVw1cw7zJ0fgV4HHv9PrfMH4IIZlbM7s3kSl1aTXBDvrqmb0T7e2opevZK5iwM6UaP8X/SZKsO6IVprpcWKnKutAFIc6LYfWw5kMy6Lj2WXz0SrT/s33BSETd4I706H9p+YgNsSQ1XObQ/UYAVF+Auxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754989303; c=relaxed/simple;
	bh=sgGWFkDYS3wfvwEU1/vcI7AebQToAzAPsQJ2/xmGWeM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PCG7MmMih7SSbu4OVkss2aWPIr3x3QvXoRaM5QbCKH2EdC6ZkBddq9QpCqKoiOY0U2d/TICcMfYKAaKoAauwAHXKKuE0lHrpClw6uXMdPTijO1lBxxNTvbbo6izwFxJ/BauRkAkmU1iy1ZPqrM0CgO4s2G6AZEc+7Ks9e/5QUac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mz3rN8xh; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-76858e9e48aso4554257b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 02:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1754989301; x=1755594101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1evk3OmIRtfZwDni9+00QXZ21rdMVrFGcmbyCodTqyQ=;
        b=mz3rN8xhP5gPgFzKD+nSmVCePCZU4ikVKlSeOM8NyHp1/Aw448lJTy0Aa84uBeS6cP
         3s6di1W22+5dRYOIgEPT3c2QBJpND6nnGTVdrYHCFC3JAF1404Ca1emqfRU1HRtmYM3T
         sOq9w0DvkE9Wyi8gAGENzWbdGxidPalDEqcm4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754989301; x=1755594101;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1evk3OmIRtfZwDni9+00QXZ21rdMVrFGcmbyCodTqyQ=;
        b=evGcm/fhoStN7lMDjOq2MbZBMef538w7wqhpxNE8xJktUkv2xVmgYR+kTSA1oUMwsH
         OFIPdhfGui2Ol+K6tM1bq/JbbvwVTvoYgZ2Lqx/FnDKIlCjZUDG/hAybJIGsprb6Zoh5
         GMAP+0YuMfcaq/BeFG4a0Gz9lZ2a17/tD5to7zybCCYWt3cjunA4SKBI7JMJiUejLiCG
         OLzv8kR3xPFzAOI0HzngMOUPGice6DaDZMW72jph3q9NhBpVPboOXQmo1HfS07ZetR2P
         zGQovAlayHb6YfGf+yHwykq5cCzs9AU0cU0M3nvPMB1ApT4Q28+KafWjyGJWB8A5XiVi
         q0Vg==
X-Forwarded-Encrypted: i=1; AJvYcCUViKvPLqVyvROq72sOXp7WUnC74qqLdd9K+H6NzjD6W+hpvMDGiwo1ms9os9vVTz/5VtuXsl9lTEcTF1U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKMO4BWmG56P/MKo+QZT4ReW6rAiUmL7I43b8nC7j15/MPfQT/
	IJI8y+JG32nm2kRoWGV8uhe9D9Gcr413Ua9gSs9B01RXdi76WzjhGFiNi15nKSjcAg==
X-Gm-Gg: ASbGncuVh2PRmlcCAeBq0V1yKl/aY/ydnTj+QCVbPluUXaYXiH3iiRDAVvqTW39lOWl
	njWgJ6qQi0kSWkQJKuyFpfTbHpovtHkuUFxAkGOHaMfR9WZ9WrPs0Y8s8IcxMjmBPAPbrjlMaVA
	BgdlN0WXdBdnhwLSTyuYHkCwgpIUSY80O0f2/SV+F72Pj9IBxvqOM4B13jNL1VlLmUfhxIJGZwt
	aCpuKnYmMB1AI+UxWiULEAjW0ZT9vDokbRo7XZVT1tMKUMcT+g8VOvejIG8YdYvE4cO4zMTxIiO
	TTIy0R6q9Qsx8+E7x+g2PhxD0jN3IDmoWhNK8YDQKz6DJDJoP+++v9GeV5snuCPlSzVdrPmDO0H
	yb5Ty7/8TYVvzWRBkeip2QRff/1IsclM001gS9dsp
X-Google-Smtp-Source: AGHT+IHXmeu6f/qQoZG8o8delXd8Ye6Z0N5pfSw8ONOvc9dDiZfBz+hBlS0QTkCIYV04xBciYh8R9w==
X-Received: by 2002:a05:6a20:3d1c:b0:23f:f88a:c17d with SMTP id adf61e73a8af0-2409aa01f0amr3953648637.42.1754989301505;
        Tue, 12 Aug 2025 02:01:41 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:f81e:7c91:8fbf:672a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfbcee7sm29052518b3a.66.2025.08.12.02.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 02:01:41 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH] arm64: dts: mediatek: mt8186-tentacruel: Fix touchscreen model
Date: Tue, 12 Aug 2025 17:01:34 +0800
Message-ID: <20250812090135.3310374-1-wenst@chromium.org>
X-Mailer: git-send-email 2.51.0.rc0.215.g125493bb4a-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The touchscreen controller used with the original Krabby design is the
Elan eKTH6918, which is in the same family as eKTH6915, but supporting
a larger screen size with more sense lines.

OTOH, the touchscreen controller that actually shipped on the Tentacruel
devices is the Elan eKTH6A12NAY. A compatible string was added for it
specifically because it has different power sequencing timings.

Fix up the touchscreen nodes for both these. This also includes adding
a previously missing reset line. Also add "no-reset-on-power-off" since
the power is always on, and putting it in reset would consume more
power.

Fixes: 8855d01fb81f ("arm64: dts: mediatek: Add MT8186 Krabby platform based Tentacruel / Tentacool")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 arch/arm64/boot/dts/mediatek/mt8186-corsola-krabby.dtsi   | 8 ++++----
 .../dts/mediatek/mt8186-corsola-tentacruel-sku262144.dts  | 4 ++++
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola-krabby.dtsi b/arch/arm64/boot/dts/mediatek/mt8186-corsola-krabby.dtsi
index 7c971198fa95..72a2a2bff0a9 100644
--- a/arch/arm64/boot/dts/mediatek/mt8186-corsola-krabby.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola-krabby.dtsi
@@ -71,14 +71,14 @@ &i2c1 {
 	i2c-scl-internal-delay-ns = <10000>;
 
 	touchscreen: touchscreen@10 {
-		compatible = "hid-over-i2c";
+		compatible = "elan,ekth6915";
 		reg = <0x10>;
 		interrupts-extended = <&pio 12 IRQ_TYPE_LEVEL_LOW>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&touchscreen_pins>;
-		post-power-on-delay-ms = <10>;
-		hid-descr-addr = <0x0001>;
-		vdd-supply = <&pp3300_s3>;
+		reset-gpios = <&pio 60 GPIO_ACTIVE_LOW>;
+		vcc33-supply = <&pp3300_s3>;
+		no-reset-on-power-off;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacruel-sku262144.dts b/arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacruel-sku262144.dts
index 26d3451a5e47..24d9ede63eaa 100644
--- a/arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacruel-sku262144.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacruel-sku262144.dts
@@ -42,3 +42,7 @@ MATRIX_KEY(0x00, 0x04, KEY_VOLUMEUP)
 		CROS_STD_MAIN_KEYMAP
 	>;
 };
+
+&touchscreen {
+	compatible = "elan,ekth6a12nay";
+};
-- 
2.51.0.rc0.215.g125493bb4a-goog


