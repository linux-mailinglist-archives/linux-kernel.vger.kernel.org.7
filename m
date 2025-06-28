Return-Path: <linux-kernel+bounces-707944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 525DBAEC98B
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jun 2025 19:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F1CC7AC652
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jun 2025 17:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D31028750D;
	Sat, 28 Jun 2025 17:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ReXIuk+F"
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2316226B77F
	for <linux-kernel@vger.kernel.org>; Sat, 28 Jun 2025 17:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751133179; cv=none; b=uO7qIZ6g4Bvx5pscQkCM2Dia9NMpoBDO2BwZuqNSfQL8nUPX7Afin5tTf0qWo+papaIHhzC25VqUooq/ce0x0eNMxjy6pJaOnJ+QWDc8Eah4f1T31snPjV8ZgLpFvYCd5hCaJicwZgWaJAllNwENa5E+YN5Og7I6DfO6Go4mSfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751133179; c=relaxed/simple;
	bh=7PWpuEuUAR02Zc52Tm0NH/qgWVIEjwmy9AreWIhhoM4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dxWraR+A56u+KBIHrs2DAXNnvOxFX7b/TtWls4nz/MzsiBrf3jrEB+fRZrpe59RwnIrwD1zW/R3lab0dln+b6CvENv1UPMrQaS55bZgBOsOO1FEkJWvLUy7c+RaMqP383y3NfBnFsqnI/1ePsuKhNjYTpVxmN/mCxjcpSF4LJqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ReXIuk+F; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2eb6c422828so2246795fac.1
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jun 2025 10:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751133177; x=1751737977; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yyTYXSb0JKXvcs1f1KFZOGpILpYpb2Em3iNzt/vn/qI=;
        b=ReXIuk+FiNwlGP8u1+eynDt23qCkc5ENB6r3oiK64i2VxXtID8dtRoFAQgQAFu8VLD
         lmdSBJJcSsHHSQ2NYMn0Vn7ANtBPnW3nrPtp44JUdEA93tIwIhnDL/mQvrjA/vmVzJ6/
         y2Nj/tGe2yI0zJthWw7Ng0JZAaloVs8mMoPYglUtGgX7QoemXWklltuhEoALYp8StJ8d
         4UjBsWi2BH1E6GyGBsLCINaP6S9otNTZ2fJEViW3Y4SylUkBNMV3brfawUnLbHrBF3PA
         8onheS33+V8J97yyahbqQkwPn/bDswnFUc4R4+O3U2AUl8Eii2QIVYVTeQ73bBgzTnxA
         QMNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751133177; x=1751737977;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yyTYXSb0JKXvcs1f1KFZOGpILpYpb2Em3iNzt/vn/qI=;
        b=MCmcAxlKpFiDSSr2AN8B4UUzCsCVTEZybtI/PhbRhrUidzjYkkjrG7+R350C4DRQmu
         PJf4xnWzo9/0077Z1VEDSkG0nDkzBk6ja7YNTDI/fe/7BqY4z+PThZn0gZf0Zys9OKYQ
         CVD3xQW+WQD3mTUFyeoVEhLJmk4Q4qGUhO7htMAHYmDR5ipe9KwB7TnKxYVYo7YzuKGF
         OtEqaRUrOnKcu3OME4dJpoo+b3iPJCxTOR4d+BLLtX2KHYd5r7EEqya5LoBPqhf5Mw9a
         +PftqMY3cLhY61uW0gWk/kf8HsYnnpsJx5nVknrBtyT4PoISntd5olEoLd10bwh8m9gv
         trxg==
X-Forwarded-Encrypted: i=1; AJvYcCUByfmyN/dcRqWWCcelFvyBTw/9IPnNnrvhAzlT7VmDx5f/s3fNZapR+eT68LyIV7sY7l3SBjJgB/HE4GQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPlfhf2tPwWLrnRiWpvSkBBQKUl9R2yu3EEnd+bjlWLyx8eulO
	8QCx8kzNkFBqwujOJAuuGBF5IHtz3RUBWu2eC/exMjjVa4NYD8O15kOz/XhscCC1mGZuON2NOx9
	9ObIUZSw=
