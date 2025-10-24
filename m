Return-Path: <linux-kernel+bounces-869300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7A9C07902
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 19:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 087FC1C4094B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 17:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2862345CA6;
	Fri, 24 Oct 2025 17:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f4HZhtmT"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56B22D6401
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 17:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761327726; cv=none; b=IGL+J52wlJwRhK06qbuUipH2lyCfXgt7apJwMkzTmArre/GvGJ00wYeemVH4DY3NM5cWO6ce1M8Ud7iaRBYms6xDmWT47o/PY5mnOqfHE0FfbNK9ymrcyciH2Ms1x7ml1lsrH7ces7Gtpmi7sULIxvMlZLVF93wHiZGm0wXrGhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761327726; c=relaxed/simple;
	bh=i3jJ7co8m6Rp6VhynG4AQYYabRnZVYzJAJnExjOrQWM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X7/8LWUrgXWTbz3gvz0EavEga2hxqmGM9IYrsfkZj2F6zvLRotNMejxxTongdpyH4X5ryK/0+WzZk/sifo7GRanGkesmlgDNx4LADbpjO/wVKw6BMTZy2b6tqiC3wZUY2JRzNbkaUTJKU6xnj5yb9a7h1qW49/0kRH2nbBPL99s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f4HZhtmT; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b403bb7843eso494488066b.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 10:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761327721; x=1761932521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bzLI87gVSsw12bcRQHm4zXKzF2cdEbYasj1bN4s+jM0=;
        b=f4HZhtmTpl3lqIq+9rAS2gJOwo66mUWkoUDstJElNtDebKt3r3jW8cuXBS6BiQ3e1s
         Jw/w9q7pPx1O1XGhP5B7ruzMhRYP2nuyF0ikdYCbJTh3ZTkisWvUeyI/YyuM5T2W+DEY
         eCe+i3bS/VhbTEbvbIuprBNb8HSJaBd4cf0DX5iUH/3WJdtJZj1TlQOlYL465QfrBGQ1
         KzbjtRRMlGfx6nGTdQ7Nw24AL3CNC7lAut+Mebif+QbgLEnYw0Ct6V5X054OVyYfXLxI
         2osW72SHSvWmAI+WP533T/q4r/boc5BdDdxDqNJupzYpYhQc3yj0F6KI4by7Rw+/dzmI
         D3Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761327721; x=1761932521;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bzLI87gVSsw12bcRQHm4zXKzF2cdEbYasj1bN4s+jM0=;
        b=PD8uLTOfz/mICYQat9d+5jTvv2x64bAnhw0ohcnKOf4cjxjuYr//j0Zzbg7RGZrQoo
         7MqRrqpe9956u6/DFO9w8qJx8WXs004bc0XOKfwS2kZdRMt1te3W7lQEt9XKGwa+n8I3
         eanHlee8smOJ1cneTyzmzVIuqyMMx2slfQLG978oKumlr8gWoE14Jmb6X/l7UDUYgNYh
         t8LxAfvFOUMUlAXGBm6yy11Z22AYYAtuH3cXdoB9MmCnzBe5AvYh0suCXhH5gokb+gNR
         YYrwj3xGDFWM9hiVoXH9/IVraVDCHpHa8pdmD0jA3tDdzFcy/8mxHxM0oyIzOQxxXOx5
         Y4+g==
X-Forwarded-Encrypted: i=1; AJvYcCW6u1LnDb+CrogYznKlj+PYBXWVd9bCJo+70vMxf/4Z0+AdoVe0UXaqXkh4Uz3PN/cMaTJ2HQouG12Qy7c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2wA9L3F4TU5ASzBXjUQ8W5K0/AsjNJifHWTQLOCK+KjtOPkHG
	Xpsu4o5/3wVT+6yFZtLuLc4sFlsazbDJjoLYbtLj98C999rUJWAdrigm
X-Gm-Gg: ASbGnctWbOzcee5s/HwZqESLWkB4wQ+o7+BXE05B2BQZ+jU8PXflNw4nM6lD1g/l/FQ
	hz8yMbwo/0knczGNxgyntkykP5PLGXIQFRWi0DUH2R1zoYHQ4aP2DSiWo82NjeBkVIl4sOJNp18
	stKbtyTUWoJkmi1goseiyRCdfquKpmW3locFax/G9MbXV7KJY4gMPxtJb9tXxpGcUZ6Us0bv7vZ
	VkKWYiEoBdG0xjuiOQLM15WiWpu9AftPxJzkx7Yf1n+1Z8R+GOVd8n1hTMUtLqiDzp4KoCODjhR
	u72Cqu2Nmj9kIVcLJzpqRvntKgw8P7lIKdenVbGpizWGqxYjTEUdYHUlc+OXv9QUZk8fORN5I3k
	D5VIzrGY7te8Ji4lyGUOXiNaRD9ypKfmpbfu7x49ZG3Gii5a4ZxU2Q8m9MEXE4ltxSdHih+txsU
	7ZqBn3JKG0JIXpJgrKNSSy7m/joqLdXKJ+lee6yBQPJI2NsEcDF/+ug1kR2wI=
X-Google-Smtp-Source: AGHT+IGsywe6fvei+hAvPha34NkEyxNo/q2u1ZRQacwWPUUZaTx/YX5nzymYXv40loyt4fMWa8J9Eg==
X-Received: by 2002:a17:906:fe45:b0:b60:d888:32d9 with SMTP id a640c23a62f3a-b6471d45a8cmr3700021066b.11.1761327720554;
        Fri, 24 Oct 2025 10:42:00 -0700 (PDT)
Received: from alina-IdeaPad-Gaming-3-15ARH05.. (pool185-5-252-158.as6723.net. [185.5.252.158])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d5130d517sm586822666b.3.2025.10.24.10.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 10:42:00 -0700 (PDT)
From: Mykola Kvach <xakep.amatop@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Cenk Uluisik <cenk.uluisik@googlemail.com>,
	Johan Jonker <jbx6244@gmail.com>,
	Michael Riesch <michael.riesch@collabora.com>
Cc: Jimmy Hon <honyuenkwun@gmail.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: orangepi-5: fix PCIe 3.3V regulator voltage
Date: Fri, 24 Oct 2025 20:38:20 +0300
Message-ID: <20251024173830.49211-1-xakep.amatop@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The vcc3v3_pcie20 fixed regulator powers the PCIe device-side 3.3V
rail for pcie2x1l2 via vpcie3v3-supply. The DTS mistakenly set its
regulator-min/max-microvolt to 1800000. Correct both to 3300000
to match the rail name, the PCIe/M.2 power requirement, and the
actual hardware wiring on Orange Pi 5.

Signed-off-by: Mykola Kvach <xakep.amatop@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dts b/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dts
index ad6d04793b0a..83b9b6645a1e 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dts
@@ -14,8 +14,8 @@ vcc3v3_pcie20: regulator-vcc3v3-pcie20 {
 		gpios = <&gpio0 RK_PC5 GPIO_ACTIVE_HIGH>;
 		regulator-name = "vcc3v3_pcie20";
 		regulator-boot-on;
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
 		startup-delay-us = <50000>;
 		vin-supply = <&vcc5v0_sys>;
 	};
-- 
2.43.0


