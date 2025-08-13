Return-Path: <linux-kernel+bounces-766846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FC0B24BE2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 16:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4D5D7B56FC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 14:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145952F3C3C;
	Wed, 13 Aug 2025 14:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="mD4Ikz+w"
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FE02EFDA5
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 14:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755095374; cv=none; b=m5oSYXpo71GoOp7HDu9nGtxquyYxhHgY2cQGTKDGNFSicES5O2XreUk/rwZbz+G1x5tTGJ1zga+LvlZwCx++k5Z/BPeOSWBO6eZ3SRrW5DfguxyJnF1Jk1flRP/77guPs41KlQ2Vfm+K8ZXFD9tsZqX6O4yCJW+/DuguUfO1NIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755095374; c=relaxed/simple;
	bh=tRLScCNd8aEoR0RyHaME8NIV0CK3UrHxOL8x20xrrAU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WCVsJVMUGymwRkuaLszvo/SesGo5T2OhDLqnknp9oKQ1XXUar3VtgrVxVtXp0pRnvQT0tIRjhbOz14qLzrI3QwRt+YJhE4oDl0VKC8C9yrjZYOPZvZEwtQW/lWtCpbfhSA29xJV9LamcYFy6USnpT7WlyslccdozcdR4xaNOw+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=mD4Ikz+w; arc=none smtp.client-ip=212.77.101.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 1499 invoked from network); 13 Aug 2025 16:29:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1755095361; bh=jhZJFs6zqhMHoUl3MWKTNF2RGyknUAVAXASmzqrI2+4=;
          h=From:To:Subject;
          b=mD4Ikz+wzacdrQeylio2irs3qrlefZspY/rwVN6k89wsm8/rxoj1tmDUX1zEcPkua
           1x2XUemTaJq8lguR4W20N3pEh2lAlCLg2CyLYxGlQoSfBCIz/f4+IJVNcTLf7lZklU
           /TCm6VVGoCOl4V/eKW2nQaD+OXhi4Gz36bnC86iKDibPMkpfvZm0otRt4B8+eH7PB2
           Yw3zBRci1ZhHytWaW6NY3EXq036aMEGZJSfD2NwN6fpXa8XQycFifP//xn8HYi0aDD
           ZmRbgkWoWI73wFn9078MyNEfFMkFdBvDMzGv2wNb0ytyimUCSKrmBZl+61F/NcY7OG
           eXmZcs2ZNPrdQ==
Received: from 83.24.134.210.ipv4.supernova.orange.pl (HELO laptop-olek.lan) (olek2@wp.pl@[83.24.134.210])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <robh@kernel.org>; 13 Aug 2025 16:29:21 +0200
From: Aleksander Jan Bajkowski <olek2@wp.pl>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	neil.armstrong@linaro.org,
	heiko@sntech.de,
	kever.yang@rock-chips.com,
	mani@kernel.org,
	tsbogend@alpha.franken.de,
	john@phrozen.org,
	masahiroy@kernel.org,
	olek2@wp.pl,
	devicetree@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: vendor-prefixes: add British Telecom
Date: Wed, 13 Aug 2025 16:21:32 +0200
Message-ID: <20250813142917.2053814-2-olek2@wp.pl>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250813142917.2053814-1-olek2@wp.pl>
References: <20250813142917.2053814-1-olek2@wp.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-MailID: 3140f8cfc6028825d164cf319c772054
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [caOB]                               

British Telecom is a telecommunications operator. It provides various
home routers popular among OpenWRT enthusiasts.
Link: https://www.bt.com/

Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 77160cd47f54..e91879137e43 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -243,6 +243,8 @@ patternProperties:
     description: Shanghai Broadmobi Communication Technology Co.,Ltd.
   "^bsh,.*":
     description: BSH Hausgeraete GmbH
+  "^bt,.*":
+    description: British Telecom
   "^bticino,.*":
     description: Bticino International
   "^buffalo,.*":
-- 
2.47.2


