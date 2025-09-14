Return-Path: <linux-kernel+bounces-815628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED149B56925
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 15:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59C8F189BB06
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 13:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8565022333D;
	Sun, 14 Sep 2025 13:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b75pKvRR"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B8B1F1302
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 13:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757855700; cv=none; b=FaLlU7Nmh8/uqJF+x+HOVfyA+G5QSZCQ5Yg8ps1z3a32Z+i+SNNRGaQjCZHZtCq3qKJFuxAu0FDNNbPfoFvmDIGezERB6R/Q8P0G5JFFMURpyG4qtBaKir1PNMtEsLl4BIo8189OOVtSzPYVTV9O3bDBjB2aqeut3l6WEIaOCi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757855700; c=relaxed/simple;
	bh=6ED/cZ+NqfhdaXzUt23lLQtv0SpOGvwArTrjdy4sL1g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L69zku7Cu6iCAUap9m7JdX7rOgV6EGBO9kInr+gYP+IoCjCh9+b0/fREMwDuUD8koK98QV/zodRHF/zyZvhX/UbyRykaD0F+8Lmw2QPxsMZF/JWHInmQ6dlqzU/kGjcz96AMuNuYjQK8xY/D852Eqh0r5jZTYpagxheLQDRCalw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b75pKvRR; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3d118d8fa91so1063777f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 06:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757855696; x=1758460496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=trovOubMvRidAW+mhU2Jgw87jFAcVgjTEKFsXv7vGoI=;
        b=b75pKvRRVQZ1ZKtn4UrMu/rPiopYbcozPANCpqvVUeKK69F4pJgVzHdCv4c2t2O2w9
         4dkuUQv3yINY9FVzlfzrkeCczFvsJesLgVV69u7If2oRlfo1/g0keAPchvTtBhE9Tkyi
         dCGuEhlg6uiIzKrn+v+CXoVdzTAql0LsXX1Yuzz/e3mK6Tm2c6w0iL4WmJ1VN43R6tfV
         LLZMpd9vDgNZU0a1t3FLLd/Z2cswt71Cp2FdsGx2dLiXDfAqit42jTA+wMtvSlVqanoV
         q83odSVBeZ3s+L8YXQRloqEK4PvIn26EkL5dP+3y6CGT14ocEgq48TSj8RMub3cj71lt
         Vg4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757855696; x=1758460496;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=trovOubMvRidAW+mhU2Jgw87jFAcVgjTEKFsXv7vGoI=;
        b=SURZZEERtyvzECoHibOwgpJ4cGR+i1r16FW1UUdT+MXx0/aIDTkHOGSgaBtxjMsnQs
         B6Y+icdZPbJu27fTiDMhRFJhCm5B/H2ymQBq7aV1TyyPEDbBKT+1F1dh/fAUV51mLseY
         5pFWGaFpI/jHJmA7BQGAXP5lskGntqmAF8ywNAaXkBhsBoQe0MOTrPA9h9MO8T3hf2NL
         wDjy2QEHC9Vd1g+qLMNCESq+nSlF9uORgXNOZ0VlRwG79iIB9WVYqD74at94lc+PNlJi
         1Cbsl52sNZ5kdLRtNHwECa3q8kwy2EAsZY81t25Z8/csLbYTenINlh+RAvIfBIV955v8
         2oGg==
X-Forwarded-Encrypted: i=1; AJvYcCV70ds4LDqtzWcvp2UtzIUDhX2OYSC9FW+dpEwIZj1+SZuWNvZPQodonKtsSmtLrkTgb3BeejVUFIs0Fgo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxULFZVawB+8qddc39shv6q83qhNfTYoTLNylGIoTjM0snbB2dB
	wFXsO0e0EAosODQIIUpN0/2UgiPRhnQd0LMfRA+pmziWYLXO1L3JIHFu
X-Gm-Gg: ASbGncs6RmWYsct07xCFtrsEitrmfoTwhPL/AjQ9h95sXIWu6wHBj1Cn//zu/3AAqqv
	Ak/6xTosn5FHiz0Lgj4sQKo4AF9rSmicNXfSwJh1Px/tQ9jvA/u7ZgQgq43uPHuXvcDk7cTbNH+
	S+81PkqM0lcHILOWOA1rwmHpA5rXGpFXm/h3ufunF2Yd3Y3GaB+8FPKrowZW5fU5Crvmn/Lh8a+
	k2guW9RLC4L9LNTRWS4ll2ZgsfRMqziszZ6HuOl+VpAAlV/UHJdMPt1hGHB96vTyihUYfu5sNn7
	U0DYgouU40SeYApY+Nb677PdvKZG+zuyZp4BkbxY3duB8nRYn53J1GiBRaAbM19yUPUoK7HKZmF
	SBwIM7jMGMx0THyzlwMolw9zDQ1uljv4QbTtkTsDPdkvXq/OfS5Oq+6MblK6VpvnIPeSLEFZJWA
	==
X-Google-Smtp-Source: AGHT+IHRcpNwEriTVL0pqLCUolaMHN3iy4aeYsC4oOedhjGnfClQkxnzDxvjJY0nYW7MccwibGt9RA==
X-Received: by 2002:a5d:5887:0:b0:3e7:44c7:4bad with SMTP id ffacd0b85a97d-3e765a36ea1mr8604552f8f.31.1757855695771;
        Sun, 14 Sep 2025 06:14:55 -0700 (PDT)
Received: from ivaylo-T580.. (91-139-201-119.stz.ddns.bulsat.com. [91.139.201.119])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e80da7f335sm7255453f8f.8.2025.09.14.06.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 06:14:55 -0700 (PDT)
From: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh@kernel.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] dt-bindings: gpu: arm,mali-midgard: add exynos8890-mali compatible
Date: Sun, 14 Sep 2025 16:14:52 +0300
Message-ID: <20250914131452.2622609-1-ivo.ivanov.ivanov1@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The exynos8890 uses the ARM Mali T880 GPU, document its compatible
string with the appropriate fallback.

Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
---
 Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml
index 48daba21a..a7192622e 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml
@@ -53,8 +53,10 @@ properties:
           - enum:
               - rockchip,rk3399-mali
           - const: arm,mali-t860
-
-          # "arm,mali-t880"
+      - items:
+          - enum:
+              - samsung,exynos8890-mali
+          - const: arm,mali-t880
 
   reg:
     maxItems: 1
-- 
2.43.0


