Return-Path: <linux-kernel+bounces-815105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B158CB55FD1
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 11:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71D1EAC42E3
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 09:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7DC2D24BF;
	Sat, 13 Sep 2025 09:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="l+y4YXjb"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAFA2C027F
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 09:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757755006; cv=none; b=lq5Anbbh9wAtf3DtSPJChBdrvHNfChD593XB+gmvuafKJ04LXiJOzBhhID+lMSFQ7Du/O1n9LwizxPwqA2h33tWEz7kcNAXOGgdA+B2z+x/G2fAM4zGmyhcLWE/ZBIqiwiXhdOEZQf3KHZT5OmZrHJJUGlU0hG7dqKjy88Bvbo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757755006; c=relaxed/simple;
	bh=50Wf/YvHyWAiEJIWnMiIPPQnOr1Oksxk5KmrCQPjYKg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ord6bW24iE+qypUcFtvliKNmjPmIMsTpo48ZbeFvmZ5VLRyGNb7jzma84EBPfb9WekyuEKsP2a9fy17HNfHM+DjbFKfTJMi+Klj9d/LNWg4BY6PVFceOx/ZvWiS3PHud2v90Vz03Vygmw5+evo3wmJ3lrx8DfIOgS1W/48vcY4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=l+y4YXjb; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b042cc3954fso484999366b.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 02:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1757755003; x=1758359803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=woVp7FNEkX/bwtVc5utqy3tuJJ+oPzZT5NUOh8DxvE0=;
        b=l+y4YXjbImHVKyuj5lmFUruyQD7ePECOoY//Rg8awJ/nrfYsMtoqr3DnwWs5hJjXnU
         TJ1AxnNV2OGDh3noPIgDYMNPITbUSLhjo3FLIxepf+8GWgZ0wffLlw1S/XLIhEchqDsH
         insgMQG31fEegXwBmxSitBEpcDNCn2QdreqHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757755003; x=1758359803;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=woVp7FNEkX/bwtVc5utqy3tuJJ+oPzZT5NUOh8DxvE0=;
        b=G4W41oj45G01Yr7nGobpvCj3Rez4LNIJJSAracqUAcs+lmZChSnt4gujG6D1ffctCr
         BTMVet7Jd4WTPDvLmVWKttmr7PpVNiejsKMY5rs/EzsbAsc0YCrzyL2/3sFi0yQZXvQX
         UR7Y9kgYvBy28Cpc3bdTHrKgOEBGxctENWbA+a148Y6+G/lKt1l45d35ZzWXcey897Wi
         qxUpcl7UZa9+FRFxiVPQb0XsGukzJ90med6QRheODPWSjysNShK3oN+JFC+Bk8Ums9di
         QVnLG35VSvQvNryEuJMTchl2T9SpYFnsPTXef6RByoX3f9+0JA6CPwW5ibK8OXqi1TmI
         prgw==
X-Gm-Message-State: AOJu0Yw60nL+hYxkpLsb+LKy/rnj12Dd/XpXlbiiuxMn0s5k8j3YFPf3
	oQKzPdR3ioaTksQXWiCthICX6LeS84Dn8u1NqKaBa9QfuAH/zq242ZGtNVchzQw3qXeKxr6IV8L
	xIbI9
X-Gm-Gg: ASbGnct0eVqh4n8MZmAixIm7h4V/EypJTcJnxJ/R6xjsq58SeqpoSIj+ZueTj4oTkBz
	pmAuD+8GMMDezOrldISptvY9Ume5zkoXjt7fSUoCtuodZXynC8ZeZSkn80utUc44F43EVlUC+XY
	vOFoP7YaQp82mhGPR6aWeys3FG5HLOZRQG1mmNfKFqbWSL+qDp2fhmVMbkY99M4WAu9KcJKIYzv
	eTU0bkoo+8GADL1uj21/eqLrDJClO2gSzvjYLPh4tG9aoYC5l7b+T8zwRKzNceHIu7wK8ogu+gm
	6ly1+Qr5JHN5xG4t3VFQWEQOpcuWSp2WE1qY8r1OtffC6lXix47LI50rUVdVYKYJEKlbSA0wGOp
	slsrUu/4W378GHs4pkk99EkJs6unJ/RXgNbL2fLVwivXUfbJb1uQsF9rec94kpAUhkbTxggc2E9
	GhdKhHEk4l5A5JHQ252F5vLX8Z86JLb2AqJlMFyytDaB5JIAwOpXyhOg7cLfesxOSY
X-Google-Smtp-Source: AGHT+IFLQcrw9kq1ufoEVqOgFBOrdye9rBnznBZUzXL2tY70bbUV8mzf6aopgG578A5tsns/4TRC0w==
X-Received: by 2002:a05:6402:44d9:b0:628:e750:85d with SMTP id 4fb4d7f45d1cf-62ed8410affmr5076000a12.21.1757755002961;
        Sat, 13 Sep 2025 02:16:42 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-56-38-125.retail.telecomitalia.it. [82.56.38.125])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62efb5b8b0asm1593089a12.20.2025.09.13.02.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Sep 2025 02:16:42 -0700 (PDT)
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
Subject: [PATCH] ARM: dts: imx6ull-engicam-microgea-rmm: fix report-rate-hz value
Date: Sat, 13 Sep 2025 11:16:31 +0200
Message-ID: <20250913091638.1003563-1-dario.binacchi@amarulasolutions.com>
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

base-commit: 22f20375f5b71f30c0d6896583b93b6e4bba7279
branch: report-rate-hz-on-microgea-rmm

