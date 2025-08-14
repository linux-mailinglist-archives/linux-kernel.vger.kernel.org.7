Return-Path: <linux-kernel+bounces-769436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FEDEB26EA5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 20:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1DA8A25E8E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 18:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCACF319869;
	Thu, 14 Aug 2025 18:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=libre.computer header.i=@libre.computer header.b="NwSUjG8y"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFAF63B9
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 18:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755195166; cv=none; b=gtAIeBgjlTakYgtegT0cp7gskcC/ZBLzDIfo8a0BSiV9wLyQ/hsPDP19XS74/1gRel/KU9b1FUWJCaZeGHLBCUswiOw2poi6xX4yCCQGgFi9vQPSd0yiQPNLsvuLIno0XuVft6eGRe0Kooj0R+xO9IHoXaWYyK95W6Pmzt3a/xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755195166; c=relaxed/simple;
	bh=ixFsJ3RPHuU/BU5W6UO6O467skwYcxEo8e5gerlA/Tc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uhKXEJY2iU/jX0yhlfh/AKNhZCvJrogqMhBPA+VMxkfTryYMmLZw50taGNnBbi/nrvsupqCihG9LgUOj2U5x9MAqX9tsYoDyvQO5U+Wg12gIFwQ+8f/w5UUAeNNf8Atm/qWsyodoollDlZ2ME7IsmTpC683eDhc4iqsO/L/Pfjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=libre.computer; spf=none smtp.mailfrom=libretech.co; dkim=pass (2048-bit key) header.d=libre.computer header.i=@libre.computer header.b=NwSUjG8y; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=libre.computer
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=libretech.co
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7e8704c52b3so137867185a.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 11:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=libre.computer; s=google; t=1755195163; x=1755799963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4/dZvvhdpeV5T70CXzzhIM2ftvucviNjA+HOyZU3hVU=;
        b=NwSUjG8y5m02ew1jaWglQPvBmFJzJ9KZcTQUsPdCdmiMyXw1LdvDkT2Ey+DO+oj18R
         KLGaHh1pTZecpNBsYl3xi9WT0ibZ5ovLKlMRJfPstzT4TrD01fQk1ZXUVZrCWExzWDwT
         7/Q1r1Ftf67AEJP1qM4Qlrl5rQfcax9/cd5Oa48OqhY4YUk8B8qTx7cg/dTuZN27TgQp
         tK7AdSV8bwQJPrnCmWBxp44PsxIGiRtf8W7AxYS3odPLdtAlixHWLEh4J4FuZ4PlnZFe
         neRgauxt+CJvc+jA+WVV7pm/IcMGopnTpeRQprLv4M6Q27IM6Dlk/HFoqA/AgOS+uv9Q
         8iRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755195163; x=1755799963;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4/dZvvhdpeV5T70CXzzhIM2ftvucviNjA+HOyZU3hVU=;
        b=UtYTlt3awLrutBYbrYZTD3KEjrFCgG07tYoYmNgjLqkZ2aS2IFtRi7HOlwnVKYlJSo
         YcKKPn3XYBeBrjajKgXLFuI+ix+g6886gLrqdpD0zI6qQ32EKm6VNv7DRFsmq/CRrjiV
         JiH1qAAFV3zrggpV8kofvlHlazSfGzJlygsdR1kc+fAA/QvLsTJO5G500SqgBVn/yQqv
         XhBkodcn4qFqpInkNIpDGaWoJ3bff8fOZEkExtOTJ0TcSteTpeWoa2sviFVp4Q6u3xV+
         ChOQiQhbAUHbty1j+Usc4Vcn+rQ2QaKxODMnZd//MvJLZ3K0+atH6zL7uLKg+byRmUNV
         nsng==
X-Forwarded-Encrypted: i=1; AJvYcCWcxynD9nAR27745L/QF5M4irKE/XgAaRSJuj0JxCmSo2ZK41pEsju+7TviICq6YkX3bc9iIgWLHYrx3gY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl1TbUYwzApNYp0HpCs0sZC7WNQ7eE5iCEpO/L+FdDXZ6zUnqM
	ojoAx5VueY1bLgLuz22bzbA1Ins31aaw6SHTfPSBrh8SXwIkQlLm/f9F8OwxI4EfFA==
