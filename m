Return-Path: <linux-kernel+bounces-826823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B89BDB8F6EC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 10:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 65E854E0683
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 08:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4032FD7A5;
	Mon, 22 Sep 2025 08:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GD6X+XhG"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39742F8BDC
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 08:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758528754; cv=none; b=tUJv80yAnELWQMHjE6LjowiF9V2F/aaP9izafTbSOyesC3yynZXNBe5vgc9dRCgxZzVIukyMmEy7qGNlg00peN94xFizpqJJGAe3Elm/AzxOBZFGBq/jDwfLxyxPKYmD6aZRqbJWG+Qm/7eakPBqcS+vEnzDshdAPwCLhDcANWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758528754; c=relaxed/simple;
	bh=2cljBbctUpov7EPp9dHLO/NTrzVDPxTc08Ag9XJ0xdk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EFDsrBJymDnl+zyAZ2+PxplFEiDXp3rap1Lm/wXb4Zs9HQp6XHkKSeAu6EYBKcq9En6SybmmgbL/HkdFlY5n9eJ0yeOTB6O/RtxJ/kOwlJHm0R5ZbY+dTjNpUnEsPlgm7mJWWF+fNc7Qyl4QUDoY0QRMK9tDwDmwY8TQkwY7CrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GD6X+XhG; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3e9042021faso3230479f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 01:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758528751; x=1759133551; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8htGACZZYE1dIEbtDAUA+3P97IrmED7ZD9WcIPqTfx4=;
        b=GD6X+XhGPR3drqDCQdw9PMOjJ+EjGbxRqE+3GgKT+OesFW2rSrDgaEoYNiIIMqYmk1
         ymu/g0BNhGJrdACy/l6CZaccfhe7WV6CIIdTgs4p2GXAwYBo1e7SD8w1S+xAovpeDvFI
         b3ZBrtXJjyv4FE41zz9cXKbQtftCnUKJwDs41LV5E1RexsmCDNDo5RMbgezUvK9egvzk
         Je8hoiIN5E4lIqCy6aPrZ/jEFHDZkrg9GZ3QW0BN38xcN74vs7SS0aG3BE+QyISRu71H
         jVyQ/2CoT2ux/HjBSZ63d2ele8QpKxlBjj5+m3a4x/JrVI67/9/9q5ecXD6ZcVkChPHp
         504Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758528751; x=1759133551;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8htGACZZYE1dIEbtDAUA+3P97IrmED7ZD9WcIPqTfx4=;
        b=Q/W+yBPq9KutBgX4GXhQNErwe4LYjhFqkNL2u9YE0uKMTCNzqnNMlQRqgss3NpDnPG
         s/NZJnpuyubDjpz+omgRArA3fMNxOfyxFMouMbyCWycA/1MZ9PI8YD0UVsolMuxy+xmz
         U5pha5zQnh7YOaXa6+gcIYVT7inpfk8GyFaXtIDkbmt2fDvUfp4t5KoXp4WHo0QdVNfW
         LygvfScZFtbpdcI5rqhQd/fePMzisf1GX6g1UIz7wb32QyTX8GUJycpoICL7NYg0feAJ
         yedrp98QMSEeGpFRuiGUGf3Sk8/EuTC5B0av6EvH1XLBR+cEwsxVPrfkLGisGb+LH7yn
         e/UA==
X-Forwarded-Encrypted: i=1; AJvYcCVxhcZUwvPRWiXeGZ5Qkj4MU4+CUmEWLHBdsD2kXlnYY1pMYv/5qmwcUtfWpv0SMwfpiYp/G8QRB+EsH7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy34opRogJEhqeMwSOTLKnROfBMxux13E2gQ/4VX0Vh0ctGsB9b
	GMSdWTwPOYcvVF5W2lWafxRThchyNf8UCz5g1xmpk3koxGBqHuYpeSWA
