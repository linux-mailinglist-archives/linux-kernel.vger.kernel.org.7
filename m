Return-Path: <linux-kernel+bounces-720243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D7AAFB90A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 18:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D6D34A5D86
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 16:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A54239E88;
	Mon,  7 Jul 2025 16:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="pYYzZY8m"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDE323507F;
	Mon,  7 Jul 2025 16:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751906991; cv=none; b=jTNfZd0mmLgANcca0spECBczCxnERu8JipcQTPmMFiAXqYuGi1V66VqBAFTQkPBftfqfiI4LRQGcN5RfwhhY+H3sHHOKg4MdkEAiegiL2q6v0KBRJbL8tNf/ZDUo6bHozt6savfZuND283T/dYroOeoZKdNOPWManbjIurLKlQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751906991; c=relaxed/simple;
	bh=A5RMOmtJFBcuxwN5bakx3eyrZRIQMZ6mQUAJAgyRpEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l9txDhca0f/iH17ZotzWN3k37FCY+cN/bOZel/Nw9wNrp/K7vs8kk27yA9Q9Ljj28HHt2nKphkgM7gkeVh7ufFUBIuZ3KXnmucBBjHYPgMrVT2/xUsW9AMgr272op8ttqiXC5yLV4myDP6zX4eKTFMn56OcYx3yMWM65JLMuN98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=pYYzZY8m; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=UssX1ASejeE1FfOOTatFss1tZXaYm0On8IoX7Y///lI=; b=pYYzZY8mQ8czGLIn/1QmcdGsNP
	7ooLfZukGQP9nDSqZmkrwX4Z8QK1B3XlGyHIvM9d60hE8lJw/Bt4dugJxKxYBSxfkW9gKyvGWyahs
	SpEbaJTl20RwPrs0yZEdH9nXD+xDbzoiY6P/gP4hOy0zGuQWPJJkZNVYcyXNwHsA4ZyiWs+0BhC6u
	6QqMDhKaerWdDCKvrsrp00wOfIuEbRugqthQQuS2H+w6WTtj3J9qpcE6iwMW5bx9zpTH6RshdJvsW
	axBWW4ya8xGTXuHF4vC5En3zKI+j0buxKSgUIxSf5EhEhQIuQtLt/MbsihJpMqP5oug9wmD3S3x1+
	NVAZv7wQ==;
Received: from i53875bf5.versanet.de ([83.135.91.245] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uYp1r-0004yl-NF; Mon, 07 Jul 2025 18:49:19 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: neil.armstrong@linaro.org,
	quic_jesszhan@quicinc.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	hjc@rock-chips.com,
	andy.yan@rock-chips.com,
	andyshrk@163.com,
	nicolas.frattaroli@collabora.com,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH 04/13] dt-bindings: vendor-prefixes: Add prefix for Shenzhen Bestar Electronic
Date: Mon,  7 Jul 2025 18:48:57 +0200
Message-ID: <20250707164906.1445288-5-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250707164906.1445288-1-heiko@sntech.de>
References: <20250707164906.1445288-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the prefix for Bestar, named in full both on Panelook.com and their
display datasheets as
  Shenzhen Bestar Electronic Technology Co., Ltd.
which produces at least DSI displays and maybe more.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 5d2a7a8d3ac6..5e066c07c188 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -216,6 +216,8 @@ patternProperties:
     description: BeagleBoard.org Foundation
   "^belling,.*":
     description: Shanghai Belling Co., Ltd.
+  "^bestar,.*":
+    description: Shenzhen Bestar Electronic Technology Co., Ltd.
   "^bhf,.*":
     description: Beckhoff Automation GmbH & Co. KG
   "^bigtreetech,.*":
-- 
2.47.2


