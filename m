Return-Path: <linux-kernel+bounces-759141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FBEBB1D912
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 15:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06F561AA4CFE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 13:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5254225BF16;
	Thu,  7 Aug 2025 13:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fdH50sZk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A046613B5AE;
	Thu,  7 Aug 2025 13:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754573354; cv=none; b=Hb9QhdMhnYPTE/62dYlLyiX3ejRisB88MGQDzz6UXunYgCOjj4hRsVzY9wFxBAAevFWQXtY7+E/QWGHZxBYSxfqwUcDJEubHGtY6YErkRU1TA5chGzbsW30lAn597kE/OsRAOpGkHEq27YkC6A7P24ocWN7jMuYINI1tgewtqa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754573354; c=relaxed/simple;
	bh=cdCOhY1Kx0+VMbY2fmJzeqOhQxEfpe/s5pe8/mpr8oI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IORq3ZQSTS3zrGUPg58XOS8NIyKiCMpV/2J43gIlUcEAsaP/67DnMsVREOnrPvvVBlyhnkXMNO6Ls97KZQv6IfzEnvLsfivm8OkAi5lGaMHl24HvYfeH2z+fPJ1+c95iL4j0GDIDKeOLvz7Gyfjs4/En1pqPcERKksZbdfaSUtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fdH50sZk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16415C4CEEB;
	Thu,  7 Aug 2025 13:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754573354;
	bh=cdCOhY1Kx0+VMbY2fmJzeqOhQxEfpe/s5pe8/mpr8oI=;
	h=From:To:Cc:Subject:Date:From;
	b=fdH50sZkCPkZ5YhsmHuypP27Q6dcAah/XTEns6CZoxVZHHD0K4k0xcdsffjLVNGHi
	 ezM8uqmxoaY1nqQzHVfiSBSObNvbEyyYjlP2kbt2YY3mZlnzOBNwdUXQAGHaElPQXj
	 tsjLxwU3lubnul9g97n/1bcN1KTz7r7tN3klFZwdRsZ+7CICuuvyinRVVwCogoRQFs
	 MAKMXSe5/RnJSdoXfjOgtPOR1Cg4GxF2p5uijesxX+089O7nFbuqFvger7Ms+iHhz5
	 NppMFQRzcex0f10xFVJTA4VfMNYbLwxjWJC/kkqFnFCA9yk3kufB7+UHbpek8M3OaN
	 YQdvvx7ayVhgw==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Lee Jones <lee@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Chia-Wei Wang <chiawei_wang@aspeedtech.com>
Cc: Andrew Jeffery <andrew@aj.id.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: mfd: aspeed-lpc: Add missing "clocks" property on lpc-snoop node
Date: Thu,  7 Aug 2025 08:29:08 -0500
Message-ID: <20250807132909.3291770-1-robh@kernel.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ASpeed lpc-snoop nodes have a "clocks" property which isn't
documented. It looks like all the LPC child devices have the same clock
source. Perhaps it is the parent device that should have the clock, but
it's too late for that. The driver for lpc-snoop requires a clock to be
present.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/mfd/aspeed-lpc.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/aspeed-lpc.yaml b/Documentation/devicetree/bindings/mfd/aspeed-lpc.yaml
index d88854e60b7f..f329223cec07 100644
--- a/Documentation/devicetree/bindings/mfd/aspeed-lpc.yaml
+++ b/Documentation/devicetree/bindings/mfd/aspeed-lpc.yaml
@@ -137,6 +137,9 @@ patternProperties:
       reg:
         maxItems: 1
 
+      clocks:
+        maxItems: 1
+
       interrupts:
         maxItems: 1
 
-- 
2.47.2


