Return-Path: <linux-kernel+bounces-618676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 436C2A9B1BD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Apr 2025 17:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 937A89A07BF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Apr 2025 15:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2971C8616;
	Thu, 24 Apr 2025 15:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="N9NZXGE3"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1A619F47E;
	Thu, 24 Apr 2025 15:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745507315; cv=none; b=o7gP8OLYjqkgk0jEI0x2xCXibt+xtd5KockFWaRHWlvEReaJxEU2eM9gv9rsZCen/8pg+eLLhhRFmY7zNYOF1pQyrC+Pm7OOq8bHq0dXbvC1GZUb1R0EOj7z4rg9jV8qrqtT7q8gRGGgjKYKQ9tljiIv8d81IOfE0whMP8n1LR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745507315; c=relaxed/simple;
	bh=DHLcH3mu/RLl2jx09mAzvxQ6hmd50A5n3GJxUeLNgQk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BR5l7vZTa7N15pr+icugUL8PYCRfUWeJ+x4/hZ02c8ylpooRl/+PMzdQD2ecPNr4cxVMDLnqV4MnX+HOkX9iPj5yp6bCbas+AujCSyMqRtes07tzgANK/QtswvP35UK1H2i+l01bSFdZLMXnGiLE++17+IF0i2667ZW3+xrNp/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=N9NZXGE3; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 437B543B2F;
	Thu, 24 Apr 2025 15:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1745507305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vJeEd7VfxCYfJYj2Q+Ydr+oDGWhfrHglzb7X7ddA560=;
	b=N9NZXGE3iOJNUGgPLqyE/3bQ679q3V4Ubdk+hqAZG/e/DsN0DO3WAKOMGxWrcar9KNKcUh
	lbkoSmYP1Fl1My9zlRb3uIgggp8ee39ZLx6fGO15+9H7oqLv+x0UJX8u81op84inWd3GWV
	zIG7YYfld2VcPu15gfLKNCdJP+MjpOSgmwrC/IfDldVbvKElyH51y4Q029J5Yla39ADIxI
	NQ3lQk4vUJfTS/jGOOthrWU2aYUUXVDKvbXrDtYxcBewW4Rjk/FEcpJUlOkkvFX8XoSVys
	38NHzRg0IIBSFlDfTuHSfSBJ4gSSqWAmy46T+PRoNJ2rLfctrrO8TPXSl7p2EQ==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Thu, 24 Apr 2025 17:07:39 +0200
Subject: [PATCH RFC v2 1/5] dt-bindings: display: panel: Fix port binding
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250424-feature_sfto340xc-v2-1-ff7da6192df2@bootlin.com>
References: <20250424-feature_sfto340xc-v2-0-ff7da6192df2@bootlin.com>
In-Reply-To: <20250424-feature_sfto340xc-v2-0-ff7da6192df2@bootlin.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeeljeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepmfhorhihucforghinhgtvghnthcuoehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeevgfdvgfektefgfefggeekudfggffhtdfffedtueetheejtddvledvvdelhedtveenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplgduvdejrddtrddurddungdpmhgrihhlfhhrohhmpehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedukedprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepughrihdquggvvhgvlheslhhishhtshdrfhhrvggvuggvshhkthhophdrohhrghdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggvvhhitggvthhrvggvsehvghgvr
 hdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepqhhuihgtpghjvghsshiihhgrnhesqhhuihgtihhntgdrtghomhdprhgtphhtthhopehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhrtghpthhtohepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomh
X-GND-Sasl: kory.maincent@bootlin.com

Faced a binding error check while adding the data-lanes property in the
ilitek,ili9881c binding. See the next patch for the binding changes.
Here is the error:
Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.example.dtb:
panel@0: port:endpoint: Unevaluated properties are not allowed
('data-lanes' was unexpected)

Change the reference of properties/port to $defs/port-base to makes it
work.
The only difference between port and port-base is the unevaluatedProperty
set to false. I have tried to use properties/port in both panel-common
and ilitek,ili9881c bindings but the error is still there. The only way
to not face the error is to use $defs/port-base reference. I don't
really understand the ins and outs, maybe it is a issue from the binding
check tool.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Changes in v2:
- New patch
---
 Documentation/devicetree/bindings/display/panel/panel-common.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-common.yaml b/Documentation/devicetree/bindings/display/panel/panel-common.yaml
index 087415753d606ce67bceabaa9b0ba7d463282f92..635f67ced0cb7103684a1415ab740d83409a7dbb 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-common.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-common.yaml
@@ -76,7 +76,7 @@ properties:
 
   # Connectivity
   port:
-    $ref: /schemas/graph.yaml#/properties/port
+    $ref: /schemas/graph.yaml#/$defs/port-base
 
   ddc-i2c-bus:
     $ref: /schemas/types.yaml#/definitions/phandle

-- 
2.34.1


