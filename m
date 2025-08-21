Return-Path: <linux-kernel+bounces-780201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95675B2FEAC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 17:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF56C7B8727
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 15:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F862D3A7E;
	Thu, 21 Aug 2025 15:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cb4iDmJt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0DD27814A;
	Thu, 21 Aug 2025 15:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755790803; cv=none; b=gth5N4H2jKd4w9xGrqxX//+SmVTWSMaCwrbiyzk+oHGEhbRI/mcYRwZEEJ/hKS7lEe94c18bqvIgct0w/y9Wxc6LWHy9aq2/ra8I/p5B1FW3hmU4dlzoWUuAuYTU6gM8aT4S1UMw8JGeYbz7BqpphEl6vG01/VQeftoLapGXjvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755790803; c=relaxed/simple;
	bh=//lvZcgVxWAuEEA3XDGiToePWRSnH3bkVOU2t/uuiIc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jXYT1BW/fvzCHTCGONIYDOOSCVP72l08ytx0GFxE50lhD7NLfyfK4cJXGSfEYPXFU/hUahOwIHuHZOzrgKx1lmyrsq8vL6CF44viqpox5NPKhRe7Zw9xuhhmxGBrxdJSq3IMs8wi2d1IoD/FY+bKkW8LHcWktDh6ZVmrTQwYzyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cb4iDmJt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 15470C4CEF4;
	Thu, 21 Aug 2025 15:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755790803;
	bh=//lvZcgVxWAuEEA3XDGiToePWRSnH3bkVOU2t/uuiIc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Cb4iDmJtkvpsfcraaWTJZwH7A20AGhAqlH073Mpqv/DpHXKx6KOthBtxZsP7jYcoN
	 N9txmEQVcmHsGM3lvrG2hxAVZxi7cAEJkashq8lOwFu6MnimEMXSvZYok+QnJPpRdN
	 KtQZG3PqG73FS2zxJ+pXF7OpRSqF3MbWDtmsl/aoJCNWZw2fVikSrQDXCvpue7n0G7
	 7a/eYQktIOEzlS+4ffvts5dttKR7ZUILF9zi4iF7p73K54URX/LfCuWhnAswA2/jT+
	 IG2HwJfU2uiHJxYilgNp7NZA00vSUdTfuFEzYqOUzyP5/245W3MfKmQ8p5m/zsaqpm
	 jpny5O8dALkvg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B64CA0EFC;
	Thu, 21 Aug 2025 15:40:03 +0000 (UTC)
From: Sven Peter <sven@kernel.org>
Date: Thu, 21 Aug 2025 15:38:53 +0000
Subject: [PATCH RFC 01/22] dt-bindings: usb: snps,dwc3: Allow multiple
 iommus
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-atcphy-6-17-v1-1-172beda182b8@kernel.org>
References: <20250821-atcphy-6-17-v1-0-172beda182b8@kernel.org>
In-Reply-To: <20250821-atcphy-6-17-v1-0-172beda182b8@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Felipe Balbi <balbi@kernel.org>, 
 Janne Grunau <j@jannau.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 Neal Gompa <neal@gompa.dev>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, asahi@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org, 
 Sven Peter <sven@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=707; i=sven@kernel.org;
 h=from:subject:message-id;
 bh=//lvZcgVxWAuEEA3XDGiToePWRSnH3bkVOU2t/uuiIc=;
 b=owGbwMvMwCHmIlirolUq95LxtFoSQ8Zy2/nG0SnPma7s+1u9jC+KO32S4AWrnn8X92R/kFnUn
 2z0xmB1RykLgxgHg6yYIsv2/famTx6+EVy66dJ7mDmsTCBDGLg4BWAiD7oY/koEWFjGfok9kx3/
 k3v65I0bfsR5Ji8oqNnHKmv2waD6PwvD/+qt78+F3JXaOeHTz5Ji7xnMT1MXKv9Yqbvl3YXZ3vw
 +zzgA
X-Developer-Key: i=sven@kernel.org; a=openpgp;
 fpr=A1E3E34A2B3C820DBC4955E5993B08092F131F93
X-Endpoint-Received: by B4 Relay for sven@kernel.org/default with
 auth_id=407

Apple's dwc3 variant requires two iommus.

Signed-off-by: Sven Peter <sven@kernel.org>
---
 Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
index 4380bb6fa2f08a475b557e80467abc2861f622e2..6d35dcc605c01977f4fc6fdb6f12976f1cef2b9e 100644
--- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
@@ -60,7 +60,7 @@ properties:
   dma-coherent: true
 
   iommus:
-    maxItems: 1
+    maxItems: 2
 
   power-domains:
     description:

-- 
2.34.1