X-Gm-Gg: ASbGncsdGpAZlaXDT6nKnBi81lhXYypoSof/XPb3xNZ7FkVO0k6RWdCS9nawtghZWh1
	CCcmqMow2gKoOA0G5DWwN1EA9aR5rAbIMPkpUiwutyFPSZpv+BeQKnclfwyDm1aelX5eC+eVnCj
	0uaLXrrVzYQsAHc5L3Sh4GICZzd02Rgj/2nf05Q2vszL8TKj1sAu7ZvP14GvepvC5LJivJOVsFi
	l47DXhOc3FZR/oh2/2DAO3xJHO7offK7yYJlcuNP38Qr8z4NMC7hQM9jR4QJxHxts5R1n3tMXpD
	lDWF1ASysMKyYuZGXK2+XUetuqoAbIuEPxSPD5UGhNQSvzfv0WKw421DbYcUE4rJDjpZ
X-Google-Smtp-Source: AGHT+IE2sqyL89nUi3xpEnV5UrwmEcMXOrE0zfZYir2RxeiYPi4H5hWHDJc4RWHFIQ7hzbJ9wYDVLg==
X-Received: by 2002:a05:6871:71c8:b0:2e9:8f40:9ea2 with SMTP id 586e51a60fabf-2efceeb94b4mr7838504fac.7.1751133177215;
        Sat, 28 Jun 2025 10:52:57 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:3092:a48c:b0c6:cbf4])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2efd50b4d84sm1593530fac.23.2025.06.28.10.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jun 2025 10:52:56 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Sat, 28 Jun 2025 12:52:31 -0500
Subject: [PATCH 2/2] iio: light: cm3232: make struct cm3232_als_info const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250628-iio-const-data-20-v1-2-2bf90b03f9f1@baylibre.com>
References: <20250628-iio-const-data-20-v1-0-2bf90b03f9f1@baylibre.com>
In-Reply-To: <20250628-iio-const-data-20-v1-0-2bf90b03f9f1@baylibre.com>
To: Kevin Tsai <ktsai@capellamicro.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1448; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=7PWpuEuUAR02Zc52Tm0NH/qgWVIEjwmy9AreWIhhoM4=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoYCvtwq1KZais2IgqJBuBMO31skW51jTIItbcz
 v1Fa9DINMOJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaGAr7QAKCRDCzCAB/wGP
 wOBrB/9jhalDH/7TQ3R694lxQ2BsxnLQs9c7X0+o8iS9iOTGcBGJJRKMUC5XG36u6MJfi8lvn4w
 fv4w4Kv9KnNvTYKcWuK8FjBuD19yaAuo/GXTe7oD2lK5nLdxU1AxIUGVuhedidmL26QB1bkQrUo
 xTvsAOBJUHPNGWk8ImypiGtUWKUgZPdC6ESjPIZnk6bkwSXWfXptm/9vhCcqU9AjMx44gTxDY3o
 +kThdoKr6aeP0i0nMCs9T33106mnf0aBQ3rv0f7gNCDxm8DvcLrZTnJGFY6UZtv5s/pxxtiX4v/
 bBkqrZa9L0kcLvY+YpK+HkKwMNZTexmZOohUalnfIgZ7Bn8U
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add const qualifier to struct cm3232_als_info. This is read-only data so
it can be made const.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/light/cm3232.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/light/cm3232.c b/drivers/iio/light/cm3232.c
index b6823a5a0860a32a65b6e3e76b4e22bc9cd14312..3a3ad6b4c46860cb401e8084c47d3abe1f3f4169 100644
--- a/drivers/iio/light/cm3232.c
+++ b/drivers/iio/light/cm3232.c
@@ -58,7 +58,7 @@ struct cm3232_als_info {
 	int mlux_per_bit_base_it;
 };
 
-static struct cm3232_als_info cm3232_als_info_default = {
+static const struct cm3232_als_info cm3232_als_info_default = {
 	.regs_cmd_default = CM3232_CMD_DEFAULT,
 	.hw_id = CM3232_HW_ID,
 	.mlux_per_bit = CM3232_MLUX_PER_BIT_DEFAULT,
@@ -67,7 +67,7 @@ static struct cm3232_als_info cm3232_als_info_default = {
 
 struct cm3232_chip {
 	struct i2c_client *client;
-	struct cm3232_als_info *als_info;
+	const struct cm3232_als_info *als_info;
 	int calibscale;
 	u8 regs_cmd;
 	u16 regs_als;
@@ -198,7 +198,7 @@ static int cm3232_write_als_it(struct cm3232_chip *chip, int val, int val2)
 static int cm3232_get_lux(struct cm3232_chip *chip)
 {
 	struct i2c_client *client = chip->client;
-	struct cm3232_als_info *als_info = chip->als_info;
+	const struct cm3232_als_info *als_info = chip->als_info;
 	int ret;
 	int val, val2;
 	int als_it;

-- 
2.43.0


