Return-Path: <linux-kernel+bounces-747493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BFACB13476
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 07:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19775177605
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 05:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6D223B629;
	Mon, 28 Jul 2025 05:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BRtfmcm6"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDDB238C2B;
	Mon, 28 Jul 2025 05:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753682201; cv=none; b=FxCRRPl8O+tU4LfOuD/kZRUVlNqtqmmtVCtqtw+n2Bc/nLFyoOCKctGKNUyw6V848iudliONTnYzwwROu5pGNsmNPKuZ96buipLnBDeUHdxV0ievWD/1ExCpRLf8p2Xm70e76VkeW+bEIjLkpiJzai5Hal12FZqn8Ocpalc9HaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753682201; c=relaxed/simple;
	bh=K5HP+5q89kEhNfZZazOuomJMhMycPY2Nx10vhKKseic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CBMejmqgTe/HPcd1vqWbGs7tX2HTx8xL8Pk/rXU6Z77O2qTBLEIj2B+l35BqJgf8HY1K2BkEZITkIvn4eSoFi6ZpnBmhXIvCgl2KQaFiY1spfQWkgPicFQ34NlbEGdJ0RStkyRShE4UloNN26gHHTQmsHsWoCzNci0N3K7XaVf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BRtfmcm6; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2403df11a2aso2084925ad.0;
        Sun, 27 Jul 2025 22:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753682198; x=1754286998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zqOVyINMYuNtnSjdNQ+edIzC8dJzm5etAOwvnetYLt0=;
        b=BRtfmcm63E7Frg2XFsagbE1Hutmf0nUFoFRQmo7+052vW4pce88mMRmop0QbEV5qzL
         KJIfx39kdfeAnR04fPTdCUY8d37Kg5YKPRfGzwPSYsSh8Q3VvP1ADQ/aZPuJA3SlE7Vv
         j99NlSvkO9hw4AYC8SZwm56prAXDehBWzYtNec/35SEStLMLsQN56GXfamp+U97yMhcU
         ymx8SxWZz/uOAzUlnNkU16cZhs6ecUM6cS5zpjP7ij+6NMYn5/ce7phnlw6njM3rDrdT
         Lj0H5etfDx65CeYRWssZfaj6Piq7IGMShP/rn4t2fWl6XrXJ/4+iKdGrX6Qw1aDM3Xj3
         gWQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753682198; x=1754286998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zqOVyINMYuNtnSjdNQ+edIzC8dJzm5etAOwvnetYLt0=;
        b=WkXgH4vGQuZU6zPwMBjIUFDns1/BDIMz39+E1l1Wy95zgt0N6tZiZqtYEcWvhZVgr5
         OnBodjNUWWgC7QZrAU4gy4iDpv4euthH1+9CCKS2KH00jZ73Xg/VQxgnGwovjYfBR0bR
         Ax3HPwFbMxBsQYyHHOap6biP+/Tr716C5eNnxYgcqjUJrfZBAzVonCzT/KBUx5/v95yr
         p/XqtHEfDXIa2oaHvy61qSmqRZg0fn7G6oMHj7JDRaMiiqBMJgxkdc6e9mbhjfk3pZ9e
         fkv0XhkvET+tS9IQDtYQKG5jwRbbvqJZsB5Chxxf5OuHNLOI81Uy48p8xbJWG3ud3STD
         PH0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUb+v22MFv8MkrGxAnqxkaU/kJDnHf3LqFROpkP8LoxKuWkpMCkq9A479HpvrjDHE4dreMosAs26XSTr4k1@vger.kernel.org, AJvYcCUzVlQhnKKGTDQO3yvUnPJfu4wgCRgXQZv5ggacT6r1sYfKEcypX+8cdqrcufzwE6t/gpL+Qt5hDC0U@vger.kernel.org
X-Gm-Message-State: AOJu0Yylaw6YUYKUD3l8DSPURWjv2UxR+0vMAnZroTzRpePFBg6vArr2
	BPSJ9ut1SiFnabs4dEa+JWk29OI0cA3ZBPJblvSg6NLkyGxOfvtKKqTY
X-Gm-Gg: ASbGncsFCyAGlKkRmUCb9RsfO4/ch03du2rO1zFD8DfTy+B6/RNVZThUTGBE5xE2yai
	RyVMGMIy/1MZ81j3Dsx9NY5vO2LzaMLicaX2NlTDHtOIplsgUIkqfnOK8s/AKs14acbxCbfrDKw
	MsWvPc9ArOZzCDrAfXaR/AcNSbl7dy814Lr34oz8b7i7Nsh84UFu8ITbgEXS9iMjJG4LS/HSprN
	jdAiy8TKQAajX5BxebCeUrzkirxcDU8Ilzwo7+uNMpYWEG+pHCGPLwP5/NlaWhXhzDp/HJUoUnw
	cKvRZrhIRIBLNpYE42uirdlBPo2FPUH9YRUVlwUJWeuM5WATOQSCrbuQDOHtH3qQlguNlv9VeD7
	ZRrdf7ZS4t2w0IplwvbnZOtnupMp6sYT2FBlzIlufQLAasN/J9uvUmQ/qg3VVdcANhPOhmB3Ifs
	A=
X-Google-Smtp-Source: AGHT+IFBm1mrwen/QlGU6O64ea2pU34DFNUrcoPJ9y+PKUl8rOqB7Kvb1drivW0O2i/6eJF3sUumhw==
X-Received: by 2002:a17:903:2a8e:b0:23f:adc0:8cc2 with SMTP id d9443c01a7336-23fb30b2f8cmr145174495ad.27.1753682197770;
        Sun, 27 Jul 2025 22:56:37 -0700 (PDT)
Received: from localhost.localdomain (c-76-133-73-115.hsd1.ca.comcast.net. [76.133.73.115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fbe514b59sm45091795ad.128.2025.07.27.22.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 22:56:37 -0700 (PDT)
From: rentao.bupt@gmail.com
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Tao Ren <taoren@meta.com>
Cc: Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH v4 09/13] dt-bindings: arm: aspeed: add Facebook Fuji-data64 board
Date: Sun, 27 Jul 2025 22:56:11 -0700
Message-ID: <20250728055618.61616-10-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250728055618.61616-1-rentao.bupt@gmail.com>
References: <20250728055618.61616-1-rentao.bupt@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tao Ren <rentao.bupt@gmail.com>

Document the new compatibles used on Meta/Facebook Fuji-data64 board.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
Changes in v4:
  - None.
Changes in v3:
  - None (the patch is introduced in v3).

 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 0c9d6a30dce0..3cc6e62ae5f3 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -85,6 +85,7 @@ properties:
               - facebook,cloudripper-bmc
               - facebook,elbert-bmc
               - facebook,fuji-bmc
+              - facebook,fuji-data64-bmc
               - facebook,greatlakes-bmc
               - facebook,harma-bmc
               - facebook,minerva-cmc
-- 
2.47.3


