Return-Path: <linux-kernel+bounces-766334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33987B2454D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 11:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC6BF565536
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 09:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B032F28E2;
	Wed, 13 Aug 2025 09:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hammernet-be.20230601.gappssmtp.com header.i=@hammernet-be.20230601.gappssmtp.com header.b="cDkB3o22"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A902F0C6D
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 09:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755077018; cv=none; b=PVaHEuyxGbdza8PCJAokYGHJQg+BlGZQfXRhG7XKlFG+032XNGScaFyHD7SQ3/fKDRaz7E9fA3KA9Ahk4VZBTVp7CP4jh4cudbhrCflYj6S6UTF1vFeMG99hzBpMnXC+bmA1a2EhJ8TXuqxPTYMAbU+z0u0+xMCX+8dOeaE6kFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755077018; c=relaxed/simple;
	bh=/rTdKk2uoMxb+q/0DRtX1FS+dFKCBJFEKFc1tSBa6tI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AhkS0uZusirIufwCp8hZXFgB66yAP1HEWC4c4RR7BIdLjyxqOd//FKDtZLP/WcbUdl5DJ3c8vdEFZ3G+5ZEMXNfKkbr2KaZL8G5jNqDJFMjuAp0OoROdVhCueK7nkL7YWFiVxMZaMYz4b4t2c+pTldv25AhcPoYREia1VvIVszk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hammernet.be; spf=fail smtp.mailfrom=hammernet.be; dkim=pass (2048-bit key) header.d=hammernet-be.20230601.gappssmtp.com header.i=@hammernet-be.20230601.gappssmtp.com header.b=cDkB3o22; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hammernet.be
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hammernet.be
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-459fdc391c6so35433665e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 02:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammernet-be.20230601.gappssmtp.com; s=20230601; t=1755077015; x=1755681815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KV/LyU13FVZD+Ygh9a2dJ4SQHfL+zi8sFF76wcqrPxw=;
        b=cDkB3o22Ic757gaF3BaRwWOsRH44EukplTFs280m0M5FTpZWRDwanWkozVxP60pus+
         yzVrw3pwz6FVbPVukvcTJUFWQ6O+JO8n5mrncbXFnkUiYUQiuOQsT3GBaUWDMnUSCF0A
         BwYgyVGKilHYKMaK+DrFNepzbA9/NhIq+OXKrXoEsJBI/QdLKa6a1RsAuJ58atB/NFzu
         rUwStvNI63DeFkPruhX+S3NU3L56hSRwjEeM7Hl0DZelVOyG47SWjz78YkwPvCiW5NhM
         aJdG1EbHISaAYR71kix3SixtQUYP55KJ7/LepYG9se6Ej+6vk04zGP+SprAw0RbSut1+
         WJIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755077015; x=1755681815;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KV/LyU13FVZD+Ygh9a2dJ4SQHfL+zi8sFF76wcqrPxw=;
        b=kRTrsAIUQGPhDFJ5YsqjRXE77I779PLWdomyb6mw34WIVGlP+IpzYzFa+b5FAjPXRi
         D/6F0PsFXv1AUBxGQMzEO4goQczyEPNd7OXG/+/KRpKS/lTvNFTpGRvI9qruwAmX+WcD
         L+OWRlETr1x5fecuOVpsDdrm2iEA87S8igAQ0IoHH3B2Oz/mTpi5qn1ignzqMyVPld7/
         dx/RHd1nh28rPCMbtmiAaFhIDlzYetpyNbXa44PO4MGK2wj2OHssKKEIMQHf48MH5CSH
         j7y/Behp41Q6QUOsY1+Gdgb5Sufif5X1tyNcM5tGRiHz/0atDZBhEc+juShTRLwRDwDb
         TYdw==