X-Gm-Gg: ASbGncvPfcGYUK60cxEGWGg3IzWGJU+9SKTBnnAxyFwdAS7HIvWPtM420KVVh/LthZ3
	a7izd7HTqeOf4yky150+xkqwPLneaQ+THX3nNPBR3deAoWjOHB5D3uRwTu2hv72+5SkwHaKzQ0u
	+awzw85cvX1E5IgDqiIXEqYAx+ANfzs39/SQK/3+qGdQSEn8207VETPDRnZWI8l/vJtX8uHZFXb
	GjVAMRDQindGdEeIocWR2fqXEhZNiuMcglWKz4KiWC4XE62z+hklIgSfVMKdT/XgJdkRuR9Yv4P
	lONsQ3SWe0PkYwadzRyu2CxI4bF8KGZXvi8xOjTphcTpFFUqJuIzxJIEdVMSHb3AtAqU3S49qdl
	ghTecQ+eMi+OpOe63fAm2Wy1CBsIUKf1C5+oBiUJcCbRcVhDCs/PnErbhO2a5L/DsdrwFZz4HrO
	wv7FHrYxacFYZqsvI/
X-Google-Smtp-Source: AGHT+IHIVtfPSrHin4y9JkfBQxIDF6jMfONQa4rDA8eGnaJ0DC6uDJwECPyzN7tfzI8/ktqkL/ZedA==
X-Received: by 2002:a05:6000:40cc:b0:3ec:d78d:8fde with SMTP id ffacd0b85a97d-3ee8585e38dmr9724920f8f.44.1758528751149;
        Mon, 22 Sep 2025 01:12:31 -0700 (PDT)
Received: from localhost (2a02-8440-750d-3377-171e-75f8-f2d4-2af8.rev.sfr.net. [2a02:8440:750d:3377:171e:75f8:f2d4:2af8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3f00cc58b91sm12911883f8f.1.2025.09.22.01.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 01:12:30 -0700 (PDT)
From: =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <legoffic.clement@gmail.com>
Date: Mon, 22 Sep 2025 10:12:18 +0200
Subject: [PATCH v7 1/3] dt-bindings: stm32: stm32mp25: add
 `#access-controller-cells` property
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250922-b4-rcc-upstream-v7-1-2dfc4e018f40@gmail.com>
References: <20250922-b4-rcc-upstream-v7-0-2dfc4e018f40@gmail.com>
In-Reply-To: <20250922-b4-rcc-upstream-v7-0-2dfc4e018f40@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <legoffic.clement@gmail.com>, 
 =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>
X-Mailer: b4 0.15-dev-0dae4

From: Clément Le Goffic <clement.legoffic@foss.st.com>

RCC is able to check the availability of a clock.
Allow to query the RCC with a firewall ID.

Signed-off-by: Clément Le Goffic <clement.legoffic@foss.st.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Clément Le Goffic <legoffic.clement@gmail.com>
---
 Documentation/devicetree/bindings/clock/st,stm32mp25-rcc.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/st,stm32mp25-rcc.yaml b/Documentation/devicetree/bindings/clock/st,stm32mp25-rcc.yaml
index 88e52f10d1ec..4d471e3d89bc 100644
--- a/Documentation/devicetree/bindings/clock/st,stm32mp25-rcc.yaml
+++ b/Documentation/devicetree/bindings/clock/st,stm32mp25-rcc.yaml
@@ -31,6 +31,11 @@ properties:
   '#reset-cells':
     const: 1
 
+  '#access-controller-cells':
+    const: 1
+    description:
+      Contains the firewall ID associated to the peripheral.
+
   clocks:
     items:
       - description: CK_SCMI_HSE High Speed External oscillator (8 to 48 MHz)
@@ -123,6 +128,7 @@ required:
   - reg
   - '#clock-cells'
   - '#reset-cells'
+  - '#access-controller-cells'
   - clocks
 
 additionalProperties: false
@@ -136,6 +142,7 @@ examples:
         reg = <0x44200000 0x10000>;
         #clock-cells = <1>;
         #reset-cells = <1>;
+        #access-controller-cells = <1>;
         clocks =  <&scmi_clk CK_SCMI_HSE>,
                   <&scmi_clk CK_SCMI_HSI>,
                   <&scmi_clk CK_SCMI_MSI>,

-- 
2.43.0


