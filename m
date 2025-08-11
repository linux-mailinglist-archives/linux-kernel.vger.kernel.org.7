Return-Path: <linux-kernel+bounces-762773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7457B20AC7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 15:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B7EB2A60E3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 13:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64BF7224B0C;
	Mon, 11 Aug 2025 13:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cfeIYatt"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387031F37D3;
	Mon, 11 Aug 2025 13:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754920316; cv=none; b=HldfCbV6LkmPOtJAcz99rPWxXK0bFcgWMHLuSY4PffgXtlMNGVhLHZMPomlPY62SWlc4Ql3eRLi4zWI9Ft5aQ0kgpVhIImnN82PmqxMCPCkq7+hP2gDmFoRzYRQj/Jjno/16w9MzGqUDFyCAk1AjGp9OhZZu07cseERT57xmAsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754920316; c=relaxed/simple;
	bh=UCisHMuxtAwW4uphlmL614TcUp9WjlCZlTIn0NRlWVg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ca4aW0Q8KNSyardU89YFWkf+h1OQB2yWqZhpwHzka0uGxwCb7WanUHiMv4ugeinIuKzZduFUPLO6jYnKHtikC4dw4u4ALrRParkLgj1I9ECXPNyRlXxDivdvQ0HZ4mm5HvHzSwf7KWy9gL8NZpBSpZ7mVTGdpr9dbW/+tQNrt08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cfeIYatt; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-76bf3dafaa5so4855172b3a.0;
        Mon, 11 Aug 2025 06:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754920314; x=1755525114; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8BEwZHZ+L3ilTH9rJUZDkczC6u83Mtp4BtglFfrqDMI=;
        b=cfeIYattFbqR1zUV0njDiQTgXOV1pRm/wG6ewIsCEjP0d2DcsfiU8J7NIaGTEkUS7r
         hrW/YpUbXll6OHpusw5hMqRKvAVkdT3wSg4cwr0GH27DUNpNszQ/bbXkHLWM9WXAqBat
         fy4OGmYg4iUVMV0oUl7JuRwi4w1lD53IGFEqghAAYr4yPoSI//NZ+W37sdVzVrDcsUv6
         fWpjHRtp+z4VQ4AhkS+vvCHLIG5t0sReHnJfdquAr30OrpS4oaqdFaZQai4IyW/3O+iY
         yqf2hLUV3nnOfmvPjw7TGE9AizZiGamodenmwa0MTZSOcSC5oOIgDOiM5OlHoGKgAkEf
         Uaww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754920314; x=1755525114;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8BEwZHZ+L3ilTH9rJUZDkczC6u83Mtp4BtglFfrqDMI=;
        b=W0yu68K8zhItN8wbY1u78bkK7fKxSUR5Jv/GX6RMipf/HPaL94vSR/lRV13U1TG/sq
         U9EeM1GeAuAbLfwYLIVK9VxNvzPW73RagCW2+vfluTabbsu0MZXOFb43PYN3xFnLlOOG
         Ql69uB/LstR9nhdN6maa4iuckBZSYeAWlvHUkLphnGmfsFrfJOtXjxi/KJXNqvc2Kp6s
         Y0urTC5jNCi4DUeB6leSLgiB5jzZAyLaO/V1UA8GJI680KNNapEQtSwio94B+w8DvszI
         8XPV4o7EouUpTzp1T+BQRamE0PgK4hZowi4z0U1xlaGnDqxhqnIUYhI3NcZwkD1szH0l
         exBA==
X-Forwarded-Encrypted: i=1; AJvYcCWdWA6nwAyHzWz6R8nBKHnYlRJP67u1QJYu2Bl5tV/9Bxd9jG7GIpI+Cy8clKQe0RD7N9S5mdLw8N5iBFTI@vger.kernel.org, AJvYcCWnZ/aO/7JdHSNwCoI1lIvIXJfe0ynlXSe5uye5wzolG8oxuzLquEm2HfbrR34ClNxCZXvMXGDpvDzF@vger.kernel.org
X-Gm-Message-State: AOJu0YwQuynnnmZuHF7sf+oI3UJEAObZ4KtufG0Ywi5W9FI2MvbyEI7p
	To7kpMn9INsreIea7rqhfebOR+ZROW8lNtcI7wW44d6B32Xk2Or4Ul99
X-Gm-Gg: ASbGncuf3RbW7T5LKQS/5TbB08JgfyMA4nwGVYr966Pe6ZRpTkT8WNsBfR6KDL5nJFS
	8qFTHfJzxbhPNnivy+yBCQSiXy/dSvIoZCzbh7kdLx3WnD8AP9IgXVzQf+C6aAhWdvQtU3mki1l
	enpCtFp0n1qvPvJHSrCFsXBuEetCWHi6wZrayVeMinEF+pMKnFHmbTJQbwJY6CIfG9y0vUR3cpQ
	hC53y44T8uEN+mFo9w/Eu59RzBP53ZhSG3+pD7YaOviX75IX+RVl9nwJVBArjqLvhxuS/aBBu2m
	knzb7KRjISmazAB1CcOsc602CFHoVKEv9RTygKNSQ+BTKVvdkuYUTpjcUO4U19IY2IyfKGzikpi
	8C4nbc1MhztDNcjohaDFY0xsdpjFpqAKz78rhxYTNT59l7XA=
