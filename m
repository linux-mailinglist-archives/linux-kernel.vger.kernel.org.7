Return-Path: <linux-kernel+bounces-898121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CDA1C546CD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 21:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A09864E386C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 20:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F2628313D;
	Wed, 12 Nov 2025 20:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XYFvh+/o"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB3221CFF7
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 20:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762978799; cv=none; b=ZdGjbO6Bm67ql0IDiHI4/GqTNsKAuHEjsIJdR2ByBZam9nx7pSokGjeHrCAzoC1jxsUp6tdRSgClcfdytsnZ1G3xeOjtlz0D/Hb3FOWWMqVz7KpGudj9ax9dA5+1uYsM+gLkI3aOaUW1i+7yFbG+0lIFzizIG8Id+jntzLniPYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762978799; c=relaxed/simple;
	bh=mXLUdMaeNsOsocpfIsU47VhtEmPcnzDzuj2QI3HCoVg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kytpuz8r0DkaY1Aq038rvkEuvC2qWE/rXpHAX5xNQp8vTbrVZdD+wi0OdCMcuw9RZNTyOSO0JOn6CCVZ5K6xRdWPhdpWi3Oa6DszgvISFGHsJT762Qa4dXpMLBQTwTcqlnyDaqJGgjOwU0sygFuYLMPfKFTihHhxy09NEklk4Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XYFvh+/o; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-bc1f6dfeb3dso35243a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 12:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762978797; x=1763583597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5Ix38lM9kXoztkSDoiHdLhWVZujA0TOjZPfShJrrOb0=;
        b=XYFvh+/ogcaKO/P36GiUxCEBwXR+FqcmnRcr4SMs8XnWGPDr4tfyMa/0Fcp6U05VN3
         9Yh4fmYguEnPn+S2tm6oOTQQhZMGbR5YRHgW3MZ08g6jPWLQhPxJhCKjQ7W+JnVWMvTu
         T6wzGxyZvQ53NcR1iNV9qsVe+PbAg5FTDsWO6GYppIAfire9/2na++ZjI4smd2kNyX59
         IxWszrY+QUuLMDXbsdHRP2b8Sdg9xtJuhxyjz91M09PfNEngP/xwX6UnUdvgR8U2JBQF
         6qs97h7qGyQKa+PuTukH/z7TTjLbJnezRjy/ma4Ed35edfxFJmulA/Nr6vOyaZgb6/GP
         XPfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762978797; x=1763583597;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Ix38lM9kXoztkSDoiHdLhWVZujA0TOjZPfShJrrOb0=;
        b=AdZb+Og2hAvr+SAqDsS09p7OJyTsrT2XdZmju3r3ASSiVu6UFG8wGM6+kjiggJwUHM
         h8eqwp9UqawvIH6vvmu3e6jwYfEcv2Jdfbw7U+WtskBgOnZy8zzo/F7FUVaA97OWWE13
         tL8kDej1oTO3f4RGNIe+eo0v8N3MIC+1gSqGODq25juuZAyDW33ZYtAH/OMXRV5Wa+NU
         oj9K62LgcGZNrpTiYHhrYKO+V/S/+3ReVmN/QDebovNTTfW9BR1uVhdjIWWWxOoPtK0o
         Ud4iX0cidVHuBua081mr/3zRSepwHRKR3dfIpUVjUUYWoMJq5VvYLQB1gn06FbL9lwpW
         NIsg==
X-Forwarded-Encrypted: i=1; AJvYcCVxHgGIh6HdGdF+3rg3MF0Bey5ZcwnKv8+tGX5PnypdpyHp67dYXx+w8TMNXbwgMk00+OpBJmbsuTQigFA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9eoy781NwNP9AZbIFCpnXURcsTN5RhtSSxpZH+dornjAk4+w6
	dVipBhr+BxvMiWA3s2SK02c+hMFxxttF2Wy/GjIoyX62YmmS9imRo7Be
X-Gm-Gg: ASbGnct9R4g6ibze4wG0LFVycde3+KOAInwEzYJXrD+AAeqdcu9AEyUDQcSzoJ+tfCv
	fpqsu9VkdOXZgbki2BVzH+qSFW1qx2rbGcPvkk6s9GU5UzVEoOv2jWODAXIdpxG4ohdtLiXTLdQ
	atT7rCKMIjQo65RG569Q6eXTMzA5IYa53JnxSkNo+KTXggrQhO5REjoVh5cRJ1FSOdyUj2qCNvl
	Pkyl6luUWM/EO88Km59JaglARlnFvr5TcBjOyQrDdfDwjTK6YLzUAhbFxCFb6GkXNNjl3uruL+a
	cuDTiryclsft+e1ScIjpg73J58UlXFBmAzkRv0J+H9/+n+HPA+HAUsAf2qnrSDMRUchokB6qnw/
	clGWaoaoU9XUhKpteh6MOveTsTbODSmG7M3hRqmqC2QMHLcr5q/mm5X3UUHbwhm3N4HD/BMWNdT
	xHP7aRgBGdMIX7mQZyyi5H2P5y68iJEyaA
X-Google-Smtp-Source: AGHT+IEdxgwGyfM1n1piNaZeQalD3y12iobhYBGRKPRDwAyJ8G9Oo2HW8iH8goas0/jcmlTS1F5TpA==
X-Received: by 2002:a17:903:2385:b0:295:1a63:57b0 with SMTP id d9443c01a7336-2984ed9d5a9mr58544975ad.23.1762978797023;
        Wed, 12 Nov 2025 12:19:57 -0800 (PST)
Received: from iku.. ([2401:4900:1c07:5748:721b:a500:103e:1bad])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2377e0sm261015ad.23.2025.11.12.12.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 12:19:56 -0800 (PST)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-renesas-soc@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH net-next 0/2] Add support for PHY link active-level configuration in RZN1 MIIC driver
Date: Wed, 12 Nov 2025 20:19:35 +0000
Message-ID: <20251112201937.1336854-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Hi All,

This patch series introduces support for configuring the active level of
the PHY-link signals in the Renesas RZN1 MIIC driver. The first patch adds
a new device tree binding property `renesas,miic-phylink-active-low` to
specify whether the PHY-link signals are active low. The second patch
implements the logic in the driver to read this property and configure the
MIIC_PHYLINK register accordingly.

Cheers,
Prabhakar

Lad Prabhakar (2):
  dt-bindings: net: pcs: renesas,rzn1-miic: Add
    renesas,miic-phylink-active-low property
  net: pcs: rzn1-miic: Add support for PHY link active-level
    configuration

 .../bindings/net/pcs/renesas,rzn1-miic.yaml   |   7 ++
 drivers/net/pcs/pcs-rzn1-miic.c               | 108 +++++++++++++++++-
 2 files changed, 113 insertions(+), 2 deletions(-)

-- 
2.43.0


