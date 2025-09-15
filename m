Return-Path: <linux-kernel+bounces-817718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C597B585A1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 21:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 452473BEDB4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 19:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36FD291C13;
	Mon, 15 Sep 2025 19:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="BdQMIcQM"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372CA28F948
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 19:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757966042; cv=none; b=Pe2V/uu3Ypl4HBCWA9+p3l1hfRrSlfJmkEpqqwNRaFOGhNhKvC6CDECo/LJOBW1Mt57xVrkmX9Fv3u3arTwAaMlm+FfqBR3j2/EGRVAGwmyQI4xoGsHl2a0svGWglrfeWsQXVop+E2RL2GalLUHAsiN5r8FiIsi6bGrUfGTRAiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757966042; c=relaxed/simple;
	bh=7R8rcOL3f1HwsUpPHaL0+BUAREAOiXb98Mm1tlgtyCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZBUZn1rPovy+y+YHIiBd3zZK9FxFFZDF3gk9K/7ozWewRZizSMb5h4WrgvCGe+2IOkRISA07c8vfXFt3Arle8CqH5fudaukTcSYPQZp0uhvR0JvEnbsjkjO00kBY77tWrV6h4qauUAu9otshVPLkQJC4Wi1vmtRPYyfIk930t5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=BdQMIcQM; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45dec1ae562so42205895e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 12:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1757966038; x=1758570838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AJ9ovkCr6DqOwPekQL9mbbfb8pXGwCeM0TnyH7IdLxU=;
        b=BdQMIcQM3C1ZUH8eqXcOCVq1rTJXq2L/71mDnR4i86VjxoDtEYdPDl9LYJT2t/KlxP
         0AF/4qH8J98MknbzreSQ0Wgxj+jJDXiAIXlcq6B0lDhf3qNJgaulUJCYe0ux5dWvBQb5
         xdq/zFLh/BakheuUx3M6nl5r9TE8ObYPHlUqo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757966038; x=1758570838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AJ9ovkCr6DqOwPekQL9mbbfb8pXGwCeM0TnyH7IdLxU=;
        b=Y4tB0Kxl/tFZ2ZFMh6p0/Dpp4LcW60Mjy15woqwjNZcKAYrSJBkbpTH3jT/oWOtnQS
         P9MA+e8o+tTnfCW6Qhjrd/oR+6Tvn3pU3xbCZUYlv/SVhbK/KKRXxCDmD+zsBTEbeW1S
         HR5/Li3ixjOlxX2nLCMd+pH9I6vMFWp4Wd4SAPVUxXRaj4qxBSDFVMgYCyp4x9nW+Rah
         kzy+Mkt3t6+DqwG0tvh6U+cSFeuuYadU2zALmwT3CxIyj4EuKhWkgzSzHcTeehp7vWh1
         EXKkROoRzNh5w7Mq1A8u3Ny3HoICZHK42SBRWYNNHqkj1v66LV7PejmLwPf/LI3BxO+W
         WUsQ==
X-Gm-Message-State: AOJu0YxlTgNHmNG52+id+3bNWvRLV3IewaKRvML3vBBWF0WVnMkdp+qB
	5G9zbUJl/k0HE0++bx1mV3VHT6h9jCUZ9TclL0TIkje5paiHftA4Mxa2YqZ7Hh6m5qXq29WS2vD
	OZtvB
X-Gm-Gg: ASbGncvGR9SmcdIiPk+DRgi4xrWOkcntxdye6DpjgoDFJ6moGRQyzZcxEatG709FF3+
	nD/5YkitKVIrNevn9Qj5rZ/PNogkT0U8oZkz6Ts4VBxjAYx7uOdfKBXtR7lm0txYHVKFfo1HaZe
	Tj+q3Fz/fKWA830s7zny2nIz5t03KLywGW6kauM4mIF9lW4sm6rhPlbzq2I+pE15uiM7VIZvWKL
	1uuoL/eS+D/jbHW5e5UoazJNG3Wrahv1UvcyaAaGKO7vRVmgjUkk9MfwbhQMxXkCJdATkLiKOAT
	zZMtyuEMsvNoRhAh/SOitLWZ8uXgIF5Tj75rUQc0VuFfzXiubqbX/LETIaUmXcjGig5NGfNnNt+
	P2sCM102AOocSDQAFvueAaJVpBoTe/jCqIfUVrBlcw8u1zFBg1yCif1gRwtArgEWidIhAz86QUA
	==
X-Google-Smtp-Source: AGHT+IFndz1AmdXVeKfJS9fz0y2h9S+/Rc1JyiVoAbeqVDR+ayQsA7o4g+R8GMH0hF64MGhaZdupYg==
X-Received: by 2002:a05:600c:6a06:b0:45b:8f5e:529a with SMTP id 5b1f17b1804b1-45f211d660bmr96982405e9.14.1757966038162;
        Mon, 15 Sep 2025 12:53:58 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.. ([2.196.40.230])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45f32640f49sm530985e9.9.2025.09.15.12.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 12:53:57 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: Frank Li <Frank.Li@nxp.com>,
	linux-amarula@amarulasolutions.com,
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
Subject: [PATCH v3 5/6] ARM: dts: imx6ull-engicam-microgea-bmm: set touchscreen glitch threshold
Date: Mon, 15 Sep 2025 21:53:07 +0200
Message-ID: <20250915195335.1710780-6-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250915195335.1710780-1-dario.binacchi@amarulasolutions.com>
References: <20250915195335.1710780-1-dario.binacchi@amarulasolutions.com>
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


