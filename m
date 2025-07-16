Return-Path: <linux-kernel+bounces-733244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A7B8B07212
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 11:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D90B83BE953
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 09:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD062F1989;
	Wed, 16 Jul 2025 09:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZX8uz7X2"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333532F2376;
	Wed, 16 Jul 2025 09:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752659020; cv=none; b=VzWbB1rvIhvHhEj0RJNOZ/i7XNgd74RWJWlkRsg5SkknETSHENPfOrtShLK6Ejd+m7kQYw95ZHYci1/me0nJL1NKY+qrTk7jj16KPaKPalrswZWL2QjwpaZ5Ij8GIPTdwAlP6esEHQ2AAA1SY19l3CGq9FDPmZdsWwvoEz/yZo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752659020; c=relaxed/simple;
	bh=/EeKD/XW09tumv9IpUb79a3IL1fJrjrz8xqmd/WW5Xw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZZBAZ07IvNvRVPMsHsJ9xCtezWvLVpuaBX8utC9X9b8K7lce2CCzocMwesuFr+zNQ3xktzY6jgFZVfjYqQt6CdAacW5l3hROfrHs2hW3g2Tr65oZ/ejXd8G5Nb0J7O5dGgwl4TN8ku2CMJFBDI2ZCRBJW08jMTMhEbxnDBTHaW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZX8uz7X2; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-23aeac7d77aso50082005ad.3;
        Wed, 16 Jul 2025 02:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752659016; x=1753263816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=59/cGrD3cECKnmhhvyten3EjV5sJFXNCMmz8J9SY3Wg=;
        b=ZX8uz7X2rbaosq8u0YqgQoWwek0TowiH7w8WIOTVXoVgZeSv422oYynD9x9WA4GPOU
         en+0MWwIS8zSkrXLSmTfPaOweL9tIexQfOiP2uM3/cS7bv495yYnbI+3SS/sZfhjcj+y
         vvRf0VEXxy8pVs4LjldipxIXwoaQwa+Cl+hb8t7Or+J9WWhGlMLRrSGp+yiQ8t3BXDiU
         j4XDUhC4mYnnTqeWNxCkJFoAcbFvqcbllP6D7pOeaBinlqWu7dasd0Rei6hD2rtBjlDO
         J83DtL4blIEW18OZL934njIhEE8XUuovoBhEEfLmmWYig6lkXf+RzegEYI3efbnHpfUh
         q5oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752659016; x=1753263816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=59/cGrD3cECKnmhhvyten3EjV5sJFXNCMmz8J9SY3Wg=;
        b=W7r2FvbKlKrRj+UbNsCBCWpwR/r6XjBPYVKCSktc/FTRtQ3qzb41i/6Qd+Tui0H231
         4nb3wL50Kz9+N8vsX3PdjXCUgbgxXajYK7l2cLq8X2xge5ITqmUl8yNOdSSy3mhvcl+v
         D8ozVUByLOT89ZxFkaenUh2MhY5/F1h6rhvz8gqrphBrHD7oo3/XFe4OQRCg8/Nb/1Ue
         vK9cJlC/Ups+cs8bMOlVgKb6AaXMS3P47NL7HHgqBIv3/ATbH/51Ql/G8im1TBy1kf5b
         e1m6ICorQd9tMR474FTfjuiLe4xR1XKX7NfnbropbWCECDU5mF5JqRHyMFF23OVW2TgD
         +zlA==
X-Forwarded-Encrypted: i=1; AJvYcCVKmZj0L5bAs1MW/f/qbnGZdfz0p2s4lXC93v9hYe9QtZM7bQDtyMnVWMwtz9UUQVfe9NuliMAvuWLA1K6/@vger.kernel.org, AJvYcCXAqjIDIQ22HhLE5zFlrGB0KnloKAHf7PkJ0VLWLNnNMVz/4x1BTr01Ak7aJEZV0Xv5WJdqaeTTJ7GD@vger.kernel.org
X-Gm-Message-State: AOJu0YzOVCkGT7RcdjxCxWioRA1VfRNZ5BV4nHT1eCTRCiOQ5DfEKtGa
	hOFfsbpK7bSHeiTBWaVN4DbQ9/Wr4iFd0TthbrF72URmdrjmncQ5OwSW
X-Gm-Gg: ASbGnctnDoAccTx2dR/g890OYB17NdROboIycMzncSk+Czkzgms3kGAJQro1n2c8PPD
	eNbwJTNepGpbVCvn1/Rf2YN4GPBI7tT9mHi3ZWCCetfSuLVzBh4Hu6q80tQSV3gPddJiJY5NYkB
	pr+PLkcnGU5lIehIzCA0rYmXNJnIJlB36fU9o1LJDcAOqOfySeoNWUd57G4+hpPFtR/c9lQKzBK
	Pms3juewH24y3O4ra9imtUw/WIi9QS6Q9eq6relSsA8t5WSU8Uyi0S8zkhOP+3tmrTib6aZnH45
	FaKCM8KeFMmDnOrIWKBb97lCjsrDa5gEEcIec9oLQV/lG2WCXIAE7Iuee4aR7xrAQt5rPnExRAf
	zCr6BfyTZhA6kB+vFsRreRFY6Mtd/9bSfsNTAkYVHXlI3nYErnnIhxgPnhdgYOmAy1HKj4qEoWM
	IlJVaYSKWa
X-Google-Smtp-Source: AGHT+IEjRWwLIhiIoP0DIOS1wG+5KB2COrui2fTYZZ19Fi0hrVi8hf0inWpz3h0vQDLXUd7CjVKp7w==
X-Received: by 2002:a17:903:19f0:b0:224:910:23f6 with SMTP id d9443c01a7336-23e24ff339bmr32733445ad.45.1752659016492;
        Wed, 16 Jul 2025 02:43:36 -0700 (PDT)
Received: from pk-pc.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c9f2350acsm1039503a91.45.2025.07.16.02.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 02:43:36 -0700 (PDT)
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
Subject: [PATCH v9 1/2] dt-bindings: arm: aspeed: add Meta Ventura board
Date: Wed, 16 Jul 2025 17:43:28 +0800
Message-ID: <20250716094329.1069203-2-pkleequanta@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250716094329.1069203-1-pkleequanta@gmail.com>
References: <20250716094329.1069203-1-pkleequanta@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the new compatibles used on Meta Ventura.

Signed-off-by: P.K. Lee <pkleequanta@gmail.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 2f92b8ab08fa..98ea2b3e0eb1 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -86,6 +86,7 @@ properties:
               - facebook,greatlakes-bmc
               - facebook,harma-bmc
               - facebook,minerva-cmc
+              - facebook,ventura-rmc
               - facebook,yosemite4-bmc
               - ibm,blueridge-bmc
               - ibm,everest-bmc
-- 
2.43.0


