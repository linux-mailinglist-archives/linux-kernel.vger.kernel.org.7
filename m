Return-Path: <linux-kernel+bounces-853244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E6DC6BDB011
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 21:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E9A4D4EFAD6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 19:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85AF92C2359;
	Tue, 14 Oct 2025 19:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MoNMO7gE"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FF82C15B1
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 19:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760469100; cv=none; b=sUXCikmci28uPs+TtOSN7NyXQ3v8Ic64+y7L8LsL6OIkP9tqvxfqPTmI8Ed0g/A/y017LY1jWKu1OtApaojgR6LfxZ7YZG9Bw5yDfOC1/5X74qvQIq5Rw9F8O1XHtWpG5X0I2lfL9edM2iwg6Lb0f4tnrRa/6nFTDFliLKLj8oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760469100; c=relaxed/simple;
	bh=S+PaKb4dQqXhsbGRU/uKTbWTAhncSD2zvQfzn4XNbaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iqEDt2KjaZNYksJcKPdPWPHmWzf572/JkWBMAbBv2wevyqFZtrQIquXqoQrvs93cg7nBwC+vXoUyVtpfWLREblkgjO9qCzg4O5cwNMISBpsbPvcqcc2nMPibV1gJQ+3s5uWdLUFh2iIL8rMFDF0u6P6e9ug+j/nXBBL78rBV8/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MoNMO7gE; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-26a0a694ea8so41728555ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 12:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760469098; x=1761073898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jwe7YXxDoU+cIzHCYhHi5EBndZPOQECM5/AlfPL09Ic=;
        b=MoNMO7gEFJpfhT0fJmnqe8fE8uaO59YuIZXtSdoDHDb208twu/1cJnqPqcQmbMgeY5
         Ay2x5mueKrDvQV/O6w/CdmdTI/qTDxgxb0UXet9SzD7Gd6brvIBcnHjzzzZcA9HxjyA6
         xwPKXa6KXrLccKYyKTjHG2TlF35Z1kupvgWOZXoJpvC5R+J6mai3bTGfOTdSBqmbLZSL
         FDzdkMBd661JSRZ5EuUhWw8lZweWNc+pd2bulKZ/v6OBLG78ix5bD1ozJ1N1d0/1984q
         WzIeF1holATdocVUwNfrNfIwBuAnI7OWENnKB5s1PNORwvvvS12uNhK/QZ9x3l+XZy5g
         1e/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760469098; x=1761073898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jwe7YXxDoU+cIzHCYhHi5EBndZPOQECM5/AlfPL09Ic=;
        b=bSlr2Dwpi6xbI4CwZMMzJgBZKuwP2DiC3OYJQOrCiaqywnAbnaYvioLZKF54rOBVku
         dAgpSuE5URQFC2hrHrMMsbWAdbyiviJ+fxRYAPigFzbLcGPbWyZILw+moglLH2ytd9OZ
         ItEiHnn4ZPOBPzKsdUhEWhMU4gSAguB+F/skY96iFFUil0KMPf/9ONW0ce8kZtBVjhEJ
         LLBNvHPsaxiPhqW/T3BVSK9+aFHXrFCiguNdGM74BO0aOsB31kimF44yJRhcruPQxKst
         AR1/VYJDzBAnhszwKM2RD29kEi5XsB6JDMsr80R8kpCEPn/YEeDKBuCQnsnX/WxMj9vd
         3kuA==
X-Forwarded-Encrypted: i=1; AJvYcCXBUKc1T5dY2xryrdk/2yCoEDe9jXLcOXNkU6cbPuuu7+mIqcrIJtpgGG/H0Ai9omMv54SpFaf3n+PbdFc=@vger.kernel.org
X-Gm-Message-State: AOJu0YygtGj7zEJnMDPnyXbOV0GugTxcpVnCjNcRcs959EC39EHc52Wq
	GGWrNI4MIpGDn2cssU6t82DIpM/BN8PLiyO+e5YprzkQdooZi7p13KPS
