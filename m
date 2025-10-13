Return-Path: <linux-kernel+bounces-849943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B747BD1653
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 06:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 430DE18953AD
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 04:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774862C15A8;
	Mon, 13 Oct 2025 04:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="DsIhr/Cj"
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D193283FDB
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 04:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760331125; cv=none; b=dccMfMKiC5h3acfgw+YUU/P8ursmWHBYtPHUyhs+N+IYdZ5Al12gx8bQmTG/ug9qYKrSjYdGWgiRrwgop1tvfzYQ6ZPnZjW/KdwqRo1SjcCVSAdLuzYWMD5QyzQ+fH7IBsslt1OzFdoryXy5E4EEDrjLJkP+Cm5/1ZvZXpVtI+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760331125; c=relaxed/simple;
	bh=TGijnfP63bLoEEIa+F0axtF4nYIOHU+yJpAd4E0PVds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fZ+nt2oybLWaSlM4aVRCQ5bHjNIG7uEXycDKQ5A138h69eHPnhAU4cEg+0kWloiJER71+bUfYZ4OKw1Ur/XdKC3HfLZLx3LdmghdRsx1HWcXNtNnqVx3Ifl59nsrjBZILlK6aA/oe2wyEWdctODy2M87jkU7RcYjaMec2oAT3WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=DsIhr/Cj; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id D4CCB240101
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 06:52:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1760331121; bh=KYSb2eVGrP9QZN+RqCt8LieU27WuvxR5OzqhlsJwvk0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:From;
	b=DsIhr/Cj0VMA8nRL7EDNsVn5xguW06shVQ1B45z0r6lA1a3tv5/0xongKWcIX9A1X
	 fEj9Qj17EumfmQcrVGqWxAGxFciY2FGeXO1QkoiHKGNUdVTxrUZhAtT9C/xZimsO3+
	 TSO/t0rniubdjo37IPSz7nEdasNQj540CFzpsIU5Zz4+JFsTE+iY2lSBfQMuroeHMD
	 A+stkNJBgerY5vC/KwgF4un6zqs/HzsfAwRElUuAVbKlGKyQGnhCUtdCTwLwDYknwA
	 MLkysJLjANnO1PeaOmRhUEL81ngj9e8lJQAKEAdxcw/U+N32ABJeNzzd1Ob7VU7x0R
	 y6/pil0kFEYwg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4clQ1Y1bczz6v1B;
	Mon, 13 Oct 2025 06:52:01 +0200 (CEST)
From: =?UTF-8?q?Martin=20Kepplinger-Novakovi=C4=87?= <martink@posteo.de>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Martin=20Kepplinger-Novakovi=C4=87?= <martink@posteo.de>
Subject: [PATCH v2 2/2] dt-bindings: media: update Martin's contact information
Date: Mon, 13 Oct 2025 04:52:01 +0000
Message-ID: <20251013045152.14555-2-martink@posteo.de>
In-Reply-To: <20251013045152.14555-1-martink@posteo.de>
References: <20251013045152.14555-1-martink@posteo.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Update Martin's surname and email address in order to be reachable.

Signed-off-by: Martin Kepplinger-Novaković <martink@posteo.de>
---
 Documentation/devicetree/bindings/media/i2c/hynix,hi846.yaml    | 2 +-
 .../devicetree/bindings/media/nxp,imx8mq-mipi-csi2.yaml         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/i2c/hynix,hi846.yaml b/Documentation/devicetree/bindings/media/i2c/hynix,hi846.yaml
index 1a57f2aa1982..0a715081d271 100644
--- a/Documentation/devicetree/bindings/media/i2c/hynix,hi846.yaml
+++ b/Documentation/devicetree/bindings/media/i2c/hynix,hi846.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: SK Hynix Hi-846 1/4" 8M Pixel MIPI CSI-2 sensor
 
 maintainers:
-  - Martin Kepplinger <martin.kepplinger@puri.sm>
+  - Martin Kepplinger-Novakovic <martink@posteo.de>
 
 description: |-
   The Hi-846 is a raw image sensor with an MIPI CSI-2 image data
diff --git a/Documentation/devicetree/bindings/media/nxp,imx8mq-mipi-csi2.yaml b/Documentation/devicetree/bindings/media/nxp,imx8mq-mipi-csi2.yaml
index 3389bab266a9..9d9b697e936a 100644
--- a/Documentation/devicetree/bindings/media/nxp,imx8mq-mipi-csi2.yaml
+++ b/Documentation/devicetree/bindings/media/nxp,imx8mq-mipi-csi2.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: NXP i.MX8MQ MIPI CSI-2 receiver
 
 maintainers:
-  - Martin Kepplinger <martin.kepplinger@puri.sm>
+  - Martin Kepplinger-Novakovic <martink@posteo.de>
 
 description: |-
   This binding covers the CSI-2 RX PHY and host controller included in the
-- 
2.47.3


