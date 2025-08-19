Return-Path: <linux-kernel+bounces-774825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE4CB2B7FB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 05:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13CDA5E4EDB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 03:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717D63090EF;
	Tue, 19 Aug 2025 03:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="SK0IFcNx"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43447253934
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 03:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755575351; cv=none; b=USHfyiPKaIuH7lqf4JWtw594se1j2cLp54c76s4fi9XuY4RfbSulb/V0ttQ3g7ykFVTR8XW8y+c60D/mNTqePPjI7fqRFNPdiuW9ZQj5Vkzg7sx1BUmmx1XjQebaznhiLs/qXSQltG6CnOnuuX2IYCdj2cQ+CBn8CAyevsTUpms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755575351; c=relaxed/simple;
	bh=BySrjUWeZWttEYxEcBYXCwbkflh2Zyv8/0xNGM+AD40=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UWpZEqdvj9N/1KQ0pP5emivFMNDoKZDXcbc0mXDdWTy13lBkjIL3POTVyf2Ht9vaQ+CmEzrGyrFHlYJzDMwe00XgJcEIL4S/P53jYouvBBvD9bkGQYpXO5Ont3uzedOOzzULJz7n0BMiRpVtj1xDFzwQjx7VSLepWkF9ns7e5vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=SK0IFcNx; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-76e2ea94c7dso5385227b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 20:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1755575347; x=1756180147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RmdG5DlYugS6q7DtukrVNJuzOFU57fMjmsXm7FON0so=;
        b=SK0IFcNxMzzcT4FTXPFR0yDq4TmtYk7haLJ50Pyx24jTYQbkjGhMuR4DugYSdDlYWg
         osJwkj/mrR4gi+e+7hYm0ZIPuyGFH3cecSdKYHZTaqm75OJ7RQVfmEQaIauBsP2dBY38
         8Ead2X0jqMDOLKr5QODOpflSaOYOdvShv6Z0MruyOLv59209iDWBsT5H7daSbL7zWlDt
         4OrSo7ZBZvP0Cyuch1WPlK7d/fEq1FPdwzU5nOOcvlNWWqa3zomhCSDKo5j4IwnIKtVg
         XIUdq5tpQZcOiZPpiu4LCpWyxYMGyqwZ3SFzIbhxYrcxlXgedvgEbI2AYr048s0tc0M2
         6nTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755575347; x=1756180147;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RmdG5DlYugS6q7DtukrVNJuzOFU57fMjmsXm7FON0so=;
        b=biYTkw7nrEsBOIjdqrs9fuO7OkbSiFkXWr23gWJ9mpHiU+W29oWd/INVvb3LMwMJek
         YuIR35NVMZ5j714Wap2I6/nhBGE6RahiPNG6X4E5tZbyF+r2zWRZkZ/kl2aJt/L+QD+u
         XF6WeH0nlRC7SQqjubtMXvHgqjvetamy0p2BKFyKsibQZzyl0QgzDJG/hXu/mcNT7vrJ
         w5LLx6eVEISAjwTagg4lWp5zmxcDojyFBZ+SxNj+77qNx0oLFk0OmGfxyb4Pf/73DhIF
         dBJsg27QGv4GWiyxbpq6QvZPHnMHX8D7j7R8BOf1XjPwV9ODZGMWt5Pqr895/EiglvMs
         NCPA==
X-Forwarded-Encrypted: i=1; AJvYcCV1hHCg3wp47dOm9itTMcgmQp12qaqvpWDlJ5s9cowiiF4EfDRDNXBvzQDo5nug+wcTZDDmKY2lIKTs718=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvK6AYK8baY6DkEjGUjVX7Kp5HwtfKYpWRXlbXocrbzJXBFHiw
	1X6OPoYXhWbgV0nMZbQSglXegNwe7g0xdDg5WexqtgvhfPEu9eJmaCzvbI6Uh134njM=
