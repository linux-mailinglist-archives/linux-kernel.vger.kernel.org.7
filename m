Return-Path: <linux-kernel+bounces-898731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DA8C55E10
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 07:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95AE53ADB05
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 06:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A0730DD1D;
	Thu, 13 Nov 2025 06:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pegatron-corp-partner-google-com.20230601.gappssmtp.com header.i=@pegatron-corp-partner-google-com.20230601.gappssmtp.com header.b="u97d0xaa"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C9C30DD21
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 06:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763013672; cv=none; b=KwJ9LkHuxOvtJ0blrHEB72nM80enLMcnKvArc5dPe47bVpQHHqEnvqbMib5b3qaBiCDIpSDj1sR1RlL7tu196cUBjyXCVNmPXk5ZonKv6ClNChNGxvhruCj82kbwwqZTflMCL4i+bdokS1TeE7B1bFwVmd/otUXe4ioL0OdcF4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763013672; c=relaxed/simple;
	bh=dK1xl/b4UAoLoRrQeXXRCzK/3igVQI+rfeqpFOBRBT8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dFDkvyax4ylQZ1WVE259r2EvBDlty+QeZS1TtuYQIKUeuhR5uhFIosd+UallHPAHH0vL/XAXP52FTiN0VcMHrXiY+FVy1HwL7F42buUm5ZlJdZ61c4WOrUIftEAofk/t2Ut/Vl8q9LCM8aB9pPWJ4PI7QAypaYxe9o+eDTXpnl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pegatron.corp-partner.google.com; spf=pass smtp.mailfrom=pegatron.corp-partner.google.com; dkim=pass (2048-bit key) header.d=pegatron-corp-partner-google-com.20230601.gappssmtp.com header.i=@pegatron-corp-partner-google-com.20230601.gappssmtp.com header.b=u97d0xaa; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pegatron.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pegatron.corp-partner.google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-297e264528aso4008765ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 22:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pegatron-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1763013670; x=1763618470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vtc5CAsvdgOiMhBgxUV1K6Ck9xfWTjWbN3Ak0NXS2tE=;
        b=u97d0xaaRhIcnWt1+zjrZkErsNaUT2GyLXd1/a1/EtJRACAwDBmecqOJYjhNxX9RmO
         34zptihja4xnEK+pCWNs5T2rpkQFpxbbAaFFvDgG2ZZuL3zKr/FFNRlG8azLXpXDs0Nv
         NgDV4suIBc+SWNze5GmCD+iPjkon5iAYnMdIuLj0J9Ju3xtqM6v//3jd3jBwWHMHxQh/
         4TmyiPMWtKjC4DjOpKVNolOPeMIwgo5+0dBiKrOko/Mg3x7E/QHqk6flir+J8+0YTIMU
         VsUAknnUucHvyi1PwueU8NGHU0YyjjKLZ28Do7xwRxPJ4ZIhVJaemKkuDsDnLh/Rguun
         FEIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763013670; x=1763618470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Vtc5CAsvdgOiMhBgxUV1K6Ck9xfWTjWbN3Ak0NXS2tE=;
        b=eNhwRKr6aTJp6I2yJ7JeeKMDu7MpWV4FrHDF0Fk3UzT3daWw3eKyhT8A5anETL47cW
         VbfQsP9pWHEfYCZ2XrM/iskrmkGItDie7VS4o2h6uv5nBNmJUcjS/jrYFhED51N/Qdqs
         VBq98rp2Cr1rKIrUoMggcGFvI2wI9OPSk3JL5vsEmKAghW+D6l53EHYyhaqrTt2IYmoZ
         UZXR4lLYXKX73IcmShtdHs7MuO7HDzP6FZwpnWRCbzhvUkvzjgFjIYw3dAKfO/dB9iAP
         BI34yfAvdOOO/i2iqoAr1WHwQLRU7YH/02eNVr3ZPsKYVv8wj6wmX3tGNaM0etO/9eKh
         Z9jA==
X-Gm-Message-State: AOJu0Yz5iDX0y0ebRpw3wXUBy8rOULGejOD3028h8jrUZZdQV42q7txg
	ALlpw8Dmj5kPS0n0vRAjVQAbWQmiw71OZsV+LoG/YDg/X8AqqHJIceUgvf7B5iKuuw==
X-Gm-Gg: ASbGncvVo8F/+bU/bZul+LiXuwHE+Cpw5ghczCYIRTZVkB1Kob8rHNqESZMiXCc1S6W
	g9aHRQrWt57nXU3qLdJfP8eNFSNDPeO5BrnzxjSpcg4nNcK1NUK70DRkeI5ha92yQCh1wKY1XO9
	H6kHjdV3oo6ii3WpKJum4a4uTKwH5NP1fziR3T4nZ6hSrdd4SWyZdGcfVZiTFazXI9ZPqSxfJBw
	ELDxYgWBfUTsrQFGLwFh81TRxGDmWhX3FVslC2nOg+aqsXkxjhA9xVtqAfB+t/SexCH5LffBmqb
	oRfMh4WToneJ7t5SzHRFGk9886FkcIXffCUMX4M3UZB6GVrcszmNb7p5ksOT2FN5Fsv9maH8QrS
	t2vPEjQvh+JBP5yyBI8cw5TDsE7DowDQyjNOSVyRw2UOuSWRujZYDymxgWWAWYR/CytaZ7tVoL7
	hH/0QyE0bI6sLj6JooRF5gK0Ad3UEWomofW6LTB0vf/GkGBckDt09pP690Q1ZJOV2BqYJc+7YtY
	P9v3iWvkQSB7YskRAXlMfzMoR7zQmLaC+DmdPLGoSGSzjY6f8ERM4zZJo0=
X-Google-Smtp-Source: AGHT+IEOgW4WzLorfiWS9/h3w8M7CE2tcP0SiXwL7rWvnUnBimo+o7EywxXlHxzo6V2dxOtii5Q+gA==
X-Received: by 2002:a17:902:e80f:b0:295:6d30:e25f with SMTP id d9443c01a7336-2984edec6e3mr72860045ad.53.1763013670222;
        Wed, 12 Nov 2025 22:01:10 -0800 (PST)
Received: from sw-TUF-Gaming-FX505GU-FX505GU.. (2001-b400-e2ac-65d6-f289-5b0e-1295-0dbd.emome-ip6.hinet.net. [2001:b400:e2ac:65d6:f289:5b0e:1295:dbd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2bf158sm11387535ad.91.2025.11.12.22.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 22:01:10 -0800 (PST)
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
Subject: [PATCH v4 2/2] HID: i2c-hid: Add FocalTech FT8112
Date: Thu, 13 Nov 2025 14:00:56 +0800
Message-Id: <20251113140004.v4.2.I47e9f0b76399e6009854dec06420c20e68e23116@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251113140004.v4.1.I894dde5015f4acad94cb5bada61e5811c5142395@changeid>
References: <20251113140004.v4.1.I894dde5015f4acad94cb5bada61e5811c5142395@changeid>
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

Changes in v4:
- Move change log of v3 under "---" correctly as below 1 item.

- Modified the subject to include the ID of the chip as suggestion only.

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


