Return-Path: <linux-kernel+bounces-721694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7D4AFCCBA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 15:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96F994818BF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 13:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF412DFF0D;
	Tue,  8 Jul 2025 13:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YH0/BZZ4"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03F52DEA88;
	Tue,  8 Jul 2025 13:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751982885; cv=none; b=E+MLcbG+j/vZ0skF5uBBTq0SB41QrnokSk7KufKKKG57SqrGt0OEFDrkfhZeycXllaUkCHbVFSbYWmg+BzgLKnqM4K4D/ckV5RSmz0dvAi8oRFBo4ftGtploORfTFhT4bHvkSQxnitT9ERLz7jYeeStkYjIozvZrSYzDEqui0vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751982885; c=relaxed/simple;
	bh=s5n1RdnAVao4nvr2l2RuxKi9utEkFRNfhVwnY8bc6fk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C0Gn1XL8Pv4CQUJBCXp6SA3NkTu/hIswWGnkDIc90FczxSjVBOOph6nwC9A2v2qGixd9hFx+OiHbIR3vHqS+E/Y6w14AEiCiXFDE4MdF9ZxzxPJ/c7NPc8o6CHlzOZdt3We1h2RjQ+sFDRmF25R8OGES2vqJwQjFQjeDfIaTVhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YH0/BZZ4; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-60707b740a6so5979799a12.0;
        Tue, 08 Jul 2025 06:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751982881; x=1752587681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q39+rmVt4A2B3V+dGS36sBW8bBHj4CY5V2BRog5QBms=;
        b=YH0/BZZ4JSmeYe/mskBqyxnkzGhqlT281GtYqs+Qw5YaQ3+JvpVAJXG0yXFsOhCttG
         0jOnpZBbv5ZdZvXj7nXfGDFgjRjpqqfMhudWh+Dm8P7TQWuM3W/8lvvSqsR3QfKRe8Mt
         euWsV7c/RBkGg3TC4BKzg9uTIZ3zuTFsJiGErSGxzfTumEfaAJqXa7IR67SP/k9fSZDF
         z+rRdtf02VEToTzWYXa1D10r5vcF+szpr+jsKqESgP8E0NwmkWdFr35Evm7cWIUibFYN
         tfoKPClvILqv0IA5J0PGlHO6o8+FsZubf/znYATaaVu9KSTrq8EjnupnLhyqqoSa6ydr
         ALdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751982881; x=1752587681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q39+rmVt4A2B3V+dGS36sBW8bBHj4CY5V2BRog5QBms=;
        b=JlPEdBUseA2y5jBx1YGax9nMdmj/Ox0GQuS6gw4XeCTyLxG8V+Yg2QPj+4Bs4wAPtN
         YrQXNG2ByBuclHDCgLBBso4J+CQdBuH6y4tG8xEq7MXRNdE2fS08I26xYsgfgWIYJ9IF
         B3qGl+tJsRUh1KNvL5OUNNmbxZQyY2vpEupZsain+zdkep+1AqMxZ2HWf1+npl58Oowj
         iT+OpAxU5zFXWB6KCzwEdA0y9RG/bK6IR7c7SaLpsMYUr9ktFwGbijNftQ+CRFO3UN2P
         CLYR4oPXh4cEO+OL/nfV9vZZPv1SoEwKNbCwVgBjdKDJSmOzThy0KUDGd2JyYQuuxy+s
         1azg==
X-Forwarded-Encrypted: i=1; AJvYcCWnRgfcehZD5ddrSCO6rCf6EbVFCBjC3ymKDEdynw8805QRW9gmcHiOxtw05p9e6Ql8TcGqxDvMqLTo@vger.kernel.org, AJvYcCXPev7NkKRxnTqoqPhvbdQSdT0B1vPSnCwprxkPrU56zGapxQGp0NCCuDwJa4ZBlpj1CWOKzFMQCKW+jv6n@vger.kernel.org
X-Gm-Message-State: AOJu0YwNGJglpMZOfRORP2W0v3P2PGBKkJAjsw+KJRh/6ah7PThf+RTe
	dU7R3ebYtVhJdmeerj+PE93heLhr4U9skkDsVRyF9w68RDDpX/6Oabx5
