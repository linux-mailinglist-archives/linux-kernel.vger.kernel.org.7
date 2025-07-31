Return-Path: <linux-kernel+bounces-752226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04784B172BB
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 16:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F5575841F6
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 14:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716A91474DA;
	Thu, 31 Jul 2025 14:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JuLn8is9"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE542D23B2
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 14:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753970524; cv=none; b=u8bpiYCEectH04aqcX97b81IuJPWfqF9HCzOltcj945kntGZTPtyY6bh4I0o3BSaBYxsCKCVuYhMPxQqGBN5ovjX9yckq5j43ksXBGcn+ZTCDnXO2BirFb34C/LH5Tg1fBfmUxdU6hstFFNajrBODQ+glVO/3rDKy547zgectRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753970524; c=relaxed/simple;
	bh=XlJAvdpOl+lzdvmI0QLsJe4IpCVUpXL32migD58w4m8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uioPGdf6t4XROu9OvM8WbsTT7ogsDbU3f0eSJ62FJ9wZtP3I8CqnYLqhuHtEMMX41oMCi/sr8BaShoefkPsAG/Ew6bqxAUOaDdTugCmSHP+bej2TqqK9Y8Hs9zpD9CQZUD3kFezgqtFhiWyhjK06Bsm6LqHCD0ZBuHXVQ2SneE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JuLn8is9; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45617887276so5686005e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 07:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753970520; x=1754575320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BqjEa6NJuLKhar1Hnx2KGoMXir3yP3J42qYMb2JDkMI=;
        b=JuLn8is9eGpstDitnNwgwlxHxYZTyZy+3EV7DqS+mCWzBKN2RpEm2zqXKCLHI5wu7N
         dfsfop0o3UQ3plGMif+Bx/O8QOk7dN1dbuchJLq6tmeFr1oK2fe4XdXeLQdLnuEVut6A
         xA7P8dIDTH0xbfeAYP/FsN+7S48cW9c8UEVyEMnbRQlfQs01bMyoF2CNqwTfXIxC5vBm
         NIyHKrdPPfgW8j4XkBxVt2/wGMZCclwc/XkF289Ibhnam2BTcSy5NB7k9ep2QCzL3fDx
         Wpn3+pAkgOgnhkhfMnQ4L9ABLmCMy3tfXdk1k9pWZ2PV59nWpYinK+R6RBLqmSHZyjek
         6djg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753970520; x=1754575320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BqjEa6NJuLKhar1Hnx2KGoMXir3yP3J42qYMb2JDkMI=;
        b=TytezhpXIjjTGak2rMLPu42jBI3uL+rcSxKmiZpyJNGgk9gezNTfADUm23HHTHuf8o
         hAXLnMwLIvuM5jfpgeEqWV+BP09QlpwcVRn8M1Q+Wt22F0tef3gxRfEQ4X74ixiVytfg
         6M4QjsbwcEcWB1n7o5seFqSq3DruTH6H+jeTV484qqgoI9Kop0nu8Zc9FU+aXbKK98kR
         yt2w/bUPuapsameZI5gx7lyQXvRH68W5Qow5oCp5ur6B3Uzjh+o7l49WUYmdRvLcmm/X
         4QW58p1M+PqYQJForakLAOJemk/R23W7ant9Ubd1gGoN/usy6u8qbjeFwL6ochi/+grk
         7JLA==
X-Forwarded-Encrypted: i=1; AJvYcCXEQEGT8EWfwoflANmJLdkhNajSV+AOtElMUz+HZyfaaWwrIgn1UtNGhQr0ybN0gIBsEclDtmfllH48jpg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2wWVpG2jap5el13g/o28Nf9tFXrRiHUfL61cyA8Au/UJAvvzz
	5AKoiPtzWYTCIyA7rScz5p7eCvJf6YS9m1QjO9zykZzbHAHPEs3KBR7/8khkk8lPniQ=
X-Gm-Gg: ASbGncsH++XmNVrG0NCG3/qQsPlHBkoLwv+gXCbesimmdR2FOexaMRKVF3m+SojvgpZ
	eqSAf0Ms2MYU1LPBTHUf/S+DOD0wn+lUdwQBw5iQ87AlV1R10cksgyX5aDf0Gav7FSgWUhQNUjM
	9Ss3593FrPsFLjnr2CAnBcKze1wMV2EmewxJ9HiylcNp2RLpYNeG+e6P6M7LfC29b0u97LKaohh
	pxhOUJagWS/c6Z+uhFR4mL1cpCbIqAvRq3bevV0UbWpYHVTcgZ9uAMX8Cl1ZQkJZvWxsvUbF6Uy
	HJjUNpp6gH2F13bnyyVd8Vfnfegl10K3tHSSqabJASDEtxWlI6IX6QEnVJ4V8vcMN8h1FBVP1dA
	zMb2PdrqOY56U/H3n/yCd8s9Ovh1JrA/edGHsKOgaGFv1kv5lDDkFZtawphY=
X-Google-Smtp-Source: AGHT+IEs9xTRBr8bAi6DfE73RMG6wNvvUR3ws14YWGjYBbTlujwfRrxFnpMHFkgHgq+RtECti1PpDQ==
X-Received: by 2002:a05:600c:8114:b0:456:23aa:8c8 with SMTP id 5b1f17b1804b1-45892b9e4bcmr70544375e9.13.1753970518732;
        Thu, 31 Jul 2025 07:01:58 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4589ee57c18sm28121285e9.28.2025.07.31.07.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 07:01:58 -0700 (PDT)
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
Subject: [PATCH v2 2/8] arm64: dts: s32g274-rd2: Enable the STM timers
Date: Thu, 31 Jul 2025 16:01:35 +0200
Message-ID: <20250731140146.62960-3-daniel.lezcano@linaro.org>
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

Enable the timers STM0 -> STM3 on the s32g274-rd2

The platform has 4 CPUs, and the Linux STM timer driver is
instantiated per CPU.  Enable 4 STM timers that can be used as
replacements for the ARM architected timers.  The remaining STM timers
are not useful to the Linux kernel and provide no benefit, so they are
left disabled.

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


