Return-Path: <linux-kernel+bounces-887480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F18C38577
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 00:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5B18E4EB16D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 23:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A0F2F60A2;
	Wed,  5 Nov 2025 23:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u4WKOYE4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC8F29BD80;
	Wed,  5 Nov 2025 23:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762384970; cv=none; b=s6jhFJvVnMTodVpu7kKmggmN+8O5dox0vVWbPdFlrD1535TtZy1KJV7nSocqVhxbbHLuFlA/3413Ap7gdLCdDbcAkSvuCxJGgO8YMZsSQpotrroEkHn46pHrXwhpEbjMBNuYHI77FF66/5vL15ixd4aPC6XzjOMI0oKhu3NKfsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762384970; c=relaxed/simple;
	bh=AegkBlTWPLHplrOMY76sYBaHhKq8AoJxhlaNcb0ph3s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gLWsD6dUeuOq45AovaZmLwV50fy3dKNn3+bPdNYQum81ndiCXwLxTao3E+vQrfhWF/U/kta4DvNW/vWSv+1IoZIIOVGqwlC3g4M2hhfLQfpXItIYbInUKgaZOdyxU1HqF/EKJtoRAwEbw9K6hUYUcEnB9ZzSu+leHF+TBk8tIdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u4WKOYE4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B06CCC4AF09;
	Wed,  5 Nov 2025 23:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762384970;
	bh=AegkBlTWPLHplrOMY76sYBaHhKq8AoJxhlaNcb0ph3s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=u4WKOYE4oLgKcVuyNGMgvl1Ur38azGDrJWp0vsxJS58IxGm0kxpdLKuVwenvyNj+L
	 maBuEjVDmUzClH1MvxSnbtsICWU4XGQrNL+Ys2F0sdohhlvLWoxd+CMczN8u1ByXHO
	 4MrmwUJGkP1aJxMKItbW3G3qceK1P19CYFlbRPzWMCORartlLyBBhJM09b0aswDQgf
	 /MyJ8Q2n/g+zv0Lhe8E8xRWpzLhUZ6qfnV4eXhr8VfTds6ZqRuFE325aHcDvNoMUIa
	 UMh1WaynzuLbsGk7AXmBdMB7unZNx7zAsVSzPL47sOzao4h4c6p5mDdrxaJsDof3RE
	 1orLbDWexeRaA==
Received: by venus (Postfix, from userid 1000)
	id 44DDC182F6D; Thu, 06 Nov 2025 00:22:45 +0100 (CET)
From: Sebastian Reichel <sre@kernel.org>
Date: Thu, 06 Nov 2025 00:22:41 +0100
Subject: [PATCH 2/4] platform: arm64: thinkpad-t14s-ec: sleep after EC
 access
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-thinkpad-t14s-ec-improvements-v1-2-109548ae75c0@collabora.com>
References: <20251106-thinkpad-t14s-ec-improvements-v1-0-109548ae75c0@collabora.com>
In-Reply-To: <20251106-thinkpad-t14s-ec-improvements-v1-0-109548ae75c0@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1741;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=AegkBlTWPLHplrOMY76sYBaHhKq8AoJxhlaNcb0ph3s=;
 b=owEBbQKS/ZANAwAKAdju1/PIO/qaAcsmYgBpC9xEAoZ96gfKRSYj5JFtmlceFmE+TjO9NVADV
 nld9NxWYVGJAjMEAAEKAB0WIQTvZg0HRj+Lcmp5VBPY7tfzyDv6mgUCaQvcRAAKCRDY7tfzyDv6
 mny+D/9mxOaGXHvXmeTrJbu34jconu+Pc4W17cRYVKvOJgKwcKGTAxIzXyXlSt78DkZWIeB3lsm
 6DTNMmeKrxSL15txjbLTTDH2L+TZ+1/y3ltEfbcwD+bkr7rY5O6ZBxNGLCjo3K+Y7kryIRAgMk3
 yFCf0jfOmREOgXwNcWPyGOkunMjFNdEclGRlfXOzKcH05wj5O+GaDgFFRB0aZCM5WjsxJrx3LPB
 jh5sVA43jy5frB+1y7WIkBnYl4R0MKO+BJCOej9YExWNH+JH1CMctVPPno3/WjboN2KOHhZbsKm
 ZBQRYf7mhXX9mQC9W1bv9yD/W/AlGAksBawwxBkszACDbR+j7OpwO0XaUX14yhzs9NXUpdewgcm
 VAjsc6Xd/44kWlInnDvnR4iZ+vaYgQR10bZJhiUhUMBnhuokJdgcS/kZozZgobnuW6p+R5/7SIg
 6OpyKZiAVaziX+uwtrdVnmsz1ujBKk96J57rfAN+vkXXKvVGThah7V80OfeReMvcI1cUmdpkijd
 FAU4LYbJAMsqRteSU4Q0GnRvd5gM2akBnfFeW9WGITclOwWiVVtyNGQvCHU0BLpxMP+aiaYbAgk
 Z8rMpiA4KhI1KuaqUPbOz1kNeJ4++7D5V6wHvM5Xm6SlDO8w4bQRxrVMm9iA2ijzU+Qgt8pPX1Y
 1dwKL7t/4D+xyCw==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

The ACPI ECRD and ECWR functions have a 10ms sleep at the end. It turns
out, that this is sometimes needed to avoid I2C transmission failures,
especially for functions doing regmap_update_bits (and thus read + write
shortly after each other). This fixes problems like the following
appearing in the kernel log:

leds platform::micmute: Setting an LED's brightness failed (-6)
leds platform::kbd_backlight: Setting an LED's brightness failed (-6)

The ACPI QEVT function used to read the interrupt status register also
has a 10ms sleep at the end. Without that there are problems with
reading multiple events following directly after each other resulting
in the following error message being logged:

thinkpad-t14s-ec 4-0028: Failed to read event

Fixes: 60b7ab6ce030 ("platform: arm64: thinkpad-t14s-ec: new driver")
Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/platform/arm64/lenovo-thinkpad-t14s.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/platform/arm64/lenovo-thinkpad-t14s.c b/drivers/platform/arm64/lenovo-thinkpad-t14s.c
index c1c01b977f2b..cf6a1d3b2617 100644
--- a/drivers/platform/arm64/lenovo-thinkpad-t14s.c
+++ b/drivers/platform/arm64/lenovo-thinkpad-t14s.c
@@ -120,6 +120,7 @@ static int t14s_ec_write(void *context, unsigned int reg,
 	if (ret < 0)
 		return ret;
 
+	fsleep(10000);
 	return 0;
 }
 
@@ -157,6 +158,7 @@ static int t14s_ec_read(void *context, unsigned int reg,
 
 out:
 	i2c_unlock_bus(client->adapter, I2C_LOCK_SEGMENT);
+	fsleep(10000);
 	return ret;
 }
 
@@ -191,6 +193,8 @@ static int t14s_ec_read_evt(struct t14s_ec *ec, u8 *val)
 	if (ret < 0)
 		goto out;
 
+	fsleep(10000);
+
 	ret = 0;
 
 out:

-- 
2.51.0


