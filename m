Return-Path: <linux-kernel+bounces-730140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EDB5B040A7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1765170614
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 13:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E154255F59;
	Mon, 14 Jul 2025 13:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KcqLBPoJ"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250A325484B;
	Mon, 14 Jul 2025 13:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752501288; cv=none; b=s86dnvGONNZF0iVo9k87XF5e759hlPLpfIlKc8jwyc3zeqwtCGMkN5hSbEDKCvyrYiWNjlBXW5uzDlIAo5G69oNGGcW1aewT0k1QJOVz+0CwUvfkC8gjsp05QQfPj7ZlIt5xqS+btvuUCyDfJDipNzKc72mi+WrdIQ86OyNTLYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752501288; c=relaxed/simple;
	bh=yGLjgfrG7ccJQbLP1bUn+mq45lSVOGYqttRomiLzHu0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=akCSN94IFmGr9IKw++Nf0lOzETU8oB/WdJJV6SBB3E6kx3QOb9/u+9N19KZlNOtuNKaqhSXGAlZsOO0R4ETH2KTcm1WU7W8/xVJT2wmh3nFSdTCEcGdoiRlABIX8Lx/kSzII/ceUOm/7STG4hvj93Cpt5y8v2EU6K3v1GRUQxWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KcqLBPoJ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-455fddfa2c3so20957605e9.2;
        Mon, 14 Jul 2025 06:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752501285; x=1753106085; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j1GozZmv2KllVJbD8Fsx904y25bNOuqAn9ZG+CR28Ew=;
        b=KcqLBPoJsIs9It2cnyKy/YsIuWGNOozUMCCyWmcvjk4BaL/yDZC+8lRZ6uHjrkMhb1
         cg/nWa8AJuty242q4bJV8P07FhqxLRYPT74zcjBdSqFep7DDN2xPCNfuKMmluyFSNGOw
         uhh/YrZMWvvme5bGMv6kphyNbq3TAI351xwfD263141RnXf8QjSlF9XbJLYYGO6x/MqC
         fY/v0Y1qQoZunAuVnibTj/z/KEMkPjju2nAOFn+RZORTQexBiPr06mCDfo8el6j7IUkZ
         qU3G1cWUC69a6di+fsHaiAZzgDypQDHzB0bcSbtiUm7HmzpUYNn2Bs57VCfsEkoS14cw
         aoqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752501285; x=1753106085;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j1GozZmv2KllVJbD8Fsx904y25bNOuqAn9ZG+CR28Ew=;
        b=apz2yPjfp1GqBhsOFTiVsrC10oZf4wA+ALfFe1yPu+nxpJJRg/zYQ2o3AlFu6Wla/4
         e9kJdttRdIWdmxV7XaPoLjOMFeay2hO1QmdUs4DPcoVid8v5kPj4sGoNZUyoBTavuvVs
         yaQOMeZbGdZ3a9FJNL4GTyR27lFtozW7eWppuB9lV0MZhvl6Pn/mnmjiKOe+qiFZq81N
         d6tDFy8rhW/QYQeULd2m8w+7F997mv+c01ZAkNHIq9cixhx45JwHVWO+BNIgaS68GJKk
         2saq0y9O5onoQOgU5BkyVZoEolgsHb7AbCheFVqB0ZVvfE0t8qHN7UwfNPswjuEx+66W
         QoAA==
X-Forwarded-Encrypted: i=1; AJvYcCUh8leA3LmmuzCK0x1nFWhBJ0BFi1xbmt7TKnMHfjp60incEGU+pVBi11QEwkR7khLF9UUBvN7D7qUrras=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUa1/T18z9G1moqCiLJBfcrlf5OGUf5oVLMTGzWqfZQPqUYU10
	VBT2jK/bN5gPpH1/NqFtjUCSZn0/bRUJi9fNjPgIi/0SsfxsSp+vS1Hgbg6VkQ==
X-Gm-Gg: ASbGncu4IHQJ249QiObU6MFdq5pdbHtDKE9sSOKCQfIC+Qwism44CcyfDBc4sUh7GaG
	YGTXAxLuINS1M/jmX93Z2eGAbv5EPx5iVOdKYlLAOGpaVMFTWhjJ1GhGMFkaIVIVe8a6f0WCN8J
	23h2lNuW1+vv3HfraLyKTswG/IUqdCOJZkXHVDWRoCMocTOsyF+gjCKE1pYetv6mwuWxEkY009P
	aziOZRa+pUALwlMI3/uypzpuI0ic5EMLxnFP0fzxYYNHx5Kz5Tyge0fwWDN8H06n7lkGBXRPTpt
	ec8VghHE+Ku9yhship6rqrnhvr78BFtmCtzYA9+TtNg2E6MicSeXu05mvcuS3NvJ8vNZyvbWSts
	rWSaJU7Kc2e4BJPyES5AWj5o=
