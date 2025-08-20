Return-Path: <linux-kernel+bounces-777663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D1EB2DC5F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 14:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C85D316C845
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 12:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EEBB304BD5;
	Wed, 20 Aug 2025 12:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="Qyvl3gK8"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B874C304BAB
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 12:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755692739; cv=none; b=B81wwEqUXQJBo7NiREH6rgsXsZ3hqbEeFgjTVHzAuy7p/lgugcN7n/TZcGTK6xd5JA/z+teHkEKRtl8DLQRTSjkbbXCikAWEctL48TjdYpA+sbEm+7T/Ly/as4o0ILuWDiUJ0FJkdyHt73yZEApEBuANNx5l7QfG7yqgZlXcBu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755692739; c=relaxed/simple;
	bh=CeotG1Hu/ciNhCFkEO+QnBJCoR9/jtz4I4MM+NxZd5U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZmN+ruqxgoUJ97u0TAResD8dKtLGN+9BNSuU9VvX0ujmaFhx9AGPbVohcDnbujvs6awJkWpwFCrb3SIwIY3wG0yENJu1wd9NBuhtdpXlcdo6a3aev0rIzz7HjPhiVOPywdYHpWTKS0Q7C49JYvI7OoVJYUXwGMKcCt7c4fe4DdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=Qyvl3gK8; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b4717543ed9so4336350a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 05:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1755692736; x=1756297536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RmdG5DlYugS6q7DtukrVNJuzOFU57fMjmsXm7FON0so=;
        b=Qyvl3gK8Pz8d64dYAskAbLAAbR4Nr/S0inYIJfdp1QQU2Z7uwsK8+sPiwj+qut0DOM
         2IYn3KF8swri2MQW/1FEvBM/ZXRvPO63OMVVzQknxngiZQ2SBY6TMMseGv9S6Jz75DhB
         z49QQ32XJJ/ddQ9ueSJ0BEdaErBut27OeESVgsjso6VWEnH+G7XKE+zPhZP+rkq7nV/Y
         aKnvMqzPCrADCGhPcCCVuuV1qPiYD8jLv8FMUFt6n+Dz1q9/ECrTe3603gGvF2SfZp4B
         qrMKjwoNS+8vBzLoOA2ckDlNGnOPsQylPMbPOXQ1/X+xEI6grFucxJmHm3xfPfbExBzu
         npIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755692736; x=1756297536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RmdG5DlYugS6q7DtukrVNJuzOFU57fMjmsXm7FON0so=;
        b=eafXLoZ6rxppyhBjEWQKwmSymK1j9FkfbdMWHlpmc/xhftIRIqDZbXY12LQ2DwD75c
         fDMi9T3p074tUMy5nyzKc9b0OPnY5KghWWOsPXYLi0RXNRdYJ/RRVq+4Tw4Sn7kCzTV1
         yzwjRMlntoQxNYNHzzTxc1KM9dYgQO07iTbzkQ2R6iBwfZQ6gbF/dul0rfeXErzzj5El
         sI+UHJWRyZfdfTwGixRWpP57MRulK0OlFAICOdqkfsYu4Kl4dQCE7Iq48e2z+hQxZcbo
         sZqoP1EF4j33Zl2SAsoYrhOE2Bh9KxRWmF7RnYPa+KKY/pas5TBDD7jBURMNtGmLhZ4W
         nT5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVBgs8g173QjuJWEna/mzK0KzupBjYRD8i256UHKWZegeIxKFzrAy/FXTAGClk35pBvF3li1ofoY8MxP1o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJTx6HyhENqSeibADXdqz6MzPVgm88Oi24iE8NJNU5itVfuJd2
	Wo/t8fJsozDmz2o/ZYhwc008o98iOLaubyG4uaO7swsSy+q7DaiL5K3gW2ljVNzMdCE=
X-Gm-Gg: ASbGncvKJ2wAga0ITGbQu/vXL3l53NpzM5OcmGYxIbPTnAhgp9t1o+u3+8uF7J/OxgO
	WD0PWKcV5M17CJVlNIS4e4Fh1JheQFeQ8YNOCuU3ITjd2JtxWDsZjgqRjkuKnsPQBArzMtaceGR
	j89a9Cl6HptPNnp2qeuzaezJt6SdDVCtu0jChSDWfOGu15Rnx35XSm9qBDhYHgnJVk1CIOp1IZM
	lpo7s+jwUJhPYdefzJHOHpS6njeqZIqXdtonDb1BdXrbLAEThLLnbZAo1/L3Ic8rEwQmzpyV+xy
	q4Q9os4Ul3hVeEBxO5TP1qjroDPBZWWpBu5tyIP1zXgjNcPS4HcFDYLVX7rCcV8xM+VDStfXkGT
	njGSX4rhDQ6NFMgIP3tXywRtC5h/XnvXVRP8kzv5E/NubM1SfRaFdUH6D8RbqZycyEY3RDA==
X-Google-Smtp-Source: AGHT+IFWXveBplzBI373wJkuOopt7z07DoZZliYZMmzDqvSeXkhutFQFlIGjWN/Z38FuhMPcgQY3Nw==
X-Received: by 2002:a17:903:19cc:b0:242:fba2:b8e4 with SMTP id d9443c01a7336-245ef27bad7mr39608355ad.56.1755692735800;
        Wed, 20 Aug 2025 05:25:35 -0700 (PDT)
Received: from dgp100339560-01.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed4c745dsm25450135ad.73.2025.08.20.05.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 05:25:35 -0700 (PDT)
From: Langyan Ye <yelangyan@huaqin.corp-partner.google.com>
To: dmitry.torokhov@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	jikos@kernel.org,
	bentiss@kernel.org
Cc: dianders@chromium.org,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Langyan Ye <yelangyan@huaqin.corp-partner.google.com>
Subject: [PATCH v2 2/2] HID: i2c-hid: elan: Add parade-tc3408 timing
Date: Wed, 20 Aug 2025 20:25:20 +0800
Message-Id: <20250820122520.3356738-3-yelangyan@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250820122520.3356738-1-yelangyan@huaqin.corp-partner.google.com>
References: <20250820122520.3356738-1-yelangyan@huaqin.corp-partner.google.com>
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
+	.post_power_delay_ms = 10,
+	.post_gpio_reset_on_delay_ms = 100,
+	.hid_descriptor_address = 0x0001,
+	.main_supply_name = "vcc33",
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


