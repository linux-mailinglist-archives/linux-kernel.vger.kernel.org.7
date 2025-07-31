Return-Path: <linux-kernel+bounces-752227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28CA9B172BA
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 16:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 985B218C7AF4
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 14:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9672D3A7E;
	Thu, 31 Jul 2025 14:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WrA6Jf80"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC372D3209
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 14:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753970525; cv=none; b=TftliHi4LIVwEcZdGeCMkoCmyF9DdfxtAu0KosRb3IQ7wEZseYLma8EdihtCqfmyjHIZIdXzNGbraGYqJ0HPpCUzRoQjDzMHwOgx6OurFTgiPlrYbcpeoklBvTYfeDSnfueU6sO5LSDQBsr4VyIF3qFEb/mfe4K1kGGac4v0e8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753970525; c=relaxed/simple;
	bh=7oA1q4nPReiJ1yN6yWyAlvE+1mr1Nyp3mcVVwjusBc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SBUbr12xRX0A9PKrhAXpMRQJA76ym62XTOd8Cno5keJHfI+DjOslAWn9+6nEstXzWlOdbCzD8gytqVPmL09meYTNnfxMd5kOAPigWKfLpGH1ubCcabur34m7HJufYq1Uoi6esR+fo9yRZ1Ku3796C3yvn/hr6OHRFLBHdhmihjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WrA6Jf80; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3b78b2c6ecfso624577f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 07:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753970521; x=1754575321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r5FfmuyODRKtH+CNEYfoGxU1JBfNxadHgUzuk0z3tnM=;
        b=WrA6Jf80/MzW6orSfPXYvJQ/8RDPMOVPSZ5FCoBlgxWo1tmkAW6ImiMPj/1pX1ikA0
         7RQe9UED8BQwvKKUOi2DQ7GJGs5A6jJQF41Dkzqhthm7Fxv+D+/u8oxVGKYBFqbOMFhj
         uomE+YyfNvt8VA1dC+KBaDzZc3na4rrzCi4iDRKu7yxOAE64sikjNq8pofjtdxJABeTS
         23BaUGxEYEMcsOfUwmxO+VJOoK/zMOEaAiM7vGcMgADt2Z12mI1nbb4tnSsbX9baubi0
         gidXnJ92KRKf2DsxFdbODAao4KJw6GJKCZ75sJecn/D+FIJREy6MyXxQqVA+V7SBcgOI
         gs1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753970521; x=1754575321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r5FfmuyODRKtH+CNEYfoGxU1JBfNxadHgUzuk0z3tnM=;
        b=CHS0zWdUYd1um4a3ByGm+EvVQwGYEswFFlIBUT9q3lJAwL2aZbN7Rq0f5bXyKVdEqE
         qadpxZZMkQlTYX+Y5QABvllK6GwADowDQ+LAApzEgJ/bqw8tFLOIW1kTx8yMoxghz4pV
         lpGg0Z9er60iIVnrV2u74bvtWNQYes0RzPNnYKTatUz6wJpcOVfb9n1qtZy2hb/jHFC2
         /HZd4PSwuqlcUw8WqZ1Quw2mtHhZUqR9EdeKcRzsX9nsilQchnvUGP8ncGpUeENd+Dtp
         O5XTEqtMvQ5HTz0cld2EHYtEnn/QZHMLYmRzntpyqyqCglvc6kjiqBYwCWiCCXzSc9BA
         DDrw==
X-Forwarded-Encrypted: i=1; AJvYcCUBwGC04fwl3bmGnYjWgteoHDPJoEqL52zcrRovxWBczV67x6vf3Jt5wR01TidHCRtd1nocteq1j4phESk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzvv0q8x4L9gtFLG6ua2myDAj6k+wJb1SdZdoBtDqTXe+8u9RDV
	mTDWmxHpp7Rq8ZfOFd5hlrXhIgT3I/vBvApazVNJ5fcUe3MiM7UcSbjLDmgHAgd6Tsc=
X-Gm-Gg: ASbGncu4FfgjELwLoc063WCTuMr57mpZBnFo7hu91hkyBSEQUUIhHvs/EwCxzBWgP8M
	g3WzyHPvV2LwTISXu5UHu8Oevw9dMniJ/L0NV0Ner0ERaNvtB4p4i/hMp+ClKm80GWvWg0JMij2
	wajcd3JPpfopeIfiXN6kZ/q4jU/qjkHsiyhfZKR0oD3PgNN1MjPpHrHAIOVhUaWOdJSMI+6JwtQ
	R7iNfYuSYC52RmSpLeB7C4H9Ra2hillwWxIDK0il26GWkpFEatB0h89aQWVHIkJW5XfDgWMxZzP
	hgl57e8RAeySA52/FtJTaypy4POgGg7+d64qnZts5k2UW4DiaDXKsSaMCOpFFXzBZBD8OrYkRAA
	SotA3wp9KeauKfpPvbpYY7hK5LiWrn3pPsbn8M+xEBbI3CA0o
X-Google-Smtp-Source: AGHT+IFSB2g77P+JOGuXRChMmlAYoDUnakc0mUqILF6lDO5fOlHpcKD5KjoKBSFMkHDfsG7jcpdOQQ==
X-Received: by 2002:a05:6000:240e:b0:3a5:1cc5:aa6f with SMTP id ffacd0b85a97d-3b794fe9320mr5813370f8f.34.1753970521109;
        Thu, 31 Jul 2025 07:02:01 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4589ee57c18sm28121285e9.28.2025.07.31.07.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 07:02:00 -0700 (PDT)
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
Subject: [PATCH v2 4/8] arm64: dts: s32g399a-rdb3: Enable the STM timers
Date: Thu, 31 Jul 2025 16:01:37 +0200
Message-ID: <20250731140146.62960-5-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250731140146.62960-1-daniel.lezcano@linaro.org>
References: <20250731140146.62960-1-daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The platform has 8 CPUs, and the Linux STM timer driver is
instantiated per CPU.  Enable 8 STM timers that can be used as
replacements for the ARM architected timers.  The remaining STM timers
are not useful to the Linux kernel and provide no benefit, so they are
left disabled.

Enable STM0 to STM6 and STM8 on the s32g399a-rdb3 platform.

STM7 is skipped, as it differs slightly from the others and requires
an additional property to be properly handled by the driver.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
Cc: Thomas Fossati <thomas.fossati@linaro.org>
---
 .../boot/dts/freescale/s32g399a-rdb3.dts      | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/s32g399a-rdb3.dts b/arch/arm64/boot/dts/freescale/s32g399a-rdb3.dts
index 802f543cae4a..467e0c105c3f 100644
--- a/arch/arm64/boot/dts/freescale/s32g399a-rdb3.dts
+++ b/arch/arm64/boot/dts/freescale/s32g399a-rdb3.dts
@@ -40,6 +40,38 @@ &uart1 {
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
+&stm4 {
+	status = "okay";
+};
+
+&stm5 {
+	status = "okay";
+};
+
+&stm6 {
+	status = "okay";
+};
+
+&stm8 {
+	status = "okay";
+};
+
 &i2c4 {
 	current-sensor@40 {
 		compatible = "ti,ina231";
-- 
2.43.0