X-Google-Smtp-Source: AGHT+IGhE+hSwc9ysPvVz7jbqtKJ2dKarkpmwubjOr30BSYSqZyhNCYRQjTx26kCmxQPcCpm1AuJ8A==
X-Received: by 2002:a05:6a20:12c9:b0:238:abe:6363 with SMTP id adf61e73a8af0-240412d3d1bmr30536141637.14.1754920314461;
        Mon, 11 Aug 2025 06:51:54 -0700 (PDT)
Received: from [127.0.1.1] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b422b7b2700sm23504993a12.15.2025.08.11.06.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 06:51:54 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 11 Aug 2025 21:50:58 +0800
Subject: [PATCH 6/9] dt-bindings: nvme: apple,nvme-ans: Add Apple A11
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-t8015-nvme-v1-6-ef9c200e74a7@gmail.com>
References: <20250811-t8015-nvme-v1-0-ef9c200e74a7@gmail.com>
In-Reply-To: <20250811-t8015-nvme-v1-0-ef9c200e74a7@gmail.com>
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, 
 Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Hector Martin <marcan@marcan.st>, 
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Keith Busch <kbusch@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 iommu@lists.linux.dev, linux-nvme@lists.infradead.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1310; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=UCisHMuxtAwW4uphlmL614TcUp9WjlCZlTIn0NRlWVg=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBomfVR4bxz+MuUXxpiFshyYD6ViYMujQXc2DuHt
 +wsEwye3/iJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaJn1UQAKCRABygi3psUI
 JKqTEAC33mI1jzeS8VVyGFEq/BiQe/bhvXliEN4SdCe2Tf6qLrBRqeMCfat6HbLoCja4CbUVsSe
 Wemni/JKDF4aHY6dMInba1FQ5MCA8wxD3RTKkJEhbX9XWcY2DGJPEW+lBuwfq5IdtpdbGPpDpwj
 zkAFEHlpl8MUaWTG7GSm1OY0HqYFLEEuAIbYr6uEeKrBhI96Iwb0sg0WXb783y9dQ3ry3uE2UT+
 OMuetIm7TibCt2bAlSkvgDYC72Rdt/curbxJ5Mdd9fRVB8aICuA0yKN0tan1nViX97O4TqKukNM
 oVh2gJgU1zt4axuYbPHfR+d1Mj5l+C2FYEP+rm1sP+0yG2HgGerJek2XpOjzLKissSw852P4/Vf
 imtGgV1Mud0iXKrxkEGPdyFX9+xWpSuN46Cld2ktxXGZuXmWOf56m00c3X++7B2KXGpITfnMwlH
 OmMc7flr9uQ7l/f17nBHDf8n5nEee9ymqZVYaHPqLPv0B1jRy1D/ZM8rCursoteS3Ll0lE5U0nl
 cJP6/uXAnYMBiRnM31x7J8vJErU1S39eSCcNR6Oitlpa35p+W6q6VQjcqTXtKks/fWGUrQk1u6H
 COIuCWyD+4hp5tNOO9FRIZRJTLU9mDzqtvNvjp8QZt6nU8K+yYRcd5SI3f/opD8MH7GOhyJoNjU
 cXMFsGdgsiST1Qw==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add ANS2 NVMe bindings for Apple A11 SoC.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 .../devicetree/bindings/nvme/apple,nvme-ans.yaml          | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml b/Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml
index fc6555724e1858e8a16f6750302ff0ad9c4e5b88..4127d7b0a0f066fd0e144b32d1b676e3406b9d5a 100644
--- a/Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml
+++ b/Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml
@@ -11,12 +11,14 @@ maintainers:
 
 properties:
   compatible:
-    items:
-      - enum:
-          - apple,t8103-nvme-ans2
-          - apple,t8112-nvme-ans2
-          - apple,t6000-nvme-ans2
-      - const: apple,nvme-ans2
+    oneOf:
+      - const: apple,t8015-nvme-ans2
+      - items:
+          - enum:
+              - apple,t8103-nvme-ans2
+              - apple,t8112-nvme-ans2
+              - apple,t6000-nvme-ans2
+          - const: apple,nvme-ans2
 
   reg:
     items:
@@ -67,6 +69,7 @@ if:
     compatible:
       contains:
         enum:
+          - apple,t8015-nvme-ans2
           - apple,t8103-nvme-ans2
           - apple,t8112-nvme-ans2
 then:

-- 
2.50.1