X-Gm-Gg: ASbGncvvzy+rS8tf5AvdruYblD4QX0hdQceUHDPsMs8x63ERHNo/xcKqRaV34UbK9bd
	ZuJvVl6teX1HfDMm9kaNWp6KlckWEcMYyFQjMQ0S3T4sNMnFwWL1FbJ8HZ4Hg6hTe+X4YB9xErv
	U7CVf+WVBaG/S3+SlDiH/hGIfZC0y7jK6HoknehZdBFLg25F8Id6hMUrM1A/+aZbrzG81QtKnHH
	fKxc/nWiHswpEOGYwPcyscuqtks9XVnb78yN9Lg9cIBmu1R1NKq2CW+bDCVRL6TKh8Kk2rNLtdh
	249UoW/rdfYnTnKIvNg1742ww9Mb4mUR0p7wRayvbwApERseC43j76MhxnWWSaUpVmSyAL6MQ+7
	2C97bdb+k67bdh7aS9NYbvk05SPU=
X-Google-Smtp-Source: AGHT+IHZet1Jvv8jg99HpAw6hDsF8fx3/AYC1SN8lGZ35gs0uFt1zck15oaDyeVmE3ge8wvu7oeH4w==
X-Received: by 2002:a05:620a:4055:b0:7e8:2989:1149 with SMTP id af79cd13be357-7e8705b5fa2mr627043385a.49.1755195163315;
        Thu, 14 Aug 2025 11:12:43 -0700 (PDT)
Received: from localhost ([172.56.29.94])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-70af5c43392sm16269836d6.84.2025.08.14.11.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 11:12:42 -0700 (PDT)
From: Da Xue <da@libre.computer>
To: Linus Walleij <linus.walleij@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Da Xue <da@libre.computer>,
	linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] pinctrl: meson-g12a: add GPIOC_7 pcie_clkreqn pinmux
Date: Thu, 14 Aug 2025 14:12:36 -0400
Message-ID: <20250814181236.1956731-1-da@libre.computer>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Amlogic G12 exposes PCIe clock request signal on GPIOC_7 pinmux func 1

Add the relevant pinmux and pin groups

Signed-off-by: Da Xue <da@libre.computer>
---
 drivers/pinctrl/meson/pinctrl-meson-g12a.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pinctrl/meson/pinctrl-meson-g12a.c b/drivers/pinctrl/meson/pinctrl-meson-g12a.c
index 8b9130c6e170..117e72b4ffcb 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-g12a.c
+++ b/drivers/pinctrl/meson/pinctrl-meson-g12a.c
@@ -442,6 +442,8 @@ static const unsigned int tdm_c_dout1_z_pins[]		= { GPIOZ_3 };
 static const unsigned int tdm_c_dout2_z_pins[]		= { GPIOZ_4 };
 static const unsigned int tdm_c_dout3_z_pins[]		= { GPIOZ_5 };
 
+static const unsigned int pcie_clkreqn_pins[]		= { GPIOC_7 };
+
 static const struct meson_pmx_group meson_g12a_periphs_groups[] = {
 	GPIO_GROUP(GPIOZ_0),
 	GPIO_GROUP(GPIOZ_1),
@@ -721,6 +723,7 @@ static const struct meson_pmx_group meson_g12a_periphs_groups[] = {
 	GROUP(pdm_din2_c,		4),
 	GROUP(pdm_din3_c,		4),
 	GROUP(pdm_dclk_c,		4),
+	GROUP(pcie_clkreqn,		1),
 
 	/* bank GPIOH */
 	GROUP(spi1_mosi,		3),
@@ -1183,6 +1186,10 @@ static const char * const tdm_c_groups[] = {
 	"tdm_c_dout2_z", "tdm_c_dout3_z",
 };
 
+static const char * const pcie_clkreqn_groups[] = {
+	"pcie_clkreqn"
+};
+
 static const char * const gpio_aobus_groups[] = {
 	"GPIOAO_0", "GPIOAO_1", "GPIOAO_2", "GPIOAO_3", "GPIOAO_4",
 	"GPIOAO_5", "GPIOAO_6", "GPIOAO_7", "GPIOAO_8", "GPIOAO_9",
@@ -1309,6 +1316,7 @@ static const struct meson_pmx_func meson_g12a_periphs_functions[] = {
 	FUNCTION(tdm_a),
 	FUNCTION(tdm_b),
 	FUNCTION(tdm_c),
+	FUNCTION(pcie_clkreqn),
 };
 
 static const struct meson_pmx_func meson_g12a_aobus_functions[] = {
-- 
2.47.2


