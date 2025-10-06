Return-Path: <linux-kernel+bounces-842894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E22BBDE99
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 13:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EF8718940C2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 11:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED33272811;
	Mon,  6 Oct 2025 11:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="ZuS+6zeK"
Received: from mx-relay04-hz1.antispameurope.com (mx-relay04-hz1.antispameurope.com [94.100.132.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0415026E6EA
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 11:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=94.100.132.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759751406; cv=pass; b=D8LDxiVenX/bfLwd1J/gFH6mXTOZfyZ4vX3LZmLaS5FaPrpfz2ryGbOGeDa2T50sRb4WBNusL0s0z91uh8+zAwW9nWUz+1ge6ZJkXM5Hp9tnSi3QzhfWmF2RzW9Yxp1DIxsO/IdYXMjNiPqflqzkHPvOeS5jn4J8LyAMGF6OCIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759751406; c=relaxed/simple;
	bh=qarvGPIXqA4kc0VRJVXX2DsO6Wnlroa5YHsjyH+FLN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YTBMkLj9RXFMwjFqwR62DVekDW83KCYWAt3Op708AdwNHjHP0noS+VqOW0jvhqULGSRAvBrYNvHYv/1+I4x3+gCRrIDheUrk8G5DelzugpKqlIVyaWf5Yc3yq8Fv50MX5CQpG0DKi2JXZ/goO3IEE0GUg/cm0XlAUIikc8aJuAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=ZuS+6zeK; arc=pass smtp.client-ip=94.100.132.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate04-hz1.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6, headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com
 smtp.helo=hmail-p-smtp01-out04-hz1.hornetsecurity.com; dmarc=pass
 header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=KYptHwQxYppzTfCWVdL/R5bMHuCmx/luf6VVt6namUI=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1759751363;
 b=KHHu+2AWTl8szZRo9T8SZQQFxIdGrW331oXUGWY51dqHgo0mcFENo9KORmm245IHIfo4f/hx
 q9M9vLx0qU/p3/cz5g+cuu7Qh5A4sxCDV5SIZe1O5mFPvGpViznVZbKi4SKrxIdVat8UJfXYpmW
 +rpbKZSH1CoUmxPGfIgLD68iLMSuNNasjrdAFuiOYkabEc3GUgWglYc9915H6/f6zjdYDVMyJ9/
 vObYpreFntKchL6IMITuXm7bCQC8PbV7CgML/yyBo1SxiGeQcZjgXq+fpESWHO5RbqyfGlbulb7
 pxQNkhPRe15b3ZyzHTSrX9wzZkQOlaY3yCnH72rDHpARw==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1759751363;
 b=XdmcP+y/weriuG1EJzg7zGgzuOXA86wQ0ukdFLVeasWgyUtcjvYkOuCQHyhDOcXNHczLrZjr
 yM9namYRrrW7FMzKC7uyn7sl4pRdPVl8OIEyx2Yx5vVyAEjZ5SGW62+nRBbe+H+erLE5VPPbjSo
 5TPIjbSmOFJHI/qbB0/Rdc8tVs1f0znV7ovD9z1llW/p1Z1SEYVLJNDkv4Sk4t3YlSuy2o8nYti
 q0OIemoR/z247MRg5YNNS+3CAJzJxwDKn7a7WrWGt5HSQWE83z4IPGObrfUduqVIR5WX8SDczUy
 ysG9Npqb80TCuuUVsLpGhyVQFDVhcr8/QlB4+gYFH0M+g==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by mx-relay04-hz1.antispameurope.com;
 Mon, 06 Oct 2025 13:49:23 +0200
Received: from schifferm-ubuntu.tq-net.de (host-82-135-125-110.customer.m-online.net [82.135.125.110])
	(Authenticated sender: matthias.schiffer@ew.tq-group.com)
	by hmail-p-smtp01-out04-hz1.hornetsecurity.com (Postfix) with ESMTPSA id 4F5EC220CF2;
	Mon,  6 Oct 2025 13:49:03 +0200 (CEST)
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Andrew Lunn <andrew@lunn.ch>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux@ew.tq-group.com,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH v3 1/2] dt-bindings: arm: ti: Add compatible for AM625-based TQMa62xx SOM family and carrier board
Date: Mon,  6 Oct 2025 13:47:47 +0200
Message-ID: <7691a2ca5ed49da6276d406e5dd986c91f221c9b.1759749553.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1759749553.git.matthias.schiffer@ew.tq-group.com>
References: <cover.1759749553.git.matthias.schiffer@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-cloud-security-sender:matthias.schiffer@ew.tq-group.com
X-cloud-security-recipient:linux-kernel@vger.kernel.org
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for: matthias.schiffer@ew.tq-group.com
X-cloud-security-Mailarchivtype:outbound
X-cloud-security-Virusscan:CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay04-hz1.antispameurope.com with 4cgHc010rQzS0jY
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1, IP=94.100.132.6
X-cloud-security-Digest:b8a1cefe5a1b3338a1f745c2baa9dc55
X-cloud-security:scantime:2.278
DKIM-Signature: a=rsa-sha256;
 bh=KYptHwQxYppzTfCWVdL/R5bMHuCmx/luf6VVt6namUI=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1759751363; v=1;
 b=ZuS+6zeKrccSv8WUDdfGwhmqg1T/Q1+usj1KmJdTQbL03RW9xi4K+yARe5OrqQbFPc3ZUOX1
 +4LEMwxv+lug7KWguEJYQfpBfhdwLO9ZO7fEZXjIEFytOPuf49Ekf9G+4AJmHYxGe0MRAmNX8n6
 OvMcUBccCthhF2J/sCSe1KwqB1QBNHAvaYgpDUC9ZfGfutLGkp7jB69IsrWss3e4NVIYJByIdH/
 x0FtpDhmJ8A0dxfveSK2iiGif4Umz6r4+HLcWHLDFDPB2fzlECE7/NO6qoNwMf8pLWGVBIuUQIL
 uFqujqO2n1Bumlu0VS2l/W965gO+g2WOdUxdS58EeFfFQ==

The TQMa62xx is a SoM family with a pluggable connector. The MBa62xx is
the matching reference/starterkit carrier board.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/ti/k3.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documentation/devicetree/bindings/arm/ti/k3.yaml
index 0105dcda6e04d..ed89a7a36e1f8 100644
--- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
+++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
@@ -89,6 +89,13 @@ properties:
           - const: toradex,verdin-am62          # Verdin AM62 Module
           - const: ti,am625
 
+      - description: K3 AM625 SoC on TQ-Systems TQMa62xx SoM
+        items:
+          - enum:
+              - tq,am625-tqma6254-mba62xx # MBa62xx base board
+          - const: tq,am625-tqma6254
+          - const: ti,am625
+
       - description: K3 AM62P5 SoC Toradex Verdin Modules and Carrier Boards
         items:
           - enum:
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/


