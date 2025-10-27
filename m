Return-Path: <linux-kernel+bounces-871229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD05C0CAAA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 10:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8C8E189B26F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832E72F6908;
	Mon, 27 Oct 2025 09:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PSY4SJVP"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A082F3C31
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 09:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761557553; cv=none; b=TpVXguqLU3DMGZRMxa5LJm9hImH6oe5N0G8IEpEczAlswgs8UbI1lyxeu2gAilmMEyjP9zbH+TfbitQhPHfTQLdYiuztMKjtiXrCelDWo/KEJhuuje/twubGxwnqCw3F3GNOZNL2iGv7ESNG5BMk9aF7h0rtB9yXkMYDu9fHGjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761557553; c=relaxed/simple;
	bh=mndTbYHhwTUyT5y96dJ86Gw5EG9MAfWXvMDRx3WMfqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DPI+l+5zrEFgnIJjTXoGbNHwqFd7yYN0SuKXek08KVj0fxHnvPtPQV01ToxZozOy3m7ipx8TqL6l4m2TQtVb99dQOkktts84lq62rEjGTOq9CUX2aqUrnMNcECAL52N/X/ZyQgJspTVZuKSt03xIFyq8uN+GQB/+WnH+CsK/cr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PSY4SJVP; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-63c556b4e0cso317670a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 02:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761557549; x=1762162349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=56PhuafYXsirG+UhANSH3mXfKoGfLYzu3y07BccvFzE=;
        b=PSY4SJVPhL7/UT5MW9EY289/sXfgQdtvrotRYBaBC41uj2qV6IGwTpGl7nwQEBjFw3
         /WuptZ809T5OCvMMiBdr8g6u9UXr0S/AKEHVn/sH5enYsnKOZyzBHBf7fWZPcWr+5JlQ
         P/SMLwtmLo+qTzlf2XnY3nJ5ccX4pdGogd6cBsVVZ2ucOg32NlWsgysyc244/Wolo1R3
         1xo5sLPKo8BAFo2kKmqYFWEcqewQxlkMsESFbkAUUbB7VhMBfcgXKlZoTQv+dZmfDJK9
         kF4S0v6uP+pTpgkdyxKku9ikpC0kr6dqyWcPgGFU3uboVh6Nwhzkubi6a88SR1wv/Y3t
         V4ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761557549; x=1762162349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=56PhuafYXsirG+UhANSH3mXfKoGfLYzu3y07BccvFzE=;
        b=SaLOLvYAYI0N1HGa4xtC94el9bbvM+nPTzoCueZb4XX1L0AnsRr3VXRvy3ByFVRdHK
         hZ9LoUWzmXq8JAPlcqmnbR0tAnVDTJZxymulfbZ3+R6XPKm9tJRhk4zv+g69pvm2slIJ
         SQJoTI2t0Zp2mjm66wrjaAHYl0idN+Lm/J0Z/xoqlYMdSL78LaKU8aut6Uvk7dScZvJI
         FM0iLB7Qaiq0Px65nk+YiwPVgRYlMTSLjVH7MOG0dgXu750v+v9Haxz2H5GUxW7myPTc
         YAK/cRgKUrF7f3K5CNmIKKr9tZIdttxTGaCr97LsFR2rJvBIBfteT/c4rd8g9CMrw0ow
         JKrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXS50ehJeac1WYkWVboGi447IRsr2rrHG1YVqsB1GNRuz3FIn+rZQwnPlfjPNFjqRC/rE7v3LDcwLRLvTM=@vger.kernel.org
X-Gm-Message-State: AOJu0YySiWSvB74O4y8WmVbufgpVvo5fCCEy4lFNSDTCyqshOZVhqmDl
	aqsTwpUTS939oB8eZeuk17sCVh65R1U3fK5GWRySAo9bcY0YR7sqRupo
X-Gm-Gg: ASbGnctCx5hb/q1BASpd6eabNHHuM667HpyPJVPj3oDBN9w4AOrj2XAlxKGTzmH0Lx0
	79feN71P5KS3a/1ZGhKDAcEo4IeKdDG95vDn4wiwcsStQu04pvx9ew906vOB+ZXQ4IsXtJPLSEa
	iKo5md9O/odVFUMqRWPTJMAdrL/pFaDTdyDDCyAjDrm+BY9wSnAgTQhHxs9OVo0hZhlMSvR8rGN
	E8bWGalWCdYRouMVMUZMGd5zmQaxtldlZ72F/3zMJo95jNJ3noJmH51dX8HajzD9qp+cqa2RmD6
	GJuwWVC2MX+pB7NjCdXXPXcs24zW1en8I2TnJCcPu5wYfyBvpK+EPBW3laH/Gn00fMS/j1v5QyA
	J1H8FhBKynBnMFLlDa5j0o+w4jbhGiukwADI3v4p7AcMC+inGqPAw2l1fvgo0qJbDfTEkJ+hXcz
	HNHPs5Sx2Vya0YJZYqm8ZOQHakSO+uVvB1vsoVmyQ7xPJ5pyNXSZzeaXLU7bNi71QV4zGayp9//
	g1hRKTYsm4V+858
X-Google-Smtp-Source: AGHT+IEFwNpP3dTtFNugaADyHzm9NL9na2nqJocl90kjFXsdtQrxoTlQehatWBhcXvoqHgFBklRLfQ==
X-Received: by 2002:a05:6402:2807:b0:63c:a17c:8efe with SMTP id 4fb4d7f45d1cf-63ca17c9097mr22821321a12.12.1761557548713;
        Mon, 27 Oct 2025 02:32:28 -0700 (PDT)
Received: from toolbox.int.toradex.com (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e7ef6be28sm5681014a12.2.2025.10.27.02.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 02:32:28 -0700 (PDT)
From: max.oss.09@gmail.com
To: Max Krummenacher <max.krummenacher@toradex.com>,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
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
Subject: [PATCH v1 5/5] arm64: dts: imx8-apalis: use startup-delay-us for wifi regulator
Date: Mon, 27 Oct 2025 10:30:11 +0100
Message-ID: <20251027093133.2344267-6-max.oss.09@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20251027093133.2344267-1-max.oss.09@gmail.com>
References: <20251027093133.2344267-1-max.oss.09@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefan Eichenberger <stefan.eichenberger@toradex.com>

We used regulator-settling-time-us for the wifi regulator which is
wrong for regulator-fixed. We have to use startup-delay-us instead.

Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>

---

 arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi b/arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi
index 4234289d4012..f2646db74a5f 100644
--- a/arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi
@@ -78,7 +78,7 @@ reg_module_wifi: regulator-module-wifi {
 		enable-active-high;
 		regulator-always-on;
 		regulator-name = "Wi-Fi_POWER_DOWN"; /* Wi-Fi module PDn */
-		regulator-settling-time-us = <100>;
+		startup-delay-us = <100>;
 	};
 
 	reg_pcie_switch: regulator-pcie-switch {
-- 
2.42.0


