Return-Path: <linux-kernel+bounces-792196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E780B3C153
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 18:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A61B58807E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 16:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A208C335BB7;
	Fri, 29 Aug 2025 16:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHSc1o0b"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542BB1C5F39;
	Fri, 29 Aug 2025 16:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756486459; cv=none; b=V73U/tPO2NhaaTTXYDF/t5OOe1P65dQbB1mskR2ekUMkBYxRPt9aZn51mCvJsd+c7BbKV0LAl9uIxuzlP/Q9RBXosRx5uvZwppyUQWsoMte+RB0Dsg+uIyPtYe84WxgE1xYIAnQrGBCuzv4Yjagx4b7p+gKg6pOKYBYv42Ll9zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756486459; c=relaxed/simple;
	bh=Vh8pONNqdH2cxr4ASVNyZwGHW7S+J8hy1ibyRDo+Ft0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tr1BqX6u+FFtGsWoKnDUBHcqnS6YaoMIZmeNI6CVOQfYON974d93O/Q1y7SOppKQ5mvHUAsuiTEWir7hdobwCNkTMGLcB84a7THVfZKH5UnGNBb3aFduLHWZYVrdiPiZgvu2pv72/J0UYpplHCH8Hxwxm7DSZGbizoRKWPzCa7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HHSc1o0b; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-61cc281171cso3968450a12.0;
        Fri, 29 Aug 2025 09:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756486455; x=1757091255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S1TbylZkgz8Mkd/dwqE0/Jwk1LwcVvsjwyovQ8CGLbA=;
        b=HHSc1o0bb6O55p1bV+XJ2Ns4PDtPPFelPH2N3LoFh2exHhIxtkZE/H3vp2dJPhXch6
         YDIBqmbr/U5/mHkn5RuTt1c1G8cgFTjhazJGdOqNg262L3DIah5GlYqMToDz8FtBnLAG
         eOvzjtNSbkZs/bDPcHizM8nWBTfSi+qkbL99oC8DYjFyHw2T658uik63o1nxyz7TmzPC
         m0bSJyr3TIPFiNDcot0rFSqYaxcEumTUVl1i2ku+LCrawOaXFooZtlkIxjktSe0Jon64
         G5dqbLPQKXAJ+1lzWS7CtwzA9fqfPdBYEHpX5iuMEzXA5Yyi8SXFpglxu17dG+hA02XU
         Vp/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756486455; x=1757091255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S1TbylZkgz8Mkd/dwqE0/Jwk1LwcVvsjwyovQ8CGLbA=;
        b=EZAqe1oEselWewbRNa20Ja7SVlYDR2ZX1l3PUcGSUcq69DeZw0VWqoiSBeu+7Xseuu
         LiNehPcoTFi5pf3zGboGc+03Ek0ayzGbL1TvmpzPNkcU42+bip2wpjIQb4bpyle8Vmod
         OC12lmgWnWE1qNC0exTzukpj/qz3o2Hclg8L4c3NpvUiCu/NIsIdwbKBbg8snACLSqWV
         wPwFUjaGcd58tz3lZRKTGp7PK85cBzFrdPvTr5yvDGxY2N5KLWarg/CqWpMKUb6SfSAz
         IL30vxoj1dJ4fLhYZeQX0tVXro4Z7CFaoGwV781Txvz2+XqoNtHboAjlh35Yq0L8pY+1
         2hTw==
X-Forwarded-Encrypted: i=1; AJvYcCXiPBVrkGVPTYHMppprLQnNWdrH1B/83JQf3j2BiwW73gx/7Mrz2QghD1j33nTLHH4+rnau61b4EXaSEEU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKDX2wGpXB15OB6i2UxyfzEPmHRQ6bY4fj4LrYfq3hJhUEhESi
	y3WMugqgyq4z/cAg+Tj7UkUV7YWLSDn+o23163Y9wZVqHRZpAEL+iaT/TcQ4JPxO
X-Gm-Gg: ASbGncsWxVS7UVL/uGdWjD6C+4LhRSGa0Og5jKUTG1Q4zEK+hFCd5gXGbfh/N2/RSks
	cxqjca1XoTaTs/bAlSNdwF+mEEbH5FOdxIN9r1Kef/MCp/T3e8plkUEuUZHjE+6l9k50HRecUA9
	Vue46rY9Zs1jptTdnxuQbufTgO/z1vXk0gSC3giR0o6N8FmzIQnHnfC3g32tcQav+G1MejDXF6S
	R2l8iKZsvs12ZFUinYEw+iLL31iLVgWitL3MFVsjbc8ucVpX07u6qfO+gobdegom3mfhP/ylS0l
	TjfYISCDMSmSjILfkSyo5+gd3SuP9PcNDeXaZGDFPwTLPoJY8wwiUIWq4BrqaAJvzwcsAeSTOh7
	/lEOw5Syylg01g0tYftj1lXh2MhGnuybGsbgLR+Tv2EiOsbidSD9WgzObQpX7ZxbgeESOZHZnmP
	ruAj5KcQ==
X-Google-Smtp-Source: AGHT+IFy0TAMi3Q+ZqyFrZeouS3CvWNb30h+N5bukCpFIMZHGFkaOOWeYA1wUKsje2e0ELbY3m2LzQ==
X-Received: by 2002:a05:6402:5c8:b0:615:957f:416b with SMTP id 4fb4d7f45d1cf-61c1b3b93e2mr24287623a12.6.1756486455455;
        Fri, 29 Aug 2025 09:54:15 -0700 (PDT)
Received: from Lord-Beerus.station (net-93-70-53-177.cust.vodafonedsl.it. [93.70.53.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc1c7848sm2130350a12.2.2025.08.29.09.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 09:54:15 -0700 (PDT)
From: Stefano Radaelli <stefano.radaelli21@gmail.com>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Stefano Radaelli <stefano.radaelli21@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 1/3] dt-bindings: arm: ti: Add bindings for Variscite VAR-SOM-AM62P
Date: Fri, 29 Aug 2025 18:53:17 +0200
Message-ID: <20250829165327.20007-2-stefano.radaelli21@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829165327.20007-1-stefano.radaelli21@gmail.com>
References: <20250829165327.20007-1-stefano.radaelli21@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add devicetree bindings for Variscite VAR-SOM-AM62P System on Module
and its carrier boards.

Signed-off-by: Stefano Radaelli <stefano.radaelli21@gmail.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
v4:
 - Added Acked-by
v3:
 - Change compatible string to match existing mainline format
v2:
 - Add symphony carrier board compatible

 Documentation/devicetree/bindings/arm/ti/k3.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documentation/devicetree/bindings/arm/ti/k3.yaml
index e80c653fa438..1cdb6464e920 100644
--- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
+++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
@@ -106,6 +106,12 @@ properties:
           - const: toradex,verdin-am62p          # Verdin AM62P Module
           - const: ti,am62p5
 
+      - description: K3 AM62P5 SoC Variscite SOM and Carrier Boards
+        items:
+          - const: variscite,var-som-am62p-symphony
+          - const: variscite,var-som-am62p
+          - const: ti,am62p5
+
       - description: K3 AM642 SoC
         items:
           - enum:
-- 
2.43.0


