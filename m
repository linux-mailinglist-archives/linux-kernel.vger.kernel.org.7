Return-Path: <linux-kernel+bounces-743363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9919CB0FDB3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 01:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44B407B7B03
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 23:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4BC6276050;
	Wed, 23 Jul 2025 23:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c156qAWi"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B01C2737E4;
	Wed, 23 Jul 2025 23:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753313442; cv=none; b=WC08Zl7mwke7Vs4BUz2LOn+zK+qnxSqnrC5BuRhJXPLYTatUR6hc50vbGqJldYHgH8+LgTB893sK5kViI4UNFIDu1qVoLYKC8iL0BszAaHBz5JMxbxEeQ6E9nusJqpoWBrUOTYF3Vli5qy8DN84LHLqS3FIQ0kXM92T3K2pSS3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753313442; c=relaxed/simple;
	bh=C791dCmMHbysshNk8RwEbLG1jHTZ0QJ8zu6qdttrXfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sxQKi1R2p5rKzOy2d0ux13fxNLfKTvTlDpF6wT4fKsVVCw1Yx+Jh+SsxIZgkNtejeo9mAuTYuyvFd9VZai9+ruaTL9NPLXJiEEhVzWSeL8QiDIy0O+UTR56zHNNdrkQ2E8JCOSYBT0MltmxG0/tg/qEcEuhjV3wzNpBhGPIk/x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c156qAWi; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2349f096605so3795195ad.3;
        Wed, 23 Jul 2025 16:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753313440; x=1753918240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5K02vRBKVj8wq0NKRnvdxQguSOVUkuGvT7a/bET5K5M=;
        b=c156qAWiQVATP31avuPJoS2AtL2Cb9tEcHbVPooMLQ47fz8vJAjg67juQmSxv3421x
         0jc/2c+yzpSb7qcqHZwfbv6jhYMYn5p6LLZZYW6iNPGgckMbFomF5x3AK/zkCNopphmc
         Wb4yhFGYHYcjwutIhe9oo1LG/E0F5Pw4nHx/JNZojhm2M1q1tvMKxMlYOlCBdZHddcmY
         cGZkHnQMZZPxgfZfz//onJSFcxvRb2VdrjGoqOYqDZKIQzXzzEU6kdo+zEmDZtnYZHD5
         ItB1kc3E29zuVQN2+3WodOAdurx6ZfAZYygpisgaQ5k9fvHUfqdr7gMzI50eFv/KP/nG
         kw6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753313440; x=1753918240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5K02vRBKVj8wq0NKRnvdxQguSOVUkuGvT7a/bET5K5M=;
        b=SPq8a0Y03wULjbeh1OTrExZ+UV0bNklM5+4GmoCgonWHyM9P1okC4JRZRdvN2FgaQv
         oRZA9kq982hso+xBxymZNGKSv0u8ltPlYgB2wEQQFuuqAXwwi+0aV2HgTo0vHMGKmHlf
         nlqQ5djY5GJhVlPtjbfBRBJFdI61Xx0YAw9ygAV3YU/QWYvUThKd3UQcQKSeOEHLV+8x
         9K5Fevtieokod8j8Wln1NMZHd/99GyrZCTxCXpvWNnWDTV0f9jSBDFJ3OAQdJhr5/cbd
         yCympl38n2BiXV1ulttSIdMyDH5m5pQ706faDTkop+EiGv/omPtDI8shCUFltQOV7y04
         RYlg==
X-Forwarded-Encrypted: i=1; AJvYcCUWo37hXhNmJLF2KlFjlQ7axxCbOHWvQdv2YqToJlfyarr+yMPjtNv5xfFfIw74gTeyaNNj+QSaZW5muqx1@vger.kernel.org, AJvYcCVlTuYf76+RXPg8U314oC3ePMFHblSrLwzLU2bZ54jQiR2UX8m20L1U+KBIgPbkIpcsrmNIjh3gLS0G@vger.kernel.org
X-Gm-Message-State: AOJu0YxGh/vI/CWcmqXa6esECgJtoJyJDDQoJ46Nk0GvLSyBZExAdYTL
	GqEA9z0CiSJLbpGzvj1VisurSD9fDvUQeUp+VKbk093VjZm9qg5R2Pem
X-Gm-Gg: ASbGncsg3EO8zMYrXsW3me7YcP2yACo76fgevcIDPqsxfOqbiGDySfP/lWF5jswZx+H
	Ib3jwxqBfI+muTo0T2nu9d6IR5VkuLVtE8qNCsMsTt4MhuBzOauNqD/d04QYgh/KvkdPLg7WvYl
	HxIFNyMcbsS+R9aflnI8FrqTwK5ovrYI6sPKz3UoHTxQQ2DQbPfoBvjen9e4sdiVRusTTfk9cfC
	0ne1sfUxttD4Bx8pW4YAHJs4nUnpc6IXoRQNBhvmgr+JKtH6ZCFkfRYiPpxfZJ0vdZQpxMtNSyo
	dQ6kNzzuNAg5Sfi7MUeTyKmqyzed1iYTUXxsWkxhfEDJI/ss4UtgtPbyN2cqGfU9Uzp+eT9pl4i
	kpJ+2lOQi2LU0gms4EzzlKSr17ng1Bl32155HRfvWe6c0GY0AQmTELqS8ecm+0eskcXIcI7CVwc
	I=
X-Google-Smtp-Source: AGHT+IEfXmpoT/g11peUW8tGwEpWWd7xfm3Gjm7afI5NZ6J1PV8ldBFo8A9SNCO/4qqrkdgMsklxew==
X-Received: by 2002:a17:903:198c:b0:234:d292:be83 with SMTP id d9443c01a7336-23f9812b3ddmr68866145ad.10.1753313439872;
        Wed, 23 Jul 2025 16:30:39 -0700 (PDT)
Received: from localhost.localdomain (c-76-133-73-115.hsd1.ca.comcast.net. [76.133.73.115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa48bc6fbsm1260765ad.120.2025.07.23.16.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 16:30:39 -0700 (PDT)
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
Cc: Tao Ren <rentao.bupt@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 12/13] dt-bindings: arm: aspeed: add Facebook Darwin board
Date: Wed, 23 Jul 2025 16:30:08 -0700
Message-ID: <20250723233013.142337-13-rentao.bupt@gmail.com>
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

Document the new compatibles used on Meta/Facebook Darwin board.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes in v3:
  - None.
Changes in v2:
  - None (the patch is introduced in v2).

 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 3cc6e62ae5f3..2887565d4170 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -83,6 +83,7 @@ properties:
               - facebook,bletchley-bmc
               - facebook,catalina-bmc
               - facebook,cloudripper-bmc
+              - facebook,darwin-bmc
               - facebook,elbert-bmc
               - facebook,fuji-bmc
               - facebook,fuji-data64-bmc
-- 
2.47.3


