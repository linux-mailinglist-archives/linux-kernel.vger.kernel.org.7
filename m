Return-Path: <linux-kernel+bounces-743357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B53DB0FDA3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 01:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9AF05A0E6F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 23:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AEB1272E74;
	Wed, 23 Jul 2025 23:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wzy75cNW"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4942749E2;
	Wed, 23 Jul 2025 23:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753313431; cv=none; b=POWg0NU3AHt7V1cizqlDUxjMkpCFnF/Na22UFwed1T2K4DQDzVEzF9Hx6Wb8yy5/80Dr2sre4++vI9iKdWtTj5HV/U7SpHnYJ9IjPm5R4l9GAfe7CyOFTM/AL/sqXd7nU9pNq0RgZ1uv2ZmE9Tk+Fqyt9CZknfLlPtE4pa0Ty5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753313431; c=relaxed/simple;
	bh=YmnOWxQl032P32j0xgCKwFLvqzBz3bwl/vuuioj6pjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zdlgpjq+dqHa234Z+hzixi04vJ2J2xVkQNeFb5+ZngLW82pCqaqb6xoutr/1kYHjN25qLhvTnciqct1+2wVJ4FCGjYkWm3XHUFDe6zOO1QPh9k6bemjwaMJr4VEl3ftCkeXb1EcWJRTY1uptVAFx46/D5xDGM4xd5CKYRxyBtvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wzy75cNW; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-23dea2e01e4so4930025ad.1;
        Wed, 23 Jul 2025 16:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753313430; x=1753918230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r0GTpnFk/bVgaaL0uc3H/ZWhqid1SYz87+1rRrLNxfk=;
        b=Wzy75cNWeMyYg8Cyw4L5FTj8t5yeqako+m0r6k1b/uwxUHpGu73ZgpUwiUsDetxw2o
         6vogOH7BIkSpzkGLiYGSG6Y6cbmih78gV2By2HMlDlL5XsHNONcnNVanEnhVHurgCF3l
         suqF7+4DsjWmwZWZlmY83zX/KeU+wuoVlfsvzCAKA1RikJdh6SM7R8VT+42/0WsZIZxs
         YyoOGT5olmV/vsKfKDX4RJ9NB6wyYW4TXku2J0b3IrdwOmSlKabeXDcPaSBc9YLfyQaS
         ZouehZ/sPy3Kot0aChFFhTy/JD6LKBLs9/UYgSB4SxrsfDQw+DHPU0ASInWwPKzqNCze
         Jrew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753313430; x=1753918230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r0GTpnFk/bVgaaL0uc3H/ZWhqid1SYz87+1rRrLNxfk=;
        b=EpYgX/iTEpR8EUK256crSJ31O9P0G5zDbr8LYEgmE09P4CI6E8XTwawNkpd7Q1a2Sx
         Va5bw3X8nQk2hyGRByxoFy7s/ACsG3sKXOc8B6QOfTd8bbfUTlFw7XTISItIXbv2FMRM
         gKKgN/VUK13eV9NzKf8vXZO1GePJeTdljXAO6NfGHKNQ64pPSc0GsERTsFOixisTDeJ8
         P2nDrUhp8Q1V7VlohjkG/VPtjbBGoJIrkMxK35G8Z5BnoClXav+GIgm319MqsMW1MGNZ
         KePb9ecQ6nSqHVDSjMjVhuzRTlAUKIQ0kmFlC2XR4Kj+TeoN0+PoTIgBgpVM32ZSXLa0
         hthg==
X-Forwarded-Encrypted: i=1; AJvYcCUDM7RyTe4XwiSJWzREzOlAsjOXfx6g5Jas/MuN3OpPer19TxQaZamPualjrIDSwxHDJzh7kLLrDidUoRBL@vger.kernel.org, AJvYcCX7Ex51v4puMorKQemGKLUNGa40rJsfbmbAQD0AfqHkzMBPRwoKNceHog27yiW0zpN4jsIFMH7VkypN@vger.kernel.org
X-Gm-Message-State: AOJu0YwMTLgdkWyLfaW/KfrqFPYljM7F8f83pZvdRKesdjM5buZzEV55
	XoAI/MLyZHe0YRQorw2XvQk826/HTjGoplr7EcPA0l8lTPxeG83FD85Z
X-Gm-Gg: ASbGnct+OIHcjbuwNPA9hf6msBnm5bCgvBK17gBwwIYFkUpB5oXMWkV0RBkhXf2jP2C
	UYDsUgBO951d/l8xlN+hTp9TmG58ZNhI4OqxTrjT81qLbfWgJT4mFdZr6XdGyVq0KJDmvKEMEFO
	RHQLdnJiaXxlImiuG2xdac6JGJ01aD90SRXCibHjZkgCFSHSicUVta8ZsRMFg6ck81HX8Hl3R/r
	rt8U//4/qz9H2XMPEzPADOeGuzfnZakj4v5Aqfyz0AmN8SolrDRwk+6qOKnz1cn2yozwHtvBTOd
	yUn0T0Cf2vwsg53Aj3wlnPSY10L2eA0qycKb4/vOA6qZUucfR0arQLkf/cBK9/tHuMHz3E9hdQR
	RMqeFTa7RyfvfLBbXiF0XS6TdPn3EoWiyPQyEnz7OJGi1+AI3yJWXs9zGUCXNFeS6iIVJkMNvex
	c=
X-Google-Smtp-Source: AGHT+IFcQmIgGW6y7P89Tcy+OQuCYio6ZcoUtY2+xTcgHdOpWxirQXUIq6CUl1omDMrL8MI72xV40Q==
X-Received: by 2002:a17:903:283:b0:23f:8d6a:8e32 with SMTP id d9443c01a7336-23f98132957mr51684445ad.6.1753313429797;
        Wed, 23 Jul 2025 16:30:29 -0700 (PDT)
Received: from localhost.localdomain (c-76-133-73-115.hsd1.ca.comcast.net. [76.133.73.115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa48bc6fbsm1260765ad.120.2025.07.23.16.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 16:30:29 -0700 (PDT)
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
Subject: [PATCH v3 06/13] dt-bindings: arm: aspeed: add Facebook Wedge400-data64 board
Date: Wed, 23 Jul 2025 16:30:02 -0700
Message-ID: <20250723233013.142337-7-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250723233013.142337-1-rentao.bupt@gmail.com>
References: <20250723233013.142337-1-rentao.bupt@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tao Ren <rentao.bupt@gmail.com>

Document the new compatibles used on Meta/Facebook Wedge400-data64
board.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
Changes in v3:
  - None (the patch is introduced in v3).

 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 01333ac111fb..0c9d6a30dce0 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -46,6 +46,7 @@ properties:
               - facebook,yamp-bmc
               - facebook,yosemitev2-bmc
               - facebook,wedge400-bmc
+              - facebook,wedge400-data64-bmc
               - hxt,stardragon4800-rep2-bmc
               - ibm,mihawk-bmc
               - ibm,mowgli-bmc
-- 
2.47.3


