Return-Path: <linux-kernel+bounces-820204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB18B7EB7C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AC481C04CC5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 08:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECB0309EE9;
	Wed, 17 Sep 2025 08:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="q36z11gy"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2593090EC
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 08:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758096348; cv=none; b=LACq/94Y9i5MY1u0+TQIPulZvRkTdY3eLQucp6sGRSkkY8H5t9YoIJZVaLdpVxKDt6+PRXN4k15YNuaKp+GBR8+Zlqhsuprf/lQElQ/YMBbw/YiwPZ4JPW4QlyaWIzqAqWOxg08z1vsXFDdkh8PJULlQ4X+SHCoBZ3lxnpZItsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758096348; c=relaxed/simple;
	bh=7R8rcOL3f1HwsUpPHaL0+BUAREAOiXb98Mm1tlgtyCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hlKOD6AsHNMaexoV4ZAO+Hk/GaBuMm3IXt/D8JG4ol/oNcPxYDnNLQ2jLCBxAEAivV3NMnSWD/haKyvAnSTFnwJ5eK2RodlkCCuJYW5c2RypfbWIqzw3AlQVFzWiAxOqi3qgG1/ggUVs4WcT1lewIEYPYg3g2NqJbXgsYoWmCzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=q36z11gy; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-62f1987d4b2so7497417a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 01:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1758096345; x=1758701145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AJ9ovkCr6DqOwPekQL9mbbfb8pXGwCeM0TnyH7IdLxU=;
        b=q36z11gyZrdNTE8ezA5OM6xfLtFubZzXQHslewyItv73P+DyAZK2z807Elnw8XdVz0
         Nhjpz8qu7Z5voY8lAnbNIPTNUZ56qhlnySlqfsBbF5/BaABG4seDea8xe1w4V+aKrYMf
         tJFElNWsT+5anTkHkvv7R7tqPQoy1KW15IF2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758096345; x=1758701145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AJ9ovkCr6DqOwPekQL9mbbfb8pXGwCeM0TnyH7IdLxU=;
        b=AxdYXjv6kXP4OLLhUzayH14HJVmfqNkMfHSKxe1DYu8mtKN9ox/LJIit5NHRzkZ5D2
         Hg87OjxloLJNQhKAZMQSuN+WkrfXm31/c2IXJQoPO1CKv/aSmkU/rRs3p/O2Bt2W8NHW
         kib3EDeZ5yYVVSJEGqo229l0PBQt7lwAon6+c/tOe0ln20laaSK8SUTZzh4ev8d6JzH3
         0YMYR/gyX4CtyJR+nHUe5KM/SYd5pN+mSVEz2qjpv8gj4O58Iy7fyjA49ZMwAUctORuN
         7lZsHNAlanDw9U6+Zx9bjaqPEQhmiORr6Y/hfDODGgF67nmdPlaelY1z2Fg4hD7NEknC
         klpA==
X-Gm-Message-State: AOJu0YxNNBB1zn1YOnp4Au93BHMskWDNczs8xhgtKWtxDo6qkPUT+ayB
	aap0nwO9HATW9XMzF5XnJD75mfp90XAXMIYydFqlA3qtkGLgZOxgQz/J1k8H6CTdLhq5c5d4utZ
	UFZTo
X-Gm-Gg: ASbGncsKqCH7w0IA24KuHe/3oPY84sRkQGNBmmu2PcyVgu4oquZaY6X3EKRSt3XeGP8
	VF6sLaVctD8cWqB6rj3MvIEQSB4MifV5QoUv6Fu/BOBxu+x5caHAIyNhBhurH4Fh+ew2MU2X/qf
	z5tu4fwBsbxyYkux4CuY8RfAHRAmpNkyeqfPD97ne95x8y2O/oT9HviJFP2N8KtjX8RvvxsAyhr
	bxGFZi0EC5etDx2jDBEI4+ZZme162P3J5jVurEM3vpLnsYXf7rg6zZahzg8X6ZCfcTw2MO0bdJV
	QbR41MVwVmkaXwnb/jPq3HESH7PXHXxvduiUO1Yl6Ow3RbJpy2YLIurlMk1OWl7UVMtT5BtjKfc
	PE2hOCiUW8D69VXZZQFMZHlibPb8XQxOhtWc50Bmw2Vx3pG+ksKG5nnEJzS8=
X-Google-Smtp-Source: AGHT+IFpWQS4pkyL9m52u+iXkDhG4zfzNZwzj6DCSRH4/FjXB7Y5wWH6XeMryYi9+6RpKzp0CFw1UA==
X-Received: by 2002:a17:907:3f1a:b0:b04:7107:9758 with SMTP id a640c23a62f3a-b1bc0e86595mr153107166b.43.1758096344821;
        Wed, 17 Sep 2025 01:05:44 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6474:ebbf:1215:4a13:8ee5:da2a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07e1aed5ffsm924936766b.81.2025.09.17.01.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 01:05:44 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Frank Li <Frank.Li@nxp.com>,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 5/6] ARM: dts: imx6ull-engicam-microgea-bmm: set touchscreen glitch threshold
Date: Wed, 17 Sep 2025 10:05:10 +0200
Message-ID: <20250917080534.1772202-6-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250917080534.1772202-1-dario.binacchi@amarulasolutions.com>
References: <20250917080534.1772202-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This way the detected signal is valid only if it lasts longer than
62 µs, otherwise it is not sampled.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

(no changes since v1)

 arch/arm/boot/dts/nxp/imx/imx6ull-engicam-microgea-bmm.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6ull-engicam-microgea-bmm.dts b/arch/arm/boot/dts/nxp/imx/imx6ull-engicam-microgea-bmm.dts
index 279d46c22cd7..f12084d8f2a0 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ull-engicam-microgea-bmm.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6ull-engicam-microgea-bmm.dts
@@ -154,6 +154,7 @@ &tsc {
 	pinctrl-0 = <&pinctrl_tsc>;
 	measure-delay-time = <0x9ffff>;
 	pre-charge-time = <0xfff>;
+	touchscreen-glitch-threshold-ns = <62000>;
 	xnur-gpios = <&gpio1 3 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
-- 
2.43.0