X-Google-Smtp-Source: AGHT+IEmMJQ9IUdhNJsjC3avx3ABcycM1c378Tv3VK+BRI3i+Yh0RCHDP+vvN/eoeQA1/W5WoDqLKw==
X-Received: by 2002:a05:600c:5253:b0:442:e9eb:cba2 with SMTP id 5b1f17b1804b1-454e337dbbcmr147287115e9.0.1752501285089;
        Mon, 14 Jul 2025 06:54:45 -0700 (PDT)
Received: from localhost ([2001:861:3385:e20:2acd:89a8:83d9:4be5])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4561323a488sm51228055e9.1.2025.07.14.06.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 06:54:44 -0700 (PDT)
From: Raphael Gallais-Pou <rgallaispou@gmail.com>
Date: Mon, 14 Jul 2025 15:49:16 +0200
Subject: [PATCH v2 3/3] dt-bindings: arm: sti: drop B2120 board support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250714-sti-rework-v2-3-f4274920858b@gmail.com>
References: <20250714-sti-rework-v2-0-f4274920858b@gmail.com>
In-Reply-To: <20250714-sti-rework-v2-0-f4274920858b@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1075; i=rgallaispou@gmail.com;
 h=from:subject:message-id; bh=yGLjgfrG7ccJQbLP1bUn+mq45lSVOGYqttRomiLzHu0=;
 b=owEBbQKS/ZANAwAKAechimjUEsK1AcsmYgBodQwg5KARvxWXSIY/kUAlwKR257nuONcT6QTUp
 C5bMLobvVeJAjMEAAEKAB0WIQQgmXv2E+fvbV/9ui/nIYpo1BLCtQUCaHUMIAAKCRDnIYpo1BLC
 tW24EACasd9KNofpB284fozmyUvUB6lKSFy9eXLzG3zktdFVfbs5l7c84Q7DCsjO7cvFJgT4vRa
 d+JfNJgLwNUODi59Zs8fEdos5RmbZRE97oCD6HwJ5PVUNymCVnDyiiga8KQ9s8nTKnKY5wMch+t
 nzNl+78zaCfUkeqCLct1JdsAAi71deF+SRcsBdmWgTH6rhV2OrLpMCJEtOCEPVlORPexCOOE99N
 b4vG5t05I8KRIbKiN+r27cYmRvNYc5huAxYK8VXi5cmEqJ6yH32CU+BWEBtRwhkcmsU2Sfr3xTs
 8JcIMi7BO09SyFWG4yyIScart0pLwa6lPqhkRc0EgI8JTR1L4sOT3iAixMJmJNT01CMnLjIkc6E
 E6qtworoQY0pVfblCf4KrEukIFukjM8SL1IgGx/0u63j28HVjKbsAdeLAjh3mr7I0NcJVQPwbQj
 eCblYz+FEWDK/nkRKR8G25gJdGIfX0ritMAE06LReWaBzCLhsoRZ+s2Onu6ShYONhmCUx2Fvam5
 2zzvfGePfnQJZEphh+5AeuNFkZ4ITmJivxg795je4BQhrMZioue5kTeXZdKHoxdfY9eg3Ui+eMW
 tdBrkLaE59OlW9ArSpOtbBapXFht+FSd7Lk9SZWSDty3GkWm45+VuzrKO41oR2LFOFqcXFzXzJd
 WP/1m9HhMUr0nWw==
X-Developer-Key: i=rgallaispou@gmail.com; a=openpgp;
 fpr=20997BF613E7EF6D5FFDBA2FE7218A68D412C2B5

B2120 boards are internal boards which never were commercialised.

Remove them from bindings.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>

---
Changes in v2:
- Added Krzysztof's acked-by
- Put this patch last to get a bisectable series
---
 Documentation/devicetree/bindings/arm/sti.yaml | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/sti.yaml b/Documentation/devicetree/bindings/arm/sti.yaml
index 842def3e3f2bce470763d3665c7603b9058b1e4e..177358895fe1c9f80f8c825142cf015d04286ce8 100644
--- a/Documentation/devicetree/bindings/arm/sti.yaml
+++ b/Documentation/devicetree/bindings/arm/sti.yaml
@@ -14,12 +14,8 @@ properties:
     const: '/'
   compatible:
     oneOf:
-      - items:
-          - const: st,stih407-b2120
-          - const: st,stih407
       - items:
           - enum:
-              - st,stih410-b2120
               - st,stih410-b2260
           - const: st,stih410
       - items:

-- 
2.50.1