X-Forwarded-Encrypted: i=1; AJvYcCVBqVGuT8hZRKXeJzalgfwh2u765k30UAHMZusDpxapLKacfN8WTpxtmg846VDcbKsByxcxwHdzs56AmzU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxENPizPhSgy8Yh3vTvoFvDPVX1TfK/MYmKSIjYI38xPZt7P0ij
	3SpWE74BFxjfAw1JcK6uU1ZRNiTGLVKeS96MKllQ4wu79MrLA2z8voOIb7CUYceAD3w=
X-Gm-Gg: ASbGnctmMtNH2OknW+n5RwkZ7P7puuTfRu48CUrfIKiRh594XX5S3+l2buRgbHSl1er
	Mqzb9NHijcKkcyTPp+VuoavS5z9jOrJDpK7dtV2cOHblsTOhn5f0jFzx4Dww0Y1gaZ1/0feTJsU
	VbAOqyj3W/KHEMJOSwTjzS9Oe1Hbz1K7g71feagraT3dYunpP7x/ay7hvbHWS7SwTsbvEsJfS3Q
	jxDR+6TSOIYsfBqOZqWE6K2LtDD39UbLgoFMIp5k1/Ic3h7e1NB1oQZMkNed8/HXgg2ZejdRYPB
	1k7lmunV6P3YdAsJC2+lapIdgieXfntuAQX5Uh2wbQhXlKgewSJWlkJ4viwRPLRpcYKPcjD2W3H
	TNYoqctVtB/D9jdEIioz0nSudhIUvG8g8QrDhXzOZEgCUHzrzKw==
X-Google-Smtp-Source: AGHT+IEWxoI/kRzm9XJtVKTQJfagZa2jXeR/JqY3ScAS+RcLcnu42mBz4ZP0ExrShNWcggbJ1f56TQ==
X-Received: by 2002:a05:600c:4e15:b0:456:1923:7549 with SMTP id 5b1f17b1804b1-45a16b73703mr16081835e9.26.1755077015065;
        Wed, 13 Aug 2025 02:23:35 -0700 (PDT)
Received: from pop-os.telenet.be ([2a02:1807:2a00:3400:d33c:e682:2af6:3c3d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3ac158sm47966077f8f.4.2025.08.13.02.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 02:23:34 -0700 (PDT)
From: Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>
To: dlan@gentoo.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	paul.walmsley@sifive.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	palmer@dabbelt.com
Cc: skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>
Subject: [PATCH v3 1/2] dt-bindings: riscv: spacemit: Add OrangePi RV2 board
Date: Wed, 13 Aug 2025 11:22:39 +0200
Message-ID: <20250813092240.180333-2-hendrik.hamerlinck@hammernet.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250813092240.180333-1-hendrik.hamerlinck@hammernet.be>
References: <20250813092240.180333-1-hendrik.hamerlinck@hammernet.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the compatible string for the OrangePi RV2 board [1]. The board
is described as using the Ky X1 SoC, which, based on available downstream
sources and testing, appears to be identical or very closely related to
the SpacemiT K1 SoC [2].

Link: http://www.orangepi.org/html/hardWare/computerAndMicrocontrollers/details/Orange-Pi-RV2.html [1]
Link: https://www.spacemit.com/en/key-stone-k1 [2]
Signed-off-by: Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>
Reviewed-by: Yixun Lan <dlan@gentoo.org>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
v3: Improved changelog
---
 Documentation/devicetree/bindings/riscv/spacemit.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/riscv/spacemit.yaml b/Documentation/devicetree/bindings/riscv/spacemit.yaml
index 077b94f10dca..c56b62a6299a 100644
--- a/Documentation/devicetree/bindings/riscv/spacemit.yaml
+++ b/Documentation/devicetree/bindings/riscv/spacemit.yaml
@@ -22,6 +22,7 @@ properties:
           - enum:
               - bananapi,bpi-f3
               - milkv,jupiter
+              - xunlong,orangepi-rv2
           - const: spacemit,k1
 
 additionalProperties: true
-- 
2.43.0


