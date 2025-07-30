Return-Path: <linux-kernel+bounces-751274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE77B16725
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 21:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3F8816A72A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 19:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06DE821ADC9;
	Wed, 30 Jul 2025 19:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X7aq8exH"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81791211A35
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 19:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753905187; cv=none; b=apdKqk231AzGAQ08848N5t3DqjUGfFV5DfFHZJAjF0LmPkY9mWBlvwKBkeQFRo7o+tSBSq1y/eozTXfovwjEHAsf1L1CIiJzVw6z/Gqo99OL/quJpKyTpYNCs2GhLv5BbFiu4MqudITGio17p61MOeoeiZa1toVYo9EcsPPfoQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753905187; c=relaxed/simple;
	bh=zXzxHIWyJeKJO/mkAbjOqDhTJEb6z28ihri+K7bnSjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P8/G8EYRNkENv0W/bMKM8MfBf8Qt3NJKZuK2Kv7/8sm+C1WV24EGQUqMnPe1AVPKrZB1TAbzkUrUNPErEdlv9BY9Co4N2xEKSu8xop9OvbtLe9TgFwrXXdY4SMmtblafddtsf3jhXIWR/le3pFgSRrxd/dCYxtwppB/f4hQTl5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=X7aq8exH; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a588da60dfso102654f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 12:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753905184; x=1754509984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0jXme2m9WwXUPYkqUyJg8c9Omz6UIdvrbWwmPeVySRw=;
        b=X7aq8exHZKzAh7G0x/qdrwY+IgXVuRc9a4QVUbNLDeiyUcbK3kU+7PM6u1AFSsq274
         7NM7h1EiIZ+2tJ/FxME5ar6JhB9Q5TT8ZEPG3Mcrh5/rpEnNwpGbqycm+5/QxO0IS9rq
         eK8o7YBAcVM7Xq5kJlebIAv/rMQWTULdYLJc46pz65t+O8QPZZYvioRuoROQRH/xvFwr
         6wXhC0tQUpBcDKK/ocltkUCgKf5g0X+tELtrNpaEHymOzfrYr8NilsipFfLrwDeA1nis
         NPAHU3a3VoGjk8yA6+7uiv3ET3jF4aGRO+swtZHS7Ro9irwKPVEkZEWZwa9MqCWnBwFd
         qNSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753905184; x=1754509984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0jXme2m9WwXUPYkqUyJg8c9Omz6UIdvrbWwmPeVySRw=;
        b=ZOH1sHKg4mUWN2egkFbhkIUlB+yATuzLXg5XxXeJTlw3WOHw09DqzNzC0it3LZMVWK
         dpJUeEQ7HVqkL+4JEWtHBYvAjeYpcLgxS+Oj4iRgA2PHD5DVOiKpLDlfrVhMpN/I6OuW
         Nsy3Dt9AWgsUbfvE2k8zUyt2RyvGVn/6hPcNuwh9MZvIr1dStCMqtDOlWrqbg4rHQb6O
         ucJfTz4/Kh1yNACqrzaWuP6e3UCEqH4hp6UYoMtxmcswxmGHUppjzSWqD0+INI4cjcx8
         6K9sUuClyL6WYE65xQ/urwKK0GWVG+OD4ZedKeka1pfAFc1lq8ib2FISYvH/9KRqTKVS
         /PhA==
X-Forwarded-Encrypted: i=1; AJvYcCUnbBDsYpOVru1ZjRsuqXD78wP9u0hGIk/sCi5P8OPypyHqZkw15xQ7s5xSezwz/MDDxBxwrV3ZKFtavRA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1moEaLzwXU5/gYm6F8AZceICkICFbvpMX7jv2zojLZcuUksle
	lRpE2zbCnx/C0i3Jmo2n9uKUjf/mlg5VQSVzhAd6L2r/DseK0A4HDzqH49jn6JLbg1s=
X-Gm-Gg: ASbGncuMxgp+S7TBqEzxLZGddRF58INVZ16yovmFu8E/TCupqwCHj0Skz2O5K/p2mfk
	MNGlt8GgexUerZGsISZlnKtcG/GQQtxtASHPVAP6vppxgC+VEi2LFRvt8dC1TNLpQTLmreD42K7
	OrbRgusLyHhMcCkqw0zBS66poA1GQygh+SQzRlg5a/+qtLQh/b8HHXIrIVwuvMfa4lMPozNEfMF
	Gt49v41gJUQMDcTG9BqsusP5Udh0R2xWtZyLn01pQlgpYY0ly8ltDzBGAxQxj8d7U0DLEU7PMWh
	sgmbGGzOLlFpxjE71ipYr4zWpMvPEK+fVyjF+IGfAm7/F8LYIy41US9xL4Opz5OqjnX+jHegU/s
	mH8XSmCQNKb9LxcySeM6K9PAeku7ZLqqmLqwsEXEewIYUEj6j
X-Google-Smtp-Source: AGHT+IFtSLxvTO7Zv8ZiaAd380UqEdsX3oGvM4YuKiKowd0BLbRk/TMTPqH8Tyy/IqqXhQ9v3ow3cw==
X-Received: by 2002:a05:6000:144c:b0:3b7:9a5f:103f with SMTP id ffacd0b85a97d-3b79a5f10b2mr1077841f8f.4.1753905183837;
        Wed, 30 Jul 2025 12:53:03 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b78b26a4dcsm9556193f8f.32.2025.07.30.12.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 12:53:03 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: mbrugger@suse.com,
	chester62515@gmail.com,
	ghennadi.procopciuc@oss.nxp.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de
Cc: s32@nxp.com,
	kernel@pengutronix.de,
	festevam@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>,
	Thomas Fossati <thomas.fossati@linaro.org>
Subject: [PATCH 2/8] arm64: dts: s32g274-rd2: Enable the STM timers
Date: Wed, 30 Jul 2025 21:50:15 +0200
Message-ID: <20250730195022.449894-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250730195022.449894-1-daniel.lezcano@linaro.org>
References: <20250730195022.449894-1-daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable the timers STM0 -> STM3 on the s32g274-rd2

The platform has 4 CPUs and the Linux STM timer driver is per
CPU. Enable 4 timers which will be used, other timers are useless for
the Linux kernel and there is no benefit to enable them.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
Cc: Thomas Fossati <thomas.fossati@linaro.org>
---
 arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts b/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
index b5ba51696f43..505776d19151 100644
--- a/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
+++ b/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
@@ -40,6 +40,22 @@ &uart1 {
 	status = "okay";
 };
 
+&stm0 {
+	status = "okay";
+};
+
+&stm1 {
+	status = "okay";
+};
+
+&stm2 {
+	status = "okay";
+};
+
+&stm3 {
+	status = "okay";
+};
+
 &usdhc0 {
 	pinctrl-names = "default", "state_100mhz", "state_200mhz";
 	pinctrl-0 = <&pinctrl_usdhc0>;
-- 
2.43.0


