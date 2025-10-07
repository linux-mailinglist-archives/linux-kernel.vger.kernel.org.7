Return-Path: <linux-kernel+bounces-844311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 745B8BC1878
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 15:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0408B3C71BC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 13:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A4A2E0910;
	Tue,  7 Oct 2025 13:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="pNuHoK4E"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC9E2E0B6E
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 13:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759844247; cv=none; b=ghI+dL+WSiTFoZRO3O9NvFUfz2SYv+6a19TYMVAvhCzfktE23KCf25UQJn7TcM/t3vtqywRHflOK5nICCOjG/DniCjfuMDUIRMN9N09Rl6e1Sx2OyjES9WC4Qa4+Qg6cIJRTf7RlYo4D6561DB3wHfAeHgm9qfrS4JhlzQbjBsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759844247; c=relaxed/simple;
	bh=cUxUchjJqZ9HGjKYpIlmaz36YSiv2DD5GuVZNfeSgh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j0HpCQAXTAidMKPy2A+S7Ohivv2b5bvb487dIpQHRLwJ7z3+FCljUNAeYSUpUNonG0bQ66ECmvi66xegJoI6K3v73hYVPwCyq0vDmjkSVdUjknKBOD1KYZPN2Ygqii4D9GSZgu2Gq57pY72VZ7/4YexoZB3iibNhTEp9sBJpHeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=pNuHoK4E; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-46e542196c7so40806895e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 06:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1759844243; x=1760449043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+4Id5q3wpF7LlskwSU/49ZXvfSykXZK8zUhTZu5WHtk=;
        b=pNuHoK4EaRV/YIqIh7eTgA0XjwgLnjhO/k6vNEEa+VqBj8DFUEo7zNeAfttkXOLbkR
         p+lS0zlaf0OE54dyUXn7D9B4Ze16kfDzUUg8x+sJheR9ZNrbOdEQbiOPyGEusHzReToB
         Pu3Y5k6HYn6sbOuKKynRdvW+WKjdwlOPlG1ryz1sjoX+asLgWh+1hWrd5U3zRvCR5wCc
         BD7Wy0PCgmmeS12YLWr5qucb0Spy8eLEdvAYKjWdS+WcjpRUMGEk/tjsMvJxmSYMmugp
         2KdEhhE18pEWqVhYfRn7WrBgNs/MymrvNT4iYnEsBInuwL/MUpHtVErR+OMoug51B+7J
         cprA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759844243; x=1760449043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+4Id5q3wpF7LlskwSU/49ZXvfSykXZK8zUhTZu5WHtk=;
        b=heRtFA3NJPR/9q0kM5WcDugRe3n9cy+e1U+K1SrX6Dm3g59pCjd04ZUl9HZ0cJgCX1
         Jg2bd5YD6QjQBv7HfKP03LiII332D40W0Z2jQQKWvqZAGErMIgHGG3yWvOZqWIX7cV13
         iwUmyRKHJpSnmX4JEfq4qNLRfZorXdVg3OgFPO9E844Vxfn1t+lFp7zSFKgGCn8/9gOC
         Hj/mR2X3s56CqM1x1ctVuTiE5cYyso20UTYu6lkJpSt0EXCK2XqwWRRNo4w5Dc3SPobO
         VH7D+Tf0gN3nwc+YAXgNZFXfoLVSlNqPxKlLYPg5Zwk7VTXvdWYx4GVo07ZOtIVLYo6e
         Ektg==
X-Forwarded-Encrypted: i=1; AJvYcCWasr/v0Exc20NuWs9Z9bZpyKNFleIppm/oZSXq6RFnWj3iHFOW5WOrm+qMMoB28wyZJzZW7LQX68XsAn4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj0Ny/+LXc+UwqCmpio7wbNyL5R1ANfOLCyDYAn6gNSzrG5CL/
	CN9kBwM5HcaGtDYrwnOTq7GfjdO888uBvoDphC8JWlPcXr3AJWG4u8HrAU/5d5T8Leh/xW1ZNKH
	AsQHu
X-Gm-Gg: ASbGnctHUjKY6vfLzBnFjl5hzReDfm/xcvbWd3+HmREiwpCXhVSjoO4+dXCC27eOqLl
	p9/41RdlCJSibTkfCn8EOYokMxPWNqa7rX1u1b0xNo/2+nonkSRXSt/u0sJHZ+pKmzhsx6MYXjC
	3t7scZbMkL8f2xegsIcv0fI7Yfy/O4xmtUj7htPcu8atLUzQTJXein5jUv1CpNAUJiipxB15R6L
	Ruq1ih3xDYQAOgXEmroL2r4ISJj9g8XZxr4BlrZJpIqBFJtBFJ3jMKSB6vQgTT1ZU5b9rqjuCs7
	cl1RVB0gCWMumFfK+nPZJnEIR9YZoI8oArnHr4iNpFECrcsv78cCRLQzr+f5BwnjaO1zh7AOGPH
	L01R2r0iqoXZhBs8inWXKcvVLKUp6g3Ry
X-Google-Smtp-Source: AGHT+IF5cwjJHPiY/TZQqHJWoOYv2ZL9F/8mleO3QYxLBh5SCar5Iq8CK5vEUS5ZcoQX2NAXmukRMA==
X-Received: by 2002:a7b:cc06:0:b0:46e:7dbf:6cc2 with SMTP id 5b1f17b1804b1-46fa296e763mr15549145e9.8.1759844243119;
        Tue, 07 Oct 2025 06:37:23 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.59])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e674b6591sm272189625e9.4.2025.10.07.06.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 06:37:22 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com
To: lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	p.zabel@pengutronix.de
Cc: claudiu.beznea@tuxon.dev,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH v5 5/6] arm64: dts: renesas: rzg3s-smarc: Enable PCIe
Date: Tue,  7 Oct 2025 16:36:56 +0300
Message-ID: <20251007133657.390523-6-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251007133657.390523-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251007133657.390523-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The RZ Smarc Carrier-II board has PCIe headers mounted on it. Enable PCIe
support.

Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v5:
- collected tags

Changes in v4:
- none

Changes in v3:
- collected tags

Changes in v2:
- none

 arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
index 5e044a4d0234..6e9e78aca0b0 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
@@ -132,6 +132,12 @@ power-monitor@44 {
 	};
 };
 
+&pcie {
+	pinctrl-0 = <&pcie_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
 &pinctrl {
 	audio_clock_pins: audio-clock {
 		pins = "AUDIO_CLK1", "AUDIO_CLK2";
@@ -159,6 +165,11 @@ key-3-gpio-hog {
 		line-name = "key-3-gpio-irq";
 	};
 
+	pcie_pins: pcie {
+		pinmux = <RZG2L_PORT_PINMUX(13, 2, 2)>, /* PCIE_RST_OUT_B */
+			 <RZG2L_PORT_PINMUX(13, 3, 2)>; /* PCIE_CLKREQ_B */
+	};
+
 	scif0_pins: scif0 {
 		pinmux = <RZG2L_PORT_PINMUX(6, 3, 1)>, /* RXD */
 			 <RZG2L_PORT_PINMUX(6, 4, 1)>; /* TXD */
-- 
2.43.0


