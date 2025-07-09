Return-Path: <linux-kernel+bounces-723126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F180DAFE33C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 10:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 346EC17D6C5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 08:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816112836BE;
	Wed,  9 Jul 2025 08:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="GGg8EwSx"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119EC280A51;
	Wed,  9 Jul 2025 08:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752051226; cv=none; b=Uegraj5Mjo4HuFlWRRnCP9rj8TAPR+Uteq2LH9wwGEhnRMpmdzxgF3dvQbkn04c79jR+sTJG6phrRVB7A9b7wYfdwNXSddZxFV5fZ4g4UFscllok0nbyq1fhI3uxjN3uHKzdaUVGUQS5Nm7MrD3SS6d3CIxvKtfXuRpkjdA2xnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752051226; c=relaxed/simple;
	bh=jWZNbtieMlukarfurzmaf+LlmGQDBBQxXt2OISoZBI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=toZcK1iIzSGwd1ou4CCpYhPyBnJK+FUd76F4ikoXafHvtOPjuV9VHPjO7uBW1JshGPjXQEvOvFcm69RmD0rVKHI3cmPWtj/Pi+ZTVnkxJWI2LOr1MAszGvOgx7H2hy5x9udt8C5/hUH4h+WEmPsGNr4/h8UcrRI/92Um0UR6wa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=GGg8EwSx; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1752051223;
	bh=jWZNbtieMlukarfurzmaf+LlmGQDBBQxXt2OISoZBI8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GGg8EwSxDwloZxnzrUqj5xAGCBoz0h7ZVfuKUBVA5gXoRrB+JYnMooojE14DNmOoP
	 Xm1rMJlWdHb5lL8FX/JuuwyvLgbE/8rBuLe9zQbuTOPoLwkc04loRrzm2auPgwqQoM
	 czAUovxwjgyFKNCWCesgR7CAEuWYZBwueMKViAwFgJzs3bi4MtKODCSYH+8v5QgGUz
	 AaeNTG3nABqEblRLY0PqYSrWyjLkgajFg5q3//IVyGsTPUF/m3PSLSttUJCp2JRxEa
	 P+rjY4EHNdYI+OLAuTFeVne1ZvlqdG4s8FDpAPhQq3XAh+rjYtrzkIr3ckYVCC67pK
	 bvih4Q9UIYMfQ==
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:8d6b:4a4d:ad13:46c1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: benjamin.gaignard)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id EA15B17E08E3;
	Wed,  9 Jul 2025 10:53:42 +0200 (CEST)
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
To: joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	nicolas.dufresne@collabora.com,
	jgg@ziepe.ca
Cc: iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	kernel@collabora.com,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v5 1/5] dt-bindings: vendor-prefixes: Add Verisilicon
Date: Wed,  9 Jul 2025 10:53:26 +0200
Message-ID: <20250709085337.53697-2-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250709085337.53697-1-benjamin.gaignard@collabora.com>
References: <20250709085337.53697-1-benjamin.gaignard@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Verisilicon Microelectronics is a company based in Shanghai, China,
developping hardware blocks for SoC.

https://verisilicon.com/

Add their name to the list of vendors.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 5d2a7a8d3ac6..1baf8304c9ac 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1635,6 +1635,8 @@ patternProperties:
     description: Variscite Ltd.
   "^vdl,.*":
     description: Van der Laan b.v.
+  "^verisilicon,.*":
+    description: VeriSilicon Microelectronics
   "^vertexcom,.*":
     description: Vertexcom Technologies, Inc.
   "^via,.*":
-- 
2.43.0


