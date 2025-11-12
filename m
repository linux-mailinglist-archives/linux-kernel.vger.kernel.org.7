Return-Path: <linux-kernel+bounces-897167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D73C522EB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 13:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BD731891B9A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06919316195;
	Wed, 12 Nov 2025 11:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pegatron-corp-partner-google-com.20230601.gappssmtp.com header.i=@pegatron-corp-partner-google-com.20230601.gappssmtp.com header.b="WHHr2x7s"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00A8315D5F
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 11:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762948761; cv=none; b=FPAk/hXhHL7DrrVVTpHz7xFbIEFiP8egFJS/0l4mbpTbd3VNeSzWXJDkDW4x4W/0YdYDf5+SvvI30oHtij+M95DgbCFNI9npVYaDYsz7/s/zpKBDfrJIF34GVMUSZ45mV5ZcP7Ppb/pT6YDmcitr18fOTxIqmiwBcocggwqS+4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762948761; c=relaxed/simple;
	bh=6GlgB1rT+FlncACmdH++HfYnLRqCO6n3Y9XoBOKkvk4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JjQa7yIKlq9wG9HvdXNJBnYiUvF6q/5LB6o2CntQj55GdUYLzV10FpXU2EA9bNm5SUSdSu84U70uaj95+eCAuv4qQ0TEfe8GV6GGYi6znOLaqIV7ZDSSTGSMg8xpP4bNpYl+h/Y/rJ2sfRsnPbiCawR0QIlhffel/rNbBRHqFKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pegatron.corp-partner.google.com; spf=pass smtp.mailfrom=pegatron.corp-partner.google.com; dkim=pass (2048-bit key) header.d=pegatron-corp-partner-google-com.20230601.gappssmtp.com header.i=@pegatron-corp-partner-google-com.20230601.gappssmtp.com header.b=WHHr2x7s; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pegatron.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pegatron.corp-partner.google.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7ade456b6abso632799b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 03:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pegatron-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1762948759; x=1763553559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V8XgLJwaQ5HvJefrgxQNE5WjrBzwyM84xyEyfeQWOzw=;
        b=WHHr2x7sUGhnea3e2vjNEiMwPAIFBxQLNtG/6LW+W5ShbZdlvdYz/mbz9pzYacZqoU
         C9rRVFifJt1L29QFsEH6objIYRQ4cMtPgpEwop6a5h27eXDX8QhgpM7uVxdYyxF2lrCJ
         7wX82OvCgBncJdUBlxLgXpVGYyKDDM0peW4K2dfgUGtjo5kcO3MGev0icNkKoDRSeOnk
         twpbqT2q99NYcRDtwuOYSao8fQF9jlPcBhttXUtP8/kgtZfvBMf80Lovwoivh8aOCq6P
         Zpvrc4BpY/3d0SsD5LMZxZolNU6iMXuIQOCkbJ2VniQqugph6ZM6VoaWFKAXN9dsPZ4Q
         JxIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762948759; x=1763553559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V8XgLJwaQ5HvJefrgxQNE5WjrBzwyM84xyEyfeQWOzw=;
        b=mJhMNqd+YNSe4lT9FVpTWjElvgi5ieqhI3iHFADGkNfZzSXaD4SyJddi10c/d2zqbP
         KvYQnyXhEnIB5INJH8eJj9Ehc5MswtS4XREHOAC4k0RqvduNvcRcXv74dxw5o/10sScS
         AyFT4PmdLWrpgLuahNTglh2O5fRqcoUN6cN5tZRlZ9XbWZliFIdje7h04/mWold4QZc5
         fdGGA6d29shHDyvw71BuvLv6TD5jE7uTs1QVuMf3TAq/xt4QGZe2vbzQ/daUQLSuZHkp
         gs7g8rkCjAHtqT6rdWhKGUaErGticpAvbCb3sBFVmk9Lp6aKO+zIZF7UBEjQalQ6vq3M
         w/Wg==
X-Gm-Message-State: AOJu0YxxQptIxteJDeLxeCBn5r5XA00Z/DKvDyLhXeyjpVHDDlXqB9vU
	8qs3HJcJUXxuYlqX1TTYDlcrX57GM32enW7G7KcfZp5wNh4PL072qHWXpQTta5WntA==