X-Gm-Gg: ASbGncuedzP51zBz95aCV0U8hMI6LvHcLaqj34/I5gEjXfp+ZQg2eG03vCgqch4CM1M
	o4YVF5a8wesNX7Z3hXceQvSDufu8+Wmr/ufBwRAkaDdnt0MRut+6/ffE2PwDVhU+j/0wVCAA8+g
	jTeecPlTs3ERebIy863n5fpNG5Y8zmn3UDXufjqzDefl3uIk1PhseIpYo7QXCcdUNRIG4n+lGUS
	p6FxJb7JpPoasdG0LCOyFVQBwpopDAfbBhRtXzD3yZPchekcfuet+PodP2CxH2MN+JaZO7o/XuW
	gxL8FCnc5okQfrc0fuN/hE/9NI2DGMT7oLjKlxYczNKoHZwEkn7gcw3y+6F0qHdrcT56qMURqxN
	v5JTdJxghcqqFnB35MaXYkFzaBGzLi/Gh/3hlFwvGSBrl2B9iAD8/BBlPXNdJp+uyQYshmw==
X-Google-Smtp-Source: AGHT+IFM0Fshz5IEB6AwHhBOB3eiEz7iW0S9l+xXsbwkiYN0l8ttjfsQMj4TzpXSRFsdYflO2Gqf6Q==
X-Received: by 2002:a05:6a00:14c1:b0:76b:d791:42e5 with SMTP id d2e1a72fcca58-76e8110b33cmr1159735b3a.17.1755575347339;
        Mon, 18 Aug 2025 20:49:07 -0700 (PDT)
Received: from dgp100339560-01.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e8538edb8sm28953b3a.67.2025.08.18.20.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 20:49:06 -0700 (PDT)
From: Langyan Ye <yelangyan@huaqin.corp-partner.google.com>
To: dmitry.torokhov@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	jikos@kernel.org,
	bentiss@kernel.org,
	dianders@chromium.org
Cc: linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Langyan Ye <yelangyan@huaqin.corp-partner.google.com>
Subject: [PATCH v1 2/2] HID: i2c-hid: elan: Add parade-tc3408 timing
Date: Tue, 19 Aug 2025 11:48:52 +0800
Message-Id: <20250819034852.1230264-3-yelangyan@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250819034852.1230264-1-yelangyan@huaqin.corp-partner.google.com>
References: <20250819034852.1230264-1-yelangyan@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Parade-tc3408 requires reset to pull down time greater than 10ms,
so the configuration post_power_delay_ms is 10, and the chipset
initial time is required to be greater than 300ms,
so the post_gpio_reset_on_delay_ms is set to 300.

Signed-off-by: Langyan Ye <yelangyan@huaqin.corp-partner.google.com>
---
 drivers/hid/i2c-hid/i2c-hid-of-elan.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/hid/i2c-hid/i2c-hid-of-elan.c b/drivers/hid/i2c-hid/i2c-hid-of-elan.c
index 3fcff6daa0d3..23826cb808b7 100644
--- a/drivers/hid/i2c-hid/i2c-hid-of-elan.c
+++ b/drivers/hid/i2c-hid/i2c-hid-of-elan.c
@@ -179,11 +179,19 @@ static const struct elan_i2c_hid_chip_data ilitek_ili2901_chip_data = {
 	.main_supply_name = "vcc33",
 };
 
+static const struct elan_i2c_hid_chip_data parade_tc3408_chip_data = {
+       .post_power_delay_ms = 10,
+       .post_gpio_reset_on_delay_ms = 100,
+       .hid_descriptor_address = 0x0001,
+       .main_supply_name = "vcc33",
+};
+
 static const struct of_device_id elan_i2c_hid_of_match[] = {
 	{ .compatible = "elan,ekth6915", .data = &elan_ekth6915_chip_data },
 	{ .compatible = "elan,ekth6a12nay", .data = &elan_ekth6a12nay_chip_data },
 	{ .compatible = "ilitek,ili9882t", .data = &ilitek_ili9882t_chip_data },
 	{ .compatible = "ilitek,ili2901", .data = &ilitek_ili2901_chip_data },
+	{ .compatible = "parade,tc3408", .data = &parade_tc3408_chip_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, elan_i2c_hid_of_match);
-- 
2.34.1


