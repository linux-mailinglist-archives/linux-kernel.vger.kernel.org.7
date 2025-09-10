Return-Path: <linux-kernel+bounces-811128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 882BEB524BE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 01:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A5424864BF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 23:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3276130C367;
	Wed, 10 Sep 2025 23:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eMxPaDi1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D4D303C85;
	Wed, 10 Sep 2025 23:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757547406; cv=none; b=eZyqX097R3T061gvxpr3Sds3C8Vc+Pt4mye7p2ri0U/Zn6ZgAjKvd85ojmzcA6mz9jHZZJpJs9MkT/Tu2dlPtBPX7LsOfxqGgzrRvqEiur5MQArGGFCavDIBPECQf4jIKRREgYme6WTepR0N9PTgpX3d6/ufagO1nak74fidJ9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757547406; c=relaxed/simple;
	bh=cD3B9ogAtUzQ5WJyQ6BphK5SCaT9vTvGdw3vMTK1Xsw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oIZkeoEk77/YnmD2zG1x8Fvjnglfl8yXbBK4HcVMrRGfheMs6ot8AeCNFU0Ja8nV9QnrJD1KwNJbXzGHb3n3lvjeslbe0W4iG1+20l1oR7dd1WzHq+RhX8RvYm3xnLcaS4Kd5cusE8GUBPTmtCQcy+88c4ZD1GUnG0ulvQEpZys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eMxPaDi1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB415C4CEEB;
	Wed, 10 Sep 2025 23:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757547406;
	bh=cD3B9ogAtUzQ5WJyQ6BphK5SCaT9vTvGdw3vMTK1Xsw=;
	h=From:To:Cc:Subject:Date:From;
	b=eMxPaDi107qJGvdMUwROxipHY+SUw4IWiHHJtw1fvj73xOBkzr9sliDA2/FGSio9t
	 OBuFfpBZNk4yDVYdMbKeaqtu7StXslje/SbmANr+qPNKw2QHEs1Lrmlt21otBdINh7
	 V6YRgKZRjZTEJw+Gt/D2MbGS7UpZwCzP1piMZu09MRLBXitjJx1t1taEpwhUhYwhnu
	 8tlWdLmzZ6V2526Wpajcsqguz1lo1hnrZ2sLqgjNAYYOOCKTuvJ/vYtMMLe9o0oyBU
	 ac8o109CLl0SoVdKb9W3VjICA3Uzv7aGyfEQUrHwkpmKbRIS+GlPdjHZhWjLvusTJF
	 EiaDlHYmFr+Bw==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: dt-bindings: linux,spdif: Add "port" node
Date: Wed, 10 Sep 2025 18:36:15 -0500
Message-ID: <20250910233615.775397-2-robh@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SPDIF receiver/transmitter can be connected to a DAI device via OF
graph port. It is already in use and supported.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/sound/linux,spdif.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/linux,spdif.yaml b/Documentation/devicetree/bindings/sound/linux,spdif.yaml
index 0f4893e11ec4..aea6230db54c 100644
--- a/Documentation/devicetree/bindings/sound/linux,spdif.yaml
+++ b/Documentation/devicetree/bindings/sound/linux,spdif.yaml
@@ -23,6 +23,9 @@ properties:
 
   sound-name-prefix: true
 
+  port:
+    $ref: /schemas/graph.yaml#/properties/port
+
 required:
   - "#sound-dai-cells"
   - compatible
-- 
2.51.0


