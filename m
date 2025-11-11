Return-Path: <linux-kernel+bounces-894726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 954E4C4BB1E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 07:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 776373B9252
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 06:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411082DC338;
	Tue, 11 Nov 2025 06:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pegatron-corp-partner-google-com.20230601.gappssmtp.com header.i=@pegatron-corp-partner-google-com.20230601.gappssmtp.com header.b="R8PlLohW"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0807C2D9ED1
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 06:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762843158; cv=none; b=iak9C4rOJlH5rYLqm21KYEP5QZxyjRML13F3jsTNPVN34yIHuBSwn0X7k5xwVx+/ZXEJjS4mtGbXBIx0RvjZ1S9cUwkbXowSHps/OA9Rg9RWclz4kiIsU3mghZU3AXnFcF8f8D6buS6ecjA4olXmWYaysv5d0He3BizwcyqRTjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762843158; c=relaxed/simple;
	bh=TdjJPkz1hWo2r9tdrjV8C9i3Ye3pn22Wmud56Ap24AY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tuQeGZgHpkKer64mhDpIDxUuQkmi56G0tGFoIN/Oww4VrTMZswJRkdU6tkey+jq3cicTXXIpy6VJY1v3mHo4FWq/9nK7okGRTdzrKYYuU5PKlQsE2fAU6d1flTqzd+ivjC3D5x3K2NJAgcBFPX74kWCTxQxLgNnoI8i2t6zc1Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pegatron.corp-partner.google.com; spf=pass smtp.mailfrom=pegatron.corp-partner.google.com; dkim=pass (2048-bit key) header.d=pegatron-corp-partner-google-com.20230601.gappssmtp.com header.i=@pegatron-corp-partner-google-com.20230601.gappssmtp.com header.b=R8PlLohW; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pegatron.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pegatron.corp-partner.google.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7aa9be9f03aso3371251b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 22:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pegatron-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1762843154; x=1763447954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=539HVCzYtsPJqOodyacxfczakrCXMmx5hlTcSg4yU4k=;
        b=R8PlLohWxJyJ8CzCuZ+ixb07hR0uJ8l4mNwtyyb58oir68o5p+kek0JrhFJcsodmdV
         Hbq8FeU1z/Zlr8BM0oylMJYaY3FRO7VLI7O3bJhr+if+9TeXHS2CZPygbzOAP60z7Esm
         xS5V97sC0qOOkklZ4chbRqsjj0G+QZlC5/iPO3fbzNKp0Oef+AxB25MKJETn8YVZ+HBa
         JqR6alkDATvkUYfBlKj7PdH+5VrcmlpdJTLaAXrc83agisTNemoZKIeuFlUvKlSb6YDY
         Afp4k3u2k7Z37psFafPzqHYGsviIVO7Yzyx6U9AucShtk7FFGfY8/aio2K5HQYylEkxm
         8GQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762843154; x=1763447954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=539HVCzYtsPJqOodyacxfczakrCXMmx5hlTcSg4yU4k=;
        b=cHQcQBmgbu6s4ZeB6MFvXuWBcHGhNV6OUrPUP8WVYEPGsVDAJvhg3txAJz8u0p64KC
         +1KvVif7msT9IygD9Su1MPs1wMYo/t1oDsAbhbwMro/fZIzHF2pqvenQzP9c5Z44jP75
         kz56n9R7PLs8mVRTfOsBCHZowd8n7Xc7fvfpecky9uj9AA1fbnSxIZoZxDg86X9F/Pg9
         alfna7nzeGxI7w2aCmrzEwkSMKbyqubhWt658oJFxnMZ7drfTdBJ1deajGMZSy7FVizG
         6QkdoGIje7uk0qY1GC6+lDbClUApfQ7wLjZdkwV1l1SvDNhcBKgVkWl1LEt39EvbidkU
         Md7A==
X-Gm-Message-State: AOJu0Yzff5Xd4GR720Yj4HIrCNaL5y0N9wlnUTisr/4eaBYkpMTUyQaf
	fCVkM8PUwsN+xACxgXAfaX7Tk7sXHQsjkOFkT+kJnyF9O5eKxZJZxpdzZXO9Qvx37XClVugTg6t
	jpKE=
X-Gm-Gg: ASbGnctjij1JzExBwb6qo0MYsn+n8F5k3O1S91nUA3ouzCpstxCkbXjQGt17dYSrTVp
	8aWhP/00oXBZAQd/EqBAdlB5auyhv4EIrBn4MYpzYwRELKm2WV2ISSYLXf9TiZqa9poXaR1nHZD
	pCZJpw8rM2GYsvekyFHvMHkvLh70K/jDS6ml0N4QUmW4huFuneYxBLICaGxXokFhlbgc0oY7NDF
	yCwQs8YVBdUA0gpzSxUEEU369GX0rNkqoRV/3P1z2SqjqoE55TNwO6MYT1DhQ5Eq6+vdZSshxOW
	9wmpiopvzSZTZ4t0r0vpeYSkKR9GvnxN7fwxJwe2ZiCfw11Nnrfz9ytihepJqiCPE98cpa2AT1M
	hgWnx4A5GyUjpZJwsCzUDTXh9w5MwTvWThCHlXqhG5uKmRZeWQHsfFDJXgj27k9c2gJLpfHVokr
	9j90p5kOpgGft7iY4jFpvIZ2mQBRI4WrYOaYMunQVtVRdsMMa8Txl/tvckLR428Pk3WbjJhiY0v
	ih/ilqw95mH4j3/ppUyljtwtSNU3kF+/l3fxzDt55KaeuhLsugw2Oyg3A1WvBLSaxOE4Pc1kAMy
	sR2/vA==
X-Google-Smtp-Source: AGHT+IFnyvDO6og6u0YFAeJesypLmt9qZ8k5II9mY37Op7AflPX2kiUWHuLaWAwwgHYe4YQ6X6SjXQ==
X-Received: by 2002:a05:6a20:9190:b0:34e:e0ba:7bf with SMTP id adf61e73a8af0-353a13a8e4dmr15478583637.1.1762843153952;
        Mon, 10 Nov 2025 22:39:13 -0800 (PST)
Received: from sw-TUF-Gaming-FX505GU-FX505GU.. (2001-b400-e2ac-65d6-f177-1588-49fc-6b55.emome-ip6.hinet.net. [2001:b400:e2ac:65d6:f177:1588:49fc:6b55])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba8f9ed1e73sm15237243a12.12.2025.11.10.22.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 22:39:13 -0800 (PST)
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
Subject: [PATCH 2/2] HID: i2c-hid: Add new FocalTech Touchscreen Chip
Date: Tue, 11 Nov 2025 14:39:00 +0800
Message-Id: <20251111143853.2.Iad6f93df7a4436f6a84ed7b7493fc468c56ab750@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251111143853.1.I76ee34ac45e1469dbeb11de0d1e47d794af7dc88@changeid>
References: <20251111143853.1.I76ee34ac45e1469dbeb11de0d1e47d794af7dc88@changeid>
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
---

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