X-Gm-Gg: ASbGncu++G1sPVmCyCmoiqqGr5NHWHuIeA3cPpdD1w6wAjNRtuEd3wIyZIP3oXGDMH2
	MxgqJ76pz2fZWHrk33H1aoJxVo9Z1WEUvabs7GWrsD164FlApuUg1K3/OHWgGDkheHPqAJvvZSw
	aP4Sp0afQfeIdjTiSfP+f8g/gfG0nVa9j5RX+Rl1FGt1RKc18mgE5IX06tnLM+Yo0/DjXNhwpRq
	PE5PGwUJUReEkcIfcc/NEnlaHOkZ3WGS/FkMQwtIrTFi0kaQuujpaTBxTtfSdXzPXs2/rlWjINQ
	gQI2uJszl5DkJSWWJLllnKxLCPt0jxiCGCVPnOnj7M6JrlV85bdZh2iT9oGH7fybe6KFlqZUaM5
	yKogox40fG1Tf+yRmowlmmhwm4aKADjdvMaehbCpazZ12y+LDzkQuNo8rm1fuijeoDelmgU3B8W
	6pK058y+3iHHeiOGzF9uksvllzCTw0OROHAJGtOEFQ7YG87Eln6SUzvg/B8eztjSW9nQ8pZAd+4
	58tyDDNLGG/q1xPjUaBqSWkrvmGxqrof6K/3L3lFHICgKcUzDYPQ8Xfjog=
X-Google-Smtp-Source: AGHT+IEXnqzqJU2/xSKNSNb5/bUNtAFElTLMyvo5uXdKTcAl/HefKl0i4M7zof74OyKG22fyZ0IfKQ==
X-Received: by 2002:a05:6a00:80b:b0:7a9:f4e1:51fd with SMTP id d2e1a72fcca58-7b7a4afac13mr3390566b3a.17.1762948759071;
        Wed, 12 Nov 2025 03:59:19 -0800 (PST)
Received: from sw-TUF-Gaming-FX505GU-FX505GU.. (2001-b400-e2ac-65d6-840d-05d3-e7aa-72e2.emome-ip6.hinet.net. [2001:b400:e2ac:65d6:840d:5d3:e7aa:72e2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b2c83906e5sm14278922b3a.71.2025.11.12.03.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 03:59:18 -0800 (PST)
From: daniel_peng@pegatron.corp-partner.google.com
X-Google-Original-From: Daniel_Peng@pegatron.corp-partner.google.com
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Daniel Peng <Daniel_Peng@pegatron.corp-partner.google.com>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Jiri Kosina <jikos@kernel.org>,
	Pin-yen Lin <treapking@chromium.org>
Subject: [PATCH v3 2/2] HID: i2c-hid: Add FocalTech FT8112
Date: Wed, 12 Nov 2025 19:59:05 +0800
Message-Id: <20251112115913.236498-1-Daniel_Peng@pegatron.corp-partner.google.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251112195751.v3.1.I894dde5015f4acad94cb5bada61e5811c5142395@changeid>
References: <20251112195751.v3.1.I894dde5015f4acad94cb5bada61e5811c5142395@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daniel Peng <Daniel_Peng@pegatron.corp-partner.google.com>

Information for touchscreen model HKO/RB116AS01-2 as below:
- HID :FTSC1000
- slave address:0X38
- Interface:HID over I2C
- Touch control lC:FT8112
- I2C ID: PNP0C50

Signed-off-by: Daniel Peng <Daniel_Peng@pegatron.corp-partner.google.com>

- Modified the subject to include the ID of the chip as suggestion only.

---

(no changes since v1)

 drivers/hid/i2c-hid/i2c-hid-of-elan.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/hid/i2c-hid/i2c-hid-of-elan.c b/drivers/hid/i2c-hid/i2c-hid-of-elan.c
index 0215f217f6d8..b81fcc6ff49e 100644
--- a/drivers/hid/i2c-hid/i2c-hid-of-elan.c
+++ b/drivers/hid/i2c-hid/i2c-hid-of-elan.c
@@ -168,6 +168,13 @@ static const struct elan_i2c_hid_chip_data elan_ekth6a12nay_chip_data = {
 	.power_after_backlight = true,
 };
 
+static const struct elan_i2c_hid_chip_data focaltech_ft8112_chip_data = {
+	.post_power_delay_ms = 10,
+	.post_gpio_reset_on_delay_ms = 150,
+	.hid_descriptor_address = 0x0001,
+	.main_supply_name = "vcc33",
+};
+
 static const struct elan_i2c_hid_chip_data ilitek_ili9882t_chip_data = {
 	.post_power_delay_ms = 1,
 	.post_gpio_reset_on_delay_ms = 200,
@@ -191,6 +198,7 @@ static const struct elan_i2c_hid_chip_data ilitek_ili2901_chip_data = {
 static const struct of_device_id elan_i2c_hid_of_match[] = {
 	{ .compatible = "elan,ekth6915", .data = &elan_ekth6915_chip_data },
 	{ .compatible = "elan,ekth6a12nay", .data = &elan_ekth6a12nay_chip_data },
+	{ .compatible = "focaltech,ft8112", .data = &focaltech_ft8112_chip_data },
 	{ .compatible = "ilitek,ili9882t", .data = &ilitek_ili9882t_chip_data },
 	{ .compatible = "ilitek,ili2901", .data = &ilitek_ili2901_chip_data },
 	{ }
-- 
2.34.1


