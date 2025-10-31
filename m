Return-Path: <linux-kernel+bounces-880204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA45C251AF
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 13:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8CB194F6080
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8BCD34B428;
	Fri, 31 Oct 2025 12:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="czqxuVGb"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665491F09A3
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 12:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761915070; cv=none; b=G61Mt4oczNNlaWSqectO4PYJSNqPB0ya3LoJv9Nbc/xZBreMGRhxJTBI6/M96m8Rjo0wF4Aej3+l1Vw0q8y85IyeLLs0XDF0eidEY8lIUOxEUD/kj3dXP4GE0Dbx+fgmsflvZt/z1vnZo/nZI61mhgzf2MbQ/fvxCwJQ+r2zdNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761915070; c=relaxed/simple;
	bh=Yu/2j0GxwZBaEKqZGl6yxDClZc58fe7sUMa878UE3Uc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oH0L6gSHQcxys1SgPtvoJUjbC8K5whk943bleCXmS0qEh8U8HESVVrKmbCbC2yG2StzAAVMW2fM7jxg5xT7TpEh78bL5EbVybTGbQ8kDlKoHxwlFFx/PiU+gZLmg8XbONHrAOPufGlSqXTXu8zmam1+k4V88lYzQkpGYolvmuP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=czqxuVGb; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3ee15b5435bso1683048f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 05:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761915067; x=1762519867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qvXLX7+QZgiVzZvZ0wG+LadEzSHLnJ6P5bBzFMwgkSc=;
        b=czqxuVGbYv2FIGy4das2YsdxTGkLU9rL1hwVIHmXlQDR1l9Kw9KZckb5z2fgQSTM1x
         1pnYvNkQ7qNillU/Cpudr8VfDPgQv6PAgd2npORNSRNQXb8UW0Ih2vHTVZboqqK2bgPz
         l2LXYQXub1jHg0KIwH8OKQGtk337Mf6Fv5iv9zqqiIU+fznM0b/4j7SNYJdHqY3hy1dP
         MrnqA1lvP1qyBhkLQwXRhrhDJ40kEUW9YZW3LbHu6ltxl7eGzc5mhnTYK7Kt8Yu/UXoI
         BvBC6FPUzFL8GS1FpYzI2PDn0syUzuezJRQmvuV04LV2/6/u2gYxJAL5nYvHSbojAOeC
         xZVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761915067; x=1762519867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qvXLX7+QZgiVzZvZ0wG+LadEzSHLnJ6P5bBzFMwgkSc=;
        b=stlS/bRxETHmtyLPrGEdW6p/Bz2Ilofu9q05m+DYv4J4+1LwtxsErTqNu1AOMZhOq/
         gsWv8HtLkm52zd/1aKmek2xbrs7zVEZpcizo5kgBNlhGTItMeBYYbRk4RFfG4yUAD+5a
         Hla7kwd9GN1E1N9sog07HynPlqlZwq/rCaunNi4rWyPvbCGNtCG47NpYkWMu4pnd5QJt
         +nwcfZESl3ncQg/JudMrD2W0/fnj/BwHTiFSBqNp21pLvZlqxI2B2LaV23tOn+NIYXzS
         NOk4EG8MfHDhrn5nSMbvxpFJvxcelTHB6D9eHq2wveDyXST9BTFl13AWEUx77nAyuzBs
         l9ZA==
X-Forwarded-Encrypted: i=1; AJvYcCV4WXKRZHMSSHF+XaGWUMxOtB+lhuuThctmZo1guG0y3PaWdUsx9FsDgM5PooFUwe5x77Gci7lse0YMGiA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywtnla7VaA7djRHM1Pox7dcsXgju0nbp5BrVMsXFOJO+ttO8M9y
	Q0eVLGKc6ErTBQtWQNe/pChhwdvfRBZjMilTSzYr7JkqzORPAxfB82i55LjWpQ==
X-Gm-Gg: ASbGncvb+26S6sk3brW1d6+jLS8Ck4qdEnX6Fnt4Oh3vVeE+yUg4tWNnkFsibwQqs77
	js1Ym46MWfzIb08xNQRQbUmIJcdYd4ytsyg2H3GHP/rdjo3UnCYFcm+PVmshjfFe24VJlOaltFC
	vnZ90NMhZK515f4uaQggL0CIQk/Hwmh39SNjq1fC5c2/J6wajAOo9FFOHkSVTP8ytaZoncwmvdJ
	P/tzK3Hed+9LwdjTTSjL9l/hmvZugIRmg9uMPNyUjPD3tCyTOnzKO4tJPOyWWsWCnOkVtI9GcKu
	0d6HN601q93J4KgLhatm3thgnLa1sBEhWaGnhyt+u/H6yt9ga1E6my1HRrtOQhHc3elj93IVV4j
	j1pnP+/yd2GDGrOeBGvjwAnmcyi+4uhddGBJ/bnynhfNttmCnOyaSvCu9hsIrDvvUlLseFIHzWV
	2G/gEGWujc89b7IWnY6rMApKrhaKYDuqASojA5Foj079GUApKbhHp7bbsa+zhxhs3ekd7L/pNym
	zkeHA==
X-Google-Smtp-Source: AGHT+IER0uBeKPOPxvxxiQO98NZsaBc8tk7mKIGeshxcLGZG7k6FCf35yqXCrk9lgrCyQ4EIIt8pbg==
X-Received: by 2002:a05:6000:4713:b0:429:95de:163 with SMTP id ffacd0b85a97d-429bd67bd22mr3151971f8f.20.1761915066584;
        Fri, 31 Oct 2025 05:51:06 -0700 (PDT)
Received: from toolbox.int.toradex.com (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c13f1d4csm3144559f8f.39.2025.10.31.05.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 05:51:06 -0700 (PDT)
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
Subject: [PATCH v1 2/3] arm64: dts: colibri-imx8x: Add wi-fi 32kHz clock
Date: Fri, 31 Oct 2025 13:49:42 +0100
Message-ID: <20251031125003.275033-3-max.oss.09@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20251031125003.275033-1-max.oss.09@gmail.com>
References: <20251031125003.275033-1-max.oss.09@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Max Krummenacher <max.krummenacher@toradex.com>

The Wi-Fi module requires a 32kHz clock to support Wi-Fi/BT low power
operation.
Setting the pinmuxing option on the connected pin to 32kHz is all
needed to generated the signal.

Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
---

 arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi b/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
index 318fe4db1b64..32bca4c6f37e 100644
--- a/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
@@ -490,7 +490,7 @@ &mu1_m0 {
 /* On-module PCIe for Wi-Fi */
 &pcieb {
 	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_pcieb>;
+	pinctrl-0 = <&pinctrl_pcieb>, <&pinctrl_wifi>;
 	phys = <&hsio_phy 0 PHY_TYPE_PCIE 0>;
 	phy-names = "pcie-phy";
 	reset-gpios = <&lsio_gpio4 0 GPIO_ACTIVE_LOW>;
-- 
2.42.0


