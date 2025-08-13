Return-Path: <linux-kernel+bounces-766424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE0FB24670
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 12:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B11F188EA6A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 09:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B0B2FE599;
	Wed, 13 Aug 2025 09:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZsKHchEL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58CA2FD1D7;
	Wed, 13 Aug 2025 09:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755078830; cv=none; b=uhuUugC/6iwbkKyi1ORu0gfriIbT05HQMkqqv8jOOtNqR4pPP6Ps556T5PdO6fizSpnI0N56bNg9ldoRQrgt0pI9m2Oj09gWfyG0iyhfgeTvMZxTRH6e4h0aBJjCdW9rKxfwMZQn+Jv2k7OTyNob2ZZWvE4pIMkHqER6v7C+Vho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755078830; c=relaxed/simple;
	bh=bXEF+XbzbkFRg4UMKvH4CuPRLb5qyqp6nFkhHxPfZQU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h0WyUaZNw11SLwgJKZT4cyyjP+CxJodM4MklYRbeZPE94kxRbg8xPWGNujKUPjVlxHk0izyKcIAm0VK+WMK8lfAvviKHZ6HJzNxTPFtxetWIqTORFe4Sj1GsGfMeuiy2n6fQ4V3w5bdSnFNvNJ/3+06vYnhAIiE44PmPYn48SKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZsKHchEL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5C498C4CEFE;
	Wed, 13 Aug 2025 09:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755078830;
	bh=bXEF+XbzbkFRg4UMKvH4CuPRLb5qyqp6nFkhHxPfZQU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ZsKHchELJM+GSpNFEosBUzYgbBoRaqHap7E2S4wmUHOxLBCtc8yaWZpSUXPB83LG7
	 d2dCOePaJZaCCHu7ziwTON2SkrRvSSJIcfjl0dS9S5KYRpNyxk4PT5rt4dar9heWNV
	 zDwrDyg9+o8a3pNKy3QHPbZEAyMcluvVCPTGrYZyNpqro7hsymjIq8lzXqgGPLRu6q
	 xD1QaZ5F3JAM9GQoHor6+2TzqYkmf+zswDP9L9xFTbh71GgLBJBI6q3QYPHvzcAVTX
	 P7qAe5VHNWyRZD5LoXi1cF+I89nffOloVGryvVBPeA0spuzSBm+ZuMjdQWihcaY2jN
	 hKeE7L1Yx813g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5440BCA0EE4;
	Wed, 13 Aug 2025 09:53:50 +0000 (UTC)
From: Janne Grunau via B4 Relay <devnull+j.jannau.net@kernel.org>
Date: Wed, 13 Aug 2025 11:53:36 +0200
Subject: [PATCH 4/5] dt-bindings: arm: apple: Add t8112 j415 compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250813-apple-dt-sync-6-17-v1-4-209f15d10aa0@jannau.net>
References: <20250813-apple-dt-sync-6-17-v1-0-209f15d10aa0@jannau.net>
In-Reply-To: <20250813-apple-dt-sync-6-17-v1-0-209f15d10aa0@jannau.net>
To: Sven Peter <sven@kernel.org>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 Neal Gompa <neal@gompa.dev>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Mark Kettenis <kettenis@openbsd.org>, 
 Hector Martin <marcan@marcan.st>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Janne Grunau <j@jannau.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1139; i=j@jannau.net;
 s=yk2024; h=from:subject:message-id;
 bh=ED8ImSi3bhM4BQ6UPMffQZiVekSQkM/K2v2LMg5RCM4=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhow5CWueyDyPnp71I75zK0s8092b1S9MzW/du7XgH2c94
 x57F8/3HaUsDGJcDLJiiixJ2i87GFbXKMbUPgiDmcPKBDKEgYtTACYydzcjQ/99CyeGynWTK+Wl
 GwzOmS98cexHd2BnQZ0mY/jRxaqHTzAyPJgS7hbf/qiF48KP9F7xzZFCv5mFplxZ9D4m+fETtuC
 FXAA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-Endpoint-Received: by B4 Relay for j@jannau.net/yk2024 with auth_id=264
X-Original-From: Janne Grunau <j@jannau.net>
Reply-To: j@jannau.net

From: Janne Grunau <j@jannau.net>

This adds the "apple,j415" (MacBook Air (15-inch, M2, 2023) to the
apple,t8112 platform.

Signed-off-by: Janne Grunau <j@jannau.net>
---
 Documentation/devicetree/bindings/arm/apple.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/apple.yaml b/Documentation/devicetree/bindings/arm/apple.yaml
index da60e9de1cfbd0151e973c3aafba6d0880fc21aa..3b90b5df60507b245de387de104a4e64f234139a 100644
--- a/Documentation/devicetree/bindings/arm/apple.yaml
+++ b/Documentation/devicetree/bindings/arm/apple.yaml
@@ -93,6 +93,7 @@ description: |
 
   - MacBook Air (M2, 2022)
   - MacBook Pro (13-inch, M2, 2022)
+  - MacBook Pro (15-inch, M2, 2023)
   - Mac mini (M2, 2023)
 
   And devices based on the "M1 Pro", "M1 Max" and "M1 Ultra" SoCs:
@@ -279,6 +280,7 @@ properties:
         items:
           - enum:
               - apple,j413 # MacBook Air (M2, 2022)
+              - apple,j415 # MacBook Air (M2, 2023)
               - apple,j473 # Mac mini (M2, 2023)
               - apple,j493 # MacBook Pro (13-inch, M2, 2022)
           - const: apple,t8112

-- 
2.50.1



