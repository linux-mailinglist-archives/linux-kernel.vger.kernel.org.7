Return-Path: <linux-kernel+bounces-849396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A48ADBD0055
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 09:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 11AAB348B1A
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 07:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D79221739;
	Sun, 12 Oct 2025 07:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="clOmEDg8"
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC2922333B
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 07:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760254427; cv=none; b=rpEq2Uu52P0qiuRv76RpBu7Aql6N43GID/5YQqGRbn+WkS/dANjMbMqNT7Pyg/vy4dnQIttBVayymp2ziLZ/hiC5hxZsoCa/lrtYWtyBd5hLeN6SBPcnZX9ryb3UHHfgpb/WqIWxNh4f5Aofe3HFK5qsddd5tzPGHSX8ipAs2d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760254427; c=relaxed/simple;
	bh=x/+sEIf8VjKkMYSdEpbEU8plM/Af4caDH9g+BysFzU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cFAymMFcDq8veIwLsAVmnGPSNNGL/PoJRKjvzJrVzZAQO6B735RfHRROQoFKqxhLbJ7M1j3UzC3sGX6gGAHW7jDe7cyhVisGeP/omryZryGDwR4/HxbrsFydNhTIPKT4SarzYGt3QE9PQUV03jT3rMEjwmlp+jCLCd4T3ercw34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=clOmEDg8; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 18F34240103
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 09:33:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1760254417; bh=lRJWFiIlekaCJeQc8xyXqvXuD8E24YnSrfc0tVcVZFo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:From;
	b=clOmEDg8tEQZn1hOoUTXIb3b5V/RFOQIG8XhOMyZetU0+hYLVSPdPu68fKS29J3wj
	 HEaoNrK/NnEv+eIe2YRkuY6zguVYPQashzEGRGBbMz7Ymu929imWmENsoRfYojcu4T
	 V4qfP8VEW+ldWeOTtiu10rPvPu3tXwi5mzdjwvSpogZ2z2RzGgq0+CGagB3q8Mg+D2
	 51aqb4mBUx39lrfoQLTgIEkU0WTng0uLqBrAn1PuFIGa801XQL97/YmkDW95+1N/or
	 6uHyMTCaRr3pBwy9wFVqMHIqBxiIS4cqE16xadc8BFZoYwie1pvQhkg4ODiN8/nMiH
	 7W9A/neJ5ey4Q==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4cksfS3dSnz9rxT;
	Sun, 12 Oct 2025 09:33:36 +0200 (CEST)
From: =?UTF-8?q?Martin=20Kepplinger-Novakovi=C4=87?= <martink@posteo.de>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Martin=20Kepplinger-Novakovi=C4=87?= <martink@posteo.de>
Subject: [PATCH 2/3] dt-bindings: media: hi846: update Martin's contact information
Date: Sun, 12 Oct 2025 07:33:36 +0000
Message-ID: <20251012073314.9035-2-martink@posteo.de>
In-Reply-To: <20251012073314.9035-1-martink@posteo.de>
References: <20251012073314.9035-1-martink@posteo.de>
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
 Documentation/devicetree/bindings/media/i2c/hynix,hi846.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
-- 
2.47.3


