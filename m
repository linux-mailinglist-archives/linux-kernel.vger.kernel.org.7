Return-Path: <linux-kernel+bounces-877037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A11C1D0A2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 20:42:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 404C44E05AC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 19:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B86F359FB2;
	Wed, 29 Oct 2025 19:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="gvuq8XCA";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="GJ7Zg+pG"
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5530929CE9;
	Wed, 29 Oct 2025 19:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761766940; cv=none; b=uBX6PMyD6ME4aeqLOVdeFxPoKGWPSasD2EFbiQsk98dKwK7ZvTDJniGrebQUvON2CARXQBDcZdY4VCRx0wYwY6ONGexHrkI2I/31v6rrqUrA24m3Lh4HKCkxfKj9EemKrWSb5qH5nB+viLtUddpG+ISi6sP9XsS8XyNeKBR2k4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761766940; c=relaxed/simple;
	bh=s9UDdg7rkftnp+QP61iD1TIGrCcsmMleZXA0PojaHCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TDT/PblGthn6+zFzpswxHK5nVaeEI1anEwSO2yE+33lgQgP/lgURkVCj1+1uVUTagIBNffki9tXte7D6LffSUyPXY9vd6dAMbjx5eqgc3R8ubBlaDbdmmzYIn2ZBAQ1cQzAd1l2bkXSn4kjW/M7E3gkO1IWw0EtQ9Q3TzBEMTWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=gvuq8XCA; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=GJ7Zg+pG; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4cxd1P38TMz9tgK;
	Wed, 29 Oct 2025 20:42:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1761766937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+ZThYyYJOwM1+BCwYF269VW+S6XvWye2pxq2VEf4UAc=;
	b=gvuq8XCAtRlAYCrGtrF0P3P4PuyPupf//+PO2Gh/loOUKusWFp25p97d9qa/CHgivoj0/8
	lKTxEYA4IurN8FN4mBhHVgU1UIydM4XYxQgoP//LrHuQITdrasMOwqvrLaaAl/pefbZzyJ
	KXWoiw+5tMrCuxmybTs3GTdmWDc2wBy5GsxYtqUCv6fMQNdr1j8ORgoP7UZAiaC2Jvxtzx
	lkrgLILhJ+XPoJGbs1MBLDmAIoRJaa7I1hlpJYfSmUYULLkS3bbbnzp9m4Ys07//7VXg6I
	688qlqUvNoWjVCzHKYoPO7M9vbrnlea/f/ieNi4jM3dEZDhy8YTmrWEP2/d4rg==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=GJ7Zg+pG;
	spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1761766935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+ZThYyYJOwM1+BCwYF269VW+S6XvWye2pxq2VEf4UAc=;
	b=GJ7Zg+pGDiNcyur0EutixwUf5F6DbfSIxNmPr92Om9wa7utudBIRTeNuZ1Ga8CHrpqXdFt
	aI6c0sdRgtPfxb1iH0Gb15QFoZjo/wbRQwdWLaQ/HelFmxHJEQZxlUMo2LofbpOYe+v1AZ
	+fPscTdBoco3KY9rxo69hU2fSHY3gaj0hSyo9dKGwgEQgPSuc/x6DKfUT3RJurbvqonfvT
	4P8VIN0sOqv9ptvSj8FsH9lIaprRR/KEZYll3cohxdU/IWH05PmUoWJStAcNtg5n6z6Kmk
	QyyZe2wmssur4nF4dEBvH12XKv1Dso67l8AIeYcr+nHUnmHn4QlCrDVoi/mzgA==
To: devicetree@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Airlie <airlied@gmail.com>,
	Frank Binns <frank.binns@imgtec.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Matt Coster <matt.coster@imgtec.com>,
	Maxime Ripard <mripard@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Simona Vetter <simona@ffwll.ch>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: gpu: img,powervr-rogue: Drop duplicate newline
Date: Wed, 29 Oct 2025 20:42:02 +0100
Message-ID: <20251029194210.129326-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: d99c324eee434e72efc
X-MBO-RS-META: fm4bxq96txzbruo1s1tkytmibwba6nsp
X-Rspamd-Queue-Id: 4cxd1P38TMz9tgK

Fix the following DT schema check warning:

./Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml:103:1: [warning] too many blank lines (2 > 1) (empty-lines)

One newline is enough. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: David Airlie <airlied@gmail.com>
Cc: Frank Binns <frank.binns@imgtec.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Matt Coster <matt.coster@imgtec.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: devicetree@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
---
 Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
index aa8b2069cc24b..a7ca6d3fdf10a 100644
--- a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
+++ b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
@@ -100,7 +100,6 @@ allOf:
         clocks:
           maxItems: 1
 
-
   - if:
       properties:
         compatible:
-- 
2.51.0


