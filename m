Return-Path: <linux-kernel+bounces-823226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0140BB85DA5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 18:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF9521C0044C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142913195FB;
	Thu, 18 Sep 2025 15:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="cJCirYTE"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244FC318132
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 15:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758210774; cv=none; b=IT1V+McPwbhdiEcr675axB0YxXzHGjUKEb6dLQD2/rtV2Y45BQz5opnyssLACbGLVOfIXUAgf/nTLKQdaksF0oMG8r7tYiXLcLinCNvNiRlaf+znIQZUooalRt39d22fzqu2egtEkM+oGa0GRV27tZB3clyCrYBG3t1cMTHwtd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758210774; c=relaxed/simple;
	bh=gGgLDa28x4UcF2lKFBKasKuonH4sgYz1s6b2kl6Iy4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=roDKBTGWCLgBspaVLUrIrzAbeJTyDab3ynjLKLeiHv1HHL40h1PD25dme7biwMaNSzUQ3EHsNnmwM40IfrBbM8sa19hibJmHuT0NrST2fEuE4I1lAiEVXZNkSTueo3HJOb888duoP0zaux5EuUq5QNNRlDvNoqKJM4zx8mYL3+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=cJCirYTE; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-61cc281171cso1611360a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 08:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1758210770; x=1758815570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KC1/Z5A4C1NKjQ4MKJ5mwlwDtHXXOD1eqAPkjlkCE6Q=;
        b=cJCirYTEA3K8X3dsOlNOqFFbdojIpJR2mG+/OuhKlkofA+JdMdIKIhBA/EV8GGxF2h
         Yh8WcgLjSxSDfrC+BfeFff77H4XIgNmQLGfC4QfAv8uMCExkkPjHHp5LcpN+V6FFnjUI
         edpHHLSTCX9oOf/YPmtRfrpNtIOIOzDztueg0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758210770; x=1758815570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KC1/Z5A4C1NKjQ4MKJ5mwlwDtHXXOD1eqAPkjlkCE6Q=;
        b=BXsNUn4rJbZoDTljuADXQpTNENrgIkPkwg13iWZTs80Db+hsTmUXD15Y84iF+9824W
         pFUhQWiS01eHKlq9jUEInMBHLz1L6IVDptSDh7WLTIUsCNGbExnKS7Ovn7/8ofsxCNC3
         aw/n6pSLGwmcQUlzOG1xgn8qpsZzysiu6Ovxar23g6/+S2ULfLKk9CoomkNI+XykOczb
         s+G2wuRAetCV9rv6gingBn8K7ZM2x3/IhgopAAZiPA0M+uudABwRMbYgB1/7inL9mii0
         s51cAiPDbYc4/OTHIIFX0rwlQnetgwt4kwP4b+7WI1+Ul+dom65XmG5F5es0blJw/jSa
         aQaQ==
X-Gm-Message-State: AOJu0YysxMCgZFhMWB6s6rn9+LhmQzkSpj/vslTRtyQXQI40OQgCMv0V
	HUWBUqbApaAjviJ6L6O2udYyiH4TMUoZ6Q/73rV6Umius56KM+q896xlxm7p3Koi0hezTReLuXS
	A6aIy
X-Gm-Gg: ASbGncsNsZYT5R1s8s9my/UG098kKvcyeyeThc0npfr5FTjJezEkqOGKlYajyjOmUv/
	kSwD9lXRq+dVtOd6mD+92MMIA1RthFfrukTajiUTSec/ptQwVm0iJDzxAvfnfy14lbhLjctDn+F
	ILGpvbnI73xmmOMtCAERBB+cWV/kdOk1WzkW87CJDcTiaXD3BXZcYfSfZKw7P8H/p9jnFuh5qm6
	U4TTKTYOACgfo0pAhtiFEQH5x+lmIX7Do6wqXI+pBdCrWMDycXGc9mWxwr0cxnyOcPxNXlYlNyF
	+pvnssUGp1fNuaqXRJUR17EBMeiwdcYkxzoaO0HwqmldBR3LGT80Y9Vmm5FXXqC/esFPO0BRGfU
	yNVdjHKkUXHtXWj60qqAO8uTKAwaxobfk1LQBTklfhh2vede8ECLpiXrq0h2pAg/N0/glTxuZOm
	VyEL5yZ2cM82sfwORPQ3PuoIb4QSFu1D3B5UD2E5FVZ1MUYNGF+Lz39a5+hS4eUI2w09tN9rnuK
	/bgcEupXmw=
X-Google-Smtp-Source: AGHT+IHrrgs1HJChTIyvAVV8Pi6aonRsXlQC1gliMmMRrY60B3FFWCvZ01egkSmZM0VTAEb3+in5cw==
X-Received: by 2002:a17:906:7310:b0:b04:858e:c1ee with SMTP id a640c23a62f3a-b1bb5e56d90mr782962066b.2.1758210770121;
        Thu, 18 Sep 2025 08:52:50 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-56-38-125.retail.telecomitalia.it. [82.56.38.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b23a1227bacsm60449766b.41.2025.09.18.08.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 08:52:49 -0700 (PDT)
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
Subject: [PATCH v5 5/6] ARM: dts: imx6ull-engicam-microgea-bmm: set touchscreen glitch threshold
Date: Thu, 18 Sep 2025 17:52:33 +0200
Message-ID: <20250918155240.2536852-6-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250918155240.2536852-1-dario.binacchi@amarulasolutions.com>
References: <20250918155240.2536852-1-dario.binacchi@amarulasolutions.com>
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
Reviewed-by: Frank Li <Frank.Li@nxp.com>

---

Changes in v5:
- Add Reviewed-by tag of Frank Li

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


