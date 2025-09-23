Return-Path: <linux-kernel+bounces-829168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7050AB96711
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 16:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33983176F86
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 14:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1E2246BC6;
	Tue, 23 Sep 2025 14:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="EA1ZpKqc"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB41F23D7DE
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 14:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758638967; cv=none; b=Vw8euePoaavRWxFpow18csVvby9AW/K7IGUPg0lP0n/IiJf9IbHyjYxy51CZd7vluLWqy8AfK2lyuVgdIUpb7wpSytdgjTLdDdYq+RJYD69O6UkwopnVH4/SPhZCvHXnodyDhCm0tQyOgG5MxrT7CMWVoDVE/YFkjXQ5lUrwjyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758638967; c=relaxed/simple;
	bh=DNqQwxK29Us8xfmOHYcY1uinDcMdwRcq4PUlWc2Tuv0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rY5W+V5Sy3DsJDVcRFVOwc2pQFBuaR5NcqGZimFboeHQbg7P5l/zbmdC0IXozmpeWzSNMCOz7IIhioxmHj8ylSS5U1rI2f0hHYR0+/HIwStS8RlZ2Ud+JG8Y5yWB/f4+L2t2pz7OuVgFaSQxLvy/NHPJK5cn4lx+PXpRO9JzZLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=EA1ZpKqc; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b0787fdb137so880702266b.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 07:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1758638964; x=1759243764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xur5ogzlO3BxY7k/WpoKiidJ69mrTNy6lGE5CvTWMk4=;
        b=EA1ZpKqcLVjvLr7gkPplFePyPjUMD7JuWm3xMlkUBjARo8zGY4AM8SEk9/LfUsxZzs
         JEW8YQpeIfII9ugr0Bt+yPcgPq2tCpazJvgcN1vZ3U4ctQQ7p5SfF4Jy97RtT06fiJIi
         jR2jrGBwNkCkDDff9no2VkqvZCL71LXZF6KSE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758638964; x=1759243764;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xur5ogzlO3BxY7k/WpoKiidJ69mrTNy6lGE5CvTWMk4=;
        b=KLJAytFyAwo6leRfxaUH5FI2g2Y8ftvspqbQ+r9V0lc7pfqMF48vpB6OaoXEYavdgv
         w7YxOyyhicwHishzwLqKCVylKe6QYs0BHF1BOk9fg2W1gN53J7ew/5WPGKMoiqkaiUjv
         D9KmvklkTY4MElbwmRH/si4x2AsYsY3FK8i3oJWIMnDZFLlCiGmF/uhhALhX5YRjT0x8
         cC72wFA+9FYgAqd4OtsdE52zK2pFryeLamKa8OvG431kpuuHIIJ5amNhds7K5LG9J5dg
         gKChRhEXWhwobhpCBYEmtyEMJqDOwpr+8rEC/87aHvberamTSnzpejwCK205TAWSbGiY
         WY/Q==
X-Gm-Message-State: AOJu0Yw0TsbII3oVrU45KojkCtSc8Ab1LNN7C4NWQt2lUIIu9Z07cVDc
	U8CuHJS/Y1h+QhspJr/VRJktrBe170xlh+CXkexI34gbzClHqd47/QSpXvbj6WoRghJNJcvnYYl
	yALTH
X-Gm-Gg: ASbGnct8MI5z2JZz3ZXrUdhK0q0dum5nKdoV9KQ3bItKH9MDr41RwdGqLuY2zYhREOT
	V1SkznG+t4Xm5gHn8IrsGxscos05EQN44iU+trdLgIcYivqvT/iZS1wHuYWVgkvdmKDil7Ld3UO
	vr7HmIzsnCaClnndztsn+CSS7Bu1+u1C33saOnkLyssXu5dnz5BwNwuLKdLHLLZOYTH1jevt2A8
	pWxVWt3EvBbQ/9J/Eq0dzCRGDgyS1jA6dxrfz2H49/KrWZcmLJ/I2OnHsbnHrq6VwDPnGMXoTJX
	rAeHDmT+AYpXzXQ5zCIZLGhsPA89LowtI7awIuyuFpKNJK6YR7HGbJ4PuDXB5hGWgQHECjrTvGz
	zqojKuilA6HjbOqKv+BrCth6Oy71N+h0tBu6tQHl4L6WcA+JMRuxpMBYD/JbWOtfxjIMytfS/1B
	9yJd88gOaBlKpxykAaZBGgX7eJz3vyie/Npko5phoSVKd2Tlfl6fu6FLK4y5VydWdJ
X-Google-Smtp-Source: AGHT+IFdTyE8sOB500lABprpHvm3+W8fwHKLli2EEJnbWm8PCy1bRjTjWqFurJ5b3114azHIHI936g==
X-Received: by 2002:a17:907:3f92:b0:afe:87bd:da59 with SMTP id a640c23a62f3a-b302a07b5demr278688766b.42.1758638963797;
        Tue, 23 Sep 2025 07:49:23 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-56-38-125.retail.telecomitalia.it. [82.56.38.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b2c0e7f7b01sm515746166b.91.2025.09.23.07.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 07:49:23 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Michael Trimarchi <michael@amarulasolutions.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Peng Fan <peng.fan@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [RESEND PATCH] ARM: dts: imx6ull-engicam-microgea-rmm: fix report-rate-hz value
Date: Tue, 23 Sep 2025 16:49:10 +0200
Message-ID: <20250923144920.2858693-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'report-rate-hz' property for the edt-ft5x06 driver was added and
handled in the Linux kernel by me with patches [1] and [2] for this
specific board.

The v1 upstream version, which was the one applied to the customer's
kernel, used the 'report-rate' property, which was written directly to
the controller register. During review, the 'hz' suffix was added,
changing its handling so that writing the value directly to the register
was no longer possible for the M06 controller.

Once the patches were accepted in mainline, I did not reapply them to
the customer's kernel, and when upstreaming the DTS for this board, I
forgot to correct the 'report-rate-hz' property value.

The property must be set to 60 because this board uses the M06 controller,
which expects the report rate in units of 10 Hz, meaning the actual value
written to the register is 6.

[1] 625f829586ea ("dt-bindings: input: touchscreen: edt-ft5x06: add report-rate-hz")
[2] 5bcee83a406c ("Input: edt-ft5x06 - set report rate by dts property")
Fixes: ffea3cac94ba ("ARM: dts: imx6ul: support Engicam MicroGEA RMM board")
Co-developed-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

 arch/arm/boot/dts/nxp/imx/imx6ull-engicam-microgea-rmm.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6ull-engicam-microgea-rmm.dts b/arch/arm/boot/dts/nxp/imx/imx6ull-engicam-microgea-rmm.dts
index 5d1cc8a1f555..8d41f76ae270 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ull-engicam-microgea-rmm.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6ull-engicam-microgea-rmm.dts
@@ -136,7 +136,7 @@ touchscreen: touchscreen@38 {
 		interrupt-parent = <&gpio2>;
 		interrupts = <8 IRQ_TYPE_EDGE_FALLING>;
 		reset-gpios = <&gpio2 14 GPIO_ACTIVE_LOW>;
-		report-rate-hz = <6>;
+		report-rate-hz = <60>;
 		/* settings valid only for Hycon touchscreen */
 		touchscreen-size-x = <1280>;
 		touchscreen-size-y = <800>;
-- 
2.43.0

base-commit: f975f08c2e899ae2484407d7bba6bb7f8b6d9d40
branch: report-rate-hz-on-microgea-rmm

