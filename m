Return-Path: <linux-kernel+bounces-870418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D554C0ABCA
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 16:04:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 15CAC4EAB8F
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 15:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E3B2066F7;
	Sun, 26 Oct 2025 15:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KGFfNx+t"
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405544A00
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 15:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761491066; cv=none; b=DEna90woX44PdeZ50oOVcJODf431gshHodJTYFPGHR4jQVP5elA7CEUa9tSoGVRNGLdw1vb2OohOBLfswn8PGYjRg+oImCL27C6/ErO4N7dGzsbPSW3urjfEnlKva2+QdVax/qiADQ+2TDcovaN/YexEVRQWHI9U9q0Zs1SO1N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761491066; c=relaxed/simple;
	bh=A3bSV3u8AarAyp31lzoLWMXHtLeH04d3zGSkueTEkDM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=reecgP1E+hY7MolpTifPWE7KHD9o9WTLf4iW7F1LgCp1RJv3UI0kG00vxb8MCnIdmsxGFqDZaIlfAAN7AnM/V0nUhW3PRDTDLobfIn8XGyufnz19whyz+CRBAplhcxvZsinC5x53E2ZXKIGdzAmsuxLeqnLfP3oOMnvhzxPQgeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KGFfNx+t; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2698384978dso24120845ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 08:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761491064; x=1762095864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Px4DGTedr0t+HqBVc78Zx84UzxWlcHUehvdoHcOj/G4=;
        b=KGFfNx+t9dnPaKmJ+V8GqTuokIguft2n5kbPp6Yg3HnOrPfWxLcuuxuQNwuihlHnyE
         sOgNpBLRKZ2UnETM3LLBcJs75LRoiR3S9lvDG43wHVn9MLizyZZ7syEq7jBz/y97eWrS
         E/TsHG13ZU8TpoUerT36DWrWWjGdNJoSxtEulI938OjDftkN+mlOa4AHCxpDdjuUGvRJ
         X/7Uw/lonjCniNItC+rzVg+dwbK2vkm/1s2cfiGm28aEantVJKyABdI25x5J7/0XTcy4
         LTWIr1AeSP2mts1KSETsirbWAB0kLOSG1ddJ9O5Vpz1VqijP1VQ6xhNYh/c8qWx0vEcx
         XksA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761491064; x=1762095864;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Px4DGTedr0t+HqBVc78Zx84UzxWlcHUehvdoHcOj/G4=;
        b=uDk4a/JKhNC1q6O14R29QTMLwGONirKyFw58bMPSfWDJ1dXHcrdR5JJHvXIY53VE3R
         J2ADJF+PZO+HooExuZZDQdhpStmSdmGGaRvpUYHYvsaZ79RhldtTjQh2PVBOa5p0gVD7
         t8cVl25NzeJjAzhw0uNoZMLoCOiZoxF7GjqzoZfvMXdEczrsgl12FNE9trr1N0U0YSMt
         cnugGq66GwxMg9JU0RurY4YDsJmbZxl+2OWQpSDhFbBF2vX3s0fecITARKRzdswqhGSJ
         AuL7Bp9r9sUWixxQfu24Di7VWCN3VZv647VSBF7OejF2Mb+XTh6A5//mmXMNPav+9qjJ
         rf+g==
X-Forwarded-Encrypted: i=1; AJvYcCX3LXrALlhsTQ+3ECyLryoPi4vdnD8KDwLFocpvkcOsEjmV8EUFGaKKlR2XKPajIw8H//4v+us/Mfe3jz0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7n1yUJHDnHbTp+m9Ylk1OUGNmNpRMy57OsmSfeKEvR/57ZmWy
	ibJhiASq9g89Q2Ij+wtiHydY2Nn+3LjWAoBzVMdEAD+xf9kXlrHltpu7
X-Gm-Gg: ASbGncs5NhOjxtR90ReNY8Za6/3LCYv+NOPJvAY/NW1/SCD0ZkLjzcFUTfTPgI3+ECt
	PUYMJFBT1CPYpSPJv1J8EfL9VhuXyROJumGQU3GsAxOEehTnMxGchwPIi1OcjFLZsTOMTqL7s/D
	Zw13Qq5wO1NRY1Zt55KvOtO9SioUYvz7sjJwfDmrkSblocxOIk/AeNCabo3BAEBP1lJDmhxoonC
	h6ErTOv1rfJEz7W2ItxClL64UJvFoR+XG74q91byr9+AnKZn1VMPIuj2fzjkL7hJ7MQq6pb2TK4
	bEV0lCx8xooa8hSdWiffJTgTyoSvWeFSf0/syxYtrwTL/dm6qt1XIICu3bS97YExtHNjQvUfeYC
	sL5YnD8ozFBUFA1mv8ArPGxnRfHXQGwlaGK1+dV9DNoU4xHbovWcf/tO+L/ymT2shbY+PLObDi3
	oxEXT1LZgX9g==
X-Google-Smtp-Source: AGHT+IGL4spg1O0mDgF7D8EgJ3Ni4wTgAIJZGQLvD5iwsaPiYkWPvkdowdH8iIGlLOxo0R0ZBTdCOQ==
X-Received: by 2002:a17:902:ce0e:b0:264:befb:829c with SMTP id d9443c01a7336-290c9c8a738mr391932175ad.9.1761491064394;
        Sun, 26 Oct 2025 08:04:24 -0700 (PDT)
Received: from server.lan ([150.230.217.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d09958sm52320375ad.24.2025.10.26.08.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 08:04:23 -0700 (PDT)
From: Coia Prant <coiaprant@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Dragan Simic <dsimic@manjaro.org>,
	Jonas Karlman <jonas@kwiboo.se>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Coia Prant <coiaprant@gmail.com>
Subject: [PATCH v4 1/3] dt-bindings: vendor-prefixes: Add NineTripod
Date: Sun, 26 Oct 2025 23:03:56 +0800
Message-ID: <20251026150358.1078453-1-coiaprant@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add NineTripod to the vendor prefixes.

Signed-off-by: Coia Prant <coiaprant@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index f1d188200..37687737e 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1124,6 +1124,8 @@ patternProperties:
     description: National Instruments
   "^nicera,.*":
     description: Nippon Ceramic Co., Ltd.
+  "^ninetripod,.*":
+    description: Shenzhen 9Tripod Innovation and Development CO., LTD.
   "^nintendo,.*":
     description: Nintendo
   "^nlt,.*":
-- 
2.47.3


