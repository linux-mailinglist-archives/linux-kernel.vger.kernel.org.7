Return-Path: <linux-kernel+bounces-829159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13160B966BA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 16:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E1F9167B6E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 14:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31B7272818;
	Tue, 23 Sep 2025 14:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BGCVa6X7"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7D22475CF
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 14:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758638737; cv=none; b=QQvajm02+fATjDrdM948e0kekhZPD2bL3Klwx7Hzr4qayKTxzC59lOGu0ZaXLotjRG1X4GuR0SkORkR0iWgWX//CVlhVUd0uP58a1B6N9c3bborEbvMjX4fsJvdHrZB96CX8i3wZtUeuHJyMXKexso6zQn4F7fYFuaQrcH2WrIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758638737; c=relaxed/simple;
	bh=FG2G0j9yMRpJsyLnTSTOBI0IBmgFvNkuE6tgk8O+uWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j7eJrUqVT1lR26X6xWHOCmRDnM+ynRgTl0DF6WVOqajCVkpCAqHS2UZjAaXYz+Wut3NDT/mnyLo0s7Xzjj/RJheWFlasIKhAHmE6xJG05YQFd0SJHsF8LdfKDVlvdGdhyfhRqnr35I/osXGaECZO+pq8edyiGWFsh26ZFsRJsuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BGCVa6X7; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3f1153f4254so1918720f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 07:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758638733; x=1759243533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0aOwKfNY2vdwS6wqcAavDYBOG0gp/iK+khNJ/Lz+BCQ=;
        b=BGCVa6X7qYc5ZVPjdJ3B/ZlE+Y5CFL6hP4EGD26AO7z8Sjv+ag326z+/eSb15GjuxJ
         T88/FVxlveVrpL/ZFzi08J6byiqFTLDOziaxX/9Bo095kHLTw9M9/WVtq4kNyseVHujh
         e435GzOc9P7vGsVK3GPyycfnUBoBpkr/EwByuHgwuSCwvjC5iUmL1N0r3XK4y3EXIGcd
         h76+pnM3nGpFv4t0izaKmIbg2OMTjJ3LPfafQJl9eID+AJzwQKVMQT2dyj4XE5xkU/Gi
         n1y4LoZ4fQ1xsSKeWDbX+YmPAN7mUZ0MvgaoLepsfz0seXKdPvgQigDvgfAnyXcnUbzt
         Snxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758638733; x=1759243533;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0aOwKfNY2vdwS6wqcAavDYBOG0gp/iK+khNJ/Lz+BCQ=;
        b=khS2lnIqfm9kgKo5V3TmjrJ3zIpMvBC8qgQRqZgyhJcF02fw16qqucYKBC3y2jEMCd
         ZlcjOxP4HgFStL2OzTO67+rot7o3UGyyCTDh8TLjNuZDy+Nt+HfTBUHzRvsNvkrqccf4
         NaNLdGdNl4s3QCJ/KLSY83diHTMzEDkpYan19z5TNufeUwowfRnOixxeTIm8KQhFHKnK
         y5nsjnYpSLQXMxO2FliE3JfspHqylpaEIP1wywOjp72/WgChGwOZFqLmzjskAhtuC5Lh
         EcMEWZcHKePf4geKoBAnv/9XIx+T0gDK6FFIwCGw+Q8cFDghqZhv7l23XKqC47EZMewF
         exjw==
X-Forwarded-Encrypted: i=1; AJvYcCWJPLQfs12QSpN7IRjt15VCzGvttDhDFUPMC0/ldRr3/k2qZeIwaNsUNeKLNvBBJemHiOi1UPOil8u4u+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhhCL4aryGcS4ElWZjmSTawNhC93HUdJMenTjtYU74ZwKOzGGN
	L4gR44QJ3VNayyrYqJhUYT+D/SgIHwUVpOqUdfakcnnyKqtmRh0QEbiW
X-Gm-Gg: ASbGncuzJSkj6T+c0InFg+DCGbjNa4tr33geTdJdF1D9Ef+2KqWA9YNOZcOh8+cwENc
	EnEMGhirKrzIeBIqwVioVkyVoE8B7zOz9biILBctyjJew7rmrgfBy756ah5CuH0cbn9M+9i40w9
	PNJ3VWmeSPKUb2ZK3WRAfTu6f+HYU90UGp6rMuuOqI/XLIJ6rIiN9UDR32k74JYu4i3v87VlV5Y
	hReK9unc5dnxObqpQ8wWFVyzdtkvOJnmKUm1g0eG9m/L9+mY22NHWVnsWs49iWMTpFqQFMnWm1p
	pJjzjza/cKIfaJF+djslVx42/UoZpD1P3q27v/B65W4se4+0LaV4zJL6vRo4ziyCJ/S9rrU7xyf
	jdzZQ438JSC84GOMllQMeYleYs4adlxZcAkiqJO38eHCd8RWVcX0O0kt5is2splj3/vgFjKUX2P
	jujA==
X-Google-Smtp-Source: AGHT+IHY05P7YPOHKEC6gk74dg40jQ6ah53p1VKJbL2X1DkEDEeClFCRPiP0QIJXrv+8WCuJmAyFYQ==
X-Received: by 2002:a05:6000:1ace:b0:3eb:f3de:1a87 with SMTP id ffacd0b85a97d-405cc70fa43mr3239608f8f.56.1758638732654;
        Tue, 23 Sep 2025 07:45:32 -0700 (PDT)
Received: from biju.lan (host86-139-30-37.range86-139.btcentralplus.com. [86.139.30.37])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464f0aac3fdsm238940435e9.1.2025.09.23.07.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 07:45:32 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>,
	Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Subject: [PATCH v3 8/8] arm64: dts: renesas: r9a09g047e57-smarc: Enable GPT on carrier board
Date: Tue, 23 Sep 2025 15:45:12 +0100
Message-ID: <20250923144524.191892-9-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250923144524.191892-1-biju.das.jz@bp.renesas.com>
References: <20250923144524.191892-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

The GTIOC4{A,B} IOs are available on the carrier board's PMOD1_6A
connector. Enable the GPT on the carrier board by adding the GPT pinmux
and node on the carrier board dtsi file.

Reviewed-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v2->v3:
 * No change.
v1->v2:
 * Collected tags.
---
 arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts b/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
index 08e814c03fa8..86df67e9230d 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
+++ b/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
@@ -84,6 +84,14 @@ &can_transceiver1 {
 };
 #endif
 
+#if (!SW_LCD_EN) && (!SW_GPIO8_CAN0_STB)
+&gpt0 {
+	pinctrl-0 = <&gpt0_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+#endif
+
 &i2c0 {
 	pinctrl-0 = <&i2c0_pins>;
 	pinctrl-names = "default";
@@ -125,6 +133,11 @@ can4_pins: can4 {
 		};
 	};
 
+	gpt0_pins: gpt0 {
+		pinmux = <RZG3E_PORT_PINMUX(5, 4, 10)>, /* GTIOC4A */
+			 <RZG3E_PORT_PINMUX(5, 5, 10)>; /* GTIOC4B */
+	};
+
 	i2c0_pins: i2c0 {
 		pinmux = <RZG3E_PORT_PINMUX(D, 4, 4)>, /* SCL0 */
 			 <RZG3E_PORT_PINMUX(D, 5, 4)>; /* SDA0 */
-- 
2.43.0


