Return-Path: <linux-kernel+bounces-875524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6308C1927A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5BA51C81FDC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7D32FABE0;
	Wed, 29 Oct 2025 08:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fc1b2abA"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377B2313E13
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761727243; cv=none; b=WB3C4vBmsTZFProaUbzzOXMIcp5LtXedXNthp/5stWByiNXq+LOkNUOzuPrOtB2BLdlvWl8VwZzz4Nxb3+8M4kJQrxd8wLE0rTABM6PJaUB97EoOFDYwWyy67hgRC3C0qpSKjmld/nQV6b3X16+Oq5WMHO2RVXyvAvVQpp15gZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761727243; c=relaxed/simple;
	bh=ByNPBZVkQaRvvDMo6YDk7cXzzfRGMjEtnqu+EzYfgyw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nlhOPkkxtzmmMXhIVQ0oclupzT0Qc76yDxibY3sE8wZtoca29xz3X9w80SM/nRGGN8QnbEBkICoYsPNAhu6BDSXYaluoMSonxQCiiAQulgSsJ7NmICftyr+WTEr50Lya3KPSWUAjIbloznjdiQJcC2RBnhN7gWXE3MwpJIVifxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fc1b2abA; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4710683a644so6744525e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 01:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761727239; x=1762332039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BWxjeRjOEhcNVgfP/QkxqsBAhufcjSTlJ37Z8hpahuU=;
        b=fc1b2abACXsGrYVYbOoRbk1aU9GwCAixenwSUb+70ZEoEYVI2UMcVw5og8SrRI0hWm
         plD5ndoxhZictdq0i0DZIF1V01lDGUBRxVuv9sRjJueikVmP/R8uIX/8HfoyX6OkpYyU
         QZbBksKXPNNsMHtzS0TeoBWBAbzdP9ZuExuT1QNinz08ElqYYqLvKyGSPeZdoawBwNAl
         mYP7LgpEaFLgXEXvo2p+vMr0HAkm38ncqI6CdNVYO1n761/olzxn92pRlPrAJCfyz7UK
         ARGQKzkJrHWfY9E/ABBd5sYbiW+xtvI4G6rLF4bhvdiGTgB0/NCaPzlz7y0bjBls+MsU
         Ki3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761727239; x=1762332039;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BWxjeRjOEhcNVgfP/QkxqsBAhufcjSTlJ37Z8hpahuU=;
        b=gKMJGQJuum/pMSt5EZO4euTLKQsfkjMveqdFGeXO8f2gT5eWN6ebOfaBQtlkiX3zaO
         r0jiezF9IelkIwADHKDPh3zd5dPunZ46J+P9kD/YDV9Mcv9UC9RTvDMpttg4f9Bdo3Xx
         mPUqyOwFJJe0v/ek9NR+f3AtFljPRYZfvndtrXC6qlD41Ao4Rqv5+qOgzfkcGiegCWiK
         JxnaMLBhgtiT12FS3xHwANQmJqk2+IOCDukHSDTTg2HzDc8rXYZVoWuCSPebI+LSeJDT
         hEHcmXCKmF3j0/LTOcy0E6vZ30NyigKEZJ6k8cFCoRj3IcaVUA//r+uPVomsYSUcu44K
         OCBg==
X-Forwarded-Encrypted: i=1; AJvYcCVkdxUTpLxy2JpNXkuhH8ASmM2sDyiKwIq6PzjZXNSv+Lf+E1fkq0f830kGYzRCvv2qok0ZTYoQlhTHCRk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrLbYw/CwxYbrpa69kSwArrah6xDmIJnMwqNM686a1Ww/6tyT5
	zcTmL/bG6mITnzeA5u8DYNDMZtKicu4V1ioK5+1/E8tn/IF3O/i3B61+
X-Gm-Gg: ASbGnctuOcaldbuvCQAHjlzygIyvt4tgD62XO8JjiVy+6WjdRiG8KFhh9dbiBU8qp5X
	r7atRuaSSwny2oVMytV8psBN8LWhRG1zWlopiizT04IDVkoaA8r6M+eX/TOXzLizAsDZzSwsVk4
	MFY49OUJaE5QMA+w5KTdUzGr++F15Tm4tziXT2Ed2g+LmbQlLbOYnJX38gwHFkSrYABICjCDdzg
	XZCrdvcboBp1Jv3QGgBuByR++kkh6z1kg2M4pDBB3puVWhsjHVxgWtDkseMUIBSjBI2tq+BMqdH
	rIG58D1eTHGQA0Ny/KupRE84Gwdn/L13PylO2zOfBGDjR9wYSosuua5BXZ1g1K+XbloEgGROA6r
	52DyeKtVLugQMKresBxsxQJBcVYiqhRZiqZrOu0eGee1+XkY/ZqxkabSjFvM2N8ua7kYskXjE+2
	I3QjovglaX+ZJQleeLNF1Y8VWabZFQouoehBe37IjUTU05ZM0zdTxtqGyG6j8i
X-Google-Smtp-Source: AGHT+IHzDG9SBUzGPViM4O6XUORkMfXDOjYXSdJLjQD/Nfqn6/OKgCqHeLDZcWlwFIAoLgO8gs3hzQ==
X-Received: by 2002:a05:600c:4450:b0:46f:b42e:e38f with SMTP id 5b1f17b1804b1-4771e6a188bmr20563075e9.19.1761727239422;
        Wed, 29 Oct 2025 01:40:39 -0700 (PDT)
Received: from biju.lan (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4771e3a88fdsm39485785e9.10.2025.10.29.01.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 01:40:39 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH v4 0/2] Add Renesas RZ/G3E USB3.0 PHY driver
Date: Wed, 29 Oct 2025 08:40:32 +0000
Message-ID: <20251029084037.108610-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

This patch series aims to add Renesas RZ/G3E USB3.0 PHY driver support.
This module is connected between USB3 Host and PHY module. The main
functions of this module are:
 1) Reset control
 2) Control of PHY input pins
 3) Monitoring of PHY output pins

v3->v4:
 * This patch series split from[1] as this series can be merged
   without any issues.
 * Collected tag from Geert.
 
[1] https://lore.kernel.org/all/20250916150255.4231-1-biju.das.jz@bp.renesas.com/

Biju Das (2):
  dt-bindings: phy: renesas: Document Renesas RZ/G3E USB3.0 PHY
  phy: renesas: Add Renesas RZ/G3E USB3.0 PHY driver

 .../bindings/phy/renesas,rzg3e-usb3-phy.yaml  |  63 +++++
 drivers/phy/renesas/Kconfig                   |   7 +
 drivers/phy/renesas/Makefile                  |   1 +
 drivers/phy/renesas/phy-rzg3e-usb3.c          | 259 ++++++++++++++++++
 4 files changed, 330 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/renesas,rzg3e-usb3-phy.yaml
 create mode 100644 drivers/phy/renesas/phy-rzg3e-usb3.c

-- 
2.43.0


