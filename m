Return-Path: <linux-kernel+bounces-871228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A62DC0CABC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 10:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 106E04F0486
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47592F6169;
	Mon, 27 Oct 2025 09:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gd7T6P4s"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6DC2F28FF
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 09:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761557552; cv=none; b=dwxfKEQdJ7vsWGIWg9nD0sal38a0t4NrigdKCCDi5yYVtkpqRtzGW9BGQ18ueRvfkg7jEaujYkTn/435u7Oof9k3pLl3ESBwVBd32K7jVfIpHTkXXHjtKXuaDeJ0sOVg148OM+NKznxp61IVLUaI/a/9Rs/6iU5m5PgBMKJhsec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761557552; c=relaxed/simple;
	bh=tOevcamH4dU12q4fMfHEnmz2A1COeCliFA26VQizE1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WFYJwQzClS4Z+4WkwvAHp0quP6mwT0aHjhgJuA9HPVq8hs2NFG8zmxCwig5MSdHtHeZbi2xN3UWJsE45laBjdo18uaSvKRde29Qx62Z2Yfy/6+ugJrhs6pKLWjRBW2kMhpIt75fGzyhz+vyVV0ZVGfEwxzNH3DGGMpKXjSxMZDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gd7T6P4s; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-63c45c11be7so7299059a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 02:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761557548; x=1762162348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kb+oCJFy28PNmi6e8yrO96eaDIYbCEFfqpsOTMY4zgQ=;
        b=gd7T6P4sLD7nBwgj+LF9RdgROZDd9yFLh5lCsXsqjSTrBVOvB/aocOtNAKgsIA0d0P
         1hMHXebDXPPoMv27emIKu+EMdXcjVmNTwQYfbbRgVzQoWfzTwASn/Akqm0Of+vyEMeY4
         ZUHrla4oKtUUiLYHziT23wDtzBlEGT0slpANxu9jxr8+nBSta+dYgk9UuZeWMIVUo0oT
         qC21NaZYcew80PzFCEGRrgZ0ZHe9pQW/hErNqq18C3LYmlezVmHEywiQbnve0EkVlTrR
         2kdiURUkcdvwpm8C7Kfi/hYO+5zg7yjfekMwi9I6Tv9C2lIVRPeOuBvrwocmnG0nRpMI
         nWew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761557548; x=1762162348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kb+oCJFy28PNmi6e8yrO96eaDIYbCEFfqpsOTMY4zgQ=;
        b=trAHr2x6tcdw01+IVJND3yp0Lfm9aRs/KtX8YdyLWJv/WkMbjteUPYdqZn8o5Oz4C5
         9T0LywvwjiA0m+ywYqp348vo0PnTZnZ/GmTvlhpd01np/l6soZ7nsW/sp9O+Lljrp6PV
         pUIBG7bxY6ZihPi8smy4Wd6JtwvRMV9PQW4q4K+5P9V+WHrVJKeI93KfYrE8m998bnng
         0KrnXfqsKDZiPRQ96w7EHGyiHYLcNzA65c3kJC6vOYB+QjOUsHqDZaNIuB32r4b4wYod
         43NzRj46bzNKhNZU8AuRlSYwV0YAY9M0QYEZCBy1eIJcwWzS/RyLo3KyMZIn0wXjlQwT
         7V6g==
X-Forwarded-Encrypted: i=1; AJvYcCXw97/mB7y/IwwTwtrNsPjQrS/tQGGV8OSMESJHUEkQLmFaVXiLwjPL7EAOjcVXzJnML6ZKYKKsmVmAwGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvAw1IXKLauLes67zAWJaDvUNXLTS+WhbzERfIPsCIhDXyEgFR
	hwCd3elDi3TIdJHY7sep0cytjmA9j8qlBgF3hY45SesjzJ8zFeAqK9aYtUwJ2A==
X-Gm-Gg: ASbGncspEOtXRPRFnFgPaHQSVgD6S2SUH3t/qso/lXYciCkDaydOh8n3xDtpHl5B4U6
	/0UjMK4mBN9pWt/XQ9aUmq15h+9sSg1ZjN8Yu6n+bFG5O3dKnJzXMfwelkFBvz/M2tljlzq2J7h
	mY9cKEcycQixBtWcI96Eqv20Ls3AL871+IfOqIYTyc1kNLB4XvW4B5XTFBrljpcvMyMfF5tyeDP
	sfiCY3WuSvcUJXsdOOVfvT6a/THPAL0lkumqyzgKcxLigRdK/cEVCNHm8WwLw3fvOTciO9zTpLb
	aN06VrIx3wpDNEq/B/274oONw8NyZS/VQsFop2z+XGifobgu+fG1+Z77pH7kSzJwLjXQIffuBRE
	Sr7EzVSy6oQZ00D9RGfyrqk4SGJ0yom68+ZEOaFlNuNvpYkqa1wx6N9fez5YQo/fQSw5S1/dScR
	GeKQ/tnTPjKsLJ1C8YTfw2eEjxMtfoqHMK27Q/Ma8otvC+mtgkEtSPq1vE/mcIvroE0IZnvX2ou
	Qrb1h6FCok9orsc
X-Google-Smtp-Source: AGHT+IHTgGv4G/+wFJOtkWMD7ZAhCWVQTDxphKQmll9bPxy5C1Umq1JWKsBdZD1UJY74GedfpKzDzw==
X-Received: by 2002:a17:907:da1:b0:b6d:5e64:c36b with SMTP id a640c23a62f3a-b6d6fe9fac7mr988112866b.29.1761557547697;
        Mon, 27 Oct 2025 02:32:27 -0700 (PDT)
Received: from toolbox.int.toradex.com (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e7ef6be28sm5681014a12.2.2025.10.27.02.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 02:32:27 -0700 (PDT)
From: max.oss.09@gmail.com
To: Max Krummenacher <max.krummenacher@toradex.com>,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Cc: Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 4/5] arm64: dts: imx8-apalis: rename wifi regulator
Date: Mon, 27 Oct 2025 10:30:10 +0100
Message-ID: <20251027093133.2344267-5-max.oss.09@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20251027093133.2344267-1-max.oss.09@gmail.com>
References: <20251027093133.2344267-1-max.oss.09@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefan Eichenberger <stefan.eichenberger@toradex.com>

Rename the wifi regulator to what is the net name in the schematic.

Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
---

 arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi b/arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi
index abf6d543380c..4234289d4012 100644
--- a/arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi
@@ -77,7 +77,7 @@ reg_module_wifi: regulator-module-wifi {
 		gpio = <&lsio_gpio1 28 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 		regulator-always-on;
-		regulator-name = "wifi_pwrdn_fake_regulator";
+		regulator-name = "Wi-Fi_POWER_DOWN"; /* Wi-Fi module PDn */
 		regulator-settling-time-us = <100>;
 	};
 
-- 
2.42.0


