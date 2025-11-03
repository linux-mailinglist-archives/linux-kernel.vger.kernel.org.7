Return-Path: <linux-kernel+bounces-882658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF881C2B11C
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 11:31:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DCB73B4AD1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 10:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C0D2FE063;
	Mon,  3 Nov 2025 10:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dIRx212w"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152142FC034
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 10:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762165804; cv=none; b=t7MZf/tvHCFmRSinJDhK9lmiY7ZpGh2HYKGeP6LoPxmB2X2QS4YSUUnwquAKFrsroy2L0psTEozwRMnpFaaas4SlsAgBZLGPbYc6U3nCeDgMhSlS+kN2aYRVhrxT00VLkMKPa6K8cAQKw5zDTutYZ9pdpYMowf7heDZzbgCWPL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762165804; c=relaxed/simple;
	bh=k9/nI+h5bOtp7UwnkH+5NqaeML64f2gcGu3Wmd92Oi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E7+yl8Ey2MQ9W8RjQCzroGMi39emehDsvRzr63//BgeX47A7Mcx1UGmBgCErYZlOzquFILLv/eHpgpwciUScqkXuS0Z0cxxiwXaQbv8F+BAD8bPbPo/3PrGj4AXVuFYP3Cr9v2BkmJDyopxBdfJqO81QUm0mgr1NPTtBljYQ4cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dIRx212w; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-640b2a51750so1957501a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 02:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762165801; x=1762770601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7uol8SK9zB104eiF162tGqib2QMloTOnkfiMZtp2mug=;
        b=dIRx212wX8G9uDTFtJ8QqC/z5IaT3YlQsMmHA1l8TxuLrtBaU8lsMr0GRV7esYTxrd
         1W73IJ9FiYOzPVPDVSm7dzI2LXHCCCfoYKV7pbKltUet/P/ScG34YkBgPyIhsXvxKmZN
         r4FTAWmcGFiSX4jmqbDGxdSkffEgK+ALCZ5pxK9kPzDjC+A25SZ1ywUk5Xoz02SAENdi
         fcakJaouU9j2h8+3oWE35HumyxMejkg6x/yNqe5UNpc/K4lMUUQ2UxvZKVI+Yb4MlXOt
         NPGOxuKtneOWEO5b8RN8VkY/6Tv30Ht1d4RJggnXFiNSLb5/XKEDmOuwYrQAi/aW8CZu
         Ygnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762165801; x=1762770601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7uol8SK9zB104eiF162tGqib2QMloTOnkfiMZtp2mug=;
        b=B86N92cYdHJOO06a8BgjPqW0I2knO6AIaSoitBQqIBhnorLdd4f6SCiWPee/4+lQ8q
         A573Amsem8dyHVNJfehBfovg57OAK9yktQ54grkPY3TKi5WkLN6XWnsgCZHEidF8eWov
         8c6n9ZI/1a6z6OaTsOqijn2LAsE1ncbq5qJ+cKAUueAMos1/8ICC9RTG4zZ+r6nHKPiq
         p2CZIz3jZx5ocyXILjk0/bXEkZuij5m+PGSG4oMHG29Z4AZSHYOHB/BX9lLrjuerjSIj
         0hm3doZdXVOdM+E6ghFrUGilrJhdyGkl17zsQXRGLEIesbX+zrjgN19P7ktNaM0oZKJi
         xvzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHdpljr3Cs5tFTBkBh8zFVNjNtyBWhU279xFccqPelXigFqJLBAj47NuRfqxeeO748WQpTMQJNvwu52/c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzISihKof1Gx0t6z8ghi1lzemuPYwTyzrC4cWqPVoOIcL8GNZga
	WT6y2NgwXMwyhZKaoEBLyjZJ/ZBxy3dO/4I0A731SCWoGRuJkNSxwMz4
X-Gm-Gg: ASbGncuxbKljcvIC0yvkwQ1XG948chcgfMbNIRBtoAbpAR5i0luv9FF0mMGsrR1Z433
	N4oKur9qnoCUgL89UzVa3Nd1BrJxnSSdDwqWVRgzaLXycL+kYL3pZhklB1UxUrRjiktti+CY2Aa
	2Bp3U5wzX/GahwjhCFcnU0a5BmjTxSuPdZcOJu6uIGlPYxezf1OYoyBD3bchAVPDGuQfttaFCoO
	ZbO/DBwrstzQpFpwX+wobD1lNM0FUhR3YCZZotDfBYwtV6qypAVMZDlj51otDNWAzWa+UQ8zbTH
	9zx9avCNSX3f14ORXWc+c6DF5DqNYMila1Z0Iv9xRTlj3vba3gmhTaPLn1psXo09jl2bq0LwZSx
	m/fwv4JWIf+OeWG69cehpx7KpFhPIr0uWIlZ4cNIWgqbCZgmhbRkfGa11OSrkEx12U/LghjazOg
	LRnYX+u73m1tGEdJN340dUtnKlJ9wq48/C
X-Google-Smtp-Source: AGHT+IFzeqw0ZeFTmoI7Ikvy2aB+JcBqMNqP5GohkKyfHRJfwjd2EG3S5q7dA3xFkhtZeKZ3AHM9dA==
X-Received: by 2002:a17:907:7252:b0:b6d:2682:8306 with SMTP id a640c23a62f3a-b7070198c2dmr1296081666b.23.1762165800923;
        Mon, 03 Nov 2025 02:30:00 -0800 (PST)
Received: from EPUAKYIW02F7.. (pool185-5-253-81.as6723.net. [185.5.253.81])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7077975d77sm1005193966b.9.2025.11.03.02.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 02:30:00 -0800 (PST)
From: Mykola Kvach <xakep.amatop@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Johan Jonker <jbx6244@gmail.com>,
	Michael Riesch <michael.riesch@collabora.com>,
	=?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>,
	Muhammed Efe Cetin <efectn@6tel.net>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v3] arm64: dts: rockchip: orangepi-5: fix PCIe 3.3V regulator voltage
Date: Mon,  3 Nov 2025 12:27:40 +0200
Message-ID: <cf6e08dfdfbf1c540685d12388baab1326f95d2c.1762165324.git.xakep.amatop@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <9232ae8cc8e7eb4f986734c8820f44b7989b9dae.1762161839.git.xakep.amatop@gmail.com>
References: <9232ae8cc8e7eb4f986734c8820f44b7989b9dae.1762161839.git.xakep.amatop@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The vcc3v3_pcie20 fixed regulator powers the PCIe device-side 3.3V rail
for pcie2x1l2 via vpcie3v3-supply. The DTS mistakenly set its
regulator-min/max-microvolt to 1800000 (1.8 V). Correct both to 3300000
(3.3 V) to match the rail name, the PCIe/M.2 power requirement, and the
actual hardware wiring on Orange Pi 5.

Fixes: b6bc755d806e ("arm64: dts: rockchip: Add Orange Pi 5")
Cc: stable@vger.kernel.org
Signed-off-by: Mykola Kvach <xakep.amatop@gmail.com>
Reviewed-by: Michael Riesch <michael.riesch@collabora.com>
---
Changes in v3:
- add "Cc: stable@vger.kernel.org" to commit message.

Changes in v2:
- add Fixes tag and Cc stable list as requested during review.
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


