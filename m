Return-Path: <linux-kernel+bounces-721695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E191AFCCB7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 15:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 510857ACBCF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 13:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1B32E03F3;
	Tue,  8 Jul 2025 13:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VF6PYrn4"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B9C2DECB5;
	Tue,  8 Jul 2025 13:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751982885; cv=none; b=c4ijADg+xDLX1SGO3TeEWS3cOFxETK7ts1OPS0a1VTHrTOpX/5qj26JeqVZKh9S/C+yYSk09XsW8pDLLMnq9jrdiqlERDK/S4Dppbw1GTd7iD9hjIK+GafZvfcEEr7P6lOZwzWES5kMXMIKHr0tDJ1T9mmejfDy/DOntZERX+64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751982885; c=relaxed/simple;
	bh=+1R64dbCPXKSNdhsS0mTg44oOFv0FtrwEmKajgqa5H0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NtEc59I2pEEzThKhXR8mWHmmBeC6AbDcBZc1AQeARV020Izz+iDAaJs/JLxTBwfmx+FfZHhoNlc3sGF27D9NmI2/jFqtO214cCDzmw+Ws/609q4RPY+1XyWpYjWPWENDZ7krF1MruMM4QYE2HNjzNIQ6/mWjEPNCk1EqZKwE71c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VF6PYrn4; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ae223591067so728173866b.3;
        Tue, 08 Jul 2025 06:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751982882; x=1752587682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PrxF6nK+mYO5VydcxGnIEhVOlrvvr7ZKNJscXE8JZuo=;
        b=VF6PYrn4TC4sM3q5XoCKZnMfUFhn0Tx9H7UCdsNriUnjStU6T3obzPHgNvfqKNKAVL
         dKz7qKnXPmdz4VcvCskfCGSkR2TAWT3G6ncgPNcTMJIp4QC7DU26E3W5mfDLWxLxZx/S
         eLQDs0mVu0XP2zQI0Jf3q79GSm7pnniERDELS/5GHHN8gEE7SvvfQp2B7A0yhKgUJpMe
         C61SB0Pm5ZdF8tvSr+NY0hEXr4u1NhQO+UVRiFGkqBApXk9w6i/ROG8jX3R1vXM8/yN1
         NH/qsREp/x1VjCAJrB8OSSZa54Wlg8AoR4fRAkyRjgHz7g7+bsqCQpXzx3TcLhAvkDgi
         3rig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751982882; x=1752587682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PrxF6nK+mYO5VydcxGnIEhVOlrvvr7ZKNJscXE8JZuo=;
        b=YD9YWIOfBrgAJTbNAKVSJD4D63e4v5ShAk4k5ByVzKAYkIrijAC1ZiK7m3YkniLk2U
         KE8ISbDLq7eNtdEyT+oC8c9o+rvNxfsx1Zi3xfUpdsndynHhEUhtdjkAy6mGOtWbjZUN
         fEhqqX+w09DuwYqRQiVvekX3iOdy7lwHeZtaWboMn2RDPNOgTOfW/loHZ5Asi/hqS4Y2
         MZaG658kn2IbovDSS6UEh0+xiOsGq4YN+jzoEyIO2h/Cm/G5pS8KtNJG7w/i90JkiPZL
         P8ZAHrRio1+hyuG3CZyJTrgTt9exmJgnK6YMMl0Ln2KuJvZjWuQSQIKJOVIYnM2SR8Kr
         kUDA==
X-Forwarded-Encrypted: i=1; AJvYcCVqn6VSZ0hnBOEra4gzjfNmn10eaRHAJ1rPHENrjaWf5KAEJZjdvU2PNVz7WSdSJdELR2P/jlXvwM0zfoSp@vger.kernel.org, AJvYcCXsKf7Gjg+Ectw+fMH7RqgIlZcAOInegZHfoCEr62ZLhp3OSWO6g+Ld3Gk9XdxMzTndQD9Ji/CiShxq@vger.kernel.org
X-Gm-Message-State: AOJu0YxdvXO6hXQ2ASkaVNpUf7FkTmIONpuufewLXQhlpesCae4A55x2
	y0e+nSHqjSQ8ZvgVhjA4oG8j5gXvVkOi8kcLV6lQQedcw83OCUQAyMf/
X-Gm-Gg: ASbGncuzbcnh7+y143Av80agiVK4awX0VFGvIPYVSxoLyYffsT/CP8JYlYB2LTyHZ3b
	kZ2zSYjcSVT9o5s4aChE/kF7T0wLjRvYhnuPWxoO7Jznemvm2eE7pEnpK9h2JSIVGJ9wDpY/Oj/
	+Z5S8yytcvD/orFujXtcb6WqUcU8nViBOMf3vuUFKPHxmsis2EHnUCJ9fYXfKrQBCoIIRqLYXws
	wugrJTjALQSVrJYtDa/HFVQ+pIR/gNVmmMPo2PIcgpv5dhTWRiRrWJT0ldgBUfXjsWSOtvCZya1
	iy8irma0nxX0uZkT9hfsCZJhY+9tWHh9m9F0dlfyQfQon6LxlHNngYK24TTVEbalgDJQuO4v9Lk
	O/juuxzXPmZEKSsLHmMVMrFbA2dEZiOy2qslWF4LK12LqwSFl2+PXweqR/RnEjRDN
X-Google-Smtp-Source: AGHT+IE/M5dxRM2q5OIUramUmzAa8UWPZ+qACUHBsAkQqnqxLmZ2oTxm7Fg0gydn9CIl664bZfqKDw==
X-Received: by 2002:a17:906:c10f:b0:ae0:b239:7fd3 with SMTP id a640c23a62f3a-ae3fbea03bemr2120751666b.57.1751982881901;
        Tue, 08 Jul 2025 06:54:41 -0700 (PDT)
Received: from toolbox.int.toradex.com (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6ac6641sm910431066b.99.2025.07.08.06.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 06:54:41 -0700 (PDT)
From: max.oss.09@gmail.com
To: Max Krummenacher <max.krummenacher@toradex.com>
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
Subject: [PATCH v1 2/2] arm64: dts: freescale: imx8mp-toradex-smarc: remove gpio hog
Date: Tue,  8 Jul 2025 15:51:42 +0200
Message-ID: <20250708135300.2855155-3-max.oss.09@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20250708135300.2855155-1-max.oss.09@gmail.com>
References: <20250708135300.2855155-1-max.oss.09@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Max Krummenacher <max.krummenacher@toradex.com>

Remove the gpio hog node which forces using DSI signals rather than
the second LVDS channels signals.
The dsi signals are not used in any of the current device trees.
Leave that decision to the actual device tree which will also define
the consumer of the signals.

Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>

---

 arch/arm64/boot/dts/freescale/imx8mp-toradex-smarc.dtsi | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-toradex-smarc.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-toradex-smarc.dtsi
index 11fd5360ab90..bebe19eb360f 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-toradex-smarc.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-toradex-smarc.dtsi
@@ -351,14 +351,6 @@ &gpio3 {
 			  "",
 			  "",
 			  "SMARC_I2C_PM_CK";
-
-	lvds_dsi_mux_hog: lvds-dsi-mux-hog {
-		gpio-hog;
-		gpios = <7 GPIO_ACTIVE_HIGH>;
-		line-name = "LVDS_DSI_SEL";
-		/* LVDS_DSI_SEL as DSI */
-		output-low;
-	};
 };
 
 &gpio4 {
-- 
2.42.0


