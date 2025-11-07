Return-Path: <linux-kernel+bounces-890980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4645C41830
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 21:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F648189C6FE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 20:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D6830B52B;
	Fri,  7 Nov 2025 20:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="Z3BGhPy2"
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E86309EF1;
	Fri,  7 Nov 2025 20:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762546027; cv=none; b=UpvP91PlOrxBbXMIicI3F1rhvxvQ4u41UAypu8RkyQAT94DW40N2b7/+pkRl1c1jASGoxIm8GeBdVR+jNqOC1WHLfnLSfJ4nMpPNMtoCAQk8L9MjXl3NV0UtJQQLpDKXUmADvko8etmhqKkBEZsFpnbIzk0HQNBxlNg6FgtEryY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762546027; c=relaxed/simple;
	bh=xK1MSW7bqEuQTy6tStX5HrpAotQbanzu2XrfeYjg9kg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UpmFvrzdimYw3Jv8rl2PEGnVsRybw52n61Lic0S9vLQE+O/AtwvacyATX8ui5U5KAYWwt7jfAdvktg/W1x01h/LcxsZgHzTk1V2Ij+fkVaIRZk5ZWJZEpLhzAnY85Y8yYpUt3/Ag2VLA0dBkWvOJP5+4Icw6dA+LrRy00YqJPKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=Z3BGhPy2; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Cc:In-Reply-To:References:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=Apyt41+4mOwFak7jR/iDHVXoTub+1mEmP42h2q4HU1A=; b=Z3BGhPy2CHpqj8mm9ED1t3DO8B
	OQm4OOn5CX8gmBsYNnUdfpsXx3TrSaSyYy+L1KsSms0B5cX+81tICQNXdSCMCECIWBMkrl+3dqFS4
	lpbRz+MhtAwJrECqqMZxaOsrkjYf3jPv9h8R+Is8cvyQ4oL8sonmjG2U2fpr2jZ7QNcObIialnFQ3
	RHRlv51DRHJHsLfpxYR5Xa+RH4vsoJcpTkqmaKEdo6fwvYCURlpeLAiJWDj+9uwOBG1ddFHWDiXcS
	x+rRySBojKNfUxd/BMMwydudNKjqAAYp/5q5gsdjx8DL7sVzITt5xNHii5EJGPegbXpvNk5/leOHa
	SiqChChA==;
From: Andreas Kemnade <andreas@kemnade.info>
Date: Fri, 07 Nov 2025 21:06:44 +0100
Subject: [PATCH 1/3] dt-bindings: vendor-prefixes: Add Fitipower
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251107-fp9931-submit-v1-1-aa7b79d9abb6@kemnade.info>
References: <20251107-fp9931-submit-v1-0-aa7b79d9abb6@kemnade.info>
In-Reply-To: <20251107-fp9931-submit-v1-0-aa7b79d9abb6@kemnade.info>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Guenter Roeck <linux@roeck-us.net>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hwmon@vger.kernel.org, Andreas Kemnade <andreas@kemnade.info>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=813; i=andreas@kemnade.info;
 h=from:subject:message-id; bh=xK1MSW7bqEuQTy6tStX5HrpAotQbanzu2XrfeYjg9kg=;
 b=owGbwMvMwCUm/rzkS6lq2x3G02pJDJl8gbFpb27udjm39roES2O2TmD0nHmOW5Qe1ezfEHpsw
 l1RpSObOkpZGMS4GGTFFFl+WSu4fVJ5lhs8NcIeZg4rE8gQBi5OAZjIGkuGv/LHZfOuXm094Lnl
 3o78VRLNJ4NUvkznYvyyef2qThXxkOeMDE/CrL5rRGy+Ffz8aalU101rsxcn9cRvx8cs8rB/wr6
 Xjx0A
X-Developer-Key: i=andreas@kemnade.info; a=openpgp;
 fpr=EEC0DB858E66C0DA70620AC07DBD6AC74DE29324

Add Fitipower Integrated Technology Inc. to the vendor prefixes.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index f1d1882009ba..506b146e9bd0 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -570,6 +570,8 @@ patternProperties:
     description: Foxconn Industrial Internet
   "^firefly,.*":
     description: Firefly
+  "^fiti,.*":
+    description: Fitipower Integrated Technology Inc.
   "^flipkart,.*":
     description: Flipkart Inc.
   "^focaltech,.*":

-- 
2.47.3


