Return-Path: <linux-kernel+bounces-820180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC9CB7E099
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BA064871C5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 07:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384F5302CD6;
	Wed, 17 Sep 2025 07:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nHAbcxfZ"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430CB2DEA76
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 07:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758095522; cv=none; b=FqEQ0nf4eD6q5uskWbQnzYG64IJ09E01/IS45fLDVjVwOYNfO6klox5qZ/46GtLmY1yUaPHZNwoqFTcIZkVTtizZ9SbhGZylwSUJUd26u3f07tI14hpBkRse2xiFF3TZjxCZKUtfUUf3jULN6Z92HXZCVSoJw7M7nN9L/0P1b9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758095522; c=relaxed/simple;
	bh=lNWmx7yIKu8Ud39Sxzz7MusXBYyYgUPRyESGPdOa9Do=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=OVbEtT69MM40+y19oEqjndiTePlwDZv/ImThF2QOX0YlAYVKyoI4CBwCYt4Mu1qyKASsq37UoO4/Nrvob2e8Vn1RPQTSM47Bc8d/OO/whizRgJRR9zNWnAApdig/nUhO+lKc/oVwdOx6nfrtlxNXG7mGZrcJKIBkgt39Dgj9dRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nHAbcxfZ; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b54b3cafdcaso3297025a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 00:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758095520; x=1758700320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=abYjL49SciLzOaOA35f0uMdKGEjHBbwqKbxX7MVH+24=;
        b=nHAbcxfZJoj8RmLGGjg8oQYFh7UMV1QO8HE31vRsNm1DENwpmxTaChTbMTnPBZ0G58
         CtDg8izLWptVKtGwK/ohsPtZRhm/NrkcWT1YpSTT24oZ5UqqndAqxoZMrO0xp1OcIcqr
         nzJcYb0+Kd8o/DJFEzXdyBvU+bGLG+qjO8uU4buboEhp8Y0ibOxjiKLoVtgKX7honNtc
         g/+rki6ZjZTMLiz8lGVa2UzqImPa1YaSxEARnYt6ro3D87xXDPByX3CjB5HgBcVxsXkj
         W7NKkTVNa7arqbO+BmQYz0KUR6JXqbVblXivqe4fJfRJi1IpEEZptRIfzQcmmaS2OWjn
         +cGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758095520; x=1758700320;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=abYjL49SciLzOaOA35f0uMdKGEjHBbwqKbxX7MVH+24=;
        b=hZ5IYCf8XgN338HT46PfUKdaGZ14ehhAmw3V9MgAwMFNmN+U17fTZ4hN/iSUWV6BCg
         aqHAe72gJDCoEhciBJbfCYUBXOqeUDbnYWaF5WQZjpci7ibNk2+JW81EQ+d+IbKFIKsG
         GWw+QCcEshxaY1laXm9zDMojStaxQNbV/rsqwfdRTsJ7fWRRU7ErUAnIcUZgRhGGzfcU
         js6u7SivbbkBTL2sYCSQWfKaUOO3B70pAjtzUQuOV73auZUezUqgtevoF6yAxa0DCn7f
         cbdaV4vVN5vnRyxMMK14chUA0Na9SCsadNvZ4/ubMzuvvr11E1YjJJFwE+EVX/FgYnqx
         fcaA==
X-Forwarded-Encrypted: i=1; AJvYcCXmSoxq7SMnLFZIc6bIkIIC4fa3nCBw1kckmw7+o3t3NNzH4qK3NBM9XJT5YUwL9Gl9DalfW1/ZVcOCBWY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZb0Q2U/QuV1fA8wgz0EwdUFEq384gHqo8CCHzyfKTqoUrOq+/
	ENh206mWO8LwhESaBnq5dAzmjSFRZe2NE2HYV9/rAc8wToDs03ANCvg7WmPKgA==
X-Gm-Gg: ASbGncvGflZoIIBT8kW/bkAg8w7B+MDC1023YYKWlYDsIKFr1HH2FUPPr08mxARXchk
	iKGdPDNvrqvz4+t2iathjZj9U/Yh1AG4TREk1JP2QtWRYTi27MtBh2IbRr8v4yKUd5IYP5YAh11
	9cj8w9IuCwXjMOpmBNPZL6RjA1/DMMtNFE60Si+ldPb+oJFPbIl02Cv4cOGEOhPyYz0pOvN8caC
	PTFWxI4DJJHkdNvs7OyU1nZ9Mbr1sf0Rp5rI473/5htyNubPZ74+xtLxaYumoZIJf3s4SDvu71v
	QDqRcexhE0hApxXUBJdid+IpgtezlEwnhtl3d9Rn2sVoVWXriBbsTTbTN0taJC0ZTWxKmLiwn0m
	Fd5/RqGvtYqsAlkCCqnhzRG0cYlZLOlo6Rlt1
X-Google-Smtp-Source: AGHT+IHUW/wTOhIs1KEMt39SwXanfpFrThAcQacQ2rNisK/1xxjIdZlvOMm825vyXwIFErVxjOFrJQ==
X-Received: by 2002:a17:90b:2c8c:b0:324:e96a:2ada with SMTP id 98e67ed59e1d1-32ee3f2ffefmr1335606a91.21.1758095520454;
        Wed, 17 Sep 2025 00:52:00 -0700 (PDT)
Received: from meta-device ([2001:b400:e359:6d3b:3881:d7b4:5e6b:c23a])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54f6d51fdbsm253168a12.26.2025.09.17.00.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 00:52:00 -0700 (PDT)
From: Kevin Tung <kevin.tung.openbmc@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] dt-bindings: arm: aspeed: add Meta Yosemite5 board
Date: Wed, 17 Sep 2025 15:51:56 +0800
Message-ID: <20250917075156.4043936-1-kevin.tung.openbmc@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the new compatibles used on Meta Yosemite5.

Signed-off-by: Kevin Tung <kevin.tung.openbmc@gmail.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 456dbf7b5ec8..6f2b12f96bd6 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -89,6 +89,7 @@ properties:
               - facebook,minerva-cmc
               - facebook,santabarbara-bmc
               - facebook,yosemite4-bmc
+              - facebook,yosemite5-bmc
               - ibm,blueridge-bmc
               - ibm,everest-bmc
               - ibm,fuji-bmc
-- 
2.47.1