X-Gm-Gg: ASbGncurF3fC1FnZiqieMfOnPV/JqT+ZheB53hVSr6N+o1ZQGXf4jrnvZuauCsbgOrB
	H9Ena+m2HR3urUm/It3MRwiiX5AdsUJqWBhG4yttOZQOMSP9azwNbb+a7DkTtKuMIw9SdE57VwN
	ArUiX46eKrs3gT2rePrd3ucjyygYTV8YTn4U5gayJywkAvWbXiTaQ2gkoVjhVVQzlKapQ1Pb5g+
	C+1cUsLHAsUYboCs8aADOEd9Pk/5XDSQW98D+t5Y01GLci5UUzkFpwx8BK+Oq3ZWfYkVba7UXKe
	ZtFxv5qoerQ6nBviZ50CToi2KvoNi4NdkcrucTCNoc5WR3mLR8cTyZuEgErj6IoBmge5hLFwmxi
	DdZqG+AgT72YoqEkYh3yjDjg0DHPrGbeuoqsCJ100/o2CbTWrvp63iX5tzfAEPYoZ
X-Google-Smtp-Source: AGHT+IEwKuGBUV6A52zfoY52+Yo41jVFUHAwMCF4D285FO0GiN1roY7nL5hI5r4cCSQtqUs421gD9g==
X-Received: by 2002:a17:906:f5a7:b0:ae3:f16e:4863 with SMTP id a640c23a62f3a-ae3fe64e8e6mr1665718566b.1.1751982880709;
        Tue, 08 Jul 2025 06:54:40 -0700 (PDT)
Received: from toolbox.int.toradex.com (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6ac6641sm910431066b.99.2025.07.08.06.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 06:54:40 -0700 (PDT)
From: max.oss.09@gmail.com
To: Max Krummenacher <max.krummenacher@toradex.com>
Cc: Conor Dooley <conor+dt@kernel.org>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Fabio Estevam <festevam@gmail.com>,
	Hiago De Franco <hiago.franco@toradex.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Vitor Soares <vitor.soares@toradex.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] arm64: dts: freescale: imx8mp-toradex-smarc: fix lvds dsi mux gpio
Date: Tue,  8 Jul 2025 15:51:41 +0200
Message-ID: <20250708135300.2855155-2-max.oss.09@gmail.com>
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

The MUX which either outputs DSI or 2nd channel LVDS signals is part of
the SoM. Move the pinmuxing of the GPIO used for controlling the MUX
to the SoM dtsi file.

Fixes: 97dc91c04558 ("arm64: dts: freescale: add Toradex SMARC iMX8MP")
Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
---

 arch/arm64/boot/dts/freescale/imx8mp-toradex-smarc-dev.dts | 5 -----
 arch/arm64/boot/dts/freescale/imx8mp-toradex-smarc.dtsi    | 2 ++
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-toradex-smarc-dev.dts b/arch/arm64/boot/dts/freescale/imx8mp-toradex-smarc-dev.dts
index 55b8c5c14fb4..d5fa9a8d414e 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-toradex-smarc-dev.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-toradex-smarc-dev.dts
@@ -102,11 +102,6 @@ &gpio1 {
 		    <&pinctrl_gpio13>;
 };
 
-&gpio3 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_lvds_dsi_sel>;
-};
-
 &gpio4 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_gpio4>, <&pinctrl_gpio6>;
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-toradex-smarc.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-toradex-smarc.dtsi
index 22f6daabdb90..11fd5360ab90 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-toradex-smarc.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-toradex-smarc.dtsi
@@ -320,6 +320,8 @@ &gpio2 {
 };
 
 &gpio3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lvds_dsi_sel>;
 	gpio-line-names = "ETH_0_INT#", /* 0 */
 			  "SLEEP#",
 			  "",
-- 
2.42.0


