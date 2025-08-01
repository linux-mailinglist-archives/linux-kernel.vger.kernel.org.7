Return-Path: <linux-kernel+bounces-753465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4616EB1836A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 16:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E88EA1C23F12
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 14:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2D826C3A2;
	Fri,  1 Aug 2025 14:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJxzeV2r"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B80726B2D3;
	Fri,  1 Aug 2025 14:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754057500; cv=none; b=moi+HDN47FnEOPJH/4u4OfAOH4furkPZlNbd+FBN9N85R276JXXp+DkDIAsCLaEe/p0FD1VZX2hW2kfPhUNy3yOBAOV0WPCN2FujNnVr/BPWaTOn1qU6mbivwoZHu34PbDOXKV8nR/DUA2OUfDldFV3ffFXxo3cBfju37Go6vZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754057500; c=relaxed/simple;
	bh=Scds2Qic/St1PGJZTeZf2BD2myYgaeD21O50CIZlX7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OEB5XkeRakxauh39EqOquU9pA0Tu+0rHv/Yae1tf9u74Wer4hahMsLQX89BC771o1XWTWrsr2eIZMGl1/9JRYktci6gWY9xS07clzwIDlvr9i+wA4ek+fU6HTuy8gJLQZvPKzi0nDW4E2ozA3zB6tfVbyzyf5SGyrviEnakUZgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FJxzeV2r; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-76bd041c431so1782089b3a.2;
        Fri, 01 Aug 2025 07:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754057498; x=1754662298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JspzBnfUdrapzn9O/Ou8fn1SPXl0+OWwJfskfM4dnh0=;
        b=FJxzeV2r2Np1C38WQT6QEr/aslANqa3E/Kt9zmXlZLGD1XAhYXAFPtdJRfumD9U6Cp
         JAdUGX4NBRUJXOmavNIqx5EMLEzEKkrrfeIrV+RbEWlqtaD3Jbmp1Qtjvq38lWPo60yC
         qrVI+ipHG9P8+0dCHw7Y9qVOfeDYZLu3HFsZ8k6425+W4+6SRVXoMleqMXqVT/0d/3PU
         7tLy61YcSOH5nh3h6XgBFGAU1Jtl+bcXLDamfzcENjcNU0rSiB3f9kCBpTtAusRr2tKD
         H1w9Xo9eisgcg1jiPqxcG23BkXSMnuSWneZcQSWaZ9msu7Q1ZtqA/DIVjUgWfFgT1Dac
         8sQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754057498; x=1754662298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JspzBnfUdrapzn9O/Ou8fn1SPXl0+OWwJfskfM4dnh0=;
        b=idbiQmbH5qyET87ZjmwKE0qh4Wfn5Pjfybn/fxqAWW3O0yZmiquQh1IlsZC4cYzc6F
         JxLpUrP8v7KPAf94U8CNGrq6MkmaMOTD++5xra5Aj7JkLv6lCNVhY8ELRkM/mZ9YBj/J
         gj/i2+Xi4X/mDxjdmF+v8bfIcISM3kUtAwQG4fozTY8pSYY/qHZuWBl9pxZJsTeo2FlD
         xxHZ3OH416qu4CABIA9iH6cqf1nBRTV1MlrhZ7Q5bFRklz2s0RpYlc+z38906KirzO70
         Zl1uqc4ZpHleXwkprbC28DH/6p7a+bmYbNnPb4O1Rn7GJemVTdLvGl1tDqshH7riTUmQ
         /y/Q==
X-Forwarded-Encrypted: i=1; AJvYcCW+di91Kd2tDIjgn8s7e0x2SGqfxq2phCINyH7Fp0tkRpvl9wMg/wzEGLJdhL3+JM0GLSVVaFT01eX/@vger.kernel.org, AJvYcCXmdcBjg4S82rWAKifhbmBlaoaizI8l01n9kQFsUpvTnlpA2CSlTOpz3YCSO0p95Fh3RgeouvGAWwlSHlOf@vger.kernel.org
X-Gm-Message-State: AOJu0Ywol0mHi8cI1rThvhW6tI39/fKH1EX1tp9ghXHIiO/igOh9xF9R
	heoJ4k2pP3BEPXSjD0UAT5FeE+QVaa4s1rSJbnBWvK2Dr6yIGGA6+a9I
X-Gm-Gg: ASbGncsfImlWoWBjgOf87jQQOZyXpjMR8UjTDaSLzYY2pJt3IagPiRAtXZH4lU50PL0
	O16wTUA0TuHbkL9C/mVz+3mF2cxD1d+rVZmfHjmvk2tTA7mDDqeqoaSnrqis3DIYLAUINynE1qZ
	r4/QZZgEXcs7fN/Wq4Tj8gW0DHlXB10k/65vldok3xSnst4bBjxJuLRx4eorct7uZsphyEqHtvR
	ZNArw7tCzC+ccDmN2FTE1Q/GoM1+Ssz00iCcCm0U5yrrcTjzh/ooxEAE3p1O9VwOIfPN7UcO/nY
	fmBNbEf0r2oyr6nPlufzGNyVupF/s9X0B3nCyN5au1/gLmlp2odDsvxMEj/gEBSHyfcgUNkmAZC
	zqWMWB+tpe6S/w3zEVXo4hxN9Ff+k+jBvYd2G8vTGY/As6tVp40qUXfX5GQSQOno6Wtfvk9uOIe
	z/pqdoDWlj
X-Google-Smtp-Source: AGHT+IFEFWflCdTZ/ecvpU2vVOlz2gwYHJz3TWkpnJ/7/BQFqAXMZ1d0N0k5n4bY1xfidiervKAK7Q==
X-Received: by 2002:a05:6a20:430d:b0:232:cc63:45d8 with SMTP id adf61e73a8af0-23dc0d608d6mr19356658637.20.1754057498342;
        Fri, 01 Aug 2025 07:11:38 -0700 (PDT)
Received: from pk-pc.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422bb0db0fsm3849984a12.61.2025.08.01.07.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 07:11:38 -0700 (PDT)
From: "P.K. Lee" <pkleequanta@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	joel@jms.id.au,
	andrew@codeconstruct.com.au,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	patrick@stwcx.xyz
Cc: Jerry.Lin@quantatw.com,
	Jason-Hsu@quantatw.com,
	yang.chen@quantatw.com,
	p.k.lee@quantatw.com
Subject: [PATCH v10 1/2] dt-bindings: arm:aspeed add Meta Ventura board
Date: Fri,  1 Aug 2025 22:11:30 +0800
Message-ID: <20250801141131.2238599-2-pkleequanta@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250801141131.2238599-1-pkleequanta@gmail.com>
References: <20250801141131.2238599-1-pkleequanta@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "P.K. Lee" <p.k.lee@quantatw.com>

Document the new compatibles used on Meta Ventura.

Signed-off-by: P.K. Lee <p.k.lee@quantatw.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index b3c9d3310d57..8cab682b7bca 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -90,6 +90,7 @@ properties:
               - facebook,greatlakes-bmc
               - facebook,harma-bmc
               - facebook,minerva-cmc
+              - facebook,ventura-rmc
               - facebook,santabarbara-bmc
               - facebook,yosemite4-bmc
               - ibm,blueridge-bmc
-- 
2.43.0