X-Gm-Gg: ASbGncuZPCj6BaMvOowvXzyB5hVLu5ADLiffBi3gnbGZFUIgUgQPRsqDPsXaCZKyYXK
	qywwo1vTrG43uO/e42RsUxpvcZx0GqHbZYhQluuOK5K+aEWSTEemXLJmOXn5F5LqZdWllfsrdtK
	GaY5BLnxcgtFQrKsfChUZuebruEBy4pyQZDMss0Wox9qIQdQpXuDXlThY4LMe9LN71uWx8r62WO
	s1owwujDsIC0/9mrM4wx2WyjXKnC30t+Phy3zC5eWQ3+EqNM2O2RBqB+Gn5Mtt4c3lRsUZqJAXs
	9kRaaJ+qF8UkbG2KX1fDcGnPG6VZUiZEFyE0Uk1A3McazeGk5NTNwvigmSrWBzNwIB0qFIdEt9V
	3jdLPAtspzPsPBZW2/FUksWQAzAbFj7W9MqzY7w2Hs3oMUwLEg1iVLxj5USuB5I1oTFOdZ8A=
X-Google-Smtp-Source: AGHT+IH6L9b+RAsdBPIs/9RaZ2biO3IFLWe3hSdfFmc60wanjgFfuMqCTaW562R6ttOdauQ5UDfmIQ==
X-Received: by 2002:a17:902:fc4c:b0:28e:a875:f7d1 with SMTP id d9443c01a7336-2902729036bmr315973415ad.10.1760469097611;
        Tue, 14 Oct 2025 12:11:37 -0700 (PDT)
Received: from iku.. ([2401:4900:1c07:c7d3:9987:bec4:a0:deaf])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034de658bsm172402755ad.22.2025.10.14.12.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 12:11:36 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-renesas-soc@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 1/2] dt-bindings: pinctrl: renesas,r9a09g077: Document pin configuration properties
Date: Tue, 14 Oct 2025 20:11:20 +0100
Message-ID: <20251014191121.368475-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251014191121.368475-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251014191121.368475-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Document the pin configuration properties supported by the RZ/T2H pinctrl
driver. The RZ/T2H SoC supports configuring various electrical properties
through the DRCTLm (I/O Buffer Function Switching) registers.

Add documentation for the following standard properties:
- bias-disable, bias-pull-up, bias-pull-down: Control internal
  pull-up/pull-down resistors (3 options: no pull, pull-up, pull-down)
- input-schmitt-enable, input-schmitt-disable: Control Schmitt trigger
  input
- slew-rate: Control output slew rate (2 options: slow/fast)

Add documentation for the custom property:
- renesas,drive-strength: Control output drive strength using discrete
  levels (0-3) representing low, medium, high, and ultra high strength.
  This custom property is needed because the hardware uses fixed discrete
  levels rather than configurable milliamp values.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../bindings/pinctrl/renesas,r9a09g077-pinctrl.yaml | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/renesas,r9a09g077-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/renesas,r9a09g077-pinctrl.yaml
index 36d665971484..9085d5cfb1c8 100644
--- a/Documentation/devicetree/bindings/pinctrl/renesas,r9a09g077-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/renesas,r9a09g077-pinctrl.yaml
@@ -72,6 +72,19 @@ definitions:
       input: true
       input-enable: true
       output-enable: true
+      bias-disable: true
+      bias-pull-down: true
+      bias-pull-up: true
+      input-schmitt-enable: true
+      input-schmitt-disable: true
+      slew-rate:
+        enum: [0, 1]
+      renesas,drive-strength:
+        description:
+          Drive strength configuration value. Valid values are 0 to 3, representing
+          increasing drive strength from low, medium, high and ultra high.
+        $ref: /schemas/types.yaml#/definitions/uint32
+        enum: [0, 1, 2, 3]
     oneOf:
       - required: [pinmux]
       - required: [pins]
-- 
2.43.0


