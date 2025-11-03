Return-Path: <linux-kernel+bounces-883634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51EF3C2DEFC
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 20:48:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F9981882C68
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 19:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EBC3296BDA;
	Mon,  3 Nov 2025 19:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JA4Fxuhs"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7854D1F2BA4
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 19:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762199174; cv=none; b=kqL2jWUMYfEeOwdz6Ff0LDYo9sJUr8dOSXo4Ge760+kxeBLY1PaNESvqomuN9H9vFTwSUXodzSAhz9ooqdDwSbUzp9+I8XdSJieowR+0iHs8dBdWQc6KJsI5RhqQpmui0PmguV+HdERp0lTUaeiikXMgLviUL9L1g8+Q23TCy1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762199174; c=relaxed/simple;
	bh=MRXE7DT9OxccPI5TsXsQ7xdXXyvKUg7JkhqyAg18Mhc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GwuGeVu1+IZBXNjJD3oEnsxKRdkZYt4/N9+n3vYnN/b8xdhlT7QzSl34cozGT6Kw660ZV5fBTfIowHTLwCQrheVGYnVNjxRgilG/9iarsHu++fkZmrAduxAc03QpGWWZo4AXBVxgNEjH8LD4gpDBDw+BzGrUcRBQBn+XC6oFmbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JA4Fxuhs; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so4817025b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 11:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762199172; x=1762803972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RMKjToI1cPGuPb6glfsZd8eb+wK7aS/JWYDCdguKThc=;
        b=JA4Fxuhsu6ZXDHA6opaJhTNwhG5h/qFlKv/l/LW6sX+a2Vj7u+GrHQmeAVpQ8k8Gdr
         uE9szcQCqIJAJ9g0CAz2Vkn5j4HRLDF9/0nlAhmlfPQVCF+Z7ZcKsvl2NkpL2Grlkrvu
         VqlPPkZiTWnhfxeM3R3Asibqk/TbJeDnsNdFCTSg3FIHDI4BcK5v8op4sAzSREHyDra7
         rGZGVbyh9Vmhu1aLohoXm2qrADG6TFthned2XSoEtgGa5QITAsBVsSMAm3n670aSb8Pq
         wjWe1r4+yCidXvyEKBKmH1pHUFwTNNN/DUU2t009KsWoVKidUckfJ53xLqSDWb58lfT3
         zBGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762199172; x=1762803972;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RMKjToI1cPGuPb6glfsZd8eb+wK7aS/JWYDCdguKThc=;
        b=QsjYKeW/yoVRe7tmOUq09LgH5biCkjtkFkJPe3QIGOy+TN0w7wPzaGhVedBaYPV3xp
         vNiot+DAzB7lK+XOROktTEJ+KNTYse141vNiwPLVzGrJ2TDRblGviB8WSsMdMqFE2vRH
         EuvvbtpWKuF1hSsULrdV0KFInJeMNcGYI6t6HB0ON0Xa+yYiU6XHoK7ke65O3GHQzfDT
         nLRrhNbfYeSbAK/oyohQdcUgUDnS3zJSyWXDFQvkghHdeD6P1wFmq8bgLnCxVcdHZGtp
         xHUSK/KGwVj7COe7GIWuUM5eD+5zvm2+uXmm6fF+/MKVDIpZ4nhB5oyeP1SC4kNxIRb7
         e8Jg==
X-Forwarded-Encrypted: i=1; AJvYcCUm+Tw+IrRh+fK1ub0tXQrkhrR+VjzPqSU/RjlQ5oMWsfPYrMOjhqAXvrz7V8XI6xXbICwCQxmswyqYWRU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvH4BSQ+7L8nj2qxhfxnpaJgeGVwkizY60s2BZm1VKlKNHrWCe
	SijtVw8HOTHAqh1fOESoa8H9x7G1h/y2o2560IDCu7c01crugzqG9lr8
X-Gm-Gg: ASbGnctiXFT1h5cjK6qTtAqDJSBUsIldM9U16io96kfraJLqAtj2Tya2A/B02uMUS3i
	RK86feChcbKhsnGDODSCLCzVkQ3RP0QL5DDPrgbP8mS70frxTDhlEswR4lDsK0nNgRw9/y46yJn
	VvloNvdMjjL3y2/TnKTCAUKEbtbIAYb4H7HzUQCS8CqhJjitO0D6RFTAF6m5MR3etknImcgjDd3
	DU1RrFF2svOUa+WwqV7jfpec/nF58ZYp6j29bgOxotYh89cB3IsUS9TtjT/iWlad+VfavlECzSh
	07UxFAv3eYtwwQzXKenquRZ7EjemhJWfan+nmK639oUN8C84WV3C+oa5At7Y5MQWX62aCjk6lAC
	ywajcKtbWAPZ5EQ5YRywRpSiC4Nty3MXVqA3/xJK81wUQ5yhujhYhPZ45ytEMl64YdutDSUYFnQ
	b+ZX5e5P6FaWKeVF+HKYN+tzvPI0rCmw0=
X-Google-Smtp-Source: AGHT+IGs/phsqHMf7vgqUydH/kHUo9Pu6wt15y2CjfYpOAPnQUisNU2Uqoapi6ssdQv3N85Tdviw+A==
X-Received: by 2002:a05:6a00:c96:b0:781:1110:f175 with SMTP id d2e1a72fcca58-7acc1a2d907mr700653b3a.14.1762199171727;
        Mon, 03 Nov 2025 11:46:11 -0800 (PST)
Received: from iku.. ([2401:4900:1c06:600d:df45:8e1:7a61:1482])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7acd586bf62sm199588b3a.48.2025.11.03.11.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 11:46:10 -0800 (PST)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
	Hans Verkuil <hverkuil@kernel.org>
Cc: linux-media@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] media: dt-bindings: media: renesas,fcp: Allow three clocks for RZ/V2N SoC
Date: Mon,  3 Nov 2025 19:45:54 +0000
Message-ID: <20251103194554.54313-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Update the FCP DT schema to permit three clock inputs for the RZ/V2N SoC.
The FCP block on this SoC requires three separate clocks, unlike other
variants which use only one.

Fixes: f42eddf44fbf ("media: dt-bindings: media: renesas,fcp: Document RZ/V2N SoC")
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
Note, there are no current users of the RZ/V2N FCP compatible string in
the kernel tree.
---
 Documentation/devicetree/bindings/media/renesas,fcp.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/media/renesas,fcp.yaml b/Documentation/devicetree/bindings/media/renesas,fcp.yaml
index cf92dfe69637..b5eff6fec8a9 100644
--- a/Documentation/devicetree/bindings/media/renesas,fcp.yaml
+++ b/Documentation/devicetree/bindings/media/renesas,fcp.yaml
@@ -77,6 +77,7 @@ allOf:
               - renesas,r9a07g043u-fcpvd
               - renesas,r9a07g044-fcpvd
               - renesas,r9a07g054-fcpvd
+              - renesas,r9a09g056-fcpvd
               - renesas,r9a09g057-fcpvd
     then:
       properties:
-- 
2.43.0


